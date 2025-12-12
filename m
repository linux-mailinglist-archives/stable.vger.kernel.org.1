Return-Path: <stable+bounces-200859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C328DCB7F78
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 06:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C987B300977B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1F16F288;
	Fri, 12 Dec 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VGnpFYKe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FA1EE7C6
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765518628; cv=none; b=ummseLLW/7a/Go7atFVm9AJs1ClNIhW3S+8tNXXk/vp9H3MZYY9cYQW7Z+eqc8RwgaZupgUQdhXlpFEsNjb7s1hIKwyy20tbohwx9Ka9YjMS3SY7wN51BJU0hhlhxsfmmEb6iXfJDmHRLLg2+GwOhIpOhZZPt9TZQ8FkilIuYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765518628; c=relaxed/simple;
	bh=tuRbDtchayVzq2x0lXes5ITy1CXf4+nfqMwbTJ2dr88=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RG0IwDJbO+n+etKLmPJDfjy7Cnltw8DVj4bq+5GBWSHIytCyu0oIiOqxBpRh01GON73NKdV84p7DctQ1GrCwurRW+vWkF3uFNTU4pTDPS4QpZ5BUo/y/OEEfEUqS9c6UsEDvS/NDS4OToJ/wVpS5cog9njzY0I5WrHuVLEic9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VGnpFYKe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b28f983333so90104785a.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 21:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765518625; x=1766123425; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5U3FZF9RvjF/Luec6BBDXZiC46B4Lp/JwY7xrlV9Tw=;
        b=VGnpFYKehoEgFvGRYKTPSJPSWIPFHQsv2PskmPkJ9gv435vauQ8eF+EDqtYvHdGqlz
         4dwr/o0Pz89jgezAwyv5AyOddVleNjzciR/I2iawlrxpyswPmomaPgleBCoQfTlet0Sp
         OGZOJcLUPiIDFkadg2gqgSWdbkj65+cUSqO5a1sf5kEc0bYCKUeCS7FQgVtAxquvol3N
         CkVaVU+1SBhVBij9Pleb35zIja5mQ5u7gIgdqXZrcAvBAUKsCbK6SAlInBRPU2AjAZCO
         OViB94qnQcTQTdt2HCs7arDHzqH3rlypZV4kWFmZb8rPMBmY0YomxkEmXhvuxlZLeBCU
         +IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765518625; x=1766123425;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5U3FZF9RvjF/Luec6BBDXZiC46B4Lp/JwY7xrlV9Tw=;
        b=xRbj2lwO3lRbd5MfVPSV6TrbnissNYpSAPTbhlJ3o3rO2g5rtUe9zIOmPrSyf9xGxr
         xyvKBoM8ZUoM2MiryBycUuP3yhL3II6BQilWhp2tPmqUxKcjW8R3xJCemdztEw0wEf9b
         2qCFXMRWJ6+T/CwUyOuIlXdt1TbRINtfd4bs5JL3CWQU9LbKvR+iZGnIWREnp9UBIPR7
         /kC8zibDtB8S3EgEMZunwX4uogpkhdMjYZx0bn4puXEpi5qaXaBP4/USY0e8k8EpCl4A
         gSyyzJAsBYM2eVDjcC4yXS2elKIEPQ/a39KQamU0gLxIdYxiHEgzVuUGEtsdi09pAi+5
         McNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt8JfVQJtVCiqPVuJeVSCec23SCrapXO2mjqsBnfrFrtMdaM2S+BdfbrjD2ToARcN4bQDDjrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3+MOY3MYy4IK8r2RXHqM4dx2wsNYaFa9GMIaGyKZ5lNnOx34
	4Jar4jucQuikCe1OFR4WP1U0VJIa5lAA/GUcLCrKxLCfHpYYJvibwG5CrP4bsm8FXbo=
X-Gm-Gg: AY/fxX5otIGWhcNlIvIFyYf/tMUwnJnXZ3E7cWXhZQFt+AZWkYy4lfwIdzoxh2X72AZ
	gbEzGTqZg41NkueHU6UZF9O1/VM993PiDaTbAbYARpWpYuo/GK46t2luWdgMe7nbzKZC4sudh4N
	WxKPya5q8qGodAng0ItRRkP3RIImJDl5nzecIHYaCMCi0KYVP1aF2FiYx5CWI4HMBQrmyjS2TOb
	tq0ipitStJ9EKB2zXi7hV7fhkqEtdRhJJj2cx2apIx5I9+AZUgHJL+y+MpJxE/o7QosPDvmMuAY
	rQ4JnOIvCO/ZO+xJfzTp7yHMXeMFOBz8cdd8W0D4xnHrvkQfxV4Iu9Y8IE1y4nPbrZZVFPOgdxl
	zOVJ3zump0UdhzGTW9U5zSp332WGCvZUcWC4QiViIea33WnT93xpSJODpnAJ+C61aBirfB4ngKN
	9GsYGqndBpVaU0DADoPUQhpA==
X-Google-Smtp-Source: AGHT+IHqDDaEbhWB1AD1vW7kv3sMO5h7V98gD88UklizPvHXo++/ioxnBxUJrL9YdjJWKJQSrWK6AQ==
X-Received: by 2002:a05:620a:45a6:b0:8b2:767c:31cb with SMTP id af79cd13be357-8bb3a397913mr137841085a.87.1765518625010;
        Thu, 11 Dec 2025 21:50:25 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm406603585a.26.2025.12.11.21.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 21:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 00:50:22 -0500
Message-Id: <DEW04ADT6JB8.1FATMFM1JFKA5@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "David Vernet" <void@manifault.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Factor out local_dsq_post_enq() from
 dispatch_enqueue()
X-Mailer: aerc 0.20.1
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251212014504.3431169-1-tj@kernel.org>
 <20251212014504.3431169-2-tj@kernel.org>
In-Reply-To: <20251212014504.3431169-2-tj@kernel.org>

On Thu Dec 11, 2025 at 8:45 PM EST, Tejun Heo wrote:
> Factor out local_dsq_post_enq() which performs post-enqueue handling for
> local DSQs - triggering resched_curr() if SCX_ENQ_PREEMPT is specified or=
 if
> the current CPU is idle. No functional change.
>
> This will be used by the next patch to fix move_local_task_to_local_dsq()=
.
>
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c4465ccefea4..c78efa99406f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -982,6 +982,22 @@ static void refill_task_slice_dfl(struct scx_sched *=
sch, struct task_struct *p)
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
> =20
> +static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_s=
truct *p,
> +			       u64 enq_flags)
> +{
> +	struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
> +	bool preempt =3D false;
> +
> +	if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
> +	    rq->curr->sched_class =3D=3D &ext_sched_class) {
> +		rq->curr->scx.slice =3D 0;
> +		preempt =3D true;
> +	}
> +
> +	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_clas=
s))
> +		resched_curr(rq);
> +}
> +
>  static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_=
q *dsq,
>  			     struct task_struct *p, u64 enq_flags)
>  {
> @@ -1093,22 +1109,10 @@ static void dispatch_enqueue(struct scx_sched *sc=
h, struct scx_dispatch_q *dsq,
>  	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
>  		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> =20
> -	if (is_local) {
> -		struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
> -		bool preempt =3D false;
> -
> -		if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
> -		    rq->curr->sched_class =3D=3D &ext_sched_class) {
> -			rq->curr->scx.slice =3D 0;
> -			preempt =3D true;
> -		}
> -
> -		if (preempt || sched_class_above(&ext_sched_class,
> -						 rq->curr->sched_class))
> -			resched_curr(rq);
> -	} else {
> +	if (is_local)
> +		local_dsq_post_enq(dsq, p, enq_flags);
> +	else
>  		raw_spin_unlock(&dsq->lock);
> -	}
>  }
> =20
>  static void task_unlink_from_dsq(struct task_struct *p,


