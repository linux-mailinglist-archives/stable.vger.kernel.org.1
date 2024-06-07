Return-Path: <stable+bounces-49961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352699000C9
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EA01C214BF
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693613342F;
	Fri,  7 Jun 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIeNt/8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCE15CD6E
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756082; cv=none; b=ca+Y38PvxvobXbu3wIbuRbuGDgHoSLoxqZts+xAZboMxS3noU1HZIVP0WED68UlTdJIRlEz8YRo3wcj4xZrHoq+dWEFWrI3wVK4EEem6pdZWFtxcFWwx9ApfYFu3oNImBFrb+rMh2lSnHo9tPC2/03ywf2g5MBQIeQQJK/nEGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756082; c=relaxed/simple;
	bh=4pOciMp2GK15yjsDcWYCbU44uPQ8B/P+eRn49XYCW98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFtsRidUl+Qlw4JjqdrBCnAe2a6/WZ7qdoKMvwN9Gu1lZptH2RJ2+NggEd7bChlMJvqxqIomnUf7KMd95CWdKT+nbKm5ev+e6NEXYY0ZMZOqBFOzxTZ3yw+SB82uceTtsFs8yXXeyiQ8h2auZ2Ca+NUrvNbp+GsanFfr37daG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIeNt/8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079A8C2BBFC
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717756082;
	bh=4pOciMp2GK15yjsDcWYCbU44uPQ8B/P+eRn49XYCW98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RIeNt/8V9WWPPNYPKqDTEzYtlrkYvw9OYK8kfJN8R67luh41HE9flftRgaclX1UJt
	 ohuK3wklJHsfs4fmKWeTcAWax0RwwNKKh/rJgc8KuZ06jiGqf78BrBbRRneGlZj3q+
	 f25c+rTeeKyLTe6MNEqqK0HwP3iWHlglxci19DqSqSKP5HF21iKikhZ4tNW2AqLDXR
	 0HdZmqhmlxZAxAtLeSQC+FPN18Eq0WWPUSTs2wkKLrt6A2vnNb3cgjBt9b02BE6Zwo
	 aH/NbbWibDzLor8BoH53h1VHj4Y5UhALAwDBvszB8cS+4iQkRhuLwRthKCSSshJ9Ti
	 dQQSqUvSQ8mgw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaccc0979eso22907701fa.1
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 03:28:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxA1T1UmqAIpLYyKKmc/3dagakh6rOKAmu8mMUpWab2K4ivzuwS
	USBqLCTS3NVbk5vrGOqMDMn45WyT9L5yEBSDml2FRSueXVk0DRL154KG5aDfaQh+rC14W/P0JLw
	TN+K9Ycp6H98PzftI0Gcss7O7t7U=
X-Google-Smtp-Source: AGHT+IF5DPfJ8Yx+X8fGE9jzoqSedq8VgObAJ5uIFHPrSrJIEYk145lWJNuE2YgJxgMtyu8fGWAfLkONbzJWRiTC/34=
X-Received: by 2002:a05:651c:216:b0:2df:c2b:8c84 with SMTP id
 38308e7fff4ca-2eadce16d71mr13354741fa.1.1717756080442; Fri, 07 Jun 2024
 03:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
 <2024060602-reacquire-nineteen-57aa@gregkh> <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
 <2024060733-publisher-tingly-e928@gregkh> <CAMj1kXHXsTOcm8pYLnOh33dMKc31_dpPZJVXaen=-Dod4DMzuQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHXsTOcm8pYLnOh33dMKc31_dpPZJVXaen=-Dod4DMzuQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Jun 2024 12:27:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_uTQetQU0GD72V=EgJQbBSLcpDwe_9LZg08dCoUPSEQ@mail.gmail.com>
Message-ID: <CAMj1kXF_uTQetQU0GD72V=EgJQbBSLcpDwe_9LZg08dCoUPSEQ@mail.gmail.com>
Subject: Re: backport request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jun 2024 at 12:25, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 7 Jun 2024 at 12:23, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jun 07, 2024 at 10:43:19AM +0200, Ard Biesheuvel wrote:
> > > On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> > > > > Please consider commit
> > > > >
> > > > > 15aa8fb852f995dd
> > > > > x86/efistub: Omit physical KASLR when memory reservations exist
> > > > >
> > > > > for backporting to v6.1 and later.
> > > >
> > > > Now queued up,t hanks.
> > > >
> > >
> > > Thanks.
> > >
> > > I don't see it in v6.1 though - was there a problem applying it there?
> >
> > Nope, it's right here:
> >         https://lore.kernel.org/all/20240606131701.442284898@linuxfoundation.org/
>
> I don't see it here
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-6.1.y

Sorry, I meant here

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1

the other queues do have it.

