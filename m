Return-Path: <stable+bounces-91494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118F9BEE3D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DEC1C24629
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B391E0B61;
	Wed,  6 Nov 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRVy/DIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61411E0496;
	Wed,  6 Nov 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898896; cv=none; b=ag3OtQoaVT1Bc1dt2BRmg21NiXHmqadGrzqtrgMCXyiBUdvcf3kYl1SAPlveFiZYk1sTEs2lHma018IGRn5nPYB7wR87YgKTF7sN0/LA7oeh5xxdOpszNd4FnjK5I9BSHq0VrNnQY/f4c8AJ85lSAYczmvRCLMGHfvXYkvLY4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898896; c=relaxed/simple;
	bh=y/ZwcQ30jn8WfaUrni9rH8aPijmUwp8aPsoE/GhhWSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpIbzSz3KtxzWdmeUW1npNlTfP0FfIJD7A2gZdq8V+b2RudWgJEgzrU9bOzkbC3VNkiawpa+u4Iuh/UQehaoeNQjsmy+k8nWhYWJRjHYQkWAZmzdFE6CdXL7e5jcWVojqH4XkIhIMXruu9hZwVGDD8qvMSpWu+LSPgponimcWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRVy/DIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BBFC4CECD;
	Wed,  6 Nov 2024 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898896;
	bh=y/ZwcQ30jn8WfaUrni9rH8aPijmUwp8aPsoE/GhhWSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRVy/DIkm3GDkVPt/l6Q9xIBcXbVowojZpCstoGu4GJjvE5h8MIX/6xrFAVMGQrBk
	 OlLAZJBeO5bKseeQEIV3KlfNexYUc3VWo0Rn4qiCALomkmS2zaH9HuEP6GTmcgAZfm
	 l+zFQoFx22L3WdARz8KP5NOj5JjODBgVHjcLAN9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Hai <wanghai38@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 393/462] net: systemport: fix potential memory leak in bcm_sysport_xmit()
Date: Wed,  6 Nov 2024 13:04:46 +0100
Message-ID: <20241106120341.233601439@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit c401ed1c709948e57945485088413e1bb5e94bd1 ]

The bcm_sysport_xmit() returns NETDEV_TX_OK without freeing skb
in case of dma_map_single() fails, add dev_kfree_skb() to fix it.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Link: https://patch.msgid.link/20241014145115.44977-1-wanghai38@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 5a2094a281e15..4db355a0c7868 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1316,6 +1316,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buff *skb,
 		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=%d)\n",
 			  skb->data, skb_len);
 		ret = NETDEV_TX_OK;
+		dev_kfree_skb_any(skb);
 		goto out;
 	}
 
-- 
2.43.0




