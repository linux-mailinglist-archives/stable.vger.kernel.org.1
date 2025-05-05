Return-Path: <stable+bounces-140198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEBAAA602
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DBB17A0AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727531DA7B;
	Mon,  5 May 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXS6WJy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACE31DA73;
	Mon,  5 May 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484318; cv=none; b=NVQQ74dG4tMd4lKWpB0/rJ8tSHnkx3IjdmAxmQ5yVfTYpLZO6Fl9lsYFY+o4tBie7F0b/bd9Yf1ri4A69zQg9/mdDsvC2l1coDQJ51DTK+WYvEUP0SDCs5mFufRtbH7wAjK9jh23JxgOBiqEQ2TqFiBfBBzexoWEp3RRzy1wJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484318; c=relaxed/simple;
	bh=EzbQ5qsjT66UzhzAE1HztXaKwjz0xNHAWtSQyhTwrms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0808fRpq5BGFufx7XqpF8e+iWviH8FEBFiBwB60lfV1RL0u1YqJRRoOvmZCj+HFEUBu3eakSxlViBg1Rd7B8CNeumJltJuidnYNQWnNYAZxfRmseybeSked5LLtCi7OFALQBwTBEWGr6ksrjdnyWzWwWJGS+bwdLKonJcqJM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXS6WJy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D8EC4CEEE;
	Mon,  5 May 2025 22:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484318;
	bh=EzbQ5qsjT66UzhzAE1HztXaKwjz0xNHAWtSQyhTwrms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXS6WJy+kFpRaN3KzYZzowHKkyD5+OiIfqoZrLgIWpKxy8kr58oZ2vCUTkZjBAG8y
	 gOw0PwJy7asdNRXjLg+kZWRGKcEa2SA5KpPyj12bb6NSUtmGzow+AJeLXFicAy0HSV
	 eRIq5ttLSda9QZL+oomJ6uAc3BNoB53Xq1htoKOhD790SbmBodFdePhE36z9kgluXR
	 h10TMi6L5BIUwnpi8SRAAF5Fo1V6/+gu1hs7fHlYKkOv5TTnpqb7BY+hb3eCXbyVeA
	 M7YCJ39n6o3DU2fNLQefynEdcWioOUuWp/2sL5Ew41rr9yA5Gjpe1nxvuQ422nn9WV
	 hleKIelPb4aqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 451/642] phy: core: don't require set_mode() callback for phy_get_mode() to work
Date: Mon,  5 May 2025 18:11:07 -0400
Message-Id: <20250505221419.2672473-451-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 8dfdce605a905..067316dfcd83a 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -405,13 +405,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
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


