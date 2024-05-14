Return-Path: <stable+bounces-44284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B58C5212
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E9C1C216D8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2A12AAD2;
	Tue, 14 May 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZVUetAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF154BFE;
	Tue, 14 May 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685448; cv=none; b=WXBGGP/7mzCDmpb1z4hNA1vJB4oS4Sb0DuR3pkDPzWrlSINFD6HzYXuM9oYqXxBxK0nPmeuyljzn/1l3blKmgPUud0Oqq1TlrcAywbowYKJWq9VSOtpvjbfH3xWiG4lV6HtwLg8Nc0Q3Ou8R+2yFSpl60quZVUXqSh2pxStsG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685448; c=relaxed/simple;
	bh=wQ//uaw1OrHat4Afy/EuKNhK5aASdKA0hOWXjFml6p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh+goeJAb5F/QJsk7idMGFp1aW6OwXF8M3HYesg8uS/d1pDuzgP0I/QE57C1nQZJKZE8ch9zdNVsKNWdX/RiCJIa67fjh9azy+S2Z3P/ol5P5zvsonMUPTjgOnd827jFT1jhL5eqeyhGe0MvsqnbQkyWqTfSYkHp4Zp0VifSTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZVUetAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4266BC32782;
	Tue, 14 May 2024 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685448;
	bh=wQ//uaw1OrHat4Afy/EuKNhK5aASdKA0hOWXjFml6p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZVUetAC+AyG26hkICqj84bB9Y6zjvBsa6XfRbEC6KXsgggBJLAwd87Sip7zDImCv
	 8N73U7SbB0YrJcoPBsObXTZxwokUZHo6llBrhnj4QLpa9L34qqidKkVKl8XXnw/hFA
	 Vi+mjG3HWfb/UjMi2hltMXalwfA5ne4LqcNlNX90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 163/301] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 14 May 2024 12:17:14 +0200
Message-ID: <20240514101038.412108454@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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
index c18b6b47384f1..94ca9d03c0949 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
 	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	return reg + gpio;
 }
-- 
2.43.0




