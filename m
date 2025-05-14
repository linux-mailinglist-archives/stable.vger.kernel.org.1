Return-Path: <stable+bounces-144436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B57EAB769D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3846C8C5AFF
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4376296154;
	Wed, 14 May 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHANg0dy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CB296142
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253657; cv=none; b=BF1HKSCV7S7LpKecaOS5iTKgTWM9UAdEMdfdeuAe+UZQISHumNXmNK/XVrRu8haZ7/HM4I1xSkjkZVAhU87CaVun3Wps3wvtkzGS2mXaROcvgoCwl6Y2gNuk0FLknE+I9pxdi/fZIsgSs/6pLQDAM6MmrDwIp0DKhtIOzGj5Fgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253657; c=relaxed/simple;
	bh=GtV45dcjIAu/hlmoSCKLvTA1ELY66jjNPAOOiPYmEP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mx83E0DE4v9Q5GsxrAF7gN+eetTRdwwuy49EqS07Iw11oQyNdllCQ9HY/NzDC0PW1Jr8CIHCpT5LXo1wBeZtV8g8MHhor7X2WhRMPWvWHu1dXDLGitlLBLP8TUVDJUKhuJLeHmVpPDk17eeiViC/Sq/ziupkOPV8lR8IkIFfGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHANg0dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC3BC4CEE3;
	Wed, 14 May 2025 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253657;
	bh=GtV45dcjIAu/hlmoSCKLvTA1ELY66jjNPAOOiPYmEP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHANg0dyFtiKsnfSHEXiyvlBg8q0dbXsuOLDxBVfKffjwZq8D3VrnOaiDV22gZ24B
	 ZOvr/K/YU5O0aA9LdWfTiw7AYtCJyX8Ue1P/YUn5RLP2cfNAu/eydNesTRsCz9JbZx
	 rUw3IZVDoXgrvGuFmYsd1Pflu6ttoWY2hFuoYWfVPUELAiuJXnFrhZhafu4Np86ZgI
	 BfUDE3n4ECxzJ4bLCWzJF36Pf+9sel38xmvnIEeA5pBul9dHPO/CI8GK54WEAuDoP3
	 W3dwqADIDS9gp47UOrgfFYQwYS4cLWRUo3Vzks+CHRHQskp5YZVQiZ8GSflikUrImx
	 DzYOlMNSi9BRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] bnxt_en: Fix receive ring space parameters when XDP is active
Date: Wed, 14 May 2025 16:14:14 -0400
Message-Id: <20250514104750-efaeb21d7ed44842@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514064438.395697-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 3051a77a09dfe3022aa012071346937fdf059033

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Shravya KN<shravya.k-n@broadcom.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 84353386762a)
6.6.y | Present (different SHA1: 7f306c651fea)

Note: The patch differs from the upstream commit:
---
1:  3051a77a09dfe ! 1:  ac412781f87ea bnxt_en: Fix receive ring space parameters when XDP is active
    @@ Metadata
      ## Commit message ##
         bnxt_en: Fix receive ring space parameters when XDP is active
     
    +    [ Upstream commit 3051a77a09dfe3022aa012071346937fdf059033 ]
    +
         The MTU setting at the time an XDP multi-buffer is attached
         determines whether the aggregation ring will be used and the
         rx_skb_func handler.  This is done in bnxt_set_rx_skb_mode().
    @@ Commit message
         Signed-off-by: Michael Chan <michael.chan@broadcom.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
    +
      ## drivers/net/ethernet/broadcom/bnxt/bnxt.c ##
     @@ drivers/net/ethernet/broadcom/bnxt/bnxt.c: int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
      	struct net_device *dev = bp->dev;
    @@ drivers/net/ethernet/broadcom/bnxt/bnxt.c: int bnxt_set_rx_skb_mode(struct bnxt
     @@ drivers/net/ethernet/broadcom/bnxt/bnxt.c: static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
      		bnxt_close_nic(bp, true, false);
      
    - 	WRITE_ONCE(dev->mtu, new_mtu);
    + 	dev->mtu = new_mtu;
     +
     +	/* MTU change may change the AGG ring settings if an XDP multi-buffer
     +	 * program is attached.  We need to set the AGG rings settings and
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

