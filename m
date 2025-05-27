Return-Path: <stable+bounces-147554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D0AC582A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648534C0476
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054E27CCF0;
	Tue, 27 May 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YjGEVJkv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE742A9B;
	Tue, 27 May 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367701; cv=none; b=gn5JFhMaNebrJU7Qg2qHh/SJ+iY+FzRWfgoDIXedvXfjp3oua7jjrVq5X8XoaBs0CEi40tbSq9BxMuNhKbmKxCA/DQpt0Nzqv4LmNr7NF7L60EQ621vlPJmYXSzG5Zk44DP7tDLbGHclpWojT5GMe4UZo5ctDV1ef40dp/HfF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367701; c=relaxed/simple;
	bh=VWcl+qiH9LTdkLyDcRKm8uOV5eLnhPtpxqD5we/uTyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTckZh9MY/iv0h66+gnpurDtRtQSMgXdCeQcS1OUmLKwUw4jgMyJ9Ik2J+EPy5Pgs1YfX3QDhONAkKNKa4Ae0L9PKapX0J+AVw8MKej9eCL81o/i4bSvbLJ5uxIRtyXkElTaUlRHy2fMWfAK1PO723ci52X0723IPcu4W5LVmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YjGEVJkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4201C4CEE9;
	Tue, 27 May 2025 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367700;
	bh=VWcl+qiH9LTdkLyDcRKm8uOV5eLnhPtpxqD5we/uTyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjGEVJkvJ4wExUEG5AIFATNW7HB37r9wq+02WeGniIjvtCtgTXC4BfDProS80AjED
	 1avhpQ2JCq39MkFSuXU4f/0KOP4PjABK9ipJWSuGNL+abbszu5Dj/XxfGxo7PvTaSQ
	 UEU4ZkU6EIC3qVQrnkOs/bAJqCwDLkdMdTwBmR3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damon Ding <damon.ding@rock-chips.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 471/783] phy: core: dont require set_mode() callback for phy_get_mode() to work
Date: Tue, 27 May 2025 18:24:28 +0200
Message-ID: <20250527162532.312223276@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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




