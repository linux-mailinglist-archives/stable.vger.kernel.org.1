Return-Path: <stable+bounces-185505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9EBD5FCC
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D82F14EBD59
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9B25783C;
	Mon, 13 Oct 2025 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpzDOFqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152272DA760
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384583; cv=none; b=VlHDn7J8ko62FgGAL4ekguWR9Ri/dCeAGpPlVVtMNUSWsFKRO6+X9eCpv5G6vvqpQ1A5Kgg4inwnLCAIuViPHByT4aEIwpf/la+dllKRjfGi/TEvEH4i2G0IynCnn1XyYaj1lsLA04Wy7GHaujbd5loI8JjiIvydfs975v6tgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384583; c=relaxed/simple;
	bh=5GKtGs7tSmMd+7LUr50qmK99sH3BTAkECSgbvDmx0Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xm4dFsLlBaK9GxgBA9ohEvHdcmy9Ur90qrTGNQYvzG8lsZHCSnU98oH9/yW5BPoT7JcxtR0R7VIOyJ4Eqce45ys7e2DNtl8z0onGa1UQXccDYbIu4hMEHC4hxaBjWuQatSgfoG/MtZ4pGIqYlRQU8hs0RIYYfe+4yhLdW6+0o34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpzDOFqA; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-554f1c13bcaso1379713e0c.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760384579; x=1760989379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rJS4wxTMBUKlMjD+i3lNTXBP3YDDjymQS8ubn/DRzo=;
        b=qpzDOFqAuoVJtO1S+U753Mv+35MpcR3Hr/JZVqRx6/3H9Ao0W+dmlSDCalbL1S1Fwx
         oPVCAU5bqYj4mEmOHh1HUq9etu0AF09FsA3qdcG6mCUvT/XZWyiz/wW48GFTLD4WsvHF
         q6TxVE+aYG0IpFE85jVUB5ei/ceglXgY9eN6++DYNXGlrUCIbdx0antYzRd3Oli7e8j6
         WVtVI9RG1GNAz2oNOS4fDknuGiX1+gYyV3AyOYUp9rFAQK+pMd1jVRqfWhL4/31rz/kh
         Rn7IRFgLQE/DIrqLijq6E4vYsyPG6Rmdpm+zbZLlcXtzn31Y7WizjM8tQlmSrZq00dF+
         593A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760384579; x=1760989379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rJS4wxTMBUKlMjD+i3lNTXBP3YDDjymQS8ubn/DRzo=;
        b=iqRb71nsI1g9TBHr0Tc3WnOl6ZCneoPirs4j/RNDBAqvqK5fBi8znoSKCWXRkWrIKQ
         h1tXIBjSovY2w3XWbXvqJotso/jI+0oe8sjLx2IHo2P+fBneSplGB4zzlwQzzTBvmXvg
         p7vqaub7KKWInzyrApIIsyJXJh64QhQHTX/6yMWDOOU35s5y3ggLVoN9z3+pTuSnXtM2
         SAeHTwvHib8Y1vrTYQY7TyIkb12+jmQJKMJTGj4guxT9Jpd2LOwlY8qU8JLIuIGNIBsc
         2v5u+0aeZ2RL10WdY279k+rjShiHN24f+dJjVTsgPRCT4jXwNHy1aet6NA1C97uHfSys
         jP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo2/sTJ0dOsTumVWtWz78ToYrr8hR4IWYwotYLgfHN4X7yWR1PjCRUiVNTn6BabkGQt4kIUsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQJxc5joenFdaqaaysg+BkKq62LF/V+g0LZyDedfEFand8IE7
	y6OK+waR6i2f9mLi82Bn1oxZ1q2gWGESpIVC/S8laNjFY61BjEEtVf54wlDoS4Jy5uKXdtXpZip
	VF/WYEBbFmVcMW+fUWdMBhFNQ20qtwkdnt5+YWiPsfuxEKMVdp4+BSm9o
X-Gm-Gg: ASbGncstkqTsAwUWINZX/sIFw08e+Y+5Ue9zIu5zXw8JWB4st0HW5R3bpeR63AVPFJO
	IoX+Mu2fGDTyynqdi4Xo6v/4oYfskiz/Q3D3yRWrFN1Kw/Tn1LjtZjfRs9I165GltnEJN+lclbu
	MLISIh+621lUoHe8nSXqr6a5ZkIVsXN0VpXzWSZ0Jkkoeccir7BKdUkbjMa3ugE4l8k/CkAx7Cy
	kbIQtDAfmJA5DKt4YlCUNB+5o06XeasnDNvKVuALw==
X-Google-Smtp-Source: AGHT+IEwCKzh2JSdlS9ZYSY2Zj5v8o8ENO/eKtrSL0Iqfbd3vuiwXYI9GtrjUxXXIUa4o/O+xJROs9yODAu1/ImIUD0=
X-Received: by 2002:a05:6102:3e94:b0:525:9f17:9e55 with SMTP id
 ada2fe7eead31-5d5e23ceae5mr9687146137.32.1760384577323; Mon, 13 Oct 2025
 12:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025101354-eject-groove-319c@gregkh>
In-Reply-To: <2025101354-eject-groove-319c@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 13 Oct 2025 12:42:19 -0700
X-Gm-Features: AS18NWB0qTRg3sJCGBbRz2qMHMk0m2Rw3JwGY8ryhxDSDbLtldmj6YcWJF6vfks
Message-ID: <CAGETcx_6c_wMbBWTOEzJ-uX2o8-dodPDAsjmsJyvNd+dp1zoUw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] tracing: Have trace_marker use per-cpu
 data to read user" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org, luogengkun@huaweicloud.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, runpinglai@google.com, 
	torvalds@linux-foundation.org, wattson-external@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:27=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 64cf7d058a005c5c31eb8a0b741f35dc12915d18
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101354-=
eject-groove-319c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:

IIRC, this is a fix for something that went in after 6.12. So, don't
need to backport it 6.12 or older.

-Saravana

>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 64cf7d058a005c5c31eb8a0b741f35dc12915d18 Mon Sep 17 00:00:00 2001
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Wed, 8 Oct 2025 12:45:10 -0400
> Subject: [PATCH] tracing: Have trace_marker use per-cpu data to read user
>  space
>
> It was reported that using __copy_from_user_inatomic() can actually
> schedule. Which is bad when preemption is disabled. Even though there's
> logic to check in_atomic() is set, but this is a nop when the kernel is
> configured with PREEMPT_NONE. This is due to page faulting and the code
> could schedule with preemption disabled.
>
> Link: https://lore.kernel.org/all/20250819105152.2766363-1-luogengkun@hua=
weicloud.com/
>
> The solution was to change the __copy_from_user_inatomic() to
> copy_from_user_nofault(). But then it was reported that this caused a
> regression in Android. There's several applications writing into
> trace_marker() in Android, but now instead of showing the expected data,
> it is showing:
>
>   tracing_mark_write: <faulted>
>
> After reverting the conversion to copy_from_user_nofault(), Android was
> able to get the data again.
>
> Writes to the trace_marker is a way to efficiently and quickly enter data
> into the Linux tracing buffer. It takes no locks and was designed to be a=
s
> non-intrusive as possible. This means it cannot allocate memory, and must
> use pre-allocated data.
>
> A method that is actively being worked on to have faultable system call
> tracepoints read user space data is to allocate per CPU buffers, and use
> them in the callback. The method uses a technique similar to seqcount.
> That is something like this:
>
>         preempt_disable();
>         cpu =3D smp_processor_id();
>         buffer =3D this_cpu_ptr(&pre_allocated_cpu_buffers, cpu);
>         do {
>                 cnt =3D nr_context_switches_cpu(cpu);
>                 migrate_disable();
>                 preempt_enable();
>                 ret =3D copy_from_user(buffer, ptr, size);
>                 preempt_disable();
>                 migrate_enable();
>         } while (!ret && cnt !=3D nr_context_switches_cpu(cpu));
>
>         if (!ret)
>                 ring_buffer_write(buffer);
>         preempt_enable();
>
> It's a little more involved than that, but the above is the basic logic.
> The idea is to acquire the current CPU buffer, disable migration, and the=
n
> enable preemption. At this moment, it can safely use copy_from_user().
> After reading the data from user space, it disables preemption again. It
> then checks to see if there was any new scheduling on this CPU. If there
> was, it must assume that the buffer was corrupted by another task. If
> there wasn't, then the buffer is still valid as only tasks in preemptable
> context can write to this buffer and only those that are running on the
> CPU.
>
> By using this method, where trace_marker open allocates the per CPU
> buffers, trace_marker writes can access user space and even fault it in,
> without having to allocate or take any locks of its own.
>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Luo Gengkun <luogengkun@huaweicloud.com>
> Cc: Wattson CI <wattson-external@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/20251008124510.6dba541a@gandalf.local.home
> Fixes: 3d62ab32df065 ("tracing: Fix tracing_marker may trigger page fault=
 during preempt_disable")
> Reported-by: Runping Lai <runpinglai@google.com>
> Tested-by: Runping Lai <runpinglai@google.com>
> Closes: https://lore.kernel.org/linux-trace-kernel/20251007003417.3470979=
-2-runpinglai@google.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b3c94fbaf002..0fd582651293 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4791,12 +4791,6 @@ int tracing_single_release_file_tr(struct inode *i=
node, struct file *filp)
>         return single_release(inode, filp);
>  }
>
> -static int tracing_mark_open(struct inode *inode, struct file *filp)
> -{
> -       stream_open(inode, filp);
> -       return tracing_open_generic_tr(inode, filp);
> -}
> -
>  static int tracing_release(struct inode *inode, struct file *file)
>  {
>         struct trace_array *tr =3D inode->i_private;
> @@ -7163,7 +7157,7 @@ tracing_free_buffer_release(struct inode *inode, st=
ruct file *filp)
>
>  #define TRACE_MARKER_MAX_SIZE          4096
>
> -static ssize_t write_marker_to_buffer(struct trace_array *tr, const char=
 __user *ubuf,
> +static ssize_t write_marker_to_buffer(struct trace_array *tr, const char=
 *buf,
>                                       size_t cnt, unsigned long ip)
>  {
>         struct ring_buffer_event *event;
> @@ -7173,20 +7167,11 @@ static ssize_t write_marker_to_buffer(struct trac=
e_array *tr, const char __user
>         int meta_size;
>         ssize_t written;
>         size_t size;
> -       int len;
> -
> -/* Used in tracing_mark_raw_write() as well */
> -#define FAULTED_STR "<faulted>"
> -#define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accoun=
ted for */
>
>         meta_size =3D sizeof(*entry) + 2;  /* add '\0' and possible '\n' =
*/
>   again:
>         size =3D cnt + meta_size;
>
> -       /* If less than "<faulted>", then make sure we can still add that=
 */
> -       if (cnt < FAULTED_SIZE)
> -               size +=3D FAULTED_SIZE - cnt;
> -
>         buffer =3D tr->array_buffer.buffer;
>         event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>                                             tracing_gen_ctx());
> @@ -7196,9 +7181,6 @@ static ssize_t write_marker_to_buffer(struct trace_=
array *tr, const char __user
>                  * make it smaller and try again.
>                  */
>                 if (size > ring_buffer_max_event_size(buffer)) {
> -                       /* cnt < FAULTED size should never be bigger than=
 max */
> -                       if (WARN_ON_ONCE(cnt < FAULTED_SIZE))
> -                               return -EBADF;
>                         cnt =3D ring_buffer_max_event_size(buffer) - meta=
_size;
>                         /* The above should only happen once */
>                         if (WARN_ON_ONCE(cnt + meta_size =3D=3D size))
> @@ -7212,14 +7194,8 @@ static ssize_t write_marker_to_buffer(struct trace=
_array *tr, const char __user
>
>         entry =3D ring_buffer_event_data(event);
>         entry->ip =3D ip;
> -
> -       len =3D copy_from_user_nofault(&entry->buf, ubuf, cnt);
> -       if (len) {
> -               memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
> -               cnt =3D FAULTED_SIZE;
> -               written =3D -EFAULT;
> -       } else
> -               written =3D cnt;
> +       memcpy(&entry->buf, buf, cnt);
> +       written =3D cnt;
>
>         if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->=
triggers)) {
>                 /* do not add \n before testing triggers, but add \0 */
> @@ -7243,6 +7219,169 @@ static ssize_t write_marker_to_buffer(struct trac=
e_array *tr, const char __user
>         return written;
>  }
>
> +struct trace_user_buf {
> +       char            *buf;
> +};
> +
> +struct trace_user_buf_info {
> +       struct trace_user_buf __percpu  *tbuf;
> +       int                             ref;
> +};
> +
> +
> +static DEFINE_MUTEX(trace_user_buffer_mutex);
> +static struct trace_user_buf_info *trace_user_buffer;
> +
> +static void trace_user_fault_buffer_free(struct trace_user_buf_info *tin=
fo)
> +{
> +       char *buf;
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               buf =3D per_cpu_ptr(tinfo->tbuf, cpu)->buf;
> +               kfree(buf);
> +       }
> +       free_percpu(tinfo->tbuf);
> +       kfree(tinfo);
> +}
> +
> +static int trace_user_fault_buffer_enable(void)
> +{
> +       struct trace_user_buf_info *tinfo;
> +       char *buf;
> +       int cpu;
> +
> +       guard(mutex)(&trace_user_buffer_mutex);
> +
> +       if (trace_user_buffer) {
> +               trace_user_buffer->ref++;
> +               return 0;
> +       }
> +
> +       tinfo =3D kmalloc(sizeof(*tinfo), GFP_KERNEL);
> +       if (!tinfo)
> +               return -ENOMEM;
> +
> +       tinfo->tbuf =3D alloc_percpu(struct trace_user_buf);
> +       if (!tinfo->tbuf) {
> +               kfree(tinfo);
> +               return -ENOMEM;
> +       }
> +
> +       tinfo->ref =3D 1;
> +
> +       /* Clear each buffer in case of error */
> +       for_each_possible_cpu(cpu) {
> +               per_cpu_ptr(tinfo->tbuf, cpu)->buf =3D NULL;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               buf =3D kmalloc_node(TRACE_MARKER_MAX_SIZE, GFP_KERNEL,
> +                                  cpu_to_node(cpu));
> +               if (!buf) {
> +                       trace_user_fault_buffer_free(tinfo);
> +                       return -ENOMEM;
> +               }
> +               per_cpu_ptr(tinfo->tbuf, cpu)->buf =3D buf;
> +       }
> +
> +       trace_user_buffer =3D tinfo;
> +
> +       return 0;
> +}
> +
> +static void trace_user_fault_buffer_disable(void)
> +{
> +       struct trace_user_buf_info *tinfo;
> +
> +       guard(mutex)(&trace_user_buffer_mutex);
> +
> +       tinfo =3D trace_user_buffer;
> +
> +       if (WARN_ON_ONCE(!tinfo))
> +               return;
> +
> +       if (--tinfo->ref)
> +               return;
> +
> +       trace_user_fault_buffer_free(tinfo);
> +       trace_user_buffer =3D NULL;
> +}
> +
> +/* Must be called with preemption disabled */
> +static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
> +                                  const char __user *ptr, size_t size,
> +                                  size_t *read_size)
> +{
> +       int cpu =3D smp_processor_id();
> +       char *buffer =3D per_cpu_ptr(tinfo->tbuf, cpu)->buf;
> +       unsigned int cnt;
> +       int trys =3D 0;
> +       int ret;
> +
> +       if (size > TRACE_MARKER_MAX_SIZE)
> +               size =3D TRACE_MARKER_MAX_SIZE;
> +       *read_size =3D 0;
> +
> +       /*
> +        * This acts similar to a seqcount. The per CPU context switches =
are
> +        * recorded, migration is disabled and preemption is enabled. The
> +        * read of the user space memory is copied into the per CPU buffe=
r.
> +        * Preemption is disabled again, and if the per CPU context switc=
hes count
> +        * is still the same, it means the buffer has not been corrupted.
> +        * If the count is different, it is assumed the buffer is corrupt=
ed
> +        * and reading must be tried again.
> +        */
> +
> +       do {
> +               /*
> +                * If for some reason, copy_from_user() always causes a c=
ontext
> +                * switch, this would then cause an infinite loop.
> +                * If this task is preempted by another user space task, =
it
> +                * will cause this task to try again. But just in case so=
mething
> +                * changes where the copying from user space causes anoth=
er task
> +                * to run, prevent this from going into an infinite loop.
> +                * 100 tries should be plenty.
> +                */
> +               if (WARN_ONCE(trys++ > 100, "Error: Too many tries to rea=
d user space"))
> +                       return NULL;
> +
> +               /* Read the current CPU context switch counter */
> +               cnt =3D nr_context_switches_cpu(cpu);
> +
> +               /*
> +                * Preemption is going to be enabled, but this task must
> +                * remain on this CPU.
> +                */
> +               migrate_disable();
> +
> +               /*
> +                * Now preemption is being enabed and another task can co=
me in
> +                * and use the same buffer and corrupt our data.
> +                */
> +               preempt_enable_notrace();
> +
> +               ret =3D __copy_from_user(buffer, ptr, size);
> +
> +               preempt_disable_notrace();
> +               migrate_enable();
> +
> +               /* if it faulted, no need to test if the buffer was corru=
pted */
> +               if (ret)
> +                       return NULL;
> +
> +               /*
> +                * Preemption is disabled again, now check the per CPU co=
ntext
> +                * switch counter. If it doesn't match, then another user=
 space
> +                * process may have schedule in and corrupted our buffer.=
 In that
> +                * case the copying must be retried.
> +                */
> +       } while (nr_context_switches_cpu(cpu) !=3D cnt);
> +
> +       *read_size =3D size;
> +       return buffer;
> +}
> +
>  static ssize_t
>  tracing_mark_write(struct file *filp, const char __user *ubuf,
>                                         size_t cnt, loff_t *fpos)
> @@ -7250,6 +7389,8 @@ tracing_mark_write(struct file *filp, const char __=
user *ubuf,
>         struct trace_array *tr =3D filp->private_data;
>         ssize_t written =3D -ENODEV;
>         unsigned long ip;
> +       size_t size;
> +       char *buf;
>
>         if (tracing_disabled)
>                 return -EINVAL;
> @@ -7263,6 +7404,16 @@ tracing_mark_write(struct file *filp, const char _=
_user *ubuf,
>         if (cnt > TRACE_MARKER_MAX_SIZE)
>                 cnt =3D TRACE_MARKER_MAX_SIZE;
>
> +       /* Must have preemption disabled while having access to the buffe=
r */
> +       guard(preempt_notrace)();
> +
> +       buf =3D trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size=
);
> +       if (!buf)
> +               return -EFAULT;
> +
> +       if (cnt > size)
> +               cnt =3D size;
> +
>         /* The selftests expect this function to be the IP address */
>         ip =3D _THIS_IP_;
>
> @@ -7270,32 +7421,27 @@ tracing_mark_write(struct file *filp, const char =
__user *ubuf,
>         if (tr =3D=3D &global_trace) {
>                 guard(rcu)();
>                 list_for_each_entry_rcu(tr, &marker_copies, marker_list) =
{
> -                       written =3D write_marker_to_buffer(tr, ubuf, cnt,=
 ip);
> +                       written =3D write_marker_to_buffer(tr, buf, cnt, =
ip);
>                         if (written < 0)
>                                 break;
>                 }
>         } else {
> -               written =3D write_marker_to_buffer(tr, ubuf, cnt, ip);
> +               written =3D write_marker_to_buffer(tr, buf, cnt, ip);
>         }
>
>         return written;
>  }
>
>  static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
> -                                         const char __user *ubuf, size_t=
 cnt)
> +                                         const char *buf, size_t cnt)
>  {
>         struct ring_buffer_event *event;
>         struct trace_buffer *buffer;
>         struct raw_data_entry *entry;
>         ssize_t written;
> -       int size;
> -       int len;
> -
> -#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
> +       size_t size;
>
>         size =3D sizeof(*entry) + cnt;
> -       if (cnt < FAULT_SIZE_ID)
> -               size +=3D FAULT_SIZE_ID - cnt;
>
>         buffer =3D tr->array_buffer.buffer;
>
> @@ -7309,14 +7455,8 @@ static ssize_t write_raw_marker_to_buffer(struct t=
race_array *tr,
>                 return -EBADF;
>
>         entry =3D ring_buffer_event_data(event);
> -
> -       len =3D copy_from_user_nofault(&entry->id, ubuf, cnt);
> -       if (len) {
> -               entry->id =3D -1;
> -               memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
> -               written =3D -EFAULT;
> -       } else
> -               written =3D cnt;
> +       memcpy(&entry->id, buf, cnt);
> +       written =3D cnt;
>
>         __buffer_unlock_commit(buffer, event);
>
> @@ -7329,8 +7469,8 @@ tracing_mark_raw_write(struct file *filp, const cha=
r __user *ubuf,
>  {
>         struct trace_array *tr =3D filp->private_data;
>         ssize_t written =3D -ENODEV;
> -
> -#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
> +       size_t size;
> +       char *buf;
>
>         if (tracing_disabled)
>                 return -EINVAL;
> @@ -7342,6 +7482,17 @@ tracing_mark_raw_write(struct file *filp, const ch=
ar __user *ubuf,
>         if (cnt < sizeof(unsigned int))
>                 return -EINVAL;
>
> +       /* Must have preemption disabled while having access to the buffe=
r */
> +       guard(preempt_notrace)();
> +
> +       buf =3D trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size=
);
> +       if (!buf)
> +               return -EFAULT;
> +
> +       /* raw write is all or nothing */
> +       if (cnt > size)
> +               return -EINVAL;
> +
>         /* The global trace_marker_raw can go to multiple instances */
>         if (tr =3D=3D &global_trace) {
>                 guard(rcu)();
> @@ -7357,6 +7508,27 @@ tracing_mark_raw_write(struct file *filp, const ch=
ar __user *ubuf,
>         return written;
>  }
>
> +static int tracing_mark_open(struct inode *inode, struct file *filp)
> +{
> +       int ret;
> +
> +       ret =3D trace_user_fault_buffer_enable();
> +       if (ret < 0)
> +               return ret;
> +
> +       stream_open(inode, filp);
> +       ret =3D tracing_open_generic_tr(inode, filp);
> +       if (ret < 0)
> +               trace_user_fault_buffer_disable();
> +       return ret;
> +}
> +
> +static int tracing_mark_release(struct inode *inode, struct file *file)
> +{
> +       trace_user_fault_buffer_disable();
> +       return tracing_release_generic_tr(inode, file);
> +}
> +
>  static int tracing_clock_show(struct seq_file *m, void *v)
>  {
>         struct trace_array *tr =3D m->private;
> @@ -7764,13 +7936,13 @@ static const struct file_operations tracing_free_=
buffer_fops =3D {
>  static const struct file_operations tracing_mark_fops =3D {
>         .open           =3D tracing_mark_open,
>         .write          =3D tracing_mark_write,
> -       .release        =3D tracing_release_generic_tr,
> +       .release        =3D tracing_mark_release,
>  };
>
>  static const struct file_operations tracing_mark_raw_fops =3D {
>         .open           =3D tracing_mark_open,
>         .write          =3D tracing_mark_raw_write,
> -       .release        =3D tracing_release_generic_tr,
> +       .release        =3D tracing_mark_release,
>  };
>
>  static const struct file_operations trace_clock_fops =3D {
>
> --
> WARNING: There are external email addresses on this mailing list. Do not =
discuss any internal or confidential information.
> ---
> You received this message because you are subscribed to the Google Groups=
 "wattson-external" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to wattson-external+unsubscribe@google.com.
> To view this discussion visit https://groups.google.com/a/google.com/d/ms=
gid/wattson-external/2025101354-eject-groove-319c%40gregkh.

