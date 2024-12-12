Return-Path: <stable+bounces-100879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4609EE448
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349481680F6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81599210190;
	Thu, 12 Dec 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjHPiJkj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740C1E89C
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999862; cv=none; b=WB/K/QnoppxufaB+nfn0fdj1ePqQ+rvTsqoZ3RhTYWzHRgKx04+BUK8PPEPOKmOGfyVoetmdbB/UB46Iq5DfB27w++g6c8lDCxuDfgT989PgRAsppdzmt4x+umBQFI6jk7f1GiVucM3WNVyhXderdzfhfsZWVWqRC20gGzQ6+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999862; c=relaxed/simple;
	bh=lbXhQ/KzqbVpd7B5BXTA+izlzp7+zEdAh/u+/LlaUfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSHe8LQxP0or0sIPYffuHgLSuPzsQ5/0w9PkC+k47t5RHGLjtCnWEDSc9Wpbcu1JQv/kVtC8r0uk0Y9E/hRSZs2ysGH0pvlknrmh/5YtnEQDBZU+NExzuvwQSUqeqGR2JKQBS1MmPDIV6f35XfIuIXx97vBCQfotj1KWpUUXpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjHPiJkj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733999859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JTkkWizlmD7XaibgWFxBEjzVwXbynIHbNpI5EofSzg=;
	b=YjHPiJkjGCD5FKSlnJqJSqVC5u9e5aTf+8w9ER0HCCiWflgxUmBA1FXt3e9UvqaMdwHQwW
	uJh55PBcL5WuuV+4H2Cs9+bsdGoFZXiUuBWhhDXQitEYunJVBAR+VoQse9l4lpCt09nHzx
	8TQX6dasAQiLmSWgrubwIbgqtz/GfCA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-rKfe0HXMM96yzhoUOORSYQ-1; Thu, 12 Dec 2024 05:37:37 -0500
X-MC-Unique: rKfe0HXMM96yzhoUOORSYQ-1
X-Mimecast-MFC-AGG-ID: rKfe0HXMM96yzhoUOORSYQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa689b88293so55034266b.3
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 02:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999856; x=1734604656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JTkkWizlmD7XaibgWFxBEjzVwXbynIHbNpI5EofSzg=;
        b=Ghk4VitzCsBSPLTy6UrkUK/5zSkZp6NhrBNexY9BlXzHJlCT84Fu0G9s5SV8wYlnWx
         OZdproWbJXhdk0BYJfTRu9BjCSwxQdqlEdhUfFe5zFekdKRmtti+x+NAVdV4IuqhZ4hc
         shBG7meBSCLsy/fCOd3PrpnbfQFwBx/5KMxs6XObFubaNI+rHUyotXp7orVDjTfI8wsI
         PJhKPcNPP0iniC2IO/fj6Nja3GDHaNVj0SqinyMMIKTmYHuxjvVrExbYsw6TslFo/3lR
         35dzveuj2OcMNZpHGdUZbtxEduInnzXMKznlv1aNBtQp0nquOUF8gTkRp/2qxAaLd2hB
         tN6Q==
X-Gm-Message-State: AOJu0YxcUPOUGNxTwKZo3JthxbJB+SLt/aNzpKO2j4ifcrghvum0cQWl
	z9c9F+Hmmn3fmPFj4pEUlD8xrTMts6/xJAwzESaw/wh7rNs1yFmzP4/anuqnV0ZYUdPm4ImUurL
	gArmyAMDS3Z6ZOvUrqa5XsHLxdQTen26TnZ0XS4yzHMjEF7XESUPmAeNxRFjhjn7E1BPIiyU7xG
	8T+T3m5/TAy+LqFtIPGmWVIMUsTx9aZ7c3Ehr7
X-Gm-Gg: ASbGncvuw02gcNF+p0VpIUU9Hv7j/C5JJvK4WJ8sv0RX0LhrdK0Lo8oJCZmqYxi81Fm
	h6i7lMnpfbQQIrxNfve1MXOdZ4j1YV9EoCJy14Q==
X-Received: by 2002:a17:906:314e:b0:aa6:b5d8:d5c4 with SMTP id a640c23a62f3a-aa6b5d8d617mr576047566b.17.1733999856134;
        Thu, 12 Dec 2024 02:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyGK0xoigCEZGG+ksErmDSAyAbqYiDMb4t7qOnzJAn/Rwq1R6i2uCiyyMOfTyzWNGHQzKXI546GTe1vDtZySI=
X-Received: by 2002:a17:906:314e:b0:aa6:b5d8:d5c4 with SMTP id
 a640c23a62f3a-aa6b5d8d617mr576044666b.17.1733999855672; Thu, 12 Dec 2024
 02:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210204420.3582045-1-sashal@kernel.org>
In-Reply-To: <20241210204420.3582045-1-sashal@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 12 Dec 2024 11:37:24 +0100
Message-ID: <CAP4=nvQ6wqxwVki--BdBHQ+5wuT36LWLYSW84FSEjO8awakmsw@mail.gmail.com>
Subject: Re: Patch "rtla/utils: Add idle state disabling via libcpupower" has
 been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 10. 12. 2024 v 21:44 odes=C3=ADlatel Sasha Levin <sashal@kernel.org=
> napsal:
>
> This is a note to let you know that I've just added the patch titled
>
>     rtla/utils: Add idle state disabling via libcpupower
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rtla-utils-add-idle-state-disabling-via-libcpupower.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This is a part of a patchset implementing a new feature, rtla idle
state disabling, see [1]. It seems it was included in this stable
queue and also the one for 6.6 by mistake.

Also, the patch by itself does not do anything, because it depends on
preceding commits from the patchset to enable HAVE_LIBCPUPOWER_SUPPORT
and on following commits to actually implement the functionality in
the rtla command line interface.

Perhaps AUTOSEL picked it due to some merge conflicts with other
patches? I don't know of any though.

[1] - https://lore.kernel.org/linux-trace-kernel/20241017140914.3200454-1-t=
glozar@redhat.com


>
>
>
> commit 354bcd3b3efd600f4d23cee6898a6968659bb3a9
> Author: Tomas Glozar <tglozar@redhat.com>
> Date:   Thu Oct 17 16:09:11 2024 +0200
>
>     rtla/utils: Add idle state disabling via libcpupower
>
>     [ Upstream commit 083d29d3784319e9e9fab3ac02683a7b26ae3480 ]
>
>     Add functions to utils.c to disable idle states through functions of
>     libcpupower. This will serve as the basis for disabling idle states
>     per cpu when running timerlat.
>
>     Link: https://lore.kernel.org/20241017140914.3200454-4-tglozar@redhat=
.com
>     Signed-off-by: Tomas Glozar <tglozar@redhat.com>
>     Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 0735fcb827ed7..230f9fc7502dd 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -4,6 +4,9 @@
>   */
>
>  #define _GNU_SOURCE
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +#include <cpuidle.h>
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  #include <dirent.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
> @@ -519,6 +522,153 @@ int set_cpu_dma_latency(int32_t latency)
>         return fd;
>  }
>
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +static unsigned int **saved_cpu_idle_disable_state;
> +static size_t saved_cpu_idle_disable_state_alloc_ctr;
> +
> +/*
> + * save_cpu_idle_state_disable - save disable for all idle states of a c=
pu
> + *
> + * Saves the current disable of all idle states of a cpu, to be subseque=
ntly
> + * restored via restore_cpu_idle_disable_state.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +int save_cpu_idle_disable_state(unsigned int cpu)
> +{
> +       unsigned int nr_states;
> +       unsigned int state;
> +       int disabled;
> +       int nr_cpus;
> +
> +       nr_states =3D cpuidle_state_count(cpu);
> +
> +       if (nr_states =3D=3D 0)
> +               return 0;
> +
> +       if (saved_cpu_idle_disable_state =3D=3D NULL) {
> +               nr_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
> +               saved_cpu_idle_disable_state =3D calloc(nr_cpus, sizeof(u=
nsigned int *));
> +               if (!saved_cpu_idle_disable_state)
> +                       return -1;
> +       }
> +
> +       saved_cpu_idle_disable_state[cpu] =3D calloc(nr_states, sizeof(un=
signed int));
> +       if (!saved_cpu_idle_disable_state[cpu])
> +               return -1;
> +       saved_cpu_idle_disable_state_alloc_ctr++;
> +
> +       for (state =3D 0; state < nr_states; state++) {
> +               disabled =3D cpuidle_is_state_disabled(cpu, state);
> +               if (disabled < 0)
> +                       return disabled;
> +               saved_cpu_idle_disable_state[cpu][state] =3D disabled;
> +       }
> +
> +       return nr_states;
> +}
> +
> +/*
> + * restore_cpu_idle_disable_state - restore disable for all idle states =
of a cpu
> + *
> + * Restores the current disable state of all idle states of a cpu that w=
as
> + * previously saved by save_cpu_idle_disable_state.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +int restore_cpu_idle_disable_state(unsigned int cpu)
> +{
> +       unsigned int nr_states;
> +       unsigned int state;
> +       int disabled;
> +       int result;
> +
> +       nr_states =3D cpuidle_state_count(cpu);
> +
> +       if (nr_states =3D=3D 0)
> +               return 0;
> +
> +       if (!saved_cpu_idle_disable_state)
> +               return -1;
> +
> +       for (state =3D 0; state < nr_states; state++) {
> +               if (!saved_cpu_idle_disable_state[cpu])
> +                       return -1;
> +               disabled =3D saved_cpu_idle_disable_state[cpu][state];
> +               result =3D cpuidle_state_disable(cpu, state, disabled);
> +               if (result < 0)
> +                       return result;
> +       }
> +
> +       free(saved_cpu_idle_disable_state[cpu]);
> +       saved_cpu_idle_disable_state[cpu] =3D NULL;
> +       saved_cpu_idle_disable_state_alloc_ctr--;
> +       if (saved_cpu_idle_disable_state_alloc_ctr =3D=3D 0) {
> +               free(saved_cpu_idle_disable_state);
> +               saved_cpu_idle_disable_state =3D NULL;
> +       }
> +
> +       return nr_states;
> +}
> +
> +/*
> + * free_cpu_idle_disable_states - free saved idle state disable for all =
cpus
> + *
> + * Frees the memory used for storing cpu idle state disable for all cpus
> + * and states.
> + *
> + * Normally, the memory is freed automatically in
> + * restore_cpu_idle_disable_state; this is mostly for cleaning up after =
an
> + * error.
> + */
> +void free_cpu_idle_disable_states(void)
> +{
> +       int cpu;
> +       int nr_cpus;
> +
> +       if (!saved_cpu_idle_disable_state)
> +               return;
> +
> +       nr_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
> +
> +       for (cpu =3D 0; cpu < nr_cpus; cpu++) {
> +               free(saved_cpu_idle_disable_state[cpu]);
> +               saved_cpu_idle_disable_state[cpu] =3D NULL;
> +       }
> +
> +       free(saved_cpu_idle_disable_state);
> +       saved_cpu_idle_disable_state =3D NULL;
> +}
> +
> +/*
> + * set_deepest_cpu_idle_state - limit idle state of cpu
> + *
> + * Disables all idle states deeper than the one given in
> + * deepest_state (assuming states with higher number are deeper).
> + *
> + * This is used to reduce the exit from idle latency. Unlike
> + * set_cpu_dma_latency, it can disable idle states per cpu.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_st=
ate)
> +{
> +       unsigned int nr_states;
> +       unsigned int state;
> +       int result;
> +
> +       nr_states =3D cpuidle_state_count(cpu);
> +
> +       for (state =3D deepest_state + 1; state < nr_states; state++) {
> +               result =3D cpuidle_state_disable(cpu, state, 1);
> +               if (result < 0)
> +                       return result;
> +       }
> +
> +       return nr_states;
> +}
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
> +
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
>
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index 99c9cf81bcd02..101d4799a0090 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -66,6 +66,19 @@ int set_comm_sched_attr(const char *comm_prefix, struc=
t sched_attr *attr);
>  int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
>  int set_pid_cgroup(pid_t pid, const char *cgroup);
>  int set_cpu_dma_latency(int32_t latency);
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +int save_cpu_idle_disable_state(unsigned int cpu);
> +int restore_cpu_idle_disable_state(unsigned int cpu);
> +void free_cpu_idle_disable_states(void);
> +int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state);
> +static inline int have_libcpupower_support(void) { return 1; }
> +#else
> +static inline int save_cpu_idle_disable_state(unsigned int cpu) { return=
 -1; }
> +static inline int restore_cpu_idle_disable_state(unsigned int cpu) { ret=
urn -1; }
> +static inline void free_cpu_idle_disable_states(void) { }
> +static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned =
int state) { return -1; }
> +static inline int have_libcpupower_support(void) { return 0; }
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  int auto_house_keeping(cpu_set_t *monitored_cpus);
>
>  #define ns_to_usf(x) (((double)x/1000))
>

Tomas


