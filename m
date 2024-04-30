Return-Path: <stable+bounces-42837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4B8B81DA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F2F1C2200C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C11BED91;
	Tue, 30 Apr 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpJy6oa1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09441BED7B
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512129; cv=none; b=dXjDg2bgNcEKjGyXH1HUnXb9BydBdxQyUzpGgj7/l2KCdnxY9tX8/XqkJl/D75DCDiHqSUUKYEF2Mk8zychUIA7hvdhWn3UStHWaEMVM5cdThRZ+DUCnnFhDqjUlnMJjxnkqzYxIWj24iddNn540v3j8AGPPwGGA6fwvmG+nF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512129; c=relaxed/simple;
	bh=I/EVp4TZiR8OTln35vMm6hHoxU6T0GwrW0UNOvI5cik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTWxtwFt6hG6bFhhYKYtJZyaJcL8B7+vcj9aG25TxSA4Kbwxy1ys+GbFg9WQYpvMtNyk2y6Z0jFAq1kj2cC9IXMqRLy3ucb8sW3rWQBM4UqpPoY53zWtLh4sEcNd5Q+0VleaB5yXtEt10paN7C2oiQ3bsdyDcDivT7yzQ9Wsj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpJy6oa1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c8317d1f25so3627175b6e.3
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512124; x=1715116924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbllIAN5xE2NiWzInq5JcWusAiQpLXP/Mpzf2+wDG9o=;
        b=EpJy6oa1sIh/R8QjKDO6oLT80FgAAetyXUr7eqUNvfS9UCEoA0rzI0ZnjhqxGjQ2v0
         5DQnxR5c0XIfFsBIB0RXxXLtiQGeLoEn1jbnaPAXsn25yt8Ry7VPEvZd7xGYETX57/qC
         PL2UtCH26zYfrqC9yU05qolNI7w0gmz6UeZ3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512124; x=1715116924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbllIAN5xE2NiWzInq5JcWusAiQpLXP/Mpzf2+wDG9o=;
        b=sBhcG/5Cc2z932x+14jfaDgZoQQkl/4H7eZZVhHQqVYZKYAfL50QXOrFXYnhxoYPFw
         jrvoOOEHW88FVsHGJXQG63Ia8iAsfZDW6wJof/Qt8QIDn4hnZ4ab3Y+2pAB5O4vvwV3d
         qqllkX9sdilAeG9HDcv8cZORpR8S+e7dr3omNhMoNLzWldeTp1xVnZ0vtXT05XTsY8Pm
         LOdloV9S2bW7w/4pkvprUW9tXRE5uxITQS/uKtYwuo2eUGg6YWwwp+cxOBxek+XYCskw
         2GYn5iWnsK/kVhG/H3eKnrXww1+xq0q1ZUZTcLiv2sEzvbQcGE8rvhA2Xl7Y/I4tX6Rl
         9gbA==
X-Forwarded-Encrypted: i=1; AJvYcCXQLJ9UCPx/k2Prs+g4RmBQx7rf1cFxMz6EgZpFt9BeDAxJ6Z9hKsZDTXm/uOGsmEAzUnWOQIj/bJjmwpbSy1MEMgrT9z71
X-Gm-Message-State: AOJu0YykawcXFCZ0uXAaA8oQVjqqaW9IC7s3qh/6T+3mkvVn0WH8Suvz
	aun+xMsgPQhE0abY6pqP4MYoskp7q09vllOYdbTbT6FGU7BJbW1hBnOI6C9OocXiDfnK5ouMBBA
	=
X-Google-Smtp-Source: AGHT+IFNqtCtWWnOPqRl/LfqkNi4Lod6EGTMS01J1I8CL9Gs7jlRBZ84QnBuGcHp602CvybEoEAIKA==
X-Received: by 2002:a05:6808:6342:b0:3c7:498c:6b0e with SMTP id eb2-20020a056808634200b003c7498c6b0emr881556oib.1.1714512124605;
        Tue, 30 Apr 2024 14:22:04 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id p11-20020a0c9a0b000000b0069b32845235sm11885492qvd.85.2024.04.30.14.22.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:22:04 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439b1c72676so59851cf.1
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 14:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIqz6TuOQhSKmDqit1xdFSvvafWFM9vDN2oxoAJ/G9QvRZ9VwCpxxu87pb+J8S3TefA09SZBc6Gg1d8rv/aRhgDxYGPqU0
X-Received: by 2002:a05:622a:44e:b0:43a:f42f:ef0d with SMTP id
 o14-20020a05622a044e00b0043af42fef0dmr20528qtx.23.1714512122930; Tue, 30 Apr
 2024 14:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430170741.15742-1-johan+linaro@kernel.org> <20240430170741.15742-4-johan+linaro@kernel.org>
In-Reply-To: <20240430170741.15742-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Apr 2024 14:21:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAF1_faO2uRzo0Sm0VOxWmqs7YCT0Ncw=Nv1iSndhBZA@mail.gmail.com>
Message-ID: <CAD=FV=XAF1_faO2uRzo0Sm0VOxWmqs7YCT0Ncw=Nv1iSndhBZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2024 at 10:08=E2=80=AFAM Johan Hovold <johan+linaro@kernel.=
org> wrote:
>
> The default device address apparently comes from the NVM configuration
> file and can differ quite a bit between controllers.
>
> Store the default address when parsing the configuration file and use it
> to determine whether the controller has been provisioned with an
> address.
>
> This makes sure that devices without a unique address start as
> unconfigured unless a valid address has been provided in the devicetree.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 21 ++++++++++++---------
>  drivers/bluetooth/btqca.h |  2 ++
>  2 files changed, 14 insertions(+), 9 deletions(-)

I can confirm that my sc7180-trogdor-based devices manage to detect
the default address after this series and thus still look to the
device-tree for their address. Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'll continue to note that I still wish that detecting the default
address wasn't important for trogdor. I still feel that the fact that
they have a valid BT address stored in their device tree (populated by
firmware) should take precedence. ...but I won't insist.

I'm happy to let Bluetooth/Qualcomm folks decide if they like this
implementation and I don't have tons of Bluetooth context, so I'll not
add a Reviewed-by tag.

-Doug

