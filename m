Return-Path: <stable+bounces-249999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKcwFPjUDWrW3wUAu9opvQ
	(envelope-from <stable+bounces-249999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:36:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF0659102F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54CE3330AD1E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588A3EFFC2;
	Wed, 20 May 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NfFrshNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327B3F0AB1
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289142; cv=none; b=qeqnVv4jcb/cHHKHRPb6d/Q3EIkrLZYSwggLtvpxB3Tlj2pAhx/e9pvdq9/xYhqZTNN+RT7lMS1iVm8SYb+7hYHnPEx4eFqTXqgVQ1TK0nLz4fA+SCE6Owe7GoNsNbEhlPT7i2rLXGv3ymhv6bDmyYYyszBThJAV1Tfciw/RL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289142; c=relaxed/simple;
	bh=kpEmV7/fIqmwo9UOY0fYGs5uxYwIK8Dm4O2sYUZqWSA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MPlanKtQ0Y/1fw+bXkP1zbef841NiOiO8n4Mw2HSpIULLwrL6qXtZjv7iMXYtE06ZVf5NAWPabyS1QlQ89zOgvdvIw6HVYTAzpXhw55yAzK9R0ezcz9zunzQLNLWOHwMcBR4GyfoDyKxdTFdHvwkwBd7sCfFMwoB8NIXYnMuTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NfFrshNM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108471F000E9;
	Wed, 20 May 2026 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779289140;
	bh=x7+a6nkBEI3FKf7FjKQFR86Vrkp3BCr95zqasHjTIh0=;
	h=Subject:To:Cc:From:Date;
	b=NfFrshNMaU1pJEqAKrsnRMf4o6MWwdDDGWyTwQp6WrkChKjLEG0NWF6Mjb3e1H/3N
	 mUUOqddfc+LkjDwtreEaqfV94BDaIG6VnHIMPSUVVJsooVaVhzrriLT8Q7Yj+PUKP+
	 gIlKZuUiG8q1MIFXn7nxdQQflipEXWjB/f25lk4I=
Subject: FAILED: patch "[PATCH] drm/loongson: Use managed KMS polling" failed to apply to 6.6-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,chenhuacai@loongson.cn,lvjianmin@loongson.cn,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:59:03 +0200
Message-ID: <2026052003-stimulant-alphabet-8143@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249999-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,suse.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: DBF0659102F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0a9c56dd387605d17dabeedd9fdd2c4c1d0bab7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052003-stimulant-alphabet-8143@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a9c56dd387605d17dabeedd9fdd2c4c1d0bab7b Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 13 May 2026 15:57:00 +0900
Subject: [PATCH] drm/loongson: Use managed KMS polling

lsdc_pci_probe() initializes KMS polling before setting up vblank support,
requesting the IRQ and registering the DRM device. If any of those later
steps fails, probe returns without finalizing polling. The driver also
never finalizes polling on regular removal.

Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
lifetime and automatically finalized on probe failure and device removal.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20260513065706.23803-1-mhun512@gmail.com

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 1ece1ea42f78..34405073c4d4 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -293,7 +293,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	vga_client_register(pdev, lsdc_vga_set_decode);
 
-	drm_kms_helper_poll_init(ddev);
+	drmm_kms_helper_poll_init(ddev);
 
 	if (loongson_vblank) {
 		ret = drm_vblank_init(ddev, descp->num_of_crtc);


