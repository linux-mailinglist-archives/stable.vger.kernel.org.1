Return-Path: <stable+bounces-177616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0357B42023
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1FC7BAD21
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9C02FF14E;
	Wed,  3 Sep 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwIWfSKR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE72741DA;
	Wed,  3 Sep 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904130; cv=none; b=LDNBZgxryvqNjX31ZY96RnnL0pxASSXRq0rHkD5zzRtEAnGKi12iE0t44jaMGsPyUzakpC02CepSGelXgAeoIPlrYvED0+q/EO/eQrXrVb6F7f9ekNnzHCTdWyoeb/xs2XsbVHSeVLor1gxcCJu55fCKizimodaRgz9uqDtDc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904130; c=relaxed/simple;
	bh=BhWff4LgXnXlgt+WyYgGJOYpISIrkJaU/yaLsUYKaj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDuP44CcgxkBZVtCPkwFcDgGDL7joY2DmGZbf4+5ULAQcDZg8H6S+ZjlmMLytO3V6K/DWNuUsFamzPooO+byqHt3/wVhTuHcB73Ev/PYiptJzQ7i/cOhIbCLLQHyxyOXY0GSV4xew9cLXSQ5iP/Z91L8v2YKR0ebPhdGcw7H+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwIWfSKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88660C4CEF0;
	Wed,  3 Sep 2025 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756904129;
	bh=BhWff4LgXnXlgt+WyYgGJOYpISIrkJaU/yaLsUYKaj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwIWfSKRaQkema1FW9jA7Mr7A32Nx66R0pHZKTk/sZEEnU8TfB40srHxVK6reVAyw
	 lsXugAmtCeMDAYggCNIlBTW3DguBZsYAZ3uwBO4ZpFdbf86k4PHn0xqgnH2hnI2fEc
	 9JZYMGEunXBn3BiMqqmGu3+4F4KOd8YenWK9LQPxv0FHgch1q3lQFVwZyBxixm949h
	 8ruMxxjFf+Gz9r0EzbYrGPlFwHzJwA9lxCsB0WnLbg7yd9z3ydXpDpJbX8ZKYXdnFk
	 j6XzWIqcvRTOI2IdCYt4H+QxbhKT+gDxSLF7j44u/cUHBdrI3ttLPUPjmd3LCKoVhp
	 pV7JpJJ0wxGgQ==
Date: Wed, 3 Sep 2025 13:55:24 +0100
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
Subject: [GIT PULL v2] Immutable branch between MFD and GPIO due for the
 v6.18 merge window
Message-ID: <20250903125524.GP2163762@google.com>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
 <20250903090922.GE2163762@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903090922.GE2163762@google.com>

This time with the correct commits!

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-v6.18

for you to fetch changes up to 9b33bbc084accb4ebde3c6888758b31e3bdf1c57:

  mfd: vexpress-sysreg: Use new generic GPIO chip API (2025-09-03 12:45:33 +0100)

----------------------------------------------------------------
Immutable branch between MFD and GPIO due for the v6.18 merge window

----------------------------------------------------------------
Bartosz Golaszewski (2):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      mfd: vexpress-sysreg: Use new generic GPIO chip API

 drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
Lee Jones [李琼斯]

