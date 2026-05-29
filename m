Return-Path: <stable+bounces-256559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mENaEKJTGWqYvAgAu9opvQ
	(envelope-from <stable+bounces-256559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:51:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB85FF833
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98CF301A92A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDD3A987B;
	Fri, 29 May 2026 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SciqvKkA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5934F259
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044283; cv=pass; b=tnCV8jXGOXio45gzaLEk3PV+AWF/hnm2c8YgXPsHx9LsdgztUZKKIukXKvKu2em9Hsc1xOGUksE4clYq/0ms7GRX7J5aluWUp/kYcNCMuGUFsnxX5Ky0C64DiqiPsyxtA+DBpJywFw7T5HZgxfi5Y6/WjoB3/SIl1+s4goIOrKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044283; c=relaxed/simple;
	bh=Wk3aiWc+QEzhu0NwKMl0y8CWK9ZNpPshVCe8NLafBPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI1I7nvdf0KT5tM0krjlwkDgjVwq9lc0b88KP7ZGJvHvKO7iiciCQffLo3BeNOASc8tyyWWMInQ15NBsrrZWS549CvIEVqFsujyG/2KyN1ZvJUe/H9jhLociHWrH6FmVzUsUIxaQv0CWh+nqJ8AoLezFuRw69dFYKImMMs9H8vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SciqvKkA; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bdf8add254dso645824666b.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 01:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780044280; cv=none;
        d=google.com; s=arc-20240605;
        b=NqUgVkqST0FDKNVdFYaPot3cjcWh0798MaE9lTNCBiXNl8fWP1Z6CqMKqT6LmrsJq4
         ZnnXPMCyLoJEyaBaDgEUKJYfhQLwd6KNT/lnl5ig8Oi+DqjikNFrkQ+RIzW69CYJn9CN
         VkBhIUWpM0Rb/JxCD1nxtDklBb0fOthV3uPOomyVKwq5E3BSztqhAnqCNAWu9quHzr0e
         s4owswHckY9mxdOtbo7MVRAlUM4qx4FLh1XxHGR3Dte4Hca3PZm0kDFMrFmlRcZUGWz8
         DNEBEDf0fZtfvhyFnkbdJBl7/8Ye0vTem3x6dPv0WV5mRVK5lh6p6SCWuNvsG2IYimkH
         bc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gFsUMUtsy1cL7mLXns7mSBxO/z8pwoHJ3QJWfcSo/8g=;
        fh=pmE/KFugVxfW2nQx/IZiXkRywaVklDHoczB3MG88qrc=;
        b=MEyiyKYjHbsaimAkV4mlyC13LUOqQAmiCRFdJZ30Xa9ABdH+m6gHVEq6RUhby49yfH
         4KNnYURVCGZkuTuV8lVnyKbAGt82bmRviiZItRAX5KEdpLsiCFRw1ruKR6DYWZMnD847
         U7ijrCbi3FHoGqx29oOkKD60zsS1TeQ5LT3k4nftv6p5jAjoUJcflisOk7FP0dVJqcZa
         F6gzgr7CEjZlYl+7mqmo5YlXaRVseLy2C/mT0BRtFOO0m2FHDWFy/qKHeJThKtZ1w1g5
         BMSl/4ZB4Fre2fGsvYoXW2CiKU1EN8iy+9lZtNhEZAEbnmVXE+hNlg61JYJnzTTFdEiz
         cLxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780044280; x=1780649080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFsUMUtsy1cL7mLXns7mSBxO/z8pwoHJ3QJWfcSo/8g=;
        b=SciqvKkAyRMf36H7BsH3vIHo9sXA0GXmR4mnFnNqCRA0mmw3zAKvymFTkdCSYgrQFh
         AE0/IkCHqKlLORttuwZo7uKU9Mmzy5yDSvlQrZxlJXPynfnOC/+Qqgq5uh4RMJDbgJvX
         KUAMuG9jIDDt36eRJ4urDJAeHrISh+2B+WiuH+aPgBjxzm117q69ih2YXeVIiilpjF9q
         mKZqxqBJD3PCNswdUqvUfJTbfftCDZraLIhGGuco0yTZcGSXuGNO5CbzPAqb1A87LBEm
         WGGscebJZkrkgL9r647MaRUzNIYezRFOcHaQQyLKmA2PH8+O1qXHWflrVp6Whk499yDe
         iReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044280; x=1780649080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gFsUMUtsy1cL7mLXns7mSBxO/z8pwoHJ3QJWfcSo/8g=;
        b=gSy1ndZstF4icy4VrsLljzQJZsZCzgHS5XXISBiV0DONhEZghnBN+Wj4+FulqMmxJY
         gwKw9BOvZ5QFg+Lh1HsK/xbzkoG9ljTBTVVj0MbPiBAIYVgRFagGdndlPJI2aHOu661c
         +TBeMLsNxIUnXnxR8ObSKLuwQbAu6l/xFs0vnUgxuAFqwBK+LATLwzpMBfznZ07aYk6i
         UdERt0hYbqB3C06O/TkmNwhm84DHtnhy4qjuVAG2JAUuKpn6VSNWpw00TzliM5pCEQ/o
         8IazyugSJiPPTlwSqpJTG4BdBQm3h3Ioefokr9A+A95s7qGuymGxQygBvn/lgJ6yvwMP
         /DZw==
X-Forwarded-Encrypted: i=1; AFNElJ86vRE26wYRVqeROEdWE/wvWdFfKhHkqN2lqy7Pk0m0eBmMnb25u4xY/J8k5TkIWhubkL08wp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydSeH7SKnyAvVCWK7pO++AmUNNg15nq1Nsy3xXeRHGvEagqjqz
	ILJrPAYf1/XmHhDAu+d2S6hd0XVS2cogQ665EUfzlNfSwNAzcQv9n1YkPxFSTgEiQyMoRJclTxv
	Hdc7shBqOz0suS11wl6oWEzf8I4FYBHE=
X-Gm-Gg: Acq92OG/Yb8MC6QdOLH6fuP0XV6HRsfhhoFUJTnIfp4bvKGWw9IUqU9aeQgE1DVJ0iR
	Pm77bOu70iGCPP1H9RPuTyMaoUPdQ4YOF7wD9xcZGvQbFwYc342u/hW4V7A2U1w99/7GeD3X7Yp
	1h9aGeyV37pPUwRU9mluvhrcaGKKVd1Y29fbxAFNC6jfHXfgIMrpA/WRMKXB8SZeats6M/Pw1HQ
	hGBVmmZpzzJvrgqIAZVQorUi4kOXMDu8EdN7NSjiZuZgzCp77OigtaT0Exqzlt7r6Kt3aaUbd2c
	VWJsFVSFF11O86nk9c/lX58wuu3hZ1DpoMC5x7mGRXNz0YTigms=
X-Received: by 2002:a17:907:1dd8:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-be9cac112aamr56012366b.23.1780044280110; Fri, 29 May 2026
 01:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528230750.1840681-1-mattst88@gmail.com>
In-Reply-To: <20260528230750.1840681-1-mattst88@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 29 May 2026 10:44:26 +0200
X-Gm-Features: AVHnY4LDUrhsTBVWcFxp4dD1EYQwUU5Jla-zgjfsJTfyvkkfprcEx8s5z28dN-4
Message-ID: <CA+=Fv5Q3BROR5Gr226Wo9KXRokZhsCeT4CY39rmJNQAqApKDbA@mail.gmail.com>
Subject: Re: [PATCH] alpha: Use work_on_cpu() for cross-CPU RTC access
To: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256559-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmag7@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,x.tm:url]
X-Rspamd-Queue-Id: 8FEB85FF833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 1:07=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> smp_call_function_single() runs its callback in IPI (hardirq)
> context. mc146818_set_time() and mc146818_get_time() take rtc_lock
> (spinlock_t), which is a sleeping lock on PREEMPT_RT, triggering
> a lockdep "Invalid wait context" splat on Marvel SMP.
>
> work_on_cpu() runs the callback in a kthread (process) context,
> which can acquire sleeping locks.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/rtc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git ./arch/alpha/kernel/rtc.c ./arch/alpha/kernel/rtc.c
> index cfdf90bc8b3f..4ad5846a1d71 100644
> --- ./arch/alpha/kernel/rtc.c
> +++ ./arch/alpha/kernel/rtc.c
> @@ -15,6 +15,7 @@
>  #include <linux/bcd.h>
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
> +#include <linux/workqueue.h>
>
>  #include "proto.h"
>
> @@ -155,11 +156,12 @@ union remote_data {
>         long retval;
>  };
>
> -static void
> +static long
>  do_remote_read(void *data)
>  {
>         union remote_data *x =3D data;
>         x->retval =3D alpha_rtc_read_time(NULL, x->tm);
> +       return 0;
>  }
>
>  static int
> @@ -168,17 +170,18 @@ remote_read_time(struct device *dev, struct rtc_tim=
e *tm)
>         union remote_data x;
>         if (smp_processor_id() !=3D boot_cpuid) {
>                 x.tm =3D tm;
> -               smp_call_function_single(boot_cpuid, do_remote_read, &x, =
1);
> +               work_on_cpu(boot_cpuid, do_remote_read, &x);
>                 return x.retval;
>         }
>         return alpha_rtc_read_time(NULL, tm);
>  }
>
> -static void
> +static long
>  do_remote_set(void *data)
>  {
>         union remote_data *x =3D data;
>         x->retval =3D alpha_rtc_set_time(NULL, x->tm);
> +       return 0;
>  }
>
>  static int
> @@ -187,7 +190,7 @@ remote_set_time(struct device *dev, struct rtc_time *=
tm)
>         union remote_data x;
>         if (smp_processor_id() !=3D boot_cpuid) {
>                 x.tm =3D tm;
> -               smp_call_function_single(boot_cpuid, do_remote_set, &x, 1=
);
> +               work_on_cpu(boot_cpuid, do_remote_set, &x);
>                 return x.retval;
>         }
>         return alpha_rtc_set_time(NULL, tm);
> --
> 2.53.0
>


Hi Matt,

Very impressive works, thanks alot for taking the time to do this!

The overall approach makes sense for RT: smp_call_function_single()
runs the callback from the IPI path, so calling into mc146818 code that
takes rtc_lock is not valid once spinlock_t can sleep.

However, I don't think this should ignore the return value from
work_on_cpu(). work_on_cpu() returns fn(arg), so the callbacks can return
alpha_rtc_{read,set}_time() directly and remote_{read,set}_time() should
return work_on_cpu(...). That also avoids depending on x.retval if
work_on_cpu() itself fails.

Also, now that this path is intentionally process-context/sleepable, the
existing smp_processor_id() direct-call fast path deserves another look.
A task could test that it is on boot_cpuid and then migrate before the
direct alpha_rtc_*() call. If the access must be on boot_cpuid, either
always use work_on_cpu(boot_cpuid, ...) or protect the direct path
appropriately.

So I agree with the overall approach here. I wonder if we could simplify
the conversion by returning the alpha_rtc_{read,set}_time() result directly
from the work_on_cpu() callback and then returning work_on_cpu()
from remote_{read,set}_time(). Also, now that this path is intentionally
process-context/sleepable, do you think the existing smp_processor_id()
fast path is still safe against migration, or should we route the access
through work_on_cpu() unconditionally?

Regards

Magnus

