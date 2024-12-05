Return-Path: <stable+bounces-98729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA09E4E2B
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E881B16A6D0
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2B1B0F25;
	Thu,  5 Dec 2024 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsnjD8iv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7321B0F0F
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383371; cv=none; b=i5mER2Mr+DnWn9HJhzLFW09jXj7mxGkzEQRY15od6ES4wMYtjb55uxy4R4KY3KEGW1l2kGEWxvh46Gd2qdu1HlfuqWB4AKJv2ZV9emZAXEdx4U+Verh81OYE08Y1ghetFM66rkdz+uFhdfIm10EzIBg7g1BO43mr8lMmV5tXLjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383371; c=relaxed/simple;
	bh=qtg5v3jGdfJeGCIU+vkRwYiByT4AAK/dy8DNJM81o18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GquCQWMMC/vUOEitB/AN9rTCR2+fwFg7ufUYUb/Hk30js4I8q+DBzyGlezua5MExc0YdjBgposkwl4F+1q5Ppzj35vAXZSWfjl90TPKpa1Qhdke3kHGKw4RRC/tpuVS/9uCj4LzU1dvqiO7EyonP4n3wySVjYYZYNiOuU5drQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsnjD8iv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so642949a12.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733383368; x=1733988168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frWHkMGaIgzljLCfRpARHBnw22n4ufJZiwlQKuJjDHc=;
        b=WsnjD8ivE9lOcDqtCFPkQ3d08qo1ZLX47HY9xrjsXB3zVuCjA/sVf6He93TM2RZn8f
         qTiRu3X7KNiKHoLaGlOZcWdbkCM8/JBYGfYSKwIfGZtf/ph+A3RuKTQgCFZmS4Whjh6S
         qPGixkc73JszHskNa/iwotNbTTyp6uUD+nIcNJVc0DcIwDvvXoLFrC4anV9rMIUb8axH
         pVMdOTi7u9KqTr9JNv7Fmrgv9HemBrNUAeWJLSUeE3Pj6v+h+tm0qLVaUjCS9Ow6nXD0
         sEhNB8tk7X6W3hpcFvxs8ZPuGYIQtoWN4+JVCJHS2eW02C5QnWi/GtZjLzZXv1/Oxff9
         j0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383368; x=1733988168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frWHkMGaIgzljLCfRpARHBnw22n4ufJZiwlQKuJjDHc=;
        b=KVh6Q56FVdU4rZgKaUWDQ5dT/Tf673FSUmmlzx2CsNSQyXPY1Y4aAfUV8j/zAqWP2g
         e+iW4xrhwdCOe6gnH/jrL6xSrP0xwIbfRZQyI41XfUwPHFkdVYiL8Fuh03BWaotkdjVW
         pTWAhoWOehDjYc1XgmWB88Sn1YBY1MnC8+Q0OaftG7i7kXZKzTBsdawIlhjHChINcCsT
         jelHhF7yoCuFsRj9fxKcvbhM6t5Nr3f34T2D5YAGixM6IkkB86Yf5Gx/Dhirlkvt/0l4
         0xKRyOkSNe+L3BMyM/SSZBO+TNy7P0+HID8quCWrTXBUFIqNitL84V744OveAiyNeAS/
         FDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVWTcJeUooA2okWjCBuNHouipCfrh+lYmqTyEM69hVLArG1MWM7j3mb9xmarrDLVUX0pFx6bF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jNf1EdOmOLvbUH2plsrlsbynSvbeI8m7QSofS2BoqxIJCFfd
	yP/v13N5DID7LXsRh4qeQE6bj8+qOY3N5/dR8RbpDHr7eaEkOZwT
X-Gm-Gg: ASbGnctogB4ZTfahAuN0WZ6O+W4+X7Us/vt1UBe2zAfG2kdYnLegIAuYDKdYAx3ghvk
	OkPtqj7hTlXKeKZSA7ENNsmLNBxtjGo3LWZQipn9/IWI67NPwXfl5++5NMFXQDMgwFe1kiM1t38
	/Trr5FYytRmDZrv6DcKZ2O+PGHxZQt6BtNaZ6bhbcTLq6Hgjz/5OFmsOmUb8b6QHYgnHww58dYn
	B4uRcvnXtXNa+Vv9OKYJR2Hf4/Q6l2RyQniXIrR+uPtyaEMgVGyFnf22OHh5/Holi1il6Y6Y2kK
	9LTNarcbVg==
X-Google-Smtp-Source: AGHT+IG4Ei5ENdv1uWiQ+2/a8eFV2OYhjNUpoVO2dk0cqdapF45EmQsjKl1oOF5X/N89aY9t5qj2dw==
X-Received: by 2002:a05:6402:51d0:b0:5d0:d84c:abb3 with SMTP id 4fb4d7f45d1cf-5d10cb7f906mr9547069a12.26.1733383367831;
        Wed, 04 Dec 2024 23:22:47 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49dd1sm448324a12.28.2024.12.04.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:22:46 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8B1EBBE2EE7; Thu, 05 Dec 2024 08:22:45 +0100 (CET)
Date: Thu, 5 Dec 2024 08:22:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: please revert backport of
 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Message-ID: <Z1FUxY74Gze-5J3N@eldamar.lan>
References: <202411210628.ECF1B494D7@keescook>
 <4ef74a1c-a261-487b-891c-56c44863daea@tls.msk.ru>
 <Z1FOMMxv8bVt8RC3@eldamar.lan>
 <2024120519-chamber-despise-c179@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120519-chamber-despise-c179@gregkh>

Hi Greg,

On Thu, Dec 05, 2024 at 08:07:15AM +0100, Greg KH wrote:
> On Thu, Dec 05, 2024 at 07:54:40AM +0100, Salvatore Bonaccorso wrote:
> > Hi all,
> > 
> > On Mon, Nov 25, 2024 at 10:26:12AM +0300, Michael Tokarev wrote:
> > > 21.11.2024 17:33, Kees Cook wrote:
> > > > Hi stable tree maintainers,
> > > > 
> > > > Please revert the backports of
> > > > 
> > > > 44c76825d6ee ("x86: Increase brk randomness entropy for 64-bit systems")
> > > > 
> > > > namely:
> > > > 
> > > > 5.4:  03475167fda50b8511ef620a27409b08365882e1
> > > > 5.10: 25d31baf922c1ee987efd6fcc9c7d4ab539c66b4
> > > > 5.15: 06cb3463aa58906cfff72877eb7f50cb26e9ca93
> > > > 6.1:  b0cde867b80a5e81fcbc0383e138f5845f2005ee
> > > > 6.6:  1a45994fb218d93dec48a3a86f68283db61e0936
> > > > 
> > > > There seems to be a bad interaction between this change and older
> > > > PIE-built qemu-user-static (for aarch64) binaries[1]. Investigation
> > > > continues to see if this will need to be reverted from 6.6, 6.11,
> > > > and mainline. But for now, it's clearly a problem for older kernels with
> > > > older qemu.
> > > > 
> > > > Thanks!
> > > > 
> > > > -Kees
> > > > 
> > > > [1] https://lore.kernel.org/all/202411201000.F3313C02@keescook/
> > > Unfortunately I haven't seen this thread and this email before now,
> > > when things are already too late.
> > > 
> > > And it turned out it's entirely my fault with all this.  Let me
> > > explain so things become clear to everyone.
> > > 
> > > The problem here is entirely in qemu-user.  The fundamental issue
> > > is that qemu-user does not implement an MMU, instead, it implements
> > > just address shift, searching for a memory region for the guest address
> > > space which is hopefully not used by qemu-user itself.
> > > 
> > > In practice, this is rarely an issue though, when - and this is the
> > > default - qemu is built as a static-pie executable.  This is important:
> > > it's the default mode for the static build - it builds as static-pie
> > > executable, which works around the problem in almost all cases.
> > > This is done for quite a long time, too.
> > > 
> > > However, I, as qemu maintainer in debian, got a bug report saying
> > > that qemu-user-static isn't "static enough" - because for some tools
> > > used on debian (lintian), static-pie was something unknown and the
> > > tool issued a warning.  And at the time, I just added --disable-pie
> > > flag to the build, without much thinking.  This is where things went
> > > wrong.
> > > 
> > > Later I reverted this change with a shame, because it causes numerous
> > > configurations to fail randomly, and each of them is very difficult to
> > > debug (especially due to randomness of failures, sometimes it can work
> > > 50 times in a row but fail on the 51th).
> > > 
> > > But unfortunately, I forgot to revert this "de-PIEsation" change in
> > > debian stable, and that's exactly where the original bug report come
> > > from, stating kernel broke builds in qemu.
> > > 
> > > The same qemu-user-static configuration has been used by some other
> > > distributions too, but hopefully everything's fixed now.  Except of
> > > debian bookworm, and probably also ubuntu jammy (previous LTS).
> > > 
> > > It is not an "older qemu" anymore (though for a very old qemu this is
> > > true again, that old one can't be used anymore with modern executables
> > > anyway due to other reasons).  It is just my build mistake which is
> > > *still* unfixed on debian stable (bookworm).  And even there, this
> > > issue can trivially be fixed locally, since qemu-user-static is
> > > self-contained and can be installed on older debian releases, and I
> > > always provide up-to-date backports of qemu packages for debian stable.
> > > 
> > > And yes, qemu had numerous improvements in this area since bookworm
> > > version, which addressed many other issues around this and fixed many
> > > other configurations (which are not related to this kernel change),
> > > but the fundamental issue (lack of full-blown MMU) remains.
> > > 
> > > Hopefully this clears things up, and it can be seen that this is not
> > > a kernel bug.  And I'm hoping we'll fix this in debian bookworm soon
> > > too.
> > > 
> > > Thanks, and sorry for all the buzz which caused my 2 mistakes.
> > 
> > So catching up with that as we currently did cherry-pick the revert in
> > Debian but I defintivelfy would like to align with upstream (and drop
> > the cherry-pick again if it's not going to be picked for 6.1.y
> > upstream):
> > 
> > I'm a bit lost here. What are we going to do? Is the commit still
> > temporarly be applied to the stable series or are we staying at the
> > status quo and we should solely deal it within Debian on qemu side to
> > address the issue above and then we are fine? 
> 
> I read this as "oops, we messed up in qemu and will fix it there" and so
> I dropped the reverts from the kernel.  If that's not the case, please
> let me know.

Thanks for the quick confirmation.

Michael, I will drop the local revert in src:linux then on the next
upload I do. Can you handle the qemu part in Debian accordingly (and
make sure the fix lands in the next Debian point release in January
and ideally maybe via stable-updates earlier to affected people?)

Regards,
Salvatore

