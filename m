Return-Path: <stable+bounces-67580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED495120E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C17C1C210DF
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6E2C684;
	Wed, 14 Aug 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDmfM13o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027D13DDC3;
	Wed, 14 Aug 2024 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601721; cv=none; b=WSyZu/65XS+rI8aUtrf50Xc9BhZ2/OcsKZ56nnuGK0uD2O1pFvjzjVd9qvQ2c9XynjFsqyo+xhAsgChYQ0oiTXLxav8UwGu5Ej6N0xFDDNbegC1WPPRk5vAJqj0pjHZQ3wLuw9+y+rSJPdaE41pHSimaDZj1lsrFM3aYpCslwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601721; c=relaxed/simple;
	bh=5zU34EoM6DMvuAuNmuBJXg4JRuV8D3pyQIgORZB1PRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvuTGfDxuMyEa/6RqpD4oNMBfMOFn8Y2KnFiy5xYxoz6rkrDuGRtBgeOy22d3FhFDTXoC42TtIMRRQq3gvFVspV0C6Ib6Stn4bLYAQRV1+lqfBMLObbLTZrjNcYBhNHgauGeygtpoF2QdXpS8KpM1F5es2GwCQjBZo1gDF306G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDmfM13o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDDAC32782;
	Wed, 14 Aug 2024 02:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601720;
	bh=5zU34EoM6DMvuAuNmuBJXg4JRuV8D3pyQIgORZB1PRs=;
	h=From:To:Cc:Subject:Date:From;
	b=KDmfM13oSZr5DiCE84KU2x72HBHMio4qr/s1L638a7yDBMttn9TJv+cku/CkwBPu9
	 54cSIFcWyEY+Kk5GN0crpWHuBE10miSQw4SSPor8JIaczNCtczX0bRT0jqKKzaw5j2
	 clLOVOiNIeRsxG/kJzxuSuVHx2LqdTpmZ8/opeaVovu7/TQxevjEphV7w2fOF64HXu
	 VapdPEagU2RBmiiJtT+AoHXLqxg7ZFkYYFsXOY9/u3cmggooGnO8/BBQiB2geSNYgB
	 /6PCmsvJmhV9hoeHhRMHcq3/BPQN2y39YvkFz40O6NiCiEBQ8xy75L+mQixpJKi3rQ
	 z7JH4BJGPHKuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bruno Ancona <brunoanconasala@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/7] ASoC: amd: yc: Support mic on HP 14-em0002la
Date: Tue, 13 Aug 2024 22:15:07 -0400
Message-ID: <20240814021517.4130238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.45
Content-Transfer-Encoding: 8bit

From: Bruno Ancona <brunoanconasala@gmail.com>

[ Upstream commit c118478665f467e57d06b2354de65974b246b82b ]

Add support for the internal microphone for HP 14-em0002la laptop using
a quirk entry.

Signed-off-by: Bruno Ancona <brunoanconasala@gmail.com>
Link: https://patch.msgid.link/20240729045032.223230-1-brunoanconasala@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 36dddf230c2c4..fa0096f2de224 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -423,6 +423,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B27"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


