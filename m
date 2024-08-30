Return-Path: <stable+bounces-71651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E296631D
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A6E1F210D6
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B871A2875;
	Fri, 30 Aug 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0U7zzY3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1EE26ACB
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025264; cv=none; b=UslEjc+DsIUN/K27f4Kd+wsY1QGD0OxkIeMQkh1JoKWcgRXjl5MoQ1nGgrS7iGsBs+BWWRxzVqi0/MgYSlIhu9c7MJ7m4cWVY9vwnZNsei8EeM2hZeepE4Dw3k2HTn9rdiIYo5ehkihcQb5FTvb+/2lmRJL7Wl7q+PSYxQxDDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025264; c=relaxed/simple;
	bh=ZrGqq5NfvEBmrRBELLAjlw3uy983U3Pun+m402wQfto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkBVSbUnL9WjKrLUrzfTN+uZTFhHjU3JbIzR9IAwZTqX1xKSLaSm17Yi3Z4lsix5VKCmlcnfsrcblB1JGyl2DYh6kZ5kZ58YQiKwOapeoGL+p1UKnUXd6OFlb0qjMVRGR+xBsTE9AnTr0IvcqHS4TXmGOiQ5+qeTvbmWyJwSGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0U7zzY3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334adf7249so2494205e87.3
        for <stable@vger.kernel.org>; Fri, 30 Aug 2024 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725025261; x=1725630061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg2RKP/1W4x57jftVobOdW3IcvUoM7v9SY5fZR0Qwto=;
        b=d0U7zzY3HOiglpzcRtTNapSysUjuckQh2xZ+OzkGJDACYSVY9xGk7V4Ddc5jvHuT/C
         zH4yMlx9plQ+P+h6TSvAOEWP2FAXo/LzBuoSDPlOJ5f57X1hC/bScRKSOgKAn/W/Vgjs
         Mrm0FunKnrP75MPzupOU5Pw2wBXzgivRPWEbuMnTUO37G0yCNMGc42ANtEXBjI9Pnrjw
         GO8TOIlLQpjS/7oYdVTkSnXDA3U6N3hf5QXyg46ScqkTLX31bgVxD7heVjHZ7mhGHisZ
         zpJSi1u0EfKGGCgvb/wzdD1NYT7+1i9Oqgm6zTIL36ZHtD3JWcuWLKhbiW9MXW7cu2Wg
         q1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025261; x=1725630061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg2RKP/1W4x57jftVobOdW3IcvUoM7v9SY5fZR0Qwto=;
        b=XxbKV/1C2i4349RpfMDQHIh3HdDzyAHYTMWZBPBf2e1JWGyraIBaist/sfW+Hc5I5B
         /K2/HUkWZ5vtngSIm5cP7HWqZxt+HXyXeNfeLUjiiW/7y4kgRGVc9yhKmC8TKWonErZA
         vbhVFWTrK4YAtYRHGhlecBSVOMNSoBvrP5bKtAt+7gz3nG/NDoDgEhkZs5sjhHPfpbxJ
         lFOuEVgkNi7hwWt/niPRD0Gsi3FpAtmq3gfEvAV1m11YXuSKxx2tUNJrFBpzFoFdv5Tz
         UcKDm4K18M44Tw58uRzJMtz2it0eq4tru/CeS9Q7SN7skZCjbHhkLww/MFJcOcZHpzbf
         LXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhxi8sL0DEBX0ywG+i7tEt045XUqmb0aPac/tWGfCTL4Sk4zE26KK9SeOaeL6zoyfZ3iUh/8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgueujF3KaWj/9tRCxW62aAGFfT0zOcSDp7m0n7NhI753Jdkm
	R//j0rE8+Nac7MrlQB0TYFx9zkBz0nMb1ICHvxsydAiZONbj+syA1EjI8qK4BLb9TIS4OwyfKgH
	dKeWIklg+Yz7FboY0PI743dK1rYCFEIdWBRpCbg==
X-Google-Smtp-Source: AGHT+IGdCAzoS2BJDw9RqgCg53rSN1MLjuzEtnLwEUapdSxGqCfZbZhxVGO0zoFyiX5x9z5GidRuT19nvaqE/jLG5lU=
X-Received: by 2002:a05:6512:398d:b0:52c:adc4:137c with SMTP id
 2adb3069b0e04-53546b25a52mr1356585e87.20.1725025260167; Fri, 30 Aug 2024
 06:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
In-Reply-To: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 15:40:49 +0200
Message-ID: <CACRpkdY65=biEaDuKxV168rYTh-ZN-Hi34UjvMorGLfidfuerQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] soc: versatile: fixes and compile test
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 8:05=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Three fixes for unbinding and error paths.  Enable also compile testing
> as cherry on top.

Nice, patches applied. I try to send a PR for them as soon
as possible as well.

Yours,
Linus Walleij

