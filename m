Return-Path: <stable+bounces-80680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490B98F61E
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C46B21EE1
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21319E975;
	Thu,  3 Oct 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ky77V5bT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91E6EB4A
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980231; cv=none; b=dRwsbmX1g9wLmYiHHqEHpmPXqlBEJhH3uIF7nr+5bgzEKnrCrXEt17QVjZg0xuarG20/KUvPJEUPsMB41AFo2Lzlycmi965l6m+aFrdtMkA5IJmxfNTru9PxyVzITUMRzKZlW0gHpDWJs/aCHG5m4EBAcekReYSif0TE0qnXhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980231; c=relaxed/simple;
	bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAGMAYO44NbKcndmCYMNWlWqd3lz+ibNYSMjfUYFnU0nStTDigkomRIjG4ydqOu1/JMBA0RhxACo7PtdeyJPCYPTemgjDwfPNpUhrAjfSfeuz7Sc28X0WurHRJePLoU6ihobPbgNLtiMOGBehf0VHTLyjTd8QqtdHxYW/dr03+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ky77V5bT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso15648091fa.3
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727980226; x=1728585026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
        b=Ky77V5bT+NZ4VKyF9ecjsztDbl4sUMB85rtmpfY9RbzwnC9mgGcmj+VCeya9/gfnUu
         dyeApDNXP4EzK5xS0sx9OcCA1EB/sW1vMMo7woNGNnrzb5fVQWX5HTn5Q0A53nVjxPwj
         xyC5C9AstbYoLyVC1pWI8F/WGgnbGJQ4QrH48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980226; x=1728585026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
        b=XGxbU4ysGwaNi7I3cEOXTkkP5vpFMbnXAP+lKp34rwXm5GrUqZr4+/5+d6ZaXv3XT2
         VNY3hlqlZbrNJkiGgfNS6kVChEFRatw7bjoPvS/cJ1VANGbu8oZN4g07Ij53uezjXp1o
         f6CWPY1Kn5eOclWdoYx0Hpj+XnqI3laR+Y9q0Nb/S1kCmjXq2pAtmDv1ZIEN4SAzDUBq
         E41ZEYMAklzv6VSPraBBsqAVxT6bfw9LbNCGhjLADWuw7RdYpCpf/hIjIzDy+QTgKvuf
         5q93TwRvCyIxLM5qxgXopNK9tuu6BL8jUxNaDPusMVWfFEri3bjgYGLzZau+JCJcU+wf
         Watg==
X-Forwarded-Encrypted: i=1; AJvYcCXS8suySb9qbFPq3pR7rXErSyKj5sPnfJGS88u/Q483FSt9ned7d4/90YGY6XFy7lWwe1SR+bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWwbbOW9mV7JUWxUBRPRLOS8nNZg8w8vC20lhWLclseOvOuNl
	1fQ4B0ZxbcfpY446vmMTj/Cn8jLlfThoWw+G+QsYJWqNLhkfOuMjU+MshGMgyN6m78WegDbgf9c
	koD80
X-Google-Smtp-Source: AGHT+IEWDbUgB0NK9JP5sdv71Qalxo6EghPiefxEMjbECJCvxfVWl/6sRa8NXTfNOQd8Z5BBYFNtXg==
X-Received: by 2002:a2e:a99d:0:b0:2fa:d84a:bda6 with SMTP id 38308e7fff4ca-2fae10281demr54883541fa.21.1727980226140;
        Thu, 03 Oct 2024 11:30:26 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc959d0sm2634421fa.114.2024.10.03.11.30.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:30:25 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53959a88668so1676518e87.2
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 11:30:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV20vtUTd2Mgq4NVZEKhDd48S3M7YNBPdi4QnIY+TpbcnFuu6oy++wKcxj9qrakrym2ZlW+OCg=@vger.kernel.org
X-Received: by 2002:a05:6512:2211:b0:539:9155:e8b4 with SMTP id
 2adb3069b0e04-539ab85c137mr174931e87.2.1727980224394; Thu, 03 Oct 2024
 11:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-3-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 11:30:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
Message-ID: <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").

Hmmm, when I look at that commit it makes me think that the problem
that commit e83766334f96 ("tty: serial: qcom_geni_serial: No need to
stop tx/rx on UART shutdown") was fixing was re-introduced by commit
d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in
progress at shutdown"). ...and indeed, it was. :(

I can't interact with kgdb if I do this:

1. ssh over to DUT
2. Kill the console process (on ChromeOS stop console-ttyMSM0)
3. Drop in the debugger (echo g > /proc/sysrq-trigger)

This bug predates your series, but since it touches the same code
maybe you could fix it at the same time? I will note that commit
e83766334f96 ("tty: serial: qcom_geni_serial: No need to stop tx/rx on
UART shutdown") mentions that it wasn't required for FIFO mode--only
DMA...

Aside from the pre-existing bug, I agree that the locking should be there.


-Doug

