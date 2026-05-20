Return-Path: <stable+bounces-249978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHYPGvDNDWoF3gUAu9opvQ
	(envelope-from <stable+bounces-249978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB41A5907DA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D492A31852BC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277F3ED3A7;
	Wed, 20 May 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2v93fmiq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D543EA96E
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288193; cv=none; b=IjOYc26gQEEvZROaFRWrKU6yDdF4EEXERgt0oxdQpY1m7Fl51HISmlI9GkiNqtgZLz2sRPyIwOn8uCJ96ixD7Uks1qWxtJm7wc/RuTaAXHQtqw8EDguej65OvM85NsEKrORbsjaMaS1RtwsJpnlF7hBAMyXcyjR5eUuOhft/+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288193; c=relaxed/simple;
	bh=gQdPFG/oARcUwTsqYqgsoz9lr6nCQMUxT8B2xtgJG0w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nrdeor/A7LhpNkQy5t0ovNNDhHXkvCF0Qljq/pfvRn6CrZdMmo8AeaXUHZZT/EPAFgZkqm9iSKP36eQtXdCDWTkFNmICTLZLTfheEKjBKcU1/qQcATT9EMHMKdC7f0JfTBZnFdM2J7Syq5lsdgozxFAU65fM7Kf9x/UCsJacLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2v93fmiq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27BE1F000E9;
	Wed, 20 May 2026 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288192;
	bh=AFq2AimuFFhk3vUQurFSXzn9VTAfu5ZtUu4/scb6kXI=;
	h=Subject:To:Cc:From:Date;
	b=2v93fmiqbo2TYFHPLuntBo8ZBytdJVnTStCyjVo4TF9w4/B0g/ULyFMvVAmhP2b+5
	 t7lYyvULiIhLDXaGuFppxKwRzZTIZ3Kh+iDMefhL1KD3VBunpT7bGOP5BVDcCyfaIh
	 UbrAkrqgjjgTn2JIW0niFPalvLcYKrx4DRvwi6Hw=
Subject: FAILED: patch "[PATCH] media: rc: ttusbir: fix inverted error logic" failed to apply to 7.0-stable tree
To: oneukum@suse.com,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:43:15 +0200
Message-ID: <2026052015-pronounce-math-5b16@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249978-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mess.org:email]
X-Rspamd-Queue-Id: DB41A5907DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 646ebdd3105809d84ed04aa9e92e47e89cc44502
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052015-pronounce-math-5b16@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

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


