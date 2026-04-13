Return-Path: <stable+bounces-235990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNAZGObR3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971D3EB352
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB7613008272
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F1D3BD64E;
	Mon, 13 Apr 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ba49pVzo"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E730FF05;
	Mon, 13 Apr 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079327; cv=none; b=Yqj8l0qqSD/hEYmMcvXoqqOxGso0JzzHTBvRtZuLFyGsnPqz7kkbU+e/H2Pv0HwqeBzCBYgzw+I/A+VVNn+T39ZKcQj7gG9w8T/w9ynorKmUgQMhZXU3OW4fXe1OKC5rzZESNPJNMuw6K59tzl2BQNFDCyDbaobC5u0DThlUQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079327; c=relaxed/simple;
	bh=aD6WW45e+NRp9O5rCvJhTmH0sTsR1ClEPzUe3gzQylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNNTJT/TXDamv6DRW3ev2gpB9aTtMld97Ark3+8Yv5ugjmayaU6KgJgQtAA0D6vsSeY3eU/pE3Q9fQK1HGnn6iM+GnQZ0nCN4vdcA8jNWbbrwr/C0K/71tGDR+4zsHstMkSeeeWIagr5TrivTbRUCJR/sJyfzvgNxoPvDq8cET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ba49pVzo; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fvQ3S5QYkz9yR3;
	Mon, 13 Apr 2026 13:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776079316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ujTFig8ng/0GP5w6u02e5j7gKiyai90e+dKLtJdkFs=;
	b=ba49pVzoT+DpLoet5qXdX9pNRN6h4LcmnxIpQ67+Y07iStql2BIbTgr24jgSLhC60nYbYT
	+VCZomXUnIX7A+6QOhU8G9awgtVFQGZ4riMM5ZIYN6a3nREuDYA0JJhSnIW5Ww4p0Rn890
	BrLDhFC6XwSd71XzSenjH3N2iOOVEzCRWw8G2QTQYK0Yt5QEj3rPrklKOeuwJLjJaQTJIs
	Cuj3m+g/9b7hcxPZoAsG8qVytFmNLpsVCygUj7LKX2eWpLPW5gcO/eqaajNKAN4sGEHFM0
	J3zRqxnuA2c7grmcgR7Fm+I1lbhiSIUW/4Qj5QzqA5PQKyX0wUF2rkUh064c3g==
Message-ID: <22da778a-a622-46b9-be7c-948f9178e77e@mailbox.org>
Date: Mon, 13 Apr 2026 19:21:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
To: David Laight <david.laight.linux@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jreuter@yaina.de,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
 <20260412131751.0e90a053@kernel.org> <20260412220550.0f35f5ef@pumpkin>
Content-Language: en-US
From: Mashiro Chen <mashiro.chen@mailbox.org>
In-Reply-To: <20260412220550.0f35f5ef@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9888fca2716acfe2476
X-MBO-RS-META: igou1zj3j1uosk8uu1wz6rf3fon9giwe
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235990-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9971D3EB352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub, Simon

v3 has addressed the review comments on v2:
1. Add pskb_may_pull(skb, 1) before dereferencing skb->data
2. Remove the unnecessary (unsigned int) cast on fraglen
3. Fix skb leak in overflow path that kfree_skb(skb) before return 1
4. Reset ax25->fraglen = 0 after purge


P.S.:
the reassembly copy loop at ax25_in.c:75 uses 
skb_copy_from_linear_data(skbo, dst, skbo->len), which is equivalent to 
memcpy(skbo->data, dst, skbo->len).
If a queued skbo contains non-linear data, which means data_len > 0, 
this silently reads only the linear head and copies stale data for the 
remainder.
In practice, all AX.25 lower-layer drivers like mkiss and 6pack allocate 
fully linear skbs via dev_alloc_skb(), so this is not currently 
reachable, I think there should be a separated patch to fix this.

73s,
Mashiro Chen

On 4/13/26 05:05, David Laight wrote:
> On Sun, 12 Apr 2026 13:17:51 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
>
>> On Thu,  9 Apr 2026 10:50:26 +0800 Mashiro Chen wrote:
>>> Fix mirrors the identical bug fixed in NET/ROM (nr_in.c): check for
>>> overflow before adding skb->len to fraglen, and abort fragment
>>> reassembly cleanly if the limit would be exceeded.
>> Same problem as reported by Simon on the netrom patch applies here.
>>
>> nit: I don't think you need to cast ax25->fraglen to unsigned int
>> in the comparison. since it's added with skb->len it should get
>> auto-prompted to unsigned int.
> It wouldn't matter if that comparison were signed.
>
> Or change the type of ax25->fraglen to be 32bits and do the
> sanity check for overlong packets later in the code.
> I had a quick look at the header and the structure hasn't
> been size-optimised...
>
> 	David
>

