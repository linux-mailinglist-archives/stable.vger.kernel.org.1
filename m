Return-Path: <stable+bounces-247729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JmtKpMTB2ourgIAu9opvQ
	(envelope-from <stable+bounces-247729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:37:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48054FB21
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737DA30D3AE7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5E47A0C7;
	Fri, 15 May 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsvmY9SH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E945BD57
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846800; cv=pass; b=ChGMS/+GhokoSLq7NZAONM+51wI+rEoxFJktWlQJyPbfDUr6ysxcJ87jthFcrGoqwo9gFyZrcnaVcHCplgcMwkNaA5kfvc+yjvPA6JA0vKhRQ9OH7QHusT/Qu7PUHAHgl1FKhZbohW9igEMO3XU6qWSOY/uQbJSxVUU+6DpwjQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846800; c=relaxed/simple;
	bh=+UBsqowdXjrxyXaGO8gZjA/lfuCfrMGbalFkQPi3Dsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttjvjk9oRd8OLJ4dsv/IBWA97kT5NLfRonDCe6fC39aFRCpkppH0fMmtuWy2A6TCsOQJmRRYV4eYRTiIMQDi8c9c/UoROjuWk0TrHWSlmwJuV3PRKWaHkKKF2PfP/pst4GgQC4rOeyAQM57tOQc9t8SToLf4+Nlc0i8usr/907k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsvmY9SH; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso79487595e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778846797; cv=none;
        d=google.com; s=arc-20240605;
        b=iLwAUozphjOji+t5HCWg87y/+0mjlMIkC7eBHdUH3hUfsJPKyhO+PVtVZGzV5xoW6T
         IMhaEoY2oJ4GaceyTy3EhG1wOpkmHhImF90KlK2q9wWZTTNYB+5uqfCUp6L/nPSE4nGb
         EvqIqdWGn6H0DXw5WOk6pD59c5EYWjpoHZlglBfGU/aovtBkSpELdeTBbyOCp/ybilwS
         oWUJ3l7nmb6rXbLYOSZ7koDx1v96NM3dgyaeMm+rjhZSKlEfRgOyEWYLKylfzwrpEGpn
         mS8HTrQH5is3b4BRlWmXvt+8YjHdE3aig0WITy5TRislL9SSQY8rTZspbhgCiOVhHrCN
         2k+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/SUkniN/IDzm6P77YkiurnQsEpxZspfg+vEHC7oOaB0=;
        fh=Y1PMsya/RzwjClfr8apQB+SpXBkH3DHa8HsUoPtYTwo=;
        b=Wwh5XUPuOmvSYzu+Lz/V783uHtWPi6ArBHzq89wOVaBU8vxGFmZEYSCNKYzX+BPyhq
         uBvTdJTSvn2el2QN6MafRcdbT6MadA6w2wDEyJEoJXskWGWxhgEdXY9H1mgTTuWA6689
         50AxV5PQnUbG2xrkxb/PzN5h7fg16oSD7ekiDHT4sUT6D3IpwXfdctE9kI1FH09HTeIv
         Awse3TRKgOk3YtsAz2EMz+Zitxc3oQBumQhTCppcGjkgjgUGct0AGsu7D9CYjNRRkJ7S
         NI+tEngrc9NdnbPoiWf/OFTP96Drt2t/LmGOgYSmn+LOz1elN3pXoaS6aQz2UBDv4KNi
         cmGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778846797; x=1779451597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SUkniN/IDzm6P77YkiurnQsEpxZspfg+vEHC7oOaB0=;
        b=gsvmY9SHvoLyBf9hkaWYkKqgYXGr4s0ohDNqY81+lz21ai39rcY/r5iyeYXfSCYz7g
         WTfDXRJ9IBn7CWeo4WOPlo9J3rEOAfjX/RphgpQEakBavghxwzHmcu3FUOKEsPuFxbTr
         H+xqZDUwVgLL2LZQHC/9/zd6T23zJCeFL1ueEw4oyhnwOja3YG++OkshKX6YrATOlVuy
         TSUPQO92PIudP0eM7oVG1hNU3q9WfboOqVdLR16tL01RjapAto7tk0ffhjjYLffg5OtG
         OK3tprtTUeEw2nVTeuTCAsxjc6RocOrbVouEPRiocyva2k8QN7qQcYnvRANsdLFKtPTS
         vcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846797; x=1779451597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SUkniN/IDzm6P77YkiurnQsEpxZspfg+vEHC7oOaB0=;
        b=WvbJP75aWeF4NDCdJ3UcRtyQ/V0leQUkUbD52EIu8YfYAhDUr/1rzN84TumROk4CJq
         QqaVGh7pO+epHeILxlckIewGoIpgyIkQVjurm9WCENSM7XZt+Q54HKU4vqJwKkxZvpIL
         ryWkA92N7rxAhUj4cBJFKGVYPymX0NQnehEEjR7fcHzuDqM3YtKaSU80G8t68Ca9jtgc
         mihKKozL/ozt7eEiUUKaMwbEUUvdEOMwYK0L7Ar1gfum18TSC4y1M+0XfTbXkU3daxUN
         uWIl4rhUKycwxvewIxxg/DynFHc+GDRQaXn8K+avKddnbyLlNw8G1kNf6bm0G4l7TIZq
         GyQw==
X-Forwarded-Encrypted: i=1; AFNElJ+ycMTX5plvNWrUsIiJ2D9GkKjytescV12IeUCZ6BRsHI/DA1KAAlm0zKAnvnmhHkox8ANqkqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BYVNNAWIt8s+s2Ati+o2CBxWhrTx8s5WQ8Hu3/4e17fjPgw7
	eBPjC0vjdNeUzSq3fXR8EccELkHqB1BfVH9ei82ZjIeS+xvyjvse1ja37kNJ1NL+rq2L7KF6Y3u
	8qOe68WEIQ9w6hGmUyxhwP/zvg1RciJQ=
X-Gm-Gg: Acq92OEyK34vzZ3EmGZzDv0Dp5F/5l6ahXQdiUcBJhUP7UVGS0Lr+mGcdPot5GC5j//
	R5ABk/G7vF9GJwX7dZ3sFLShFigKIYxQhsUgoaGldOEp2GtXAQLKEQXvH/ShxXgI8l2fgypMlS7
	BYBMRkSKHnxXZ2GA+pzfZPHb+qigz4z7m8hURkwDaur5c73xKmXj0TvpfENQnQIF3xBz0GxezMZ
	Z+3pJu2uIW7+BCpyfIc5Qk9+Xgx4SEoD4IUaJ+FmYUWMI0hZuOVhKpzKlihHxYTXxFIXCc7HD5K
	8fLMpZeZzmwMXnDeQUnftQfzT5veO3a/PLa+4LGu2naAFZ0juBKITVe8M44ci/5W2NlyJMLmXeZ
	FpP6r/Xm6LYwWw6YcUMuX32H+gRk2e1+IrtqymKcr3AfsEIISyhEN6EQWSnOtL3c/HatBX+nlXq
	6z/fV4Ow==
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr40441305e9.8.1778846796773; Fri, 15 May 2026
 05:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-magnetometer-kernel-mem-leak-v2-1-320e1ad4843d@gmail.com>
 <20260515125821.520fe56f@jic23-huawei>
In-Reply-To: <20260515125821.520fe56f@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 14:06:25 +0200
X-Gm-Features: AVHnY4IumS3GgOW93qHfl-GGifMpK5rCnPEeVuFifXrJ4fA1ojTTKUpQcOsrGIo
Message-ID: <CALoEA-xTWUpg86QVSaToroCfvjDX-H_YB1rqhzVW_v=HSeCRDg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0F48054FB21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,parrot.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247729-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,joshua.crofts1.gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, 15 May 2026 at 13:58, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 15 May 2026 12:28:23 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Currently in the AK8975 driver there are four instances where potential
> > uninitialized kernel stack memory leaks can occur. If
> > i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
> > the size of the buffer, uninitialized bytes are retained in the buffer
> > and later the buffer is passed on to IIO buffers, potentially leaking
> > memory to userspace.
> >
> > Fix this by adding checks whether the return value of the function is
> > equal to the size of the buffer and subsequently if the value is
> > lesser than zero to distinguish from a returned error code.
> >
> > Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
> > Cc: stable@vger.kernel.org
>
> I'm doubtful about a stable marking for the patch.
>
> Personally I've never seen an i2c response that was short (yet correct
> enough not to trigger an error return).  There are specific devices
> that will do this because they are not ready for instance, but not on
> a general read.
>
> Whilst I know in theory they can occur, has anyone else ever seen one?
>
> I don't mind hardening against it but not something I'd rush
> to backport or even necessarily to take as a fix.
>
> Patch looks fine to me and the thing sashiko is moaning about is already
> fixed on my tree.  Note this is going the slow way at least partly because
> of all the other work on the driver!
>
> So picked up by stable tag dropped.  Applied to the togreg branch of iio.git

Hi Jonathan,

Wasn't really sure whether to CC stable, but added it just in case. Yes, short
reads are pretty rare, however I do agree with the hardening angle.

Thanks

--
Kind regards

CJD

