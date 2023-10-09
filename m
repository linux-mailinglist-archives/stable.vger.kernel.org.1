Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064E7BE120
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377451AbjJINrO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjJINrL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:47:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A933CB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:47:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3505C433C8;
        Mon,  9 Oct 2023 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859229;
        bh=lwfUT/BssXa+Fl8XW8t/khg0MAZ8iZcLSfoL2Epz/Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvCxfJ6RBMl/hCzyQ9X50u3AlIpWpsXaSaR04rwcsDyaUwKI3nU0z8mLrostK0cLC
         R8A8gMTSI9UaMM+h0UG+MSbkrrP/6hbzHao0hRD4t5M5KtzP61VfATE8NY4EwjFGpe
         CmwjMX2/O5DBmbwFpNMPyC2ZLqy06DJCBIPQbpZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/55] parisc: iosapic.c: Fix sparse warnings
Date:   Mon,  9 Oct 2023 15:06:11 +0200
Message-ID: <20231009130108.181225428@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit 927c6c8aa27c284a799b8c18784e37d3373af908 ]

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/parisc/iosapic.c         | 4 ++--
 drivers/parisc/iosapic_private.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index eb9137faccf74..4cc08d13b82fa 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -216,9 +216,9 @@ static inline void iosapic_write(void __iomem *iosapic, unsigned int reg, u32 va
 
 static DEFINE_SPINLOCK(iosapic_lock);
 
-static inline void iosapic_eoi(void __iomem *addr, unsigned int data)
+static inline void iosapic_eoi(__le32 __iomem *addr, __le32 data)
 {
-	__raw_writel(data, addr);
+	__raw_writel((__force u32)data, addr);
 }
 
 /*
diff --git a/drivers/parisc/iosapic_private.h b/drivers/parisc/iosapic_private.h
index 6e05e30a2450a..7a928c03d5201 100644
--- a/drivers/parisc/iosapic_private.h
+++ b/drivers/parisc/iosapic_private.h
@@ -132,8 +132,8 @@ struct iosapic_irt {
 struct vector_info {
 	struct iosapic_info *iosapic;	/* I/O SAPIC this vector is on */
 	struct irt_entry *irte;		/* IRT entry */
-	u32 __iomem *eoi_addr;		/* precalculate EOI reg address */
-	u32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
+	__le32 __iomem *eoi_addr;	/* precalculate EOI reg address */
+	__le32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
 	int	txn_irq;		/* virtual IRQ number for processor */
 	ulong	txn_addr;		/* IA64: id_eid  PA: partial HPA */
 	u32	txn_data;		/* CPU interrupt bit */
-- 
2.40.1



