Return-Path: <stable+bounces-158350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF4AE6013
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B43192328A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D6277CA0;
	Tue, 24 Jun 2025 08:58:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B726B740;
	Tue, 24 Jun 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755497; cv=none; b=infczNEaII9Snf5cYyUWlC1LYkS2EMjqbsRoADbWKz13yH8uCochvnMwWCHKUmJxGfEgNeproAhqqMehD0Vn5OUSUb2wr+aIbAfzdc9FZKbthhqlWVKuG4JnZA/OwrK3FT3qZv0nlZJu1TYYgdzwuZiuV4vNGknP2td/Q4I6ioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755497; c=relaxed/simple;
	bh=VLbiWkX8kQdNOTQe/nl+zGd6Uct821hYaKB9Ta26SfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brAvXMnpsCPIVG7TXhnpCvAlyz9UEvuQ0wTbzFsKCZub3AHnqFuSl5Ax5wbo/KcGXCTxm95vGtdrPhFOTW5eEBVDZl+5BTH7Ukder1NUJJ0u16oUR/xJOTUfuDf7l3UjCJUlo4NgVisukBQDQw3x/zpMUWIyODQRH+eNP8pMzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1750755414tdc053a77
X-QQ-Originating-IP: Jix17jil7KHpbmzTpYumfJ4YKxtyb10ZR7lsQr2uxkc=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 16:56:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3746311101423383304
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/3] net: wangxun: revert the adjustment of the IRQ vector sequence
Date: Tue, 24 Jun 2025 16:56:33 +0800
Message-Id: <20250624085634.14372-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250624085634.14372-1-jiawenwu@trustnetic.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OM0iiw2VivNHFySH9DvUUCFnqFRjfg6qrj+2jF65pMYpVFsHczsisLpb
	ocNBddKq7OVhwfgT3xOEOVpBZQT9sN4luo1rzHsjEZmOUrk582z3UJGefxe9R4Vu6N7Nux7
	B7N2+HtzP9Ljey3DtjMQMvgzIPEmlmdAGo2B99n0VXk59OLtAUgSgpYgE35o2aafV4mu7lQ
	kLlXctKuuaytXE39RPROYmsqAqIaxbHEm67WDqfQ2nV6ThoWNYxUu5mJ9+4ructfG4c6oHl
	snkQdxDfD35Zgp6oTL8yTitISI01f701/voIcGd11Skn3zcapw9XPQudNDjUGhzCYIwPykg
	30i6y99d7FvccOeXdXSrjZ6xlPaVtiy/cwFB3BB4sJeYY/CPEvjcGR1ipwkAnBKU69QyhzW
	YbVk0m5V4bnjUmsz9+vObq8WETpjsicOBIw7bRGq8LaGnyO80Sl8QOeNXWC1S7WEY7r8pva
	TMq0Y/qm9hKtupFYmrQAr13Pk6sg/hIyEzriTOUTPn/ifLYOrVvxl1d4nEYIKuPlQyFqrEK
	rAq6FroaGynySbAHw5GG4OZChYpImza6tXHURToIfTlruW9UEVqiH3EcuHCBhT1swhN6PRH
	29IvwSMOYoJLoLyk6RTbjfn9XIcKKP/jbbYLdRy2aaPg/lDQjuWxmRhxDJAQbG/cbKP0v0S
	2+pYXXIo1nZ0DZXYx4oUjizXMXPoOn/04mHD9UqQKryyH9dY3gPUrvHxO83/nzhpobtzdz6
	1PkWRsdldtAeeyO06Hb/UXnR1Xhn8up8zy4dHtKDm1K/pZ0ZQSs8e3Ivv1pU7pGf8y1GbFl
	uJgWXDaYjSMhWbc8YEEE2WRvXkQ/ryAP/PdkWZQtZAzSuU3G4ZSqBc48uRaA28JgBWiTmaw
	mO3PDLoli7xM9rlZH4BDHFeNNds7kKz3cpUQpt93ms25xGhwyfPd5OmM0BgWfT3/AS8CUtg
	pcM1HVP9127Q44gsoXMzK20zxiC5U8NE4mtMm1smf+8lR1c45syIl7jD23ztyIG9ldYTzkJ
	fUi8EVk1Jh5drFwmgwGiGXI7E4vaU3R2Ub8Te1JoJPk1Bo4RTVJ5b/JzxndFP7d0ItN99Qm
	a9xrG0lLSoo
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
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 17 ++++++++---------
 drivers/net/ethernet/wangxun/libwx/wx_type.h    |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   |  2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c  |  6 +++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  4 ++--
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 7f2e6cddfeb1..66eaf5446115 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1746,7 +1746,7 @@ static void wx_set_num_queues(struct wx *wx)
  */
 static int wx_acquire_msix_vectors(struct wx *wx)
 {
-	struct irq_affinity affd = { .pre_vectors = 1 };
+	struct irq_affinity affd = { .post_vectors = 1 };
 	int nvecs, i;
 
 	/* We start by asking for one vector per queue pair */
@@ -1783,16 +1783,17 @@ static int wx_acquire_msix_vectors(struct wx *wx)
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
 
@@ -2299,8 +2300,6 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 		wr32(wx, WX_PX_MISC_IVAR, ivar);
 	} else {
 		/* tx or rx causes */
-		if (!(wx->mac.type == wx_mac_em && wx->num_vfs == 7))
-			msix_vector += 1; /* offset for queue vectors */
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = ((16 * (queue & 1)) + (8 * direction));
 		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
@@ -2339,7 +2338,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 
 	itr_reg |= WX_PX_ITR_CNT_WDIS;
 
-	wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
+	wr32(wx, WX_PX_ITR(v_idx), itr_reg);
 }
 
 /**
@@ -2392,9 +2391,9 @@ void wx_configure_vectors(struct wx *wx)
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
index 7730c9fc3e02..d392394791b3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1343,7 +1343,7 @@ struct wx {
 };
 
 #define WX_INTR_ALL (~0ULL)
-#define WX_INTR_Q(i) BIT((i) + 1)
+#define WX_INTR_Q(i) BIT((i))
 
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index b5022c49dc5e..68415a7ef12f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -161,7 +161,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
 	else
-		wx_intr_enable(wx, NGBE_INTR_MISC);
+		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index bb74263f0498..6eca6de475f7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -87,7 +87,7 @@
 #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC				BIT(0)
+#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index dc468053bdf8..3885283681ec 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -31,7 +31,7 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 	wr32(wx, WX_PX_MISC_IEN, misc_ien);
 
 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 	if (queues)
 		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
 }
@@ -131,7 +131,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 		txgbe->eicr = eicr;
 		if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
 			wx_msg_task(txgbe->wx);
-			wx_intr_enable(wx, TXGBE_INTR_MISC);
+			wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 		}
 		return IRQ_WAKE_THREAD;
 	}
@@ -183,7 +183,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		nhandled++;
 	}
 
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 42ec815159e8..41915d7dd372 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -302,8 +302,8 @@ struct txgbe_fdir_filter {
 #define TXGBE_DEFAULT_RX_WORK           128
 #endif
 
-#define TXGBE_INTR_MISC       BIT(0)
-#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
+#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
+#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
 
-- 
2.48.1


