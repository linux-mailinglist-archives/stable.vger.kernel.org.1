Return-Path: <stable+bounces-212620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB/LLxE0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B32A516F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1972130481AC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87A3033E0;
	Wed, 28 Jan 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eeswfm2v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304FF306B06;
	Wed, 28 Jan 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616132; cv=none; b=MM/jou4p/QRYoR+MKIy90i0j5K/wvljocnJPZvSdHBTmCeD/kiJl+HnNFi9cJKQktrnapuMQeKTDKeQoXWge158s5TiRvrAmtuHsoEcOXC0ZGeCWV1nzbQ+2iorNV9GLB6O8ekKFYuf71Jueu43Da4/58tmySC5UGYMu55N69Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616132; c=relaxed/simple;
	bh=70LYdc2L//Uc69cdw5TN+eELvzaAW/qQVlXMEZFDMac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GArRnwGE+BDIcOqgqQXXHRk7qon4n11XYT84bghCH0rSvRydQNnx9ZyTGykoXvGxAWiVvxCNm7dzqB/iafQQYtoosabnl4L2XJ2NmATF09mZ2yXoYX9b7nJGLTeKEPhtRFwO8TQyfRP31Yetf4xCa0hvd3FnLq/478CndL1lXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eeswfm2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BA3C4CEF1;
	Wed, 28 Jan 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616132;
	bh=70LYdc2L//Uc69cdw5TN+eELvzaAW/qQVlXMEZFDMac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeswfm2v7j9jsb/ph81kzXwIDLMRR8SE4D+0Kk9qlDdSaPYMAiuLXInvySXylt7BS
	 hgr5IDMCCiBM+0TLvjm0VTVAAHLoeqKt08bhZJ02IrytBgoYfR7Mza20SC6VTp4K+t
	 I+9kUM4PM1dB6SJOApu3fynsYdkC93L2Ek3AoLe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.18 216/227] gpio: cdev: Correct return code on memory allocation failure
Date: Wed, 28 Jan 2026 16:24:21 +0100
Message-ID: <20260128145352.206534173@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212620-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55B32A516F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit faff6846474e99295a139997f93ef6db222b5cee upstream.

-ENOMEM is a more appropriate return code for memory allocation
failures.  Correct it.

Cc: stable@vger.kernel.org
Fixes: 20bddcb40b2b ("gpiolib: cdev: replace locking wrappers for gpio_device with guards")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20260116081036.352286-6-tzungbi@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-cdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2720,7 +2720,7 @@ static int gpio_chrdev_open(struct inode
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
-		return -ENODEV;
+		return -ENOMEM;
 
 	cdev->watched_lines = bitmap_zalloc(gdev->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)



