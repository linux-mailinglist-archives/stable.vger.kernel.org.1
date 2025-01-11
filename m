Return-Path: <stable+bounces-108265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12301A0A33E
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C997A3CC1
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4811922F2;
	Sat, 11 Jan 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctgYIKWO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678361537D4;
	Sat, 11 Jan 2025 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736593985; cv=none; b=YIFelonX6aXJ5Bq5D0MauOg5wF6a3yyI2L0/0hg25mXmikE7jSdzsz/mlhNSvsRJWnMmvnNxI9FDesOt5ZaWYp9xo9/JaPr3IxQ3jfEeJWGEDDjbzu8QsPGivmu+6l5g7nM7y83KXAWSEcwkt+YojTytj9MEifZB2jDPvvcUoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736593985; c=relaxed/simple;
	bh=LwnCOp04jxe7ud0+oZDujjSPho7IfoB8cf0lLGGfifQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCFevsWNqCToNsmqffa+1Bzr75LQFwepsRYnh2IanSrtNvSp2VDjf/H3z9hG1R4bLXH1N/bW+pw+U++PoIGG6jHAxyCYX0hyqyurJld9S5UieB3tCmXWTxmSqRlYhVPigzmTAexET1Hoq/Cn3pidgTkXJ1JgiRhEcnTyasZTQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctgYIKWO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so408508166b.2;
        Sat, 11 Jan 2025 03:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736593982; x=1737198782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwnCOp04jxe7ud0+oZDujjSPho7IfoB8cf0lLGGfifQ=;
        b=ctgYIKWOYNo5p76vyIYROB0zndC5oeYfYImjJp4DUyr0qZqNf8djEzV3Xy7Lwqj96E
         6LudhSzQk6wGmjbwrnAmuNQS3EWjo5zDdbF9X2fBIkG1s+R5HF8NC1sEgGgwldFBvJ7s
         qzydD1cpMeJ9f3Cfaflra+2ALJcVtCfOgKPb8rLqf3MmEWFSBOOJbJEhImsh0nnpRowD
         jyoRHoXsslt/EJcGaPElLivLXrzroMtkQRpOqKkWjU2PNcR0IhOt5reTAA5zib7TbYJi
         rge36z7ZP09x7WITtS1E52QHjd4zDHZ9RQliZ6o820h4USvvPNW1FPUKcev3jvKfLel3
         djiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736593982; x=1737198782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwnCOp04jxe7ud0+oZDujjSPho7IfoB8cf0lLGGfifQ=;
        b=jBC5CGZzE6QnGTMyze1wUd1wyPGSxdyQFhKyIQE2SbmveGKQyKQEu9rPFYK5d3Kokz
         dkhasXP8cs3GYx55eJhOKnhqRaD1XmpB0bUqoLJt+7XHWeJTfLBpSN8CVS0m/Z1YIOZ3
         WqYODPz4bxT/UlSeRp7vktgrdtAHmnEBHBwtApOpxy4kr9lhLYZraSj0SL5fzLv5ZI41
         itidFgIZCveyaWnNmRN+jR9oFDZMLOUMEmrw3OekScvfp7QTWDJXMJ3I/9JGZiZlpp8m
         6oWd1+0SEZfvLhps+nM0qqauL4r1ZsN8VyNchISAwrxPlJ0YI9RhZnWn+vAPtFnSRcY4
         kchQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoRY84ZZ5nFjrF5oGwK+ehOJIIH0vr/qkfc/T3TeoX4bvBsDxrGRR46CAnyFKGpxThG92u1y3tYzx2Xd8=@vger.kernel.org, AJvYcCX7OlUqSrzf0R7etS1ZqOOFeKJZiRmE4Fynp7mr/w3UJ8lzf5dJj8Z01iZH12KUh/+yJ6mWmXLk@vger.kernel.org, AJvYcCXbaKUg670iN/yTBPWrCxUlhVR5+lhwSYaCYJLHzgwjqml+UmrU5Nh1IBojn6fAduRoeBhfDxdA@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZGayh4yILya5FvDAspUIr28yg8jaKXi4HXjgLgKmMdsrEcLo
	9OiRx8GwxHCB1EL4i9H0N4ItrXiQuKry5bQ17a6i+XA4BdgtOPi9eVJOteTxExXZ6eje7b69NzW
	TE1gGOH0FJKiTT6mlQKJsUnJ1ys4PGSBj
X-Gm-Gg: ASbGnctdXdm/EI0EoJHAzJpp6TCMXXPgkX90Tm7Dhqyq7psXNCPPONDc8Mbgpv7TzwX
	U5l0YuRBsd0ZkHVCIWbXVG7WZVeCeOXetZn0Y/W8=
X-Google-Smtp-Source: AGHT+IF6282MgM1DgwU5iUlWE7vIfL1E+Kry4JlQWVoR+RuoeWnDE/apz2b7KOC+1HpNjRDQujaBIN+72zs8crWyISI=
X-Received: by 2002:a17:907:7f1e:b0:aa6:7091:1e91 with SMTP id
 a640c23a62f3a-ab2ab66cf8cmr1310652266b.11.1736593981455; Sat, 11 Jan 2025
 03:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108192346.2646627-1-kuba@kernel.org> <20250109145054.30925-1-fercerpav@gmail.com>
 <20250109083311.20f5f802@kernel.org> <TYSPR04MB7868EA6003981521C1B2FDAB8E1C2@TYSPR04MB7868.apcprd04.prod.outlook.com>
 <20250110181841.61a5bb33@kernel.org>
In-Reply-To: <20250110181841.61a5bb33@kernel.org>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Sat, 11 Jan 2025 19:12:51 +0800
X-Gm-Features: AbW1kvb7vYlwuMrCJ4LNPpD4i2XnHdUS01P_Rf6z3H8hOvlMHGCbJq3Pu-BhAhY
Message-ID: <CAGfYmwVECrisZMhWAddmnczcLqFfNZ2boNAD5=p2HHuOhLy75w@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW0V4dGVybmFsXSBSZTogW1BBVENIXSBuZXQvbmNzaTogZml4IGxvYw==?=
	=?UTF-8?B?a2luZyBpbiBHZXQgTUFDIEFkZHJlc3MgaGFuZGxpbmc=?=
To: Jakub Kicinski <kuba@kernel.org>, Paul Fertser <fercerpav@gmail.com>
Cc: =?UTF-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cp?= <Potin.Lai@quantatw.com>, 
	Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ivan Mikhaylov <fr0st61te@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	=?UTF-8?B?Q29zbW8gQ2hvdSAoIOWRqOalt+WfuSk=?= <Cosmo.Chou@quantatw.com>, 
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>, Cosmo Chou <chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 10 Jan 2025 06:02:04 +0000 Potin Lai (=E8=B3=B4=E6=9F=8F=E5=BB=B7=
) wrote:
> > > Neat!
> > > Potin, please give this a test ASAP.
> >
> > Thanks for the new patch.
> > I am currently tied up with other tasks, but I=E2=80=99ll make sure to =
test
> > it as soon as possible and share the results with you.
>
> Understood, would you be able to test it by January 13th?
> Depending on how long we need to wait we may be better off
> applying the patch already or waiting with committing..

Hi Jakub & Paul,

I had a test yesterday, the patch is working and the kernel panic does
not happen any more, but we notice sometimes the config_apply_mac
state runs before the gma command is handled.

Cosmo helped me to find a potential state handling issue, and I
submitted the v2 version.
Please kindly have a look at v2 version with the link below.
v2: https://lore.kernel.org/all/20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gma=
il.com/

Best Regards,
Potin

