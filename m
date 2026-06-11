Return-Path: <stable+bounces-262668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ntDOKRmWKmoitAMAu9opvQ
	(envelope-from <stable+bounces-262668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:03:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99580671204
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=Rd49jsO3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262668-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262668-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79CD73003833
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792873D6487;
	Thu, 11 Jun 2026 11:03:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E43CEB9D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 11:03:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175828; cv=pass; b=S5K/rIaoabPFBBgLqL210XMBnHpmwfqlPF7dIjhURd1D6Ld2+mjihckrTXYShZq3+4gUzVCu0q74NDaDygcr40W2gE8qSYqwohLibLl24I7PjfhCpMiNnQv6eqqQ/Xthh6+pIXaYLaJLQ7ZiA/RVK7SjMds9GAdOo8LxZpTp0l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175828; c=relaxed/simple;
	bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZS+IdFN5MOQWwlzJR+BW/NoLXox+JShWUfVTOs0zT9TlekT+p1zOS0RirozuTpZA0ny/CKiSYQIjvWBz5/OjLYoyKLjSTq6hPND8TYajUjuz6N6Ndw675JExUuuEHRpfUB/ceyX4QLJbgpjK0n2gxMB5MsGG6VDtcIxTGbw5Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Rd49jsO3; arc=pass smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51778069c31so61902231cf.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 04:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781175826; cv=none;
        d=google.com; s=arc-20240605;
        b=Nx2ic7F4Vfxz9i92BevaQI4wtTQRQjQ3/C6pj6adpLjgQaoD07wqbGMB8b/EZcHiFl
         RpV/V9jX2p54/u5Yxnv6MPgc8V0k0Hd1O/mvAzP3NDzKV2xtKYiXXN8cSXiHmRxwdCUZ
         JD0U1N0kxK58exQz2LHrednOwsuLzHgokb6aLGjYh9f5W7KaOmsUVUsarwEw9zEC+xjF
         D4Hu4q6f7g4qWRh2jgg9bM3karOXuF6o8j28Hi8Hi2GaY5Rozc8Lmy3v3k/ocqNTvyj5
         B2W97uH59y0FE+PFtM/1Ned+MqgCzKZvqQsr7AAQw2yd0E7cWLAEpYg7VJMOTDRsGwHl
         rgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
        fh=MgAmkMQ4r9GKBeKrHRvwMSJHBKLrRXmehAGjDF90U/s=;
        b=K2iJtifR84nnU+Deyfo8icpNGgUdYfffeNHEFYPG1qkzhjGL74Gv3lLF+kqx2KOrtP
         OoKJHlqUZ1WdzQS3na8twjaBWIm4G2elpe9R1e8QNXfeG+HFjdh9lJs0+aaJge/yrBKB
         dmzh4he+T3JSmlEOkCLav9lUmyx3RSqxy4mCHzMAra81MXrMvYk87nF8YjxZkFAlhHej
         NMAzQATsHXeXvbSmARBqIcDIfe6rHqcGMuE74xyo02cPX+tz8McsfcCIl+pghPOqF063
         /15InV/KjUUWv4XSQ+5Msl0Sxwvb+bC+ciMN6Nf/7wN/zR/M6JjasahPIlbyn50Hleob
         gmFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781175826; x=1781780626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
        b=Rd49jsO3l1lY3RF2KuX+rknXELNjOpxr3qKIOIMJXqckJl2Q7OpEoPruQKFd1YtF//
         6HKpdxKxwHbuI1nGdgr8AgF4Iyfo6I43U9pgrZ5wKFNCXpwKm7WBbjdJ9Zt5BnqhuEuk
         A+6gq0nxvufyjLi6zTxBR2cfkRJpuWhRJh56U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175826; x=1781780626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
        b=h24cuLbEy8mj7s73Hx3td+Aqtnid6MUL6zluzWpTrro4Kz8AWHRXSx3gRrJr3EExtd
         Y+P2tS5c4tTRlFBhk2/eGApGOlwaphP83/bGDp3fDhgPFuDuwGIDi3XNnQLUrBAnvTDo
         5P0Nhihq/PD++cBYUdKOuOrwHTC/yfD6lUMKfiIUaYPy2CHZxIa/kauXeX1NbUWgxI4r
         HDCZAu1IYbv1UWRNkeyMiXkfzhAmeK8yrxwKDk/CpQsfJUw95Rliv48MahsEugrZPJ2a
         /hVQsqBrlbcRHrxCWSxH0fCsB7ypsHN4xllyygciR5PJ9x3y0SFqqGeePnZGEtAmsFhq
         kWCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t5zOZZnZtHOtlT6EnMexs7maqWRKq8BEYpStckCMmoGdUQUYHaZf1MUAr9HjNvoi2fkAk7oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymHntgIK4mzgRZaQye4BXVF2UGeheo9Yr2v9yX2SfR+amjlNl7
	gFwwvpvrFzN08Iev3MqFWin+EBfZMBs7KhB0K5HRrgMvFwgQQbjnY5EOWYSWgmwqFMdj7zCEVlJ
	QyX5DoQ3INYo0a3rzZfalwPgPpJsWVOJjpmwUtbeiUg==
X-Gm-Gg: Acq92OFkbvsWkX6QkApi+hHLBj3op6vlfMTZrqWJkSmfzYkghX3gqnSMv/UgrKbQvHF
	wyh3J+zUVpfKKgkD9gA5wfMnkaZiQIO6ZA82HGYSQCD4JG2oasvB6DgfqY9jgFe5kqvc0RgMr+y
	V7WCqm8gmM3bBMgm8CDUpe+dybFw5KQATDjD1g2zr1j/5dQ6smYZGv+kUrp97WWFH0zppy0cDNR
	Y1xGYedBAOjjbtepVVA5rp5oGG3JCn5EO92EkJPWFQ9Ub53sh8h5xgmqeqarm/Vb8jfPlpzjs/S
	ATs0MmWjfqAjfetIitQhQ7PEafpF4rlx9kkip/QlfAVQI2zYSWo=
X-Received: by 2002:a05:622a:5a09:b0:517:8315:d6a5 with SMTP id
 d75a77b69052e-517ee3ecc73mr34001861cf.55.1781175825944; Thu, 11 Jun 2026
 04:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408172510.52950-1-joannelkoong@gmail.com>
In-Reply-To: <20260408172510.52950-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 13:03:35 +0200
X-Gm-Features: AVVi8Cdo4QiSj1oTyoStt3uNLXQRdQ43vrDqaYk9NAzSVhSlqcEh0yVVAFo3E4w
Message-ID: <CAJfpegtR2ghZLZ2_O-YCWdMoPPEKE1naiTkmoang-=S_As72CA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix io-uring background queue dispatch on
 request completion
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, hbirthelmer@ddn.com, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:bernd@bsbernd.com,m:hbirthelmer@ddn.com,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262668-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,szeredi.hu:dkim,szeredi.hu:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99580671204

On Wed, 8 Apr 2026 at 19:28, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a background request completes via the io_uring path, the
> background queue gets flushed to dispatch pending background requests,
> but this is done before the connection-level background counters
> (fc->num_background, fc->active_background) are properly accounted,
> which may reduce effective queue depth to one.
>
> The connection-level counters are decremented in fuse_request_end(), but
> flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
> the io_uring per-queue bg one, which means pending uring background
> requests on the queue are never dispatched in this path.
>
> Fix this by accounting the connection-level background counters first
> before flushing the queue's background queue. Since
> fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
> skip the background cleanup branch entirely, which avoids any
> double-decrements; it will call the wake_up(&req->waitq) branch but this
> is effectively a no-op as background requests have no waiters on
> req->waitq.
>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
> Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos

