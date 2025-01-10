Return-Path: <stable+bounces-108219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35249A098EB
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CACA188D925
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD81213E69;
	Fri, 10 Jan 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgXP7qbV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524218C928;
	Fri, 10 Jan 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531569; cv=none; b=DvZKKhGJfmdk5lPUQNskJtYxMFVkwHHIu2Xers1bVqUwTHspFLpAIrEv3qD4SqgkFw5etwjP+/knI07EWaGwX60XquM3YUXL0TYDXVBaSwOLO5KuOlGyjgFlHOPwO2OHaZdaxToijjpIWNMSlBKDIn7J8ZQMHBVCLobuG7ewqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531569; c=relaxed/simple;
	bh=Rz8w0lstIuLH6/IzR1zFLkdQ25LALXlY/OCCYOFTzx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKI+hmHNY5dSo2lIthc073WSQOIiz1bvJzSA3Z/ie61HfIHTD2Tx1d2rLYn7EYfVDgw0qfpFr03IugbRhNMR7tMdUPyA2Z6auXf5PuhZK9jCI/a3sSlXlLJ7gLnrBz4d0W9ovUjGsUeBsfFTduAkvW9Glb7DicAksVHyx5Tw9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgXP7qbV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso2029167f8f.1;
        Fri, 10 Jan 2025 09:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736531566; x=1737136366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTpWI3SOQ7n29zKKV3dVg4dmzAu0cuaqiEf1YVn/pVg=;
        b=mgXP7qbVHFQZVKQwBsK5rw+r+KkQfbIxD8oVy1bnVKB39mJLufczLs+l1Ucq2bVzGg
         8TqT38yZIaUkyhmAGAEQICT83peYpM8jWfo7SZpO8N+HoadLcnYhqtZvs/rximnuzqUi
         t6XlGzG8iPro3TXiIn6tL9MJqZDP7oDsajeiCLgNHdE8PxLMyg/fOTBcd79fmNveDQNo
         //lr0PBzOWrTCjPXdFWOYEzQPQeIf4KKbYhy4ffTcrtWlQH03jp318PKgJdsGldx8/HV
         bVi7UfYByMjMjgqYbb7OybwjusrvDjCqzgq0cLsAnIxGmn+wGtgjvi9VHI8X6ibhiY4J
         aJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736531566; x=1737136366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTpWI3SOQ7n29zKKV3dVg4dmzAu0cuaqiEf1YVn/pVg=;
        b=KQklS9kbNXccaM07xf7PsvMAXV+olLqvUz09/xZ818Om3KJo+3DwVhkqqAI78SR+TZ
         JHkNrwHvXI5YHNjUnM6XIl77lnr7KdQPNBJdNe2oNpI/zmOl0yMgpuzmVurbyhxj3g1D
         JMxf1FpgYKZ/QrMVhFIWzAuuCPOVQmSm01WJxbhhOEUcl59ROcMdUmw6kzCle2aLecux
         sK3nygJEVdfd+HfoHXtHtCVd5qEECVvF2ySYD27YCRwMd3rineppInVWsc+lCzme1tkJ
         +1m0tqFYv+ulHdyZto/E8Ifd9x+RBIl9wBoyUJolgmDSBwRpu62+kbGm9N9EGGdtvhyj
         GQFA==
X-Forwarded-Encrypted: i=1; AJvYcCWsHfnp9WC7yA8ntgQ/PHn9cNCfXi97he57/cPI4zAHIgUECU1n8RyzPK134dXrijo0xTsKFUSVFY89zTQ=@vger.kernel.org, AJvYcCX0s8JVQf7VH+Q7IwWq+a0iBLQnySMY4Y1Yc9RN7Ny/bbN3EgAaQLmVXAZh1HkBGPQKjlmQlk+bZZe/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlmm4i0kffmiXb8lEs7S5702O4BdRQ95NRZogBtvkPbwymwUWz
	4JAANYvwctgb7Fld5W6/Jv3rPi+Cq4Rjt5t+50Zg6ncaOYpbuxiK
X-Gm-Gg: ASbGncs5wl+Cy3koT8QorgDLGif0/S7mANWEDPoTv8E2dQvsZG8exy4MUZQ0q7HFgA0
	l/XaYek9VkoSZKNVeBUTV8TY0CtWGH3qWXCZB7X0vJaIYqxtjWn1BUYk5/W0zjLnRmFH648FX6P
	zYwY6xEDFdUaM0mFV6imh0x69lXa9JSw5BuQwCUrXo/2XlaQ3U9IO2Lm0290R3N599tr81tOepK
	rgzGkNjDochTplYt2QCQHE6kTibCFoIAql+YSQZ6FhuQY0AMGcOQ+So5NqrDq2UuLUul2qrnPUw
	Fmq0cPHEmoVbH6GwZ5iDFYFQtJ+QuFw6s4rlrYf5NCMy1jZk
X-Google-Smtp-Source: AGHT+IGY0hL/kvEy5xckuzoaCDclezlPGQEHX3vYYyMOnpQzgRIiPi8Q1zLZq5txiSrFCBXPSobGBg==
X-Received: by 2002:adf:8b8d:0:b0:38a:5df9:f86a with SMTP id ffacd0b85a97d-38a872eb1demr9052197f8f.26.1736531565367;
        Fri, 10 Jan 2025 09:52:45 -0800 (PST)
Received: from localhost (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1de9sm58915395e9.15.2025.01.10.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:52:44 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Brad Griffis <bgriffis@nvidia.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: tegra: Fix Tegra234 PCIe interrupt-map
Date: Fri, 10 Jan 2025 18:52:40 +0100
Message-ID: <173653154336.3488930.500938674526829720.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213235602.452303-1-bgriffis@nvidia.com>
References: <20241213235602.452303-1-bgriffis@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Fri, 13 Dec 2024 23:56:02 +0000, Brad Griffis wrote:
> For interrupt-map entries, the DTS specification requires
> that #address-cells is defined for both the child node and the
> interrupt parent.  For the PCIe interrupt-map entries, the parent
> node ("gic") has not specified #address-cells. The existing layout
> of the PCIe interrupt-map entries indicates that it assumes
> that #address-cells is zero for this node.
> 
> [...]

Applied, thanks!

[1/1] arm64: tegra: Fix Tegra234 PCIe interrupt-map
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

