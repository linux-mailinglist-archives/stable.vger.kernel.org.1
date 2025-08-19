Return-Path: <stable+bounces-171767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72078B2C091
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B94D16352C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4DA32BF27;
	Tue, 19 Aug 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9T4dDTq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91222A4D5
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603061; cv=none; b=mBS9ejO0SsQR8i/h3R+QvavkeoUffTCm4bs4A4TeXmK672Llhy5KSs1UYPmCiXAkvr954qB+1J+5FUK4IRg8DUAAhm3FZslOPMZZYt5ZlbZ4vMguZ4hUnO2adhcwxP4FG4qII6jq/9LJOf7BateQXDkrIyeWy4Tvba3jp1gMkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603061; c=relaxed/simple;
	bh=RS+DDBsenDMGRVRuo5OpJ0by6/pE8abc8eGvwv3Szfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAlUoC8gOMqOkQwwmg/u0mdMvFMNi5sAzyWYd/MK5vkxPWOBROwoWhsZI5CURKgp9ux/NlABav+HrNfj4r4qXSjzLfE43XjQNex0iAurUMLdiv0NL1k03cdxH5tIXh4N+V1TtFxGAtwJMSg0hHGKLIzLhGL1/hmdoqY2tm5TUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9T4dDTq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78ead12so730338166b.1
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755603057; x=1756207857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZSqNXnF5cFT3EKTsD5C3uA+ixCm4MLZap6H11YwJU=;
        b=I9T4dDTqJjS4jq0QjdwoeWQRXmAWQvbPFYS0e2u8VTGBYdjWEzZ/5mLK0pq8JSOmzG
         lXFYAAjqgvVOUUFneeHZQHh59gCz6bx4698RZzv8hIilHrQdFIVDIq+LWklvPojeneh/
         TwXkl86vCC386iFAX5MRIBOWge8IF5SSdTWrtvVGmcbzn2u8jjG5OHetpuj6OR6y3MSW
         op9kDqoS3OsCu0iHBQQkaXfVQI9DKBVfvlbUFu8v5SAQuikPE/V+/VZ+orSALcdatqPe
         MpISU+2sKowBpbhlDX1wYbmrLMunlSudUJykGUdotRdFbm8q2IawSVyMEhTqags7Tyzg
         Ocrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603057; x=1756207857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlZSqNXnF5cFT3EKTsD5C3uA+ixCm4MLZap6H11YwJU=;
        b=J/k0oJwC9Gs4s5PoXtM40FHhX26WNk/uuRW4u2VoEmutW4jvMQPIOb5YHhOe7A4N0P
         a1xxCpnhcYpywTEpUY013FHPjcBoBVjZ00bbTBiMza6SBtdo3P0t6b7HCWEDK0oAvkfI
         3cLsTf1rGmvgUQIrPIj6tjihPt1Wu07eA2EB1NhJ6lhUyAZP+w5py0z6r54U2Eq4VXQj
         wU5PGlMn5rS4XwJ7BjupY/cNNMLecm7H+rimTdnRqgsM8wTR0rXdPOHFNUzapFyCW9G5
         OvWplVX8fmh0ybrIdGJrGVyV03QMeOvEnR2O8tCG6Y21nYfiklaxHs+FK7CoYIthD1Ri
         15Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWeMrqh7X7ndkfpliSiHZefZO0xGlgdksLlTQczdny1DLRtEv3Yl1aga/Gf0NbEzxA0yHClRLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeF4zeBWKQNfERghWCgsXM/Gh3Jl7lgMliKLSd0pF/pSd+Psq
	u7eolUJfyMk3b9T1vn6neB0OBXa+3Z7+PJeqWrzcIILTPdte8EsYDGas74zUepo/wEHjFsmm41h
	LJvgRxsAJYyDdz5sB5rvGAt2tTkdPIwpBtWVjsnRc7MWICs8eC3zYkqU=
X-Gm-Gg: ASbGncsj9Q+IZe2H0yOgJVlyGnkGL4kXxm8V/QgIFeot/cnAPGA60m/FhuWRILG8L9u
	83U097eBmJR2hU/5NMFJ7VFpkv/Hw8AXAbjOzMWXpDCfqbVK40sSYnyfiWnUT4peynKevrrAnKo
	W8tXu+6ZzSpMEUX+vo/fQgvNkOdjAWS1VLRMUzdaj9T5c3B+SLz9SOz7uBNIHxf3mv7qgkymTGX
	mtQ
X-Google-Smtp-Source: AGHT+IFc1qeOeB8SEpfLr5OOLAFUUqEj6GU45bLARYtHghlfX/crq9PpWhn+VH6PLkjxDEuyGteYvZKpflusqa5M/Ig=
X-Received: by 2002:a17:906:c115:b0:af9:57ae:dbb3 with SMTP id
 a640c23a62f3a-afddcb81908mr192322866b.22.1755603057341; Tue, 19 Aug 2025
 04:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124458.334548733@linuxfoundation.org> <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
 <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
In-Reply-To: <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 19 Aug 2025 13:30:46 +0200
X-Gm-Features: Ac12FXyaJepFNIeos9w4tdtDWEq_utvLUQ4wMo0fo8sqlMNsdeJO5hMNv6oFTrY
Message-ID: <CACMJSeu_DTVK=XtvaSD3Fj3aTXBJ5d-MpQMuysJYEFBNwznDqQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, srinivas.kandagatla@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 12:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 19 Aug 2025 at 00:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> >
> > Boot regression: stable-rc 6.15.11-rc1 arm64 Qualcomm Dragonboard 410c
> > Unable to handle kernel NULL pointer dereference
> > qcom_scm_shm_bridge_enable
>
> I have reverted the following patch and the regression got fixed.
>
> firmware: qcom: scm: initialize tzmem before marking SCM as available
>     [ Upstream commit 87be3e7a2d0030cda6314d2ec96b37991f636ccd ]
>

Hi! I'm on vacation, I will look into this next week. I expect there
to be a fix on top of this commit.

Bart

