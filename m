Return-Path: <stable+bounces-137599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143FAAA13B6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449BA7A78EC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D8247298;
	Tue, 29 Apr 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkUr/QhX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89F221719;
	Tue, 29 Apr 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946552; cv=none; b=pxrg/SDJIjTXcFNU0uuwlaA9LbmRs7cJKDHO5q+brRy/J/mYVVkGH0zoI+/NPMxbADQx4GpgWC+TDEPQWFksw5/qywB4VWcitDFAN3kToDGH5ccmXN6a10kwLOPJZUks/2W8X+6Jk8t7wWJup+yZCg6SEtcOLLhawYTUpChEeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946552; c=relaxed/simple;
	bh=UC7KENQ3eXRuIv5OgcuJi0cCQaDRH/0Dob5FqB0JZIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9F7vhfRtfDbYVbq7D0McnGq31a1QbjAcwAMqvmQKZNum6Spno+VYJC5lb7F8ZnhdzlFvINv86AKQKWSn1nS7g6o5Hpva7ncYPQjUatf7zu4OHVvnfUipvlETgrjc2DjhEVU3WGFaqfjA4Sgnq9lOs4mQ7Pr6PUcrlOiaRauUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkUr/QhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3859FC4CEE3;
	Tue, 29 Apr 2025 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946552;
	bh=UC7KENQ3eXRuIv5OgcuJi0cCQaDRH/0Dob5FqB0JZIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vkUr/QhXLZ5rjDfIzP90uE1xWX261gzZD3ZMn6aGhWrIZ6WdIlZ+G2fyqqA9+uqpM
	 ZYFOeYnZyEU0wvAYQczh072ExMUhazwH/Ny42L3leWZiTtkdO7qTs57zAfFL3Q5b2v
	 9g8/s5QUpEdAvb6DMhinUx3y5px9C90EzwEX97R8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.14 304/311] net: phy: dp83822: fix transmit amplitude if CONFIG_OF_MDIO not defined
Date: Tue, 29 Apr 2025 18:42:21 +0200
Message-ID: <20250429161133.450028576@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

commit 8fa649fd7d3009769c7289d0c31c319b72bc42c4 upstream.

When CONFIG_OF_MDIO is not defined the index for selecting the transmit
amplitude voltage for 100BASE-TX is set to 0, but it should be -1, if there
is no need to modify the transmit amplitude voltage. Move initialization of
the index from dp83822_of_init to dp8382x_probe.

Fixes: 4f3735e82d8a ("net: phy: dp83822: Add support for changing the transmit amplitude voltage")
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Link: https://patch.msgid.link/20250317-dp83822-fix-transceiver-mdio-v2-1-fb09454099a4@liebherr.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83822.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -833,7 +833,6 @@ static int dp83822_of_init(struct phy_de
 		dp83822->set_gpio2_clk_out = true;
 	}
 
-	dp83822->tx_amplitude_100base_tx_index = -1;
 	ret = phy_get_tx_amplitude_gain(phydev, dev,
 					ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 					&val);
@@ -931,6 +930,7 @@ static int dp8382x_probe(struct phy_devi
 	if (!dp83822)
 		return -ENOMEM;
 
+	dp83822->tx_amplitude_100base_tx_index = -1;
 	phydev->priv = dp83822;
 
 	return 0;



