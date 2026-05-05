Return-Path: <stable+bounces-244115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLtzHqXZ+WnNEgMAu9opvQ
	(envelope-from <stable+bounces-244115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:51:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF424CCFDA
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 108E23049BE7
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12D39A053;
	Tue,  5 May 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="C7gmUYdu"
X-Original-To: stable@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D31335064;
	Tue,  5 May 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981596; cv=none; b=XEJOSCnjJz9UvudDy7kTQiQXgHp7BMCy+PFpOp8CztaQfTqnKV1yUDFEYGtr3wO4l/l8MzelGdLMX9EA/zD8sC4ZuRQkobCgymNIC7PryZAK8teXNr+gyhgElSlwBZ33O2ehvZPgzXRyl6BAgegX9nu13FSiHQHp+Xe0HPxdtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981596; c=relaxed/simple;
	bh=UxRNdmfsA5d8M/6N7hiMjOn/jWhQCRiFtjt0Lh88Ix4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOe3+iFG9LPYeokulDCTHthp7txIT7j88GFe0JglfJtuw0sBSAe9eZ1r+sTWss9b7XUCh8QmP+13xQWFx5tGDOTvoccrNz667J/2lOKeScb0a+iErOQJNUV/GVG+cF3GP11nsMhUtyVw9pkdtqeGbNs1HjREYG2eTVZm6wtlcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=C7gmUYdu; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62CC9100349;
	Tue,  5 May 2026 14:46:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1777981589; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ipTVLyFau41mgVvOQSWKGbXVWkfz3iY5wGZ2cVJPYA0=;
	b=C7gmUYduUnjG57CZowZ1NJDX/SVA6X6BhFhcsPOf48/f6WIJbUWSgtjSZ3ucpRQ73R5X6X
	34qlEGAaRHKTmN6oEad0XE1tktu5XKoR1fvpailDlDPuCGvvjEzPSTL24AzjoE+VTwcmQy
	q3xaqWGqJMqJvxyGbUBKBuKpgT9JPrpXy7fIYF0lhF0JlbZLnv0DkjPBQmvUlI8EnzcGBC
	diyd4jWaFq6GnLbWrx7HdG2WKARm3hOg7jIv0HzRr+JKRNUP9Co5cYgZE0+AiZ9JpcwyK0
	FKvpmCFuPfaUllRcjO5i0JTp/YlKgEiyozmWTxIfCRoxHpd8QBaPnZ2W9mu//w==
Message-ID: <e7e7b46c-70a1-48b9-a2be-57080556fb65@rulkc.org>
Date: Tue, 5 May 2026 14:46:21 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: rawnand: fix condition in 'nand_select_target()'
Content-Language: ru
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, rulkc@linuxtesting.org, oxffffaa@gmail.com,
 stable@vger.kernel.org
References: <20260504221012.1310605-1-avkrasnov@rulkc.org>
 <87mryeqoqs.fsf@bootlin.com> <57b0cc2a-6d62-405c-bfa5-68d1c46dbad9@rulkc.org>
 <87h5omqntt.fsf@bootlin.com> <335fad03-6113-4508-b28d-b21c7efcffe6@rulkc.org>
 <87bjeuqn6s.fsf@bootlin.com>
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <87bjeuqn6s.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1BF424CCFDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244115-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nod.at,ti.com,kontron.de,kernel.org,lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wikimedia.org:url,rulkc.org:email,rulkc.org:dkim,rulkc.org:mid]


05.05.2026 11:23, Miquel Raynal wrote:
> On 05/05/2026 at 11:14:25 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>
>> 05.05.2026 11:10, Miquel Raynal wrote:
>>> On 05/05/2026 at 10:59:16 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>>>
>>>> 05.05.2026 10:50, Miquel Raynal wrote:
>>>>> Hi,
>>>>>
>>>>> On 05/05/2026 at 01:10:12 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>>>>>
>>>>> Two important typos in the commit log :-)
>>>>>
>>>>>> 'cs' here must in range [0:nanddev_ntargets).
>>>>>                 be                           [
>>>> Hi, sorry, You mean?
>>>>
>>>>
>>>> 'cs' here must be in range [0:nanddev_ntargets]. 
>>> I meant [0:nanddev_ntargets[ which is the mathematical way, IIRC, to
>>> indicate that the last value is out of scope/excluded.
>>>
>>> [0:nanddev_ntargets] means that nanddev_ntargets is included in the
>>> scope of values and here since you are explicitly showing that it is
>>> not, it feels wrong to use that convention.
>>
>> Ahh, Yes I see, just small misunderstood in math symbols:
>>
>> I mean: [A:B) == [A:B[
>>
>> https://wikimedia.org/api/rest_v1/media/math/render/svg/0719b1b08cdf649e735e6dab6dc7355fa37a9b21
> Ah ok, didn't know that other convention, fine then, take the one you prefer if
> both are identical. Just add the missing "be" please!

Sure!

Thanks, Arseniy


>
> Thanks,
> Miquèl

