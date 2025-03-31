Return-Path: <stable+bounces-127216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE1A769ED
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B575416A991
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914AD2144B4;
	Mon, 31 Mar 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMsTTYAM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59D221710;
	Mon, 31 Mar 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432964; cv=none; b=izi5DkBJU+SQw42Waj9yCN7tzKMK39QMR+CeUpL+egV/B/P7kZqqs583CUGe2DeJ5DfV/AJQBbJR6eTTr+Yl4xRye+TC75BmbFtjIk90UI9GDFw1hqrq3Y3MSpeJRK7o6D3uwgFOPI8te625dHAcHJH99pJVa3cOMWbschOxnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432964; c=relaxed/simple;
	bh=/kyYR+odfJKo8/HBjohag0R+zlA8lDnjJL8Wz/SYofg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P5Cmw1L9UTO5aAp50949q3f9RsaGPw9DilltwlXU3BhmWKNtM5dcfL9J6PdL3XoUjDDWhlEKMrIDYx8sGYzpg4LewdkzSGa0SJ6oWmlfoSD6ZeBgyDi2gjUKkmSQ6U9p0gVCW8yFiYpora9wh7WGBA28LSEh7EBlqI7/N27zICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMsTTYAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBA8C4CEEB;
	Mon, 31 Mar 2025 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432963;
	bh=/kyYR+odfJKo8/HBjohag0R+zlA8lDnjJL8Wz/SYofg=;
	h=From:To:Cc:Subject:Date:From;
	b=TMsTTYAMet3l159Hoo1rnIaOOpszVi8gdiOMbeXzohvsZGjMz56OUm+6b8PZUtLuU
	 SawkkZOSHFh7P9kIinQf4oV76+MTSuPnH8es9nEGDhaD0+yfzS1lssGifrfGPeyS1A
	 vP2Zxh4888NY2ksOta/x2vdT2X57NP1cZaH8X3GolU19xgL/Lrm3eFfCnlpxm3U6Xp
	 dV0lu73m0KqBiwgt40INhZPU3HsTC3MWT2XKzBNDTfUdm5TrW9NjVz6Y5UOQlBHziO
	 wkJw0Srwtfn9Py7TamAWtnx+ASVpAVpFmQ1+S5qEYklHNcDG9i9silp1KU7VYIY3F7
	 3wWtY54RCJIfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/19] ASoC: SOF: topology: Use krealloc_array() to replace krealloc()
Date: Mon, 31 Mar 2025 10:55:42 -0400
Message-Id: <20250331145601.1705784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit a05143a8f713d9ae6abc41141dac52c66fca8b06 ]

Use krealloc_array() to replace krealloc() with multiplication.
krealloc_array() has multiply overflow check, which will be safer.

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20250117014343.451503-1-zhangheng@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index cf1e63daad86b..7afded323150c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1267,8 +1267,8 @@ static int sof_widget_parse_tokens(struct snd_soc_component *scomp, struct snd_s
 			struct snd_sof_tuple *new_tuples;
 
 			num_tuples += token_list[object_token_list[i]].count * (num_sets - 1);
-			new_tuples = krealloc(swidget->tuples,
-					      sizeof(*new_tuples) * num_tuples, GFP_KERNEL);
+			new_tuples = krealloc_array(swidget->tuples,
+						    num_tuples, sizeof(*new_tuples), GFP_KERNEL);
 			if (!new_tuples) {
 				ret = -ENOMEM;
 				goto err;
-- 
2.39.5


