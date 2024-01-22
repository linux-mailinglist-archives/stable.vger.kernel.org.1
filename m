Return-Path: <stable+bounces-14020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D306D837F2C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E811C233AC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F01292E8;
	Tue, 23 Jan 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b0H3+adj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D451292DF;
	Tue, 23 Jan 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970981; cv=none; b=oAJzUQ94JerwNC+MdROmH14716lbGdvWQ4T+3aIsk4EWV08PvQ/Tk8n+ZgD+AzZiYZPT5xZkDwGI+8t0pXBHTUUITFwFKSslPKMGR3pqpgyNgGUc6YcIphY0Ja6ibXHyouL1z6s8TasrXu20sGboA4+UaCBuBewUSZer8BN6xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970981; c=relaxed/simple;
	bh=V8asHHJMbDw+IJmIOxjRygwUycjLMyRBL5CF2lA3pLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOnpq512b4g4dCk2xbGyLRktp7xhWG0IA3ZjPG5KpEAGoIdefnJ/6D0ExZ98QxDfHRQaVAFlIcdkWmwDQqqYEhCPIGLLDt24olL6RzSovreNO3bAB2xWPY4S35gl5Rk40EUo536NFd/Q+rFm9ZJ6gyHyPMkOK9UGH3/BviqfZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b0H3+adj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD688C43390;
	Tue, 23 Jan 2024 00:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970981;
	bh=V8asHHJMbDw+IJmIOxjRygwUycjLMyRBL5CF2lA3pLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0H3+adj44wKT5haRTyzi71QkthQ7WsSJrNucn4BNp79W528JZ8cAhO34+HrrhyIf
	 y+vCGbKZ5nADQePe/nvomajWictAQXn2yckgRAaKkOdXm2EUtLdaaFubP43e0yujLF
	 XeEKkL6lwZVwI+Otnig2XT6sdxPPH3OrKuOuq4AU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 155/417] ARM: davinci: always select CONFIG_CPU_ARM926T
Date: Mon, 22 Jan 2024 15:55:23 -0800
Message-ID: <20240122235757.207958208@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 40974ee421b4d1fc74ac733d86899ce1b83d8f65 ]

The select was lost by accident during the multiplatform conversion.
Any davinci-only

arm-linux-gnueabi-ld: arch/arm/mach-davinci/sleep.o: in function `CACHE_FLUSH':
(.text+0x168): undefined reference to `arm926_flush_kern_cache_all'

Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20240108110055.1531153-1-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index c8cbd9a30791..0b54ca56555b 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_DAVINCI
 	bool "TI DaVinci"
 	depends on ARCH_MULTI_V5
 	depends on CPU_LITTLE_ENDIAN
+	select CPU_ARM926T
 	select DAVINCI_TIMER
 	select ZONE_DMA
 	select PM_GENERIC_DOMAINS if PM
-- 
2.43.0




