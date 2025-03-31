Return-Path: <stable+bounces-127191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9DA76997
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589E17A462F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27421232392;
	Mon, 31 Mar 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxwoITUc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484D232373;
	Mon, 31 Mar 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432907; cv=none; b=AvjZjuu0w02nG5G1sMblUKkD54jwkIeIuS5g8QxCDagpuuvqD2Br6VphWvdBxVYHjLX2aTOeLezQfrP/gzNDS90W8hNydCfAUh89Kxb/gb79qP21bCypHqdYlPOQuFKADmiwxBT8DNdzZ2lhOqHgVBlZz5rzPSHifbE+dy8THJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432907; c=relaxed/simple;
	bh=JHvzP+hUYBoJ9QnlX7YdWhMeQVeyfXu1CQrpDc0tVaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiFTn5x7Hh+c4c5CN56UPrOcEZYGZUJo2Wcmm+VbwtqJAM/rEZ8fhYf0mrq61re50fgRDKowTc/NmYYiauYhUcRNIw5Lr3Xhab4HH6seHxG20a4+9WhR7ZS8TL80ruhEWUbN5+mYO20uv0lTiwp/u2PQmhgrnpplLVboWMmDpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxwoITUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FE2C4CEE3;
	Mon, 31 Mar 2025 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432907;
	bh=JHvzP+hUYBoJ9QnlX7YdWhMeQVeyfXu1CQrpDc0tVaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxwoITUc8ltwT9a+tBykpVIovfNuDzkMIfkr8c+6Xdqpsm55LJsIxZJOzbX42hiQN
	 CgPp3IPrB6EcK99eVLCKxCfqNv0zR+KYvrru4dUNbxM0A2uRMsHDHH1nOqjexW/1G5
	 Z+LMijzfB8BuYSyqjK6D0Rus3WGH4eGdpWS1SpFVssh7p3wNlAeM5ZM/bS6n2xEUjA
	 aMWoxGCivSuHFZ+/aYmiXTIHE9OlsBlWZOqmN52g6bcUw+yqLHs2Ki5InLDhepOb9D
	 PDDKYxacj47xL9aJ37YwWJgWpmYuE7dt1yJTiRHwLe/wFYIPPYe1id8Tv2Pi5EjZ3O
	 Jg9/9xhIbNkGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Syed Saba kareem <syed.sabakareem@amd.com>,
	Reiner <Reiner.Proels@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	end.to.start@mail.ru,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 23/24] ASoC: amd: yc: update quirk data for new Lenovo model
Date: Mon, 31 Mar 2025 10:54:03 -0400
Message-Id: <20250331145404.1705141-23-sashal@kernel.org>
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

From: Syed Saba kareem <syed.sabakareem@amd.com>

[ Upstream commit 5a4dd520ef8a94ecf81ac77b90d6a03e91c100a9 ]

Update Quirk data for new Lenovo model 83J2 for YC platform.

Signed-off-by: Syed Saba kareem <syed.sabakareem@amd.com>
Link: https://patch.msgid.link/20250321122507.190193-1-syed.sabakareem@amd.com
Reported-by: Reiner <Reiner.Proels@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219887
Tested-by: Reiner <Reiner.Proels@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index bd3808f98ec9e..e632f16c91025 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5


