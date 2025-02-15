Return-Path: <stable+bounces-116503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC2A36FC4
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E03A16FB64
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3CA1EA7DD;
	Sat, 15 Feb 2025 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="aBsnKVA9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDF1C7011
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640354; cv=none; b=trWpptx2Na65ZdfvxcTR/CnMb7WbBVfhGUKxgRLfrVjlFiDwQ3ZdHD69mJtebx6jg5/FGuXgSKdrp5GVMROT+9mzQk7ZF3TXQw97QRyysvdrVxY9+7h0wAUgEemuEsH1sGtIWcb/dtwUuwrnN++jBY0y/RtJi7RFPXsMBl4YmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640354; c=relaxed/simple;
	bh=bWdwc4tU+jS/WtyYL5ZUs1E6ELOzM9Zd3g3hT2CGL20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnE6J3Y/bvpJXFYJ+fPeQ6xB87pvCxRXIDWrt7bRL7pohWZ4v46vSLgI748jFPeb6td97+h/Q78KBsZV0NHBZtrwwxOGHK0Nlgkq4kDzqTZPtEakr6KjdYGy8pCCDme95yNuNAHlCGEzbtW7dhQM03cLDG6Cgcl4J9jYhJQ5hQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=aBsnKVA9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7520028bso71010066b.3
        for <stable@vger.kernel.org>; Sat, 15 Feb 2025 09:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739640350; x=1740245150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHP8LGPaE55AxKwpSHf5L42NI3V/KQU7zbKAocoI1Fw=;
        b=aBsnKVA9ag9LC6n5ANYZdb5zeLf2sQJlZ+LXg/4VdFDaiYs/T8fBRNEzptsFRJVE4T
         bGmMd88mjEIZTAJbYq+HxsAcVaFXLAFHmHnoSyRDRzuGg7omEvSqbDdCqGDB8WHXr6ot
         DiWS7YqXH60NCiEYU+EU3G/whlQtUlwskc1tigiVVQ5s927i2Wk+95DsHJJ7JLNdY/Kk
         4a3YZPlqFJ1t5+6MZTvabV/pDGzsK9HXKvEcrWl3AhyNNsUUZOzVnNau6Vfj/+LQT2pH
         R5OM/XSE9KwE7UbZE5CcYqh49lzIKuuuReZbW7u8az1A0Vv1wzFUnXuuzLaI55WB9B38
         Rs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739640350; x=1740245150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHP8LGPaE55AxKwpSHf5L42NI3V/KQU7zbKAocoI1Fw=;
        b=LVwmhk9IiQ1tPjPjANLfuLir/ulfT+QNL37H1o0Bj3HrvFWcx6qMkufk5cBc4y+VTy
         4jVE6wQCrRTZ2o6kK/gFftgRFkYYhoGc2+wXaH24dw7DWUg2qvhsu3ksh+6Wx+QUK/Rj
         Cz8Rbx6qgCau6P/o0xC2MmBRN7IOvi2PbBl3Q7AL4gsXtDHOL5UGIT5uSDLttJi9VWuN
         hDyWK5TxAn7tMq4L2+/supVrhGmKXorCRM7UeDiiOza44Ook6cMYwZ9LfTuru/v6zkh0
         EK8HfNbWGLcjeGsiHbIT7cg+vXVKDmcyhOasKYySoPvwtCy3d+kkdqNt1SFkjwmM4SIP
         M4Fg==
X-Gm-Message-State: AOJu0YyAmvCUKX3Ai0+bgX4EXZxCU2jN/DvBlrvLB7U0pOJuAfi6MtIL
	pNoC8T80NruoRnVIehqOsppxlCExj47/Ieq0/48sutYc2Rnvnzwo9SAf1f3CGYewjhDm0pXXBvC
	gp4FT4GoG4o04363CM+Y+7x005H+QYIjykaJMKg==
X-Gm-Gg: ASbGncsfSv2GIgHqirkHF1+kZXJV2KTXRkTpgwGyXAqbUsH86qoMtD+uKj/avCrTEJy
	EnOiHNjSNDStbef3FT0HASKy1lM6pCj4rqMpL0Y44VaTE/kY0Z3r+PFl/2bSXb+bwYGhWg70/
X-Google-Smtp-Source: AGHT+IHJzLjc0Mpd+v0lswpn7DhJ2tM9BZti1csqHDT4yfjUQZtHYKVsAb7uI+EuHhv1xXJViJSu9WBUuDD1SVw30Wc=
X-Received: by 2002:a17:907:1c21:b0:ab6:fd1d:ef6b with SMTP id
 a640c23a62f3a-abb70bad34amr363614966b.27.1739640349746; Sat, 15 Feb 2025
 09:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075925.888236411@linuxfoundation.org>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Sat, 15 Feb 2025 12:25:38 -0500
X-Gm-Features: AWEUYZkvqJ1y-XsnBU_Lwvy2M4G3bDMXGE9SW7Ow2NVPM6dh7UJTVqGNeXXm7gM
Message-ID: <CA+pv=HOEzqtotB8hp4ikj_q7NWFB334CgPUT5BwYi2Re877dpA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:57:54 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

