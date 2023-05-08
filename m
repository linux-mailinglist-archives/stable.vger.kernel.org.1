Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD26FA82E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjEHKia (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjEHKiG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3A29444
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5840661712
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B78DC433EF;
        Mon,  8 May 2023 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542282;
        bh=9yy/HZY/C+K3AJl6G24hXErnAHqKSnZo1FpKBWuJSsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3ledHCuJKCSodBjhMZqTD2H80lgGVaG5/guU4QvS/H6JLlYjv9Wx/Gbhw/lo2TNr
         A0OTb3f5+h54NCzZhgoYT7ToQGLL7zp3vd7gALVyQtdS/mFgbYFj4icnYTsvf8UG8f
         x5F5N/uWtlABFWx57jcsByvBUAqW15fK1290qw8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, P Praneesh <quic_ppranees@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 353/663] wifi: ath11k: fix writing to unintended memory region
Date:   Mon,  8 May 2023 11:42:59 +0200
Message-Id: <20230508094439.598554327@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 756a7f90878f0866fd2fe167ef37e90b47326b96 ]

While initializing spectral, the magic value is getting written to the
invalid memory address leading to random boot-up crash. This occurs
due to the incorrect index increment in ath11k_dbring_fill_magic_value
function. Fix it by replacing the existing logic with memset32 to ensure
there is no invalid memory access.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Fixes: d3d358efc553 ("ath11k: add spectral/CFR buffer validation support")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230321052900.16895-1-quic_ppranees@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dbring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 2107ec05d14fd..5536e86423312 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -26,13 +26,13 @@ int ath11k_dbring_validate_buffer(struct ath11k *ar, void *buffer, u32 size)
 static void ath11k_dbring_fill_magic_value(struct ath11k *ar,
 					   void *buffer, u32 size)
 {
-	u32 *temp;
-	int idx;
-
-	size = size >> 2;
+	/* memset32 function fills buffer payload with the ATH11K_DB_MAGIC_VALUE
+	 * and the variable size is expected to be the number of u32 values
+	 * to be stored, not the number of bytes.
+	 */
+	size = size / sizeof(u32);
 
-	for (idx = 0, temp = buffer; idx < size; idx++, temp++)
-		*temp++ = ATH11K_DB_MAGIC_VALUE;
+	memset32(buffer, ATH11K_DB_MAGIC_VALUE, size);
 }
 
 static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
-- 
2.39.2



