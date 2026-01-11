Return-Path: <stable+bounces-208000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C096D0ECEA
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 531A630139A2
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4419733C1B4;
	Sun, 11 Jan 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfDzgcqP"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103733C18C
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133126; cv=none; b=cZvKA1OBJ6NPy6BWhDjR4dr8uNLMHC309cTtOVXuhiNk6cXsNSaXYBvtsoguuzSWAZj3Jmyk5qmZ367Tz5m5y/QUtIDyhnNBdWdifLSDF2s4y4L5oTL6Q/4UsK+qeyv9oNWEOxe6SuoOBHHhvTwbtJ4EBvszHf03mbb3YxL02O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133126; c=relaxed/simple;
	bh=BJGL51uFk7fQ9hz7zeX/+jdsupIgJO3pK5yWzIkYIKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0ZNcUoi7oWLvngLgexM5lKPUlJhpXg1RvS2ow4iPbanfWGMCKRH73f3BqAhe+3jwwmF5Uin4ep7Ehw03gWq2CnLfbpZm2d56fE76d3wx7f2wm0M8IqB35ntFqBz5qFTU85yTMfejkonBR2zX6QjiQOs2XhlJ08g/mhWR+MCN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfDzgcqP; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64661975669so5982460d50.3
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 04:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768133123; x=1768737923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJGL51uFk7fQ9hz7zeX/+jdsupIgJO3pK5yWzIkYIKU=;
        b=KfDzgcqP6MaDSHkvF+DnFLT/bBe2y25RwfkJoo6BtaexSrBE7VgIlUyCd1425DUGVr
         tDOpP51SoDNcTpmPj4O+9shsvg4PBNiKCPBX/ARWB6XdXcmWdgVFTN69SfwYCmiZfFk0
         ggJ37RjWV+ANT0PgkVUVKxxdF+Pn3TCC2rEBZhGlaVw0Flfr+4FAwjGpDDBv9kBdSPnM
         9UufImKl02Hgi/FMxF3lAmpiWHkL5VEJX7D0eXjzlEzYkY6d/kCbodmoO+YldUoejEkX
         hVREAxptE4FcF31KRMeU2XeZ5PJ0mCj4ov62CIl7MnH0Dkbo0EyQTXIK7TQ667eoTiVy
         PmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768133123; x=1768737923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJGL51uFk7fQ9hz7zeX/+jdsupIgJO3pK5yWzIkYIKU=;
        b=OmRunuGFBLYhQwfiIIbAu+VlQzWsrGvr1CUckhrPTn3gghzELWeWsVNaPnHFeNdj+3
         u/4olBDx2OlKr+A0536bC8THQi/xCgXQPdOysSa5QVKkXjly4zamfx1LrEIaiRT691tg
         l30VYqH97kLyhKWSyt9u+SSMMFWK3hL9h6ZMwDluFdBNBv/Bv1szd6btq/MpwWOnd9k8
         veuvrgtopAp0gWmyRrOxVW0mp4MPPUO7NYmj10rvs+6zvFA6h/pMx4dc0A1ISPYVZudg
         0uSwnYgJltdkE1t0RPfaoxtKibftylQXdQp7PyhkkJtRZkfcfIjkKPMv4QvPi047DNkP
         tQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFQiHNTCDapHiiQ0umHTt9+i6TAPvjfOJLOFfb/ZnJBIKC6pZfHBgLuMLI+I0RARgny94MLMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5G0D9mq7lCK+pHM0fN8h1iJObA7RSlUoCG4PKg2d31QlUT3/R
	KM/V7Ss2zwgFcVCAB6rXuMZP4fxDMlZm+vWcp5rW558w/qxot8qaLOXZyh4hO3S3OFDnPo89FLX
	rMk+arcFm5fT8zNGftDocSrOr0sTUz9g=
X-Gm-Gg: AY/fxX72jxU17Ky5zpu3iT+5K7nyQ5/XR4bVERS9NxLfTKlKw/GrkKxBslQdHC5PNFP
	TLHszGEx8acD7xw+ONGu00ypMOb6VjreTy8WYMoKK1mpmRP9Gn23wP7DxTz3r3oXvJeual6haix
	LocYcVHWe+46vhAhrm2vZIFomf1R8mPhaWJtwLR869RDntm0DGRe6tq69i91TkaePqOYxzQjP1u
	fClOPm42b0qNqV6qMdqq8g0eXDDxUV0G1MB0/3fx+bABY8Wh26GCsyfxETUelJlnZrUj+o=
X-Google-Smtp-Source: AGHT+IGahIVp0QXfjLl8u9XAUuZ7fv6XRsqgXN/SrrswcxGhag6nP5JvuSR8ieSQy0oB8X46LSRqzKp520LUEChgAVU=
X-Received: by 2002:a53:ac91:0:b0:641:f5bc:696f with SMTP id
 956f58d0204a3-64716c69376mr12371028d50.75.1768133123569; Sun, 11 Jan 2026
 04:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215004145.2760442-1-sashal@kernel.org> <20251215004145.2760442-3-sashal@kernel.org>
 <CAPnZJGD0ifVdHTRcMzKBFX8UEf_me1KTrkbwezZrhzndcTx-3Q@mail.gmail.com> <aV5Ap8TgMEDLucWR@laps>
In-Reply-To: <aV5Ap8TgMEDLucWR@laps>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 11 Jan 2026 15:04:47 +0300
X-Gm-Features: AZwV_Qj8Sx4l4BPwlCO49T3uPzi24vzhWqsFCLRApt24D8voFX6GP-5XOhNcwiE
Message-ID: <CAPnZJGCJ1LZRzfzO=958EfcrLm4Z3pYdtHZEpp812fstsUcOAQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.17] ALSA: hda: intel-dsp-config: Prefer
 legacy driver as fallback
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com, 
	ranjani.sridharan@linux.intel.com, rf@opensource.cirrus.com, 
	bradynorander@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 2:16=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
> >Please, backport this to 82d9d54a6c0e .
> >82d9d54a6c0e is commit, which introduced "intel-dsp-config.c".
>
> Looks like that commit is already in all trees.

You mean that 82d9d54a6c0e is in all trees? Okay, then,
please, backport 161a0c617ab172bbcda7ce61803addeb2124dbff
to all trees.

--=20
Askar Safin

