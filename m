Return-Path: <stable+bounces-32225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D688AE66
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6481FA310D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652174501F;
	Mon, 25 Mar 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITb02MdP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536C8526B
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390473; cv=none; b=HEP/16MPYBC/f4cBpSvZ0tYCg6koEsAWb61LIGiC+CfmFS7DuH9phR/aBtMY8T1BX74YZ8fG29zox0D6Yc2F3U6Hag+0ICL9/n1tZ+XrbEWfkb7mAIm/H1uD7Jwj9WrfNEvTSM+OszgQf7gJEufZMzJk2m6JwaXWpS2ZfPxAh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390473; c=relaxed/simple;
	bh=uoKndnM7WR57Y2jQSczCyTa7WbsIHgrSH56Dgnchj5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuWh71A17rRvnHv2AsvOcjVj/LCZ/z2/W6jvZwmp6KzGLX5zaL5I4vBNaYZ4ZvOmsFuASZSibWPRwsAm9VB+bYxH8u7zoE/3lNdT4PubFoOpwdaJgCsNYxZoy5XffcnMgI1iqEjp5JK++MEMNgT5BFUVWd+1dRPl9NAhB7qh/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITb02MdP; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7dfacd39b9eso3005938241.1
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711390470; x=1711995270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7mzMb89CzzOzwuDZNRkxn1omr9+Z8w6rZzQ3Cuwg1ck=;
        b=ITb02MdPPreiQiu54hF03ocHBU/92I5/SYRH14Y8rINKORrLSyss6z4k4JpeR8YXLp
         cXp7C2K8sYjSGxchltEhQpRR60qsogqoL+ewPasreu0DMSFEOrNGEDnPlYXqByzxheFp
         0MSgWVtECWI+hHw3XZ2FXOzYhVXSZba18L8majD3IqeeTXOMuev95a9k2okZlRqpzs0L
         //tcwAO+Me1pLnFX3+AtZppLzoofaEQ3i/ylY+j8wxFHG6zKr0B33DnvJ2KVPJD8LbKm
         6u7DOzumT/K6WUex4eYgyBNEsmBC7KWRCDeJemtkd4odWB4hhKc64eR9TW+yfW+XdHG3
         4P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390470; x=1711995270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mzMb89CzzOzwuDZNRkxn1omr9+Z8w6rZzQ3Cuwg1ck=;
        b=D4g6Z7dMSLc/NOj24eC+v4nVOLIG0ZkaIL8qT2BdH/Qj1lva0SxFHRFUMOZJdYXQDr
         rzB1MMOg/9Hx8G/aINNJkrv+LaZyNnxm/8gNjt7NEju3UlNydeG1D4SdQ5Fc5XY4JDAb
         6aCy5gjM3Pr2ME6qRuec3ZyRzEZvxdErTlfnPtz6ofJttjX7g2x9pHyGoYqWYc5W44Bo
         5JAvAUeW5ASvmQIGhXhNgXYsjKweYq9zl5MhiB2G3Vix3ZyDc9P1UVFQUILUG0jX6xuw
         dAPB4+rBbsgr8OWGwMZedPJsc+WnqH1aVeN7tPR8ar4aNiQe0ORcVgxl95tNZZjAq3iq
         O5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUCO3LpyTu+YkvY6kSUAEOCe6enHE5joag4Ey9mz2LVqCCT35lzWppbjo314M6KzDOdzh/2ak4fHknt4cXCK6DIZIhpPBko
X-Gm-Message-State: AOJu0YyNVy6/7fMVrYl2SSi7N8/Ca6B51199bNXeZfO4gwpFUZsyn4Pz
	zIvn8Zsau8xpLG/whuqW4Cpx6GgywMYlRX+QyvYTs439p0yTEimWxiXxJRgCSQuz5evIf5mVMy9
	Qtrsn35w5RSfZXfcfIs0hHXRn0S06rjJ+pp/yJw==
X-Google-Smtp-Source: AGHT+IF3AN9BTXq9VUzstwJllYsZ5/APcdgXw84SgQ3iZrX0RZ+0NWOxR5Eb0stGXtrNeh5Ys8hSF6Y4ah54JHuGjPM=
X-Received: by 2002:a05:6122:45a7:b0:4d4:34b2:9a89 with SMTP id
 de39-20020a05612245a700b004d434b29a89mr5359618vkb.8.1711390470191; Mon, 25
 Mar 2024 11:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120018.1768449-1-sashal@kernel.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 23:44:17 +0530
Message-ID: <CA+G9fYuJZ+uYmm=qytHv-9AggymX6AXuf-10suxXrH1QoJx44A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, Petr Mladek <pmladek@suse.com>, 
	ohn Ogness <john.ogness@linutronix.de>, Francesco Dolcini <francesco@dolcini.it>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:30, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

From the previous 6.7.11-rc1 and 6.8.2-rc1 report,
the armv7 and i386 boot failed on v6.8 and v6.7 [1]

Following two patches needed for the boot to pass.
90ad525c2d9a ("printk: Use prb_first_seq() as base for 32bit seq macros")
418ec1961c07 ("printk: Adjust mapping for 32bit seq macros")

Please apply the above two patches on v6.8 and v6.7.

[1]
https://lore.kernel.org/stable/CA+G9fYtBKCPVmRETNpo3OdQbky-XiY6RDQ+Pc2b4Yj1yLe_e0g@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

