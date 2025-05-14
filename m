Return-Path: <stable+bounces-144425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D7AB7686
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E247A10BD
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB41295506;
	Wed, 14 May 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtcwC3KJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB6295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253613; cv=none; b=iblJIv6D9mY8kZu9mrbQBxfWAnKEQqvvkbVDciMcq7kuJVCqwRRjBxGiEL4jESCJ6Gp3Ok0MdfaWMCdDlt1CdAJpeD64n81lKTD/xbKjA4LiMwimVM+YOdzHZDQQUqOCZqIuv3PScvp9ZYSBYTu9VGcJCL7fCVAyFCl/ZSE4vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253613; c=relaxed/simple;
	bh=wuyaNtN5oqW6zLPoVaivCzpUSWH9e580d5El93VqVqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYv0rjZkqCG81DrGMCu+j2NmPf6lQT/aevEuI5Zv0h5FgbfvKW1NdAw/X6D8IhXrALYVv/g+CGTDhj9dD79NIrkT8syc6MqL49Tp7DyI4zi/yjlO0Qme3Rc4E6N/yURi38TUWgP8Ss6ELw18hycoudNCmavsLfZYczVrNUNb4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtcwC3KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C163C4CEE3;
	Wed, 14 May 2025 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253613;
	bh=wuyaNtN5oqW6zLPoVaivCzpUSWH9e580d5El93VqVqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtcwC3KJnvHj8MIl8586BuDPosmdWM15Kefo0nfDUqt2X1gDh9HqfG3wVTrxbY0YP
	 IghPrdYLYv/l0SsTEvYTHWN9RN28cfCs/ihsZliIJNRHUydiS6DzjjTDkBcrNE318P
	 YDoM2RmlBZDq1YInf9dlV8tAWOa4gP01wKbY16pT8Mr1WtWDvQMkVkKa1LtSPS4EU2
	 t8yDVaoIvikDHmVJXaFjq5H5MTd8MVyCyp+nNwwPCpddrGVEThClt77KFwUH7lWx6N
	 ADg5lAki8C/Mb4a71s13+FMuu1Ti9ry/5FE5BV3Rwtdfe7M4QH2kYJBJd3wl735kE+
	 Dero8GgP6Vx6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] ibmvnic: Don't reference skb after sending to VIOS
Date: Wed, 14 May 2025 16:13:30 -0400
Message-Id: <20250514085925-77276d0c2a619e04@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514115347.3492228-1-bin.lan.cn@windriver.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bdf5d13aa05ec ! 1:  3acbb072e25da ibmvnic: Don't reference skb after sending to VIOS
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
    - 	tx_buff->skb = skb;
    - 	tx_buff->index = bufidx;
    + 	tx_buff->index = index;
      	tx_buff->pool_index = queue_num;
    + 	tx_buff->last_frag = true;
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
| stable/linux-5.10.y       |  Success    |  Success   |

