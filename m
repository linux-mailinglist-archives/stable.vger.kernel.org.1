Return-Path: <stable+bounces-113278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF768A290DE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA52F16A411
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74EE15EFA1;
	Wed,  5 Feb 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nxnJIl0h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D0156F39;
	Wed,  5 Feb 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766422; cv=none; b=KwoFQC6990n4pznBMITNQMx3hlJ3ueL4x3KSzqfYQubyBq7272dTj5UePp96dgcqlnqpb3yBg1wiJhAvpzZ5b65tppYuwBZ2zguU42XAyHCk37+d+7T/vrU7RZ4CHAOqY3E8XsFz5TP/Ld9+RUO3BNz/bcfoJ0d9th/wXaopY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766422; c=relaxed/simple;
	bh=qyp3Tqbe0kydWCn9B+fvwYkgFs0lwvv/l8VdOcSNuzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqkWqJCXsZny5QdxKnAaY7/ESEYCyKon/plOx+jZszO0r/xq1u8UCbC/GCxCxZm5lBE00rExIVUB0/ps/Gv9EIwr9fIjnetkdY8kkXYfhuLDGsw++7Pual2DQtedBes1zcfTSnI3M9WNhHDxMoyW59yJUusaQZ0bo5gOlXS7msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nxnJIl0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631C9C4CED1;
	Wed,  5 Feb 2025 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766420;
	bh=qyp3Tqbe0kydWCn9B+fvwYkgFs0lwvv/l8VdOcSNuzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxnJIl0hHEZPuh6mLJu5056lHi00u3x0bXmz0BBoc8jtLrwEmezt11w2Ps3NTnCDE
	 cFpD49giXSIIq92S1+I9CsTYOZG6aQNqv/gVDYI5C25QALBCq9EXQI9Vgblh3IrzaT
	 xlGjLdmPRVA6M8y1FvM1iV4QKDRAsS9AtHsRXx7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 343/393] bgmac: reduce max frame size to support just MTU 1500
Date: Wed,  5 Feb 2025 14:44:22 +0100
Message-ID: <20250205134433.435353789@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 752e5fcc2e77358936d36ef8e522d6439372e201 ]

bgmac allocates new replacement buffer before handling each received
frame. Allocating & DMA-preparing 9724 B each time consumes a lot of CPU
time. Ideally bgmac should just respect currently set MTU but it isn't
the case right now. For now just revert back to the old limited frame
size.

This change bumps NAT masquerade speed by ~95%.

Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
page_frag_alloc_align()"), the bgmac driver fails to open its network
interface successfully and runs out of memory in the following call
stack:

bgmac_open
  -> bgmac_dma_init
    -> bgmac_dma_rx_skb_for_slot
      -> netdev_alloc_frag

BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.

Eventually we land into __page_frag_alloc_align() with the following
parameters across multiple successive calls:

__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=10048
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=20096
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=30144

So in that case we do indeed have offset + fragsz (40192) > size (32768)
and so we would eventually return NULL. Reverting to the older 1500
bytes MTU allows the network driver to be usable again.

Fixes: 8c7da63978f1 ("bgmac: configure MTU and add support for frames beyond 8192 byte size")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
[florian: expand commit message about recent commits]
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250127175159.1788246-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bgmac.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index d73ef262991d6..6fee9a41839c0 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -328,8 +328,7 @@
 #define BGMAC_RX_FRAME_OFFSET			30		/* There are 2 unused bytes between header and real data */
 #define BGMAC_RX_BUF_OFFSET			(NET_SKB_PAD + NET_IP_ALIGN - \
 						 BGMAC_RX_FRAME_OFFSET)
-/* Jumbo frame size with FCS */
-#define BGMAC_RX_MAX_FRAME_SIZE			9724
+#define BGMAC_RX_MAX_FRAME_SIZE			1536
 #define BGMAC_RX_BUF_SIZE			(BGMAC_RX_FRAME_OFFSET + BGMAC_RX_MAX_FRAME_SIZE)
 #define BGMAC_RX_ALLOC_SIZE			(SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) + \
 						 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
-- 
2.39.5




