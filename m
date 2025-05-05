Return-Path: <stable+bounces-140498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B9AAA947
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5474A7043
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00135FAE6;
	Mon,  5 May 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naVr5Fxc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CF359E17;
	Mon,  5 May 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484985; cv=none; b=k9++apnk3IDJBTes9AZpF4/XByVBFPf/qvwSLfsByjfnwAl+R5QMuUlt6PHcTVbhgQbv/LYlNU4Mx/LYLftgTClnVSBvoYBEjdfbNgYYP4BiNcyzMiP3PA7oSrgk/qCty2RGQAwO5LwMchpuOu2I7Ay+qlTqLfZo5SyZMOy5t0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484985; c=relaxed/simple;
	bh=QZJg/qnDtIKPDm96Agh/Xj3Gqhe9xZPuYljzuQiAzTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNb4XU263ihHYMUmDWFIHu5uZCEAlOnSB9/queT6IgGWzIJEkK/DtyTSrlVbx9o3xqoGty2lVRPThqD92qEknAysHV1HCp5cbyQhJsjf0C1FxT3CBqKKsAST1/VSFgNiHH3n/08ufZAtzi92nonR8ZNiG0KAoqr0FwkV4HTaOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naVr5Fxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC50C4CEEF;
	Mon,  5 May 2025 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484984;
	bh=QZJg/qnDtIKPDm96Agh/Xj3Gqhe9xZPuYljzuQiAzTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naVr5FxcGOKxG/VuaB0iGZGt5VTk116vlXTIR6QY24l+AVxhcgr7hcSqi88Psx/Sf
	 O1sFzz1fGx1be74YOvFezPLq+hFmcJjdSXvBnS3XdeF8PLm+N7l0MeQoE3ocMeFGaM
	 /Jf6bd0R86FNSX/lS19ybgVqOrxqCrFRMHF+qzGdDjFz/hpRrwoU/1NgQo6dkv+iIN
	 6AjohRQ82XVbWRBsNKXm9EyqnQ8FG+5W0vcxlAC4B6KqwD9i7VtWVlZ66PhUiZuZre
	 JN7mZzGr7jjCG+/a4SLm0050/7wU4OdGHsNO9UBpPi00sbCNUrnpKGQ8AiVh+KfwEr
	 O6hyvep6ZbgTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 110/486] ASoC: mediatek: mt6359: Add stub for mt6359_accdet_enable_jack_detect
Date: Mon,  5 May 2025 18:33:06 -0400
Message-Id: <20250505223922.2682012-110-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 0116a7d84b32537a10d9bea1fd1bfc06577ef527 ]

Add a stub for mt6359_accdet_enable_jack_detect() to prevent linker
failures in the machine sound drivers calling it when
CONFIG_SND_SOC_MT6359_ACCDET is not enabled.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://patch.msgid.link/20250306-mt8188-accdet-v3-3-7828e835ff4b@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/mt6359-accdet.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index c234f2f4276a1..78ada3a5bfae5 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -123,6 +123,15 @@ struct mt6359_accdet {
 	struct workqueue_struct *jd_workqueue;
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_MT6359_ACCDET)
 int mt6359_accdet_enable_jack_detect(struct snd_soc_component *component,
 				     struct snd_soc_jack *jack);
+#else
+static inline int
+mt6359_accdet_enable_jack_detect(struct snd_soc_component *component,
+				 struct snd_soc_jack *jack)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif
-- 
2.39.5


