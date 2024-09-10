Return-Path: <stable+bounces-75630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC97973700
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E931C21611
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11F18E77F;
	Tue, 10 Sep 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV7+5Wif"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371618A6AA;
	Tue, 10 Sep 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970734; cv=none; b=ESOiS58h6gOAxcVGgBGJWtdaDS0ujrkUheWf1HF6VTtNZWOpThJvG1NSCiD2ngGH1QLaE57A8PefgAyT+x60yzJenn+TfDM9OibFbf/rYRqPgVAH+Y38IZhoky477rC8DyeQd095unj5gPv7nEXXpU5aYkCBvB724LEzogPmQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970734; c=relaxed/simple;
	bh=hvg28RGaogIMmIPDjmKkIM35Mo3dgzbyvb4yAgud9C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6ivBfiBbLUqrBbpBthLGoTqpsmctoE665IWeVZjGZ84ZRdZpeEPRiwFOwZhEcOr5ONhznG3YrlgwqMdYHZpMUYDlxErYr3dK5NeVt+6GTReNQ0pKHJq1ptzJCy0bpZ41odgBDs0PO41QmTbRlfsvZDdTBf7cfPkv/eaeTGvFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV7+5Wif; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4441708a12.2;
        Tue, 10 Sep 2024 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725970732; x=1726575532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPvvRryr0vgpHkg1cRcRCsWDsYNvGIowHyQK6GkDpME=;
        b=DV7+5WifxtK452vIMUKJYlyuVcNJk+mFsJlU7fsdDAx8ig6CvyTU9eHtWv25bxJXcM
         LfKcxkU0lIvKpX7zLBh7nNvOVcBw16oWWp2gDDii/EaY3a80JoqG9YE/C6VxpjJwCBXX
         Rz5+5kVPIHzE4W1m8HaHutZhoFs2dN9qehIxKo9QkgLzlyGgvPKbTwTsIPAPitYEHPlL
         v+4Ue0tOKYiP2fx94VyNJesIizQNh8jw2K+iE7VxxJ4qiOPpjjqc6bS2tagpc3xBN4OH
         hHFdTC9d8fDpwSxajtFaIFKiwKqSAyh31m34LclKvO8x9FT5Fd2q4mBbaXrKgbvy/vt+
         sulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725970732; x=1726575532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPvvRryr0vgpHkg1cRcRCsWDsYNvGIowHyQK6GkDpME=;
        b=tik/5tB9W9lLhJ+BGKBNSM/2b4uS+2ltZBH+TSea3fhq6DaMUmMtKLCtERJ2mFoHuU
         vR97sU15jkZhvuvL6es1eZKI4Vqd23KXpRDQhmoPLfMpWbZQXVcbwpneI4LWNiBe8mhQ
         wGoAkxhL+wf3ojjeWfhn0kB8EcrFwrabt1GCPjb1JjLRAdDPR2YyswoXBH8/NO2vv+s+
         1ZIz4p3+7v5dPigi8q2OyHDk6woEv69xuyYvbce7wqbImcmbJ+jiEZa/0aqKmw3AWenN
         UlcRaGUwW2zylnJzo5uRzEbAliBrhCqSkJh6NV+gevcMOm6oTnD9dLdCUJgqcbwklt3f
         TbMA==
X-Forwarded-Encrypted: i=1; AJvYcCUArl73QWmvKSbuFuG5UMFAMKlqdlUg+OQpHYoQyFvFJhLbQi0KY8DVZmnJfk+T18UEqkxvYawByaRADYlu@vger.kernel.org, AJvYcCUGDWiFokMYYDEToj9ExTBtSErWp/IxkRgxy5hq8t4/+JHh5wnka8D1hYO1Hl27yfPysC6+8TQh@vger.kernel.org, AJvYcCWk0yxEe7neAZWeg7OV5utJYneAjPPQQZYWgEvv6YIRBPWK5ocowYAb6Y93eS4EeJ0JrNijAFiXDNRVfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4//KwxPZ1dy3ZFdOm7cbcRt184Qii6JLwRrtWmeqRTphmFXs
	jgWXEZX1gGKvF6rItfCPOnbQoV0VYAlw7DeLXB7CF3JGCIGMOrLYkj2oW3QxSxsXNPSMJzXZYS8
	7Iq2GYasJx1jVnJw6PR8siRSeZDs=
X-Google-Smtp-Source: AGHT+IEqnPdqGPGDHSqJ9shohkQQvK+iGfhG5oaAvU7FW7rygKnMjlmBmhrY9M9Ct4hLeZ0hd+LUouxLfQHVHh0lF2g=
X-Received: by 2002:a05:6a20:cf8c:b0:1cf:3a0a:ae45 with SMTP id
 adf61e73a8af0-1cf5e156d0fmr992068637.35.1725970731916; Tue, 10 Sep 2024
 05:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910020919.5757-1-jandryuk@gmail.com> <Zt_zvt3VXwim_DwS@macbook.local>
 <ad9e19af-fabd-4ce0-a9ac-741149f9aab3@suse.de> <Zt__jTESjI7P7Vkj@macbook.local>
 <2024091033-copilot-autistic-926a@gregkh>
In-Reply-To: <2024091033-copilot-autistic-926a@gregkh>
From: Arthur Borsboom <arthurborsboom@gmail.com>
Date: Tue, 10 Sep 2024 14:18:35 +0200
Message-ID: <CALUcmUn30tPxjToysLBVBmibMaQUWW=GqFoqduP-W5QwQ-VriQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jason Andryuk <jandryuk@gmail.com>, Helge Deller <deller@gmx.de>, 
	Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, xen-devel@lists.xenproject.org, 
	Jason Andryuk <jason.andryuk@amd.com>, stable@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sept 2024 at 10:33, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 10, 2024 at 10:13:01AM +0200, Roger Pau Monn=C3=A9 wrote:
> > On Tue, Sep 10, 2024 at 09:29:30AM +0200, Thomas Zimmermann wrote:
> > > Hi
> > >
> > > Am 10.09.24 um 09:22 schrieb Roger Pau Monn=C3=A9:
> > > > On Mon, Sep 09, 2024 at 10:09:16PM -0400, Jason Andryuk wrote:
> > > > > From: Jason Andryuk <jason.andryuk@amd.com>
> > > > >
> > > > > Probing xen-fbfront faults in video_is_primary_device().  The pas=
sed-in
> > > > > struct device is NULL since xen-fbfront doesn't assign it and the
> > > > > memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
> > > > >
> > > > > This was exposed by the conversion of fb_is_primary_device() to
> > > > > video_is_primary_device() which dropped a NULL check for struct d=
evice.
> > > > >
> > > > > Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video help=
ers")
> > > > > Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > > > Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=3DLkXWeiSiTK=
sDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> > > > > Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > > > CC: stable@vger.kernel.org
> > > > > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> > > > Reviewed-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> > > >
> > > > > ---
> > > > > The other option would be to re-instate the NULL check in
> > > > > video_is_primary_device()
> > > > I do think this is needed, or at least an explanation.  The commit
> > > > message in f178e96de7f0 doesn't mention anything about
> > > > video_is_primary_device() not allowing being passed a NULL device
> > > > (like it was possible with fb_is_primary_device()).
> > > >
> > > > Otherwise callers of video_is_primary_device() would need to be
> > > > adjusted to check for device !=3D NULL.
> > >
> > > The helper expects a non-NULL pointer. We might want to document this=
.
> >
> > A BUG_ON(!dev); might be enough documentation that the function
> > expected a non-NULL dev IMO.
>
> No need for that, don't check for things that will never happen.

And yet, here we are, me reporting a kernel/VM crash due to a thing
that will never happen, see 'Closes' above.

I don't want to suggest BUG_ON is the right approach; I have no idea.
I just want to mention that (!dev) did happen. :-)

