Return-Path: <stable+bounces-118851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91456A41CF8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3223161B0C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A026981B;
	Mon, 24 Feb 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEv4oE36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF943269811;
	Mon, 24 Feb 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395974; cv=none; b=DjOGVUcBC6dZLvRoNrrXiFWte/mylOoqxev2SKpjVE4P0/I1LrZFQCl+WFVYX1P4rnyxJ0MOv53cix3nqYkM5/NPP7GIky+19XBGFkc/sDhfq2GDsrPQTTv+21tUBrTh8SB5xZs0sv5i6L3S9WBqB65cYRy6KvHMMz2H3JPnpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395974; c=relaxed/simple;
	bh=JbYs6CPuyfa3uoR3bDdzYEkr86ANZ03AnoglmKeiZF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9nRsm2NBE6uD1kEjKlToABPreSHiCfPPGKfz9kSdESwZamGElndCmt8XKoGpE9tW2oEBq5taoxDZr8L41MagTjdPs4C2tbg3WKOv9B7SeyJcwhAqxwL/dfy+VahQxpoVmnQH/k8FOn+tpsNmlCzBu+Y/me4uS7WpWtY1fgIuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEv4oE36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6639AC4CEE6;
	Mon, 24 Feb 2025 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395974;
	bh=JbYs6CPuyfa3uoR3bDdzYEkr86ANZ03AnoglmKeiZF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEv4oE36LEfRsTjVY2bKpzwbDAAFP8+FtuYT1Pr4NvgvI6G54fRuR7iAhBKJYDsvE
	 Om9YzT/7J3KZAGCvtNg0/m6bhmZcg5kod7VTZx7IgFsdmfcmdpUwVh3QdQnWPl1zxN
	 8lHaNMwEtr3Eoqt9Ygur5sQIPiEb9c1rUuDExSHFTx7tAjg3VJLRqwKnV9rpZ0qS49
	 SAWtsgLUFDTVSPTY6fJgGW9+fR6CeR1zDK+HNmrM1c4E7KhPHHjRsurNX2ePO04vEx
	 SQ/EcbRLQA7+AT6BQ0Z9ZWFtx3M3GkAMf5iV2ciu67IcBy3NLVdTYqmDLTqucRq+K3
	 eRN9BiQ87ukwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/20] ASoC: rsnd: adjust convert rate limitation
Date: Mon, 24 Feb 2025 06:19:00 -0500
Message-Id: <20250224111914.2214326-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 89f9cf185885d4358aa92b48e51d0f09b71775aa ]

Current rsnd driver supports Synchronous SRC Mode, but HW allow to update
rate only within 1% from current rate. Adjust to it.

Becially, this feature is used to fine-tune subtle difference that occur
during sampling rate conversion in SRC. So, it should be called within 1%
margin of rate difference.

If there was difference over 1%, it will apply with 1% increments by using
loop without indicating error message.

Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://patch.msgid.link/871pwd2qe8.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/src.c | 98 ++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 22 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 9893839666d7b..e985681363e25 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -34,6 +34,7 @@ struct rsnd_src {
 	struct rsnd_mod *dma;
 	struct rsnd_kctrl_cfg_s sen;  /* sync convert enable */
 	struct rsnd_kctrl_cfg_s sync; /* sync convert */
+	u32 current_sync_rate;
 	int irq;
 };
 
@@ -99,7 +100,7 @@ static u32 rsnd_src_convert_rate(struct rsnd_dai_stream *io,
 	if (!rsnd_src_sync_is_enabled(mod))
 		return rsnd_io_converted_rate(io);
 
-	convert_rate = src->sync.val;
+	convert_rate = src->current_sync_rate;
 
 	if (!convert_rate)
 		convert_rate = rsnd_io_converted_rate(io);
@@ -200,13 +201,73 @@ static const u32 chan222222[] = {
 static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 				      struct rsnd_mod *mod)
 {
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	u32 fin, fout, new_rate;
+	int inc, cnt, rate;
+	u64 base, val;
+
+	if (!runtime)
+		return;
+
+	if (!rsnd_src_sync_is_enabled(mod))
+		return;
+
+	fin	= rsnd_src_get_in_rate(priv, io);
+	fout	= rsnd_src_get_out_rate(priv, io);
+
+	new_rate = src->sync.val;
+
+	if (!new_rate)
+		new_rate = fout;
+
+	/* Do nothing if no diff */
+	if (new_rate == src->current_sync_rate)
+		return;
+
+	/*
+	 * SRCm_IFSVR::INTIFS can change within 1%
+	 * see
+	 *	SRCm_IFSVR::INTIFS Note
+	 */
+	inc = fout / 100;
+	cnt = abs(new_rate - fout) / inc;
+	if (fout > new_rate)
+		inc *= -1;
+
+	/*
+	 * After start running SRC, we can update only SRC_IFSVR
+	 * for Synchronous Mode
+	 */
+	base = (u64)0x0400000 * fin;
+	rate  = fout;
+	for (int i = 0; i < cnt; i++) {
+		val   = base;
+		rate += inc;
+		do_div(val, rate);
+
+		rsnd_mod_write(mod, SRC_IFSVR, val);
+	}
+	val   = base;
+	do_div(val, new_rate);
+
+	rsnd_mod_write(mod, SRC_IFSVR, val);
+
+	/* update current_sync_rate */
+	src->current_sync_rate = new_rate;
+}
+
+static void rsnd_src_init_convert_rate(struct rsnd_dai_stream *io,
+				       struct rsnd_mod *mod)
+{
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int is_play = rsnd_io_is_play(io);
 	int use_src = 0;
 	u32 fin, fout;
-	u32 ifscr, fsrate, adinr;
+	u32 ifscr, adinr;
 	u32 cr, route;
 	u32 i_busif, o_busif, tmp;
 	const u32 *bsdsr_table;
@@ -244,26 +305,15 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	adinr = rsnd_get_adinr_bit(mod, io) | chan;
 
 	/*
-	 * SRC_IFSCR / SRC_IFSVR
-	 */
-	ifscr = 0;
-	fsrate = 0;
-	if (use_src) {
-		u64 n;
-
-		ifscr = 1;
-		n = (u64)0x0400000 * fin;
-		do_div(n, fout);
-		fsrate = n;
-	}
-
-	/*
+	 * SRC_IFSCR
 	 * SRC_SRCCR / SRC_ROUTE_MODE0
 	 */
+	ifscr	= 0;
 	cr	= 0x00011110;
 	route	= 0x0;
 	if (use_src) {
 		route	= 0x1;
+		ifscr	= 0x1;
 
 		if (rsnd_src_sync_is_enabled(mod)) {
 			cr |= 0x1;
@@ -334,7 +384,6 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_SRCIR, 1);	/* initialize */
 	rsnd_mod_write(mod, SRC_ADINR, adinr);
 	rsnd_mod_write(mod, SRC_IFSCR, ifscr);
-	rsnd_mod_write(mod, SRC_IFSVR, fsrate);
 	rsnd_mod_write(mod, SRC_SRCCR, cr);
 	rsnd_mod_write(mod, SRC_BSDSR, bsdsr_table[idx]);
 	rsnd_mod_write(mod, SRC_BSISR, bsisr_table[idx]);
@@ -347,6 +396,9 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 
 	rsnd_adg_set_src_timesel_gen2(mod, io, fin, fout);
 
+	/* update SRC_IFSVR */
+	rsnd_src_set_convert_rate(io, mod);
+
 	return;
 
 convert_rate_err:
@@ -466,7 +518,8 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 	int ret;
 
 	/* reset sync convert_rate */
-	src->sync.val = 0;
+	src->sync.val		=
+	src->current_sync_rate	= 0;
 
 	ret = rsnd_mod_power_on(mod);
 	if (ret < 0)
@@ -474,7 +527,7 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_activation(mod);
 
-	rsnd_src_set_convert_rate(io, mod);
+	rsnd_src_init_convert_rate(io, mod);
 
 	rsnd_src_status_clear(mod);
 
@@ -492,7 +545,8 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 	rsnd_mod_power_off(mod);
 
 	/* reset sync convert_rate */
-	src->sync.val = 0;
+	src->sync.val		=
+	src->current_sync_rate	= 0;
 
 	return 0;
 }
@@ -600,7 +654,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       "SRC Out Rate Switch" :
 			       "SRC In Rate Switch",
 			       rsnd_kctrl_accept_anytime,
-			       rsnd_src_set_convert_rate,
+			       rsnd_src_init_convert_rate,
 			       &src->sen, 1);
 	if (ret < 0)
 		return ret;
-- 
2.39.5


