Return-Path: <stable+bounces-191528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B1FC16442
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18DA75640DD
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A93491C7;
	Tue, 28 Oct 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="HYu6JTSP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1D276024
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673248; cv=none; b=sl1yzyER6OkjR0T0OnF74W1kaEIf3CCQFY6fx9Xz/qVbjlCDUOLaHw/n0sUCXVR27O/OYsc8zaWn6VHjemy83bvpMXeUkqXG20I3g8QWuEnex8fclpnfY90dIwPxRfkKTFpHGfnZDk2IV7aIAVYagXhfqxU9EIYUhT7XpOg1FEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673248; c=relaxed/simple;
	bh=k2oFcW+F5IbZatog7pgx/F1s8i3ixYSpqpoKtIdHFps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWgLZPlTJayFGn3ihQRLBQqz5cFsSkh9Eqca5WGDlhmaVE9xmRKKJM186WNh2rGQYLykOuGDLuqgEXaAJ+s5wX5zwXRft0FvtfUqVPGmItpLXFK+m5yTT4O+oqwu0GCU/eHOyIHqY7BOtFv3Ryb3ouTwR0LuCBVZdRicpyt9xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=HYu6JTSP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6159011a91.2
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1761673245; x=1762278045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luiyWuiRrVRfhN7JAiac9EdJ6Gfejadf8kzjmyI1PuM=;
        b=HYu6JTSPEmM3aFi358p+nHQ7iz5PIhYGu3CEjyHhDufkmGZJfOfYlH6SKOoue/R8k7
         qk1WHOraf6nH9510V+ZMqEykIEQopNF6hEu6vR16WZsIv5tZjczSl0J5F057Ku3BafTl
         MlPFUd2+Oo7+OGA68hUNycvRECle4yyA8HiNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673245; x=1762278045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luiyWuiRrVRfhN7JAiac9EdJ6Gfejadf8kzjmyI1PuM=;
        b=VaZXRQ8XST6G8D3ZG6cMMrgfUmwf5PpzVbzWNUzoVxpVAg8G9CsVG03N07ae4AeZIA
         Vwffg1mh5NL0fJtK4anl18KAgzcE5XT6b8++d1wvHqhNaBHHL2bw4RhSWZs2boOp39dq
         HrZJn/HoAO2orH/dPWId0Pg70tFru/B8Bz7X2fBWviMJE/h91dAyjuqX/y8Nmw0qR2a6
         E/GPLaj8UlACRMnKy6aiEtc2yansgKyZDwUzxdjpmVaRBaUaUoa7vmJAfT9iJ5flzKKN
         VAlX4cjp+7NmhwWnZOJMKTjAWIR8WvaopipYy/w1pzv96bC4LJ3OnqE1nBpdEBVTORMT
         a7ng==
X-Gm-Message-State: AOJu0YzH+NqMrQpPET38Ft1VaI5GoBPtqHW2b9LG9chHYVt5naOMB8kL
	LZylLtY7VLlQujVuUcL2Wgm9y3rxu8L+HSB6IXmEdg7F7+Drr+JB0UFuQ2Kmx7ImNw==
X-Gm-Gg: ASbGncsXL4PMdp/JoRG8YL/XSNRX4id6dedqRT5Non8OQSBy9SjLORCOU8M7PDg17JW
	Xk9ewgrZUozg/b7o+7yWxrXYEBZDhJ5RqxXuMqInUlNeYp5FivVa2b4dnkUsh7A4ROJRL49uv7B
	2IM4SJEOFQQ57qFg05jNpSgVLCW49o85+VvEbP3A+oCfHGU0IHV5DS5W1BZ1q88LZdqS4BwKwAo
	OfS1o9IfsaO7KKr1/c+W5EYt2XjRP78dcaRrwmBhXmkkG6aXl6WrpMbtivsXNtWuduWmIUP4pHf
	LXr5pF1FbW/uJXVUxXOEkxL49iaIAOq9CtZ6SQQkp8oKIJ9mq2h+HuX6ccwXSTpJkz+aGySNpeJ
	L9YFBBFm/PfftWix5U4o+8fN0JK0wwX88q+3x8sKd0w962gimUWw2iOF6xLY6so1EpAyrWsJOPZ
	WPnSsRCJAAtWnXExFMvXqv
X-Google-Smtp-Source: AGHT+IG5V4vsb7CrJYMRIp5V3RyRMADScln5MWpRKhmnO7Ie2PDaI8M38ch/Qo6ITFZL8KyPH7+JlA==
X-Received: by 2002:a17:90b:37d0:b0:335:228c:6f1f with SMTP id 98e67ed59e1d1-34027a06cedmr6107636a91.12.1761673244857;
        Tue, 28 Oct 2025 10:40:44 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.125.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a86fsm12863100a91.1.2025.10.28.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:40:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 28 Oct 2025 11:40:41 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
Message-ID: <aQEAGdx7n9tjCu1v@fedora64.linuxtx.org>
References: <20251027183514.934710872@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>

On Mon, Oct 27, 2025 at 07:34:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

