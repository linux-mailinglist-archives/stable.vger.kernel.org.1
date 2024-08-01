Return-Path: <stable+bounces-65080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4949943E23
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E551C2243F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922CD1D6182;
	Thu,  1 Aug 2024 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okJgImih"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDC19FA92;
	Thu,  1 Aug 2024 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472275; cv=none; b=JafQ4d8pLVWsN8OXI0Xnh5jPieOIkRyaqsb9sFndBL9UFNN9cuzrtSFWsQCIVEb1oJ3fNrhy2WNav8M1+k0d1je2C2ojipghFxsJ/VQv+lasJY34xbpwsBIxRsNIlXU5Qr8G5/yx4lMMq7azPdtI7pwMu7/mcf7iEB9ZDkiua2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472275; c=relaxed/simple;
	bh=CD6Jx+aTI+3Lv99v/xOm4/THGDtLnHkNjrNWCrQ0syk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkeZNHwWSHtCd9eSLA7Vjt0Qgy1kDwknED6SPKREV1olSsa3UQbiARyfZA1z965FpmgO7abtrzyK2u8XuP9XMg0DEewXVeFlr7jSrRIzwZ+B2rMg83zekcADTDJUVAZfXOhJ0KZvw4CKxVSFQV8H2seBMg+PFAPwBYK1pOY0QTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okJgImih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C62C116B1;
	Thu,  1 Aug 2024 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472274;
	bh=CD6Jx+aTI+3Lv99v/xOm4/THGDtLnHkNjrNWCrQ0syk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okJgImihSn3ytl0b8YuCjZ9fEWkAHFoEluWFjs7z3S4TMMTZwhjilzPo9RnY5HaB9
	 tz4o3I0FhOUyLhSDvDotbPFnceYX/z6EuL0CfV4QgFbsrDCWcvWS1N1GPaQyB391Ky
	 jp95iZAm3N1NIOWixBRKX6Ll+aGx+e1XL5vrMUKFvS0oEFb/QT13ncfJqZjXlsyhkD
	 J2AJki3ZT4YoAi9EYMY+YgMrZ2jAOFx6dtDouKvwcjNdYb+aEHSfoCoZgMFlBQeVop
	 BIFfZHE5qri5D4ABTTknrWk0BZB4HRKkNYVZY7WQYLIDVQ+mSJAAGlCaM6D3pqKUhO
	 MYJmcFNGxbOMg==
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
Subject: [PATCH AUTOSEL 6.1 51/61] phy: zynqmp: Take the phy mutex in xlate
Date: Wed, 31 Jul 2024 20:26:09 -0400
Message-ID: <20240801002803.3935985-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 9be9535ad7ab7..67c45336bb2c0 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -790,6 +790,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	phy_type = args->args[1];
 	phy_instance = args->args[2];
 
+	guard(mutex)(&gtr_phy->phy->mutex);
 	ret = xpsgtr_set_lane_type(gtr_phy, phy_type, phy_instance);
 	if (ret < 0) {
 		dev_err(gtr_dev->dev, "Invalid PHY type and/or instance\n");
-- 
2.43.0


