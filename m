Return-Path: <stable+bounces-212647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF6EBUFGemkp5AEAu9opvQ
	(envelope-from <stable+bounces-212647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:24:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0367A6CBC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425EF301BA75
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E858333434;
	Wed, 28 Jan 2026 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLRINZ9Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2B31ED62
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621041; cv=pass; b=JqsM+jVv7Ero7Pbpes1iqAbTOfXMAZu15wXBrsHn2ZoFu0EqLHNUXa6v3erl4/SpIFG2W2hGOcbGHyZ5e0jmLNMV0hbpsoEcIuSI1FXvqomX9nMyKIFXRZJzQ7D1elkWnVHXDxm0Uk9gIEz3dOlO3CR6HWHsJXcvaalwFUgEVrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621041; c=relaxed/simple;
	bh=kizkZuvdxw6uKJdz5CGeib2vOGGoPb1DUKZR/ygQBzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjtRoFeVKih9ROy5RJq4xPTBsx4AXhT4SjgY5TzoiK1k3Yt0TVow6ey1jo8zMJI/IHuaPEkbPtTDua0byVSZkv5/uabs5ZpWRc3xIRmtY+UuS0IHJlD9SD7hwL0TOn+p4rGNtRwVGW1rrTiUQB26zZaHyZhENp8xcAC48qSmdu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLRINZ9Z; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a871daa98fso146135ad.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 09:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769621039; cv=none;
        d=google.com; s=arc-20240605;
        b=AbUiX7JEBfQgNEsBAOO3tICKL8lXxqZOgOAdwo0mPAOQe1dSgzwvKPLGzhAW92N2/r
         l0GTadB3qUc4tVDwVdvwEX9faqBtCSIc6/63frE+2r8DDfjpC+d1cRMrmu3bnPCHsSsV
         eXUV25+q40gjgMrxFwb7h5PinNCIY9Gpi/Rd39hsvpflTc0qck/9kM+GSj+KANkTDQ3x
         WbqbJ4BYbr2zxRul2Kenco8bU3S6G9iso8rj+hJNzuGGwEi3U3PKfSG7MVNdh4RWfrw3
         6KpBcWgbNtNPCUXJx8glyVd81DjjwRr1kWAAeNjW6U2PNWESCPb/UecvIPEo6Fw2TM//
         gulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        fh=WYqoKWVviQEGFY5A5/tO67blDFyTMkrwboot/AezZn8=;
        b=JnBR9qiMVwydOnz9kx6b8Z0+iaXtYbOo4xkDtG0UfGd9jo/2dKBuCf6cPgzfZS4q9k
         N0uEN2Bg3cGyFI2/KO5z8OvzHVXcfhmXqHYAe+psYFJtO6PhIZz9XzjzRQszopZDdx8H
         MB/BQo8ZMQ/bete3RUY4duVUhehjcHdqeHSDJGvXgoFxc0FYS39ylZ7p9PtGG9Iatb3G
         rlao6xF2TEsStBTfSGMpTmUJZg7H7hYmJUH6tV38mV/AhAp0DrBA9+TQ0cTHUIvlvyIG
         xcWeZtWZPqXchK7dqZfa3JTzNF64AhKgyyXiDdCgUzjcruRhiiwvg1/ppDyW8Idx7Yh5
         41iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769621039; x=1770225839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        b=RLRINZ9Z2mdC15RRQfK11I3dIYlKrJQt++jxEjPb5IUjwEYbqGwXI9TdsrC7Os1JLi
         zee3W3QMflyxCOu4sX4hcppUhInbgwXpQRjqbQy/QbsBTKJ1+oEAA6IldwpwN6qXZNfM
         aqPsoyMOTzd2LCGriFaZukmwgRRBLOlLWbtK5Uk4aWuxaipK9C7HTTGM1O6jLEcVzu2P
         a5UsxiFeCNBSVvYP5GkFcYIGQIFuGBKMsF+i4JBi/abCd9ZCRYmTODfFHUZ3Cq9SSMk+
         Y976E+Zzcp74NphQd/ssDhWrhz/IRAWOR78SwW0a7A6fvm+2jX8gFInJ+0rmCPkv5q3+
         RRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621039; x=1770225839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        b=EiuV/FEyJ9ETqKYFxtYeFsRbyLqObzWb7fRWRljso8/6NO6697fsYxBHUxwfPafXEl
         PzFgz5x0tkYcavt3kfzG25sT0MiYtHefj2t7EDXxBtN8MaL60/jW80ejoPZxjMDqBftQ
         CPVEHLmBIXJhbBhhzJ5eu+f7EfPHmZvDJVz+Us5PAmVkX520pkcUC2sSPSlSm0bfHWAi
         +dPOqj6OgIWKO2DAl4cW3C2OY/otbqfL0hbI7xeyloT9ZJWcF3zyzq7PwvlexD3FCOGv
         1YVVu8p+RioiLDUHNjv4scmm2AP5746OAVfCkDErM+vJHVWqsiOjWFiFHEkmG8905f/U
         tsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3eiarEBgI69hwXGOGU1AiM1W8Uf3vJSoGY33fA6buP+WcA/Lbe4x0aO1dYiADH40FeDm8Vsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwM4v6szI1pQnNq45OG3Gic7oRhvVxPBzbouTkv10UE6tfnzL
	mljXteIFCzi8Y+t5iaDlmBWk6LhOOXenm+vsFnhBb+ftfB4h0oVziIWeKnHlQ8NifjqHXCzrmNX
	x3kJ1157BqjqUZgE6eIL0EXYozEa3SVA=
X-Gm-Gg: AZuq6aLIpI5KOvD8e1EYPlG8fv29jxQlYuE9M8/zjg7oWYeJ92sfsOHGp9elu9q0Y+Y
	FGfqHn4WVIfObu7CCBSZc6ugol+63moiLc36WxF67YCi7Hz8lGadTHmpJTVkbdJFSO4Gm9lGQml
	o37mkpu30ktyuNRZKrfb+jGrlQPmDtM38m7ZeLXN/1hjX3VE1zn1zjZq7H1vRxaH3zd6RtxIg1Y
	RYJpFVUkke8EjHMSUWGVfBP7AZolQKgQmeALrUHvb10XNkX80aB1EEXNTFi3k3RzZRKuHfBwGLU
	XHwkjtvprcs=
X-Received: by 2002:a17:902:e5c9:b0:2a0:d6d5:b342 with SMTP id
 d9443c01a7336-2a870dcbe7amr57082335ad.37.1769621038802; Wed, 28 Jan 2026
 09:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org> <aXoUOEhDfncEkC-f@redhat.com>
In-Reply-To: <aXoUOEhDfncEkC-f@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 09:23:45 -0800
X-Gm-Features: AZwV_Qj6rb3WoP_Y9fiHuFQxMtZyQOzI2dFswDQeqWIoSEtuJcdiEz7owWd2EyE
Message-ID: <CAEf4BzYJJiUdQTjDgr_uVSQ+uBhYWKki0vjS5VffTzbST1uS2g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: fix incorrect lockdep condition in filter_chain()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212647-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C0367A6CBC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/28, Breno Leitao wrote:
> >
> > The list_for_each_entry_rcu() in filter_chain() uses
> > rcu_read_lock_trace_held() as the lockdep condition, but the function
> > holds consumer_rwsem, not the RCU trace lock.
> >
> > This gives me the following output when running with some locking debug
> > option enabled:
> >
> >   kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section=
!!
> >     filter_chain
> >     register_for_each_vma
> >     uprobe_unregister_nosync
> >     __probe_event_disable
> >
> > Remove the incorrect lockdep condition since the rwsem provides
> > sufficient protection for the list traversal.
>
> I hope Andrii will recheck, but looks obviously correct to me.

yeah, I did, and it also looks obviously correct to me, I didn't need
to use rcu flavor there in the first place, I think.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> > Fixes: 87195a1ee332a ("uprobes: switch to RCU Tasks Trace flavor for be=
tter performance")
>
> This commit just change the __list_check_rcu() condition...
>
> Perhaps
> Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly =
under SRCU protection")
>

yep, this one is the earliest change adding unnecessary rcu flavor of
list_for_each_entry


> makes more sense?
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>

