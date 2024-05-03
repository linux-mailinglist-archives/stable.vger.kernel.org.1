Return-Path: <stable+bounces-43025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BE8BB180
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0FE284A51
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC47157A76;
	Fri,  3 May 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOExazcV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69475157A6C;
	Fri,  3 May 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756367; cv=none; b=rC7Csi32XVYHDSlup4MpMC0W6/a0PPV/asPtuVTr9fQ2Egua3taqOsPpYdmvMVCijNjiB9/E4z5yuN+J7qvnI1Q0CGTKfNJorE1k0seox0kxZSTMgegj+tqzT1E6A2imHycsHC+vidfFUx0It1hJE5bhxTOEAw5TDd+MCrWOVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756367; c=relaxed/simple;
	bh=TrukaTzLG5Ze/vSBowccUcz1MejPwsbnENfwux681mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz8/bMFidavlUFbQ1JojQMuKzfB46pnnEQqh0sCzHgxNa3cJlIiUjuaZ2lhLhuvqZOEv/esqmtDsurE78eaZljE68u+ZEa5UzZyjiGVNmi0Bfj7mozGxs6cz0WX2lUdqU6WOSqgZv9boXwhyKPY/G0B1VfuTpXqxjXCOhAJ2teQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOExazcV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso120594701fa.3;
        Fri, 03 May 2024 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756363; x=1715361163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSJLyImBKTtU/kaCK7ArudZzxUgbCTaWT6T62Q5YTag=;
        b=YOExazcVQVpNoKen9xbeCCy++OvT5SUu9QJ1bjQbNwevCKAMCZHpiZrgkuSYevYc03
         h8W21o6P5IWTmsylU1Nyn/xK+Ews5PCBISHZlN3jjQrkRRPIhNaz+357C1qfMr8h8dJ7
         D6CJlqZLwvip57srcoh08gktd+pG6pVgrJAnbWC+ufFUodovrtTwBMG6MGpQmTQTthUf
         6bddmLRoO0YS1YLLI6u03NyDDcuYzVPcX/FUVXXbJUA7Kb//Pek7o9DKqV/hZ9K5BSFe
         xLD+XvG6PGUpsikNwTzslBi9r16CHz/w+VrEMV122yeHSabCe3aQGWLr7uvep13cnY8b
         RwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756363; x=1715361163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSJLyImBKTtU/kaCK7ArudZzxUgbCTaWT6T62Q5YTag=;
        b=DTSqJb4zVaQhPXiADpgiaDc6MxiLYJbc5V56OlJqix227XKJy9u2YBekZIK6KxHLGA
         sRXfFfhlCkFvRbxPxXvKQkXwuHxfsH/tLHnjHC089xHT19OWJyinyKxZa3xl+t8DttyT
         DjtXlL/vqjh1z7VF7TKTt2UknEyIzXihsdgcviVOQ/U+f91SCKNhFdI6BLIuvgvSyUOp
         uW6w/X0LS4eIRW3fLWIiRcxuAdWwNTvykp1JOCSnAeO1xwg5u1+vptiNpvDlcu+xrK+s
         s9HgLbYKjlt9mPV1KHZNIJHvSAHAzWDMyXz0J9Wyzgu3ABqW9aR0YsQgXmSgrpBSW0ym
         1wQg==
X-Forwarded-Encrypted: i=1; AJvYcCXWPI7pf0PY9fg1XSxvL98XeqtY+UeYrHA9UkZkCV5SD0wJFfJdvQ3WGbihDm+6wrAnTSnEv1dtTCJyOjdao4b9fPG84JGod2Y7Iu+4FsI=
X-Gm-Message-State: AOJu0Yz3609fpxY7ZrDO1U82Cf29SfdQldayNREUfLc6aKB495CYf7jV
	yCRaZJ3GwYmliHXa0LujpVzBwlX7ca6+T1SBr9GSJjXMSPBjg8LbIT3o3SsDwoOEtNJDM/JBJgd
	FADP0oyD6rbifxdZPvs13LlG56Ws=
X-Google-Smtp-Source: AGHT+IH2IxEla5tmSIDR03XkjTb8FGC+tqz03FyascX+1tWYhep+rgsqN6tUZJzlFWOT/weXaVH4qnVJ6+D3cZP5NTU=
X-Received: by 2002:a2e:9bc5:0:b0:2e0:dc93:52ef with SMTP id
 w5-20020a2e9bc5000000b002e0dc9352efmr2075992ljj.26.1714756363247; Fri, 03 May
 2024 10:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503163852.5938-1-sashal@kernel.org> <ZjUVBBVk_WHUUMli@hovoldconsulting.com>
In-Reply-To: <ZjUVBBVk_WHUUMli@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 May 2024 13:12:31 -0400
Message-ID: <CABBYNZLN3ULgxqv3MtS_U5DbMnmuuPFqC=zrabcEt0WChu-W0g@mail.gmail.com>
Subject: Re: Patch "Bluetooth: qca: fix invalid device address check" has been
 added to the 6.8-stable tree
To: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	johan+linaro@kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Fri, May 3, 2024 at 12:47=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Hi Sasha,
>
> On Fri, May 03, 2024 at 12:38:51PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >
> >     Bluetooth: qca: fix invalid device address check
> >
> > to the 6.8-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
> >
> > The filename of the patch is:
> >      bluetooth-qca-fix-invalid-device-address-check.patch
> > and it can be found in the queue-6.8 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree=
,
> > please let <stable@vger.kernel.org> know about it.
>
> Please drop this one temporarily from all stable queues as it needs to
> be backported together with some follow-up fixes that are on their way
> into mainline.
>
> > commit 2179ab410adb7c29e2feed5d1c15138e23b5e76e
> > Author: Johan Hovold <johan+linaro@kernel.org>
> > Date:   Tue Apr 16 11:15:09 2024 +0200
> >
> >     Bluetooth: qca: fix invalid device address check
> >
> >     [ Upstream commit 32868e126c78876a8a5ddfcb6ac8cb2fffcf4d27 ]
>
> Johan

Im preparing a pull-request which includes the following:

Johan Hovold (7):
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: generalise device address check
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix firmware check error path

Let me know if I'm missing anything.

--=20
Luiz Augusto von Dentz

