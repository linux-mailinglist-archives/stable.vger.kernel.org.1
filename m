Return-Path: <stable+bounces-134960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A3BA95BAE
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A88C1673C6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA460265CBF;
	Tue, 22 Apr 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa1yEVJF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1494265CA8;
	Tue, 22 Apr 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288297; cv=none; b=EnqUlkMNYOMPYyLTajmhLJn79gcPFLABmypW4bWNMwitlQMNCWb5aO2ieZU/z/CVhsf38Dq1mWzamEKWB/F67WLck5pHtyPO/v00J5JAyY83JjJd/RDhLQbfvUc4FRRoll8OMsLYmjIrouX5xNFSnf/XzcL8NVVCc9ijzvCRp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288297; c=relaxed/simple;
	bh=/Y+EBwSCQzDGbUyJxbJPpMMbsba07Pgv+rdAzk/ck0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pu5E4kV9uqmdEmlrXDD3F/OTEPEshIJRvxoEKlj4y8MByykf1fNJv1wnRNiUt5mD5xjj6U1uCDrmrLLbjdvi5CqxMjn1HUdmdQZLxJCx7sqDw3eENCaVghnZ5m+0OM+bcOflrrC5fnKOcTx0pzkJ8h3ZOvD9eFycFUqz6Pkdwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa1yEVJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BDDC4CEF0;
	Tue, 22 Apr 2025 02:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288297;
	bh=/Y+EBwSCQzDGbUyJxbJPpMMbsba07Pgv+rdAzk/ck0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa1yEVJFuzGjItcs1pPhFc29DACdHsYChrly6XhiH4rwfAMTuq+G1SbcXZ0VIgfrJ
	 fxcEWhm+MwFDNM5aDADTmvMk/GPqoJMfMsCLIjzHLusPwMlDc71fsk47FuBW50BqG1
	 +45oFPYmYfoTxW56JTMOBtvEemTHAx5G/CyVKJqcoPhjTQ4YJ05WbBqA0Kz8APiqkO
	 UM+JIwF102aMhr9YpRJq9DGrIJoOgbhasnRMMf6+/l7i0otqLyVzOyIlewrWOee9w1
	 jGVqKgnZzcYu/R2mWCFnuOR2qcTXX4W9slB+oB1m51us39F+aDW6WqKwqXNS27uxRj
	 8Mc+sKaLmIXdw==
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
Subject: [PATCH AUTOSEL 6.6 10/15] hardening: Disable GCC randstruct for COMPILE_TEST
Date: Mon, 21 Apr 2025 22:17:54 -0400
Message-Id: <20250422021759.1941570-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021759.1941570-1-sashal@kernel.org>
References: <20250422021759.1941570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index 2cff851ebfd7e..f1ba84812ab22 100644
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


