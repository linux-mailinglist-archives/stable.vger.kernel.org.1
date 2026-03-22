Return-Path: <stable+bounces-227855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MurXNXlCwGmHFQQAu9opvQ
	(envelope-from <stable+bounces-227855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 20:26:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B22EA7C4
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 20:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09F630078F4
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FB36AB5E;
	Sun, 22 Mar 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbIqkTh7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875C1A2C0B
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207606; cv=pass; b=QHkox2xLnHCPIZeLDFCfFLA3Qlbv3yqg9bOSASOShQzYcM/Asatl/0jkxP3KjxUkWSYJG7QaOqmN6xd5LFHkh6+nQMjsh2UsHFa8qGWCyEDCF23J8TCVG/Riy2s+7yehDnNYqiKU49ivtBYOU94ac5lnI074jbSHArX7YX+1kS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207606; c=relaxed/simple;
	bh=tkIqX90KMvJAYj3he47Jtl9R0pKV+NaauyYiOTpKerk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDlNJaeTyCFE3J5Gk+vwcaWECjQoantzJ0C18057VPNoZVH1LpRE/t1PaU7IDiQZ7iEYJZbjwZQAc6jmFHw47KsAFNtTrZsH6OKIqPPMC19nZAWZbWcdeTsum9WUXvyIpP0BEM2dPiBm4WtR5eXviKg3rrZpHc80Yt0uFHHn1n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbIqkTh7; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4152698e745so745968fac.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 12:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774207604; cv=none;
        d=google.com; s=arc-20240605;
        b=AWBOGfGrgJYHbrcdpGsVr4xn2+hq2K/DcHAlZKzqqG0JqcShGtwp5xlfygJpAI+l4N
         0be0GqiEYIQyiMQ/6RQ4kNe5s0MvEDvlcvOfsJAX/JmeUwa1j0ER1WWAR402z/1wgU5o
         RYdvj1L8wUoN8GQmlq3uUK7XkMc3XTC7AhGbbv9Jv5/cU/FHBcle93l8TKVB20NSji0g
         naOMupub59jRK03wXtsXjjogHAQsh8B0kYn8DW5rYKHwCtAmK6XHi5Ulv39iUc9m7abU
         RrwPfySnoFQlsdUT2g9ggWPm4zjpEefq/EDhIa7bcMss7tuBz/fP92e9z5/eF0wQoSbX
         R/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Bgdggyq0/oyLyjb2FYH8nUxRMH811f0m3byMmRZLmjk=;
        fh=FzudBUNZD2R4zkhX446GDiMKc7AEY36xx2/Kuz1PAis=;
        b=LbUbywnSKmwk7fKcCZbDfvhA1H/+ZK3Kb9jFDLAZ2YN0zBZHCgfrXukaeHoWLePaRM
         3SOI2QI3dZj9aVQXsTyATYVfzW6lljOB6TFfy+cz+a49mmKwVjyZDl17NcyNrxaVUnNe
         MOPkCQiCV9tJPs84OGSii6fvPMVU8W43Xu04UzqOX/wxmZihzTH0990Jn7oUS0TNqJX4
         E5bKRguwxJwv2TP1Xdl1DqETrhip5kaOJkfXHf70BdY3XTE3PPK1GM8eqHqWyWQpJ63l
         O7yXaWVWllstu6hUe8IP+TOg1d9GFN3CFL/hsmaTrHHQQYeSLlA4E83BsvZZu6gJfWBo
         FiVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774207604; x=1774812404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgdggyq0/oyLyjb2FYH8nUxRMH811f0m3byMmRZLmjk=;
        b=NbIqkTh7xWQwgjRIVNMQDT6435lEINoRMV8U1PlLaY1Wdmayti4dYNBUO/IB0TExxk
         NDhf/aC/3XfdfVHjrL30EHqZV5CaV7QvvVca4lLKl6+1eqO0ct5Gje1ai9WzPhlG5jl6
         1ULg83ClUea5KwhKQenBpXsE30RWSNYC2lj27nnz/4QiT0q6J+urP/dpKk3qbeawnZjP
         ehYIw2hB9mF9bg+J0V9c6OBo6vCOvChhYEDvQHAz0oAcw/mXpjJDa3s+Onfxkh849n5a
         3l+rWwaEqyfbVgMW176aasCvg55mbCVTOWhkR593yU4q/gUkRk+lRfiMsW+Wfj+tUSQU
         Kgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774207604; x=1774812404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgdggyq0/oyLyjb2FYH8nUxRMH811f0m3byMmRZLmjk=;
        b=kReADjDrZ8EQ8WoNtPJ7X0KlvrrJMwQnEfyqggR6xBdX80pAEXe3DSuNTP5ZgV1Bvb
         DFPAmL+oeV9IrKz6e13vloCHYhkyMTTvSDMEze9tKncdsNKjrxx+0H88tqc8N7GCMCW9
         CyqmJxxbqcR7U3ytHygFmVjG/ATVWV8NX3U1fj3Q4VZIIoq+usQ2yXKKfQgjHN40CGBY
         U9cLXP9M70y73qCnjC+kkSd6l8a5QR8BvBtf4T2wc9J/3bbfa9Xp59uWrP1CWVwXU7bA
         UwxSXO1VfVvoB2cEdMoZhzzfhKRdo0bbMsvogRMwgKusnvNlm/dw2X/sN01T7rjbMLJP
         neoA==
X-Forwarded-Encrypted: i=1; AJvYcCX/1b/b9adV8CMNfOdHtGu1L1evXiSzCIXm0HKW4GWxqEbDbQHUm/gABB+t6WR2zW0aM5zWujA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kt8gF36d6PscLJyggaEbt9tz288pbv/Gn5oHjtMmiJMth1n2
	A2PJ2124BLaYsZumaKuP4FF4TortkQ+lm00J64OTFr8N2FqN5iyvsst8WfdlR68fxPSmz4QDEdg
	PSeLvvhj5/NpRiK/GpBRNOjIRzcoEGSc=
X-Gm-Gg: ATEYQzwnfqAM/ZOeWfbMZMZ5xLlrNnJXZOlfUC//sku8FrC9UuefBRFgqPrb0huczL+
	Qy/qlS/r83rbT0DjrFYRTvfEiUH2o1paEf/CQME8Vh7Ph5isOgP1iiGQZsUsEm93Khg3YQll9LJ
	26ESepjF0aIaXAb6fKtuuo6dBhi/eutMH9jMyOwR9WW5PrmL/VBP84lnDqBlMvSeQRgBVwlRc+T
	Z51haVYHRDM8u5/nZKyC2Mg9ITpS45Pugv/lE3rSHrtwQmuccVAAu7YI76kSyYafyotdUzuLMZj
	Fvak9qVT+mQ899NJCkFuf75+RhjvblHSLhYvcg==
X-Received: by 2002:a05:6870:8988:b0:40e:b6b2:b97a with SMTP id
 586e51a60fabf-41c112c7312mr5973280fac.51.1774207604139; Sun, 22 Mar 2026
 12:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322080142.5834-1-devnexen@gmail.com> <20260322164943.37460-1-devnexen@gmail.com>
 <20260322115452.29f2ce981610faf2d7b8df32@linux-foundation.org>
In-Reply-To: <20260322115452.29f2ce981610faf2d7b8df32@linux-foundation.org>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 22 Mar 2026 19:26:33 +0000
X-Gm-Features: AaiRm52rCpQ5CDXjSzyYVhuRvJs0IHy18nzsUG2phl57c5Mq-e1Jp1XNV3VRxnA
Message-ID: <CA+XhMqx+5WSxpvHdjC4iwhVTq5ETYfn56dHMT6TbBY-7H1CtoA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: fix obj_cgroup leak in mem_cgroup_css_online()
 error path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227855-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 2E5B22EA7C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both good points. I'll address them in a v3:

  - Drop the redundant pn NULL check in the free_objcg error path.
  - Add a NULL check for pn in __mem_cgroup_free() to guard against
    partial alloc_mem_cgroup_per_node_info() failure.

On Sun, 22 Mar 2026 at 18:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 22 Mar 2026 16:49:43 +0000 David Carlier <devnexen@gmail.com> wrote:
>
> > When obj_cgroup_alloc() fails partway through the NUMA node loop in
> > mem_cgroup_css_online(), the free_objcg error path drops the extra
> > reference held by pn->orig_objcg but never kills the initial percpu_ref
> > from obj_cgroup_alloc() stored in pn->objcg.
> >
> > Since css_offline is never called when css_online fails,
> > memcg_reparent_objcgs() never runs, so the percpu_ref_kill() that
> > normally drops this initial reference never executes. The obj_cgroup and
> > its per-cpu ref allocations are leaked.
> >
> > Clear pn->objcg via rcu_replace_pointer() and add the missing
> > percpu_ref_kill() in the error path, matching the normal teardown
> > sequence in memcg_reparent_objcgs().
> >
> > Fixes: 098fad3e1621 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
>
> Thanks.  Sashiko review of this patch claims to have found another bug
> in 098fad3e1621:
>
>         https://sashiko.dev/#/patchset/20260322164943.37460-1-devnexen@gmail.com
>
> > Cc: stable@vger.kernel.org
>

