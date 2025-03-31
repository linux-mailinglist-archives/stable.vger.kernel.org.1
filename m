Return-Path: <stable+bounces-127194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B13A769FC
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA63B3C1F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA48C233708;
	Mon, 31 Mar 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg/9QXPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82813233716;
	Mon, 31 Mar 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432914; cv=none; b=GvfN90ZTbPtqC33o2R9z32div4cz245oqkucXtKbGkmxVZGxK0Db9uOQZucvJaxJujKR62H2euNo8/Inw/pKaagzArkYLlhcsKXMX17EFHNWirKfyE2o6HaaZ5/RmOf6B4neKm5jmAi7ROHzRNZhD7aJQboPGg9HeanOkFj9oVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432914; c=relaxed/simple;
	bh=icd6Oa5O6KWiKOuht2wEdQiNaTaeqek3EIBNhG54G1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNiOmxk9663YRrIRSrthTScopbYUel/qB/G2eOq8SIxuk5nXBO1+9IcG4UaI4H6I1GHASLLuLKdMYGbmA17TcUpPjWuNFASlmt82fPZIp0/g6+Ah/wFoA0GnJvurunrce+ZZI6agMNqub5lLQgWDNU00jht9I/RT+oTWgxs14gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg/9QXPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7E4C4CEE3;
	Mon, 31 Mar 2025 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432914;
	bh=icd6Oa5O6KWiKOuht2wEdQiNaTaeqek3EIBNhG54G1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hg/9QXPGdk2Gf2Fzw5wWO3AwEW57ts4bZAlH8heTMBOUpRLcq1lgqqmN0MALcwaS+
	 tXT1Cj2UvG9HDRyuzrb/+xHS67/Z+AtcyJxMm3Vr1/qx45We5w6b2MBsggCEEJS+A1
	 t88Z7rlciTCq11y/QEJdojMQOy0PBCAc1uqUok+Ujsldv0Bd2Albbd4lWrnvV0jofz
	 l9xR+aq9QPlp5mv8f8TJ/rBGDTzpctrigYOJaZTWOAc42gohhXRxo4TMTkX2bHXivy
	 NDDeXjW7WPqWGP6rSEsopp4jnSdbFU6N5WhzXdqYUmvG7lMDAZU9bJT51AUuXHLfaw
	 ReAo1CeRZmoDg==
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
Subject: [PATCH AUTOSEL 6.12 02/23] ASoC: SOF: topology: Use krealloc_array() to replace krealloc()
Date: Mon, 31 Mar 2025 10:54:48 -0400
Message-Id: <20250331145510.1705478-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145510.1705478-1-sashal@kernel.org>
References: <20250331145510.1705478-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index b3fca5fd87d68..37ca15cc5728c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1269,8 +1269,8 @@ static int sof_widget_parse_tokens(struct snd_soc_component *scomp, struct snd_s
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


