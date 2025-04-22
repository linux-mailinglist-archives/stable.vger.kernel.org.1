Return-Path: <stable+bounces-134944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA0A95B7F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF06176865
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069A25DD1C;
	Tue, 22 Apr 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N09J6kBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4025DD10;
	Tue, 22 Apr 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288250; cv=none; b=K6fQQxb9ULXyRIx1zOZgL4aDBKHzZGS6yUCThWZB8V9GO1igIPRWymAwg4FYTMO4hHetAerGO3RZqSjqUdd//Usw6ZyJN58JAcPxkyTWmwjNJTwXDDV8sBnbMzrTviOliuuZnnT3CnsLKAIf/hH2aId91ugUp8dCPT45UpgUv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288250; c=relaxed/simple;
	bh=/+VZRm3/buXWZ1BaneQ7NrztphF6dAQs1rQhAbV6Ct4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J79J3l7/rpX50xyce81tSbpJgsK3Khu+fhhOlG76KU4hOnqEvGq1BHZRClMJFOn0Lu6h3DKt4lvWd3enHHBQCNkxxSxEv8BoUOpMSrWRbC4NBg4RG6qfvYWR1dn6roP2vchvCstyXHPUqbfLSY0oOFpwHLZPf/fRVTNUXzAzxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N09J6kBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F72C4CEE4;
	Tue, 22 Apr 2025 02:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288250;
	bh=/+VZRm3/buXWZ1BaneQ7NrztphF6dAQs1rQhAbV6Ct4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N09J6kBQWcRC9Ap0OGyWk/7PpXPGqP3TVrmVOr/feivl0wdt5S326vIvuFmzJCOEX
	 Qox3rONZBTs8EroItfyM1i9osZ63MEVYVMLufZlNnurkuVF8j05DryuLX95FBDiLrn
	 XlzxAEuU02OCfgUWC/Ouek61DEH2dobgonKN7m+w63gUJds3pQWLbSUYRoqEtDithm
	 UWnGYtl4DoNgceB0Yy8iwy7pJ9KkRDOefC5H4kI1wKIbZ2zsS9m3YLYRuRNlMTFOgm
	 pmSkvrAYZVyCtEVXiVeLiEa/pY1vtlktqg1zIwYgMWYLGeKpmeSYijeG7WzVMiL0PZ
	 Hj+0+ThVI6BPw==
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
Subject: [PATCH AUTOSEL 6.12 16/23] hardening: Disable GCC randstruct for COMPILE_TEST
Date: Mon, 21 Apr 2025 22:16:56 -0400
Message-Id: <20250422021703.1941244-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
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
index c9d5ca3d8d08d..2b219bc26fe56 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -310,7 +310,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if COMPILE_TEST && CC_HAS_RANDSTRUCT
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
-- 
2.39.5


