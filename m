Return-Path: <stable+bounces-88144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB39B0111
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E580F1F22AF8
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8D1F9EA1;
	Fri, 25 Oct 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEG60jEl"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5D1D54FE
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855223; cv=none; b=LKTLrh0GOQeE7lRr2+OngOBes4zdeYJYOlT8FeD47u8pDBS+Owf5NnE/XUI0wT1T3ZSMUwtpIg0mFXk+Fni7xEPzlp2U+bNnTZrFHHdQCDa87Ze8SXDD0I4/T9rEQo5R9Um8youopTpB1cxy5D1JD7r+J5T6nB4ETEkzTome6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855223; c=relaxed/simple;
	bh=WI7XrMwtXL077tWZKycguwQfQ38m20vMCPsqD+m+N3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHyU2ucmkPXJdGdyK8dD83EAzWoEugav7vM4YNhqdRJs2uGj6RGXSkSkigT90vG9a5hnmJM8UT4BT/ls80mIkMXdSHu4tvV7umomT3kfNenu+8gBGdyY0sDjVCFsAA3OCYIvXzGTjH3rxEb14Wm0SL2jVMxVhMo99W2yX4eHz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TEG60jEl; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47fd930b8so596829137.1
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729855220; x=1730460020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI7XrMwtXL077tWZKycguwQfQ38m20vMCPsqD+m+N3M=;
        b=TEG60jElpzEJC1VT5+OpLoLh7NHPJDqvghx13/98TBO75B/lWbpz8YtKUt8JdPFU5q
         h/A+M43tkLl8JpPOIb/OFOJDi+A+gOPU9JL1AELX58S0ny9E/0l+kQQfNr85YgUogu2t
         mTzcSz+y9YJ8rVjN+FpM1g+ZnVLZ1neu2QPAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855220; x=1730460020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI7XrMwtXL077tWZKycguwQfQ38m20vMCPsqD+m+N3M=;
        b=kXha5mtXTWWZJcz+NY5Td55ubcNd/B/x6Aa/g0vqcZCaSF84zLdmvSsG7CNmGgKpsr
         KLxyulyJkvp2wB47qbnFjIRFOR6HYCT1r91Ff6icrejjkcWihXPapCrSdsU17UqRkS/L
         p+STdg8LWlf8yrb+DPGjr10PX9yEm810a3YdNWpD2y/1fbbVbx0SZm9NlasA4iPIhSvy
         wPnd1NlYB8MpsobFd0onaOoIR+PvDDReJu25vD6bwRc21+f5C17K+72rlYKZ7RHtqNll
         JDPEdJjGh2iD0nWljrPRQZRxSkvLrGT16VzUQoFR8302q76ZHuA0JhWbqVbz3jP/XadH
         36bg==
X-Forwarded-Encrypted: i=1; AJvYcCUevO+YGwP9JoS5v5ehZORk5gsGFmfXcsyhVAkgl60HMCmKfDwJSg9lR42C8OPJnlNyNX4rRF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhmM/GvlTGWh3m1FEyDBf0aDJ/9py+3BTBx3uZERtg3Nfji5E
	4BDyueGQ+vs+lEmDNsqVCYRjvyy1H6v2zxNXWE7CtWut337+UkJKYierOG7wl3WZFxO2TqdtT0a
	4jg==
X-Google-Smtp-Source: AGHT+IGbNbIL0kk7yRJLM8HX+6BPiWBOqN8FkXifN+DNJQxEyCsURE1WkG9HigTiGOO9c/1iMTfSzQ==
X-Received: by 2002:a05:6102:1623:b0:4a5:afbc:48a9 with SMTP id ada2fe7eead31-4a751bc71c4mr12162761137.8.1729855219984;
        Fri, 25 Oct 2024 04:20:19 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c520a9adsm169335137.7.2024.10.25.04.20.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:20:19 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47fd930b8so596822137.1
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 04:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOMzyxqq8Jnf733zsKSFnqtQ50d3bW+NyXsxTq6qpUAiG1gNaNjsdGj2Uj4O8NGce/cWHkCac=@vger.kernel.org
X-Received: by 2002:a05:6102:954:b0:4a5:b712:2c94 with SMTP id
 ada2fe7eead31-4a751bff426mr11555515137.14.1729855218618; Fri, 25 Oct 2024
 04:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025075630.3917458-1-wenst@chromium.org>
In-Reply-To: <20241025075630.3917458-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Oct 2024 19:19:40 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhPsPRYk_w0n9or7KrEhF_UzLjN8MFCL6xw_FLR1b1++A@mail.gmail.com>
Message-ID: <CAC=S1nhPsPRYk_w0n9or7KrEhF_UzLjN8MFCL6xw_FLR1b1++A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8183: Disable DPI display
 output by default
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:56=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> This reverts commit 377548f05bd0905db52a1d50e5b328b9b4eb049d.
>
> Most SoC dtsi files have the display output interfaces disabled by
> default, and only enabled on boards that utilize them. The MT8183
> has it backwards: the display outputs are left enabled by default,
> and only disabled at the board level.
>
> Reverse the situation for the DPI output so that it follows the
> normal scheme. For ease of backporting the DSI output is handled
> in a separate patch.
>
> Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
> Fixes: 377548f05bd0 ("arm64: dts: mediatek: mt8183-kukui: Disable DPI dis=
play interface")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>

