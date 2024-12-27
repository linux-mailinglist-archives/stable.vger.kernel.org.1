Return-Path: <stable+bounces-106194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A79FD434
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902D43A0F82
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD41B2193;
	Fri, 27 Dec 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q//aZnUz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFF14AD29
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735303606; cv=none; b=Qh7QRlXeATvlCnxLGSxg7791fh0sCvICJ9SQ8sJXs7nwEEthy2gbXk7kIRksaAGFLoCnw2c1ELVGsbMuf/HX5lOSYxXRs0hpk6QGQvONnO4b9CS5s1RmwLjkYudKLxUteRNJ09olzXGkNl40SPoDwpHkOo/Y8aSjWpE1MmxHAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735303606; c=relaxed/simple;
	bh=IX1Pbb9e9j1HoYmbUCLz0vmxGQOa9VaE8MApR1YCGOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH7v0EkB308EZf+E+5I1yQ+XlBmWalb5fiK+hF3VubZ99Q6CEBkrybO24d6g2zwRcZ3sVS5DeuLrFVG86I7AszpYSa9toBDMa0TSxJ6ysgM31liFJhRUrVxIC6/RwkdLer1dGN9QyloYlECn0vty9+eh/XGaoRqq6p7KcLdV8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q//aZnUz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3913212f8f.3
        for <stable@vger.kernel.org>; Fri, 27 Dec 2024 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735303603; x=1735908403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAr5MJyxW4tliQqtSvIibq4rtO0kf94wwATw2mUtoLU=;
        b=Q//aZnUzV9muSqLahVP7KhXETYk0BL1wsxA07GNo2UvpcQxPO6r0XnJdXvb2qn4Fke
         yEzIQAa5LjNnFltmBm1i5xAObm5VHoDm+a+SKcV7gk+zc9DvJrTyDnAETXRhIqK1K0/S
         9B30svSQ9XIc57Wyfa7f4ATPOTFFEbJO9c8kPeZl2BMLI8tyxnxfIfQpmHwP5B0fuB2f
         tZaOXyPIh64XlspQrvUNP3Y7xg7IGdzJhUZPxpHExKqetgkNecrvoX117OaEmrLRPfle
         dLU5Q32knnc+QzddMkLjnfjCZPR4YAIq5QQhH2/GNsvEjpk0W0Ug/wvggu2b7pneCfx1
         YoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735303603; x=1735908403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAr5MJyxW4tliQqtSvIibq4rtO0kf94wwATw2mUtoLU=;
        b=ZsrW969qBX1xthp5mmWkMuwVnwsim8FNckHNs1F8aQNV3JY5iorG8Dyr5XS901dS3q
         V+55m5Vk3DYusUlKKJzTgHlWFHBkDErGiIbhxnS9ROnkFzt1Spyq6enAcYAZkfPhbTji
         MHUyJxKdZ8yLcA8QUAqllJOuATpmb5Ih79zrS/5Zfk5zYNNpLd8uwxejJ9rheK34UmvB
         OQe77j0Q2uIqgjKeLYrOW0pBo7i5Uz16jUBBH5G5kVSypZq7rnuFUzspx9/QYZgU5uat
         Keg78GhjyW4XKpxnHiHV0vAJpc8Z+efrPCcSP3N3seQwI7c7CyxHkgt9LFQET/VwhI8K
         khJw==
X-Forwarded-Encrypted: i=1; AJvYcCVu5M6ny5fGSCUReTw3ABLISRhR3o10x/DJjGytlqN0hyxuS29dtxvKyNhGsnfP+O8cqzQG2Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkk2nXEam/HFs//bFEIEq+T2oysQy1HggcPcvCB98+50yxguyo
	gIAvnCiPuRWPnEM/MtFhoQV0uv6W7psHu1t41iZ4/Xi6GqkX0RiP0tZnP3t9h1w=
X-Gm-Gg: ASbGncv3s83IE3+Ji6NKhQkdyS+86tS+yAV5mz7d76eE653lNnl2cWHeKMS6kZI8F42
	lppdTQO5JkLrxYYxyFg96L0rSa4MpkvFd+phvL5dkq6AuJLBqB/W/mh9vLMIrEXRNAZZk4jOda+
	7vkUnD5XTReud2qy9EaH8u3tfIqVf3MMuKpsmX4jUPqsS3UhoVt5Yelfj2yQYGDbHAfn7TYNYaz
	zF5fKggpLlPEyQ49wmNg5je100nN6eGkiHMrxal7ECz6b7k+6ZL7lQ2
X-Google-Smtp-Source: AGHT+IFOSyN6MsRY52PNGIySqb8jJ3jiAJ8ipn+mH7OpC8pga8Vo0BdkKK7utvCX05gXYmLza6GGZg==
X-Received: by 2002:a5d:584d:0:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-38a221fa9cdmr21953130f8f.15.1735303603117;
        Fri, 27 Dec 2024 04:46:43 -0800 (PST)
Received: from hackbox.lan ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b11495sm297172905e9.19.2024.12.27.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 04:46:42 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: linux-clk@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: imx8mp: Fix clkout1/2 support
Date: Fri, 27 Dec 2024 14:45:59 +0200
Message-Id: <173530350106.4140483.17403614068290152779.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112013718.333771-1-marex@denx.de>
References: <20241112013718.333771-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Nov 2024 02:36:54 +0100, Marek Vasut wrote:
> The CLKOUTn may be fed from PLL1/2/3, but the PLL1/2/3 has to be enabled
> first by setting PLL_CLKE bit 11 in CCM_ANALOG_SYS_PLLn_GEN_CTRL register.
> The CCM_ANALOG_SYS_PLLn_GEN_CTRL bit 11 is modeled by plln_out clock. Fix
> the clock tree and place the clkout1/2 under plln_sel instead of plain plln
> to let the clock subsystem correctly control the bit 11 and enable the PLL
> in case the CLKOUTn is supplied by PLL1/2/3.
> 
> [...]

Applied, thanks!

[1/1] clk: imx8mp: Fix clkout1/2 support
      commit: a9b7c84d22fb1687d63ca2a386773015cf59436b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

