Return-Path: <stable+bounces-127190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781ADA76998
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3FF165201
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47B231CB0;
	Mon, 31 Mar 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcT3uA8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFD231A55;
	Mon, 31 Mar 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432905; cv=none; b=O5w5W26XnGA0FDaxo3yDnM5UPvNJYuG+2rhkexNwa0z4JzWF2W1mmcIOJSb4SchD5CL/BAQxxFOaSNaaAwyucg09xTERFC5lbtZKsjP13pf/5pdyuhy267tfp5lbgbBVOANh+nIYl74FlMI8V1vesAJerSJhPFLJeP97cDPwTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432905; c=relaxed/simple;
	bh=dMuYUUG0QO/b56n5lHSv0nbpGRVRnruB/rWrazYDeeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd3I01uHiL3Qc69PmvkcSAfywnYYlNfig1o1+7eOhJCew0IDxTKgpdgxPbNGXwZD5YSwwovWKxAMWMNfo2NAdTHdkhx7iQdoIB4KTzNCESnhHltRYg9RmY8js4jgGrBhXGup2W/NcZOtNJTNTo8zml7UG1Wq8mw6liuqvqFLqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcT3uA8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E0DC4CEE3;
	Mon, 31 Mar 2025 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432904;
	bh=dMuYUUG0QO/b56n5lHSv0nbpGRVRnruB/rWrazYDeeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcT3uA8VUcQ6L3/t7VkX3Z1wQHu6UJ1bjr2z1OISAQNvl2cq/YkOt5mOMiu9O1894
	 yHSFQhusYWQRaOBFa1MHtgsmO20y1b3kJFpiWNGlBCo2n3AXzCww9WcfT6oAtFZRF3
	 91hi9g5qqBZtHNlVcXnlkEWcnm4MSgsoTBmNeloFulsz2hdZLBGoP9+o08s2YcbndH
	 MdSecUvIfbisAb9PWJewuY90Exkqt16zKQmcco6TvXyqmegouPUos3kQYqqCMhdOxo
	 GAX4yfsvtU9ZBaKn7DHwGbCn36FNGbzfMFy2Y53ug8g7Fs0kySUJAwSJfAgj2YFiFp
	 z6JTsaHxNrrAw==
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
	venkataprasad.potturu@amd.com,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 22/24] ASoC: amd: Add DMI quirk for ACP6X mic support
Date: Mon, 31 Mar 2025 10:54:02 -0400
Message-Id: <20250331145404.1705141-22-sashal@kernel.org>
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


