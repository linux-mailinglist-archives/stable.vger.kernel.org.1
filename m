Return-Path: <stable+bounces-52469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A1190B058
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAFD1F2134D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436172101B0;
	Mon, 17 Jun 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGB//S9z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40452101AA;
	Mon, 17 Jun 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630699; cv=none; b=NbA1STzTwI9iKiEYU8UGaGMkx8XDem1XAJUcGgxG3SqazICg7XFOXG3GWGYBWfu7rYXUKdw08dJ+reur8RK7the7aZsxwqhKdFInC4aLfVS+oVIEv5oQqVxRLA1Ykv8HEA20ydIojGUBJRMfGbJecNyd2zAmZo0kOSNrxV4g7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630699; c=relaxed/simple;
	bh=MUpmA9MZ4i76S7YO4RwWYwYhCpJTtuZDBDgbMrW0AAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz7JM7GfV8KdfW0mfQQLW7D0RAj515KJ9TkjE0QalCIDG5OGKC6TnMrnTXx4G3fPXmdDWrg81twORsb0ozFi/Q/xI6ZXfGIfy0IzAcDoVFq5NnZfAneNBVOYizPLZ9kCnKbbb/wcLjGfWRmfnCyTSSi9Yyhh4gA2BSJjDyO+FTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGB//S9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9D5C2BD10;
	Mon, 17 Jun 2024 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630698;
	bh=MUpmA9MZ4i76S7YO4RwWYwYhCpJTtuZDBDgbMrW0AAk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZGB//S9zyWi09ZdDRHbF8dZuXjO1hki7E1DZZvrG7rdWCGvZXeYsz3xsT5y1Uq9Fq
	 eG8VhGALbPAxiBJZoXiVgBeN6/BGYwEx865dD3VS0hmnqgUdopUdusqELVmJiVHwkA
	 0Y6cw1xWbsMro9mLXUrTMWffAKJmtis9y/4V81QSjaHKFHh1M/kCls3zEfCDtq0grl
	 Pxc4bXb2tXBZJ1mXb2EOaAz4v7HgjVPQa61SjoZk8JgeaDdMJsVzj5eY91wgoK0EXK
	 N1/UNY+4e2ivjDCYUgfSGkXx0nQ+cL1rzvLzC4eEfaaJgx52wDupz+QtALSfBmfhRE
	 g6qvsxWsB9mng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Wilck <martin.wilck@suse.com>,
	Rajashekhar M A <rajs@netapp.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/29] scsi: core: alua: I/O errors for ALUA state transitions
Date: Mon, 17 Jun 2024 09:24:05 -0400
Message-ID: <20240617132456.2588952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Martin Wilck <martin.wilck@suse.com>

[ Upstream commit 10157b1fc1a762293381e9145041253420dfc6ad ]

When a host is configured with a few LUNs and I/O is running, injecting FC
faults repeatedly leads to path recovery problems.  The LUNs have 4 paths
each and 3 of them come back active after say an FC fault which makes 2 of
the paths go down, instead of all 4. This happens after several iterations
of continuous FC faults.

Reason here is that we're returning an I/O error whenever we're
encountering sense code 06/04/0a (LOGICAL UNIT NOT ACCESSIBLE, ASYMMETRIC
ACCESS STATE TRANSITION) instead of retrying.

[mwilck: The original patch was developed by Rajashekhar M A and Hannes
Reinecke. I moved the code to alua_check_sense() as suggested by Mike
Christie [1]. Evan Milne had raised the question whether pg->state should
be set to transitioning in the UA case [2]. I believe that doing this is
correct. SCSI_ACCESS_STATE_TRANSITIONING by itself doesn't cause I/O
errors. Our handler schedules an RTPG, which will only result in an I/O
error condition if the transitioning timeout expires.]

[1] https://lore.kernel.org/all/0bc96e82-fdda-4187-148d-5b34f81d4942@oracle.com/
[2] https://lore.kernel.org/all/CAGtn9r=kicnTDE2o7Gt5Y=yoidHYD7tG8XdMHEBJTBraVEoOCw@mail.gmail.com/

Co-developed-by: Rajashekhar M A <rajs@netapp.com>
Co-developed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin Wilck <martin.wilck@suse.com>
Link: https://lore.kernel.org/r/20240514140344.19538-1-mwilck@suse.com
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 0781f991e7845..f5fc8631883d5 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -406,28 +406,40 @@ static char print_alua_state(unsigned char state)
 	}
 }
 
-static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
-					      struct scsi_sense_hdr *sense_hdr)
+static void alua_handle_state_transition(struct scsi_device *sdev)
 {
 	struct alua_dh_data *h = sdev->handler_data;
 	struct alua_port_group *pg;
 
+	rcu_read_lock();
+	pg = rcu_dereference(h->pg);
+	if (pg)
+		pg->state = SCSI_ACCESS_STATE_TRANSITIONING;
+	rcu_read_unlock();
+	alua_check(sdev, false);
+}
+
+static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
+{
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
 		if (sense_hdr->asc == 0x04 && sense_hdr->ascq == 0x0a) {
 			/*
 			 * LUN Not Accessible - ALUA state transition
 			 */
-			rcu_read_lock();
-			pg = rcu_dereference(h->pg);
-			if (pg)
-				pg->state = SCSI_ACCESS_STATE_TRANSITIONING;
-			rcu_read_unlock();
-			alua_check(sdev, false);
+			alua_handle_state_transition(sdev);
 			return NEEDS_RETRY;
 		}
 		break;
 	case UNIT_ATTENTION:
+		if (sense_hdr->asc == 0x04 && sense_hdr->ascq == 0x0a) {
+			/*
+			 * LUN Not Accessible - ALUA state transition
+			 */
+			alua_handle_state_transition(sdev);
+			return NEEDS_RETRY;
+		}
 		if (sense_hdr->asc == 0x29 && sense_hdr->ascq == 0x00) {
 			/*
 			 * Power On, Reset, or Bus Device Reset.
@@ -494,7 +506,8 @@ static int alua_tur(struct scsi_device *sdev)
 
 	retval = scsi_test_unit_ready(sdev, ALUA_FAILOVER_TIMEOUT * HZ,
 				      ALUA_FAILOVER_RETRIES, &sense_hdr);
-	if (sense_hdr.sense_key == NOT_READY &&
+	if ((sense_hdr.sense_key == NOT_READY ||
+	     sense_hdr.sense_key == UNIT_ATTENTION) &&
 	    sense_hdr.asc == 0x04 && sense_hdr.ascq == 0x0a)
 		return SCSI_DH_RETRY;
 	else if (retval)
-- 
2.43.0


