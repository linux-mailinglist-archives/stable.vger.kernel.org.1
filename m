Return-Path: <stable+bounces-155014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE13AE16D9
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B4319E0D92
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2731E51D;
	Fri, 20 Jun 2025 08:58:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BD27CCC8;
	Fri, 20 Jun 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409911; cv=none; b=c8eWiYLEhtaOT/3T7VyWvvNcgWYL0NwFWzxGfgkG2GTKVU/2xAcYbbv+khV4xejd5GLBk4I1zcl/2qbWHOX5KVPmusBEnUPHDxU/S7nQ9wsEkgc38AL0poMyyGuAd7fPkVA7uHBM5xYHFP1JlYPfHim+Sl2TV+jC8zXVSn/y1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409911; c=relaxed/simple;
	bh=dY/kf8w24loafQrqsLv4iIn+vH6kOrDuHaJVuCKPG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L84wz7b62niqSx1vR8eyBxKcdYr5m2rUYRPBdErbZpUKJ7NWS4U3x/4kvIqwI7K8FI/u4FINXA1j0zOlbj51cWjfyQvaJLa9UWEE1c2qQA3tj9shdMamGeKG1LjV0wPOSWBPY0l1F0laHiBhbSrwWlJZcQEj+F2KKxLZgDKNdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz12t1750409861td5f91715
X-QQ-Originating-IP: FFxKXzU4UJvD5UKaVFZgQaDc2yMocUNDiJXVhD3OTVU=
Received: from lap-jiawenwu.trustnetic.com ( [60.176.0.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 16:57:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3715390230374951233
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
Subject: [PATCH net 2/2] net: wangxun: revert the adjustment of the IRQ vector sequence
Date: Fri, 20 Jun 2025 16:57:20 +0800
Message-Id: <20250620085720.33924-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250620085720.33924-1-jiawenwu@trustnetic.com>
References: <20250620085720.33924-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NG7xP+P+sy647TZszhLtkLW2RpwwLd1+lK76/6E7S/forkhbY2ZbDPKs
	/m0XdGbyHHQYHjHLghd5hlaw51iiNWEMS5JsGxYOUxh+A1n1jXrzryUVcuQCLpNWJryu4mR
	tLyyfhX4jonwvKq5OCe4cwn7pGJzYxFfvXsnvaFtvM5fmuDLa4UHmSZAKT/0T9ajjV2wnCU
	aulbqly6apOzUSTIRpVTYQS5X8/h+IJloRBD89xevVARpnx1+RN9tSR2wGlhJ06MEmbcxbD
	FKztO5N1dSLjvWWjmxxRYYC7+LFYDy6CW21b0mWX6iub9x1zIt5bauRysCSyQjU6dXKl7Ar
	B6OOJAFAKwN8HInyn3gSBRKMB1rDAU9F7eWPA6SYhcrssFIeTQ8jxoM6RDN+Vlko7MRDq9R
	UD2gFW9XFUsDjQYjRxt+T4YLx0wfzfJ3UcNRcsJkZIselSuEwinFhjEtiz/KlWEDYeSl+aH
	Z6Co8+cL1F3AeyjyqKrkd/n9hp98qdPFURXClaoC2Ae9QDA65ci4b1YfKJblhhsDVvRJ7zS
	yPCLgG4S6Ze1iqN2sza/P9RNt3mIHtt4212x+CBqxG/52kunU4viXjv6zX02f3dnUQS55iS
	EK5e8aKqZ2MoB1o7PRPrVf9FAEeeRuTgi01Oqylnmfzrf01+JIVg0Q50V1NX9Ou1zKEDDUl
	7cgCfixLCNTN11Mygn5ox3se6W7Q4x3fnUlPAUyD0tzx84gJ8jOSbGn9izf7a/DLr8w5Od9
	F9ZOUjfCGkEIVHr07zXvtRfIpgGrSWVXfRMBY6sHFu/+49HXv8UjOrkU0akzi0epjSWCqHT
	nuE9t/r3mRz1xPJFFkQFIeSdFvxdHjzpbow5YO99O27cViUFfLCMsLvLJAghzogDn7GE65O
	7itLdef984U4iiO6c09w7SjJiJQf0S8BPpiLeWH9vL9JcxF0B/ZICHahz+S9HoOLpBcRk1d
	7j26KaDstHkBOz7FF9/GF3guIL5EXJiyluRmaCOroGHOYo2dJ8S1L5z77PEWHoouxrR3E92
	lazg/X67WIIeUVees2zMXhB1YLdYGuw5KqdIFvYAtGAkhwgsGamNB7J6Lmvw/m8gWzfQS2K
	JHqF/ID5Le4
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
index 20b9a28bcb55..21fc86ec25ce 100644
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
@@ -132,7 +132,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 		txgbe->eicr = eicr;
 		if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
 			wx_msg_task(txgbe->wx);
-			wx_intr_enable(wx, TXGBE_INTR_MISC);
+			wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
 		}
 		return IRQ_WAKE_THREAD;
 	}
@@ -184,7 +184,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
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


