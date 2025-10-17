Return-Path: <stable+bounces-187072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02724BEA115
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E498C58582A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F023EA9E;
	Fri, 17 Oct 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYc0fg58"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459593370FB;
	Fri, 17 Oct 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715041; cv=none; b=IKvlqybudjyVDmkRmzrz+XpAx5xxCacT0hsha5Sa1l0u5mJPCdxXlEM/wQjQUhum+4f0YA9YBVev5tkkvLyePRFlcADqhWajCoh9pat2nemIvTO4XQeH5zY8DLkQedkPWc0loYGoAfikTYEp1xmZg8Z643AdHcENiMIpKKA3RxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715041; c=relaxed/simple;
	bh=m/mg2SX03q1x+UAgKZBM3zVyMy+jbMQ94zxoaB0gxKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrwLjKWv+LfyZ5nsekF7aPDioOxa5L7S66rWbr80lqMPpowXVUvdLLvgKrKbBsTlI27A0bo1jS+2apr/TrPkZdYseWWBxAg3FCXDc5rSa9cc3JvQknK7F/XPKR3PYBeRgc5hF6AfrkNs0kkI0+9ZRful6/hKse+4xKCcWsoCR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYc0fg58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3880C4CEE7;
	Fri, 17 Oct 2025 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715041;
	bh=m/mg2SX03q1x+UAgKZBM3zVyMy+jbMQ94zxoaB0gxKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYc0fg58yo80eZnyeHdDkuScgl8wdYWCmZ5KV0yk4JTDzCwwUr17eiQEtUxnlScH5
	 UhNtPxCYIU1pR9Cf902nuHigMwsLDRcXzjvKagmykb6qLdFoTVoFVixPv0JgtInmbI
	 e+DHyTd/gtV63GxShs674Hi8mBik/HeS2IzgpxWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 077/371] LoongArch: Fix build error for LTO with LLVM-18
Date: Fri, 17 Oct 2025 16:50:52 +0200
Message-ID: <20251017145204.725832881@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 19baac378a5f4c34e61007023cfcb605cc64c76d ]

Commit b15212824a01 ("LoongArch: Make LTO case independent in Makefile")
moves "KBUILD_LDFLAGS += -mllvm --loongarch-annotate-tablejump" out of
CONFIG_CC_HAS_ANNOTATE_TABLEJUMP, which breaks the build for LLVM-18, as
'--loongarch-annotate-tablejump' is unimplemented there:

ld.lld: error: -mllvm: ld.lld: Unknown command line argument '--loongarch-annotate-tablejump'.

Call ld-option to detect '--loongarch-annotate-tablejump' before use, so
as to fix the build error.

Fixes: b15212824a01 ("LoongArch: Make LTO case independent in Makefile")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index f2a585b4a9375..dc5bd3f1b8d2c 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -115,7 +115,7 @@ ifdef CONFIG_LTO_CLANG
 # The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
 # Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' also needs to
 # be passed via '-mllvm' to ld.lld.
-KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
+KBUILD_LDFLAGS			+= $(call ld-option,-mllvm --loongarch-annotate-tablejump)
 endif
 endif
 
-- 
2.51.0




