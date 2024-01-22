Return-Path: <stable+bounces-13795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28463837E13
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD98B1F29CBF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD355C34;
	Tue, 23 Jan 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYkJb7FP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE953E16;
	Tue, 23 Jan 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970345; cv=none; b=su145MB/3BbasXWDkyN4hT2S6VNMrKdHmn2gmTq6c2mu/jpb1atQz0uZ2M0c/+5VqV8vgS/Jbvr6mrKrawsS6Io5V/A59Qidb8Ky64yxTND95T8ysVL+l94SiWKGGfezhSd/NM/f26QuOqGLjA6B72723b7I3OLIsZC/wTcrTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970345; c=relaxed/simple;
	bh=sUrPH9xjy85NwwGk0TWQGgi/8bQ5RMY7dDdSvZ95eF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9oI5iKHF9IywjpUlxO9PgRxFxWUEvptf7tiw8q2WL2HyI4JLciXn8Irl8QQwLNdT2l/1pNEKvU7SJdfWivzt+7vf+Hpbmw/feevBH6iEjvlK3EwTI5QPt4xhq1how7Gj0PDLLsx2R17dDSjl5qUo9bin8v4lwnR+BEcjXnJHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYkJb7FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CC6C433F1;
	Tue, 23 Jan 2024 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970345;
	bh=sUrPH9xjy85NwwGk0TWQGgi/8bQ5RMY7dDdSvZ95eF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYkJb7FPi4CnU9Ux5YWp3pHKOcgmzgKS27QydBdBGxcX/z3ZZGVMK9iklY55PlG8y
	 2i8/E6jjxgwhgnboSfY3UnZSur66tnyY0T0gxAnaSfAGXy16HlL2hBoM75pEwX8xK5
	 3TjyNaK2rPbfm9vvPXcDNc6Qnb28YBeJKW6qgzbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 605/641] net: ravb: Fix dma_addr_t truncation in error case
Date: Mon, 22 Jan 2024 15:58:29 -0800
Message-ID: <20240122235837.173414355@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

[ Upstream commit e327b2372bc0f18c30433ac40be07741b59231c5 ]

In ravb_start_xmit(), ravb driver uses u32 variable to store result of
dma_map_single() call. Since ravb hardware has 32-bit address fields in
descriptors, this works properly when mapping is successful - it is
platform's job to provide mapping addresses that fit into hardware
limitations.

However, in failure case dma_map_single() returns DMA_MAPPING_ERROR
constant that is 64-bit when dma_addr_t is 64-bit. Storing this constant
in u32 leads to truncation, and further call to dma_mapping_error()
fails to notice the error.

Fix that by storing result of dma_map_single() in a dma_addr_t
variable.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8649b3e90edb..0e3731f50fc2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1949,7 +1949,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct ravb_tstamp_skb *ts_skb;
 	struct ravb_tx_desc *desc;
 	unsigned long flags;
-	u32 dma_addr;
+	dma_addr_t dma_addr;
 	void *buffer;
 	u32 entry;
 	u32 len;
-- 
2.43.0




