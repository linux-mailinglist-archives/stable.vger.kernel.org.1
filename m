Return-Path: <stable+bounces-180846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79DB8E96D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CA7AA840
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57472625;
	Sun, 21 Sep 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUD2hQgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC21EC018
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496574; cv=none; b=heOVrVVHT+3rjXaZVRvGFbjm6BVrIekaQlPvDxa85dpAZ5se5n+EaCSpO1u131cAsfSWgGTmZ4TNL3y9om6EZaWaIRWWbCI172qSiiun269ln38b22+yBSJznoDSORrpkYaD2sCojRHw8Uzm/SvqU3qQJQa2P8KK+gEQyOGrk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496574; c=relaxed/simple;
	bh=eSscLVDVS/WVcpDTyEJ4pnzehSdk07HbJtgLidnaHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZASqFiZOheXjwRqDkYXMc4N7kHgmX1lMwAsUF5q3tvdvrWfugoP/TsnKuJltNhx7DCzuQwsf/Sghi2KQvRWXSkarrMQ6j8/vF9dWthilr3D8EWT6hEYa8Ve/qS31Voudsns9UPgKrcLjiyUFIe5HT0s3dlWMtuiB9vBKMOOVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUD2hQgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF2EC4CEE7;
	Sun, 21 Sep 2025 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758496573;
	bh=eSscLVDVS/WVcpDTyEJ4pnzehSdk07HbJtgLidnaHog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUD2hQgBsOHN93R84cxx5NTJ8RYOAxiDiBlmXjp/wzHztTmr35UC5HbMS7ZJq7XXi
	 7AHjfqU9+Yu2oOZtT4GhjqwDvuFSvNEQij4kJEPtivVeOLix19arms4Vd84W3EDlAe
	 CD5KNiMdLQ15sFfturbDFeQ30LAQWvq9fBtL4t9E7NGP0X7qL+m98yyRKWjYPL01aj
	 xXqehgpgfsu5GLHrybWKZxoOX9zstKZjPoRKr/zFgW8uFuDt+YiGl4o8347LQk4ZE6
	 7JPC/m1QwrjEU+j26AG6pdzx5BBuZVPj6GTHuKu/h/Ay4En3v2wLTyCyT+NrZDXXM4
	 YkOqCPbh1ahjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ASoC: qcom: q6apm-lpass-dai: close graphs before opening a new one
Date: Sun, 21 Sep 2025 19:16:09 -0400
Message-ID: <20250921231611.3032852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092104-booting-overstate-c9cf@gregkh>
References: <2025092104-booting-overstate-c9cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit c52615e494f17f44b076ac8ae5a53cfc0041a0dd ]

On multiple prepare calls, its possible that the playback graphs are
not unloaded from the DSP, which can have some wierd side-effects,
one of them is that the data not consumed without any errors.

Fixes: c2ac3aec474d("ASoC: qcom: q6apm-lpass-dai: unprepare stream if its already prepared")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230323164403.6654-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 68f27f7c7708 ("ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 23d23bc6fbaa7..420e8aa11f421 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -130,6 +130,9 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 	if (dai_data->is_port_started[dai->id]) {
 		q6apm_graph_stop(dai_data->graph[dai->id]);
 		dai_data->is_port_started[dai->id] = false;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			q6apm_graph_close(dai_data->graph[dai->id]);
 	}
 
 	/**
-- 
2.51.0


