Return-Path: <stable+bounces-211436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xK5TNQgMdGlG1wAAu9opvQ
	(envelope-from <stable+bounces-211436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 01:02:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7657B934
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 01:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59A8301572C
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907351373;
	Sat, 24 Jan 2026 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j2DzqW7V"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39E38D
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769212933; cv=none; b=NtS9KwcV1uNajFrTAfDXjeMaUPYmSlIipPe//hiaQzZR/qpIt6gBkkaqHZw/l8IOPF9J/OIKB1B6voedJCmO4syryIHVxNVbXaTY1Fp0UBjChn8HY/b8iff8IJa+tlBCA8IAPtqwBXiNkU2l/GFui4P8XmvwNhUOQJqpE0VbzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769212933; c=relaxed/simple;
	bh=McfmxtPH9+iWC1nGp8gWsDTFhIjSA6p2id/xCPffMLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6GSWFcokRqPjkOY1IlOwXTsu0+g52tMk7U4FIt+DJGqwD/fd8QO2Y4o2pin5n/SGjeBtFeAByJJmpWcMKHsZu4+5nJetBtTGHAx2YvtMH7gs4CHsMz9QaRFnYQUvQYnc3Mn/T5f0LUW2jZeMmW8g7x2Z7B2E47D0b2yaxtMvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j2DzqW7V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso105676666b.2
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 16:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769212928; x=1769817728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuCDz9F8Ho603yGMU1x5Pa2VnQyzmdC16O9gi5uXdh8=;
        b=j2DzqW7Vy5zD6IgB+QmhycfPLAPUyyvutzRhilz37n9lqBbTaP3RSOjKvimYOQ++DX
         +tevlBEWmTfEaC00hgFKYjia/R+A0bfwbwagUmCuqnwyIqiuxfFK+YeZS9tlV40kECRb
         oshbdGTwq90YRrNuROFHgKbiwtru1YGFpK9dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769212928; x=1769817728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuCDz9F8Ho603yGMU1x5Pa2VnQyzmdC16O9gi5uXdh8=;
        b=MUjeBvYURVv5lZM7i8UQMDlwMpxXNO35lKd+fya4Als7ZG/4pUmgxB5dtSllO0B8Tn
         7g2z2XJCtDuZbS902NAOh27BiV7hR7M4VodJrBATjTwhJMPVRc8n6qeneyWv9G5TxLW9
         RIhOisqu4uNA1AP8JmjpN9Fd7v+zYxLfzpG2+EslyRNJzKL3Oouse/9gDFHFEmbxCv4U
         hSrK2tN8TxXqvwy2pZeVQdL6P71jcUUbuNciIzuvRh+24i+daZUi/HV6fZeoHAprXMQf
         jRqaZQ/ZBwmyLtAiXpXf6IcKyZV1a8D38WMauCz8VfZ4zZdj3tBb96tnyVkBUDQ/6NyE
         J5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwL9f6bsEteJORuvn751rj/dCNA4sr1LyZfrZR+AG7UQjoiyoh0Bl0XZW2PqNk1lzBwBNDn0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4VX7btmxjebC1HyfIGVhBmerfZ1lANGo2HT/Kr2wAXOs0EBE
	TrkZ70bidPY8OHczMNvttah55ZqEDYs3H8NlgZI1bmrUfN471bILExAs4qcadKudcEmnOtIU6fd
	fZON6LSZz
X-Gm-Gg: AZuq6aLUVGcf1/FxPgUaxUxDwjXtUoeOjrWLZ6L+r3aPR/QEc6vuQIqlAMD7oMdWw6h
	PZq/GsboQIGnTL83jb4QII10uxUXRmqvHTiJKeXyhzriguUp2YglXPlur1j3x7ml82C1l6l8DMm
	uJIhxb4EKxCc/9ajSe0CuZoR4Ooh9ar/ek3BmznNkZvLs1ZbfeEwR3pO/k0T0/nDsbnZR20ccQL
	Nwzh+XFr/iAtMooRCmJ+A5IVhgpTZROooaIxD262Rt2Awea98NGxP8dSDMFa2zuId+QO9jhvGz/
	B9QwJmOZjDk34CfmwRDUYFWB2beEUxYFRpA5sOBnlTTsPVRfyAnm3knLFlIc26/DuJzNWPI5hHX
	Csl4V5tM/fXy+RdU9d3sTYFXbKVKsBocja5BcrVPWXBQJoBw+cK67qlEAbvxJW2XwLWqrchzONd
	/CcsGVTKx3wdoHCGCJu6Yci9FNje9F/WG1btlC/xi38aH84kHOjQ==
X-Received: by 2002:a17:907:6d22:b0:b88:241e:693c with SMTP id a640c23a62f3a-b885ad2930bmr370043766b.31.1769212928391;
        Fri, 23 Jan 2026 16:02:08 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b766733sm176585666b.55.2026.01.23.16.02.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 16:02:07 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435a517be33so1666025f8f.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 16:02:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkZIAy9/KYJ7o16RhnHP7w9/2k0LsrTV9NS5hqM/Ez/6Pis+taLbL3VknwuJdYJEawYWs6cbs=@vger.kernel.org
X-Received: by 2002:a05:6000:4287:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-435b16179cbmr7571899f8f.50.1769212926845; Fri, 23 Jan 2026
 16:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=UGpqN3XsHWM9coRdez2mL8mz0_hsUMQttTqaD7oEvSEQ@mail.gmail.com>
 <20260123063407.248775-1-realwujing@gmail.com>
In-Reply-To: <20260123063407.248775-1-realwujing@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 23 Jan 2026 16:01:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
X-Gm-Features: AZwV_Qgww6BU2s9o8UKPxUEj0exFCvl8FVpkSFp-7jScwFxXAI9t3KfOSr0cnoY
Message-ID: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
Subject: Re: [PATCH v3] watchdog/hardlockup: Fix UAF in perf event cleanup due
 to migration race
To: Qiliang Yuan <realwujing@gmail.com>
Cc: akpm@linux-foundation.org, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, song@kernel.org, 
	stable@vger.kernel.org, sunshx@chinatelecom.cn, thorsten.blum@linux.dev, 
	wangjinchao600@gmail.com, yangyicong@hisilicon.com, yuanql9@chinatelecom.cn, 
	zhangjn11@chinatelecom.cn, mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,chinatelecom.cn,linux.dev,gmail.com,hisilicon.com];
	TAGGED_FROM(0.00)[bounces-211436-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 2B7657B934
X-Rspamd-Action: no action

Hi,

On Thu, Jan 22, 2026 at 10:34=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com=
> wrote:
>
> During the early initialization of the hardlockup detector, the
> hardlockup_detector_perf_init() function probes for PMU hardware availabi=
lity.
> It originally used hardlockup_detector_event_create(), which interacts wi=
th
> the per-cpu 'watchdog_ev' variable.
>
> If the initializing task migrates to another CPU during this probe phase,
> two issues arise:
> 1. The 'watchdog_ev' pointer on the original CPU is set but not cleared,
>    leaving a stale pointer to a freed perf event.
> 2. The 'watchdog_ev' pointer on the new CPU might be incorrectly cleared.
>
> This race condition was observed in console logs (captured by adding debu=
g printks):
>
> [23.038376] hardlockup_detector_perf_init 313 cur_cpu=3D2

Wait a second... The above function hasn't existed for 2.5 years. It
was removed in commit d9b3629ade8e ("watchdog/hardlockup: have the
perf hardlockup use __weak functions more cleanly"). All that's left
in the ToT kernel referencing that function is an old comment...

Oh, and I guess I can see below that your stack traces are on 4.19,
which is ancient! Things have changed a bit in the meantime. Are you
certain that the problem still reproduces on ToT?


> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Cc: Song Liu <song@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Jinchao Wang <wangjinchao600@gmail.com>
> Cc: Wang Jinchao <wangjinchao600@gmail.com>
> Cc: <stable@vger.kernel.org>

Probably want a "Fixes" tag? If I had to guess, maybe?

Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface
for async model")

Why? I think before that the init function could only be called
directly from the kernel init code and before smp_init(). After that,
a worker could call it, which is the case where preemption could have
been enabled. Does my logic sound correct?

Can you confirm that you're only seeing the problem when the retry
hits? In other words when called from lockup_detector_delay_init()?
Oh, though if you're on 4.19 then I'm not sure what to think...


> @@ -118,18 +118,11 @@ static void watchdog_overflow_callback(struct perf_=
event *event,
>         watchdog_hardlockup_check(smp_processor_id(), regs);
>  }
>
> -static int hardlockup_detector_event_create(void)
> +static struct perf_event *hardlockup_detector_event_create(unsigned int =
cpu)
>  {
> -       unsigned int cpu;
>         struct perf_event_attr *wd_attr;
>         struct perf_event *evt;
>
> -       /*
> -        * Preemption is not disabled because memory will be allocated.
> -        * Ensure CPU-locality by calling this in per-CPU kthread.
> -        */
> -       WARN_ON(!is_percpu_thread());

I'm still a bit confused why this warning didn't trigger previously.
Do you know why?


> @@ -263,19 +258,31 @@ bool __weak __init arch_perf_nmi_is_available(void)
>   */
>  int __init watchdog_hardlockup_probe(void)
>  {
> +       struct perf_event *evt;
> +       unsigned int cpu;
>         int ret;
>
>         if (!arch_perf_nmi_is_available())
>                 return -ENODEV;
>
> -       ret =3D hardlockup_detector_event_create();
> +       if (!hw_nmi_get_sample_period(watchdog_thresh))
> +               return -EINVAL;
>
> -       if (ret) {
> +       /*
> +        * Test hardware PMU availability by creating a temporary perf ev=
ent.
> +        * Allow migration during the check as any successfully created p=
er-cpu
> +        * event validates PMU support. The event is released immediately=
.

I guess it's implied by the "Allow migration during the check", but I
might even word it more strongly and say something like "The cpu we
use here is arbitrary, so we don't disable preemption and use
raw_smp_processor_id() to get a CPU."

I guess that should be OK. Hopefully the arbitrary CPU that you pick
doesn't go offline during this function. I don't know "perf" well, but
I could imagine that it might be upset if you tried to create a perf
event for a CPU that has gone offline. I guess you could be paranoid
and surround this with cpu_hotplug_disable() / cpu_hotplug_enable()?


I guess overall thoughts: the problem you're describing does seem
real, but the fact that your reports are from an ancient 4.19 kernel
make me concerned about whether you really tested all the cases on a
new kernel...

-Doug

