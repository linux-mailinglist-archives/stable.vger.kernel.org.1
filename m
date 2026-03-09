Return-Path: <stable+bounces-223732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ILcMe1Ir2krTgIAu9opvQ
	(envelope-from <stable+bounces-223732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 23:25:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3C24232D
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80594307A0B6
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 22:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11A38F23D;
	Mon,  9 Mar 2026 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfRMRZCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DD34C808;
	Mon,  9 Mar 2026 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095145; cv=none; b=A4QroJ35c52JjqGEEv05UVyOkNAdQsQZXXsPUsY6Fau+1Mzzmy4dEGg/N7iE4G93tZxI/wuqwpqrRovwXngGD48Hf4mhjddxbCZcx9zpZ0erU96MIKXebtfhMcYr09W/P4YCpZutf3iGN+XR7m1GzRKJIFrrs7y/Su9ReWVS7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095145; c=relaxed/simple;
	bh=TiSypGeK56DQQOKvg7ZatSK7JXwhRoLz0dwJQliqOy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1RAAjp/E0aOMjeMW2nImGL4OpTxfPGDqMfFU4aMtYVKh8gYP8GyNPG1UPDxP/8cGKTDulGPyrynCvs0aYPnwVo0cm83XEVQm7PogwtaTP7OhGJdq0UU6p6Z1DCtBznu0nYYjzM55hIsygjzYtchBL1zpIqac3o2Ga+uE+J2nAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfRMRZCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DCFC4CEF7;
	Mon,  9 Mar 2026 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773095145;
	bh=TiSypGeK56DQQOKvg7ZatSK7JXwhRoLz0dwJQliqOy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfRMRZCkaW14x4h++ltw2MbEi1947ewPfAslGYEaAis6OFVX2yauU1T2y/l+ohRjT
	 CizbOLDBGX3Y3umqiy84HC8y8uYTq1r6YTww5hW4SiqCKVMRcsI0Yj07Oz1aBybHFc
	 41MqX9lQfWbYqgeaR9dxGGMEbTPDyWlwqutwtkifeaaZ0WYxFJzf1jpfIuC0DhRmkW
	 WZTHNChAK8BXt9nuHxZ8ymhXtI/BMh1w7MsUGWNHxhQ/qakQiHBb1tiGX+KmblE0Dl
	 2+Y/fSIVCAkNr/qRnb10ZwGqChIN4Z6w131QROUVJFWT3CHCVdwM56Xmy8PfX8j1ai
	 gw437vZPCQROQ==
Date: Mon, 9 Mar 2026 18:25:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "ACPI: APEI: GHES: Disable KASAN instrumentation when
 compile testing with clang < 18" has been added to the 6.12-stable tree
Message-ID: <aa9I5wRCtUsGB6Td@laps>
References: <20260308164129.19119-1-sashal@kernel.org>
 <20260309212807.GB3411535@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260309212807.GB3411535@ax162>
X-Rspamd-Queue-Id: 2CE3C24232D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223732-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,intel.com,alien8.de,huawei.com,linux.alibaba.com,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:28:07PM -0700, Nathan Chancellor wrote:
>On Sun, Mar 08, 2026 at 12:41:28PM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18
>>
>> to the 6.12-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      acpi-apei-ghes-disable-kasan-instrumentation-when-co.patch
>> and it can be found in the queue-6.12 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit ccd3cab8095d5c53eaf8a6598ff339ffaad6a696
>> Author: Nathan Chancellor <nathan@kernel.org>
>> Date:   Wed Jan 14 16:27:11 2026 -0700
>>
>>     ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18
>>
>>     [ Upstream commit b584bfbd7ec417f257f651cc00a90c66e31dfbf1 ]
>>
>>     After a recent innocuous change to drivers/acpi/apei/ghes.c, building
>>     ARCH=arm64 allmodconfig with clang-17 or older (which has both
>>     CONFIG_KASAN=y and CONFIG_WERROR=y) fails with:
>>
>>       drivers/acpi/apei/ghes.c:902:13: error: stack frame size (2768) exceeds limit (2048) in 'ghes_do_proc' [-Werror,-Wframe-larger-than]
>>         902 | static void ghes_do_proc(struct ghes *ghes,
>>             |             ^
>>
>>     A KASAN pass that removes unneeded stack instrumentation, enabled by
>>     default in clang-18 [1], drastically improves stack usage in this case.
>>
>>     To avoid the warning in the common allmodconfig case when it can break
>>     the build, disable KASAN for ghes.o when compile testing with clang-17
>>     and older. Disabling KASAN outright may hide legitimate runtime issues,
>>     so live with the warning in that case; the user can either increase the
>>     frame warning limit or disable -Werror, which they should probably do
>>     when debugging with KASAN anyways.
>>
>>     Closes: https://github.com/ClangBuiltLinux/linux/issues/2148
>>     Link: https://github.com/llvm/llvm-project/commit/51fbab134560ece663517bf1e8c2a30300d08f1a [1]
>>     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>     Cc: All applicable <stable@vger.kernel.org>
>>     Link: https://patch.msgid.link/20260114-ghes-avoid-wflt-clang-older-than-18-v1-1-9c8248bfe4f4@kernel.org
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>> index 5db61dfb46915..1a0b85923cd42 100644
>> --- a/drivers/acpi/apei/Makefile
>> +++ b/drivers/acpi/apei/Makefile
>> @@ -1,6 +1,10 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>> +# clang versions prior to 18 may blow out the stack with KASAN
>> +ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
>> +KASAN_SANITIZE_ghes.o := n
>> +endif
>>  obj-$(CONFIG_ACPI_APEI_PCIEAER)	+= ghes_helpers.o
>>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>>  einj-y				:= einj-core.o
>
>The backports you have taken to make this apply cleanly to 6.12
>
>  20260308164114.18890-1-sashal@kernel.org
>  20260308164118.18945-1-sashal@kernel.org
>  20260308164121.19006-1-sashal@kernel.org
>  20260308164125.19064-1-sashal@kernel.org
>
>are excessive in my opinion. I think you should just address the
>conflict... There is absolutely no dependency on those changes so
>"Stable-dep-of" is a bit misleading.

ack

-- 
Thanks,
Sasha

