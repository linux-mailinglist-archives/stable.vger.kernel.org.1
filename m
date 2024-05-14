Return-Path: <stable+bounces-44751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA38C543A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A01F23381
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0F13A252;
	Tue, 14 May 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwXwCHM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61432139D1C;
	Tue, 14 May 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687071; cv=none; b=hukKQdOuVPojFWhEYI7In+jfpW9gRYsFSfJ4VQYbeUk+cfMsV2A817szDYR7B+ofA6G3UtaezOIECSNKhv0TV3YHwa9KaEwDFRLY8aitUw/l52hGyNGqWMvDfasKDdvQEvjQtpfhMX46oxeii1gMb9FY0QtTS99oBMAQn/9uugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687071; c=relaxed/simple;
	bh=vNAMZlTaoOgqFtVxlXwuIhGpTCzNSwlTusdbt0o6faE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3ElT8TX1cjVn2ba6qAL8Lm4ArWDjVnP7kNvTZVw/Tk2XLkPzz20WavuSREDBL3PfIUKOTVm3Pr5OhEh8UCtrQWiFUcmjOoaSf1vbCbL9Gwj/avgx5+MMDuoL1jjtSk0KkH91ceYU8MsR2xSsKekucqr50jwoaWW+UCp/KFm/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwXwCHM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F02DC2BD10;
	Tue, 14 May 2024 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687070;
	bh=vNAMZlTaoOgqFtVxlXwuIhGpTCzNSwlTusdbt0o6faE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwXwCHM8cRO5vbF8PsA1BE3sGFMYI2Js9b97iwtpOzmlU33YsP9kkA/60ZnJVXR1t
	 LPZRTZ+4fFnan+AcuWs0s+Vd0ujkY+jQU/sXQIDfU18/c27MYviAWzmxMjuY+NwHm5
	 +G2zvBqDd8P6WFeFLqk3tKmYRr5FYgcN/baEdSp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 54/84] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 14 May 2024 12:20:05 +0200
Message-ID: <20240514100953.718012595@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0c3b532ad3fbf82884a2e7e83e37c7dcdd4d1d99 ]

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 444fe9e7f04ac..79946c098271a 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -102,7 +102,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 	unsigned int reg;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	if (reg_type == CTRL_IN)
 		reg = GPIO_IN_CTRL_BASE + gpio;
-- 
2.43.0




