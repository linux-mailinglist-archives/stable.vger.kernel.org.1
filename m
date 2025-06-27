Return-Path: <stable+bounces-158792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBCAEBBFE
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE83BD5F4
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013A02EA48D;
	Fri, 27 Jun 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QUOr2Trv"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC62E92CF
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038466; cv=none; b=W15Wo4qEU+PYRVeURNa/I+1mpBH7kGyHxDzi7fsRMz8hICEFDH1RLvHykB3kcFyA+T6E4mysO6oMmWPBpZIUjrqwIXDXj7R/UmATQ5NaVzFmR8dpjSsJGRJ88+z2t40EFBaw/vQJClNEew4+y+J9ar9BltexxLzN9JppxQpxoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038466; c=relaxed/simple;
	bh=GnZwq82c4iN3CQWZkWuYEREf/dvjkl9NxEukoUkaifY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu26hfhzd2qmYhqS3EdlCB4zXVjs0cYOPCPwJe2z0ss8yAIbgj8o1Ww+WtjoJWLjL9+4wFw2ZeAD9GriQQ599aX+j2WUrb/YiP9N4PBJc/t1PsMDXP/ggfWPq2A9dPLbcqlgEB0PIFZpuXzHeF2kxS1vr2ym2W/Dk8TGRbUpvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QUOr2Trv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5535652f42cso2663581e87.2
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751038462; x=1751643262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGlr1hf4Y/2lW5YY5YfSBn2FF3StM0v/6461VWOkMkA=;
        b=QUOr2TrvKFFg4VcNUPci6g5vF+g3xOTZj2hv4LLaBkRw4xQKA3mFU5wTA/+obUa/Il
         cpCWuaUbuLUlPAGYZOUmotZWpnQeHeAQUVg1v5HKeHqICF5JXcykwHBF5iQ0EAUYYp1p
         gLc5ZplqDewq+sZb3feblWtAHycaxYmRHzSncq9icCv/hrrxi2IhPHMgnTyyebA8ApXJ
         Ob90RGzIgNdLpf9bWH3QiLUB008/fLNDYzgl6+jyg0w/COUsb1p1FiPHZSBt5HKuyijp
         ughHjo5YehtGNBYq6VZXbRC1T8T7WlxdACOxW9JhToG3wAXVm3gklskPNyCwTE5b37VP
         9bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038462; x=1751643262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGlr1hf4Y/2lW5YY5YfSBn2FF3StM0v/6461VWOkMkA=;
        b=h3krOKmincQhRanOuxZ0mfTNoiyi59XUzlj9cItFdQnLJKtZqePNKsqnNCypGcrTx/
         RuXOl4TeOdPazFuqzkoysEMENn+6tsKuNofibfTWH0z3hd75B/SmIr8ZK4mLkBVlR/QS
         iZgRSn5Oa3zX7XnHLXBjtzBccT5Kbl0ORcrTiiv2c19w67QiPxYKL98sEMOGGliT/vUV
         C5AEDFoYS+CO1ErvI42Zi9K0eBb7V9kI7E0NreiD5V5pkiWzc7qVJzFgMMlhn0dO3Eqd
         I/ra/woIxW7DtcSh+6GKT12tmvVRu5xGudqjGndubczoGpciRupeQh6jNSTttdJZrQzX
         NF9w==
X-Gm-Message-State: AOJu0YxuhuguJ9acXjd0oEqI2cOmkobSoMaa3DpHuXALKmIW0/cO559W
	BRDr/cVnil67kosE2Z+xmQe/5qdBEwTqBfmJTfYapCheHpvBBcrjfl7zkblgFSjAMDupopQIFWp
	1jpG8yWZmftYUAyDYspyvBRhmrXoPRL5V5ASm0pUZdSEBnNrwgWWy+FQ=
X-Gm-Gg: ASbGncu0AEPod4I6/G+MbHigvDHkmEbIQPrfHlm8voaRCa5tNQ7yMW3h4ysimGDk8uF
	yBjdeEUEcXTwsSdlI8m7jOvXCYnsDzdLrD/eWjAxGrGUAgDzrBubk3JpC+zjNXEaVxSbcqmn4qf
	0YinQVpGZ6bHEepwn0nohmWVe10+JxmQmw75HtKIdTTI8GL75rLsmG+88QtlkRZJ6+erK4ElM5M
	Ow=
X-Google-Smtp-Source: AGHT+IGIriuR8N1nqR9PK64NptQfCBJdbtZlh6p4QcJP8nqxfPJ31TnSPvDtDgZ8bxLTmkwdTANfsXHjPcnhMHzkT54=
X-Received: by 2002:a05:6512:3d02:b0:553:a64a:18b0 with SMTP id
 2adb3069b0e04-5550b89b376mr1399564e87.42.1751038461891; Fri, 27 Jun 2025
 08:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627140453.808884-1-sashal@kernel.org>
In-Reply-To: <20250627140453.808884-1-sashal@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 27 Jun 2025 17:34:10 +0200
X-Gm-Features: Ac12FXxmgKu8xhH2PmdypYSX97xcjXIn8JLNIppj1jlCN5m4t8W7B4QI3EoY3C0
Message-ID: <CAMRc=McpWPQx2f-7zR9AovKiA1B5BF5QiXHrPXVpT+Xu1uH7cQ@mail.gmail.com>
Subject: Re: Patch "ASoC: codec: wcd9335: Convert to GPIO descriptors" has
 been added to the 6.15-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, peng.fan@nxp.com, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     ASoC: codec: wcd9335: Convert to GPIO descriptors
>
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      asoc-codec-wcd9335-convert-to-gpio-descriptors.patch
> and it can be found in the queue-6.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>

Why is this being backported to stable? It's not a fix, just
refactoring and updating to a more modern API.

Bart

