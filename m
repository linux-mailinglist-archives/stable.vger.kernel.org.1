Return-Path: <stable+bounces-160160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EFAF8CA5
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD9D1C456FE
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B4286D63;
	Fri,  4 Jul 2025 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4/es0pB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5E2868AC
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618763; cv=none; b=kJFe+rpFP9A3ZODNlQbEq1mDt1jpWA9GHMCTBpYqhS2h/RbwI4+vDEtmyHv2Q+SdtswTyuIjlrtZOmQhAYVEsQBYNN+H5tMug+AmT4t6B1dHlhB9U31cZFz1TACIhDh2XZsVFm/kcfpCD98pWp4XRiUfiG3SnhAW0eBv/qBiJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618763; c=relaxed/simple;
	bh=fWtsRtsKRR+YxmcUmibZ9YIr5Kb9L6DQ3I2HhuhqgkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCiAUtbAZRo3hOf6TLgWwHNTF1xQlERoG0du8VGG4ZKl0yZTwdtYchnmmbnuOuFHhU/fWlXriU5cfF/qepg/r+3tS9fHp1cKJF0VTck256WlN1kCkFAndKNExZHgSu2bLooML8Y6ATn0QYtc2yg96GPNiQssbroEbULt+j9SxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4/es0pB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so1036911a12.1
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751618760; x=1752223560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5HDyQjJmwrKGxCz76EsKchM6gEU0GOHofHph6N/rOI=;
        b=d4/es0pBAe6BFIqQSAWgg12RjnBG4zVW/d2ZctV8y39IzJ3yAFBIxB1DOSt5phf2vB
         5ZYpdxQfDUnaKvhJgz3wKYPCw0XIePLtgdmZidE8n0OQeDmbCjUNsFgimSsKlEZLaAPd
         tuK/WRYwFxH5n7KtnU7W8ZN5wOvGpj8Ii6D2+llfgx9DkDQfz+P7BNJqzS1dOIYIKMul
         iUijkZb20UO10UZTo4RyeSA8Fnw/66MIEx5vRu/BYWXVXondjub+hwo4B+kEgJB8Vrsl
         qEe0bcaUKQpcJ+inMY4olyB9ikBHhG265bGAUwIl4vqE2mtqFkjVaJrul76Pk7ijClEB
         O/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618760; x=1752223560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5HDyQjJmwrKGxCz76EsKchM6gEU0GOHofHph6N/rOI=;
        b=sAjwL6PSQm5odMxJqlrD7INUFCmaNusD95q8f7CcWhJOe1HE1N4adXK6YYfb90FLKJ
         BP3GatRmAGZS8oNnHYlqwobPoddoaOh6Of0P3cFVCYXTwElKmqCQLBF1mIzCa7g3GFiE
         YQACHJCUiV7TV76/dYs98qEtXTlfwrqC1pz85iZXHzwzKvxC5CW1knWuocSnRV+HA/2s
         zHdFIJ9eoVSQBAPQqAD4xFTXXypd+S1tIrSBu66G8zBEGZZ5WVV624UYD691FsqDLMZv
         jFwkkaiu1+ohUNc14tQqnoY90dWiCcPK3KKH2jroo4TYUlRoKVbI4IXYzI/PDoNtK66W
         TJIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQoMfQFA3GwdEQksoANtBb/K1U6jIuhYagYx6MPWUxuKJTGelBQFQDDYnPxt5qeHgt/oMwAtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0C7gyJ4AQtqyfct7Ia6XD0LoGSCFFs1llQbPzIIkDuNlTwrKi
	RvmuoImolSlzJxxVaTSQEZulFPXodfUBpI0ExY+KIQ7t4V3rOoJBwVxzqKevjkchVz5tJbgBkY6
	0j/S14S02HW2n8ma3mRy5gkwO1dbgYzkD9BdiuoI=
X-Gm-Gg: ASbGncvLco8umoWetWOfBZdoFmuv39fL/M70d2eCvXZS1YivnHDbYEjhuJUTdecSjP2
	S62iUlUVUhXzXl9btZ6/rhpr4sIkHSxXOlAouC/uJkJcsdmW3SPsSjN6RWf7NL8/028nMeX26VF
	2AlW072BsZIULTXR1NQ8xcKb/WY8d6vDFXvB5AwmjaFyExL9l7rVlyQzrgmaw6Ukt6P7sfAczm6
	a2n
X-Google-Smtp-Source: AGHT+IFu4kYKiCz6Emj33LW7Y8GFJCg3mveK+3CAC4UqDx64WQQbP3BFbyi5n6piGzPp52QeR/j6y92LD+YSyEJBJiw=
X-Received: by 2002:a05:6402:40c5:b0:60c:44d6:281f with SMTP id
 4fb4d7f45d1cf-60fd650a617mr1234971a12.7.1751618759948; Fri, 04 Jul 2025
 01:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624134840.47853-1-pranav.tyagi03@gmail.com>
 <20250624191559-d8d1fb6d1407e834@stable.kernel.org> <CAH4c4jLg+X-2AoC6WgHVkS7gR1Vr2zmEy-Sv-oey8sg0DU6ZeQ@mail.gmail.com>
 <2025070449-lubricant-bullish-4653@gregkh>
In-Reply-To: <2025070449-lubricant-bullish-4653@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 4 Jul 2025 14:15:46 +0530
X-Gm-Features: Ac12FXxhxH65De3JH7a5qg7CYUSTU13_wlGznVoGVIGL7kWMwSsQcWd9bLLi5I0
Message-ID: <CAH4c4jLL8naS6R=8gRaVYK-bJ-oi6ioT1qmvUJy=QVzL0PBi+Q@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] xfs: fix super block buf log item UAF during force shutdown
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 1:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Jul 04, 2025 at 01:16:01PM +0530, Pranav Tyagi wrote:
> > On Wed, Jun 25, 2025 at 7:39=E2=80=AFPM Sasha Levin <sashal@kernel.org>=
 wrote:
> > >
> > > [ Sasha's backport helper bot ]
> > >
> > > Hi,
> > >
> > > =E2=9C=85 All tests passed successfully. No issues detected.
> > > No action required from the submitter.
> > >
> > > The upstream commit SHA1 provided is correct: 575689fc0ffa6c4bb4e72fd=
18e31a6525a6124e0
> > >
> > > WARNING: Author mismatch between patch and upstream commit:
> > > Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
> > > Commit author: Guo Xuenan<guoxuenan@huawei.com>
> > >
> > > Status in newer kernel trees:
> > > 6.15.y | Present (exact SHA1)
> > > 6.12.y | Present (exact SHA1)
> > > 6.6.y | Present (exact SHA1)
> > > 6.1.y | Present (different SHA1: 0d889ae85fcf)
> > >
> > > Note: The patch differs from the upstream commit:
> > > ---
> > > 1:  575689fc0ffa6 ! 1:  9876b048d8f68 xfs: fix super block buf log it=
em UAF during force shutdown
> > >     @@ Metadata
> > >       ## Commit message ##
> > >          xfs: fix super block buf log item UAF during force shutdown
> > >
> > >     +    [ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0 ]
> > >     +
> > >          xfs log io error will trigger xlog shut down, and end_io wor=
ker call
> > >          xlog_state_shutdown_callbacks to unpin and release the buf l=
og item.
> > >          The race condition is that when there are some thread doing =
transaction
> > >     @@ Commit message
> > >          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >          Disabling lock debugging due to kernel taint
> > >
> > >     +    [ Backport to 5.15: context cleanly applied with no semantic=
 changes.
> > >     +    Build-tested. ]
> > >     +
> > >          Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > >          Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > >          Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > >     +    Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > >
> > >       ## fs/xfs/xfs_buf_item.c ##
> > >      @@ fs/xfs/xfs_buf_item.c: xfs_buf_item_relse(
> > > ---
> > >
> > > Results of testing on various branches:
> > >
> > > | Branch                    | Patch Apply | Build Test |
> > > |---------------------------|-------------|------------|
> > > | stable/linux-5.15.y       |  Success    |  Success   |
> >
> > Hi,
> >
> > Just following up on this 5.15.y backport.
> > Please let me know if anything else is needed from my side.
>
> xfs patches need to go through the xfs maintainers for their approval.
> "build tested" just doesn't cut it at all, you MUST actually test this
> at runtime.  Otherwise, why would you even want this patch applied if
> you don't have xfs systems that you care about?
>
> thanks,
>
> greg k-h

Hi Greg,

Apologies for the oversight. I had assumed that a build test would
suffice for a backport since the patch is already merged upstream. I now
understand the importance of runtime testing, even for backports. I=E2=80=
=99ll
test it on the XFS setup and resend the patch.

Thanks for the clarification.

Regards
Pranav Tyagi

