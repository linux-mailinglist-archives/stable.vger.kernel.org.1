Return-Path: <stable+bounces-28426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EF4880188
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEB11C22F01
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D67823BE;
	Tue, 19 Mar 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ES9j3iV2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4281ABD
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864644; cv=none; b=DuRCKsUBoQ7YNs8QpUPI0b5p4J3VO2ZVOl6j1zQXlTqd8XMOwrjr1wT3HxVqCApTRzTiRqzP40g6vt+oXS3TDtK6FSKRQVpWTOzS4yFJR9dDJmRqOOuFCAYisxC06WMIvmfi1CjjgEFZuxXwQ4aiQ426e0wHXtVXVqLkv30Irn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864644; c=relaxed/simple;
	bh=4BDyA1fp80l7JzPfJ1e9Vcia9HkvY/RtUdxfuRXBrig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsIuAwYGypC0KECKyiyV0Isk5NQGkgPecfS84tMp7gUXiy3+YrRGNm7F4at1NGalmPBDr2uYyxMi2pFr8QNgY8x8g35/zwmLsxSzArPg/pAUDWeRizt8ClpYpWUvx6suWm58nhTPldFJYMJAErzreMo8VHc4clj3+C3CEM7VX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ES9j3iV2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78a15537fa1so40448785a.1
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864640; x=1711469440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=ES9j3iV2JBRMkvAan48pxSiBUveza/4c9K0/dDfwc09aOzmZdkhz1smErukihYnfuj
         NOoc4XxH9Je0U6HtJWckEac3HeoMmqKcVDGP9CEe2H5MT1YtM1IJyksu6P377sGaEXrh
         GRfCrPYB1a+6U9elDBRxvJS3okcwMc4hdktyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864640; x=1711469440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=VP4B3WxyJrnWWpg5Dena9ga99u65n8Valphhf4E+EYhdMZUvlqIs7BN4Ve6mZX5vrY
         gMA/WJ+dtIe65fO9E+Dxm3VFYOrtBrlVImquYkj/HCFrgFa4dUrQxPquJxmQ/9d6ShAW
         RA6tWBcXemHhiefvQRKOHwXxz8/g5y/lwbAbNxkahSDbjdsrdKNlh1iCTUxWwRABmuc1
         KkhnzdnejI6n/yBf7djag+s6M9EnaOXXnLsTtgPGeMXjR4W3QS3HGHWcnHtUQbjdqOg/
         Ebux1J3RBy9jFbejQxj2RFyyGFyqvNNlpkBxm1C4TENnjyTf6JcCCbNllFo7mEtX0bC9
         IxQw==
X-Forwarded-Encrypted: i=1; AJvYcCVlD5b7FrMe+cGC2I+85WoIW9DDHfb+4dUpmzRi92ivpMQDHGdsb3WAgRZeFtZ7wYyNKZkmkojmTnBKmhvPIiAOOTx3iOFu
X-Gm-Message-State: AOJu0Yzt+BtueEdUsrk45njLT6ZAkRErWklA/AKDZzhyWjb3h/M9mKNY
	Dr9tZ/ldHutivbR4osXgipjkhd24zai9MmiGmcJROCof+KZX4I7++YGsSvgUJbhXjmr1+kmHkes
	=
X-Google-Smtp-Source: AGHT+IGAEmGnB/6xnBXOEqmLUszwNRnDmIRSrvyNg7C2QLRdNNAu+cwDc0+CxOLhX9MCzOPCytVtqA==
X-Received: by 2002:a05:620a:414a:b0:78a:bfd:42ce with SMTP id k10-20020a05620a414a00b0078a0bfd42cemr3905649qko.41.1710864640552;
        Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a005b00b00788402160besm5572712qkt.128.2024.03.19.09.10.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430e1e06e75so434801cf.0
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZCoEr0LdzYmz2oNXyicrtQ56Co4VFc582MDPQoSSkyQw4EI1AHx6ZhewMNtMr+lynz7DxXTMw0t8nTMX07jnKcX/dN6f4
X-Received: by 2002:a05:622a:11d5:b0:42f:3b05:dc8f with SMTP id
 n21-20020a05622a11d500b0042f3b05dc8fmr390619qtk.8.1710864639829; Tue, 19 Mar
 2024 09:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-3-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Some Bluetooth controllers lack persistent storage for the device
> address and instead one can be provided by the boot firmware using the
> 'local-bd-address' devicetree property.
>
> The Bluetooth devicetree bindings clearly states that the address should
> be specified in little-endian order, but due to a long-standing bug in
> the Qualcomm driver which reversed the address some boot firmware has
> been providing the address in big-endian order instead.
>
> Add a new quirk that can be set on platforms with broken firmware and
> use it to reverse the address when parsing the property so that the
> underlying driver bug can be fixed.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  net/bluetooth/hci_sync.c    | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bdee5d649cc6..191077d8d578 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -176,6 +176,15 @@ enum {
>          */
>         HCI_QUIRK_USE_BDADDR_PROPERTY,
>
> +       /* When this quirk is set, the Bluetooth Device Address provided =
by
> +        * the 'local-bd-address' fwnode property is incorrectly specifie=
d in
> +        * big-endian order.
> +        *
> +        * This quirk can be set before hci_register_dev is called or
> +        * during the hdev->setup vendor callback.
> +        */
> +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,

Like with the binding, I feel like
"HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
"HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
don't feel strongly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

