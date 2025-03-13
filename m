Return-Path: <stable+bounces-124221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95CA5EE5B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD60516588F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BA262D03;
	Thu, 13 Mar 2025 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsNl1upG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD226037B
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855738; cv=none; b=XLiiYbb1NXVx6SKoIhumf8pwblX/o1mNuwMgoKHgQeBdMzWx72THg3plIrkvVacWI6Pl51lfZV6vfDSqqJallCeXJwUOxaXx852MGckKwtMhMM2hJbB5ZX/IqrEtpbJus0G8M+uYKhVvZWk/L5VIXZBgQ51WkTJrKA0ydDIPB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855738; c=relaxed/simple;
	bh=5JSx9yXVSMH1oIfWAZP5BAqaDyb/cZv1fzFwbXXkrDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxWaGnJjvH0AJqViuH7qutvuDyw8LFdQqdzrrXhtz5+72G/wCmVfmiLHiXgiUqX+fA7Xuw6+Br4zOChKRzGIeWvdVj8eUEJOWXzlWlTS7akPSAdJeJDLUAFldFoJbT6SSf2IyS8MQ2Ru9QL5JGrfYt5F9E0xmvnh9ynsqDrhRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsNl1upG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30795988ebeso7700111fa.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741855733; x=1742460533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JSx9yXVSMH1oIfWAZP5BAqaDyb/cZv1fzFwbXXkrDE=;
        b=NsNl1upGm2g3cB8QwYym3nRrJWTr9+POsRQX//o7PoQhJkG1Z1CzrI7mhIS8np2Eum
         hXWJq3Gy3ja4ltK0xSLNen2dpC+eavbkJZRZ4sSR+f99n+WtLRPfz7ElQnqifbGL9ktr
         cT2GS6leCSVcMFKv8w+yW1+Ast41b5tH3mD/tSHuC8+aHyVbhhn0qMpXEa2XPx8hKVev
         n6zlw45oMW/4gDGQP7OaRVysnbV9R4vr2M2w1u2rdb72htDmU/RoXqtXKbEgSlEu6Jop
         OekYzVZk98cSzzTirZ7I933ECuSISQXi6yPpLm55AwMtq9fuciP6OOoMoCUdUu8/tyRm
         upQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855733; x=1742460533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JSx9yXVSMH1oIfWAZP5BAqaDyb/cZv1fzFwbXXkrDE=;
        b=nbwf89/v2byNQBmSXyxzprWYjndNl5WfI/2ox98WRH1V1HsASIP2rU0ZOMbcT8kvlT
         S9sQ4SPOMW/KSeckVPwKw8mtT/mIWFd5N7Gf8iINkkf+1iEv+Dc/2cxLPWyVQytOwKOQ
         0OZ4s66GTm598iuER4/6yGaz4tN7HmE26MqI+/dCtb6Y5f7SOTYUSlRMk1japPxULbNf
         8xg87J5RqHAwRgFuHvU361S6MJeO7KhCbs3ZcQfai93HrHE+p3WNkoqQzNyvuN4SikEA
         xY6K7VNlbqoHVePp8bY+X1Ey/YsiAJrOCtDY7TJf/trIxs4QMH1iAFagBZII+T3y9/br
         8WOg==
X-Forwarded-Encrypted: i=1; AJvYcCV75b4GfRy9qrYgsPrcp8mSQQDfrstOKJ1LybktlMUOiyWx+Hb3nGITKB7/EH2scKctKhLgOkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQ7p/wfClGbd/JTzZMfWjEEFV3ItuhRUOQt82Lv+S/ikS0GyE
	sEApYYZ1BupWa7rxm8oWZpjIOVZAXro50ux9DeEx0IaxZ0umEK85NOr3moa8WWgUI5JW6eJAQ1H
	sDdqnLb4njPJmr7l39j458nYbdvPl6bIVx4PuExz0T9FfAcAQFx4=
X-Gm-Gg: ASbGncu745zXpIOjj5riwA/91VX2lA0Y+TpU7b9wvKc8zbo+s1iUZdisBZMHecd3Ijd
	hU2FNxUw1JmQfCdhY/8CSQxNybCO47KuA9dx5CuALAfb5f7BnHzCiHg8bpCyniULzBJmWuJGVoK
	QWkklzlniYDUS/iKiltLEorZfWhQ==
X-Google-Smtp-Source: AGHT+IGI8tFaOVTeJQCqFzI9EQ42o/9graFjduSws1PVhjUTSRn9EgLXRgQWygDrvrGqu/hZbh3Ks12WRVjlfFyAipk=
X-Received: by 2002:a05:6512:ba6:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-54990ec17dfmr7466352e87.53.1741855733121; Thu, 13 Mar 2025
 01:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
 <20250311-arm-fix-vectors-with-linker-dce-v1-1-ec4c382e3bfd@kernel.org>
In-Reply-To: <20250311-arm-fix-vectors-with-linker-dce-v1-1-ec4c382e3bfd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Mar 2025 09:48:42 +0100
X-Gm-Features: AQ5f1JqmIPVBXkWKiQ4L7FkcGH2_zJJXfhNRe652n92bAmXjxmmkzkQ8l-fLCmw
Message-ID: <CACRpkdY-yxaiG89Co+C2=vyd0i6sh9pP0UGWZh1yUg4jd9jmuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Require linker to support KEEP within OVERLAY
 for DCE
To: Nathan Chancellor <nathan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Christian Eggers <ceggers@arri.de>, 
	Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:43=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:

> ld.lld prior to 21.0.0 does not support using the KEEP keyword within an
> overlay description, which may be needed to avoid discarding necessary
> sections within an overlay with '--gc-sections', which can be enabled
> for the kernel via CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
>
> Disallow CONFIG_LD_DEAD_CODE_DATA_ELIMINATION without support for KEEP
> within OVERLAY and introduce a macro, OVERLAY_KEEP, that can be used to
> conditionally add KEEP when it is properly supported to avoid breaking
> old versions of ld.lld.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/llvm/llvm-project/commit/381599f1fe973afad3094e5=
5ec99b1620dba7d8c
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Very clear and easy to follow.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

