Return-Path: <stable+bounces-27205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FB877083
	for <lists+stable@lfdr.de>; Sat,  9 Mar 2024 11:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E643E1C20D55
	for <lists+stable@lfdr.de>; Sat,  9 Mar 2024 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B3364D8;
	Sat,  9 Mar 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+stfkch"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF52BD12
	for <stable@vger.kernel.org>; Sat,  9 Mar 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980864; cv=none; b=PQrtZc7C6mt7kTgdKWf4G5qmVSukI3u4B7AfT6RKLVNl/dzSdwRL7hhZoNm2G1Fai2dFGRher+K5+271GM/V9wm4A3fBspKxvQzzBxOP2UJsBpkKwm2mUC5hBQ/gGt4WBweF2V1+YQcrZaRax4DiFycSO5iXA3m24scmheuIWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980864; c=relaxed/simple;
	bh=Dh9V2PfB348Arae8187yykw+A7d4pAIxQgkMlEODmIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egGiZjvuekCZsKXJdnMLesKhjM3kpxr/YoAqbGF7B7XbD2t9oaLnbKzFbVo3Tw8ccw0tYMTUbf4eF1lgQvwF5Gvy/p1thxaHdtO1qyExdfDZFoptQdgC5aJJpj2kiDMwWWyxPzkCiPzRzy+xU3AOgz64WQ1HX1OkrTiEap4n9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+stfkch; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1710675276.3
        for <stable@vger.kernel.org>; Sat, 09 Mar 2024 02:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709980861; x=1710585661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zwcDfLfy6H/xwTNg7xVsc+HCBPAWPPDyK8ncs4w+gs=;
        b=T+stfkchbw3OzdhVTmml7wBSaHenkNjauK1L1qMQKhTAvvGdhPD7hBCiyo5MdNF/pE
         10bEQswQKQ+p1NQbdguDlUAOYKU19ywyp5araFn/nZJLZoYe7teiKXkl/AatHLWzAdjr
         kbTwfhptcVhnmySU3No7yrH2gAb1hsaEEuqSYUd4CVTukpXM4CIUkoCrMpkxVVAVdrGY
         xUDEt6VXUPJOXM+fot8W3bHdCAZ4gjUhzIFBI/rkTy+puCfc46n5qIk32BB07ePWmvs9
         uzWYwUH0rzHUVO3EdPGceDh9Za/BqBv58TAr4ZUzxMgO+D6JvXp2iqVUFGtSpMu6NGB4
         JtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709980861; x=1710585661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zwcDfLfy6H/xwTNg7xVsc+HCBPAWPPDyK8ncs4w+gs=;
        b=dOCIa6gRWyyWBFaFrULGp4+PKJpe+rbr7bJfqcxs7WpJZzVNTt+4L53NIcSLCT4BQd
         PFl2uGX+6RCxg2LV76fVrBEGOj1u2UEKy1u76orvq8W0pYHrlhdinjmFomGPhVCpa7AA
         xYnX1hTj4HbOX4YIReU2nty1liZtDAepESeHqyTG49YFHoRlYJHuvkt9u57/dDKiImOi
         /ebxmcUXLmL/eoiKQPT3WkhuuxFrMZq/vTxTkbYVV5dBS1Jc1oX0iN84r0z3Kw4mWMu/
         VjaIOd79dEstSzcDm1fd1DV7AMHz0QRbk2lokh/lJFkbPYVqg+tJrlQTYNrHRTWfpGOj
         JwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOPwjqR+BjV249636+mkwVcRNIPQ8p5ytV7EcHK43F17PXPSEi/P8ozEiNRYQ3AWO5/X3i6Ru5B3SCsTtWv6St+gu1uAjK
X-Gm-Message-State: AOJu0Yx0hbkx8c6+7LSDuXBl/KCorxaj0zF/gHfkDmQh6pAI0CdANLm9
	arNujepWHO4+c8FdvJ7BLSPFadaRUEZotG98FTHP1RHttYD/wDP9QpB8M2vPhpnRNFGLxfRMVav
	2Y+1htH4WzFJ/tSYYIoQVVaCDmnqdl1MF9x919w==
X-Google-Smtp-Source: AGHT+IHwQwkSLfesKtrPrMGKJ4Q2PnQLBph1lGKkzbnH0SpIFTbRZI4HlaMD+5FNweFu/bH2N/hGy0XTcTcPw+znj1M=
X-Received: by 2002:a25:b325:0:b0:dcf:f535:dad6 with SMTP id
 l37-20020a25b325000000b00dcff535dad6mr667006ybj.56.1709980861366; Sat, 09 Mar
 2024 02:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org> <20240308-topic-rb1_lmh-v1-2-50c60ffe1130@linaro.org>
In-Reply-To: <20240308-topic-rb1_lmh-v1-2-50c60ffe1130@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Mar 2024 12:40:50 +0200
Message-ID: <CAA8EJpq9bOkv9Ha5wjOjHGdPT7AqTZWnA2SpLNGB99YXP2OmQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: qcom: lmh: Check for SCM avaiability at probe
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Mar 2024 at 00:08, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Up until now, the necessary scm availability check has not been
> performed, leading to possible null pointer dereferences (which did
> happen for me on RB1).
>
> Fix that.
>
> Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/thermal/qcom/lmh.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

