Return-Path: <stable+bounces-161388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9435AFE019
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953101BC7753
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3326CE2D;
	Wed,  9 Jul 2025 06:41:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF326B75C;
	Wed,  9 Jul 2025 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043318; cv=none; b=SQEkpZW9i6W5tNAyLzUJ9t1LXLqZj0oPZLoAtwxv/YYahNU+wnprtMXq6HHLHehfOtj4ZLasyUZuNGlV3G0MU7R3iEcoP6ntIZDRe7HwzlqzOimjppG33nKzD4P4kU3rVNZiD44gTD7jVRzJH59lw1OS+qad0CGtOPrP/aCnRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043318; c=relaxed/simple;
	bh=H9HrPg7DIsGR9qJFMgiIkdZD6FjYeVkRwMB0lzEp6QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+b0z8F13+kVfrEb45dBYbskbhRyycaP6T8ERJUR3s2V1FsE9S+nFppdvyH8WxUhL9ns0dT8U2b1bKgRuZa+E11dSqqM1ONuEwpIUwHvnDAPOpG9HoMzaNE76mRrmHOwhH8w3W/+VlQZfTARVKN9Qn/NzyacT1rUppOR05WedBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1752043246t128a2e9c
X-QQ-Originating-IP: y2+5PbEK5WDlhHAbE3efsxdZevrjew8XYqzSgefqPvQ=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.45.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Jul 2025 14:40:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15836940012302802655
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.kubiak@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] net: libwx: fix the using of Rx buffer DMA
Date: Wed,  9 Jul 2025 14:40:24 +0800
Message-Id: <20250709064025.19436-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250709064025.19436-1-jiawenwu@trustnetic.com>
References: <20250709064025.19436-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OKK2DAMrOULS6Ly0fIf38DFW1+lJNk4Hn409swjBuDecgPwnghpMuhX6
	NhmmWnSbydVaQr/mL5DI98h+7AEJ6liRRH/OwwdIGY2Zpi+AJDO+jFBnenjvTrJgHtQ7mpC
	aEEXulNnW9ZNd+krHGNdfgLjdPMFRUd0R0zJwLyLsrs1XK1OcR0owXv2Q4GDh67WaGdCLhM
	p4tpzfDgAuLosqZ9Gm+D7EMsmwfU9ULj91yMb1ZB9xj4qivcXAjzJR1ykz4euxMiOAy17WD
	tAcZ05o+ZGqVoeZDbY8tI+y/SvYKHmxwidgjXKTSgefnoLYve2Mcpc3jOd1GxSlbIt1Ibva
	b9p1wKssGh4abSyZcWbj00NGx4N9D4/vjKDCsIiYOjggq0gvzwGJwK9RK5yMAY/Q8XtQq9L
	RTAHLBgDI3aFcbHERbli7U8zzeWyAMqqPhWNgDotllAI5x2EkdJTDOwMtob7gfSHHxa+sty
	V/6pmEwV2aAO01WvQj8VI5HuX+/tVeHYmyyrzgQ/XnGiB4U8OmWpyAJ5ad9bRubDpl935fD
	IAnWoWBD2XqqraVF2TbH3ib6MLsAYfP7PSUZ25DcKe9tGsIOYB8NSgY5v76218Iw1cnzxBj
	gTlanofjTDKB6vUlCRG4uKrJSfa1Hl2d6r9hJ4EPRzMJdDXqOlO5kyplGxLPbPJSPhlzQ41
	qEPF9wmLB75ekdk6F7EYcozIkhpAvb+MAtlPiW2y6Lunm/Qe6MMEdDt92dkXUQC3++XuaU/
	Xe8Vdtqvvut+VXe6Fq95hYr7jhyD8oiw0S79zUySaCzg13ff1XmIQLcB4YNOZGJxwO9WpWL
	LKh2ogwJ5Ad7osFlJ8fyxfC/Dab9mAoMAdd7Dp/w/ZvgiCgEphOaUL51SzKTt6ObzCEeTWq
	9KQtPyFH72bt9xySWO/v0PxFre4zkr4DcjEM3V64afAKyx7Y/J4tCEh65djWIA59yuDrMvv
	FeO+rhXbUUNzKGimE799VBWPo2MKfhZ+J5Y5uExrTQWNDPkETK1Ix66T06QO3IXfqcD3WXn
	MV1wknMo6/aOq7NoWkcgHTvpilBHmhVqBBKQQfbYd0w5nXH7TmJynNTCHxoNqQNB26D3mML
	A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

The wx_rx_buffer structure contained two DMA address fields: 'dma' and
'page_dma'. However, only 'page_dma' was actually initialized and used
to program the Rx descriptor. But 'dma' was uninitialized and used in
some paths.

This could lead to undefined behavior, including DMA errors or
use-after-free, if the uninitialized 'dma' was used. Althrough such
error has not yet occurred, it is worth fixing in the code.

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 7e3d7fb61a52..c91487909811 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -307,7 +307,7 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 		return false;
 	dma = page_pool_get_dma_addr(page);
 
-	bi->page_dma = dma;
+	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
 
@@ -344,7 +344,7 @@ void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count)
 						 DMA_FROM_DEVICE);
 
 		rx_desc->read.pkt_addr =
-			cpu_to_le64(bi->page_dma + bi->page_offset);
+			cpu_to_le64(bi->dma + bi->page_offset);
 
 		rx_desc++;
 		bi++;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c363379126c0..f5a8ce681a68 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -998,7 +998,6 @@ struct wx_tx_buffer {
 struct wx_rx_buffer {
 	struct sk_buff *skb;
 	dma_addr_t dma;
-	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
 };
-- 
2.48.1


