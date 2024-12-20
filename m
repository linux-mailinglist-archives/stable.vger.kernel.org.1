Return-Path: <stable+bounces-105448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B09F97A4
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EEE16065E
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9E225A46;
	Fri, 20 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI2fygnw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEAA225A37;
	Fri, 20 Dec 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714731; cv=none; b=fMb5PnPXCd3y0ZadoHBiI3+eks81qBpxGvk1x0vMsBasBnQeoWr21q6jCk1L7uaR6iLjDh7ijBAPixgvTYJe8a7Rjn59E7m37PdMFrnlQHz2HnEL8hMXpQCgBewRLBe+B/Az3SICpVnbpTTr4ZLxnEtimtEYvC0EPv2Ebni1Ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714731; c=relaxed/simple;
	bh=Cs8Fwbjm/+tdErIqsMWNv7TNq9GRR/CppRqJN9tMKJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R84IblvELJdZ0WHg+WgpEGL6T1U4ZzCZf8O5+9Ic+vYGsG8jOzqEj88RERuW2dSlAicvIi0m+pNF1g9Xz8qCf6UQ31t01A3Gsf2Pty44fmLjG2MLXqWh4MCzqN9NnjD3TZbgupsSNv5e0sgaiNL76jI6DovlxOno83rX+7twSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI2fygnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B7BC4CED7;
	Fri, 20 Dec 2024 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714731;
	bh=Cs8Fwbjm/+tdErIqsMWNv7TNq9GRR/CppRqJN9tMKJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mI2fygnweTx6+NuH5TaGtTI7IxHJNL7mWiPjWos0eAQD2EHoCi12YZYa2OpkcfysN
	 /wGKwpK8rvCsdx9FSf0iBzNQ2Op2HTOGKW3GZeVNNJH8Su4a5xn1phgr/q7kW4YGL9
	 qs04SWaCwiGmN4b0GY9gSb9Xk3tw9mGKtFf2i+sntsmDGqJCSMRH8c6u5yKKykqjU+
	 /2wtOIeceqZrU1IQSkAmHWAkA9tVdO7CZCsO11eJYpHimvVdiAh8IJgbL5NDito9dS
	 ltyfAXc13l8n9OL9igUc8EFeDqlVJLGCeUFT1Yg5ak5Yv0fbNJNO5tVqWlquHbVRaG
	 pijfu39qLn67Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Gordon <gordoste@iinet.net.au>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/29] ASoC: audio-graph-card: Call of_node_put() on correct node
Date: Fri, 20 Dec 2024 12:11:17 -0500
Message-Id: <20241220171130.511389-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Stephen Gordon <gordoste@iinet.net.au>

[ Upstream commit 687630aa582acf674120c87350beb01d836c837c ]

Signed-off-by: Stephen Gordon <gordoste@iinet.net.au>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/20241207122257.165096-1-gordoste@iinet.net.au
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 93eee40cec76..63837e259659 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -779,7 +779,7 @@ static void graph_link_init(struct simple_util_priv *priv,
 	of_node_get(port_codec);
 	if (graph_lnk_is_multi(port_codec)) {
 		ep_codec = graph_get_next_multi_ep(&port_codec);
-		of_node_put(port_cpu);
+		of_node_put(port_codec);
 		port_codec = ep_to_port(ep_codec);
 	} else {
 		ep_codec = port_to_endpoint(port_codec);
-- 
2.39.5


