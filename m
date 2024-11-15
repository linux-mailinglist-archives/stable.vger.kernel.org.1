Return-Path: <stable+bounces-93190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1F9CD7D3
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FFB1F2112D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CA188735;
	Fri, 15 Nov 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p5XkTdyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587C188012;
	Fri, 15 Nov 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653090; cv=none; b=OJQI2meM31ApCTrtDsiHt1TlFyzNTfHjqYkj3heMuTpbxGb+tukyMqbu8NQdj2zrVLrLN1Mj1enSFfp/5TZSCkAZSaKC8DlGIIVuD3IaHDoTZlylqdBqU+r0rvH7iV2Ld8rJH1iYI2OGkfqCpkfm3TVtrkkPvE2i1C4tyJx4tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653090; c=relaxed/simple;
	bh=hhjNPBb96pmFRgJSoHn4BTQRMrXb71vjDoyttULJTgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDIMLbosaVbK+xhzOgw5dQqWbYLUPINlwo8JRdfKuZ/M77sYO1ACkV+0OAj6wQHJ9sxGyuTYWf6xG4dl8vTw/9ZZH01xuulfO/GZBlNbROw7Cuz9bpLKqq+t8mV6NiY5NRPxeQzMM4PCWTtR3YA+oNVXjHxB1utU0r5L2YhpEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p5XkTdyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A645AC4CECF;
	Fri, 15 Nov 2024 06:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653090;
	bh=hhjNPBb96pmFRgJSoHn4BTQRMrXb71vjDoyttULJTgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5XkTdyCpcwC/oKEsb9EEeU3/Ct3YjDo6gHYGDl960FQ4W/+mIWioX3YGkiHehj1M
	 1/P3a5ttl+MmPWUGPv0AphFBpBvvY8NkmiQE6fcdPnZAhHY3cXfGahghmAyRzZz/5c
	 ULiox2hfp5E4Nt9jty/ziy75zp9/e+ZEmheggCk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 17/66] media: dvbdev: prevent the risk of out of memory access
Date: Fri, 15 Nov 2024 07:37:26 +0100
Message-ID: <20241115063723.465150498@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index ba91c6f8fe1d8..4a6e8a6b36f45 100644
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




