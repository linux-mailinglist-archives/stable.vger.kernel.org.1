Return-Path: <stable+bounces-271983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TcASMR1fSWph0wAAu9opvQ
	(envelope-from <stable+bounces-271983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 21:29:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E97083EB
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 21:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271983-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271983-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0694300682D
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B157376490;
	Sat,  4 Jul 2026 19:29:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D8374E48;
	Sat,  4 Jul 2026 19:29:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193366; cv=none; b=c6MAsR93ybLiX0aWD0SfS/kaGv5siptpla4FZaddqA0pZOl+WvsL/WqCXX5sup0PbU2H0fL4FCMhc39vPTs348fXfn5c5Z4Drf3lz2pGMgU5qsjxxkKoeF4wxVb2FLyoyoYhQgQz9JVzn0mm/Oitl3e+1QApXnh3LD94Bo/8EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193366; c=relaxed/simple;
	bh=8uG09NracTJuE4Jo/AqYI1RPizfOvPcxiYYG2z/CJi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyTQRy58bbUnvbrrVG/EXMkKCcbul/v0mYg3kUwKf5WT+iY+HisaFsFQUhM73N76RYwtU6vW/FH2uo+XiEn3+SKOYnRz0OvPX3rwckee+ZNMS+8B5iD3EHWo0uQlDbfy7oMoWlIJALqmTLzfOrrxp7Sg0U8HhPaiXzBm2sRRFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.231
Received: from MTA-15-3.privateemail.com (MTA-15.privateemail.com [198.54.118.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4gt1030XQKz2xCl;
	Sat,  4 Jul 2026 15:29:23 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4gt0zf4rbxz3hhTD;
	Sat,  4 Jul 2026 15:29:02 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Weidong Wang <wangweidong.a@awinic.com>,
	Val Packett <val@packett.cool>,
	Luca Weiss <luca.weiss@fairphone.com>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH] ASoC: codecs: aw88261: only check PLL and clock state at power-up
Date: Sat,  4 Jul 2026 21:28:57 +0200
Message-ID: <20260704192857.88366-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,awinic.com,packett.cool,fairphone.com,vger.kernel.org,catcrafts.net];
	TAGGED_FROM(0.00)[bounces-271983-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[catcrafts.net];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:lgirdwood@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:wangweidong.a@awinic.com,m:val@packett.cool,m:luca.weiss@fairphone.com,m:stable@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jorijnvdgraaf@catcrafts.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jorijnvdgraaf@catcrafts.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jorijnvdgraaf@catcrafts.net,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,catcrafts.net:from_mime,catcrafts.net:email,catcrafts.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C60E97083EB

The SYSST check performed during device start requires SWS (amplifier
switching, bit 8) and BSTS (boost finished, bit 9) on top of PLL lock
and clock stability. Those bits cannot be asserted at this point in the
sequence: the check runs after amppd release but before the
hmute/ULS-hmute release, and the amplifier neither switches nor
finishes ramping its boost converter while it is still muted. With the
Fairphone (Gen. 6) firmware profile, aw88261_dev_start() therefore
always fails with

  check sysst fail, reg_val=0x0011, check:0x311

and playback aborts, even though the amplifier is fine and PLL lock
and stable clocks are present.

Check only PLL lock and clock stability, for which a definition
already exists; this still re-validates the clocks after amppd release
(aw88261_dev_check_syspll() checked them before it). This matches the
vendor aw882xx driver, which only validates PLL lock and clock
stability at this stage, and the in-tree aw88399 driver, which skips
the SWS check whenever the amplifier may legitimately not be switching
(AW88399_BIT_SYSST_NOSWS_CHECK).

Fixes: 028a2ae25691 ("ASoC: codecs: Add aw88261 amplifier driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 sound/soc/codecs/aw88261.c | 6 +++---
 sound/soc/codecs/aw88261.h | 6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 549783d3e75e..dbdf51188cf5 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -206,10 +206,10 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 			return ret;
 
 		check_val = reg_val & (~AW88261_BIT_SYSST_CHECK_MASK)
-							& AW88261_BIT_SYSST_CHECK;
-		if (check_val != AW88261_BIT_SYSST_CHECK) {
+							& AW88261_BIT_PLL_CHECK;
+		if (check_val != AW88261_BIT_PLL_CHECK) {
 			dev_dbg(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
-				reg_val, AW88261_BIT_SYSST_CHECK);
+				reg_val, AW88261_BIT_PLL_CHECK);
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
 			return 0;
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 270ccf375f36..f16f9f8c40a2 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -194,12 +194,6 @@
 		AW88261_OTHS_OT_VALUE | \
 		AW88261_PLLS_LOCKED_VALUE))
 
-#define AW88261_BIT_SYSST_CHECK \
-		(AW88261_BSTS_FINISHED_VALUE | \
-		AW88261_SWS_SWITCHING_VALUE | \
-		AW88261_CLKS_STABLE_VALUE | \
-		AW88261_PLLS_LOCKED_VALUE)
-
 #define AW88261_ULS_HMUTE_START_BIT	(14)
 #define AW88261_ULS_HMUTE_BITS_LEN	(1)
 #define AW88261_ULS_HMUTE_MASK		\

base-commit: be44d21728b6646189779923b841ad3a46d694e5
-- 
2.55.0


