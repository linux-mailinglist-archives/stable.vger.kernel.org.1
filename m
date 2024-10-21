Return-Path: <stable+bounces-87251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE079A6417
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1CF1C2231A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305311F426B;
	Mon, 21 Oct 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IULPxUsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6451EB9E1;
	Mon, 21 Oct 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507047; cv=none; b=oAZcu6Qf5Pf9mud+ZLOPBZHgwh6kgYwMGTIleqUzz6KAsarPA/oyEJqpgz6zf4TvwImV/g2hYUQ7Ud1kudDD5yUF/g5YFmYj3qF5YcEIQ5OPQSf2QUXqCN3NDjM9Tg3tdQOgUtYi5A4rGe22EVJSDQX5NciwHB5DxmG8wXsg88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507047; c=relaxed/simple;
	bh=rkSsQQjiGqP8Z4JTtGIz2DVkXRi7eqmTvvB6TsBi3VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfkWV0iLluFm6TiRrb/7s0UZ/FKeMvqnkZrdSGtr/jImQtzq3bokSIeP4DHOdoRMnAHZIZGtjzK8mzW/MAo4p9Ilew0822hqLPQu8ImAUI0mi/YmhPAZRmXkWoujHwmyXszgJ+4AQmy43om4xO9Y2JiGr1C6+SANtNll0LxbMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IULPxUsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2203DC4CEC3;
	Mon, 21 Oct 2024 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507046;
	bh=rkSsQQjiGqP8Z4JTtGIz2DVkXRi7eqmTvvB6TsBi3VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IULPxUsN7PZSiZm9+AuwVnOb0aaAoYdXbF75x72fAD16cS16z8IWW44f1N85/YZgG
	 wE++8pVMp1OtoYTkKuFN9h87j64kea51chu/ObJHgrvnZxa8jh4XeSzYD+1zCXixfL
	 ZOOWjxeAjopS1JyTOUYeixVRXeSIkYo5drBkO+ck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 072/124] iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
Date: Mon, 21 Oct 2024 12:24:36 +0200
Message-ID: <20241021102259.519205561@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 27b6aa68a68105086aef9f0cb541cd688e5edea8 upstream.

This driver makes use of regmap_mmio, but does not select the required
module.
Add the missing 'select REGMAP_MMIO'.

Fixes: 4d4b30526eb8 ("iio: dac: add support for stm32 DAC")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-8-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -426,6 +426,7 @@ config STM32_DAC
 
 config STM32_DAC_CORE
 	tristate
+	select REGMAP_MMIO
 
 config TI_DAC082S085
 	tristate "Texas Instruments 8/10/12-bit 2/4-channel DAC driver"



