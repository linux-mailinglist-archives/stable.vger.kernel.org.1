Return-Path: <stable+bounces-19075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61184CD0B
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 15:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D21282446
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A457E596;
	Wed,  7 Feb 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kWbzYrpL"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078587E76F;
	Wed,  7 Feb 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316949; cv=none; b=RAatikpbei+FveK8ViOJkbG41G64cztUDUcgQWBJnBzU2wFGOnqrbmltzjNscgoRop9Q3x7TbAtfYQStmg4RwsUlp9QE0dDlAU6NFG9VY2EjEXrwUSpp0KCskINeHgYgSENflru/KGWtaq+jHJGhFXmOnizaUt3nsST5I3A8y6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316949; c=relaxed/simple;
	bh=I6hzrIUtnSs54OFI6AqxQ3VKJYAZEy9pH7ofba6UDdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cq8StWAH3Qj++4YT76GCr69U2/LGIzImeJqBT0CqsO2qID91AOunt3thF6cehpjUhrIs18ssnrDP63tRpTPtqn+t0NHE1LIz5SS7vhitczQaV7ACqHKXW90ikEUaI0KkKP/aUFi2F1eKTrUTlKrVfc62SxsklAxTfpVucaqbtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kWbzYrpL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDCDE47A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707316947; bh=vDYEhTFFgnork5EjOqZIfhF7OqvelUDpm60RO3y0ru4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kWbzYrpLFW+myFWvIs2Z9rxjg/F0FRxrv+fj22TH/HkA7islP9/DJdvVhwejJyCjU
	 DgO4NEOk4CDMtHAzgD/omZcI4P0NqKDP0kO4qKawcueapZWennaNtvwSdhu312Xv6U
	 OnzLZIcP2YXj5o89p3kkg4hNaFJvIpnuYV47Zzp70ggiMg3W+m1gD113Y1U/y2FB3T
	 N4IV5M6521CKFXGKc9d4JMMm/7xorFYJHjVe4WuTtAtdmkqT+N4/1sC9wwuuvTziL3
	 DJeaWc1K+dZqu4fM+vsAN2JyHtmY/2a7wJ0s5wBgKH7B1FSFl2Rj/y3ZTZgr6n7StK
	 jspaufYTTHpDA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CDCDE47A98;
	Wed,  7 Feb 2024 14:42:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, linux-doc@vger.kernel.org, Justin Forbes
 <jforbes@fedoraproject.org>, Salvatore Bonaccorso <carnil@debian.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
In-Reply-To: <bb4493e2-91bb-4238-ab77-b38b16cd2a57@oracle.com>
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
 <20240205175133.774271-2-vegard.nossum@oracle.com>
 <8734u5p5le.fsf@meer.lwn.net>
 <bb4493e2-91bb-4238-ab77-b38b16cd2a57@oracle.com>
Date: Wed, 07 Feb 2024 07:42:25 -0700
Message-ID: <87ttmknxny.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

> On 06/02/2024 23:53, Jonathan Corbet wrote:
>> Vegard Nossum <vegard.nossum@oracle.com> writes:
>>> @@ -109,7 +109,7 @@ class KernelFeat(Directive):
>>>               else:
>>>                   out_lines += line + "\n"
>>>   
>>> -        nodeList = self.nestedParse(out_lines, fname)
>>> +        nodeList = self.nestedParse(out_lines, self.arguments[0])
>>>           return nodeList
>> 
>> So I can certainly track this through to 6.8, but I feel like I'm
>> missing something:
>> 
>>   - If we have never seen a ".. FILE" line, then (as the changelog notes)
>>     no files were found to extract feature information from.  In that
>>     case, why make the self.nestedParse() call at all?  Why not just
>>     return rather than making a useless call with a random name?
>> 
>> What am I overlooking?
>
> Even if we skip the call in the error/empty case, we still need to pass
> a sensible value here in the other cases -- this value is the file that
> will be attributed by Sphinx if there is e.g. a reST syntax error in any
> of the feature files. 'fname' here is basically the last file that
> happened to be read by get_feat.pl, which is more misleading than
> self.arguments[0] IMHO.

The purpose is to point the finger at the file that actually contained
the error; are you saying that this isn't working?

Sorry if I'm being slow here,

jon

