Return-Path: <stable+bounces-158691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78331AE9E4F
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3981C42954
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034572E5404;
	Thu, 26 Jun 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQualrS3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA42E540A;
	Thu, 26 Jun 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943519; cv=none; b=KwmBqWr+k5dPaMcW1IDSW4DB6IXl+jd517vdrArh/5Ms9GKyD8azmiEshqp1jwLslTqzUnEHwTXdNfh/8cbjggkmlpQnLw0THbrwNCiI0UyZ5T5DlLYPGPSkuqchq9nhziNKNtCRM4qSiV6vi7NwdkR8RWLyECoE3KzDTVl5rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943519; c=relaxed/simple;
	bh=MCwjJ5Vu59NECXROlgdeWoW1Ipr9KsqQJuNVbzIMvIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgZ0U9QnZHSdGVXPbTLCmjpDGJr+sqa54SxSEt3NrJMy3DYw+AdMU+CiZzaLAxg70lg9nv1c8XoxpBZ2gp0mJPr8iL/7Ds0VxkN/w0kzUpje2dN/YSBQtOhgbXUWoQJRHbWdUG82dHdM6+4kA+OF/1yGPIAaTv+5tOTEC7ulG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQualrS3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso9745531fa.0;
        Thu, 26 Jun 2025 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750943516; x=1751548316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCwjJ5Vu59NECXROlgdeWoW1Ipr9KsqQJuNVbzIMvIM=;
        b=TQualrS3qvY++KTBjskxuel7+QeJ0UpjD7iB2IBb6GzN8I6W0Y3UFE5KktmKhrwH2R
         WzhgF0mMdd7CrsUoTd2bGI/oZZDmLAyFCwkdtkODijZscsTJKsMGhqPWduBV2jgL4w77
         5KflZ45vXvfcken8KErklUDslwO+ofnBnn6Nn7ONyzyzxBF6vdPTfhfWf9m3tcxE4IRx
         bqx1aifFBpjbwQlhqCTX9K2npR7TaFPBPTtX+UHn2TtpGilt5vpyMZM6n3r70M4F8C8R
         O0CypM5I6kgmaQ0febanotGD31zE8pQtlzgRO4EkT2SF3NoWa7vqI72cAJjiQFDC/zoA
         fuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943516; x=1751548316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCwjJ5Vu59NECXROlgdeWoW1Ipr9KsqQJuNVbzIMvIM=;
        b=uD0UOsx1PCHNTB7S9OzzyWdeMpFhcyCbL9vTHZpUeZv/YjQ4vbasQVx6MJOS4wwtVQ
         2ZXZ6MEhrLxOvV6HLoOyB9h05e6HPd4GgDJ4Pnmy01Zw7A7C9DBKyhFA7PSklf0sfYdh
         dz8HqIaw6VMWfpTmtZyIJ43NYsvK7MPEBB2vAgNiAfKnCZhhCPIMbgmH64PKU+EYcjMV
         D5nkBoyXD1JMuxvmlt86a81/rScLPRiu4dfnhR7q9qlDXj4+FUJvQH5W+Gwtv45KGEHU
         h1vA8dXR88nrrGEgEdZ885mmMuDkFg9d8bjGsVWjSZyn0gSywfmiot8MVW0CaIikpxd4
         eetw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQSwEfdsti41+HT60BFkHlXDu/Zm6fpFgHcGdxogknRw/sU6J8od8SMzsHeoXP7M4koapPm8O5f0kqm0=@vger.kernel.org, AJvYcCXb07Jlh40Kk1vnfYi4FqdV2Crp2bPHOMJcHg1ojQEQCdE7k5G4txamwQyT3Q2ab5HuPo1rOR1ROx25jpE=@vger.kernel.org, AJvYcCXvCwpwYQe6THL/LO9PJ1dUJEU4mgL0EdI0TVkJGQSbeVVF+XC6r6k5ojyj3sY+p5Ka2V+hEOR2@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkKH0FCLhRT1qfN7vdndbySqD2N2rcnjdibgf3bzRHrL/tw0W
	xbrSb3gXHGBFZrFLi9xhYSh/H5l5w9cUmdcNe3qdcyQfkFuQ5BCK1GUyNAVjy/B0SvQzSRvW2mS
	LB2AYSqrw9lFmymg0Onw4zMs11NMK78w=
X-Gm-Gg: ASbGncu/z7ilcWcJ/Ry/wvl96swnnRCgAs7c+xTPtDBqgHMt2Dw0SmdQwUN4XDriaVd
	6Y9B1fGz6bJUfaMjU/jm6IuWfTAOK+i+iFSewSpZSWjY7qnfwM6H4aVWDUod6LIiV5KbwdmfCts
	OG2ZCNhnvSjRqK1N/Gs3qFgZ2tHsR3SywYc3ttPzjwPwVaSaQgaFi3XGX3qf7yHb2HJSakHB8zE
	xE=
X-Google-Smtp-Source: AGHT+IE2jBjORY52vwz1SaqfWBqWQRMlfyjcOqrk1aRtY75tKwDcBNf2YDuSUs0Sjh99nX7hNamlLbwguMTnnVZ18o0=
X-Received: by 2002:a05:6512:1189:b0:553:a273:66c5 with SMTP id
 2adb3069b0e04-554fdf82584mr2354324e87.52.1750943515819; Thu, 26 Jun 2025
 06:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626130858.163825-1-arun@arunraghavan.net>
In-Reply-To: <20250626130858.163825-1-arun@arunraghavan.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Jun 2025 10:11:44 -0300
X-Gm-Features: Ac12FXw268pHp7EgiOTaBin1GwQomhw-dNFiDTxHVgc1k3q0De6jl0tgozoDaQ0
Message-ID: <CAOMZO5Dk2aiW3MQViXHRzweJXgjK20BkycT_A+dm8koxNH+MxQ@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: fsl_sai: Force a software reset when starting in
 consumer mode
To: Arun Raghavan <arun@arunraghavan.net>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pieterjan Camerlynck <p.camerlynck@televic.com>, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Arun Raghavan <arun@asymptotic.io>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:09=E2=80=AFAM Arun Raghavan <arun@arunraghavan.n=
et> wrote:
>
> From: Arun Raghavan <arun@asymptotic.io>
>
> On an imx8mm platform with an external clock provider, when running the
> receiver (arecord) and triggering an xrun with xrun_injection, we see a
> channel swap/offset. This happens sometimes when running only the
> receiver, but occurs reliably if a transmitter (aplay) is also
> concurrently running.
>
> It seems that the SAI loses track of frame sync during the trigger stop
> -> trigger start cycle that occurs during an xrun. Doing just a FIFO
> reset in this case does not suffice, and only a software reset seems to
> get it back on track.
>
> This looks like the same h/w bug that is already handled for the
> producer case, so we now do the reset unconditionally on config disable.
>
> Signed-off-by: Arun Raghavan <arun@asymptotic.io>
> Reported-by: Pieterjan Camerlynck <p.camerlynck@televic.com>
> Fixes: 3e3f8bd56955 ("ASoC: fsl_sai: fix no frame clk in master mode")
> Cc: stable@vger.kernel.org

Reviewed-by: Fabio Estevam <festevam@gmail.com>

