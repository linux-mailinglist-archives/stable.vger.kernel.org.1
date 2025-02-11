Return-Path: <stable+bounces-114851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1955A30537
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668631885EB6
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E81EE03C;
	Tue, 11 Feb 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="K4wyEUEk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465C1EE00D
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261159; cv=none; b=ftW7ck1Z3Y4w3YKH5Ahm5seVruWihxhmdBCqRPY+zHVBwkGjeEbxKu+o+tOQYY1fiTe9pFrPGZw1Duiavb2IXvWBLHGrbskerCW+uWUsmbYCxqoCXj41HbDh5CLhZE6eETLMqQTQlJKzwjDSFuXLzcyDAwJt8dKwOSg7sExAssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261159; c=relaxed/simple;
	bh=oZul2d/wKFmYJJHdQwxELki+d2o5+CW8gJ8R+CmprR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyOGTktE/B69LeSJ4/pgv/ZKPjU9b8ZcUCsCZfT/1R66oB6iayhPj/otDjVQAlfzQTHfehb8uOcYVSjh3G5JcYu4KJoHCpbpa/1RzAU+eWFkmBCwhkzVgl+BcM9Ze6eoj/nzzeD2dUs+c/ZBCBh3wz0/X0W8uKL82tGyeRMSHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=K4wyEUEk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so805804366b.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 00:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739261155; x=1739865955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJrOUp+F89GFnzwAsaIErFuCcKPjmLvk5s9hg9IRNZc=;
        b=K4wyEUEkD1EmMy5T2wBjcdSdS3491zZV0bOXg0j6PIHJFsnR0+dO1V+JewGd/4Qx87
         wMLCDL/WOLOR2aXEnBfw8YSX9hj0j7hKq+RsZqRWO22J5iCihdRDgF6doQYDn3xIOffm
         UCRNrSXNiOaQRNw+bVwUKcbpuHA6iHlQgAuPJKZSlkVIZwSbbJkAMaRQSS7lJD+LbR23
         QHNiWxKd+9Q59/7uMYBm+8ZsJpWOT9qBmxInOCK6lI3yhqHUboFprkkvf8xR/rfvXy5G
         tcJ3lzFzNBagjFW4RONrkCEfjCY2wWtaVUMwYM0WJr0cW8Wb2x/DwkLZU16c71OWCLDG
         Yw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261155; x=1739865955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJrOUp+F89GFnzwAsaIErFuCcKPjmLvk5s9hg9IRNZc=;
        b=kl66aryb/iNMkgvFGwAM0Yfk5XcBuU7ToxKEDa0QliMZt9IqdNmdsKQuIpEZ6hoaf/
         6H7yS1hdZuys8AJY4GWzwJFj7bF1Hce3rVbZNYBzVsrLC/kvi4dm/adQnPmG6HF7R+Ac
         6rFXX3DPJ1NjKyLPv6vBSiaC5uItsHZafTbrqPshFYBqvmkEFpS145kEp47hcSDw4bus
         71Qg7HAf76JlYfIIOPkQRTQJTtosc1lLQhM89FdXv3X1v5BnHtaDsfdzyjEtkXt40H/d
         rMHjbzicxGmQ4EcHUTL/fqN6pv6TLTzne/S/hqj+kuDeBq3Kz7Gze8kOE03nCEnRrkuQ
         Vrzg==
X-Forwarded-Encrypted: i=1; AJvYcCUtYobfh8P3txZvl8VOB3enk8lyEnbuDf8eDZe75hBQISRlXMcd67h05X6IvJxHwKMyfiz0Y+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLG4wUZ8OKmlWFtvftN8P/Ii7l1Ckh+DhCyPcNdhwcSGmm+12
	IhQrRsBGibJla/z8bGmdvPNKrnlUSPz7GQiC3LifH5+yZ6XgXrVRmq8Z4Z00LRxwhr+kGW7/rrC
	hVTPvNnFNat4EtWDuy9fp3AEiEEeNJMFBPdv5oQ==
X-Gm-Gg: ASbGncs5lvW7J4lCK5RPXFd7weO+ddmc5Qp/234Wt3X1e425Blw3JZSqpYBeF2MiN/u
	ylBzbR/agmIZcCzIwgzDEAU7HGEAB7tJD4RrbnMXAy8CZCmpLjkXEdr6Gd8lGipk5myauEhStvS
	l5spdYd7J11vAKA1VVZDucFSLAXA==
X-Google-Smtp-Source: AGHT+IEvCt8BeOXdJg8lh6Pl0LfjKQqELNkqQazSvkXvBC8ZT59e0sRDOAAy7KvIr0fZcwzxkMFleImklwBwEspDSj8=
X-Received: by 2002:a17:906:6a29:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab789ca2972mr1452330266b.54.1739261155397; Tue, 11 Feb 2025
 00:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210223144.3481766-1-max.kellermann@ionos.com> <2025021138-track-liberty-f5d9@gregkh>
In-Reply-To: <2025021138-track-liberty-f5d9@gregkh>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 11 Feb 2025 09:05:44 +0100
X-Gm-Features: AWEUYZn8IYtLkGvSdhSF9RacLZqPPLjjSSgyWsPBEwf3ckYtzh6gc1WMb8IYbZw
Message-ID: <CAKPOu+-Mi1oCNvk3SJnui3484wpfru3fE1gA72XVcX77PFOjVA@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without `marks3`
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:30=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> > Note this patch doesn't apply to v6.14 as it was obsoleted by commit
> > e2d46f2ec332 ("netfs: Change the read result collector to only use one
> > work item").
>
> Why can't we just take what is upstream instead?
>
> Diverging from that ALWAYS ends up being more work and problems in the
> end.  Only do so if you have no other choice.

Usually I agree with that, and I trust that you will make the right decisio=
n.

Before you decide, let me point out that netfs has been extremely
unstable since 6.10 (July 2024), ever since commit 2e9d7e4b984a ("mm:
Remove the PG_fscache alias for PG_private_2). All of our web servers
have been crashing since 6.10 all the time (see
https://lore.kernel.org/netfs/CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=3DzCy=
9Y87R1qw@mail.gmail.com/
for one of several bug reports I posted), and I went through
considerable trouble by resisting the pressure from people asking me
to downgrade to 6.6. (I want the bugs fixed, I don't want to go back.)
For several months, 6.12 had been crashing instantly on boot due to
yet another netfs regression
(https://lore.kernel.org/netfs/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=3Dgcmkz=
wYSY4syqw@mail.gmail.com/)
which wasn't fixed until 6.12.11, so our production servers are still
on 6.11.11 today.
Before these bugs got ironed out, v6.11 commit ee4cdf7ba857 ("netfs:
Speed up buffered reading") wreaked more havoc, leading to 8 "Fixes"
commits so far, plus the 2 I posted yesterday.

I wrote that e2d46f2ec332 has obsoleted my patch (actually both
patches), but I don't know if it really fixes both bugs. The code that
was buggy does not exist anymore in the form that my patch addresses,
but I don't know if it was just refactored and the bugs were kept (or
maybe yet more bugs sneaked in).


Max

