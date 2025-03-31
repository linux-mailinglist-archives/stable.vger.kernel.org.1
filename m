Return-Path: <stable+bounces-127171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6EA7694F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0E2163323
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7422ACF7;
	Mon, 31 Mar 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7baN3za"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFE22ACCE;
	Mon, 31 Mar 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432851; cv=none; b=aRMXnC0L/zNkm/8NzyXk1IJLXykgl+DDhKCHJP4sGXRTqqO+suxlN9YGn6ubOYN+22ZVDt3GiiboVj9PSzLZjGPmg3zaebd3t2fZ22N+l3BVO077wVk9tT+Aa/TpIqlwba2Py5epfhVZbTdJKWZMD/tEGwUdxVD3y5RickQrYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432851; c=relaxed/simple;
	bh=icd6Oa5O6KWiKOuht2wEdQiNaTaeqek3EIBNhG54G1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igmQmQEUwFs/lvWsu4MoZ2WMpDa6Q+mBU2WZ5SjOfPVHbrh7T7lZhy2UZIXSZ6B2UzXxqJEDQzIUTPBbgQMSbdqhPpAoXLjF3fCaj8o2F8Mm4pb/VFxSdvLU/F52ONZs8B3pLviM1aq365go+/Nc6mHJaf4ncRAeCvw8KMY8sUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7baN3za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E0C4CEE9;
	Mon, 31 Mar 2025 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432849;
	bh=icd6Oa5O6KWiKOuht2wEdQiNaTaeqek3EIBNhG54G1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7baN3zasEsQB/V7ZbopVj5MgpizTwDQtVZ+gvZnfSzVqtaRSeumTdLJssnhhl3Ql
	 sIwnUW+jNSNC3BBiq9hzFmzErMGF0C5j47KcROylp5k0taGCN5tePPr1cw8nuxS2YF
	 4DFs3Gfe3Ai4u0gWNGo+ksCGQoyP6VTyAWOLX+WY4Dc7k1wZ4P8MpNbD3bVNM74ymL
	 2zMUdBsHB46qejm4jl9e2TNYtigSbyiNZvlp8npMsQ3zoTgxe1uHli7SX88YS0eZ4f
	 zhDcZuKmFyUpf4sCn6/ii5164MDjCARTaBFuc795psnySqHTYAW+ThJX7+TN8KZb+S
	 R3WkLpxQDTjpA==
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
Subject: [PATCH AUTOSEL 6.13 02/24] ASoC: SOF: topology: Use krealloc_array() to replace krealloc()
Date: Mon, 31 Mar 2025 10:53:42 -0400
Message-Id: <20250331145404.1705141-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145404.1705141-1-sashal@kernel.org>
References: <20250331145404.1705141-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


