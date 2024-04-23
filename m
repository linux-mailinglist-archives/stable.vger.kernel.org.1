Return-Path: <stable+bounces-40599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768798AE494
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178821F218C7
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75DD13C676;
	Tue, 23 Apr 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3weKF7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9813C3E8;
	Tue, 23 Apr 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872443; cv=none; b=XuCEDryy8Nv+QXSQIGU7mI1gjmavzVpRNYVzGEYXalxTAu/ehYVqo5N5IDHdwx+UzwPJYvdqZNrd489cmFFYfdaV8BCCWByI8CNFyomPbdWqLssh4uCssaOEF8rthM2UnndO2WJWdusq8BdIhWFzxTbb28lytd+TYtabYnYyxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872443; c=relaxed/simple;
	bh=KLImw8kVMJi9UQFAGXGwxIOjx3Huc7OW8+lDilCzSI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGf9sadvq8ZCDPSTW+Ai9aXLX+Vo6lvqCD1EsFJUtm2lsdPqDqZVGA3IGw7HvKwpD81Xk7M5kxA5nlbE8TXEqsXDy3StPHPBMTLGH5azWa8cDRu5EwVR7GcdR7E7YhNO93LJMS/yL8FQ3kGz53weSGeyprlQCeyuu/oE8qs2LkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3weKF7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D00CC2BD11;
	Tue, 23 Apr 2024 11:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872443;
	bh=KLImw8kVMJi9UQFAGXGwxIOjx3Huc7OW8+lDilCzSI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3weKF7UMh5soWIOGwotwaxAKOdDlEGvneJHBZJ//vuUBSTsLyuJnz0QOQTZpetK5
	 7Ol/7peADbyx0LLT2A4MBgiKi1QT7JfvIrf+OdopmEd7MDTzUKrvNQT/c8JzqEC7Nv
	 h5TEFaGJKhbh9IUCh7aiY1b++4GPLT1LH6ep1Ra9tE2KEBASlXIp+XAKvV9JxTL1TM
	 AZY7EaI6dSSrME29QiJXhu6/lhJAzLW3KjfaDuKdSClP4mrgrpy+R0djPGbH5iQkMt
	 i9khxW9qCC+wIgbCpQ7VXegyctx/UP8AVghewbTN3BDArjKG+NaRcpoaL3EZ3kuewS
	 ip9jTkxSUqm4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/16] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:01:40 -0400
Message-ID: <20240423110151.1658546-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit ace0ebe5c98d66889f19e0f30e2518d0c58d0e04 ]

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-crystalcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 1ee62cd58582b..25db014494a4d 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -92,7 +92,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
-- 
2.43.0


