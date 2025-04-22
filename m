Return-Path: <stable+bounces-134975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C4A95BD9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BEB171ACF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AAD26A1DD;
	Tue, 22 Apr 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIUlAawY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82D26A1B1;
	Tue, 22 Apr 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288320; cv=none; b=dZAbv2bf34AX1TD4me01hFwd4aP+nHRCWpfrd1KpKdfNEj5ZosT9TgXQ6Ww0UqOMM44Af6JLzXm8mOtnkqCkjayZgtZOAL21D//46xLXupnl1VQhJl3siChnC5nA8mvbx0zkQ75dthtSLmxWWq5TJx2WlNYTF5Z5rXt33Ls53ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288320; c=relaxed/simple;
	bh=EiBywMglqTtZn0m2XECVj77kVL4VtMf5fxBX/VdScno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNPVKcMRC5CYs2zOuzKjpDK6U80HgdKAoQGu8u9PUnUVo2ITbazS4jJfH1LA1R7dkNKT1llT62HCuQtvnp/VmZXCCqbJKcevM/EqZDe9oC+7mtSOTp/riekLnRlzqwuJPAepzSZg5krhPWyuxlty8KmdagRsgLpHvaTSA9tJJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIUlAawY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC14C4CEEF;
	Tue, 22 Apr 2025 02:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288320;
	bh=EiBywMglqTtZn0m2XECVj77kVL4VtMf5fxBX/VdScno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIUlAawYaOcDR3z8p8NVLjKENJcRcJND2RgYVr5tTS8nuP8nMEpMWKvgZblVGrAAt
	 PWnRrVMDzSDU6KzJvMfV//0KSW9esb8sI20DcALVO0uiYC6Le5p7CsgvOm0Wx84hdH
	 EBpYD4vFlHCtLG2QZGubbs2Jlxq5LWLw3n1vfkRDR08A7ciRysYwi/Wof397rhbfep
	 PI30TKOa7x2F3GCxeUN08ga4dRZd4Nix5jcEVjwoEVrMa25BBRkmo9MzoWz9qulC3M
	 pFpVltWzUMv1y+CXGESo2OKIPVm3UKUNL7TLSsuYRy+7wEldJ8oMlrnXqezih+KyBv
	 v8VAezwt1yHyg==
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
Subject: [PATCH AUTOSEL 6.1 08/12] hardening: Disable GCC randstruct for COMPILE_TEST
Date: Mon, 21 Apr 2025 22:18:22 -0400
Message-Id: <20250422021826.1941778-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021826.1941778-1-sashal@kernel.org>
References: <20250422021826.1941778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index 0f295961e7736..12e7e836a3f12 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -287,7 +287,7 @@ config CC_HAS_RANDSTRUCT
 
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
+	default RANDSTRUCT_FULL if COMPILE_TEST && CC_HAS_RANDSTRUCT
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
-- 
2.39.5


