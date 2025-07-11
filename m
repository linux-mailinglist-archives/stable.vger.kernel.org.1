Return-Path: <stable+bounces-161647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB0B01B73
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9AB3A3BC8
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308B28B4EB;
	Fri, 11 Jul 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLifZW3h"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FB1F4C8C;
	Fri, 11 Jul 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235531; cv=none; b=EFlcA8mnZTCsXmlMlTQQQAnNTEqXzGnIKiD7xxv8pKvsPQItRgN2GSvCyIu3nhjDfIo+NxWUBN424rEWBxPetT1F82DJEaZyFwViZoiKqTnq5QFr6HystMGFTj1IS8ukqyyJnv2Kagu0brtYIsoBFSKZFhY9tw4N9XNfwCaRy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235531; c=relaxed/simple;
	bh=2AEASaq5CDzhb6ktnTbfQ22tIfOZRPSGaJHgFyQUuec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYmtD9oprLp4UhdH3BqtDemrJ0cBMd3EPoQxWnfqrKErl/J8w3rNlwhOWYNKhoYExJ6E9AuQ09z21MwYQ7QtTE7v4kwKk6F3Kug5hwbxjHpGDc6Ze8qyXZ6afTjoqtTc3E7VsvopmesntAnt+Ic/erXkxwJnlKeYmFNiEUE5XsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLifZW3h; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54b10594812so2064705e87.1;
        Fri, 11 Jul 2025 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235528; x=1752840328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AEASaq5CDzhb6ktnTbfQ22tIfOZRPSGaJHgFyQUuec=;
        b=iLifZW3hfNPgld3SU2c+IW0B2Ks3OgBbCjXgiyppFYvYSuCXy/gtjpksCDvIGBAkRl
         wNgqF4DqqqKJVHeLxdpjNiPn88AIycN5yK4qY4SS6YoUX3alkr2Hk0pTASMMaRqahB1t
         ad2ejkG85kdOT74sFvUIGH21I8zuKa+iehMqX07SrHOskMRu9Llbsh65qTJmFLHU6vVb
         oBFxLm1W+IoaovSdQjgPgM9wnU3inv6V+UDlDgdgI431HWlutRYpp8yCBpr58tFwAl/a
         WCRHTR5h1oXPmk3dziBnqNuKnFNX2bkn2rRdetY4fI5jLSr3/uVZcmdAyxZImToSQ1hD
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235528; x=1752840328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AEASaq5CDzhb6ktnTbfQ22tIfOZRPSGaJHgFyQUuec=;
        b=CmiwiD3KvTICyF8lffnhLcinpyvE8QysrZwEWr/soEtnZ/fArse6aP+HbXqkBbkJmp
         8c3z4A3pkJm7xgreoRX7tOjuefKMnNp222jA9qeVAWa+ZRjqL8OIKkhb4lypbH6CuQqF
         bFuNBfYEIGf25qFKD0da5NEM+7qIlMLOgukA07yora+0EKm+k6P+bb71qDRwi/bh+TOg
         sirc/RtXQwYrG3/2oXY/+T5tzD+KkxnnHsaUg98sTtX4HcHvP5RW8wD+65jUvAHW+RFl
         7PQ/YPFz2UqdUCkTkAtrk8Ie/oyDtyGBrhf2MZuZqtzQHVTKyBGvXxL3XWOhl97RtYRi
         o9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVUat1+4MeQE6Dysz1bMGGSIq+zLi1CaKX60sPE6VWaLvL/8IY5Cj3rTSTk4nxuSw/J9OowCW4o@vger.kernel.org, AJvYcCWqS6AyMeLNB3KTrgE9nTeFvGWwRdmsgtMiKa1dHS8UWKefgGD03jxb94Hu6ZuMj0+zdujP4aZ7NL3iqdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzXHh+F8SJbuwnqcCWyMlEQyYhPB0gZHNoUTBPdeblPMqdo92
	ZkLe2NGTr2uRg8xJSGXeGube0wWbJiKn3XPpyVrMvnhf2nv3RtJpU2qTFPnLvAPfsztlrjLPfy6
	waUBWP6YcOrYapJDYxfWL8pPXqXnDAyU=
X-Gm-Gg: ASbGnctDKHqNgT0bNXacKwTwn6zywR8yy+cOOeqlg5R9eN+XICRhzJAYXrIm2h4N/DW
	UezbeHz+nAVSUO3JVKoz83a+U07jEo/5PDoZ8MKoK1RzDiFO/1bbyVqLziEaFuOAppM5FUNGsYN
	C54xMQLqIaU2Sh8SF5uG7RvNeUWW3CcQhtxUBI9a9JtVgVN2PIpR9CyEZ8UU0fs+kKN/8os4OA/
	etwycdjOwxICBK1l9dUuPHO88u63mJ1JoLwEtc=
X-Google-Smtp-Source: AGHT+IFl+IoLWuIaEOcASJ3YDYcH5iOQ7KM94YNp90zKqQwivksqlWt3cmzdDFclUAJWq5ZCcUCbfLJPflKvNsW1j6Q=
X-Received: by 2002:a05:6512:234f:b0:553:2645:4e90 with SMTP id
 2adb3069b0e04-55a046448c7mr1047920e87.52.1752235527861; Fri, 11 Jul 2025
 05:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711120110.12885-1-ceggers@arri.de> <20250711120110.12885-3-ceggers@arri.de>
In-Reply-To: <20250711120110.12885-3-ceggers@arri.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Jul 2025 09:05:16 -0300
X-Gm-Features: Ac12FXxXhUl0pWyBQ1-EtucR0saC40xWMP_mrTY-Vw0EB65wy0G0ZSkmB17HgQ4
Message-ID: <CAOMZO5BNgGao-+B_K8+7juBXTHVKr72NCRRk5NMpr2ew=t0+aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmem: imx: Swap only the first 6 bytes of the MAC address
To: Christian Eggers <ceggers@arri.de>, =?UTF-8?Q?Steffen_B=C3=A4tz?= <steffen@innosonix.de>
Cc: Srinivas Kandagatla <srini@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Jul 11, 2025 at 9:01=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Since commit 55d4980ce55b ("nvmem: core: support specifying both: cell
> raw data & post read lengths"), the aligned length (e.g. '8' instead of
> '6') is passed to the read_post_process callback. This causes that the 2
> bytes following the MAC address in the ocotp are swapped to the
> beginning of the address. As a result, an invalid MAC address is
> returned and to make it even worse, this address can be equal on boards
> with the same OUI vendor prefix.
>
> Fixes: 55d4980ce55b ("nvmem: core: support specifying both: cell raw data=
 & post read lengths")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Cc: stable@vger.kernel.org
> ---
> Tested on i.MX6ULL, but I assume that this is also required for.
> imx-ocotp-ele.c (i.MX93).

Steffen has recently sent a similar fix:

https://lore.kernel.org/linux-arm-kernel/20250708101206.70793-1-steffen@inn=
osonix.de/

Does this work for you?

