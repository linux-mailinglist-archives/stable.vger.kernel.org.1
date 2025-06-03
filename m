Return-Path: <stable+bounces-150723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5086ACCA63
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48511665EB
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEDA23C8D6;
	Tue,  3 Jun 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dn5Lp0bK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2C23C509
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965404; cv=none; b=Lpl/UfPY2Mhuokya7w+/GUuf2mzFLG7rOMiVPfZ99eICQccHiuo00yputECAk0YJVJ4plYSaBYRkjqq7sxYdMOkKz5a8HkkX9t/8oLkIZZU+6m7gB5Z8w/3SkW6JConAZWxEsD1d99bOUvuk6aqPbkl7MdEMRBVVSYskzgSdEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965404; c=relaxed/simple;
	bh=aKo9WNWRBL0f8HmrtPSASNW+mdOzeR3AWVqy7W4T820=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K73tzahRWIwJ3U44h0TzjqfNZvdqIzapJFdk0H874HbQ9uA1Y7PpFEpiB9o3yn4Bbi2m0Ah8rf8upARGophPiiz3Cp2q5NupzgefQ+5LqrLCasnBruuoauNtLDYZYCnBx+6/zQBsz99yh08JUoZhX6BuR7sqrXd5i5fri+19ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dn5Lp0bK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad89f9bb725so1155696066b.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748965401; x=1749570201; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=172AOsAQz4QlRBaW+nRn36onwnXefgQKgc9WvkOzeXc=;
        b=dn5Lp0bKDGpLka3BIU+PNOMDBTnjqJ6TcNBnKA9IurpOBFORDMHiLUAEjLqZeRP41o
         Zj6fUUGPeYh/id/u7KywDsovgxjJuhM+SeRFTOS8O4uQxx4T9Hlq7teWVVH14RHccAHL
         Od0g948M8zIZEtLNuEnq4tLUr3UNLpSWDqJIA88+8RVqcJ3BHQKCULikJ9jRbpO1AB/i
         HtOz15pKID+N50w7l8dV6YG5ynL9aro1I1VFXxwJgmujgHhpununNuG2C2qiPp0+V61B
         tiJNJoUh9aFI1BU3UEe1qlLuLZqV45Jah85mO1oioqLh4nF77pWv9WH3QWYLQJiBS2j2
         h3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965401; x=1749570201;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=172AOsAQz4QlRBaW+nRn36onwnXefgQKgc9WvkOzeXc=;
        b=iYWPzqrUjUN/IA7ft/Bs84vEU/iYvU4baeLxvMQBFaWrHl8Odu8EqiwWHvB7nkYFVQ
         Nfony1SKJdX7J2gRDmZ6esAwxAxXy3i0fFnjiKRfLzEy5xFydfJzqPIitmFnIbLgV6zV
         TTpsD3gXYp+KPSe1MWGewV2XceHhUg7KUdgqOZ/iaPAE6QRqQxoYZINxtI2TTHM9B/+f
         GJ1L5C75sNXIoq1QylKKj7WMbXT+Yt+7I5ar5LAish63K0gd11x30milns/sRf+ekg6m
         KZBBzuPx3SjkRn9zysiC9L3rriGB06VbIwKw5EWrqI1qla/u79GPnYDYJn3VY+MsgfCQ
         iS3w==
X-Forwarded-Encrypted: i=1; AJvYcCXYRPtMNz1/tJjTOOsCHOe+HZ2P+T8PenndyV9GrCHKmPiWz8ZBnGkcSZfVXzqa2qltpDAvZBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXYrH3uFYVo/sMELVF9PVNv4uvY/TihVXTXsAYMia9WbY4Rk+
	hH5+/tUA0M9XhtEAPrECTmuWdG3ZBlxur4gItRpIwwW6Eb6upcAoEIHVtXjMBZPHU6w=
X-Gm-Gg: ASbGnctkS4SXUqLJXlLkCfTNuGslxuTypNZiRAXH0r0DfmUtRVzQbiLj/OnAWQ6DaSg
	K1ZK1kjtLSpC1wNoTYv5nf/ngzbCWhBUkX6iGpGoNjcF4n8S+wGbz+WEuis13KEGRYLkLzkCNI9
	PFaOEmPM8iOfqrxjJXJuLY3tkjASMJJ7qSZQAUu9lyj2oe2VBPd52ulnkHIviQVXxbarhctOC54
	mo9/yKOmPjaai+pyuA/Dbhgwb0og08P9PVmwOQhncBBQyK5527ZU9/7AjqtMMhnm2vQOq0MWie+
	rRPF3fmVj7YWrYHXSzJHvN8n7FOnNcBx1m7HM+gAGX2frUMU3rVhx/DBXxsurp1uVaTOoPzAYoQ
	uscv+mrraNZJTBEVmj+oljfysK7s082xLhwg=
X-Google-Smtp-Source: AGHT+IGloNqlwgmA2JLdwpv1Sfgyhpoy3jA6UsqagxeRD/QCKnQisvHafq6ll76RsV6qpOjXtFvGFg==
X-Received: by 2002:a17:906:478d:b0:ace:5461:81dd with SMTP id a640c23a62f3a-adb36b05802mr1654872166b.3.1748965401077;
        Tue, 03 Jun 2025 08:43:21 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de9bsm959277166b.47.2025.06.03.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:43:20 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] clk: samsung: gs101 & exynos850 fixes
Date: Tue, 03 Jun 2025 16:43:18 +0100
Message-Id: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABYYP2gC/x3LSwqAMAwA0atI1gbqp4heRVzUmtagVmlQBPHuF
 pePYR4QikwCXfZApIuF95BQ5BnY2QRPyFMylKrUShctitnkDB7tuqDjmwRN7fToRl3bpoL0HZH
 +kLZ+eN8PPxlKomMAAAA=
X-Change-ID: 20250519-samsung-clk-fixes-a4f5bfb54c73
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Hi,

The patches fix some errors in the gs101 clock driver as well as a
trivial comment typo in the Exynos E850 clock driver.

Cheers,
Andre

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      clk: samsung: gs101: fix CLK_DOUT_CMU_G3D_BUSD
      clk: samsung: gs101: fix alternate mout_hsi0_usb20_ref parent clock
      clk: samsung: exynos850: fix a comment

 drivers/clk/samsung/clk-exynos850.c | 2 +-
 drivers/clk/samsung/clk-gs101.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: a0bea9e39035edc56a994630e6048c8a191a99d8
change-id: 20250519-samsung-clk-fixes-a4f5bfb54c73

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


