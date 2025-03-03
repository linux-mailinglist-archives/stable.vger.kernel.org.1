Return-Path: <stable+bounces-120120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5333A4C78C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DCF1883853
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB539243956;
	Mon,  3 Mar 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIWqSzVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0085243379;
	Mon,  3 Mar 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019443; cv=none; b=Geb6Zz72cQcbr9aQIBmU6Krybp8IqxSN7BLA2wrkjjN7mvTr2JNsHuU/5qRZEkxhGnb2LN9sGztvBQXddxhT1ta0E22ex+++5OgPHfML5ADB2+gThZkdSYqWNNSP5zbjG7L2etdX/FQj5e1NVCZVRX/DTokCCOiA9mHCubEhyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019443; c=relaxed/simple;
	bh=kzBJWSicag1qKjz5770nSTUwj7AkXxzpM6uIrGZGg44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKNJM7ymdbe2hbeZZvM3XGZK4Qwz2oNr7ekpdg0pCxdugPXV7wpFkxuc4liCuc9q95/q5S5uADbjeClO1xVjidJXEyCdBcB5V7aAmE9hG9dgRmhanW7Ebp2AviM0JJwFHm1KoS7wXNxtDYAH56+80ksNcmT4oHF1GH7hGFi08q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIWqSzVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F9C4CED6;
	Mon,  3 Mar 2025 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019443;
	bh=kzBJWSicag1qKjz5770nSTUwj7AkXxzpM6uIrGZGg44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIWqSzVAL7LJAfD7zzSwn1NesMyFw+mUp1uu4XcfEZb1aMuLI8AObBqJbHMit9lFU
	 nkGkBNLHyWjPW5UVNb01/zt2EOTXnBc6lf0Ii+APiI1E4mdo77Q3Zj9FAwSiz7p+pQ
	 2FXCr77pTR0uXAPN61NM/BEhJ3e0CvuDaXGSorNzx3yYyrWEBREK3X6IunVtQTKlY/
	 V0WoGfEE3HJ/9fp5OWgysi5FoyU0HPQbFD4Z4iKaK5D2JNtskl3g57NF4w/lowfrC9
	 1mxJcNGgjO27wJRuUlgjP2G+mug2/PSXxMTGK46hZs8DWV3BmrxJN3JJI69parrxFt
	 bNJoDZE7qKjIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/17] ASoC: dapm-graph: set fill colour of turned on nodes
Date: Mon,  3 Mar 2025 11:30:18 -0500
Message-Id: <20250303163031.3763651-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

[ Upstream commit d31babd7e304d3b800d36ff74be6739405b985f2 ]

Some tools like KGraphViewer interpret the "ON" nodes not having an
explicitly set fill colour as them being entirely black, which obscures
the text on them and looks funny. In fact, I thought they were off for
the longest time. Comparing to the output of the `dot` tool, I assume
they are supposed to be white.

Instead of speclawyering over who's in the wrong and must immediately
atone for their wickedness at the altar of RFC2119, just be explicit
about it, set the fillcolor to white, and nobody gets confused.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/sound/dapm-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index f14bdfedee8f1..b6196ee5065a4 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -10,7 +10,7 @@ set -eu
 
 STYLE_COMPONENT_ON="color=dodgerblue;style=bold"
 STYLE_COMPONENT_OFF="color=gray40;style=filled;fillcolor=gray90"
-STYLE_NODE_ON="shape=box,style=bold,color=green4"
+STYLE_NODE_ON="shape=box,style=bold,color=green4,fillcolor=white"
 STYLE_NODE_OFF="shape=box,style=filled,color=gray30,fillcolor=gray95"
 
 # Print usage and exit
-- 
2.39.5


