Return-Path: <stable+bounces-58808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B992792C036
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E921A1C23F01
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F91BE259;
	Tue,  9 Jul 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON4ORJGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7B1BE24C;
	Tue,  9 Jul 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542159; cv=none; b=KR0L1nfc6f24lpvqs9FYM9lusPtrUfm8dKJeNtu/RFLBLUzunOjgMdTKap/S/oTsswrVzicGBAMaH+RvNPOV4tis1zDqIeZwdXHRa4wOz5L08zPFmD17QlgmjsEvxdaFVbfCi4f+94BJx0dhzwObCmsNJCAM7p3Kn3QPSEKoaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542159; c=relaxed/simple;
	bh=bDPEQgQdePTDak+4yaZRdBK1tWDjCZJ8KuRRwjXGZ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKcS8CwJwa+ghnSKIC8AttsCsC4Cd4uU8CHx4/m7jCiRn+CweB6+vMvjbdhJYcgISpjlpubOaHx9t4Wq6s6Nk+XvJ4d/0dIL6fVikeW136WgbO2EenAlF50M31GdbvUmijRzoMZB1GR6DBlBHK2Un2BpeGuwp9CQkUVUc4O6lRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON4ORJGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCC8C32782;
	Tue,  9 Jul 2024 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542158;
	bh=bDPEQgQdePTDak+4yaZRdBK1tWDjCZJ8KuRRwjXGZ6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ON4ORJGKa97n7lcSoPbdu6b6ZL/lBN2v8mkZWIroQL8LxpON6imKPgRnN+oC4ujg1
	 vKBFdXxxTet1O6f/jB/vh/peob5HzdXAP+n5rdC1EPgmTEk4kXw3DMeNn6JLDDdWyG
	 F+K4e4fK3KtWmYRAPaupEv1KV5Nj2VQIC3F4VZX62/eaMQt/4ry8DLOTQT/LeRPmdU
	 veZTYzTnK+idxNBynQSgIJu3XY5+3tRGBrS6iKu5hz/5XncL91/ywrbTPVs67srWOG
	 ZqN8y8FWb59fsvV3on7ZX4A7VpmBtk/CdyK/Of3AhwprBFtdtqa3OY+sF0ssKcwZT5
	 5/KszX2+e6RgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/33] ASoC: topology: Do not assign fields that are already set
Date: Tue,  9 Jul 2024 12:21:32 -0400
Message-ID: <20240709162224.31148-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit daf0b99d4720c9f05bdb81c73b2efdb43fa9def3 ]

The routes are allocated with kzalloc(), so all fields are zeroed by
default, skip unnecessary assignments.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-4-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c63545b27d450..8b58a7864703e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1072,11 +1072,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		/* set to NULL atm for tplg users */
-		route->connected = NULL;
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0) {
-			route->control = NULL;
-		} else {
+		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) != 0) {
 			route->control = devm_kmemdup(tplg->dev, elem->control,
 						      min(strlen(elem->control),
 							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
-- 
2.43.0


