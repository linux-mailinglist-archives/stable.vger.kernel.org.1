Return-Path: <stable+bounces-204320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AAACEB4B9
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB283011ED6
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 05:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC930FC23;
	Wed, 31 Dec 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaEfPAge"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618231F4611
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767158887; cv=none; b=PDXOnROJE5ahxXHO+5AMEtJBZV5gRgIc9MFtEEMfb6yHHXNQ3o2bmSEgTlVR4rzu47HS7XuPAVmBdd0DeVozplD5L6A2IlVGXhL7/2Rt7NJg2Np/CZ4I19S8LdXmd1DDQFKlyhECLz4PTaZebJKad8QRGmOLo1OKsr/3LuSwxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767158887; c=relaxed/simple;
	bh=WR+6+OUkqQr+Y5lDdNxUM3EuAUXticwgpKYJ7Mc9H1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWFL3dzK4PqxAnbOX5XSNLFjX72z8PmKksa5H1o7tWg38W5Dqk6t3HlE0QIM9MKQPWj/hYDe0o5S5NQdIT1NSiZVrH5PIgUIBaruPbaITLadJ7tFRU9VjNL0x0sga40pi75ua6L3eEfQYG0DJEzH03oBybnUDYFI1mCOsjdYRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaEfPAge; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640d4f2f13dso8951723d50.1
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 21:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767158885; x=1767763685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neE2xjkWXwgvUgGg5ZJ/mbPsEp4n4zK4JeRN0ZAZy7U=;
        b=GaEfPAgeONLBpm8jl1nzuXwa5dHEN2LwaWDRGsTjS86dYRCBa40jVXN+twd4k8D5Ax
         7iJWndVssgnxeLTf40oXV9kXUCkpp5jwPn2XJGAgo4jSuwudCpEHfrDzFrFBZh6ABGj6
         2ciWyoZj562L7v1A88FZSlVWnLjCgbDForL76AlNOmoUtHaN3JJsTle5lWwFSBMuGAi8
         g66IeAKQO1oL0/ow5Qu0D7LghIbPBXwtZh3TzbK3m/DNqleQ790uGqPI27m4NVKX55ow
         JagHlDPc47x+jYcg+aZqtOWAfW3IZZKhzNIqWZBI+gJHZNLx4SR7TUP9ezVQL1rcXdE6
         Q/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767158885; x=1767763685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neE2xjkWXwgvUgGg5ZJ/mbPsEp4n4zK4JeRN0ZAZy7U=;
        b=uwazfcwdu095rN9R86BpzPwJ5uDD1XjT5FUCr/63Q2yWCtYXbi3YTpLbSZWgZZgR3Y
         fAw8IGg2GPOqON2Axf5uk5VWzYw+zHSQNyc3xH6fEOrNu3KzBtS1Em9XsXwSqqVmI96i
         0bE3F6jroEdCiyKl4uKp6W9IqF0j6x4cYSGl4dGU9psvsTwVfq2IjIsju1Tji2KQcarK
         xcC7h+urAFrx88k6i9jUzjSHGmi2OSgdBE4NaVVM2S6VIstQ6vi3g/IJtQGZXilPDmbM
         0FFN+tNXLK0vPEZ4kazKc/MOEDO8JD5nAAm/0avrEcgJPHV6QQ7RLVcIxtO0sVmdrV6j
         YyKw==
X-Forwarded-Encrypted: i=1; AJvYcCUWegaj4V5Gna0j98X7s3EGF+VkGJw0Ay5qDHEVuWmb2jsTqjUd/3jyAL1MSGuKOK1tTZWUwCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1e+0x9e2Q3N4rI6EFrpUivglYnrjCo5s7QTjY+sELDTn0eQF7
	vCU6EgHyDi4b6XQL+9P0LwCX/3ByrW559baoL2KUvHZhpAgdqUE6XcDTfrCNNPpIShM+WtYHGk8
	kBjRFNGuqWgAZqLr0wVuWUYTTRy+0Ogc=
X-Gm-Gg: AY/fxX4c4IWGmBHooy+eGk2YaeiAoXwEDEeVOJAkds1172RXtcaWoFjU5dPFrRfV08x
	48FlJmdX2Q3AlYpuJeGtBqV73xWQhIaY/OAR55If18hcS6o6ubTxVlt4fzLatQwFYxDwJYGQrE7
	5oKCMP6xtyx5IyOh370Ba/5wVGWZohGawimBd2120x7gp1oWYlwlswu/0CGkNPvNj4IWaGEVXkX
	5LFQeqZVKuGpaSkCA8WXfaTQemItDYbq1Nn0YMPhC8HECo36Qmxt8byXV5IjZjegWZCWVlFc6Sj
	QfYBRbE=
X-Google-Smtp-Source: AGHT+IEXZaIdD+WLGv3jQi1HvQb+WET+wjlJvMaD1oEmCvE1HqOdYGi+snxXD9Pe5VDdymn3M0Y1Zoc0IoKr3Gc7U/Y=
X-Received: by 2002:a05:690e:bcb:b0:640:dfa4:2a6c with SMTP id
 956f58d0204a3-6466a8b6e4fmr28144084d50.63.1767158885298; Tue, 30 Dec 2025
 21:28:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230034516.48129-1-sj@kernel.org> <20251231012522.75876-1-sj@kernel.org>
In-Reply-To: <20251231012522.75876-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 31 Dec 2025 14:27:54 +0900
X-Gm-Features: AQt7F2qc4ikpHLFjT-n4BMfolCsHaYaz_KyU9_25Xqa-F_N79PKbP9l9_QEVNRY
Message-ID: <CAHOvCC6F5zLnBF=v7G5k1WdDZZmkBAK94ixzLiPF0W53wdtyeA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "# 6 . 14 . x" <stable@vger.kernel.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
>
> On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > >
> > [...]
> > > > I will send a new version of this fix soon.
> > >
> > > So far, I got two fixup ideas.
> > >
> > > The first one is keeping the current code as is, and additionally modifying
> > > kdamond_call() to protect all call_control object accesses under
> > > ctx->call_controls_lock protection.
> > >
> > > The second one is reverting this patch, and doing the DAMON running status
> > > check before adding the damon_call_control object, but releasing the
> > > kdamond_lock after the object insertion is done.
> > >
> > > I'm in favor of the second one at the moment, as it seems more simple.
> >
> > I don't really like both approaches because those implicitly add locking rules.
> > If the first approach is taken, damon_call() callers should aware they should
> > not register callback functions that can hold call_controls_lock.  If the
> > second approach is taken, we should avoid holding kdamond_lock while holding
> > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > but I want to avoid that if possible.
> >
> > The third idea I just got is, keeping this patch as is, and moving the final
> > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > removes the race condition between the final kdamond_call() and
> > damon_call_handle_inactive_ctx(), without introducing new locking rules.
>
> I just posted the v2 [1] with the third idea.
>
> [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org

I generally agree with what you've said so far.  However, it's inefficient
to continue executing damon_call_handle_inactive_ctx() while kdamond is
"off".  There's no need to add a new damon_call_handle_inactive_ctx()
function.  As shown below, it's better to call list_add only when kdamond
is "on" (true), and then use the existing code to end with
kdamond_call(ctx, true) when kdamond is "off."

+static void kdamond_call(struct damon_ctx *ctx, bool cancel);
+
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:       DAMON context to call the function for.
@@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
damon_call_control *control)
        control->canceled = false;
        INIT_LIST_HEAD(&control->list);

-       if (damon_is_running(ctx)) {
-               mutex_lock(&ctx->call_controls_lock);
+       mutex_lock(&ctx->call_controls_lock);
+       if (ctx->kdamond) {
                list_add_tail(&control->list, &ctx->call_controls);
-               mutex_unlock(&ctx->call_controls_lock);
        } else {
-               /* return damon_call_handle_inactive_ctx(ctx, control); */
+               mutex_unlock(&ctx->call_controls_lock);
+               if (!list_empty_careful(&ctx->call_controls))
+                       kdamond_call(ctx, true);
                return -EINVAL;
        }
+       mutex_unlock(&ctx->call_controls_lock);
+
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]

