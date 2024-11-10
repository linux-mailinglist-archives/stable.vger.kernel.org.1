Return-Path: <stable+bounces-92038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB29C3162
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0EAB210B2
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFBD1527B1;
	Sun, 10 Nov 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLB48SLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99214A624;
	Sun, 10 Nov 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731228060; cv=none; b=hxa5mQVeHMzliOH7NJcLiEcQNuSt1ddEUdJAjsDeS3Aco/eaGx24UtDEUCCNYW/mTb2VPbVkO568wbHH5qdXldhcEpzvWz6yhUtOaOU3ZIOa6CPOtACyDn+9zQ3ET11IC48W7VcK2oNfgoCqcZsk09qTaNsPpeqM8cIXnVWFg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731228060; c=relaxed/simple;
	bh=XHpF6g9TuwAK/W3q4RtoekD7zC117/f/yfx6R0MdJ4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcvQ4bZsrmmyajfMS8boGjqkMm0s6afAAlG5rS1tVWdlXlEFSb3mYAQPLrYe0shl+farq3+ABKpt8Rof84u2/8RCsIu2BW4KzRpenxY7b56mUkBJL1kEdqORc1A6SfBj+VyH6SDGJy2BVaB4s0eAW27ajLhNovHrq3mI8XRdVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLB48SLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1834C4CECD;
	Sun, 10 Nov 2024 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731228060;
	bh=XHpF6g9TuwAK/W3q4RtoekD7zC117/f/yfx6R0MdJ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLB48SLKKv0Dcg3qDNxI7nGRi/3pSZN1FpGn4YSR15aeQDTEIsGGyi6MUwnhOcJkc
	 c1kI0pctXnjnU2M4/3VW29qUrFkSQlt9hV5y8Nwc3EVChAObK8+uE+huODKks17K/Q
	 dqGQkSWGlgRweJwWFvplRIuQSJFI/TBEDgFhqgtqpOez4zOaOyR4Tb12GI32I5oHJy
	 hatuNk+/M4X2THnAc1mx8ZKQ3eoM5I4vl9/GDUkYCMWiMpPaXB3Xkp129eZG+trL6w
	 dtc3NPGJx3sPN1EhFnjSorztifOOH9V0t/sAB5ecthUno8rAd3s2AueASaVHmltxnn
	 4UyID6w8p3Crg==
Received: by wens.tw (Postfix, from userid 1000)
	id 6DF9F5FC24; Sun, 10 Nov 2024 16:40:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer
Date: Sun, 10 Nov 2024 16:40:53 +0800
Message-Id: <173122798221.3483730.11740779803275328915.b4-ty@csie.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
References: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On Thu, 19 Sep 2024 21:15:26 +0200, Dragan Simic wrote:
> The way InvenSense MPU-6050 accelerometer is mounted on the user-facing side
> of the Pine64 PinePhone mainboard, which makes it rotated 90 degrees counter-
> clockwise, [1] requires the accelerometer's x- and y-axis to be swapped, and
> the direction of the accelerometer's y-axis to be inverted.
> 
> Rectify this by adding a mount-matrix to the accelerometer definition in the
> Pine64 PinePhone dtsi file.
> 
> [...]

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!
Helped-by tags were replaced with Suggested-by, as requested.

[1/1] arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer
      commit: 2496b2aaacf137250f4ca449f465e2cadaabb0e8

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>

