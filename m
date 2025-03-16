Return-Path: <stable+bounces-124546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A839FA6364E
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F1F188D69B
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842F19ABD1;
	Sun, 16 Mar 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDkZP4Mi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45397170A23
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742139728; cv=none; b=CMPWNtr7RkQ63Z99vSmLQRmggZCzE0n10n/+BTsC1k5higPHjPa8kHU2+67E8mZb4CRpOEGOHXPIwBvjn6nnrLyFlW08fnBqJxFQnQXtcDwsa2MVfA2Ev19F5cdfSUGq7IZse1yHIXvfCdzCpWzcKq1WeSC1EzjcTpNHZQj9plM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742139728; c=relaxed/simple;
	bh=zT9mj/X88HI5d+JHTJ09RdGiXYGda8hTweMgBWHmv0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8s/dcyUd3W0zzK4gD8TBaCaMt5SpKcESOvcUJFb5I3JI/e8goLU/PBiXe1rBBcc3W8Szn/n+1GM4zcQebEJ0v97BMVOfgxzye5UnVt32AkfbFLSficr7795I2pisgjNpWoRkXwnT8V3WMP87HtMLuFnvJtGlbeVesIpFZBt2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDkZP4Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3587C4CEDD;
	Sun, 16 Mar 2025 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742139727;
	bh=zT9mj/X88HI5d+JHTJ09RdGiXYGda8hTweMgBWHmv0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDkZP4MiQXOou5yy8Wt6HuG44kWJu/hStWlJI+Z8oXUqj8JI3r33/gd6WNHSO9Veu
	 xlLpg0+mpmbW7xT8fjXMHOD4vXeTu5IQ4MtWwIl7TDYKWWav30kQ8XLep+XYJ+rC1F
	 EzeU5+BwMkwWCVrUXb0M7qU0A7M0sI2BraVqsWcULjnCCreI5unxI6JF31pj+sZJBP
	 vqtdhqeMjvZ2KG8uFJDGTdCpfEYugJ8DgK44zfWMTBSzsQpGC8+Azw4T76xYzeX7hD
	 0dP8ua+C4wcGjtMw67vaZPml7wo0K+WFxYrKMxN+XWH/5KLnizb+0YDaQ+ZPJsJEY2
	 loht6fgMBnFaA==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6.y] rust: Disallow BTF generation with Rust + LTO
Date: Sun, 16 Mar 2025 16:41:59 +0100
Message-ID: <20250316154159.2404145-1-ojeda@kernel.org>
In-Reply-To: <2025031621-july-parkway-796f@gregkh>
References: <2025031621-july-parkway-796f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Maurer <mmaurer@google.com>

commit 5daa0c35a1f0e7a6c3b8ba9cb721e7d1ace6e619 upstream.

The kernel cannot currently self-parse BTF containing Rust debug
information. pahole uses the language of the CU to determine whether to
filter out debug information when generating the BTF. When LTO is
enabled, Rust code can cross CU boundaries, resulting in Rust debug
information in CUs labeled as C. This results in a system which cannot
parse its own BTF.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
Cc: stable@vger.kernel.org
Fixes: c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
Link: https://lore.kernel.org/r/20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 60ed7713b5ee..1105cb53f391 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1908,7 +1908,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !SHADOW_CALL_STACK
-	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	help
 	  Enables Rust support in the kernel.
 
-- 
2.49.0


