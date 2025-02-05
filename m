Return-Path: <stable+bounces-113994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A5A29C29
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA83718847B3
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A6215168;
	Wed,  5 Feb 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Q4pFByCU"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04420215067
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792477; cv=none; b=MXp/7oxD/KtfrJCBw3ZxBDtSHlO6fcwvTFmNcWs0u81gpucqDO49qmkzz/UREBuUPzWeVzJ4yzik5A3tkWaZx+dVPwh/KSJO/3oJpIkcbnDkObo7nq90W0MSg+VYUfwQGkfor5pjOPEw9QQ3mFnTVnhTq69y60v5GJb0BP4pPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792477; c=relaxed/simple;
	bh=7hYv5dIku61xxB4YYzq3uEp5CTiTbBzQk/a/gUrOKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXhQvSMFTJbai/cYxfLy2zKR+ipwXPd13SvPn9JrBMXToxLxUwAUh0X17WaA+SDtVs5VCPHtCU/hgWc41r6Bzn0uLpA5tK8YyrSexncKzykjfpEs0FiXhsQEnBos6oFn1c5nAtgcY16fuwnwlaqxYXyjyIsND8wrg6cftbm4or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Q4pFByCU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce868498d3so658055ab.3
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 13:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1738792475; x=1739397275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P496XEFyd48SqnxWvUc186zaYO6NAXCLlCQfz4QFBQ=;
        b=Q4pFByCULU1fxkpMZJNWNmBREH/VMgyDCRjR1QUT7bqO8I/dveP2cVs317ggreSIwa
         Xqy48/6KgPkeZABwZ+cq/0M4SsLZUnlHN32CqsTgbeBBRXke7kmdp6bNAHD4OvX2FQfZ
         QOu39zPW8fTGjXbj6tjUPKhkGsfGy6oV8RbJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738792475; x=1739397275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P496XEFyd48SqnxWvUc186zaYO6NAXCLlCQfz4QFBQ=;
        b=Z0KXi6eJrtQzJs/eqZf21OcTJYXQW6RINaIr8F66M+Mgsr8txNlmDcm/mbUakkfIqg
         M5fwZF0vjnviDZYOTuQu2ZtuZnS6Ag7ZlNsfO/NHJT+Zwx/gIB6IkqI9GEkqZYByrKxD
         JZ2LZuSnZPjl9A64sZhHIWvClbqBub/CQHKc1N5SNTEtip/patCPUpR0v7yF7BdGugVb
         Ibu9GX6pqTi7tqcPpZRBQtdQxfdX9ZiWG6Fr75HQZ42CuY3kFRVjFrJKHFQQiEw6c3zz
         zcP1k2y+dMojS0QTg5e3vO0CgIxMJPN+ShtdprL645RaLIjT0d2hG3GDZdFIrd0TRbix
         qo4w==
X-Gm-Message-State: AOJu0Yyl7hlXrC+sxvJipCl9yKFy1rwEzUbntTFM4Z+xFxYIDEXBnjeg
	Ts0HYZu/zCzFjVYHBmja+TNGWT746YYonqBPP2qCxT7BfWyL7qGHQoPPe4IOKg==
X-Gm-Gg: ASbGncvb3OfYFfvrmT1zNOdjBM/8HXclaCtAccymJmqGswKQ1Hz8gqV1KZZGAZKZH3Y
	vnmhigoVT06MnwqcXf/lEeB7iEoiRlLMHnoPqXkaIcR0J8IM4ArgQHq/qOoEHDYI1RsNSzq1LnC
	FZUUPZ6hDo/NHxU4y7+4vK+21YCmop3DNCPSIkxLSXvmbVbFT1HelFrAWc7dUM/iMTSo8SGlfF2
	Y3v8uWydcJznzigDIhIz0JSvZZxtl47gf98ivOwDmqrQFETyvfonObfTS/sgQLNlHfiiD30hqjN
	4UD9wKHGKfvD2zcCGFBfCy7RWc4oCMNB
X-Google-Smtp-Source: AGHT+IETeY6aK5dolIEu79iP3omSgxyhTR84StQvlNAIr8vYtLnLrdK4f/+SZ2p9/owFtG6WQwhh1w==
X-Received: by 2002:a05:6e02:1542:b0:3d0:235b:4810 with SMTP id e9e14a558f8ab-3d04f403570mr46060005ab.2.1738792475025;
        Wed, 05 Feb 2025 13:54:35 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d0505dec79sm5502915ab.13.2025.02.05.13.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:54:34 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 5 Feb 2025 14:54:32 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/590] 6.12.13-rc1 review
Message-ID: <Z6PeGEp__6A2D4DJ@fedora64.linuxtx.org>
References: <20250205134455.220373560@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>

On Wed, Feb 05, 2025 at 02:35:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 590 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Feb 2025 13:43:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

