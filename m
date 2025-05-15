Return-Path: <stable+bounces-144530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C2AB872E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6C33B7031
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DFB298CA1;
	Thu, 15 May 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pyjFK9Xt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E42980CD
	for <stable@vger.kernel.org>; Thu, 15 May 2025 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313956; cv=none; b=LJFYchsb1DqAjonYWiMhpgqEwnaOwuMbNhqY1h71c5R0I6BVcVVdjItFjuYZcCucZYSmKWYtdoAtvFMVCP6sapvzmYBi+2ogrCETiMnbjLJl6bFlODWf6ZMcAXj2qkNbloDffUpcQoplhDn/Ogs8oK3qB7ALnKvlRqxbN3tOLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313956; c=relaxed/simple;
	bh=ZU+L9HRsuQDe88PKm6tInPPVLfT8JP5Bqdm/hv5vNlc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mUOQbAZDfP0TPwtBLZpsP+leX4os9o10SvqsMAca57GIlSk9bw+bt4pnnu6S+YphDh2OnFXOoV7STBqZnb+VH7B5+84UyRhIgVnLZiwWNUXOsApnqxg6+r9f3++G2Riey8hmbPbW62eYeVSPXvKFQ7+XEjCFWEESu/i7DPJtQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pyjFK9Xt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso10130245e9.2
        for <stable@vger.kernel.org>; Thu, 15 May 2025 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747313952; x=1747918752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93NSiG1e0zBMLdXcPRXVb1UoRXanauxq8sjT5bMUUhw=;
        b=pyjFK9XtrtDE1rF0UB8WNs7RuSwJ7+AKtdGrvj3EG4mc1inZzPv86zFMsqVKhDQ2ws
         FeEtB7VIiurpiedqWyBJ4eWL6MKAwrADiKe1FRzgx0x1rQbzpSKWW/0u/MYGkdn//tv2
         lwnxnqrdynRwL/As8WvGxIFnLvWSuz6TujNBrk6yaZQ0Bv98sgeIerE/j/FDuhuN7PwH
         DpQof3y3pGPoi+PPzKBk7d1aaVgc0I23veNwoVOtYvkrYsfjwNnT6AufHadfiD2jlgyE
         L1L9L+REm4EUtFvSjDy2mmLgdod6h8Dmy97Sv+4Qdxiuhtch/ZjlKMd+rgIUs+BLB9AR
         1iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313952; x=1747918752;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93NSiG1e0zBMLdXcPRXVb1UoRXanauxq8sjT5bMUUhw=;
        b=SKH/+cwca7pM9exQKs+LyqSzm8oWJX+ENhDlvitylAz4aXcZbBgymkVCl7pO0T9VU8
         5AoWhXBNKmvin3m2CD38nPKGG11GIqJMHHgTOtkzkA8ddukhDXjJ2H6UGnvHDqSh1tdf
         1OoJTIknPaRaUllurYl/jyLXT7+RXprTrVE+l4rTohK92adUbVSpRWEQ0AXTXHKqB7tD
         Ipr/4PdUU6U9KaZakPhvIDE0yrLky772k1JqYkk5kFaRhxSI+CWC57oE+TCuSxUMVLBN
         sklf8jZQeRZXW2CIYFnT4rkdKBeAK6n18xgYoYG0sBAWN+P/VqTFA200U8MMeZ3tVjNf
         dFhQ==
X-Gm-Message-State: AOJu0Yx9jOLbDP822vg7VJ6YG/gbZh0kwamjtIzxrJ4zOOs8Ez1CYoVU
	cm6CvTHhCnkdplf775CG7sWWOJMxIuIlqeUQWv6LgCKHSS7QUH2J/FCunxLtk1I=
X-Gm-Gg: ASbGncsFKB6yEdn1GQZZfPYWmBEHY1IRvj5aRoWF6LkuoKI3us+EJo0RsrfHWH0GzQV
	IvmIe41EaDbdEJRUCVtbMLNpP6uSHnSAGa7lgnYecAYGWK1A8oBKm5TSHJ7O7fAa9Kj/LcrrglK
	Tmpeecl9xrZzh43VAfsFMEeRwiMmWhlJn2rMMhkU7YXNQln1B3qVCHZ4fBmhG6r7QiTnkYrpz4X
	hYmZq+8xNU4Gs2c9f3/ulAy5PbJ7qK1ofQmwY/4B6/zhprziz5S2jo93Gg1zZsCJHhaV+MUGe76
	GtFJ3rNM1grOxRzf3oN8F6YSeeSA6IZhwdh0LA37iJA1Zq58fe7XgIb/jQWssGEC8A==
X-Google-Smtp-Source: AGHT+IHpy1rhqw987Tuz+RK9oDjiZ/Y3wtsR+06Hh2lLmeOPW+aVkSCgkOsbFAx/A5adDBQ/I/BpHA==
X-Received: by 2002:a05:600c:6612:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442f20e1abdmr92975295e9.10.1747313952121;
        Thu, 15 May 2025 05:59:12 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:82b8:c32f:4d8c:199e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e8578sm71180475e9.29.2025.05.15.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:59:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Da Xue <da@libre.computer>
Cc: stable@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250512142617.2175291-1-da@libre.computer>
References: <20250512142617.2175291-1-da@libre.computer>
Subject: Re: [PATCH v3] clk: meson-g12a: add missing fclk_div2 to spicc
Message-Id: <174731395123.3761659.11544664862448009697.b4-ty@baylibre.com>
Date: Thu, 15 May 2025 14:59:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: meson-g12a: add missing fclk_div2 to spicc
      https://github.com/BayLibre/clk-meson/commit/daf004f87c35

Best regards,
--
Jerome


