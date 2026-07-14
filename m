Return-Path: <stable+bounces-274465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8KoMbhpVmpr5AAAu9opvQ
	(envelope-from <stable+bounces-274465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:54:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF17757202
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W8C2R35o;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274465-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274465-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9F2302B82A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B04DA55E;
	Tue, 14 Jul 2026 16:53:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EF4D98FA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:53:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047993; cv=none; b=QyzuLVfqYMXSX8yD0KaZRuohKMM7O/cVBjF1kcNCxlYO0Poxq0KFe7+IoYHcGHFtBl5pmLRCVIKE28XVLBD4yHISOX9BZxadkk7th8XlBBcaPb2R1QmQjpTaNKcwO0M3/1N7y9P14bHJdkDBTol8/Gvckp1Vxs5Qgj1oHTuLHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047993; c=relaxed/simple;
	bh=UynP7waHvnVv90IW7+Ff+tGm6Qvp6W0MRtKVTBQnnXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDOP2Z8vQ2h4e5U/qL3qRv7FgXOpbes/KfQpTYlyQFkqeiab91M3CtnJ2YR3iTNKFE6EDDnkPmU8YU9hk+lq6D5PUK1ivxISORQT7+TBjNJccrsyNHHy1iLll8wM471N8mEbl0uiYw3ggK1HE8pinWlKiEPmaydPNqyIEQUDExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8C2R35o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A322C1F00AC4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047992;
	bh=0GuTTRWvyCne6K/TMPuZlWhgMIx0adVHAqSG19V+XXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W8C2R35o/I1X5fPhJO9ImuwUaHrliG8WoQRrIrsHHP4d1xxjszyvgMZi2CiFMypDn
	 uoN3tI+ojAif5C21kFnBwncWcXpTiI7KPsUfIgW6T108T0FTvUlrkqToyUX1LH+q6m
	 Wbbt2qPDYd76RKnyIBH+ReHj+2xasBqZAkwiH1tBsHjEO3oysgzORSsjibaQJH4zGq
	 LxM8U53HTEsaopQ+3EIXviGDjsK6JFEHg+x/w/+24Tw2g68cYfSCabaVhWzhSzr0tQ
	 168cUo75DXafH+UqJ/UJdHSvxrCoNu+ToDYsf4RhSx2v+HLQu2zSJftwhhRfkP0CXB
	 hnajdki9ChO7w==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15e2dab83eso194393166b.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:53:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7JChjLixCYSk6ph4L6X+Hnz4oV+iKjLQS7HDWE+Wc3WmZQ2+0jDUZNJr4ge/7XLfl8SHqWqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26wIwnakjXp02fE1d/YXGVgOAveT/cIsjlyojnQtS7j+8O4tK
	wPlyCb+sEpcdZ3zlbq6Q+j4plz4aF02hWBKw0Hgy//g0+dw8QhxGEtRT9UIQBqJBGja5QZtgUSe
	1RqZz5EDpZiA6Hr2JHzTDBAbNBOTrCMk=
X-Received: by 2002:a17:906:f5a1:b0:c16:12ff:dc8b with SMTP id
 a640c23a62f3a-c161f3b58ecmr712408966b.54.1784047991521; Tue, 14 Jul 2026
 09:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081510.16895-1-jiahao.kernel@gmail.com> <20260714081510.16895-2-jiahao.kernel@gmail.com>
In-Reply-To: <20260714081510.16895-2-jiahao.kernel@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 14 Jul 2026 09:52:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
X-Gm-Features: AUfX_myK2ScSuKb9Od0WSe9xHl83YPOH--7pRL1A1D1eWAOU3YMEEFq2p0-lNTY
Message-ID: <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
To: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274465-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:stable@vger.kernel.org,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,kvack.org,vger.kernel.org,lixiang.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FF17757202

On Tue, Jul 14, 2026 at 1:15=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
> Therefore, the global shrinker shrink_worker() always takes the !memcg
> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up=
,
> so it fails to write back anything.
>
> Therefore, when memory cgroup is disabled, fall through with the !memcg
> branch and shrink the root memcg directly.
>
> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
> LRU is empty, which means the total pages are already below thr. The
> loop then safely bails out via the zswap_total_pages() <=3D thr check.
> For any other return value from shrink_memcg(), the loop is guaranteed
> to terminate, either after MAX_RECLAIM_RETRIES failures or once the
> threshold is met.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Cc: stable@vger.kernel.org
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Reported-by: Yosry Ahmed <yosry@kernel.org>
> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeL=
c=3DeyTPKPVQgX4g@mail.gmail.com
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Patch 2 doesn't really depend on this one, right?

If that's the case I think this can (and should be) picked up
separately as a hotfix. Andrew, WDYT?

> ---
>  mm/zswap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b5a17ea20237..3d697a1a5365 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1356,11 +1356,12 @@ static void shrink_worker(struct work_struct *w)
>                 } while (memcg && !mem_cgroup_tryget_online(memcg));
>                 spin_unlock(&zswap_shrink_lock);
>
> -               if (!memcg) {
> -                       /*
> -                        * Continue shrinking without incrementing failur=
es if
> -                        * we found candidate memcgs in the last tree wal=
k.
> -                        */
> +               /*
> +                * A NULL memcg ends a full hierarchy pass (except when m=
emcg is
> +                * disabled, where it is always NULL: fall through to the=
 root LRU).
> +                * Count a failure only if the last pass found no candida=
tes.
> +                */
> +               if (!memcg && !mem_cgroup_disabled()) {
>                         if (!attempts && ++failures =3D=3D MAX_RECLAIM_RE=
TRIES)
>                                 break;
>
> --
> 2.34.1
>

