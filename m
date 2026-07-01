Return-Path: <stable+bounces-270086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zVZOAJ0RGopvAoAu9opvQ
	(envelope-from <stable+bounces-270086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 03:57:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8716E9246
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 03:57:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vf3zTw9i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270086-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270086-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F100305D98A
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3936167B;
	Wed,  1 Jul 2026 01:54:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FD361DA9
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:54:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870883; cv=none; b=dVZQxi0lSICzxTVGi8INe/N/TxPqEtAwEe9xqUzmYoDA+epaIBcRjgzx8pSQ8fGgu/5bosswyu/yCSDYRdjcOBXXKgXiqHumqHUuidwBROfmPoc55ShoRq1qBT3IHH4tZp1+GCHIvuEgLMKqxzxof6K+jnaCE+LeEH2NB4Aynuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870883; c=relaxed/simple;
	bh=oPFoD+Gy41Us98atv6JBSNlzcvWGF8SfRZGdEZUx3VE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WrclMTWM6eQA9VSoZafDSiXacOKgqY8wqj4ybhI5PohyK1DtgmqFlnkYRNZcLNCsuUUDTKkhO9NbdknYBaTD/UzvVzNvOHgOKcRcsMwuyuhngKL+Qi468zJIKUhkIwy25EzmC5Ji5UMJu9MaoFStFtWvX0aqqHxOyBTVUMU/NEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf3zTw9i; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80dc4a68e4aso1316447b3.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782870879; x=1783475679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMNxjGCrCOaavy8c2KM0YXIXOn6JcV1cFAWmlEIqhtE=;
        b=Vf3zTw9ih7sQUf1Y8jk/3l8VZVD5WU8zCynVee6uxAXBo6VWMz5k2OP3aYwrFs/l4+
         T2OVZ+ytSQmjcw8S4JM7BJR63cUpCnyKaRYoFpIA0KS1/Cfk8dB9F1N+1g26Tg37kzbI
         4YEScdIhukwc7bYPeDlDljRrYmcrxODsF40s0o6S6XribOELQTTZ51CFIbU5/rofbQ0o
         8TMFzJXm1ZdMETuWGJiYjOqrRPnzghkYC7YBvtN3TJjBTm77FMbxuP2OCiHY1r8bBppd
         3yM6vy7qr1607EFZWlEih/uAW5DdKB8EVoEN/oYW6LT+3vrubzdDfY/N8QzcWVejnvHd
         xEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782870879; x=1783475679;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMNxjGCrCOaavy8c2KM0YXIXOn6JcV1cFAWmlEIqhtE=;
        b=WKsyBBVJWnW0iL4YyqXULFshjWV7p3teyRUUkrSHfmLUkdGK43aVIpJmTOUb5FSCfx
         2y7vhkEeoKI0L/d7RFGFqI2nWFmqumritJyv41q1RnqmrqIgyO0kquDLo5xTVHVV1F4I
         968bW8au5R/7XS4XTbUuQdE1uY9bVQ/8ysrULip9ABq9P2BCP+xkpOSd7yRAwc2DIMFr
         1ihjpi58F6QRwVZKNQSi6eju/VkHKYrFIp871uMM8CjtYFpyr9+HbDIWq0WGfScEL39N
         F71FNL8sjS6QZCVhOBpROzcPROPdV/2klVD8A5EzGBs68D5eA7/N2zcQMU5LsWKw83q9
         AV8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoBGVc3mcliZXGfGmA89NiJMj7nECXmMOnvLPZkYZpZgmhM7a3e3v5rjSE2GJkLkob/ginlcZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeUA3qOobtuLmTLY7w1SNaY5MW1gjyKrV/qMrfWegZyr4d1SJ
	V+alT15JEBrJoURtJA9WCLmrnvIWo2BSsdCBWrmSFx7AMO0dCtEX0c3g
X-Gm-Gg: AfdE7ckj5pq47oyDVEdirqgzgxMovpNATjAP/+9onN9Cu9oJnE9waQVtifWBXpK8CVg
	fhWaC3xKnMfOOKUqu1FQKZrCGGetbzBUtRY+1I3hQ9oB3zGicuPQCCF5wlz9v5J4aQevdO9rvE5
	i2NRrxNpdBeNPf0fc/0ysXMo9wYdvJG0RLFFIjJrRf56NI2PBalzHAv8UugtrZQSB2S1/ebFoML
	Ce1PP0fgYDERvfNZaMO8EnSNC/hmo6bsrjcoVOxuxePZEqtwcxFxSP2rZRxBIwzL0EWiaanAQVY
	XWe8hzVOI3ujgEz3BFSdfP7CIAGec2iwzfuM7di339ZZhCcAAiJKFyuB913UD5JVma/IK9z0Yvt
	uCAyvliVh5USIWn9+inZIQzMUPocIvpRNlb1e/EyGT/RpAJ1Fvi2cFqfMmlrPqZQxdGHMTmfrn1
	tAWHVDs1h1iKtmg0+raxPMdedoG210DRxyZh1OEv56zpj4DJkecRF+C1+yOoakwmJ5ItFzmuxJx
	Ay2
X-Received: by 2002:a05:690c:9c09:b0:80c:85c6:898f with SMTP id 00721157ae682-81204145786mr27480377b3.62.1782870878859;
        Tue, 30 Jun 2026 18:54:38 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ae35a73sm2498767b3.17.2026.06.30.18.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:54:38 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:54:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 imv4bel@gmail.com, 
 alice@isovalent.com, 
 eilaimemedsnaimel@gmail.com, 
 sd@queasysnail.net, 
 steffen.klassert@secunet.com
Cc: lena.wang@mediatek.com, 
 stable@vger.kernel.org, 
 Shiming Cheng <shiming.cheng@mediatek.com>
Message-ID: <willemdebruijn.kernel.257d168c38ada@gmail.com>
In-Reply-To: <20260626084451.27699-1-shiming.cheng@mediatek.com>
References: <20260626084451.27699-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v2] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270086-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,isovalent.com,queasysnail.net,secunet.com];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:imv4bel@gmail.com,m:alice@isovalent.com,m:eilaimemedsnaimel@gmail.com,m:sd@queasysnail.net,m:steffen.klassert@secunet.com,m:lena.wang@mediatek.com,m:stable@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B8716E9246


Thanks for the fix.

There is something weird with your subject lines:

     [PATCH v2] Subject: [PATCH] net: 

> The new skb_gro_receive_list() function is missing a critical safety check
> present in the legacy skb_gro_receive() path.

, as of commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a
GSO packet.").

Please add a comment referring to this commit, as it well explains the
need for the flush.

> Specifically, it does not
> validate NAPI_GRO_CB(skb)->flush before allowing packet aggregation.
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
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
> Cc: stable@vger.kernel.org
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

