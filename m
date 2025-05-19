Return-Path: <stable+bounces-144967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B33ABC9E4
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4904A2001
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 21:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234E242D9D;
	Mon, 19 May 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRQ994Qe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A927242D94;
	Mon, 19 May 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689808; cv=none; b=FoVUckOhJ13yQltLS3ddOv8gZA0iadRCu74loU2pQrydhD18HCcjY5dloWx4J/9Ay3Isq7woMEFM9SrkOO+N6z73BljBz2Rd4cn2HK5T5GIstOCZ0/zG/e//WPM+gNqDHKS/msTrckw6mNXcDiNUBydBIK/NcCsCD3/kOpm1u2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689808; c=relaxed/simple;
	bh=D+yoGs0xp7bxGF9vq7xaHgl4YzJmjkkb4nOu5yJCX1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ofdyu/15P6NNm+g2d3KkataAJzIBsbe4ljiXICXeS1LgVIXBg6oteN6gNoCDxos+K2j82fTBmbCVo4OXzyzxnvSx/WurV+QGyz7E9O+2RZc25BIVQWFArKpzNkJPSFZzEDGNMZ9ybkBIuf2EFB3nWo7q2pSD1hu+9luOlx0HqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRQ994Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0CAC4CEED;
	Mon, 19 May 2025 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689807;
	bh=D+yoGs0xp7bxGF9vq7xaHgl4YzJmjkkb4nOu5yJCX1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRQ994QeKlpqNQCnprYqGtgkWBqCx+xljnmB1G8w420lzLm8LmZg6SGMlqArl7hx8
	 6WIgT/IETb29PnK1VADP8CdOZwMX+piAdj4XiNZm4nM3HDxdJB6Vo2Do9F2Kjtz3Ne
	 erAVFfc6F0AQD4otUe/IwTsMnALUeJFucJ++u6Ip/rA7CGC74WjJJARPoVrSLSuqsu
	 5EUjqr52m1X6swr1LSOOOZCRh5G2QCCrB0aeqLhCTLkqe5EZqhRIsXvMd1DOCh3rQC
	 KttQMB9HLOTQJieUfoiS2sGSH9hnTUQ3t4jzr1Ap7V+5uRR5Heq85AUhtHgmW3YOUA
	 k+7nqCJlyzT1w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Gow <davidgow@google.com>,
	Sasha Levin <sashal@kernel.org>,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/6] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Mon, 19 May 2025 17:23:18 -0400
Message-Id: <20250519212320.1986749-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212320.1986749-1-sashal@kernel.org>
References: <20250519212320.1986749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit ab09da75700e9d25c7dfbc7f7934920beb5e39b9 ]

Building the kernel with O= is affected by stale in-tree build artifacts.

So, if the source tree is not clean, Kbuild displays the following:

  $ make ARCH=um O=build defconfig
  make[1]: Entering directory '/.../linux/build'
  ***
  *** The source tree is not clean, please run 'make ARCH=um mrproper'
  *** in /.../linux
  ***
  make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
  make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
  make[1]: Leaving directory '/.../linux/build'
  make: *** [Makefile:248: __sub-make] Error 2

Usually, running 'make mrproper' is sufficient for cleaning the source
tree for out-of-tree builds.

However, building UML generates build artifacts not only in arch/um/,
but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
files remain under arch/x86/, Kbuild will reuse them instead of creating
new ones under the specified build directory.

This commit makes 'make ARCH=um clean' recurse into the SUBARCH directory.

Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Closes: https://lore.kernel.org/lkml/20250502172459.14175-1-skhan@linuxfoundation.org/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 4211e23a2f68f..e2caca06c1553 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,5 +153,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
-- 
2.39.5


