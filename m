Return-Path: <stable+bounces-181754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D5DBA2062
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 02:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582A41BC432A
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 00:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A134BA4B;
	Fri, 26 Sep 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqTe/4va"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18710E0
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845224; cv=none; b=f2csh53LqzfYHPBRTKCOfPWPPc1p92CPRIt/GO/5mxIP+iNfEzceoT9bQUIEIXM3auaugZvG7K+Nl0Pjo9tHzrv0ZPTX4V7rtfjEmEx35zPy8GwhPuyusYh+DIQUByT05jAP/cVxZPl9dHOnhWzHnKqD4zS4/iMObSA0H1vjwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845224; c=relaxed/simple;
	bh=+qqySPIS+RD9Ch2d8C6jpEJA6bex3TqAu323+T9ewig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL73lt9Jbr01RDe748rHg3MF+uYWKhAzJEsabPtrOXQG2S6KGdei1Rfa0ALoxH+WhfZr6uKUNoFPQptHQkiOp9/t301gYq6ia+kmrDUxipoQs1CP/DxoAz4XHACtCT2yk+fkerAlVVRx7/orZQbd/nR7DOLNUBO8PQoY7lKZS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqTe/4va; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so12143561fa.2
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758845221; x=1759450021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2nBwEk2eAXDcNki56ZRHE7qnCAvvWI6uqhPHOUuTEo=;
        b=GqTe/4vaIClwvyzoXk7STbvcVE9442GSI4dHdbcVugtrqpKiZagw4Xg8Yso9IwwzOU
         FyWq5iM2my5VD0sjRjBRK6gNQ/tPC0gRoqBPFmKJlOM6F84A91F0E7RNg1d+sB9y5fp2
         U4IUA5mMkf1rksyUepcpjiueP1eD+rwxncxAsKWmLuINh7GQFxBGjQliXdRXnjJImU9V
         26Hl6JzDAzwJSVvH1MHfBwZc26ZtL+jZCe41P29QHEmuW6JgsCe3NQbwApQfB4sQxVaC
         Sr8+WhrCtVn109PK2n2Tw5PkuqUpvLzyXPFi6ZeO0mKdJcwb2642WKoPOlNZbh8zz7z8
         2sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845221; x=1759450021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2nBwEk2eAXDcNki56ZRHE7qnCAvvWI6uqhPHOUuTEo=;
        b=JaKaLZG39WqzLg/VTOQJkCt+jHRaDRs/t72EwnCtP4Ahj50qRvFuWgNUJsmd3qTdvq
         ANr4vESUqgKKNvFnKKtd9eoiF18MwJSDrIhwWuT0eBNaYlBoS0KuMb3eabwnmp2Hddg1
         LjJDKwoqopA6XYBQyZ6jmbQED14KstZU7BVYt8Si1WhBb9hLQgLQ+vSNUp5Chuu9QzeU
         2hYQRky4/lwq/hB2R5+s6ME9rKg6Zj5xhtGsWaVBvwRGhOvJc2RDXiZnCADdvGltsvsE
         XuETeEeAW6zAlYsUtMOMG6U3aMRoItUeOCxK133w0pEqc3LD0qLi7P67IbqlmStDjK8G
         Srfg==
X-Forwarded-Encrypted: i=1; AJvYcCVimeBuNbyZzftFvOn1kZnmQdS6MU7C5wDCb6VAoh/cl3Sfi799HBo5YssbxP6QwVKeRgpvqfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpKaFq08ntMOUCld3ZszXspGf8z2Q+fUV43Yy7y0PM0oevF/z
	1LVRsmY/MlJoX1/oQk4Vkxn5KoBZl8tjv0CMOotHnQs/YfPE3RZ6sNev0VY+EtVH8GWYBy1PqXd
	HOSwSNc/a5SNKEHLEV5cNTRg7Izhx+i/YBiGSa3Q=
X-Gm-Gg: ASbGnctN4tS+SJG4xMcHjZF6JD7G1OQq50b0VQgZQxh8GuaQI+7v+6439sxWpPb358N
	+dJxkxXhl98HYBMbqB3w0caUYhFbZCb5cm7Qj0XQpPzprF0fyaAHGaGj9Ubc0VLH7vGgsxknH8P
	9rFUWc5tmdGMdhtlxouMtDbUzwtMVlT0dvFrjvUIgmnJMhTQSSagFitBzJDYI/sjb1iwXUqyCAq
	nV37+b2L2f0yJT1I0FE4Mo+s/XjOXLUDfWsWIGwSJs=
X-Google-Smtp-Source: AGHT+IEf1w7t7CWNT1vdPjMJPoB7Vai126p2EQGlhIzx5l+95YccPlzQLpnr3phwJBnv2/8dT6rFhSkXPgxvEBAE0g0=
X-Received: by 2002:a2e:9a12:0:b0:36b:9ecc:cb36 with SMTP id
 38308e7fff4ca-36f7f247ab7mr16169721fa.23.1758845220596; Thu, 25 Sep 2025
 17:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925133310.1843863-1-matt@readmodwrite.com> <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
In-Reply-To: <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 25 Sep 2025 17:06:49 -0700
X-Gm-Features: AS18NWDIx7wG2OEqajQZdx5uLcTNiTOxfc1iDY-gkBOx2dIyBQjYB9pypBFcbEQ
Message-ID: <CANDhNCqLqy8p+o9tPb87BWQpbFeVJ_xGUfRoEiB7_mEv-xKD1g@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
To: Matt Fleming <matt@readmodwrite.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chris Arges <carges@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:05=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> It's confusing as this patch uses the similar logic as logic
> pick_next_entity() uses when a sched_delayed task is picked to run, as
> well as elsewhere in __sched_setscheduler() and in sched_ext, so I'd
> fret that similar

Didn't finish my sentence there.  "...similar problems as the one you
are seeing could still occur."


thanks
-john

