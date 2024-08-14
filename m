Return-Path: <stable+bounces-67585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14095121C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7321F224AD
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85147149019;
	Wed, 14 Aug 2024 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN/aPPw3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA3145A06;
	Wed, 14 Aug 2024 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601728; cv=none; b=mlbYF70qKvuhLm2VN/m6shryKw0n+3xtAdPZQ8s2aw8dmemdvLTjRH+TiZ5YvcZY2GJr2t17J11r8R476k18nzHPTPbzJdJCFyqfNK7mow3OkN3KoVvC9/jCieTx5KVevKFgkZMFKgrx3s0I7IRY7FRXCOjcKMvimfzdYPqkZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601728; c=relaxed/simple;
	bh=dV4nVI6VK8mbnpS/RZlX5b1RbtVI7nxm+YELZUDB0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkVZxDWleB/MglaiKnmShSY2BGZXNvjlzGzOR3s1bA8nxr2Yzb73r3nSHRxR2hXgyK7mpF/gU/JYkGKoTv2Wogy/Xc+R2Ha0ccIBE6aTrcnR33Tita1gawBWz6Ss35Jbsu9jxA4UWp3bfp6kJecne36ETEnwzat2Zl1wRe4RZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN/aPPw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE1DC32782;
	Wed, 14 Aug 2024 02:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601728;
	bh=dV4nVI6VK8mbnpS/RZlX5b1RbtVI7nxm+YELZUDB0aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kN/aPPw34xvt/fliqk4n1mvGarJoOBjHpR0ZtkMgYiDcFlnvvXbcKBnoBWdtmhk4p
	 QsvjhWlw8LOboY+8YK8o68QqAapKPXpkgRWAhoN8jM0Vh3+cUU1YNgvdTs3H1m1fWX
	 akxRNBIVNpDELz52knFoUcSjMT95glVp36kJPRU0Y9MoOrUpzcWRq09y1RyT96gvcn
	 B+j0BUjOSEqeu8gDczt8QzdzpGBYRd6btSZm2AXYk9q3oNCOzKTaUGTXVGXFnSyKMc
	 N+P8iVNKpqvAlaRoh7SU3qIR5hh9ZcO9jcNSkVn1Q69HESVw2+M+iMAATLloOhXjky
	 C4CMPPcslO7Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Krzysztof=20St=C4=99pniak?= <kfs.szk@gmail.com>,
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
Subject: [PATCH AUTOSEL 6.6 6/7] ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6
Date: Tue, 13 Aug 2024 22:15:12 -0400
Message-ID: <20240814021517.4130238-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021517.4130238-1-sashal@kernel.org>
References: <20240814021517.4130238-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.45
Content-Transfer-Encoding: 8bit

From: Krzysztof Stępniak <kfs.szk@gmail.com>

[ Upstream commit 23a58b782f864951485d7a0018549729e007cb43 ]

Lenovo Thinkpad E14 Gen 6 (model type 21M3)
needs a quirk entry for internal mic to work.

Signed-off-by: Krzysztof Stępniak <kfs.szk@gmail.com>
Link: https://patch.msgid.link/20240807001219.1147-1-kfs.szk@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index fa0096f2de224..103eb93143d11 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


