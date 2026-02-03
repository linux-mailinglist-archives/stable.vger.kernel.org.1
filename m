Return-Path: <stable+bounces-213179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOLKG1WzgWnNIwMAu9opvQ
	(envelope-from <stable+bounces-213179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 09:35:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95534D645E
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 09:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 259813005159
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37C393DE8;
	Tue,  3 Feb 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+Run3yV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k2W0wYPd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB933921F0
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107727; cv=none; b=l8Cy0vDauSq40HjNb4Eo/lRKbgTzS/OT26GLy0UWkHaReT8FPNAfjGlXrb221a5oywntwfO4fih4Ugw1+E0A9RJMLKfPuowNOON1aGD68gBG80jtE0jcip98ZVLslcMwA6/h3qbs+rzC5eP66cVlAB/4j0C/SG6WCbj2aiiI/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107727; c=relaxed/simple;
	bh=qqdXqfAkWHIiS+E3TUwOzvfGUtFEx9QZw4utlQtjxwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J34U6l9QHo37T8+WU3gmduSKPiE+DGZdB+iclnWxefcS9LW8aCd/7uf8/ud1DoN04VneVIzPiSG0T9WrVaixnuYHHoPzitltKWuGapsrRNEZtm5dSRlpSIAXSnt/F45GiwUiBcQ5Mcwgx03RsHYZxC10S5sqyphywQqh3Zls1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+Run3yV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k2W0wYPd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770107724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy0hVPUiK2w0Rez7l2fCnpsK8hrPlTDFnOepXkhOUq8=;
	b=B+Run3yV/uFZiRQREpUxUn64EjeHwj2RoTft3LjtP3tnDX04unAs3gsMlrYFiNQUw+RWc4
	Vjdt4+9w5En9+qPGCOKXCwfsJe5P/swvtkvigo6Og/Q2a1qLYSHXm3cSrRw5TJB7jFFG5U
	0WT2RmyIlc96JR/Ls375dEIaQ+I7TOk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-_D8yd_4hOQeq2EsU3Ssv8A-1; Tue, 03 Feb 2026 03:35:23 -0500
X-MC-Unique: _D8yd_4hOQeq2EsU3Ssv8A-1
X-Mimecast-MFC-AGG-ID: _D8yd_4hOQeq2EsU3Ssv8A_1770107722
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806a27aa31so49685855e9.2
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770107722; x=1770712522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy0hVPUiK2w0Rez7l2fCnpsK8hrPlTDFnOepXkhOUq8=;
        b=k2W0wYPdqD4O6yFHDTLcDCfo6cR8cCzZfn91dm0sDaO58mW5Unqh5JU/C4fKN4ztH5
         ZejAHX+OZeAJUip9U37jlOLbfBAVkrE+lpu6J/pJxrlqLFKvizbk2upbJg3wMyKWxHcM
         7RfgTtiDzUatF8HKh7SuG13nXnpaJNZcJt0U3CdXtbGh98KCoKx7lyuBnjZnz4jouhBf
         BLDLsf3fc2cQSxr70/t1TESEg9t/CZerSmD9Mxktbp4YkVo+cxveA+zdYsd3kXnK2OXG
         PO0yqZE0aAcZ6X7gc+1b55DZVFWY69GIuYnLG6VP4vZbdVcViCibWDPZolkiN+6UvXiA
         LM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770107722; x=1770712522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy0hVPUiK2w0Rez7l2fCnpsK8hrPlTDFnOepXkhOUq8=;
        b=Fk4pIfRbJKyZ9d75Qp2+h2O2iiAkASJbXfjNJyI4L/9jAqSox5bYis+7xdzLfr6x3d
         b4e5j0iDid5k6pRvtSj0CgNPAkgoR/xw3b8ZyQnJfE8ObPXU45pBpzcQBUtNAGDI68Hd
         xU9QwEWqN9PTWk9KG/P/GJYh8423wKs/piLM+dXLEF1yUv/xxBWIxPgLSOOLY3uFJVBN
         /7wN3ifJD49g9KvETTiJFx8CdOMMIjol8R4YK+Ocr7yIvu9UyCzr98fzOvk+k5jZtkMw
         JM51sB3z/V4uc2R4SiqRvBmzO9JjcBlch7cILteOSUw3PnvYDbnD1ckm4FqGK+dFl3T5
         hlLA==
X-Forwarded-Encrypted: i=1; AJvYcCUba3Zh3d3iufix8x99soj2irTKgkLDNf9P4SzL0Q6unyjq2/KBKXTomEbgDX/9U10aAjK9aUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEIehZhXmbyQFi+bqpvrEbpumeEa9pKxAy/26BIW2ipYIFEBY
	+aNX1lOTB0hsBTM+VXDnAEjpxjIVRfbFxHFrV+5v0VE2Xz4CY1p2Jm7b9jf9GzQRSHKdYLXENLE
	HKE4S3iNMpP6u43eklBXkSOr3L6DAG9uevRpk01ASiSPWyVIDMfr8nSWw8A==
X-Gm-Gg: AZuq6aJ+jK/TU25bDHhZjw6KzJOXwpo0Ejl1tZDhb+n3nFhBBr9hOmbroQQ4A32H9cG
	1BpQ5kZl6Ek/5TDtbyKegsfj33t+SBE1BTWfew0rvt0r+B2Y5xBOYHSWQ1bJIN3wk+IfzF+/W3z
	t+JPLsTS72pYH6tYiqGseonrqpfF1zlLOImG4xilSwbMUzKO0gWZwS/2/GWPYfOwYoePH8czyuP
	4jlBD84NT6ahwxMXwvWbbLaEWmf6dvhaymWOb4tXQ5Q3QHl3JmZ4Dtb6aQlLtF0WgUX+qxu0iHY
	3Ksim0gbVW8tP21ukL7bCRTf7yDoQEkMLCnvK6RYI9XDlydsmDVzH8eErUwt3O3YjT0HDgqjtLK
	gK+UoE6NHu1W0OqI0mx0GStWImowS/JljAXgJG8pP3+f05FjaUA==
X-Received: by 2002:a05:600c:4451:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-482db457724mr208563905e9.4.1770107721819;
        Tue, 03 Feb 2026 00:35:21 -0800 (PST)
X-Received: by 2002:a05:600c:4451:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-482db457724mr208563575e9.4.1770107721265;
        Tue, 03 Feb 2026 00:35:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48305129321sm46223605e9.4.2026.02.03.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:35:20 -0800 (PST)
Message-ID: <a274b913-b41f-4fe5-bc56-b45ea030c2b7@redhat.com>
Date: Tue, 3 Feb 2026 09:35:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mgag200: fix mgag200_bmc_stop_scanout()
To: Jacob Keller <jacob.e.keller@intel.com>, Dave Airlie
 <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: Pasi Vaananen <pvaanane@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260202-jk-mgag200-fix-bad-udelay-v2-1-ce1e9665987d@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260202-jk-mgag200-fix-bad-udelay-v2-1-ce1e9665987d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213179-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,intel.com:email]
X-Rspamd-Queue-Id: 95534D645E
X-Rspamd-Action: no action

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

On 03/02/2026 01:16, Jacob Keller wrote:
> The mgag200_bmc_stop_scanout() function is called by the .atomic_disable()
> handler for the MGA G200 VGA BMC encoder. This function performs a few
> register writes to inform the BMC of an upcoming mode change, and then
> polls to wait until the BMC actually stops.
> 
> The polling is implemented using a busy loop with udelay() and an iteration
> timeout of 300, resulting in the function blocking for 300 milliseconds.
> 
> The function gets called ultimately by the output_poll_execute work thread
> for the DRM output change polling thread of the mgag200 driver:
> 
> kworker/0:0-mm_    3528 [000]  4555.315364:
>          ffffffffaa0e25b3 delay_halt.part.0+0x33
>          ffffffffc03f6188 mgag200_bmc_stop_scanout+0x178
>          ffffffffc087ae7a disable_outputs+0x12a
>          ffffffffc087c12a drm_atomic_helper_commit_tail+0x1a
>          ffffffffc03fa7b6 mgag200_mode_config_helper_atomic_commit_tail+0x26
>          ffffffffc087c9c1 commit_tail+0x91
>          ffffffffc087d51b drm_atomic_helper_commit+0x11b
>          ffffffffc0509694 drm_atomic_commit+0xa4
>          ffffffffc05105e8 drm_client_modeset_commit_atomic+0x1e8
>          ffffffffc0510ce6 drm_client_modeset_commit_locked+0x56
>          ffffffffc0510e24 drm_client_modeset_commit+0x24
>          ffffffffc088a743 __drm_fb_helper_restore_fbdev_mode_unlocked+0x93
>          ffffffffc088a683 drm_fb_helper_hotplug_event+0xe3
>          ffffffffc050f8aa drm_client_dev_hotplug+0x9a
>          ffffffffc088555a output_poll_execute+0x29a
>          ffffffffa9b35924 process_one_work+0x194
>          ffffffffa9b364ee worker_thread+0x2fe
>          ffffffffa9b3ecad kthread+0xdd
>          ffffffffa9a08549 ret_from_fork+0x29
> 
> On a server running ptp4l with the mgag200 driver loaded, we found that
> ptp4l would sometimes get blocked from execution because of this busy
> waiting loop.
> 
> Every so often, approximately once every 20 minutes -- though with large
> variance -- the output_poll_execute() thread would detect some sort of
> change that required performing a hotplug event which results in attempting
> to stop the BMC scanout, resulting in a 300msec delay on one CPU.
> 
> On this system, ptp4l was pinned to a single CPU. When the
> output_poll_execute() thread ran on that CPU, it blocked ptp4l from
> executing for its 300 millisecond duration.
> 
> This resulted in PTP service disruptions such as failure to send a SYNC
> message on time, failure to handle ANNOUNCE messages on time, and clock
> check warnings from the application. All of this despite the application
> being configured with FIFO_RT and a higher priority than the background
> workqueue tasks. (However, note that the kernel did not use
> CONFIG_PREEMPT...)
> 
> It is unclear if the event is due to a faulty VGA connection, another bug,
> or actual events causing a change in the connection. At least on the system
> under test it is not a one-time event and consistently causes disruption to
> the time sensitive applications.
> 
> The function has some helpful comments explaining what steps it is
> attempting to take. In particular, step 3a and 3b are explained as such:
> 
>    3a - The third step is to verify if there is an active scan. We are
>         waiting on a 0 on remhsyncsts (<XSPAREREG<0>.
> 
>    3b - This step occurs only if the remove is actually scanning. We are
>         waiting for the end of the frame which is a 1 on remvsyncsts
>         (<XSPAREREG<1>).
> 
> The actual steps 3a and 3b are implemented as while loops with a
> non-sleeping udelay(). The first step iterates while the tmp value at
> position 0 is *not* set. That is, it keeps iterating as long as the bit is
> zero. If the bit is already 0 (because there is no active scan), it will
> iterate the entire 300 attempts which wastes 300 milliseconds in total.
> This is opposite of what the description claims.
> 
> The step 3b logic only executes if we do not iterate over the entire 300
> attempts in the first loop. If it does trigger, it is trying to check and
> wait for a 1 on the remvsyncsts. However, again the condition is actually
> inverted and it will loop as long as the bit is 1, stopping once it hits
> zero (rather than the explained attempt to wait until we see a 1).
> 
> Worse, both loops are implemented using non-sleeping waits which spin
> instead of allowing the scheduler to run other processes. If the kernel is
> not configured to allow arbitrary preemption, it will waste valuable CPU
> time doing nothing.
> 
> There does not appear to be any documentation for the BMC register
> interface, beyond what is in the comments here. It seems more probable that
> the comment here is correct and the implementation accidentally got
> inverted from the intended logic.
> 
> Reading through other DRM driver implementations, it does not appear that
> the .atomic_enable or .atomic_disable handlers need to delay instead of
> sleep. For example, the ast_astdp_encoder_helper_atomic_disable() function
> calls ast_dp_set_phy_sleep() which uses msleep(). The "atomic" in the name
> is referring to the atomic modesetting support, which is the support to
> enable atomic configuration from userspace, and not to the "atomic context"
> of the kernel. There is no reason to use udelay() here if a sleep would be
> sufficient.
> 
> Replace the while loops with a read_poll_timeout() based implementation
> that will sleep between iterations, and which stops polling once the
> condition is met (instead of looping as long as the condition is met). This
> aligns with the commented behavior and avoids blocking on the CPU while
> doing nothing.
> 
> Note the RREG_DAC is implemented using a statement expression to allow
> working properly with the read_poll_timeout family of functions. The other
> RREG_<TYPE> macros ought to be cleaned up to have better semantics, and
> several places in the mgag200 driver could make use of RREG_DAC or similar
> RREG_* macros should likely be cleaned up for better semantics as well, but
> that task has been left as a future cleanup for a non-bugfix.
> 
> Fixes: 414c45310625 ("mgag200: initial g200se driver (v2)")
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> We still do not know if the reconfiguration is caused by a different
> bug or by a faulty VGA connector or something else. However, there is no
> reason that this function should be spinning instead of sleeping while
> waiting for the BMC scan to stop.
> 
> It is known that removing the mgag200 module avoids the issue. It is also
> likely that use of CONFIG_PREEMPT (or CONFIG_PREEMPT_RT) could allow the
> high priority process to preempt the kernel thread even while it is
> delaying. However, it is better to let the process sleep() so that other
> tasks can execute even if these steps are not taken.
> 
> There are multiple other udelay() which likely could safely be converted to
> usleep_range(). However they are all short, and I felt that the smallest
> targeted fix made the most sense. They could perhaps be cleaned up in a
> non-fix commit or series along with other improvements like fixing the
> other RREG_* macros.
> 
> Thanks to Thomas Zimmermann for catching the originally unintended flipping
> of the loop condition, and for helping determine this seems to actually be
> correct. It seems likely that we are blocking for 300 milliseconds every
> time unintentionally because we loop until there is an active scan instead
> of looping until there is no more active scan.
> ---
> Changes in v2:
> - Update the description after the insights from Thomas, and the testing
>    from Jocelyn.
> - Fix some minor typos in the comments.
> - No functional change from v1, though we now explain why we're changing
>    the conditions in the commit message properly.
> - Link to v1: https://patch.msgid.link/20260128-jk-mgag200-fix-bad-udelay-v1-1-db02e04c343d@intel.com
> ---
>   drivers/gpu/drm/mgag200/mgag200_drv.h |  6 ++++++
>   drivers/gpu/drm/mgag200/mgag200_bmc.c | 31 ++++++++++++-------------------
>   2 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
> index f4bf40cd7c88..a875c4bf8cbe 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
> @@ -111,6 +111,12 @@
>   #define DAC_INDEX 0x3c00
>   #define DAC_DATA 0x3c0a
>   
> +#define RREG_DAC(reg)						\
> +	({							\
> +		WREG8(DAC_INDEX, reg);				\
> +		RREG8(DAC_DATA);				\
> +	})							\
> +
>   #define WREG_DAC(reg, v)					\
>   	do {							\
>   		WREG8(DAC_INDEX, reg);				\
> diff --git a/drivers/gpu/drm/mgag200/mgag200_bmc.c b/drivers/gpu/drm/mgag200/mgag200_bmc.c
> index a689c71ff165..bbdeb791c5b3 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_bmc.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_bmc.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
>   #include <linux/delay.h>
> +#include <linux/iopoll.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_edid.h>
> @@ -12,7 +13,7 @@
>   void mgag200_bmc_stop_scanout(struct mga_device *mdev)
>   {
>   	u8 tmp;
> -	int iter_max;
> +	int ret;
>   
>   	/*
>   	 * 1 - The first step is to inform the BMC of an upcoming mode
> @@ -42,30 +43,22 @@ void mgag200_bmc_stop_scanout(struct mga_device *mdev)
>   
>   	/*
>   	 * 3a- The third step is to verify if there is an active scan.
> -	 * We are waiting for a 0 on remhsyncsts <XSPAREREG<0>).
> +	 * We are waiting for a 0 on remhsyncsts (<XSPAREREG<0>).
>   	 */
> -	iter_max = 300;
> -	while (!(tmp & 0x1) && iter_max) {
> -		WREG8(DAC_INDEX, MGA1064_SPAREREG);
> -		tmp = RREG8(DAC_DATA);
> -		udelay(1000);
> -		iter_max--;
> -	}
> +	ret = read_poll_timeout(RREG_DAC, tmp, !(tmp & 0x1),
> +				1000, 300000, false,
> +				MGA1064_SPAREREG);
> +	if (ret == -ETIMEDOUT)
> +		return;
>   
>   	/*
> -	 * 3b- This step occurs only if the remove is actually
> +	 * 3b- This step occurs only if the remote BMC is actually
>   	 * scanning. We are waiting for the end of the frame which is
>   	 * a 1 on remvsyncsts (XSPAREREG<1>)
>   	 */
> -	if (iter_max) {
> -		iter_max = 300;
> -		while ((tmp & 0x2) && iter_max) {
> -			WREG8(DAC_INDEX, MGA1064_SPAREREG);
> -			tmp = RREG8(DAC_DATA);
> -			udelay(1000);
> -			iter_max--;
> -		}
> -	}
> +	(void)read_poll_timeout(RREG_DAC, tmp, (tmp & 0x2),
> +				1000, 300000, false,
> +				MGA1064_SPAREREG);
>   }
>   
>   void mgag200_bmc_start_scanout(struct mga_device *mdev)
> 
> ---
> base-commit: e535c23513c63f02f67e3e09e0787907029efeaf
> change-id: 20260127-jk-mgag200-fix-bad-udelay-409133777e3a
> 
> Best regards,
> --
> Jacob Keller <jacob.e.keller@intel.com>
> 


