Return-Path: <stable+bounces-73108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D196C9CB
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD2D286004
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98C1741D2;
	Wed,  4 Sep 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8B4Pu7m"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400F1714A9
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486695; cv=none; b=M7cdD2o1PBj0VoeqdVwTSs4w76+C3fouSsn7WUtwSTd5O2m7enJ9N00Ol2CINSm9DVeE0a+xaUEFCJp1xO9HknppjxQuNKkWMebglqE0h/KgyIHrXyK2KzK+RrWeW+lfP5wK0UdwXUzDDnytR3ZOcgDCrDsxCwcv/RuR/s1M4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486695; c=relaxed/simple;
	bh=52OavEbDbnnXzGVYj1cdimeK3fNcZ3tbnsTSFU90N5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpllB3hQaxmHO9tduSuOCsXIE61nqAOgje2/DS9QewrGPw6kUCuHMQzb/aW/P5Rg+xsC4j9OmnI3NLpowmJOCr8i5MlzHdDzAQp/jHnuSpxMneDO2591ypXj6Z0avE8B6/JYzP6YNp65Jtni03MnC861d+zPAI4uw3FWopLz3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C8B4Pu7m; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70f657cc420so87900a34.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486693; x=1726091493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEVB0OaxtEANZF8G4JgUXQ7IBpjIjKgmyEACvOZxq44=;
        b=C8B4Pu7m+yGIBipLecwld/aykc2j6fT05QvwJUKZtzO/gjHu4lqFiM8aCcNcrr3Ayl
         hTAu+A/hSofKApJOjdK5zRnjzBm/UfVzSeNBHyxXnVlPGuLxJ/tPstfRycF8mo3/gYjF
         Rz+gkJVntXToufnGfBlMIAd9F0iiMKm9BFflo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486693; x=1726091493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEVB0OaxtEANZF8G4JgUXQ7IBpjIjKgmyEACvOZxq44=;
        b=wO9aKAlKRpQzE4VxZRN/tFAv48BZgYVLM7OExiaFHik8DldmsRQjuUUOjpcWSnVRUa
         rdoQ2JXtFSWCNhbWDYCH6xmPuGIGyIFq0dPGaRSqWhEApjrrwGLqBW0ZmljYCKJHYVyn
         EfHh2r2zV5XnCfmECy70ZWte/osILqB/o8rq0Dzw+W+KzsNPCxsFD7oTLQnlJdKqw0GW
         MfZjm30E7gXhc2k0WNeNSojDiOU5RE8XWJLKitAA537QoAj+6QJ59CmYlKdOysTEN14n
         UTzKFvyY95EwZfDX7f8q1bTxTz/jSzT3DCpWHyeZF9nFtWzddI2RMAUidvfQLvj8Ub44
         zytw==
X-Forwarded-Encrypted: i=1; AJvYcCVNwTJtRrjS0ySgr0lWIBYlnVbVMMUUfyFfBBa28yumJ/el05/He2DkEK4+okOFE4f8FQ2YD9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4cEeVe6HlIW4WFBEVucvcHIsOl6/H1vdZnPEAnHEYDWwtd//
	TKkK1Y4yaxZGavF2T4LROhpgOcTr1LEfdlrO/ly6UD2ZgKTOrbjtxWVZRJ9wO/YTWjVaD+nhgG0
	=
X-Google-Smtp-Source: AGHT+IFrefq2/GkULd1h++htTcPtIDhsDzwRhldzTQyKX6QMFUBi7l2KUe4NTnObS6nElnJjwiLT+w==
X-Received: by 2002:a05:6830:3747:b0:709:4094:2a68 with SMTP id 46e09a7af769-70f5c42d45emr28264072a34.30.1725486692747;
        Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671a8938sm3020747a34.53.2024.09.04.14.51.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70f657cc420so87878a34.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBrUMaoUTSMJIgPsMVQg8JOBkCb4GwWuLTRK8k9Wyr5t3iGO53AoAk7qfvbyWNzmVfS2FNoFY=@vger.kernel.org
X-Received: by 2002:a05:6830:6d08:b0:70a:988a:b5fd with SMTP id
 46e09a7af769-70f5c406907mr29012888a34.24.1725486691455; Wed, 04 Sep 2024
 14:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-7-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-7-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnpPnSToWV3f2Z-DWm2-1rdgYmDZeicGGRQD-_YjS2Bw@mail.gmail.com>
Message-ID: <CAD=FV=XnpPnSToWV3f2Z-DWm2-1rdgYmDZeicGGRQD-_YjS2Bw@mail.gmail.com>
Subject: Re: [PATCH 6/8] serial: qcom-geni: fix console corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> +static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +       if (!qcom_geni_serial_main_active(uport))
> +               return;

It seems like all callers already do the check and only ever call you
if the port is active. Do you really need to re-check?


> @@ -308,6 +311,17 @@ static bool qcom_geni_serial_poll_bit(struct uart_po=
rt *uport,
>         return qcom_geni_serial_poll_bitfield(uport, offset, field, set ?=
 field : 0);
>  }
>
> +static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +       if (!qcom_geni_serial_main_active(uport))
> +               return;
> +
> +       qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GP_LEN=
GTH,
> +                       port->tx_queued);

nit: indent "port->tx_queued" to match open parenthesis?

...also: as the kernel test robot reported, w/ certain CONFIGs this is
defined / not used.

Aside from the nit / robot issue, this solution looks reasonable to
me. It's been long enough that I've already paged out much of the past
digging I did into this driver, but this seems like it should work.
Feel free to add my Reviewed-by when the robot issue is fixed.



-Doug

