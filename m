Return-Path: <stable+bounces-47899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502768FA7B6
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 03:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EB028AED5
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF113D292;
	Tue,  4 Jun 2024 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHelUyMW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465D2119;
	Tue,  4 Jun 2024 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717465470; cv=none; b=qRJPyZuZLM/cODbgxrQPlMoHoWoeCB7b55vbVubrOLql69Hg2539DSYWM61d4wTspcSg4EkLHFUnKSNpBvi0aczXj7MAeEgD4UWj17ZmkzVrC8actyKaNSgap/rzcO6pBfCEPibFfV/qXMsa4OfKSAj1no4EqJ8fKCxT3jmoCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717465470; c=relaxed/simple;
	bh=y28s+nLNO1bWcxjBQjbsD7eMNMx5eUTUY2NVePXeVQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUNtZgNLngahbUdkRfVmBZFJHmeM+VhAxr5GCju8z2UY7ylmuCSr1YpXS98DQB3quFyEv02tF395GzXr/4cvdDNWMs7snfn87Gv63Fv5wwiPVwYy8c7u9qATomYzLv8tglYYIlrZH1yNGInBc7Nc1lIPTHZwwcLfnn4JEMCjFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHelUyMW; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso4034251a91.2;
        Mon, 03 Jun 2024 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717465467; x=1718070267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvi35CutHOvk8L4T40KqLdLme+seQz75uz8K1IuqiKI=;
        b=aHelUyMWQyADuTUIye83vyWjgQ6E1BSs6FwHuPI21oRt+pzwpBc4tR9qo1ti3jybN9
         W8HotAtC13w81GylMYoCxiHxJLFnYYlJVbyQfxgiH1C5h5qi+cc05wRBZ78tm33QwJhI
         DDHA2SYpTyfrIOrATE7rLPCJrdaRsmIJWnK00xsbgtAmZjGcKBLCZc7TcKVwesbvyhsD
         eLrEQKhLY+XD6cTZUol+Fz4LHq+1oajpii0jhp4xFeP8Oe9zRX/pxisbHP+IIJAKgrLL
         UpJK6PEdLVlDhbwdqCwvl+z0y4swUllfU59CkOyyfmUPeU5tQZXvlr6u2OxsZQBsM/bE
         IFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717465467; x=1718070267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvi35CutHOvk8L4T40KqLdLme+seQz75uz8K1IuqiKI=;
        b=KEhVJy4RvlQbTHYOnkqocUe1zPvBGoDx3qtAlWl2GX59zvOMF2gZOVdPSInwJdeVjJ
         DCULxa2HL+HXNoYfI3hm/EjkeUazVRLR8OysOFbwHCrc9te+ZkOGUDtf/7CwFqmeLm3F
         xwVcCwuVgoHWPk4ASOhbqFJr69pW+3rDT5FaIL17M0KLJfaEwFnRWZ1A0S15jI4SZPFH
         h7iu/W+xWdVS24Vp1JJYiGIcbe1cemDYTr6KhBqUVb2ydLiTXfi+wLY8IWzhekuYxMh8
         5CnAlemM3edbaFt3n/eh24IXD2CyulYjadzG7Gdr7Pje2gBoHSeYUPZaIxJc1WwoYVC+
         4Jjg==
X-Forwarded-Encrypted: i=1; AJvYcCXvsBwk47ML7DAhzovVC49PubG23iIwBu8dDHjzcye0v2Wcc5eB5AynUEhFa2jZtdSasAArMEs8Wh0tI3pcX+/vHgWL28B8sLJcOPrkVFWGEQhiSwArAfVwYU4xeDdZVBEB7Et2
X-Gm-Message-State: AOJu0YxOx9xXnJ4XJsmjJUOy5kn5jbftmlV10lPHyFXPjCH/sVWMcKwh
	oSxpDyvLGiCo8cs4SQQD9713uFcDDmoRw+R7PHdsHGF9hlCV1NBxPk4dG72qOJlcV20Hmo4yBjO
	6dmEhGeRKaY4+PRJn2aGLOHgLVCw=
X-Google-Smtp-Source: AGHT+IFhp4rKoM4tYI0AmyHbd1SD0L7TWWRFvRLc+IzUN28sOCydRuy8wSF9EeCiqZdTdg6jyPw9gvpqW/SsAaML6jY=
X-Received: by 2002:a17:90a:530c:b0:2c2:4106:1ada with SMTP id
 98e67ed59e1d1-2c241064fc5mr3042177a91.16.1717465467248; Mon, 03 Jun 2024
 18:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603073953.16399-1-linchengming884@gmail.com> <2024060337-relatable-ozone-510e@gregkh>
In-Reply-To: <2024060337-relatable-ozone-510e@gregkh>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 4 Jun 2024 09:44:01 +0800
Message-ID: <CAAyq3SYg3Qr08DguhPbC8Bb89_KS_AAG-Z8SNG_A7H_v4YNrDA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: mtd: spinand: macronix: Add support for
 serial NAND flash
To: Greg KH <gregkh@linuxfoundation.org>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org, 
	computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jun 03, 2024 at 03:39:53PM +0800, Cheng Ming Lin wrote:
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been merge into
> > Linux kernel mainline.
>
> Trailing whitespace :(

Sorry, we will fix it in the next version.

>
> > Commit ID: "c374839f9b4475173e536d1eaddff45cb481dbdf".
>
> See the kernel documentation for how to properly reference commits in
> changelog messages.

Sure, this will also be fixed in the next version.

>
> > For SPI-NAND flash support on Linux kernel LTS v5.4.y,
> > add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tables=
.
> >
> > Those five flashes have been validate on Xilinx zynq-picozed board and
> > Linux kernel LTS v5.4.y.
>
> What does 5.4.y have to do with the latest mainline tree?  Is this
> tested on our latest tree?

We have requirements specific to the 5.4.y, and these five flashes
have been adapted for the latest mainline tree.
Additionally, they have been patched on LTS 5.14.y, and we have
tested them on LTS 5.4.y.
Given these circumstances, we are hopeful for approval to backport
these five flash IDs on 5.4.y.

>
> thanks,
>
> greg k-h

Regards,
Cheng Ming

