Return-Path: <stable+bounces-170301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41DB2A3AD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F04B56316C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657831B104;
	Mon, 18 Aug 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FatC+fAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BDE218AAB;
	Mon, 18 Aug 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522193; cv=none; b=UEvtSXnBOfiLG+lt/dpPma4z8K0QE3ZhBl6R+tVlQpBVyv2BcrsMohqER7hdB96CDdiSEgrTrh4wseMFIHDxOYo7X4vJu8/Ngzyd3dMH/Fj88nLzLqaIhARL8awJU5Nn27InW6aa/4D1JCmeC4YgPZxVldhiV5aSu7zqOV7fk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522193; c=relaxed/simple;
	bh=VbRdykkUeA+U5Mh9+lxYpoGivPkFo1bn+/qBqF0fGQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrXnBJCvtqZx8FdmJC+1XVX6pLu/gvkkYlZ/f6pRgTQ8bxQhBPDcaNOhbj4WfFMbQkdI+ZMRcHZNC9RZVW0kptIOzM7s16PzIWUAaXv7y0rhUsrahHiM0XG+M0icPXAOhrkpC2X/hu/4GT3ZSiBW7VIfCJXEPJ433e5tYWpv2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FatC+fAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51F9C4CEEB;
	Mon, 18 Aug 2025 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522193;
	bh=VbRdykkUeA+U5Mh9+lxYpoGivPkFo1bn+/qBqF0fGQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FatC+fAC2+zhXO2ReEqiY5VCHhJa585FfmompHjNTeH3yfCaAMhVyHqD4UQXBy/rV
	 poLdeYbgBjIlhKJn2gTD9s1bbvYFOoUl8AziFYk7ULV1ikdh4NxcnQB6M6rPaeLQBg
	 fuKvnTqX55Gj6Lwuo6CzsCn9nPlb/zzVUBLA/HaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 243/444] dpaa_eth: dont use fixed_phy_change_carrier
Date: Mon, 18 Aug 2025 14:44:29 +0200
Message-ID: <20250818124457.944668093@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit d8155c1df5c8b717052567b188455d41fa7a8908 ]

This effectively reverts 6e8b0ff1ba4c ("dpaa_eth: Add change_carrier()
for Fixed PHYs"). Usage of fixed_phy_change_carrier() requires that
fixed_phy_register() has been called before, directly or indirectly.
And that's not the case in this driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index e15dd3d858df..c5c1d3cb0278 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -28,7 +28,6 @@
 #include <linux/percpu.h>
 #include <linux/dma-mapping.h>
 #include <linux/sort.h>
-#include <linux/phy_fixed.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <soc/fsl/bman.h>
@@ -3129,7 +3128,6 @@ static const struct net_device_ops dpaa_ops = {
 	.ndo_stop = dpaa_eth_stop,
 	.ndo_tx_timeout = dpaa_tx_timeout,
 	.ndo_get_stats64 = dpaa_get_stats64,
-	.ndo_change_carrier = fixed_phy_change_carrier,
 	.ndo_set_mac_address = dpaa_set_mac_address,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_set_rx_mode = dpaa_set_rx_mode,
-- 
2.39.5




