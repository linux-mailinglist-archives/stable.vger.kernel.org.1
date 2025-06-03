Return-Path: <stable+bounces-150760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDEACCD78
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F753A3591
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658762192E1;
	Tue,  3 Jun 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttpXiP1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240FA202F65
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977452; cv=none; b=aEZfgtjXp3CKYwrs5BffrNp/yVTBdvx+Mfl8fqy4tvZY4Lgc7xicggKoN+H+Mau5AO7j1cFL5KJnAdhTo0ByJsBqhXsHo+TepFs9fwey8ioglEoh8/dVUdJnJpwtKhawjXJIX5TV8ibrib6A2TZyN3PNc6Bwy5ZwB3pIcCnFY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977452; c=relaxed/simple;
	bh=IW/5TydU2ldlftgGa1EOtLh03qeMuKtofXvaiWOWGxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX2SBqN3JZPJ4zhoG68lS/Kn26+vc2DUo614mIzm+y6v7AUczvdciUyPz4Uecpyu1226BBMoNuZ1SiXiDyN2N6gam08UKnlyULDX8atNDcrx47/kshamprlXsE8+h+qHZUoik8qVELqZc8gjZPGrC9HMOAH0EMB/efSti5KGgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttpXiP1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22590C4CEED;
	Tue,  3 Jun 2025 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748977451;
	bh=IW/5TydU2ldlftgGa1EOtLh03qeMuKtofXvaiWOWGxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttpXiP1MBbaykAQJvMp2DBr4D0oQdN2dEpHRHWDw1JYBqZkebpcCXrArxP37/Y3KJ
	 sZx5d+JE4y3HtoeFjM6hVeZ4C/FgONUh9zTafU3gSR0L+cnap6N7ScTU4HYCHA8+Vo
	 lIQq9w0EioV5jB8tXQEo0WKbwF9x2Azi8kbViRilAvTUMD/HT/T9wcwqWAw3WeH/pz
	 uI3tgOlFwrXC+nns4zlJk5V8/XkI7UhyvIHuSP5LQVnnSKia7lXP/tX5ZOwAJGxjr6
	 /zV4vcSUxuuek2KLr/NnUuVNOyBJu8KsVmjMSVRAU4xnKvrx3VwYV56i4W/SW/pK8j
	 E/QVv9mvhvrZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jm@ti.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: dts: ti: k3-am62-main: Set eMMC clock parent to default
Date: Tue,  3 Jun 2025 15:04:09 -0400
Message-Id: <20250603134000-8bf68cc49335d979@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602222012.82867-1-jm@ti.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 3a71cdfec94436079513d9adf4b1d4f7a7edd917

Status in newer kernel trees:
6.15.y | Present (different SHA1: bbd9a9a4bdbb)
6.14.y | Present (different SHA1: 3dd5ba003449)
6.12.y | Present (different SHA1: d8fbd2030a06)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3a71cdfec9443 ! 1:  86ab474092731 arm64: dts: ti: k3-am62-main: Set eMMC clock parent to default
    @@ arch/arm64/boot/dts/ti/k3-am62-main.dtsi: sdhci0: mmc@fa10000 {
      		clock-names = "clk_ahb", "clk_xin";
     -		assigned-clocks = <&k3_clks 57 6>;
     -		assigned-clock-parents = <&k3_clks 57 8>;
    - 		bus-width = <8>;
      		mmc-ddr-1_8v;
      		mmc-hs200-1_8v;
    + 		ti,trm-icp = <0x2>;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

