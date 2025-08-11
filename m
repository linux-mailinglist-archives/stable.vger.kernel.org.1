Return-Path: <stable+bounces-167084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB9B2198E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD8E173440
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6842857DA;
	Mon, 11 Aug 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zivi2j0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1B285C80;
	Mon, 11 Aug 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956340; cv=none; b=sB+clBGABGr9qtkfOyIWnCqSpOZxYUuBYDrymj6NkhBc2kCSlI9qmKih/XjuA9dmA5eFzwoLzSmiMjwhqZPF1VHpxYq5WhUj6ftKkbX4CR1cg1RSdE/cnmbcxM5MZpVE57MK33LlY9WeD34rMtk1v3gJ77hCGGUGEvmH6laYDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956340; c=relaxed/simple;
	bh=yrqwhQ1NBoLVlJayI9+AyiJgUEW/+iKeCKKoTPNol7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeEu1vtQYX4KU+5EJz8rl5KXGoQB7i30gcB+iuQTAhXJXQOKGTl7bGlM7b23IpZoUQIQP1V6TyAb+nUjsMsi+ATOuo9WscaruMTMIecGHthX+hrsxF+WbnbLaDRnwHFR/N2aHjG50JhX5osA6K8ZmbRl+OW+al7Fb1A1vD6+ovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zivi2j0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE33C4CEED;
	Mon, 11 Aug 2025 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956340;
	bh=yrqwhQ1NBoLVlJayI9+AyiJgUEW/+iKeCKKoTPNol7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zivi2j0HiFn8FfFvclMYUwwUWpkBphnpcwJqYgPZup+J7Xk3nwZPgb7QSaf/0hfbK
	 dJjhAy8f8gOI3XsINbULWUZ0Py65zixBqYFtnXzzgKGbVT+HBI+MLl/Hwwh5ILTUeJ
	 WBdeVNPIaC2LHEJ1OJmAFOQ5Sexsh3P7SJd+RLmJQyRtJtLL5UKEu8E+74ylmghhyp
	 dO2TlQAqvJUow7xauxZhn0peWuYcftDcXNRVyu/VaseRnDqELitpw3LzLLWq3FCvho
	 C0HFKKvHIc392+6G58bJjhMBfMhWdLEhsNShUfdNi/M+zaVEGXZ1CwSUHgYpwZ4oRe
	 SWnq5X3BAehWA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 3/6] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
Date: Mon, 11 Aug 2025 16:51:48 -0700
Message-ID: <20250811235151.1108688-4-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811235151.1108688-1-nathan@kernel.org>
References: <20250811235151.1108688-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 08f6554ff90ef189e6b8f0303e57005bddfdd6a7 upstream.

A future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to
KBUILD_CPPFLAGS so that '--target' is available while preprocessing.
When that occurs, the following error appears when building ARCH=mips
with clang (tip of tree error shown):

  clang: error: unsupported option '-mabi=' for target 'x86_64-pc-linux-gnu'

Add KBUILD_CPPFLAGS in the CHECKFLAGS invocation to keep everything
working after the move.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4542258027a7..cc6f8265f28c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -319,7 +319,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
-CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
-- 
2.50.1


