Return-Path: <stable+bounces-76592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D197B1F2
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772C01C24431
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305791AAE1A;
	Tue, 17 Sep 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yStfJrlM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA1176FA0
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586002; cv=none; b=Di3K1xKAFk16mF6IbQMO4hQZ1PbzsUzsxdLOpsxpxiwu2w5cCNw0A20URKuCkjKxyG5NyYi3Miyh6Iy8x96Mk9dz/3PtugkAO4qsjmzrxVtlxjyJzx7cyY+Z497Ln4iXnPBngvPX3GEz/3BY0ink/xBLUy+7MQ2ntr/P5OCzvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586002; c=relaxed/simple;
	bh=C6BIJE5gYeC/g2Oak4zV9l7IfmZQnQtGYVUJTeQWod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2hfisEGbVVGXkaG9K2LFkzmUQB+KrJ21muohIBgHeP5f/LbRpYdflyQ9u4l6cotTiht+huTSOa/KLBNX1odYcemeAshvzRl73I4ltlR4eEKD1/UPxbYHYFj+gzcVZH24xixni0NTB2ix+nntlRhyY5aJ3wp7XwPleyAZOlO18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yStfJrlM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so47834971fa.2
        for <stable@vger.kernel.org>; Tue, 17 Sep 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726585999; x=1727190799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9QCqlRh9eT2CMbCDWw6auXzAwjAo/ozmjDpAB5cjRo=;
        b=yStfJrlMhN4gbrtmJKgz2O1MF4AD9CH88Hy2nqW1pq8ElVywcJ9EWqGDOdgYxXttK3
         bpwNR7HMVpke9eioC5kp4efzUPDBtbLw/zwKnyiwwVTAUtoc+MnnWa/Bxdgmh/hA44HT
         BHGIcFBfWSANWEvCNbEIUIlgPA0j4hRcZKBaIr8Cc5ol4CGb5cAjzT7KNzezLATyMX+c
         V9FSbsT3RqhDYQgR65gGd6NEEakSeeB55APgcKITHi9TYhWNxuCYEfS/99nmVCfbM7Ra
         fv3smgOYTpVcrx0MNpN3lNBkS/txwcAoq6MUCn9iDgRrr08mWSWix2kSc8OyzXPobYka
         GWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585999; x=1727190799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9QCqlRh9eT2CMbCDWw6auXzAwjAo/ozmjDpAB5cjRo=;
        b=WEtBfZgr4xlNILjJfn8XYR0ZfPyCL5bbF2iuZ0RV5J68kja+CMpVtSz4J8MKftfq7+
         LNuQWyYxAvbTPyz1qvCuNARq7WFMy2vf57BbPIPR7my137eJnuPT2OLMO/Nmq1qukpvI
         1HeBhnf53T2w7tfH30rZsYf4l28q6ukkk2/raiMuU3gDB3q7K3fO/TyxmLQ/DAjmaqwo
         1oXyRag436KtDOKQhpE5XXPZPwbmpxnScosKJ82FSELKN99IsjL6e+3aF2b0B94wp814
         AM1ogTQ1+JUtQjLHvSSFE7ygc0nGzC6Zq0ERwHXCQqf3Pd0LVRTkPXK5jZ1kv+kkjv0W
         tyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxPjgYA4nKs9fIoh/2MBfgrx+IDaNGQ1ZJplO+KAwzxUf436beIJczu7OThCF7ANLPyN8CSUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOO50QMXEPAa+hBK46CEV3YGXULkOEFWwc+iUeClti5SxsfbA
	oKoXd/ws+rH9vEyWyiV3Qj4s7oXmzt7MxeZnb/eGiekpPiBQ9eMiuytT+8F99CIoy+toCi/6Ydl
	V1VQ0KcVa308gc5TTY6ltJHf8AcDaVG8lSBF5Qg==
X-Google-Smtp-Source: AGHT+IEjk8ZHjlHyyFFjPJuCGwJFKhZ0kGO8bejy0WGDuXef54JZ6Xsqkq0B58+CUBKCRRCNpr78RpMazH22iNaAcZ8=
X-Received: by 2002:a2e:bc19:0:b0:2f7:5e7f:b4e1 with SMTP id
 38308e7fff4ca-2f791b4d3fcmr82055101fa.30.1726585998980; Tue, 17 Sep 2024
 08:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916172642.7814-1-johan+linaro@kernel.org> <20240916172642.7814-3-johan+linaro@kernel.org>
In-Reply-To: <20240916172642.7814-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 17 Sep 2024 17:13:07 +0200
Message-ID: <CAMRc=Md-B3MCdjBA6Z03Tn09Qdq_O=2Gij=0kr8HiLtpp11kVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 7:27=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> The call to stop rx that was added by the same commit is redundant as
> serial core will already have taken care of that and can thus be
> removed.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 9ea6bd09e665..88ad5a6e7de2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1096,10 +1096,10 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> +       uart_port_lock_irq(uport);
>         qcom_geni_serial_stop_tx(uport);
> -       qcom_geni_serial_stop_rx(uport);
> -
>         qcom_geni_serial_cancel_tx_cmd(uport);
> +       uart_port_unlock_irq(uport);
>  }
>
>  static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
> --
> 2.44.2
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

