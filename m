Return-Path: <stable+bounces-94970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209F9D7619
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B3EB203E0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3A1E260F;
	Sun, 24 Nov 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9GWz3oN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A301E2606;
	Sun, 24 Nov 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455449; cv=none; b=AScBG5jmmdXbrH2QEur2apfoDTPpGgquyI48XSzuzv10wzlagnZF6xy8SjOt+eOHzkRcI78ez+HDxvvPG9efv/VBnjws7d5mohwTO9Ts4C9/jf2UnFMiy9E/AL2GmkS/832NZ6epOBAdRMfbsLNOxQoem/QfFSNQ73BookqkQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455449; c=relaxed/simple;
	bh=FKkLCagGZZI+0/8piRcbpFI14zgHSDxcKrCvRX5yhws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljET+DJp2hE3Jp28ecxHLGA2kVflVaScel6JCMUML3Nx3wnjgugS9GERy/zAYHL3nzFoauAWP8goSnknkRh+pXaZID2ug4RsvBjEFqpohWWnNs1u1JPtvwHIDTawGaBLT+MCmllXd8EpW6i7eXEaKNYU3Tx+t8ypV5R63jdUwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9GWz3oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C74BC4CED1;
	Sun, 24 Nov 2024 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455449;
	bh=FKkLCagGZZI+0/8piRcbpFI14zgHSDxcKrCvRX5yhws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9GWz3oNVutMBv2S7trkZcK7oQEJdJHzElazX71JLU5DJoYA4FxdL8BJnuqDTMmyW
	 NbzbOHSEtx7SoBcFs1n85JLv4OFZwAuiU4jTWsuanJ1DnMjbdD2LEAB9BlDD3LW/B/
	 orBmBySd9zkpWQxO0WU7rVomEmT3Y87rQN4boZIQ8tDg39Cd5JZgh3fy57ux/ObKrO
	 9DHJlyd1W/cIKP2MSsiI8SRE3wlufDkZgch0R2SeX4vPHIKUo6U+ouJ8MzFVXKWqf4
	 6kxecP2Kyyknotx6bs1l51iwKpJekEdu/uFsOTblmDPpUUqtVqX8DDxsOSOY5jfkGI
	 lvFoLU5AH4wzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	Sean Anderson <sean.anderson@seco.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	madalin.bucur@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 074/107] fsl/fman: Validate cell-index value obtained from Device Tree
Date: Sun, 24 Nov 2024 08:29:34 -0500
Message-ID: <20241124133301.3341829-74-sashal@kernel.org>
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

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit bd50c4125c98bd1a86f8e514872159700a9c678c ]

Cell-index value is obtained from Device Tree and then used to calculate
the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
In case of broken DT due to any error cell-index can contain any value
and it is possible to go beyond the array boundaries which can lead
at least to memory corruption.

Validate cell-index value obtained from Device Tree.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Link: https://patch.msgid.link/20241028065824.15452-1-amishin@t-argos.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman.c | 1 -
 drivers/net/ethernet/freescale/fman/fman.h | 3 +++
 drivers/net/ethernet/freescale/fman/mac.c  | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index d96028f01770c..fb416d60dcd72 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -24,7 +24,6 @@
 
 /* General defines */
 #define FMAN_LIODN_TBL			64	/* size of LIODN table */
-#define MAX_NUM_OF_MACS			10
 #define FM_NUM_OF_FMAN_CTRL_EVENT_REGS	4
 #define BASE_RX_PORTID			0x08
 #define BASE_TX_PORTID			0x28
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 2ea575a46675b..74eb62eba0d7f 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -74,6 +74,9 @@
 #define BM_MAX_NUM_OF_POOLS		64 /* Buffers pools */
 #define FMAN_PORT_MAX_EXT_POOLS_NUM	8  /* External BM pools per Rx port */
 
+/* General defines */
+#define MAX_NUM_OF_MACS			10
+
 struct fman; /* FMan data */
 
 /* Enum for defining port types */
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 11da139082e1b..1916a2ac48b9f 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -259,6 +259,11 @@ static int mac_probe(struct platform_device *_of_dev)
 		err = -EINVAL;
 		goto _return_dev_put;
 	}
+	if (val >= MAX_NUM_OF_MACS) {
+		dev_err(dev, "cell-index value is too big for %pOF\n", mac_node);
+		err = -EINVAL;
+		goto _return_dev_put;
+	}
 	priv->cell_index = (u8)val;
 
 	/* Get the MAC address */
-- 
2.43.0


