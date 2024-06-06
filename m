Return-Path: <stable+bounces-49046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C916E8FEBA3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F901F28F76
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4319A29E;
	Thu,  6 Jun 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFLDyBYA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690081AB8FD;
	Thu,  6 Jun 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683275; cv=none; b=orsgQ/2ry/91WDZ565350/ug0MXN8YotAYY+D18GKF6zL+7fM8ZyHeDG3SBEqQ3RLAR+0CKuvhLY13ZqqR+NaDqhBHaZsjwwLmLPUDpBX0CCMcEGzYpL8POtlvHkv42wTaa+fCL/nqAACu72NA4hLKzKX4rvM5fx3jsN3+9cQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683275; c=relaxed/simple;
	bh=bb9MF6s0C2JeuDIA0vFLuNWIkimJD30VvluyvBdbM3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsAdvGFFwnbU6QgIX4csZlnKD3KRjFLCXVkVu7TKQSsOJBjx1pBQweMUf4M2Z07yistYKkOXHVMAJ3Wdy17YkSYHf/KRWYSOsEuaSRG8LZfq1VoOuAJBVqQrfnMFUabBWNvotp8Ivc2Q385o08Aalwx9CBkMmebLED4iKeNMKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFLDyBYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A40C2BD10;
	Thu,  6 Jun 2024 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683275;
	bh=bb9MF6s0C2JeuDIA0vFLuNWIkimJD30VvluyvBdbM3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFLDyBYAdKAVuovCHv2csq33jDpu3hv7xWXoyRPQbXrrV9JlAnp3UhIhcQoQ1iPFf
	 PxNmhVfQQ2Nb6cLsYVaDMSTUZJnQ5AZok4eFamrft3oI76H2IjaBXnWVC+E+8tt2cV
	 jEQAWNNrdqkGBP01SnqDmj79rUvLfqgP9PLkx4oc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 153/473] selftests/resctrl: fix clang build failure: use LOCAL_HDRS
Date: Thu,  6 Jun 2024 16:01:22 +0200
Message-ID: <20240606131705.012919597@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit d8171aa4ca72f1a67bf3c14c59441d63c1d2585f ]

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the following error occurs:

   clang: error: cannot specify -o when generating multiple output files

This is because clang, unlike gcc, won't accept invocations of this
form:

    clang file1.c header2.h

Fix this by using selftests/lib.mk facilities for tracking local header
file dependencies: add them to LOCAL_HDRS, leaving only the .c files to
be passed to the compiler.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: 8e289f454289 ("selftests/resctrl: Add resctrl.h into build deps")
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 2deac2031de9e..021863f86053a 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -5,6 +5,8 @@ CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
 
+LOCAL_HDRS += $(wildcard *.h)
+
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.[ch])
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)
-- 
2.43.0




