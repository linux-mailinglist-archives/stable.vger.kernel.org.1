Return-Path: <stable+bounces-83176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A999658B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 11:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F881C211FF
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315018C924;
	Wed,  9 Oct 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SiB+xNM7"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A87817;
	Wed,  9 Oct 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466403; cv=none; b=RplDuGzOSlpvbs9sVVtxYCJb9LoYFo591E1AxwRmq7TnHZO5/b+NBW7TwDpXI4SvgRoqrU+31D0+D7kSqojlufVwd1fRmEroGtKgO0VA+p44QR17DJhVJ90vGwKtPTE72CLfyP1R74VQDofCVnioGnq6s74BBdVdR8LA4Rs8tnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466403; c=relaxed/simple;
	bh=q5kFK27zC9QSAxnsiecNggmepszAXtsQ+p+LPc5iPyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbjqT2Ync3Xnj0rIQVUMfJ7xzFTtimXq5oFsbNTj28KTlzHiRgsx8Nmcfi3NvAIIHOhDeE6ivV64NBcLxfx+vmM/VTbkci8cD2wkrXPW9wDlXkWU7YZPzx94EBfsue2FZowW4LKGXdngZPE08WyRZAFW/cuTeyP/XSOPab5T6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SiB+xNM7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D095C40E0163;
	Wed,  9 Oct 2024 09:33:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pjcGAUtbtB7b; Wed,  9 Oct 2024 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728466395; bh=W6veSKU2WR0GJ3J3IAY1ac2OF0tPd4BKxz66Q3nLu48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiB+xNM7LOfy+PbAlpYa3zMBJaG5i8SeceH4IKveVCuudf7lIDKkgVs6gUuzOIxnh
	 p3Get890m+cdHWUdyWCpwOmkgjWul8nlYx0uiMJH8A8oqkTGBf7HfCAt7RT1PcsIkT
	 YxbrVkV5mRUWXowkDBAr4VwynH/ezM1jxbW2W5h3v4qys4UFu6CZkFZpZnwOgvK58q
	 9rahKZkkCV5SBmCXrwZJruBh3JsaiytxNQNgEABeQYJjJ8B9xyWAxVjNX4/ybYQn8C
	 KEjpXkiG9P3Jd2cPwE3X147AfUW5YK0SwSdb7jI8gadiLfz1QiApTz3IKD0F2x6ZVo
	 k27gbwhnJBga5tWoJ6cl+7Ox1J1sIlT5GCjD70HPPi7pl2HZ5Dhh7RnXjFSa6p3KH5
	 udcACPkFn3qAGseuxreYSW2joxM+OKb3gF0Gj/t30BAmLmaXZcXEWf7t/3fCllr3tA
	 gw+4CNxhkwVTerbbRH8ZVrXLfe5hIlNgVPX/Tb9cRoY5nWe50ibtABXabt4mFoz9SQ
	 ugNzFA4QMXbMM3V0XJORa6tzV15iX/78xW+8Dgq7nCXn9lT58nTsc7UI+dsx3KH4sv
	 yLUPBlcLOKWKWxw6AIT0HVOGeUacW4aGTaJxKYQQK0AUxuSgNeiV44Y6gJ1nzORZ6/
	 m9vRz1YstVTcgLzk3SMjv8bE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43EB940E0263;
	Wed,  9 Oct 2024 09:33:03 +0000 (UTC)
Date: Wed, 9 Oct 2024 11:32:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 5.10+@tip-bot2.tec.linutronix.de,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/bugs: Use code segment selector for VERW
 operand
Message-ID: <20241009093257.GDZwZNyfIjw0lTZJqL@fat_crate.local>
References: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>
 <20241009061102.GBZwYediMceBEfSEFo@fat_crate.local>
 <20241009073437.GG17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009073437.GG17263@noisy.programming.kicks-ass.net>

On Wed, Oct 09, 2024 at 09:34:37AM +0200, Peter Zijlstra wrote:
> You need ifdeffery either way around, either directly like this or for
> that macro. This is simple and straight forward.

Nothing in this file full of macros is simple. In any case, I would've done
this as the ifdeffery is shorter and the macro is simpler. We have this coding
pattern in a lot of headers, abstracting 32-bit vs 64-bit machine details, and
it is a very common and familiar one:

/*
 * In 32bit mode, the memory operand must be a %cs reference. The data
 * segments may not be usable (vm86 mode), and the stack segment may not be
 * flat (ESPFIX32).
 */
#ifdef CONFIG_X86_64
#define VERW_ARG "verw mds_verw_sel(%rip)"
#else /* CONFIG_X86_32 */
#define VERW_ARG "verw %cs:mds_verw_sel"
#endif

/*
 * Macro to execute VERW instruction that mitigate transient data sampling
 * attacks such as MDS. On affected systems a microcode update overloaded VERW
 * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
 *
 * Note: Only the memory operand variant of VERW clears the CPU buffers.
 */
.macro CLEAR_CPU_BUFFERS
        ALTERNATIVE "", VERW_ARG, X86_FEATURE_CLEAR_CPU_BUF
.endm

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

