Return-Path: <stable+bounces-107767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B46A032C2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986931649C4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301C1DF748;
	Mon,  6 Jan 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WP5GlpCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BD1D5CF4
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202792; cv=none; b=nhV+0vCI6M/CMYuMfNrluLc1dCQCTpTHEnVdOyZzs6YXOjw4HvvgW5zRk1DRZnUuBoFXXsaeua/hZ9ZIIT82L73K7FjRzj3Tpqa02dS7gfU0hSr96GtL63Apz3mEV1XVmblDLaehvGqb9Xb0pvu4F/HAdLYUyuobBfiiawxHDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202792; c=relaxed/simple;
	bh=aYm4URDEQO/lzotOzZp2mj5H89M0Pd2jmDgyB7Kq3gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mujSXoFw8KkxJDoiIkCk41NwVK/ldmPz/hiFlXo50JS5TOLz7o1Af3aI66VT6uPm5Qo9JTjQmESwrmZIbXBcL9hJh/nMCDCc3xx1E1BvmCTH+XUw21t+tdq22ZvDKKvhpkORZHhLFAcROpz8JnWOOTuzy6i4zBArf4s5X1ArAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WP5GlpCl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so15164472e87.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 14:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736202787; x=1736807587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5di1ZJTIkSt/0vjsQI3NGZHRVROu2YShhixW2NJYijg=;
        b=WP5GlpCl2Sw+RnqqcZbDdAycVRRtKK6N8Bhvqq5f4eMlJovxxWg8u+myui7ET49JJ8
         i+w9dUICmVC+q1Ca0ssGHzb81u1/7dhkVd1Idr5DW+LxFrKAPnEckbTAncYdpkx1uDp9
         jWtuAdnPFhysp7TGoLqpYbvImkorzLchNZXqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202787; x=1736807587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5di1ZJTIkSt/0vjsQI3NGZHRVROu2YShhixW2NJYijg=;
        b=vKOBk6h40no30BFQS3mAGDfPvh29tIvc5nmmgfjBxcrjhzS8a5iDnkZra9qk8WCxxi
         EDXOekXSlipj6fpQLjG7wG5FJIKBmz4aFtKMTXdqc1T2RDb9l0LFX0PKtIXHmSSGv+5s
         SK4P5caHTTR9BTFoqLbPKHfKUwbkflbSwjjRo+VMWRGB/rT8IyTQ3EqWYtx31RgULQrD
         ymhQRlcX/ic/sPzJHgYE6j6eUntQCp5DW0bsnviusVWtpCu6FPOfkoQcz25qye5lZFn+
         FBcDRlKKYX3C3S4HbSGE7cTpnK9YuoTemGBJOP3byz9XYjecwiXX38uGYIs4UwkApgQL
         3DLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfEuiN45W4BA0852dcgNpkO+g5YnYbJLwahex5VaXY3NjT1bN6G+veVD6hexM6In42bxF8e9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYarrXyKtp7rdYVSE1tuay0bfheqbzEIgBshHMyITes6WsSxc
	Xr1rj0GkpndDvAAvRSt0rUZvEUFMZmqw2oY64oOe9KImlgk5Rf0Km2yagLiJSaoMoYsx8G0fgOw
	=
X-Gm-Gg: ASbGncsRaJtv/1VcFTtYRAkvsKZsXqKi93nGEpVNXGvsChH2XtNcjP1wgNbTJEBt3Ct
	UKe6Kh2q8bMEFyR4ZVYLl5E1GnjtoJJ6vdGhafzXDSZmU+/4yOCC04qwPxo5NmfQB1jvaRtWMj7
	oD4tBSvjGDl9GiqMnm1WsIUkuiqG6Omkj7TN5xwTwAx59asH3ZCich6qo5xc7q0jewRQtZsDroT
	oObpcez9NrMdau0Jy6guUASLpyPDyNMYcVFhlrfvjhCDWIJPa9BroD61pJ89IRrxZIh1/M4gZIZ
	2qFy51fHHGdZW7u283Wb03GX
X-Google-Smtp-Source: AGHT+IEA6b7mtpys1j1i9nuGWwpYRdR+qO1yj8FUHfNzrvAcAICLODu9Xtsr2AsC6TED4W3hjrYhFg==
X-Received: by 2002:a05:6512:ea5:b0:542:28a0:a721 with SMTP id 2adb3069b0e04-5422956beaamr16672022e87.54.1736202786596;
        Mon, 06 Jan 2025 14:33:06 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f6514sm4967963e87.24.2025.01.06.14.33.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 14:33:06 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so168136811fa.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 14:33:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXje/6OMosUP1w9mYhsqLjPdrqNKaOCoXwChsMssruN/31RhmDIzp2jlERmFSkZpssSMwkADo4=@vger.kernel.org
X-Received: by 2002:a05:6512:23a2:b0:542:1b86:7c1f with SMTP id
 2adb3069b0e04-54229522934mr18141915e87.4.1736202783870; Mon, 06 Jan 2025
 14:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219205426.2275508-1-dianders@chromium.org> <20241219125317.v3.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
In-Reply-To: <20241219125317.v3.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Jan 2025 14:32:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6t42VNFSY3Jk1XUk+O=B8VnhioQxOHMv86ZH0BqLJQQ@mail.gmail.com>
X-Gm-Features: AbW1kvYZAqrZVb37fi_gK8pn1DP2gA1RSqPKabqLChsYVb9JJqj2V46xz1vb8Rw
Message-ID: <CAD=FV=U6t42VNFSY3Jk1XUk+O=B8VnhioQxOHMv86ZH0BqLJQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>
Cc: Roxana Bradescu <roxabee@google.com>, Julius Werner <jwerner@chromium.org>, 
	bjorn.andersson@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, stable@vger.kernel.org, 
	James Morse <james.morse@arm.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 19, 2024 at 12:54=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> @@ -916,9 +932,8 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_m=
itigation_state(void)
>         }
>  }
>
> -static bool is_spectre_bhb_fw_affected(int scope)
> +static bool is_spectre_bhb_fw_affected(void)
>  {
> -       static bool system_affected;
>         enum mitigation_state fw_state;
>         bool has_smccc =3D arm_smccc_1_1_get_conduit() !=3D SMCCC_CONDUIT=
_NONE;
>         static const struct midr_range spectre_bhb_firmware_mitigated_lis=
t[] =3D {
> @@ -929,16 +944,8 @@ static bool is_spectre_bhb_fw_affected(int scope)
>         bool cpu_in_list =3D is_midr_in_range_list(read_cpuid_id(),
>                                          spectre_bhb_firmware_mitigated_l=
ist);
>
> -       if (scope !=3D SCOPE_LOCAL_CPU)
> -               return system_affected;
> -
>         fw_state =3D spectre_bhb_get_cpu_fw_mitigation_state();
> -       if (cpu_in_list || (has_smccc && fw_state =3D=3D SPECTRE_MITIGATE=
D)) {
> -               system_affected =3D true;
> -               return true;
> -       }
> -
> -       return false;
> +       return cpu_in_list || (has_smccc && fw_state =3D=3D SPECTRE_MITIG=
ATED);

Upon looking at this again, I realized that I can fully get rid of
`cpu_in_list` here and the whole `spectre_bhb_firmware_mitigated_list`
variable. After my patch there's only one caller to this function and
it only cares whether the firmware call can be used to mitigate, so I
can rename this function to has_spectre_bhb_fw_mitigation() and
simplify it and the caller.

I'll plan to spin this in the next day or two and also include the
proper loop value for Kryo-400 cores, since I've got that now.

I'll plan to keep Julius's review tag unless told not to.

-Doug

