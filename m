Return-Path: <stable+bounces-63699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C2941A34
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08611F244A4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6818454A;
	Tue, 30 Jul 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQ+h0PGC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F31A6192;
	Tue, 30 Jul 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357671; cv=none; b=QAV+rNWxSVauUG6xkD6RN9gQCj85Tcoepz0OqMr8XfhFtSLkxKktzN8zy6r09FhHGj36SkFKVzSs74IpdHj/YGaR0OjNLZVvWYLWL9ZhpJwFiEBK8e1u1qwtGA2w3QL8Pw1vC3ZCbhxmuvEJJFiBfcg83G/aKR+G+yIi35KZSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357671; c=relaxed/simple;
	bh=u8Xm5LH6ul5cKVLQlcOMnBoHKunb/3lM8q8OsRZO7VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCdelFc1Aqr7OHw1VYW3i4uqHM1/amHa+fBHO5EuyTM1527uj2/eN3wSGkbOe9AiuIBvTzGmylkyD5QpXgcrRSoC/BgQTgQxyU3wX2sLG9XQb8x5bLW/ZK58zjAXg+QtmisgVEnOIlkdg9r36uzYQ+RGC3REkfVnHSk3c8gDWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQ+h0PGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48174C32782;
	Tue, 30 Jul 2024 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357671;
	bh=u8Xm5LH6ul5cKVLQlcOMnBoHKunb/3lM8q8OsRZO7VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQ+h0PGCLOBkyoPydzGs/yqL65KE1NER7b9y7JWGu1DDxdyrdxgi1io8WeD3EJqnC
	 1IhADuyc5BXc4kuMzuKZupB7/adpXTRLbDDkg2sXLBaqY5QRmVA6dFB7REt5ldnN3y
	 ekECQ6Ua026QSi9FAU5M9u7b2suj6pcirloNBRyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 280/568] ASoC: max98088: Check for clk_prepare_enable() error
Date: Tue, 30 Jul 2024 17:46:27 +0200
Message-ID: <20240730151650.819002603@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 1a70579723fde3624a72dfea6e79e55be6e36659 ]

clk_prepare_enable() may fail, so we should better check its return
value and propagate it in the case of error.

Fixes: 62a7fc32a628 ("ASoC: max98088: Add master clock handling")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20240628080534.843815-1-nichen@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98088.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 8b56ee550c09e..8b0645c634620 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1318,6 +1318,7 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
                                   enum snd_soc_bias_level level)
 {
 	struct max98088_priv *max98088 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1333,10 +1334,13 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
 		 */
 		if (!IS_ERR(max98088->mclk)) {
 			if (snd_soc_component_get_bias_level(component) ==
-			    SND_SOC_BIAS_ON)
+			    SND_SOC_BIAS_ON) {
 				clk_disable_unprepare(max98088->mclk);
-			else
-				clk_prepare_enable(max98088->mclk);
+			} else {
+				ret = clk_prepare_enable(max98088->mclk);
+				if (ret)
+					return ret;
+			}
 		}
 		break;
 
-- 
2.43.0




