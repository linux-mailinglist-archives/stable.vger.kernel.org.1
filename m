Return-Path: <stable+bounces-123131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF22A5A65C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 22:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFFA1890590
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5211E3787;
	Mon, 10 Mar 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RC7gRiAC"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAEE1581F9;
	Mon, 10 Mar 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643065; cv=none; b=psc317zFOCbOZEo9zhvw7EPnQnMxnceYMILrMon0CErY8usSNuLUYq3qPjXCcV5RoEpEkzJ5JftnxEMAkWpy36EiW2rMUG4q7oOOgIirpwp8hlA4I0o8O9WIvDZbZ/DNs3DCMl9jz7v4GotkjJq2UGdshf96LxG4uhTQeZqGDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643065; c=relaxed/simple;
	bh=G7Fme57u2IzU0aCRudFHsqV8wPt8fHJGI84qD4gstHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+nu4W+kEnyg0QmvQ82rRbMPFN76i5LarDMyFF0Hkq9tE7EFdqtrAlX+gidJpGctGUtK2usoKF+RTFPkpc/OFjG0XOS7C4tu2N4foGSliLWUlbGx2haUmN51wNWcDROFC3PYL3O/lddoEML4JglydtDe+n1+xrDDIKY6Z+oA2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RC7gRiAC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A959A40E0217;
	Mon, 10 Mar 2025 21:44:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id V8iI1EDRSufR; Mon, 10 Mar 2025 21:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741643056; bh=YrWW6plKqCIN0T1rbvfgL9glpKdkbBP+e8JtMnvli14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RC7gRiACbr5X2bOvgLgQHCbYrfco5yY5J4Zyzf1tmLdAua6uP6NdKhnSP7EdroM6p
	 68eXZ/A6rncjQlT88g/IM0ocOOOKQBoKd5kjHYHc78pwZbfE8oR7eE2S+bxh5a3jUt
	 i3fhlUaVxs58JY3i++65Kq08aO/RkftEWfBmXxxcDiGU9YWC4Svhucg0zjDYSzPOTC
	 4/Lx1h8l2qYxz7fLoVLsMIE8Ueo3JfpVBH8wN2JYpnLLRqKRs6v2VW44oVhvo3NsYr
	 pPDiG+53Jc1qReJr5hLePbxKU+YSr5M5Cm3GltXwes8zI+XEuiuMpVH4FBlCxKJ5Nm
	 XkFUJh17/yacZzUVcHpNlp0IOpR+06B3pxDBOu3lbSmsJIvg+L0/aTcfrQjHUGYmGQ
	 4JkBd7Lt5DDHvK7lgYZ+L5AJ+OghMqDi8Xmn+SlksSy6lfHjiAhhIVc+MgCSMjZZG4
	 cDQ7vl3vgyTqpCzakt+/6tqG9SKHKSD3ZlCv24bnXCjj1tgXrHp13A3Wb2L3ECCrYg
	 QgKVISQPzNvvdu795eWiGTXfdlD+gNxS/gz7t33zi+2vHbzWzIJQUyALpJXc0nne2v
	 6PgcaM9RegqMtqeYGqs9SUITZXoDbdcxh7J3LXSIBwg82/V9Ie3K8BjdTezhDZ1lvC
	 KuyiROtXrBe0rCJNiNxGuXd0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31B8C40E015D;
	Mon, 10 Mar 2025 21:44:03 +0000 (UTC)
Date: Mon, 10 Mar 2025 22:44:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com>
 <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com>
 <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>

Just to report this, bisection tomorrow unless someone figures it out in the
meantime...

This is 64-bit, allmodconfig, clang:

clang --version
Ubuntu clang version 15.0.7
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

This guy:

Ubuntu clang version 18.1.3 (1ubuntu1)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

on the other box builds fine.

tip/master:

commit bc6bc2e1d7fa7e950c5ffb1ddf19bbaf15ad8863 (HEAD, refs/remotes/tip/master)
Merge: f00b8d0b903a 72dafb567760
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Mar 10 21:57:15 2025 +0100

    Merge branch into tip/master: 'x86/sev'
    
     # New commits in x86/sev:
        72dafb567760 ("x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()")
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>


vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x30: relocation to !ENDBR: .text+0x180475
Absolute reference to symbol '__ref_stack_chk_guard' not permitted in .head.text
make[3]: *** [arch/x86/Makefile.postlink:28: vmlinux] Error 1
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 2
make[2]: *** Deleting file 'vmlinux'
make[1]: *** [/home/amd/kernel/linux/Makefile:1234: vmlinux] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:251: __sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

