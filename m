Return-Path: <stable+bounces-152740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F5ADBD3F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926DB7A7EF9
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633861F4701;
	Mon, 16 Jun 2025 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NXofV0iz"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA072264D2
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114211; cv=none; b=WAj1Ydl6tllxKHO/6lgwPUsQChVyGW7iV7+yygKDmzKclonezAJxKGURuvM34/2Da4S44Bi5i6A1RIXcfUkcX+XMIQQ5gmdo6o3yYhwMkGWEyuMS7eNUjtyUZXBUV1+XFS3prRBkqwsigbwH3COEcd91j+NJgOWjb3tjTdjcTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114211; c=relaxed/simple;
	bh=u3myzeYQQNI4dGJ7CXo/S6LUtXZyGM8dl3Q3XM39EHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3dolpOP6SSLSwJNKm1ZhVp2CgCQ7QznAt524XuK2hPAxczsHrh8Z3BH3PGhu5n8aLWg4Qpf2UxceW+RPYfLtRclyasZw8T3mxoydqREuJaOEG8XNr1JGfRlSydjWsgku6R4uBUWw8lZZFwrHI4m1+AYCL6WI17A3doDwmibRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NXofV0iz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=STkfK+n2QqOrf5nWntXxakMH/bhkRXMM6hSudnVMFW4=; b=NXofV0izkEYEama37BKSWMu3qu
	jOpn9HWlpUyFB1538ccXM/l79uwnjuknbhis02ug2Skxai5aO+SsBcM8ObDgfrf5cF4Lv83WslHM3
	XY7RSmU99R4jIrloskxtGvJuM+EYrZ12khoNEy9sh0MiezGtrBZACnZIdUUcjm9cbgNUtG7TyQwi8
	epjrEHmENrgJvgArJsVo3YLwqJx14wi0waJureW5XB+rE6NbFrVUZfikyeWcdiFicLsz2wcwZVZnX
	LVmVv5oA9pF32roZzbOWL+OeZ5Sn/jcYfPFzAj0WStlLwpPJ9+dp9VIMCZzhTxJMjCc8Yr0mm+6aN
	Syjyfp7g==;
Received: from [189.7.87.79] (helo=[192.168.0.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uRIeP-004Ju1-8c; Tue, 17 Jun 2025 00:50:02 +0200
Message-ID: <060d2738-064a-4075-9352-dfc43fff207b@igalia.com>
Date: Mon, 16 Jun 2025 19:49:54 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Avoid NULL pointer dereference in
 `v3d_job_update_stats()`
To: Chema Casanova <jmcasanova@igalia.com>, Melissa Wen <mwen@igalia.com>,
 Iago Toral <itoral@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
References: <20250602151451.10161-1-mcanal@igalia.com>
 <26c90825-35d3-4362-9eaa-28316c7b6b6b@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <26c90825-35d3-4362-9eaa-28316c7b6b6b@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chema,

On 05/06/25 06:27, Chema Casanova wrote:
> This patch is:
> 
> Reviewed-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
> 
> But I have a question. Could we see this scenario of the process finishing
> before other access to job->file->driver_priv in other parts of the v3d 
> driver?

Although we access `job->file->driver_priv` in other parts of the
driver, the other accesses aren't problematic as far as I could check.

With that, I applied the patch to misc/kernel.git (drm-misc-fixes).

Thanks for the review!

Best Regards,
- Maíra

> 
> Regards,
> 
> Chema
> 
> El 2/6/25 a las 17:14, Maíra Canal escribió:
>> The following kernel Oops was recently reported by Mesa CI:
>>
>> [  800.139824] Unable to handle kernel NULL pointer dereference at 
>> virtual address 0000000000000588
>> [  800.148619] Mem abort info:
>> [  800.151402]   ESR = 0x0000000096000005
>> [  800.155141]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  800.160444]   SET = 0, FnV = 0
>> [  800.163488]   EA = 0, S1PTW = 0
>> [  800.166619]   FSC = 0x05: level 1 translation fault
>> [  800.171487] Data abort info:
>> [  800.174357]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>> [  800.179832]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [  800.184873]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [  800.190176] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001014c2000
>> [  800.196607] [0000000000000588] pgd=0000000000000000, 
>> p4d=0000000000000000, pud=0000000000000000
>> [  800.205305] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>> [  800.211564] Modules linked in: vc4 snd_soc_hdmi_codec 
>> drm_display_helper v3d cec gpu_sched drm_dma_helper drm_shmem_helper 
>> drm_kms_helper drm drm_panel_orientation_quirks snd_soc_core 
>> snd_compress snd_pcm_dmaengine snd_pcm i2c_brcmstb snd_timer snd 
>> backlight
>> [  800.234448] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
>> 6.12.25+rpt-rpi-v8 #1  Debian 1:6.12.25-1+rpt1
>> [  800.244182] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
>> [  800.250005] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
>> BTYPE=--)
>> [  800.256959] pc : v3d_job_update_stats+0x60/0x130 [v3d]
>> [  800.262112] lr : v3d_job_update_stats+0x48/0x130 [v3d]
>> [  800.267251] sp : ffffffc080003e60
>> [  800.270555] x29: ffffffc080003e60 x28: ffffffd842784980 x27: 
>> 0224012000000000
>> [  800.277687] x26: ffffffd84277f630 x25: ffffff81012fd800 x24: 
>> 0000000000000020
>> [  800.284818] x23: ffffff8040238b08 x22: 0000000000000570 x21: 
>> 0000000000000158
>> [  800.291948] x20: 0000000000000000 x19: ffffff8040238000 x18: 
>> 0000000000000000
>> [  800.299078] x17: ffffffa8c1bd2000 x16: ffffffc080000000 x15: 
>> 0000000000000000
>> [  800.306208] x14: 0000000000000000 x13: 0000000000000000 x12: 
>> 0000000000000000
>> [  800.313338] x11: 0000000000000040 x10: 0000000000001a40 x9 : 
>> ffffffd83b39757c
>> [  800.320468] x8 : ffffffd842786420 x7 : 7fffffffffffffff x6 : 
>> 0000000000ef32b0
>> [  800.327598] x5 : 00ffffffffffffff x4 : 0000000000000015 x3 : 
>> ffffffd842784980
>> [  800.334728] x2 : 0000000000000004 x1 : 0000000000010002 x0 : 
>> 000000ba4c0ca382
>> [  800.341859] Call trace:
>> [  800.344294]  v3d_job_update_stats+0x60/0x130 [v3d]
>> [  800.349086]  v3d_irq+0x124/0x2e0 [v3d]
>> [  800.352835]  __handle_irq_event_percpu+0x58/0x218
>> [  800.357539]  handle_irq_event+0x54/0xb8
>> [  800.361369]  handle_fasteoi_irq+0xac/0x240
>> [  800.365458]  handle_irq_desc+0x48/0x68
>> [  800.369200]  generic_handle_domain_irq+0x24/0x38
>> [  800.373810]  gic_handle_irq+0x48/0xd8
>> [  800.377464]  call_on_irq_stack+0x24/0x58
>> [  800.381379]  do_interrupt_handler+0x88/0x98
>> [  800.385554]  el1_interrupt+0x34/0x68
>> [  800.389123]  el1h_64_irq_handler+0x18/0x28
>> [  800.393211]  el1h_64_irq+0x64/0x68
>> [  800.396603]  default_idle_call+0x3c/0x168
>> [  800.400606]  do_idle+0x1fc/0x230
>> [  800.403827]  cpu_startup_entry+0x40/0x50
>> [  800.407742]  rest_init+0xe4/0xf0
>> [  800.410962]  start_kernel+0x5e8/0x790
>> [  800.414616]  __primary_switched+0x80/0x90
>> [  800.418622] Code: 8b170277 8b160296 11000421 b9000861 (b9401ac1)
>> [  800.424707] ---[ end trace 0000000000000000 ]---
>> [  800.457313] ---[ end Kernel panic - not syncing: Oops: Fatal 
>> exception in interrupt ]---
>>
>> This issue happens when the file descriptor is closed before the jobs
>> submitted by it are completed. When the job completes, we update the
>> global GPU stats and the per-fd GPU stats, which are exposed through
>> fdinfo. If the file descriptor was closed, then the struct 
>> `v3d_file_priv`
>> and its stats were already freed and we can't update the per-fd stats.
>>
>> Therefore, if the file descriptor was already closed, don't update the
>> per-fd GPU stats, only update the global ones.
>>
>> Cc: stable@vger.kernel.org # v6.12+
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_sched.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/ 
>> v3d_sched.c
>> index 466d28ceee28..5ed676304964 100644
>> --- a/drivers/gpu/drm/v3d/v3d_sched.c
>> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
>> @@ -199,7 +199,6 @@ v3d_job_update_stats(struct v3d_job *job, enum 
>> v3d_queue queue)
>>       struct v3d_dev *v3d = job->v3d;
>>       struct v3d_file_priv *file = job->file->driver_priv;
>>       struct v3d_stats *global_stats = &v3d->queue[queue].stats;
>> -    struct v3d_stats *local_stats = &file->stats[queue];
>>       u64 now = local_clock();
>>       unsigned long flags;
>> @@ -209,7 +208,12 @@ v3d_job_update_stats(struct v3d_job *job, enum 
>> v3d_queue queue)
>>       else
>>           preempt_disable();
>> -    v3d_stats_update(local_stats, now);
>> +    /* Don't update the local stats if the file context has already 
>> closed */
>> +    if (file)
>> +        v3d_stats_update(&file->stats[queue], now);
>> +    else
>> +        drm_dbg(&v3d->drm, "The file descriptor was closed before job 
>> completion\n");
>> +
>>       v3d_stats_update(global_stats, now);
>>       if (IS_ENABLED(CONFIG_LOCKDEP))


