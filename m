Return-Path: <stable+bounces-73107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6E96C9C9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5143328940C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDF17ADE3;
	Wed,  4 Sep 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlszaVA3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FB15B108
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486686; cv=none; b=V96Vctb68ZXxefduXLzuxx06ZzGu5/4FkAVmzi8Tlv3ToGmqqBWNtu5Bo84O5mERlMQDx6Z/T/Ucow4P1z39MdZDxuYCE8eX0hPmCYIkJxVVuoQMn25JDfyNmxhj0NhYdho434Npn3VewBqC87rvoC1tFS+Ktp71NrEAV+i1jk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486686; c=relaxed/simple;
	bh=knUk5g8ScG6jaMqCjtTQXGlVYSsfYw20xNj43ODq8mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYL83zwCUme1cvG1Vxaa6/d3r92g0cJn4JZErHXjtw4EZvFeOdUP5uDmEQ++wQLacCg7FqLhSzMosxZ+1uL2EwoaaDRzsrQ68htj9iwbfU7ltZLLwKyiP4TCl1Pn7Y9p2ZN8Mgm76TCSzyRd/O+tDjfIirgqnVQrqUgd1T/LqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DlszaVA3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso516656d6.2
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486682; x=1726091482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXSA8W0aVMFFsXPo/UPncBkp5lzvV+GsF0QFk8bga9s=;
        b=DlszaVA3pc39dP3y6svZw5AbMh28YA+4knB6wXI01V1q60JaAToWfPIx4x3SxhV3wo
         AjxTN7QcZb3V6TikS6UQrso/elfzS8/zKBsK3ldocCDZetDv3sbNO7KVjvYCEN/PN1oD
         vw8UuyZiVYUwQKtsRKsxKnTBJncIuXIvjwMiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486682; x=1726091482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXSA8W0aVMFFsXPo/UPncBkp5lzvV+GsF0QFk8bga9s=;
        b=ahy9iqyx1dARmCOmjbz9kb08lv2BvFfRsMd9qitiO1LtBt3MkJ5tXlY2CVLnjQTbYj
         X6BSu1mqsUrowDKFDVr7VRtxIRyxaIDHjNXzDtg1R4aA7S4SzqxQX00Wm0mYZC3B/+K3
         9MhHqUMavcnG1jTNuDGClSKKW+8Gky3mln6yQmDcWdUbtE+uJL0wuHkylWsRBorQLYf3
         ymTfEUifwNDFewgpMkkIfrG0aDP/2oJ2Jhlc5jrpHUS/dklp7ZPdus5XEdbQCIyxMFwl
         N/7eHvE9kpDeluolO/yFDWDuRmk2jcDekY19sCcfGfwZHV1fgBZRoecyzgEs5NqRUbrt
         eH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaz3TvT/7HNil07Z/YJLOwMokap0kEapqtDAt5T0QpdvWPfLRaeWhx233S3PKQhgnQa3cMV5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMbfYNiclqXaoyLxabuMHfNNO0b8I2c0h/XEFtvDHs9BT9L28
	P9lLY68jYqT79JuMQpSPS1OpWpUWoMLGpP6l5KDAK0o1MVT2sU7A8qVwkHYXxZHwwu6j9LnxwmE
	=
X-Google-Smtp-Source: AGHT+IErIk2PHPfnhoip3f8PUJgX0XeyI122gyp7l+mF2QhgY2NpXy7q3NH39olGrQ612Bqe66levA==
X-Received: by 2002:a05:6214:4a82:b0:6bd:7373:8c8c with SMTP id 6a1803df08f44-6c3556465afmr199128226d6.11.1725486681685;
        Wed, 04 Sep 2024 14:51:21 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801cbd11fsm2062941cf.64.2024.09.04.14.51.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:20 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso534516d6.1
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:51:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0vGOE97oVfpq8/TjwA07jc1cjxQa+8kH88Ngz1SAiHYxZatz2sg/KHI4pO/YJXdeIM4llWvQ=@vger.kernel.org
X-Received: by 2002:a05:6214:5d0c:b0:6c3:5aec:4504 with SMTP id
 6a1803df08f44-6c35aec461emr191088526d6.28.1725486680181; Wed, 04 Sep 2024
 14:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-3-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UH8dLB6ebCXGeF2t5Bi5EhYrumLDnSV68fg7qzdPCQMg@mail.gmail.com>
Message-ID: <CAD=FV=UH8dLB6ebCXGeF2t5Bi5EhYrumLDnSV68fg7qzdPCQMg@mail.gmail.com>
Subject: Re: [PATCH 2/8] serial: qcom-geni: fix false console tx restart
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
> Commit 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
> addressed an issue with stalled tx after the console code interrupted
> the last bytes of a tx command by reenabling the watermark interrupt if
> there is data in write buffer. This can however break software flow
> control by re-enabling tx after the user has stopped it.
>
> Address the original issue by not clearing the CMD_DONE flag after
> polling for command completion. This allows the interrupt handler to
> start another transfer when the CMD_DONE interrupt has not been disabled
> due to flow control.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Fixes: 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

This seems reasonable. I guess this can end up causing a spurious
"done" interrupt to sometimes occur but that looks to be harmless.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

