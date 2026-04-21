Return-Path: <stable+bounces-240223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE25OKy852mu/wEAu9opvQ
	(envelope-from <stable+bounces-240223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:06:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09F43E5BB
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C533062A06
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CFC3064A9;
	Tue, 21 Apr 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="uMDVrEqL"
X-Original-To: stable@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E62DCBE3;
	Tue, 21 Apr 2026 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794376; cv=none; b=W9758NBr/o/lzVJemq/vWT+JxDxjdhLeYGuyAPoTR0B2x7e7HiwlI1EwDqpu+aZ7hl31iRpGzQsoGi4WhJF6o79lNYQiASXRR2THG53AvTUwUou6Nll8z4A4vlSkHkx0B/PnnEciJ/ZnxjJJe1dH7rreDW/v+Q4tiT9MSwofV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794376; c=relaxed/simple;
	bh=dbKpdaGeOsDRsaYMe+qivHZwiee1Wrgke4iiIwsWuX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXr9KRY4bJ7n9TCeyiqrp3cnPLuICyDO5qkHU1L7mdvef8bksyuarFVhgyu+pwyy7NxERn8KmoDotAV8J0dl2+kkr5CZLb5ZOD9LV5WNqB+1q9u5LiM8JShhn82uY2cApByzqPTBCnMwlJR38uT7ENKQdQnmncTT1n8SEWq18RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=uMDVrEqL; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 660551045;
	Tue, 21 Apr 2026 19:50:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 660551045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1776793829;
	bh=gUoY7e6VWR3cECyo6qQIXb6/saGIgBLVjZvUmCe+aGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uMDVrEqLAUyB+rTiqplLh1IO9Ca2/chScoiKp7ZvQeiUv3yDpyPQFDTFcCEls47a4
	 W4Vk4uAlU0DqssiIawlRz5Z1zqCrnNuHMuGI+ar3fHdqIEvcjQuR083mL2tfuSF77A
	 fjGgBlM+RucAwdWqedF1/iBx2w4if/LirKvDgvcj1CjuwHtFX0DlocJEq4QKRgPh7V
	 YGJ9o63QK2xPmZLJOMOgUjLshBIOeOQn76SgKrGdWPgWKshcpZCPGXylbwqFjoowPN
	 SXJUllOP9+IYA4fNnS9GnQXhLMYN6a+ePsvk2hD8m/TxH56V/N1Kp1tNE4dhh9xdTs
	 NqqkTCZfnpq1A==
Message-ID: <d2a0a7ac-09bc-4773-b106-a4cfa62ec06e@uliege.be>
Date: Tue, 21 Apr 2026 19:50:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: fix seg6 lwtunnel output redirect for L2
 reduced encap mode
To: Andrea Mayer <andrea.mayer@uniroma2.it>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: anton.makarov11235@gmail.com, stefano.salsano@uniroma2.it,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260418162838.31979-1-andrea.mayer@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20260418162838.31979-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uliege.be,none];
	R_DKIM_ALLOW(-0.20)[uliege.be:s=ulg20190529];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240223-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,uniroma2.it,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@uliege.be,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uliege.be:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uliege.be:dkim,uliege.be:mid,l2encaps.red:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email]
X-Rspamd-Queue-Id: 0D09F43E5BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 18:28, Andrea Mayer wrote:
> When SEG6_IPTUN_MODE_L2ENCAP_RED (L2ENCAP_RED) was introduced, the
> condition in seg6_build_state() that excludes L2 encap modes from
> setting LWTUNNEL_STATE_OUTPUT_REDIRECT was not updated to account for
> the new mode.
> As a consequence, L2ENCAP_RED routes incorrectly trigger seg6_output()
> on the output path, where the packet is silently dropped because
> skb_mac_header_was_set() fails on L3 packets.
> 
> Extend the check to also exclude L2ENCAP_RED, consistent with L2ENCAP.
> 
> Fixes: 13f0296be8ec ("seg6: add support for SRv6 H.L2Encaps.Red behavior")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>   net/ipv6/seg6_iptunnel.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 97b50d9b1365..9b64343ebad6 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -746,7 +746,8 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>   	newts->type = LWTUNNEL_ENCAP_SEG6;
>   	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
>   
> -	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP)
> +	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP &&
> +	    tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP_RED)
>   		newts->flags |= LWTUNNEL_STATE_OUTPUT_REDIRECT;
>   
>   	newts->headroom = seg6_lwt_headroom(tuninfo);

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

