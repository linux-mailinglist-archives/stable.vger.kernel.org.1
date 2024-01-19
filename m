Return-Path: <stable+bounces-12302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A18832FB0
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3CA2842C5
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05956755;
	Fri, 19 Jan 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wkblauQB"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BE5674C
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695609; cv=none; b=Rlv4SgIyNOG1lhwrLvPlGohAnTw3oBODjL2TeMuYyst+oTSbc73kjNbtlQ5GUNcgkRzaCHZ414/M4rR7aZ8mE1Oymgd/4smroD3E5AsTrVPOq4oGVPzbLCG1JTY5EGsQiY1Fvcv+JRorBClGZv4XIi2nOHKmsCIx1rbyF0QLnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695609; c=relaxed/simple;
	bh=25mz0o82Jy3aLuCIMzS7v6P1CB8SZY2Ww2EoRgOuIJM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BeFWmM2650ezcU4P8iMARm4MYijz4DwbIwpnxJM6b3fDZYq8TqMqcsPIPdRs7/zacStcz6iIWib3+HiUiO0spzCchqeLDCM4VIEXZ3aT7OePh7+2+Qua9/Iuso5f9MfSrPWetT7tX5Ug3CvCLikhPprFxSmMelW0imym2DwVOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wkblauQB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso17524139f.0
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705695606; x=1706300406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhvriKPgl9s4lfkMPxwk9myhtKbT/z+svBvh0IYvttM=;
        b=wkblauQBv1WpcFPHlXltmDjs4AzMrWGynEz7jxaYVvAyM1wT9D7To0aA2hZTgfhuEs
         p/fAS72KRw+7vpaearSgYrbESJ+WkX+pjjlG742vAMWl+mh0U4LZVxMpTd0FC0hjH3tf
         /x9+1+dntXXu3niW7SRpnsdYNyvzDMyxF5wpXrYy721ZG5BFjNLnOxhHAIk5fPLhXKGF
         L43USWgAuo2mXyibL8ugRHL2zNnfdagR8Ks3by0KOOuBu7Ud8YP3tgdv3+Cakd8Gp6te
         NzEzV7Fu63y9edbbMUVsQsBnogExxZhOA5u8feibpCqCGzKgMeKnooHA/4E+fk1Q1qPN
         ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695606; x=1706300406;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhvriKPgl9s4lfkMPxwk9myhtKbT/z+svBvh0IYvttM=;
        b=NOU2slqdd+C/+SlyjwDJt6MXoXc3lVcFVyYmhDveG5J9oh3j8BqCj9514UMnIRa40Q
         zbnOtcLFBKawSxYF4yyTrfsWLHeGkVNtc3UTGt/OHeJwyUQqEc225UGh3Ar3SoRLCd18
         BY1hk29v39ZCO6iq35k4NdlSKRuSVpdZsgQoKqCORzNcoW1nXtENq71Hl56KlTAbW6rl
         MXC17owRXbVYOHwrgCvwNSWz/7xBQgq4CXCHCqROIQIzfnh0AFMsFuIvXcuS6wNV2bYy
         AKyYwufYLNVrtznIKRQnovJMkptkiAC0m5NH3SixeInR4dm7t+yskYM7GCtoaJZ0HrUm
         hxJw==
X-Gm-Message-State: AOJu0Yyy1Z1j0PBw4C1ANcRmy2nVt2oXkvf3nnXSfDl2dsTNHQ+/K95B
	x2YNyrZfQYySJnRydvWf9gN8Hzrx9J1xokWx8H70Z/cfHivqGmJC6o1FxWMO5C4=
X-Google-Smtp-Source: AGHT+IEIsYLEbuxrZbKbguUwtUq5ajxguzBO+wCEwjp34rxbZIksC08UPLnw9jmQ63S4RZo2RutH0Q==
X-Received: by 2002:a5d:9bd8:0:b0:7bf:7374:edd2 with SMTP id d24-20020a5d9bd8000000b007bf7374edd2mr561964ion.0.1705695606235;
        Fri, 19 Jan 2024 12:20:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k21-20020a056638141500b0046e9bc44846sm1761035jad.17.2024.01.19.12.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 12:20:05 -0800 (PST)
Message-ID: <3469483c-baf9-4df9-93ca-e5d8a1350511@kernel.dk>
Date: Fri, 19 Jan 2024 13:20:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unnecessary unlikely()
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240119163434.1357155-1-willy@infradead.org>
 <fe1f4fe8-48d8-4b09-bd50-36e8fd8e75cb@kernel.dk>
In-Reply-To: <fe1f4fe8-48d8-4b09-bd50-36e8fd8e75cb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 9:41 AM, Jens Axboe wrote:
> On 1/19/24 9:34 AM, Matthew Wilcox (Oracle) wrote:
>> Jens added unlikely() thinking that this was an error path.  It's
>> actually just the end of the iteration, so does not warrant an
>> unlikely().
> 
> This is because the previous fix (or my attempt at least) didn't do the
> i >= vcnt, it checked for an empty bio instead. Which then definitely
> did make it an error/unlikely path, but obviously this one is not.

Just out of curiosity, I did some branch profiling on just normal
operations of on my box. Of the ~900K times we hit this path,
10% of them ended up in that branch, and 90% of them did not.
While it's not an error path, that does seem rather unlikely. Sure, for
single entries, it'll be hit 50% of the time, but for most normal IO
it'd definitely be less than 50%, and as per above non-scientif
profiling, it's around 10%.

-- 
Jens Axboe


