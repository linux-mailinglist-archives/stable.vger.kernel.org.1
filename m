Return-Path: <stable+bounces-263100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v7G4FYFiL2oH/gQAu9opvQ
	(envelope-from <stable+bounces-263100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 04:25:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B534682DA8
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 04:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=socionext.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263100-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263100-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8691130028A5
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 02:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB0254AFF;
	Mon, 15 Jun 2026 02:25:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9D0244687;
	Mon, 15 Jun 2026 02:24:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490301; cv=none; b=N8pwEfrYK7oOsVcGq+dYcM4w7/M5UTc4j6svonSZbcsNJ6GyFYZkmAE0RJ9GvUpZ9/WKWWwbb79jMCnSrSdhH+dVa8rJ2YjHqszJwa9pJO2BVefaD+jcNg7qW17tllLaltJvbymnrRH0AHd7h1Xsyy02gmdXOzATK1U9xbN0yDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490301; c=relaxed/simple;
	bh=MR61lgIaKdV6p/YLuZYNVwMFQPzl3hdBc7xY85ZG7Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0ETsyyBeyRHG4gHsUpBuQU1TUvot/9BcHUKbiFYUtPwNoXaAS1CEhZlRNDFBSQXq0P+J/0Dw0hPLLxawjN+1ohVyCcw2naX6aJ8yPtrtolMTOPisfuS2hT1aYbKD4yggnnEdyC85MJiYGTA8I0lqxW+1mzaiEP7MkzmD39/ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Jun 2026 11:24:52 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 93A452068E61;
	Mon, 15 Jun 2026 11:24:52 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 15 Jun 2026 11:24:52 +0900
Received: from [10.213.138.178] (unknown [10.213.138.178])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 091D8107185;
	Mon, 15 Jun 2026 11:24:52 +0900 (JST)
Message-ID: <c18914f2-3dba-48ad-abcd-04dc3251f4c9@socionext.com>
Date: Mon, 15 Jun 2026 11:24:53 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: uniphier: Fix completion initialization order before
 devm_request_irq()
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Kyungwook Boo <bookyungwook@gmail.com>, stable@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20260611113137.139673-1-hayashi.kunihiko@socionext.com>
 <airBmzYhnxuK_xdh@sirena.co.uk>
 <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
 <aiv9j5CInFE3twZX@sirena.co.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <aiv9j5CInFE3twZX@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[socionext.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,snu.ac.kr,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-263100-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:linux-spi@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:stable@vger.kernel.org,m:mhiramat@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hayashi.kunihiko@socionext.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayashi.kunihiko@socionext.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[socionext.com:mid,socionext.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B534682DA8

Hi Mark,

On 2026/06/12 21:37, Mark Brown wrote:
> On Fri, Jun 12, 2026 at 05:17:49PM +0900, Kunihiko Hayashi wrote:
>> On 2026/06/11 23:09, Mark Brown wrote:
> 
>>> This doesn't apply against current code, please check and resend.
> 
>> That seems a bit strange. I applied this patch to v7.0 and linux-next successfully.
>> Which tree did you apply to and fail?
> 
> It applies to none of spi/for-7.1, spi/for-7.2 nor spi/for-next.

Sorry for my mistake.
I've checked the differences, so I'll resent it.

Thank you,

---
Best Regards
Kunihiko Hayashi

