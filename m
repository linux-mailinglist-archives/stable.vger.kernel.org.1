Return-Path: <stable+bounces-196568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3E2C7BBA8
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 22:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92CC34E1661
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 21:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B93305070;
	Fri, 21 Nov 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="fmv+wuWj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC12DFA31
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759651; cv=none; b=Z35sGCIDKGm5Je0Uil6We5IXVwGK82bKDfWujoVNWF2YpW4qcwt+PMzbrIukrFxlHHxdau+ThAzYvK6GZWMFX3CLKEcIKCHghCF7nA5SO/o0kjfniGenRm88RVFU2vWZc41w3PJBlGYuEo4j3uoXDl4gcu6L9v4i0H0UL5RB7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759651; c=relaxed/simple;
	bh=pEFooFR78YrhIvGWQXoeWCNC2kSSj2NyKh3ms4wsbIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTYhvOcAR+FmA4BxHdNQ+wVTJuDGEtBgK/Sos14Hb16krwGroC1t2kzH+n6q583WPpS2UzUEky3i85NNxmxGFPRYXtyyVCjXddjWg+1cWSdN5ocWeiDVrLkzuIN/aix9oE29gq/anzljYDRzKUjQqZpFshWCAUgnyKBi5DocNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=fmv+wuWj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29558061c68so32941275ad.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1763759647; x=1764364447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DefMfvVzY19z1+5A+UQbLAdG6uc9MBGDJLgUd7SbSRA=;
        b=fmv+wuWjKi2uEMilGjxHLN54e54K2K8/d2v97RM/sH/ysjIblA73WXriRlABt4ALUz
         egGQPlWPtFDWUeJuDMJw3eOIhNLBN6GWB5Ja7mvbRWOF+dOCkB3DQEMsfDgSDpYy7xvb
         RpGHuSLlG4U/0F4EhU4KgQhZjmZYh2M1INfN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763759647; x=1764364447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DefMfvVzY19z1+5A+UQbLAdG6uc9MBGDJLgUd7SbSRA=;
        b=GK7J3Y8hEcHNXLknXgonnXCof5xshomp6vuNnkJNpvz2veBu6P8CPT3W4rZlLEk940
         DiBDD14/E3/JNR+FFLnctT2ocbMZFE7GEQ8hFOoidrWzYYeH2zhb+Q5Gr4gJKy7dm7AM
         +4AUeUpCnS0sdESNm11RwMpr1iJkxfvqKYL2vsQ4tiBgm9fMcq4TDzQwOoF6d6MUH5GU
         5JNN5e37Z/BixON39ftFLhPT1iPwyfJDeo3hek58gaIzIPxwc+IYLszb61lYQyXypucn
         PKbGEZ1b/oA6qbKJ+Pzat4r0zbpMa0UlXK2+DYSj83H/cqXxxSgIWkb5NFH7R/Iwzfvt
         70Nw==
X-Gm-Message-State: AOJu0YwwxhD+NZhRzAA4Xj3m2ToL3DBWIFOaj/rwkpv4KZS5crkfdm5s
	AQgGfn01KjvF4bpwk3uEmCa6l3NF9pmFaHx+dQjOmxLu3LuzlPqhG9uWg1UojAoAVA==
X-Gm-Gg: ASbGnctK8r509D+ANW2IOBq8HUjTx4LWVGyFD2727+nEBFcBULrRDT4foULFoOFnTvS
	gvJnjk+8TpK5w7AxyyQIDqbKuqE3k8tx9GPdDLtZSO7yGUSTnKvsuc9wca4S/dlpIxxdag0tkw6
	cuHyC9aEtK6LfBY/ApEZ/9yj0Xgpg/1yNy8pcgoQJOrB9J9Ah2A6frbVscyw7n2dVbPauqxD4CZ
	RD7CTLd4+6skgRc0AXdLTbnkRvocM0Ydf197L2N75G9PUiyxs/KKgHBCFz51PlD7PdQb4rq7nVL
	wO3kikZ+LQ0U2qcWevqB1KMKduv6UdKFvd8ZUc9bs8C07gwLIw1Rk6ms9hIsszQSmqNnuDLMsQi
	g4clqw7y5S158Zg/UDM7yvHVORbAqFcxlxrP+zEZcRMJ/bB9qmq+SndiNNhIKkJ5ASJL23oYXeO
	zWPlPii7L+w4m8q5+RT+jzux/K3/wiEkqt
X-Google-Smtp-Source: AGHT+IGoICO5vKGUzbvGQPv8FA6NHPI2AeaS2RMHkJJXNl2UM/lBqDzjcLi9woXD/2w5OzxK19kA7g==
X-Received: by 2002:a17:902:d587:b0:295:592e:7633 with SMTP id d9443c01a7336-29b6bf3b62bmr46414455ad.29.1763759647409;
        Fri, 21 Nov 2025 13:14:07 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105f79sm64411075ad.20.2025.11.21.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 13:14:06 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 21 Nov 2025 14:14:03 -0700
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
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
Message-ID: <aSDWG9xH4l9QJYQK@fedora64.linuxtx.org>
References: <20251121160640.254872094@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>

On Fri, Nov 21, 2025 at 05:07:19PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

