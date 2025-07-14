Return-Path: <stable+bounces-161797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB90B034A5
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 04:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA961898EA3
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96E11448E3;
	Mon, 14 Jul 2025 02:49:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52097126F0A;
	Mon, 14 Jul 2025 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461397; cv=none; b=kG8srKZi8CbWhDXjmYI4WPAr2Lwn921UhNg92scMCEUF+UWn4In3dFGT1QH3PsxgeDznXtmQ3WqeQFo3JLPhWVhTTkEHirnWNcccddDRvWwTcqM3JU9AqYIpjjr/B7vUGLro6zuVYw2sdCPOTVMA63nlu+GV4pINovkTgVWA7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461397; c=relaxed/simple;
	bh=MR7w7mQs+GFAmNi0SwtlcAv7UV7DacWr/Q9Bga2qIV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLfqlHb2F4/5u3Vdh4ilraeE1phePunvZW/0MkgXpyeE76TFWaWTMBNTjkNPivfGNeYsFms0M04C4C5ml/g2ABldqJGD8EpNDEUfr+Wx9Y7P53sRV9Rdqnpw45kbWXcfX901yiZ1X+xCudgXVQOFdbzNXGZugMvMbegSTPC2kIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1752461297t3b7cbab5
X-QQ-Originating-IP: /0WatQ+mTimusGpZt/Bz0czysoNhxLhELwTCXH2LPr4=
Received: from lap-jiawenwu.trustnetic.com ( [125.118.253.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 10:48:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11363736685552628769
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
Subject: [PATCH net v2 2/3] net: libwx: fix the using of Rx buffer DMA
Date: Mon, 14 Jul 2025 10:47:54 +0800
Message-Id: <20250714024755.17512-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250714024755.17512-1-jiawenwu@trustnetic.com>
References: <20250714024755.17512-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MKD6Cx7ZSeC2sIIrJcSifb+Dkhohg1Vm95fqqyhB0wDZbA1EAIGwJnDt
	FAwkA8UMHhGatRoVTCgeGHsHGMwruM+Qstix97tkrGFDtLmA8b/TFZsZd7dztccS/fAdR4c
	rK6d+Lf0+FuxiThvmUDxh7bHOxwtFrcjf+dIvz8+u1yGXVcOc8ixZGgE27GxSqHM6DD6OxG
	5vE6BTwH/BwKRo/Y6ryOhjMsOc4kjKD8FixKtwb2vbzQf2wPjC00fUROZGPgMYMsEm9XCOL
	GpJbD6cSxxmyQOOrqI7bvVa3GpDFMi5tBvQniH61uy59VGzvLrQCd0A86daOwPL4CH3C+MN
	TAT3aHTWzpUBwBp1FW4yJl3EbRbQ3m7XOxYmUkJ5yxnHIUcM2Lsqjj3aM2j/LdpezH31az7
	q5v5yGgyqYZ2RNiEio/WnsIABfZaerNWmaxjkksR6NsaF0xv8jVGvkgywu6IHOk3Lj000sk
	MYwSyznTplYDdSnbiAHUH/ouhX/nPP13c/OsQfxbDMuyCQY7Arq15C7ktWzO7ms71gbPjcc
	U0YPHnbXUi0fnWMt2MHWKcGFdpGWOfHGlGNr0gW5pwve+0VN7NuqrlQZXIiYFrLcZZrytLz
	MWRdWYQDTP2Eq9mOCLZZK97l5sOvzSbvs887qJtXtclQ90Cx8Bthb1NtFGhkBQOGl24KQ9u
	aicA/5wSYvb1bT30VA5XN6BMkOiqJdaX1M73Njt2TscYL9DKV+ytbfa353WCG8OImr0VaJr
	lWWnJAyCPWpaPYlq7Sdn66cbIoG2QUVZoxqZ4+hYaT2cBfMXvROWrEErWVDCtIDbYfZVF5k
	9h1raoFnOJCWdKHUgv1y4o8K5UbqTZ34GpLPWGjbrE73uCBur8rHCeipiraveGWqrnUMo74
	4g8hkKHDgVT3rAjhQoXvQ9IZKbKLtk63gHosqB+6z3PXCY1gVI7oVSGQTk/qG+9gCe2bJPT
	PvkBoU+2ZYU4Otn0054XF7VifaQqJCVLx59fV5gh7Ny+ZgsBVeQyzXN4TM6iLdBiI8Vn9jc
	dTxRc2o+Kfg2WxOIq8YHqgxZW1kcoLhUzylw6ntVY4Ov03LpLxqD7QI3ejDZQLbehXhvlC3
	ZxaMx/JeU1q274JPYHE4F8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Reviewed-by: Simon Horman <horms@kernel.org>
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
index 622f2bfe6cde..1a90fcede86b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -997,7 +997,6 @@ struct wx_tx_buffer {
 struct wx_rx_buffer {
 	struct sk_buff *skb;
 	dma_addr_t dma;
-	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
 };
-- 
2.48.1


