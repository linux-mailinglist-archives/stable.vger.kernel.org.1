Return-Path: <stable+bounces-4006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740580459C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81EB2818E4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2816FB1;
	Tue,  5 Dec 2023 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hm0Osm5F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3526AA0;
	Tue,  5 Dec 2023 03:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E722C433C7;
	Tue,  5 Dec 2023 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746361;
	bh=IqgIXXxG0HxxTXDjSKXVU4YWAmhy4/6/5Av3ruLcVVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hm0Osm5F2bEdtuKlY/UUIWcpqBSf6MnaYKtmZmvhDv44VXdnQpOG2TKnz//fwroP3
	 /SyY1qAHttNP1cfog/+clKd0bZs3S+RE/3xmfa/dOCMR2WEk7TjQggDBIVFfMUKWWR
	 wtwhp0WjEQ64Cah706adSj0Z/OhJleE9vFRNjhns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Haberland <sth@linux.ibm.com>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 12/30] s390/dasd: protect device queue against concurrent access
Date: Tue,  5 Dec 2023 12:16:19 +0900
Message-ID: <20231205031512.224380166@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
References: <20231205031511.476698159@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Höppner <hoeppner@linux.ibm.com>

commit db46cd1e0426f52999d50fa72cfa97fa39952885 upstream.

In dasd_profile_start() the amount of requests on the device queue are
counted. The access to the device queue is unprotected against
concurrent access. With a lot of parallel I/O, especially with alias
devices enabled, the device queue can change while dasd_profile_start()
is accessing the queue. In the worst case this leads to a kernel panic
due to incorrect pointer accesses.

Fix this by taking the device lock before accessing the queue and
counting the requests. Additionally the check for a valid profile data
pointer can be done earlier to avoid unnecessary locking in a hot path.

Cc:  <stable@vger.kernel.org>
Fixes: 4fa52aa7a82f ("[S390] dasd: add enhanced DASD statistics interface")
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20231025132437.1223363-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -721,18 +721,20 @@ static void dasd_profile_start(struct da
 	 * we count each request only once.
 	 */
 	device = cqr->startdev;
-	if (device->profile.data) {
-		counter = 1; /* request is not yet queued on the start device */
-		list_for_each(l, &device->ccw_queue)
-			if (++counter >= 31)
-				break;
-	}
+	if (!device->profile.data)
+		return;
+
+	spin_lock(get_ccwdev_lock(device->cdev));
+	counter = 1; /* request is not yet queued on the start device */
+	list_for_each(l, &device->ccw_queue)
+		if (++counter >= 31)
+			break;
+	spin_unlock(get_ccwdev_lock(device->cdev));
+
 	spin_lock(&device->profile.lock);
-	if (device->profile.data) {
-		device->profile.data->dasd_io_nr_req[counter]++;
-		if (rq_data_dir(req) == READ)
-			device->profile.data->dasd_read_nr_req[counter]++;
-	}
+	device->profile.data->dasd_io_nr_req[counter]++;
+	if (rq_data_dir(req) == READ)
+		device->profile.data->dasd_read_nr_req[counter]++;
 	spin_unlock(&device->profile.lock);
 }
 



