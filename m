Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD574C298
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjGILWZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGILWY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE890
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80EDC60BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C56EC433C8;
        Sun,  9 Jul 2023 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901742;
        bh=pliFVdMuf51GMDN9egQxiP92mH1yOS+LjzSYlEzTJBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Zu8xNcxJgNL6zkDAT/4pDgjRZy/06FuOs9qGbJQRQ9T0pVCAUTIoSEJBJifjHpN3
         nPRxa8mUDVPYXyzRs1WBx36HUHI7n4RHeGl4K38P+5y75ZlkOGUqZKGQulwgPR9pXz
         Gft5nzuB3CvBDAJAdBJD24d6UnmMgUoo7z38kUI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 121/431] wifi: ath11k: Add missing check for ioremap
Date:   Sun,  9 Jul 2023 13:11:09 +0200
Message-ID: <20230709111453.995043679@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ab923e24b0a9c..2328b9447cf1b 100644
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



