Return-Path: <stable+bounces-119300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FFDA4259E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D5919E176C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D944824A3;
	Mon, 24 Feb 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z4xNnL+s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E284A35;
	Mon, 24 Feb 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408996; cv=none; b=giTsQk92O5Ao07t7Gw3SCH3J3Ag38WKcvVHGFa+NniYr/OprKl8NRYOJ8Xiam/rwcOwF4gDY2O2gOzo6YeRwXTpkhg0t/wRApJkYeXomoG26nHaXn6f/YCnEOq6QsPhS6fm/TvTWBdO/LGhLHIcm6mOhgXmx5bu4AqKqgI0Ccik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408996; c=relaxed/simple;
	bh=rWxLhzRe4isl779ruCRjlFT02s4h5NwjHMP9BVqyZK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw2uq/PnBFNWuMeoYv6rhGjvjiWpgNcnsYqyUhbssrHZMovCTTAjNrKnFxLSdefO6kqvss/6lHxWFxfss3cQfkqtcPd6zQEu15l9C1pCswQpPaXEmbVgZ55bv7ukFYuGoj+6FV9e2xoDGSkQhv7JVwlEnz0WymE8We8+5eedLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z4xNnL+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E359C4CED6;
	Mon, 24 Feb 2025 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408996;
	bh=rWxLhzRe4isl779ruCRjlFT02s4h5NwjHMP9BVqyZK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z4xNnL+sJBQUpYT7EDu3jXV/WCXQFwqzwVqesRX6kWaW2GxZKchwgApRlhASCStCj
	 QTS+W2EYzRBX2KAOWY7aoH4cs5cfC5W6wX59bMTYhB08gBgdlw5HfEgs9JZvi7Vp2d
	 dZXAODNRMOJ+g8w0Ai0yYEIZw4GxqoDwvwSyQo2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 067/138] platform: cznic: CZNIC_PLATFORMS should depend on ARCH_MVEBU
Date: Mon, 24 Feb 2025 15:34:57 +0100
Message-ID: <20250224142607.109673081@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit dd0f05b98925111f4530d7dab774398cdb32e9e3 ]

CZ.NIC's Turris devices are based on Marvell EBU SoCs.  Hence add a
dependency on ARCH_MVEBU, to prevent asking the user about these drivers
when configuring a kernel that cannot run on an affected CZ.NIC Turris
system.

Fixes: 992f1a3d4e88498d ("platform: cznic: Add preliminary support for Turris Omnia MCU")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/cznic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/cznic/Kconfig b/drivers/platform/cznic/Kconfig
index 49c383eb67854..13e37b49d9d01 100644
--- a/drivers/platform/cznic/Kconfig
+++ b/drivers/platform/cznic/Kconfig
@@ -6,6 +6,7 @@
 
 menuconfig CZNIC_PLATFORMS
 	bool "Platform support for CZ.NIC's Turris hardware"
+	depends on ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y here to be able to choose driver support for CZ.NIC's Turris
 	  devices. This option alone does not add any kernel code.
-- 
2.39.5




