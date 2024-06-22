Return-Path: <stable+bounces-54864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5CC91330D
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D130B1C20E3E
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F614D431;
	Sat, 22 Jun 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnXqZfj8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78914BFA2
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053370; cv=none; b=UFa5oJ41Pr4DIFOWJx8SqGas6YKVR6F7pB81NuAfBNjLNXenDfdHN+s/O5MeNdALo2b+IL8RkXrMHTzTgKZqZ4rzRS/hfRLS6ZpRhbTBwq9E3cPlp5QrI2GdiVDoGpYO0NWBZ7BN2i01vmK0OAEB7o0FUgJ/qyzkMqJkQw8CQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053370; c=relaxed/simple;
	bh=UD+lAkouumB3PIrq8tN6oOxpBGGY1WuW8r0CHKDC0+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tiyQfoCT3FjYDbj9fbf9uCHkkc/6PWfzYrKy/TUp+dbMVYXrhiqRplccJgs2PbVFTsM+70JTMLRCxxVA9+wcStajrmGq/qT3ktVBUl/eMwRf/EWwW4eq0C8Cxv9AX1H+3m/h3VTs0Zz4RPnUEigFJBwS9kBlwXZzuS0btiOjWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnXqZfj8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-364a39824baso2075592f8f.1
        for <stable@vger.kernel.org>; Sat, 22 Jun 2024 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719053367; x=1719658167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlHWnVqKixYfxgTxJ7LtzKU7/K1qY6Dr90ft4beeGYk=;
        b=jnXqZfj84wmmx94s9jJO7oAeAiheRFa1ZxL6kdtZzeacmRrFUZeBOgMG7Y97O5gDRj
         mOZWcGiQMby4JbAo9MiQqovIqADr3E2X1xE8Mpl+8RGwnkOmEeDgwq/JwwnePDcB3vz7
         Trd8htrq/lAC3NPquwYFUTJOkrAXqW+MwOZ2IBBqMZPLpZP6Ohz9efNirzWWLhQQJkNP
         73h9eEQxScoOoYQp3uEEatsVa5lCEX84fBsJIfOyV+vijikPoPZ2Bs0HXl//i/Fd2SiU
         NPp1w9+qR2O6s/M7tK+bxD+InVb2eyeMfhoy3WEoPC4D7TQ4/tyk6maAbGZQqlqtnKFm
         BV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719053367; x=1719658167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlHWnVqKixYfxgTxJ7LtzKU7/K1qY6Dr90ft4beeGYk=;
        b=eSawdmjf1qyNWKF2YSIUGWgThZh0U0A2jY/ZyvPN2w1gXcNG2ux/sGKDik9r7oKUOh
         4EUn2RNBUQTMo8YRN5jeCPskxCCKF0iBEkG1DdEoiglN00w/GJbcz+HmORCNcw+iUCy5
         paNp8nShcdJX7rfqQ6DkTVpItcWIxjRRpm55t0JMt313JwupJmEsUoKxl/SPzdOGcWC/
         bZa24Sz34uCGSUBsYuabspudZA2UFboloQh4jg00WhK6aAOAPpQYWqRK7zpJSCm5lNqB
         dMDPoxz1twymPEqFMPLZzSOZrBIuZp8vomoQhRK5hFa/kElOVHXNiOMiBxg3n1SuirSy
         R9gg==
X-Forwarded-Encrypted: i=1; AJvYcCWVCllJNA8SGfcJU/HZgqQcAVcLZeXeFXQxGIIMfDaD4JV4KRDSrBJRSngU+o8YmVZUl4UPj6rG35qB4rJOFJ+tv63hN4gI
X-Gm-Message-State: AOJu0YzM/dGKw6ttyiBfEDl1zicWj03mev7QVpLL6Td7hGZ3MX6YCPZf
	+R+25ZZ0lDL1RkMpsIn5RF38RoGmVMz2DNLe/7xVT5BC4hf22+Mst4rdryfPdKg=
X-Google-Smtp-Source: AGHT+IEaeZe/ovN769uftIo/IvGq9huS4i8XzLmG5th/x9oaDRrhvRLAOXGDe+ujRML8hLbqv2v8CQ==
X-Received: by 2002:a05:6000:dca:b0:362:93f9:cb81 with SMTP id ffacd0b85a97d-366e7a4790amr209872f8f.55.1719053366584;
        Sat, 22 Jun 2024 03:49:26 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9c16esm4127934f8f.57.2024.06.22.03.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:49:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
Subject: Re: (subset) [PATCH 0/5] nvmem: core: one fix and several cleanups
 for sysfs code
Message-Id: <171905336506.244973.16113259707012674277.b4-ty@linaro.org>
Date: Sat, 22 Jun 2024 11:49:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Thu, 20 Jun 2024 18:00:32 +0200, Thomas Weißschuh wrote:
> Patch 1 is a bugfix.
> All other patches are small cleanups.
> 
> Hint about another nvmem bugfix at [0].
> 
> [0] https://lore.kernel.org/lkml/20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net/
> 
> [...]

Applied, thanks!

[2/5] nvmem: core: mark bin_attr_nvmem_eeprom_compat as const
      commit: 178a9aea2c5db8328757fdea66922bda0236e95c
[3/5] nvmem: core: add single sysfs group
      commit: 80026ea9fdc22bbc8bfa9b41f54baba314bacc55
[4/5] nvmem: core: remove global nvmem_cells_group
      commit: e76590d9faf8c058df9faf0b6513f055beb84b57
[5/5] nvmem: core: drop unnecessary range checks in sysfs callbacks
      commit: 050e51c214c5bbe5ffd9e7f5927ccdcd2da18fe3

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


