Return-Path: <stable+bounces-94041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6579D2963
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D78D1F22917
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C81D12EC;
	Tue, 19 Nov 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvLaduA/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1531D0426
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029269; cv=none; b=ZH+SQt3kOOgG3p947XtL5tIticwKKRajoCUfG0eXhzZVfGvJW4G8rKG5E2pqAgcc6GQzccDxkr0LYSypjs0sHplttE5hGL1Cp3qySnwa5C6KDVDxHFmDmdjKifB8doR1jDlmJB2xT3iJpsGyHMFXIOKYA7KzclK9LT5OuPCN/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029269; c=relaxed/simple;
	bh=if69drRBCTV4awSjdBUuTYvDa30Qxaap9FKm1O56q7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0m06UgXBQdxY4MhXLb2sAQPZkadABxIGLCPoEmgs5hVYMDKL7M/Y+C0K6dVfyTO9edmChDms0Mm+JYqByPelfDbWjZn/s4QNrC8Jj5j/Oxz4senZFXp5FEvsN8tH8mV7Z2HAU9rZoZrEBCU0netdDrPlHo43ejnf2wStwT7pYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvLaduA/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732029265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if69drRBCTV4awSjdBUuTYvDa30Qxaap9FKm1O56q7U=;
	b=hvLaduA/YeMJRELxaKy4GA9mAPTzp3g3zZneUfI+66IBVFoo0GFzk7HjQkmfEX9CD1fb/O
	KWRj4uVVORnw+MW5kO5Wmmrmbqo42DjijLTCvFQ28z0t0m0T9vw3w0lAGxNvTVVKy0waZQ
	GadvTD/E5qaXkLi+wS3PWNCY3FsegkU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-odinL6WiNJ2AteMihozlvQ-1; Tue, 19 Nov 2024 10:14:23 -0500
X-MC-Unique: odinL6WiNJ2AteMihozlvQ-1
X-Mimecast-MFC-AGG-ID: odinL6WiNJ2AteMihozlvQ
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d425049448so26419246d6.0
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 07:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029263; x=1732634063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=if69drRBCTV4awSjdBUuTYvDa30Qxaap9FKm1O56q7U=;
        b=SIQb+WQlLZCkbJCmdY3iIMBn015RGuKi5dgx+3y6tsHaW8ZaGQdvRbpswTc0RhxYm/
         mFJoWPju1dxAJzuNgWG2LfG/qk7/9CgPJ3wz+DGHL97Wt272liRSmLStMXfUfGq2ynwV
         d/R/9pMGl1s1ymqyowWZICF/sAcnnXGLD3hnztKBPS2ja7iCF6/J14WrJMw2zKL+IqtT
         Ly//aZzaQXHsWl52oF/DhfQS7z6a9K1w8vcfABI72oKTk03oLVCN8tri2vQsktPdPW0G
         7mlFkjfbU5o4byF2EbZZEnQ/rDhlQa47Fur7v8mYyg4XleAiGZqq1RQVptrEXj6mm5+2
         t3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCS5lvDyzYVQNGXiG8g6i0nTgG0uJJFEmmyl3QK6/66joz3Z6PIaj9jeZT9cZruVu762W9hGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dVwt6hsrc/cOYo/UBUiRV9ZOC6rFAGCjal4WSkdPzXzxFQlZ
	oUqID4vJeASzMEi9kU0q0j2vE8oRRYD5l7cCTnr27JQlfN/NLfuJL0BHI8Svn3wuc4c1j6+5aBA
	agTbB7FMBlbtQ7rFHkYde+llJhBnhc1OvH4PQjjpOImSlQ/dg3iga5z+NdOJcGGOr0jgekEeM3Q
	xwRTb8B4Htz9OoFoq+w2xMMicWfXdf
X-Received: by 2002:a05:6214:5342:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6d3fb897fabmr211990016d6.40.1732029263249;
        Tue, 19 Nov 2024 07:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0SlS3oVJQi6iYOznIb2/23KkAp5532+AGyC12c5UZIJ3MNw9YvtejqtSgZStLfm5g2gA2QzoeQinXwBB7eLA=
X-Received: by 2002:a05:6214:5342:b0:6d3:f1ff:f8d6 with SMTP id
 6a1803df08f44-6d3fb897fabmr211989736d6.40.1732029263001; Tue, 19 Nov 2024
 07:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com> <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
In-Reply-To: <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Tue, 19 Nov 2024 10:13:57 -0500
Message-ID: <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dario@cure53.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 9:54=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Nov 19, 2024 at 2:58=E2=80=AFPM Patrick Donnelly <pdonnell@redhat=
.com> wrote:
> > The protocol does **not** require building the full path for most
> > operations unless it involves a snapshot.
>
> We don't use Ceph snapshots, but before today's emergency update, we
> could shoot down an arbitrary server with a single (unprivileged)
> system call using this vulnerability.
>
> I'm not sure what your point is, but this vulnerability exists, it
> works without snapshots and we think it's serious.

I'm not suggesting there isn't a bug. I'm correcting a misunderstanding.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


