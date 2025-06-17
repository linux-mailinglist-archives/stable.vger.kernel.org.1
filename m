Return-Path: <stable+bounces-153689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A2ADD633
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC0D19E138E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784142EF2BD;
	Tue, 17 Jun 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4z6roKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C342EF2B7;
	Tue, 17 Jun 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176771; cv=none; b=nIh4E/ndf7yNLmc8UGWLViOv3LUs4WkiFxGYnD+wev+PAi/PZtX8NcmwGHovm57A+vQeSqWbcF1EiYr5XKr5vVjLUk6q6VtqCbbQM4MbDHIsck1vxtf5qXFXYd6flZy0FxuxaCkbzye/jeoE6ziORxUAlaD2YKpchXGAIQbdSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176771; c=relaxed/simple;
	bh=DM5A2eRTmcxTIE19qhF3m6D33z16UHs6qTKugyJQ2w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt4xED4XFNRqeVuYrHIb4J5MwH5/E2aRG1WkcJRBcqirpC3A03Cgn/i0yD7LTylDcnypTcNgGBqit47dPEbSw7V4opWAGlK57PiQWSFfr2SSbb3/rGrUlH8LNpktvmLRa3upL4XHFsNdmpRnzHfoQ8p4Bq1G59MoIQ9LNsnRZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4z6roKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FE8C4CEE3;
	Tue, 17 Jun 2025 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176771;
	bh=DM5A2eRTmcxTIE19qhF3m6D33z16UHs6qTKugyJQ2w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4z6roKbwMhywwTL77T5loUaelJtP4OCpkagNFIeb62LrPr1ZtyzKhqScrcZufctQ
	 8/pzKlwaeYJBTC2TjBD5rF/V/9TKcTN+LhJP4H7BfoJVSVoulqnxuzKFm4Q3G7gbR2
	 w01sA0VWFWj2euiveFX2VHei34n4Qkjd4gNDrFJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 265/512] ARM: aspeed: Dont select SRAM
Date: Tue, 17 Jun 2025 17:23:51 +0200
Message-ID: <20250617152430.329459784@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit e4f59f873c3ffe2a0150e11115a83e2dfb671dbf ]

The ASPEED devices have SRAM, but don't require it for basic function
(or any function; there's no known users of the driver).

Fixes: 8c2ed9bcfbeb ("arm: Add Aspeed machine")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Link: https://patch.msgid.link/20250115103942.421429-1-joel@jms.id.au
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-aspeed/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 080019aa6fcd8..fcf287edd0e5e 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -2,7 +2,6 @@
 menuconfig ARCH_ASPEED
 	bool "Aspeed BMC architectures"
 	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V6 || ARCH_MULTI_V7
-	select SRAM
 	select WATCHDOG
 	select ASPEED_WATCHDOG
 	select MFD_SYSCON
-- 
2.39.5




