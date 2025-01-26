Return-Path: <stable+bounces-110619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D60A1CA88
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47DC18892EA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535D2045A0;
	Sun, 26 Jan 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJtcyTe8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5120459C;
	Sun, 26 Jan 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903692; cv=none; b=kRvOjft2ZD/I4dCWy2LkGje+i7ZNF+U3wNA9/SD/zOYR5UM5GmnS93vi7WZ4dFXNIh32fJbWYf3ymDDt1OcCatPlzEncWQlJ0uUh7Meqe43mgoKN1A0J1KuBabnHa7aXkJJzDlZhsZ6HcgDawqmBdfy09fasYEr6cLh6iFQ/uVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903692; c=relaxed/simple;
	bh=KLm/CTcTL+IUclM2KT6BuF/GUzV70zOt2tO5osuving=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlhpGYQW8OMgO0y8TAcNUibLk+KCoP2gSNPe8Otu+uLFH9kQSRB+92FRzBbyaLyzFQBQaZqqN5CGthgF8TCDauhEUnbI6DR/r9OUB/ASVBZlaMNzr7YwCy6NvlLlYGJuMvscnlMPBQ6Qftga7+h+PlxcmXpmIOAAFaJYEqzqLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJtcyTe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C684EC4CED3;
	Sun, 26 Jan 2025 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903690;
	bh=KLm/CTcTL+IUclM2KT6BuF/GUzV70zOt2tO5osuving=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJtcyTe8jZQzUBqxdPZ0P6pdlCxkSpsK+UhhqVozIkyXYatKnWDdJDen58x2/bkjh
	 yAxcwldZqnNcIXcKSgYBlfWmyRbWnfNbeHexqz9cfED5H5kNsZEg4yc3X07JVSMWOG
	 dUOFMmNVEEOuBvFOEkNdKY0jpoQ9LNzerr5iBMDhPBSSvM5Y89+mg+DiCP3veUOExr
	 ul7lRrePSFt0kz+xKZljPxzM1FBCDHQAEmZD87Z+ETN+qGymevDsrXPxr14sURavoC
	 sHD96+tEj6WotrnIHaroTdMvT2l0VioThZ/Ow7zxIapxyxoaxoUqiyCebKRLT4jxv8
	 eGvKwAVtLBPBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.13 18/35] Revert "mfd: axp20x: Allow multiple regulators"
Date: Sun, 26 Jan 2025 10:00:12 -0500
Message-Id: <20250126150029.953021-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit b246bd32a34c1b0d80670e60e4e4102be6366191 ]

As Chris and Vasily reported, the attempt to support multiple AXP PMICs
in one system [1] breaks some of the battery and charging functionality
on devices with AXP PMICs. The reason is that the drivers now fail to get
the correct IIO channel for the ADC component, as the current code seems
to rely on the zero-based enumeration of the regulator devices.
A fix is possible, but not trivial, as it requires some rework in the AXP
MFD driver, which cannot be fully reviewed or tested in time for the
6.13 release.

So revert this patch for now, to avoid regressions on battery powered
devices. This patch was really only necessary for devices with two
PMICs, support for which is not mainline yet anyway, so we don't lose
any functionality.

This reverts commit e37ec32188701efa01455b9be42a392adab06ce4.

[1] https://lore.kernel.org/linux-sunxi/20241007001408.27249-4-andre.przywara@arm.com/

Reported-by: Chris Morgan <macroalpha82@gmail.com>
Closes: https://lore.kernel.org/linux-sunxi/675489c1.050a0220.8d73f.6e90@mx.google.com/
Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
Closes: https://lore.kernel.org/linux-sunxi/CA+E=qVf8_9gn0y=mcdKXvj2PFoHT2eF+JN=CmtTNdRGaSnpgKg@mail.gmail.com/
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20250108164359.2609078-1-andre.przywara@arm.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 251465a656d09..bce85a58944ac 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1445,7 +1445,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		}
 	}
 
-	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_NONE, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.39.5


