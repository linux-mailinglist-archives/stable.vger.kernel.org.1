Return-Path: <stable+bounces-119858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A1A4881D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45289188A804
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8841EFF90;
	Thu, 27 Feb 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZFP/lvFL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D7234984
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682038; cv=none; b=IUqfwL7t6AiS2hmvrWAlzT7ZzJrVSqgBD1eFXxeKizh/Xx38TIuqAE6un8sfxZEu6lEUWT628yUhcQbqLeIa26BXpCL8DMJuCaaMzCJebgrZigEFlvEG/kxVH2SWn15E1eOvB9A6MmUJxEeVW7MlLHQ3BSzlQokkxYIwqwsElt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682038; c=relaxed/simple;
	bh=5SPcYAb4oPwW2TOd6VG5gIHdoNJn4lVLOkrv5u+C6Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buIcTB+abIodawiXz4LW5hSum6Jd7R7BNw0zvXyZRNikvGIShRDfHP2CeZ7OGEUQf58Z+RjhhA7QDLe7SHj7hX/bIZa3R5Rail2wG+KQ9AeJ4+ji6jCJFU05LxeLi31JB0Czzc7gUkyMyebjkGgyRLsaiiOwEcv1qED30nQuEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZFP/lvFL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e897847086so8062716d6.3
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740682035; x=1741286835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgI8ZXoxqtIF/44cBOq0qi/g6VHw9sfjjXJgPa3P4vA=;
        b=ZFP/lvFL72hYcg9DXXbbe/sqXIGpgZ7AxxOXk2+ghBlSLhflGP4UbfcQbFmj6bMII3
         Td5iolMXfPh7IKu6XLYbJiOtEwhdSNbkBm3KVexDX13hJVfdZIQAd/UXQMI6iPxwBjKH
         WXqB6LaXKyJepWfdT4EyihlQ2AZd/2vl9iSW/pF2Mn2vHdEOb5y3fiW5FgmRr6RfEwAc
         U4OTGw2knc178UT7KB3O9M9RbP2ekaGO4R9RRdBuIAzpXmRF/KSubCHS4ibA7en3aYlz
         pVGBu5LTGMIrBkXP/cVTLl1cmdUnk3Xg+aLqIrdegyeQuPqohNfF8CODiDC1oTRx2Q0n
         Bmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682035; x=1741286835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgI8ZXoxqtIF/44cBOq0qi/g6VHw9sfjjXJgPa3P4vA=;
        b=N12V4YuzHl974zo5RAVbXHJ1HTpkcmeY5NEHJF0ox25e739wjsvmkbaIyBka9x+Jh+
         uZmZer2EBXLK9JAUp1lpMc4w2WhuoEaUbvsLmUtnsGDzsGMftRUwd0hhdtQ078HzF+rk
         bWFq+WTG9EETIjrT2a1Nsz2ppOIm7reaTwvepZb5bAHc4kcaSTz4F3IghIEez1A87lV1
         Wgkc3yzc8ZUae+MeUUOsxN5GEn9YYi0Bjrik8EuLhvgfgxGz/ZRb1kS7PGcKPYLf8H4n
         3Suns+zvmrjq/mKoxjJhexkwUk1QoHqdGCIlb9ji7HoYBBTQ6k2NLadefzWeaZnlXXjy
         gqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvIyYWyt+s89jm3PK/xbTi05r1Mw3ZjTnzg799mHspckvzlLSEohlOXDG9NIA4dAaYgFM6uGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6jGMbBlFDz/N3k9YK078haxkNd7jRS1Xy7akVMweL6Sw9WHu
	K5JZRIzQKA3PhwDmiu/0zFmvS2PywKPUdXXWXCfjFq/BOPWQnLyG/v6BASjJjAY=
X-Gm-Gg: ASbGncvaZtw4g/2TyDfaYzDIKix7jx5UcPfds3+6m+o+oRFd++y3DugIz6bEx9r4LZg
	q7hNh5r5l1eUIj816Zn9Is5LdEUoFxdErHwiZTTIHlW3mKVfIL65PYnXpQxMrw/rgy01gmRdf3m
	JjKT0dqpvsVdgOIkUzX1baayskiu0AvTYIpthRS8TqGPLSKh0RouEDuUTtlw0jnnREDu7GvDjsA
	kMkLMLnVnEV0Ekq3pCBr5oGuLAHHLQzrGMpWWPzkKibh2U9u+Q07S47jm8RnPZcmGT30EAZMdOs
	d9D40gt8ngV+rAQnK6gtZErlkXfQoQtTtdkN9bd7kXb2HYdr
X-Google-Smtp-Source: AGHT+IG/nZiB295Oky1mvAJCOoNJO4stizczIvgW8MkBaBJAYiXALUtUxHKjRSqb2HBjt6oTAcvQWg==
X-Received: by 2002:a05:6214:2683:b0:6e8:a091:1a3a with SMTP id 6a1803df08f44-6e8a0d0f44bmr8676186d6.19.1740682035300;
        Thu, 27 Feb 2025 10:47:15 -0800 (PST)
Received: from [10.73.223.214] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634a8dsm12682036d6.7.2025.02.27.10.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 10:47:15 -0800 (PST)
Message-ID: <e96da1d5-db98-464a-8006-615ab086d4d2@bytedance.com>
Date: Thu, 27 Feb 2025 10:47:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 238/676] bpf, sockmap: Several fixes to
 bpf_msg_pop_data
To: Tianchen Ding <dtcccc@linux.alibaba.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org, Levi Zim <rsworktech@outlook.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20241206143653.344873888@linuxfoundation.org>
 <20241206143702.627526560@linuxfoundation.org>
 <445cf95d-b695-4e8d-b4ba-6ca0c12b1c52@linux.alibaba.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <445cf95d-b695-4e8d-b4ba-6ca0c12b1c52@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

More background about it, this patch series includes some fixes to
test_sockmap itself, and it exposes some problems in sockhash test
with SENDPAGE and ktls with SENDPAGE. This might be the reason
for the kernel crash.

The problem I observed,
1. In sockhash test, a NULL pointer kernel BUG will be reported for
nearly every cork test. More inspections are needed for
splice_to_socket.

2. txmsg_pass are not set before, and some tests are skipped. Now after
the fixes, we have some failure cases now. More fixes are needed either
for the selftest or the ktls kernel code.

More details in 
https://lore.kernel.org/all/20241024202917.3443231-1-zijianzhang@bytedance.com/


On 2/27/25 1:40 AM, Tianchen Ding wrote:
> Hi,
> 
> On 12/6/24 10:30 PM, Greg Kroah-Hartman wrote:
>> 6.6-stable review patch.  If anyone has any objections, please let me 
>> know.
>>
>> ------------------
>>
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> [ Upstream commit 5d609ba262475db450ba69b8e8a557bd768ac07a ]
>>
>> Several fixes to bpf_msg_pop_data,
>> 1. In sk_msg_shift_left, we should put_page
>> 2. if (len == 0), return early is better
>> 3. pop the entire sk_msg (last == msg->sg.size) should be supported
>> 4. Fix for the value of variable "a"
>> 5. In sk_msg_shift_left, after shifting, i has already pointed to the 
>> next
>> element. Addtional sk_msg_iter_var_next may result in BUG.
>>
>> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
>> Link: https://lore.kernel.org/r/20241106222520.527076-8- 
>> zijianzhang@bytedance.com
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> We found the kernel crashed when running kselftests (bpf/test_sockmap) 
> in kernel 6.6 LTS, which is introduced by this commit. I guess all other 
> stable kernels (containing this commit) are also affected.
> 
> Please consider backporting the following 2 commits:
> fdf478d236dc ("skmsg: Return copied bytes in sk_msg_memcopy_from_iter")
> 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> 
> Thanks.


