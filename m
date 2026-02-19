Return-Path: <stable+bounces-217482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFCyBbhFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:17:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9079161103
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF780300847E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A073C07A;
	Thu, 19 Feb 2026 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euoj26kU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EF347FD9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521451; cv=pass; b=Jzjg6jXGuSZHD4+OoMqhZer/Z/63t/5Mp0XJBql5btrC7qkXPnc8MZIlurOZAydpiFveVCrlOdxG+jjPZV/cVAhi6FLZ5OBBpHUePtJPaVL8dw5rEQG/OOLzsEkTwtYEdWo0DEVfA5iXnmUFXVd4GFa5HvHYDKWPHIsGb2DyWgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521451; c=relaxed/simple;
	bh=8s7zqn+JKR5OYoKOoaTPQWs8K5lNLxKEgdGO9RiCybo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZldFA00/dHWwOI7Ef71pJ5jJK/k57eJzvEi8Cb5qK3ayIdcAlKHcVw0FDWAjWYbCiPopiknfgDHsElpOJw+NqF2kbALQAKf4rMJP43xjRR83xji/LA5kCnRhjHrtKItMm7Y0chXE6dfpsbNuN0imc8vfmRa2mtRNPD+S91NSnmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euoj26kU; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89464760408so7568656d6.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771521448; cv=none;
        d=google.com; s=arc-20240605;
        b=gl67hP3chNbGR2c2gnk0Cjeuw7HQVbdn4KANk1A0XB1UfxbZXp8dUxI2OjbHTGcQV3
         CU49UfFLwqQ3zeQDAw5wu0Qo9lCut5Gb13lv59xANXwZzcbGDYpweMN2AI8YLFLlUJSa
         irQe1FUKVERMAHKSjkWEFNTWp/BukTYLuoxN9ZqX/GYlYaZ1b69hHqLq7IkQKvycIHaF
         N8+upYL29hIjf7Y0rT+wfaV7342MpGzytQuMdWjR7NOK0K36gJd5/ptWz8Xs84RqXtKS
         7xQO3rNAypEU9TpMeW04bAGji2nEeXDlIQQRz63STZlrppvWO9vQ7E6LHlM+Z9yfCCMr
         eTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S5w/msoFDa9orh2H96VLrf36iiFdGsvKYnvJC5OxIJw=;
        fh=hit7+KdilZsr382BZO8LJG5cmwRLRQOdxC7FbTBCTWQ=;
        b=OQejiocZrB51afxoLItT+TlA1WKVaNECiLYBQn3r3t/kbJKHIsVE68DdTy9cAzB3kt
         ebC1yNNQay9oi31SoNpDyOAtmn2ldPl54GO5BSDkzfaE72oPVwiEmYNtQJjA2MF/4drR
         xqDEBBwDPW0///bf8460RzCg+1PWwI+gflNkJd+RzFUCoOeOpxw841piqZiC05yuBDy2
         j+tXPysv5FTyHWhEHJuLx2GxX/4LXExwyTzPXx+BmxoU/4ZGhLf3U9/1YNItspXkj3VH
         bEkHDWBUVwsBMGmION6ulmiMUHnTPp2uMM2J+dnaFBkg20c8wx2qI7iCvUOyTSyNigQw
         ojSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521448; x=1772126248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S5w/msoFDa9orh2H96VLrf36iiFdGsvKYnvJC5OxIJw=;
        b=Euoj26kUrtcgEk6QPtpHD+kB/MwC2KTzN6gfCyDpZjfIcIziTSNNcrxFLz4YEz4580
         kVBu8Ky1ewyPSj6UsZO6k5e17FbGgup5BHqzPN2ENpIKbBzKaLqymZc+dA2Je9l+tE22
         UzhMSfPYKHn/oY0vVTp3MqyUppHs6enM6PIRN47idsdDmlAZ29nuAsXGafMCSvoTnRW7
         4+9wI15XYWfeviVRigEa1ovsO/O92xzwvn59ba8ipb2y26bMmo25smsIKM5P/O6r4wA1
         XA6O8HBKM+AKaUNgSFwpZBvvi4OeAWGcqwbglEkQFtnlpCpA6ZFaEBmRsG30VLOs1V1A
         V42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521448; x=1772126248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5w/msoFDa9orh2H96VLrf36iiFdGsvKYnvJC5OxIJw=;
        b=Bg5XNheHXukQ6feExheAiMl0/Myf+aEXgColc5UYYJRmpqm6GdSYeDG5nJqHA1LI3P
         l62vaty9R6rv1qWzvodIxwjWyKIq/w4o49Z6vV/d0ArJL9FJRKdD8jp4y2cQCiWGWeKw
         75A8atsKF1Atd1desFLxyMMf8wdsmU3fLQo6S2Zl3EVbiXS51vA14/OstkpEKJmVRYcX
         8RjLsHBCdgSMvcbrJ786PiV+40LgXJY1vl0aQjA0GP2NM05hl+LCVQ0IPKD0YgL/yiER
         q4EJMOWac3WyFfTKCMYewgS1SdcE8me0Yyuhq6U2vZNhdxhHWMci7d/bAnzIuy0XY7Ty
         7IsA==
X-Gm-Message-State: AOJu0YwoenRnw+rm0FEl1ZLGkM45m3xWC6uf2wvQxVeN4CEXp9Fr9+0w
	kpfz3KE3I8iJwKGsovgL00kzNNPfzhwZRQ01XdPpbN0eLigwSwNBadLBtq4gzXF/YyX4kQXjKDt
	+y9jELoJA90YtxrdH1UxSTo8/Xz7URhkFdiSd
X-Gm-Gg: AZuq6aIgVF9DltQzlc6lB62Mrt/nxarIHdpR8v9OltSFJzkcXaZEFNO++EIMe5XU4ii
	RrEGL21/DHmXEQNL/NNKkUQrGJZwRm3jc+eMMztfGfDndjujtW6aCleJDKUNtS8hnWlp26YVc5x
	vKW+ZP5HIMXWFJGI1EAkj5pYGoLleglCsYvgGUqbKlRDhUD0ud4aAN+AtASqbGKg9pI2IBk75/e
	wvLOjS//3ZiV/GRe3ejDlLlHFxvEcyGtU2Z8In8gpTYnT8uMkZirxzq+GsVBP5Uiatt4co6m+7g
	Qy+fyFSpJw==
X-Received: by 2002:a05:6214:27eb:b0:896:f6d5:c73c with SMTP id
 6a1803df08f44-899580a8bcbmr89613496d6.41.1771521447631; Thu, 19 Feb 2026
 09:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219171310.118170-1-aha310510@gmail.com> <20260219171310.118170-16-aha310510@gmail.com>
In-Reply-To: <20260219171310.118170-16-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Fri, 20 Feb 2026 02:17:18 +0900
X-Gm-Features: AaiRm529edBYEh1GUJI3ts8-SzVmsBmd3V91rJtHn___pgs9QXwHrjAbeawXVSs
Message-ID: <CAO9qdTGZVdkug1kn0goW8Uwro95P+_jLW3MBxxp04bxgq=SsCA@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 15/15] timers: Fix NULL function pointer race in timer_shutdown_sync()
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, Julia.Lawall@inria.fr, 
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org, maz@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sboyd@kernel.org, 
	viresh.kumar@linaro.org, zouyipeng@huawei.com, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: D9079161103
X-Rspamd-Action: no action

Jeongjun Park <aha310510@gmail.com> wrote:
>
> From: Yipeng Zou <zouyipeng@huawei.com>
>
> [ Upstream commit 20739af07383e6eb1ec59dcd70b72ebfa9ac362c ]
>
> There is a race condition between timer_shutdown_sync() and timer
> expiration that can lead to hitting a WARN_ON in expire_timers().
>
> The issue occurs when timer_shutdown_sync() clears the timer function
> to NULL while the timer is still running on another CPU. The race
> scenario looks like this:
>
> CPU0                                    CPU1
>                                         <SOFTIRQ>
>                                         lock_timer_base()
>                                         expire_timers()
>                                         base->running_timer = timer;
>                                         unlock_timer_base()
>                                         [call_timer_fn enter]
>                                         mod_timer()
>                                         ...
> timer_shutdown_sync()
> lock_timer_base()
> // For now, will not detach the timer but only clear its function to NULL
> if (base->running_timer != timer)
>         ret = detach_if_pending(timer, base, true);
> if (shutdown)
>         timer->function = NULL;
> unlock_timer_base()
>                                         [call_timer_fn exit]
>                                         lock_timer_base()
>                                         base->running_timer = NULL;
>                                         unlock_timer_base()
>                                         ...
>                                         // Now timer is pending while its function set to NULL.
>                                         // next timer trigger
>                                         <SOFTIRQ>
>                                         expire_timers()
>                                         WARN_ON_ONCE(!fn) // hit
>                                         ...
> lock_timer_base()
> // Now timer will detach
> if (base->running_timer != timer)
>         ret = detach_if_pending(timer, base, true);
> if (shutdown)
>         timer->function = NULL;
> unlock_timer_base()
>
> The problem is that timer_shutdown_sync() clears the timer function
> regardless of whether the timer is currently running. This can leave a
> pending timer with a NULL function pointer, which triggers the
> WARN_ON_ONCE(!fn) check in expire_timers().
>
> Fix this by only clearing the timer function when actually detaching the
> timer. If the timer is running, leave the function pointer intact, which is
> safe because the timer will be properly detached when it finishes running.
>
> Fixes: 0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20251122093942.301559-1-zouyipeng@huawei.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Jeongjun Park <aha310510@gmail.com>

> ---
>  kernel/time/timer.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1360,10 +1360,11 @@ static int __try_to_del_timer_sync(struc
>
>         base = lock_timer_base(timer, &flags);
>
> -       if (base->running_timer != timer)
> +       if (base->running_timer != timer) {
>                 ret = detach_if_pending(timer, base, true);
> -       if (shutdown)
> -               timer->function = NULL;
> +               if (shutdown)
> +                       timer->function = NULL;
> +       }
>
>         raw_spin_unlock_irqrestore(&base->lock, flags);
>
> --

