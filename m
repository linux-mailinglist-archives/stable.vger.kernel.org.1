Return-Path: <stable+bounces-71422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49770962C82
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23201F239CB
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ECA188014;
	Wed, 28 Aug 2024 15:36:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136513C3D5;
	Wed, 28 Aug 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859408; cv=none; b=tzbpMtFQBdaelzn5p+AFTtKqKv3FzwRwSIQA0i1rNzOTvLxmxUb/szL7+7vt4k0t9i2PFayPPOwbkKY0b7qzskbt7WV3b2Xb1GsAf3xQcOsp4P7ndRje1VIdA8oALY7jcuIkJTJslD1+ptgZeGavKFG6gEEcklgMsca7rLz3vqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859408; c=relaxed/simple;
	bh=jkGUiU11lEWeOEVI4KtrbRaZWEkKRekW4xWVqNfaT+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=E9UpLu7S9JCMJHXJqcDfLnx9EK33adhay4XB/UYBRPvB51hdnO1Eo/chUKP/wzifDKrV/u9t/m/8LjXRyk6y+9svcqPkAogJ4284cPRRVmBfXPESm0EHZynPil6nppUjqK8A1KWnMpdC17/dOCyFvqrTrr0LrXgtkZCwydoFaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Z4mYY04_1724855725)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 22:35:27 +0800
Date: Wed, 28 Aug 2024 22:35:27 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org,
 akpm@linux-foundation.org,
 linux@roeck-us.net,
 shuah@kernel.org,
 patches@kernelci.org,
 lkft-triage@lists.linaro.org,
 pavel@denx.de,
 jonathanh@nvidia.com,
 f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net,
 rwarsow@gmx.de,
 conor@kernel.org,
 allen.lkml@gmail.com,
 broonie@kernel.org
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
Message-Id: <20240828223526.7E07.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,

> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

We need a patch
	upsteam:  0a04ff09bcc39e0044190ffe9f00f998f13647c
	From: Alexander Lobakin <aleksander.lobakin@intel.com>
	Subject: tools: move alignment-related macros to new <linux/align.h>
to fix the new build error.
	tools/include/linux/bitmap.h: In function 'bitmap_zero':
	tools/include/linux/bitmap.h:28:29: warning: implicit declaration of
	function 'ALIGN' [-Wimplicit-function-declaration]
 #define bitmap_size(nbits) (ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/08/28



