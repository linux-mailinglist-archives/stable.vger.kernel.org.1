Return-Path: <stable+bounces-2773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1BE7FA5B1
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9021C20B28
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847635892;
	Mon, 27 Nov 2023 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f0Weq2uF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD54D53
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 08:08:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285d1101868so875223a91.0
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701101300; x=1701706100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qJHcJvgSi9NsuTwsEhpD2ncg0QTQnQplCbXljQilBg=;
        b=f0Weq2uFhY/kdVrbmL19Vky95iZTlI+r+ngHxXuIUGJolImKFU9KSS7l5Md+aP3gpv
         rDNsuqig0WEEyi6Efm8riBxvO8PVwYrALEOmS4avcqRcys0+/OHH3yL1vtedmUOsWZlJ
         6bbATvpfnpmPOpgCJ6cPiFBhQW6mdNhxjVJzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101300; x=1701706100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qJHcJvgSi9NsuTwsEhpD2ncg0QTQnQplCbXljQilBg=;
        b=rQzEA7FBwc8GY6eywTDUZSDqYJT7Wn0aO6RKiXzJkmMiz0UR562RFkhGhpf7gt/w7O
         TSgE7GZZjrxAf4zWPTO8MS9Zw8f6a2a6mxIuE0665LR/YYAI54hizrYMp6/HIlu/1biI
         /rvh8fxh+ud4bNHscQe9k4JAX1yGmFsGWiDUlAQZ9mrJ11n7+55STof9zCzCyAB4WsD9
         s4We8YwweBNq4i1jfM91yDvY9976Hm1I9QA9c5eITs9dZvqLLNqdm9xQYxYRpBbdH3+r
         iguYc95rszBxzXloXiDMbziYziQwDGKcsY7iZfL5MzXtjj7XKjeM43FoXMnpzB1hFy3B
         p1nQ==
X-Gm-Message-State: AOJu0YzgaoCKk3Gdq7+JRZsTa1ayxnY/59Kl+SM/N5rL2Qau1DxUnrWp
	Bi4KqGNPT19JtEpFr6TR1F1kBG+C6t8KjQ0DWp7MQg==
X-Google-Smtp-Source: AGHT+IGlBQfeWyOms7gUrf7fFFg33Nf4rfw2bvUdcqWN587HmwZDfz+vXtO9m1AP+AS1BOAvQdOxEeHpXZs+RJo2Ejc=
X-Received: by 2002:a17:90b:3907:b0:27c:ed8e:1840 with SMTP id
 ob7-20020a17090b390700b0027ced8e1840mr11052657pjb.10.1701101299771; Mon, 27
 Nov 2023 08:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023112456-linked-nape-bf19@gregkh> <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>
 <ZWSEsrpogmi7LQa_@arm.com>
In-Reply-To: <ZWSEsrpogmi7LQa_@arm.com>
From: Florent Revest <revest@chromium.org>
Date: Mon, 27 Nov 2023 17:08:08 +0100
Message-ID: <CABRcYmKCFW-Z1zEegkktuczD2n+FuMmmB46mvt=4+zugkddrOQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] prctl: Disable prctl(PR_SET_MDWE) on
 parisc" failed to apply to 6.5-stable tree
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Helge Deller <deller@gmx.de>, gregkh@linuxfoundation.org, sam@gentoo.org, 
	stable@vger.kernel.org, torvalds@linux-foundation.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:59=E2=80=AFPM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Nov 24, 2023 at 04:10:25PM +0100, Helge Deller wrote:
> > On 11/24/23 12:35, gregkh@linuxfoundation.org wrote:
> > > The patch below does not apply to the 6.5-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following com=
mands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.5.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112=
456-linked-nape-bf19@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> > >
> > > Possible dependencies:
> > >
> > > 793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
> > > 24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
> > > 0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")
> >
> > Greg, I think the most clean solution is that you pull in this patch:
> >
> > commit 24e41bf8a6b424c76c5902fb999e9eca61bdf83d
> > Author: Florent Revest <revest@chromium.org>
> > Date:   Mon Aug 28 17:08:57 2023 +0200
> >     mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl
> >
> > as well into 6.5-stable and 6.6-stable prior to applying my patch.
> >
> > Florent, Kees and Catalin, do you see any issues if this patch
> > ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl") is backported
> > to 6.5 and 6.6 too?
> > If yes, I'm happy to just send the trivial backport of my patch below..=
.
>
> TBH, given that the NO_INHERIT MDWE is a new feature and it took us a
> few rounds to define its semantics, I'd rather not back-port it unless
> someone has a strong need for it in 6.5 (not sure the stable rules even
> allow for this). The parisc patch is simple enough to be backported on
> its own.

I agree with Catalin :)

