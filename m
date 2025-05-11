Return-Path: <stable+bounces-143099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA332AB2A07
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDF7172132
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835E25D534;
	Sun, 11 May 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="L3qIKz4V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF7219E8
	for <stable@vger.kernel.org>; Sun, 11 May 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985116; cv=none; b=vA9D/JdkV9REQIdNyvNoLwflN5idSkU5m1UnNpXVCOlhIztP2Tr7OYImlMQ0uIXWYzkSEgwYtcceGV2hwqtnSz3xRAJ06uv2KLi9jECOApS7IcL24HPNfes8QPYRk86AI5L16RVRZXnNy21hB5ubJ4AcB0hnMoBRMMfO/ZKAY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985116; c=relaxed/simple;
	bh=eBBZG/T8tWp3lz/GI9IwiMI7jMFA+cT2hqHx+2FpoNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNncsV33ij/Aek7+V5fjx6Ck8n3Ry7SPaSxVF75sRnGqvt4bZ65ft/Xw0zPLgGING+2EvHvqVBoD4a+oxtTIUG1Gn4hMpjR4x1xJQWq9H2DJvLlCyZ7KXyc7pTYweW23emE90Qshh4xCodu+/Zzlolrq66lhctduYOcSUKyfdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=L3qIKz4V; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b1ffeda9363so3608595a12.1
        for <stable@vger.kernel.org>; Sun, 11 May 2025 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1746985113; x=1747589913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htpdGgGE0WJqHpqKCEDMnW5Vc8YelVzDOmwa66AXTRc=;
        b=L3qIKz4Vo0pKj8AjefDb3UDmmoQFDUkbGSPC98p2fgrAwaz162TyheWO/UnuETzf4M
         q/D3+uyzImAvT/rqyijHH8B/OxaCE0kuRhPfny/YISLvKj2a64ZU6KbKtAjRG7Jw3BNT
         PjdLXl36zv3QU5PLioDu/fnLA3bq91/7tysDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746985113; x=1747589913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htpdGgGE0WJqHpqKCEDMnW5Vc8YelVzDOmwa66AXTRc=;
        b=anHka1EZBEt7OkEtgotGb4quR6EPjqPMV+AvsqZDUYwE8P4B20i+nXtPWpwy/thr8D
         VJEPK+or3XkFMd3TSfMiDNTCQjCgwWPPbc7Bz8yzE/ZV8k/HOaFLh0czdR3MCH8XJmte
         YgpqHknMDN03uFVoyqdMMhLghwlgSnTZlOnRFP4xV1ZN4HWFWvWK8XHF5v6K7YK+K+lV
         2VLSu9bzviOissGRwl2uyPzJudkbtcv6bFXC1dsI67TU4MnuScd3mmgTRomHLrN2+g+Y
         vjQHM2dXokob9K8xF1kXLeGDa78tZLvrLkZL1Ht1apHKbcv6kE58BTv/gEnrTXzoTJ9k
         igiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4jffMK08hyyj9aAly5OfUpsHGdicsHK8IjZWgmll3p55yQooUVJ473CizWBbQm6Z6RXbTwhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMpbbqSTA6DTrKC4wv+1VibwIQRpx2/vzmUdvO/d/n8+Vgo65
	rgOVXqMFpRUjdgkbPITdFzsEJVxg9P9fleu9r2Un8nysL+v4gun+WD9DaPw7a6tM8JKAyJVEZdV
	pXG7GpImvftLFERRWIGxVaqxoccY42wMMtL+mfA==
X-Gm-Gg: ASbGncv9XUsMptxA4VDxBgiPJYeoDRrPLirLUcp1SI0CEtZM6nJ6SEis1QR6nh4RZGH
	S7MSAnQMjEIfDWqj77XGpgfKvJ2vx7IBPi8tUGMnDhS6cg6Vu+OojbpMt7CGV0tuPLCpDtwSXY/
	1MjAs00NeVRMFxrcZqnUTdFIQ0KepiUF7+GPbYhLTdn38ypImlCbYuCc3mCDe1lyC7yMPs4TGfi
	RRO
X-Google-Smtp-Source: AGHT+IGlWFjDOSR6LptznPfsrBGcmLqTeFU1+S1/2WDCbsxyxoLwah/czQtlkvxYzoeR/HfJw2W1NJ3/is38sxpCk0Y=
X-Received: by 2002:a17:902:e94d:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-22fc91c2cdcmr176733505ad.48.1746985113315; Sun, 11 May 2025
 10:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511172732.1467671-1-da@libre.computer>
In-Reply-To: <20250511172732.1467671-1-da@libre.computer>
From: Da Xue <da@lessconfused.com>
Date: Sun, 11 May 2025 13:38:22 -0400
X-Gm-Features: AX0GCFtg3EgdoWRuH-CkzemoXtkQsOI76TednUqqH8u_ZIuzhBzf52QSqYFsAO0
Message-ID: <CACdvmAiqQj4NjazMvdwQtB5zX+SQs7bwXEchT5thNM83=bQBhA@mail.gmail.com>
Subject: Re: [PATCH] clk: meson-g12a: fix missing spicc clks to clk_sel
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, stable@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, this is an older version of the patch without Fixes tag from a
mv error. I'm sending a v2, ignore this one.

On Sun, May 11, 2025 at 1:28=E2=80=AFPM Da Xue <da@libre.computer> wrote:
>
> HHI_SPICC_CLK_CNTL bits 25:23 controls spicc clk_sel.
>
> It is missing fclk_div 2 and gp0_pll which causes the spicc module to
> output the incorrect clocks for spicc sclk at 2.5x the expected rate.
>
> Add the missing clocks resolves this.
>
> Cc: <stable@vger.kernel.org> # 6.1.x: a18c8e0: clk: meson: g12a: add
> Signed-off-by: Da Xue <da@libre.computer>
> ---
>  drivers/clk/meson/g12a.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 4f92b83965d5a..892862bf39996 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -4099,8 +4099,10 @@ static const struct clk_parent_data spicc_sclk_par=
ent_data[] =3D {
>         { .hw =3D &g12a_clk81.hw },
>         { .hw =3D &g12a_fclk_div4.hw },
>         { .hw =3D &g12a_fclk_div3.hw },
> +       { .hw =3D &g12a_fclk_div2.hw },
>         { .hw =3D &g12a_fclk_div5.hw },
>         { .hw =3D &g12a_fclk_div7.hw },
> +       { .hw =3D &g12a_gp0_pll.hw, },
>  };
>
>  static struct clk_regmap g12a_spicc0_sclk_sel =3D {
> --
> 2.39.5
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

