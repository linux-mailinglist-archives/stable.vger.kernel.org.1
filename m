Return-Path: <stable+bounces-36070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B33899A14
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A708284E8A
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4B016131B;
	Fri,  5 Apr 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSY0hE2w"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA215F30B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310955; cv=none; b=QTZVuP8IkyTu5oSp9d61Vz/v0d3tu4UWMJIuIZCYEUd8FJrgsUlao4TLv3ZpwjssJBfHpXb59QEFqfzjesns/ksKmUNBg1Hfca/R3+C8wS+gdYppqo0/DIDtTSv8klyGcnh5ObHJR7SKMYZ2wn8kF3g1ZOonSRzV3a2aICP23fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310955; c=relaxed/simple;
	bh=sKT+5162kddF5rUiOM1e46HqK6J0xo3bZXUCnYfNGFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRRXURzSlFnKc2c8suGIv5501BYhXfwaAlwenU1aXTFstGNNd/BkojRGJK2xGeQL5OaYDeb2Oli9VPQ762rzIq5c4frFLfXitp/OtXPWeoDOdh4bZYbGEIzcy6v3PJu+PX5BYa6Bv2/BH+MvLDu4revghoAX0xDJo0y6UXeWkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSY0hE2w; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69629b4ae2bso12501066d6.3
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712310953; x=1712915753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKT+5162kddF5rUiOM1e46HqK6J0xo3bZXUCnYfNGFY=;
        b=iSY0hE2w0XeycoqIm5oGn416JGoPHfjFX2MlrIBwMeRtcpzsrhRhQYKWKX+x602Ka7
         a/PV0LUB8elg4rOXgQIOecxnDnqctk8FFgQC5+Nw+aQGxjwRCmeAQfZUFrZzEOUUwV46
         n+NOVA1oun/g7xjqgBN8FfiKhymecwau06vBmYkKO+DauxoL2wdPVLyFWvKLkhFunp8T
         Jh8D6B0iepZuYsEqvzVXoBkk3ME7awJXnVBf2qNp6WnUO9dR1l7inQEHbv4Rg/zaoWDq
         3JBB2fhde7uEktoi7QApYx6757ZFmsUgf82hW6MiCAIE2J3TDocQxSmIOoapLC4wK2dr
         AM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712310953; x=1712915753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKT+5162kddF5rUiOM1e46HqK6J0xo3bZXUCnYfNGFY=;
        b=Tn25CWPBkaad2QFYGng59Dx3KCxp2+hWY5pKpkh1c9SxSRIPPYUjC+/GPiOx8LX7vS
         Kqjl4boJdgLIdgw0tZfgz06MkgzTIYY8fleoClzx7fchbxHvxTwJqwjo8tILImXSYgUB
         Gt8aRJpqKH8N8VbmuFF1PNXOpuWxhPkjxkMiwmgdbF0aI4QBmvkywlT6vTLqL1fWULNw
         GRu5SywbPcr1cyIiUAUFQuFQu+VkPhnyOq79i9JTVV1mD4fgQeuMhgpkNwneZZQw6FDZ
         f2IHp2EHPyrCljuMYwm6Vw2+h14z+q2zha8nUnlU5GOtcJxTzdXExeWCi7/+THdKchWy
         btjg==
X-Forwarded-Encrypted: i=1; AJvYcCX2H/VZxIETJQGSHRxZRp3U7S1NrplMnc8f8MpMTTCD9KVVCJYtLap2dTw8Gw6ZlUkAJZ/gMOJCT6kPuv0EqGqMqwdcAx3S
X-Gm-Message-State: AOJu0YwwNWDuatzue593da3BSe/WP4q6qeWozHLXREWh33rzIovuaitt
	isfV2RsBqQ6b1oPKarUv7cyOTbgXs2Bm9gPnHIW0Lr3z+cyhAN8kNN/DBbCF3sRfe9z5yfu+DwA
	x67sp4vOyirfybq325ddGW5aaKh0=
X-Google-Smtp-Source: AGHT+IFdIN8fhlwghNNZCUqMqvfD7m27hy6I7zzP7Rr+Rj0ilaf7BiikBexRbozCS4nooq71WbeZYlm+zfFUKsC1I+c=
X-Received: by 2002:a05:6214:dab:b0:699:2674:929e with SMTP id
 h11-20020a0562140dab00b006992674929emr792971qvh.10.1712310952990; Fri, 05 Apr
 2024 02:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403125949.33676-1-mngyadam@amazon.com> <20240403181834.GA6414@frogsfrogsfrogs>
 <CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
 <lrkyqh6ghcwuq.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com> <2024040512-selected-prognosis-88a0@gregkh>
In-Reply-To: <2024040512-selected-prognosis-88a0@gregkh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Apr 2024 12:55:41 +0300
Message-ID: <CAOQ4uxg32LW0mmH=j9f6yoFOPOAVDaeJ2bLqz=yQ-LJOxWRiBg@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by xfs/179/270/557/606
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, Leah Rumancik <lrumancik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:27=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Apr 04, 2024 at 11:15:25AM +0200, Mahmoud Adam wrote:
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Wed, Apr 3, 2024 at 9:18=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >> To the group: Who's the appropriate person to handle these?
> > >>
> > >> Mahmoud: If the answer to the above is "???" or silence, would you b=
e
> > >> willing to take on stable testing and maintenance?
> >
> > Probably there is an answer now :). But Yes, I'm okay with doing that,
> > Xfstests is already part for our nightly 6.1 testing.

Let's wait for Leah to chime in and then decide.
Leah's test coverage is larger than the tests that Mahmoud ran.

Thanks,
Amir.

