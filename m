Return-Path: <stable+bounces-67386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CA94F89F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 22:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5501F21DB8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145F194AD6;
	Mon, 12 Aug 2024 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/E0+wHk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF0168492
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496027; cv=none; b=k7wlIHdqHIBxvv88P2DVcFh+k5WZ+TDNbG8xY3KlBuv9/aSM5yOkk7birROefE8KPtCf6Rr3B7+G647CwhiJucd6S/zL3O50zYn80xs3TZdAl8afbaoTPmcUdSinw5UcYdGKT8/OJ7vpg4g/JUEkNeUbo6IhlPKNtGDiCXzgfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496027; c=relaxed/simple;
	bh=popiTOAvrARqgESpFaajOWe+yLPWMHUcOMxzZp1+JYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+4b3qDsqgG9p3cjGh0smsXAaSl3j51PiHVRMNANGC2fAowoWZIqae9vEpmA469TNzhXBDdMaGh4+/MeBgW48/iu9gEtaU0Y3xYzldrtDVu7HM6LoQF3CTzBz62fUMAUBGjY82LYcNHrfWcBDDzD7T8t2EeQUwolZ2RoER8eOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/E0+wHk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so5531352a12.2
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723496024; x=1724100824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc20NfdFlq6bqhOz2Wh8VDZxca5ONeyHpZNq0C9p95A=;
        b=h/E0+wHklZR9ToYLGvHD6QJiG9UhBoQZAVhDIsNVuNQ1hdTiUJyEFNSXq5rWnV7z9g
         gM4PrPHwTm7swBbOoa5R83YyXVo/3IU5DtfgoqD5Y4W+VvOL0Vxw0W7Hdtm4EBTAbt5n
         d3U+Ip2+i010DG3h61+wj65oMMIOzxpR2dbMJKgYC5LMZi+V3X97GM/QSC5yPfpDhCVO
         h/JiG+AnCpTKnnCRfVSHDMet8nPDrS6qRqq6kZYzADEzheRTt3eg3rZbJwmmN0U4z+cr
         XF5r5i1cpO0clY+OqM3XAeHMVicw6efPxm3diurilGgNN3OImdw6+1tODT/x7TRwWVYL
         0m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496024; x=1724100824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xc20NfdFlq6bqhOz2Wh8VDZxca5ONeyHpZNq0C9p95A=;
        b=GG87bPbYJhwSblp5fMqPnlhfzlRWJ4DFTPytd5iEZjrCVynsapm+V7VZWSgVlx596U
         +9zThq432P0lNCu1lRvkVC8HkUX8ZN0TlUNQzUZyBOFsk+vYunM/hN70MSIx5f0o0Fo0
         WOq4uewsffjvPcsIR7qdVso5dcmgYjM1g7xIF7QIIRFmW7VY9OrBv5AqpgPa6UsvVKtT
         WPaHIH8fSWWgFGHg552/0Rci5KJEMhJm8oZhKTqU9x9b6SxoI8bFznL5KmSu9RMn4bgz
         LfBZf8T/kfyDG+DsM92Xx/yRyMJxox6BFOBDj5h+inP7KTbZW2Ka2A4EvySyckQjC6HQ
         zLSA==
X-Gm-Message-State: AOJu0YwykxaacKWYLiA42gL/3jvp5Z5Tq7MniNWyncIX5LfA1yXMvv0S
	TzptcnEv6cC7F9AiaGniNhitbhqF+PWiZrYw7JL39+BlB02HrE5P+69c2cW2I72qouQQIAQW6bH
	PSt4ZxTwNQ9RsNkv2ld10+G4eu3A=
X-Google-Smtp-Source: AGHT+IGIzVpRORph76EGbVMuKVT3HaVuo7vUHWBdMMlldf1tL015EPPE36beOXTCXagdLphR4SjlQr2OGTksELNAmuw=
X-Received: by 2002:a05:6402:3552:b0:578:60a6:7c69 with SMTP id
 4fb4d7f45d1cf-5bd44c69222mr1030039a12.30.1723496024291; Mon, 12 Aug 2024
 13:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730201315.19917-1-sergio.collado@gmail.com> <2024081227-habitat-cough-dfb0@gregkh>
In-Reply-To: <2024081227-habitat-cough-dfb0@gregkh>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 12 Aug 2024 22:53:08 +0200
Message-ID: <CAA76j92rfaj56SGii5Gd+MX1jScjgRPDTz7+NmobcWifE_fONA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] jfs: define xtree root and page independently
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	Dave Kleikamp <dave.kleikamp@oracle.com>, Manas Ghandat <ghandatmanas@gmail.com>, 
	syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for pointing that out.
I will review this, and send it to all relevant branches.

On Mon, 12 Aug 2024 at 16:37, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 30, 2024 at 10:13:15PM +0200, Sergio Gonz=C3=A1lez Collado wr=
ote:
> > From: Dave Kleikamp <dave.kleikamp@oracle.com>
> >
> > [ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]
> >
> > In order to make array bounds checking sane, provide a separate
> > definition of the in-inode xtree root and the external xtree page.
> >
> > Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> > Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
> > (cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
> > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> > Reported-by: syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
> > ---
>
> What about 6.6.y?  We can't take commits only to older kernels, that
> would mean you would have a regression.
>
> Please resubmit for all relevant branches.
>
> greg k-h

