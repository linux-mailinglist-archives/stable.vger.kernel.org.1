Return-Path: <stable+bounces-244362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEwxL2YZ+2mYWgMAu9opvQ
	(envelope-from <stable+bounces-244362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 12:35:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F294D95B0
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B5B5301325D
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA723F54D1;
	Wed,  6 May 2026 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njCYnPSf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC473FE672
	for <stable@vger.kernel.org>; Wed,  6 May 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063660; cv=pass; b=DFyGuYoOMMITl3eKghpZHzCwUEN4vlDMsjm4TBy9Psdwxl5drqqCr4vqv4FF6sr+zC21+22QSVVGSgcUuzKwTw7bjvtfWsj7BzJj3cDsxg2xud33DxqzznTgSkZGKb1oTmI73vM+fLLGQJFskEkUbt80j6Rfux3Autkl35AZPls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063660; c=relaxed/simple;
	bh=ymu/ULNMpf6rOlkJLsdppPQLIdg6x6fe6eAOnsCUVqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF0qDlPhkvj8W1qr2OY4VcM9oglf4pgwYJAqk4IuuuvMMmpn7GiG4kTOAj7cHL1hKweXUMtXZ6hg/2M+evYEY222BPu6xXwX/GqsHjA8X+xNdJIjYWqgb/kOQ5yWkx/e2A0MPps6GpHInx5a5VRudZJojJn+UAhe2l06HaaHH7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njCYnPSf; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so5156554e87.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 03:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778063658; cv=none;
        d=google.com; s=arc-20240605;
        b=hkrOW2G7r/kXe+vgALl/g7TYIPRUSgrLOqzukjIWKzzP4BZr0FXP6OMu9AtXofo8l7
         h62S4BOi8V0aCLppWZNcduPv+3Y+sk2liJ159HKbNoYwsc8jSkwyHv4bc0g7KFYhF2BE
         4qu4TGZXmLNbeNZNGR2PciQ+iGfjHy4FjXOXVn82mrms5PJWKXr8I4vLgqq2eyqN94Md
         4W8mwoTC301Vw51eGsl6mf/ATgoW4y73VXhw78cfAx2+otugi7P6oAS1cM/fsHd8u51N
         QUQnRw6H+FMCGdegkgOZSd6gWsi6jGA5/Ud5QCkJcnI4iiSgxP6vBY2jEKXbj7iMAlDp
         bF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zu6wn52XuUTERulX1xQyyyKBkcflJXL7rnBSTp2R7Zw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=a0qR+m1mU9TJi2/XaszlCCBWotzhOX1y/lQvYU1rEgN8mXkHta6GTCkYa91o3m0gxf
         WLYA8gDTAOnmRim1TesVAVwWl/ZV5SsKL5bG/bjCM/XSpJ2odYRhfsOVUgayutKmQop2
         dLjgtR3KXzOPWqEOsDA9FIkVxIZ0Df39+acrx0KyIhKYaEKKznqe2tTA8WJIVgadb6Tu
         9YaCi6l8ZTVblSOVv6NQiQtzXgE0dG4KWKyqJxycMLqcV5RmnQ8AkL+P42aKUQvSu1Bd
         OeMf4nI9PfNaxWdRymO+fT4sqTxxboSl/VPY/+AlgZiCxCqb+Gha96wwKnm/LFARxvbB
         4PWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778063658; x=1778668458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu6wn52XuUTERulX1xQyyyKBkcflJXL7rnBSTp2R7Zw=;
        b=njCYnPSf+HcVLRQ8FmW4wlmkp2u/SCOGE490j+wyX4BJB3KcXiTghEX03pH76o8A98
         DRfJhGFnGc/5JUzTzf6P9dIjzIg3Aa30tiNc1YspzzBngneZ46MDEiJFoUe2Qmvr8W5+
         87yvnlC9DYOLdw1nG1xfGCwbnt9yI3vcnD1Rqu5GAg2v6iumJOgUiODxUuCnyt2lIhG9
         FWpDxRJFxhSKzToZc8JZLJrwoWHHEkdMio87s+C7tUCKm0stoHdJrG+n53coVFTBXFu5
         l9n86tJAA7cggSr5ZMEOaIYcaxd4PSLgiNYY9TyzwQ1O+YqThxIt4vDy7Yf/IIzEb7xx
         L3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063658; x=1778668458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zu6wn52XuUTERulX1xQyyyKBkcflJXL7rnBSTp2R7Zw=;
        b=X0dh6V70SCVwwCSxRzWuM6V2IUMqBCwpcJQ1UzqVMvlUCcLavhsLXUfsZ5d+9LW7dm
         ztv5V6+sWHF67RiE6gIqXg9MMPFzG9dIJ2L8xoOjwNgoElKT29iTlCFtwyS5KZnXRSFO
         IyRoFujVmtOL+VXrbBwcYlBlCUUi4/MqMb3CY3LS0zYGa0ZuP/s2gdf+PPOllBFfVMQw
         1P9ZNKuE57PnxWZolwPyB+B0M3T9hSSd0hy2qAu90DA6yL2DOUJ6vQcW4fWXTqWPIuNC
         FzRor9S0Ci8BtdESL8VZF312CvwnmlcMeOOmOwS5F6T+3iy28CYqLpqf1F9wLqVeG+53
         C55A==
X-Gm-Message-State: AOJu0YwUHuMY5v/ijGhXC+tZ6FLWhlxMinjbNUz04QaGPdxUOOiRX19V
	qrlV7A+ntVAIy8o00JoHXAYBPxb3f6ppsvSXLfwAaWrd2GbT8aLcZWhrXtSjPZpwHKsCfRfdP9+
	w3gAAr34e260cF7pVCeYF8TszDwvPLYc=
X-Gm-Gg: AeBDiet+tA0C9cs0DE2aSIb0/IwwyQWhFMdI+8+FM1whC6cDOe0dzcYT4wGxoHdidys
	BFp9HMCzkQXytgANxZdfhjqxVKLoioxT5i4QininbyFrYc3xnmI/QFYuZ+L1ZMEECLrLJ47p5b8
	EfmLNygtXclkViCmV7yDzx5yfFeTKvJ178ZRK6jchWeJhY1SR7IJYnIhwwebs4eAgdVOQob31LW
	RV2IuElUlG0fFq9BOjFmUW2hwm+WuYt3OllJBpEFVaEb1g/vf81oE3GcJO4RF4ZzYW33xwp/L74
	eW2oEitygufc//kd+DBzLhGNGGyoA4LaK1Ex5wI2eHmBSQa4Vw==
X-Received: by 2002:a05:6512:4008:b0:5a8:80ce:ba55 with SMTP id
 2adb3069b0e04-5a887ae1e90mr1184465e87.11.1778063657311; Wed, 06 May 2026
 03:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504135142.929052779@linuxfoundation.org>
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 6 May 2026 16:04:06 +0530
X-Gm-Features: AVHnY4K7yxeD5Ig1FnC-1j_hdVDnXwTmp5bmA4Z2kBvlTKJ4EIy7RnQeAUK2Kbg
Message-ID: <CAC-m1rqbchqj0qiYnC6cRuQTpFX2MpXr-D-YXY+KgrNXx=vZyA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/275] 6.18.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 26F294D95B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244362-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 7:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.27 release.
> There are 275 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 May 2026 13:50:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.27-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

The kernel was built successfully and booted without any issues
in the virtual environment. No dmesg regressions were observed
during testing.

kernel version: 6.18.27-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: bc63ee3bfa3240cc8657ef3302d0f3923f8b4bd6


Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Regards,
Dileep Malepu.

