Return-Path: <stable+bounces-262883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ri+gGC/BK2qYEQQAu9opvQ
	(envelope-from <stable+bounces-262883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 10:19:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BF677BEE
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 10:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=socionext.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262883-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262883-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22621303AF14
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0937B409;
	Fri, 12 Jun 2026 08:18:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0AD2F5485;
	Fri, 12 Jun 2026 08:17:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252280; cv=none; b=Cb2U1dNnvR+Q+CP/wRj+KFw+msgEgVPvc3jvv80nN8e+ko4+Is95dF9JxI9nBgDHbHgA54PKoCL9qECuAy4HOWL7NYeixTiD80lHg5jdY6U6MPLiPVOqRKt2R4NNtnphc6tMXLqmp037WaTLAwyTYXlZxjIi/MLwKVR1DrzoDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252280; c=relaxed/simple;
	bh=d9UZVK29jJEql6NUZAMfkQ8JdAbaLItWGUyRU5X8ztY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKRCpJNDX1se5Ctg4ml3RcioVbcWZul6JNfTSmla5bwBkIl8B8M719tulDReDVTM2QCgWK5uxmHH63JauZYePo5C5BNc/AhE8emAr2uGe5oPL9NvOk0iEmhjAtB9n1FWsGswRHRVBH0PfeoH0UOT3w+pwjAWUFEuOLTFvMgvcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Jun 2026 17:17:50 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id BDD322091480;
	Fri, 12 Jun 2026 17:17:50 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 12 Jun 2026 17:17:50 +0900
Received: from [10.212.247.31] (unknown [10.212.247.31])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 0C716107185;
	Fri, 12 Jun 2026 17:17:50 +0900 (JST)
Message-ID: <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
Date: Fri, 12 Jun 2026 17:17:49 +0900
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
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <airBmzYhnxuK_xdh@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[socionext.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,snu.ac.kr,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-262883-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1BF677BEE

Hi Mark,

On 2026/06/11 23:09, Mark Brown wrote:
> On Thu, Jun 11, 2026 at 08:31:37PM +0900, Kunihiko Hayashi wrote:
>> The driver calls devm_request_irq() before initializing the completion
>> used by the interrupt handler. Because the interrupt may occur immediately
>> after devm_request_irq(), the handler may execute before init_completion().
> 
> This doesn't apply against current code, please check and resend.

That seems a bit strange. I applied this patch to v7.0 and linux-next successfully.
Which tree did you apply to and fail?

Thank you,

---
Best Regards
Kunihiko Hayashi

