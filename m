Return-Path: <stable+bounces-134917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B096A95B2C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C66B3A962C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED11A2C11;
	Tue, 22 Apr 2025 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAJdgTPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49342397BE;
	Tue, 22 Apr 2025 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288185; cv=none; b=LOllEG60vRcLec/L91fZ1RNu1qll5DE+s8Oicp8gLibd8bcHCKbOjiOdCh/q/eEMNR0CHTyWzltpNnktC1nV/J6iurK40XKEuPH5Pl1fk7JCe038l4A5ZhiUag392TgvMF81q3vWVlaRKyW4E5AiIABrfJVAvorEQG7lTpFk1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288185; c=relaxed/simple;
	bh=0238oT80ZRbDUPcDv23xV+rQAWCGsjssH4Cychfl15Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWUbnZcyuYoTB7gm5Pzq5FWGM+RwDDpJl0jKgzJUxHy0ovWgxz241lgrkCfA98U5h9dBZ37Nup4Gt/NnZqz6d+pSTEJ3PKcAlhYubBg3NXBTzEz650ic2PvTdUb0Y78nQUvAn0Vwp4/FFfhVXSrU531Q8Um8o5NM2/0/atwX6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAJdgTPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AED8C4CEE4;
	Tue, 22 Apr 2025 02:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288185;
	bh=0238oT80ZRbDUPcDv23xV+rQAWCGsjssH4Cychfl15Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAJdgTPgK18vDD0lpWULXcrgp4KStFYJaC0XT3INz3fgTKtfuu5DxxyLaW881IBdc
	 QgOYYtgtpL0ej4DrK+GeG8rQ/Iu+dlosWmGzFtWSYUAb68uGa0Kfmib+pFU+XaqukV
	 oIZ0VF4cjVHZEcuA/c/HyT+fDlvYqySi4a8QIZUybQTwAQHkH/YMV06CHH4fYFnH2o
	 KrUpI+z0bCdO5sBNNgsb5YXok6PFI+6RWouiCZTEVzM3vBK5Yjd3N45eestCUciNsr
	 8eTQM6RrmezqoRJe1vL3BzcJEIgoJig4tlUleHsWooco8VBtqmp88Rj9E9YbE6mvcx
	 ehC+mRQ9ww4Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mic@digikod.net,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 19/30] hardening: Disable GCC randstruct for COMPILE_TEST
Date: Mon, 21 Apr 2025 22:15:39 -0400
Message-Id: <20250422021550.1940809-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit f5c68a4e84f9feca3be578199ec648b676db2030 ]

There is a GCC crash bug in the randstruct for latest GCC versions that
is being tickled by landlock[1]. Temporarily disable GCC randstruct for
COMPILE_TEST builds to unbreak CI systems for the coming -rc2. This can
be restored once the bug is fixed.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/ [1]
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250409151154.work.872-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/Kconfig.hardening | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index b56e001e0c6a9..10be745c13ba5 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -311,7 +311,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if COMPILE_TEST && CC_HAS_RANDSTRUCT
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
-- 
2.39.5


