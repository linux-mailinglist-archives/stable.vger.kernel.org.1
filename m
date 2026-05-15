Return-Path: <stable+bounces-248543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KH8LP5OB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:51:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8A554078
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61E8F3368F2B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06013F44EE;
	Fri, 15 May 2026 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNxAwgdO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E97481A90;
	Fri, 15 May 2026 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861999; cv=none; b=YvSjEJXOYL0rkdG+4yxChrQprUl7jSLD84yjDq17pFQH9+Vmoshl8IyfkDfM0tpvqkeeErB44KYUdFoDmADoAYEyHKY7PW/AQtSYLKe8BVnVMgkj1MSlY5Qn8wrlhkyX082laPrMByclhimZqcnCO5f9usYo0muxvPKonHkfBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861999; c=relaxed/simple;
	bh=JurM1rOrAjTNBEJGWt6Albf8JRRegE2Ktoz4Nwd2JF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDkQ/51NGtrC/Wh+PhsEIdaAQzZ+/vKKeY0w/eUCgduSWBR/JPLJDciE/QvojEx94UdxqswSDyWosDa0D8nP6AtwJWV29izDPGQb+baFgeQvjFMOQQEXI4ka+33sI2JRlH5tw9C4jKOG+/+gCdzqiDasIMx/Qh3VaDDePHwusf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNxAwgdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D62C2BCB0;
	Fri, 15 May 2026 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861999;
	bh=JurM1rOrAjTNBEJGWt6Albf8JRRegE2Ktoz4Nwd2JF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNxAwgdOpxtB8MN6Y4nHw7Nma3kvRwrEm3L1s8ilgP87rhhNMriCPcZEJ0uEjNkpf
	 TGuMBr0IwA/G9MwbtR8cue3vqKZCO6GRtbq72NunOsX0LzhoaaJgUKO3Y/EPetmKso
	 nFytWK3lcMLdKTpLDPavkqORJJLcM15yMvOzEzdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.18 026/188] media: rc: xbox_remote: heed DMA restrictions
Date: Fri, 15 May 2026 17:47:23 +0200
Message-ID: <20260515154657.876322254@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 25E8A554078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248543-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mess.org:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit e280d1e5e3f2595bbb43fe6e1bce00c59a43c0ff upstream.

The buffer for IO must not be part of the device structure
because that violates the DMA coherency rules.

Fixes: 02d32bdad3123 ("media: rc: add driver for Xbox DVD Movie Playback Kit")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/xbox_remote.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/media/rc/xbox_remote.c
+++ b/drivers/media/rc/xbox_remote.c
@@ -55,7 +55,7 @@ struct xbox_remote {
 	struct usb_interface *interface;
 
 	struct urb *irq_urb;
-	unsigned char inbuf[DATA_BUFSIZE] __aligned(sizeof(u16));
+	u8 *inbuf;
 
 	char rc_name[NAME_BUFSIZE];
 	char rc_phys[NAME_BUFSIZE];
@@ -218,6 +218,10 @@ static int xbox_remote_probe(struct usb_
 	if (!xbox_remote || !rc_dev)
 		goto exit_free_dev_rdev;
 
+	xbox_remote->inbuf = kzalloc(DATA_BUFSIZE, GFP_KERNEL);
+	if (!xbox_remote->inbuf)
+		goto exit_free_inbuf;
+
 	/* Allocate URB buffer */
 	xbox_remote->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xbox_remote->irq_urb)
@@ -262,6 +266,8 @@ exit_kill_urbs:
 	usb_kill_urb(xbox_remote->irq_urb);
 exit_free_buffers:
 	usb_free_urb(xbox_remote->irq_urb);
+exit_free_inbuf:
+	kfree(xbox_remote->inbuf);
 exit_free_dev_rdev:
 	rc_free_device(rc_dev);
 	kfree(xbox_remote);
@@ -286,6 +292,7 @@ static void xbox_remote_disconnect(struc
 	usb_kill_urb(xbox_remote->irq_urb);
 	rc_unregister_device(xbox_remote->rdev);
 	usb_free_urb(xbox_remote->irq_urb);
+	kfree(xbox_remote->inbuf);
 	kfree(xbox_remote);
 }
 



