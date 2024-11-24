Return-Path: <stable+bounces-95176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FC9D73F0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD31D1656CA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30F2354A9;
	Sun, 24 Nov 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGt7GJ36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035732346F3;
	Sun, 24 Nov 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456240; cv=none; b=Ezm8VycTeUix+9ErQ7lVMKuiFuM9ztMwcGQYBFuBe31D7VMsywYm+2YkmEI75dQ+Ys1ocszKYJ88GI2SpKu6we+NITWK4spfGzd9KgGT4UzEVj9LNCBnbHFabu37z99cEb7ijGlC0FyICl8V6oaGwDv7KXrRKTTmTNvqMR9J6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456240; c=relaxed/simple;
	bh=uqdvZm7pkdBmUwK73zw/7HE9X+0n/8F30n1YL4PBDIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGWEQBneN1kTVK0leIbMdnBMLCUNhEynfL0Ucq/Y05UkopZJpdtOSFjlUZG8zV9M3CI+9UzPMj3f1WmWvQiGMDKbpkk6R0gfl4BI97V/WIkOoajOvO4JPJi/gYukoY4F6GPB9m/Ubj3+nNxh05mHORDdkc1/wHQXNFGh0M6pZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGt7GJ36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945ADC4CED1;
	Sun, 24 Nov 2024 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456239;
	bh=uqdvZm7pkdBmUwK73zw/7HE9X+0n/8F30n1YL4PBDIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGt7GJ36Z0jzpcFFNwwIdLXsM16vptmsRlvhyjkH0C2VqcRp0Peq3tb36nyRV4Xhv
	 AJtkTmyxnKgh4J3zwBGQRw/Hj4DxRi3DpIXyIgkhZe0b1dFiCENp4pRrumHLeDsBYP
	 U1VFpzzoETtrQ8YdStPsDEBoqK0b0avcP066X9oASvW9vC5XV6Ma6W6Qjja21jkWKp
	 n3lMVKCapgOiH84h4/wIpWaAqnbzxrmcCIKwi4CSv5fzVZo76l93auep9aie6HI8o/
	 KO5zQ1njpkBQiFIM7d3oCwUqbCWsL20Dkgocy5O/xlLVnwRvtAIgx/0QyIB0VxaMM0
	 K41AvX7ZK+/Ag==
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
Subject: [PATCH AUTOSEL 6.1 25/48] net: sfp: change quirks for Alcatel Lucent G-010S-P
Date: Sun, 24 Nov 2024 08:48:48 -0500
Message-ID: <20241124134950.3348099-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 06dce78d7b0c9..0666a39dc4859 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -386,7 +386,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
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


