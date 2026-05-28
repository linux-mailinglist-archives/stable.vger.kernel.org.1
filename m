Return-Path: <stable+bounces-255000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MMKHnpIGGr2iQgAu9opvQ
	(envelope-from <stable+bounces-255000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEA5F30C9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6AF5306B146
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F2F23F417;
	Thu, 28 May 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTzUVy0n"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2E246774
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976137; cv=none; b=Ca50tPEN8aG6MKQHxfK6EADmBoze8TV4Txq+5niROx0Ay1NoKUicBsSq1FZAYnrwuk3xSCKwrzmuu9JoNIQkmFRZGr48QOerRjHWATV+mWM3R2AR9Nq7ZG0lN33XXfPNA8igdsXrMOxj4JnYU0pfGcqg3LTM7Ns+6goQ8JDCw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976137; c=relaxed/simple;
	bh=ZMNSn8FMJhcKftTmwQAwboYvQ5sk+yuXs2A8qvrkjyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGGdyO50YsLpYbiOUGK9OcPXD5O7QPVBMem8acX0fkS7yGIELeEORdYLvU3SN2EGT5oAnAjsjylpmOwk6ll4z4832r6dx7CxuSM9JqQO7/bkvcFHzi9nhHRF5qMkMxplu4andSN+TvVsWx71sNDzG6j+VSDTUDVPGBijEEg+a1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTzUVy0n; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1447f76-0ca4-49b1-a1ba-2670dbbe5eea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779976131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1rfDTRW2cmLcCORksVjwMmc2zx0nSP0mJx5m/+xkoI=;
	b=xTzUVy0nmLvVsdNV3uG0l8Zwz58tcumtzFYVCGuh4e+HPqzDRPWokyUZt+d2aHCOfJgIGx
	+cuU+1wMFmxfeWhRqt0OqViZCFmKsBC7qLmWuGLD9aa1dTi1HuaiwF8+OxAy+kl9IAQIC1
	iCxmytlKn8DO0ZoKWjdt69JvS9tbQBU=
Date: Thu, 28 May 2026 21:48:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv4: validate ip_forward_options() option fields
 against skb tail
To: Qi Tang <tpluszz77@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, lyutoon@gmail.com, stable@vger.kernel.org
References: <20260528111204.482401-1-tpluszz77@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260528111204.482401-1-tpluszz77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-255000-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3CCEA5F30C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 7:12 PM, Qi Tang wrote:
> ip_forward_options() re-reads the RR/SRR/TS option length byte
> optptr[1] and pointer byte optptr[2] from the skb on the forwarding
> path and uses them as indexes for 4-byte writes via
> ip_rt_get_source() (and a memcmp walk in the SRR branch).
>
> __ip_options_compile() validates those bytes at parse time but stores
> only the option's offset into IPCB(skb)->opt.{rr,srr,ts}.  An nftables
> FORWARD-chain payload mutation between parse and consume can rewrite
> the bytes, driving the indexed writes out of bounds and overlapping
> skb_shared_info.  With optptr[2] mutated the write can land in
> skb_shared_info.frag_list; the next time the skb is dropped
> kfree_skb_list_reason() walks the forged list and frees an
> attacker-controlled pointer, an arbitrary-free primitive (R15 below
> is the corrupted frag_list):
>
>    BUG: unable to handle page fault for address: ffffed10195fd757
>    Oops: 0000 [#1] SMP KASAN NOPTI
>    RIP: 0010:kfree_skb_list_reason+0x167/0x5f0
>    RAX: 1ffff110195fd757 RBX: dffffc0000000000
>    R15: ffff8880cafebabe
>    CR2: ffffed10195fd757
>    Call Trace:
>     skb_release_data+0x565/0x820
>     sk_skb_reason_drop+0xc1/0x350
>     ip_rcv_core+0x7a8/0xcd0
>     ip_rcv+0x97/0x270
>     __netif_receive_skb_one_core+0x161/0x1b0
>     process_backlog+0x1c4/0x5b0
>     net_rx_action+0x934/0xfa0


The bug is real, but I'm curious what kernel version and driver you're on.
On my side the skb falls into SKB_SMALL_HEAD_CACHE_SIZE (704), so the 
linear area
is pretty long, and optptr[2] maxes out at 255, which doesn't look like 
it can reach frag_list.

May the driver use alloc_skb to allocate small liner buffer?


> Bound optptr[2] within optptr[1] before the RR and TS writes, and
> clamp the SRR walk to the bytes actually present in the skb.  Match
> the existing error handling in this function: skip the malformed
> option in place rather than returning, so the single ip_send_check()
> at the end still recomputes the checksum for any option that was
> updated earlier.
>
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>   net/ipv4/ip_options.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> index be8815ce3ac24..36a4e3cc39dd1 100644
> --- a/net/ipv4/ip_options.c
> +++ b/net/ipv4/ip_options.c
> @@ -544,18 +544,26 @@ void ip_forward_options(struct sk_buff *skb)
>   
>   	if (opt->rr_needaddr) {
>   		optptr = (unsigned char *)raw + opt->rr;
> -		ip_rt_get_source(&optptr[optptr[2]-5], skb, rt);
> -		opt->is_changed = 1;
> +		if (optptr + optptr[1] <= skb_tail_pointer(skb) &&
> +		    optptr[2] >= 5 && optptr[2] <= optptr[1] + 1) {
> +			ip_rt_get_source(&optptr[optptr[2] - 5], skb, rt);
> +			opt->is_changed = 1;
> +		}
>   	}
>   	if (opt->srr_is_hit) {
>   		int srrptr, srrspace;
>   
>   		optptr = raw + opt->srr;
>   
> -		for ( srrptr = optptr[2], srrspace = optptr[1];
> -		     srrptr <= srrspace;
> -		     srrptr += 4
> -		     ) {
> +		/* optptr[1] (option length) may have been rewritten after the
> +		 * parse-time check; if it now runs past the skb the option is
> +		 * malformed, so skip the source-route rewrite below.
> +		 */
> +		srrspace = optptr[1];
> +		if (optptr + srrspace > skb_tail_pointer(skb))
> +			srrspace = 0;
> +
> +		for (srrptr = optptr[2]; srrptr <= srrspace; srrptr += 4) {
>   			if (srrptr + 3 > srrspace)
>   				break;
>   			if (memcmp(&opt->nexthop, &optptr[srrptr-1], 4) == 0)
> @@ -572,8 +580,11 @@ void ip_forward_options(struct sk_buff *skb)
>   		}
>   		if (opt->ts_needaddr) {
>   			optptr = raw + opt->ts;
> -			ip_rt_get_source(&optptr[optptr[2]-9], skb, rt);
> -			opt->is_changed = 1;
> +			if (optptr + optptr[1] <= skb_tail_pointer(skb) &&
> +			    optptr[2] >= 9 && optptr[2] <= optptr[1] + 5) {
> +				ip_rt_get_source(&optptr[optptr[2] - 9], skb, rt);
> +				opt->is_changed = 1;
> +			}
>   		}
>   	}
>   	if (opt->is_changed) {

