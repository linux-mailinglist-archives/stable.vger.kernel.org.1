Return-Path: <stable+bounces-84330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7299CFAF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CC328CA75
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258881C3054;
	Mon, 14 Oct 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJxeW7di"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C961AC45F;
	Mon, 14 Oct 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917640; cv=none; b=Gkr12gUGAWKkXyBswvYodylgOF0tK35JtR1zqTdP5L1gf1SekDdgJCYLJ057y1g8Ki0Rym/HWZeYuLZ/AM+npCMYgQvF1IWYvvV5ESsUqhaN8d8MAFMrSrImFJH1YPOe68uNIym319z6hu+A27M3YMRbyGsL6qsfL03XBJspjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917640; c=relaxed/simple;
	bh=wZlm+RZNCNJcxZSzDHWSrRLE+1mTd8ZDyjlq+jOxwAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhLdbHmprHwURhaEFHgT9mXLrNmefi3jaXWCPZyx2ep0Up4k12l+CTLmKKVtWnCjLV4CjZcFMNFYR5dlrv5DY9V+w3CsBnTTmL3twAueAp7/lhKTEFkPSlxuXxCAK2ZwG6uRpL24ClBT7MmSt48Fet/f+dk+La8db5Z0Syvgq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJxeW7di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B6AC4CEC3;
	Mon, 14 Oct 2024 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917640;
	bh=wZlm+RZNCNJcxZSzDHWSrRLE+1mTd8ZDyjlq+jOxwAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJxeW7dir2u25PEZy1QzK6K9SV5h48iSNw4a+H7PFFiEz14rkkfjwUvwZFhr8zJ2O
	 ooYh+0TdzzM/aSzjxs3GzpKg1tGKOgUKtWyrnkhL8WxQkyYec+wb3Qn7m31wpPYUhP
	 CVuYKMmg8f3TrfcMbbsT4jShsPmgGvDbbnplIvSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	En-Wei WU <en-wei.wu@canonical.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/798] r8169: disable ALDPS per default for RTL8125
Date: Mon, 14 Oct 2024 16:10:12 +0200
Message-ID: <20241014141220.221812752@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit b9c7ac4fe22c608acf6153a3329df2b6b6cd416c ]

En-Wei reported that traffic breaks if cable is unplugged for more
than 3s and then re-plugged. This was supposed to be fixed by
621735f59064 ("r8169: fix rare issue with broken rx after link-down on
RTL8125"). But apparently this didn't fix the issue for everybody.
The 3s threshold rang a bell, as this is the delay after which ALDPS
kicks in. And indeed disabling ALDPS fixes the issue for this user.
Maybe this fixes the issue in general. In a follow-up step we could
remove the first fix attempt and see whether anybody complains.

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Tested-by: En-Wei WU <en-wei.wu@canonical.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://patch.msgid.link/778b9d86-05c4-4856-be59-cde4487b9e52@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_phy_config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index b50f16786c246..6ab89f4782857 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1060,6 +1060,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xa86, 0x15, 0x0001, 0x0000);
 	rtl8168g_enable_gphy_10m(phydev);
 
+	rtl8168g_disable_aldps(phydev);
 	rtl8125a_config_eee_phy(phydev);
 }
 
@@ -1099,6 +1100,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xbf8, 0x12, 0xe000, 0xa000);
 
 	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
 	rtl8125b_config_eee_phy(phydev);
 }
 
-- 
2.43.0




