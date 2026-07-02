Return-Path: <stable+bounces-270506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F/YXHCdtRmrHUQsAu9opvQ
	(envelope-from <stable+bounces-270506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:52:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31E6F88DF
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:52:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=c6LMbmXN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270506-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270506-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A28130325E6
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765E4A3413;
	Thu,  2 Jul 2026 13:52:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EB360EDC
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:52:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000353; cv=none; b=qnnFKA03xAN+uMkkYJx3Uu0E+zrG1ivt4h8tGRkF/pkqVzPBJJ/7BnsTyIGQIHjbpehyOX3rGh9GTovmqEbRMKiL3/Uziza6ryG964SFWooDuh9+26sXTVQ480FMy2VIHICCAKUSnYiVhVcizfYTPTllhYBHj6A7N/puweoxt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000353; c=relaxed/simple;
	bh=j/UDqIB8kkju/Mc3RqVh5qBDliywmf8SBbiGagEL6DU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MRo0Bo1ZytmuL8avaFFACztQdaC/KV8vGu+MJsTl4saaQ5stLyItWgfiKt+kpWiThxM+lqvh0xN0m6sY7SPmZQc2J84TGTdyLjp39YEIuVM/FSnn8DTWJkhZV5Hkh1lFOeQJucEWP2ERS0VbBEug+S+U4ydNVzePL+M9N/B4K4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6LMbmXN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15251F000E9;
	Thu,  2 Jul 2026 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000352;
	bh=E5R8BHEOibtT6FTrZyuY+qdj53L6Px6ujqmJXDVoggo=;
	h=Subject:To:Cc:From:Date;
	b=c6LMbmXNOaswqJi7sfabWpyo5kbgBzI5Aw+QP8im+T0RWp+9kCeu0URahwtP59O6B
	 ZprJ1KWOt0wN0TNVQ7c6ehzDyImtmCRo0kBtLDvf8BzOvheEcluZvmg+84VDXGujF9
	 0i0VpHjGFemXha+0nKsNtXwq3dw2E5QdxowAkWlY=
Subject: FAILED: patch "[PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of" failed to apply to 5.15-stable tree
To: 25181214217@stu.xidian.edu.cn,deller@gmx.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:52:30 +0200
Message-ID: <2026070230-congrats-plenty-c9d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270506-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:25181214217@stu.xidian.edu.cn,m:deller@gmx.de,m:tzimmermann@suse.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[stu.xidian.edu.cn,gmx.de,suse.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,xidian.edu.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B31E6F88DF


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070230-congrats-plenty-c9d5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2 Mon Sep 17 00:00:00 2001
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Date: Fri, 26 Jun 2026 00:03:06 +0800
Subject: [PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of
 fbcon_do_set_font()

When fbcon_do_set_font() fails (e.g., due to a memory allocation failure
inside vc_resize() under heavy memory pressure), it jumps to the `err_out`
label to roll back the console state. However, the current rollback logic
forgets to restore the `hi_font` state, leading to a severe state machine
corruption.

Earlier in the function, `set_vc_hi_font()` might be called to change
`vc->vc_hi_font_mask` and mutate the screen buffer. If `vc_resize()`
subsequently fails, the `err_out` path restores `vc_font.charcount`
but entirely skips rolling back the `vc_hi_font_mask` and the screen
buffer.

This mismatch leaves the terminal in a desynchronized state. Because
`vc_hi_font_mask` remains set, the VT subsystem will still accept
character indices greater than 255 from userspace and write them to the
screen buffer. Subsequent rendering calls (e.g., `fbcon_putcs()`) will
then use these inflated indices to access the reverted, 256-character
font array, leading to a deterministic out-of-bounds read and potential
kernel memory disclosure.

Fix this by adding the missing rollback logic for the `hi_font` mask
and screen buffer in the error path.

Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9077d3b99357..37beb93045af 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2405,6 +2405,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	font_data_get(data);
 
@@ -2451,6 +2452,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+	/* Restore the hi_font state and screen buffer */
+	if (old_hi_font_mask && !vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, true);
+	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+
 	font_data_put(data);
 
 	return ret;


