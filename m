Return-Path: <stable+bounces-118885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CFA41D62
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C123BCE0E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE925A630;
	Mon, 24 Feb 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDpMOX0/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB713E40F;
	Mon, 24 Feb 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396060; cv=none; b=gXdPih+UpWBosljlwiqTGKmS0wiItBban9W92cuSBnB3pLKUinLwg3RPWuL6hbqn48w/mofov8+lrOleVAlgjSFIFsVEyku94fR8R/xRHsAjvM6YK3GJ3GvHYjLdEeLHwz8Aky1Vq9/QCppdFYK523wYpEQYtzWACrv6Rx0sGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396060; c=relaxed/simple;
	bh=45M25RYS8Htfx9OfpaXzbZdEu3KrYGkziD99hyUJN4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adK7g/iPLuvsR5KAbNZvM0ccVtkJPYpLZ4m6evMjLHz+tmX76yvedWS6CoUbyDgFvemvQ9rpiQo68KDPc3v8Oh2hAojLEN5XcLBnf9Tx4PMBriE4eGom0fsfTiEKqoCIl5JkGMNZebcBIXjL1sudY2OFn4f+PTeWEn0E3ivz8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDpMOX0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65516C4CEE9;
	Mon, 24 Feb 2025 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396059;
	bh=45M25RYS8Htfx9OfpaXzbZdEu3KrYGkziD99hyUJN4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDpMOX0/lfYRFxL86gvmol4n9IHJnTqPWDMYZe79/KIDhh4DKtuVEOf0afbsNa/+m
	 Ifz8qM01bjVvOse7z86D2JCl0xtVVp+rXrtJTNydyPL2FuR7t6+la2bq0nJHOBruwG
	 Yh7chRq6kwXFl7PbywpXgETEKXif1nlcHgsWQvFh7M8kERsRVaLrbAeRHDzLE6494e
	 4xOhUOOF3ukVK4wPon4i7cpiAL+dJfI+tshE4q8dpqkEq3znoxmwKUjvnCu00w/uQj
	 x+cyp3nfW1RLGc39QuqOhuKs5JQi+f+caa4ViKKC6ittjIvuFIr0LVDJM7jjrqvnbv
	 LL9Z2um/68flg==
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
	herve.codina@bootlin.com,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/7] ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()
Date: Mon, 24 Feb 2025 06:20:45 -0500
Message-Id: <20250224112051.2215017-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112051.2215017-1-sashal@kernel.org>
References: <20250224112051.2215017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit c3fc002b206c6c83d1e3702b979733002ba6fb2c ]

rsnd_kctrl_accept_runtime() (1) is used for runtime convert rate
(= Synchronous SRC Mode). Now, rsnd driver has 2 kctrls for it

(A):	"SRC Out Rate Switch"
(B):	"SRC Out Rate"		// it calls (1)

(A): can be called anytime
(B): can be called only runtime, and will indicate warning if it was used
   at non-runtime.

To use runtime convert rate (= Synchronous SRC Mode), user might uses
command in below order.

(X):	> amixer set "SRC Out Rate" on
	> aplay xxx.wav &
(Y):	> amixer set "SRC Out Rate" 48010 // convert rate to 48010Hz

(Y): calls B
(X): calls both A and B.

In this case, when user calls (X), it calls both (A) and (B), but it is not
yet start running. So, (B) will indicate warning.

This warning was added by commit b5c088689847 ("ASoC: rsnd: add warning
message to rsnd_kctrl_accept_runtime()"), but the message sounds like the
operation was not correct. Let's update warning message.

The message is very SRC specific, implement it in src.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://patch.msgid.link/8734gt2qed.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/core.c | 14 --------------
 sound/soc/sh/rcar/rsnd.h |  1 -
 sound/soc/sh/rcar/src.c  | 18 +++++++++++++++++-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 289928d4c0c99..1471d163a7f7a 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1599,20 +1599,6 @@ int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io)
 	return 1;
 }
 
-int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io)
-{
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-
-	if (!runtime) {
-		dev_warn(dev, "Can't update kctrl when idle\n");
-		return 0;
-	}
-
-	return 1;
-}
-
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg)
 {
 	cfg->cfg.val = cfg->val;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6b519370fd644..b5a7741848d77 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -737,7 +737,6 @@ struct rsnd_kctrl_cfg_s {
 #define rsnd_kctrl_vals(x)	((x).val)	/* = (x).cfg.val[0] */
 
 int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io);
-int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg);
 int rsnd_kctrl_new(struct rsnd_mod *mod,
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index fd52e26a3808b..577d50e2cf8c6 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -521,6 +521,22 @@ static irqreturn_t rsnd_src_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int rsnd_src_kctrl_accept_runtime(struct rsnd_dai_stream *io)
+{
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+
+	if (!runtime) {
+		struct rsnd_priv *priv = rsnd_io_to_priv(io);
+		struct device *dev = rsnd_priv_to_dev(priv);
+
+		dev_warn(dev, "\"SRC Out Rate\" can use during running\n");
+
+		return 0;
+	}
+
+	return 1;
+}
+
 static int rsnd_src_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -584,7 +600,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       rsnd_io_is_play(io) ?
 			       "SRC Out Rate" :
 			       "SRC In Rate",
-			       rsnd_kctrl_accept_runtime,
+			       rsnd_src_kctrl_accept_runtime,
 			       rsnd_src_set_convert_rate,
 			       &src->sync, 192000);
 
-- 
2.39.5


