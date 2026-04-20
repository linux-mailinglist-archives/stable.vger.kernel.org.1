Return-Path: <stable+bounces-239336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCBROQhi5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:27:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A824313DD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDC4377E6D8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8B336EDE;
	Mon, 20 Apr 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmYyYwwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF3332919;
	Mon, 20 Apr 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699985; cv=none; b=AgYnPtW7Yh4HNu4jUohi4p97NNaeuc5QyYkxRNMdc8R0S9fFHh389X2sGhMQSi5WgAMVvjeUUjavGjgaL3vp2UaF85OnZQmSTRrzexMRFpkgQhkskEoIhV8C6lZMsDBs9Q+n2PAnaObwZUgUG80mvZ0M4EPKSjttQRYs9A6tkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699985; c=relaxed/simple;
	bh=nLG1bLXf3wikWEHvXVfMR1Q0qOxkaWNid22tPRHm0is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9j9lNFi8Q7srAA1h7/PSO62i2k0WCtR7AaQtWlM6ulH0Pvru8CxdB5qid5TUxkJcwq/LhPW3w5q9+QHG7kS8A4lW9NV/1+0zsTAUFfqFMQ/nBiW/AGx/hOT0PeY3MCs0Vtyt2OU/HFnBFxmNlFMQAKoMSsBBTGbYBRaQhNFSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmYyYwwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0C4C19425;
	Mon, 20 Apr 2026 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699985;
	bh=nLG1bLXf3wikWEHvXVfMR1Q0qOxkaWNid22tPRHm0is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmYyYwwvqhS23pM2Ulwr+63bZQ2w4cvegT74qFmx09d3asuhd5xvWKeSbJkyKHIiI
	 XZXwGTUoryK5Mu1cqC3Ya19zOnU9tBVTsRlPFlcvMsJlkWMslMNo5rLRcqyfEfOvW5
	 L9AV1Sklfrb5AYV57hqcGvuQM6fvV4ORBcDRx+QM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c025d34b8eaa54c571b8@syzkaller.appspotmail.com,
	Abhishek Kumar <abhishek_sts8@yahoo.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 67/76] media: em28xx: fix use-after-free in em28xx_v4l2_open()
Date: Mon, 20 Apr 2026 17:42:18 +0200
Message-ID: <20260420153913.259008008@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-239336-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,yahoo.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,c025d34b8eaa54c571b8,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89A824313DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Kumar <abhishek_sts8@yahoo.com>

commit a66485a934c7187ae8e36517d40615fa2e961cff upstream.

em28xx_v4l2_open() reads dev->v4l2 without holding dev->lock,
creating a race with em28xx_v4l2_init()'s error path and
em28xx_v4l2_fini(), both of which free the em28xx_v4l2 struct
and set dev->v4l2 to NULL under dev->lock.

This race leads to two issues:
 - use-after-free in v4l2_fh_init() when accessing vdev->ctrl_handler,
   since the video_device is embedded in the freed em28xx_v4l2 struct.
 - NULL pointer dereference in em28xx_resolution_set() when accessing
   v4l2->norm, since dev->v4l2 has been set to NULL.

Fix this by moving the mutex_lock() before the dev->v4l2 read and
adding a NULL check for dev->v4l2 under the lock.

Reported-by: syzbot+c025d34b8eaa54c571b8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
Fixes: 8139a4d583ab ("[media] em28xx: move v4l2 user counting fields from struct em28xx to struct v4l2")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Kumar <abhishek_sts8@yahoo.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-video.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2126,7 +2126,7 @@ static int em28xx_v4l2_open(struct file
 {
 	struct video_device *vdev = video_devdata(filp);
 	struct em28xx *dev = video_drvdata(filp);
-	struct em28xx_v4l2 *v4l2 = dev->v4l2;
+	struct em28xx_v4l2 *v4l2;
 	enum v4l2_buf_type fh_type = 0;
 	int ret;
 
@@ -2143,13 +2143,19 @@ static int em28xx_v4l2_open(struct file
 		return -EINVAL;
 	}
 
+	if (mutex_lock_interruptible(&dev->lock))
+		return -ERESTARTSYS;
+
+	v4l2 = dev->v4l2;
+	if (!v4l2) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
+
 	em28xx_videodbg("open dev=%s type=%s users=%d\n",
 			video_device_node_name(vdev), v4l2_type_names[fh_type],
 			v4l2->users);
 
-	if (mutex_lock_interruptible(&dev->lock))
-		return -ERESTARTSYS;
-
 	ret = v4l2_fh_open(filp);
 	if (ret) {
 		dev_err(&dev->intf->dev,



