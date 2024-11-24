Return-Path: <stable+bounces-95048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322A9D7296
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684A4161C90
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2752200B9E;
	Sun, 24 Nov 2024 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3giH5qG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD8200B90;
	Sun, 24 Nov 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455804; cv=none; b=Vfe7eMQOnyfEIojoFG4A0C50DGlZZo8a668c1ycs+O2JEazmhLBpSfZYTWPrnXNOyuCsmL7pghzLIaZkKDMtRgCiuROoub3FcT41U701bEaQoye+YxtezcaI4CPKfzgQJ1JVJKegdXt0+znRGGAmUGtL4h7p0MWrFwRNVM9VVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455804; c=relaxed/simple;
	bh=zFPlCJFfDBebf0bG6Mx9689tRjtn3qTTTMtEGdNV8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM9cIn6M3TZydHRpF575VFM7Ls9OjHUKuD5O8VL/xjMm+V+ZKPiNk/fiHD9UDYr125GX35BbhjYLQPrMW86tczh5GK0US8l1iO1rJJp1aBc4uGqAXQnYNVQ+1zOuVgEdHAFzm5v7ISbiCIkLqgzU6yTt8d2QuntrHm7yNzLh4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3giH5qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873BFC4CED1;
	Sun, 24 Nov 2024 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455803;
	bh=zFPlCJFfDBebf0bG6Mx9689tRjtn3qTTTMtEGdNV8GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3giH5qGgX6fZsvE9mcPyb1ucHI0Zk5tWS99b1FxfcmT2/Ptr+y+I51/PTNkhuBP7
	 BFquOxw/0WI3EtZ5lj0Ld90hqsI2ZWrX/P6QFg+atjOlQKLN4OPigZalivtornz2tM
	 Upmo3WLfR3r81nR17sCF+OlE/ROfLo9OhwLCBkR12bHOIQjpMk49ccL4U77HmoH7xb
	 gJi7nT1RhDOW9a/3MoI5UgTLNKGzwoyI4iY6FtU8CkfUpADBNusWGfT5govwekkEr6
	 7Vly1dDu/B1QAqP/1QNYkDl0zxB1A/YsMa+oRuR18tJuRH9myBGwOhDOuO96eKF1BS
	 l3junGWRxSIIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 45/87] net: sfp: change quirks for Alcatel Lucent G-010S-P
Date: Sun, 24 Nov 2024 08:38:23 -0500
Message-ID: <20241124134102.3344326-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Shengyu Qu <wiagn233@outlook.com>

[ Upstream commit 90cb5f1776ba371478e2b08fbf7018c7bd781a8d ]

Seems Alcatel Lucent G-010S-P also have the same problem that it uses
TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Link: https://patch.msgid.link/TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a5684ef5884bd..dcec92625cf65 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -466,7 +466,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
 	// report 2500MBd NRZ in their EEPROM
-	SFP_QUIRK_M("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex),
+	SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
 
 	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
 	// NRZ in their EEPROM
-- 
2.43.0


