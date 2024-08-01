Return-Path: <stable+bounces-64930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CAA943CB1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE71288F86
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7521C9EA6;
	Thu,  1 Aug 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBdJVwwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD31C9EA1;
	Thu,  1 Aug 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471482; cv=none; b=I5UNz0jXTBEDQ/7gKIwytrz3K8JLPmB6zbrH6nbXkLawG8D9Ct/HZhFj6sSQ5hqTQDAp5lJDS67kGcXUlg22l4PckhRaD7Wy4ywYdEnK/DRWmmbrFsmdcEnWz3+itFMoAnMT7iQeis7doE04AZyQksNiPvxtDzk+QCx5JeFHo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471482; c=relaxed/simple;
	bh=I1ihhMI+ois11ajX6ji/bdQRgwfxdvb+1/6KIY3gT6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A72mPomsO/f9POueM4QYvzs9ALXELR1MBjA903OaVZ1ojLeXtop5G6T4LSoCB2/qSVAwUSQ5iixwVIz42ZDeempKjBVsiv+iPeHkwiftdoT8qkmFGpKIgQeAbTgsnDoYszDyr+c7FooC23Yr4iiFs2kuxZcZTeh67bC/U+/HEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBdJVwwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4CEC32786;
	Thu,  1 Aug 2024 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471482;
	bh=I1ihhMI+ois11ajX6ji/bdQRgwfxdvb+1/6KIY3gT6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBdJVwwjqpSvunkyTDbtrC4jc/ICyprx/dD+tr2yabAHX7QfW8QsGh4VWaTtBmSyV
	 EE79h8E6UYAFB7yYl+y86T1CjHP4DhgxjWh1QzG1og+ccjAmnWbfjMhTiyDVBSfHcC
	 cd+6n+Kma7XN2Q4NLuK4Xuf9zPjq6RnHP8W1XXkhMPoKGl7feR/sp1UgM37m0tUH6l
	 VtC/EpbayAkOW7wFaR+2E3J9YOAfcxCalnC3/spE5XeA+qTbkSUgJUV3Djt5MQjJpo
	 zOqn9SOrVWAogfitf2gwvti7jx5FYAxqPhwsLTyfEbkyRtl5dQiFxbESG7B6KkAdYP
	 rTQzV/1hGtbKg==
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
Subject: [PATCH AUTOSEL 6.10 105/121] phy: zynqmp: Take the phy mutex in xlate
Date: Wed, 31 Jul 2024 20:00:43 -0400
Message-ID: <20240801000834.3930818-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index dc8319bda43d7..feaece2ed0d47 100644
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


