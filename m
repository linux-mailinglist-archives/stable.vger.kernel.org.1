Return-Path: <stable+bounces-17577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DB8457FA
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B596F28EE82
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD008665A;
	Thu,  1 Feb 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Mz/o/p8r"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030202134F
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791442; cv=none; b=Ye21hGP32z30Hln7Fk33kSQ5en9b2TYj+n3imJ6VCM92rR7uBGAkUtLbZPetJH8FSaTv5VyVMPCiFPnSxu9X3K/0pbf0rVJbACCbCgRq5LzyZWWIyJPreJORHW+E5zxBV9A1Xho0OPbPROpkG1y4R6aL1J4pb8/wBfaIRk0BLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791442; c=relaxed/simple;
	bh=dEL0gc6v8FtcF06YHB8recoHi6yic+HuArz4FFcZTwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbO7SgXXF/XMbIyOlGIKdnxMo3A+uDYZRC+UzYXGP4NlmGv2cbd4QsJx3Vz1WE3pvrP7/h8a4nkM1pBAIrFuzrgGafh1cGxaF5IO4xNPcftki5t5FnN8qj9XEBRZE7KHkE9FUUl/R70ZvIe8bYOluE8O7FC+gpkl66BEYpIOnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Mz/o/p8r; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so61020839f.1
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 04:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706791438; x=1707396238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkVTb1L2m6NuCmMShY81C/HsZ5E18+lzrF+Dzoy+HMg=;
        b=Mz/o/p8r0QlOy54ZqOPAUKWTGwP5hR7rTxAQNsCaG/NKl/E7xuFZso34JNWvux85Bn
         qbh1r7b2ITRjxh4L3lgZvJCG2G/s8JuUjCIGQqCvAMS7AvtY9kbbUjrItsChkM9WZBTN
         dZOzPJL8laZxNfD5dxlBXcTbFR45tsvq3xm0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791438; x=1707396238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkVTb1L2m6NuCmMShY81C/HsZ5E18+lzrF+Dzoy+HMg=;
        b=vkHxAwf9WhS4LQuK/pdldgXqI5MPjO7wGaEpbZuGJpAahyiH3HcEE+hnMDZIDHOeDc
         +H/MZ2CHLdQnuWmvY/g8ZWgyCCDd01xfoVigQL3C6eqxuFQasNeH15L8z/fKwYkJiJSj
         o2TWKwae84fJAoSXIKzdThpAz03gj3Dpp1JzCC6wfrIXibKx1kcaZIPh+USnfD8jXr0x
         heAoiqhTo3V6ADsHQFErDRdUVLNJ94gPSeHxrJ7uZyfKWknV/XW7n/U4wm3U4Egmq2tg
         t/CHVFzaK8AWWeUKrxSbb7tJ0mbQhDYjGH5tuSxCsmUf6pjjGl0Hc3W8RSM1tgETkwiT
         5+Ng==
X-Gm-Message-State: AOJu0YzOppbe8Auf0ppRC/Q+goYpIiTZl4LCCBNqWNxZmBHNK4fezd4k
	yTic0oStclmxy0VQhH+xyOl2jd157Q30GT+qP7WT1GYStxWFruWEy8W+WzyXL5xHtKTg0Nfu7Pn
	bvg==
X-Google-Smtp-Source: AGHT+IG8HrY/5043BY/AWblc7Gx9K+wnEwvlwuGA8omOj7wge5pP/B8qHFa9jR52wRQewc/GZ0ZemQ==
X-Received: by 2002:a05:6e02:1aaf:b0:35f:f880:10ec with SMTP id l15-20020a056e021aaf00b0035ff88010ecmr5212836ilv.4.1706791438493;
        Thu, 01 Feb 2024 04:43:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7rVOVaoK4eQsbqF451lJWfBJwx+w3hQ2Y8C5cMLxEP5GNFaTM/CX7WH4qe6ppNxgxtACQSmsO8Lp8o1cK7thwzpEok6En
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id f11-20020a056e0212ab00b00363a88d6ca5sm52057ilr.30.2024.02.01.04.43.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:43:58 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-363898391beso2157775ab.1
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 04:43:58 -0800 (PST)
X-Received: by 2002:a92:4a12:0:b0:363:7f58:ceaa with SMTP id
 m18-20020a924a12000000b003637f58ceaamr3070531ilf.10.1706791437923; Thu, 01
 Feb 2024 04:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170014.969142961@linuxfoundation.org> <20240129170015.067909940@linuxfoundation.org>
 <ZbkfGst991YHqJHK@fedora64.linuxtx.org> <87h6iudc7j.fsf@meer.lwn.net>
In-Reply-To: <87h6iudc7j.fsf@meer.lwn.net>
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Thu, 1 Feb 2024 06:43:46 -0600
X-Gmail-Original-Message-ID: <CAFbkSA2tft--ejgJ58o3G-OxNqnm-C6fK4-kXThsN92NYF8V0A@mail.gmail.com>
Message-ID: <CAFbkSA2tft--ejgJ58o3G-OxNqnm-C6fK4-kXThsN92NYF8V0A@mail.gmail.com>
Subject: Re: [PATCH 6.6 003/331] docs: kernel_feat.py: fix potential command injection
To: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:21=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Justin Forbes <jforbes@fedoraproject.org> writes:
>
> > On Mon, Jan 29, 2024 at 09:01:07AM -0800, Greg Kroah-Hartman wrote:
> >> 6.6-stable review patch.  If anyone has any objections, please let me =
know.
> >>
> >> ------------------
> >>
> >> From: Vegard Nossum <vegard.nossum@oracle.com>
> >>
> >> [ Upstream commit c48a7c44a1d02516309015b6134c9bb982e17008 ]
> >>
> >> The kernel-feat directive passes its argument straight to the shell.
> >> This is unfortunate and unnecessary.
> >>
> >> Let's always use paths relative to $srctree/Documentation/ and use
> >> subprocess.check_call() instead of subprocess.Popen(shell=3DTrue).
> >>
> >> This also makes the code shorter.
> >>
> >> This is analogous to commit 3231dd586277 ("docs: kernel_abi.py: fix
> >> command injection") where we did exactly the same thing for
> >> kernel_abi.py, somehow I completely missed this one.
> >>
> >> Link: https://fosstodon.org/@jani/111676532203641247
> >> Reported-by: Jani Nikula <jani.nikula@intel.com>
> >> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> >> Link: https://lore.kernel.org/r/20240110174758.3680506-1-vegard.nossum=
@oracle.com
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > This patch seems to be missing something. In 6.6.15-rc1 I get a doc
> > build failure with:
> >
> > /builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc=
1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kerneldoc.py:133: Synta=
xWarning: invalid escape sequence '\.'
> >   line_regex =3D re.compile("^\.\. LINENO ([0-9]+)$")
>
> Ah ... you're missing 86a0adc029d3 (Documentation/sphinx: fix Python
> string escapes).  That is not a problem with this patch, though; I would
> expect you to get the same error (with Python 3.12) without.

Well, it appears that 6.6.15 shipped anyway, with this patch included,
but not with 86a0adc029d3.  If anyone else builds docs, this thread
should at least show them the fix.  Perhaps we can get the missing
patch into 6.6.16?

Jusitn

> Thanks,
>
> jon
>

