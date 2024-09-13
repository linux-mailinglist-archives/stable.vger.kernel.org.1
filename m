Return-Path: <stable+bounces-76113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78AE978A11
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDE82850F4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349B14A4E1;
	Fri, 13 Sep 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiSQX4Dt"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FB2F860
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259809; cv=none; b=qI/b+1ODy1L1tVInJ6Q8bDUzlAr+D2ocQJ/V5ynMAZ+OYE3PqorQL9dM3F61vewQf27BhqO+qkCRHJukrE9EWm060p2HunE6dpJ9FfAC/f+EuPI5HSUDzFOC3viiIbRsva7jOXhbdf5BfthA+zRvWmFPyIUJJLXFMuu63dFhUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259809; c=relaxed/simple;
	bh=NmHc4YF+tz/3lKV9rilHhM1j9OBqOR5PKMP4YIIkiBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOdyJrbPAnpwqqgb4b/nfHjREiHeKOJxQcSuDzzEIq9fOyrS2chwudh3A/JMonCBX/aceabCsj21mOmnrW6sEXAFNwGJyNk2HJTwJzaT4PnV7h3AuQ06WxKcl/Vi+EDCPM7HNGSX52w3mHc3fgvor3vufjWoXYi8Rx/fBGtU/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiSQX4Dt; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82aa7c3b498so80069939f.1
        for <stable@vger.kernel.org>; Fri, 13 Sep 2024 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726259807; x=1726864607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sznNtJoWgEL1wptIdIW4OqFRFz5ELoel5XGp3dpKKzs=;
        b=JiSQX4DtEXHfTqs353jyGdN+kLrEGcoVENENDz2Qy7U9F3L2ZxaT8TKLu2YEcAFrml
         3GsGdUYRegUwn1FkbBEyelkvFP1yXWHajkRE9CYWu+J+2jGTC0kXeWhuaJ+lwF2v6I3U
         ktleJdhljrEd8QChAdZlOu6WF0FtLcM3qlJ1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726259807; x=1726864607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sznNtJoWgEL1wptIdIW4OqFRFz5ELoel5XGp3dpKKzs=;
        b=dshB6v/k/vDC/3qb1B/QU/VRR/EO2TT8egx3JVNTvtRUAl9kDmq8chAROC5slUsiVu
         +7RBCiJfILRzjLbVsR22T1G2mbMGTsLa6Wlv+R7vGJkBqdg0A1lWjf3Oj1M35B/pJuAO
         ixoWLI+MmntJGiGt0AkqshR6tObvik+XNc44S7nYEBCRgNpVYUMejAnHHjkfHnhe1Wc2
         ACPbIancfnHQZbEO8ofwhqxrWvftxRTikskEqedbnzoyQWUmfZ6zH+tTh6KKKVepRvxj
         csF/HvTcRPjlQuGHZl5dfNBxjKAiHJgHSxyqAOd+YxSBEjSk9PZba08mxKb2hNy1kyHp
         sgaw==
X-Forwarded-Encrypted: i=1; AJvYcCXXFrOj0I9L8asRiA/tN94AmNVxovMCkw56r5Ai4QUq5pNH5vy0ZoQ68KyjPmmqMgfg/8k2Zbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkPOjtFnuNJ9a5hdv2cqoCAUuatbPmv588i+CV2ZrDJrFp1nS
	66XtUmuXOBFCuuHOs4g9ncSX3E8U5zpQhSYaXnKBEjJgV0HuKWVDBPn6vKNQpmays7yHS9MImIX
	C
X-Google-Smtp-Source: AGHT+IFrvZgxHhL178pRxD9rDxW1V6SMp8oTgVYKhiFyeSNUFGCsWEON+2x07cDlkOPMw/B0XrqJug==
X-Received: by 2002:a5e:9808:0:b0:82a:284c:a807 with SMTP id ca18e2360f4ac-82cfaf58631mr1240933439f.0.1726259806647;
        Fri, 13 Sep 2024 13:36:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf4e1csm44953173.20.2024.09.13.13.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 13:36:46 -0700 (PDT)
Message-ID: <e2aee448-5288-4365-8041-e3b13b1e7b64@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:36:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 2/2] selftests/kcmp: remove call to ksft_set_plan()
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 stable@vger.kernel.org
Cc: gautammenghani201@gmail.com, usama.anjum@collabora.com,
 saeed.mirzamohammadi@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240913200249.4060165-1-samasth.norway.ananda@oracle.com>
 <20240913200249.4060165-3-samasth.norway.ananda@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240913200249.4060165-3-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 14:02, Samasth Norway Ananda wrote:
> The function definition for ksft_set_plan() is not present in linux-4.19.y.
> kcmp_test selftest fails to compile because of this.
> 
> Fixes: 32b0469d13eb ("selftests/kcmp: Make the test output consistent and clear")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> Reviewed-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> ---
>   tools/testing/selftests/kcmp/kcmp_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
> index d7a8e321bb16b..60305f858c48d 100644
> --- a/tools/testing/selftests/kcmp/kcmp_test.c
> +++ b/tools/testing/selftests/kcmp/kcmp_test.c
> @@ -89,7 +89,6 @@ int main(int argc, char **argv)
>   		int ret;
>   
>   		ksft_print_header();
> -		ksft_set_plan(3);
>   
>   		fd2 = open(kpath, O_RDWR);
>   		if (fd2 < 0) {

Thank for for finding and fixing this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

