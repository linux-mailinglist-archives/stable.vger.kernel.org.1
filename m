Return-Path: <stable+bounces-123133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405EFA5A6F8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 23:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7145E1680EE
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 22:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735461E1C1F;
	Mon, 10 Mar 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1evGh/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A736B;
	Mon, 10 Mar 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645158; cv=none; b=R977jV07S2DAPSSAupaDjHMlVQnpbs1RSBzF9kYDuCp1GP5cc0da3A1ihS7D31lzTB3uJ8wkKGjVkVKyqM6SZ9LGRceRb0KBt6Hf/6dn6uXynWljAWELS6A+sLUH1VNBTT6WSIeOUvIwpUdpV4Us29I+9NQr1BukRceU3eZHUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645158; c=relaxed/simple;
	bh=ttzn3xrpc9m0mdtHto8VbGwJZiB73dr7m/moKJgZ1VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPRZXDvXp+LRkuLe06ooA387blPKpkp8xp6a08xwkdPErv7oPNTk/Fil1oQArYksi/ZdgcZbNAYWJuClPOTTpenHbCWKFSzf/CLC2BYSh3HKR18dHVRaOMRClKooqiNlk16tr+7HRUya3qckOQ9bTL8bIQJd6FCbz3V4NglIkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1evGh/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A298C4CEF0;
	Mon, 10 Mar 2025 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645157;
	bh=ttzn3xrpc9m0mdtHto8VbGwJZiB73dr7m/moKJgZ1VA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1evGh/MFQ2TUhrhYk3pd53WrOU5UbDsCGWPK52cBRh4KVEnH65SGwBiWIwxsWPum
	 D/m+t1B9WlQf48NPabGnE2sSNRSIp5cUuEdynlaprd2ckEgOPSbAldAjrVV4v+HR/C
	 ddxEQ7YgK3gQo+/qa9kSB1Gb2+xE8bTWK0xEnZ+4cxsFflPgNa/0r6IDuN9NPg7UkP
	 4MOsNwJfa5ZbG0qiLb9iClrgMY9bj8LrGFtmr8tQpP+Ub5PGwIEBzgqB9ajfGE0WHY
	 yJ6JvN3tjoRz1s2lv+rqKxrpdIqwi3PKKmsQMg57Q8IGN8e4zEOg0a1VXjFZ0VIUnS
	 2YwzSxL/fYsOw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfca745c7so30543051fa.0;
        Mon, 10 Mar 2025 15:19:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOshUqOmVHLzRMLdbkqerdB2MnD6nJUafvk9aaiykJEFUSb1ELi7TSyf2gG1ReqdXRHo67v9LW@vger.kernel.org, AJvYcCXgT5V2Dv2aAWFluygu1gyhxC5gNNYW6NWicD2JkCaqUf3l0xuuwM6bF+gpTaVxalZ1wHNSoogFhnTnGoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmwOPlIG9mqE8cE4o+vTecoPC3lCVLmSILsBjWZrs4zvYoPRW
	BA/KiPj6srGd6BLoiJCOVb3RsWdnCZhW6zjNanEU5LZTgz4O7IedhuzlB2ifgTnNEo8HKcENOa2
	SwrYr5dGncAGY3FP2g01E8xBm1mk=
X-Google-Smtp-Source: AGHT+IFdaE7VD03XpZBnZqZ5Te7f8zq1KRlmCI4uG+Nn6ghC/OEFCEYVSh5or7jkPSs+G9WiTRE/Xv1D7ifH5p7rVXU=
X-Received: by 2002:a05:6512:ba6:b0:549:8b24:9894 with SMTP id
 2adb3069b0e04-54990e5d3f1mr5757058e87.15.1741645155867; Mon, 10 Mar 2025
 15:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206123207.GA2091@redhat.com> <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com> <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com> <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
In-Reply-To: <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Mar 2025 23:19:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
X-Gm-Features: AQ5f1JpxrtcPCgK348i6QVqdsYk8YkunbVdiGOmc5N2jiT_-ZL6G-uIZ5hpTUNA
Message-ID: <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 22:44, Borislav Petkov <bp@alien8.de> wrote:
>
> Just to report this, bisection tomorrow unless someone figures it out in the
> meantime...
>
> This is 64-bit, allmodconfig, clang:
>
> clang --version
> Ubuntu clang version 15.0.7
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>
> This guy:
>
> Ubuntu clang version 18.1.3 (1ubuntu1)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>
> on the other box builds fine.
>
> tip/master:
>
> commit bc6bc2e1d7fa7e950c5ffb1ddf19bbaf15ad8863 (HEAD, refs/remotes/tip/master)
> Merge: f00b8d0b903a 72dafb567760
> Author: Ingo Molnar <mingo@kernel.org>
> Date:   Mon Mar 10 21:57:15 2025 +0100
>
>     Merge branch into tip/master: 'x86/sev'
>
>      # New commits in x86/sev:
>         72dafb567760 ("x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()")
>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
>
> vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x30: relocation to !ENDBR: .text+0x180475
> Absolute reference to symbol '__ref_stack_chk_guard' not permitted in .head.text
> make[3]: *** [arch/x86/Makefile.postlink:28: vmlinux] Error 1
> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 2
> make[2]: *** Deleting file 'vmlinux'
> make[1]: *** [/home/amd/kernel/linux/Makefile:1234: vmlinux] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:251: __sub-make] Error 2
>

I tried building allmodconfig from the same commit using

$ clang-15 -v
Debian clang version 15.0.7
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

but it does not reproduce for me.

$ make LLVM=-15 bzImage -j100 -s
drivers/spi/spi-amd.o: warning: objtool: amd_set_spi_freq() falls
through to next function amd_spi_busy_wait()
vmlinux.o: warning: objtool: screen_info_fixup_lfb+0x562: stack state
mismatch: reg1[12]=-2-48 reg2[12]=-1+0
vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x30: relocation to
!ENDBR: .text+0x17f535

and no error.

Could you capture the output of

objdump -dr .tmp_vmlinux2 --section .head.text

and share it somewhere please?

