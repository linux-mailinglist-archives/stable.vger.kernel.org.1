Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9547E7CA296
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJPIvt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjJPIvs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:51:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A756EE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:51:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D78C4339A;
        Mon, 16 Oct 2023 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446306;
        bh=qsaty9QCdAyMTfotiNQQgIQsXC4aNZnZcvqVOEt8u7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPswKadEzPNpsHvGoDXyh41UgpKF8Y6kTwBaGjkmp0raEcmnPIAzGujKxb1BxsO48
         CKGsgDwcpq4dFEyhiVJ2SXzYF2k4LyCFzZhbgOvtqy79uR1cO3skRBuPU5zucH/Eru
         eaEAY1NjLizltz9RYELC/V86zdKnoqTW1nZbWIYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Horman <horms@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/131] net: mana: Fix TX CQE error handling
Date:   Mon, 16 Oct 2023 10:39:44 +0200
Message-ID: <20231016084000.092429858@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit b2b000069a4c307b09548dc2243f31f3ca0eac9c ]

For an unknown TX CQE error type (probably from a newer hardware),
still free the SKB, update the queue tail, etc., otherwise the
accounting will be wrong.

Also, TX errors can be triggered by injecting corrupted packets, so
replace the WARN_ONCE to ratelimited error logging.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4f4204432aaa3..23ce26b8295dc 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1003,16 +1003,20 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
 		case CQE_TX_VPORT_IDX_OUT_OF_RANGE:
 		case CQE_TX_VPORT_DISABLED:
 		case CQE_TX_VLAN_TAGGING_VIOLATION:
-			WARN_ONCE(1, "TX: CQE error %d: ignored.\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: CQE error %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			break;
 
 		default:
-			/* If the CQE type is unexpected, log an error, assert,
-			 * and go through the error path.
+			/* If the CQE type is unknown, log an error,
+			 * and still free the SKB, update tail, etc.
 			 */
-			WARN_ONCE(1, "TX: Unexpected CQE type %d: HW BUG?\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: unknown CQE type %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			return;
 		}
 
-- 
2.40.1



