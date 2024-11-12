Return-Path: <stable+bounces-92842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066309C6216
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 21:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9E52841F7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F794217472;
	Tue, 12 Nov 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="xKSVHFtG"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EB21A4A7
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441809; cv=none; b=fQExzkIsrqkD6m+tDneaDUGSCFb2Kl8sMbfnsBQFkLMHOCvfjB0Emi0JS2BdwG55SWx5Es31JO8Lva34QOWiufYy2N8S9v7x6ECU6fThknMTJsCHvu/82SbM0nBsNRXunBEop3Zo2WMXtF8krfDQcpxL1OxwMHp4jMERBV/0/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441809; c=relaxed/simple;
	bh=4V+ElV7iZ7MNpOcw5Soyu9KtvCkm/qDlDKSNirfb8vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKkQWA20QDnmjWXZsofbN3j+jE9Q7WyiUMTGqfUcxXTIPj9kpeXVFC+YIkl0DToWPGHY5Q+jtU0MDODxIO5+AkjdkoVafnHkwLDaAxvTFT15JbMdap9jZN/ELCNFdSmqg59E0X55fThtxTcuIxISeX2b0Lw/u7aWkDzM79vdRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=xKSVHFtG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Xny5c4M0Mz9tGT;
	Tue, 12 Nov 2024 21:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1731441796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9PwjHXkref7LjYELDw6TCYyWgj3et7c85IEa7VdQy4=;
	b=xKSVHFtGxQnsbZ4ZxOwf0SBXpIcO421eBWdlFtKWrjuQbL0p9FT3dppR/R/Mtv96X6Eu2f
	AYXoLJfWTnhmLk/K/oVgJCSmiGExqAk/92HtVuyNTnRb1eRdPhJKKVMF1OYuXL43Jzarif
	CtLsI4hqBEEH7/2M/8ifYsHXKUPAv1d+QMJXbf+H6xqC9/YFTBr0Nqjjn9zSsqBT9w4Ckc
	IFO68AiRbvsiTVWFM6+zGFHIMtW+b+BVZV40tR3U5p8NQ+USlRRxIeb2ObMa2kkv/PjRsU
	2zwessE6us2Jph+wSfC7uEsBficf2Wup7KBNAFEi243gf2wfFIacN/in7IKRLQ==
Message-ID: <99d08ebb-9a99-40e6-b1a6-7c82b1ee1bc0@hauke-m.de>
Date: Tue, 12 Nov 2024 21:03:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: backport "udf: Allocate name buffer in directory iterator on
 heap" to 5.15
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jack@suse.com
References: <8e759d2a-423f-4e26-b4c2-098965c50f9e@hauke-m.de>
 <2024111134-empirical-snowcap-8357@gregkh>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <2024111134-empirical-snowcap-8357@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 13:57, Greg KH wrote:
> On Sun, Nov 10, 2024 at 06:36:08PM +0100, Hauke Mehrtens wrote:
>> Hi,
>>
>> I am running into this compile error in 5.15.171 in OpenWrt on 32 bit
>> systems. This problem was introduced with kernel 5.15.169.
>> ```
>> fs/udf/namei.c: In function 'udf_rename':
>> fs/udf/namei.c:878:1: error: the frame size of 1144 bytes is larger than
>> 1024 bytes [-Werror=frame-larger-than=]
>>    878 | }
>>        | ^
>> cc1: all warnings being treated as errors
>> make[2]: *** [scripts/Makefile.build:289: fs/udf/namei.o] Error 1
>> make[1]: *** [scripts/Makefile.build:552: fs/udf] Error 2
>> ```
>>
>> This is fixed by this upstream commit:
>> commit 0aba4860b0d0216a1a300484ff536171894d49d8
>> Author: Jan Kara <jack@suse.cz>
>> Date:   Tue Dec 20 12:38:45 2022 +0100
>>
>>      udf: Allocate name buffer in directory iterator on heap
>>
>>
>> Please backport this patch to 5.15 too.
>> It was already backported to kernel 6.1.
> 
> I tried to take it as-is, but it broek the build.  Can you please submit
> a tested version that actually works?
> 
> thanks,
> 
> greg k-h
Hi,

I just noticed that it does no compile on x86, I only tested it on MIPS 
and there it compiles.

I already have a fixed version will send it soon.


Hauke

