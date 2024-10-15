Return-Path: <stable+bounces-86301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4FC99ED1B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30362869B8
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAE1FC7D1;
	Tue, 15 Oct 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/qFf2qQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92001FC7C6;
	Tue, 15 Oct 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998450; cv=none; b=e/ZG+ZXiXwGi9q7CiUC8SuBnvdwPW7JuM7wHRHeYn8eLHc7CpcPhvhJy0X94FG8AhtiopJcAJ/Q8AiVFfq+A3Khb8ZRcCk3AAvcFWGx844A5UHK40L8YrwBnPG98ywgYAH+0Hfg/BJ7OIbNvxUsZOvoockqDnh56XknW9g8wq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998450; c=relaxed/simple;
	bh=jYhb4XEc5a8Jaw3Ga/4fWTi1ilw1rmnhv7hrWM/iiok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVta8x5y9kJlC4t+0SCH7LQuf/TPfBk4lcoydwvmV0Zq4XWT8m2eTE3+M42fMsfiexOs9mEmcuER77BlxK97t4CvLAx2S1fOssz0JK7nNvesTihoqAAUcccvBjA4B++glZsLcBEB496xxER57XIiBFSb7O6SB0ZJXqo2MrnCmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/qFf2qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C527C4CEC6;
	Tue, 15 Oct 2024 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998450;
	bh=jYhb4XEc5a8Jaw3Ga/4fWTi1ilw1rmnhv7hrWM/iiok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/qFf2qQyuAXABqIy41kt6TNOvytzL/XzTsrkJu8hHH+PbMtXGgbpACzdEt2vain4
	 D4RoDiaRhkrkORoYyHcb9m+Tidg3+bfDWvVMSKNol6s+OHmjeDDFRlNKkfjj3H0kyc
	 utMitQLU5pDp3GmSpBolotSCb2+F/Lcdb+FfeTYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 481/518] net: phy: bcm84881: Fix some error handling paths
Date: Tue, 15 Oct 2024 14:46:25 +0200
Message-ID: <20241015123935.566768614@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9234a2549cb6ac038bec36cc7c084218e9575513 ]

If phy_read_mmd() fails, the error code stored in 'bmsr' should be returned
instead of 'val' which is likely to be 0.

Fixes: 75f4d8d10e01 ("net: phy: add Broadcom BCM84881 PHY driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://patch.msgid.link/3e1755b0c40340d00e089d6adae5bca2f8c79e53.1727982168.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/bcm84881.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 9717a1626f3fa..37a64a37b2ae3 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -120,7 +120,7 @@ static int bcm84881_aneg_done(struct phy_device *phydev)
 
 	bmsr = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_C22 + MII_BMSR);
 	if (bmsr < 0)
-		return val;
+		return bmsr;
 
 	return !!(val & MDIO_AN_STAT1_COMPLETE) &&
 	       !!(bmsr & BMSR_ANEGCOMPLETE);
@@ -146,7 +146,7 @@ static int bcm84881_read_status(struct phy_device *phydev)
 
 	bmsr = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_C22 + MII_BMSR);
 	if (bmsr < 0)
-		return val;
+		return bmsr;
 
 	phydev->autoneg_complete = !!(val & MDIO_AN_STAT1_COMPLETE) &&
 				   !!(bmsr & BMSR_ANEGCOMPLETE);
-- 
2.43.0




