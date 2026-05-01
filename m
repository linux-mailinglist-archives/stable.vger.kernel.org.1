Return-Path: <stable+bounces-242442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC3mCja19Gl8DwIAu9opvQ
	(envelope-from <stable+bounces-242442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:14:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A564AD274
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E83D301E227
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94C3C277C;
	Fri,  1 May 2026 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fByLrzER"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDA3C13F0
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644837; cv=none; b=TkWvonDkpJJuVaVvZtsbcmzcaZBoa58NDef5I8kfqgmMVUZP4NPgD7YKR0Rc0KmAnm8gI3zUy91IOZs71QfC0CXrtiaYwbfdlzbIj1p2H9xe0XSdpSsKaLhQEYand+k/6nJWhKNiwAO9nT3l3UhXiwoQq6AQfho5JlDcdAFB5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644837; c=relaxed/simple;
	bh=09xIVSIOCHld7sNJ6+3WxJZmKrRnpZPPPMGuyfUUpXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYiT4qzSwK5+j7tmnJc5/ZdZ3jqtHcJRtkSE+VJYAJD7t1tMmnl2e0BxLBs5I/FRipq1mkwA9EiQBC0pMvD72N/16iJUVf33nlIurQq+DmNHqlr8f/eHS218XZ/qQJ0Cnj1LeDXNZTdSiieRW37ZD+4dPhNWsvNa8cVDxMoiRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fByLrzER; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b3eab6ec9bso36198676d6.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644834; x=1778249634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmbjUGxD1u3NABfRek7G1d5V6wG4/EqTR/sOvz6Wzxg=;
        b=fByLrzERHPfMgWyirobyM1H2k5Dsh8sXkVm1z8Cfjiid25AE5CFrypKXvTkYUjuOF3
         dGCX0Sev6iB2MgwfFLHvxlePIhX4wZQgnsdI9Eb1F44iX14U2Gc/TTB5YM6sxjCKb8TI
         tYc4tWaMEvohFFKkV0wrMJtGmScOk6txc9iyZWqdLAKq0h1JUzkiSNKavpPNUjFWEUBS
         OKVJsHoDWRdK0fJX6VYCBx8fvkb1ZNSGVRK6fIGg4Loh28+oz3IMsiSTS4ndRpZuP9r3
         1DGffyiu8kG1j4phxluZBG3awNpAfqPBp8TwqAt0eMmA4RMzSXI+PP/y3BDajxQUD3jg
         uobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644834; x=1778249634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmbjUGxD1u3NABfRek7G1d5V6wG4/EqTR/sOvz6Wzxg=;
        b=i4/hA20GBqMrAM3M1s8/4W/jR8QPREoeKEMRUEm+Qa6jQuFpvPIG0TdAdVJVGLn0M4
         wAEnbfLcv+GLWf877HgeV+//6hnqxu0k4yx2fXknB/aIHTaT70soQLaVxJ0l9d/tcWTT
         hCDfCJ/4lh2JXYknze+jRSETbinqDYI2OlJ8jzwMwy8JprMWmQF+8QDK7b8mXwsMjjck
         mQFIEEowhs0kjkmS21PVZqL3UdnVinJZpSzcZ9rTR3EAQwWqIm8CRar7nB4dAWIC2jXn
         ICvDjfSvxjPAtkCqnn3gpAd3C2S4tuSrqf6MqTxUm17uOAlAh/aoxaJz2dGjmidHMEEU
         ZU1A==
X-Forwarded-Encrypted: i=1; AFNElJ9zvyoQF5KCaOHO300Jac/+3fBnaoOsB7eMl1GMy36+Ek7a2pxaaZd1Ge9OaDdR1eiRIJxB8BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzag80J5f2wvDNqhF/BQZNsOYsj5tYpicUdxZLKrcWkd/fB+fF
	ei+arHeCRKIFKvycqz7/gZ3Vmw48fDmNlarF1W7Z1khsetmc8QEdLrhV
X-Gm-Gg: AeBDiesvCNgywnJo14xG9syJxQp8Ebq/tdS/XFnsIKIlTGR5kSUQ4+0RK83BDqG67/4
	SIMeiKpnyruGtIvZ8YPr83WE3dJxi7Hill4MEQgNMTfYo4Sw5n+b5xlJMY4WowujVM1bE2sZy/l
	3ydNT+Egz95c71ldocsbs5WyCaJfdvBVbdbEvF0qobPPDQgtFeyBp+ELZ16D3l5W407wYnqFyfy
	U5i4fnqJuIfPTzJdrVEcttJtAxYfTAYj1z9B7VuKpCpo0P7bEWZQD+tMPeBeBAjoOi4yNHy3r/K
	jk5/1DX/BE63ic++WxFnKojQDgkaxmKI3mSDirwA09y+DK2hgLuqZjzS6dGI/0t+6q5AYMbfooe
	Xr9ECjdTC/xIYyOf80cBCe3NsqEqPnhqn6DhFBKaSJV4+huHynkLF8A0OJyGazcn8E2hZh+lW+I
	TUVhQQCLQq588sWV6JF1MoYHjIiyCkUO3oqOTkg9hkk5Q+5QmtX1CvernZGVkQiU2CHu7zzyFhr
	trSPnoQCyJ6/5hSDl9SZw8W
X-Received: by 2002:ac8:5d14:0:b0:50e:18f9:b5e2 with SMTP id d75a77b69052e-5102d09af36mr91940941cf.6.1777644833795;
        Fri, 01 May 2026 07:13:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:7cf5:7b4:6072:d3b2? ([2620:10d:c091:500::3:18f8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b86535sm17194531cf.27.2026.05.01.07.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:13:53 -0700 (PDT)
Message-ID: <ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
Date: Fri, 1 May 2026 10:13:52 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in
 psp_dev_rcv()
To: David Carlier <devnexen@gmail.com>, kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, raeds@nvidia.com,
 kees@kernel.org, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260430062033.20428-1-devnexen@gmail.com>
 <20260501130046.16008-1-devnexen@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260501130046.16008-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B2A564AD274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242442-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 5/1/26 9:00 AM, David Carlier wrote:
> psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
> when psph->hdrlen indicates that the PSP header carries optional
> fields. A frame whose PSP header advertises a non-zero VC or any
> extension would therefore be silently mis-decapsulated: option bytes
> would spill into the inner packet head and downstream parsing would
> fail on a corrupted skb.
>
> Compute the full PSP header length from psph->hdrlen, pull the
> optional bytes into the linear region, and strip the whole header
> when decapsulating. Optional fields (VC, ...) are still ignored,
> just discarded with the rest of the header instead of leaking.
> crypt_offset and the VIRT flag are intentionally not validated here
> - callers know their device's PSP implementation and can decide.
>
> Both in-tree callers gate on hardware-validated PSP, so this is a
> correctness fix rather than a reachable corruption path under
> current configurations.
>
> Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
> Suggested-by: Daniel Zahka <daniel.zahka@gmail.com>


No need for the suggested tag here.


> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v1 -> v2 (per Daniel Zahka):
>    - strip the variable-length PSP header (psph->hdrlen) instead of
>      rejecting opt-bearing frames; VC/options are ignored, not refused
>    - drop the crypt_offset and PSPHDR_VERFL_VIRT checks
>    - refresh kerneldoc above psp_dev_rcv()
>    - retarget at net (was net-next)
>
>   net/psp/psp_main.c | 41 +++++++++++++++++++++++++++++++----------
>   1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 9508b6c38003..b040345d7273 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -263,15 +263,17 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
>   
>   /* Receive handler for PSP packets.
>    *
> - * Presently it accepts only already-authenticated packets and does not
> - * support optional fields, such as virtualization cookies. The caller should
> - * ensure that skb->data is pointing to the mac header, and that skb->mac_len
> - * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
> - * is not supported).
> + * Accepts only already-authenticated packets. The full PSP header is
> + * stripped according to psph->hdrlen; any optional fields it advertises
> + * (virtualization cookies, etc.) are ignored and discarded along with the
> + * rest of the header. The caller should ensure that skb->data is pointing
> + * to the mac header, and that skb->mac_len is set. This function does not
> + * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
>    */
>   int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   {
>   	int l2_hlen = 0, l3_hlen, encap;
> +	u32 psp_hdr_len;


There is a style convention in the networking subsystem that 
declarations are sorted longest to shortest from top to bottom. Let's 
maintain that here.

nit: int psp_hlen might be more consistent with the types/names of the 
other local vars.


>   	struct psp_skb_ext *pse;
>   	struct psphdr *psph;
>   	struct ethhdr *eth;
> @@ -312,18 +314,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
>   		return -EINVAL;
>   
> -	pse = skb_ext_add(skb, SKB_EXT_PSP);
> -	if (!pse)
> +	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
> +				 sizeof(struct udphdr));
> +
> +	/* Strip the full PSP header per psph->hdrlen; VC/options are pulled
> +	 * into the linear region only so they can be discarded with the
> +	 * rest of the header.
> +	 */
> +	psp_hdr_len = ((u32)psph->hdrlen + 1) * 8;


I don't believe casting psph->hdrlen to u32 is necessary for correctness 
here.


> +
> +	if (unlikely(psp_hdr_len < sizeof(struct psphdr)))
> +		return -EINVAL;
> +
> +	if (psp_hdr_len > sizeof(struct psphdr) &&
> +	    !pskb_may_pull(skb, l2_hlen + l3_hlen +
> +				sizeof(struct udphdr) + psp_hdr_len))
>   		return -EINVAL;
>   
>   	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
>   				 sizeof(struct udphdr));
> +
> +	pse = skb_ext_add(skb, SKB_EXT_PSP);
> +	if (!pse)
> +		return -EINVAL;
> +
>   	pse->spi = psph->spi;
>   	pse->dev_id = dev_id;
>   	pse->generation = generation;
>   	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
>   
> -	encap = PSP_ENCAP_HLEN;
> +	encap = sizeof(struct udphdr) + psp_hdr_len;
>   	encap += strip_icv ? PSP_TRL_SIZE : 0;
>   
>   	if (proto == htons(ETH_P_IP)) {
> @@ -340,8 +360,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
>   	}
>   
> -	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
> -	skb_pull(skb, PSP_ENCAP_HLEN);
> +	memmove(skb->data + sizeof(struct udphdr) + psp_hdr_len,
> +		skb->data, l2_hlen + l3_hlen);
> +	skb_pull(skb, sizeof(struct udphdr) + psp_hdr_len);
>   
>   	if (strip_icv)
>   		pskb_trim(skb, skb->len - PSP_TRL_SIZE);


Minor comments, but otherwise lgtm.

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


