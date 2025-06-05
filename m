Return-Path: <stable+bounces-151513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D80ACECCA
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839F9170DC0
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388420C023;
	Thu,  5 Jun 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UDS4Ey5b"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8C1FC0E6
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115679; cv=none; b=jx+HqR2K5k8vi5YjdVqC4P2lJ/xnQIb0NAOOZ0XiXj6nvKqlESKaby9OZqeIv9I9tWYplBeFjZwmD+6eWJrLQSwhk+M7arCvXZd902NXIAmxbu57sCZd6qavP/fJoBxuB2ijbZba1TfS/E6HghlFIcXLf4nRZLQRFEOeUwhv9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115679; c=relaxed/simple;
	bh=ZEyK32eMGAR+g6NZCRqTZyTrVbHeBosYj7RbRq2IjqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B71GY/23Kt+9oijpVvlDqixzNvBogKROKGLxLKA9zecFu+lnkrrclGcQf9ldkR/yDpT91ff5l2ODR3o18eBWZJVJPPy+5WJsi669uKbfB8Nxw/GzqoZlly9fScRMfBKX0b2/asO2W2fg3PARwpcOmqGfrLM/ypVl0W2WO9wZJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UDS4Ey5b; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I0C9stOe9RN4H1EQdBa5SHVsy2V5RbQVPbAs6WsVd8c=; b=UDS4Ey5bLPQxPj5qcEGYOFawKt
	rpscUHm5jXmL+/JDi+ZZS/0eJzsotq+5AbnpA0C+t9/8V+dq4QT8mp+gABDhICN9l2133+YiZDGAh
	l/XvGCFoDTv7Z8E4O9RyLsw7JmG7/GEIcz/67wEU5mkDSHbxTnAx7ByyvRy+9cydDe5dvc3YXdK/X
	E1cJ81Mvu12g9ZZp0vHeFPLt25Vx5EIhyo7DDYu1oRZkeOb6ZN/GRjamiVWsnOZ9aIX4B6F1+/x86
	6uJtf2Epxm21eGLpm5yZKEFCV9Bia/Zp/K1XC1t7kGgdbG/PYZIaI14fWKVcLQPIuz6iIeTQ6j4p9
	iiriZk0A==;
Received: from 170.red-81-39-42.dynamicip.rima-tde.net ([81.39.42.170] helo=[10.0.21.177])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uN6t1-00HS66-O1; Thu, 05 Jun 2025 11:27:47 +0200
Message-ID: <26c90825-35d3-4362-9eaa-28316c7b6b6b@igalia.com>
Date: Thu, 5 Jun 2025 11:27:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Avoid NULL pointer dereference in
 `v3d_job_update_stats()`
Content-Language: en-US
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
References: <20250602151451.10161-1-mcanal@igalia.com>
From: Chema Casanova <jmcasanova@igalia.com>
Organization: Igalia
In-Reply-To: <20250602151451.10161-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch is:

Reviewed-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

But I have a question. Could we see this scenario of the process finishing
before other access to job->file->driver_priv in other parts of the v3d 
driver?

Regards,

Chema

El 2/6/25 a las 17:14, Maíra Canal escribió:
> The following kernel Oops was recently reported by Mesa CI:
>
> [  800.139824] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000588
> [  800.148619] Mem abort info:
> [  800.151402]   ESR = 0x0000000096000005
> [  800.155141]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  800.160444]   SET = 0, FnV = 0
> [  800.163488]   EA = 0, S1PTW = 0
> [  800.166619]   FSC = 0x05: level 1 translation fault
> [  800.171487] Data abort info:
> [  800.174357]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [  800.179832]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  800.184873]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  800.190176] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001014c2000
> [  800.196607] [0000000000000588] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [  800.205305] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [  800.211564] Modules linked in: vc4 snd_soc_hdmi_codec drm_display_helper v3d cec gpu_sched drm_dma_helper drm_shmem_helper drm_kms_helper drm drm_panel_orientation_quirks snd_soc_core snd_compress snd_pcm_dmaengine snd_pcm i2c_brcmstb snd_timer snd backlight
> [  800.234448] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.25+rpt-rpi-v8 #1  Debian 1:6.12.25-1+rpt1
> [  800.244182] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> [  800.250005] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  800.256959] pc : v3d_job_update_stats+0x60/0x130 [v3d]
> [  800.262112] lr : v3d_job_update_stats+0x48/0x130 [v3d]
> [  800.267251] sp : ffffffc080003e60
> [  800.270555] x29: ffffffc080003e60 x28: ffffffd842784980 x27: 0224012000000000
> [  800.277687] x26: ffffffd84277f630 x25: ffffff81012fd800 x24: 0000000000000020
> [  800.284818] x23: ffffff8040238b08 x22: 0000000000000570 x21: 0000000000000158
> [  800.291948] x20: 0000000000000000 x19: ffffff8040238000 x18: 0000000000000000
> [  800.299078] x17: ffffffa8c1bd2000 x16: ffffffc080000000 x15: 0000000000000000
> [  800.306208] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  800.313338] x11: 0000000000000040 x10: 0000000000001a40 x9 : ffffffd83b39757c
> [  800.320468] x8 : ffffffd842786420 x7 : 7fffffffffffffff x6 : 0000000000ef32b0
> [  800.327598] x5 : 00ffffffffffffff x4 : 0000000000000015 x3 : ffffffd842784980
> [  800.334728] x2 : 0000000000000004 x1 : 0000000000010002 x0 : 000000ba4c0ca382
> [  800.341859] Call trace:
> [  800.344294]  v3d_job_update_stats+0x60/0x130 [v3d]
> [  800.349086]  v3d_irq+0x124/0x2e0 [v3d]
> [  800.352835]  __handle_irq_event_percpu+0x58/0x218
> [  800.357539]  handle_irq_event+0x54/0xb8
> [  800.361369]  handle_fasteoi_irq+0xac/0x240
> [  800.365458]  handle_irq_desc+0x48/0x68
> [  800.369200]  generic_handle_domain_irq+0x24/0x38
> [  800.373810]  gic_handle_irq+0x48/0xd8
> [  800.377464]  call_on_irq_stack+0x24/0x58
> [  800.381379]  do_interrupt_handler+0x88/0x98
> [  800.385554]  el1_interrupt+0x34/0x68
> [  800.389123]  el1h_64_irq_handler+0x18/0x28
> [  800.393211]  el1h_64_irq+0x64/0x68
> [  800.396603]  default_idle_call+0x3c/0x168
> [  800.400606]  do_idle+0x1fc/0x230
> [  800.403827]  cpu_startup_entry+0x40/0x50
> [  800.407742]  rest_init+0xe4/0xf0
> [  800.410962]  start_kernel+0x5e8/0x790
> [  800.414616]  __primary_switched+0x80/0x90
> [  800.418622] Code: 8b170277 8b160296 11000421 b9000861 (b9401ac1)
> [  800.424707] ---[ end trace 0000000000000000 ]---
> [  800.457313] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
>
> This issue happens when the file descriptor is closed before the jobs
> submitted by it are completed. When the job completes, we update the
> global GPU stats and the per-fd GPU stats, which are exposed through
> fdinfo. If the file descriptor was closed, then the struct `v3d_file_priv`
> and its stats were already freed and we can't update the per-fd stats.
>
> Therefore, if the file descriptor was already closed, don't update the
> per-fd GPU stats, only update the global ones.
>
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_sched.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 466d28ceee28..5ed676304964 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -199,7 +199,6 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
>   	struct v3d_dev *v3d = job->v3d;
>   	struct v3d_file_priv *file = job->file->driver_priv;
>   	struct v3d_stats *global_stats = &v3d->queue[queue].stats;
> -	struct v3d_stats *local_stats = &file->stats[queue];
>   	u64 now = local_clock();
>   	unsigned long flags;
>   
> @@ -209,7 +208,12 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
>   	else
>   		preempt_disable();
>   
> -	v3d_stats_update(local_stats, now);
> +	/* Don't update the local stats if the file context has already closed */
> +	if (file)
> +		v3d_stats_update(&file->stats[queue], now);
> +	else
> +		drm_dbg(&v3d->drm, "The file descriptor was closed before job completion\n");
> +
>   	v3d_stats_update(global_stats, now);
>   
>   	if (IS_ENABLED(CONFIG_LOCKDEP))

