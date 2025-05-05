Return-Path: <stable+bounces-140963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E831BAAACD4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC26D4C4D81
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BC3A80C0;
	Mon,  5 May 2025 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoS3TQFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22513A80D4;
	Mon,  5 May 2025 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487034; cv=none; b=hJmthVnDImnIYPWI8mZg+09YypqR6Oq+7Uo7wzfXme2Bx05SaR2nS8/HorB3oBxveEYCOpLhPue0t3yhPWVXF/aXfU0WscdPpi/5Yip20nJozPO+d/qJirv945NkJk9hCL8Wi1x5PDkQ7Tt27B2nPSBiElSg0TzE9nvNsQML8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487034; c=relaxed/simple;
	bh=zbIh2rCXluk3jiPuns4fTzYWcbjU0+ods668F6FV3pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwD8Q2vntVb/YdbOauAeaian2I8zKl1muvCI+eZPHsm10l1UEUKxduytuiVXZ9pcZAWFN5KVkv7ozw6qn1HGDhrF3ehYMMI9u8NyZybJ3RmkKd/OEII1n/lPYeNImgb4FNvhPQOK54+I1E9ohIOi7lr4W8Qh7zSevSmW7rlq1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoS3TQFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05CDC4CEF1;
	Mon,  5 May 2025 23:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487033;
	bh=zbIh2rCXluk3jiPuns4fTzYWcbjU0+ods668F6FV3pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoS3TQFmYpmmAIf6QwP2di+0tFkQGIK8xmBdtY0bNLfXHhkwk7fVk+Ppx+3pBXCXZ
	 lYawcyZdjGqOxKQRwr4Rb8ldR52uogw8xzFlrp1Q0bpbtEu/VzYWIGuApCGFdNI8qc
	 GKBPVAYAoaYg35X5/R0DjUPzKa9KOGerb4eAdoUHBQcqXWlKGHnshwr8IYbysDPt8c
	 9BRGUvQqj/Mbu5FMtFmu1sj/MPrmbCRtiFHvlMiQRRNiDcGlvoSfnA3D7226zExREZ
	 zo0QRGkWU4ar807yK8FEdnY/YCHUKh6WzttOI6caVz/koXMWnTLDr7TK8xkkdTwfFE
	 2uwdfqSNwnaaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 120/153] phy: core: don't require set_mode() callback for phy_get_mode() to work
Date: Mon,  5 May 2025 19:12:47 -0400
Message-Id: <20250505231320.2695319-120-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit d58c04e305afbaa9dda7969151f06c4efe2c98b0 ]

As reported by Damon Ding, the phy_get_mode() call doesn't work as
expected unless the PHY driver has a .set_mode() call. This prompts PHY
drivers to have empty stubs for .set_mode() for the sake of being able
to get the mode.

Make .set_mode() callback truly optional and update PHY's mode even if
it there is none.

Cc: Damon Ding <damon.ding@rock-chips.com>
Link: https://lore.kernel.org/r/96f8310f-93f1-4bcb-8637-137e1159ff83@rock-chips.com
Tested-by: Damon Ding <damon.ding@rock-chips.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250209-phy-fix-set-moe-v2-1-76e248503856@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/phy-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index e2bfd56d5086e..21f12aeb7747f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -360,13 +360,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 {
-	int ret;
+	int ret = 0;
 
-	if (!phy || !phy->ops->set_mode)
+	if (!phy)
 		return 0;
 
 	mutex_lock(&phy->mutex);
-	ret = phy->ops->set_mode(phy, mode, submode);
+	if (phy->ops->set_mode)
+		ret = phy->ops->set_mode(phy, mode, submode);
 	if (!ret)
 		phy->attrs.mode = mode;
 	mutex_unlock(&phy->mutex);
-- 
2.39.5


