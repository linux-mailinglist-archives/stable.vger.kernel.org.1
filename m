Return-Path: <stable+bounces-177592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE371B41996
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31A73A5376
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB42ECD3F;
	Wed,  3 Sep 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHzxVUEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C12E7BBC;
	Wed,  3 Sep 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890568; cv=none; b=SI8dVmWPaHuiXYrjWHbM29TS/tjXEzIWugRLrlcLdgDTl95/qossuLBd9xdhPYr6yhPPYP+nS+sFLZlLI4hfUA8coehvXVqnAk/NaNA6CnrxXIJg46qG/mmNxobIVioGnnCWmTpkikiL6XMMvwqFe2mh2LthWRmlosfXORxkTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890568; c=relaxed/simple;
	bh=aaP//DKoTyXw9b8rEWxNVUG0MySjvFrbnX2ldK/9x0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp5HQgkmJFizER0YRFq8GMLjWQQMkollE6/AV0Ow09azyETdvHkahoc1iouyj44QHEXyVGY66UFA9J875RMPd1w4lGCRsALikjQr0jCkCFxQ35AUYGo+Ovzjb+q6Q0vzvUe1hwS4w7mux4dZ349hJIe02EWTt6vnF/oqulxzmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHzxVUEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA8BC4CEF0;
	Wed,  3 Sep 2025 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756890567;
	bh=aaP//DKoTyXw9b8rEWxNVUG0MySjvFrbnX2ldK/9x0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHzxVUEcYuKnulw79ljez7oeIjUJNNWNO7i528aKEPlAl1ntv9ggYy+XnTmo/exA2
	 KD0r8/E3XdmFS+7VE0JbmOE/xOVelb93O6LJMw4hC4XM8Hr8aD3nNJ2tsRUvK+OEKu
	 4cTIHW801CPMzmNxrI2HXBvNJr6SVKAkVXQEC9eV+mfxGkHfpzBtSZE/swbSyfmm6c
	 uXqZV4Tu8n7sQXCOHDZM+y+BJ8Oftf8VbMU6qAj4OxqxsUAWmkUpnvm7dbirnXWPyV
	 jQm1jZJ8rI9Mc/JCdLTVJm8USFnuyPYwIDGM/u33ik6coOnlxV6tKZ1KOMWjRVCxHn
	 7o0XhIH0JnHyg==
Date: Wed, 3 Sep 2025 10:09:22 +0100
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and GPIO due for the v6.18
 merge window
Message-ID: <20250903090922.GE2163762@google.com>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>

Enjoy!

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-v6.18

for you to fetch changes up to b7fe89d2ea0dc9c823b103ad982f97a00d50e04c:

  mfd: aat2870: Add GPIOLIB_LEGACY dependency (2025-09-03 09:08:48 +0100)

----------------------------------------------------------------
Immutable branch between MFD and GPIO due for the v6.18 merge window

----------------------------------------------------------------
Arnd Bergmann (2):
      mfd: si476x: Add GPIOLIB_LEGACY dependency
      mfd: aat2870: Add GPIOLIB_LEGACY dependency

 drivers/mfd/Kconfig      | 2 ++
 sound/soc/codecs/Kconfig | 1 +
 2 files changed, 3 insertions(+)

-- 
Lee Jones [李琼斯]

