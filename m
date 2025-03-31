Return-Path: <stable+bounces-127233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5762A76A61
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600B7188F867
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7752459F8;
	Mon, 31 Mar 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2FiE1nv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F8221DAA;
	Mon, 31 Mar 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432999; cv=none; b=W6j+TZM8JlQucziDT24rZBDm3FB2O10fkvJj5rRFORnVMiB1jD51RkkpUrAySoSzl9DqXINHk28lG2g+8v6WZS9EUWFppFkQLefg+9mNtd5e1NCDXvvIdIV9eF2qN1+KAgpznQojN32ZRkQD76FOm5vBuJCuRvKnJWDE9N7e600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432999; c=relaxed/simple;
	bh=S3C3aVWQGzzI25t6fOd1oulqgTWGDhqBLOHkqO7rUmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsaWvM/gUqzeYmiFqHl6yx7QmNhlij84mVjOM52vkgOjB+gbeTZB3mXzDJpJbfkDmIyoc2xgVOAe5u+AFHnP2YG2k4LYTcsNQvreAqVaOqpjIsGRWfsqgm3XOdNRVdPRjYgmuiNrJtF3xfYGUaS9gF6kLf3iIIuuAQKcMMPsV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2FiE1nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2281C4CEE3;
	Mon, 31 Mar 2025 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432999;
	bh=S3C3aVWQGzzI25t6fOd1oulqgTWGDhqBLOHkqO7rUmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2FiE1nvDv4z+p3CU1UPxudBuViC2cfTSAY9B+f8EkTkwaykRBVHjrpyLeBeYlrue
	 hvHAHQdKE/IYcQNSfJAO4FrE12y7tMY4kOHiXiMy3Mo8hixeycGjesDzsHCfEnHH25
	 c8iZEysP9Oe0cQOJrS4jRlAqT17pldlWZe4+wqTORc9knnekoP57JJIeTGP24Ezhku
	 JwiI/OwOBq8Ilo/8uGuRy/wHNTk+nhUROk5VU0+FeTW2gbjd1i9iuV9LexMlNzUQKI
	 /KROGyd+chCG/62hcCqRM6HPUlt/3OcT7Hj3oczuZQ7OPFLaWUTeyEnJr12odx6dtI
	 g5W181kEGGmaw==
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
Subject: [PATCH AUTOSEL 6.6 18/19] ASoC: amd: Add DMI quirk for ACP6X mic support
Date: Mon, 31 Mar 2025 10:55:59 -0400
Message-Id: <20250331145601.1705784-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145601.1705784-1-sashal@kernel.org>
References: <20250331145601.1705784-1-sashal@kernel.org>
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
index 2981bd1c3530d..2536bd3d59464 100644
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


