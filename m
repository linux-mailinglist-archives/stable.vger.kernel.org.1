Return-Path: <stable+bounces-181777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05818BA470B
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5951C03B97
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA521255E;
	Fri, 26 Sep 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="f0a7ciUz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937820CCCA
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900883; cv=none; b=meIVro+hwDwZu2SDAP+q6ryoxMc6EDXubD8+jewgUi0SMDjOjAXawZutrBp+UuzIZVDorMvMkzDylrvMnwOGLcZeTKdTW8yVRqfM/gJ7KYQxkXepLx2ww8FlKOItBTzrJUJnPHIPPxr/hEaK045HjWfdoiev/JKLJIfbC640VDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900883; c=relaxed/simple;
	bh=R5l5O0ELEICcmvU1tgTwCQBnh1hmOYozkzq4CTQ6Yfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvOu0dwcXkPOEni1GaY6DKy+oJIQRIc+6Bk7aY5rtn4joskQSQJ06w30/Sb1mRJgRr87oW7JqP5sH12wJb41oARhSdgLTqPDNZM/n0Nb+T0rSX0aAzg4DG8NOHqYv8XSmhFaAKVpE2yhL/asn+uC7dHtsIe9fVXHo2mbhv/WcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=f0a7ciUz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b58445361e8so477484a12.0
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1758900881; x=1759505681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5l5O0ELEICcmvU1tgTwCQBnh1hmOYozkzq4CTQ6Yfs=;
        b=f0a7ciUzj8NEs8weKq8RdQY+Mc0kYnala68cRTgxxg2pnhg+I7UmwpdhXbKs3D5an3
         6YjY7QOo2I4tEb0DZjdEmIkF3DjiNyFk0hElQY0p0+7Q1TXAbPj2yFZYBGeXcVWenb/6
         AwqbYNvzuqkSlmBpfnkyfpdhmJmv69oSk5ClwrpQisW19rQUsMdcvBQhShyAtLFXzmu5
         fGNvkjsYyO2LeTr4LIeFQxohDBtofva22E1FDtx0yIPlq6bed/wF61GgMfLA9jpnUylS
         51DONm5eMaejlWJtKEsZNg/py/ZMM9DiCc/AJxmwQmRMkXbXBmq/i7WgNIldiSpOs4OG
         ToOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900881; x=1759505681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5l5O0ELEICcmvU1tgTwCQBnh1hmOYozkzq4CTQ6Yfs=;
        b=cDkSJpEaUtgeEgycaSWTD/TQDoOF/VVOQTUZC8aoeq3q8EDrM3P52XUm1LHeOgWOYK
         FnStWgY7x2xkENYdx6gDkk890bD3GbrPgoVek69kbkXNCXeKJV16dgH0t3KnQLu9GZKm
         8jW/0EavR0R5xc+yI1Ah+Vxb3YwbYiVlAuCXJItFNs4ccHmXc1drWxsWsJ9gevunnw7z
         fmqX9BB62e0PQyAf+JYE7R380ddCoZVnbcClXra09SWidc94XlV4hP+ywTJMiOa9T0m5
         JMIuKuLhvLQwHVUpkEMybP9Ew9HHFRqVeNDhvYH+jh9kmsanzMp4CWq+IsL7nzU2mbYd
         JBkg==
X-Forwarded-Encrypted: i=1; AJvYcCWf1n7n75B00bYY2qNARi2HBos2Fiduf1ezOAk4VkMMJ7Hsu5cl0qjI49jNlaubk4tva4+zO48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8mhOwoJEenXFzb7IYnEtSKmOR2ZWxG3VQVj+TbG3mXWMCfs9
	Skg6aZWtojlRFKX1QU4L/rKRAW+Mzk2p2sz6/bZoYuALPjajnyt6MW1IaJ4Io5vycKxrxPJLKQN
	qmEWeLZq7qBz8te+1T9QTlVVAKhM7NRDDiawh8NQ6Og==
X-Gm-Gg: ASbGnctIgxVxL+BFgsFVq1L7gB1VJk/JcU+RDgwysnbwtg2X8GaBCplALuTG3zshkB/
	VDsJ0F8U6AAp0xc0evndPlhWIZHT8cRqN1aadDn4L6h3RuIxCNszahAQwaxdq3iXz6SuTzPUkVh
	C+Fnu2hYFx9DfjtBBwYknZ/wqbE0yYkg1r7h1TSaJ1uj6itgjri88mrMlgNmw5sPVeOafEL5P80
	glp25zXL14z0RaMNMlHhFI=
X-Google-Smtp-Source: AGHT+IHDNvUuimJZXDq/t/yZdMNFh3ZPFKwDL6MOoLCVHco0ixuvDz5wBxD6/QCHMerYfoxERXUrD51hG45kRE6GhmI=
X-Received: by 2002:a17:903:ac7:b0:269:4752:e21f with SMTP id
 d9443c01a7336-27ed724f5dbmr67904095ad.22.1758900881024; Fri, 26 Sep 2025
 08:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925133310.1843863-1-matt@readmodwrite.com>
 <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com> <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>
In-Reply-To: <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 26 Sep 2025 16:34:28 +0100
X-Gm-Features: AS18NWCdv8WeFO6G9_Vl5YRKVZjX0sSmVcq-ADr201Rz5R9EbRLn4XWKT-GPLSc
Message-ID: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chris Arges <carges@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 3:43=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello John, Matt,
>
> On 9/26/2025 5:35 AM, John Stultz wrote:
> >
> > However, there are two spots where we might exit dequeue_entities()
> > early when cfs_rq_throttled(rq), so maybe that's what's catching us
> > here?
>
> That could very likely be it.

That tracks -- we're heavy users of cgroups and this particular issue
only appeared on our kubernetes nodes.

> Matt, if possible can you try the patch attached below to check if the
> bailout for throttled hierarchy is indeed the root cause. Thanks in
> advance.

I've been running our reproducer with this patch for the last few
hours without any issues, so the fix looks good to me.

Tested-by: Matt Fleming <mfleming@cloudflare.com>

