Return-Path: <stable+bounces-200860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB86ACB7FE2
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 06:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE04305AE62
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE330E0E5;
	Fri, 12 Dec 2025 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="fs4ajX5K"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE92D0C84
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519068; cv=none; b=rD50quEK+3OQaUm9a4UrugRTRlKeDMbr/SH36M6Npp5paTgqOQLW4YJl4DbvWGmDbyxvG7V7ZHNchOoxTrE59BIPvPEqyk9A39JJ0gB67eK1VsWHSwdEOdOidIDkG4Vu/X5TKj4kGPmkL0CtW3tSNGcalWJKgmze2Q6siW8NcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519068; c=relaxed/simple;
	bh=fgsSX3Xvqg0pVTixbgqmuCjN8XlgMkq8rvUKPfF/H5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JmGJ8YMTQ9GsplOS1SzLi5+tDDYjOPwLRGo/T6rizoZdQhtZiz3fOEnSFCEarbemHvi4nNogvw7DFye6V6wmekE1HQew+zhVs8cDpBxvN0U2EB65Xj5GJu6+RK3wSB2WUlW/8WbbtMZQk4SpjYiS3wWvmRGYEHDA5q6Em/1WfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=fs4ajX5K; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso71270685a.0
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765519065; x=1766123865; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+obT2GMuFzYEIOMsvhKf6eth8yBNwnM9yUNGgmvY90g=;
        b=fs4ajX5KzWGM+RerUpncj3pWCJpEVtQEOYnJMRlaaHtS3T5suJInmPan2+FirVW2+a
         eXEkj/7z00VRlZh9VODVmyprU8cSMxnaI09Nub+dO1Hjg7dgkkMZExIy1eU8z4B+j0TA
         ebwnwkb4b03k3mDfwzA/ofTwfbEGN83XDOJ5PpahuXWoAKH4sh1Dg3YAClKH1YlAQk3L
         E6SCvV1mlISyRx95GIqUm468xfOHFHHKCjLjlSy2g79JBq66Bq5YqL/g4HxVJU2JGDGE
         4AuOAwwBa8IKSCEWGsLrG/k1doKv7e4jipWmkJjJKcsf2cxijtgAO9Icn61/C9iUG/BY
         sUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765519065; x=1766123865;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+obT2GMuFzYEIOMsvhKf6eth8yBNwnM9yUNGgmvY90g=;
        b=H2iOJGRTZstDtC7XYpnfSK48TfxjUR1Bt73smcOheJjEgZY8Ps9qv4xSDKvNt5X0D1
         IYbs0TPujpPhD1Qm/1gPuBl2l9A9NtgjNVkU5xk5IevuiyZ0isAC2HGqf1P/nXxaLsS0
         06IbySYSSTRFIDJoTu1pg0O9nqQyixtizCKbVJev8fEEWhPDMRKirIcMKUJvvZ+nSu23
         9DC5iOLtWb1aCF22duivbA1lCriKy55lg9tk1KudPksqX2vW/TReHu+cyyz7fLLhpjsw
         InPKoS8ZRrkBkvsL6j/+1xbZ9mAUl4qMAFVbJy9R/B+DRYp8BB+OX5JCfgq3zvSzq9u5
         TjUg==
X-Forwarded-Encrypted: i=1; AJvYcCUlWR0DHb5jwCH7damRhTBMnYpfH/VCxMEr2GB0jJUJxUjq5hc0QO+xncpKHqMsXupfHXyDA0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdFJL/J5JyfIMDWjG1ygucpr+xd84AfXPnRKLXxwrQC2WVeGy
	Q3ygaSsbY567CMJoJzLT5lVzd/MaE1cxKOO2u2lBuSw2+q7juEOxx8r7KmjjdmuDHrg=
X-Gm-Gg: AY/fxX6LFYlFEurFmD9xF3lbq4mmi/33fsTBezexGYRngevyNQhZI4mFDe6u86wjMH8
	GpUVFIAZ7UeD9VW9mAgFJx+vxGdfPHiSlc4sThBHa3MG8s3rNIYlspZ00529PqL7a0NihL52AX2
	7WMGOjtC8iMbQymPEKz8Uw0bJ87R1FRYFa4+gbmprIuiX+YcddBT3WuoRkCetswciaDp8tVaRHV
	vcJpqWCBJ595SXPcPnlfu4ENm1kNfqRVzdE3qgPCKkg/hhsuXicZRRbiFwiE3QuowYoQZ5AXZT9
	Ij6z3jIG1CjRSFnJTbpIooQn7mfA1KDVoDsjPfB+nFhs/O1DOTPdgN6oXWSD3Zs6ByNi1Q2FLI7
	zFApOhTveFyhjUTSDVpbYIzmlj9V+kZH8V2oLUKugJA17Ux0rrf5cEJLLtGKgtJAHNrvC4IU1oa
	Fj/KHew+Y80iK5skgl8UAAlw==
X-Google-Smtp-Source: AGHT+IFJyCJZmyqnZwBk6jh7An7wM8i4gimml50s/3knWSXiY1rTb4VzoUtzWii88NakKgFz7dRRCQ==
X-Received: by 2002:a05:620a:2a01:b0:8b2:76c6:a7cb with SMTP id af79cd13be357-8bad3fb038dmr613360885a.16.1765519064974;
        Thu, 11 Dec 2025 21:57:44 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d4edbasm381614985a.51.2025.12.11.21.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 21:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 00:57:42 -0500
Message-Id: <DEW09WJ1U1FU.IQ9B68XD9VAS@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in
 move_local_task_to_local_dsq()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "David Vernet" <void@manifault.com>
X-Mailer: aerc 0.20.1
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251212014504.3431169-1-tj@kernel.org>
 <20251212014504.3431169-3-tj@kernel.org>
In-Reply-To: <20251212014504.3431169-3-tj@kernel.org>

On Thu Dec 11, 2025 at 8:45 PM EST, Tejun Heo wrote:
> move_local_task_to_local_dsq() is used when moving a task from a non-loca=
l
> DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
> without going through dispatch_enqueue() and was missing the post-enqueue
> handling that triggers preemption when SCX_ENQ_PREEMPT is set or the idle
> task is running.
>
> The function is used by move_task_between_dsqs() which backs
> scx_bpf_dsq_move() and may be called while the CPU is busy.
>
> Add local_dsq_post_enq() call to move_local_task_to_local_dsq(). As the
> dispatch path doesn't need post-enqueue handling, add SCX_RQ_IN_BALANCE
> early exit to keep consume_dispatch_q() behavior unchanged and avoid
> triggering unnecessary resched when scx_bpf_dsq_move() is used from the
> dispatch path.
>
> Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_=
dsq()")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c78efa99406f..695503a2f7d1 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -988,6 +988,14 @@ static void local_dsq_post_enq(struct scx_dispatch_q=
 *dsq, struct task_struct *p
>  	struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
>  	bool preempt =3D false;
> =20
> +	/*
> +	 * If @rq is in balance, the CPU is already vacant and looking for the
> +	 * next task to run. No need to preempt or trigger resched after moving
> +	 * @p into its local DSQ.
> +	 */
> +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> +		return;
> +
>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
>  	    rq->curr->sched_class =3D=3D &ext_sched_class) {
>  		rq->curr->scx.slice =3D 0;
> @@ -1636,6 +1644,8 @@ static void move_local_task_to_local_dsq(struct tas=
k_struct *p, u64 enq_flags,
> =20
>  	dsq_mod_nr(dst_dsq, 1);
>  	p->scx.dsq =3D dst_dsq;
> +
> +	local_dsq_post_enq(dst_dsq, p, enq_flags);
>  }
> =20
>  /**


