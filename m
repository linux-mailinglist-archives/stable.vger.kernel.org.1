Return-Path: <stable+bounces-88630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84B9B26CD
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CB1C21425
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C418E374;
	Mon, 28 Oct 2024 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipZWExZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897D15B10D;
	Mon, 28 Oct 2024 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097768; cv=none; b=LJgPAI48KRsL7j412vO3jnJvcXQgB1ZLSYPfS4Ap2QnzEVVfVCpmnTRGU0lnvMaKpyx0nVfvj0nTJJmiA9xITW1v0eInYik8jFXp0nFNAQFfbRZni28+veUcCeAFxkHBoSIjsC1OxOnELuSagcSY3SddIq+3RsdLgAXkmuo/QfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097768; c=relaxed/simple;
	bh=svvvEhcpGywSLI/LXc5481SikhakX6gu4dgZIAMhlLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2DNxeNsnxytZluElf4Z9AtvOmPrBxjpv3Q/je6LqYXPLUjJhBZiEl+KWMK11qotlOibllTtr/Pll8dWlsmqWnFM2StYP5vTzFowEiKzmah85DPOcaM2tP3L5KYrmeOUBUtOVmxAIBVlBQCPTuguaS9L3KWIlDEI2WJvK38Vx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ipZWExZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7058C4CEC3;
	Mon, 28 Oct 2024 06:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097768;
	bh=svvvEhcpGywSLI/LXc5481SikhakX6gu4dgZIAMhlLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipZWExZwHV8s1i6own05/89sNGQk2uX8e9vOKdGSuEsPBhSeSIIG1dTIjuLqmOfO3
	 WCKETu44vLBAcRC7XwNUkRpm4uOVZQNA2u4SBymeu6dO/D1WQ/lYZJxIrJIen6Mp7y
	 gCQxnCbEMKvrFFkQWc7HKdALDCHVCeaTAOymYHtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Hai <wanghai38@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 137/208] be2net: fix potential memory leak in be_xmit()
Date: Mon, 28 Oct 2024 07:25:17 +0100
Message-ID: <20241028062310.011277186@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit e4dd8bfe0f6a23acd305f9b892c00899089bd621 ]

The be_xmit() returns NETDEV_TX_OK without freeing skb
in case of be_xmit_enqueue() fails, add dev_kfree_skb_any() to fix it.

Fixes: 760c295e0e8d ("be2net: Support for OS2BMC.")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Message-ID: <20241015144802.12150-1-wanghai38@huawei.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index ad862ed7888ac..9d425ece33fd2 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1381,10 +1381,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	be_get_wrb_params_from_skb(adapter, skb, &wrb_params);
 
 	wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-	if (unlikely(!wrb_cnt)) {
-		dev_kfree_skb_any(skb);
-		goto drop;
-	}
+	if (unlikely(!wrb_cnt))
+		goto drop_skb;
 
 	/* if os2bmc is enabled and if the pkt is destined to bmc,
 	 * enqueue the pkt a 2nd time with mgmt bit set.
@@ -1393,7 +1391,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
 		if (unlikely(!wrb_cnt))
-			goto drop;
+			goto drop_skb;
 		else
 			skb_get(skb);
 	}
@@ -1407,6 +1405,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		be_xmit_flush(adapter, txo);
 
 	return NETDEV_TX_OK;
+drop_skb:
+	dev_kfree_skb_any(skb);
 drop:
 	tx_stats(txo)->tx_drv_drops++;
 	/* Flush the already enqueued tx requests */
-- 
2.43.0




