Return-Path: <stable+bounces-69696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259A95822B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD51C20CAF
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6618B496;
	Tue, 20 Aug 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k0IXrelx"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8418B493;
	Tue, 20 Aug 2024 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146042; cv=none; b=RmjN9QDN2U8NJBiDFn00B9D/YbE7fBQuphCLx4du8nFTSNrKt9RX4Ai/sghhBZ6mwuAPUKaJ0JU2K8eMp4+pvV0DK9O1Rdk4cqYecKbitumnfnRlTVY0Ru05Z1FHRkk4cqklk9kDYG3JxXfQRp88VguYdU4oHEC26iot30zfYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146042; c=relaxed/simple;
	bh=VMIkaESEWnZtDu7m61lJYnpAx8RNEOmQg402P4Akm3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeqzxFxq07VSAaMpyGnn0A+DjicsjtvQpZBp5dw8GEI2N4tUsZ5DvnkodHfBaniNHdT7alreBRh68qxn9NFchWX5nYbvhUClzazIUlafNOqvRMROVgKxdgRye6pW4tzxFsCZ71dCfe6w8NGxcfhE2eX3F/Cypn5S7jzTRDoSae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k0IXrelx; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724146035; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K/MrWzNIyumOIgtjq7Sac1rrkPi5s2Cv9Be/ma9e4Xg=;
	b=k0IXrelxmKRJmwnTssi86tnRrzrTC0XsMzQIQC45m8hpjPd9qF5456Md8lKV7+K80GriVGdl4oZdRijsMolIMBVn+PMWQvUevvOK1ORfXf3L58qMv8TYpe4qD+bwWcgFjzQpnLZ5x2WsMjpxa+yg/dJym+dVfiez1s2EywBWcGs=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDI3ajq_1724146033)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:27:14 +0800
Message-ID: <c2a0cb7c-3858-4872-9d11-f620df03d476@linux.alibaba.com>
Date: Tue, 20 Aug 2024 17:27:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
To: Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <000000000000f7b96e062018c6e3@google.com>
 <20240820084224.1362129-1-hsiangkao@linux.alibaba.com>
 <8481ec6f-9f8a-4f76-8ab7-b45e38cc8d40@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <8481ec6f-9f8a-4f76-8ab7-b45e38cc8d40@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chunhai,

On 2024/8/20 17:25, Chunhai Guo wrote:
> 在 2024/8/20 16:42, Gao Xiang 写道:
>> If z_erofs_gbuf_growsize() partially fails on a global buffer due to
>> memory allocation failure or fault injection (as reported by syzbot [1]),
>> new pages need to be freed by comparing to the existing pages to avoid
>> memory leaks.
>>
>> However, the old gbuf->pages[] array may not be large enough, which can
>> lead to null-ptr-deref or out-of-bound access.
>>
>> Fix this by checking against gbuf->nrpages in advance.
>>
>> Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
>> Cc: <stable@vger.kernel.org> # 6.10+
>> Cc: Chunhai Guo <guochunhai@vivo.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
> Reviewed-by: Chunhai Guo <guochunhai@vivo.com>

I've sent a patch to add links and reported-by.

I assume I can add your reviewed-by to that version too?

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Chunhai Guo
> 

