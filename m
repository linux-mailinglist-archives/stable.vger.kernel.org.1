Return-Path: <stable+bounces-116410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DFFA35E2D
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5660F7A48FF
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40770264A7B;
	Fri, 14 Feb 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATtEvCIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF48263C62;
	Fri, 14 Feb 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537941; cv=none; b=DMGyxQZGmgMmQwmiRjfjd9GzoeJZ7FakuNTtJi9nDuSi49noIh81/lzvYdPwmRp6Tl0c5V4l/R9JxCHJ3oG2Oc35aYl+BQVxuSuKRmQJ35dAvasPVOlXsJjJIzH7uqmTu6n20Vpnc02SgIOqFB+ug50JvcWA3JcIO1ls8S2XnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537941; c=relaxed/simple;
	bh=h6D49r1ItgNgeLQ5sQSietMLZJjMNj0FrXN962iqeCs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JQmc8r5Cliy9fMc/29tFzbnayxKTk/g15wgQSepBmXNrFhGvlP/nYCzPp/SleNEpVWxCEryGOudE7v6+rEwMcoGsma83JaN38eKoav7+TM5tUcDw/R/or3aBun28wzS412G/A9sLLCcdAGyRUAdGV9J4PtnwUo8WvYT/DyGnG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATtEvCIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADC0C4CED1;
	Fri, 14 Feb 2025 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739537940;
	bh=h6D49r1ItgNgeLQ5sQSietMLZJjMNj0FrXN962iqeCs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ATtEvCIaXYrfO3mZ0U1GWbogbs10zRN1Tz7ux38J7RX5bYAdD4G7UAH5Y+71LSRLO
	 QZAso7lAUoiVKCETlCh9ri2uHqrMGbEegOxUgrRrXF4r/1/st5qLWAdi/KmU1Q3ogj
	 H7ihrDOncuCVBQRjq/oslW02XAFdtoCATjo7EToDrBKyNCW/+eWbmJ3XeKPcqlRP8j
	 VKL6bWlCziTfFZ+8lHtV8rt4Njk9azohBJjJ2gSgXFmvIIq9g+CqYo8KXW0Ky0kPJe
	 FUm/Pv/ndT5TQwYOeIN2IHhmKHxJyrscOk9tjEaIZBdrw0D09wkQlQGU6v4lR0XF0o
	 n5Nycc0aEd8GQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241205-gs101-usb-phy-fix-v4-1-0278809fb810@linaro.org>
References: <20241205-gs101-usb-phy-fix-v4-1-0278809fb810@linaro.org>
Subject: Re: [PATCH v4] phy: exynos5-usbdrd: gs101: ensure power is gated
 to SS phy in phy_exit()
Message-Id: <173953793587.323038.14073970116035091802.b4-ty@kernel.org>
Date: Fri, 14 Feb 2025 18:28:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 05 Dec 2024 10:22:00 +0000, André Draszik wrote:
> We currently don't gate the power to the SS phy in phy_exit().
> 
> Shuffle the code slightly to ensure the power is gated to the SS phy as
> well.
> 
> 

Applied, thanks!

[1/1] phy: exynos5-usbdrd: gs101: ensure power is gated to SS phy in phy_exit()
      commit: 8789b4296aa796f658a19cac7d27365012893de1

Best regards,
-- 
~Vinod



