Return-Path: <stable+bounces-163712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A8B0DA93
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAF41C212DE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3622E9ECF;
	Tue, 22 Jul 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="dKKvTlTq"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8023F40A;
	Tue, 22 Jul 2025 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190093; cv=none; b=XF13Gvm4CKa6rviLLS3C4GpB/pfqwu+0P1WDiMh89C8M1BOP5Ao1/j5A8FdnEl5gA0U7r22Jn2XTQDEvhAdYNVTGzwqqM7NcnioES5fxxF4Y9YD8kEeg2ryxKA3x8hqU3oxLAwAAe4sF7JMK4yHfF1PHp3Xe37SOJB7jnahFmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190093; c=relaxed/simple;
	bh=Iq5WsvxE4xIjbPjMheshMDgRthAhYinH65f+nJSr80w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCOi/Duhc6efzXh7HU1QN5m0nZB6d7ISj7aRar1sIXFz7u8Dl4IQoovXrUoi55hBiq5+clDNu+lkkxogAArgqlOXb7lUeSg1rUE4e6Adm7fg20Jai7F+yGQn6zks4Tbfk2JIdJhu7i2sBPOv++PSPJaZVtCjf33ytGUBmR3WOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun; spf=none smtp.mailfrom=bbaa.fun; dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=dKKvTlTq; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bbaa.fun
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
	s=goar2402; t=1753190050;
	bh=Iq5WsvxE4xIjbPjMheshMDgRthAhYinH65f+nJSr80w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dKKvTlTqgNUkoXdgLHlJvAnmFI67UQwbte4fMK25yLO8I1LJvvMnwPQDosBvVaA7c
	 gYK3Q9DD9KD0B3WbThZJitMG7DtZ+os7YMPGK05SM5qoR8Tv876p/4S+/pQgMHx3YF
	 WTyfRMtcUkrWSKpX+sErr+KVXA6NJhm/HOAIALto=
X-QQ-mid: zesmtpgz3t1753190049t7cdff5d2
X-QQ-Originating-IP: +iH9NVu6tcN9o3nxWpFzUQFUvBWNOiOqsXX84wy4dF8=
Received: from [198.18.0.1] ( [171.38.232.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 21:14:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8363422106706379366
Message-ID: <5F974FF84FAB6BD8+4a13da11-7f32-4f58-987a-9b7e1eaeb4aa@bbaa.fun>
Date: Tue, 22 Jul 2025 21:14:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION=5D=5BBISECTED=5D_PCI_Passthrough_/_SR?=
 =?UTF-8?Q?-IOV_Failure_on_Stable_Kernel_=E2=89=A5_v6=2E12=2E35?=
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, bbaa@bbaa.moe
References: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
 <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
Content-Language: en-US
From: Ban ZuoXiang <bbaa@bbaa.fun>
In-Reply-To: <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M8TtDEU6z3sY2Ra3o6fpIKJ0Sb/mVsx8thL7GCTx1Tn2f2LO7/eYW2lt
	sUh4aEsyPANjzGNIW4Pbv28PocKwLWViT3ECUQZc4XAoH/kVHeNhCMBEy4XGmne2QptUFBA
	CzWjRZZWuZCrpBVNXgVTWoe6HcQ3Ax0pGibeTpU/SBxiz1v9D39AVOpBOyPPMieSqQvtQlc
	MC5UQzOhUYWAJy6mvLD+wzWBvAK5+ERjHeIjVB71O2vVBKeuWKeHqa3fWZTwXtp3ttZcxHJ
	FFAp3vl5/cvQK2dRxNkjvmgSO9bKoO/WvI1Ur3Mgn+ngMjC2C4BwZCusKkYP8CUY04E3K0+
	lnwuWrw+OIwUWBOUKxVbsxXE/BfbsKeksFwKnOQ6mao1yz4S9OPSoSQRFyHB4E5xhXjnmEI
	braec8hcYh9YTBGz1cZkhE65/iAZ5Mb3F3ZmNwk0A8pY+rl9yoQtS9YGrxT4F8vIBbuu4SU
	5MfKeSORrufMq7bWIH/G0EvMHIoY4nX/q/Q0gP2hJ2oxbsTVORBLJ2bzflfgZV1Htdh593q
	J8QFZ7iBx1W/pJ4hAgl/B3ImLxkSYRmz4iqoDcvcCplEWuWUTQHIsiCi12Evgjsvc+dDBK6
	CCfT/TiUaYmwepQJopGy7kc2Pd7GRAbtUg38n6sicvJ8wrqV8ryjs/Mbg2eGZKIHrb3d/h/
	c1JOE+CWdO3RW2Rw8i18S8ZDtiTarBUqbYs2a/bEv+upZUI3fsxiYmyCqSstXgztSBgWlCz
	xxirjjk4QFmsNEnICjpGY5TGc5ZS/2Z5QZmo3Ei7eZUAz5MztI2JGPrEWPN+oQfqmdDmmvX
	Ystsc272+VBQub3u+SC5jwXylgjSGTKmKNX2uiPrts8QwHN6VuaIfvozqoqPbCzC/u0/B+o
	LHSVdaWKw3uY7iivx561KfpOsurOzxWXtJr/FhbERDgiRXMHV1AWSqYJo5Q0XH3sMkdR0jy
	K/fTrdQKjLXvKqXPREB26MTvhzgQuoLrd95iC0pIFIVIXpPIg1nepdZ6Slii+QG76FGHKba
	8i9IqP2w==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

> Thanks for reporting. Can this issue be reproduced with the latest
> mainline linux kernel? Can it work if you simply revert this commit?
>
> Thanks,
> baolu 

Hi, baolu

The issue cannot be reproduced on the latest mainline kernel (6.16.0-rc7-1-mainline).
The Ubuntu v6.14-series kernel which also include the commit is also not affected.
I think the issue only affects the v6.12 series in linux-stable tree. Should I wait for the stable maintainers to solve it?

Thanks,
Ban ZuoXiang




