Return-Path: <stable+bounces-272074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GmbsE0RpSmqDCgEAu9opvQ
	(envelope-from <stable+bounces-272074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:25:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC270A4AC
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PcuNUD8C;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272074-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272074-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C625300908B
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C726384248;
	Sun,  5 Jul 2026 14:25:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B21376490
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:25:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261504; cv=none; b=hXckgL3tZqmuZYxo7lrZh/J5y/vMMmunsfzQ7G0VmmCXJGBmZfiHCafFWK3XPcHPesdCQpjT+Atw4GyrnP0tU7O2jF2hTfpyRh7wBVXBx5mYqtMsN2c9X/KRsN0NCurVeE95W+soAAXJBHbuVw4Gfr6RoHbbPQfEvqfmD813e/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261504; c=relaxed/simple;
	bh=9+Z3LFJ1TUoyOzawIkHkpoTBgkb/cLpvH0/Nfrm+Y4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAZi+PPdMe9S2v+geUByrV75AERhNHi9NQl4vs9qD+IE5GcsRx/sOZhmykIB/+TpuXZnlhe2gkcFAYpNCwkjw963k9kjYwDp2Ro1CbNXEP6qbxWqllY4t0J6JNKHIewweng6crw65x6ielAIQmYxqLyrp4EC/jyDjhhQuiBZDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcuNUD8C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4691F000E9;
	Sun,  5 Jul 2026 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783261502;
	bh=cOkS407vKO4+ufm49cPCAOV2jl9ZYDiOs917R0Xdec0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcuNUD8C+ykg5D8D2l6eAM6h+sk0A5bPRZeVDl/ue7J1/LnqfPzeI+RMyVrLY71TC
	 +KRxiaVRWnvCnoBiMTn/AFDRzDbE/XctXciemSXCrQvyeQ929zbGoViuHTsqFWCm31
	 efpufMKeWWmBnbMuXay8iXeRhaJ62NlJ9zP89O32V0gpDw5NL8SXKukJ+hODo6hPtf
	 RNChR6ruwB5FUscTfjy7k4EPWNmOm8eQu2m9gGZKmrhXEK7mvDOksj12REq/FLH2/s
	 VvdgWR1TvaczAdGhSCEHyg/SJEs0gUiMAXRBEtmvFm0v+iyycU1QuQupoJwODA+jfO
	 kvRSfECZcFNug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Sun,  5 Jul 2026 10:24:59 -0400
Message-ID: <20260705142459.1798975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070231-lash-wick-98ec@gregkh>
References: <2026070231-lash-wick-98ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272074-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,m:tzimmermann@suse.de,m:deller@gmx.de,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[stu.xidian.edu.cn,suse.de,gmx.de,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFBC270A4AC

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[ Upstream commit 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 00cd29a3bddc1b..b72d7bf448793a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2426,6 +2426,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2479,6 +2480,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+	/* Restore the hi_font state and screen buffer */
+	if (old_hi_font_mask && !vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, true);
+	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+
 	return ret;
 }
 
-- 
2.53.0


