Return-Path: <stable+bounces-253373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPRYIhoNDmo35wUAu9opvQ
	(envelope-from <stable+bounces-253373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:35:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490759877F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78259306195F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854034AB00;
	Wed, 20 May 2026 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M3Mp8K2j"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEE3469F6
	for <stable@vger.kernel.org>; Wed, 20 May 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305543; cv=none; b=mJTjTjSwnFUOLDZcMW+evTnBf8KVs4Q7ZYargBojlKhs4LFQHOSEvmlB72BxzuzXRmrLrLAl8XKblzJfTTRXIgGAphWr4pm0TvfSgDYqdvHoDrG70O1z9gHF+OL8dyAhYUG5Wmh9qSzY04GU6i8lKi/OfEw+nFCWIY3nVtJ5rJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305543; c=relaxed/simple;
	bh=fE7L5X0OAZJPu0MR4qi275DCqHXUYbK31o+O4PycIek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPujS+CtSIdYd7DeU1+z09EV4Uw7h/NvP2wmN5PDLwIRK7e+bI8k5qvnQLoWJKGz3jzpK6/cWBK0UJ+Pyc43MhofVvC3/mIr7cIZoWFNt6rwqDrTxZ6wKzOjEu7MHL0X38AloqJhmJ2MURA72zf3gF7ki1wTlR92Q2nbl6CPyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M3Mp8K2j; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd8f9725b30so458625666b.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779305539; x=1779910339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XtsLxXbuubW9aHbvOjPZig1kaSvDhEBypwJASxFDBgw=;
        b=M3Mp8K2jH2riYp5PbkzummazO7tuDrbs+0/au7aQCoBoKIEDf+/7ZV0DRMVkP2o/c/
         X15MZ214LAY6uMGUsbGv/gftyQDK2J5tTon/8tIQdsU+4GkLENpP40zpwynIrMmu7cG6
         JBQaZz/HuoR+mtAXDljNBA13Yq5a5aIDwUA9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305539; x=1779910339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtsLxXbuubW9aHbvOjPZig1kaSvDhEBypwJASxFDBgw=;
        b=lnm1hn27lGYnEzYSCkbEY48cIMpcGbAN1/65pazBseCBbCVtL0EE1UAeMnYKfd/XhK
         YzhQDP3kbgmu56uJT+Iql7NxQRoUCiRxSja1TeuuZ7/bzVXwBx4i/PToPU3gM4RzHgZV
         jMTD0iss1vNYduHZZUpvA1TyJE705gnHuGOz4rx9HOjlpbFMa+mnLpD7g9J1oG4kaiPy
         0dRVv+7SbNkVA4nnijFI/MNhBZinY/ErdXrslKBG8H2altSn9/bCMke9hYbkcWvXq2Pu
         Hg54lTemM9ubVAm8TI4WDscEZA5DJylpId88y6mAjDo4aKjgEXpWT/b+R7OJQK6LJYmw
         +Kcg==
X-Forwarded-Encrypted: i=1; AFNElJ/7OgNebrL0GOYTlzqsLyy06ENwp858hjItQopFTElHEdwhyr4BdzKaG5o67AcaGLNwz/3ucNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabzwDAzZ9sw6O3KEzEZE5bd1lL726x7pWwT2qRBcyh1Ps2lh9
	7vdavroWOzGQSAwjizxX0lGGEZitFDK+uzcDu3SkEDcY4hJ263o+mMzvDDheMqovyCPhM0vDCW2
	QpGkdhPtMYg==
X-Gm-Gg: Acq92OF1V+gzrBbnHzXlsCSAPSAOH74xCEHJWwCPUQUYo8ALhPQ883/aigmZNNopeIT
	xsjtM7Xfe5qpNPBEaqlSXoVobifLwNf8oSHJ0He1juaN9TZAu6qJ4b6rf3VTK4sQ/QKmlM1iR5t
	1BHzaZQJos7sS/pvFiHfRrXf/gifm6L+U3I63QGbsbA1yJ+6I36wd+L9T72MX9uRtdcqdmyFK0u
	woh65H7W55fjyKdUvASm6on0CHXm8+mvZoW3AFQFKPDeM1Pn72zmP7iLEeD5+8lsPgh6maqTUj5
	4qu+3hSrRvL05X0+IZCBcrNBEXF0ZRhIqz9n5cS/kOWLDoBBaQvIGcebVXPjAzpPOTBe1G3K/if
	0jNnHmszdgdhx/WG2DK02vIM9i1eVQs2+rqkl/TnyLIXjO9LKHLtQeWfQF/ALaPLgTmthmudN5Y
	/b1jF0rx8CRHsapo0QWexZ53Ceun5Rj0VDgF7qlj4VHXdZvekH44yH+vBfRu18lt0I0y6WZ9qKo
	QQowoe5T5k=
X-Received: by 2002:a17:907:1c8d:b0:bd5:1519:8a3e with SMTP id a640c23a62f3a-bd517842476mr1336201366b.14.1779305539374;
        Wed, 20 May 2026 12:32:19 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e68fa6sm919975666b.54.2026.05.20.12.32.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 12:32:18 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso2250020a12.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 12:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+gmuC7BieSiiLGG5tkhCnI15AD4G/cIYxeS21OCZdNHi/ZHTMFOH5XCeyjimemmmP0WZyKx6g=@vger.kernel.org
X-Received: by 2002:a17:907:8305:b0:bd5:2ed4:4ef6 with SMTP id
 a640c23a62f3a-bd52ed45a11mr891164366b.19.1779305538567; Wed, 20 May 2026
 12:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
 <2026052047-silica-grub-0bb2@gregkh> <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
In-Reply-To: <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 May 2026 14:32:01 -0500
X-Gmail-Original-Message-ID: <CAHk-=whwq2_iaf7pTuzVXEcJmng_exwae_bKtgSDdm4BQivGHg@mail.gmail.com>
X-Gm-Features: AVHnY4JbF0smfoYDE8sbuuYGNoDoNmD1Smk1nthlg9vTbrAZFGd72HXyofmB_k8
Message-ID: <CAHk-=whwq2_iaf7pTuzVXEcJmng_exwae_bKtgSDdm4BQivGHg@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, August Wikerfors <git@augustwikerfors.se>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253373-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1490759877F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 08:53, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> >
> > Just never rebase any public tree please.
>
> I guess the alternative is to do merges, right?

No. Back-merges are bad too, unless they have a really damn solid
reason for them, and some "keep up with other peoples work" is not
that.

The primary model should be that you care about your own work, and
make sure that that is as stable as possible. Do *NOT* try to chase
other people's work. Not with merges, not with rebases.

Then when your branch is all done and ready, you ask upstream (in your
case typically the networking tree) to pull it.

Some people at that point *jump* to the point where upstream merged from them.

Or another fairly common model is to have just started another branch
for future work. Keeping independent development branches for
different features is also a good thing to strive for, because it
makes it easier for different people to work on different branches
without messing with each other, but it also means that one feature
being delayed (due to unexpected problems or whatever) doesn't affect
other branches. And if done well, it also means that you wouldn't even
care about the whole "point where upstream merged", because your other
work simply isn't dependent on things like that.

So there are many ways to deal with them, but rebasing and merging are
typically the worst ones that should be avoided unless active problems
happen.

Sometimes you have to rebase because of a mistake. Sometimes you need
to do back-merges. But you should damn well have *reasons* for both
that aren't "that's just how we work".

Back-merges in particular need to not just be "merge upstream". They
need a commit message that explains *why* you're merging upstream (and
not merge some random point, the same way you shouldn't start
development at some random point of questionable stability).

Rebasing is "invisible" except for the mess it leaves with random
commit ids (and the problems it can cause for anybody who happened to
use an older version). So you can't explain it, but it should then be
explained to upstream why you ask them to pull recent changes that
clearly cannot have been tested in that form.

                Linus

