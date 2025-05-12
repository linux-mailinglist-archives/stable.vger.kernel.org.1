Return-Path: <stable+bounces-144023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E6AB4556
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA101B402ED
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49D298CD4;
	Mon, 12 May 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K320a7yY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647A23F417;
	Mon, 12 May 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080416; cv=none; b=bbYgOlWr7Q0xx9MCuaLZiOd+rXQRD6VbBW/rmWaBsWC6zzwfC53t62d7bsveQWtKVqY4nOFgiR/vmLDK3E10HC0BmR+nlvHijiB1rUXUF+nnWPnZQqyJna/TGdVn8bz+/eUX8ahaM/AXzoM6By255dEcxDUMTCzsqFlpYl+j0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080416; c=relaxed/simple;
	bh=WSiW7p0aNjUIq3le4mLwbELe1ERLMvn/occVL3eCR/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iM7aue0JJvThxvVJmmr9Hg0sMoIr5a5eX5sw7JxeKIZeyMZleceFwtPHqeCP1HO6WL5MVG3w7vTMP5PT5KcthPKKp8IIbhfR0Ou0D5QUKa6gQfoBqJCLs2yJh/SNBIsuWWXo3XCU8TAhrrUw+N7dTlMBbkOoSsd9N3UNh6QHEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=K320a7yY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22fa47d6578so49288355ad.2;
        Mon, 12 May 2025 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747080414; x=1747685214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSiW7p0aNjUIq3le4mLwbELe1ERLMvn/occVL3eCR/Q=;
        b=K320a7yYxNkY7iKbWXs4AtcybnAFzNwD5gsWhjw4sEmYT97aI6gnIrvoSTWxlT03Cf
         X8wK4gNwyyq94Z/PyNesLafKqvVHko+cLYRQolEOqoPsMYw+p15bdFaSdUOlR7zcboN9
         cFTsdeN9zgLOLykqmeYCuhmRSrIm81EZTF17oWMO6HSQFE6XktcYL8lSu/HM0gql+7a9
         q9oTf6umhcrhAMBOY7m0N1VyyZ9jvE3jddDfnzQFNWgpVB85HQDE9SBWefzlITkJ1iyf
         yzr7MIdourmlRm/7BcU5zVLD86vpDPdugCOsJ5BVn2X9dR61glYZceQEClbE8e9z4Ak0
         IAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747080414; x=1747685214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSiW7p0aNjUIq3le4mLwbELe1ERLMvn/occVL3eCR/Q=;
        b=WPfFQhzJ8fgU+eu0eJhgL4SYVu/Z8kqBoOTnbFjEvlDfL7s+N/Jcy3VXnrh2dD3wsN
         QCF8oJwsYEMB6vyhqae5jP8tnFFvhrsXw/ewaagsFWXvK4jaOr3MkgUaaH7bb+Su75Jl
         Zqy7ajN2Wl048Jmlc3/Gxc6i2jM4kpEifAaM1lNydS5n1hctUlskPsHqMj9mMMv/UJwv
         sWARhn97CEq0hPkGPQRMd9PTbH4Kqm8uhVTDIVIcPrBBQginWRfuh5QO+JuSiwaT2Gfc
         WRCxTIrz0bo83B74qLyl0o4GQRpPsIU8nWZy8XALCZ/f6mpGGfQwgKsPJRiBjz/iUigr
         IokA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDr4a+cHPSqBoZA+fZbDirbiotn/tNlRkolFbMuRJDrwaRYyX6rOlcLsjg1gE5pj3/E4tejo1@vger.kernel.org, AJvYcCWqXZkiUgHkZqZVHY7qZ3HXcEdVzgkQ0+eiE0Iu9ZEElUYs9mVU4EkxCtebeFT8yCJuEWEJrJqT//waMIgF@vger.kernel.org, AJvYcCXA/2aRF2+3q4Lqx26lFZCyCkqAA+mAOl8yhpCCia3J2tqYAu3NUKW1pRIF0mMfZeQViL0qxGQzo1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqG5mtIgF02yHTHkUEFzndA1QXbUjy0rlEJlKGefTBQEsvvEAp
	uuGpfogCUY2WeDm3T4oNQ1ILs0RaVIrBEzAMCa1dou+MNWtPLVPe3lf3BVcQdID/D3Oz/4PAeH+
	ERVGzgPNpCyHXBf2i5kTHNFyLW5Y=
X-Gm-Gg: ASbGnct3wxdim2quA+/+/Qz2xXlWoq4pHHhWWhxQBYSkq9Sgsd2VPuxa8klSW6oxAlG
	JqyTjljNVqG1we9YP494MNf2ghM9t/ASSDt/kCU7QlqrTZXIzeGDyMGmoxqZIsagNYc32+Vaaxy
	IZ43uVfc+O7GbFlH8n+6+986xfRzs/Yoz+HpXY3L+fj0oXtkw=
X-Google-Smtp-Source: AGHT+IFBqbnUdLiitufbLXxaAIrV+TzMyJv1ak+Y8tA2k06O+SGSu05Ga70FrDqE5JlHGr/Uin8JRB6H8itaAnItfvE=
X-Received: by 2002:a17:902:ecc2:b0:223:4537:65b1 with SMTP id
 d9443c01a7336-22fc9185f13mr189423785ad.36.1747080413803; Mon, 12 May 2025
 13:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512142617.2175291-1-da@libre.computer>
In-Reply-To: <20250512142617.2175291-1-da@libre.computer>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 12 May 2025 22:06:42 +0200
X-Gm-Features: AX0GCFvfd5bSiWturfPtggiMZTkGOscolWitajhj7zf65L0D-tJWKFL1VX0LLFs
Message-ID: <CAFBinCDJguJPfA+xpCqaeUTdTHqYHNNoZQXUdw6yy6o6UVvN3g@mail.gmail.com>
Subject: Re: [PATCH v3] clk: meson-g12a: add missing fclk_div2 to spicc
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, stable@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 4:26=E2=80=AFPM Da Xue <da@libre.computer> wrote:
>
> SPICC is missing fclk_div2 which causes the spicc module to output sclk a=
t
> 2.5x the expected rate. Adding the missing fclk_div2 resolves this.
>
> Fixes: a18c8e0b7697 ("clk: meson: g12a: add support for the SPICC SCLK So=
urce clocks")
> Cc: <stable@vger.kernel.org> # 6.1
> Signed-off-by: Da Xue <da@libre.computer>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

