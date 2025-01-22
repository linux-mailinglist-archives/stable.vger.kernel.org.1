Return-Path: <stable+bounces-110107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299BA18C97
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE9C188AC03
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8271A8419;
	Wed, 22 Jan 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="JsON4Y0h";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="UOOAmQs5"
X-Original-To: stable@vger.kernel.org
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE21170A30
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529907; cv=none; b=hpFexaZlZeS2ppwS4u73uXFurtC7fjMDRgfcoRHv1E5IgUlbAWVwC+4zUL0sxqzwyO6/qw0Ds8IAtG5LChB79DCij3CaQMcYi94BgEJD2xokOwzjcC8n592hejsyAr5FE6+jF0NhVgUD91rNLkrFA+oZuk0nseFy6znwX3Dm/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529907; c=relaxed/simple;
	bh=TNpI51pZWWQbfO25dihlhFNTdZIebflR/kqxFxhuos8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J8mu+tJ5F10w4PltKqz3sarwMv+hhmiUDvzsmGpmR1fHA9wuoHwPYQDrVUSWoUgWu2xTBwwkKcFCKL7Lk9nG7dGe/Yrs14nTeliubI+oEeWwjNewKS9AqvngWKeyItFCJHlfFjH6QJX5OQg813nsSKvAaN1NrQf0qwehDaZmd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=JsON4Y0h; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=UOOAmQs5; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1737529905; x=1769065905;
  h=dkim-signature:x-google-dkim-signature:
   x-gm-message-state:x-gm-gg:x-google-smtp-source:
   mime-version:from:date:x-gm-features:message-id:subject:
   to:cc:content-type:x-cse-connectionguid:x-cse-msgguid;
  bh=TNpI51pZWWQbfO25dihlhFNTdZIebflR/kqxFxhuos8=;
  b=JsON4Y0h1gt5gP9ZFXf6Ai6n8CxDKWC/8VupY5zZBS7OoNZyQywOy/Tc
   /Mz4B2R6gVR7ztMECshcir9sqk3bXcXpvo0McnXZVdhvw6T856zvehEep
   WmWuUba0vc0cLgw87Xm8dmFPha1FULvthY4HTi0epJoZXSIJMCfB9GPdj
   TSTRT+ZM+ECdeguy2F0OXDADorvXg9ewjaEDxE77xH+bzk5NS9hEzbw5U
   XfrbUD38tgxkzpcuQzIOju5zYqUgspQ62JmRCY0Vk/hcpu3EFWN/4kWk9
   zBiNabQ9nLSHuk9Qw9pehZyolzyfCaOGiXhnCbSE/+WQ44zGpj4ewCCUn
   g==;
X-CSE-ConnectionGUID: ixPJq6KGTzmNGfOJLpWsew==
X-CSE-MsgGUID: lOAZQA6FQyeNpXMQipd2Hw==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Jan 2025 23:10:36 -0800
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so17861676a91.0
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1737529835; x=1738134635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wI92WC2FqxNLcvD7BYS9EfQ1xXQuypuDqhspDDYCWIE=;
        b=UOOAmQs5KmrEPstNuCXho/hAzZ9bPUH7ndk5/D/AivcbfoRKkAR/P9b94lUMeYmRLE
         RSo0cfAP3Oy3SWIsOfQI9y5xlz0hyrdyxitP2ZJAlMd8s3jfWxjFQ84T/uX5hJYs1LNj
         iKqeULNN11kOBOY/O0Yv/XTW2jN9Ypa5dc+LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529835; x=1738134635;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wI92WC2FqxNLcvD7BYS9EfQ1xXQuypuDqhspDDYCWIE=;
        b=K2z0xJk+aQCCyveoKIINdVGdmAlfvUn0t0xW+drqrHR3j43sUkmu3ldoLv6xxZrBM6
         SzIELPrglzn9lPzKQh+3u5896G73g6rTqj8BEaZQlEAvRFvnk7RLkVAJn+7d8fg2g+rq
         fGg/yeJfj3RK2qKRYxnknwLkeaLktDY6ISI4bYuxNDOo6V9OIt6cZ5yBoY9PlZD50D83
         woQIe6JTJ5tAf/3uinzRXFibKHVHq4bdk6yM+56Dqay0qpkJf7jaTyFXiNpwXW5wbcoq
         xz/Xjbk2e1UhRfN6CM7m9+R95L96xNygA2/+xj6O3Qs1OPht/IdB6tzmdwhkDX0d+wbD
         If6Q==
X-Gm-Message-State: AOJu0Yw3cJT6aRqgeo8PeuiGLOOgLFsrbtxwCvsT1Y0v+lgbv0w0HCwk
	DjV8mkDAU0O2H5lYKBt0+p0kuWAt9k2WhLojw44dJ5nDBeT6K0IDPGhEuMyM87kSndLEf5IOXTn
	xnws6nggJSJtUv/veMIMdo2aggBW2xpAIwBULxgSU31h7nW8ZHUtuhv8zl2ZgePefA8uCKobSgd
	qJsuGwfzibkG0WzmdeW3I5AEjIJB0+lfENtMMdLhmm
X-Gm-Gg: ASbGnct/Ui4Y1kxgszmHIzxiQ8yBY3thUoy909NK5IHohijCnxu7E/ohTtGyMH/u7Au
	Ef5KOiaUSejBjuMJpw+oDSOCm7ND4jIKD5eVzlCpgypCsvIuJCLSvL1kLxwWOCKm5n34g999IKH
	H/nVggbE661g==
X-Received: by 2002:a17:90b:2808:b0:2ee:d433:7c54 with SMTP id 98e67ed59e1d1-2f782cb61bemr28386772a91.19.1737529835204;
        Tue, 21 Jan 2025 23:10:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZtJbBNpJwz6KRKGQuTnFynCIrBfceWOVkIrppwAxS51YLYIQqIxRzsq/AAgAJbIas8OfVIaXfsjuCvjfXNTk=
X-Received: by 2002:a17:90b:2808:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2f782cb61bemr28386755a91.19.1737529834942; Tue, 21 Jan 2025
 23:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Tue, 21 Jan 2025 23:10:23 -0800
X-Gm-Features: AbW1kva27Ug6j5F33i3SNLopJ8dBESg7VjM9L9EjTwJwG_0-G4bdab5QeYyLFa8
Message-ID: <CALAgD-5WmCEvNQMkQBk+XhRFQbKCoC8XP_eMP4U7N9RTOqWmQQ@mail.gmail.com>
Subject: Patch "net/sched: Fix mirred deadlock on device recursion" should
 probably be ported to 5.4, 5.10 and 5.15 LTS.
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Zheng Zhang <zzhan173@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We noticed that the patch 0f022d32c3ec should be probably ported to 6.1 and 6.6
LTS according to the bug introducing commit. Also, it can be applied
to the latest version of these two LTS branches without conflicts. Its
bug introducing commit is 3bcb846ca4cf. According to our
manual analysis,  the vulnerability is a deadlock caused by recursive
locking of the qdisc lock (`sch->q.lock`) when packets are redirected
in a loop (e.g., mirroring or redirecting packets to the same device).
This happens because the same qdisc lock is attempted to be acquired
multiple times by the same CPU, leading to a deadlock. The commit
3bcb846ca4cf removes the `spin_trylock()` in `net_tx_action()` and
replaces it with `spin_lock()`. By doing so, it eliminates the
non-blocking lock attempt (`spin_trylock()`), which would fail if the
lock was already held, preventing recursive locking.  The
`spin_lock()` will block (wait) if the lock is already held, allowing
for the possibility of the same CPU attempting to acquire the same
lock recursively, leading to a deadlock. The patch adds an `owner`
field to the `Qdisc` structure to track the CPU that currently owns
the qdisc. Before enqueueing a packet to the qdisc, it checks if the
current CPU is the owner. If so, it drops the packet to prevent the
recursive locking. This effectively prevents the deadlock by ensuring
that the same CPU doesn't attempt to acquire the lock recursively.
-- 
Yours sincerely,
Xingyu

