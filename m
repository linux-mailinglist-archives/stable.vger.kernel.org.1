Return-Path: <stable+bounces-96246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0909E18AC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B270B47357
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB931E0490;
	Tue,  3 Dec 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="JHS+ZWzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCD9iIXu"
X-Original-To: stable@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91C1DF272;
	Tue,  3 Dec 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218890; cv=none; b=K7HShqdjF5Gy0a08dRk1uaugy2d9Eo3OTnSJXVU2s1rsApHXpUQwO8wTNn87L8F0QMK6OQAHzz9Pil9ZDuEMfJ6+dUFRnNWZqI6AOcbFNjHFiAU43DXOvVVv259RxZkh7ZvTF5IznTlzb4v6pHxcmIN8LJk+wxTWJAJClSCkWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218890; c=relaxed/simple;
	bh=qc9sm83OjeqBvun4Gwlp/tsLDHuq0w4+yWIRcxn2Stc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaS/2Dawv9IuKR3Oc86/cdEhluR1YRlu6eF//AA3VfPSkCcXXeJDoSYoOen0TIUWu2eJMmPWE2C3XCQZF+y7HHQbLhtcBAdzDZ9w8KrflYlxIEnLDPQz3/fHWGAyKirBOXi2Fu2paTGP6DbWbMxXfqTLOX/2MsxnROnB0sYv26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=JHS+ZWzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCD9iIXu; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 49F101D40801;
	Tue,  3 Dec 2024 04:41:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 03 Dec 2024 04:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1733218884; x=1733222484; bh=/mQfoVgVhx
	zLYtR/Una8//ubxPP0cKXi5Jx7MW2HSt0=; b=JHS+ZWzpaisLvq5iODaZN7YHdw
	QLnf8CONaLJFmS75G5B9Tl4SnqH4jJJOmbXjzfTH536da19Ywt7y7YlsoaDGCsJp
	QXs/4DXX854EBt1SmIvIl9HDC68qVIJu5iUSjWyzWOI2yJPcQnd+9YMk1IpMO3Zr
	Zf6uSukCQ3jYVet4JfZCLP5mKJebZC1+vB47oaBh6GPoLZbJoe23s7EisJOenpSf
	yqR6/qm0N7EFIvp15M3JHu3hhUCOjUszgN404IcqnHRm8AomnFW8BMcjVz1Aj1PI
	cwCZQZt3Ou9paU64W0hwEr3gsi+l+xC2+2EgMpqHv9uT+a/R96xYVb+fbrKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733218884; x=
	1733222484; bh=/mQfoVgVhxzLYtR/Una8//ubxPP0cKXi5Jx7MW2HSt0=; b=c
	CD9iIXuGhha9OHiHT3T5Gap/iA2ipA3lyuuDRiHh4dkgffs/ErtERPf6ll6GI+HQ
	uQiS43x4k0J78q5tQCjARCqJ3MDGj0sgVFszS1SpvEnsoX+GCCA3HPKt8+H5ufZ+
	5XaQepFo9heHf//FabaYOGIjvvDZKQZB9y8+17eNmPfGDHsit5MnOUfW3DhttbHF
	F2igqsqf+1LB5ICYZOgXO714NtQVZqBPrrT+lQMIsV5y8CEmxuwdZVZz/Vo9DNVk
	+NeiJEkaSLyPIxz/zLt9l1Hs/rBMUAmI+Qwim2AxHupo+JhGUun7eZ3w2jmaVNOI
	E5L3XhZDdUZSOxHxQqF1g==
X-ME-Sender: <xms:QtJOZyJUhiDRF8DjBG_NWQhz7pxKevVBSgOlm6bCGqyggAGjQlPSOQ>
    <xme:QtJOZ6J6Ftwx4Vy_hQpSRh13kkrpQ5qm1Nf8pp2gdRLMvJq0fcgzWrNBjQAii4fyA
    qaxvhvmaH_bnKpYZDI>
X-ME-Received: <xmr:QtJOZysbeGhcjmD8oVyDvmAG4yAPevfi0fEwq9qaewjOrUIsH8Bl8k3PUnKD2gWl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhush
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpedvvedvjedugfelhfetjeevteehkeegleej
    jeekjeevvddtudduieeffedvhfdutdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hinhhfrhgruggvrggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspg
    hrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrrhhl
    ihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopeholhgvghesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhm
    pdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprg
    houhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegvsghivgguvghr
    mhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtoheplhguvhes
    shhtrhgrtggvrdhioh
X-ME-Proxy: <xmx:QtJOZ3afE_5UHaAglalPUchM-DzfwYyUcelhXbRZKfGqbIc121AdiQ>
    <xmx:QtJOZ5atqmB_-qZP0p2SWPz1eSf0fsHcW3eLGhhiSAr_c_LkdW3tIA>
    <xmx:QtJOZzBJzxuPjhqV66Si0N_Ii8O4E94h87q-EEVe9e81RMHjk35Uvw>
    <xmx:QtJOZ_ba4J375LHg1OQFVdBJ6nsqGZUGNZFnxmYOL4QAm4tmG0lO3A>
    <xmx:Q9JOZ3y0JfA3qMZoK12dkIG8BXsl3DHYKh0dubnUQEtvPnSwwkwEQYA8>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:41:13 -0500 (EST)
Message-ID: <406b4b74-992b-461e-b1e2-ca670fd3da14@coelacanthus.name>
Date: Tue, 3 Dec 2024 17:41:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/ptrace: add new regset to get original a0 register
Content-Language: en-GB-large
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 Quan Zhou <zhouquan@iscas.ac.cn>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
 <Z06ZAP-_4J4-6aK_@ghost>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <Z06ZAP-_4J4-6aK_@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-12-03 13:37, Charlie Jenkins wrote:

> On Sun, Dec 01, 2024 at 05:47:13AM +0800, Celeste Liu wrote:
>> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
>> no way to add it without breaking UAPI. (See Link tag below)
> 
> We have had a patch sitting on the lists for a very long time to do this
> which I guess didn't get enough attention. I am glad that we have more
> eyes on this problem now so it can actually be fixed :) [1].
> 
> However that patch has the problem that it modifies the
> user_regs_struct. It is super unfortunate that riscv didn't have the
> foresight of loongarch to add padding.
> 
> There is a nice test case in there that would be great to get added
> alongside this commit with the appropriate changes. [2]
> 
> [1] https://lore.kernel.org/linux-riscv/cover.1719408040.git.zhouquan@iscas.ac.cn/
> [2] https://lore.kernel.org/linux-riscv/1e9cbab1b0badc05592fce46717418930076a6ae.1719408040.git.zhouquan@iscas.ac.cn/
> 
> 
> Since I am familiar with the code I have gone ahead and made the
> appropriate changes. Here is the diff:
> 
> From f35184467cc7b319c2a5c5c034d18119c46f54c2 Mon Sep 17 00:00:00 2001
> From: Charlie Jenkins <charlie@rivosinc.com>
> Date: Mon, 2 Dec 2024 21:19:13 -0800
> Subject: [PATCH] riscv: selftests: Add a ptrace test to verify syscall
>  parameter modification
> 
> This test checks that orig_a0 allows a syscall argument to be modified,
> and that changing a0 does not change the syscall argument.
> 
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/ptrace.c                   |   2 +-
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |   5 +-
>  tools/testing/selftests/riscv/abi/ptrace.c   | 133 +++++++++++++++++++
>  4 files changed, 139 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/riscv/abi/ptrace.c
> 
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index faa46de90003..025c22894d32 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -197,7 +197,7 @@ static int riscv_orig_a0_set(struct task_struct *target,
>  			     unsigned int pos, unsigned int count,
>  			     const void *kbuf, const void __user *ubuf)
>  {
> -	int orig_a0 = task_pt_regs(target)->orig_a0;
> +	unsigned long orig_a0 = task_pt_regs(target)->orig_a0;
>  	int ret;
> 
>  	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> index b38358f91c4d..378c605919a3 100644
> --- a/tools/testing/selftests/riscv/abi/.gitignore
> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> @@ -1 +1,2 @@
>  pointer_masking
> +ptrace
> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> index ed82ff9c664e..3f74d059dfdc 100644
> --- a/tools/testing/selftests/riscv/abi/Makefile
> +++ b/tools/testing/selftests/riscv/abi/Makefile
> @@ -2,9 +2,12 @@
> 
>  CFLAGS += -I$(top_srcdir)/tools/include
> 
> -TEST_GEN_PROGS := pointer_masking
> +TEST_GEN_PROGS := pointer_masking ptrace
> 
>  include ../../lib.mk
> 
>  $(OUTPUT)/pointer_masking: pointer_masking.c
>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> +
> +$(OUTPUT)/ptrace: ptrace.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> new file mode 100644
> index 000000000000..1c3ce40d6a34
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/ptrace.h>
> +#include <sys/stat.h>
> +#include <sys/user.h>
> +#include <sys/wait.h>
> +#include <sys/uio.h>
> +#include <linux/elf.h>
> +#include <linux/unistd.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define ORIG_A0_MODIFY      0x01
> +#define A0_MODIFY           0x02
> +#define A0_OLD              0x03
> +#define A0_NEW              0x04
> +
> +#define perr_and_exit(fmt, ...)						\
> +	({								\
> +		char buf[256];						\
> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);		\
> +		perror(buf);						\
> +		exit(-1);						\
> +	})
> +
> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> +{
> +	int status;
> +
> +	if (ptrace(flag, pid, 0, 0))
> +		perr_and_exit("failed to resume the tracee %d\n", pid);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +}
> +
> +static void ptrace_test(int opt, int *result)
> +{
> +	int status;
> +	pid_t pid;
> +	struct user_regs_struct regs;
> +	struct iovec iov = {
> +		.iov_base = &regs,
> +		.iov_len = sizeof(regs),
> +	};
> +
> +	unsigned long orig_a0;
> +	struct iovec a0_iov = {
> +		.iov_base = &orig_a0,
> +		.iov_len = sizeof(orig_a0),
> +	};
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/* Mark oneself being traced */
> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> +		if (val)
> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		/* Perform exit syscall that will be intercepted */
> +		exit(A0_OLD);
> +	}
> +
> +	if (pid < 0)
> +		exit(1);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Stop at the entry point of the syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Check tracee regs before the syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (orig_a0 != A0_OLD)
> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> +
> +	/* Modify a0/orig_a0 for the syscall */
> +	switch (opt) {
> +	case A0_MODIFY:
> +		regs.a0 = A0_NEW;
> +		break;
> +	case ORIG_A0_MODIFY:
> +		orig_a0 = A0_NEW;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to set tracee registers\n");
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee\n");
> +
> +	*result = WEXITSTATUS(status);
> +}
> +
> +TEST(ptrace_modify_a0)
> +{
> +	int result;
> +
> +	ptrace_test(A0_MODIFY, &result);
> +
> +	/* The modification of a0 cannot affect the first argument of the syscall */
> +	EXPECT_EQ(A0_OLD, result);
> +}
> +
> +TEST(ptrace_modify_orig_a0)
> +{
> +	int result;
> +
> +	ptrace_test(ORIG_A0_MODIFY, &result);
> +
> +	/* Only modify orig_a0 to change the first argument of the syscall */
> +	EXPECT_EQ(A0_NEW, result);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.34.1
> 
> 
>>
>> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
>> access original a0 register from userspace via ptrace API.
>>
>> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>> ---
>>  arch/riscv/kernel/ptrace.c | 33 +++++++++++++++++++++++++++++++++
>>  include/uapi/linux/elf.h   |  1 +
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
>> index ea67e9fb7a583683b922fe2c017ea61f3bc848db..faa46de9000376eb445a32d43a40210d7b846844 100644
>> --- a/arch/riscv/kernel/ptrace.c
>> +++ b/arch/riscv/kernel/ptrace.c
>> @@ -31,6 +31,7 @@ enum riscv_regset {
>>  #ifdef CONFIG_RISCV_ISA_SUPM
>>  	REGSET_TAGGED_ADDR_CTRL,
>>  #endif
>> +	REGSET_ORIG_A0,
>>  };
>>  
>>  static int riscv_gpr_get(struct task_struct *target,
>> @@ -184,6 +185,30 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
>>  }
>>  #endif
>>  
>> +static int riscv_orig_a0_get(struct task_struct *target,
>> +			     const struct user_regset *regset,
>> +			     struct membuf to)
>> +{
>> +	return membuf_store(&to, task_pt_regs(target)->orig_a0);
>> +}
>> +
>> +static int riscv_orig_a0_set(struct task_struct *target,
>> +			     const struct user_regset *regset,
>> +			     unsigned int pos, unsigned int count,
>> +			     const void *kbuf, const void __user *ubuf)
>> +{
>> +	int orig_a0 = task_pt_regs(target)->orig_a0;
> 
> The testcase above highlights that this should be of type "unsigned
> long" instead of int! Otherwise 64-bit systems will only be able to set
> the first 32 bits (as Björn pointed out in the other thread) :)
> 
> This issue was found because the test case tries to set all 64 bits and
> succeeds, but the extra bits corrupt the stack. Maybe the code here
> should enforce that the count is equal to the size of an unsigned long?
> Fortunately the extra bits ended up in the stack so it was determined to
> be corrupted, but I suppose that will not necessarily always be the case
> depending on kernel compiler optimizations and user_regset_copyin()
> could end up overwritting other data in this function undetected.

Yes. It's my mistake. v2 included fixes and the selftest. It has been sent.

> 
> - Charlie
> 
>> +	int ret;
>> +
>> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	task_pt_regs(target)->orig_a0 = orig_a0;
>> +	return ret;
>> +}
>> +
>> +
>>  static const struct user_regset riscv_user_regset[] = {
>>  	[REGSET_X] = {
>>  		.core_note_type = NT_PRSTATUS,
>> @@ -224,6 +249,14 @@ static const struct user_regset riscv_user_regset[] = {
>>  		.set = tagged_addr_ctrl_set,
>>  	},
>>  #endif
>> +	[REGSET_ORIG_A0] = {
>> +		.core_note_type = NT_RISCV_ORIG_A0,
>> +		.n = 1,
>> +		.size = sizeof(elf_greg_t),
>> +		.align = sizeof(elf_greg_t),
>> +		.regset_get = riscv_orig_a0_get,
>> +		.set = riscv_orig_a0_set,
>> +	},
>>  };
>>  
>>  static const struct user_regset_view riscv_user_native_view = {
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index b44069d29cecc0f9de90ee66bfffd2137f4275a8..390060229601631da2fb27030d9fa2142e676c14 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -452,6 +452,7 @@ typedef struct elf64_shdr {
>>  #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
>>  #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
>>  #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
>> +#define NT_RISCV_ORIG_A0	  0x903	/* RISC-V original a0 register */
>>  #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
>>  #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
>>  #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
>>
>> ---
>> base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
>> change-id: 20241201-riscv-new-regset-d529b952ad0d
>>
>> Best regards,
>> -- 
>> Celeste Liu <uwu@coelacanthus.name>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


