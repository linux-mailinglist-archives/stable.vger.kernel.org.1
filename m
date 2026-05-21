Return-Path: <stable+bounces-253516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNOPK7L5DmoSDwYAu9opvQ
	(envelope-from <stable+bounces-253516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:25:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D45A4BE1
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AAB3004233
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64C3CF66C;
	Thu, 21 May 2026 12:18:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63F3C7693;
	Thu, 21 May 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365930; cv=none; b=J/BqDcB1HNcKjy3OGNbAczi7RzbpDj1tAudrtMohNXU0X/J9XjCNyDfllftKs/RHD2gGtqbpVUDWvVVGpkgg3reFmGMg6EjxQ0AxrQ221+wYCu08BR0fKfON2QnCC/WUUdOIZfeqdwu9BnuDXhrnAJBdBBFkp3ruCytcpiVfsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365930; c=relaxed/simple;
	bh=WtzEe2PyHbhjo8rMgYfE7tvDVgINqwgYAed2GhwV+J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6b20FOpv+D6eCjyZAfSJorN7CB09SAF+TcYuEQZcpvJbYDw0cvIu/OPLZ+HJViXk+y7G1guopnkBUPhLJG07dAKYTjCFhm2SxQKlcMiLW+z6WsUQff38ivXwzkIsewHEFYLXCLGLG0LX0lZgwG5MUk3p4hBrEmiLGNvsBcw3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [123.118.218.47])
	by APP-01 (Coremail) with SMTP id qwCowABX_mkV+A5q_z0IEQ--.5407S2;
	Thu, 21 May 2026 20:18:30 +0800 (CST)
Message-ID: <825c93ad-bb68-443a-8c0a-9c5e62e08ac0@iscas.ac.cn>
Date: Thu, 21 May 2026 20:18:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: misaligned: Make enabling delegation depend on
 NONPORTABLE
To: Michael Ellerman <mpe@kernel.org>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Paul Walmsley <pjw@kernel.org>, Bo Gan <ganboing@gmail.com>,
 Anup Patel <anup@brainfault.org>, opensbi@lists.infradead.org
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Songsong Zhang <U2FsdGVkX1@gmail.com>,
 Drew Fustini <fustini@kernel.org>
References: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
 <nrvt74qnojaubiwjo37ums4lnclu466hovwrhmtbag6f5uhrql@q6msoe2oto4b>
 <cec3dd9c-37d8-4859-bfe0-a42ee3efdc97@iscas.ac.cn>
 <a2a5621f-4be1-4e39-8434-9a6009c8f762@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <a2a5621f-4be1-4e39-8434-9a6009c8f762@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABX_mkV+A5q_z0IEQ--.5407S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryxZw1fCrWDKry3tr4ktFb_yoWrXw4fpF
	WkWF17KFWUtr18Zr1xKwnFqFWjqr48Gw47Jrn8Ja4akr90vF1IqrWIqr4Y9F9FgrW8G342
	vry0yry5uFy5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,oss.tenstorrent.com,gmail.com,brainfault.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253516-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rivosinc.com,dabbelt.com,ghiti.fr,ventanamicro.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 188D45A4BE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Anup, Bo, OpenSBI list: It's the already reported issue where
SBI_PLATFORM_DEFAULT_HART_STACK_SIZE is not enough for
sbi_misaligned_v_ld_emulator. How should we approach this? ]

On 5/21/26 19:49, Michael Ellerman wrote:
> On 21/5/2026 10:27, Vivian Wang wrote:
>>
>> On 5/20/26 23:47, Anirudh Srinivasan wrote:
>>> Hi Vivian, Paul
>>>
>>> On Wed, Apr 01, 2026 at 09:53:17AM +0800, Vivian Wang wrote:
>>>> The unaligned access emulation code in Linux has various deficiencies.
>>>> For example, it doesn't emulate vector instructions [1] [2], and
>>>> doesn't
>>>> emulate KVM guest accesses. Therefore, requesting misaligned exception
>>>> delegation with SBI FWFT actually regresses vector instructions'
>>>> and KVM
>>>> guests' behavior.
>>>>
>>>> Until Linux can handle it properly, guard these sbi_fwft_set() calls
>>>> behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
>>>> NONPORTABLE. Those who are sure that this wouldn't be a problem can
>>>> enable this option, perhaps getting better performance.
>>>>
>>>> The rest of the existing code proceeds as before, except as if
>>>> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any
>>>> remaining
>>>> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
>>>> implementation is also not touched, but it is disabled if the firmware
>>>> emulates unaligned accesses.
>>> On a Tenstorrent Blackhole with SiFive x280 cores, with OpenSBI 1.7 and
>>> defconfig kernel, I'm seeing a bunch of hangs/opensbi prints at boot
>>> time.
>>> Without this patch, the boot prints this and continues on.
>>>
>>> [    0.226339] SBI misaligned access exception delegation ok
>>
>> Your OpenSBI looks very broken (more on what I mean later), and in a way
>> that might only manifest if it's trying to emulate vector misaligned
>> instructions? An interesting thing I can think of is maybe your SiFive
>> x280 has a very long VLEN (512? 1024? I forgot) which may have exposed
>> some stuff...
>
> It's 512.
>
>> I have two ideas:
>>
>> Firstly, try bumping this in include/sbi/sbi_platform.h up to 65536 or
>> something like that. If that works you can also start trying to lower it
>> to 16384 or something similar.
>>
>> #define SBI_PLATFORM_DEFAULT_HART_STACK_SIZE    8192
>
> Yep, bumping that to 16384 fixes it for me.
>
Thanks for confirming. I've already told Greg to drop the stable
backport [2]. I still think that's the right thing to do - users on
older stable kernels don't need to get surprised by this.

> The culprit is in lib/sbi/sbi_trap_v_ldst.c:
>
> #define VLEN_MAX 65536
> ...
>
> int sbi_misaligned_v_ld_emulator(int rlen, union sbi_ldst_data *out_val,
>                                  struct sbi_trap_context *tcntx)
> {
>         const struct sbi_trap_info *orig_trap = &tcntx->trap;
> ...
>         uint8_t mask[VLEN_MAX / 8];
>
>
> ie. 8KB on stack buffer.

Yes, thanks. That's the one I had in mind but forgot the exact location of.

>
> Shrinking VLEN_MAX to 4096 also gets it booting. But I guess that's
> not viable because in theory someone might build a chip with VLEN
> 65536 one day?
>
> Would a heap allocation at boot be better?
>
Allocation on boot would probably be better. Or maybe there's some way
to refactor it to not use so much stack.

> Or just force the stack to be bigger when vector is enabled, eg:
>
> [...]

Possibly. I'm not sure. "CC_SUPPORTS" sounds wrong.

I haven't dealt with OpenSBI for a good while so I don't have much of an
idea about what should be done here. Bo Gan's thread on the OpenSBI list
[1] is probably a better place to talk about this. Or maybe we should
send a patch to bump the stack size first and try to deal with it later. 

Vivian "dramforever" Wang

[1]:
https://lore.kernel.org/opensbi/20260210094044.72591-1-ganboing@gmail.com/
[2]:
https://lore.kernel.org/stable/99c8c715-b37f-4f2a-8100-5ea4970ff34d@iscas.ac.cn/


