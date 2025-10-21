Return-Path: <stable+bounces-188456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65136BF8598
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FB6B35682C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD3A273D9A;
	Tue, 21 Oct 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhDroc5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7FB26738B;
	Tue, 21 Oct 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076462; cv=none; b=IzgnOetW3I3N7rFvbzkwDs0nahgAUkxA6W4g+s3hFweNc6iu2fKnme5Jr7du2zQKILQFaAchW0XF20TnHqyGgS0uNCvBofoRBJ2WqwxqPGC2U7WHROWCzPJd/uafqqn5cMz1H2KyjlFZonVTfki6UGpqAD2z1MbQqYU2a6YGQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076462; c=relaxed/simple;
	bh=7aN7/+H2N5eyRkEpCHXbPMjiwhVO5W3RRMeIr3KWInc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOvWFcjezKBDAiTRInEhQxu8CKTCPXGc5+/SAwUDzcPXCP6LyZncNSbFwJFsT4IvzcJtnnawqH+xAOQBRd7TkJom5FexaOfMXlQ3h6t+d09C83MeLXwasFpR3PzA/WxmPaB0+ws3W34c4nj8td/sNCosIRlqF7BMuM4M4hcTmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhDroc5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE76C116B1;
	Tue, 21 Oct 2025 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076462;
	bh=7aN7/+H2N5eyRkEpCHXbPMjiwhVO5W3RRMeIr3KWInc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhDroc5ee+Biil4mei8IIXpQfghIb3QdlnUf6Ld2QLfpei8cmoJKdFuDPkpQE0XBl
	 5hXdNOMoDKkd1KHtDAN96g+wYryfBfEG7fbnkP0SDfjt4AmJtYGA7OeleYWyEouhRv
	 z9T1RNfByFd3IvWNp+8W766GUMdhAIr1EfhErqfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 041/105] amd-xgbe: Avoid spurious link down messages during interface toggle
Date: Tue, 21 Oct 2025 21:50:50 +0200
Message-ID: <20251021195022.663945545@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit 2616222e423398bb374ffcb5d23dea4ba2c3e524 ]

During interface toggle operations (ifdown/ifup), the driver currently
resets the local helper variable 'phy_link' to -1. This causes the link
state machine to incorrectly interpret the state as a link change event,
resulting in spurious "Link is down" messages being logged when the
interface is brought back up.

Preserve the phy_link state across interface toggles to avoid treating
the -1 sentinel value as a legitimate link state transition.

Fixes: 88131a812b16 ("amd-xgbe: Perform phy connect/disconnect at dev open/stop")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Link: https://patch.msgid.link/20251010065142.1189310-1-Raju.Rangoju@amd.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 1 -
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 34d45cebefb5d..b4d57da71de2a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1172,7 +1172,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
 
 static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 {
-	pdata->phy_link = -1;
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return pdata->phy_if.phy_reset(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 8345d439184eb..63012119f2c8e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1664,6 +1664,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
 		pdata->phy.duplex = DUPLEX_FULL;
 	}
 
+	pdata->phy_link = 0;
 	pdata->phy.link = 0;
 
 	pdata->phy.pause_autoneg = pdata->pause_autoneg;
-- 
2.51.0




