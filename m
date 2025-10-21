Return-Path: <stable+bounces-188843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494EBF8F24
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A63B18A4516
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C8028B7DB;
	Tue, 21 Oct 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdqiCfjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429B15C158
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082492; cv=none; b=i8dGBGh1uE29zsWgL2AgBj9mHrTKtTVCDM3/aeJiPsZ6allxw4MaPfdeKRNk1CpApvBb/1LbPEpVPKDDFBVvE8afH+Uue80leZ/4EZBol9THs6vEQHJR9lMxcB4IRLr/VOzeEE30w6lCXr43rMjekCReZTzg+I2tHTuJS45zjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082492; c=relaxed/simple;
	bh=RLRSydNWUiXf5CH/wGMqDSko+VPeHiDcy74JGPJ7TVU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=I04gn5CXPFQvphwPw8j+80+4jrKTlczYBTs4HF1pp/ZsvcxYgL0xzo/9OTyEkIyqfRbnKdsvhvIA+zmG3ZgoedHXqsFQ5Q/ETvKi8dPFbCI9hwq/soFLEXJD2us5BXLcM5dhTaLdMxsTBrz4FADZKVg5ARVpjrOIxOuMjP4nXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdqiCfjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871A0C4CEF1;
	Tue, 21 Oct 2025 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761082492;
	bh=RLRSydNWUiXf5CH/wGMqDSko+VPeHiDcy74JGPJ7TVU=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=GdqiCfjVzCIZtbgWuqfsDaX4YucS121PqCN8ssdnI09w5+aGVZvdaA7RCRTozBQr7
	 PQqDTAQTnuH2nqIrfhA6d5hY5X6ZybvIB4fTgEscJW0nSKguRpUMFu2ix3hAIEGj+9
	 bUkWfTnZcQsulWgp+RMImY2TmLI8JisT4gOnCNbr8yG/IrPbZYc5nFBQj3dGVKVFc9
	 m2uEy91zNXgln7dmjKiOeLPVUMGxrBtU7JHDem0Lqc4Oiifb8y2DTQEtIJg9AY0fg+
	 +YBFwaWMqa1PUjqUCT4CgEZhsjqoWrrVMu4MPOmqHL12BPhccbfpwqdyYTX8WPMuAy
	 uJVw1K9U/Mwyg==
Message-ID: <edffeaca-e52a-4ecc-b788-3120e11bbef2@kernel.org>
Date: Tue, 21 Oct 2025 16:34:50 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
To: Pascal Ernster <git@hardfalcon.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <2025102032-crescent-acuteness-5060 () gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
 <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
 <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
 <1f15260b-684e-4b8c-807f-244bbfd31f1c@kernel.org>
Content-Language: en-US
In-Reply-To: <1f15260b-684e-4b8c-807f-244bbfd31f1c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/21/2025 4:19 PM, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/21/2025 4:08 PM, Pascal Ernster wrote:
>> [2025-10-21 22:45] Mario Limonciello (AMD) (kernel.org):
>>> Are you cleaning your tree between builds?
>>
>>
>> Yes.
>>
>> I'm building custom kernel packages in a clean chroot for my private 
>> package repo. The kernel config and the PKGBUILD can be found here:
>>
>> https://remotehost.online/linux-6.17.4/debug2/config
>> https://remotehost.online/linux-6.17.4/debug2/PKGBUILD
>>
>> Here's a tarball that contains the PKGBUILD, the config, and all 
>> source files that I used:
>>
>> https://remotehost.online/linux-6.17.4/debug2/linux- 
>> hardened-6.17.4.hardened0-0.src.tar.zst
>>
>> Here's a log of stdout and stderr of the build process:
>>
>> https://remotehost.online/linux-6.17.4/debug2/stdout_stderr_combined.log
>>
>>
>> Here's a fixed PKGBUILD that I used successfully to build my kernel 
>> packages:
>>
>> https://remotehost.online/linux-6.17.4/debug2/PKGBUILD.fixed
>>
>> The only difference is that I've commented out the two patches from 
>> your patch set, and removed the corresponding sha256 sums.
>>
>>
>> Regards
>> Pascal
> 
> It looks to me that you have CONFIG_HIBERNATE_CALLBACKS set but not 
> CONFIG_HIBERNATION set.
> 
> How does this happen?  HIBERNATE_CALLBACKS is hidden, and it's only 
> selected by CONFIG_HIBERNATE.
> 
> The fix for now for you is to either turn off CONFIG_HIBERNATE_CALLBACKS 
> or turn on CONFIG_HIBERNATION.

Alternatively does picking 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbfe987c5a2854705393ad79813074e5eadcbde6 
help your issue?

