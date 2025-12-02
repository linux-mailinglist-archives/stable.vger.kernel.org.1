Return-Path: <stable+bounces-198053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01467C9A97D
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 08:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3BDA4E3258
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A43054EF;
	Tue,  2 Dec 2025 07:56:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A1305E31
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662189; cv=none; b=Jp6r2JjXjHthQX0uCLc4PG2zVGEG856W6vMRK2snR6pJJU/Ly9LX3TxcJqLgPBc0ahzTg2ZF6hsCBXC7uonZiAZEAMEs3dxq4VJo2moEej/iNhvu0mnWsI9zBmRM+29TspGIPE9D7efKPUOGsfa9q0G4V+1HtY16n2zodStv6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662189; c=relaxed/simple;
	bh=irraxAI990oxPoH/HSFMcSjTISRVotKaXhb/rORTpw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMzUaKZujk5UbiiIYcTkI8LBdnaf0IWtpk/2G2dhdwBLhada7wfgGG7M58F7KNb+PrLfNq5A5UOqZf/r0vgT0NsxNMW0Vnbkug1TGwYO//wz5i/SJUEhuB2Qpg4EiRSJKueJ0WVOz3ws4UbQfD+v42Uzh8CIXb7J/WY31F0bVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5eabc5c4cf5411f0a38c85956e01ac42-20251202
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d0dc6c50-65c7-4534-891d-652e90468ade,IP:20,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.6,REQID:d0dc6c50-65c7-4534-891d-652e90468ade,IP:20,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:a9d874c,CLOUDID:039194030dede998078eec01d89f9611,BulkI
	D:2512021031260E6B9Z8S,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5eabc5c4cf5411f0a38c85956e01ac42-20251202
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 147703907; Tue, 02 Dec 2025 15:56:12 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com,  stable@vger.kernel.org,lienze@kylinos.cn
Subject: Re: [PATCH] mm/damon/core: support multiple damon_call_control
 requests
In-Reply-To: <20251202052956.987-1-sj@kernel.org> (SeongJae Park's message of
	"Mon, 1 Dec 2025 21:29:55 -0800")
References: <20251202052956.987-1-sj@kernel.org>
Date: Tue, 02 Dec 2025 15:55:56 +0800
Message-ID: <87bjkh71wz.fsf@>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi SJ,

Thanks for your review and quick reply!

On Mon, Dec 01 2025 at 09:29:55 PM -0800, SeongJae Park wrote:

<...>

> On Tue,  2 Dec 2025 10:14:07 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> The current implementation only supports repeated calls to a single
>> damon_call_control request per context.
>
> I understand "repeated calls to a single damon_call_control" means "single
> damon_call_control object having ->repeat set as true".  Let me call it "repeat
> mode damon_call_control object".
>
> This is not an intentionally designed limitation but a bug.  damon_call()
> allows callers adding multiple repeat mode damon_call_control objects per
> context.  Technically, it adds any requested damon_call_control object to the
> per-context linked list, regardless of the number of repeat mode objects on the
> list.  But, the consumer of the damon_call_control objects list,
> kdamond_call(), moves the repeat mode objects from the per-context list to a
> temporal list (repeat_controls), and then move only the first repeat mode entry
> from the temporal list to the per-context list.
>
> If there were multiple repeat mode objects in the per-context list, what
> happens to the remaining repeat mode damon_call_control objects on the temporal
> list?  Nothing.  As a result, the memory for the objects are leaked.
> Definitely this is a bug.

Thank you for the detailed explanation -- it really clarified the design
for me.

>
> Luckily there is no such multiple repeat mode damon_call() requests, so no
> upstream kernel user is exposed to the memory leak bug in real.  But the bug is
> a bug.  We should fix this.
>
>> This limitation introduces
>> inefficiencies for scenarios that require registering multiple deferred
>> operations.
>
> I'm not very convinced with the above reasoning because 1. it is not a matter
> of inefficiency but a clear memory leak bug.  2. there is no damon_call()
> callers that want to have multiple deferred operations with high efficiency, at
> the moment.  In my opinion, the above sentence is better to be just dropped.
>

Agreed.  I will rework the patch description for the next revision.

>> 
>> This patch modifies the implementation of kdamond_call() to support
>> repeated calls to multiple damon_call_control requests.
>
> This change is rquired for fixing the bug, though.
>

<...>

>
> Assuming we agree on the fact this is a fix of the bug, I think we should add
> below tags.
>
> Fixes: 43df7676e550 ("mm/damon/core: introduce repeat mode damon_call()")
> Cc: <stable@vger.kernel.org> # 6.17.x
>
>> ---
>>  mm/damon/core.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>> 
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 109b050c795a..66b5bae44f22 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2526,13 +2526,19 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>>  			list_add(&control->list, &repeat_controls);
>>  		}
>>  	}
>> -	control = list_first_entry_or_null(&repeat_controls,
>> -			struct damon_call_control, list);
>> -	if (!control || cancel)
>> -		return;
>> -	mutex_lock(&ctx->call_controls_lock);
>> -	list_add_tail(&control->list, &ctx->call_controls);
>> -	mutex_unlock(&ctx->call_controls_lock);
>> +	while (true) {
>> +		control = list_first_entry_or_null(&repeat_controls,
>> +				struct damon_call_control, list);
>> +		if (!control)
>> +			break;
>> +		/* Unlink from the repeate_controls list. */
>> +		list_del(&control->list);
>> +		if (cancel)
>> +			continue;
>> +		mutex_lock(&ctx->call_controls_lock);
>> +		list_add(&control->list, &ctx->call_controls);
>> +		mutex_unlock(&ctx->call_controls_lock);
>> +	}
>
> This looks good enough to fix the bug.
>
> Could you please resend this patch after rewording the commit message as
> appripriate for the bug fix, adding points I listed above?

Okay, I'll resend this patch shortly.

Best Regards,
Enze

<...>

