Return-Path: <stable+bounces-211509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBLzCdPfdmmhYAEAu9opvQ
	(envelope-from <stable+bounces-211509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 04:30:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3D83AF9
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 04:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CE1300422F
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04F267B05;
	Mon, 26 Jan 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQjsEPuF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81920B810
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769398222; cv=none; b=ihzAoMlw+5dFZvkD9fgpph/5RiOIij+OfU0eQdEBhJlXWfEyoMHRT+IgoMlGSl3d/+dx0hXxI8xoBYZ4xdcGNXgCeg2Tg24iIpd6ovtGsnSeQKWIB21KT5L+fl923/ilfA311Ev0K5gPQjwG2JEDRhQFkyBfjazTxSQLnwJjtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769398222; c=relaxed/simple;
	bh=odnHQjFmvL9q0KAXvfxM5lKxhjvove08qebNT2N/TYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXQ2eXp+7kCyAPb2cJr2GQA/cjuMPSRzo+e/ECm/jwYJCkeDsFLoFuyQaahrZjzwsKUqnUiBR50fEblxIZMfsJLuSdkk2orJNDZE276JxYqEnh1KXiojWTaouT0+xChKMwJ+gV/NQTGuTyan64NEOVhUNgk8+EzirKIWsNyODHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQjsEPuF; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b7070acfdcso4609284eec.0
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 19:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769398220; x=1770003020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALi30XfcHcP7oXf6VT++jD7PYo4ntaFHOPvpKBXFeRE=;
        b=SQjsEPuFoIIv7vmZ7ST28ifCdVexsZ28ScvlTDN52PrkEH5NlA2sQIOUK10k3oAJL3
         pa0k6jbiEkAgqUPf8wmr9U+BPL/DTTcKV0Ck2FHi+UzTTxlTuvkprKJNuENYnlPqv2qn
         A5N+ybjv0TCQ/eO5lXJ92ICEjxvZw6wV+v4kMVRBxhuvTG7GB7iqBadSKun+Zwqfn0vt
         Ng3CQENVMvyD9652ZpFMzEIfa0f3rS1Hh6HCeosfUMmsNDhnNoakjk44c8WyD+LrdlRT
         WVBmufytixsYpL6pONB6BKDk1PEcDlHuCFCV81DB9Bvz5zkzeYJnwDWgHu5A0gTgdjZs
         41tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769398220; x=1770003020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALi30XfcHcP7oXf6VT++jD7PYo4ntaFHOPvpKBXFeRE=;
        b=DypxutJLGLrDiwTUoUlWvkVqHXPM4D2XQXkoawhUcmkkVldzhru1+9I9YHqb9P5e9X
         Vl2BI+MzVL0nYGXmS+ATCrCNIdspLyDuO23sHvRsG6CKaF//mndkwC3iso0Pw26eFzUU
         dRfppvVS3Mp4y4GqyVYfwyWHQXZnB0Dvo8RGq2KcwqsYvskz1QFvPplgFeah5JW8WZIA
         JUsKDCOUf0bqDLspInp0fque+bWBnmODAqWiD+vfxY4qO8+XhmyTg1TdHXkGQnD1G5Rk
         P3eBbvFWVK42LX2nq9ajbTGreTJwUyoyVp+OdUQ8b7Jt5zddooV/+uf5UulUVQK6jMPS
         gijA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQkqWZ0yX1VCeXi/ggE7NLL4ykJBLJh9zXiP3JDOVLD/SvZ68RiqQIDti8ld9h2cc6BrQKuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOteqd2hXMKCxPjFDGWQOGl5UVC0hSyeAwwS7TJ2INXdE9QWUG
	V73N74MbEprFJ1Yqk9tOvldeMYhj5hLsVEox8AFmRbh9gIfwA13+NN1A
X-Gm-Gg: AZuq6aITXHV9UMs4PVxIeHzl5WZTcyXMYz1k2G3xZqIu3EfASIZql0YemFLm4oL6ZWt
	Sas7lSgJlzZ4P0A3lbyB5W1TjHbn9OBK0raPyb9v4SAc6tXiGVW29QA8JDrsrulB/gThxGQRT0o
	BU9hF4y5mSn66/UdwqVbfy1bvlU5gRqBQfOmE9sCFybWTo9fCd4q5/va9McyHNPi4hwqD+DzP57
	npU/5BJujaX1QVML3mf5l+frRHmPmqBGrRiqLuowkAEm+gjHM1XV85cwqquJeY2GEVZzDUKQpaP
	SGpk5MJCa5IMOH5ToNhn/EaOtgC+pA/JhiCvgIEcEt0GFqvihhbOhyvDh7cH8RPN+2xuaH8ZHVf
	O3WHQAEP/mx7UYZ0WYuvfqylmjRbrPinBH8PxofXdLfYae7nDxncqdD80KKuSjcsSdXZFzWtlTz
	XbzHg=
X-Received: by 2002:a05:7022:511:b0:123:345b:ba05 with SMTP id a92af1059eb24-1248ebf7011mr1465124c88.22.1769398219711;
        Sun, 25 Jan 2026 19:30:19 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cda6sm15429026c88.1.2026.01.25.19.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 19:30:18 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: dianders@chromium.org
Cc: akpm@linux-foundation.org,
	lihuafei1@huawei.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	mm-commits@vger.kernel.org,
	realwujing@gmail.com,
	song@kernel.org,
	stable@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn
Subject: Re: [PATCH v3] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Sun, 25 Jan 2026 22:30:12 -0500
Message-ID: <20260126033012.934143-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAD=FV=Vmk1jA+dAgJNVDMtxrhhrPxgnXkNxiqJXWBvgUcZZUxQ@mail.gmail.com>
References: <CAD=FV=Vmk1jA+dAgJNVDMtxrhhrPxgnXkNxiqJXWBvgUcZZUxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211509-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,gmail.com,chinatelecom.cn,linux.dev,hisilicon.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 4EB3D83AF9
X-Rspamd-Action: no action

Hi Doug,

Thanks for your further questions and for digging into the 4.19 vs ToT
differences.

On Sat, 24 Jan 2026 15:36:01 Doug Anderson <dianders@chromium.org> wrote:
> The part that doesn't make a lot of sense to me, though, is that v4.19
> also doesn't have commit 930d8f8dbab9 ("watchdog/perf: adapt the
> watchdog_perf interface for async model"), which is where we are
> saying the problem was introduced.
> 
> ...so in v4.19 I think:
> * hardlockup_detector_perf_init() is only called from watchdog_nmi_probe()
> * watchdog_nmi_probe() is only called from lockup_detector_init()
> * lockup_detector_init() is only called from kernel_init_freeable()
> right before smp_init()
> 
> Thus I'm super confused about how you could have seen the problem on
> v4.19. Maybe your v4.19 kernel has some backported patches that makes
> this possible?

You caught it! Here is the context for the differences:

1. Mainline (ToT):
   - `lockup_detector_init()` is always called before `smp_init()`
     (pre-SMP phase).
   - Risk source: The asynchronous retry path (`lockup_detector_delay_init`)
     introduced by 930d8f8dbab9, which runs in a workqueue (post-SMP)
     context and triggers the UAF.

2. openEuler (4.19/5.10):
   - Local `euler inclusion` patches moved `lockup_detector_init()` after
     `do_basic_setup()` (post-SMP phase).
   - Risk source: The initial probe occurs directly in a post-SMP
     environment, exposing the race condition.

For openEuler (4.19/5.10) kernel, the call stack looks like this:
  kernel_init()
  -> kernel_init_freeable()
    -> lockup_detector_init()       <-- Called after smp_init()
      -> watchdog_nmi_probe()
        -> hardlockup_detector_perf_init()
          -> hardlockup_detector_event_create()

In mainline (ToT), the initial probe (safe) call stack is:
  kernel_init()
  -> kernel_init_freeable()
    -> lockup_detector_init()       <-- Called before smp_init()
      -> watchdog_hardlockup_probe()
        -> hardlockup_detector_event_create()

However, the asynchronous retry mechanism (commit 930d8f8dbab9) executes the
probe logic in a post-SMP, preemptible context. 

For the mainline (ToT) retry path (at risk), the call stack is:
  kworker thread
  -> process_one_work()
    -> lockup_detector_delay_init()
      -> watchdog_hardlockup_probe()
        -> hardlockup_detector_event_create()

Thus, `930d8f8dbab9` remains the correct "Fixes" target for ToT.

> OK, fair enough. ...but I'm a bit curious why nobody else saw this
> WARN_ON(). I'm also curious if you have tested the hardlockup detector
> on newer kernels, or if all of your work has been done on 4.19. If all
> your work has been done on 4.19, do we need to find someone to test
> your patch on a newer kernel and make sure it works OK? If you've
> tested on a newer kernel, did the hardlockup detector init from the
> kernel's early-init code, or the retry code?

In newer kernels, when the probe fails initially and falls
back to the retry workqueue (or even during early init if preemption is
enabled), the `WARN_ON(!is_percpu_thread())` in
`hardlockup_detector_event_create()` does indeed trigger because
`watchdog_hardlockup_probe()` is called from a non-bound context.

I have verified this patch on the openEuler 4.19 kernel. During our stress
testing, where we start dozens of VMs simultaneously to create high resource
contention, the UAF was consistently reproducible without this fix and is now
confirmed resolved.

The v4 patch addresses this by refactoring the creation logic to be stateless
and adding `cpu_hotplug_disable()` to ensure the probed CPU stays alive.

I'll wait for your further thoughts on v4:
https://lore.kernel.org/all/20260124070814.806828-1-realwujing@gmail.com/

Best regards,
Qiliang

