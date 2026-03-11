Return-Path: <stable+bounces-224723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM7tBZ2csWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:47:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84719267884
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CDBA3031023
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D083E276D;
	Wed, 11 Mar 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYSKz8uK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106473DFC9F
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247641; cv=none; b=uGLkeeJovjYqutYShPXkr6ysx8L00bLAj9CUJOwFRH3Yfhrfpk23jHA4ZLPhwkb7BjHaWrqHI4u4ZPPg82TfGh6MoyLh5hHkQHHx+TVBCEAttw3V24R8zBPUVnAkPxgcJJrS9hV0RBpwBw7L+Z5ESeKzlehi+J3Idlchss8yaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247641; c=relaxed/simple;
	bh=07KoFmIiZuLE0r78+cnohMeu/H1TK9ZRpKNMrm4Ua8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0dKbTzE8Cfr6KBG+9x245+evOpZuR+Tt2r0z7DuUYGaa5e0XB+WFirLJ6ekpEzmOAOgf1+JC4l+msEDMjHa/Iul1FJnMXCLZHC7V0yqsQIAV9MuvQuHFxFPxn2UOx3M41M6gpKX0lyyApnAQAlaDUS12u1hoUuyuhOwEnWpb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYSKz8uK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4671cbce626so54249b6e.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773247638; x=1773852438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yioi7HyRyHO1HEe3ML/SgM5AjwSP20V3T57RuvHWGvc=;
        b=iYSKz8uKITX9XoFTxZ/36AaSfeZpQ4D2zOKpXpfxy34WoSg+Bntu/8i2VUTG8dXEVF
         rf9ADaFB2IzpphOwLDpfbszKE1ILJs/144JTPVM8m4dWVgCuZg3oORc4e7S0MkkNrg7B
         NvxLpeYkFpoC9HLyX9Lkrg/LiZeNEGK2GJJBA+TDaKCsX1Q6eRLya2pg1ckfz5DK2h2z
         30JbfeUu97IiC2MkyDaHFbY1L8MGS6U5EKkA91QM0j4c5a2S7fi1DelcaJtcCkNnh7CN
         SS7jxzhYJH2OkK0tzKPnT8xTWymtDGwd69wBnKWCllpMhOVQbcJ+Ztv3GYsFzHeUNJfY
         eH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247638; x=1773852438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yioi7HyRyHO1HEe3ML/SgM5AjwSP20V3T57RuvHWGvc=;
        b=ADFr4r2bdnndqI/0OcnBsSF8xx+/jS9LriZROx6x1hcQNCALUXardkExFNg3N3ED+u
         mkA5fMow4W3VUTfIp6zhPIzcX99tvtIrWwC5x02FWGC/IPkyGvHhv0hgjGtcYdfVj9Te
         skw67vw85aXH1JcQnpniJCg0WIsN1BJJfC/PWAJHJdonVJZjRbuxJFFwjcZ7RRaMjkgg
         9KNy5xUOPYxJddY8dKkxlMR/fQCuwRH0QFQJkl/VhcT72Av+o+FURELCvB/XDOqQ5wdD
         ONxwrI9S7TUhiEQmWH8WXiBWKvNqYTYikbGVLKYLitpDlpIT60PbTZM3OfRcamFUqwtk
         g5/g==
X-Forwarded-Encrypted: i=1; AJvYcCVPK2sGeUsLOu/P+K7yQONYb0BmZjW1eSqiBXpeNmJm985lkCYlk2Rn9R4/9q44K+86FYs/FdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUA0gt7n1WBg2azOYH/Iobg21G7B+OgdHP1VFxf6MAt+yfF8w
	PZO/97DR2JgKo4CyqpSeSEFt3asEzxrpkw0ySXq/7hWBC7kNkWZLEb88
X-Gm-Gg: ATEYQzxfssOPkpuOIWM7oyrK6Z5ORQh1Ki7FziY4FNyk0FvvBNmZdl9X8awlLqhwK25
	pYku9FG9SvII/Bjs3SvcyzwqHVK1TTrh5EFLVhPplPnp7PO6rvNma9rVvgabODq1f9+6czsEq0k
	ad8v+C2WQSc+jvKhpnZgBEi1Xgvo3rY5qrmRiaI3pQM/Kg23sG3eWDgnKrp+fYoKXI+8uwUQ8q7
	zO/3l+wg8nAhly78F5zUofhuW/WPo1NHMEN9jpMOn/3eTm+BCKDBwnRor1dIvWTL6XP3nHFd0wO
	So+UBv9nXfq8sidsN04TeBtvVs3QXgGq86n+cY5cZTf9+7y7d0P9NWkNORectKZnqgZIMbxbZpM
	iRgh++EkQnV3o5KItDRGN46a4qCWGjjk3v7KEWRq/lOhMnOBr+M5iIap3EK2z9lhuSP9Gery1ER
	TI5ckxwb361r0NxkF1oExGXQ3AI3qI5j5IXXeN5fNEC2MNzOLtJf0NV4+o5ILLoSXp6Kmqld2up
	xojP4P6CWd0eIdxaR9OcA==
X-Received: by 2002:a05:6808:d50:b0:450:89ee:922c with SMTP id 5614622812f47-4673349d5dfmr1873647b6e.27.1773247638017;
        Wed, 11 Mar 2026 09:47:18 -0700 (PDT)
Received: from [192.168.1.228] (76-214-69-104.lightspeed.irvnca.sbcglobal.net. [76.214.69.104])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46734343f69sm1500624b6e.19.2026.03.11.09.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 09:47:17 -0700 (PDT)
Message-ID: <97a13d4f-e1ee-42f5-ab90-d6dc589ecefc@gmail.com>
Date: Wed, 11 Mar 2026 09:47:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <cover.1773140654.git.sashal@kernel.org>
 <75302bf4-3f06-4e9a-8d05-1706d60f44c6@gmail.com> <abDACatouF12XBX5@laps>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <abDACatouF12XBX5@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224723-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84719267884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/10/2026 6:06 PM, Sasha Levin wrote:
> On Tue, Mar 10, 2026 at 12:09:32PM -0700, Florian Fainelli wrote:
>> On 3/10/26 04:05, Sasha Levin wrote:
>>>
>>> This is the start of the stable review cycle for the 6.19.7 release.
>>> There are 311 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux- 
>>> stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
>>> or in the git tree and branch at:
>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux- 
>>> stable-rc.git linux-6.19.y
>>> and the diffstat can be found below.
>>>
>>> Thanks,
>>> Sasha
>>>
>>> -------------
>> perf fails to build the pmu-events for all of the freescale SoCs, I am 
>> not sure yet whether this is a build environment issue or a genuine 
>> perf build system failure:
> 
> Could you try building with a revert of b56111d7a464 ("perf jevents: Handle
> deleted JSONS in out of source builds") please?
> 

Yes that does resolve it, thanks!
-- 
Florian


