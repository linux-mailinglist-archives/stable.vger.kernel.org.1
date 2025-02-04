Return-Path: <stable+bounces-112124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99AA26DF5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01334164193
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945D207675;
	Tue,  4 Feb 2025 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsugyoNO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67D20371A
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660354; cv=none; b=u45Wu/gPrFrxQTJi5NLzGo17RH82RXj8e4gGq7EwWjU+8T8itxRbuh/iaBz3oK/yaHAIiZ9OKwH7ydzxYiWcdNltSAPMUHjbPjXK4HhpRQKB1dvmOW7wwN57IaQJ3g8AdEA3fiDmLYAg+qSnyGvl3vDtJvcQn1F7leECSnB5a8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660354; c=relaxed/simple;
	bh=lOmPfU/eGVZYXYoZjIKS38Xdl1n45B66FHiHc6aVvxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J01Nc8ESzGwYrD6igCvBAl0/gAPs/1GUcFqdF2RDCAsv3tBr8nqL0INBPEVxxBIqZIqyf8VQzNJvjW5ktAwJ3LjkxdQyU/1pW1LXg4/1wyUOk1WBPkX5QISlLlb04WScjhgSXB2JdBS3NdpOAcoXpkGiyUekFXdszWXoNV8AY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsugyoNO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e3f291ad6so3232418a34.0
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738660351; x=1739265151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOmPfU/eGVZYXYoZjIKS38Xdl1n45B66FHiHc6aVvxk=;
        b=OsugyoNO8Fa8C+GvUlzxiM7UIIlCQeHx/hlv3dMUbqOaLJISdi7d9VhaGq/WCRaCJx
         b0lHOpftlfNJkfMYm4LizR/eqZvp3D1BeZglUXIm5Z1aDgZ0d4CBVOsUtt21yg9fHZs9
         sZUzVaO3sBuIt0/0vz66myMiTA04vVrim56pvvE1ZM+cTOEXaGytasfdiDSoPTxB8JTG
         4zfSmAMamdTw4hsln8wid4mqM8LCeiJg2rdefzzbVcWhOVrGS0mlA/wMo83n/6XPrxA8
         ubQhOiNs6wQRk5mQTjr2D+su5lflbEDT0a0GxB9jArBKJYzrzIl9oj+ROfraZsWoLnvc
         V+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738660351; x=1739265151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOmPfU/eGVZYXYoZjIKS38Xdl1n45B66FHiHc6aVvxk=;
        b=ptbqAlHaRX9eYWS5rkfjrIzfy/rI9Tg49Vhhs6kPnZlm9VvWTbX1/jtsVrXynk98Ua
         8GSeF0B5JlycZ8XGwvDcIToVWtIJwsowX2ON94MtLuDmaiFskWSzhtnVNxcd5oaGfE2v
         OGOohfcPAOzbztGgNFQmn1Od0S7PjRlWRQCGLaL+xo4hR4DAMqVeamAJhLt1ERetFnWF
         FjjFth7yvyeaXz+GYsurK7loz/0iV9I3jUHdrc4LOLMZRLQu7EC7SNIOPnorHGtmRJd2
         xgFlstYHF0roOSinJUmV7HtAmA5jiBxn0iTh7PPclnmz2z9vWl1OnWe4w3SqIZm/iDus
         +BSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsNnQLjfn5OQKnueQi7f80xEw697aYCv6Ev9jIro496cF/qk2iCpFpB8dXBJ+BMoI6vLNAAS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8aCjT+Wm+qcmJ9NmVbSo4i92Wgn4S/zarKtVv0sFrs5gtaKG
	gmUryiXNOjlPyPlYmZ+XX/Ots4kr7VFXSgtceO4cVkAXHyufeo32ggoLdPCmlQ3xsDPosxPlpYC
	R97/KQXqx3dqe6j7LlEguWEyy+3Glh7XKoBc7Kg==
X-Gm-Gg: ASbGncstjSTzZRtonRdF+XaZL3euFigciLzGdPmQL1pWIsdXNMell094AGwDpOoDhyv
	FTa9NcGY8EMdKBXycl4o3uvO37oto2ZVzJG5ChCwTztJEpsc1l2cQr2jOQdiJM4bWNuAhzF6p/w
	==
X-Google-Smtp-Source: AGHT+IGaBtWiKIGnTwJFrQeBl34glJPVbOx58PH1j6rhPNeD9c1tAu04EaLX9zcvsa1rWGTAMV8NY2NzowwhK+UlT4A=
X-Received: by 2002:a05:6830:925:b0:71d:f6d3:9fd2 with SMTP id
 46e09a7af769-726568f1915mr14303629a34.24.1738660351634; Tue, 04 Feb 2025
 01:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204073418.491016-1-sumit.garg@linaro.org> <60cd3fcc-5d21-4b98-9a81-f5fbec2099fc@app.fastmail.com>
In-Reply-To: <60cd3fcc-5d21-4b98-9a81-f5fbec2099fc@app.fastmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 4 Feb 2025 10:12:20 +0100
X-Gm-Features: AWEUYZmX7hyL7KTGLrWQk_2I6kQWMPU905QHsNtMHpKEdVFr8ey35q3rQRoHbC4
Message-ID: <CAHUa44EnCdjEfevuFa4rdTykiD1fjU9+GbVq=TSOPaFz1sZpDA@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: Fix supplicant wait loop
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sumit Garg <sumit.garg@linaro.org>, op-tee@lists.trustedfirmware.org, 
	Jerome Forissier <jerome.forissier@linaro.org>, dannenberg@ti.com, javier@javigon.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 8:45=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 4, 2025, at 08:34, Sumit Garg wrote:
> > OP-TEE supplicant is a user-space daemon and it's possible for it
> > be hung or crashed or killed in the middle of processing an OP-TEE
> > RPC call. It becomes more complicated when there is incorrect shutdown
> > ordering of the supplicant process vs the OP-TEE client application whi=
ch
> > can eventually lead to system hang-up waiting for the closure of the
> > client application.
> >
> > Allow the client process waiting in kernel for supplicant response to
> > be killed rather than indefinitely waiting in an unkillable state. Also=
,
> > a normal uninterruptible wait should not have resulted in the hung-task
> > watchdog getting triggered, but the endless loop would.
> >
> > This fixes issues observed during system reboot/shutdown when supplican=
t
> > got hung for some reason or gets crashed/killed which lead to client
> > getting hung in an unkillable state. It in turn lead to system being in
> > hung up state requiring hard power off/on to recover.
> >
> > Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> Jens, I assume you'll pick it up and send me a pull request, but
> I can also pick it up directly if you have nothing else.

I have nothing else, please pick up this directly.

Thanks,
Jens

