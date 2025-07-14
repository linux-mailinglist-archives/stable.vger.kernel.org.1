Return-Path: <stable+bounces-161796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7AFB0349A
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 04:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE733B6173
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 02:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0613A41F;
	Mon, 14 Jul 2025 02:45:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6101D5146
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461111; cv=none; b=aGTK+hb1n0XXJJ6RJzKMNFFBf1p1Tv+k0s65JbvLemFIJdcTlxYm2F2YSQqSFFG9Zi8Wo5opZms4AzXxCdJWbHAqntfeLFvdT8ig3XQfqshNm/MpxY1qdB8mUyyLRzNkM3eLtGw58M6ctEQytcSzXCRY50WtRGYRWqILqZ+pxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461111; c=relaxed/simple;
	bh=NBboOhPeCtU1cKJT52SUl6rz8diXHUUx+TUcCMhPRbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrlgRD1bo1gP4IA1ZPCZ7wWh2rPQW6msWOKcq4x0qrmFCdnClad6SI88iOtcZDXopSi81suBNk/zbVDEyEdl5cJ/hkrFlu9PgFk180vk9kYE9a6DtL3RtPuKb8G1MhyrjAOUIc0+C2Hd9AwIvFd9DHD1Ecbdtw1YBv/irqARUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz4t1752461081t4c5a8825
X-QQ-Originating-IP: f/rQHGCyyuiidX95fHe+mxi3thk31B/yZ7HwRYWy3jc=
Received: from w-MS-7E16.trustnetic.com ( [125.118.253.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 10:44:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13799519219817714427
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.15.y] net: wangxun: revert the adjustment of the IRQ vector sequence
Date: Mon, 14 Jul 2025 10:44:30 +0800
Message-ID: <D0563743AAB64DFA+20250714024430.292370-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025070625-walnut-bargraph-970b@gregkh>
References: <2025070625-walnut-bargraph-970b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M20CudKc/jgfz3iyk27XHISf6ktlNtCt8E7HwjpbxUZ9rIZRWCd9MeCG
	Y4W9V9VjXqnfnXxGOwfXYheU6hSwTUlV2PtiJ5+4Zx5V9J8LM7CJyaUz81X0nGKRXSKZ59j
	0G1VWHiAfIS4Gj75pmPByCtLRnTFXGgUKC73w/fIHP3N7rjupfm47z1j56pnI1gPG5lafVH
	hAKvsAm8YsziCYdPahbMDDMvt38D0Nuvl1eEh1dW9y3UYWELGFBptdi2dY4Cil8uqyuMBv6
	lWARa1VPhIQphY+6JI0PyTZLZIiOIAeNX7UXH4DgDER2jV/lX2w/tml6HxUDVzJpz1pcqh5
	BEyx3aZdbVGnCtVo/nEAYc9x0iXNTUJ+hHiZ6Op28lwwVFqXaKoYezj8YV9bDPhYTl0yKmi
	tSP57Tt52OqLNvQKoBFNAQJAXWxZ76qF75ilWwqckcv6bVT2AJ6ooPWM152t5DBZBqhgHLD
	FWNKL89BSqE812UIf+p4fhoLlNg3dPzA1YYWD0YdNI7j+RJJKQ9CdAVYax8NqXIEuG9e9RZ
	oLKyENupW0fMyPPResoVIdMDPL2IFhgP/tRpxnLjp7mhvttD664QJeHfNQfZmGTfaCyxviu
	l7ayHo0hLkn4VjGmNEuifYDQgiVl0IxiJL5klvdxR7wWF5WB2a8GD3AB851Jr0CMdbOpZay
	1M7zeYkhC+lJSLKOGMf0pVEAmwJvoawiFLo+NeSjRlSl52PRJ6KbChrN7KCGZORmx6wGFKi
	83puW+H0kh09ttv15SGMSl9xZ2VPsSTkLzHTF12H1zxexx0u7BCRPXQNi9UNo+OUBxD2EG7
	RdFFWmvvVUDKSctmfuGParp73M2haKpeV7lgo9wR4/SIm4K8LGq+bViPop8C7UTAMtriDQk
	w48twumDkXWftSncDaRi15jMeZ0a0TJrYHSD87yuFJRwav8hbfK5RCxwZg0CwBCxw/Jr2qZ
	ebIHbjP7ZQhgkYedmCYIQATc7kjHrkHFhi10haTlVLq9iPP8+sJFbdPT6wVWrPP8p5XaREV
	jl1ld8H4LzPQH5/H1LdIfl0h+2aAPjYuIYnWbRzcm9Jyp7oKVOAUOtGSRM7ra5e5EzWEcxJ
	nKzrJCOT/GyaWghqrl/QEdvaWeDxFuWQ3IMQpxfHYR4
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
index f77bdf732f5f..4eac40c4e851 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1680,7 +1680,7 @@ static void wx_set_num_queues(struct wx *wx)
  */
 static int wx_acquire_msix_vectors(struct wx *wx)
 {
-	struct irq_affinity affd = { .pre_vectors = 1 };
+	struct irq_affinity affd = { .post_vectors = 1 };
 	int nvecs, i;
 
 	/* We start by asking for one vector per queue pair */
@@ -1717,16 +1717,17 @@ static int wx_acquire_msix_vectors(struct wx *wx)
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
 
@@ -2182,7 +2183,6 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 		wr32(wx, WX_PX_MISC_IVAR, ivar);
 	} else {
 		/* tx or rx causes */
-		msix_vector += 1; /* offset for queue vectors */
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = ((16 * (queue & 1)) + (8 * direction));
 		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
@@ -2220,7 +2220,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 
 	itr_reg |= WX_PX_ITR_CNT_WDIS;
 
-	wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
+	wr32(wx, WX_PX_ITR(v_idx), itr_reg);
 }
 
 /**
@@ -2266,9 +2266,9 @@ void wx_configure_vectors(struct wx *wx)
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
index 4c545b2aa997..3a9c226567f8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1242,7 +1242,7 @@ struct wx {
 };
 
 #define WX_INTR_ALL (~0ULL)
-#define WX_INTR_Q(i) BIT((i) + 1)
+#define WX_INTR_Q(i) BIT((i))
 
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 91b3055a5a9f..d37fd9004b41 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -155,7 +155,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
 	else
-		wx_intr_enable(wx, NGBE_INTR_MISC);
+		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 992adbb98c7d..9e277a9330c9 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -85,7 +85,7 @@
 #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC				BIT(0)
+#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 44547e69c026..07a6e7b54607 100644
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
index f423012dec22..b91f2f7bd1fb 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -280,8 +280,8 @@ struct txgbe_fdir_filter {
 #define TXGBE_DEFAULT_RX_WORK           128
 #endif
 
-#define TXGBE_INTR_MISC       BIT(0)
-#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
+#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
+#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
 
-- 
2.48.1


