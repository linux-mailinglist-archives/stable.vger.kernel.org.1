Return-Path: <stable+bounces-112176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88746A274C8
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C83162523
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D712139D7;
	Tue,  4 Feb 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTRjoPse"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5A2139B6
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680472; cv=none; b=DNmNCPwhnyQNTyRpEnUqXwHQMpsorDpphO+ToNId45GrVmWaEVl6DlQr87gNcU2Q2SpDOmeKQNbkd9lVHMMSrcSj3bu9qqllj2WOit5WU4g2KeDPZ/elIU4T4TfRgrgyHKxPy/4t9MWdI9yLhukDkHsbzqgzKEu2CFCXVkwISwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680472; c=relaxed/simple;
	bh=oE4QU3PPtsAJQ4G2P1RTlCw8H+CMDJW6wqA0hhTxZUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liv0l3g9fHjhmZzDLDjAbHi5uBgW5OrkbyFZXqKfj5kbb3+7tZq076rl05re2YivGxiuTWymJO2ixmV7bNlad1OFKvM6sOnygyJrswENDb3Xp/uxEsG/weh3yfZyiFz6bVwfXL4ia6XBdM9f8QynxUSqPoKqTZzW7QBIe6PUzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTRjoPse; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dcd43726ecso1595a12.1
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738680468; x=1739285268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE4QU3PPtsAJQ4G2P1RTlCw8H+CMDJW6wqA0hhTxZUg=;
        b=sTRjoPseG9HrykGS74MsmqQI99cQte3pIhv/HNb7cNIjxKd0KqDiL5gFuzHJzHnEI4
         0KP0rfTILp/pvcyGrWRegWUZCBnFU71aJUgpTehMw6bvuP0bC2dhWVHiMit7E+v6uyvl
         sTgLzUrvYruIIGZRmFVgd/DAE/9li1I2OW0QhZJDxPgdAWWJqBxOq8fK9ufJxfnI0KTB
         7KabTtP7btjPdCxMJ7TphC2Cu+Q24vU6T2FBQGne2Ai5CJbCmYOpeNTNZsRyjpbFfzxc
         THxNib3XtCK++gUQA2puc/CL/uk4WUbsl6NrJyBJASkw+h8EvsN+wiumdU9auSSVAmfa
         bQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680468; x=1739285268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE4QU3PPtsAJQ4G2P1RTlCw8H+CMDJW6wqA0hhTxZUg=;
        b=UqxJdJBM5lmyiLI50vc1tcehMuj3bo+dE/5Tn6Sr1JEfz1CdI2SzF0dMsl3JOVYPto
         AF/noX7j9/PvX8zt/lZuqjV3GfcA4SIqFOFmN7S2Cq6NikcDZ3QDVtApeOVUM3yrlD11
         JcCPlOu4dea5mXXXICVe296rYuMdO7LYybDa3c0za44qVfhv3Lfyns611Q0BFa4KVLeh
         FHyxRezYkp/NElBD3EOxW8jEL7HhBAXa7CAMyw6sWNGLIbO8NWkNb5EzyL6aP43+Q/mU
         w0ftLlGNjUdhQEt3OQ1ydIcp0iJag3UClIAoQVcF6sHOnTmuyRQvAZCSTv7ED3ldYlEY
         jT/A==
X-Forwarded-Encrypted: i=1; AJvYcCUxSmtY60v+GJGHl10gFS8Tw7qMVNAV5UcMks/jaikM4pjh3e0qlljsGtU++31igou1aWi7Jpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTkuTWL0L0ZZsWglQy1n+O6fdFXZWZi9n4cKe/6t61Yhw0LI/
	+Vs+gSPIVtv0dZhDD12p60KSQeoK74XxBzFepLxKLqGS4o9U+S21BBZkRQVpxlHf/0ie2FBro7Z
	xqoNwIOr8AmrFOY7ayI94m1n6QMQB9CqXMoRz
X-Gm-Gg: ASbGncvn/9pfSKXrWf3NX4NixUgtxiMzFRtMFfSY6ZN3kyIRSJv9hPDj+PPx4o5LrkK
	Q1QXMbOt327M4xgnVIEav7pgLc4TCECtR3Db8FqlzdgEcBzIjy7kMpqVPkMa5hcQZf7f7ZUGtY+
	GNGjTAtYGMJp7myUb5WXdIAmmW
X-Google-Smtp-Source: AGHT+IHpUVbkwPej9K+Dlnsjsfxe5J6A8lGTV4hhIFKe9AxZm0DQVeZZQF0YTYdrn4VQ2w9nMXN2sTyauiQxpeIsE0s=
X-Received: by 2002:a50:ab55:0:b0:5db:689c:cab9 with SMTP id
 4fb4d7f45d1cf-5dcc25411bdmr105621a12.6.1738680468027; Tue, 04 Feb 2025
 06:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
In-Reply-To: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 4 Feb 2025 15:47:11 +0100
X-Gm-Features: AWEUYZl6Qivkx551CaKDtXrd_BRbJ72ewinSBW6Wih4vXJvTWtkxDxYDRb1ACy8
Message-ID: <CAG48ez0y=ZwotbWDSR4kG4RJjV8+_VJ-LHbfAEDRKT5kZm3yvQ@mail.gmail.com>
Subject: Re: [PATCH] pidfs: improve ioctl handling
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luca Boccassi <luca.boccassi@gmail.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:51=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Pidfs supports extensible and non-extensible ioctls. The extensible
> ioctls need to check for the ioctl number itself not just the ioctl
> command otherwise both backward- and forward compatibility are broken.
>
> The pidfs ioctl handler also needs to look at the type of the ioctl
> command to guard against cases where "[...] a daemon receives some
> random file descriptor from a (potentially less privileged) client and
> expects the FD to be of some specific type, it might call ioctl() on
> this FD with some type-specific command and expect the call to fail if
> the FD is of the wrong type; but due to the missing type check, the
> kernel instead performs some action that userspace didn't expect."
> (cf. [1]]

Thanks, this looks good to me.

