Return-Path: <stable+bounces-35889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF75898113
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 07:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A921C23A7F
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A391208AF;
	Thu,  4 Apr 2024 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i25CJeRQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC153FC2
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209541; cv=none; b=Qc1ORxB/aHNKvw9jEx3dVgPaPy0MBhE6YkiCboit+Im2O+HkFSTOrcBl7jYAAwg3CNkjf4SvvGGAZmGtDwpgX59/tcIZF5HeL7JtWPcvrRsvv0BCfHL6H5vOulIoLilPh8PVFjuSs6pJdQW46NfurkPhzIG4s8/F2Zxod5Pb6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209541; c=relaxed/simple;
	bh=v5h8hqZxiwjVqASRqbRuqc+3bJR43y3g+w1/FQfELEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaKJhEhhM2NrEjGhaYqu8zrt3qcUHOhNb1ivMl5VTtHmP9kmrRo8lKrp7WqgNepn6DqPI6Gxo/QCL+1PaxVBKBx9jkc7zIdSVQOBtEEzAW2WwpSqkxuduz3C99X2d4r5EusNveoqMaX2iUMGDW6x81C7qw0pGmXzb13QxDqI35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i25CJeRQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789e209544eso35958585a.0
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 22:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712209539; x=1712814339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03s9bMBcNjM3dBImbo4P+8VnomglBAt3SfFNVoQlq4E=;
        b=i25CJeRQp1R+0hmEp5bTrhe7+SZ0F2e8LiJOsr9nH6FGbE/ydolBkxAri1MILy2MGm
         Gclt+mpMxrJXWPCnRDieTKZ+TeBFvFE6nRqQRbFuXrpRGi+WCNo2CSzDd5JkPwqHRld6
         05OIcC1XoxxUfxUzaQP60jRwxc8UgFPK8l2bTLO3xEX7xwYn1aUCn6a7DmnXVWpyJLQL
         z7UycbzTfMEERmbOuHaKen81wL58n9pGRitJOhlXNKK9TtOQDYA9MnGla6m5Fw2vo9Vr
         WRuS8ClaZvbZ8jnxhsfrt55Ebx+dGevgfn9SBC6w8cNPPwQ5CdtBvU10IRglcGMAW05z
         3MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712209539; x=1712814339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03s9bMBcNjM3dBImbo4P+8VnomglBAt3SfFNVoQlq4E=;
        b=YtPTk9igyC0Wxyqf5gGGAfubwnfhgBzc3qYRHCp/++rOJADEATQkb1cuPRfAJnJ0Vk
         1T7JqzNTxdrmxsUawIcdVNdNPWhucq0i+89nxiCcVp8s/ZOgpTSaolvwxrqKOxqo5RC6
         JzbQ2Zo1YbAyv/2vTwHgDOruMuRmbi/Arrgbll7liulHDsPMYiVXzzX3MHJmxPsTBan9
         UNAVVR6vZe0dWMZflmrWEfN/si4JCa10ercwUM/uVWFn6JiKXrfLDKohOoy5ruRk6GDd
         WorwVU+g4kX69gP66yqY4AyosgmwfKWOc3qSdRTCf5Wp8PcCCV2qGv01URUr4535t2uu
         LdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu7yM7V2oq7hORC/JMfSmHFnWkDMEyuazU6x84G+8X05sYHnYBMOgJe+YJ0wN73KHOflzlcGHYnffBkK1TZMrgtHe5WGJl
X-Gm-Message-State: AOJu0YzV+Wh5FsW8Uw/u6gL59oJ5O9iFdqA4nB2tQRXP14dq7/xvIbzV
	cm0Ugj+l9ZcVG4k0988q+EwhoNj/WgyjR5elgi/MJfn6m6yA+Um+/EZA2y0oCy1ii1B1ddXz56A
	DWxr1n21BmHZtV5+cvorEkZbr6GEkdGSAw3Q=
X-Google-Smtp-Source: AGHT+IEUEd4pLLFFJudZZYxr6Ph461ZaP3eIH1EDA2fbQDIDund0Fta/JOcGvvTVbNON0j5HsCdxYo4pjaVjL9hSmm8=
X-Received: by 2002:ad4:5aaa:0:b0:696:42f7:142e with SMTP id
 u10-20020ad45aaa000000b0069642f7142emr1966445qvg.47.1712209538934; Wed, 03
 Apr 2024 22:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403125949.33676-1-mngyadam@amazon.com> <20240403181834.GA6414@frogsfrogsfrogs>
In-Reply-To: <20240403181834.GA6414@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Apr 2024 08:45:27 +0300
Message-ID: <CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by xfs/179/270/557/606
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, Leah Rumancik <lrumancik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:18=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Wed, Apr 03, 2024 at 02:59:44PM +0200, Mahmoud Adam wrote:
> > Hi,
> >
> >  These patches fix and reported by xfstests tests xfs/179 xfs/270
> > xfs/557 xfs/606, the patchset were tested to confirm they fix those
> > tests. all are clean picks.
>
> Hi!  Thanks for the backports!
>
> Normally I'd pass these on to the 6.1 XFS maintainer, but I'm not sure
> who's actually taking care of that at the moment.  To find out, I've
> cc'd all the people who have either sent 6.1 backports or made noises
> about doing so.

Leah has claimed that she will take over 6.1.y ;)
Leah, do you have any staged backports for 6.1.y already?
Can easily fire up a test run of these backports?

https://lore.kernel.org/stable/20240403125949.33676-1-mngyadam@amazon.com/

It looks like most of the backports are from 2023 (v6.1..v6.6)
except for patch 4/6 which has been backported to 6.6.y already.

>
> To the group: Who's the appropriate person to handle these?
>
> Mahmoud: If the answer to the above is "???" or silence, would you be
> willing to take on stable testing and maintenance?
>
> Also FYI the normal practice (I think) is to cc linux-xfs, pick up some
> acks, and then resend with the acks and cc'd to stable.
>

Mahmoud,

I assume that you are running xfstests on LTS kernels regularly?
In that case, you should have an established baseline for failing/passing
tests on 6.1.y.
Did you run these backports against all tests to verify no regressions?
If you did - then please include this information (also which xfs configura=
tions
were tested) in the posting of backport candidates to xfs list.

That is effectively the only thing that is required for doing reliable LTS
backport work.

Thanks,
Amir.

