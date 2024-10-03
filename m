Return-Path: <stable+bounces-80679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B718C98F61A
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEE2817D0
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8F768FD;
	Thu,  3 Oct 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ckwwNfL7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6054FAD
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980221; cv=none; b=hJQuoxJQ2FB+TQdSbqMfJBWv5ayrksXNaP6f2w5Op7uYG3QW+KYETS2TL59KYrx+YoBjUTNHSZk3SHe3dOthF1JK5KZtHhjwOFirCn2wE6WPqyZyMDWMQXZC8VSEX+8+/HE9AKF3gAy6QH456B+6TQ59TP/mKbQujTkxgKFcjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980221; c=relaxed/simple;
	bh=Njq0fwvF+5VhnQZ1131zaikWJHtF2S4Q3i8c1LX2lvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4LIvkrlSZF6bD9ChRu0nr3WEAGhLPO/zw0kKUb/hQOWLh714BiAkJ6wJ8Y5ZzHREjV4MbSSHOJ+OBW/ehT9eEiHDFeGWH9ZbSmN0TiuQD2FZOuEv9AQBQkUQ0WiJRSMe+irFYoEU9Ym9cTJsW3tLLonNiim5Yr9nF0zQrt+60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ckwwNfL7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398b589032so2134853e87.1
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727980216; x=1728585016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQhmHIpIANYWDxfaKfnE9P0S3zwxERnpg0mMy9nFKho=;
        b=ckwwNfL7ImqcVGwCnYmY0CdUmW3wQnerFyrAmvE88W8UgwcMD9ulEz2f+9hXKbFD10
         R3HC4eLIgq0Ap/P6uVQb3OK5+EhQ1x1M7owRjsLTlXRBSTEpU3NpviLDS18QqpNYPty7
         9/jx1qnGBxBxrrc/bwgZ4bb1EMzHqZG3E6/cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980216; x=1728585016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQhmHIpIANYWDxfaKfnE9P0S3zwxERnpg0mMy9nFKho=;
        b=PogmoJzXoidLWpHMsBwo/YdicT8nHOpyPtbBfMpypc/zFmf2XsWRv+V1F8i3UbcjEX
         eDJrDq7AvBc4yjRD4OqElijOJM0OLISxi4CiAIYFVJSmQZ+OAkzEv1Txn7DlvNMQlE7C
         5T9gIzHJYZo9fw75VuPvwQSKGy6t8SRdvi/cs80SSjACSXDqsw/SrOKM8q1jckvE1MTh
         WCRcG4YN9eJv8CyVQp7KZE1Kt7uIAA4uFAs5Zqx5njqbrw4aSuIGmuVl9RitMcgBusxo
         EnFH6t1wnPaapv6hFtXPcxZ6/oIVtyQPWhYgj6lafI2O9PemxpRuXsq6whWMa1oA47hH
         hR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUG2Q4xOwkibLOmB2Z/jaOW4CGesAFQBGKXg3z2bRmNFdjjLaQSPUi1pFYUi0e3HjklvlCc5SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBflgVkW8QXeGWp1vydGq7JYZCbADeHE0RYQqYNflUIihMCdIR
	fRsDw5nAVWy+7re1qxGY1TIhLVFB8zgZzH8mcLaYwtuFspme1t4kcma4wzGCLUOQQmwhU5lxR4A
	XIF0n
X-Google-Smtp-Source: AGHT+IFaS8e8hC0qOHY0DgmZmSq9mkNDF0ugecRTZpW3Rv0oDlahrPICZZ4ISzY7L6o9SUgl8a8W9w==
X-Received: by 2002:a05:6512:304d:b0:539:8d9b:b61c with SMTP id 2adb3069b0e04-539ab9e5fadmr235745e87.51.1727980216484;
        Thu, 03 Oct 2024 11:30:16 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82976f7sm236353e87.138.2024.10.03.11.30.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:30:15 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso20051781fa.1
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 11:30:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzsrq4nK1qiYV9Ez8xU0yw1Y2FZ8dGryYT/yDlqQt0Rsw22TDBUxxWcHe6rWH8ppVsUVHnvYg=@vger.kernel.org
X-Received: by 2002:a05:651c:b10:b0:2fa:e52f:4476 with SMTP id
 38308e7fff4ca-2fae52f46b7mr54095681fa.45.1727980214619; Thu, 03 Oct 2024
 11:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-2-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 11:29:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V31VFVoTWstVUnC_qDBmaUCb5Xv7pyUxUto7mquR5U4Q@mail.gmail.com>
Message-ID: <CAD=FV=V31VFVoTWstVUnC_qDBmaUCb5Xv7pyUxUto7mquR5U4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] serial: qcom-geni: fix premature receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Aniket Randive <quic_arandive@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver should not be enabled until the port is opened so drop the
> bogus call to start rx from the setup code which is shared with the
> console implementation.
>
> This was added for some confused implementation of hibernation support,
> but the receiver must not be started unconditionally as the port may not
> have been open when hibernating the system.

Could you provide a motivation for your patch in the description? Is
patch needed for something (perhaps a future patch in the series)? Is
it fixing a bug? Does it save power? Is the call harmless but cleaner
to get rid of?


> Fixes: 35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibe=
rnation feature")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Aniket Randive <quic_arandive@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 6f0db310cf69..9ea6bd09e665 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1152,7 +1152,6 @@ static int qcom_geni_serial_port_setup(struct uart_=
port *uport)
>                                false, true, true);
>         geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
>         geni_se_select_mode(&port->se, port->dev_data->mode);
> -       qcom_geni_serial_start_rx(uport);

FWIW, I found at least one thing that's broken by your patch. If you
enable kgdb (but _not_ "kgdboc_earlycon") and then add "kgdbwait" to
the kernel command line parameters then things will be broken after
your patch. You'll drop into the debugger but can't interact with it.
The "kgdboc_earlycon" path handles this because of
"qcom_geni_serial_enable_early_read()" but it doesn't seem like
there's anything that handles it for normal kgdb. If you drop in the
debugger later it'll probably work if you've got an "agetty" running
because that'll enable the RX path.


-Doug

