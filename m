Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7873F2FF
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 05:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjF0DuJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 23:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0DuH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 23:50:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C11C9B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 20:50:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5766e49b802so57630167b3.1
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 20:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687837805; x=1690429805;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fDfvg9qpGNPcH7tVEdA15n0ws2grPYnUvYg9/GWoVQ=;
        b=qWgaYX+YMWZjumk7Au+z9GqDfC2FpNfRMRfdpXz1d5aQGQjwuzzs+7et+vpbAh4Aa8
         gFlk+ZrOpzCACLdWNIRlP9hhbCTJB2qkRMQ77Zzq91mC0/ls2NccioVAyfYcSOM75L5G
         EoIr1hvGdx+DTxSlNA75LAgy+zxzMq2lJKCTlN0NpNQI0qijPzbbdcivXw1J7lRc/vaZ
         Q/52PPTO3I+U2kpWDE7MvaQh8C6N20IlcYM6j+WVamxCfQTJvHSM0xGKvbmn11c4Iw2w
         LV5Qp7XMHIse8KF+oyNGZSYDI69blUNp85fM+uYbKsttnkAw9IxUfDUtl7berJmcX+2+
         6myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687837805; x=1690429805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fDfvg9qpGNPcH7tVEdA15n0ws2grPYnUvYg9/GWoVQ=;
        b=dEZHnhIrJfHXPJ/pVJo/i1vmK0BYlBsC+yGQsulp9DD4dO+1g71BAQ70P5XVPwRLig
         rnuQ3I5mrjK1SUXwB5dMz8kosqSympxYAD0V4SrhmC8Aqy5M1qsSHI/3hW+NcOhEyJvY
         llUtsXsaBxCO30MosyDXosDTiuZ+tthlbmTEvOxC/OsERFTH1Jnxj2vZXJYPg/1T+cKz
         TNB/AYslwFMHOuis9Ism00m0Sgs2wrzm/IbMVE1cpjslRUDC95tAakLVWLA1NMMAmUg6
         NhOykkTP5GG0Bx2BmlD6IIf1X9Tg4zSPAa1TITrZCfRuAIzxAKMW8DBrzM1rz7+aa0uA
         PPBw==
X-Gm-Message-State: AC+VfDz+ne0qxbLZCp1zk9TEeCS8TuxrVTR1loM7yaaLpzIw1KukJwuP
        gk4RvSzTPH0pm1Z0ZLIXcUxnKow9NgGe
X-Google-Smtp-Source: ACHHUZ6ZN9tfSD+MJTtLMnXtHEQjcNraDQpakIn5A+scrvCJUexrLj3oId2jQqMQcEYS4M2dJzsII6ji4KyN
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:2442:0:b0:c0f:5586:fd8e with SMTP id
 k63-20020a252442000000b00c0f5586fd8emr3748389ybk.3.1687837805503; Mon, 26 Jun
 2023 20:50:05 -0700 (PDT)
Date:   Tue, 27 Jun 2023 03:50:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230627035000.1295254-1-moritzf@google.com>
Subject: [PATCH net v3] net: lan743x: Don't sleep in atomic context
From:   Moritz Fischer <moritzf@google.com>
To:     netdev@vger.kernel.org
Cc:     pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, mdf@kernel.org,
        Moritz Fischer <moritzf@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
proceeds subsequently to go to sleep using readx_poll_timeout().

Introduce a helper wrapping the readx_poll_timeout_atomic() function
and use it to replace the calls to readx_polL_timeout().

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Cc: stable@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Signed-off-by: Moritz Fischer <moritzf@google.com>
---

Changes from v2:
- Incorporate suggestion from Jakub

Changes from v1:
- Added line-breaks
- Changed subject to target net-next
- Removed Tested-by: tag

---
 drivers/net/ethernet/microchip/lan743x_main.c | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f1bded993edc..61eadc0bca8b 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -144,6 +144,18 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
 				  !(data & HW_CFG_LRST_), 100000, 10000000);
 }
 
+static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
+					   int offset, u32 bit_mask,
+					   int target_value, int udelay_min,
+					   int udelay_max, int count)
+{
+	u32 data;
+
+	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
+					 target_value == !!(data & bit_mask),
+					 udelay_max, udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -736,8 +748,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -748,8 +760,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
+						    DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 
-- 
2.41.0.178.g377b9f9a00-goog

