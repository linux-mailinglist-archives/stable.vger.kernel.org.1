Return-Path: <stable+bounces-270005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wpjAHDDqQ2r5lQoAu9opvQ
	(envelope-from <stable+bounces-270005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:09:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C281B6E6460
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AyU9pysZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270005-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270005-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB4D309143E
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEDB472794;
	Tue, 30 Jun 2026 16:02:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1046AEF1
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 16:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835377; cv=none; b=QlmU3PbTBfLVciSqi63RmSM50gXX5lYAL1Iw2cyT5172VvbFFcgXAXIt7oGrGQlgPEaAyYZI49vYEjzG57qxfii4R2L/5woZe4N1pk0EKk61SjuGlRIGCze7kbs8WJOhvTJ2IP5p4PtPbQ/i8IDX/smk+veO8R45EDZP3CgFtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835377; c=relaxed/simple;
	bh=rJypcviBg/vRv6ioQRUNiFCv1YHZxZVbYVHtKG9g1HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy8lPiVhrUF9e9/Rkmynr3TpFREZ39/7PHtb1W+Wd89Rjltq78ZG9KOphJQTL3+fwHrwJG/xZvKpkN2UrzVqYSsJ3nvfw2z6m1LvRsAM4HoFI+jlcs1Okrd3Ofy5anlKtjXS9N+1vGsQOgZZey8iAAkWzFRqQAw9QA3rBk4NYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyU9pysZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B184C1F000E9
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782835374;
	bh=umGH+O+Vn9L4EN4GsKIUG29QvvcbPRfahOmTYYjIzwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AyU9pysZa5FxM5bEif2ni0OwUQmdao9QscH4hMMt+ZWZM4lIgtdPnS9OXCYVe4lm0
	 q//YDfVL4qBjWIeJNn/jZlg0zD8yT0UkIEAMAbD87yHmaE/185XWq7j4f1V7QOtqpV
	 Kw3wyyBL6PUijpi5T7ZyOXh5fkvPtXQehQuuTLJadJoSlvqU56jN783lGpOs0dn63n
	 7+XJ4Jm5DaRCGqNix95VcdUIPiM/AW6xm93426tp8YeBKNRAznkJasR+bMO/PXtUm0
	 RDjCHK+IIKV+eAGxEJlWEl7ebtNNd1e6IAU+C5p3DVCZwZ/vQCGXpkrNYDiS6dFItr
	 iybeKb3UU0iDA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c12629c937eso309203966b.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:02:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqjLv1GdE9UMAtoLJvxHKAgiXirX869OrM0Nw330Fn4y5cQ/JS49Z3O9Y37V3HV4AYQQGvdA2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5lVjr8AFGgpWrwJFCj0acBGy1WEYUxcXhlSo/HzQusJ6Dbvq
	mGmtst2472GNCJ+SU4sCiJjbsx9cmneocS3PQr2wW1YNWA3WpdHaO577xePSLL5i33A9GnHuHNk
	+qj2m8u8KMgJdpUnQWp5ZcjEfV1Hozc4=
X-Received: by 2002:a17:906:70c8:b0:c12:350b:7c6c with SMTP id
 a640c23a62f3a-c1297c30894mr52377366b.28.1782835370961; Tue, 30 Jun 2026
 09:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629112032.20423-1-jiahao.kernel@gmail.com>
 <20260629112032.20423-2-jiahao.kernel@gmail.com> <CAKEwX=MniM-4-aV17aH3UiDd_Xd2RH743fFZaxEnYX9qvnokeA@mail.gmail.com>
 <fe15eb9f-0b6c-dcaa-d0a7-5f08c3f92bfb@gmail.com>
In-Reply-To: <fe15eb9f-0b6c-dcaa-d0a7-5f08c3f92bfb@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 30 Jun 2026 09:02:39 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPBe9BPwP8NXz7pdH7T+8HLNsRAckL2Vfcnz0c23TH=iw@mail.gmail.com>
X-Gm-Features: AVVi8CcCxY3djerzT5lNld_VLCKVnmzQBQkQgjO1_FN5S20hdx2Xm_guHNHu7_I
Message-ID: <CAO9r8zPBe9BPwP8NXz7pdH7T+8HLNsRAckL2Vfcnz0c23TH=iw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270005-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,kvack.org,vger.kernel.org,lixiang.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:stable@vger.kernel.org,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C281B6E6460

> How about something like this? If there are no objections, I'll fold
> this into the next version.
>
>      mm/zswap: Fix global shrinker when memory cgroup is disabled
>
>      When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
>      Therefore, the global shrinker shrink_worker() always takes the !memcg
>      branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply
> gives up,
>      so it fails to write back anything.
>
>      Therefore, when memory cgroup is disabled, fall through with the !memcg
>      branch and shrink the root memcg directly.
>
>      With memcg disabled, shrink_memcg() only returns -ENOENT when the root
>      LRU is empty, which means the total pages are already below thr.
> The loop
>      then safely bails out via the zswap_total_pages() <= thr check. For any
>      other return value from shrink_memcg(), the loop is guaranteed to
> terminate,
>      either after MAX_RECLAIM_RETRIES failures or once the threshold is met.
>
>      Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
>      Cc: stable@vger.kernel.org
>      Reported-by: Yosry Ahmed <yosry@kernel.org>
>      Closes:
> https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
>      Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Feel free to add:

Acked-by: Yosry Ahmed <yosry@kernel.org>

A small nit below.

>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4b5149173b0e..9d4f19fc440e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1361,11 +1361,12 @@ static void shrink_worker(struct work_struct *w)
>                  } while (memcg && !mem_cgroup_tryget_online(memcg));
>                  spin_unlock(&zswap_shrink_lock);
>
> -               if (!memcg) {
> -                       /*
> -                        * Continue shrinking without incrementing
> failures if
> -                        * we found candidate memcgs in the last tree walk.
> -                        */
> +               /*
> +                * A NULL memcg ends a full hierarchy pass (except when
> memcg is
> +                * disabled, where it is always NULL: fall through to
> the root LRU).
> +                * Count a failure only if the pass found no candidates.

I think "last pass" is clearer than just "pass" here?

> +                */
> +               if (!memcg && !mem_cgroup_disabled()) {
>                          if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
>                                  break;
>
> Thanks,
> Hao

