Return-Path: <stable+bounces-176413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C36B3719F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97153ABE51
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99726A0F8;
	Tue, 26 Aug 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z86GPizG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911A9476;
	Tue, 26 Aug 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230344; cv=none; b=ovQpA+IX+m8cAvwrwVk7at52MXxEotagIIVlZlTmEdxcQhK5osBEPah0j6iD/OECOugPj3d9riezqUo1ZfYPYXdkiyGTzYIIMzaY6dd7RveH2U8Ev+dePj+t/91Gkowg/e0T+x0GCYIEeB5pStq2B/h1Ho96m2dxiDn/4D/2e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230344; c=relaxed/simple;
	bh=RoS5AJ3nIL4LViJhPP9OiQzK+IyOuXHeDZrGkYUX3GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q37F2+iNtptR0l+dMatja9bniFHJlEJK8njK4oJCbgipEtJ6x3AXb4yP+4oivM8YX7HtPt3PJxE110Z6QIj0jDSQ9D+Ieu9MfIXd2UStCSZlSs+i/uohNGVHRro5/iN6Hw+Z+8BC/XBisKcB9VU9NPb6+4pIp5INwqR+C0h1wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z86GPizG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f6f367a1f0so17897185a.3;
        Tue, 26 Aug 2025 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756230341; x=1756835141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+RoA35ojaz/PgTS5ozZxmtRBovkvjsUCjkDFl9uLa84=;
        b=Z86GPizGxz6XNjSFQUhkIpExxBI8SvQE/RRLpx4FZcouW/zYB5vZFYgYnSUsuUQv6l
         Ht5HdEFON4SHjPYXEs5KJQaLzj3JSFdNn2h0CZnV6S/gOTRhgUhkqq3JYZStOGXjIGG3
         ZhzlqKWHkiurx5FeYtsRrF1ZSkALz4+VKz5vX7UgosVnzAveGkpKViVpCsdNkq+qDluZ
         kTaNwz1EirEVDurnbNBNgWUgWk5WEXrWtodCnEhaEz6ZeLlUI+82gzZnDxAZ/vTrTqVq
         O3wCtmtGpxdIz36PzSTZ23phhxdtdx5aPYZ38NdtHiGQJbKQbqytQovPZlN1I2tt5BNB
         0/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756230341; x=1756835141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RoA35ojaz/PgTS5ozZxmtRBovkvjsUCjkDFl9uLa84=;
        b=bs/VTjgCbIO+/bSaUkrzozy1hqGmePhdVEoBglTizjGBz3cQA9rbRZX4sWEnnc5ESj
         wurJBIzfafXKjlSH5O5aaFC2QOvSskcRZHlQ8CGmylDavj0sZ0w9EI1etNRz95VX52eO
         fwG+S4jgbuye9JtKLs7Uur+PYpAtqkxTZWGCRHYdzSylZNqLqE52G4IBjKjoqdR0dnl6
         aIaNnyK06tf2gMfBADmd4XzH+LrhCWyBXssrLB1CNHzUQDXGwVdkA4nU9L+8IvMODtNZ
         AKKZmjrpZPyzpmoG4tTWrLM5Sy6HQtBoJ0rUKnzsBNuXxds6n6s5W7v2QmY9LK4JdHE2
         ZMKw==
X-Forwarded-Encrypted: i=1; AJvYcCVcD0YlJo3LcdbeVLKksuaoBC8AAdRySbRAHOpaqtSiG/sxaSzsL+BbM5OHf9IBB+3M8NZzsrTFJSecrTA=@vger.kernel.org, AJvYcCXVZagP7pHHw2X74Exs4naLnxt33TavNfU+EvqrSF0KNgz1wKFY47DUW+xxlXzHzAvZVoivkV1O@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVolO4BO74NXLd/km+0OODe+x0vcemJafZQNWGjySoGA+rG6b
	EfSsxtQnyU0k7QZMsTz0l4Xp03qczt4wYnnmonNyT2hWE+eXItOMueko
X-Gm-Gg: ASbGnct3A53T1yyme9JStfWSJFv0dQtgsSiDxAB5k3/OXZ2/pYlv3TFeAXG/gR0d7HH
	17njLsesCTpFQtmM3ADmR8JUvsUHh+NlZCbi/Zl5asqbswfunQ5gSDOHsygNkVqd/pqc92A0/qn
	l7YG2tgc/bQXMOP0mKwyjsgEuNCFIGPyZ/p9LbBYDUAZ2HqbJ9S3aKfJQ2rcggY2w0B1OnG/1ag
	/NPo0b9ipnPeT2R8Y9m08bKTcehwWLl7oE7eALLcAObec28H34cd0rzTe5/bZHRAWxPBXeWsv8c
	5pw1RAr9xNfw+iJhMPFN2nhdnzfenCRsnRglr6s6FWqoIeS/gk3KTrfgOZmnn0cAW6vyL1gR2Bj
	/jjufdg5BzB8srtIhP7CM69wHB+TpubXk3QKk0BmYNCbOWkRI+Q==
X-Google-Smtp-Source: AGHT+IGW3c39mf1AgCXfHtzpioy+8KFkpzH5cUNUK0ll1A27gIebRlGFBsz8lEe/Ps4Mn4KpemR+lg==
X-Received: by 2002:a05:620a:19a2:b0:7e8:33e6:72d6 with SMTP id af79cd13be357-7ea10f53863mr2149516585a.6.1756230341085;
        Tue, 26 Aug 2025 10:45:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7eca064dff9sm682166385a.47.2025.08.26.10.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 10:45:40 -0700 (PDT)
Message-ID: <8da510a9-d705-4744-99a1-7ee78e196d13@gmail.com>
Date: Tue, 26 Aug 2025 10:45:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/482] 6.1.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250826110930.769259449@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 04:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.149 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

