Return-Path: <stable+bounces-141365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69239AAB6D3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2543A3A8B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4E2DF559;
	Tue,  6 May 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHa3ENHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E32DF542;
	Mon,  5 May 2025 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485923; cv=none; b=gFagWZXdjLodQzLgKAlCHWXjWK4CGEadzGu3DXpoGjzBSYZDFJXGLGPQ5kYR3AO56bCH9wWKZwKOK/TYU/HqI0XVUI7RNh6hPpkJzfxu27RafvclmTQKR68m729LmdL7i3QhN49n+EDcbTPffJCezTK9DDpml6vG1xPQdgH442k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485923; c=relaxed/simple;
	bh=QZJg/qnDtIKPDm96Agh/Xj3Gqhe9xZPuYljzuQiAzTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIRtGOxOnCMYYhcZb1RmZoPFOYE/TcJoax/0w9DgqoGweyjw/7wJMX5ZdhiuVUVNMdbVDyUdof8cgu3es1fvCMhzb22R4v2YS9vXRjJfLL23BE9vidq3EAFi3ph3ihT6zDyrvikQvJyCFUanNia1xtpAlz25LpQaZMJQfjDOC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHa3ENHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930DAC4CEE4;
	Mon,  5 May 2025 22:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485921;
	bh=QZJg/qnDtIKPDm96Agh/Xj3Gqhe9xZPuYljzuQiAzTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHa3ENHQ4J6S69Mj8pnN2cY5UbjJ9G0T1ERwBF8yZ35xClZrAXcaM3tEUyXXYRdWv
	 ieZ3oBcqa6Drolpxi+O8vzLddmOsXRJu5mZvJ0YwvrIhZ5PFrLRglKOoUcBqda0mzw
	 MeiJpMuPY8hVwVu7kn0qVSdPqHH2lHeEzmPDb/7xajyD74IMwbX5R0Ba7P7lslSNkx
	 89srhf7cLD0MtUhNCQV4q/QGW1WL9nyLdkaaWxmYbRSxdtFMU/D8gib96H/0x6BvTa
	 pj9JZjw2FP7Tx7eobOUvhUYOsEC+du2Ap8+QhP7oNraGVWFqH9lVx92aMECdrU1yGc
	 7mmlz04MrBjag==
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
Subject: [PATCH AUTOSEL 6.6 067/294] ASoC: mediatek: mt6359: Add stub for mt6359_accdet_enable_jack_detect
Date: Mon,  5 May 2025 18:52:47 -0400
Message-Id: <20250505225634.2688578-67-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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


