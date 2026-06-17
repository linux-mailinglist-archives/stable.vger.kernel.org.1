Return-Path: <stable+bounces-266823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y9S8Kjq9Mmro4wUAu9opvQ
	(envelope-from <stable+bounces-266823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:28:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0369AFCF
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CXz0HYJt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266823-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266823-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 660173099A04
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD944481AB2;
	Wed, 17 Jun 2026 15:24:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864645BD5F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709885; cv=none; b=OJOWxWSuY04MkS+/xLSwsYa88h8ZNR0ApXrv6zLDckw72AaXfPeVIdjRPRkaX2ZVFGs+/gLB6KukAOVcid2e1Z+7R1h+x0mIE+7YM96gb3jsaq/jQn2TjSXkUz5jPcFSEwpjI7mpqkbioHUJoSUn9y0TEFHV2SaOa64xJAvGif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709885; c=relaxed/simple;
	bh=K6BdhynNCxTbKte0oto9qXNQxgiuj197Vq3cvTizjVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjTdwtk6fVBxKqc3KGnfgbMdbxbLTxDgddzGKy7DQSMHq3pFoN5W6snNNojCaBsmdADYN3uCm+xm9ZBdy+oaeI4LlnmcSvZHZ09JY3KKd/MzFFOzbqJ93Me5hM9Y7Qd3VkFFJNrDeEyLvOwfsooT33YcXxHuLY3oFJ5+wqjuANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CXz0HYJt; arc=none smtp.client-ip=95.215.58.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781709882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/1YITrhnDXSdmC6Dqv+F70YQc0TGd3NsGsm13gGEdTo=;
	b=CXz0HYJtk190U/sx4Wh+h4WEdBGdG8kvRojZHqmHkrTL30R7QlpHwmdrAsFAW9WWyEcG3T
	xGW691kNb7opYYX3Y+JvQqZ5VHE0g2iA4DLyV48lj0qNtPMa65C7+NHBF2TVXeQyBMtsYO
	wRgsOTWWDN/7rLn2rG4eCwvWJBfqSqg=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepak Kumar Singh <quic_deesin@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1] rpmsg: char: Add lock to avoid race when rpmsg device is released
Date: Wed, 17 Jun 2026 23:24:18 +0800
Message-Id: <20260617152418.7046-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266823-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:quic_deesin@quicinc.com,m:andersson@kernel.org,m:wen.yang@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wen.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wen.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,quicinc.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12D0369AFCF

From: Deepak Kumar Singh <quic_deesin@quicinc.com>

commit 17b88a2050e9d1f89a53562f2adb709a8959e763 upstream.

When remote host goes down glink char device channel is freed and
associated rpdev is destroyed through rpmsg_chrdev_eptdev_destroy(),
At the same time user space apps can still try to open/poll rpmsg
char device which will result in calling rpmsg_create_ept()/rpmsg_poll().
These functions will try to reference rpdev which has already been freed
through rpmsg_chrdev_eptdev_destroy().

File operation functions and device removal function must be protected
with lock. This patch adds existing ept lock in remove function as well.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1663584840-15762-2-git-send-email-quic_deesin@quicinc.com
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/rpmsg/rpmsg_char.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 3e0b8f3496ed..a271fceb16f4 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -75,6 +75,7 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
 	mutex_lock(&eptdev->ept_lock);
+	eptdev->rpdev = NULL;
 	if (eptdev->ept) {
 		/* The default endpoint is released by the rpmsg core */
 		if (!eptdev->default_ept)
@@ -128,6 +129,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	}
 
+	if (!eptdev->rpdev) {
+		mutex_unlock(&eptdev->ept_lock);
+		return -ENETRESET;
+	}
+
 	get_device(dev);
 
 	/*
@@ -279,7 +285,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	mutex_lock(&eptdev->ept_lock);
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
+	mutex_unlock(&eptdev->ept_lock);
 
 	return mask;
 }
-- 
2.34.1


