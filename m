Return-Path: <stable+bounces-111959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F638A24D57
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E697A19C7
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F531D54F2;
	Sun,  2 Feb 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBxM4cah"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCA17580;
	Sun,  2 Feb 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738489454; cv=none; b=QuRfWRFNcKNFKfsOclKAqtYOruhzbLhvd2KOzRRWXLzoCixtbhrE/BmZQ7l//qCYfkNEOu7goCwvpe4XXUkSzkRtcd0Y6hn7OxpJ2PnTQfIV7Vd6tq5zbMEsWSCZX/E/IzpgQ8B6+grfds5LsrybW094sgKs25yEbD7zp9B4uHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738489454; c=relaxed/simple;
	bh=phTz817HIJFDlVQMxotl+fC1ygoVGjm+Cl6fWK6evsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VB+H3ruIow4vrQhTFy4isaW+Oklz5xKeWVgTBfFLM8+lY9ovKR+xs7Nw7skcelDGwSUWEKHKcD6jnwQXkVc7S7BTMxIzsJlE+wBU29zMJxARMKPY5gSqwp93dY6XYxf4VWVNgaNyanGKEXm8+i0lvYUicxkfQOUlYE4/hdrT5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBxM4cah; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso8384078a12.0;
        Sun, 02 Feb 2025 01:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738489451; x=1739094251; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdhVL6OAiuXkzODg3j/ldO0Z/8xWE8YWbcHrQvSsto4=;
        b=PBxM4cahYTHccgIvfVqRGFwj6qss+Nm+0G17jOi6Q+GhP1YMB0TV+K5P6+R4/oBsQ7
         OhUceaQmMZAl7fUvI2Kg/DJsGkY0icYw6byoXj4oYHh6QEEa15rjPw3ih8MbAMdISnA5
         3pShiDSDch4lateMT02s18BJHsymlcxr0UCU/dED9DRqDgHwcJji3C+gTb+uMVljr7rX
         0w7rdKdLD1u0OcEN/OlhQi4zEEzVY+r9Epo/Iv/XRcIkoxgAzEk4GR2jdcIfhm0lsWBk
         1yrm26i+rfrQe2D5nRKf2W/JGAleCNlvuRewnqy4xyw1b4wXMKWrsG7MA+qhKSKLPBA0
         dIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738489451; x=1739094251;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdhVL6OAiuXkzODg3j/ldO0Z/8xWE8YWbcHrQvSsto4=;
        b=tC90v6H4JIu7AgHwWOWDqVi+u/X3Kl+lgMOzBt0sARKnVwjb+7EQGFVpMqxaFqO+XW
         G6Zmj3b9sXBya+J3CHsmQmZBo4qpbLSQ9gZ6FJAQ6Vhb7UH5NkqUkFXtSXC4asUJq3Z9
         zlvkQGeqVtQ78CgwtzW/ueNdwZyHM/PIN5wy3bxJCU/mTxquSdeCfsY/EwO4I0XQivgF
         vf+PaU5ABDNV4SucTBg0NSmWbEO4H6xAcZJ+wUe7j2BB1kaDVQYLbm5UrtxztP5sRxoE
         vfcKnUOimnA9IZiSc+YpU2Uh7joYN1kDMfVPeTkie6itHRv+81yTN+sK4OOWVK8WMM/+
         cDww==
X-Forwarded-Encrypted: i=1; AJvYcCUtYBvnRxv+K7reQ8RKY+s3uYjIv0LQ78ZGMVHLbPoicGZesqXUfm8WhmBpKk/oKPYcOf7rvqEHybrDqtv0@vger.kernel.org, AJvYcCV9X0zd9If7gtWFBVewl2SMZw4oWM4OE1opqUPKMCGk3HijQ5kaYxK8KQclznwAvNE0BW75W9NMz/x8Xw==@vger.kernel.org, AJvYcCVuAtDE+Cz/4NMI0kpEqMlqvOEafYng9gazJFyf4HILPDC6vyUqo+tpVXtjiFgI/3rtXWgMUaLS@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVOPd7DFhUf+I+YxqyOw+kZ5wTmcCHQ9TlzMX9lk+JuemXuyc
	A4nfg0jMMfGuFIdxD+zmhk1R5rfeaIU1L5IuvoyrTDQPZ1U3zEMWQ0CvrkZoNh53PuqfLBKJgJ3
	RBcRM3zkQaTL+6NkuUbGHmKKZdE4=
X-Gm-Gg: ASbGnctkXQnMHgQEwX7aWGCaN26Qg+K4stTwzRZP7+rMiltwokJ0jq065pCM8sOikQe
	zkcHK9oHxkihqB10xBIpOf1MFAhgsMKtBpVVtba4zoCcQUaJUgfhMwEjXDpbJJ5CQiQJ5GBPaBw
	==
X-Google-Smtp-Source: AGHT+IHNbGgo8vKUq54BhAMWJKgRdhTRrOwX7rnSY2Wa3qoKnk7FPQerC1qmn+llgOv5xMAbbdaWb/pC7FCjWl+rH2s=
X-Received: by 2002:a05:6402:2706:b0:5d4:1c66:d783 with SMTP id
 4fb4d7f45d1cf-5dc6f3bc813mr15751885a12.0.1738489450963; Sun, 02 Feb 2025
 01:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131104129.11052-1-ink@unseen.parts> <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
 <Z56qWp9GGuewJr1K@creeky>
In-Reply-To: <Z56qWp9GGuewJr1K@creeky>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 2 Feb 2025 10:43:59 +0100
X-Gm-Features: AWEUYZlXO60BUra0ObFm51YCCxFxArnZLlfEKc_6tVZCUZhZGiT12UxkACwzdzM
Message-ID: <CA+=Fv5Sd8hwJN5uxoNEB0MttZ-EvkBRJsK9LDp9H-srJaa_y1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] alpha: stack fixes
To: Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Ivan Kokshaysky <ink@unseen.parts>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I've applied the patches to git 6.13.0-09954-g590a41bebc8c and the
system has been running for more than 24 hours without any problems,
I've generated some system load with building kernels and unpacking
large tar.xz files. The patch series seems to have fixed the
rcu-related issues with network interface renaming as well as the
kernel module unload. I'm now also running tests with memory
compaction enabled (CONFIG_COMPACTION). This used to cause seemingly
random segmentation faults when enabled on alpha. So far, memory
compaction seems to work with the patched kernel. With a little luck
the issues seen with memory compaction on alpha were related to stack
alignment problems as well.

In any case, very impressive work with putting together these patches,
this bodes well for the future for linux on alpha!

Regards

Magnus Lindholm

On Sun, Feb 2, 2025 at 12:13=E2=80=AFAM Michael Cree <mcree@orcon.net.nz> w=
rote:
>
> On Sat, Feb 01, 2025 at 10:46:43AM +0100, John Paul Adrian Glaubitz wrote=
:
> > Hi Ivan,
> >
> > On Fri, 2025-01-31 at 11:41 +0100, Ivan Kokshaysky wrote:
> > > This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> > > Thanks to Magnus Lindholm for identifying that remarkably longstandin=
g
> > > bug.
> > >
> >
> > Thanks, I'm testing the v2 series of the patches now.
> >
> > Adrian
>
> I've been running the patches on the 6.12.11 kernel for over 24 hours
> now.  Going very well and, in particular, I would like to note that:
>
> The thread-test in the pixman package which has been failing for over
> year 10 years on real Alpha hardware now passes!
>
> I have now successfully built guile-3.0 with threading support!
> Previously guile would lock up on Alpha if threading support was
> enabled.
>
> So there are some very long-standing bugs seen in user space that are
> fixed by this patch series.
>
> Cheers,
> Michael.

