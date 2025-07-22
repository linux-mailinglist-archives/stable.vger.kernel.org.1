Return-Path: <stable+bounces-163638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB9B0CFD0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC72C3A46EC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE261DFE0B;
	Tue, 22 Jul 2025 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="BgeJLEWc"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C51537DA;
	Tue, 22 Jul 2025 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152101; cv=none; b=tDnQXmZtdERym4axRjNeuk9BZ+nm7kddFuJiE9gNyoShC01PMDaZtcDvlpuU01WNyh2ARNQxbaNQDU2pt/mDGv7FzUYBFUf556tj4IC1Esv51/IiXJ+Ftos4gEUGqGClbPKWnMq7TnlH/P0y+egjcuD8f07XoAkv921W/k+R6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152101; c=relaxed/simple;
	bh=lj/3O/Co/a/TOZNtsKz34bzvrLC57/+nYzQmJf/IWe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYOe/OzaMYhewdebRSYwiQWAK4zz42XqNvNtKYJIxCjqMt/B0K5/0c+AIhmp3usLwOID6vnI19Ntv//mo/cBXMjP/KAH+byADSbAk2GTYR2SkxF2XdqlvGnvAqJAh024svgSYK0sG6HqMC5IFfNBuKlbuqLYyp1/PZcI5ATimwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun; spf=none smtp.mailfrom=bbaa.fun; dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=BgeJLEWc; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bbaa.fun
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
	s=goar2402; t=1753152041;
	bh=lj/3O/Co/a/TOZNtsKz34bzvrLC57/+nYzQmJf/IWe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BgeJLEWcePu7iD/obLTmpu4rwdPb/JJDc047l9iEf8fKwujhBcyU3brnL9KRfiC1w
	 xkzbIM4r3RTsrFa81XdzLNa0GwezlT/RjfKVckV+mJU3JWGDalBI388d60i38UOi1R
	 bLv+X3hcGLNPM95H/izRg+nAReMYDGRXRlHkPa8U=
X-QQ-mid: esmtpgz11t1753152040tbfda5de9
X-QQ-Originating-IP: qGvRIJKo3JyH86pqieyk/fky0Wuzm4ofHUD0t81YHKg=
Received: from [198.18.0.1] ( [171.38.232.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 10:40:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3727465619527990102
Message-ID: <A862457AA700FAA4+c9af0384-8fb6-47c9-9876-8ea8be528ac3@bbaa.fun>
Date: Tue, 22 Jul 2025 10:40:38 +0800
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
From: bbaa <bbaa@bbaa.fun>
In-Reply-To: <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OE2BWzPe+8GtWb6VslmUpZ2QttO/EHJ717EaT4R/QwJrteMgXvF2L9JO
	+BM280WoIVJtycwCm4iiTjKuuISpJp4ROQI6TDI7VwywNBW0rr+ER/P0ST1gg71X0LnhuSW
	+22SoUQmxq38hOHVEz1ilI9tTHTI6n5WwOpnuV1K9ZsMbqEXhaVoH4uyKWRpZJeDxyNEXNr
	BztBzU5r4Zz2cFTSMuMZXriNyfbTYF9R40CbgmMSySH7PbStT6+NjVyR+NFm7sv+86fvgHt
	KS/D0Y/00CqapeaBWKMcoMLX6go4csatcFpv3fZBwo14Df62APk4n2Ttd6HIbwzvEJUaSbf
	KWiC7hY1a+bGJhX/iymQjnxQzF/ztunrkDBDmojWldGytn7kkm7CAazO8PowJxT6WawAjM4
	kuwz5+FqSPw16JfAqFbGIGWypwP18AUpvxAjOvynVgjNOPM/mao5f5FzCNDCtiJGtUw1iNt
	PqVe8kZuqwyKsEmuOnfI/iaHxvp/TtpoAEsw0boCYWClKB1JM/3fVCoKMf2keezPixGpe+O
	g4dd4N59+fNEYy0u/uNno+XWM3vgPYA5rk701TPAhascHxQMfOn2VyuJyk6EdUBGJ8U/2bq
	8R5vBMsZZTHKWhJwjVZUuX/pgLMscN2gHVkUle8KfGvk8VKJzlFiPdMR9tuRyCMMC/RRgdy
	v5f31PDji8Tv8k2SxiXP/V8UBEKugZxY+/4kkZrgpV231RztHCpNDQD8hoQISwMHYhn8yeW
	TRCyHDgM1Pfx7WC1q8C7VF0zq4RxzI4Ash1pfYMWVjNS5zh6ayOOsFSwf4x1DCAx2ZA+mWH
	aA1kpwwG/SkSlPMGDL69xHCRu1Tg+EN/bnzVqyiEu1Ml38PeqxEZVUuxcVKwMgchOM0k2Fs
	kd5e9mE0iQvK/8xfVs0Aa3Z+xt07KyLlDPjNKSIPV5ZGtiltu7dwtbrRjYyXgsceeQA5rPp
	lpfV6KsxnPIhyJVcZjHSmngD5
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

> Thanks for reporting. Can this issue be reproduced with the latest
> mainline linux kernel? Can it work if you simply revert this commit?
>
> Thanks,
> baolu
Simply reverting this commit can resolve the issue.
Since Intel GPU SR-IOV currently depends on out-of-tree modules and is not yet compatible with the mainline kernel, I will test it later.
It can be confirmed that the v6.15 stable series is not affected, which also includes a backport of this commit.

regards,
Ban Zuoxiang





