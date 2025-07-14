Return-Path: <stable+bounces-161794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806CB0348D
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 04:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F37A6EF9
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 02:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3B18D656;
	Mon, 14 Jul 2025 02:38:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BD1DF26E
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460708; cv=none; b=HSxZRCEY8HBfXHJOJkjZL2en7jZGrIpaXZoYExuFpMeLZol3OJJzrAv52cAUgBNXyi0fFX0eCmOEfkVdAEdD8ql3tqCCivELqkJZTdRpcFXqD3IqNhiH4p62BHvFni1oE/u04Ed/VE5iq3RWuVEY8Kwsl9aKg223kxb608v9de8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460708; c=relaxed/simple;
	bh=pn2+yVZBnkxFpDKv6jqrGa6zkGfzDItdV1vC3xEfL8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDYRi7WXQdRw2OYE22iv8M2XPLYrCn+KtgUx/rWtrTjoaGRkV2Rdirt2u9AEyPR6jppjwPZQ4tya4p8PBr6XG48YwM/RgXwyTSHSW7xE97ebaJA/+qHFMR/3xTphF3tnk787xuglnKyGB7oM2xaGpZiKon1BXfH7gsSxwCtv3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1752460654t8ae25980
X-QQ-Originating-IP: 0M771eIWWen//zUamxNNK0D2eM+ByXpckpDHuR+IMhg=
Received: from w-MS-7E16.trustnetic.com ( [125.118.253.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 10:37:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11689872801480177623
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] net: wangxun: revert the adjustment of the IRQ vector sequence
Date: Mon, 14 Jul 2025 10:37:12 +0800
Message-ID: <5F37839BC86F69DF+20250714023712.291869-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025070626-come-nappy-3fec@gregkh>
References: <2025070626-come-nappy-3fec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MQPu5pFEJFN4xbbiDpKyYk9o8Q+FFcK6SP8a8BILsAlGSgrS6XBpzBbJ
	oBJu45e473Pwvx2riz0Cln4CPVPo2kOffnr9ZVJqUdiXJpVMRMMfVsVCEV4MaQZm0DShiG+
	Vpi2k1ozgIv7Shtg24RgQv18QPFaG/70qNRfSudh/e2dZbOrr14BPlUnF2cuhTLyzQBXXXD
	KaqfnnhFgt8Q8ux+sLOf7vIaQF2Wl5kNMWzhd2xKswygBfP2K8gFySh8L1jGCEBJWlKGCDG
	vR/bDRJMX2AbqNRQvfhyXaPA055OygSAU1Pto+UDdkSryv2NfZahQQFHtRVOnabJBLo+4+0
	9AlzLRzgIcPjL9+R+K/y2beUMlz6FwuglPi1UZVqJqg5aXwzNKgDQGKp/P6w4Wl5qMNKGIp
	SsU3CykVejvWOwuDcEecf21upVKDytpvSUMWi36IvtQZcnlOLX55TJ9sYXy4FB9sl4P0fvw
	QYLcGd07FmUge7FoIk8bVIvo0kNxfXLXgNS96cBybZSAIg615nM5zsf0jkWdEt+oAk9km3a
	Zu67dLhfLDuYFJ8mdw7MdYkrysDrJv1GN8r17hI0cujoUh8SYiD8JHQWVEzDQd5XnLCq+M0
	pEve/2ZZXSk0GU3mPlprX27BmKj+v7rvNmysKxzQnaiKruDOCoNYRaweq/v3lTc1EQkRJLZ
	dsUVomSY+TB5JF4OzSByhoPu8YWHUMabE3Nr1qIzOBKPjVAIJ5NMFuAPtl5wTDCe53+fcCw
	cfLr0w2E8MxbtWNMK0z1M9su6elCf3EMRpRHg4Y4DNicFE2W30XQdetkzTLeuXwHh1qMXsO
	EwpDZf4sUvIuHN4trt5zDayBU/ApV/JuGb/RBhJg7Bie2DH+aWxRWP3nQHNZRnR504Q8E34
	QBraJL0oBMRovGRiZQGZSMoDBk3AHJFmhU1+DQeHskZi93hqj+atUX23z/5OrDgmGHZir7X
	ek1IfFzUrdVaiA84uZb9rpX2ViQhTdXi8cEE4qWmalXF3PriyWfxoKh/6cESCL0KarqnEkj
	tTkQ9Cs98J949IUmeWWz8JtDVFQS2abtS8Ri38Eg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Due to hardware limitations of NGBE, queue IRQs can only be requested
on vector 0 to 7. When the number of queues is set to the maximum 8,
the PCI IRQ vectors are allocated from 0 to 8. The vector 0 is used by
MISC interrupt, and althrough the vector 8 is used by queue interrupt,
it is unable to receive packets. This will cause some packets to be
dropped when RSS is enabled and they are assigned to queue 8.

So revert the adjustment of the MISC IRQ location, to make it be the
last one in IRQ vectors.

Fixes: 937d46ecc5f9 ("net: wangxun: add ethtool_ops for channel number")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://patch.msgid.link/20250701063030.59340-3-jiawenwu@trustnetic.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit e37546ad1f9b2c777d3a21d7e50ce265ee3dece8)
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 16 ++++++++--------
 drivers/net/ethernet/wangxun/libwx/wx_type.h    |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   |  2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c  |  4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ea2123ea6e38..e711797a3a8c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1624,7 +1624,7 @@ static void wx_set_num_queues(struct wx *wx)
  */
 static int wx_acquire_msix_vectors(struct wx *wx)
 {
-	struct irq_affinity affd = { .pre_vectors = 1 };
+	struct irq_affinity affd = { .post_vectors = 1 };
 	int nvecs, i;
 
 	/* We start by asking for one vector per queue pair */
@@ -1661,16 +1661,17 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 		return nvecs;
 	}
 
-	wx->msix_entry->entry = 0;
-	wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
 	nvecs -= 1;
 	for (i = 0; i < nvecs; i++) {
 		wx->msix_q_entries[i].entry = i;
-		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i + 1);
+		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i);
 	}
 
 	wx->num_q_vectors = nvecs;
 
+	wx->msix_entry->entry = nvecs;
+	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
+
 	return 0;
 }
 
@@ -2120,7 +2121,6 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 		wr32(wx, WX_PX_MISC_IVAR, ivar);
 	} else {
 		/* tx or rx causes */
-		msix_vector += 1; /* offset for queue vectors */
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = ((16 * (queue & 1)) + (8 * direction));
 		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
@@ -2151,7 +2151,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 
 	itr_reg |= WX_PX_ITR_CNT_WDIS;
 
-	wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
+	wr32(wx, WX_PX_ITR(v_idx), itr_reg);
 }
 
 /**
@@ -2197,9 +2197,9 @@ void wx_configure_vectors(struct wx *wx)
 		wx_write_eitr(q_vector);
 	}
 
-	wx_set_ivar(wx, -1, 0, 0);
+	wx_set_ivar(wx, -1, 0, v_idx);
 	if (pdev->msix_enabled)
-		wr32(wx, WX_PX_ITR(0), 1950);
+		wr32(wx, WX_PX_ITR(v_idx), 1950);
 }
 EXPORT_SYMBOL(wx_configure_vectors);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..dbac133eacfc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1136,7 +1136,7 @@ struct wx {
 };
 
 #define WX_INTR_ALL (~0ULL)
-#define WX_INTR_Q(i) BIT((i) + 1)
+#define WX_INTR_Q(i) BIT((i))
 
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 1be2a5cc4a83..d2fb77f1d876 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -154,7 +154,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
 	else
-		wx_intr_enable(wx, NGBE_INTR_MISC);
+		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index f48ed7fc1805..f4dc4acbedae 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -80,7 +80,7 @@
 				NGBE_PX_MISC_IEN_GPIO)
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC				BIT(0)
+#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index c698f4ec751a..76d33c042eee 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -21,7 +21,7 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
 
 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 	if (queues)
 		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
 }
@@ -147,7 +147,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		nhandled++;
 	}
 
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 8ea413a7abe9..5fe415f3f2ca 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -264,8 +264,8 @@ struct txgbe_fdir_filter {
 #define TXGBE_DEFAULT_RX_WORK           128
 #endif
 
-#define TXGBE_INTR_MISC       BIT(0)
-#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
+#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
+#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
 
-- 
2.48.1


