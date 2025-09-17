Return-Path: <stable+bounces-180459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C85B822C0
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 00:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFEB4A3BE2
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6019830F954;
	Wed, 17 Sep 2025 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo40RZj8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20930F54C
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148722; cv=none; b=AWE3vQX2c2INSsIKRSzMCNRFq6eQ3KzYBGNzHAFlUQ9kPT4tyjIYg8Nq9Rh2jiOybwWaxV4z8vBjpnWRWRjCNohK/YdBFyyyjZ/FEWxbsINQ69MqCE7HlB+bvevwx4pcsCAuzSRGeBicPQRoSVn99pmu+cKosgIN+0Y1t1WUeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148722; c=relaxed/simple;
	bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qteIHMYPEbtQBs8BZugeX0XPmCgzOdmro8Hx3wxWxDduqwpZ9Xb8YGirTM9WX7Ra8/OyOuAoURqgJo3eE+SAl4mJnE6R3nMHRN/uN80WGMuMOhnCeWGJYL4VaiWpQPdEzzxVD914WpeFxzRj8A4Y2WKkOxLUPgW0DqWYPgGVh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo40RZj8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f7bcde405so445356a12.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758148719; x=1758753519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
        b=Jo40RZj8Y+fSh8WxQwb4kkcp03yvJIUpOWA9cdy7FWTd6uFBhU1hZS90MJGxe9XEoc
         yAOJ547sKIMtJgLajvQ1VkSS9XqPlLkkbrg7/U4iSkFFJ8vW1tK91wcUTyfwsjTGqHZl
         7/4pbwhK/iReSUvORozQL71GgfoNSOm7T9+8hK5vYa0Fj9SsyWmlVhb60xVUH9209Zu6
         Mb6ka2sT1xRD7SquiptIIRE5CHOYNWld0RMeEG8EPN8whZU7Ob7Xd8R7/ibvDS2cCR1z
         UpeQBYc/XWZuiNOp9viNOYHbFLLoe/sPmIfsrhLrIWTob0MfH3E9+S4LgcKZcapAq6Tj
         twRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148719; x=1758753519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
        b=G8oS1tJlEyU8QS8etP5KR2ljhSwlM8LXhPu4pW8UvShW0yD2I2AuQRLL4HVTqxQWn8
         NvvoXOhQLvlM/3M2oVGaC7SiYyDzeqr8SwIS9atz+vSAdwJvSAGIotGqk00I6DMIr+M6
         iRwdkgTPPaIUJ2ggutYf3KQ0QnJi4Frk3Z/ZWR+ipvaIMOBmncfe1T/ZGCokiGPkFYPC
         5GELfBJXZzvdKkXmW4YEchptJFviqUsVlQa5FNZWRFDNPuOh36oIJNLZcLskHHL7pwHH
         RlrXT0VoskA+Cif1YOV6MJ1PCKxMu+PKEG7miCJWVe7MK0YQXkSiMS8tO+7RGZETU8DX
         og/A==
X-Forwarded-Encrypted: i=1; AJvYcCX29YvobFmhXHYAiZ7QzKHVFEqHG3/pmUFtBGdPVO4wADkT+7U2E3n/Z05RvoMPaNT2GH0px/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaCCoz0OSj1g7OuKCtcqWB8tCMkURsrQcOb8mZTY3peX4FuEa
	3upM1R7q3m4mwmKg16ERoY9QU3OK30RicwUvbh+/cFU/OuO1S7snbMHlQwq86L1oPCsFN/3l0TT
	r3jO4ECnI49AfmOsAIT3tMM6SX+Ej2Ss=
X-Gm-Gg: ASbGnctYxeEuF704eeQN+TRbLEbWmWvCKNAGb6+Dh8ApQQTGuMHkyFdQSKqEizH2ep8
	mxTrq3nDBAtuv6sLwxtGjGSrNjlmw07VmGBmIepvFahaDKFF+aP4Plb7hqEVpm/B+NCKT0GdQjH
	4SgP5kFNdksY3D2QbVw2ObLrFsoIcxtX8dAXn7UbVfmTJh9Na6zK296/AKYlENGu7k7LJDxWLiz
	YYKVkXDVy0jLXFK0Y92axPVIq5iori6Voem84l2hx2b2akoOlyGgcaPdA==
X-Google-Smtp-Source: AGHT+IEfSJAKNHpWgZVUf8o+j/Jls/Qpg0S3h5SUv32JXiLjp2fei3IxBHlxD5hh5CStRz/jkhZR5P7q7aYPIS20EDs=
X-Received: by 2002:a17:907:7b8d:b0:b04:3623:a9fc with SMTP id
 a640c23a62f3a-b1bbd3a68ffmr460226666b.30.1758148718744; Wed, 17 Sep 2025
 15:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
 <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com> <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
In-Reply-To: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 00:38:25 +0200
X-Gm-Features: AS18NWA4pOwDUosllJlj4H9gooia92TA6PwJgeXuzaDepx3vHsHzDeL6mCXiLr0
Message-ID: <CAGudoHF8pKE3ODqY-WnbV=ZpjC9hH+U+COq_KE=aH7mEW8fsKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:34=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.=
org> wrote:
> >
> > One ordering thing that sticks out to me is
> (ordering can't help here since we'll rapidly be flapping between
> ovflist in use and inactive... right)

a sequence counter around shenanigans will sort it out, but I don't
know if it is worth it and don't really want to investigate myself.

