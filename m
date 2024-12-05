Return-Path: <stable+bounces-98819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1829E582C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926191884266
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D0218EA5;
	Thu,  5 Dec 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hldoOR1w"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE61A28D
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408100; cv=none; b=KFVqQepm0hnRze84R/VR9PTWahd7L4BQ6V+08EtI/72zfJDMAAnUznyqxKvz3/Oc0fhIAeLyHDK8PS0G1oXeU2Ai5Nf6uAESUgwKLoLOPRdqZ00IGVGNhrcW3tJA7828+wWxOYHYBZy0IENDrR9e/jJDeyCCjzAibUHOzNaQICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408100; c=relaxed/simple;
	bh=vUF64ErbUwTycERyQ7nasFCTlJeKVIhuEkeDOGpCuNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7z5GXfWDqpGr7QCHZlz7vWAzwoLhfycl3gJ9zEx05o8I1AJDPxfLNc/vZomRPmpR7lNvA0EeORAjKIX1uCrOn84aksbDmXFjraNEVSqkEgVDjKUxM1KRCjc/iQMAUm8MiUpLOPaSPXJJGDXBHr9L1hWAUbxER9R/fA0wvyXKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hldoOR1w; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8cf27d831so8909856d6.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 06:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733408097; x=1734012897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rIu8mw2i75SLZUvq8SDXEsvqZYyN63JMdPNObjBvEU=;
        b=hldoOR1wxOB/YnMOt6l+soXrj9RfCf9DpMo7eeP4leRSKvWa8Q5PGTDwHGeNB+aUi7
         DG7OBTSbi1ZLvrmhhdiwY6FmS7uHmHB2V8lSpvSZfI0nj8J/wX6wBriHxnW2u/KstD+L
         mPF38vP24Lii6hwfReuiLElZTKuarrjPvWxJyuLhakzvBqXiJhdskScEGYc157kAAMoD
         yMiF7kQkTpavazIG6hlv6LcKZs5aE0AN+J0cVvQ9gNJf074XDXGphGkga2yRDq41aOqO
         OkqV+gurEKt30dvLxDmxfHSQ8GBhgVZ6WGLi348KQDUrp2ixn0pwk7RJIrUNSh/kcuoY
         sBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733408097; x=1734012897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rIu8mw2i75SLZUvq8SDXEsvqZYyN63JMdPNObjBvEU=;
        b=ZWubIr10fwL+EZ45qxfqCf0hCIeeFfEEorJ6vKeHaENkIkYDweq8kOEccDxvsznoe/
         a24ailw9AW/sJJxShA5SA8xPfbkhbT83aAE/Om3Ex3JcESsyGIdMX+s3mWgwa+1bu1TP
         grKXxd9t1U+BdSflcTC+AYdU6oRnfafoBUKKVFnq0winal7Nupu5gLH4AgcTUnvHsb5Z
         rKe880E6oC5Dw7XQmwPJzMN+dgGJxuKFfKiAe/+dKsvM5leo2tlb5DOCbdGK8aYKCMFY
         pBI32myw9LnS7jb97n4JIi/x0SgcgyCeT1W+UepnTutxhWg5NcurC8IQVdQq0hbU3lkx
         nFvw==
X-Gm-Message-State: AOJu0Yzb0KyVzEVvYGteNQ+fRhEItmKjOSmxM5mjIVQvk29acoetrOdS
	WZdfDmtVSShFfroAey++5eFz3zqciQUeDKSqfGULmzicBieMmWZ0e5ZExbbyf+QAN8mnqof+eM1
	EN0PpwKaPfKhvTbQ+DplvngvUcpMA70+xmhKU
X-Gm-Gg: ASbGncty69YDq4yfeRk2eTZxqxA8uQqgoz3WuN9vWZreWgN6aWpX/OvVyrGmH4+qXce
	oWxibtMw53OmClCG+iFGs98J5J+TaJOGR8dkjOXGZGVSMNbfTgwbeaK74vUw=
X-Google-Smtp-Source: AGHT+IFhtYzpqiqgAUikDy7P4Mh5HnQT4oezT5a6TSzW6zyCdTf+5ILc6GMimACZxNC/Ir0uR3oXu9kQ2t05UlDGLoI=
X-Received: by 2002:a05:6214:2622:b0:6d8:b3a7:75a5 with SMTP id
 6a1803df08f44-6d8c46dae1bmr140564956d6.42.1733408097342; Thu, 05 Dec 2024
 06:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205130758.981732-1-bsevens@google.com> <2024120523-sash-ravioli-e697@gregkh>
In-Reply-To: <2024120523-sash-ravioli-e697@gregkh>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Thu, 5 Dec 2024 15:14:46 +0100
Message-ID: <CAGCho0UWR3zt6hcvfhy63Y_Oskb0e8UNOvrUyU=jkguCPBFTkw@mail.gmail.com>
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: Fix out of bounds reads when
 finding clock sources
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2024 at 15:12, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 05, 2024 at 01:07:58PM +0000, Beno=C3=AEt Sevens wrote:
> > From: Takashi Iwai <tiwai@suse.de>
> >
> > Upstream commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6
> >
> > The current USB-audio driver code doesn't check bLength of each
> > descriptor at traversing for clock descriptors.  That is, when a
> > device provides a bogus descriptor with a shorter bLength, the driver
> > might hit out-of-bounds reads.
> >
> > For addressing it, this patch adds sanity checks to the validator
> > functions for the clock descriptor traversal.  When the descriptor
> > length is shorter than expected, it's skipped in the loop.
> >
> > For the clock source and clock multiplier descriptors, we can just
> > check bLength against the sizeof() of each descriptor type.
> > OTOH, the clock selector descriptor of UAC2 and UAC3 has an array
> > of bNrInPins elements and two more fields at its tail, hence those
> > have to be checked in addition to the sizeof() check.
> >
> > This patch ports the upstream commit a3dd4d63eeb4 to trees that do not
> > include the refactoring commit 9ec730052fa2 ("ALSA: usb-audio:
> > Refactoring UAC2/3 clock setup code"). That commit provides union
> > objects for pointing both UAC2 and UAC3 objects and unifies the clock
> > source, selector and multiplier helper functions. This means we need to
> > perform the check in each version specific helper function, but on the
> > other hand do not need to do version specific union dereferencing in th=
e
> > macros and helper functions.
> >
> > Reported-by: Beno=C3=AEt Sevens <bsevens@google.com>
> > Cc: <stable@vger.kernel.org>
> > Link: https://lore.kernel.org/20241121140613.3651-1-bsevens@google.com
> > Link: https://patch.msgid.link/20241125144629.20757-1-tiwai@suse.de
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > (cherry picked from commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6)
> > Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
> > ---
> >  sound/usb/clock.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
>
> What changed in v2?

Only the commit description. Should I resend it in that case in reply
to the previous thread?

