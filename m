Return-Path: <stable+bounces-55115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF669159C2
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 00:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013E71F22410
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92B1A2550;
	Mon, 24 Jun 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXf8vkoy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE01A0B09
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267596; cv=none; b=DcFbARfb0ZdPaCIq28F3oKCIsiTUYu2I2oASPF/nRC0YA1HPje0MeghLwmyg080hyj5OKsMVjSSswMk0MAEkXy1o9A2wSJN2emlv9zafFCtXMhZUv+N9QN2Od/Ro5tAICJFwSDuXCt5/Rj9MqZmd75+UiaDKSG4qeMbxybIHWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267596; c=relaxed/simple;
	bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiIJyRcgu+o/Vf17k43WTtmN8wQKY4DisDIzIK5bx8ZcKoVVnUlsIZ6V+gme9HS8g/qP1MS72dGlvZAjp8hqB1qUYLUkHcHRiPfiJh1lIfYItgf0OO9Mzzt+x1Deww0opRbmn0R0bk0/VPO+yn2QadMi5/h3Txir/wTUVUm9zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NXf8vkoy; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b9776123a3so2193418eaf.0
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719267591; x=1719872391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
        b=NXf8vkoyUdiLGwE8GXhqfp+i0/XFM/uxv1z+ah3oPd4B0I+Yj8/dPV9jjwO47ZsYYc
         LOTMyyDernxOb7HrZplSnr+/NCsbyISz/heDNl4BKAMJWH9MrIaW4i5pj1A6LmzZodxz
         NKnEge4UouqjZ1rp/7/l3Lsx0smTL1LesgPoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267591; x=1719872391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
        b=fLkN0Af2DPCcbbYI6GMa0jqfCCQ0COe9qSVuQyMIltCLs4RDuHF2v23cJ73Gz/H2uW
         /yRNY8Ll6cDPMonYioI3Pw6kHegWwMX9T4TjMMNDuY9zmsQOJ7d8dlx41Iou7ZvMGqpL
         DvvBzgU4aLBc2DNnBO4Db7lP7OiYNUOmhB2bkr6Kp9IwT52aNMWyNSCdkwEA2a+jOWf+
         eounS8MxTfzfSU+pEs7JpuHBOfPXG5YM9X4fcGLqtpGXu1ihoWgJJMs1DC5H7gSX1KLt
         ZUUWUYfVNy4HNVlv0N7w0n58kjsQjNAkxFWV+4hP6PAwbFJwo5vOfIrZLBkHFSPjYbbQ
         ejnA==
X-Forwarded-Encrypted: i=1; AJvYcCWBMDqxYYezxdCBgRIZWCYRap4/G9ncKGSF3V1b4gY4+LHXYlo0aFCG6i8VUS/YcysGIxsxidptC6/zO6rZFiiNCKC0M3xN
X-Gm-Message-State: AOJu0Yz9sigoTeA/7b63/zp2pqjQbwIj9NhMpq4tevitSnI999d0949/
	+EdG4b3o8wDmoT/OssYV8NFEAczgxJcHBX3/eRvgJdzyK1caW8t+Mb+sW/NLh2wwicIFj8yCzPs
	=
X-Google-Smtp-Source: AGHT+IG1xU4KdPp8HyzgSiO0aWjQ+cOSmyZWhmb7VftK0MLtTjqbUVH2OPZMx4eZXQDErl9Ven8Srw==
X-Received: by 2002:a05:6358:5f02:b0:19f:5317:499a with SMTP id e5c5f4694b2df-1a23fe12f56mr771573155d.22.1719267591559;
        Mon, 24 Jun 2024 15:19:51 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed8284csm37693346d6.69.2024.06.24.15.19.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:19:50 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44056f72257so52681cf.0
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU13eYkE3fCtgPsSzJflQZniumHNHHnQi/C1ETSW9Q10nK3qe/P0K9ivFuKc1/WDyu7Ocy5cxaB9RaxMlWaUNGxqGvmDssa
X-Received: by 2002:a05:622a:18a9:b0:444:ee24:8dc8 with SMTP id
 d75a77b69052e-444f2566c83mr1037071cf.22.1719267590005; Mon, 24 Jun 2024
 15:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-4-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 15:19:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UL2NCbxmQALjKbW4BSpf4WkM30ZHLf1eZiMqRP+s-NDg@mail.gmail.com>
Message-ID: <CAD=FV=UL2NCbxmQALjKbW4BSpf4WkM30ZHLf1eZiMqRP+s-NDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: qcom-geni: fix garbage output after buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The Qualcomm GENI serial driver does not handle buffer flushing and
> outputs garbage (or NUL) characters for the remainder of any active TX
> command after the write buffer has been cleared.
>
> Implement the flush_buffer() callback and use it to cancel any active TX
> command when the write buffer has been emptied.

I could be reading it wrong, but in the kernel-doc of `struct
tty_ldisc_ops` it seems to indicate that flush_buffer() is for the
other direction. Specifically, it says:

This function instructs the line discipline to clear its buffers of
any input characters it may have queued to be delivered to the user
mode process.

It's hard to figure out which direction that matches to, but looking
at the descriptions of "read" and "write" makes me believe that it's
supposed to flush characters that have been read by the UART, not
characters that are being written out to the UART. Maybe I'm
misunderstanding or the kernel doc is wrong/incomplete?

I guess the underlying worry I have is that there's no guarantee that
the flush function will be called when the kfifo loses bytes. If it
ever happens we'll fall back to writing NUL bytes out and that doesn't
seem amazing to me. To me it feels like
qcom_geni_serial_send_chunk_fifo() should detect this situation and
then it should be responsible for canceling, though better (in my
mind) is if we never initiate any big transfers if we can get away
with that and still be performant.

-Doug

