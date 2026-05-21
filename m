Return-Path: <stable+bounces-253413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF/OCpFRDmpq9wUAu9opvQ
	(envelope-from <stable+bounces-253413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52F59D4B0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 895F2301DC36
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246223645D;
	Thu, 21 May 2026 00:27:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F11A9B24;
	Thu, 21 May 2026 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323277; cv=none; b=IvtZmt/WEcYhLEqQP4roKjDwdr/5UaAJ1wKvlRJyUCVpzb7/KCrPuHNfNquebejxa5+E+clp9+vUw1RbWqarynA85+XxB3vcuMZcyKR8ui9X2OOIGlRaMiFlnmzcowUUXUgvStL/IuwXnmiUU6SE1PtTZH42j3wltNXGWi+mRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323277; c=relaxed/simple;
	bh=dsrZJCe5ftbYKd0MAjYLXBt7dSrDouyZMRgAhu3wZYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz3CT3ebH5FSqZe4xLzE5htsUQ3EKFGG4qxDaZLS3I+xid7FRtZa5fZOImHDI7jI/keNeYXaew18vP9dvGClS6VjDxOPuBbayFmdWHJ7uh5ZuF8Y+c0/G/bEnsE1a0kYx8/hVEWNha+1JpZFH+4M5yBpP3zuERTUwwB1tkV49f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [123.118.218.47])
	by APP-01 (Coremail) with SMTP id qwCowADXgGxsUQ5q0n72EA--.6636S2;
	Thu, 21 May 2026 08:27:24 +0800 (CST)
Message-ID: <cec3dd9c-37d8-4859-bfe0-a42ee3efdc97@iscas.ac.cn>
Date: Thu, 21 May 2026 08:27:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: misaligned: Make enabling delegation depend on
 NONPORTABLE
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Paul Walmsley <pjw@kernel.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Songsong Zhang <U2FsdGVkX1@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Drew Fustini <fustini@kernel.org>
References: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
 <nrvt74qnojaubiwjo37ums4lnclu466hovwrhmtbag6f5uhrql@q6msoe2oto4b>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <nrvt74qnojaubiwjo37ums4lnclu466hovwrhmtbag6f5uhrql@q6msoe2oto4b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXgGxsUQ5q0n72EA--.6636S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4DKw13AryfGFyDKw1UAwb_yoW3Ar4Dpr
	1UJrn0kr48Jw1Uur48t34YqFy5tw4qy3W7JrnrJw1F93Z8Wr1DZrWUKr4UGryDCrs5Xw12
	yr4DKr4UKr4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253413-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,dabbelt.com,ghiti.fr,ventanamicro.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 9D52F59D4B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/26 23:47, Anirudh Srinivasan wrote:
> Hi Vivian, Paul
>
> On Wed, Apr 01, 2026 at 09:53:17AM +0800, Vivian Wang wrote:
>> The unaligned access emulation code in Linux has various deficiencies.
>> For example, it doesn't emulate vector instructions [1] [2], and doesn't
>> emulate KVM guest accesses. Therefore, requesting misaligned exception
>> delegation with SBI FWFT actually regresses vector instructions' and KVM
>> guests' behavior.
>>
>> Until Linux can handle it properly, guard these sbi_fwft_set() calls
>> behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
>> NONPORTABLE. Those who are sure that this wouldn't be a problem can
>> enable this option, perhaps getting better performance.
>>
>> The rest of the existing code proceeds as before, except as if
>> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
>> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
>> implementation is also not touched, but it is disabled if the firmware
>> emulates unaligned accesses.
> On a Tenstorrent Blackhole with SiFive x280 cores, with OpenSBI 1.7 and
> defconfig kernel, I'm seeing a bunch of hangs/opensbi prints at boot time.
> Without this patch, the boot prints this and continues on.
>
> [    0.226339] SBI misaligned access exception delegation ok

Your OpenSBI looks very broken (more on what I mean later), and in a way
that might only manifest if it's trying to emulate vector misaligned
instructions? An interesting thing I can think of is maybe your SiFive
x280 has a very long VLEN (512? 1024? I forgot) which may have exposed
some stuff...

I have two ideas:

Firstly, try bumping this in include/sbi/sbi_platform.h up to 65536 or
something like that. If that works you can also start trying to lower it
to 16384 or something similar.

#define SBI_PLATFORM_DEFAULT_HART_STACK_SIZE    8192

Secondly, there's some extra misaligned emulation patches [1] from Bo
Gan that might help. The stack size being too small is also reported there.

> With this patch, I see a bunch of lines like this
>
> [    0.432225] cpu1: scalar unaligned word access speed is 0.01x byte access speed (slow)
> [    0.432232] cpu0: scalar unaligned word access speed is 0.01x byte access speed (slow)
> [    0.432232] cpu3: scalar unaligned word access speed is 0.01x byte access speed (slow)
> [    0.432232] cpu2: scalar unaligned word access speed is 0.01x byte access speed (slow)
>
> and depending on the boot I either see
>
> sbi_trap_error: hart1: trap1: store fault handler failed (error -3)
> sbi_trap_error: hart1: trap1: mcause=0x0000000000000007 mtval=0x0000000000000000
> sbi_trap_error: hart1: trap1: mepc=0x00004000300241ec mstatus=0x0000000a00001920
> sbi_trap_error: hart1: trap1: ra=0x00004000300241ec sp=0x000040003004ad40
> sbi_trap_error: hart1: trap1: gp=0xffffffff81a2b090 tp=0xffffaf800227e400
> sbi_trap_error: hart1: trap1: s0=0x000040003004ac80 s1=0x000040003000ef42
> sbi_trap_error: hart1: trap1: a0=0x000040003004ceb0 a1=0x000040003004ad18
> sbi_trap_error: hart1: trap1: a2=0x0000000000000000 a3=0xffffaf8002944089
> sbi_trap_error: hart1: trap1: a4=0x00004000300241ec a5=0x0000000000000004
> sbi_trap_error: hart1: trap1: a6=0x000040003004cdf0 a7=0x0000400030010d64
> sbi_trap_error: hart1: trap1: s2=0x0000000000000001 s3=0x0000000000000000
> sbi_trap_error: hart1: trap1: s4=0x000040003004aeb0 s5=0x0000000000000c01
> sbi_trap_error: hart1: trap1: s6=0x0000000000000000 s7=0xffff8f800029b988
> sbi_trap_error: hart1: trap1: s8=0xffffffff812b2fb0 s9=0xffff8f800029bae8
> sbi_trap_error: hart1: trap1: s10=0x0000000000000000 s11=0x0000000000000000
> sbi_trap_error: hart1: trap1: t0=0x0000040000000000 t1=0xffff8f800029bae8
> sbi_trap_error: hart1: trap1: t2=0xffffffff810015e0 t3=0xffffffff819e5cb0
> sbi_trap_error: hart1: trap1: t4=0x0000000000000007 t5=0x0000000000000003
> sbi_trap_error: hart1: trap1: t6=0xffffffff81811d08

That looks to be a null-pointer deref in M-mode, caused by...

> sbi_trap_error: hart1: trap0: mcause=0x0000000000000002 mtval=0x00000000c0102573

rdtime emulation. Your OpenSBI is choking on rdtime emulation with a
null pointer error, which is very odd since that should just be reading
from (A)CLINT mtime?

> [...]
>
> or
>
> [    0.252142] Oops - instruction access fault [#1]

That makes even less sense... I think this was a broken exception
redirection from OpenSBI?

> [    0.252150] Modules linked in:
> [    0.252160] CPU: 2 UID: 0 PID: 63 Comm: kworker/2:1 Not tainted 7.1.0-rc4-next-20260519 #1 PREEMPTLAZY 
> [    0.252167] Hardware name: Tenstorrent Blackhole (DT)
> [    0.252172] Workqueue: events check_vector_unaligned_access
> [    0.252186] epc : __riscv_copy_vec_words_unaligned+0xe/0x24
> [    0.252192]  ra : measure_cycles.constprop.0+0x5e/0xac
> [    0.252197] epc : ffffffff8001a92e ra : ffffffff8001a3f2 sp : ffff8f80002fbca0
> [    0.252201]  gp : ffffffff81a2b090 tp : ffffaf8002a41900 t0 : 0000000000000008
> [    0.252204]  t1 : ffff8d80000ab708 t2 : 0000000000000008 s0 : ffff8f80002fbce0
> [    0.252208]  s1 : 000000001fb5c27a a0 : ffffaf8002add561 a1 : ffffaf8002adf563
> [    0.252211]  a2 : 0000000000001f80 a3 : ffffaf8002adff83 a4 : 0000000000001f80
> [    0.252214]  a5 : 0000000000000072 a6 : ffffffff81036d70 a7 : ffffffff819e5ca0
> [    0.252217]  s2 : ffffffffffffffff s3 : 000000000f37f1cc s4 : ffffffff8001a920
> [    0.252220]  s5 : ffffaf8002adc001 s6 : ffffaf8002ade003 s7 : 0000000000000402
> [    0.252223]  s8 : ffffaf80fe3c2080 s9 : 0000000000000000 s10: 0000000000000000
> [    0.252227]  s11: 0000000000000000 t3 : ffffffff819e5cb0 t4 : 0000000000000007
> [    0.252230]  t5 : 0000000000200b20 t6 : 0000000000000001 ssp : 0000000000000000
> [    0.252233] status: 8000000200000720 badaddr: 0000400030048d30 cause: 0000000000000001

Yeah, that's a Machine mode address... Something is redirecting the
fault while it shouldn't be. Even weirder is it came up to be an
*instruction* access fault - is this address outside of OpenSBI code?
The OpenSBI boot prints should tell you about which address ranges are
code and which are data.

If this is jumping to the stack or something that's very bad in OpenSBI...

> [    0.252237] [<ffffffff8001a92e>] __riscv_copy_vec_words_unaligned+0xe/0x24
> [    0.252243] [<ffffffff8001a46c>] compare_unaligned_access+0x2c/0xac
> [    0.252248] [<ffffffff8001a6bc>] check_vector_unaligned_access+0xb4/0x138
> [    0.252253] [<ffffffff80047f6a>] process_one_work+0x10e/0x354
> [    0.252258] [<ffffffff80048826>] worker_thread+0x136/0x280
> [    0.252263] [<ffffffff800500ca>] kthread+0xda/0xfc
> [    0.252271] [<ffffffff8001358e>] ret_from_fork_kernel+0x1a/0x154
> [    0.252279] [<ffffffff80bb3d9a>] ret_from_fork_kernel_asm+0x16/0x18
> [    0.252291] Code: eee3 fad5 8082 7713 fe06 cf19 86b3 00e5 72d7 cd34 (e007) 0205 
> [    0.252298] ---[ end trace 0000000000000000 ]---
>
>
> Sounds like previously we were relying on misaligned trap delegation
> without knowing it, and now there seem to be some issues in opensbi
> causing these errors.

Given the above very weird symptoms I'm inclined to believe it's
something both badly broken and "simple" like running out of stack and
the different handler overwriting each other's stack. Hence my first
suggestion above to bump the stack size just to be sure.

> Has anyone tested this patch on other HW? Paul, any chance you could
> test this on other SiFive boards?
>
> Regards
> Anirudh Srinivasan

Thanks,
Vivian "dramforever" Wang

[1] https://lore.kernel.org/opensbi/20260210094044.72591-1-ganboing@gmail.com/


