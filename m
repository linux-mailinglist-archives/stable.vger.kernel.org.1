Return-Path: <stable+bounces-144428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605CAB768D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14A18C5D79
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCB295517;
	Wed, 14 May 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtyiH7JZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBC295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253624; cv=none; b=UyLVaY4bblyLQVlnmss8VcY0yIaO94F0nmEl7S1hvZAhszsOzZu9HtgIpBeUaEWd1fWJE+SYq9R1PQeAQzrvg4XBIPP6nFIJOypos3XF1SDTh9ayhgnoSsajsfVJhZFp+TCV0A3awyy3rPf0QcLRGmuGjlq+H53e7GjIM01gWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253624; c=relaxed/simple;
	bh=DUizavQb3/RIgCp/3o2rC0tfTSGo6OcEXiDFUwadbGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOeOuLWBbIC4jCacuUE+JlhaC/lQneVyHbAmOzmUAAEdbA7BdKPipK1BO9CVDpD3QHwUMpFFX11C79Ddo+TwZPnKYe/FoY3oKFZlIeIy7hSB0vyYmdPHTEVxJi9dgCoh5wEZG+IbwwWezCQI3xII4IRztvtSgUDY9HUrT4Yw2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtyiH7JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAABC4CEE3;
	Wed, 14 May 2025 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253624;
	bh=DUizavQb3/RIgCp/3o2rC0tfTSGo6OcEXiDFUwadbGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtyiH7JZ32QH5FXP5UD2yKWuYY5/tEuKknFaVzzxi/3dAUYmOYufKxzv3hwq0DP4e
	 z7S7FrHOqHZPHijM64e97OwcZ1k3KojmCDK+zJWTg5dIlLzxHioKemUocZcx9Uu2Di
	 15ohbi/jZ+H+fG6kvEqCE5KX+yY/yAHENct6WjkdBZE7WQyEEImtH/6S/o8DiUKC2O
	 WXqFoU6NCyS3B0SdUCUNYMN9sbPLBjnkCrkHqUk8UWDTLidHABLWfEVPT7iO9srkIq
	 7UUope7b3kW8r2Zn62X52HHarzmbZT57Xros+5WuFqWeoJtPdM4cWvg1YbUEpUKluw
	 naGiq+tWAShxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ibmvnic: Don't reference skb after sending to VIOS
Date: Wed, 14 May 2025 16:13:40 -0400
Message-Id: <20250514104333-182a7e1764848a53@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514115155.3487850-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: bdf5d13aa05ec314d4385b31ac974d6c7e0997c9

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Nick Child<nnac123@linux.ibm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 25dddd01dcc8)
6.6.y | Present (different SHA1: 093b0e5c9059)
6.1.y | Present (different SHA1: 501ac6a7e21b)

Note: The patch differs from the upstream commit:
---
1:  bdf5d13aa05ec ! 1:  a7d6d80294525 ibmvnic: Don't reference skb after sending to VIOS
    @@ Metadata
      ## Commit message ##
         ibmvnic: Don't reference skb after sending to VIOS
     
    +    [ Upstream commit bdf5d13aa05ec314d4385b31ac974d6c7e0997c9 ]
    +
         Previously, after successfully flushing the xmit buffer to VIOS,
         the tx_bytes stat was incremented by the length of the skb.
     
    @@ Commit message
         Reviewed-by: Simon Horman <horms@kernel.org>
         Link: https://patch.msgid.link/20250214155233.235559-1-nnac123@linux.ibm.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/net/ethernet/ibm/ibmvnic.c ##
     @@ drivers/net/ethernet/ibm/ibmvnic.c: static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
    @@ drivers/net/ethernet/ibm/ibmvnic.c: static netdev_tx_t ibmvnic_xmit(struct sk_bu
     +	unsigned int skblen;
      	union sub_crq tx_crq;
      	unsigned int offset;
    - 	bool use_scrq_send_direct = false;
    + 	int num_entries = 1;
     @@ drivers/net/ethernet/ibm/ibmvnic.c: static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
      	tx_buff->skb = skb;
    - 	tx_buff->index = bufidx;
    + 	tx_buff->index = index;
      	tx_buff->pool_index = queue_num;
     +	skblen = skb->len;
      
      	memset(&tx_crq, 0, sizeof(tx_crq));
      	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
     @@ drivers/net/ethernet/ibm/ibmvnic.c: static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
    - 		netif_stop_subqueue(netdev, queue_num);
      	}
      
    + 	tx_packets++;
     -	tx_bytes += skb->len;
     +	tx_bytes += skblen;
    - 	txq_trans_cond_update(txq);
    + 	txq->trans_start = jiffies;
      	ret = NETDEV_TX_OK;
      	goto out;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

