Return-Path: <stable+bounces-160252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96109AF9FD5
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142163BFC89
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A68246BC9;
	Sat,  5 Jul 2025 11:24:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71872E3707
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714682; cv=none; b=FK0JoDV1IHEp62b3y/EfBn9BOkCFHI+td15RlqT8+p/SIimjpiqjgRhfXD/YavidCN41+9aCvP6N6CZLgvTmHPQi4OFgXoPCc0W1JycvHr5DiF4pppl/MucaIL2l6+d+trh3IJ7FaaTXWHfV0+IrCo5h5O4B0ErGhoFt8PxlfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714682; c=relaxed/simple;
	bh=y/OUVmX/DGtQKU06WL90xI9QoLn7Y3p5tA2OYERATV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKmcBexfiRanyovP8mXsC6FjWoX/NtYQBSti36WykxGCxx9cPNB073cdPz4gWeiNILAc+iD38ui9p9IVl/I7cI4755IkzfSqXYy/CawwIX89Jz8yIBBxAQCkebF1n4vTtQs3MSpQdCxhuWNaXNEtTv/LNjy5f3OW6A/N03BxBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [223.72.70.63])
	by APP-05 (Coremail) with SMTP id zQCowADnP2BYC2loYu0zAQ--.4844S2;
	Sat, 05 Jul 2025 19:24:08 +0800 (CST)
Date: Sat, 5 Jul 2025 19:24:08 +0800
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>, Yixun Lan <dlan@gentoo.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Tsukasa OI <research_trasio@irq.a4lg.com>, stable@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
Message-ID: <aGkLWItEnzYkc9VJ@Jingweis-MacBook-Air.local>
References: <20250627172814.66367-1-wangjingwei@iscas.ac.cn>
 <a57e83be-c506-4ab4-962d-4cdbce4aaed9@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57e83be-c506-4ab4-962d-4cdbce4aaed9@ghiti.fr>
X-CM-TRANSID:zQCowADnP2BYC2loYu0zAQ--.4844S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4kGF1UArWrJFWrJr4Dtwb_yoW7Gr48pF
	Wqkr4YyFZ5JrWxuF9rKr1IvF10qan5Gr13Jr1DKryUXryjvr13Jr93KrsrAr1DZF98K340
	vF45Wa9Ik3y7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ec7CjxVAajcxG14v26r1j6r
	4UMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyItCDUUUU
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/

Hi Alexandre,

On Mon, Jun 30, 2025 at 09:34:28AM +0200, Alexandre Ghiti wrote:
> Hi Jingwei,
>
> On 6/27/25 19:27, Jingwei Wang wrote:
> > The value for some hwprobe keys, like MISALIGNED_VECTOR_PERF, is
> > determined by an asynchronous kthread. This kthread can finish after
> > the hwprobe vDSO data is populated, creating a race condition where
> > userspace can read stale values.
> >
> > A completion-based framework is introduced to synchronize the async
> > probes with the vDSO population. The init_hwprobe_vdso_data()
> > function is deferred to `late_initcall` and now blocks until all
> > probes signal completion.
>
>
> Can you add an explanation of why the move to late_initcall() here?
>
Sure. I'll add that in the next version.
>
> >
> > Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> > Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
> > Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> > ---
> > Changes in v4:
> > 	- Reworked the synchronization mechanism based on feedback from Palmer
> >      	and Alexandre.
> > 	- Instead of a post-hoc refresh, this version introduces a robust
> > 	completion-based framework using an atomic counter to ensure async
> > 	probes are finished before populating the vDSO.
> > 	- Moved the vdso data initialization to a late_initcall to avoid
> > 	impacting boot time.
> >
> > Changes in v3:
> > 	- Retained existing blank line.
> >
> > Changes in v2:
> > 	- Addressed feedback from Yixun's regarding #ifdef CONFIG_MMU usage.
> > 	- Updated commit message to provide a high-level summary.
> > 	- Added Fixes tag for commit e7c9d66e313b.
> >
> > v1: https://lore.kernel.org/linux-riscv/20250521052754.185231-1-wangjingwei@iscas.ac.cn/T/#u
> >
> >   arch/riscv/include/asm/hwprobe.h           |  8 +++++++-
> >   arch/riscv/kernel/sys_hwprobe.c            | 20 +++++++++++++++++++-
> >   arch/riscv/kernel/unaligned_access_speed.c |  9 +++++++--
> >   3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > index 7fe0a379474ae2c6..87af186d92e75ddb 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
> >   	return pair->value == other_pair->value;
> >   }
> > -
> > +#ifdef CONFIG_MMU
> > +void riscv_hwprobe_register_async_probe(void);
> > +void riscv_hwprobe_complete_async_probe(void);
> > +#else
> > +inline void riscv_hwprobe_register_async_probe(void) {}
> > +inline void riscv_hwprobe_complete_async_probe(void) {}
> > +#endif
> >   #endif
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index 0b170e18a2beba57..8c50dcec2b754c30 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -5,6 +5,8 @@
> >    * more details.
> >    */
> >   #include <linux/syscalls.h>
> > +#include <linux/completion.h>
> > +#include <linux/atomic.h>
> >   #include <asm/cacheflush.h>
> >   #include <asm/cpufeature.h>
> >   #include <asm/hwprobe.h>
> > @@ -467,6 +469,20 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
> >   #ifdef CONFIG_MMU
> > +static DECLARE_COMPLETION(boot_probes_done);
> > +static atomic_t pending_boot_probes = ATOMIC_INIT(0);
> > +
> > +void riscv_hwprobe_register_async_probe(void)
> > +{
> > +	atomic_inc(&pending_boot_probes);
> > +}
> > +
> > +void riscv_hwprobe_complete_async_probe(void)
> > +{
> > +	if (atomic_dec_and_test(&pending_boot_probes))
> > +		complete(&boot_probes_done);
> > +}
> > +
> >   static int __init init_hwprobe_vdso_data(void)
> >   {
> >   	struct vdso_arch_data *avd = vdso_k_arch_data;
> > @@ -474,6 +490,8 @@ static int __init init_hwprobe_vdso_data(void)
> >   	struct riscv_hwprobe pair;
> >   	int key;
> > +	if (unlikely(atomic_read(&pending_boot_probes) > 0))
> > +		wait_for_completion(&boot_probes_done);
>
>
> To me it's not working: if a first async probe registers and completes
> before another async probe registers, pending_boot_probes will be > 0 but
> wait_for_completion() will proceed before the second async probe completes
> (since the first async probe marked the completion as done).
>
> Let me know if I missed something,
>
You're right, I made a mistake here when I rewrote my patch. I will
rework this in v5 to use the "sentinel-count" pattern (initializing the
atomic counter to 1).Thank you so much.

I was having some issues with my email client, and it seems my previous
replies might not have gone through. It appears to be working now, and
I will send out the v5 patch shortly.

Thanks,
Jingwei


