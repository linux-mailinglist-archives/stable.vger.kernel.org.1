Return-Path: <stable+bounces-158919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A5EAED8EF
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5D71746F8
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DE246788;
	Mon, 30 Jun 2025 09:42:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C628FC1D;
	Mon, 30 Jun 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276554; cv=none; b=g9ZwAVncvulwOG/Ym2sH7mVsX4kYYaXo3ltCc+4x84yMsvMT83pbl1XqcBcflSq0vIlth/T+5Yqb9F/kaJeKCnQGnvBfDyMjg/w62kkxoT2n47YcU+Sw6H7Qji+Mt9UjZ3LAFwdXFd4zWaBMu2JjMBfTfJ4PnBjwAGSX7DzY/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276554; c=relaxed/simple;
	bh=ouLFgmRvYWHiYjRbi0QKE+hRqzA8wYBedRhl6jY4HNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKBcY44ZwV9HxeNbwm8DeRb1egJYCSyN24473FsNyz55xKPIUS1RGn8xG0tOrQyS0OO2MLJ1pkmxMQnlFpxvMVDuNHoM9LJXyHlDzyElN/1N6IVO1H6HuDa4aGlLp3EHqcBKWV3Fbp2RnGE+EakRM4Pc2HygabavGmKDukskUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1751276476t83dedbc1
X-QQ-Originating-IP: wB8ILOyR8jZl/vHVC7KPmfZjJkgAgDakoffsBLAVl1M=
Received: from w-MS-7E16.trustnetic.com ( [125.120.151.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 30 Jun 2025 17:41:10 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 106915942635377542
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
Subject: [PATCH net] net: libwx: fix double put of page to page_pool
Date: Mon, 30 Jun 2025 17:41:02 +0800
Message-ID: <C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYlggeZuI0UG1AEP5h9/MiWHNUNwK8W/x/Q0TKVIPxS7c0ZRIH+mXXgX
	SFTDwIy4RNzWiEVtkebgt4rekD1NzopKtZiAk0QM8z9lU6SO9lVRxJpNwwPwt69oCUsO+w3
	y+HL/cH6ZNaaMoWUzYJW0rPfPH5aViqrpPEXcTT2bJvz1oPNDDxLlBUmNCmJQfP/1hHButc
	T4dQsYE8RQCCNog4t2tiXXAlYpd2BHOh+mAY3UdIjeiIGC5hnxgyqy6tL+foaNPWQiKKtVU
	T/dGCdBHMJPUWkcDXb7Pic9tWZYOTkdRK1w29DT3yeSRUiQiMKsLXYEtgrm7gC5ZVkDw0/b
	3MHzqM2mPUTvrrr085LZZrO7h6I2punl2miLjY57zjTZ+6B9fr3s7DygLG2IqhOBjBUJWob
	6ZkkST3uh/Yyv8lIUQgAg5JJ9f5zIhR8cSWrRpl15hfNpr+n19aGs5VwGQTizzIB9mVho/8
	2ezDSDEpVEPGP920xna0Mj9T99ZXRQZibc4yldBS9aE8SKabi7iGlXfJl4/QwrU6SSCSc0u
	8lB6dJVAXLukZyTnPMRKLA/bxif7THu+rgYzfdjzcrEOmZ+RRlG/gt6DQ6WtJUAlMp8ydKE
	a68wz7u2MUDUZg80gC2wKiCBHVZ0cuw9dU1hCI5fIVv09Ut7GIk766vaPSn+k5HWwVCaBm9
	BMUNQMSJimhDfysP4MAVhAbdmjJPhVWM5zVcuxwPtGVMkok+ebAVRovMKZc/COAeIFSiv3z
	06UUPUF0nwMoAdPworvL5hx6gzjP9fq0wxyNp0fVENDuH1uMdbdHxD5QkfT/3bj7TEHDQnv
	YaypGyXxt/jjyFYFRu7sDKR5rvKuSPgTb1+QT+ETj9UfcgBNtC8mTTtLQsXoOjttGZ8Kbf5
	U9EhuSbV2+YzijUrQqtvp7MFQkUA/7c8fMqBneaYoFMLsGYrXrAmIse41LWSyIDWRMzK1Fp
	G13vsLlRF2r2y3dpU9jzuhAVTDnPOdfWcf/PsYIqTNZYMG5p10E6Q0rwTa6DfAVAV61FsCS
	W1+YCLDMRO2Naz9FsKjtU9w3ojHdoyCfkIWVYGl2CLrPAAr3ufKHFm4FZa3Co=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

wx_dma_sync_frag() incorrectly attempted to return the page to
page_pool, which is already handled via buffer reuse or wx_build_skb()
paths. Under high MTU and high throughput, this causes list corruption
inside page_pool due to double free.

[  876.949950] Call Trace:
[  876.949951]  <IRQ>
[  876.949952]  __rmqueue_pcplist+0x53/0x2c0
[  876.949955]  alloc_pages_bulk_noprof+0x2e0/0x660
[  876.949958]  __page_pool_alloc_pages_slow+0xa9/0x400
[  876.949961]  page_pool_alloc_pages+0xa/0x20
[  876.949963]  wx_alloc_rx_buffers+0xd7/0x110 [libwx]
[  876.949967]  wx_clean_rx_irq+0x262/0x430 [libwx]
[  876.949971]  wx_poll+0x92/0x130 [libwx]
[  876.949975]  __napi_poll+0x28/0x190
[  876.949977]  net_rx_action+0x301/0x3f0
[  876.949980]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949981]  ? profile_tick+0x30/0x70
[  876.949983]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949984]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949986]  ? timerqueue_add+0xa3/0xc0
[  876.949988]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949989]  ? __raise_softirq_irqoff+0x16/0x70
[  876.949991]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949994]  ? wx_msix_clean_rings+0x41/0x50 [libwx]
[  876.949998]  handle_softirqs+0xf9/0x2c0

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index c57cc4f27249..246b18a0285e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -174,10 +174,6 @@ static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 				      skb_frag_off(frag),
 				      skb_frag_size(frag),
 				      DMA_FROM_DEVICE);
-
-	/* If the page was released, just unmap it. */
-	if (unlikely(WX_CB(skb)->page_released))
-		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
 }
 
 static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
-- 
2.48.1


