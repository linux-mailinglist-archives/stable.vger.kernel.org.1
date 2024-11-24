Return-Path: <stable+bounces-94931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D59D7307
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18894B417F5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F31CEEB2;
	Sun, 24 Nov 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC2lJcf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D297193084;
	Sun, 24 Nov 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455310; cv=none; b=XCFXv50tQ3q7qDW5mvy1uHKJS/oH7ozA3uGGrumyNM7G3kHxvJCWiY6ONzMzFE9iiJgy8Em0jhJxwQNhMWv3GDAYzR0yEJ/cn9/l38ZQdNrVAa3eg7kh06Czfg20E5lkZknqjBCL571qqEuaO4Gp4Rs/c7KxxUyUhYbrIkMPp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455310; c=relaxed/simple;
	bh=Qhy7JANXNyHFsvnfHh6X07Ap8VC7xwwVuNn9E51Pc2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uac0Pk56mRnTzEaaScbi7qjFV/7QbITX9zyFkTXPCincykzUvAS4tTqSbdScHlwKZ1RJ5rftOjcCI6kAZxAuH1d0qUrMOp5VJ0YYKso/exujrn1H3SsgL8sv53N7zDG1OfWU4mJbPoLQi0JeHUEf7kiabtMJrHz26peaspQ/gLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC2lJcf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1786C4CECC;
	Sun, 24 Nov 2024 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455310;
	bh=Qhy7JANXNyHFsvnfHh6X07Ap8VC7xwwVuNn9E51Pc2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC2lJcf9hK366QgRvXbvGl5nDNe7SF0SCqnFMj4VOjuPxj5dZt/LN5opPKoE2peU6
	 AHD12Ug3nZLuMJDnrawOR49C7FOLI0N+WGx+pn/pvFDULSRReUyVqxv0Ak9slxugqV
	 56Ya9/XmPxbeClWLsGbbmFAGCk3j2zyuMkjTNkMu4ts63IaC2s9nV65pxfNFbsAZDT
	 E/tOpugkaUypE0cY7Xkf4061owc9T4m4nNlVDa5W+WP5FmBkeZWl7VuzDtloWxPCW8
	 dUw41D6uIzUEAWywEWGnjBdJl/Qm/zPsS5QA0rJHKqMiW1DO5FJaa2qfKl+Tsb17u2
	 GEFlT452+fhgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 035/107] net: fec_mpc52xx_phy: Use %pa to format resource_size_t
Date: Sun, 24 Nov 2024 08:28:55 -0500
Message-ID: <20241124133301.3341829-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit 020bfdc4ed94be472138c891bde4d14241cf00fd ]

The correct format string for resource_size_t is %pa which
acts on the address of the variable to be formatted [1].

[1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229

Introduced by commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")

Flagged by gcc-14 as:

drivers/net/ethernet/freescale/fec_mpc52xx_phy.c: In function 'mpc52xx_fec_mdio_probe':
drivers/net/ethernet/freescale/fec_mpc52xx_phy.c:97:46: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
   97 |         snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
      |                                             ~^   ~~~~~~~~~
      |                                              |      |
      |                                              |      resource_size_t {aka long long unsigned int}
      |                                              unsigned int
      |                                             %llx

No functional change intended.
Compile tested only.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/
Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Link: https://patch.msgid.link/20241014-net-pa-fmt-v1-1-dcc9afb8858b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index 39689826cc8ff..ce253aac5344c 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -94,7 +94,7 @@ static int mpc52xx_fec_mdio_probe(struct platform_device *of)
 		goto out_free;
 	}
 
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res.start);
 	bus->priv = priv;
 
 	bus->parent = dev;
-- 
2.43.0


