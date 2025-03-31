Return-Path: <stable+bounces-127164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C700A76974
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF91C1891B38
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0B210F5D;
	Mon, 31 Mar 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQbTnCqw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88526228C9D;
	Mon, 31 Mar 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432831; cv=none; b=o7nYnzAjRj3FYlwJtSoJsfoEN7iS1jo0AiXg5bPKyGxAPKaOcpHtUYHWiXMR6yEw9gN2N+vo/0FM1g5bqAeeDoSf2/28z5ocNIolTm6Ccbvnt9yOKUjgsK59RfMkSMVI16n3i1U/9uhgixDY7HuAhbNOCqv+4sOrldjXRs90WWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432831; c=relaxed/simple;
	bh=dMuYUUG0QO/b56n5lHSv0nbpGRVRnruB/rWrazYDeeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kdwq5SG/B+kstgMU8XKPScU02o/saHkFak97eSDx6KEpYvKbi4clR5aA3GDjCwzA73AqUQak1CMoKmkiQm+eauMknMp2x2zacL7eGxHe8K8MwxLfVdeXk8U/dT3065qb8eJ6m0mctkGD+HE7/nUFFWMlag0zXmvIZhbzYwwgb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQbTnCqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A4C4CEE3;
	Mon, 31 Mar 2025 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432831;
	bh=dMuYUUG0QO/b56n5lHSv0nbpGRVRnruB/rWrazYDeeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQbTnCqw9hpvgzlh4YQpMyn1YWBRdI06fKhxleWoGSMUG0MQStAX8NVpthy5xPF+9
	 eJqe2EOuTqiCI3UJ8zud55AUcGVV7R1Mjm8lWzJB2m5WH+vQlIIpvCo0rk7borAUnH
	 js25rvCd3CYHpfDsAFbPCM6QNH2Dq/R/iYf4YEAiXEsogAsboqwkocEb84CQbBPcwm
	 sHqfilV1K6xazwEwQPFzA75wd6Nf2lhZ5OyU9DHyMS9pybYeYPKlIQEJQdt+ORPcXe
	 hhoA11dIypoIJ4lL6s9uj3OGUHY/AgG18EJVK03Iv8/INVkb/b50kfrY2zoM3rodpS
	 v3LltyTd0d5SQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: keenplify <keenplify@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 23/27] ASoC: amd: Add DMI quirk for ACP6X mic support
Date: Mon, 31 Mar 2025 10:52:41 -0400
Message-Id: <20250331145245.1704714-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: keenplify <keenplify@gmail.com>

[ Upstream commit 309b367eafc8e162603cd29189da6db770411fea ]

Some AMD laptops with ACP6X do not expose the DMIC properly on Linux.
Adding a DMI quirk enables mic functionality.

Similar to Bugzilla #218402, this issue affects multiple users.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219853
Signed-off-by: keenplify <keenplify@gmail.com>
Link: https://patch.msgid.link/20250315111617.12194-1-keenplify@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a7637056972aa..bd3808f98ec9e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -584,6 +584,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7UCX"),
+		}
+	},
 	{}
 };
 
-- 
2.39.5


