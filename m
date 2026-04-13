Return-Path: <stable+bounces-237201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM0NOoQg3WneaAkAu9opvQ
	(envelope-from <stable+bounces-237201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:57:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE83F0590
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C25030811A9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8126ED41;
	Mon, 13 Apr 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwO0H2T8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F0314D26;
	Mon, 13 Apr 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098846; cv=none; b=CsjtpMvUQnjcQNjzexbXqIvCoIpm8zEPazjrNCNS8Iu7ghwiec9PBzfJzOjcRG7PHeKMsX14p3d4k+qbC4ZugAy7CuOJLOS/Tsn3aZHC+EZMw5ISReuVoQime9ldPplSaLUpaWLkxGNfDhTSMdxFbjwHC8Ooe9lZm+v7C8nG4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098846; c=relaxed/simple;
	bh=+GDDFJHLBoaRvypGnh8C+bTZnrwEJkJWLxUXnE5o/WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lcl+ockKRwv95NvEd3O+c57Zae4m4bWjMqYL9gp237P2C3RqIA6cn4R5ldRT0fRYB84OKADllmY+4YMt6rqj+7EmjO5ObSYWlsnsJy9FXRn8fYIlP0h+8eKFA4l+1eJy2qW6I72BDEhE1IMSjSU3hoEUmh61G9TynRqSc0eTFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwO0H2T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC3C2BCAF;
	Mon, 13 Apr 2026 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098846;
	bh=+GDDFJHLBoaRvypGnh8C+bTZnrwEJkJWLxUXnE5o/WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwO0H2T8maciL4oZnbDvvqp86Jr0JxpJhFqFXPG0aU3h47jaLcF+qec3/ovMVlTL3
	 cGZHFsl8egixKppUtZFC9XLMrHSQ3qQ/d78E9D+nmEK7YMppHXu5SC7joL1u9ToZ75
	 tGWF5l+/OBnImzxqo6OrKvjLB2FnBU2/rQWAObNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 069/491] ASoC: soc-core: accept zero format at snd_soc_runtime_set_dai_fmt()
Date: Mon, 13 Apr 2026 17:55:14 +0200
Message-ID: <20260413155821.629489273@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237201-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 7BAE83F0590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 7db07e37e13cfd46039d82aed91092185eac6565 ]

Do nothing if format was zero at snd_soc_runtime_set_dai_fmt().
soc-core.c can be more simple code by this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ee8jt7d3.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 95bc5c225513 ("ASoC: soc-core: flush delayed work before removing DAIs and widgets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/meson-codec-glue.c |  3 ---
 sound/soc/soc-core.c               | 11 ++++++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/meson/meson-codec-glue.c b/sound/soc/meson/meson-codec-glue.c
index d07270d17cee7..2870cfad813ac 100644
--- a/sound/soc/meson/meson-codec-glue.c
+++ b/sound/soc/meson/meson-codec-glue.c
@@ -113,9 +113,6 @@ int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
 	/* Replace link params with the input params */
 	rtd->dai_link->params = &in_data->params;
 
-	if (!in_data->fmt)
-		return 0;
-
 	return snd_soc_runtime_set_dai_fmt(rtd, in_data->fmt);
 }
 EXPORT_SYMBOL_GPL(meson_codec_glue_output_startup);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2fca5d03fd4f7..4294206dff362 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1240,6 +1240,9 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int i;
 	int ret;
 
+	if (!dai_fmt)
+		return 0;
+
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
 		if (ret != 0 && ret != -ENOTSUPP)
@@ -1297,11 +1300,9 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 		return ret;
 
 	snd_soc_runtime_get_dai_fmt(rtd);
-	if (dai_link->dai_fmt) {
-		ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
-		if (ret)
-			return ret;
-	}
+	ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+	if (ret)
+		return ret;
 
 	/* add DPCM sysfs entries */
 	soc_dpcm_debugfs_add(rtd);
-- 
2.51.0




