Return-Path: <stable+bounces-167085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E81B21990
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7151F1890934
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60127285079;
	Mon, 11 Aug 2025 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBOIuzHD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFE285C85;
	Mon, 11 Aug 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956343; cv=none; b=UTjTrHlz7cHW06akCxzWecGaf+ur5iVpDz+6RVfjLu/qEE3c56+O0rDHt5TLVAKKGJSXzzIp8nHOS0ixdNq8nZzEtCXfZRJEVUYx1+ZfNyn6dVZQuAxiC0yIzZdx6gpzhZLqm2NPTv4wrmB8/WCA6NuDoY5n/ql1yIx0ysSPES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956343; c=relaxed/simple;
	bh=tFW7xAFCsBDZ9EJ2Une7mqEt2FB05XsC3D8WsL/Sa6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3jUwsf2jS69wEJk99LR4IVwEClPn97iuj4ycVBlkPst4W6dOKmZJ9C7AvMJT71FJkqrT9ba/MPrOkT017V6ReNgOg1tKIE/IY4ezzvYG7gNHSTfDGhYHTNT2NCFGkFEZTVjQEAFLzvvr3B5gJr5yTK+hoRp5kuVbHqHlJhQcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBOIuzHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDFC4CEED;
	Mon, 11 Aug 2025 23:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956342;
	bh=tFW7xAFCsBDZ9EJ2Une7mqEt2FB05XsC3D8WsL/Sa6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBOIuzHDPnS7Qum8aaoOAKQFQN+2qZjbvYtMilYgyhtjTuFqpSuNKvSUo9BWTLZVh
	 eHP6HhYNf/dxQlyGyA84gBtOZiR4+ScXPt5Ef2izBG3MR7g3u73k0PNijbVs/3qrH4
	 z9qtLngjgGKvPdw4aA+xr2Lful31h4PFK3egfkP/r+thsgOKYETdGjScgb30pUGxEQ
	 2UasbYwnC0IfwUQtHf9EO435asrLXoeWcff1it+A+aLFBGdB698NK78mlIRQ5xhUP4
	 37PudMwTMEOXRyC1oQZQGKAjuMNEU+ydY6gRVQGSuM2ZqBh3cUnsthg5lQsinZfPOF
	 f350FUwd0lAzA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 4/6] kbuild: Add CLANG_FLAGS to as-instr
Date: Mon, 11 Aug 2025 16:51:49 -0700
Message-ID: <20250811235151.1108688-5-nathan@kernel.org>
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

commit cff6e7f50bd315e5b39c4e46c704ac587ceb965f upstream.

A future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to
KBUILD_CPPFLAGS so that '--target' is available while preprocessing.
When that occurs, the following errors appear multiple times when
building ARCH=powerpc powernv_defconfig:

  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12d4): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717520 is not in [-2147483648, 2147483647]; references '__start___soft_mask_table'
  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12e8): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717392 is not in [-2147483648, 2147483647]; references '__stop___soft_mask_table'

Diffing the .o.cmd files reveals that -DHAVE_AS_ATHIGH=1 is not present
anymore, because as-instr only uses KBUILD_AFLAGS, which will no longer
contain '--target'.

Mirror Kconfig's as-instr and add CLANG_FLAGS explicitly to the
invocation to ensure the target information is always present.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 11f905b95e65..b01d3108596b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -108,7 +108,7 @@ as-option = $(call try-run,\
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
-- 
2.50.1


