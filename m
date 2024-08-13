Return-Path: <stable+bounces-67478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9C9503DC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA59282D09
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0D51990CE;
	Tue, 13 Aug 2024 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFQwEUEl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB91990BB
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549065; cv=none; b=NaRDzfw+UQHagkal1dGon7bLJEoPUd7hF3fccD4X+qp7lqp6cja9yBgq/hXe5FSPAwApg6AD9FjLus/BdAPiZdmLk8u9pZ1G3+Z8hRKsUyo1VJqdiCnyHFjTOpc+fotNrqxd2cPxFFeaAxYVk7zji8buUpDe3FuxXsi4PcaXqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549065; c=relaxed/simple;
	bh=RFkO9YN6R66d5+iDA3PywDeqKm3aITZe71Gy4WVoXzg=;
	h=MIME-Version:In-Reply-To:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type; b=dtf5wYTsuh1DplNk+6dTscVlqVsOB0ZHTihDWWInPtTdcLZ8DVHuhm8nyToX+AjPuHshGv7ieYjorHnvFEbwAdj05ptIXO0+76X9cC9lCyYE8uHCu1KLHKDyFTSXbs1t4PSj47/4T6v3OeaYfqs/trbwivYYR3Aa+rN4YVvH75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFQwEUEl; arc=none smtp.client-ip=209.85.167.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-530c3e95c50so4999375e87.2
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723549062; x=1724153862; darn=vger.kernel.org;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFkO9YN6R66d5+iDA3PywDeqKm3aITZe71Gy4WVoXzg=;
        b=oFQwEUElpj0bnWLPd4XCTeOR1lHdgJ57xGdnBp+Bbs1E94z6QztZ5Eio7KLAjz6CDT
         e12aB6NKENgyHCeM/VmrfBdhR/4g861qfeyFXiM/jUPBE6UyrhrLeV9XGQlOhbH3Zcad
         neAucM/xXQEhUa2HvS7zvtmZqn+RDkb6aMzmwE+S/G8IKjt40TNdIBHKO68ruSjsj488
         C1RHRkCQk5RCM0rNmKETVegEVeH2CK9bLkzizOxsUtSYMvlw3uVAtR0VNrV2V4DITeMf
         BbzL4/0oRKBZTksAEHpUP1XNnXRos5TneU3MHRqBaVsPlZbCM5c8MnjCtkJMuT48jOXJ
         UQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549062; x=1724153862;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFkO9YN6R66d5+iDA3PywDeqKm3aITZe71Gy4WVoXzg=;
        b=SUVdXBGakmAqzGHqGKO2rHHRqGDQuIlLlwNx9w4LwKFu4gy8rl1FmkFMwymgH/Ndeo
         Vu3wuJ4y5TFNg6aGiQMQ96PPQEJ/9L+9bIMuWRR0GdiYY0KQYPx3hkJEfiE09p4kfx2F
         9Hgaig32wcsPfMx3VSPGnrwmIlhCUjCpyJ2yQjwkVuvlzNragdwessTULt6zKiAIUf1+
         b2y8ko6EGQoVeB+UUnFIkfVXtuQ379iSeEYb+RMTBE1fqSp/mL/a3lojexocR0p471x5
         pFPJX9vSWynVnrxdLdpN9UREPh/HhHJ7MHe3Gq8Ws0Njv5sQqSxaG6kj7tlnOO4hhqf5
         vm+g==
X-Gm-Message-State: AOJu0Yxlyf5jQAOAdHGVBhDtjdO8C1+y4JOxm3Lg3JJUp+5q6HrZmUuS
	DNfjQoyLFCvQgT80cRIvgtremVEw9Iat/YMSbqxxyUeC0Fci9+fRZMtEq8IRjTV007mEAz538oa
	meshVQCqdx9lnTXCUm8N3NlSa2qprpw7w1J5FWXs536EADpkLSKb9oswf9ExK8ut5cT062CTa7W
	ssjaRc2pfPB8vX3ibJRZUmvi6+u44A
X-Google-Smtp-Source: AGHT+IESDKeJuvd9ozQ8U27FEoLn6cGLk50ZCbxJaBKb9NzZBU4rWxB8rxUromp5TEQJ3k2AWNC3KjxvCzkmDL0ThI1D6oyaAlvfwTZmDa8EJxvP4Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6512:3b0d:b0:52f:c782:d9cd with SMTP id
 2adb3069b0e04-53213649fabmr4071e87.1.1723549061729; Tue, 13 Aug 2024 04:37:41
 -0700 (PDT)
In-Reply-To: <20240813061957.925312455@linuxfoundation.org>
Message-ID: <0000000000009420ba061f8f09cc@google.com>
Date: Tue, 13 Aug 2024 11:37:41 +0000
Subject: Re: [PATCH 6.1 000/149] 6.1.105-rc2 review
From: ChromeOS Kernel Stable Merge <mdb.chromeos-kernel-auto-merge+noreply@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, chromeos-kernel-stable-merge@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hello,

This rc kernel passed ChromeOS CQ tests:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5782314/2?tab=checks

Thanks,

Tested-by: ChromeOS CQ Test <chromeos-kernel-stable-merge@google.com>

