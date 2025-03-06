Return-Path: <stable+bounces-121139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308E5A5410F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 04:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698E016D802
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252FC192D86;
	Thu,  6 Mar 2025 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgZJ70Jf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A918C332;
	Thu,  6 Mar 2025 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230716; cv=none; b=AYD/JFCp3ySF06SuSRBoOvm0grHArSslvcXsApynyBPLjbHDtpFzfPArgjKZaO26fQJ00QxKNqjB7VBPCiDtlcufR7GqunHzY+rB0Sfn9KwTfMZ8WDskKQu1hFUgUDSr0MB7BOjsEVXgrOtD6d0wmOFbcaRSiQQLXd8Tn+yKp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230716; c=relaxed/simple;
	bh=CwtArKbyGw6WAGllyene8slMtHuO2Cr0qLhI4+n5zrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P65r4xByH8tdNR8n8VkYjY2wwQjcvs9ncGNuJQnxMW88zqu7y8z4SD88v9OBKI4mUMs5qKzqnajsf3C4+UY3m/5UgIDkOw0zTB64jnAndgN3qLH3S4fh0rlbnPTINmMUM+194+kfZAxr8pxCt5PKOYpm5iuaUxkqT0461o4xGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgZJ70Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F63C4CED1;
	Thu,  6 Mar 2025 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741230714;
	bh=CwtArKbyGw6WAGllyene8slMtHuO2Cr0qLhI4+n5zrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QgZJ70Jf2j2nxmbf5ss1jrh+8T9y+h/MPdifXnt5doRpUrXcPVdibhqtgQdSdJyFX
	 IpRjJPP3S4iKEukVdiYP78BEzTL38To9ZD+xxHypakU4qKQOT9GoRGg+515Ed8wh6a
	 KvRMYT4gY0DKnF41SUO9HiOYoaqRZLQQJCpWfuYk4OCJDlDcNcs0545cSbS2t8krp8
	 VQMZ8wZMJ+64GN0nnNhn9JwmaPJauVqcpToHI2f0HCD8sX/3/1SwKbhvLoPE6Ci25T
	 HmzHHUhFM3Xmt8MwgoxdhBHAOHBTv1NuwjNi4DkUIPnIIUWl+FsmSAp3nNoYnJGs1L
	 KRAE7fgjUBT/Q==
Date: Wed, 5 Mar 2025 19:11:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v1] netmem: prevent TX of unreadable skbs
Message-ID: <20250305191153.6d899a00@kernel.org>
In-Reply-To: <20250304234924.1583687-1-almasrymina@google.com>
References: <20250304234924.1583687-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 23:49:24 +0000 Mina Almasry wrote:
> @@ -3914,6 +3914,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  
>  	skb = validate_xmit_xfrm(skb, features, again);
>  
> +	if (!skb_frags_readable(skb))
> +		goto out_kfree_skb;

I'd put this new check at the beginning rather than the end.
Feeding unreadable packets into GSO will not result in
much happiness.

