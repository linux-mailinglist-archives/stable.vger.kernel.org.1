Return-Path: <stable+bounces-261994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h55QGySIJmoEYQIAu9opvQ
	(envelope-from <stable+bounces-261994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 11:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD76547A9
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 11:15:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=foxmail.com header.s=s201512 header.b=ef+BHDuB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261994-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261994-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=foxmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0F183008D6A
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFEA3B19CF;
	Mon,  8 Jun 2026 09:13:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080F3AFCE5
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:13:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909990; cv=none; b=BSulk7DOLcunpCaYh29KyMml+I9qSIHteUsfom84ZsAqop3oxTRkpYFGXVn1BLMZT8tL1lFntV7clhmshAAye3DEr6nOB6o2owml2WnerREpSaDTZEJFf1xyv3VMo1uP2lxVVC6gC/yE1MeB3gOewEZG5K0TOXD7OOxebRXvOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909990; c=relaxed/simple;
	bh=TrFYGa2op91byLRTN68QsIHQy4X9NeuphZtPVHEMisQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bDXnSArFeESb2eD0ACUPX8PLmhYvcTRy2/klOGdzZLtJo8HH7rIDHezhjYtwbjVBAVx2pHeYhBR/7tmauQ6jisn2kCyviVlnMgPJ5sepv2hCmKueZs/tVfodzOktPol6bq/khRLcrSdqZxP3vWdVCq6iX+qvC8l7z//kTHWm+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ef+BHDuB; arc=none smtp.client-ip=203.205.221.240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780909979;
	bh=+fqbAYNvBbhGamEyI6RgTGYGo+FJfa7zUeW6Q86NOV8=;
	h=From:To:Cc:Subject:Date;
	b=ef+BHDuBb9bqbBgkYYcUCXTkAewKPI8NG7a7WaEiVvhLqAMSgZuoxDFH5QPAWw8US
	 haTkj8i6eAUxJMmUeKFWYLoQfVBvSDw3SM3ZvMvxCbRamDRfyk1JsAzlWJTybqq+Xe
	 SuAjXGd9Vq2zhLvfL/RzwT2JH7cXemDS+h1J4vJA=
Received: from chafi-Matebook-Ubuntu.. ([117.25.98.102])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 32F830C7; Mon, 08 Jun 2026 17:12:47 +0800
X-QQ-mid: xmsmtpt1780909967t9w3ffs40
Message-ID: <tencent_41186F27AF2C13B660C14ED5E6E14759800A@qq.com>
X-QQ-XMAILINFO: OEqHD1PnWCNqOwCy+d3Obi9zlJvkegDosYWvNDkri1MFywdxVJZCdKfyufQj6D
	 skDDJabPGMemcLZtw0pYckoBoSZi8WP7aHN5LBRm8AvhQB0x6iqad2zqIhuWEFO33c81Qqdxyl23
	 626sMZ3z67sFPAaJtij3QToZaciVzv7wpqx8bO36bQeNQ2TnQBRKTpc3DFUIHnNQDWZng/4B5P+G
	 X/AyqPmMWnK6LyfixxCyfWHxx2I/WlHcKhjjhcgUq6ZtpMcyUOs5PHlnvn7lTf7Qr+t+R35FLrh1
	 qvWFTJS0f3DiousnC1PM/fNU6XXNwSz0IEW7CX3VMqrY7vihAuuUj3UElw5ncaeSOZWA1mbmGQU0
	 4s18cr7FFX5tBi4nFw6P5vNftCl97TQhTqsAuF3gLQJ6VsGeiT9gz3cIaVtaHh8u8NNv2ZesJi3Q
	 yWs42OApmvgXHGAGRYJwRwEm+hPx0iekZyYq2pnXfW6XygxrgKPjMUbI95i+s2wQIxF426TzENkx
	 Nxo9SOtfmVB928GCf3XF+E47SphWD2ZWw7KfCL2jnqqyF13m4plabOOS702/fI3WVvKSvZ4SoOD8
	 Jp17QRzPuUMYlkZLGnAQ1f9v08dqn1ZAsT5v+6j8u6muXQNpyC30YpuCemB/VADN5PlLmopEWzwg
	 c94NvyUd7PXQVJ26w+EbqGwQomt3DUcDmzv9QUWIqF60zR8a2do0tvuh6kjD3+Kg0ZqRyyHZ4fDP
	 TaDkYRhaHXHS7oVwEgU7pIOZCMgf4pJJttanY2wpF42NOl4OTm4mx+plXralSed2c5mvHVFg97R2
	 ijZiNFWqCK03lJfu7ruTwiK9xXDTKqXeZ67xFoKfRX9VuwItYYUvb+1/zKjX3E01oQtdDpZ7pL6p
	 nGcyLVJxf58T3ec1+oJWy+nm3kK/a1Sk11wnQB2d2VAH1xb9kcKCh1vzm0cRqAUwGOf6ml3RRDhI
	 1Qv6JCWrXa9bEAYmzT3QCV1z0MLSFGpDrNDHifkDDqPVD+kncL1nYvrNsxvdAWb4tcznrQfX3uZi
	 rutQTEWcLkt/L7lE0SrMD96KpxEh22GZwIRyZiQST071C3vgOd
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: chafi <chafiprc@foxmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Yu Zhang <chafiprc@foxmail.com>
Subject: [PATCH 1/3] drm/i915/dsi: Program TRANS_HSYNC register for dual-link command mode
Date: Mon,  8 Jun 2026 17:12:42 +0800
X-OQ-MSGID: <20260608091245.462464-1-chafiprc@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261994-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,m:chafiprc@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chafiprc@foxmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chafiprc@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,foxmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79AD76547A9

From: Yu Zhang <chafiprc@foxmail.com>

The TRANS_HSYNC register programming and dual-link hsync halving is
placed inside the is_vid_mode() guard, so it only runs for video mode.
Command mode dual-link DSI also needs this:

1. Without TRANS_HSYNC written, the hardware retains an inconsistent
   state, leading to errors on modeset:

   [drm] *ERROR* mismatch in hw.pipe_mode.crtc_hsync_start
   (expected 2762, found 1380)

2. The hsync_start/end are not halved for each link, so the hardware
   stores per-link values while the software expects full values.

Fix this by moving the dual-link hsync halving and TRANS_HSYNC write
outside the is_vid_mode() guard, making them unconditional for all
DSI modes.

Fixes: d1aeb5f399d9 ("drm/i915/icl: Configure DSI transcoder timings")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <chafiprc@foxmail.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 951f30a64..c667d5941 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -950,7 +950,6 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 			       HACTIVE(hactive - 1) | HTOTAL(htotal - 1));
 	}
 
-	/* TRANS_HSYNC register to be programmed only for video mode */
 	if (is_vid_mode(intel_dsi)) {
 		if (intel_dsi->video_mode == NON_BURST_SYNC_PULSE) {
 			/* BSPEC: hsync size should be atleast 16 pixels */
@@ -961,18 +960,18 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 
 		if (hback_porch < 16)
 			drm_err(display->drm, "hback porch < 16 pixels\n");
+	}
 
-		if (intel_dsi->dual_link) {
-			hsync_start /= 2;
-			hsync_end /= 2;
-		}
+	if (intel_dsi->dual_link) {
+		hsync_start /= 2;
+		hsync_end /= 2;
+	}
 
-		for_each_dsi_port(port, intel_dsi->ports) {
-			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_write(display,
-				       TRANS_HSYNC(display, dsi_trans),
-				       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
-		}
+	for_each_dsi_port(port, intel_dsi->ports) {
+		dsi_trans = dsi_port_to_transcoder(port);
+		intel_de_write(display,
+			       TRANS_HSYNC(display, dsi_trans),
+			       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
 	}
 
 	/* program TRANS_VTOTAL register */
-- 
2.43.0


