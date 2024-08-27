Return-Path: <stable+bounces-71134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BAC9611D2
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FB41C237D5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F81CC898;
	Tue, 27 Aug 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DeCSlXoi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8D1CC15B;
	Tue, 27 Aug 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772211; cv=none; b=MRBNroA9IesSfpZX8aMM4KFT9xYLiPItzX6eUOzOEAW4uP11fK5/p7kNBfTNZSdN5d4Mh2l6QA7cWbQy/VWt0nWF80fSko5QRaOgVqZIkyt88FFn6hgSbcAmOChzcij6L117mJzgNx2P8pyOFKPQb7lfA8JKu8qiuU5tABfnywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772211; c=relaxed/simple;
	bh=topv9tqaEdZ+bLUskY8e54jfeFZywKwWevcpkjydadY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5MJqPFet5AYwU+R4qBZ3aCR0gh/ACciEGLHP7GJCFdl12n4X8b0+XdAa8xzV/hQvTP+YFE06k2h/RkxZguoTFlrZaNbL90+c481mxNqmgzzsteCQF2q7ObTd35fN6F6t52s9BiE9g6ES7KjAHctteIAy34uWg9Hay4c6937hXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DeCSlXoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D48CC61066;
	Tue, 27 Aug 2024 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772210;
	bh=topv9tqaEdZ+bLUskY8e54jfeFZywKwWevcpkjydadY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeCSlXoiyZjZ5GnP8AJMNoHH9WjFo0eg2CZZCcKgaz0VWq7azg2XOmwe38Fg3Tr1r
	 fH6gTfubfuRWDzbfD68cVqv55EfjT6wV7eqHNmCsd4qCVZ8ej3NyOxGGrpf7sz5GTM
	 NsZfPAHa8ApVxz32Dk8slb5vMLyL9PudXsSByFbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 147/321] rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
Date: Tue, 27 Aug 2024 16:37:35 +0200
Message-ID: <20240827143843.833575103@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit aacf93e87f0d808ef46e621aa56caea336b4433c ]

Another oddity in these config entries is their default value can fall
back to 'n', which is a value for bool or tristate symbols.

The '|| echo n' is an incorrect workaround to avoid the syntax error.
This is not a big deal, as the entry is hidden by 'depends on RUST' in
situations where '$(RUSTC) --version' or '$(BINDGEN) --version' fails.
Anyway, it looks odd.

The default of a string type symbol should be a double-quoted string
literal. Turn it into an empty string when the version command fails.

Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20240727140302.1806011-2-masahiroy@kernel.org
[ Rebased on top of v6.11-rc1. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 85e8bf76aeccb..2825c8cfde3b5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1942,7 +1942,7 @@ config RUST
 config RUSTC_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,$(RUSTC) --version 2>/dev/null || echo n)
+	default "$(shell,$(RUSTC) --version 2>/dev/null)"
 
 config BINDGEN_VERSION_TEXT
 	string
@@ -1950,7 +1950,7 @@ config BINDGEN_VERSION_TEXT
 	# The dummy parameter `workaround-for-0.69.0` is required to support 0.69.0
 	# (https://github.com/rust-lang/rust-bindgen/pull/2678). It can be removed when
 	# the minimum version is upgraded past that (0.69.1 already fixed the issue).
-	default $(shell,$(BINDGEN) --version workaround-for-0.69.0 2>/dev/null || echo n)
+	default "$(shell,$(BINDGEN) --version workaround-for-0.69.0 2>/dev/null)"
 
 #
 # Place an empty function call at each tracepoint site. Can be
-- 
2.43.0




