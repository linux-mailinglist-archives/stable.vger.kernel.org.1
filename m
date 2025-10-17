Return-Path: <stable+bounces-187683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78499BEB145
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EDB1AA5E43
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC0306D52;
	Fri, 17 Oct 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZifL+JU/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDB2E4254;
	Fri, 17 Oct 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722435; cv=none; b=aCC5q+SFVCyBt0Iq31hJTrA80TE6f3VgfZTy7evafwBjzU4OYbWNyXz5Fza3XiNaeWr8s+kfxlTaR1ouBDq+SD+6FaCSwJg6oHU7udZkqc6e4s8tPBBcpidaqoszt9VKxY3qJxqt74ez7QGtUNZpoT2JBOWsji/rNVhfiG7wEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722435; c=relaxed/simple;
	bh=ui7yVZ6WbMYNe7EHu4NqAuwm0HLMLbJ5LF66UYQlSKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ6c0wOnFautgfTdDv9nWIC/CfxzbfrX7ippmvrfMfNvzVvrqCR4xaohoP4XvQTMiSA8YxLkYgY+3Pi9/HLJNSv7qUciMGsZM1Ub4vZf7a3QzZxKeBE9DJdnzJ5sr1f7AD1U/koH9St9VBbNWXa+S9WsdO6OiDkKKbK9yktNOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZifL+JU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF83C4CEFE;
	Fri, 17 Oct 2025 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722435;
	bh=ui7yVZ6WbMYNe7EHu4NqAuwm0HLMLbJ5LF66UYQlSKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZifL+JU/nD0B0akdhTsQSDotj+odlNu8tfZoMcsHRq+3Lg5qqKtx3GTxDywfj9uI8
	 udAvIEXCnB2mHVsL8AZ+RA8EJnMrllMV3xlG4UkMVHCR/Uv1RJSeM+LFY4yNRC9Ztr
	 V/v7RX1imDbJfwBDuhhJ8OBgNNT0NKq/dcjUOC3Zj/L/1oEC2kfAPKOM8vQNtEc9dD
	 Kp+ssZQ14RvTkr+aNC05x5lNe3MAUm0shX9Spy1DShLh1/StTRvQcWYNoMHk5Ex0pg
	 SJVloWJbFK4DVE/FiDNHLnY67BrTD1Ts+zOKcETKHSkcbubukRqmoVKTX87mU0LEuw
	 PEjo8isRh/CTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 19:33:38 +0200
Subject: [PATCH 5.4.y 1/5] x86/boot: Use '-std=gnu11' to fix build with GCC
 15
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-v5-4-gcc-15-v1-1-6d6367ee50a1@kernel.org>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
In-Reply-To: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, 
 Jakub Jelinek <jakub@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hoMQpSOACl+S1Hma2+NP+Coi7rrUG8ABFqi8bz4/NSw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+1f4I2H3edJqUyTsJHrf94s7vw6PClIOfz9FP0dtZ9
 XdxoOvJjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImkTWJkmO/44l7ni30fdrad
 iNrRuXCDeH8qv/NdsT/v3r5wTF2fm8bIcL47u8qzrvoTT9py4bebfRe/TGDd9X9h5tsKJTnrwh1
 C/AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Nathan Chancellor <nathan@kernel.org>

commit ee2ab467bddfb2d7f68d996dbab94d7b88f8eaf7 upstream.

GCC 15 changed the default C standard version to C23, which should not
have impacted the kernel because it requests the gnu11 standard via
'-std=' in the main Makefile. However, the x86 compressed boot Makefile
uses its own set of KBUILD_CFLAGS without a '-std=' value (i.e., using
the default), resulting in errors from the kernel's definitions of bool,
true, and false in stddef.h, which are reserved keywords under C23.

  ./include/linux/stddef.h:11:9: error: expected identifier before ‘false’
     11 |         false   = 0,
  ./include/linux/types.h:35:33: error: two or more data types in declaration specifiers
     35 | typedef _Bool                   bool;

Set '-std=gnu11' in the x86 compressed boot Makefile to resolve the
error and consistently use the same C standard version for the entire
kernel.

Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com/
Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Reported-by: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250121-x86-use-std-consistently-gcc-15-v1-1-8ab0acf645cb%40kernel.org
[ Conflict in the context, because a few commits are not in this
  version, e.g. commit 527afc212231 ("x86/boot: Check that there are no
  run-time relocations") and commit 5fe392ff9d1f ("x86/boot/compressed:
  Move CLANG_FLAGS to beginning of KBUILD_CFLAGS"). The same line can
  still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 62ef24bb2313..e436819859d9 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -27,6 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 
 KBUILD_CFLAGS := -m$(BITS) -O2
+KBUILD_CFLAGS += -std=gnu11
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386

-- 
2.51.0


