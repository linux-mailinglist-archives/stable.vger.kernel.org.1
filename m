Return-Path: <stable+bounces-50262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6A905401
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA7E1C210DD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43E17B511;
	Wed, 12 Jun 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fsFu7OOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF21E504
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199744; cv=none; b=PV7g6poQlsZKnF9IzCF2ojNcxWHeOlGNyPEEtnMIIFfMpESBK4CSjRRyU+O04gA348QaYzw/67eEa5l0KybKCsdMvljLAi73UC7jff/CsklDtjR6PIOEp7/ojl0IMzFekWIMrS/oCmiWCPPmkw1psgi2/QeJIY6EWEZf3fWbfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199744; c=relaxed/simple;
	bh=1rUNGyYPbLlHTZqrSkFtp6gIlw8YEJ9uBYcwt4mDdKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTyR60XD2hryfZU1Ec5q3n0Q5oaUIP7S/5+p4zIBqmoAqZO3pG98cKiU1BzWxBZNUqqePYorki7eTfuXHS5iibBt9eG+rZZkmfDhLzd3+m0icCM/arhOLLyoZogv6QUZwckWMZvLiiBE0EOHFQkwE3gjKLhc9Q/IY4tzRbHQV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fsFu7OOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA91C3277B;
	Wed, 12 Jun 2024 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718199744;
	bh=1rUNGyYPbLlHTZqrSkFtp6gIlw8YEJ9uBYcwt4mDdKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsFu7OOUfNfeMSvpPehduDLKCIK9q636699+KAP3Boz6E9xEypEO91N2L/2kHu/Oj
	 A3ysTJlOk4cRnDcYAi6fvSb0uvJ7g+o9plOAsdvYgnFspLaPxygr1dNCSPKTaZ5ZtN
	 dEbXbLHMiTwUb/GLuQTd0UOApcO64SzfntROQJ5E=
Date: Wed, 12 Jun 2024 15:42:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: stable@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, David Bauer <mail@david-bauer.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH stable 4.19 up to 6.8] vxlan: Fix regression when
 dropping packets due to invalid src addresses
Message-ID: <2024061213-platypus-munchkin-d553@gregkh>
References: <20240606094733.14589-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606094733.14589-1-daniel@iogearbox.net>

On Thu, Jun 06, 2024 at 11:47:33AM +0200, Daniel Borkmann wrote:
> [ Upstream commit 1cd4bc987abb2823836cbb8f887026011ccddc8a ]
> 
> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> has recently been added to vxlan mainly in the context of source
> address snooping/learning so that when it is enabled, an entry in the
> FDB is not being created for an invalid address for the corresponding
> tunnel endpoint.
> 
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
> that it passed through whichever macs were set in the L2 header. It
> turns out that this change in behavior breaks setups, for example,
> Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
> passing before the change in f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of
> vxlan packets are dropped due to vxlan_set_mac() returning false as
> source and destination macs are zero which for E/W traffic via tunnel
> is totally fine.
> 
> Fix it by only opting into the is_valid_ether_addr() check in
> vxlan_set_mac() when in fact source address snooping/learning is
> actually enabled in vxlan. This is done by moving the check into
> vxlan_snoop(). With this change, the Cilium connectivity test suite
> passes again for both tunnel flavors.
> 
> Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Bauer <mail@david-bauer.net>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reviewed-by: David Bauer <mail@david-bauer.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [ Backport note: vxlan snooping/learning not supported in 6.8 or older,
>   so commit is simply a revert. ]
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/vxlan/vxlan_core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 0a0b4a9717ce..1d0688610189 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1615,10 +1615,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
>  		return false;
>  
> -	/* Ignore packets from invalid src-address */
> -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> -		return false;
> -
>  	/* Get address from the outer IP header */
>  	if (vxlan_get_sk_family(vs) == AF_INET) {
>  		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
> -- 
> 2.34.1
> 
> 

All now queued up, thanks.

greg k-h

