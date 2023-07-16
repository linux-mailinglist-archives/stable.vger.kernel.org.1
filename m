Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0436E755507
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjGPUgp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjGPUgo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218EE64
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1993360EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27123C433C8;
        Sun, 16 Jul 2023 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539795;
        bh=M4yrUy9LDSgVVxB4R2vhTByc0ljDeuEJonatVHu8gkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKn7A3a5sRi2BqKr//pOR4wW2nyTaZTqc4hpPxc5ecp/13TAcjbruCxs/8Tx7/oUL
         q7lTT89Zc+i6FSuM9O5xyerzhFYSZbTvF7ks5i2CRhW+3DQ3ZpZ1l8mNF5siWoYdYb
         FS8iO0vFRuvO4YN9qcHIxhFSRnGflx6vE2kCaRR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/591] wifi: ath11k: Add missing check for ioremap
Date:   Sun, 16 Jul 2023 21:44:07 +0200
Message-ID: <20230716194926.673878995@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 16e0077e14a73866e9b0f4a6bf4ad3d4a5cb0f2a ]

Add check for ioremap() and return the error if it fails in order to
guarantee the success of ioremap(), same as in
ath11k_qmi_load_file_target_mem().

Fixes: 6ac04bdc5edb ("ath11k: Use reserved host DDR addresses from DT for PCI devices")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230608022858.27405-1-jiasheng@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 381c6b390dd78..01b02c03fa89c 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2058,6 +2058,9 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			ab->qmi.target_mem[idx].iaddr =
 				ioremap(ab->qmi.target_mem[idx].paddr,
 					ab->qmi.target_mem[i].size);
+			if (!ab->qmi.target_mem[idx].iaddr)
+				return -EIO;
+
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			host_ddr_sz = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
@@ -2083,6 +2086,8 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 					ab->qmi.target_mem[idx].iaddr =
 						ioremap(ab->qmi.target_mem[idx].paddr,
 							ab->qmi.target_mem[i].size);
+					if (!ab->qmi.target_mem[idx].iaddr)
+						return -EIO;
 				} else {
 					ab->qmi.target_mem[idx].paddr =
 						ATH11K_QMI_CALDB_ADDRESS;
-- 
2.39.2



