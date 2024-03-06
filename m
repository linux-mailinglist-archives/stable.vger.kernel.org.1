Return-Path: <stable+bounces-27017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA518740C0
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 20:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA011C2120C
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A0140E23;
	Wed,  6 Mar 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yro2YoIx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD714036A
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754577; cv=none; b=EIPJ18Az+8ld3CiMyTioj+nPEtYqh87w+TxwaAb2/V8bFOAFaQYZ1c0mfrG8LqXk1E9FflTPF+kCMEjfnl5tWJwos1TF9f3nCKl6EWNpMYpF8LHCD6moHYuzLT5PSXdI2ho9MVmAnCL1kcWAhvdOfq3GAwB3erb1uQ48ztzGKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754577; c=relaxed/simple;
	bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWLCLfeqPca6g93qA/a9vdAV2KwMs6OlBbK7W3JhELhdbv47+Qxc4hZjsIav6PTbEIpcwu9FdiqLtDRTgXLIM3W7vCEE540ZBb3uGuDr+3tO9t4A2c0yeKDQ3JhJ9DF94gIcgK+r4e8eXqnibshPVsqb6xKFtxKpRxG6JUnw/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yro2YoIx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-609241c2696so1263857b3.0
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754574; x=1710359374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
        b=Yro2YoIxVHiCUZZqMZDh7Vr3vscV+8B6DQ7IKlmr19lRxBaYtcSxKoWbO0k0CgaO1s
         KSUuDORKC92XCwxtV7sv5hpRRd0fbVnpj8MFsbIYgSC9/TQ0B9Pl/fz3yHXbfiW15jR+
         svnOfGaQnFWopnVSrmpwmYailosH76Qg1dq0rlxkDF92UNiM+bbmnVJmlshqJPfmzW8K
         5amp/eVG4vLeukWPqoYzw8CMfiXdpohgmU8cnqnOIoTypNPQ66Vy/jxV3zRAGyMlIzHJ
         z3xaS4RNHAfpdko42h6iUVLnZ/t/09AGUDvazF2SUXnjvcHpFnknc2zvDIhZKRtCpwmf
         Hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754574; x=1710359374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
        b=P9njENl4TEsEQ4UJzzNbWDRxfyj4buI6hFkhT3lSlBC57JTcbJEhaGrkHmDWnpN71q
         CkEOJZfa0LbBWpjPbS+t3b1+JUJjwxAvymTGsbWkKZfYBNPJ7PPaZi0A8BzD6Zxe0CfJ
         1ovl5o9CFn+kbaMd+ARvsvLSYRYC0WREj3ivndB2RFiyRMNBivuaKTM0bypLmEOzJvDj
         EqplLU5DSJw40HOlLkIDtE53SOuDLSYMYxPCEGucMqThVM1ZeEp6rYVIOtmXeAV1zSia
         /lt5e1MwwrZdqF6ngvGA58NNc2LjC3QK1jWdESbS/yYVtYCYBzte3w6iYxkK4BO2SoBX
         nJJg==
X-Forwarded-Encrypted: i=1; AJvYcCWAiHtu2iPrW5ObsnhmMRyeFT9fL0j+MyEtheWnohJWFZ/iWdS5tnPLfdewj+mf0VbCCLtDJEGjPLQkcgykdNXdTKNj853J
X-Gm-Message-State: AOJu0Yzzxxb/Bkl8X579xvgaO7Ta4WiPTmKDklgCNPvuGlpQw/rNJkdQ
	FyBQyzPLPtlvwl/vJc5jhpSN4nBM1sxwMWP9ct1vNp9AS7rPhN/Hot8Q1DWDMHWrVrdYQ5/X3i4
	LgHBeQHzjVg91q+AsRfpEVqAJC4Y6ldBWj/qAWQ==
X-Google-Smtp-Source: AGHT+IHxsHr/alraTiTEqBEIabc4AtN/z3ZG5Fo2cAVhC41CbFpwoSrEAqQlrDjlml+vAdN3ScgmBzzdVF0/UxuJffI=
X-Received: by 2002:a0d:d4c5:0:b0:609:dbbc:451b with SMTP id
 w188-20020a0dd4c5000000b00609dbbc451bmr2705058ywd.23.1709754574622; Wed, 06
 Mar 2024 11:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
 <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
In-Reply-To: <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 20:49:23 +0100
Message-ID: <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
> On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> wro=
te:

> > We should probably rename it part_cfg because that is what we
> > store in it, it's assigned from card->part[idx].part_cfg.
> >
> > Then the id field in mmc_rpmb_data should be deleted along
> > with all the IDA counter code etc and the partition name hardcoded
> > to be "0" as there will never be anything else.
>
> Seems reasonable to me. Are you thinking of sending a cleanup patch on
> top of $subject patch?

Yes I can do that once this patch is finalized and merged.

Yours,
Linus Walleij

