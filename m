Return-Path: <stable+bounces-183656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85ABC75B7
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 06:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB391897956
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 04:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484AC244677;
	Thu,  9 Oct 2025 04:20:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082D1F2B88;
	Thu,  9 Oct 2025 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983650; cv=none; b=Lt0VE8C/zXmzy91yyg+VH998Byl6evJrJy0IEddOdF3lWwmdl16sAG9hzqpyEVg3YcUfzKadhNTXd1szKjWgjZGSCa42DR11PqPAPj6fXlcA1TGWPT6ejkEqs9Zb9P5c+gXClDcL69ESv99YdpGZfzoboV2okmmy8H27ca5dKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983650; c=relaxed/simple;
	bh=YwvXXskhFwkJdm5leOJwSTVj9nM2YCkCbZbPDYFez8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh7b78QusXLB5TFqXVagE3q8ypHu7UzlGgLyJdP+l5jr2MbNK6Sg01945OZjb8V4ZR32ptadYZClja5GXdzbrlW5Z4+Q1mRNQhKOHCWUaw1+iFr/1a0g+Y1u9WQ/WLN6xwU7hw5JFHaCg4NtJYzQQeO0gQJLGQsCuZCaGuB8QHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.108] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowABnvqDiN+dohP8sDQ--.29046S2;
	Thu, 09 Oct 2025 12:19:46 +0800 (CST)
Message-ID: <187fe5a3-99b9-49b6-be49-3d4f6f1fb16b@iscas.ac.cn>
Date: Thu, 9 Oct 2025 12:19:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/2] riscv: mm: Backport of mmap hint address fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 Charlie Jenkins <charlie@rivosinc.com>, Yangyu Chen <cyy@cyyself.name>,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Inochi Amaoto <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Meng Zhuo <mengzhuo@iscas.ac.cn>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
 <2025100812-raven-goes-4fd8@gregkh>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <2025100812-raven-goes-4fd8@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnvqDiN+dohP8sDQ--.29046S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17CFW8Kr4ruw18uF17ZFb_yoWrZr43pF
	WrXrn0krWkJr18Ars7WwnFqrWYvFZYya45Gwn8G3W5Cw15WFy29r4a934a9anrArs5X3Wj
	vr48ZwsF9rs8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYsSdPUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 10/8/25 18:20, Greg KH wrote:
> On Wed, Oct 08, 2025 at 03:50:15PM +0800, Vivian Wang wrote:
>> Backport of the two riscv mmap patches from master. In effect, these two
>> patches removes arch_get_mmap_{base,end} for riscv.
> Why is this needed?  What bug does this fix?

The behavior of mmap hint address in current 6.6.y is broken when > 39
bits of virtual address is available (i.e. Sv48 or Sv57, having 48 and
57 bits of VA available, respectively). The man-pages mmap(2) page
states, for the hint address [1]:

       If addr is NULL, then the kernel chooses the (page-aligned)
       address at which to create the mapping; this is the most portable
       method of creating a new mapping.  If addr is not NULL, then the
       kernel takes it as a hint about where to place the mapping; on
       Linux, the kernel will pick a nearby page boundary (but always
       above or equal to the value specified by
       /proc/sys/vm/mmap_min_addr) and attempt to create the mapping
       there.  If another mapping already exists there, the kernel picks
       a new address that may or may not depend on the hint.  The address
       of the new mapping is returned as the result of the call.

Therefore, if a userspace program specifies a large hint address of e.g.
1<<50, and both the kernel and the hardware supports it, it should be
used even if MAP_FIXED is not specified. This is also the behavior
implemented in x86_64, arm64, and, on a recent enough (> 6.10) kernel,
riscv64.

However, current 6.6.y for riscv64 implements a bizarre behavior, where
the hint address is treated as an upper bound instead. Therefore,
passing 1<<50 would actually return a VA in 48-bit space.

To reproduce, call mmap with arguments like:

       mmap(hint, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);

Comparison:

        hint = 0x4000000000000 i.e. 1 << 50

                    6.6.106             6.6.106 + patch
            sv48    0x7fff90223000      0x7fff93b4e000
            sv57    0x7fffb7d49000      0x4000000000000

When the hint is not used, the exact address is of course random, which
is expected. However, since the address 1<<50 is supported under Sv57,
it should be usable by mmap, but with current 6.6.y behavior it is not
used, and some other address from 48-bit space used instead.

There's not yet real riscv64 hardware with Sv57, but an analogous
problem arises on Sv48 with an address like 1<<40.

One real userspace program that runs into this is the Go programming
language runtime with TSAN enabled. Excerpt from a test log [2], which
was run on an Eswin EIC7700x, which supports Sv48:

fatal error: too many address space collisions for -race mode
runtime stack:
runtime.throw({0x257eaa?, 0x4000000?})
    /home/swarming/.swarming/w/ir/x/w/goroot/src/runtime/panic.go:1246 +0x38 fp=0x7ffff84af758 sp=0x7ffff84af730 pc=0xc9310
runtime.(*mheap).sysAlloc(0x3e3c20, 0x81cc8?, 0x3f3e28, 0x3f3e50)
    /home/swarming/.swarming/w/ir/x/w/goroot/src/runtime/malloc.go:799 +0x56c fp=0x7ffff84af7f8 sp=0x7ffff84af758 pc=0x67944
runtime.(*mheap).grow(0x3e3c20, 0x7fffb69fee00?)
    /home/swarming/.swarming/w/ir/x/w/goroot/src/runtime/mheap.go:1568 +0x9c fp=0x7ffff84af870 sp=0x7ffff84af7f8 pc=0x824c4
runtime.(*mheap).allocSpan(0x3e3c20, 0x1, 0x0, 0x10)
[...]
FAIL    runtime/race    0.285s

With TSAN enabled, the Go runtime allocates a lot of virtual address
space. As the message suggests, if the return value of mmap is not equal
to a non-zero hint, the runtime assumes that mmap is failing to allocate
the address because some other mapping is already there (in other words,
it assumes the man-pages documented behavior), and unmaps it and tries a
different address, until it tries too many times and gives up. This
means Go with TSAN fails to initialize on Sv48 and current 6.6.y.

(cc Meng Zhuo, in case of any questions about the Go runtime here.)

Patch 1 here addresses the above issue, but introduced regressions (see
replies in "Link"). Patch 2 addresses those regressions.

Thanks,
Vivian "dramforever" Wang

[1]: https://man7.org/linux/man-pages/man2/mmap.2.html
[2]: https://logs.chromium.org/logs/golang/buildbucket/cr-buildbucket/8708301310656989281/+/u/step/22/log/2


