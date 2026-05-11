Return-Path: <stable+bounces-245092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFZeHgk3AWpHSAEAu9opvQ
	(envelope-from <stable+bounces-245092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 03:55:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF4507117
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 03:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A133009B38
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6523C50A;
	Mon, 11 May 2026 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKDpFQrd"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2ED23AE87
	for <stable@vger.kernel.org>; Mon, 11 May 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464505; cv=none; b=iL5CnN3wWh4TOo29qFpwqaMMA2uQwBLEu5m6g14l9yyLey6+ZnIMR9nbqi0/L7eaiPbP88u+/+eWJ4aHdCy+mhUCtIkEq/QbhEwE3zE97bYnnvyWjk0w3UgorlLAH9F2kWE74QGECVQM/jfRX6/cm74V5dz8WkqiBXRzRK5WTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464505; c=relaxed/simple;
	bh=L5+VfFmd4q0nELm8IyWO/MRLcTB5GIHfvdLH8IU4DUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPwHRo5KMLxMpc15zRP/7Qf2aPRYd5erA5X7ysBveWJZNLgtOE2DSbGl/xv1XWZEEpImTmT8bp9lM3n0ithVdoHduZWLZXBBu7E04xOPVjJ8uuw9IOLOwLEVgp59HIVPv15+dev+iatyXEwOZTIbLxYM7xti7KW+53xisYRbbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKDpFQrd; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7f242c1-5f54-4cf7-ac61-ff6e9c70394f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778464492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtJTx1y6qo++kH6bgsIbuhUTA+JODMED3RgfOsmy8z8=;
	b=qKDpFQrdYzeLhV6rzhb44PWPIqqtAYufdwqtmobtv6ztEdckB6rCFHQbfQdnYmDxTHcMr5
	PLU/UTxCrkDRSX8HKEhKqctTWZc9JoKy7Y3VIDyFLN4N1QZ/BvFaWDONLMd3o5k1PyoO85
	tFw7hrusKyCNayIozAwR2esUSm2o0jM=
Date: Mon, 11 May 2026 09:54:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Jakub Kicinski <kuba@kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, stable@vger.kernel.org
References: <af2kdW2F1gJ9U-Gg@v4bel> <20260510084520.476745b5@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260510084520.476745b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CFBF4507117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245092-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/10/26 11:45 PM, Jakub Kicinski wrote:
> On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
>>   			    sp->hdr.securityIndex != 0 &&
>> -			    skb_cloned(skb)) {
>> +			    (skb_cloned(skb) ||
>> +			     skb_has_frag_list(skb) ||
>> +			     skb_has_shared_frag(skb))) {
> We seem to be getting a lot of fixes for this issue, and this one is
> incorrect :| Writing to _any_ frags is incorrect. You have to copy
> if skb is not linear. skb_ensure_writable()


There is a issue Simon pointed [1] that triggered 
BUG_ON(skb_shared(skb)) which was fixed by commit d0d5c0cd1e71
skb_cow_data -> __pskb_pull_tail -> pskb_expand_head -> 
BUG_ON(skb_shared(skb))

I think skb_ensure_writable will also trigger such code:
skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail -> 
pskb_expand_head -> BUG_ON(skb_shared(skb))

LPE will become panic.

[1]: 
https://lore.kernel.org/netdev/20260501155806.222592-3-horms@kernel.org/



