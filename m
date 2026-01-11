Return-Path: <stable+bounces-208021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2ED0F641
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FD93038F41
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51DB33CEAA;
	Sun, 11 Jan 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1HCISd/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170A3242D2
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768147351; cv=none; b=jNb12zrpZr+J1f08DHnL+F7m53xOOF7Urb1CUSYJdXOTwkurFl1t6IrGX8AA5comEMi0YHqGpNQIPKEe7HjwWha4MyVtUkEaaXlTG55h5AKczlKujGyKAcoYp8HCNekkIbbTiW329BSUHLm8IIvVERbRV6zSRAdb3jB01WdtDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768147351; c=relaxed/simple;
	bh=eSaYeVb9xp7hiZVnt79Dppo3RCzVphfcMVldS9mlf6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlNHi8US86f7d0QUFM/zxyLRrQOUCBO7ADyHnFUYHMU/mwmzgPJPVfnh7Cl+gmtvaTYR3nvhKRo0hz0RLW90iiQobl5H/NHWjiUcyixXFyKTrxi90l8n1nlBIHqvsUzbnvUCjwOBkH6+iJh6xYSHF69tUPksGe6lLGyUMlev+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1HCISd/; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6455a60c11fso4676677d50.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768147349; x=1768752149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mrycd130M4sr6y5csevbsCsisFex4vtcFdUC5UAakBY=;
        b=c1HCISd/OPAyhADacCEPawukDV3JS/3ZJHm1TcIOtd5wbIo4zYUw3sM3878L+ME1n7
         qhSyfhY8BR6egRWRFSZGns+Bw2zKCldgFY4UGywyfKZN7KaU/bCE9RGtrBBxhRN0ysrm
         jiU4dt3fCVDxdfroGu7BIoz+rNAEV82I0tdANztz8n62BEtH6lHHGzSUQtbg174ddEmw
         Njzzyg9MRcjJCF2j6+/1Ely0Sj1O5dREzLZPSIOdHC9tidyEzWfXw+n7QHRpOmHe6eUS
         wUMfz0Cs3OeUGw09i9sLWzBOqdxm0WVA+sCBRHp0mv8HEB4ZPExYZ7XM+mQlLQh9Lcx8
         6vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768147349; x=1768752149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mrycd130M4sr6y5csevbsCsisFex4vtcFdUC5UAakBY=;
        b=NY6rZ3bWgoqK8KpTrv6XxhiWbGuI+W2SbZoN1R8V2Op6Y5NgBLn6rNJQKjpS7BOZ9v
         IDJuijNUqk6QLGW3vrx/5p6K0De8K2q/UBLF5+bPPSmYAqw4DNflhtJH4peijFMk2eLO
         15RqcaE6kTNK2hf7Bcp4V0sbMEilITWcaT9XizQTEUnBlKSnEmIyrd44Nz4t+NJdKywJ
         rGBcd5L1zgicJEpGxbfks0RWOGWEFUhE+htbuI+JLOpkBT1jx8+qjvvAmZZb7jliJImJ
         QURO9488tR4FvCwZWZ8I2P0PteIf1oYDb3fRSdSclHkqo4IfZAF2DJ5TCMUwyjoo1f8P
         q9hA==
X-Forwarded-Encrypted: i=1; AJvYcCVR6QtJTWDaz32WHRB0511q6Boo28suD4m1DnCcJum1kiEjX+LVBVlypWBmnM07GVy8W+h9UQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDh/wg94WT1ccSZK9XsIcvHOS+kRtFdxW5i89GoHRDGTKAosLm
	IZPmOxi14EU2GUqLjwkXQxVKV7T9Gez2vaiLmlhEnATxDngtS2oV9uWEurnm5pC/cdPkEVeEDqY
	hCnDo9doL8u06Idnn7yd1KMtEuJpddVtJA3Tl
X-Gm-Gg: AY/fxX75MdTmnkmnx9QfU6aqWlUV/txIgRsXcU0ukOGdcTbA7FNRxWdV438f3Qvkl3d
	j0f18/IrKR+XVndMD0KBKwUFlJHI3xA8qYosoc/ROGmXYEZFbr7W1jXuh6iEK66vAhjnxi7bEHN
	f/koJjvJvE8kbC5sjB0lfl6o8jwwqLqbgk/OCvx9UjCAAhAgESavjVOfzql7iKj8WHLuAjvyxfc
	y+t78Fbg2NiSmF2PpcEj1DTScRFGH2Np3Hjp0CchouqjW9R/U2cn0ORZ5dn1M19+E2FpIc=
X-Google-Smtp-Source: AGHT+IF8KwHX9n4cdLJcJVB+1Qbgj7xp3EnY3eddzftroQhS3lOBRejGEzTuxx79W8cJXIm8mv4flYclON7riLXunQ4=
X-Received: by 2002:a53:be4f:0:b0:644:7612:6298 with SMTP id
 956f58d0204a3-64716c94ef8mr9426151d50.79.1768147349222; Sun, 11 Jan 2026
 08:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215004145.2760442-1-sashal@kernel.org> <20251215004145.2760442-3-sashal@kernel.org>
 <CAPnZJGD0ifVdHTRcMzKBFX8UEf_me1KTrkbwezZrhzndcTx-3Q@mail.gmail.com>
 <aV5Ap8TgMEDLucWR@laps> <CAPnZJGCJ1LZRzfzO=958EfcrLm4Z3pYdtHZEpp812fstsUcOAQ@mail.gmail.com>
 <2026011119-stadium-trilogy-22ac@gregkh>
In-Reply-To: <2026011119-stadium-trilogy-22ac@gregkh>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 11 Jan 2026 19:01:53 +0300
X-Gm-Features: AZwV_Qj8Iaiq8jyFrAWd7h_o61n6oQGSG9QPqA4Rx4PSntORpllo3Vv3IL8l3rU
Message-ID: <CAPnZJGAXLEgqKx+XA3RugES1kcawtqMEYPTzFERcf2kgRjNbFQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.17] ALSA: hda: intel-dsp-config: Prefer
 legacy driver as fallback
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, stable@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com, 
	ranjani.sridharan@linux.intel.com, rf@opensource.cirrus.com, 
	bradynorander@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 3:24=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> > You mean that 82d9d54a6c0e is in all trees? Okay, then,
> > please, backport 161a0c617ab172bbcda7ce61803addeb2124dbff
> > to all trees.
>
> Why?  I see no context here :(

Please, backport 161a0c617ab1 to all stable kernels, which have 82d9d54a6c0=
e.

161a0c617ab1 fixes bug, reported by me here:
https://lore.kernel.org/all/20251014034156.4480-1-safinaskar@gmail.com/ .

I did bisect and found that 2d9223d2d64c is the culprit. But then Takashi I=
wai
explained that the bug appeared earlier:
https://lore.kernel.org/all/87345iebky.wl-tiwai@suse.de/ .
Iwai said: "the bug itself was introduced
from the very beginning, and it could hit earlier".

I assume "the very beginning" here should be interpreted as
"commit, where intel-dsp-config.c appeared", because the fix
modifies "intel-dsp-config.c".

"intel-dsp-config.c" introduced in 82d9d54a6c0e, so
161a0c617ab1 should be backported to all kernels, which
have 82d9d54a6c0e.

--=20
Askar Safin

