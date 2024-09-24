Return-Path: <stable+bounces-76961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F918983D71
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 08:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE9C281CDD
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B083A17;
	Tue, 24 Sep 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fstab.de header.i=@fstab.de header.b="R/8KoX3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98481AB1
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161118; cv=none; b=EEJiAN91EvzC97KvMHs7YLUIHHSWVnPzkvhiQ6MIcKzle2gJ0OPONzFO9rUNg5Nrm1TE7AAjU+QaCHoTNXVgsy21r3tND5fJw/wbzVWWMalIf10IK81rnzO154EX11k+GGDYQbe8XkhUiZTgWow0jP8cncIBVlk+NRlrX6UdBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161118; c=relaxed/simple;
	bh=07q9ahYM/nP+CJ0HMHVEG+85azyTF6BeNrjm3O9SQGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaEIt7Z4pxpmi3y92eDzFw0Yw8y5DyUQcBxT2LhsEErPz7byYf6DRDWWPkxr72rcKL2MATWBmedWbRyMggvBW6cbiN7yvE5El0RjXM67/w3cf3QbYqj+3vdAy6W9BwdRTj+2aUqI25OdfQG6Ks8I/2uMX3NhHdogI5a2b+ObUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fstab.de; spf=pass smtp.mailfrom=fstab.de; dkim=pass (2048-bit key) header.d=fstab.de header.i=@fstab.de header.b=R/8KoX3o; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fstab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fstab.de
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c56eec7fccso36402336d6.3
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fstab.de; s=google; t=1727161115; x=1727765915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07q9ahYM/nP+CJ0HMHVEG+85azyTF6BeNrjm3O9SQGs=;
        b=R/8KoX3oIk6MckCsnIIc/2Jee+UrhLstJohwv/DepTP4naFJ/uPCrF+gX4XSXB6ooT
         TE4TOMCyOLheK8Gv2QXExWJ5IjdiD5/7ZPOfDQSjIN8eYHXWc2pxpfZ7XydVllnlnASF
         OQJpcl+CLxz6L6+aJije/tbq7ctlh43zUznjP/0l0q6T5PCn7SxeMn5NLowJb4VSSxaD
         gn2/1LQSmw3aOLK+iZTidgs1Nt1/hgA8P1GuLV2ARWsdrSc+SPUKUo16fRHUF4IUfif8
         KSCKbDnQYhvV4TZWMfID4mKywVCNfNR8mwxh+lRRenTtT8bbbxKq+c+BbajkojNDFX2R
         SCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161115; x=1727765915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07q9ahYM/nP+CJ0HMHVEG+85azyTF6BeNrjm3O9SQGs=;
        b=b5IXgIprnRdAZpEhUxQoUoddIPYEZ9u4//yULwezJ7+gGTFGG92aDAOi4d+yC1xA4K
         JRUqkir6vWFEp8FjCEhxD0Gmu99qjNO3zcZ5GfIBLbIICLGSx9qoiji/PKHrve5UYMPH
         W5a6xpzhL1rvaqbuOtqCXM/dvYumOB8UugHZlDMCnhTACu+AHyDG4nSUgcFg64Kfc9u9
         5xATecT3Kq7n9cfkq6IOOVOmuQ1/mm1AtI0qSI9/MGP8EdHL8znt4yRo4fp1M0AaxN7O
         pwXsWJhWD2v4xeeBYSvnNK8aciYJeM7FzWR5xmk57cTg4qpKevW6wyp4oWhpoQChFqIv
         1H9g==
X-Gm-Message-State: AOJu0YznOJa09WSlFP44nW2NEN7sW5sY7RQ4iPSRFBLoKxos+UdlHc6F
	5oVjDmOLkQNevuHX+2C+UNmjjuMk70erqUm5EOPV4npuyhyhs7c+fDGTYPaF2xFqe6YPbSyzInK
	OoL6MTZONowjFn68uQh+dx1pu9mckx4kYOrvb0A==
X-Google-Smtp-Source: AGHT+IFXJduceOyuYmjFZFES4FBzZayxNGhe01YJ32akwYi9lbFIAX7peTclwe0Uro0bKhwdttyXSE5jwSC68MbxVT4=
X-Received: by 2002:a05:6214:5d11:b0:6c5:8125:d7c2 with SMTP id
 6a1803df08f44-6c7bc6f1a81mr244109976d6.26.1727161115375; Mon, 23 Sep 2024
 23:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
 <2024092318-pregnancy-handwoven-3458@gregkh>
In-Reply-To: <2024092318-pregnancy-handwoven-3458@gregkh>
From: =?UTF-8?Q?Fabian_St=C3=A4ber?= <fabian@fstab.de>
Date: Tue, 24 Sep 2024 08:58:24 +0200
Message-ID: <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I can reproduce the issue with the upstream Linux kernel: I compiled
6.6.28 and 6.6.29 from source: 6.6.28 works, 6.6.29 doesn't.

I'll learn how to do 'git bisect' to narrow it down to the offending commit=
.

The non-lts kernel is also broken.

Fabian

On Mon, Sep 23, 2024 at 8:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Sep 23, 2024 at 08:34:23AM +0200, Fabian St=C3=A4ber wrote:
> > Hi,
>
> Adding the linux-usb list.
>
> > I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
> > Linux for years without issues. However, updating to
> > linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using the
> > latest non-LTS kernel doesn't help, it also breaks the USB ports.
> >
> > Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
> > working version.
> >
> > I opened a thread on the Arch Linux forum
> > https://bbs.archlinux.org/viewtopic.php?id=3D299604 with some dmesg
> > output. However, it sounds like this is a regression in the Linux
> > kernel, so I'm posting this here as well.
> >
> > Let me know if you need any more info.
>
> Is there any way you can use 'git bisect' to test inbetween kernel
> versions/commits to find the offending change?
>
> Does the non-lts arch kernel work properly?
>
> thanks,
>
> greg k-h

