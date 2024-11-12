Return-Path: <stable+bounces-92272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346AB9C5449
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87770B27136
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567242123D6;
	Tue, 12 Nov 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZC8bdv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834121263E;
	Tue, 12 Nov 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407115; cv=none; b=fx9djk869R4FxQ3WYTLILrOOPjLAkjwQFNS3pwezZMDDnp/aRVnkumnmPL3rGsx7S31c+4xYZ1sg5Ik0Fgl6QPBGvTT7PIG83WVGupF2cx7MfvEMfsDAXvZKWrR8NWdIVcUlIh1MhxpRNaTMg0ckSkb/1vJ4PSNgoTT8ATsCVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407115; c=relaxed/simple;
	bh=DC1Tjf3JlPwhjFnqWoHBiOQpym1d86zqZJhz4xsHoFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSE1OOcUtz5SDz2MQxlPouHOGu5iSKZ8+TCWmaHMB5xCtWlPpHIrt3c9OnVhOrCxGeFLw0QAcyMBk2ZeRu3ivX60lJTI8Cy5419ajfIF3s82zd1NvOwX142wuPH3qJpZjQv7CwJjXPiMYsJLzgsKVzYTJEU9oTEbzjxNAbZhygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZC8bdv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBF1C4CECD;
	Tue, 12 Nov 2024 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407114;
	bh=DC1Tjf3JlPwhjFnqWoHBiOQpym1d86zqZJhz4xsHoFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZC8bdv+AzeH65sAd3y02mvyQ4oh1ycxRddfbEBy+Iq8JQjd77boWMLN80c5Yadx9
	 zuiV88+d9vpS6HzfRVEGdsGQgvDC4BLDfuoVmsIFvpT7dysiXamQ/m5uZ+INPYtdLX
	 sM5Wq5bTLudw0z63EpTlJ1Madv0LWeJyJ7HjvUrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 27/76] media: dvbdev: prevent the risk of out of memory access
Date: Tue, 12 Nov 2024 11:20:52 +0100
Message-ID: <20241112101840.821506071@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 972e63e895abbe8aa1ccbdbb4e6362abda7cd457 ]

The dvbdev contains a static variable used to store dvb minors.

The behavior of it depends if CONFIG_DVB_DYNAMIC_MINORS is set
or not. When not set, dvb_register_device() won't check for
boundaries, as it will rely that a previous call to
dvb_register_adapter() would already be enforcing it.

On a similar way, dvb_device_open() uses the assumption
that the register functions already did the needed checks.

This can be fragile if some device ends using different
calls. This also generate warnings on static check analysers
like Coverity.

So, add explicit guards to prevent potential risk of OOM issues.

Fixes: 5dd3f3071070 ("V4L/DVB (9361): Dynamic DVB minor allocation")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 661588fc64f6a..71344ae26fea7 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -96,10 +96,15 @@ static DECLARE_RWSEM(minor_rwsem);
 static int dvb_device_open(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev;
+	unsigned int minor = iminor(inode);
+
+	if (minor >= MAX_DVB_MINORS)
+		return -ENODEV;
 
 	mutex_lock(&dvbdev_mutex);
 	down_read(&minor_rwsem);
-	dvbdev = dvb_minors[iminor(inode)];
+
+	dvbdev = dvb_minors[minor];
 
 	if (dvbdev && dvbdev->fops) {
 		int err = 0;
@@ -539,7 +544,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
-	if (minor == MAX_DVB_MINORS) {
+	if (minor >= MAX_DVB_MINORS) {
 		if (new_node) {
 			list_del (&new_node->list_head);
 			kfree(dvbdevfops);
@@ -554,6 +559,14 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 #else
 	minor = nums2minor(adap->num, type, id);
+	if (minor >= MAX_DVB_MINORS) {
+		dvb_media_device_free(dvbdev);
+		list_del(&dvbdev->list_head);
+		kfree(dvbdev);
+		*pdvbdev = NULL;
+		mutex_unlock(&dvbdev_register_lock);
+		return ret;
+	}
 #endif
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
-- 
2.43.0




