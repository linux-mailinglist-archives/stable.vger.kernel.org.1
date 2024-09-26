Return-Path: <stable+bounces-77757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A5986E80
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792D5283115
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B7145A0F;
	Thu, 26 Sep 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkXycBby"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DC13CABC
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337990; cv=none; b=c+vRTTM108vw2WaEKRYewqH5rZxkis5jYaFSOr6j4fofzQoaQkPR9UfSN9CPNIkJ+Sjt9mAsAm2XqZ5qDDjiy0yh/5Ti33ZqhszhOLonbB32vzJW3dQmyMYgHmbVr0Jx8ao0MsnvcnRg9MUeoCfQl4VAGGTpvdwt6wV+WIW9LYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337990; c=relaxed/simple;
	bh=biWe9SCPMWB4EBx4lKE9mL17X69k/v0fgz92fvOkNfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzJCH5MII7psm/R5wWwGIOoh1xD6LF0/kSKUN9SdSDxJzt3tibZ5TknnRonMVjoYPo828pDxJRyaZyDv5tNZ8wDfSJZQVB8hsU8S3Pa/Itk62OQ0MnCuW6Jaxz1/RS6c8qPI0VfAU90kDuDyhQxPBYAlzfw29QqviqwGGLHX6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkXycBby; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so5466925e9.3
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727337987; x=1727942787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biWe9SCPMWB4EBx4lKE9mL17X69k/v0fgz92fvOkNfg=;
        b=rkXycBbyJl1F4bqOWNsovXohYyj5qf1rUnfMPl9GwZeZxtnsajHFg4ehjvyXwhjyy+
         feCaJVKI0BXKPUn7ZYtkpVb7y881taFOIuF/DjaqDFT0zP+1UF027FLZh/lVsrUV9VQG
         kmME17WNno7fftv+tocZomb+QPgP0eR0Rf+MS6wlMA7SD2CgXuiwPL2Wh1shJXjCAM2Y
         ZovWlgEHneADNNogtpJ71MAflysfYjrYnWLij5edAZwZN09iWrap7bWsMD/MEl6Be3wU
         Y1l/gaTM03+IzlBwCrNVaOU+uvGyEpUvUE45OgPSG4mK5tyl/la4ccvfS4uFyum+3MAt
         Kmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337987; x=1727942787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biWe9SCPMWB4EBx4lKE9mL17X69k/v0fgz92fvOkNfg=;
        b=vTnz4ECxOxo4SQSdkSgg2ifjWwQK8BraK9BcZzWG4TPE5Y2YJPGrTNeNvEW6kc5DJn
         HwzeMJUJL4uaN0FYWTm+Wi8kV+SvL2ePWbvuNMFLa2W9jEASjzqwZdbJGPtXfzhSN40f
         AIBUIVUuBdQds7OyqMYcC67CWbwsKj+IgPPTdnOT2ckbL93FR2HoZRxF5wdB7r66rAN4
         SE+0AQkpNlljRBjLJ93azlqmCg0KjnpRerlhlrrtm8YCFWIK9H3XyTdxCeLzCq22leWb
         5WBTneNpnVH0G/iVxRqar1H2wXyUA2n+jkdgntkOnwV2w74FiIUPD11ixkPqmgYrGY6M
         bclg==
X-Forwarded-Encrypted: i=1; AJvYcCXLgJ6uTcG1bOsl+LDkijhDjbnyqZOPZN/XeVnLn8lJi5Xprn0ceXG/uQGEECB2hMZQDwyUHws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75FuhnHeTq2RpeHeFIqrBMYAN3/k1qcQ++WoXAOn4x2b1VVTY
	pZ10deH61FEzXnaxutUKX9qgRWrRoffIaGrDVFzspcWhnHwjrmq1e2k9rL7xV/GbQVGL/hD+W9m
	QCPMhp6qzbpBLlVVaaQKj2CDdnYsA7yOPrMCx
X-Google-Smtp-Source: AGHT+IGQf4MlOYVIyq+fv+nPRs9u8K5eq9suqxgAzZolV8xGTd0n1ASvxWSTxNXpoLbpcjjNRQOQzO0np9ED1wdtB5I=
X-Received: by 2002:a05:600c:468f:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-42e96248ad6mr39208825e9.29.1727337986691; Thu, 26 Sep 2024
 01:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-3-cmllamas@google.com>
 <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>
 <ZvRM6RHstUiTSsk4@google.com> <CAH5fLggK3qZCXezUPg-xodUqeWRsVwZw=ywenvLAtfVRD3AgHw@mail.gmail.com>
 <ZvRRJiRe7zwyPeY7@google.com>
In-Reply-To: <ZvRRJiRe7zwyPeY7@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Sep 2024 10:06:14 +0200
Message-ID: <CAH5fLgiqgWy9BVpQ8dE6hMNvDopEMVT-4w3DffXONDo3t6NqEw@mail.gmail.com>
Subject: Re: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:06=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Wed, Sep 25, 2024 at 07:52:37PM +0200, Alice Ryhl wrote:
> > > > I reviewed some other code paths to verify whether there are other
> > > > problems with processes dying concurrently with operations on freez=
e
> > > > notifications. I didn't notice any other memory safety issues, but =
I
> > >
> > > Yeah most other paths are protected with binder_procs_lock mutex.
> > >
> > > > noticed that binder_request_freeze_notification returns EINVAL if y=
ou
> > > > try to use it with a node from a dead process. That seems problemat=
ic,
> > > > as this means that there's no way to invoke that command without
> > > > risking an EINVAL error if the remote process dies. We should not
> > > > return EINVAL errors on correct usage of the driver.
> > >
> > > Agreed, this should probably be -ESRCH or something. I'll add it to v=
2,
> > > thanks for the suggestion.
> >
> > Well, maybe? I think it's best to not return errnos from these
> > commands at all, as they obscure how many commands were processed.
>
> This is problematic, particularly when it's a multi-command buffer.
> Userspace doesn't really know which one failed and if any of them
> succeeded. Agreed.
>
> >
> > Since the node still exists even if the process dies, perhaps we can
> > just let you create the freeze notification even if it's dead? We can
> > make it end up in the same state as if you request a freeze
> > notification and the process then dies afterwards.
>
> It's a dead node, there is no process associated with it. It would be
> incorrect to setup the notification as it doesn't have a frozen status
> anymore. We can't determine the ref->node->proc->is_frozen?
>
> We could silently fail and skip the notification, but I don't know if
> userspace will attempt to release it later... and fail with EINVAL.

I mean, userspace *has* to be able to deal with the case where the
process dies *right after* the freeze notification is registered. If
we make the behavior where it's already dead be the same as that case,
then we're not giving userspace any new things it needs to care about.

Alice

