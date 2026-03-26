Return-Path: <stable+bounces-230512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMCPBcd3xWnw+QQAu9opvQ
	(envelope-from <stable+bounces-230512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:15:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD85339E03
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2452303E415
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38B391836;
	Thu, 26 Mar 2026 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT4AE684";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5CqWKwy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB383FF1
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548769; cv=none; b=c6023CZUjQuljTFUl2zncnyr/uRuy6XFeeJ9AE9KCgfSIx/5nL0zj3CGLyN2aVBBiZwwrlPla+Y1FfJGJtmCJ7cGWn59Kb8IfXYEPNxInIOtbcd4/dNRcJ/+7JxLz4NBe9bknk8Zv0TmiXk7tK+Y1KXQ8ogLXSdGS1EeyMNWrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548769; c=relaxed/simple;
	bh=Nyn9o0z/Vyj5eL80gjL6x3Er/Npl+b/ftlHZrrMv4Qc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltWq6S1TYmsesj24PPQxs/00KTHx8ZhsnvbSXNLrexvTixLjjPgHwoSZFL2xpTLF82x4Zkz8MAYhEn/KyBhkhabK+Oa9Yb5kbtyCDRIvR7A6r5ZHCMOikeGRL3sZkzbk8S91FFQylDRQr7UYX3JF/fjtig4MaYRJffX4p2Rq0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IT4AE684; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5CqWKwy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774548767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUmfuyK4xGMAdmr2y9W6DRQeyz6/9EcH7bMhjshvQQo=;
	b=IT4AE684ZsUiggFVO1IIOEk8pQpxbEwzeaPNpExrjMaeNlkSCD+tV8pxUJVOILhNNSUUXk
	tJUAoL/bWKE1JCLztJtIQZNi/PxZQg+n1ihTn9/NhidIUd3eYWnagkI/50/P8mantDoT97
	gxYO3ZJ4y6nT9M2q8qPYDAjPg9UjLAY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595--7UQvB5wPl6NVi00aqdviQ-1; Thu, 26 Mar 2026 14:12:45 -0400
X-MC-Unique: -7UQvB5wPl6NVi00aqdviQ-1
X-Mimecast-MFC-AGG-ID: -7UQvB5wPl6NVi00aqdviQ_1774548765
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89cc6879a4bso37326366d6.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774548765; x=1775153565; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUmfuyK4xGMAdmr2y9W6DRQeyz6/9EcH7bMhjshvQQo=;
        b=P5CqWKwy6m3hDmtNKCy8CvfVVDmJTfeofnHg25cNUSuDRLfNak6IUWCNTpBqljYLLH
         tSKe1ybmuKHsVJxcFJAwXkldspiwp1duEjfMNPo1yHsae99ypC8iYnCPGNTw3llkt09L
         kprrSJBqGWz2q6IudIewx3oN7JJ47IuqLK3Ak4UkZX+RNpvpqSieFRG05jxiniZvR+TS
         jJwEkLhg3VL++6M4IVS2VsztfusNhb4cvzV2yhZfZhn0oigEZFKqGI/JfzF3aEZljBy+
         17e3UYa2xq0WQY0khP/Kh4RbCuU0XVZ49U3lxpLokHYTlZ7dD2p6Py0CGFj5eXJp5uSr
         sKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548765; x=1775153565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUmfuyK4xGMAdmr2y9W6DRQeyz6/9EcH7bMhjshvQQo=;
        b=gpR4LvLpMr42yhU4i9SB6KDL/id5+5juNaF/hFxN48Upc/+mODo0a1kIBYYjcm96EP
         2iFDkpMArWkGwlx8SvqvSNUuNgSx0k5AqTOykAjYatnaGrVjYWz5oz9kG02MBQ+OTNE9
         kgSIdLJwPJ7i/X9Vm5t7gLZLKosEcccQfLVfOfACoxXiyMTYpm/nIhUvK5J6l91OkyU5
         OL4a+9PdrTq8tXd+bwzXYcaORhlfgZlwPnQl1yk8tiFs3RSK/Lcy3c3/0TH+BRB0vTkj
         7MuqqpuxfafIlyO1oQWBcHU+6hm4blGizw/dFq19po1tH6h0DbzR8XuUpzLnAeQtNWi6
         ufVw==
X-Forwarded-Encrypted: i=1; AJvYcCVyuoaw1/5i1EYM/A19z6vHse76O7RRcEpwGWOMgKtzNKt93NF219vNpzpIe+dhdEMLcd4PR1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqvTQ3imH7WkWI2li6ro/iIINdgPNtU6mGgN4UDHrkUuBfBGB
	+j19eZbXfHOnAXKz/OBw3KL4oveUizeMVDZICWiQh7nIDnu5MYIOaTm6YLle/oXY3f4mi1IXxZN
	fLYnRsy2yjSWMC7g6NqJiK71/DXUT2mUbfUCE/EGe6+DKKBykS9OLjxgBtw==
X-Gm-Gg: ATEYQzzi1XEHzJimsjUbHin6CztuK3i92LaRNaOeCo3ZzAspFAD3JFypO48i3qzufNi
	uXG2yg4I5oPwzbGFgR/bLTLgmVi1D2brqq86bDd0QHiKD2BKrAVxVVNbWNEWn/gz4ydPYciZ1dm
	JTGt0VWlbI4KCd7Rz8GaP48olBZ3PU8Y69Of7/5s/WkkEtpxy7tNpyWbExM+WlfDiTKUgpowvBK
	wO81nsG3CKHth3DABMXlqvsFSTb4LyNRnB8oM+tyaME0HkJjBazUy+BHz590dcz+MTYVj8kC+89
	5yzWRv+qtmMBgvKIsGD0h5ZL20783HN3gtUUrxzJq1bt5ZIoNwlUmQ+zTIFcLTrYC0yfXzZoHC/
	gHUcSdxw3qm/BVPATcXH5XswD3wcuSjcQBgv5GwtTLDih3JO/upeFeQ==
X-Received: by 2002:ad4:5963:0:b0:89c:ceaa:872c with SMTP id 6a1803df08f44-89cdde2d618mr35273506d6.13.1774548764654;
        Thu, 26 Mar 2026 11:12:44 -0700 (PDT)
X-Received: by 2002:ad4:5963:0:b0:89c:ceaa:872c with SMTP id 6a1803df08f44-89cdde2d618mr35272566d6.13.1774548763964;
        Thu, 26 Mar 2026 11:12:43 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a24fd9sm29826276d6.25.2026.03.26.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:12:43 -0700 (PDT)
Message-ID: <af22ac4288e36ff879fa8993790c11973f6af45d.camel@redhat.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes =?ISO-8859-1?Q?~50=B5s?= noise spikes on isolated PREEMPT_RT cores
From: Crystal Wood <crwood@redhat.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
	namcao@linutronix.de, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, frederic@kernel.org, 
	vschneid@redhat.com, gregkh@linuxfoundation.org,
 chris.friesen@windriver.com, 	viorel-catalin.rapiteanu@windriver.com,
 iulian.mocanu@windriver.com
Date: Thu, 26 Mar 2026 13:12:41 -0500
In-Reply-To: <20260326140058.272854-1-ionut.nechita@windriver.com>
References: <20260326140058.272854-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-230512-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[crwood@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACD85339E03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-26 at 16:00 +0200, Ionut Nechita (Wind River) wrote:
> Hi,
>=20
> I'm reporting a regression introduced by commit 0c43094f8cc9
> ("eventpoll: Replace rwlock with spinlock"), backported to stable 6.12.y.
>=20
> On a PREEMPT_RT system with nohz_full isolated cores, this commit causes
> significant osnoise degradation on the isolated CPUs.
>=20
> Setup:
>   - Kernel: 6.12.78 with PREEMPT_RT
>   - Hardware: x86_64, dual-socket (CPUs 0-63)
>   - Boot params: nohz_full=3D1-16,33-48 isolcpus=3Dnohz,domain,managed_ir=
q,1-16,33-48
>     rcu_nocbs=3D1-31,33-63 kthread_cpus=3D0,32 irqaffinity=3D17-31,49-63
>   - Tool: osnoise tracer (./osnoise -c 1-16,33-48)

Is SMT disabled?


> With commit applied (spinlock, kernel 6.12.78-vanilla-0):
>=20
>   CPU    RUNTIME   MAX_NOISE   AVAIL%      NOISE  NMI   IRQ   SIRQ  Threa=
d
>   [001]   950000       50163   94.719%        14    0   6864     0    592=
2
>   [004]   950000       50294   94.705%        14    0   6864     0    592=
0
>   [007]   950000       49782   94.759%        14    0   6864     1    592=
1
>   [033]   950000       49528   94.786%        15    0   6864     2    592=
2
>   [016]   950000       48551   94.889%        20    0   6863    19    594=
2
>   [008]   950000       44343   95.332%        14    0   6864     0    592=
5
>=20
> With commit reverted (rwlock restored, kernel 6.12.78-vanilla-1):
>=20
>   CPU    RUNTIME   MAX_NOISE   AVAIL%      NOISE  NMI   IRQ   SIRQ  Threa=
d
>   [001]   950000           0   100.000%       0    0      6     0       0
>   [004]   950000           0   100.000%       0    0      4     0       0
>   [007]   950000           0   100.000%       0    0      4     0       0
>   [033]   950000           0   100.000%       0    0      4     0       0
>   [016]   950000           0   100.000%       0    0      5     0       0
>   [008]   950000           7    99.999%       7    0      5     0       0
>=20
> Summary across all isolated cores (32 CPUs):
>=20
>                           With spinlock       With rwlock (reverted)
>   MAX noise (ns):         44,343 - 51,869     0 - 10
>   IRQ count/sample:       ~6,650 - 6,870      3 - 7
>   Thread noise/sample:    ~5,700 - 5,940      0 - 1
>   CPU availability:       94.5% - 95.3%       ~100%
>=20
> The regression is roughly 3 orders of magnitude in noise on isolated
> cores. The test was run over many consecutive samples and the pattern
> is consistent: with the spinlock, every isolated core sees thousands
> of IRQs and ~50=C2=B5s of noise per 950ms sample window. With the rwlock,
> the cores are essentially silent.
>=20
> Note that CPU 016 occasionally shows SIRQ noise (softirq) with both
> kernels, which is a separate known issue with the tick on the first
> nohz_full CPU. The eventpoll regression is the dominant noise source.
>=20
> My understanding of the root cause: the original rwlock allowed
> ep_poll_callback() (producer side, running from IRQ context on any CPU)
> to use read_lock, which does not cause cross-CPU contention on isolated
> cores when no local epoll activity exists. With the spinlock conversion,
> on PREEMPT_RT spinlock_t becomes an rt_mutex. This means that even if
> the isolated core is not involved in any epoll activity, the lock's
> cacheline bouncing and potential PI-boosted wakeups from housekeeping
> CPUs can inject noise into the isolated cores via IPI or cache
> invalidation traffic.

That sounds like a general isolation problem... it's not a bug for non-
isolated CPUs to bounce cachelines or send IPIs to each other.

Whether it's IPIs or not, osnoise is showing IRQs on the isolated CPUs,
so I'd look into which IRQs and why.  Even with the patch reverted,
there are some IRQs on the isolated CPUs.

>=20
> The commit message acknowledges the throughput regression but argues
> real workloads won't notice. However, for RT/latency-sensitive
> deployments with CPU isolation, the impact is severe and measurable
> even with zero local epoll usage.
>=20
> I believe this needs either:
>   a) A revert of the backport for stable RT trees, or

Even if the patch weren't trying to address an RT issue in the first
place, this would just be a bandaid rather than a real solution.

>   b) A fix that avoids the spinlock contention path for isolated CPUs

If there's truly no epoll activity on the isolated CPUs, when would you
ever reach that path on an isolated CPU?


-Crystal


