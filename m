Return-Path: <stable+bounces-169374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE5B248EA
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A861A1A25433
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DE2F83BB;
	Wed, 13 Aug 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DnEYi4qA"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19E2F7441
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086116; cv=none; b=HTHi4eSdvFwRT0AjOsXhzPaRLWkQX7OplB2B7bAElwqxDDu3NtABflwYOsM+jP0vZ2LCdiKLl2Jz0Cx7WStQv7rJ1d9z2uXaeWTTmlFXDVtMiYcH9uiPKbvYUjlzcprNrNs21DbiHh62lwfcty/MtsHDTo1ngmJzJZv/zKgDsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086116; c=relaxed/simple;
	bh=9k8L6fJfanB94bToNO5EjAwUXG9S2EmjSnJrXlbomWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=no97yTk2c//HCWQi4gVPmuPjbQ7w7sI10uLr8Q5X0xqdRQswYACOnOTJtxejHOWuT4ulIYanJsorvE8A57zpLwq69YRsXjkZxnz49UxOJefYmbYrdgoEEjSdYJWAy4sOyrDPDnm3hgFZ0iUlH/SBLJ5CPxLxx9aPh+M47Ck8oxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DnEYi4qA; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755086108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zjnoDWuos9LoWwfo1FBp8Xf8YE2eos8JTMRFVapAYis=;
	b=DnEYi4qAhS7EnR323g5r6bhiG+4rCL2Ev+RfT+87WdhmIOCpXJBPqHYlBZBDIqIODDm+TmNrlEbaPiWAH1XcuNxaA1p+yIoQ8wiK8EoQARHVnoga9QN73MyeqYhuEX2er3I6JoCixDNdB9FrFhxKrhzY8VbzRyDlW5JHbkks/W0=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlffiS6_1755086105 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 19:55:07 +0800
Message-ID: <21c69abe-b070-4f80-81be-96e73a601c2f@linux.alibaba.com>
Date: Wed, 13 Aug 2025 19:55:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 028/627] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 kernel test robot <lkp@intel.com>, "Bo Liu (OpenAnolis)"
 <liubo03@inspur.com>, Sasha Levin <sashal@kernel.org>
References: <20250812173419.303046420@linuxfoundation.org>
 <20250812173420.398660113@linuxfoundation.org>
 <d0af351b-715c-4f32-b33a-77d2459c2932@kernel.org>
 <ca432b9e-e016-4d2d-b137-79def0aaca85@kernel.org>
 <2025081346-mobilize-bobbed-5bff@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2025081346-mobilize-bobbed-5bff@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/13 16:06, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:36:10AM +0200, Jiri Slaby wrote:
>> On 13. 08. 25, 8:32, Jiri Slaby wrote:
>>> On 12. 08. 25, 19:25, Greg Kroah-Hartman wrote:
>>>> 6.16-stable review patch.  If anyone has any objections, please let
>>>> me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>>
>>>> [ Upstream commit 5e0bf36fd156b8d9b09f8481ee6daa6cdba1b064 ]
>>>>
>>>> fix build err:
>>>>    ld.lld: error: undefined symbol: crypto_req_done
>>>>      referenced by decompressor_crypto.c
>>>>          fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress)
>>>> in archive vmlinux.a
>>>>      referenced by decompressor_crypto.c
>>>>          fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress)
>>>> in archive vmlinux.a
>>>>
>>>>    ld.lld: error: undefined symbol: crypto_acomp_decompress
>>>>      referenced by decompressor_crypto.c
>>>>          fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress)
>>>> in archive vmlinux.a
>>>>
>>>>    ld.lld: error: undefined symbol: crypto_alloc_acomp
>>>>      referenced by decompressor_crypto.c
>>>>         
>>>> fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in
>>>> archive vmlinux.a
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-
>>>> lkp@intel.com/
>>>> Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using
>>>> Intel QAT")
>>>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>> Link: https://lore.kernel.org/r/20250718033039.3609-1-liubo03@inspur.com
>>>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ---
>>>>    fs/erofs/Kconfig | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>>>> index 6beeb7063871..7b26efc271ee 100644
>>>> --- a/fs/erofs/Kconfig
>>>> +++ b/fs/erofs/Kconfig
>>>> @@ -147,6 +147,8 @@ config EROFS_FS_ZIP_ZSTD
>>>>    config EROFS_FS_ZIP_ACCEL
>>>>        bool "EROFS hardware decompression support"
>>>>        depends on EROFS_FS_ZIP
>>>> +    select CRYPTO
>>>> +    select CRYPTO_DEFLATE
>>>
>>> This is not correct as it forces CRYPTO=y and CRYPTO_DEFLATE=y even if
>>> EROFS=m.
>>>
>>> The upstream is bad, not only this stable patch.
>>
>> -next is fixed by:
>>
>> commit 8f11edd645782b767ea1fc845adc30e057f25184
>> Author: Geert Uytterhoeven <geert+renesas@glider.be>
>> Date:   Wed Jul 30 14:44:49 2025 +0200
>>
>>      erofs: Do not select tristate symbols from bool symbols
>>
>> I suggest postponing this patch until the above is merged and picked too...
> 
> Thanks, I'll go drop this now.

Yes, and I will submit upstream soon so that those two patches
can be backported together.

Thanks,
Gao Xiang

> 
> greg k-h


