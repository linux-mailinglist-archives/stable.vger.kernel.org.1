Return-Path: <stable+bounces-200447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F50CAF62A
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0201C300A370
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D5228751F;
	Tue,  9 Dec 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVX68rQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4A23AB88;
	Tue,  9 Dec 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271090; cv=none; b=a1n9HmKlajQB+Hei3n3e+mVhoSMbKKpZ2lCUmretZqcr/fFO49Wj472FeHgAFHhnfZIpEZZ+SsovcZV3gOnEgJhOkYhRHJo49avnIGfmX6V2Sja/mZBoDNvMaZ9VhNelGOU2T67wiglu3DwUJzSZ2qubLk5V7VWZpubYqnjbfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271090; c=relaxed/simple;
	bh=6N1ooYsbWWNUhV36tFrhXO8gBBI4cfMhZttIyF50dBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXiiWQupjR752CJQXu7WDRjjBfr1BNfiU6x67Fm4QVxkKoRorWNwxub8UviePq2ZDc44FuuCT/u2/yUXrzMTlgMI2lvA1/pJgpWHwoDLGGEMe5YoxG9EgDlT55lR/Od/aWZu4z9CtU0ZE3AgX/54XM9qJn5uth96et8HLME4HAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVX68rQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96849C4CEF5;
	Tue,  9 Dec 2025 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765271089;
	bh=6N1ooYsbWWNUhV36tFrhXO8gBBI4cfMhZttIyF50dBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVX68rQfJdO0sCDW5lOwiJVeDWtYqQvjNnlb/ptRrqO1huzyX/jUn9Q1M0892saBT
	 M4MtIP7Psgb9jAAGqHp4pxH6AXl9gkj1+/5AhXlmaZDgvHGe92k2VGyG8mYgOe6awn
	 I2pIp2yihj84kUejEaNxm8GpXNgeibQOj/lGdExmSnobocg6tKFYKvxfw89Yet0vIC
	 pCY4tSwnwtVJFJ7oM+FxF9oW3vO+oEa4JRop4g5+sViCCQHv/dDSSdlNhott2zMqao
	 Uaw3Yf68to/V7eoDsGQEIDk6aHTWWXhVf+9VO5PGNBa6IJiGdc5xU6z2yXneHNgByw
	 Osu2uoEG5LS4Q==
Date: Tue, 9 Dec 2025 10:04:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: yongxin.liu@windriver.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	vigbalas@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/elf: Fix core dump truncation on CPUs with no
 extended xfeatures
Message-ID: <aTfmLKlUjQN4e1Zw@gmail.com>
References: <20251209072124.3119466-1-yongxin.liu@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209072124.3119466-1-yongxin.liu@windriver.com>

* yongxin.liu@windriver.com <yongxin.liu@windriver.com> wrote:

> From: Yongxin Liu <yongxin.liu@windriver.com>
>
> Zero can be a valid value of num_records. For example, on Intel Atom x6425RE,
> only x87 and SSE are supported (features 0, 1), and fpu_user_cfg.max_features
> is 3. The for_each_extended_xfeature() loop only iterates feature 2, which is
> not enabled, so num_records = 0. This is valid and should not cause core dump
> failure.
>
> The size check already validates consistency: if num_records = 0, then
> en.n_descsz = 0, so the check passes.
>
> Cc: stable@vger.kernel.org
> Fixes: ba386777a30b ("x86/elf: Add a new FPU buffer layout info to x86 core files")
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 48113c5193aa..b1dd30eb21a8 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1984,8 +1984,6 @@ int elf_coredump_extra_notes_write(struct coredump_params *cprm)
>		return 1;
>
>	num_records = dump_xsave_layout_desc(cprm);
> -	if (!num_records)
> -		return 1;

The problem with your patch is that '0' is also used for other errors,
it's the all-around error flag for core dump helper functions such as
dump_emit():

                if (!dump_emit(cprm, &xc, sizeof(xc)))
                        return 0;

So please change dump_xsave_layout_desc() to use negatives
as genuine errors and otherwise returns num_records, and
change elf_coredump_extra_notes_write() to only abort
on genuine errors.

Thanks,

	Ingo

