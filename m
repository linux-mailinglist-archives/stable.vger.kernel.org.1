Return-Path: <stable+bounces-115140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B3A340B2
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAB03A8F96
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7B23A9BA;
	Thu, 13 Feb 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVkiUUXS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BF23A9A7;
	Thu, 13 Feb 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454350; cv=none; b=Z3BSxt8iFgLmqIKvFyp3soxVfcqp+reTnK4NY6/DJ+80WIXe76PETcCQENJXfQ7+63Ob9K0JJ01FjhP/5vTrjVmcYmyaSnvNhT8AKToFUzrBslCKAXEA9h7Vlwdqh4VCTG3GMJ4Dow5S1aa93YHHXJDWIaCzRt6+uVf5Ye8ibYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454350; c=relaxed/simple;
	bh=GSbac0XMGlGpq3LK4pbKLskyjw5oUq3AyoRnGYD0RgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7iEf3bG2xp0sMvWSTip9dwAvQm+W2RRGJNrYMZISbXAOzoBwjbRGQ4aUdSIGGWWW2DOyJXFAeavM61SZKgttSrnIJM20l/RUKNXFt4Mr6FXLMAXoa44SLQ6QQbvoPXJazYOUdG2FUn4UDy+sWgUGNq9Zh8eocqpOWVEtlsxwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVkiUUXS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72707750de0so27709a34.3;
        Thu, 13 Feb 2025 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739454348; x=1740059148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gQOE+5IhCQGEcBG+5exSEJRqbSS6WLMWBkfFhzqs0I=;
        b=dVkiUUXS4pQGpAbBaTeTfWXomFIQvfGbfDYOUOzQuUeYyYU31m1ATYJuDI9KgMUaxs
         m4Ary39dwXMprdj3XO6AE6rlauF9fKUmGPLlTzi6rYO7UbrJx2jUqNpaC+dTghSO3Hz6
         jWTay2uVSFImT50ZVsvdQJ5rQDfecqQ86U5qXt69wEky8SIvJE21HyllNAB5/tlpddp6
         ATfUG3JPUnHowEbAXCIc0G/7Q71OVjJ48nCxD5m6Z7EBNUzb/cpltOX6GAobwVxrWgDc
         KRKdIEpag6IiW7nYy/A9T7Ub/pKqKf+h1R960oCJ/vDGGCxkxaOfChSjiS6I6FX1O8sx
         4SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454348; x=1740059148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gQOE+5IhCQGEcBG+5exSEJRqbSS6WLMWBkfFhzqs0I=;
        b=CXxjWevSsSwBR6NDLB1cRtxShyzin/DF/3T0Di1v9oOK7lWtd7RN7Qjut/oDRONDty
         TbOK8jP/eAWRlHE54p4t8OfTNrCWHTBK/9w0+ETSsYdvVF2lizaUAhwbHKQsPASnud5k
         4Ny0BvP1PFJS63TBsvSUA3bfu1Obb35UVxndP0scWF26XhzAyJiYxr/iRveyhLBCI8XV
         JKDdXXCAJpknqZ/yEhLkdTIL8F+wq8EcdLl3YJ3++fGzf0xh36tw3aaOf7Pp/uknpeb8
         bwGNWUvRkp6B+0qYhDhxvoE5g2xj1Qgb1KF/Zhx4YlnXIc8KQK1TWqCO8x4feH7A9+S/
         3KuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4JdBsnLCRG3IOaPkSYRQcVYBD3v18heax1CKGakOJQHBlqvLRpJi8FEgQMJajXQvRlaQOdl3QeGJu@vger.kernel.org, AJvYcCVb9D+lRU0WM8CUAVaTvvq4XcpwamZZrUoV5PC+AwiCqA1NYblT8B3jevp8/RAmrtXwYZ6gljoJ@vger.kernel.org, AJvYcCXpktpc4RKPQjSFXc38B2LglAq5pUdKy2xG8lHP4zkZcBHKUuBWqHNcqqfRh0lTuhveZS/e1080CQxr02U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvdqNwLmmdGIdRLPYAkdHaOITls4lzkF8AeyO033XKO4Qq+62
	40F0uxv82W4oJCdxcKaLNkauwyj+5TQxNFL+MtIQ6ePrQ2jRfMY5zUmgmg1Szp2Czr/ugajlTwc
	KYwDDRidn8ly0peRMHLz+TtG5rk0=
X-Gm-Gg: ASbGnctt7lYvGnwy77uAThdyS06dY1Ej6AWCSDGWwB7JgAIzN0jIUZmlR//yCa+9Ggj
	BWuNLvyVLPUTcXk7fbsSivVXPMiZg+HmTQlacUrztimjbQ1OXp66eG/312Xew1IfezoXqHA96
X-Google-Smtp-Source: AGHT+IFBfX/ztdybMLcS3wSj+Xa+3ijqwcBNNhBdZ0A6tha8fsOV0Z5urFhL/q4CRZobnikCvYpy14N+IWxcPFf5OHo=
X-Received: by 2002:a05:6870:82a4:b0:29e:255e:9551 with SMTP id
 586e51a60fabf-2b8f8ab7afcmr1808374fac.2.1739454347668; Thu, 13 Feb 2025
 05:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209071752.69530-1-joswang1221@gmail.com> <5d504702-270f-4227-afd6-a41814c905e3@google.com>
 <CAPTae5+Z3UcDcdFcn=Ref5aQSUEEyz-yVbRqoPJ1LogP4MzJdg@mail.gmail.com>
 <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
 <CAPTae5J5WCD6JmEE2tsgfJDzW9FRusiTXreTdY79MBs4AL6ZHg@mail.gmail.com> <2025021323-surviving-straddle-1f68@gregkh>
In-Reply-To: <2025021323-surviving-straddle-1f68@gregkh>
From: Jos Wang <joswang1221@gmail.com>
Date: Thu, 13 Feb 2025 21:45:36 +0800
X-Gm-Features: AWEUYZmoFdU52uY9i37E7NZRnAW69SIroh2dDb4IJ8WBYjnXmS0bZLH8p7pupD0
Message-ID: <CAMtoTm3+0X46e0yO5zne_wxjjDMZGyPfGBUqieDGc6-hWef5_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap
 enters ERROR_RECOVERY
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>, Amit Sunil Dhamne <amitsd@google.com>, 
	heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Feb 12, 2025 at 11:16:35PM -0800, Badhri Jagan Sridharan wrote:
> > On Tue, Feb 11, 2025 at 5:50=E2=80=AFAM Jos Wang <joswang1221@gmail.com=
> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 7:51=E2=80=AFAM Badhri Jagan Sridharan
> > > <badhri@google.com> wrote:
> > > >
> > > > On Mon, Feb 10, 2025 at 3:02=E2=80=AFPM Amit Sunil Dhamne <amitsd@g=
oogle.com> wrote:
> > > > >
> > > > >
> > > > > On 2/8/25 11:17 PM, joswang wrote:
> > > > > > From: Jos Wang <joswang@lenovo.com>
> > > > nit: From https://elixir.bootlin.com/linux/v6.13.1/source/Documenta=
tion/process/submitting-patches.rst#L619
> > > >
> > > >   - A ``from`` line specifying the patch author, followed by an emp=
ty
> > > >     line (only needed if the person sending the patch is not the au=
thor).
> > > >
> > > > Given that you are the author, wondering why do you have an explici=
t "From:" ?
> > > >
> > > Hello, thank you for your help in reviewing the code.
> > > My company email address is joswang@lenovo.com, and my personal gmail
> > > email address is joswang1221@gmail.com, which is used to send patches=
.
> > > Do you suggest deleting the "From:" line?
> > > I am considering deleting the "From:" line, whether the author and
> > > Signed-off-by in the patch need to be changed to
> > > "joswang1221@gmail.com".
> >
> > Yes, changing signed-off to joswang1221@gmail.com will remove the need
> > for "From:".
> > Go ahead with it if it makes sense on your side.
>
> No, what was done here originally is correct, please do not ask people
> to not actually follow the correct procedure.
>
> Jos, thank you, there is nothing wrong with the way you sent this.
>
> thanks,
>
> greg k-h

Thanks=EF=BC=8CI will submit the v2 version patch soon.

Thanks,

Jos

