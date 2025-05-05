Return-Path: <stable+bounces-141565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F8AAB480
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BA1C04C3E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49CA47BBDC;
	Tue,  6 May 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPZk9VNx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87E386691;
	Mon,  5 May 2025 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486716; cv=none; b=ZbqeSSbHFuOOIL9AyWspT5oC2q/x6+NbBPXXBjmtxJ4kbpwj1ZTvo3BX/9R2rRslsAGOGmWtwhfZL64b34frIJJlQniDZ6kcRVCCCdx8tICeBiikc5Nhoatco2Y+BNJSxHESmiz6ZEWI/fAhRTXzZfTkmJ3o+cQfkolGyjdIrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486716; c=relaxed/simple;
	bh=GfrMrwI1HzyaSwl8t6c37iWXgnxb6KyIge4Y6qbMHOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eo/rOYf79XY5KCh3mVohn5+UEHHGL99B1YqhcNxyDGOSBeTyTaikBJ1zd4ZZ0yWI9trkPI4m8Lm7OmdbiW69ReKtJ8blTy2b9nKBBVnr29OX4G/RBLOrHda0bTRb8hqQ0LFe+uQry/MBij2k7PzgtKFxG0BephF0L833mPRdeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPZk9VNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37074C4CEEF;
	Mon,  5 May 2025 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486716;
	bh=GfrMrwI1HzyaSwl8t6c37iWXgnxb6KyIge4Y6qbMHOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPZk9VNxaA9kB6ttW+oTa0x4HdiKBIIfQEx8A9Bw8RnqHKDXinHN4Ij/jVTQ58Dm3
	 p0TWpOxMsGZ9tfp+jJD564t1HvvjVpLJrtPMhI8I9mkc3qVpYYuv23bdqQthIMuoib
	 Ekus105iJeDNPsjBnyf9Mr9VXYeYyIrJc1virIsB8sJi6Z6y1/GEIy/pm1hdJZPS3D
	 y6ZjmYyHylvzhqfRBHynRsM2aUDieNhgVnavG8nqjOdwX5JTtmRbze0lI2JgXKNmVA
	 OxZr3s1AET6C8G1rtwdqsheUcxQKJCwA64ckH/Tmd/vyfuI9lUWOp7cXqJyKlDO8Kc
	 h2ahssSOr/eHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 169/212] phy: core: don't require set_mode() callback for phy_get_mode() to work
Date: Mon,  5 May 2025 19:05:41 -0400
Message-Id: <20250505230624.2692522-169-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 0730fe80dc3c1..069bcf49ee8f7 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -398,13 +398,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
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


