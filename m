Return-Path: <stable+bounces-53831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B181190E92C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C951E1C22728
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4F139CE9;
	Wed, 19 Jun 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuu3dwIU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9480BF2;
	Wed, 19 Jun 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796043; cv=none; b=k/+nhby8V6nCLJ60n7Vsuo3PypvQLtDb3zvkR0e1EEgIk8aWg6XunNYLbHnGFUfYHvcHh1s0c760zSwN/GLdyEeJpxGGKyCBd1lgsuCtUzRxOtDzfsxG0iI6FPF8c4Zo19pZoSyVoxucJKij6MEWkuLWZ54lS8BG/aimDOCOKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796043; c=relaxed/simple;
	bh=XScUQ9xKv3viE4nGItvwHd/wPr1+lIosTNq6JX2Fov4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMS1LPBfj2xylk7GMBo60yvpRE9C6cZJsw7ZS15FDCvNIuqNjMxhTF4neuOdlhpN/RsS0VkJ10sN4y3lG4eNSi6Jh5pd3JGvq3XoZQOokw3ka8bI8edTVvkHhmJBg/OHZIjHY9STZqGvCQhsXRgVtX/IvYmU2TU0E6b8ZwngO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuu3dwIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BB0C2BBFC;
	Wed, 19 Jun 2024 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718796042;
	bh=XScUQ9xKv3viE4nGItvwHd/wPr1+lIosTNq6JX2Fov4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xuu3dwIU1BinnJ0NQFA2MRNMzhgQeHidolw/WeXaf55AsYFKLjzAIBZoBzXKfVpnc
	 ytL6xowDO6phB2Dqjvv2M4zyp2a7FDq4M9/nVIgI4p8h8a9w0P9ouAtYJhi3OWOch5
	 6jvwKZwLQZ8dLyEY8yW5P6MCZeUUiagXUuCKOsf6kbKRhu1cES0vTbr/HJ9GmYPBKa
	 v5cG1Jl6R5j60PYFV4MQM0r3sDsCZHVTMqceJyuPynHLMsnHzDdqjYT77Fq6/7zzmO
	 c9cWxVEqKGz47edpxEpTIsOd7+C+9u9ikCuP+Aj7B9RUZ1+6m2crg2js2EzTNrqZ+c
	 knPVb6CpS49Yw==
From: Conor Dooley <conor@kernel.org>
To: kernel@esmil.dk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	william.qiu@starfivetech.com,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Shengyu Qu <wiagn233@outlook.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards
Date: Wed, 19 Jun 2024 12:20:00 +0100
Message-ID: <20240619-slicer-embolism-1d74656749ab@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References:  <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=hyxqrF+zdFDORBV9MQKebE44wmRMdbJxx9CDCqJHNeA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlF+x4Ybd5Uqy4eu9LcKC/4zYp3bdlNki9sdDXO/N5Z3 bDk+iTRjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkyn6G/5l6YcZ5l16rds5t +S08Y+eN9RHidrNmn47ddUz1zVWZN/sZGbZ71ASfu/rC19dpBfP1w2L/nm0JujH7fXD7kg/lKU8 /OXICAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 12 Jun 2024 18:33:31 +0800, Shengyu Qu wrote:
> Currently, for JH7110 boards with EMMC slot, vqmmc voltage for EMMC is
> fixed to 1.8V, while the spec needs it to be 3.3V on low speed mode and
> should support switching to 1.8V when using higher speed mode. Since
> there are no other peripherals using the same voltage source of EMMC's
> vqmmc(ALDO4) on every board currently supported by mainline kernel,
> regulator-max-microvolt of ALDO4 should be set to 3.3V.
> 
> [...]

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards
      https://git.kernel.org/conor/c/3c1f81a1b554

I was kinda holding out for a response for Emil, but I've applied this cos
I'd like to get a fixes PR sent out later this week.

Thanks,
Conor.

