Return-Path: <stable+bounces-268773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g795FicvPmo6BAkAu9opvQ
	(envelope-from <stable+bounces-268773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 09:49:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E75616CB11F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 09:49:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=189LUFVV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268773-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268773-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7368B30A2902
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973C302742;
	Fri, 26 Jun 2026 07:48:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13A372EC5;
	Fri, 26 Jun 2026 07:48:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460118; cv=none; b=GxnaQROH8AJCpRJkGFY/t4PAcE9D+jcn30NrTTRE75YysC0qTAyt+40hUC9zmPzHfClHU20bcO2rCF2iM/xCjpb3Um24oikwKYMft2Ij4jEyYVlV2hCL5pHHY27dMWLemijjjTDBPuKDAGm0/mGqs3Pxw0pPKZtClmfpVXvW7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460118; c=relaxed/simple;
	bh=9/wnZYGiw5BX/H48k6GHhZ2VZquIF4wcS5MnFY1QA8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9PX+d2ony88nHV4COOvaWGSxPYtLyriYywlFnalNxNp1XiLRbLKPPR1NhlxqO9ZesCR8loQdUAbxK0pTt+ErFHB8CcJGSrkqrF/08c50Q9Cztc+d5OkCt5V86RFcRJW/K/DwNWlt7g6tReiQ4Ii2kR+LnEGzrlPpK7CcshO9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=189LUFVV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAAC1F000E9;
	Fri, 26 Jun 2026 07:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782460116;
	bh=KnMOkiEFGTcRc3gnwyUBZHMnucCU3hCP7342uw+A/EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=189LUFVVzxixg/NIUmZLVKjK+/lscpy8/cjhBKk8dGSc8rX8/d9UPvhQABw6Cp6cC
	 DWPnyXE0lEIvqeosfHv1MpNHAC+hn8wxAEhHWs9oe1IF+7UZ26flcPMqhuoiufUmki
	 6QLe52WECex3aXQJ12qUv8FuS9/sGqZu4SoeffIk=
Date: Fri, 26 Jun 2026 08:47:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	willemb@google.com, imv4bel@gmail.com, alice@isovalent.com,
	eilaimemedsnaimel@gmail.com, sd@queasysnail.net,
	lena.wang@mediatek.com, stable@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
Message-ID: <2026062614-dress-rethink-c6f8@gregkh>
References: <20260626074059.25244-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626074059.25244-1-shiming.cheng@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268773-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:imv4bel@gmail.com,m:alice@isovalent.com,m:eilaimemedsnaimel@gmail.com,m:sd@queasysnail.net,m:lena.wang@mediatek.com,m:stable@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,isovalent.com,queasysnail.net,mediatek.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E75616CB11F

On Fri, Jun 26, 2026 at 03:40:59PM +0800, Shiming Cheng wrote:
> The new skb_gro_receive_list() function is missing a critical safety check
> present in the legacy skb_gro_receive() path. Specifically, it does not
> validate NAPI_GRO_CB(skb)->flush before allowing packet aggregation.
> 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Driver Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   2. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 9dc2c3cd6c11 ("net: add fraglist GRO/GSO support")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/core/gro.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..076247c1e662 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -229,7 +229,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> -	if (unlikely(p->len + skb->len >= 65536))
> +	if (unlikely(p->len + skb->len >= 65536 ||
> +		     NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;
>  
>  	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
> -- 
> 2.45.2
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

