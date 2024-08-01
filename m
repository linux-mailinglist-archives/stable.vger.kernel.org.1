Return-Path: <stable+bounces-65016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538F2943D8F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F401C2238A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409FF12E1DB;
	Thu,  1 Aug 2024 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+hoCl+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B616F0F9;
	Thu,  1 Aug 2024 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471949; cv=none; b=h+u674rsS9MeyXHinJHIdi0lagmBYR2H0kXyRb3XwyOW/PIEkZXhk/a70iHZB0kKNMSpcwXE2p2is0UiVnKqVnFpHkcwEpu4Lkg1t0+F9Nu5SKaZ0UsiKIq6kkzQ4fwlpfP8DQrfT+mKSyje4EWhjAkKYjQIHZS5fIiUOiqc41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471949; c=relaxed/simple;
	bh=xGhvvW5Nb1lltgltgtaN920HQ82BD/KDG6WYsOpH+9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqrWQZJ36XWTmFgg0xjNSUuP+vSR46f14bJeJO7KL/Dv27T0IeUkxKg0BJL4LkldZBouNa+C/F61fDPjyTT4MejX22pK9TiEx/0krlqTHdxVH7ctuHBh+vf1LQnZW/Jya5tfUqLE2NXBtiYSBdj5AgeIHEFm/FdgyTM7avCFEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+hoCl+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF10C4AF0C;
	Thu,  1 Aug 2024 00:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471948;
	bh=xGhvvW5Nb1lltgltgtaN920HQ82BD/KDG6WYsOpH+9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+hoCl+LIdQsu7aaqPLKcgr7Iyq/1D8wQi2CBT8xlz9cnEBdKy5p47R5CuTF9oBwt
	 fXYqAYqHnPMdr79kYlx0y8k+a1nd/vxPOAkP1MZfp3VOW9AyOyPRIAvyLlYJem65MB
	 F1oztwRRlc9Lfy1sqSofPVqBPrD2IKzZFGqXoDG2Idgz35PFBCtD8tjrSWkxPfo+I5
	 IhE2kY/gQe9uLTQOH8yUNsVHBweojaiKpiIJ2MHA0pzriNQ84xXY982uppZc4PgBza
	 41j+bzqhdQo1kYoyI3R4o7dBPznZQdYXyZzt8QHaczAKFntid4yHFaA3QE4f1pMMpC
	 CBWUpP/SsaoFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	kishon@kernel.org,
	michal.simek@amd.com,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 70/83] phy: zynqmp: Take the phy mutex in xlate
Date: Wed, 31 Jul 2024 20:18:25 -0400
Message-ID: <20240801002107.3934037-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit d79c6840917097285e03a49f709321f5fb972750 ]

Take the phy mutex in xlate to protect against concurrent
modification/access to gtr_phy. This does not typically cause any
issues, since in most systems the phys are only xlated once and
thereafter accessed with the phy API (which takes the locks). However,
we are about to allow userspace to access phys for debugging, so it's
important to avoid any data races.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://lore.kernel.org/r/20240628205540.3098010-5-sean.anderson@linux.dev
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/xilinx/phy-zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 2559c6594cea2..b2b761e8d6a3a 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -798,6 +798,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	phy_type = args->args[1];
 	phy_instance = args->args[2];
 
+	guard(mutex)(&gtr_phy->phy->mutex);
 	ret = xpsgtr_set_lane_type(gtr_phy, phy_type, phy_instance);
 	if (ret < 0) {
 		dev_err(gtr_dev->dev, "Invalid PHY type and/or instance\n");
-- 
2.43.0


