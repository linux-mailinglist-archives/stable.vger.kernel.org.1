Return-Path: <stable+bounces-274559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6/ncAzyjVmrw/QAAu9opvQ
	(envelope-from <stable+bounces-274559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:59:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCC758D8E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=kWKn33aL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274559-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274559-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6557C301D223
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E9429CC5;
	Tue, 14 Jul 2026 20:58:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98179429CE1
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062695; cv=none; b=q6ioGYkdPTr1VXOpyDobP7SgLUQxkQbuF2ktEbVBCL2H5uaDr0zjlJKz+TwzfFPWIXy9rHjEWYAFBu/FvTMvJZ557/wEriX881vTwg/2vuAmmajQPe9RpVg1qPuKfahywgtisCKUJOnKtOl44nOoQ3HC8fSlgmwhfX//tWrmiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062695; c=relaxed/simple;
	bh=ugFocKQNvJq5suQ2bGHSV0nqJNZHbZnZeHUn8h4L41k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiHMmoYFQ3ib8Z/j4ygUFi+tphHciUwska/IIzBYtxHP+VtZ6fUoZ7zzhPW7u8j8pE4kHEuQ79Jl10iFff9XONnAgN6yn8K9J9SB9swHhdf7hHcOGHxhSk9cZrsWicffd1cE3cZH3U2SoQelcQAGmdtOcjLpVsgKoph6q73a1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kWKn33aL; arc=none smtp.client-ip=91.218.175.179
Message-ID: <1fc10768-18c7-40f4-9287-250415c3e7a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784062680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdayDcoevcw1swGHvcsiPGuw7O5eij5Cwke7HcSMW9g=;
	b=kWKn33aLNzr3sotFHz5u2DOaBFLv4KJNytljEJAtWGkpmO//huga3KVLdteyIubYWCnn5I
	NYfCA+jPzEtAmwz6YaOvvRGJE81y6p7aEyYv2wTcfOeoPdixo88cWva/qxyesFtDzfua7i
	YEVaob3fpt7gp8wI97m5QXnyosKVcXQ=
Date: Tue, 14 Jul 2026 21:57:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] nfc: llcp: reject PDUs shorter than the LLCP
 header
To: Doruk Tan Ozturk <doruk@0sec.ai>, david@ixit.cz
Cc: horms@kernel.org, david.laight.linux@gmail.com,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260714164631.75068-1-doruk@0sec.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260714164631.75068-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274559-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:horms@kernel.org,m:david.laight.linux@gmail.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,0sec.ai:email,0sec.ai:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01FCC758D8E

On 14.07.2026 17:46, Doruk Tan Ozturk wrote:
> Every LLCP PDU begins with a two-byte header (DSAP/SSAP + PTYPE), but the
> receive path never checked that a frame is at least LLCP_HEADER_SIZE bytes
> before parsing it.
> 
> nfc_llcp_rx_skb() reads the header via nfc_llcp_ptype()/nfc_llcp_dsap()/
> nfc_llcp_ssap(), which dereference pdu->data[0] and pdu->data[1], and a
> CONNECT or CC PDU then computes
> 
> 	tlv_array_len = skb->len - LLCP_HEADER_SIZE;
> 
> as a size_t and hands it to the TLV walk. When the frame is shorter than
> the header the subtraction wraps to a huge value and the walk runs far
> past the buffer, an out-of-bounds read.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Guard the common receive choke point __nfc_llcp_recv(), shared by both the
> target (nfc_llcp_data_received()) and initiator (nfc_llcp_recv()) paths, so
> a short skb is dropped before the rx_work worker parses it. Use
> pskb_may_pull() rather than a skb->len test so the two header bytes are
> guaranteed to sit in the skb linear area even for a non-linear skb,
> matching how the sibling NCI and HCI receive paths validate their headers.
> 
> Reproduced with a KFENCE out-of-bounds read via /dev/virtual_nci on
> linux-next.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v3: use pskb_may_pull() so the guard also covers non-linear skbs and
>      guarantees the header bytes are in the linear area (David Laight).
> v2: move the guard into __nfc_llcp_recv() so both the target and
>      initiator receive paths are covered by a single check.
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index aed5fe1afef0..e3b2627cb089 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1565,6 +1565,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
>   
>   static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
>   {
> +	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>   	local->rx_pending = skb;
>   	timer_delete(&local->link_timer);
>   	schedule_work(&local->rx_work);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

