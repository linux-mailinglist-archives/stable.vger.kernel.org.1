Return-Path: <stable+bounces-210448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C862DD3C043
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EACD40557C
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D660381710;
	Tue, 20 Jan 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ30QReI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D13803F4
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893297; cv=pass; b=s8cu5Dsfv5R5ov0jjnGCjqG5q9lga1OXJDfXRc9TGbkmodU2oOR7c6xgV/Ajyib4Jy4a5CDyndTFNe9zz/SzZdDuVOgM4gANacprv/T9Xo9YbRXNCnqYHKEkaHc6m2Rw3YDidQtyNrBTTFXHpL7gIKnR9yZN4aFGhUOfc3jQ9lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893297; c=relaxed/simple;
	bh=2apavE+c+60xBpwAPAfHfp3nJczltL44E4xnBaDErHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7/esdGU+6h+iTL32zq8Jhjq+uBo4prL4oeLNIymmPpDZK2cbtBOVRkvAxAFrAFgJKG1+o54ldMJw6ghxZcwvmQylaIWZM5lAQGGXX7gBDKYroGz4c/4FC76+JXjU/mnjyFORuFYBtDOPtyw2Kmy+5MV7Y6TNDCorrKVQmik4zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ30QReI; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so3695402a91.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 23:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768893287; cv=none;
        d=google.com; s=arc-20240605;
        b=LO6i7o81bubsapXUvKXXbh+qnDTJY2vXy0VCE5gtaQRZ9cHVRAORpYfIFDJb8AlLeA
         glOzaq+zN3/CAvpZGub1FNH8hEKJDuD9aaz4uv0FSkusxVzmGPBr28nH82m0o2aEOjKM
         QNuXsNch+c3FsvXrdfph9+4NsLTmhH2GjxgWHFNGmvN+JBWBHMsIUj4zF893L6YR0UpM
         sqspDaEvqbci0HFLvRaIVtVTXkxChFjZ4jF9A4A3s5HjW2drCvFApGvgVc/3FpnppPs5
         es6sScPfY/VdYSZSeSv7vLuTcZdzHlsrlqmlc/uhcgdICzraqzyOsisnRASTbC7wWbO+
         0Q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGLQil2RG9d2Wuf3AJIGoH64VyiurRe3JNq+iqICMGc=;
        fh=GpF4hdyUn/mVledepd/xbDtuRRXOldvB37lvTHpiUi8=;
        b=R6SFtnXKaHRoulwmEPtIRfA3tDKFvRlFaPqbeRFkMlUvdjlksWFpKgXCptQkB1R7ME
         tDgeI0EVXaYnANZjckLSPYRFM/FLYyQ8ol+NvlzuhH801Pml68qP7phOepHaVDx5Ajh0
         F6ENZTmLJ8e2PdbPLpMucDxPf76Nuq2RaDSgdAT1MlF0GAKkDldSUCJRWhFmL9mUWEVj
         MKg5sWae8YgqU/uFFCGYbw2tc//2K0zgJJuTgas7stDLORd/obe+Jo3DgTygWWSJ+Brz
         CiJcEe5APQy7x0EUq78G6MjjgOp+2qF30nPIfWsvXZmEVVAZwasxlK6aVL1AMJZBqfQW
         0h2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768893287; x=1769498087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGLQil2RG9d2Wuf3AJIGoH64VyiurRe3JNq+iqICMGc=;
        b=CZ30QReIxGPh1vn06dR9YnceGBbGHK4QwHyPbs5mgcvyNUXfi0Zdds6vJ16SC0ct33
         p85bho8nxBpi+9q6OymOVPn4ItfSTDbOrvBJpISLxBFxE6HYrAtul+Bo00l8lG+BF6Bl
         KvG8wL4hmxK8CCTERIU1kvC+zyHqppAj1eUpGbkjpQ+zOAlwSvcsKkiaaoVZeezgHNiS
         jdz9zhGG2w2jtgM/8yKlmwI22hxHsSC1cAyh8Yr66JBdEcK52jTV413ajJLP/v24sqUG
         b2DhGBOKTg7x1CjsrBRU7xxh4UnHA29oFMbVjK8GhMe/8tgQVMHTM1p11PcePn1y8Lgq
         ayHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768893287; x=1769498087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGLQil2RG9d2Wuf3AJIGoH64VyiurRe3JNq+iqICMGc=;
        b=IhmM4fm3wzDzsmvr9Fo/t/WK3c5Y6zwshMBwuNvdL0eSTKxfdE8eFx5gwqKFHMzsNn
         W90VTnN4LkNA/WhO54EHPx2hMI1nfUg/Z6u2zyCHCsH+YGIULtLDZVGBBGmH9CLJlvZV
         jVQTXPD+yxtnwohyQg0mL1rrXglzYTtA+EIJH/wsbPHMCX5vtamFe9ikIZvTDSY/qtrP
         vbErJhpRmjMb+meQvF65ZHqt6CqMnwAwHbS+zVyWWuyz/+8tl/mvqJIm0awfW/fgk0lH
         54nPFArwhgKjpIZkOgo6kbxXY3E5sTRzJMRQMmav8h9nMvXNUBcKLEFQwzW4g1vxRcKH
         +4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPP/vyfQk1nH2aFeTM2G08n6hNt7EIp6NGl0LvOellK1k57j9xg3fjozC3OGTCdKH6ZBUiLCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd7Q8siIzSsJ5Ty3cttwrAGorcP5VeMwJtH/TDZ9tp1kv03Kj
	6641V+17LFmIC+7qKVwsPPY6SeMwlViDByBPlll7xZJx0Gg8SKYb7+pTSJ3CWtX6W1NU8NtJHvc
	aTS8FYBHiZp3WklEIdLyyjfHJX2YW5Ro=
X-Gm-Gg: AZuq6aJY4NIord4F0tTjGyjnIPnxnCuid8KEvCAAKdcrwK55whzGov2F+ned/3+IUrc
	9QXM0SbxUAkD/0Dp+ITAhjoANMbj+ezhJ4NK6y0BkSYQJ7v00XVyZKfGjOwsyEdRSTmuouiew5i
	Bt4NWjxzRhj52UdqM7KQJ5VQmEDRsckWOMqXOjBncwL89lMOWB7C8NTK7WMcj9ZxBBZeh33T4/T
	wAd6DVpzraadfhC/HUwW8KHxZrPESq8iaapAAJ+6mhBtbgxCD3+okTR50JANMAFMoJ5g7g=
X-Received: by 2002:a17:90b:1c84:b0:343:f509:aa4a with SMTP id
 98e67ed59e1d1-3527329c737mr11291662a91.36.1768893287413; Mon, 19 Jan 2026
 23:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118205030.1532696-1-festevam@gmail.com>
In-Reply-To: <20260118205030.1532696-1-festevam@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 20 Jan 2026 15:14:35 +0800
X-Gm-Features: AZwV_QhANuYAMbdvOcsvLwzcsqnrExKdw3Lq6AQB2yvSz6Q2_jO2O5XyvjGg3fE
Message-ID: <CAA+D8APZ6Un4ViiO0PMDdUhnef6ny7BtJ+DUVL0d3qUkNVrMjw@mail.gmail.com>
Subject: Re: [PATCH RESEND] ASoC: fsl: imx-card: Do not force slot width to
 sample width
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-sound@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:50=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> imx-card currently sets the slot width to the physical sample width
> for I2S links. This breaks controllers that use fixed-width slots
> (e.g. 32-bit FIFO words), causing the unused bits in the slot to
> contain undefined data when playing 16-bit streams.
>
> Do not override the slot width in the machine driver and let the CPU
> DAI select an appropriate default instead. This matches the behavior
> of simple-audio-card and avoids embedding controller-specific policy
> in the machine driver.
>
> On an i.MX8MP-based board using SAI as the I2S master with 32-bit slots,
> playing 16-bit audio resulted in spurious frequencies and an incorrect
> SAI data waveform, as the slot width was forced to 16 bits. After this
> change, audio artifacts are eliminated and the 16-bit samples correctly
> occupy the first half of the 32-bit slot, with the remaining bits padded
> with zeroes.
>
> Cc: stable@vger.kernel.org
> Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/imx-card.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
> index 28699d7b75ca..05b4e971a366 100644
> --- a/sound/soc/fsl/imx-card.c
> +++ b/sound/soc/fsl/imx-card.c
> @@ -346,7 +346,6 @@ static int imx_aif_hw_params(struct snd_pcm_substream=
 *substream,
>                               SND_SOC_DAIFMT_PDM;
>                 } else {
>                         slots =3D 2;
> -                       slot_width =3D params_physical_width(params);
>                         fmt =3D (rtd->dai_link->dai_fmt & ~SND_SOC_DAIFMT=
_FORMAT_MASK) |
>                               SND_SOC_DAIFMT_I2S;
>                 }
> --
> 2.34.1
>

