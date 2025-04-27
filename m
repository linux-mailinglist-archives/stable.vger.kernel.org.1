Return-Path: <stable+bounces-136790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084EA9E41F
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 19:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3521894215
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387A1EF39B;
	Sun, 27 Apr 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj8FXkbf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0F1DD0F6
	for <stable@vger.kernel.org>; Sun, 27 Apr 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745775541; cv=none; b=MR3G0eaY934BNjaS5P91yI8hJFmFaCzprnGB8yECg2bl1TR3e7TQ5W87lzUVuZXCT5OaxbUojK+mqz3wxr1mroSyEcyBnaXXqwm6I+N2VC13BIT8FVuXUjOKVieqIFOIxkirqUYjGHPFk1a2ma27KcHhmjtvq4kndWK/smQ68D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745775541; c=relaxed/simple;
	bh=xlOkb+AA7EeoOdc+SBv2SlUBLZ444ktBXbA5itkBKrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgFgJ5+FNjXxvcTu2vGH7wQTmnTahdQQbSBlUAUcMYNwfQUlZfngM5vPVI8tnuJ41oOX8YHGaeWOvh4xirfNj0ctZAYSgBgIwQx8a7lwIGbSL+E73un3M2pI/OAEfKl8Ag3Gp7X9PapV16gT1NMG9AIXXsMhWDWNNZbQUOLzOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mj8FXkbf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225df540edcso50467255ad.0
        for <stable@vger.kernel.org>; Sun, 27 Apr 2025 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745775539; x=1746380339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQlOF7pnuoHcV4tUzU9FAAnsi+yiSpTmFNxdSuCGH2w=;
        b=Mj8FXkbfunkSE18HhuzSHu4wNXue46L4eyK1um4fP0zZA+/wZIxQtCehMiy3k8HWK5
         zTr6skiGx8KaOMWhEPCIcbZYvp4qWAS2N6hgeSf3J7hlEr6HphBMtXj40hClGxVe3PWi
         2hyKdt4hg98/OceoiFc49UwHcVR++anQVqQ341lwGAKZVgfdjbz39dTyizOMXh8X2Pe4
         h3kdal2AMuWC7EKs6GbcJt8XoHrxcni9W77GGcjb6tfmk/xQxNNk2UpEUTMBUa+VX6fc
         Knm+RaCnAFhxW98wwbYvD4npZ2u0yQLpsdnm+QmFym2g4htklIQq8RhgIcpcn1TAENoj
         LOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745775539; x=1746380339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQlOF7pnuoHcV4tUzU9FAAnsi+yiSpTmFNxdSuCGH2w=;
        b=Xm+xUom64iBORp21j5LdKuMcOBC745It3hMSQCwk6ldEzhDPzCZ9jJFCks+DOvdOB4
         7LSIcZBZaz2xLwW3wUoH7qJdHA1GhyaktARhS1vEYY7nHA52ni3G1sr2A6Pf27Vd49nn
         KuyYJ6q2MVa7luv7xDznF79VkoD63zLm6wCZK5uww0M2qKtfMDue70/Dk3OBlQB99sv8
         FV7xo2wel5P/BvaNHhHQWQJdZAVPvk9/U4xw3Hr+ztPuwrw8VTitQ4gRFCsj29cTXE2j
         JkxdQus++jVWmMhg/73ip1ojYt0QRDosAZfnJTquf6wUQeRC7KTaPcNrJYyidUvF94Fa
         Xklg==
X-Forwarded-Encrypted: i=1; AJvYcCWDmamF6oOdHL2zjuhLLREHIoblB6M3QghzK9j6F820eaaw7yGS86zbMGXXOZj4h3WYZA8mNhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYnqNeUgWSP6Nr4YAG865cvTIbcWB08zYPYYb8DUHDKf+1pGI
	FX0TWcjhpR6NltDUFTcSbXbwYgPl0EoiHD/nwMdujNHPZDZ464LHrzxJe2QgGA==
X-Gm-Gg: ASbGncsZRBYQshXM+iPKnYeUNvg787w8+oT9jfQkbbfVckvC0FxwwEFaaS1UK5DgWyt
	Gu8Jz7TkhNe8knA3hrqbFLIyBT425Ax3Pwkjb4GYjogeGAWPV+VTnfvjNE6ja2fUlBiwZfmFJvM
	4b0033VvX661ytWeuT8+hW/sY04ymf+HKPDI7ZXzu8JJ+M7kdbSadLZe1EUNFKq9EOZwysN1uqj
	fH1LzMLChbOrzz/or7o/W9vhVZe7p793Jm96odFOD2YdZMKTgpLPE13g+b7qI619bCLaDopFHBP
	it0oWDfTnZ0ESVFV5EfMFNbDMgLedVOj+Wcm6ydTW3VxeoWgzgYa
X-Google-Smtp-Source: AGHT+IEU5IH9SCIsyt0qXj4mqk3Sr5u/bdn7eIkZRJYO1TNJJ8pz73ALG1a7lc4tKhheycKSRkIO8A==
X-Received: by 2002:a17:902:d4c2:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22db481b546mr195207145ad.14.1745775539333;
        Sun, 27 Apr 2025 10:38:59 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbad7dsm66569285ad.60.2025.04.27.10.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:38:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Rob Herring <robh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix function call sequence in rockchip_pcie_phy_deinit
Date: Sun, 27 Apr 2025 23:08:49 +0530
Message-ID: <174577552237.92328.3418257212908173284.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142138.1377451-1-didi.debian@cknow.org>
References: <20250417142138.1377451-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Apr 2025 16:21:18 +0200, Diederik de Haas wrote:
> The documentation for the phy_power_off() function explicitly says
> 
>   Must be called before phy_exit().
> 
> So let's follow that instruction.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Fix function call sequence in rockchip_pcie_phy_deinit
      commit: 286ed198b899739862456f451eda884558526a9d

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

