Return-Path: <stable+bounces-158356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF1AE619A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0292B3AE609
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065127E1D7;
	Tue, 24 Jun 2025 09:55:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25A27E7EE
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758912; cv=none; b=qRuL8ADOzexyCfH/LeflCEPWw8sYY8amquTqov2w4/1eH6l3KGx3j8IZ9+8UmnBS3gdHqEJFjLQPWnuK1a6WNIUqilwe3XLaHxlGSGf4WDZk9ac6Z520BPfIL/zDDqiH6Jriq+o+TEXEMG5CsQt9qd1B8gMY06QrJMw2y3iCmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758912; c=relaxed/simple;
	bh=/2mWyWhy4M8WbYqhzcLpxHPdXZveKGRZVWQMonc6/s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qycPWKLcTaW73V7u49mJrIqcX3V4/sIarAIBgdjOBpTp9q0YwibAPjHedQguwI+6AgSDg49sMiriqp0AvMGcE805GAswIK0zZicwyP5V7Y7Wlq0X4bjabfyJceURFjJT65GuYcKTj/JWvO9anzdu5/uWCyx7ZZe+JigS2TDU7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [198.18.0.1] (unknown [210.73.43.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3vgzfdVpo+lb8CA--.50083S2;
	Tue, 24 Jun 2025 17:54:40 +0800 (CST)
Message-ID: <e4025d1a-fdc0-41a9-9076-8e011925701b@iscas.ac.cn>
Date: Tue, 24 Jun 2025 17:54:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
To: Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
 Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
 Charlie Jenkins <charlie@rivosinc.com>, jesse@rivosinc.com, dlan@gentoo.org,
 si.yanteng@linux.dev, research_trasio@irq.a4lg.com, stable@vger.kernel.org
References: <mhng-FC7E1D2C-D4E1-490E-9363-508518B62FE5@palmerdabbelt-mac>
 <da8bcae6-a6e2-4da2-8547-08ed2e35c55f@iscas.ac.cn>
 <f0a2971b-ff67-448f-b8d7-8082b0c77f4f@ghiti.fr>
Content-Language: en-US
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
In-Reply-To: <f0a2971b-ff67-448f-b8d7-8082b0c77f4f@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3vgzfdVpo+lb8CA--.50083S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7KF4rGF43XF15GrykKrg_yoWrCrWkpF
	WY9F1aqa1kXF40v3ZrKw1vqw10q3s5Ar1UJryrK3y3Ar90kryYvFZxtw4xuFsrurs7J3WI
	qr10q348Za4qyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUviL0DUUUU
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/


Hi Alexandre, Palmer,

On 2025/6/23 20:15, Alexandre Ghiti wrote:
> Hi Jingwei, Palmer,
>
> On 6/20/25 10:43, Jingwei Wang wrote:
>>
>> Hi Palmer,
>> On 2025/6/11 06:25, Palmer Dabbelt wrote:
>>> On Wed, 28 May 2025 07:28:19 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
>>>> The riscv_hwprobe vDSO data is populated by init_hwprobe_vdso_data(),
>>>> an arch_initcall_sync. However, underlying data for some keys, like
>>>> RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF, is determined asynchronously.
>>>>
>>>> Specifically, the per_cpu(vector_misaligned_access, cpu) values are set
>>>> by the vec_check_unaligned_access_speed_all_cpus kthread. This kthread
>>>> is spawned by an earlier arch_initcall (check_unaligned_access_all_cpus)
>>>> and may complete its benchmark *after* init_hwprobe_vdso_data() has
>>>> already populated the vDSO with default/stale values.
>>>
>>> IIUC there's another race here: we don't ensure these complete before
>>> allowing userspace to see the values, so if these took so long to probe
>>> userspace started to make hwprobe() calls before they got scheduled we'd
>>> be providing the wrong answer.
>>>
>>> Unless I'm just missing something, though -- I thought we'd looked at that
>>> case?
>>>
>> Thanks for the review. You're right, my current patch doesn't fix the race
>> condition with userspace.
>
>
> I don't think there could be a race since all initcalls are executed sequentially, 
> meaning userspace won't be up before the arch_initcall level is finished. 
>
Yes, the initcall sequence itself provides a guarantee before userspace starts.  
The theoretical race condition I'm concerned about comes from kthread_run, 
which  hands off the probe's execution to the scheduler. This introduces an 
uncertainty  in timing that we shouldn't rely on. The completion mechanism is 
intended to  replace this timing assumption with an explicit, guaranteed 
synchronization point.
>
> But that means that this patch in its current form will probably slow down the 
> whole boot process. To avoid that (and in addition to this patch), can we move 
> init_hwprobe_vdso_data() to late_initcall()? 
>
That's a great point. To check the actual impact, I ran a test on a 64-core QEMU 
setup where I deliberately increased the probe time (from ~2ms to ~256ms by  
adjusting JIFFIES). Even in this worst-case scenario, the probe consistently 
finished  during the subsystem_initcalls. This suggests the real-world 
slowdown from  waiting is quite minimal.  

However, I completely agree with your suggestion. Combining completion with 
a later  initcall is the ideal solution to guarantee both correctness and 
performance. Since  the vDSO data is only consumed by userspace, moving its 
initialization to  late_initcall is perfectly safe and makes the most sense.
>
>>
>> The robust solution here is to use the kernel's `completion`. I've tested
>> this approach: the async probing thread calls `complete()` when finished,
>> and `init_hwprobe_vdso_data()` blocks on `wait_for_completion()`. This
>> guarantees the vDSO data is finalized before userspace can access it.
>>
>>>> So, refresh the vDSO data for specified keys (e.g.,
>>>> MISALIGNED_VECTOR_PERF) ensuring it reflects the final boot-time values.
>>>>
>>>> Test by comparing vDSO and syscall results for affected keys
>>>> (e.g., MISALIGNED_VECTOR_PERF), which now match their final
>>>> boot-time values.
>>>
>>> Wouldn't all the other keys we probe via workqueue be racy as well?
>>>
>> The completion mechanism is easily reusable. If this approach is accepted,
>> I will then identify other potential probe keys and integrate them into
>> this synchronization logic.
>
>
> Yes, I'd say that's the right way to do, there aren't lots of asynchronous 
> initialization stuff so we can handle that when new ones land. 
>
Thank you. I'll prepare a new version of the patch that implements this  
completion + late_initcall approach. I've also had a look, and for now, the  
asynchronous probe for vector misalignment seems to be a special case. The  
completion framework can be easily extended if similar ones land in the future. 

Thanks, 
Jingwei


