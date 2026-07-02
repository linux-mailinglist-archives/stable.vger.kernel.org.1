Return-Path: <stable+bounces-271523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +E5eNc+nRmprbAsAu9opvQ
	(envelope-from <stable+bounces-271523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:02:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE976FBCF0
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:02:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DrRJ6Fjp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271523-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271523-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B145F30D6E57
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA630499A;
	Thu,  2 Jul 2026 17:02:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27B24E4C3;
	Thu,  2 Jul 2026 17:02:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011765; cv=none; b=JeJmfV/TnLgU9LnzS3KI5GnTBBlqcqzS1TQhsZFuU0HvBq3Dww/jB9yTjcQjy1ONZhYOEeaI8pWyTdOOEFzyNeKYt21YyA8ndgtiAxhZ2O4ErfRRgyZv00+zh/twDCBD2ejWUj9+eeN9HtC63Av9gNfJZHYketQnnM4qAc1h2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011765; c=relaxed/simple;
	bh=/lTkDijhHKwaVb7fToQC9ntk1KagKlsuXJC7LIn1vao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUOrPD/GrKCr/JBEoCsmkdVkykZYSl5N0RG6el66nVbrSMxhWjs/1xW9Q7NRgBjXV+vu7xtysuilj2IY3dM5fx9RQkrKpn9Ac6Qn2oTEtWAjA7s8HtSceUFM+vqvndW/U9yfEhJ9q3SY10kwgm/LTZ9woz3wEPT0DSg01u2ollk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrRJ6Fjp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005881F000E9;
	Thu,  2 Jul 2026 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011764;
	bh=FJPucgB+VXTr2AVJRUiokUrc2Ry1TDGPhRPmBvovb8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrRJ6FjpIrFSWRQfR8lrxK4ddIco/vmjrQkdtJDvf0JOtxNHuj5DeyEXP5uw/6rhf
	 6giCO8NQJsT6YCOwWxNuHFOz0t7UUD5v2ffWc7dZnTYEc79t8Ur1B2B8WDCqylQDhg
	 8yw8MrQZs/fikz5fXxsTyJWtBm95yFNOTXVKE5Ws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 7.1 100/120] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Thu,  2 Jul 2026 18:21:36 +0200
Message-ID: <20260702155115.027652883@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271523-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,stu.xidian.edu.cn,suse.de,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:25181214217@stu.xidian.edu.cn,m:tzimmermann@suse.de,m:deller@gmx.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,suse.de:email,vger.kernel.org:from_smtp,gmx.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,xidian.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDE976FBCF0

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

commit 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbcon.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2407,6 +2407,7 @@ static int fbcon_do_set_font(struct vc_d
 	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	font_data_get(data);
 
@@ -2453,6 +2454,12 @@ err_out:
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



