Return-Path: <stable+bounces-87697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9E9A9E36
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EE21C24671
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8EB199FB5;
	Tue, 22 Oct 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YDK4Tc4b"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058F152166;
	Tue, 22 Oct 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588575; cv=none; b=eoLaL0iXOtj9gKqP0OEcvAcxEUfj1Pjdn8s8g+hAjtQgMiWKMvFHW5OAhpefJZQiGDF1XDBM0JaGV8oHqWKfUVff5YoBFqKIrNAWy59QxMnfg7bYEf00Z4ul9cSraC8DJNht9YzLgHUx76s4yBmQqJ9O/YqlKvpxepocpq3hmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588575; c=relaxed/simple;
	bh=sl0NtYtcnPuoIwLlUEcbG1AzVTC9P2SfOFUZ4Si+h4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c/YmjiazH/dowJOqK/9Ge5Qe6G1bI4/0RH0z0gpUByEj4Zz7XJH4Ddd8Nsr171l+TeExGWdvUg84YaTRrF76yL0xIm5rAHfdv8hC9J1B/JbY2WvRiGza/1AkOw/gB+patIr23xtwIRtgv+LSgFk1J/rjsbyLF3jZ2Iq4W3WiF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YDK4Tc4b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588572;
	bh=sl0NtYtcnPuoIwLlUEcbG1AzVTC9P2SfOFUZ4Si+h4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YDK4Tc4b3cbrC/8wT8ngke1EKB5BDI3v0oHI7opwJdaKSdCaFbqUuWzuKgqNrFjPC
	 sTU64CYHkcFnjyYWsa/JZyQKYny/yUtslvXedOMrlxQhrbE4LzKIkjL2EVgYknucRp
	 ZQ1MMq2dWkoAfujcU5eVaTs4Yn+nI18lTrgk9sYLodduY03VqUws1sOeXIbZEHhee5
	 EJOzhR47JJUKmm+KV9s9gRux1EJRXugZTekdIy76/BN62dEa2wAECe2QAqT+RD2bK0
	 B4jp7qGJREcrIljO9HOEzLlJ8T47jEYBoR0fmCpbHB44g5dlYQxzfwby9tMIhsKz1+
	 MP8ZIjfZcc3eA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4EFFD17E1395;
	Tue, 22 Oct 2024 11:16:12 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241021140537.3049232-1-wenst@chromium.org>
References: <20241021140537.3049232-1-wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Fix GPU supply
 coupling max-spread
Message-Id: <172958857228.72613.9158406663277512408.b4-ty@collabora.com>
Date: Tue, 22 Oct 2024 11:16:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 21 Oct 2024 22:05:36 +0800, Chen-Yu Tsai wrote:
> The GPU SRAM supply is supposed to be always at least 0.1V higher than
> the GPU supply. However when the DT was upstreamed, the spread was
> incorrectly set to 0.01V.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8186-corsola: Fix GPU supply coupling max-spread
      commit: 2f1aab0cb0661d533f008e4975325080351cdfc8

Cheers,
Angelo



