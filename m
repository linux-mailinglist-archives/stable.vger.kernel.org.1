Return-Path: <stable+bounces-72693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A09682B4
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2331F21D8D
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F6187356;
	Mon,  2 Sep 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuD8bzvM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35B1311AC
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268126; cv=none; b=B08KzGqC79J8RWTGbfAHqWxYW3mg5wNapBu9KL2FWdKmRzLSKzUThCm60EofVaVcnOVxYRyinoS9Twl2M0lMHXi1qCfHFbvfE9OZR9YKy/ZZzNkQ++c7iy3bAiCdWJo1izGiIMb+Ca+sd1/UoWVJakUNdFzbCknkuPi4yERMSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268126; c=relaxed/simple;
	bh=ItlPypp6WrCWIb6a+iZ6UnRF5dm/ZOiMxnKIf5htWU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaS9h7qStVzjFkleqQ8yjT2RtD7OHu2+3WWbJVRh4PiKWFTr2t+at3wSfs+B46wNCIHPRcCzG8PudVKMDXkl2Y+0yrua23absDGKganYHh5/3zLVrcy/RMY/i1xRt8AgDH7GXeoV1H0MStcKv6nZudrwUDWL2baSHE9Xu6KpzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuD8bzvM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53345604960so4424464e87.3
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268121; x=1725872921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItlPypp6WrCWIb6a+iZ6UnRF5dm/ZOiMxnKIf5htWU8=;
        b=uuD8bzvM5C/y53wR6FUbASg+81EL8koD7lGuCaa/PrYnbVC4tphzuiUMNWzrPBrvkn
         QmrRjFFLVscLw54V0oWPo058hxyxoe619I0jMbd26JFST4M/LG/XA/pNL+Eg7EIgj1yI
         3CfAkGCJKLMxY1F2Uhhzbfv5eoI+EtVzU5uZlScYbhjkdBlZB+/DyNjChHXI+DIkO+4O
         QHXHZGzPT1a/4dQkldFj+dc/B4YhywFYcOwi8t+pONPkbLX9TGTGIPA8wWkVgTFCYKTm
         zCoYqIjA1eLMg+jP+u7ycYXFzBGK/9PCtOeubwSE/axuDrrFy41t4mmDvbOT0HTPNiG+
         hbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268121; x=1725872921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItlPypp6WrCWIb6a+iZ6UnRF5dm/ZOiMxnKIf5htWU8=;
        b=QQ9IUfHQbVmvrWQ8R+ZsKcW4/pDkDj0AVyfU2arnTUKyOTo1MkjL/eIDbJ4o3x5Vdu
         gF1/DWLKXSCl69KvTzgzWTFZYhey+smPEJxwSSNsKfukSF4YSfIwothFpavls8Ltb8Gu
         a5lDE5ixUvOB8DIae7El3vF6c7rF2dNyeclmxKkdK8ZQS6qXPX6gyaaw6rK+pJl6hbBc
         tzDDvXhh1bOHO5hAmq9R0+7W2MXPeFNQWKatsjRg184OGgoX8B8RHKuGGnTcHwVWxl55
         eWNUSF9aUI9T+3hyst/9nVNnZmouEiw/36ONjzzDMOj9UavRrMM4hdVN8efEGvQRze6e
         2u8g==
X-Forwarded-Encrypted: i=1; AJvYcCVa2BRITAjA/SHUMU2WERyV1r33UShOod5L8tXywrEx2DD6FwpbHcheLU1qz9YyUXut2JIRc2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKT8uTvcVSxbK1tvpzUCF/yg6iQ0rratlNbhS+X7IPrA0zP03r
	hMBO1276SCLD+F+RWbUGdnDwom5x9iUXJ/eD2cGSdgstFaaXpA/cllEl/HhG0mQpdpbv0dl+aQO
	FW6H23xSV9kz20Sc1CvfOwjw6jvpws6E9NCICWQ==
X-Google-Smtp-Source: AGHT+IE7Gmr8DRXU57qN/PlvHfcPdekTg2Ympj1QWPZ+v6eYceQhpU7ghw98R1G+yXBVxygGtcP2A1ooOEzFQ96QHpg=
X-Received: by 2002:a05:6512:3d24:b0:52e:a68a:6076 with SMTP id
 2adb3069b0e04-53546bb4d0fmr7358027e87.49.1725268120534; Mon, 02 Sep 2024
 02:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830-x1e80100-bypass-pdc-v1-1-d4c00be0c3e3@linaro.org>
In-Reply-To: <20240830-x1e80100-bypass-pdc-v1-1-d4c00be0c3e3@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 11:08:29 +0200
Message-ID: <CACRpkdY97ZOOu66FkLcCSF9vd5uw9N6i239t8aeuaAR4B_ccxA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:09=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> On X1E80100, GPIO interrupts for wakeup-capable pins have been broken sin=
ce
> the introduction of the pinctrl driver. This prevents keyboard and touchp=
ad
> from working on most of the X1E laptops. So far we have worked around thi=
s
> by manually building a kernel with the "wakeup-parent" removed from the
> pinctrl node in the device tree, but we cannot expect all users to do tha=
t.
>
> Implement a similar workaround in the driver by clearing the wakeirq_map
> for X1E80100. This avoids using the PDC wakeup parent for all GPIOs
> and handles the interrupts directly in the pinctrl driver instead.
>
> The PDC driver needs additional changes to support X1E80100 properly.
> Adding a workaround separately first allows to land the necessary PDC
> changes through the normal release cycle, while still solving the more
> critical problem with keyboard and touchpad on the current stable kernel
> versions. Bypassing the PDC is enough for now, because we have not yet
> enabled the deep idle states where using the PDC becomes necessary.
>
> Cc: stable@vger.kernel.org
> Fixes: 05e4941d97ef ("pinctrl: qcom: Add X1E80100 pinctrl driver")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Patch applied for fixes, excellent work as always. Thanks!

Yours,
Linus Walleij

