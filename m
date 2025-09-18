Return-Path: <stable+bounces-180477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38897B82E5C
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 06:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66D67209D8
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4C2737FD;
	Thu, 18 Sep 2025 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PNBi5cJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3E27147D
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170611; cv=none; b=GR+M2PlzvvGoaLx5bPLH/TQCcvzHBXTvvI/lUF+jMyYPu/0p7J2UKhKM6jQqkQHFOvD8gwL1Yjb398xnst/HjVmrKzFdrTeJin8xXHffiU0YnLLc9/k5frQzZbDJbxJs3/4zQ1gSmWIMst072edoa/GL1aHvBpBNYwNfpdTeXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170611; c=relaxed/simple;
	bh=bvQKqbZUHSmC9Cgyqlv2yW20y6m1kbKZ+PzcmlxuJdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLQLDc1ii6RAEOf2bvrAETAv3vCGahZrPojTvMSiBNaQWbLI+gv1IUjbHtF/QUp10MtCwLow3EN166gF1VQv0IqAOMi6V+XSB/SCY3To5zMuMkAsQPSYhQM5m/8HOh8bfMLg1qb6BzU4rEIv2qEAdCd07T/i+ll/juV8WKsrdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PNBi5cJd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07d4d24d09so86101766b.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 21:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758170607; x=1758775407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=PNBi5cJdKb61AR69OvOnVOEoyrnSW+Jt3k9rfHifyaHDfqLk3ptS1BvpdF7s9Awy9F
         LYiAS9VDemdh4t0hw+LfbNvUgY2qs8iqsBlZOBQg1UvMHpeFuldby4a9vhaWZpii0PQh
         2F+hg/AVVZ53AiT+o+/XelJr35ZQECe/OM0sxGaXVxiVzGdn9QYzqhefC6pmCGEB8dXF
         KjpJr0Xz5SPKJMMVrqVGdfZ+4yFgyPdDLNP0RQXdi6oJumbGczqIEM2WgZfN148p0Xpk
         GLpu5lYnraC+JB4opqDja1lDF97artNDYpERNrjlEvCZ5T12gn6wrHXGP+BjEJzocwlV
         ODnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170607; x=1758775407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=AyQ/Qn4V4JJUARvhnaXGr+Ia2jKhmNAVq6usM79sl12rKj9/98BmjxS3/KMB4dc78s
         Wy7z8wf+gJR/xwUl9skMnvLwtpN0+ciNjshhzq3XLtnD7SpvT7xTXR41SSSvHbWWdQoq
         O/1GeId+5UvraX41yB2nPLSihFSglItkGQu8jtcJHfhRCy/TyM5KQDRuXyH9Hb8hMS4d
         GtDTydG9YmXiez4KmKD7cHO3G4Uz0tnbO9/gca5N6qOwcV/cbs8dTfewq6JBUTmnzAxE
         BBsTUXtCvWbHCQEIaJdV+E3H2XQtGjs/zubslAI8mE05usU952SyZ3ladarsq+blY+09
         M1bA==
X-Forwarded-Encrypted: i=1; AJvYcCUY/KtHqRluLz5U+lmsqLtSXP6inl13WzeBkkwUlPlELrgFNtjQhysV/ge6/afwwNXJwKYM/lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTlcDjVgEZSxNPfxnsn4vNzmn8RV7umez3QOI408l+MQxgzK8
	+CVEl/QnunJzy1Ys0A6sNQ51kHHfsK0sg4owRP+zUcAmByGgbANAbrYBNpy/ctOzXM6FkCtEir1
	2d++CfAqcBbUB8aXIZIMfXQ57hrap3AJzM/2iLTgrYQ==
X-Gm-Gg: ASbGncuyW6CkYsIxVPzzG+qmsPrRgCqqL6i1CJn1BMGxjxdF5m/eT8tBcryTQtPuP85
	9uEq7pCSLfiwOsbKYluegpb1twZdixu3rzZ+noJug6lCNRmW6a51N7/k3rQG5QmYtQ4/1sukn04
	K9/NLG5wcdKJ/4nDPW+s5LeTBW2iMOUizAs1BSe6raXHJkMq65CvYpBzH0QvE0MpUE+QhEWomGS
	vREKeJcSa5qEig0jpKMbp6JzE1kGDtW9SBj/6MoieqIKrV1S8NGTxM=
X-Google-Smtp-Source: AGHT+IFdanVNfWfNv8HWsgTltRUqGbgVYdYb/7YWgH/k9KVu04DfDvwoBsaR56HasWl+Vm1bcuV82HMzZ0TGHEI2ctM=
X-Received: by 2002:a17:906:4fca:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b1bb17c9028mr565217566b.12.1758170607385; Wed, 17 Sep 2025
 21:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:43:15 +0200
X-Gm-Features: AS18NWC_NdTi_yqxzEjcc4DGgSbWqBjqdGn8xuCbd_fnQdBXhfAk81_WXjHssKE
Message-ID: <CAKPOu+9io3n=PzwFPPgmGSE0moe3KDbyp7MXmwx=xU=Hsvqrvw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.

No, it is necessary to have a minimal fix that is eligible for stable backp=
orts.

Of course, my patch is a kludge; this problem is much larger and a
general, global solution should be preferred. But my patch is minimal,
easy to understand, doesn't add overhead and piggybacks on an existing
Ceph feature (per-inode work) that is considered mature and stable.
It can be backported easily to 6.12 and 6.6 (with minor conflicts due
to renamed netfs functions in adjacent lines).

