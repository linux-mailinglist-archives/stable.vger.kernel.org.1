Return-Path: <stable+bounces-108000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF513A05F50
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 15:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62BE166310
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4A1FBC99;
	Wed,  8 Jan 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9ln5Fyx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21A15B99E;
	Wed,  8 Jan 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347798; cv=none; b=jw5+M3tiNMxpjHCxqLlAJsf51X5bBwjQIDoPeZfdivca7UbzEfiLHXiqWTovRcDCjB1gbco4FYlsjq8T+yPQqKqW2xjUTELCA0qIaIJQPzhm7vtXDQy0pipmaz659ZpEyC9mVgxBfVSCHT1CEVPLx2pqG7KjaFuKrVey3TCFBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347798; c=relaxed/simple;
	bh=bkQ/hDH6HPgRZUkyQtoui3t/iThIuKsMrAqTFCrlRu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxupE6UQ5ICRjm0zh/Hx27vTp8zqT3PHllwuCE/aPKo7CLCI5NsMmuT5sJpDqErH83ZTwNvCZHNC9A/z81xU5xaKKydS5sk6f28KGv58QhzEhP4zFsUgRApa/F0GTdufRS0A8zqoXPDhPqG06txKKNtH7kMppSdg3TEEn/vXB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9ln5Fyx; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e2851de95so3842662a34.0;
        Wed, 08 Jan 2025 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736347796; x=1736952596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvoTYYDkb2KCKKkR7iPqN33SRmeBP/rGexYGylWWHgU=;
        b=S9ln5Fyxhdh5DDRm9A1jUvXRaAsBkyahbB9BENw9BjEIhxhwomrxOWb/LuyNYeZ9yU
         3/bimJweQ7KWIdtZL89k9EcncycbDT9R6fIwPi/bSOfY5KcWXfQBc72vwP/CEvrQfQPJ
         g1iisMCOGLG3zuYm2NvD1k+7rwkNnONiu7Z/FJFUw2UZB7aL9IdppbtusFu36Fi2RvEV
         88RO9qsXTPpnnt5pKq96SXSA8rfJRm/E3ihFsgCzXbtaTal+R8JUt++1Nfj1+aCGyfYA
         xX+t8awRweUhL4Mo3GLc3SblOY3mZRW5qFRyiQx2c3wUU0HBqx2iBEq4X3mdZEyAzvjM
         F33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736347796; x=1736952596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvoTYYDkb2KCKKkR7iPqN33SRmeBP/rGexYGylWWHgU=;
        b=TERvVd/dTcZNNKV39t7b6v+/O1wp/9PrQj9Nu/ZSH7JsG/ojrV4OktUlZdslT27VFX
         ufMTrrCqYeDEfRbbBjbi9Yu72SbfFp3Ex7uUBFmmmgwIOQsFHjMCOCx/4VakboT/CT2D
         pUvWGYHYDebk8xoaIsQI2YONRTZIA+42kvBQgSPjets1xuhT+eik6IS/b107FLBNgwKP
         Tc9Zo4qwJG11nnT1iAE8DCvW1D8FTIj3MEGyF3AeicjAXeiCm8jF59LSGQNvJ5b/eFyA
         OicIeux1kPtYWVoNyM97GClZwgZT8XSqXos5rHf/lFEYhWO5R8BmvnwE5rsZhlXITDXK
         FYQA==
X-Forwarded-Encrypted: i=1; AJvYcCU+c0Uy1UOtlaygPGpFH2lpy9Y0I9qkdUOZUfbvPc6FK1pmwGDzDUlIrZ3ouNViTvN8gShrHROH@vger.kernel.org, AJvYcCWOPjaKiOaRTVW0EZHTIjZ6c8NVkixgBGh/CJpOxRJl3UaE95+6umAHxJemzSPpWuAxTuS/6Ui/c0Dp@vger.kernel.org, AJvYcCXe0FKbmOT+vqyDdjQWe5PBjkAINGC5xtR6M3YdEAOsJk7tNacv1apabFOu+0F041MpziIn3/Rm04sw0uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3Lpka/6QC0+trkIOBjC4RzjOe1Q2pFP7xhRVf+afgCSIAojl
	axI/lPJ0c17RkJp/T/acJxTtb/DTjbgiJBZYsCejVspZPXGgb1weWzWZq2f2sW5ZDRYq+GIwEWB
	TsDJf3/hFbVipUzLHdPV/3pf0DyU=
X-Gm-Gg: ASbGncvbCghlOzAlv7yuYiq5lKpQYdy3EDG0a8bU8WZc5BHYQ/CD+fpcBPxahZKgHI3
	+MzKy801j4RldiUSr6InqJNjCZLujGI1DVkhZBm4=
X-Google-Smtp-Source: AGHT+IFt6L+Sit8O470wDgrNHgLPUamOgaKfeQ+UVtFu4QAGEk7wW+QqcUJvCt7OD7rosybkHaULmh73CVfZBdPu+yg=
X-Received: by 2002:a05:6870:1585:b0:297:27b5:4d30 with SMTP id
 586e51a60fabf-2aa066479a8mr1430458fac.2.1736347796238; Wed, 08 Jan 2025
 06:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105125251.5190-1-joswang1221@gmail.com>
In-Reply-To: <20250105125251.5190-1-joswang1221@gmail.com>
From: Jos Wang <joswang1221@gmail.com>
Date: Wed, 8 Jan 2025 22:49:44 +0800
X-Gm-Features: AbW1kvYDb0GIJFPHTSyus0vpLVgszdDZH0Vs3sd3gRWSxRoBSjNZZ_vlpFoaZjk
Message-ID: <CAMtoTm1xeviEXJGCAECF65RidexGTG9pjKhU8OyW17rOq7evfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: pd: fix the SenderResponseTimer conform to specification
To: dmitry.baryshkov@linaro.org
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 8:53=E2=80=AFPM joswang <joswang1221@gmail.com> wrot=
e:
>
> From: Jos Wang <joswang@lenovo.com>
>
> According to the USB PD3 CTS specification
> (https://usb.org/document-library/
> usb-power-delivery-compliance-test-specification-0/
> USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
> tSenderResponse are different in PD2 and PD3 modes, see
> Table 19 Timing Table & Calculations. For PD2 mode, the
> tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> tSenderResponse min 27ms and max 33ms.
>
> For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> item, after receiving the Source_Capabilities Message sent by
> the UUT, the tester deliberately does not send a Request Message
> in order to force the SenderResponse timer on the Source UUT to
> timeout. The Tester checks that a Hard Reset is detected between
> tSenderResponse min and max=EF=BC=8Cthe delay is between the last bit of
> the GoodCRC Message EOP has been sent and the first bit of Hard
> Reset SOP has been received. The current code does not distinguish
> between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> This will cause this test item and the following tests to fail:
> TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
>
> Set the SenderResponseTimer timeout to 27ms to meet the PD2
> and PD3 mode requirements.
>
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> ---
>  include/linux/usb/pd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 3068c3084eb6..99ca49bbf376 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -475,7 +475,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_NO_RESPONSE       5000    /* 4.5 - 5.5 seconds */
>  #define PD_T_DB_DETECT         10000   /* 10 - 15 seconds */
>  #define PD_T_SEND_SOURCE_CAP   150     /* 100 - 200 ms */
> -#define PD_T_SENDER_RESPONSE   60      /* 24 - 30 ms, relaxed */
> +#define PD_T_SENDER_RESPONSE   27      /* 24 - 30 ms */
>  #define PD_T_RECEIVER_RESPONSE 15      /* 15ms max */
>  #define PD_T_SOURCE_ACTIVITY   45
>  #define PD_T_SINK_ACTIVITY     135
> --
> 2.17.1
>

Hi Dmitry

Discuss here "https://patchwork.kernel.org/project/linux-usb/patch/20241222=
105239.2618-2-joswang1221@gmail.com/",
you suggest setting PD_T_SENDER_RESPONSE to 27ms.
1=E3=80=81In actual testing, setting the timeout to 27ms can solve the CTS
problem in PD2 mode. For PD3 mode, since 27ms is at the boundary, it
cannot solve the CTS problem well.
For example, in the test item =E2=80=9CTEST.PD.PROT.SRC.3 SenderResponseTim=
er
Deadline (As a Sink, the Tester checks that the UUT accepts a Request
Message sent at the deadline limit of tSenderResponse min in reply to
a Source_Capabilities Message.)=E2=80=9D, after the Tester (sink) receives =
the
Source_cap message, it will send a Request message 25.26 ms later. The
tcpm framework layer on the source side should take more than 2
seconds to receive and process the Request message=EF=BC=8Cwhich means that=
 a
Hard Reset may be sent before the Request message is fully processed.
2=E3=80=81The current modification is as follows:
#define PD_T_SENDER_RESPONSE 27 /* I am confused by the comments here,
such as 24ms - 30ms or 24ms - 33 ms or others */
There is no suitable comment here. In the next patch "Make timeout
depend on the PD version", this line of code may need to be modified
again.
In summary, I might consider including the following changes in one commit:
(1) include/linux/usb/pd.h
+#define PD_T_PD2_SENDER_RESPONSE 27 /* PD20 spec 24 - 30 ms */
+#define PD_T_PD3_SENDER_RESPONSE 30 /* PD30 spec 27 - 33 ms */
(2) drivers/usb/typec/tcpm/tcpm.c
Make timeout depend on the PD version
In fact, it is to patch "[v2,2/2] usb: typec: tcpm: fix the sender
response time issue", remove "Make timeouts configurable via DT"

Do you have a better idea?

Thanks

Jos Wang

