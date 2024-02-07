Return-Path: <stable+bounces-19078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A384CD9A
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA97284E1C
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC265A118;
	Wed,  7 Feb 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdiLXX2c"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A877F481
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318245; cv=none; b=YyVtnFch10DbgF0ZXsjnrogfIKnNI5/EK4gsWIqTFDp43W81fF2FtrlaCi4VgSMwh87f9VUwX4mqV0H4KFXxoI5cnCg2EbjJahsY1YaVRE/0vqWf583JGw0ONnJIRphqpSej9FjhoiG2kZ2Lj/ibjO8vaa21ll+wohBWGBmUpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318245; c=relaxed/simple;
	bh=I87ABi+TTrDuBafniC/PL+SYU/E2xqbbxV0VxETwk3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpebA58PdgF+HRcWJ098ja1dhXCV/Ikj69Pts2iQCxgb4UjM96eFaHNNMitTlXVQffZXDq2djin9e+VzRdDf6EqqMl6SidBSXm+YWKnXrxVaRm3cFBiOSairgL909/NA5hbadon/YfLkTRCFON7ODtPco35yp0CsoLFza39/Q24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdiLXX2c; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3810e975aaso98952966b.3
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 07:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707318242; x=1707923042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekyRb1jmMOkOI68xzhu6ghCfzzpSW1u5Hc1zwdlq+5o=;
        b=hdiLXX2cEgIB4BsoZb5dRt58iqBF9zujnVBHIkqHNqB7MeVCmiNaRJMsPbmH6EXgzd
         VzpIUbq7HtOCgHTZEC683kqoI0eugMvm7hxWSYJ8XUuXJtjPlyJzj2EUxWiK0jFzSWKl
         27Dr29OGmITyP+KKzTquCI1TU09iXT+yl79WSClJxbycRNY/ImFlRVZQ2ZofZqrvszH2
         L6uyULdI4s/DNZIxZtJRRuBqb9zNVP04ggyXGU+mZZa2r7CIig2YNIrfgSUz/yMfsmAm
         U1es0GlPlrR3D1x5Ray+ZL6kWX3uZTB3YBJD2dW7b759iybQAq5oD9DyWna5o3x+HILx
         4QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318242; x=1707923042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekyRb1jmMOkOI68xzhu6ghCfzzpSW1u5Hc1zwdlq+5o=;
        b=TISGASZKmc3c50NMRPXXgkdoATmREM4FZEoWYBKl6T5D14r+J/FQH2zjKJiVQe9XEA
         bJirqa8Vmk/LHrDxVps/WSjFljebG/W7GN6+q4YyPNDP1wGPDU0bMj663MMBm3LqkfC1
         pjz/pQNZAewujtBOkw/bvtwXUzRfa9A/WlI4bG4A6l25tWcJqxE2ktqQi39nh64vl6wf
         ep8a10Xz8K4pQNqZUqFajRIW402BUVnUKdBtUgr/vk4T6wmRAPg40ecyt916YlASLrAK
         9LmiXeD2ZFxEoj3NZMLaZn9RDGu69CBg/WIiQ9s5RHIXZSoZm027+ivXGxBJnm9iIcrB
         RidA==
X-Forwarded-Encrypted: i=1; AJvYcCXxklxu7mPH2VPQekN7vr6ynADqvzVfVb6hlkxqi1mVmiM1+DAl+F7fSTHNMezHmsqo6hc7zMkFLYE0REZRlvqMpg62/mMd
X-Gm-Message-State: AOJu0YyE7n8gcXlFJ2j+pjdiGPbgJBlhp5dV8UAoe41I68f6AT0s+Y5j
	ripZzWS1Kj+7jOJxw3OaaZrnBti36hN6YiAH5S6rL2FPaofA0GXcjrbU+ZhrfFymLYFItT6xObi
	iWxxSyt/3otvq1juGuhlQ7/UwlN7t74BvXV5h
X-Google-Smtp-Source: AGHT+IHTli2pAHUoJrCsw8RIEWALTQk+BoAv5NH4xK0yYAxfNkWEMUQAL5bQpZTsGV8s+Yd3F2Y+rtpYpl3PRIO57n4=
X-Received: by 2002:a17:906:1b4f:b0:a36:fc15:d724 with SMTP id
 p15-20020a1709061b4f00b00a36fc15d724mr5051540ejg.18.1707318242300; Wed, 07
 Feb 2024 07:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh> <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
 <2024020734-curliness-licking-44c1@gregkh>
In-Reply-To: <2024020734-curliness-licking-44c1@gregkh>
From: Joy Chakraborty <joychakr@google.com>
Date: Wed, 7 Feb 2024 20:33:49 +0530
Message-ID: <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:04=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > > Userspace will see a false error with nvmem cell reads from
> > > > nvmem_cell_attr_read() in current code, which should be fixed on
> > > > returning 0 for success.
> > >
> > > So maybe fix this all up to allow the read to return the actual amoun=
t
> > > read?  That feels more "correct" to me.
> > >
> >
> > If I change the behavior of the nvmem_reg_read_t callback to negative
> > for error and number of bytes actually read for success then, other
> > than the core driver I would also have to change all the
> > nvmem-provider drivers.
> > Is it okay to do so ?
>
> Sure, why not?  That seems like the correct fix to me, right?

Sure, I can do that.

Is it okay to change the if checks on the return code to "if (rc < 0)"
instead of "if (rc)" as a fix for the immediate issue with how return
value from rmem is handled which can be applied to older kernels.
In a separate patch I can change the definition of nvmem_reg_read_t()
to return ssize_t instead of int and make corresponding changes to
nvmem-provider drivers.

Does that sound okay ?
>
> thanks,
>
> greg k-h

Thanks
Joy

