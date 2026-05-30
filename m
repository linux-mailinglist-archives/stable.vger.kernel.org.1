Return-Path: <stable+bounces-258946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFf8EAwxG2qKAAkAu9opvQ
	(envelope-from <stable+bounces-258946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:48:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF86128AF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F3330E3799
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6A32F770;
	Sat, 30 May 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V2VpC/SK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BD2EF652;
	Sat, 30 May 2026 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166076; cv=none; b=DUejc8KPY8HHjS2P4OoCODdKoXXOKvptPFpGVA+jD64p1oLQHvBL90M/AFgrQ74vcxZS0C4gTNOLVYYh8cm64t71/zFK1gRfK/ADlu7FLAQjiW304wEGpJX2bz59aYEEt5aHU9A1+Ah53D5IMDNTe2KhZxqa66V/A6+touJXfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166076; c=relaxed/simple;
	bh=vOT+DJRm8LMi80ODFqO11T/CH+6kxQnDXUZA6yII1Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFu+ENMjuU43tm+ta9encbintK3UE1lDDjoqtKcZD6PwYR6r7oAmf7AxGB2G8hoR6cDt1jm6XIYRvS4OM7LiKcEzjf7xOruFCFlq/RUdOhCarQo7lcDkTe+AdFe/gtrjXdldq/LPEkuHj5RSY4zxSKEhUKkX4c9+rpl6V3yvv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V2VpC/SK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C473C1F00893;
	Sat, 30 May 2026 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166075;
	bh=L7PSwrHHm76De6TU9wNV6CgvswjZYAB2appAa8QcsGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2VpC/SKbgglAOqGUcydDi3poi6sdXUPH6yQkaT68Gn/nidbYavwQu3I+zeZ+ibNc
	 nqYS3JQfqm6I2C5foKnP6ArPMdJDVyhL2YkW6tyCGgoxoog27cgqw3dKYmb881hCyI
	 JcMV0RVGHOoPt0LtCNcwVvP+Ukh7QPC8GYZnV4Dc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 5.10 266/589] media: rc: xbox_remote: heed DMA restrictions
Date: Sat, 30 May 2026 18:02:27 +0200
Message-ID: <20260530160231.982529121@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258946-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BBAF86128AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -220,6 +220,10 @@ static int xbox_remote_probe(struct usb_
 	if (!xbox_remote || !rc_dev)
 		goto exit_free_dev_rdev;
 
+	xbox_remote->inbuf = kzalloc(DATA_BUFSIZE, GFP_KERNEL);
+	if (!xbox_remote->inbuf)
+		goto exit_free_inbuf;
+
 	/* Allocate URB buffer */
 	xbox_remote->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xbox_remote->irq_urb)
@@ -266,6 +270,8 @@ exit_kill_urbs:
 	usb_kill_urb(xbox_remote->irq_urb);
 exit_free_buffers:
 	usb_free_urb(xbox_remote->irq_urb);
+exit_free_inbuf:
+	kfree(xbox_remote->inbuf);
 exit_free_dev_rdev:
 	rc_free_device(rc_dev);
 	kfree(xbox_remote);
@@ -290,6 +296,7 @@ static void xbox_remote_disconnect(struc
 	usb_kill_urb(xbox_remote->irq_urb);
 	rc_unregister_device(xbox_remote->rdev);
 	usb_free_urb(xbox_remote->irq_urb);
+	kfree(xbox_remote->inbuf);
 	kfree(xbox_remote);
 }
 



