Return-Path: <stable+bounces-152744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D8ADBE59
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 03:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7597A5222
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 01:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D9136327;
	Tue, 17 Jun 2025 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7WTMyk7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8B2BF014;
	Tue, 17 Jun 2025 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122436; cv=none; b=eIt2w4h+oXkbBIHKJw4bkawL6d+L3Osw/mB7t6M9ZnKd1APzs1PQG29Dw19RqUvVFUIfwjEGYLxySFtxq0XwDorA6iFxc+pkR7vfR7SvnRrQj1ifXYQsLQnlr2s5smd2jOjouchdwzIJ19/Es9aLeXur/JvCC6yRd/gH6WhPPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122436; c=relaxed/simple;
	bh=HbFb6CshsF71RmYPnO4/VfKtNDtyBXqxqwWV9EAVx7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P66+IIpKviXx5A+d8rJepFGoRe99TmePKVWahEjMVrfMGwqh7Yfxe7FMWAunjym96dDTkjXfSyp1bc/j7OpMSIRvblTWPyTQ2U/BWLjSOl0zeocrFAhviguXhFSpW7W8qH+mZ4yCIYGWlaz7rZQWDY7XtswL0KXNQssPSvXhtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7WTMyk7; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e7ef5d6bffso1124152137.3;
        Mon, 16 Jun 2025 18:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750122434; x=1750727234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad9i9fPjljtJDZlJd+81Ng6OvEgS6Th4cAu7xxdqO2w=;
        b=k7WTMyk7mBSx/L461HFpcxbD89opZTsXMXVLTb2+whJlyPiZHvyAxfkViUbHuX8KhQ
         It69m0pZk+jt4WM0c2MwR+HPQuWNAxp1hNTObx7LA4BZyWm4pTD0Om+JSmXG9PFARzj4
         AcDlUMjw41UgFj7WkVvNA9PZjD4PPMyBE+fi4H9HUoHU3X/hMbICI+8N6QPrfTSRRgco
         Qrm+8ZYDh2qmHBesOZwDISfrRpUHsW6+I2oZAgvl/PPWfnF9fobNh4A1PbT1+6Mh19cV
         E+htLk+xm3LlnNtl9lV586EFJ6Tn/hgkYaVJD8We16XmuBBq7D1CCgHLIzyr3um3jFlv
         qL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750122434; x=1750727234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad9i9fPjljtJDZlJd+81Ng6OvEgS6Th4cAu7xxdqO2w=;
        b=hiOAz7lx32pMcEuBcqV5wxUEgEGL35KFdf2L0MTN7t2jJPemrmPAX7R4U0ySgCfttK
         D2VGh4oJ8Dbcy6tmPvZwvkYwvDUbgRCn/68OAvmM728+h7NFa5srxt/MpfJDT4O7KH+k
         /Fy7O2CQWZbdvx0+8ZipIU8Tv1p6+YbVTodk4IOj6IaORmvIfZy/4Fs9KBQSuzd0USus
         I0h0jVVjJC6D4wJOBFC2Lxz5FBQ2XVKyaKjc/KBWZyC7AXvCe6aMGNpti1EZ8AHGQpdx
         dxfV6oGciZCWb6uDVg6up5HrIz8U0JCHpHjwxyTzijiywBlT6OuGUQALJLsed7Z7pAGh
         96Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWB8YPyR61YIS1bqN3+rh8LDjh9hKABWAo+7lXeDtaDyfMLT2ndt4pNE6GIbJ+pneaznsKZTfhQaPc0cfFiAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhzhq+cjOeejabz8d65AYs53wBc1hQhFLABR58ymiFw6j2D3QB
	vVvP5R2LRVnUF0jI1UWjhkCxWlns42brtcdncIZ6XDfJx8Zh8WpKrw6bOAmbBZoiUlcaeTJhNCM
	MHrDH4PM4U9M13oOCV7JMuh/3B+ppsaA=
X-Gm-Gg: ASbGncteGD5K2bQewcQxJXUPtMt8PLMskmy5p4sEYBm6bYAY6Myx7qNaHC7S357TfQt
	j9hAGc+F7pIrmqtAJuK4Ee85NWHD23toAQBnlEPEhj2IH9WAwCU+xyOSCoa9pbzjR+oX8U1W4Th
	F1SVRjz0X/ZnHRVqfPY0zbZ4KrQb0ZN2KbZt8Jn3rdXYNwGQ==
X-Google-Smtp-Source: AGHT+IGWWQh8EgOU8Ef1D3I8x2++wy4jP5/Q8SxZF1v6kp1G6N+898u98f+dgH2O8LhGvD3gGpWdgpqVD1X3QZp8f3Y=
X-Received: by 2002:a05:6102:5488:b0:4e5:acea:2dec with SMTP id
 ada2fe7eead31-4e7f61b5971mr7608951137.7.1750122433867; Mon, 16 Jun 2025
 18:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615131317.1089541-1-sashal@kernel.org> <871prjvl32.fsf@nvidia.com>
In-Reply-To: <871prjvl32.fsf@nvidia.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 16 Jun 2025 18:07:02 -0700
X-Gm-Features: AX0GCFvSn2m5B1OZPDO5gL24OrE9gJLHj7SYr1oo0WBhymbBpazp_Mlm-ZqC9eI
Message-ID: <CAM_iQpW5m37WH5sKyEHemq8oJLDYWbakWpqGo51bAFpjYyC1wA@mail.gmail.com>
Subject: Re: Patch "net: sch_ets: Add a new Qdisc" has been added to the
 5.4-stable tree
To: Petr Machata <petrm@nvidia.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, petrm@mellanox.com, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:05=E2=80=AFAM Petr Machata <petrm@nvidia.com> wro=
te:
>
>
> Sasha Levin <sashal@kernel.org> writes:
>
> > This is a note to let you know that I've just added the patch titled
> >
> >     net: sch_ets: Add a new Qdisc
> >
> > to the 5.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
> >
> > The filename of the patch is:
> >      net-sch_ets-add-a-new-qdisc.patch
> > and it can be found in the queue-5.4 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree=
,
> > please let <stable@vger.kernel.org> know about it.
>
> Not sure what the motivation is to include a pure added feature to a
> stable tree. But if you truly want the patch, then there were a couple
> follow up fixes over the years. At least the following look like patches
> to code that would be problematic in 5.4.y as well:

I blindly guess it got accidentally pulled into -stable due to Fixes tag?

Could we drop this please?

Thanks for catching this!

