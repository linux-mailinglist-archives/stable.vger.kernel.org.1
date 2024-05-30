Return-Path: <stable+bounces-47708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14558D4CC9
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E9D1F22EB6
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179E17D884;
	Thu, 30 May 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pXEVbgt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718B17C20F
	for <stable@vger.kernel.org>; Thu, 30 May 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075844; cv=none; b=f1mRwJ+vcNVlnlKi3YtVnB/SoufGgHSb4434VhDWFMHd1khqCRtD7ckioJNZj4xt4racQfwJhqUFNf+NPpkYKUYwaKtbZa3Gi9ot2ZFDR8VrG721My/SvN1RW3p+WpsgdFT8607vaaif0INcgVp/omj00LwlnmDegArnRibQ5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075844; c=relaxed/simple;
	bh=EbCIr2vQd6v/UepcBv0vSQxRCcD51fuU44nOE8Zqcjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQO5W6vr7ignSUS2+Ew12rBO8OvCRuEBU0+A1TlVLi4IzdL1IWTmSCwV3WtDNnB5QCOkGv+TPk8sHrOrxs56/R6IsZasfIokA+81bHMvL73o3JvoAb0CnSl7QcTCVXtRqRfO4IIdsYpDA2+7m3xVberbMiUKyU36F7J0lNfvxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pXEVbgt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43dfe020675so342201cf.0
        for <stable@vger.kernel.org>; Thu, 30 May 2024 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717075841; x=1717680641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZXkKgvuTnGu9jT+KUX2KYjiff1KxpNRdNPNMddfEKw=;
        b=2pXEVbgtfXNQJ5sh1DI8ef/nsyKgQYPEqb3anFO4GRJgSXCMSvuup1WZ8Hp0Lpi7W/
         UdXAvRY+PsZnPBMLTBtPsCGjiXRHCa5vEXsVvkB5Ob3wqfwos8v9raLid2XIgqkYaPp9
         i5qtTcGFXJSvYRp9/QzMzp2MLtsGmV62jMgSlmYU+Q6U5puBVf5j1okpy6XbZs+59g0A
         ixn4v81VxNAMyZx9++924/+D+lcU2B6izFXzj6HztJ1aUn59zV/D9eMESBgmfIEgrS8I
         bpqNWb/W0XTk7A0b2/hwheYYSUzaD+oNxV31J055d3AeBfUNFogJGiTOxRMKcJDWN8Qp
         YKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075841; x=1717680641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZXkKgvuTnGu9jT+KUX2KYjiff1KxpNRdNPNMddfEKw=;
        b=an8mB3H7zhrrT+ttE90l5UspEcQxkFYQ2FY/W/7lw2/D9sowrC3ogFNfNGyn2whBTO
         JTHueDYIxm4Si+BbMPSpdB2I+ZP6ejTowTJlQE5BYTiOGqvo/DIdUV7HXm3PivqQbfOy
         MjqjxSWDyb7K3nZV0ubW2YSErGUTvIRekmqym05tAZCCO+Wp/AcyKR2+Xo5z8S13SfXy
         Z0WnUBXlVoj1WQ9NUWyNu6tT9GWHQ9LI3+41EXv2lPPaB6ZNhp5PUm/OnRfmqM/MClxZ
         oiDUgBLPiCY25Vj5xQnI8kcCB1ca9Z1rxVeY3N5DSDdGx7Z83lrVrBGReSqGiboJmxAz
         R7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWreWGRh6XePD32rJ9lgwZU3//RDDzj8yh0tvNGtvDjKdJAWWsP91G/lOmZtnRIfzki/U13WH6K993NXJSzXEyJB7rWNIrs
X-Gm-Message-State: AOJu0Ywet9+MQAkEsiK9KuA/gVfmFoaQXxvHcBejNbDSptyO77e2eh0b
	LiV1yR8df4OlA5sRQCImIUhh2dPOT5V9rvLs65t2PREHkNE5t5lXGW0DrCMP14Ao8jbgfNrL4/y
	0sRJEBxqbpih6huxvjuKBnlkqBxx6svUbaboB
X-Google-Smtp-Source: AGHT+IHp6ul6mGglbYpgjttSroYSPr1ojKdlWjH9/BeOaHLo+Qgzs0pC8gze9GA3WkL92NKLQXVOpcB9uIriM6v4gDU=
X-Received: by 2002:a05:622a:510e:b0:43d:e294:3075 with SMTP id
 d75a77b69052e-43feb3a29f9mr2840601cf.7.1717075840883; Thu, 30 May 2024
 06:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530082556.2960148-1-quic_kriskura@quicinc.com> <20240530082556.2960148-2-quic_kriskura@quicinc.com>
In-Reply-To: <20240530082556.2960148-2-quic_kriskura@quicinc.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 30 May 2024 06:30:23 -0700
Message-ID: <CAD=FV=V1Z029z08j3ppTyHmHEZ_MpN0WKDMGG7GgkH9rieUiow@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Disable SS instances in
 park mode
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 1:26=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> On SC7180, in host mode, it is observed that stressing out controller
> in host mode results in HC died error and only restarting the host
> mode fixes it. Disable SS instances in park mode for these targets to
> avoid host controller being dead.
>
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

