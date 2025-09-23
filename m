Return-Path: <stable+bounces-181427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206EB9405A
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 04:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF55441DC8
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 02:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C332273D73;
	Tue, 23 Sep 2025 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WonmVGXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABF25A64C
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758595192; cv=none; b=itMZGQYQMcPU/cbFYZGrZHJMRu1gFe+dQFNs+kZoBgmQVXnIwBfwCs5ZuR2bk6WnMnv4mom1Z8PIHWgyVIvLnj9kuvDNpuhCXOZLTN0DIhjEoHtVoLSnrzNhRnoJyvH3JjHKxG4alNI331uWqQja8dGUDdYlYivxpvCp6J9qAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758595192; c=relaxed/simple;
	bh=1/d2HFVGLGHQMmxjDB/j0xkRdNQfTVZWtuk56ZysKew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W18tTt2N1u0U1JhASpFsv0RTqxfDdiiFfIQYGzPAc90tEY0wkw3dwGECMysLimnuBN6AZvwF98fxyzOdIkQD5rGuqLP9zyZAAyXM5aHMVYxOVeeGNOIY5QudAuMqf2MV8mEe0ceLRy/WGLGcFgwpcdzk/xuIwX6kWRLw0Hzxlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WonmVGXf; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4248746aabfso18880985ab.2
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1758595190; x=1759199990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEqc5Nhg0kVbwLVE1FmI2uJU0IwqC3G08jt+br7HVvY=;
        b=WonmVGXfwvZKDUjcbmqXNRdxAicq4BOMRxs/cDL4V6VxpKSduGOouaQG3VT2DA/zVe
         cTg3UrxjTIjQzEzXyKxtreKZBtoqkhARwxenByKNDGIDzNXc4OtdwZAEb5m7RgxFbcpY
         UmsCdFlTyHHtkBiPwV2uhLAPMiBJ84v6roekg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758595190; x=1759199990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEqc5Nhg0kVbwLVE1FmI2uJU0IwqC3G08jt+br7HVvY=;
        b=EKok+R0YIsUeMVaSHpMTcxoDAsxGkjHq7q9JBo6LZc0oI9ESiNoksKfRyT4ZmcgWGD
         c67KCMu1sQhnNJUrpxK3TNLN50uvYETaNX5w1oBMqldvSQWFe2WA9nWOgYLJDpGT5Cc+
         XwFrN+AjEsLDuTx3EsCZiza1resS6tZhzlKWk0YMwuYprFZD5MW3D6ZW0a8Z6X54MZLc
         ELIAqjXJefiKMVwn6QZNMPznFU7tRurqNo65aTcmyJiGpf6yVGL+/0y4Me51NgReoRAo
         clFBLhSQyZ8R/0UR+a7AvgkeTT7rfWSSj8OvVX7qjddvxtwSm+VA6Wf6u227ctmYYMuv
         Uavg==
X-Gm-Message-State: AOJu0Yx2xgto6suzn0ZXo70Sp2A0vqqLNkUI1aa++k4LG63ukIwYPFcD
	PkZNseLM/yicpgb4OahqOC5JgdqRznI5BR59O3i6VqcDhB8IbuDC2NONUWZlvDxe9w==
X-Gm-Gg: ASbGncseQHo4GAttK+8XI326sAHnh8K0Z9JL0zKi+B/ZNN1OhxHnw9XyCMle2FtM2jU
	TW4cM3Odm9qMFOYYXW8jgKRhmu625B+ekiMphJXJfw4kPd7ruJUDqnzqbxJ7rTS78ftQL5v0qr0
	L7DpZnHCCsny0ctjsPvDnVfg8LFpPw0zJDyOJaShrCK94hgRgPJR7+tJ+nj3w8OCAUKien+KJnC
	kEYRfg2brjB2rpwI3QrYFodwR0smEnZ+dSmaxQ+Y8azUzq3ba4jHKavHnyal7oJpq9I0oMYtXCo
	hL/DuvVAmC3tecNNUZEXNRTUNhnu+gH4m7sV8bQyI31QLv4Xu06N3mirQsmEKb0tGYdZeoCt8rY
	tzQr8WJG9ihCoH5Is7nUQcAMaPVCYj94Px630fFTrBFw=
X-Google-Smtp-Source: AGHT+IGG2xktWuC5rnCJ77VprZKayFRcKDJYjnoABifuSNMEumClFcB3oEYBOA6ij/ifYDVwewko4Q==
X-Received: by 2002:a05:6e02:2509:b0:425:79a0:94d3 with SMTP id e9e14a558f8ab-42581e2ddb6mr20016565ab.12.1758595190167;
        Mon, 22 Sep 2025 19:39:50 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.123.46])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3b015dd8sm6369599173.13.2025.09.22.19.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:39:49 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 22 Sep 2025 20:39:47 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
Message-ID: <aNIIc9Yf8hfkELs2@fedora64.linuxtx.org>
References: <20250922192412.885919229@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>

On Mon, Sep 22, 2025 at 09:28:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

