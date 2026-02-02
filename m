Return-Path: <stable+bounces-213029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOXlMfNVgGkd6gIAu9opvQ
	(envelope-from <stable+bounces-213029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 08:44:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99BC947E
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 08:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40F23008D0F
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B8529BD89;
	Mon,  2 Feb 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n/QYfyh2"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1A29617D
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018202; cv=none; b=mW6KEUTGdCPezL0zYk/Mdn/OkKp83uNbUcNZZ0caoxXTN/k0BKYInfntSUtAoPG6pYdYou+MCiKTmS8A27lTXUnuWWgHGkfKOksHPN6UZhq5eYoY5BhBtu12+PklXXmNg7TAshcXCaERnOBFQBVmvxNIqBQHrShnUAWNPsCkdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018202; c=relaxed/simple;
	bh=G7Ms0Rdb076S1fetXyEIkIwmDu+ivrLjNBLHbP+2rsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5pUsLMadYF7po32eIUIA4InHMwLLzopRZFVi7VBMeNl4r4gdLQRI5rtBbcC6znYbTrmMDgnfSGiAIzRYcbrCyY3EY7jw4mT7u70ffy3wR1Ats3ICn5yTTQ2aWj+aKgUwJV2SNakZHPCIyeXrWL+295NvGa1A1yuv0x0opnVjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n/QYfyh2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bef6065d-57d6-4b88-aa7e-ece766107892@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770018188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7Ms0Rdb076S1fetXyEIkIwmDu+ivrLjNBLHbP+2rsE=;
	b=n/QYfyh2o06E59isIib+1RpgCaFdFKk5mTGmQ0ehzmTDBQcbmITS0vDCpzqXtpu8vs+IYr
	c2ZF5/KKEBML2OJYZQNWZC8H5doWuUvPNfcNmNQZ+1LFayd/LwhEv3+/6EDHjxiq/A3Ext
	CpQCXDaBVEsHx3Tn0wZdPC8EMzNq15k=
Date: Mon, 2 Feb 2026 15:43:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: Correct spelling from clk_scr_i to
 clk_csr_i
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260201023619.366505-1-chenhuacai@loongson.cn>
 <524246d9-bc9b-4d65-814d-d544b53bcd0b@linux.dev>
 <CAAhV-H5T=1FefitLWSf5Qw3HEwFO0ERhefq1udae6mt9tq+ikQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAAhV-H5T=1FefitLWSf5Qw3HEwFO0ERhefq1udae6mt9tq+ikQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213029-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[si.yanteng@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: 4D99BC947E
X-Rspamd-Action: no action


在 2026/2/2 15:29, Huacai Chen 写道:
> On Mon, Feb 2, 2026 at 9:36 AM Yanteng Si <si.yanteng@linux.dev> wrote:
>>
>> 在 2026/2/1 10:36, Huacai Chen 写道:
>>> In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
>>> so correct it.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> fix tag?
>>
>> But this is just a comment, no need to backport it (I'm fine either way).
>>
>> If no fix tag, please update the subject to typo fix instead.
> Why? Is the subject line wrong?

You're absolutely right, and "typo" specifically refers to a typographical

error in written content—this patch is a correction to a comment, so using

"typo" is perfectly appropriate.


I might be misinterpreting the wording here – what I really want is to tell

exactly what a patch modifies from the subject alone, without having to

check the patch content. Maybe "correct comment" is a better fit. I know

I'm splitting hairs a bit, but I couldn't just stay silent after receiving your

patch, right?


Thanks,

Yanteng

>
> Huacai
>
>>
>> Thanks,
>>
>> Yanteng
>>
>>
>>

