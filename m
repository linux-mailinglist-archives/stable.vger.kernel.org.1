Return-Path: <stable+bounces-63296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD294187E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1B6B2A3FE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BF183CD5;
	Tue, 30 Jul 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPKm10oz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155111A6185;
	Tue, 30 Jul 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356368; cv=none; b=DP9sffcxPjp1u8rGwVCmJKWB0Hmh+8Jf8tD8E8761esVIRaEq+xNFpOEB4D/M393qWdEOhWeQNsL/mIYCi8sujSFaJql66fNshsNbOOobXVq4xFZwjaOcE47ulQOXqf5esQRri6W2OXsk9MFj3d///JAteEc3mDZgFF9cEbkVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356368; c=relaxed/simple;
	bh=bZbyC0wtKdqY6ne5b3V/pY4Whr/4Y5nFzkTWgHPWsrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPMBEL8/hnXP4lKO3uVeqrCyvxJdSdVMDO8qhds0F7bTOgZfNXgmdWin+dPxfJcY3fH+inj3BZva9JsmzJPRnxzSkVRa2NQ5ukfRO/pM+OXI1qhKN1Q0AKpKbN+JkdC2az33qXoySNhMsDM1b5J6GqHO2N4uKbXlVIeHT2r5Aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPKm10oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7248FC32782;
	Tue, 30 Jul 2024 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356367;
	bh=bZbyC0wtKdqY6ne5b3V/pY4Whr/4Y5nFzkTWgHPWsrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPKm10ozJFlAHR2VNxcZJItXXZmm9Qc4MugDp8v7q/QfAQpLdSZOQVaQHGI1s8IZN
	 a62hWpSCJTFEAsPj2gpk2OarAQnrtdnWX9aP4FGcz4dNWAUD8LyGEpVeiLeh6EY8gn
	 g1yvFUA67jCFGls5LTcynwsQbakPl5FB1DaW3Y0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 185/440] iio: frequency: adrf6780: rm clk provider include
Date: Tue, 30 Jul 2024 17:46:58 +0200
Message-ID: <20240730151623.100178671@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit e2261b4a4de2804698935eb44f98dc897e1c44c3 ]

The driver has no clock provider implementation, therefore remove the
include.

Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Link: https://lore.kernel.org/r/20240530092835.36892-1-antoniu.miclaus@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/frequency/adrf6780.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index b4defb82f37e3..3f46032c92752 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -9,7 +9,6 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/iio.h>
-- 
2.43.0




