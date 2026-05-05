Return-Path: <stable+bounces-244011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLb6Hayn+WnF+gIAu9opvQ
	(envelope-from <stable+bounces-244011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:17:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4944C88A7
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD60303D374
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5523EC2F7;
	Tue,  5 May 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="TNRZhxNp"
X-Original-To: stable@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC53EC2F8;
	Tue,  5 May 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968875; cv=none; b=iOnfHrWGJIxAn8OChxX2JxJ/yIn8DsiMN0EQrtyVKJkB3yEE/hT9BPwCjgdyBV/SY/FEBzhnsMlxk3jkj6zbCeJFa8pEPDsQvl3bh7+JzlicxdAMiBjW9sqPP9qtIHh6gdFdQ1pTGMdjgqeR6WBDGUbc9NuS0bZQd5rzXFYLDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968875; c=relaxed/simple;
	bh=iZPdbDhgsHrfhzEBY/9iI3/iw0mFzpoY/DwgbbNrKUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVv/qT94FbfUXiHCha2TmLEraunQPNF6VkscI2AEMKepJ3BUjXZMa+lpBoHYke+hyZxzq2K2wirCJJ3HDQ9Km23IXuyPYY0jCpp8/C22wCQnLnT9Hkkc2DDfUwsoUs0f9f2wW/CCNSHW3ccXTsY1JCidwJPmy5JeiEkQKssVGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=TNRZhxNp; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7874A100669;
	Tue,  5 May 2026 11:14:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1777968869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+iLyLh61C8aEZa/2TYtI1k4JIMZds1vZXdM5uMOUSFM=;
	b=TNRZhxNp7qK1DX6RgkPUFaSFaNfFFMP7/HzjVrbxD6UZp2EUusk6z58EGx4wvI+Kp0Nrfl
	sjoXC2eu0+mZLO8T3kbn6Vt4/MAM16diFZdpTm09RVYDVBt8sah4V3vIVIJHXlQLWL7ERY
	fGBJT98+UoeHoYNPeLn4x8pEKwJTJGV7fVtTETRncvuXa5EqhvI0Io3+NTSZP6A0j/6Vua
	Z1VUTSzomr6wBewHgkjWpOlZJ6BC7pi4U/dNYjrsz0EbESHuUZNAlmLfLT7YT0IuMHeKIG
	M8TTn2gDKgzncyb++Kk1DoxTxnROeQpCCjMG/y+UYT+DXUQ8bwDEJYxwf0EzXQ==
Message-ID: <335fad03-6113-4508-b28d-b21c7efcffe6@rulkc.org>
Date: Tue, 5 May 2026 11:14:25 +0300
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
 <87h5omqntt.fsf@bootlin.com>
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <87h5omqntt.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: EC4944C88A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nod.at,ti.com,kontron.de,kernel.org,lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244011-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[rulkc.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]


05.05.2026 11:10, Miquel Raynal wrote:
> On 05/05/2026 at 10:59:16 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>
>> 05.05.2026 10:50, Miquel Raynal wrote:
>>> Hi,
>>>
>>> On 05/05/2026 at 01:10:12 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>>>
>>> Two important typos in the commit log :-)
>>>
>>>> 'cs' here must in range [0:nanddev_ntargets).
>>>                 be                           [
>>
>> Hi, sorry, You mean?
>>
>>
>> 'cs' here must be in range [0:nanddev_ntargets]. 
> I meant [0:nanddev_ntargets[ which is the mathematical way, IIRC, to
> indicate that the last value is out of scope/excluded.
>
> [0:nanddev_ntargets] means that nanddev_ntargets is included in the
> scope of values and here since you are explicitly showing that it is
> not, it feels wrong to use that convention.


Ahh, Yes I see, just small misunderstood in math symbols:

I mean: [A:B) == [A:B[

https://wikimedia.org/api/rest_v1/media/math/render/svg/0719b1b08cdf649e735e6dab6dc7355fa37a9b21

Ok, I'll update it!

Thanks!

>
> Thanks,
> Miquèl

