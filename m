Return-Path: <stable+bounces-249979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLYdEfTNDWr53QUAu9opvQ
	(envelope-from <stable+bounces-249979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E45907E8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32FA53187AB0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC3A3ECBDA;
	Wed, 20 May 2026 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UgiYOx+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E43ED3BA
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288202; cv=none; b=lK13vKZBXCpcLXqjxLJjHUQGf1nCTSh1MaJ1FpP8tRUsHVv4qpUdZZWXQYHRTKJ0vqlVMh+BmDo3iFcsaEw/c7h8dXBmPKJ+MtvKumR2o98U64zfST1RHk6vEfm0xnu3fxRGZzLXUmZlEuCajBRcu7zKVhWtHGFbLQ7yrB4S0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288202; c=relaxed/simple;
	bh=J7kLm+I3MAqKAyBZE1mcasyO/Cs6A72dmGATyPWiNi0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PnhbOJQQcfrbGtaU8gvjwA9b9nwKCvyMEO2AQyG9+K7IxtIgOJOq+0h+efuedXQ0IbRO2pvXdOJ2X90rQCs8ZjyHvh7kyIIm7by6ZJk/AQ+wkH0k3goLLZ+FAbWFdaQaG8PD4Ize7pXiuR0lDF6BwbYHBmBCIIeJkDjSOrZzt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UgiYOx+l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE651F00893;
	Wed, 20 May 2026 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288200;
	bh=RJ6S9w9upkvq3xvcgXzKbQTQDZh6C8tK551cVrLrzIg=;
	h=Subject:To:Cc:From:Date;
	b=UgiYOx+lOXFkxpMxvvDxTRHraqFK0BPLDAfw9m72oyYd3eTRDQzpMHxhPii4szBsq
	 nntWtmWaTpRL4PXmTw1iRHrXeVygI8qFuZxMTj4sXNon1nonWi7ec8Rt44IKvwqftb
	 UUPQ/pQp9ismK2Ru/RQWFcSjgiPbUO6GVi4W1sYc=
Subject: FAILED: patch "[PATCH] media: rc: ttusbir: fix inverted error logic" failed to apply to 6.18-stable tree
To: oneukum@suse.com,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:43:15 +0200
Message-ID: <2026052015-cursor-myself-fe38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249979-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,gregkh:email,linuxfoundation.org:dkim,mess.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D50E45907E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 646ebdd3105809d84ed04aa9e92e47e89cc44502
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052015-cursor-myself-fe38@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 646ebdd3105809d84ed04aa9e92e47e89cc44502 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Fri, 10 Apr 2026 23:03:09 +0200
Subject: [PATCH] media: rc: ttusbir: fix inverted error logic

We have to report ENOMEM if no buffer is allocated.
Typo dropped a "!". Restore it.

Fixes: 50acaad3d202 ("media: rc: ttusbir: respect DMA coherency rules")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 3848ad3a6b85..db2f6698a6c0 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -191,7 +191,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 	tt = kzalloc_obj(*tt);
 	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc || buffer) {
+	if (!tt || !rc || !buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}


