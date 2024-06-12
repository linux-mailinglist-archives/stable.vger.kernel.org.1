Return-Path: <stable+bounces-50267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746699054A6
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E441C20DB4
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A117F4E5;
	Wed, 12 Jun 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YyRLDP4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N75oX6X0"
X-Original-To: stable@vger.kernel.org
Received: from wflow8-smtp.messagingengine.com (wflow8-smtp.messagingengine.com [64.147.123.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039917DE0D;
	Wed, 12 Jun 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200790; cv=none; b=Ntuawv7n2jM9qcxlf8XMEb/VYRA7D2PMGoDfdNqFSV8WSjBl2IlqNts39DJ3Nlbmal7UgqWdJXTzTTVjyJj+LdTYPXd+QvJAT2ptD1zEzbFndkmP90ixId7oqCcSLNn68VSPwaeU+wCRJ9A1E/Klrv33eqHscUMuP1/kIa0rdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200790; c=relaxed/simple;
	bh=dPBzzsXjrO07QLwWs5XXY+MPcbxXVdmIKtOrOPdSILM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi+ZmyQP6Ze9JosravXUekaxPODTqbSiGh8V4WHRZCU6iBUTCkh4+vciGtLf20VphpFLGqu3LV5U8ZqIbc3gkkyWXJAGeWfjUPVmCWPsbKGBfcBoGuuJZVXL3cInZQWeza9rh0z7kNgAYJmiXG60ibBB2ROlv2jUK/BTbroxkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YyRLDP4Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N75oX6X0; arc=none smtp.client-ip=64.147.123.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 65EB42CC0161;
	Wed, 12 Jun 2024 09:59:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 09:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718200786; x=1718207986; bh=9BYgF/XNuP
	9G9oOmTJrbZ0MguyXPGFcxh3vdPRUSBng=; b=YyRLDP4Z8IMawrXZi9v/Z4g2oM
	JQq49DEpHwIKKZuijQmjARFa9ponNcGGVYx/XwE9R3Ru/NQSNVMMXQvoiVeIMfrj
	C89mQD/kkI7kFFS7xbtXGLB07bqa0mvWB0WJG0hdHFpI+4FIMPolOYf1r5xc4PyE
	2//sic61E3RdPp6HSsPmELRIjBkWxmrhGzPgvcZ696k6nVGOVzgf6LwPD7zo1Xyg
	eVWohb1YL0TuC/DOSqEo8rFokvZ+tBxt+fLL9VImoGUENIzSNrtYlcdIxEILrV4G
	eNkBHalkEQzezXpFyGpJnXMcOJIMyS1Yn/cYZbSakdtg7MWdKkyApfMg2ZRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718200786; x=1718207986; bh=9BYgF/XNuP9G9oOmTJrbZ0MguyXP
	GFcxh3vdPRUSBng=; b=N75oX6X0ryMgblfvcQNh0AfCxUi3vAuBzzT8n8UMwz+y
	1Xn+iXseReaRHPYGkbEybtNiGj8kz12UPU/xziQfRBmNvbCFkY4TCE3Bs17tAojm
	pBnA3mc2TymAk3S86cJWi+fYthwSNQOFMGCVpbv5Gx7S+hxuTMYlbRPlLu1cVdMM
	iORglcC/PPR3KJ07aWe2Gtm/wCv3w0tgo7ZP/cjWj4ptaXsNslGaYvTYnYuxUePC
	2GYeW3stuCfXAYRGGA0B/maY+H86c0k/p+Y+itW5Ov1NUAEDEiwkmRBEOP7Xqgst
	UadVjHSGOUv6Lhxv8xY+CpXBo9L1l7mXasZBHjm37w==
X-ME-Sender: <xms:0KlpZnjmhcwnGjAyQmxDLtuNMbUboFFNCIrVFwSplYKkFpVzHtXUWQ>
    <xme:0KlpZkANqTBtA65SY6FfIj-JF6SIXOrKrUSpFRA19t7VmfI1_CSURgJDOlSCG3rdU
    zFLmswajPStNA>
X-ME-Received: <xmr:0KlpZnF8Qkjjb1BLXmeoLJxNz3-nAFa_Uma7XyB-UTbPaRB6Tv6wEiBiRxMGImOz01Luna_-WtQdmDopNT_YMs9efAWFk_1iWP4-Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:0KlpZkTuK3thDp6RJfCh6ITbYMFxSHLwV8MG8Avfg2cfXAsRo2Cn4Q>
    <xmx:0KlpZkxPucRuADSfXq-uv5Pgqu3nuAgpIaLN4EZHoU_fHLjTBBTihQ>
    <xmx:0KlpZq6nG8NjPQayvjigz6Z5K2ArZY-tkhwxHCaIsUhNzS1W5aJsLA>
    <xmx:0KlpZpxKctY5bW3nmcjCvQhle7ifdCvDlmqAJLuLlZDaVCsNc0Jkug>
    <xmx:0qlpZmphRJFzcu7Mwmd2gXniyuRTuThiN_dT_yiwjt1WsMHNT9BWUZu7>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 09:59:43 -0400 (EDT)
Date: Wed, 12 Jun 2024 15:59:39 +0200
From: Greg KH <greg@kroah.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: stable@vger.kernel.org, Qingfang Deng <qingfang.deng@siflower.com.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Ville Nuorvala <vnuorval@tcs.hut.fi>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19.y] neighbour: fix unaligned access to pneigh_entry
Message-ID: <2024061231-most-blinker-c31c@gregkh>
References: <20240605022916.247882-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605022916.247882-1-dqfext@gmail.com>

On Wed, Jun 05, 2024 at 10:29:16AM +0800, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> [ Upstream commit ed779fe4c9b5a20b4ab4fd6f3e19807445bb78c7 ]
> 
> After the blamed commit, the member key is longer 4-byte aligned. On
> platforms that do not support unaligned access, e.g., MIPS32R2 with
> unaligned_action set to 1, this will trigger a crash when accessing
> an IPv6 pneigh_entry, as the key is cast to an in6_addr pointer.
> 
> Change the type of the key to u32 to make it aligned.
> 
> Fixes: 62dd93181aaa ("[IPV6] NDISC: Set per-entry is_router flag in Proxy NA.")
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>  include/net/neighbour.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index e58ef9e338de..4c53e51f0799 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -172,7 +172,7 @@ struct pneigh_entry {
>  	possible_net_t		net;
>  	struct net_device	*dev;
>  	u8			flags;
> -	u8			key[0];
> +	u32			key[0];
>  };
>  
>  /*
> -- 
> 2.34.1
> 
> 

Now queued up, thanks.

greg k-h

