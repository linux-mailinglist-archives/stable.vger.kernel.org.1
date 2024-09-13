Return-Path: <stable+bounces-76114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FC978A12
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27B41F2254D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3E34CD8;
	Fri, 13 Sep 2024 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DRNAprKS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187914831E
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259810; cv=none; b=s/dxZepvUBOexdHOVz783jVAg40DmMuV5dKU5yGpWu79eJmSIrS+bRB9s6QTXYQ4Jg8edFUkRAmpmndyewcTVarKg5vJCSqeGa3DzHrxavBMlqnIGGeDUpTvd/ERLa12Pe6p3yewfsYFX970zoS3TZF34yCwIkhpqOQNroF6sgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259810; c=relaxed/simple;
	bh=jKtw0Brni1/+iCUqpzFBjatwEiWqFozxwWCl0Dg92jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXud40PiFBVtmQlizgsyx++V8cNimTQZs3MhuC+JFpDF2YIYPUYRLyURSnrPPskmKKciqPxm/YSfPbjoTzQCBKq76rvlQEpdM2uqEw9KWpsoTO/R4pYWVEWUALAEG5+fJPgo6zL5D11cShSm60PG5oD52WJ06yYcdf3QlOqbq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DRNAprKS; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82ab349320fso103818839f.1
        for <stable@vger.kernel.org>; Fri, 13 Sep 2024 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726259808; x=1726864608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1WoLTK+YlUVcs/IjyKVz4zW4+QbadUtrtKQYYALwEM=;
        b=DRNAprKSaEeO5rJPlv5613phkSKbEaZwQdYz8OzrBl0vDW/HCktTrNvzyZ5PUgc7cE
         rqon3jEmuDgjoHnPsvPdYogoMLRiGIDQXgIyD3MRqDzQReMfqPzRoHILGedfPSQVDa4N
         XYpT5az9/6eGnxqlJvQZGImD8Kkrvut/pEY0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726259808; x=1726864608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1WoLTK+YlUVcs/IjyKVz4zW4+QbadUtrtKQYYALwEM=;
        b=QOF2CjTXFVDoDbLhydS3JXamtQ8Zcw5tG8Q1rwFp3AqXy3/EBy6cTz3DDofR3WUDRU
         7G81jYG0gRlTGYGPEeDxVTfvsA0RZ1JscbZtIK6OjdVK9mQ/FyCYUaF8mZP2MOBqQwaO
         I5nAyjdnFKHH1O17Dkxl03t5X/HzENI2mzSWncOxTQtvYD6t5y9GsGV5a/LkFmJTqOcI
         UcDNo2SS1O84M1hiudp0xb/BwebVgeg77OU2dHdANEgSsEjQvL1b8zfxP0jlJJiETnfZ
         sxf4Q1mNSpiRZbrBeQ03YqLn7kCaMrRwOwTd/SlDCqMD1O8Iic6ePVw9NUBTZ+gcQe45
         LqlA==
X-Forwarded-Encrypted: i=1; AJvYcCVphWK2T30TcI7Cf5v4QAGZjWMd2K6hibPxB6s2OYNHbihZjtOrRckAAXcci1JrKKNTsWcrofs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKnB08rz7/s8UvjX5D6QXPU8dls6ZRdEPrI0+d8WVdkD7N+P9
	IriYW9CJ4/N2WQpPn9L4ev8jqM6ntZcJlv9XQ6ShMwUBgJbbC8oeiY62YKapoZA=
X-Google-Smtp-Source: AGHT+IEQ1L0MFKR1nRMmiDLgnPh7PrK8Ke0srYPlD8+V46YSRMNcq+JiyaIknXLPqiXgRA/pBIETJw==
X-Received: by 2002:a05:6602:3429:b0:82d:96a:84f4 with SMTP id ca18e2360f4ac-82d1f8a8e0fmr824283939f.1.1726259807870;
        Fri, 13 Sep 2024 13:36:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf4e1csm44953173.20.2024.09.13.13.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 13:36:47 -0700 (PDT)
Message-ID: <4e893168-8bbe-4422-a638-fc85182f7646@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:36:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 1/2] selftests/vm: remove call to ksft_set_plan()
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 stable@vger.kernel.org
Cc: gautammenghani201@gmail.com, usama.anjum@collabora.com,
 saeed.mirzamohammadi@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240913200249.4060165-1-samasth.norway.ananda@oracle.com>
 <20240913200249.4060165-2-samasth.norway.ananda@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240913200249.4060165-2-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 14:02, Samasth Norway Ananda wrote:
> The function definition for ksft_set_plan() is not present in linux-4.19.y.
> compaction_test selftest fails to compile because of this.
> 
> Fixes: 9a21701edc41 ("selftests/mm: conform test to TAP format output")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> Reviewed-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> ---
>   tools/testing/selftests/vm/compaction_test.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
> index e056cfc487e08..e7044fa7f0b70 100644
> --- a/tools/testing/selftests/vm/compaction_test.c
> +++ b/tools/testing/selftests/vm/compaction_test.c
> @@ -183,8 +183,6 @@ int main(int argc, char **argv)
>   	if (prereq() != 0)
>   		return ksft_exit_pass();
>   
> -	ksft_set_plan(1);
> -
>   	lim.rlim_cur = RLIM_INFINITY;
>   	lim.rlim_max = RLIM_INFINITY;
>   	if (setrlimit(RLIMIT_MEMLOCK, &lim))

Thank for for finding and fixing this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

