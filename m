Return-Path: <stable+bounces-205052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034FCF7615
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876D7306DC1E
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAA30B506;
	Tue,  6 Jan 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L9hAKf9l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCF30ACE8
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689885; cv=none; b=uUzabgRX1mCzA3QAkClmGGfl16EKdIfDMbeUHYIoV3cDBASDwXJ1GU6qMterf91qhcNvwLpDZV33ixrKy/FEQccw3t78s+r5TfdTx1lpCDA6gUkWhDqyi2APN6ZGckLKx55FGzwtwqaYo4FpQxwO1U56z6tN56/JPlql4D3c6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689885; c=relaxed/simple;
	bh=G53t0O2Tt/dmLK4wV/1urjfV+TQ9DJgUnzf6yqxBeYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oB0a9wD66Tx10WGW4fjazJ97+Rov8WAZCAkrtQozjergp3YXkqLlG0mbNdGhGjBnczracFGXDCzCCSL03LvL3qeb5+caB9H4W0hUOF8Hg70k7bQplH347AN49ya1pM6XvHuEpk7mLuWJcAoRK/F2J+jpZn1LNSoLhefeQsKv130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L9hAKf9l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a2ea96930cso9052155ad.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 00:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767689883; x=1768294683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G53t0O2Tt/dmLK4wV/1urjfV+TQ9DJgUnzf6yqxBeYk=;
        b=L9hAKf9lnMLLnBiVcQzDR6OiSHKG2eQdEDe7YMRadP8g4blvb2VR282yuxhRkEE5Oc
         yQw/E/n/GNXsPyqUOWc9Af+282wFpRt4z4Vi0KOfS8Q3cuYEKvGAsBFb1T3qA2L/WEaJ
         uhJNaPuuMs33MeU3HXqMg2qBvKsKDzJDovRiIdmzS2lSpupT1Q5TqtTop1S26fa1t/Wi
         rw11ggGsFLcLlGpmdgkpR5jIqUrAaNR2z7V3VnBlcgo0NaD0OmfEhxK8/1Q1qWKmtwzp
         I4WfH8naqil2m71k3PseafIefSPw1iux0cTVIJmWPgcR3oYXoTbgaAOGACgDZ5fe8ws+
         XbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689883; x=1768294683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G53t0O2Tt/dmLK4wV/1urjfV+TQ9DJgUnzf6yqxBeYk=;
        b=jwWX/BH/yFa2Ez0yJMTjZXvwGxLmPjr4hcX458br/1sYC/XDX6JEn/mTcVGf8QYH+h
         8mU8GodMc65gZA5+N7TfXw155q1Z2Zk9DmtUt3UTJxvPoZ5mbqvKZEpu585AOrklOL4s
         ofrJWmIzTsvKSvycThgiOKiX3MvbADiMr3DFdE+M+i/1CUPFJk5vs1Wb+S3bgx2H93C1
         C030f2gsOy6CkLnnSFK8yKSGONgniQ2xYFeFIEPYVOo52iMyzl1KBeHwKfcpTPe3h1SN
         +UDAKqp2s+Gb+lqTV5qDtvnsKQjrAwxV8ih/E29lrzwJQJg7fVVRTutbWDpD2hIzY7RU
         ORvA==
X-Forwarded-Encrypted: i=1; AJvYcCVl3Wi4Lv8AX5968W/6bGWMT/vjCg9NilI5g8DPBm/RLtpPvM3L8+A0XX4dfkA847gjjInexJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxFFVs2G8JD/62mCEUBHP5Gm+eABOx+iS08yEFoGMHt4DvZHX
	lnHwBbglMoNrbSZITKzvD706/Hh30RCa2isQR2sKaqqhFJyoDe7Bmu9QCxVTLiYKsO76xc2uDbB
	TxKmtTrM2Z3J0TpUNNPtTTimfpVWlA8w=
X-Gm-Gg: AY/fxX4qhiBy7P6Ix1+OOPQrClgm7LJ2kSZnonymFjZUs1vS20+veE6O4sAunTjHyde
	/hkNNpFZ8+Lrs4msjNcUw4DqWEvsX4k1FWNhizf43SdnV9ZqbwrmSD17l/BM14zDuX3tz+5WjKt
	6HZbSoiv3w7/XWphHz7vsjv9uj+VSAXuQU/XzfrIVjM9wqK/vWrUYqvCpcc7voJ8Z/ZpqXHleO3
	jh8S9pTwVOYpqtGDJiFIRO2VZRsefZFdr/J7XWTVni7PymdNAArULD210MHWJ/oX0C/LSwdrFkB
	YQBQcviiC5YDSeUyj2FDCeQpDGs=
X-Google-Smtp-Source: AGHT+IFA6DKd4Yqb25+QMHYXfH+Jh2NRCrQLjGTa8ZM9+F0Xx1xd3Jy/OMlG71eaOtGzHsmwhgEtR9fyBW7b1Rm3bUk=
X-Received: by 2002:a17:903:1510:b0:2a0:ccb9:2f0a with SMTP id
 d9443c01a7336-2a3e2d787e6mr19166985ad.8.1767689883552; Tue, 06 Jan 2026
 00:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106085253.20858-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260106085253.20858-1-bartosz.golaszewski@oss.qualcomm.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 6 Jan 2026 09:57:52 +0100
X-Gm-Features: AQt7F2owLdGLdqQ3XnchKp1E79BKW3iLtGUJOY0QKVFPigG-8AogrAe0KMljxw8
Message-ID: <CAFBinCAZsHfYcRO4P84E6wes9rPw07Cf0h+4zS4KkbVB8vhkUQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: amlogic-a4: mark the GPIO controller as sleeping
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:53=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> The GPIO controller is configured as non-sleeping but it uses generic
> pinctrl helpers which use a mutex for synchronization. This will cause
> lockdep splats when used together with shared GPIOs going through the
> GPIO shared proxy driver.
>
> Fixes: 6e9be3abb78c ("pinctrl: Add driver support for Amlogic SoCs")
> Cc: stable@vger.kernel.org
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Closes: https://lore.kernel.org/all/CAFBinCAc7CO8gfNQakCu3LfkYXuyTd2iRpMR=
m8EKXSL0mwOnJw@mail.gmail.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

