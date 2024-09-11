Return-Path: <stable+bounces-75910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47D975BA4
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E5AB219FF
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA481BBBD1;
	Wed, 11 Sep 2024 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5FZBUuZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5B1BB69F
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085995; cv=none; b=HbYyHLW/gKbPzrkjeB6ht4g+enrzYHzX73bBwSwIbA8yu4r1RjfK39o3Nyb64fUbXYbkD+aR9v6q+c5nZjyeRq9cuRb/2rOHgU5qtRYlE4qCemcsdFf5OcxuFoqeyEzD+ETUhLqb1KXrPrxXZ8z/xGxSlUm7f/3gT3oEJFld50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085995; c=relaxed/simple;
	bh=LNjfIqdnJ7xDwaFYjSU3zgI/rR85Tz4XyQ8E2ga59QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrRRGnkb9Z+ym+yf6ccrdFiU6boO5NLS/RAOoffmAtwZb45kSIxayHwV9136rVaMh0/dNtDAtBODCdUB6I6m0rpqxqODHBbMLRFTsE5fT1JUS9iiPB6yG6jPrqxpahy6S6f7OP0FThtgZHz0iOvJooT+p0pDcRpPX+zzFVBiF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q5FZBUuZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6d49cec2a5dso2310417b3.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726085992; x=1726690792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ2fUDORmV/sdyoK/2gbNCgI2EeD5lNRSWNYdKecCGo=;
        b=Q5FZBUuZOPslaD/1/0ulCE34QlK6SiRtxHYL0WfW3ZfqNaHrZEm9LTaViNrxdQrxLO
         jpXBzCdSB6oncsAQcjnS0rHo9sCYx2N43WKdD8pxwCrxWRUabeabNLdDuuwG+bdhPd0H
         +Ym+IA9ug97ax5tR/A7bnJeAJkfOhxeH25yPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085992; x=1726690792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ2fUDORmV/sdyoK/2gbNCgI2EeD5lNRSWNYdKecCGo=;
        b=pp4NfQ39khmDsS1GKS+Efdk/VYfnmE4SMoTNRL42GF+uPYWuff7tYaQWoRI9JUbMwl
         OT5R9W95Sbl2ElugXmmHlbdSP15Gw2h/f6vXYvAQKeEscx7Vric3ySdU9VTSY8tffmsS
         UScXF+byfcHP47p2VBPUsmA75nmK7BNKchxLKuKP8C32WfR+i+R9aB+/UpCzN+x7WAp3
         P0WuXCqP0t7L6yCKkraq+R0NyPa0iwe97ySk1FZ6RMgXMlWkY2skHBgrNSfXieHcq0YK
         kr/TLUovOO///joTEuuUvfPoF1C4eQ47frhuoL7VwOUlVQ3WubAgK9Q3znqqsaUQ8IWF
         okOA==
X-Forwarded-Encrypted: i=1; AJvYcCUaFB1vzb3UGrl5feBJXZG5HaMbomW+6OTQsSqLj1K0CcCWvAekcwV57Z/B00xtinn00LxYzmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpQKkAnKVvVfHV8pVX0K6cnk0xMFhpDJtOV/PRMNVTBPcSWBh
	9PBnOF8DoMCrSJ42yOd215IdI4HBjTv2gAQmXlx5Pmcxc/QvtyPkw/EODEsUySxDsQMFwcwpLRI
	=
X-Google-Smtp-Source: AGHT+IF2xf8sEtkFWFgObTc6yLvgjY7Tb9p0bx9+eILiS5HXR5n52Yc8SwZqF5Aerj8qS2hh6lyeQA==
X-Received: by 2002:a05:690c:6612:b0:64b:89cd:7db8 with SMTP id 00721157ae682-6dbb6b8c85amr8300667b3.28.1726085992047;
        Wed, 11 Sep 2024 13:19:52 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a29258sm457761685a.127.2024.09.11.13.19.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 13:19:50 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9aa913442so15273785a.1
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 13:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnzjiwtuJxQcUN3VB/sxLzD+dVCzjSgdg9x6D2dgs/9wgVVB9fO+8EPiXSoQ3mp2tdwf4kgVQ=@vger.kernel.org
X-Received: by 2002:a05:6214:448c:b0:6c3:5597:406d with SMTP id
 6a1803df08f44-6c57347eb8dmr12957366d6.0.1726085989561; Wed, 11 Sep 2024
 13:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906131336.23625-1-johan+linaro@kernel.org> <20240906131336.23625-2-johan+linaro@kernel.org>
In-Reply-To: <20240906131336.23625-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Sep 2024 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBVct4e4oe+KP1_2FuFjZ4tsX+FavK56FUnrOfZfP=fw@mail.gmail.com>
Message-ID: <CAD=FV=XBVct4e4oe+KP1_2FuFjZ4tsX+FavK56FUnrOfZfP=fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] serial: qcom-geni: fix fifo polling timeout
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 6, 2024 at 6:15=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The qcom_geni_serial_poll_bit() can be used to wait for events like
> command completion and is supposed to wait for the time it takes to
> clear a full fifo before timing out.
>
> As noted by Doug, the current implementation does not account for start,
> stop and parity bits when determining the timeout. The helper also does
> not currently account for the shift register and the two-word
> intermediate transfer register.
>
> A too short timeout can specifically lead to lost characters when
> waiting for a transfer to complete as the transfer is cancelled on
> timeout.
>
> Instead of determining the poll timeout on every call, store the fifo
> timeout when updating it in set_termios() and make sure to take the
> shift and intermediate registers into account. Note that serial core has
> already added a 20 ms margin to the fifo timeout.
>
> Also note that the current uart_fifo_timeout() interface does
> unnecessary calculations on every call and did not exist in earlier
> kernels so only store its result once. This facilitates backports too as
> earlier kernels can derive the timeout from uport->timeout, which has
> since been removed.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 31 +++++++++++++++------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

