Return-Path: <stable+bounces-139681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D5AA934B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18DB1779D7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999A248897;
	Mon,  5 May 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebwuewjD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A86206F2A
	for <stable@vger.kernel.org>; Mon,  5 May 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448589; cv=none; b=agdW7tv87KgKUGj2WI0dbKOOYXWWSm43FRPBECurGIMucil/VOk1RUB4mnTAmJ998vFz8goj7MiKcBOAurylnXCQfW79qzLM95oxNAMlc+nVNoSqyQGZxOJTJQ6M4PP94Ad15jC/3kq0hbwJexzUCNYbUF9Fii4sFag7BZvcPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448589; c=relaxed/simple;
	bh=LC3z7RCWc/JvyjQUbetuKHaUmEJ8vDFK9bVb7iQVdFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OJxLBWEduc1DHe3U8a0yFjzwWuDoqrrgWW7D++bmcs0F85sahjtlB+IToVl+nxG9XH1thIA6MCNH7ne3ydODfyko/TL0iiq4DjVNiqWIpHeiDa/adQRCUPhW4b0ylNn5CVOitgaVhwNiI84CGeI9LqXeRFYerUFodT8m7YR0ZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ebwuewjD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a07a7b517dso2723208f8f.3
        for <stable@vger.kernel.org>; Mon, 05 May 2025 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746448585; x=1747053385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pms5fvQ0dnJoBWv+1H4MBoKeVfIfZlhVgzVaTxFBOSc=;
        b=ebwuewjDjIQjexRgfqtFdaihjgh3tNgeiISAARecivYOz2Quacw0B67MEOFyoFAL1v
         jD5hoJIhEOt9zJb8shSBj1PE9+ouHRL0+HwtUtMDobUpXZ0xKChJKtfGLvATosVp2cXn
         /uvIJcfW2XHKJBC+5/VmS3BpgL2EmRJ7v289LP+z8xicwGmB/juYlezyuVgXXVFpi+bT
         mI2lnwZKw3KHXPw2gl6WxIxejXOEBiSEBCzfagLE5N8aMFHjA1JAjnJIF3Xy8APM8L7b
         ksU6UawgeAA2lOPZygd7r9O2qDINzS3GkzG58z33dnbRF0YqYhzl/P2yqVKoEuCg1/Uu
         hk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448585; x=1747053385;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pms5fvQ0dnJoBWv+1H4MBoKeVfIfZlhVgzVaTxFBOSc=;
        b=eiSUDDXWqhPwV3ofoXI1rVd/8utbimMa/U3kbDbaa/kqmto2drF0fSjQaaLw6iVyF7
         BQfGJsTY1Baecq/5NR4/92Dx7qec+Um6ZMp0fKvR/GoTqw9Hv7wTxdSf4zwKFtc4S++v
         Oqhc46IQ2O0WfyKPOtFR0qhqwLCjunqS08buTBqEoDUolWvmc/ESWEwt6Mp1W2OzNsH6
         QQK2K+e/dUnj7kjM102MR0VkXRVAm9sJ7IHiVVmsFk1oZ9y1WbQmCsFOGLGCRcakx+db
         zwiD7ZG0S5WTfj+T6RJmh/0MptUuPLHtXCsCVEu+DgJd0PdCShwwPr7SJ4s8a6PVzEY5
         0y1w==
X-Gm-Message-State: AOJu0YxyUiS64EKFEA6xTP7HJEsTElhwA8c1dztAEhRd4g1gPlWIUV90
	PyFpk7eLWyoLYxr7m3eJv/83kXlsJwqgzKFKmsEBsCOAryLL0umwq/PvtswclukOdcgseh4AbF8
	G
X-Gm-Gg: ASbGncsv/aRC5YaKB8NBnrcA9Lp7X6FMJNMImsTbmI+qUixMZb6L2o6LxKP6Ygmh1Oz
	x1mm3NFkUCr352cY2JOPRtzGt6YtaG3cBEylNK40IMd8A5ISa/FbPwDjd4CDhhKaqEtTkeXB/WJ
	M53Hk8IIyQqkeYAFj0lnhdr7QvRnF0hxE2zCQ1nEGdFxagj1ZxgRgpHcrBGzSDmN4W/8V1cm2k1
	yD7a2Lzs1DB2xpuIAiGjw2a5HimgGCj9OcRB1hRj41eJ2ATEkuPalIt6JDt2eJUuMUpTJoIVezg
	BgMUQ6EKoYzpTTvEaT9a18ht5UrfBBp+eUJSsVoXn9bfEMFwN614dgdxugzvMvzVEsT9mYAJ
X-Google-Smtp-Source: AGHT+IGsEliGJnwJASNNzDOIlUfeubpmj2r4ysjGNDPlKRJUSM2MTHWLJu/fnMkKxMkulAhjanR1Kg==
X-Received: by 2002:a05:6000:1a8a:b0:39c:d05:3779 with SMTP id ffacd0b85a97d-3a09cf4d5admr5929318f8f.49.1746448585435;
        Mon, 05 May 2025 05:36:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0cefsm10434442f8f.15.2025.05.05.05.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:36:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Christian Hewitt <christianshewitt@gmail.com>
Cc: stable@vger.kernel.org, Emanuel Strobel <emanuel.strobel@yahoo.com>
In-Reply-To: <20250503084443.3704866-1-christianshewitt@gmail.com>
References: <20250503084443.3704866-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: dreambox: fix missing clkc_audio
 node
Message-Id: <174644858455.1377517.9885445879892405270.b4-ty@linaro.org>
Date: Mon, 05 May 2025 14:36:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Sat, 03 May 2025 08:44:43 +0000, Christian Hewitt wrote:
> Add the clkc_audio node to fix audio support on Dreambox One/Two.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.15/fixes)

[1/1] arm64: dts: amlogic: dreambox: fix missing clkc_audio node
      https://git.kernel.org/amlogic/c/0f67578587bb9e5a8eecfcdf6b8a501b5bd90526

These changes has been applied on the intermediate git tree [1].

The v6.15/fixes branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


