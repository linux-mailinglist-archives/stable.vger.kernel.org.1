Return-Path: <stable+bounces-240488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKmlGMkf6mntuQIAu9opvQ
	(envelope-from <stable+bounces-240488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:34:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519C453025
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D998306774B
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF23F0AB4;
	Thu, 23 Apr 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GYkEUMFj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674283F0AAE
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950718; cv=pass; b=s2HAZlJr1v0btYR4yARdwZKMW0GuwYJ+kYCNRVYyaChSPIZDt5LbdlFg6nG84Izu+ZU2tUxgqy3KAQIhA2N4WgxxLSlFQeLiFByw6i5CDAJtx2KXA6gwkyWcwmcxZuisLkbCGYWxHrJ84LBXqAsWM+R+0VuWuFf+e7gPixeftZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950718; c=relaxed/simple;
	bh=9b8754IDEm0TQDjQSnxDEexYNuYd2dC6tmyRCw03JwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx2wMedGQxDEqSABrh1vefzdfhqdTAiwZo5KmtdL9plOHhrMFCw9HusIHBtOUpJKnfhalo1MBKdD5Z7DRDDsPdpHhCmMWC4igTiHG8gSTfEaPXxGnb96NP3gPwEfci1X8upYSQM1tETnrbJ4GcYK6Fkxtb1/z7xLGMENqPr09ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GYkEUMFj; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6540fe6a8e1so5647914d50.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776950715; cv=none;
        d=google.com; s=arc-20240605;
        b=VIrYXk+ViXafmzZcXGluzjkgCs6DeUZJd3xULkqdSIiaVg3PuukmkQAhacpEhZJ9vq
         RypX4nZNeYnQYQqds+hqfORaAMmo+K1yJLzQ+xf3sOo4Ps/b6Bui7vBptPTUdJhA/ULA
         21jf+wPP557NInHHmbYROodHi7/mQOTloYrtTDyKqPTB4VDHF69Q3Z0v54hi5NCwaXcM
         u++41Bn3pb6vZ6AFQ95bcthTDYgAhS/wbW3T4vnTK6gHeCNbh9sLpeTENrqC201KyrjG
         T/SNHXRAdOWJKZhXwwKNUbs9INKy51MJvBQrDZLxvQZcgidOsJqc3CWT52L87Hh41Uxr
         pOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        fh=bfOJ5hDFd8kvJDeB2tjIY8xtDnZD8Lji8fLNlF4ONAk=;
        b=ija2EOKWjOq5Y+lmSbEkdPsYmoFgYT4gCysPYycrHCdM12cqVTP8sB5HF933OuqJ7c
         LQRDjo0nJq5n86AV7pdkGtLMJ7d4ajreqV3XQApxWEDZ5NCNT0h7ZHtVW9916KsiaWfF
         bpA7E5OsZdxsMGA6SY5irR55qhr+m149kOMC4eU3O2YiKzgkJXIE9XCbXWPBhP39a1TU
         QRObjLw6oTHscWGylcaijvNXNo00yayOJeIJ90xsAcSrfr/KnD9L1cnPfNV+EKF1Sf6D
         /fN8bFjvPQqk1DACPUFKWhT92I34BSvt4olXT8IIqbcYQskqW6dvGP6/Wdf7lxCWYm1h
         FJUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776950715; x=1777555515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        b=GYkEUMFjmceiNCtpVlZJN/CS/8bgBuEXGSA70ElbG0qbEzUFDWFrHaYJaoBY7t0OjU
         ATEj8yutKcRnCCKXAVFWh4G1BQtH6jTviOaUue9dC7vOtmkAM28+qSrS5Wix6cRk76kE
         +e0hJ4xxpfIllirCrxMm2ShkgcRakNWK/kKAfZKgne+3vZ1P9Qk3hEtvfiC+QLSdpoRa
         ktzq0v8+sQ0LLT9A5BpgqI6qS3xyKxfCAjktMFtxA3UV1UOCmvEkyXIID9JJGN89XbMY
         Xb54Vt8ZFs8dke3Gr/oAiZTEgO9JpXrMtN/3c+Hg5h0mwQX+owCPXn/2yUFJwYOSOZmt
         Wisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776950715; x=1777555515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        b=hhtKGwG1PiyPCG0l3H0Ydr/p3xaZOM8yLPiMGgbNJcmKrv2UNE3szriiXxlN+q+l80
         z3QkXQDy/MzZ7AVR5WfqyChY2qdVynhkQIxNtEe7BtjGCQ+u5YPofb74R76OjqZ7nNvb
         GJfnwWwOgiI8KptSLAfw7zq59sm9k/qhi75YeLQWhX89sCXL3ywDv3WxXVYpvQNq00nE
         AEScTLxNgm814hFmBJaRWWzXvYfbA87SoSBkDhGvgz1bieh1g1btbS24nBS3V+KafOHO
         bbJheLqNbjPH7Cd5g2so9gT5j6hBt5bam55GK9npKeslrjUsmg31/S+SZXbMXlqVzKXN
         k62g==
X-Forwarded-Encrypted: i=1; AFNElJ8ptY/VD+F0yIDpSVPNBKM0nBZasjITwP/nDwT/5Q39CGKBUmIBT6/59v+noasczsmpOwEcYyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4g6nesNwk/GtCZtr4KRr2nwtnn1cRxGBTh6Gdu0pGzgJxMEpl
	h7Te/KDQErNVqUY9RgkmXl9HYTNgRXYDd7bkgqRnnAQMcX7wbzFD09yuiANFChBDUimIm6n7WvN
	qmoU7cs6zu4o++SbBDbaDm0LanpPcbj93XdJpQEYQjg==
X-Gm-Gg: AeBDietOeE1BKURwsMs/SQQrN99vPCZbdGwEIttBTo6rvzKBX/IKp8+8iHv8eCPBjmK
	9jMHS/iPHzD53X7wMSUcyB6p7r+Xl7R6wXw0ho+St0TEgbvms6YlDz7SpDi9K9G854D9pkme+vR
	/pURutd+haSCqTIiJY2wqHkfK4P+Yp0BeolDqgpPsYLtO4fgLXEdeo7cRsLTPKgLfKGK+B8OUd3
	mw5HGIzs6Q3R/wZbgJy+wB2CnGNKYZp+MUNT0nuUts2tm9JFxFccaYEhU1AxFYs58iyc4cz+kOc
	Vv44eKWtS5bf/d5t0hXHMiQSVqpJkQOO1kUuBYvkpNQB/xWp
X-Received: by 2002:a05:690e:1913:b0:64f:fa9a:9017 with SMTP id
 956f58d0204a3-653108846afmr26025810d50.28.1776950715337; Thu, 23 Apr 2026
 06:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aefAWGcAQHeRYbs8@slm.duckdns.org> <20260423090100.3231633-1-sonam.sanju@intel.com>
In-Reply-To: <20260423090100.3231633-1-sonam.sanju@intel.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 23 Apr 2026 09:25:04 -0400
X-Gm-Features: AQROBzDuqnoAWQ0x4UMQxhwITFSDzgrxL0fOr-O37WxBma-Xso9IsfXUvAQZ01s
Message-ID: <CAO7JXPgf-PQah9XCq-KD+FimQATkxy4HpvWy6r6LDT52Jv0sdA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
To: Sonam Sanju <sonam.sanju@intel.com>
Cc: tj@kernel.org, dmaluka@chromium.org, kunwu.chan@linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	pbonzini@redhat.com, rcu@vger.kernel.org, seanjc@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240488-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[bitbyteword.org];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,bitbyteword.org:dkim]
X-Rspamd-Queue-Id: 9519C453025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 5:05=E2=80=AFAM Sonam Sanju <sonam.sanju@intel.com>=
 wrote:
>
> Hello Tejun,
>
> Thank you for the detailed analysis.
>
> On Wed, Apr 23, 2026, Tejun Heo wrote:
> > The problem with this theory is that this kworker, while preempted, is =
still
> > runnable and should be dispatched to its CPU once it becomes available
> > again. Workqueue doesn't care whether the task gets preempted or when i=
t
> > gets the CPU back. It only cares about whether the task enters blocking
> > state (!runnable). A task which is preempted, even on the way to blocki=
ng,
> > still is runnable and should get put back on the CPU by the scheduler.
> >
> > If you can take a crashdump of the deadlocked state, can you see whethe=
r the
> > task is still on the scheduler's runqueue?
>
> I instrumented show_one_worker_pool() to dump scheduler state for each bu=
sy worker
> when the pool has been hung for >30 seconds.
>
> All workers show on_rq=3D0.
>
> =3D=3D Pool state =3D=3D
>
>   pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D47s
>   workers=3D13 nr_running=3D1 nr_idle=3D7
>
> =3D=3D Per-worker scheduler state (first dump at t=3D62.5s) =3D=3D
>
>   PID  | state | on_rq | se.on_rq | sched_delayed | sleeping | blocked_on
>   -----|-------|-------|----------|---------------|----------|-----------=
--------
>   4819 | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4823 | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4818 | 0x2   | 0     | 0        | 0             | 0        | ffff953608=
205210 type=3D1
>   11   | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   9    | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4814 | 0x2   | 0     | 0        | 0             | 1        | (mutex hol=
der)
>
>
> All 6 workers are in kvm-irqfd-cleanup, calling irqfd_shutdown =E2=86=92
> irqfd_resampler_shutdown. They contend on the same resampler->lock
> mutex (ffff953608205210).
>

Sorry for the late disclosure; I was running the 6.18 Android kernel
and missed this relevant detail because the bug discussion initially
started with KVM and I had verified the irqfd related code was the
same as the vanilla kernel. Now, after going through Tejun's response
and reviewing the __schedule() code regarding SM_PREEMPT, I realized
the Android kernel has extra logic related to proxy execution that
might be triggering this issue. I tested on vanilla 6.18.23 kernel and
was not able to reproduce this.

Sonam, just checking if you are able to reproduce this issue with the
vanilla 6.18 kernel?

Thanks,
Vineeth

