Return-Path: <stable+bounces-159119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E958EAEEECC
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52001895165
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A2248866;
	Tue,  1 Jul 2025 06:33:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797B257452;
	Tue,  1 Jul 2025 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351581; cv=none; b=Bn8F/Du956/fD3tGV3Gut5UfT09E6lEO9uh7RZjy05Nu0Su5baxXiI5tta2J2+zUpZ3KTmJ6LzVSQM4lEvCTfMbNud3r3fh9K17I84mrzmEjPf9nZ9r80qAC2RspLg3oUWqeVvvQfGPK8AJOQaLYH0WhIUMKqmQTqP/WW8hnxD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351581; c=relaxed/simple;
	bh=z86vE8HPdVpIGsnjSJR520qHPeMlCi6ZwtFzl1plbnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebRHNYodJSzo7SE/91IBCkuWjaeFCXyHCG6OV2IuydF/X4FuVuiHPhBMr+AHH0JeMz7QK6JJTyxvRR6mZJCOLoaitApguQerQhIPYuWAOycvxAGjqGKlxY9MYeWKJH5563mAUIkC9zhXmPiZ+for4OslO4KMZAIfI7Iz5N4rjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1751351486t6910a100
X-QQ-Originating-IP: 78rVTldPRxl5imDZiO11OYsMK3TzVbQ3N6E3Uo3QYKk=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.151.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 14:31:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7562240398961290973
EX-QQ-RecipientCnt: 13
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	larysa.zaremba@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/3] net: wangxun: revert the adjustment of the IRQ vector sequence
Date: Tue,  1 Jul 2025 14:30:29 +0800
Message-Id: <20250701063030.59340-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250701063030.59340-1-jiawenwu@trustnetic.com>
References: <20250701063030.59340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OaBGvEDLEgIQSiBkSoZbG7wvGM7TGljTRMKUoZpaku59WOfW32FlaM45
	lOSRpK0ZcjNz6g0icNgTzQx0X9PPLaAm3B0Suwj3npc04Tby4IQm+7vj9D2cgH+nHzJU5HO
	dYgpVXNPAcaFA0pe+zrFj+I/i7Ig/ynyQrHU+1mgHrOYCy/X/mxoiX+4R/6YAFVC9732bQF
	K1SfOuTEzoBPQZkNdIBQ+p/gx9xD8PBPdxBzXFLg2cVwoaH4eP/eahxBj8lS7Y03FHz5zyZ
	MyPqJgV/KqQYhUTDJtbAJweb8ro8VHTeA1UIMUDhtrWEasQmstt1jnRbrMJ/zTye9q6AAIa
	6/Br4v+YZcEyoYPLwaljLn0yc+Mr6axodZqqAOzMK4RTzCfItPt8Qwb1LZnlMeozd5P2BZe
	Vw8KfeQ7wMbyyouZwrhNKLTlRfg+IKlKF7tJXWpIG59YzKhH+/bcntpdCB8NmtH4pPEfAVq
	QHPruGBdRWKh/AupZg6uF3o+tMVR1TCckk3eX4eY8Mygj5X8KnxLXdyMHDn2koKv3Wjeof2
	hmf5ENFWBvxFtLcM8DUZXtwyHHIPQaLGlLpbVD5JTU4fJ9t6xZ6SRLvoVLb7xDGLZLmvIKZ
	4R3eki76C+uUzrMuTXmCrHWn+33kYHzJvpQ117itUwC4hoPgzcLKbo7q5QIkZsSlooprIcG
	WDbWiGO6iexjhu04w9rE+Ssc5OJk0IUxVFPNdUSA4nEUzo940V71rFAQaWUsH6WRrEvfXNz
	d9DVKM1mdHL5dGBz4ILoJG5WitfOkD4K0ztGCx5c87dhf7KBHnOEWgl5iRqgTcijA+wVVlO
	+XXOBmWntaWDyuhvm8E/qfCmiTTyiyGsx463pYvepUpnu10Pvk12jGqtzqrl5f40/SSmxjQ
	9wUQCZAIafhttsjKo2nqeokCbjpKSKuJQWndm6eIYV+X8WGKQfWihSd30/ReIySVjBk1h6f
	D2ltbLIIFbynw3wnIiD44hEaDJ7oUORVk3lFzFjzB4dXMzrd6mvfz5TKea8W5D6+htjkMW8
	dlT9n2n10X7fPAnEn9sl7PH2knIxKsSIsz7hwmYZEN2r9GTd77
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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


