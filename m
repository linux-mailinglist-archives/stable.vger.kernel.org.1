Return-Path: <stable+bounces-134687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E9A94337
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B814C7B0174
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4491D54FE;
	Sat, 19 Apr 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAGNx5e4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81318DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063239; cv=none; b=gr3cjeFj58NkDdFcXs136JW7TAgWrJxupoEii9MPkPaYpkCviXrjukKyvWjPpo9nZByceBoiCvgVsCo5jLSbb+vnaNpILMq+UL7yXqN01azBVTkNeO4nZ+4NLfbWlFmPDwa4DY5Mn4EB7+OgyZ5qS+75zxMufkty14GUXnNg9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063239; c=relaxed/simple;
	bh=yKwf5buYKJRGe9vRrCDY3yp8xbOUnjCo7U/ekFjGrWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc8cB8Ljllw68ZYRCNJ2IFt6SEALge3PEL+regdrvZWGHaTNHfW/VV67vEcpQM722sOFOM5nVoh8ppK1CM+1G8V6UiH1Z3zsKP8w5G8pfLmoeROuY72xFeetKeYHEUf+1DHM4UUa+ki8ZXqyWXp18mVtxQB87E19c26seuWTpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAGNx5e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A0EC4CEE7;
	Sat, 19 Apr 2025 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063239;
	bh=yKwf5buYKJRGe9vRrCDY3yp8xbOUnjCo7U/ekFjGrWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAGNx5e475mIxTj4h/Ynl8A9cQQ1Vf1XsNtWuKpleLym7TzMa7qMyuYcysJFCTV6x
	 ewAxeqQqR1FZjiIyYeRe5G3D/7KF4vu4AU5JX7ZMkdsrwAq8gz/m6GsHosmHRxolf6
	 UU0t1cb8C0s27r4GMv+FLrqvH/ld4iZvqnuEK/J+U0UrDmnPbVv8AB+psb60K/ib6B
	 mqsPOmX33gVgZ6YNcZu7UeKHoRL/DA4UtMp3XlHyiiH9+QHXLiQ61TgvSnyP3YBuUp
	 dAloYw7PkMb+2eLZ7t0ig2lgKu9FIJREmlvwo9oEpqBuGehry6LtYoXG/M1QDTq75f
	 W65eFbtv7+ZBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:47:17 -0400
Message-Id: <20250418160743-a6c7e42f1065cec9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120540.2019525-1-hayashi.kunihiko@socionext.com>
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

Found matching upstream commit: f6cb7828c8e17520d4f5afb416515d3fae1af9a9

Status in newer kernel trees:
6.14.y | Present (different SHA1: 501ef7ee1f76)
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  ca27160c463e2 misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

