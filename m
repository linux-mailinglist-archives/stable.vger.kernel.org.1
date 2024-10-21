Return-Path: <stable+bounces-87260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2757A9A641E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562361C22474
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792121F4285;
	Mon, 21 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/sZ2w8K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B531EABCE;
	Mon, 21 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507073; cv=none; b=F1vIoEzMtjMQjbC/kdlyuIdFb1gemqS4z/oBboKhNgwr+XT0YUhfp0I+Cfn2WkSGkNGqA2XMZeN82FDg7Jcg8u3gLP8LIMNUAVHJkebkl/A0YpYjTRFRSnH1xaEfTUYURxuDdv/v5/k9CQJZ3o5DIejxazq9HCJZ4O1uiJWcYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507073; c=relaxed/simple;
	bh=ZnTtR6gEnMU1uejB6AZMKeNH1ukPLhmMpVJUsqpxCJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qri/09E/F/SveURhzL7jBFO+ejp18A/x/duOVAks94Zs1Kwb1flCVxOVpgzswH+DlOczcX603ocoaZiwX/P+TmX/5/TsCdIJmgsMqivIGU/Qh//MWs3j56J5XXD9+KsegmHogpf+08gQMIvMdkMXhum/tJ0ez7g4dTggFjOUXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/sZ2w8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C670C4CEC7;
	Mon, 21 Oct 2024 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507073;
	bh=ZnTtR6gEnMU1uejB6AZMKeNH1ukPLhmMpVJUsqpxCJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/sZ2w8K6EFRm34fuOVBW2D5Ng/H7JU3LJilRiPeJuQS5fHwFs/DF8bVVFa2IT0Zm
	 1DxX6mm6B3bt9sza6VY/KPI0aywFaedcjW+2buLPWsPu6NIcb/ytitutglUeJNC64x
	 Z1ty3c3tMwkRe2dR7bfyjW9qKljJcxMOoULfPWWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 080/124] iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
Date: Mon, 21 Oct 2024 12:24:44 +0200
Message-ID: <20241021102259.826460231@linuxfoundation.org>
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

commit aa99ef68eff5bc6df4959a372ae355b3b73f9930 upstream.

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 41ff93d14f78 ("iio: light: ROHM BU27008 color sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-10-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -294,6 +294,8 @@ config ROHM_BU27008
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Enable support for the ROHM BU27008 color sensor.
 	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,



