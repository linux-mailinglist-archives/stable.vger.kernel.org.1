Return-Path: <stable+bounces-94625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DF9D6146
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 16:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2737816036C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63D2AF04;
	Fri, 22 Nov 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma1GLpGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17282309BF;
	Fri, 22 Nov 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288866; cv=none; b=MN/ENGx0cZOOSbToZmRDwQiCvC/2q+NZhBGYq7b/l+VgQD9iOaBpa9ASr7b57pzF+Xj/6qbaAn+rO1UMcQ2SzL+az7t+JL7GmvMC1A07Iiob6fR3Jrzvls1w/r/6EVTEXHpV7FOtt8PnDzeOqk+kXJbBRWFs7EubRcZ0CMoCHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288866; c=relaxed/simple;
	bh=7pz32RbN7KvAwY8Z4VR7ySVX87cMIOLDDNQdlcRElAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQKgNcI8YYCTryj+Atdsp/4ySnRzaxhV5eIf2fFu+qWJoyoyqqo2GTRrfRRtdjyBVInFAV5eYrZFEMnWfLaucsj4xyeCo2LtqSrakZVNJB3JCXO/kHW+tHVI3nGxscjK6PanEoP8z7uLxHIC72c1S4jZ1BEdsDCxKEo0pHJ7CSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma1GLpGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5EDC4CECE;
	Fri, 22 Nov 2024 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732288866;
	bh=7pz32RbN7KvAwY8Z4VR7ySVX87cMIOLDDNQdlcRElAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ma1GLpGcU49K7V4i4V697Y2v1F+5gFEzWWYfG5ikQE+epTRKFWCKoH1EKhBUlvgg5
	 Rmuxt/3KU1BnX25bq4mq4g/MgfNMmzgnc3Oz6kOk/ENKy4N0brAfguPHD6jmQ6fu+a
	 2Gc4fcqjhh4EkAyn8gWE5c06MQwMBq5ZRiGINmHPhF9nO7yBjnolYua+7MfjyPeQ18
	 NLTTzKlS3ZC3p/iuWeIRAJ0od+DZuaxN2wuVP+e2tY1c94VMmdNMZXYdLj/oWLG9Oj
	 z4miGV/9poZHenA3v3hzPb8qGGkOcXCoxFRhj1jbf3w9hm51XJGkYvPW3wEXf8VEvL
	 8W/a3r9HB3mWg==
Date: Fri, 22 Nov 2024 10:21:04 -0500
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, linux@armlinux.org.uk,
	arnd@arndb.de, samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.6 5/6] ARM: 9434/1: cfi: Fix compilation corner
 case
Message-ID: <Z0ChYA7bsmnZRI2d@sashalap>
References: <20241120140647.1768984-1-sashal@kernel.org>
 <20241120140647.1768984-5-sashal@kernel.org>
 <20241120151338.GA3158726@thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241120151338.GA3158726@thelio-3990X>

On Wed, Nov 20, 2024 at 08:13:38AM -0700, Nathan Chancellor wrote:
>Hi Sasha,
>
>On Wed, Nov 20, 2024 at 09:06:35AM -0500, Sasha Levin wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> [ Upstream commit 4aea16b7cfb76bd3361858ceee6893ef5c9b5570 ]
>>
>> When enabling expert mode CONFIG_EXPERT and using that power
>> user mode to disable the branch prediction hardening
>> !CONFIG_HARDEN_BRANCH_PREDICTOR, the assembly linker
>> in CLANG notices that some assembly in proc-v7.S does
>> not have corresponding C call sites, i.e. the prototypes
>> in proc-v7-bugs.c are enclosed in ifdef
>> CONFIG_HARDEN_BRANCH_PREDICTOR so this assembly:
>>
>> SYM_TYPED_FUNC_START(cpu_v7_smc_switch_mm)
>> SYM_TYPED_FUNC_START(cpu_v7_hvc_switch_mm)
>>
>> Results in:
>>
>> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
>> >>> referenced by proc-v7.S:94 (.../arch/arm/mm/proc-v7.S:94)
>> >>> arch/arm/mm/proc-v7.o:(.text+0x108) in archive vmlinux.a
>>
>> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_hvc_switch_mm
>> >>> referenced by proc-v7.S:105 (.../arch/arm/mm/proc-v7.S:105)
>> >>> arch/arm/mm/proc-v7.o:(.text+0x124) in archive vmlinux.a
>>
>> Fix this by adding an additional requirement that
>> CONFIG_HARDEN_BRANCH_PREDICTOR has to be enabled to compile
>> these assembly calls.
>>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202411041456.ZsoEiD7T-lkp@intel.com/
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/arm/mm/proc-v7.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index 193c7aeb67039..bea11f9bfe856 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -93,7 +93,7 @@ ENTRY(cpu_v7_dcache_clean_area)
>>  	ret	lr
>>  ENDPROC(cpu_v7_dcache_clean_area)
>>
>> -#ifdef CONFIG_ARM_PSCI
>> +#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
>>  	.arch_extension sec
>>  ENTRY(cpu_v7_smc_switch_mm)
>
>This patch is unnecessary in branches prior to 6.10 (when ARM started
>supporting kCFI) because SYM_TYPED_FUNC_START() is not used here. I
>would just drop it for 6.6 and earlier.

Ack, will do.

-- 
Thanks,
Sasha

