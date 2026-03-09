Return-Path: <stable+bounces-223729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBirM3E7r2kPQQIAu9opvQ
	(envelope-from <stable+bounces-223729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 22:28:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D1E241AC3
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 22:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAD443023D5B
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6823BCEE;
	Mon,  9 Mar 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo2U0KhM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B328507E;
	Mon,  9 Mar 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091693; cv=none; b=hm2dXL1mABotsscnrRcOiygdgbAou+09xv6SNlyUfEbMnwi4MaEh3osElmuDkCMGnFu6TwMWMQUqdzi9rG+3bkgHGL46+U+LsfC8kv735Xi3FTze0+E1VIkoA5VsNYzRWQfig0vIPEpffMyatg439RggRufFKF69gfgFGbeYdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091693; c=relaxed/simple;
	bh=cCDrgo1oeB0keB3HoR3pwZGw2J12Pky4iB02DQkv1yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWsMjaizFhcdLD3LkipEMNK5MAqJTrXcJ3M1ycGmA6VdFGMoHU3ThwXOuK/v5l7AjyklpDbdPkR/YuEJVc6zrNN1lvp7zdXa2XQT0WHt+LYRjGLMFl08RPZt4oYPSyg89NT56nw0XduiIWfeMHVH1NCDw5Jpv5PnqhcYdinH4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo2U0KhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB12C4CEF7;
	Mon,  9 Mar 2026 21:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091692;
	bh=cCDrgo1oeB0keB3HoR3pwZGw2J12Pky4iB02DQkv1yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qo2U0KhMydzxX24g3oJCu02ECNxaGDzn0cvcH/E3Il/LGV2XMle1xc47KF5Nrjro9
	 Lrd8SnxZaVOrNWAeV2IPBCShBe2pTTseeIEcThwtIP/cyHEamwhYJ0sc7BCmQSp74w
	 UybrIdlLLs/BJ5CyFlJixDwGjg/gUOrZ4P/k2+1LAkNeVOmkd1y0iGK1u4bIO3uXUz
	 0SJuvNg4xQM+j0VcDQllqcrkZf4XQ0uMHtQBoWxdEPF+OOwOBf/SRmM/jpFEuBjwmb
	 KxnUY1cdLrqWDZESzWFvoXInD9UL8g7oP0QUNDHyXTcnvr9RkZ1uK3y0gT2dBg9k05
	 6p8D7sMfYtRFQ==
Date: Mon, 9 Mar 2026 14:28:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "ACPI: APEI: GHES: Disable KASAN instrumentation when
 compile testing with clang < 18" has been added to the 6.12-stable tree
Message-ID: <20260309212807.GB3411535@ax162>
References: <20260308164129.19119-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308164129.19119-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 88D1E241AC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223729-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,intel.com,alien8.de,huawei.com,linux.alibaba.com,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 12:41:28PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      acpi-apei-ghes-disable-kasan-instrumentation-when-co.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit ccd3cab8095d5c53eaf8a6598ff339ffaad6a696
> Author: Nathan Chancellor <nathan@kernel.org>
> Date:   Wed Jan 14 16:27:11 2026 -0700
> 
>     ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18
>     
>     [ Upstream commit b584bfbd7ec417f257f651cc00a90c66e31dfbf1 ]
>     
>     After a recent innocuous change to drivers/acpi/apei/ghes.c, building
>     ARCH=arm64 allmodconfig with clang-17 or older (which has both
>     CONFIG_KASAN=y and CONFIG_WERROR=y) fails with:
>     
>       drivers/acpi/apei/ghes.c:902:13: error: stack frame size (2768) exceeds limit (2048) in 'ghes_do_proc' [-Werror,-Wframe-larger-than]
>         902 | static void ghes_do_proc(struct ghes *ghes,
>             |             ^
>     
>     A KASAN pass that removes unneeded stack instrumentation, enabled by
>     default in clang-18 [1], drastically improves stack usage in this case.
>     
>     To avoid the warning in the common allmodconfig case when it can break
>     the build, disable KASAN for ghes.o when compile testing with clang-17
>     and older. Disabling KASAN outright may hide legitimate runtime issues,
>     so live with the warning in that case; the user can either increase the
>     frame warning limit or disable -Werror, which they should probably do
>     when debugging with KASAN anyways.
>     
>     Closes: https://github.com/ClangBuiltLinux/linux/issues/2148
>     Link: https://github.com/llvm/llvm-project/commit/51fbab134560ece663517bf1e8c2a30300d08f1a [1]
>     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>     Cc: All applicable <stable@vger.kernel.org>
>     Link: https://patch.msgid.link/20260114-ghes-avoid-wflt-clang-older-than-18-v1-1-9c8248bfe4f4@kernel.org
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 5db61dfb46915..1a0b85923cd42 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -1,6 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
> +# clang versions prior to 18 may blow out the stack with KASAN
> +ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
> +KASAN_SANITIZE_ghes.o := n
> +endif
>  obj-$(CONFIG_ACPI_APEI_PCIEAER)	+= ghes_helpers.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>  einj-y				:= einj-core.o

The backports you have taken to make this apply cleanly to 6.12

  20260308164114.18890-1-sashal@kernel.org
  20260308164118.18945-1-sashal@kernel.org
  20260308164121.19006-1-sashal@kernel.org
  20260308164125.19064-1-sashal@kernel.org

are excessive in my opinion. I think you should just address the
conflict... There is absolutely no dependency on those changes so
"Stable-dep-of" is a bit misleading.

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 2c474e6477e1..346cdf0a0ef9 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+# clang versions prior to 18 may blow out the stack with KASAN
+ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
+KASAN_SANITIZE_ghes.o := n
+endif
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o

