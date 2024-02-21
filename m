Return-Path: <stable+bounces-23248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B885EB85
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FE0284245
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE512837E;
	Wed, 21 Feb 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTeeYe+9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918883A1F
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552904; cv=none; b=TUxW5ki8JQshtsY/GBr1ZheQyrRIe1Jo2bV8htdwEEzxGC/lMi0lD3QCP1EDa97tUy5F2ZHeXenmndv4j6jp0/Mh9RERuojKIZBrn7eEO0KKxIFpUYlow3IO8PKsxqlupj6onUK1+Zcn23zkh8n8b3pcU8HSudcTeviy+aSC9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552904; c=relaxed/simple;
	bh=iNw2KqCWmRNQPgf2kdh7zI9t8Dz1bKx9uiQC7k43/yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRXoYknzMkBBS9CwDRR+kS0XaUy1V+x5OCMWeVh8Rm1c1/umC1FGHXlSQGqmsP2lEuxRVCKrc+u+yyWdahjvD8lQNPK9t/HA49zjx8oS2B3yIqY645Hmg41mOWRgou8A/ZHzIE6rlV4P5iDXxzjQEsxtL+8rP13K36mk5vqbh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTeeYe+9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso1309416276.3
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708552901; x=1709157701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNw2KqCWmRNQPgf2kdh7zI9t8Dz1bKx9uiQC7k43/yw=;
        b=kTeeYe+9mzFWcwOls8v28c7uAyZJn+2A/r2fRPTp6DkUweL/tC2O9MF/P0xieaXz6F
         YxwdpnilpfASWSKMzIvfnJePfYkzSkMWQmEFpfE8ftwVWSlnCbrijpjZReIMCU/YYeNB
         EpnTnnax65u8RYJTY2+rMUXTIsopidhF5ArcxFggcwMNToDXmdAEUeJ/p4bDB29dufGr
         qmGPgSim1L1G2wdDZBnP64RBpz4Jy/R+gXq8nSAJTM4J+ZOYKLLk/a3hbYihySkGhOub
         i+p5H9FaYqf7trQRAoQUX90+8J7st/5GSW6qm4Ur03RKNknacDIm6rasgY02JYt9u+xx
         P3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552901; x=1709157701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNw2KqCWmRNQPgf2kdh7zI9t8Dz1bKx9uiQC7k43/yw=;
        b=QdHljbAckNcSzLT+sNEH82LBGeDIyKdsd9L7BvpVUKnswu7RLUTozuDge/regdOlzc
         Sdz4yeSihcdHH1NtjbA16PMfko3ip2dgZSLr9AFEtHNzTeoI9iJtVn0gWOzW23Ps1mH1
         PkwbKXlTN5kYg2vNfXfClj/LjKtdFDcFXlJjsmVxgB9mKFOcdeCWHmBZHn6F+3aYlgGP
         8Z/hoc4Hj7FAfObgJndI3WziTZJpJsgWB1/8LrIMb3Yo2Y/r/X59kahQSfBrgfEVm3Lv
         W8LCjHVINPEH3e2nMO62IiI70XkhbZRbhL54Mik/+y6rg3mA8EFLwUP74e0t5Tibkcz1
         XJdw==
X-Forwarded-Encrypted: i=1; AJvYcCV3AmBwtufbrHLwIV5AV/Tm/Z4ltzrZxRhThbD6KnJh77eJtkYSvxmE9IW5IGshUirucYc2afJV2kG7CiGEVduuGSGWWDTj
X-Gm-Message-State: AOJu0YySl6FCMf0H631P+dqjGMazXFBYlBJsHbx6G9s5ka5zSEV3rKWx
	HYpK+j8sX/GT0M3VtJVo6Qd4MEX4SPvaKFn0tDGS9qV6RQA6DemlDDD1ObL3vbY6vg8FUijZgAt
	ncjdiCqzG1wJlWgjeZcnbj7d0QulvuKdTCg2T7Q==
X-Google-Smtp-Source: AGHT+IGt7B28bXGqHFPzSlnPE3u5pmDcd649uWARD4nozEqzjnhA0mNDtNnmwavCtFt30Cy0Tp2XEPHZZyHNc1h1yjc=
X-Received: by 2002:a0d:d905:0:b0:5ff:9aa1:8970 with SMTP id
 b5-20020a0dd905000000b005ff9aa18970mr21216281ywe.34.1708552900788; Wed, 21
 Feb 2024 14:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216102435.89867-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240216102435.89867-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 23:01:30 +0100
Message-ID: <CACRpkdbOEir0x7ivXRdMgdi+Sk2e1-m9u2pruh1-RWrkoNd41g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8650-lpass-lpi: correct Kconfig name
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:25=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Use proper model name in SM8650 LPASS pin controller Kconfig entry.
>
> Cc: <stable@vger.kernel.org>
> Fixes: c4e47673853f ("pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied as non-urgent fix.

Yours,
Linus Walleij

