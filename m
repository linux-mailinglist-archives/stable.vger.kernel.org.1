Return-Path: <stable+bounces-118334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F35A3C96D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102CA168938
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A507214A82;
	Wed, 19 Feb 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Awq6Xmbh";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="tqFTyAwL"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C589214A91
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996041; cv=none; b=EgbmB4jLEmGmT2GdtLrCykTO1Fhj6opHYSzwDW4mXHs2XF8pgdkhBs6I0pH2aT7l2kjG24j9zs/IBvi+rU9EfGuTBTyErhevjz5/81oN03rqBgnxe9u0K4VvxlGCS8AF2AQTJpsRPUad2tPJ+7IPhv99w8Q2XCR9ZDycuBJmUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996041; c=relaxed/simple;
	bh=ncGs2z4pfHMjN+d3lpcfpfn98kj6rBfaHKbLUA6xG98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npz8A+2rsT/6K2+brFUU9CtoDkWlyrhYKeDhY1C7b9VG9NIo0BnLfHpjAnnUQPnqJkF82I2hfEEL2szgP47LEVZ8b72Ram7+gGcy8nopJu1r+9SIpd+VaaHUaefKTCnJxm/gijNb/d7M4X9HZOyy3/WUrJ8MeCXssAUIGVrfns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Awq6Xmbh; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=tqFTyAwL; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=ut4P1R7thuxaKMIe42U//2Z0wRf+Qh4WiJbioRnnIoI=;
 b=Awq6Xmbhiym8F2HZvToYTK3lP+Y5eTsASm6KRf0aGFWdro7wF8N31XFQw+5V8wsNGiIR5XfTt8mTPrliDUuTmlfpfhd6wS5o+G2UBtUvjowd3cdJgIWFQfkqVlW8fCiQpUn6fW7TJiTanYZanWK1g/49h0ljmCjRYMB7eM/wNN3/TWqYiL8cOu5DCPQq8/zsKRQPi2nvNANgu4mZSdBloMwLGUlQZhJbLiX7HYOx6pnSaLzMEeaQH3vmu2YaSOB/BNW6epxBq17swS4VITWMW6jb44mi6l96sgOVgfuDkPnY3n7e21l66mCHNX0Di1WnKGMXwG/FHBymA6uKkAUi8w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 419E12400AE
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 20:13:57 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so145373a12.3
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 12:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739996036; x=1740600836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut4P1R7thuxaKMIe42U//2Z0wRf+Qh4WiJbioRnnIoI=;
        b=tqFTyAwLAy9CZkUqXFTfMmHyLPTuU0ETCCEDtTNODc+RcNHdB2R6IGNgtUVwX+zI9p
         uk5JLUqbRBHdd/smhDvbaakX3VLr36L1aPP0HTlwQNaMJ54Y5PIdxVXua6EW1xXcD/TL
         gZjq9XL8tGe0fel/cNQwSauuKNygu8BOqFM3vrML39QOhW1/+BhGxToJ1B05N8v6VYtu
         wdl+8vVIZ8lK9Vy1CV1k/eekH7yzYgNLmaGOXM6NFcuJmQ1rOHqhgCm5X4ccjdxjj5rt
         WMfpp6thb9lJU/v2e2ef2SfEmkJtQoBxHRZBQQaWGvMe54K6b4j0CXa69myzu/cJRuac
         zrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996036; x=1740600836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut4P1R7thuxaKMIe42U//2Z0wRf+Qh4WiJbioRnnIoI=;
        b=HiK3yQo7XGJRhRR+RmyNhCW8flDZA0aqtJ9f/jmYzonJyRg6Rni2ro4Rrvm3+9OPKa
         z9YXGe5Nvhg+Aa7BfutXEKUrMAIg/HUFSUrCmFCZd4Gj2kPVVyhG6wxeHUqZxkuDDsqe
         w+uUNs2b0V/8xOKqB3ivXW8xH7pN0s6QbZw1ydflG+ciPab427Ck7faVL5A3BqOYlw9L
         VjTqA4SnjjZhPJV7uMwO3BTYNrcYrV+h5DrK+6ILw3DDYL6s+H5WjQGwtcI2hKmogvXs
         EOgXP8Q/bfN0SFQUEhcvqjr/x+IqaKFS1ez9yI+IVcdbh3XHnfaXoy6ZhkIiPpPUFB+m
         WYWg==
X-Gm-Message-State: AOJu0YycSoKICppfdI9nIeHlOeQW+ft2GPIqhF/Nx33E1IFs8vhRWXFJ
	yVRCgqy+uKFAz/QTE/H2hF0C6kSmRUfHXx0wtGzqi6a1fNSAffTp3ikgtgeA7eTO9OYG471UU7Q
	qoZrv1c0vQzXibCmvPeH1o6Aqk+SimvuOEeTREENHzPxu2LU9n++fmY1ml8xGL9gwe82jNGo6Vb
	J+tCkd4YLetZyeb2qaEpzsyj0gcvA9ZtLcg7xfab6NWj5cV6KkdA==
X-Gm-Gg: ASbGncvBhQXI1yT8AOmbvOgGkLVgJM9TZFeYFdhWY5wZFGOWCulSf9iUKmdGOGxokCC
	JvsZEJIeREEcWB7wF3V0CvPxbUutno3yJgopsXAUyW1m3tNsNhzLQQBdenBF3iw==
X-Received: by 2002:a05:6402:35cb:b0:5dc:caab:9447 with SMTP id 4fb4d7f45d1cf-5e036063e6amr49232745a12.18.1739996035986;
        Wed, 19 Feb 2025 12:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0KvQ9Ik3mCAFqGO1Y3HmZ0iJJC1SyKZfLV7M2w+N5UlImKuoI4YmqvkXHE+fgnAGu7i3sSGq4opUKSR07pFE=
X-Received: by 2002:a05:6402:35cb:b0:5dc:caab:9447 with SMTP id
 4fb4d7f45d1cf-5e036063e6amr49232642a12.18.1739996035270; Wed, 19 Feb 2025
 12:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082652.891560343@linuxfoundation.org>
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Wed, 19 Feb 2025 15:13:44 -0500
X-Gm-Features: AWEUYZlZSDPa0fGt2SFhUpS9xdY1jqEpDAGyJntR_9fKDs7gkaEck9SEpNdTnsI
Message-ID: <CA+pv=HNn2rhObW67iY-i0LkQoL30uXXxAbfWio7BgFCVp-0r3Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/578] 6.1.129-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MDID: 1739996038-jkHAratyzrZG
X-MDID-O:
 us5;at1;1739996038;jkHAratyzrZG;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;

On Wed, Feb 19, 2025 at 4:05=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 578 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

