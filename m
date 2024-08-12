Return-Path: <stable+bounces-67324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A794F4E5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD136282354
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A1186E36;
	Mon, 12 Aug 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvb//xDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45716D9B8;
	Mon, 12 Aug 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480555; cv=none; b=GbhxuH4kteEPujZm7aCsG/PM/xtcOuPK/yqSpWUUPeOAWtcfLPCXApVinAJ2bk6ZCcMyQVynyJcF82Rdp9rDWFWBYqbq3lGczm+GlTBW+ebkyOsAt+meKN7YAC4mmhJOUF2BCyXCO26vre5rjTudHKfwACLTmXPHcy9qS19vbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480555; c=relaxed/simple;
	bh=lQhqu+oIAYP3Q5rwrbSV2lYMLPJQzXyc73qW5X/GUWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgef3Ia9uKCwXQMhg/daMWMfjipbYnrJvYHBUtbgX/LC7FbqBCYpCW485IGT+hZgJcAGUEqiKuhZpdMx0qVDO3Vuf/hiVDooHsGbNDmPuRdpl58wFK1AZgeFJS96BLiMKmamdmD2UvSi/fCyID00gRXpWC+esBCnrLLAIIYh0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qvb//xDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D16C32782;
	Mon, 12 Aug 2024 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480554;
	bh=lQhqu+oIAYP3Q5rwrbSV2lYMLPJQzXyc73qW5X/GUWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvb//xDDGRG7iKfxhZhVJ4G8g5qtm6wLnCPQJNbZeyCpBdEZ6C8jeDttFtLo73icL
	 0kT8Ri3Dqp7TT+FuHOiA2BWZEjaT8go82KLcyweH5MuXifPPxuoBWqnmzgt7fNMnx8
	 WRmbzk1vsqlSSq40jt6W2G6i/MxONC8KW3//t8wI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nico Pache <npache@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10 232/263] selftests: mm: add s390 to ARCH check
Date: Mon, 12 Aug 2024 18:03:53 +0200
Message-ID: <20240812160155.416483906@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nico Pache <npache@redhat.com>

commit 30b651c8bc788c068a978dc760e9d5f824f7019e upstream.

commit 0518dbe97fe6 ("selftests/mm: fix cross compilation with LLVM")
changed the env variable for the architecture from MACHINE to ARCH.

This is preventing 3 required TEST_GEN_FILES from being included when
cross compiling s390x and errors when trying to run the test suite.  This
is due to the ARCH variable already being set and the arch folder name
being s390.

Add "s390" to the filtered list to cover this case and have the 3 files
included in the build.

Link: https://lkml.kernel.org/r/20240724213517.23918-1-npache@redhat.com
Fixes: 0518dbe97fe6 ("selftests/mm: fix cross compilation with LLVM")
Signed-off-by: Nico Pache <npache@redhat.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mm/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -106,7 +106,7 @@ endif
 
 endif
 
-ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64))
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
 TEST_GEN_FILES += va_high_addr_switch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs



