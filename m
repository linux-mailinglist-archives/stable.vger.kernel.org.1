Return-Path: <stable+bounces-202775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8DCC67FA
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6FF307474A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E063375DC;
	Wed, 17 Dec 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJxlLvwO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542943370EB
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958805; cv=none; b=Rb9bRwiCzBDB53CYphl+X4wtD1TyXsTwKXHBGWyLHlr3Br4Ih46GNADrl/msq0c7H5Px6sAZu1eVegEWdBJ6C66Q4EsifIgHPCwJRaJL31c23uDEE2yj+yPEXgqaj0uO5Vm840pRMcqB2i2IqmP2fXr9AtvelgJu4k/vJKlvzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958805; c=relaxed/simple;
	bh=bq7BliE/NjEHPTcJ+hqfuLZ5dvCT2Zv4pztbvHrgXi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my5xHKsQvGz4JZIvbsdJiXEzlDp1bYodl9fFB53YY65d9Ds+STskqluq3umy0xXgbNCA+qM7n5mOIUuA1nKYaYUbQjc+ZC8TbQkJb34D+GP2huPXBBy+zpeZnvkGy+ZKS0FyThvBlkfPM85ZneugoeWjBs074ooD2MbUJBRLTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJxlLvwO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c0224fd2a92so5160762a12.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765958803; x=1766563603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bdB/aSgFib9yNMnSjtnjVwQzHDWZlq9a/a2iwdeEH6I=;
        b=TJxlLvwOW4dDVRr+a2eUuA7SM42N+gLa2x6M7nJQ/4YDvy6I37TWM5kFcayzBJdDBO
         q6y6xQ6L9vEe+tuU3DAoFY+VQSLOEPKiCeXo1lawK8d/jiAzq30+ZfTl4EVqm3yWRQ9+
         OieKKEq+q0puAgWoRFovDOEMAL3wAkbrAETRm0g6vIWYN7IcQTZTap3K10g+m/sBdV0a
         paKy+OIHmSYhRJGdWghuxEum07CI3xfOYqToZCQ4H6Ki8lsE4c9L7L8O+VgZU1oa9AZG
         VatGAg8yiH8uCWpLX8aneHdN/z33qOtxPYt8G+9GlHh5y5rIlUkQtIMySe9YqPKRVlgP
         7kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765958803; x=1766563603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdB/aSgFib9yNMnSjtnjVwQzHDWZlq9a/a2iwdeEH6I=;
        b=hBFg1q279bcwDro/WbZ0H4tEqykLXOBuzVyeNUg3j0PsjJaetpHFoBg5UJ7R6ELUru
         GwDPFzxkbzxN+nX5UHnHPEZgM1NbDW6brmWJN2IefA9lYbyXsarhF1e3Lktl6UGNMneG
         jDEYZiNGqc+iusXNwp9Uq9jw9kEMBnXRi4CCC5ZOMbNj5FQ9qniJ1xFpRC8RNKBXqv8E
         Yvm3iClv4N7nU2pkXBCLfIi9vRcU8VWErRndaDzB5APjZoDFLDtr/M7fhLzr3Q6yOlAH
         CFp9OmyR8jwgpxBjV+T0M9kOqrXBAlUS5a4TYbnUIaM6ZnYDxg+PykG0hXbqWUsyMT8T
         HANg==
X-Forwarded-Encrypted: i=1; AJvYcCXktbAcT5x8EDCH7GLoKe3nnx3QUQg0RWgohaKpGBNdo8Lif2o9UlSnWOngd22sj9pHZDWrP+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgjecywDIO6aDU4JH4TeW/9Ugf42K6SVglU2S9+6LHZat8xMC
	TttMN3bOEF264atoUMBqQTJm4Ep/wtXkQMmxianae7UxEl9sfOe8cRZMCDV9uyCUX+MrUeTF7Ii
	lxzJcgQvkQziJyWlS7muAtFQYrPtzgAB6gk1WcwUa1Q==
X-Gm-Gg: AY/fxX5ZNm/C1qEsrvX/dWST/2PWqygP1fUiu9m9T738F1wMpB39JoHlmKwqJJaXEXR
	9NS/P0EgvI/NzJS+GlDNXk4ChHr3aSv9piYSSOxB+h+bGc0f5uaBIlcdzZCBiPc0MZaZ9CcwowH
	B+Nl1EkSnomRfZNssavoaOklqawm0fHn2BjOstp0loiy0JJ/F25sOpVs+sXvgArBjHLgX46vmbF
	NGeNrLX2Usn9lEx8nH8bkniPySOnBJOu/qV1QAqugtqdhpp9MQkG7bkn83M+IlsHfsBj28yuV6w
	+r09DHNYu/SayihJ2WipdZ4DXBOP
X-Google-Smtp-Source: AGHT+IETkt/jVd6uk/R3QClwG8B5S2yNELg/JhUbEoBFWBg/UTAAcaP0rqWFCRLlCLTgvIDR/ubLYtPnNiiQ7GZIBHk=
X-Received: by 2002:a05:7300:d10f:b0:2ac:1bb1:68ed with SMTP id
 5a478bee46e88-2ac2f85e863mr12003914eec.9.1765958802517; Wed, 17 Dec 2025
 00:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111401.280873349@linuxfoundation.org> <20251216195255.172999-1-naresh.kamboju@linaro.org>
 <2025121719-degrading-drainpipe-fb2e@gregkh>
In-Reply-To: <2025121719-degrading-drainpipe-fb2e@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Dec 2025 13:36:31 +0530
X-Gm-Features: AQt7F2rN0pF4kAzdVPk6eazQcFQyu-jClKs6CdNRybqUHycKnrNF6TQT-vGyPj0
Message-ID: <CA+G9fYvc==Vz83Kka7J84XHA-hhig0CKGHixRVBAzGDv-1BA7A@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org, 
	conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com, 
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@denx.de, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, dan.carpenter@linaro.org, nathan@kernel.org, 
	llvm@lists.linux.dev, perex@perex.cz, lgirdwood@gmail.com, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Dec 2025 at 12:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 17, 2025 at 01:22:55AM +0530, Naresh Kamboju wrote:
> > I'm seeing the following allmodconfig and allyesconfig build
> > failures on arm, arm64, riscv and x86_64.
> >
> > ## Build error
> > sound/soc/codecs/nau8325.c:430:13: error: variable 'n2_max' is uninitialized when used here [-Werror,-Wuninitialized]
> >   430 |                 *n2_sel = n2_max;
> >       |                           ^~~~~~
> > sound/soc/codecs/nau8325.c:389:52: note: initialize the variable 'n2_max' to silence this warning
> >   389 |         int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max;
> >       |                                                           ^
> >       |                                                            = 0
> > sound/soc/codecs/nau8325.c:431:11: error: variable 'ratio_sel' is uninitialized when used here [-Werror,-Wuninitialized]
> >   431 |                 ratio = ratio_sel;
> >       |                         ^~~~~~~~~
> > sound/soc/codecs/nau8325.c:389:44: note: initialize the variable 'ratio_sel' to silence this warning
> >   389 |         int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max;
> >       |                                                   ^
> >       |                                                    = 0
> > 2 errors generated.
> > make[6]: *** [scripts/Makefile.build:287: sound/soc/codecs/nau8325.o] Error 1
> >
> > First seen on 6.18.2-rc1
> > Good: 6.18.1-rc1
> > Bad:  6.18.2-rc1
> >
> > And these build regressions also seen on 6.17.13-rc2.
>
> Thanks, I'll go queue up the fix for this.

This build regression is across the 6.18.2-rc1, 6.17.13-rc2 and 6.12.63-rc1.

>
> greg k-h

- Naresh

