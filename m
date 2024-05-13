Return-Path: <stable+bounces-43686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81EA8C4321
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6411C281974
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA7153837;
	Mon, 13 May 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDATdW8L"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9086153839
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609993; cv=none; b=ayWySovojIpXPJK0ot/2PQSqcF7qNJ6vEI5EeDamzXbApMsvLdl37k9NcN1UXGnlPYKoFbTrQI+rJkjBzuskHJ+LR1wIeHx1dGxma52d8zPD7Yn9grc9OT/3NEO2oErwlHlNCPq+v74Qw4pwvc3QSJtEI9El2q9hwO1ZvgF46Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609993; c=relaxed/simple;
	bh=FJU7JVlnZ2I6KFXxfQGxHCu4z68nM3b5Yn4fGzAvPxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIrpjNpbSmiKZOEo8NtZ6Ya0kWtJFhJ/s/Jikhs8HFhk4g/6juHRCYAz3nFZSmY6BgTZqKTuXOeo8RSzf0aGOqbFydNw92aSGYk4/62ThFc+On/uixRdGV+ihjthcEOowT0Fh2Ne1vl2mz/QwYcnMfV2SfBRmhrL0jnwTHD+mlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SDATdW8L; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so3016571f8f.0
        for <stable@vger.kernel.org>; Mon, 13 May 2024 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715609990; x=1716214790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MI8iUfIfVZxfoXyESW0UBGw+69fG9Y5Cp6pgNECHV9o=;
        b=SDATdW8LmjHcJ0C656Syill25TCJ0MlpqoSJw3okadfY+yxadDoBggBC4rNhhm1Ybl
         1Pethw505vIirvX+fucjltxfpvut5Rj7V9fGit+ATtTSRChP6RjHCGAqxYqtiSAr5ykx
         ADIisO9qWYKBZBZeU7//5gIgwlota5hkmLBqkoAIA3RG0Iu9aLK2Npf44cDzYvVwcQxv
         B6XvKT9KKYn9rsO56dWy7gVdgYehEDh1IdI4mFRezXu9bACt14A4pcU/4OurQCqy/c/6
         I5FdqWY0yafJFmQkyACvEnnq0URoWHwofsmO3TM4z9P0vXLbqeYZYHNJ6FfH91diKTfJ
         j2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715609990; x=1716214790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI8iUfIfVZxfoXyESW0UBGw+69fG9Y5Cp6pgNECHV9o=;
        b=AMlYqnU5ZIrn4DnYOgW5zXKtxeTga3Qb/hOswJHP81pfoS7ZFi6Xd8UqqBfkrXBPVb
         3cLTUEU6t3DAsYn+g9Oyod4mLhTIToTpBEwgLk9eXyLxpZvQnfnKLisNuCr9VXJU9ojj
         yNHUKDq3CEVR3ggfCpp/DwtB0sX7MkBn7RdqxKpAtT5SBZoaL5ZkY0WGrtKljItwoqhL
         z1B0VlYKsTN5qjEC/tCBuFmwqRZqgQO4WI5zI/B3oUnu4Qpwm6ZcVlLTsZ15ArFTCEVB
         cPDUpoSYqmGW5nIWGviudeapSU+bnyUj6vHsgKLyID0PSEXHAK9kTblUEONO+IJ0NFfV
         r73A==
X-Gm-Message-State: AOJu0YxxghmwrlHl54RBsSE6k9qHZb/lU1v3h4E4beRex1E2N83WUYB8
	17ZAbVMx+HfyPSMSggyUAqjMLjewhp7ArO2khgqO+H/IGZnE8GHAEYgz4bSzYHA=
X-Google-Smtp-Source: AGHT+IEmGjXn4Ig0Sh89fhQDQMEfK6tTleMxH1ooL2dUZ54OOawoGFbuGi1uo0bFgHlc6bL0B0ywGQ==
X-Received: by 2002:a05:6000:440e:b0:351:b9ea:1e17 with SMTP id ffacd0b85a97d-351b9ea27a0mr2890788f8f.7.1715609990148;
        Mon, 13 May 2024 07:19:50 -0700 (PDT)
Received: from [10.211.55.3] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf08sm11205460f8f.96.2024.05.13.07.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 07:19:49 -0700 (PDT)
Message-ID: <d4533012-bbd1-4b39-b62c-85d04d82df97@linaro.org>
Date: Mon, 13 May 2024 09:19:48 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Old commit back-port
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Alex Elder <elder@linaro.org>
Cc: stable@vger.kernel.org
References: <c655924f-7c16-46af-8d1f-e201f82328ad@linaro.org>
 <2024051337-illusion-cannot-34af@gregkh>
From: Alex Elder <alex.elder@linaro.org>
In-Reply-To: <2024051337-illusion-cannot-34af@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/24 8:01 AM, Greg KH wrote:
> On Wed, May 01, 2024 at 02:50:05PM -0500, Alex Elder wrote:
>> This commit landed in Linux v5.16, and should have been back-ported
>> to stable branches:
>>    0ac10b291bee8 arm64: dts: qcom: Fix 'interrupt-map' parent address cells
>>
>> It has three hunks, and the commit can be cherry-picked directly
>> into the 5.15.y and 5.10.y stable branches.  The first hunk fixes
>> a problem first introduced in Linux v5.2, so that hunk (only) should
>> be back-ported to v5.4.y.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>>
>> Is there anything further I need to do?  If you'd prefer I send
>> patches, I can do that also (just ask).  Thanks.
>>
>> 					-Alex
>>
>>
>> Rob's original fix in Linus' tree:
>>    0ac10b291bee8 arm64: dts: qcom: Fix 'interrupt-map' parent address cells
>> This first landed in v5.16.
>>
>> The commit that introduced the problem in the first hunk:
>>    b84dfd175c098 arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
>> This first landed in v5.2, so back-port to v5.4.y, v5.10.y, v5.15.y.
>>
>> The commit that introduced the problem in the second hunk:
>>    5c538e09cb19b arm64: dts: qcom: sdm845: Add first PCIe controller and PHY
>> This first landed in v5.7, so back-port to v5.10.y, v5.15.y
>>
>> The commit that introduced the problem in the third hunk:
>>    42ad231338c14 arm64: dts: qcom: sdm845: Add second PCIe PHY and controller
>> This first landed in v5.7 also
>>
>>
>>
> 
> I'm confused, I applied this to 5.10.y and 5.15.y now, but it did not
> apply to 5.4.y, and I did not understand the "first-third" type comments
> about hunks here, sorry.  Can you just provide a working backport for
> 5.4.y?

Yes, I will.  It might be a few days.	-Alex

> 
> thanks,
> 
> greg k-h


