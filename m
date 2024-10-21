Return-Path: <stable+bounces-87131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE2F9A6358
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0A01F20C73
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31F3A1CD;
	Mon, 21 Oct 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cKZU7D1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6A1E5707;
	Mon, 21 Oct 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506687; cv=none; b=jCUesg1RCiIr9WmgQB8vHGzHuz/5O9kmVKgx8TeQXYjMmGzdrA0yRuSovmeyuuxhVAhnjmhfmJPRASsPlbO8/FSSlVPG92hcb9gqEki+qMAZYZAcYgg04FG4w5Nj4euvy83VjIGvRDSd71x1BLYvnrlRKJLHykEs/pnQXOkTzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506687; c=relaxed/simple;
	bh=Ql1NbfNjR80TOJLOnmInIb0fvLjxul3fWYNgoJW8gqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NE9jcGxpDwnv4Z1eHjRNRO0qkiaNL4dVrDw3X1XBxNvsMJc2PZzJxKS+2CymeiCFGM2HqQsaHXZsmg1BVmx1HuSg+3Gh4lBosM87J9xn/3fKkHsxHOQkjtCnHDinIV3/yFE7g7+0AAq9WRxV78HdNb1LpKy1nYjmEoa+ZEeM32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cKZU7D1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B9EC4CEC3;
	Mon, 21 Oct 2024 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506686;
	bh=Ql1NbfNjR80TOJLOnmInIb0fvLjxul3fWYNgoJW8gqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKZU7D1RKWi9JYslgy4v9QfYDnzZnO4+kpcvIu6NPk5D2xgMvWNgl/dVj72fVbFhp
	 cL++oN55Fq9w/PW7m1OvESwntWMjHmCgjfGgEhfI7XFTu3SCg1fjT/EGnP7JcXphwu
	 mpiFJckdIC3TRwQBE1hG/eUOCzkaGis6jY7syJaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.11 070/135] iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
Date: Mon, 21 Oct 2024 12:23:46 +0200
Message-ID: <20241021102302.069562388@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit bcdab6f74c91cda19714354fd4e9e3ef3c9a78b3 upstream.

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-6-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -262,6 +262,7 @@ config AD5766
 config AD5770R
 	tristate "Analog Devices AD5770R IDAC driver"
 	depends on SPI_MASTER
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices AD5770R Digital to
 	  Analog Converter.



