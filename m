Return-Path: <stable+bounces-69547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703C9567E2
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F6D1F22D54
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768315F400;
	Mon, 19 Aug 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmR8pEPU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8F15F3E8
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062361; cv=none; b=lJF3uii9o4Ow/9Y/ApUkAEGhth/Gx/jJPIJKg0iMGD0CyLsaK7yIfHLP0zmT8ifKfSHHQeC0KgOB8LUicu8fUAUFTYKQLm3DSrBq5qjAvwP1Jde8fnKxkYI4JOljivKTrv+mXUPgPzPoRACQ6X3QO315FwYiTG0FZC1ECFQkHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062361; c=relaxed/simple;
	bh=vZo2/t11CLRtBFZBAyg1Zxki1cpdcGREz6Qnn+hDfcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEIcN7dF9/HywM3Afh/nGVVEu/E1VIsydTYazDMYj0GRrR66/ecj2eKVSKFARAxUH5soGvBWfcEuE8+XDVP9rRYK//4SssoRkIqWOV0GXd/073RAQwwPcsUlVmO2oBoA7uBShLyHBi2WWtlCuUe5f5EaDPaVhv44YqnYctDVp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmR8pEPU; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f51551695cso1496163e0c.3
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724062358; x=1724667158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kEt0b7cjq1QrC31R8bsvHblz1HFMuMei5OYtb8lQy+o=;
        b=BmR8pEPU1VaogzGC6Z/pQ6JpGZ9grHlNGOh48Ws5+Cs45ynNNrPLJfDjNt8co34Uh5
         FslywdTU02UImtBCBv8kNDr6bJd2jda48BPHpz4ribqqZ/9XMcwoX69WmU468mql7GIe
         GZzb716s7J6VDricJch7X5gYOqLirnirpX7MtfmjCICxOUR5rmYuwdbdlTibKTb0z10X
         uzgSJrF8W2+Rs5fwuMD8k2g/nPyminamEOiH2zuH8dzZEKjCyJLRQKGSEy52NXmhU2iA
         imfyHDUnhoOohxwOJbojOHI8JEWKQ7dcxfS43duPAn1v4KANgblHtPxODU6RZturkAwG
         mhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062358; x=1724667158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEt0b7cjq1QrC31R8bsvHblz1HFMuMei5OYtb8lQy+o=;
        b=S9hbCtpBk36ipJSOA1D0maTifFC0PyOJE1k3OMr5KbB1uHiw7PCdfoAYs108edJpo4
         ViQ1G/hA0ZvPTJpMr3QmsExESbP59StfI5dyzrIbORxgIBrHa+Z/AbCaKcJRhi+/RzIN
         ura/kytkvbgbqYTXBvdfkdJv+MtwsfttqDW0hQQqbGEmkIz3qkmPK984zKtP2UZgr7Im
         i1/QVOqPcfWOZyl35hYHpvpnzMYLPfnizMPSVOqUbd8RbZThFKxfwNkbOqEKJGcI69/U
         ZvwS9EETkRea06RyZ/6WFn2fMSSBtrwnSL0KIHII1SMf+0+d6wo41xeUwlEaBgCUk+BP
         ovBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYkN4VRHGcBruvzrlTQv1vCstp80+mc4XKiL1Z6JtZM0Lr4SizbN3T3LAM1xgR3xb0rRz1NyBQYT+KSvFI2FwcFHyypDC
X-Gm-Message-State: AOJu0YyJKls140eh5lh83l+Q1n/xOw4D8/H157vD8cO0ErvqQWg1s2Lk
	7L8y6OiQ0tP6x3JeX+A1Q70tKDf56CqYIf1myI3ySK9d0z28/8h/W9rjgG31pvoW9FnOZnGEFPS
	jhRRpVEmDYfsmW0MzyMODEQq/+52kAmGXcfQTGA==
X-Google-Smtp-Source: AGHT+IF2X6KST38O2iXNOkEv4ma2f5ghfmUPtcGSPzix+b5Pd5uLiS8hzIqnRvab+YafaLZfxCL8wAqGZ+nvTGAWzos=
X-Received: by 2002:a05:6122:4129:b0:4ef:5744:46a with SMTP id
 71dfb90a1353d-4fc84ad5a54mr8021886e0c.1.1724062358099; Mon, 19 Aug 2024
 03:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 19 Aug 2024 15:42:02 +0530
Message-ID: <CAMi1Hd29PWjsS_kxPpFgpW23xpSq6n6uqL5KKFBvQwe7df0W-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Chris Lew <quic_clew@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 04:47, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Amit and Johan both reported a NULL pointer dereference in the
> pmic_glink client code during initialization, and Stephen Boyd pointed
> out the problem (race condition).
>
> While investigating, and writing the fix, I noticed that
> ucsi_unregister() is called in atomic context but tries to sleep, and I
> also noticed that the condition for when to inform the pmic_glink client
> drivers when the remote has gone down is just wrong.
>
> So, let's fix all three.
>
> As mentioned in the commit message for the UCSI fix, I have a series in
> the works that makes the GLINK callback happen in a sleepable context,
> which would remove the need for the clients list to be protected by a
> spinlock, and removing the work scheduling. This is however not -rc
> material...
>
> In addition to the NULL pointer dereference, there is the -ECANCELED
> issue reported here:
> https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> I have not yet been able to either reproduce this or convince myself
> that this is the same issue.
>

Thank you for the fixes Bjorn. I'm not able to reproduce that
pmic_glink kernel panic on SM8550-HDK anymore.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Bjorn Andersson (3):
>       soc: qcom: pmic_glink: Fix race during initialization
>       usb: typec: ucsi: Move unregister out of atomic section
>       soc: qcom: pmic_glink: Actually communicate with remote goes down
>
>  drivers/power/supply/qcom_battmgr.c   | 16 ++++++++-----
>  drivers/soc/qcom/pmic_glink.c         | 40 +++++++++++++++++++++----------
>  drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++-----
>  drivers/usb/typec/ucsi/ucsi_glink.c   | 44 ++++++++++++++++++++++++++---------
>  include/linux/soc/qcom/pmic_glink.h   | 11 +++++----
>  5 files changed, 88 insertions(+), 40 deletions(-)
> ---
> base-commit: 296c871d2904cff2b4742702ef94512ab467a8e3
> change-id: 20240818-pmic-glink-v6-11-races-363f5964c339
>
> Best regards,
> --
> Bjorn Andersson <quic_bjorande@quicinc.com>
>

