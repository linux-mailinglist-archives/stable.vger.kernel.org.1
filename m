Return-Path: <stable+bounces-49052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B168D8FEBAA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA6B23B55
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AB1ABCA3;
	Thu,  6 Jun 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vc9p9HVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E41ABCA2;
	Thu,  6 Jun 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683278; cv=none; b=rIpPSiqB5YtT1pmD08ZOyOgDIbavPIexKzAqA97qRpUOLwtmKs2NTY5E3jJk1EMnB6zacvU9Ef/Ilafs11fel76BT4f+0w0lD5OzUuRMzE+ksByFYNbyDVQLYwj15uwmyOOzHWfXAndcC4tsC+JuvBG4gTVonxOahJ1e4xfky3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683278; c=relaxed/simple;
	bh=SQhHwGLNzq/TP7rNKCjcfFrBxklPhiTNT1sELw+pEec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1VATfKniSEfQ4d59PZGFLfodJ3k/VV2mDIYGioeKotOsoVa/pgMj1xenafrD8NDFqpx1dmtl6qEVvn7XGPcaTQfd/s3NmnWO2Ot4rX6osL2xRAfjDkRRKvzPyK0ZsRi2Yb8tVO3crVLhmCGxJS6XfcCvlu7v8vcgI/tnd+zlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vc9p9HVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D0C32781;
	Thu,  6 Jun 2024 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683278;
	bh=SQhHwGLNzq/TP7rNKCjcfFrBxklPhiTNT1sELw+pEec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vc9p9HVwQ0mEspiwT8nrE8qYVFBHjyPredJMgGwva9TrfbetaMbkBzWXlVT7zo/Cd
	 8jYIoCTroorbEt1xoPa7mLXd9upsDpgb0ER2Kbs3X3Rls8CNhjSDJnyIOwLEn5kBwp
	 Iu3Ii3IYUXloL4OXK6plkl5i0xV3Q1OnsJJgTcT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 220/744] selftests/binderfs: use the Makefiles rules, not Makes implicit rules
Date: Thu,  6 Jun 2024 15:58:12 +0200
Message-ID: <20240606131739.446353321@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit 019baf635eb6ffe8d6c1343f81788f02a7e0ed98 ]

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the following error occurs:

   clang: error: cannot specify -o when generating multiple output files

This is because clang, unlike gcc, won't accept invocations of this
form:

    clang file1.c header2.h

While trying to fix this, I noticed that:

a) selftests/lib.mk already avoids the problem, and

b) The binderfs Makefile indavertently bypasses the selftests/lib.mk
build system, and quitely uses Make's implicit build rules for .c files
instead.

The Makefile attempts to set up both a dependency and a source file,
neither of which was needed, because lib.mk is able to automatically
handle both. This line:

    binderfs_test: binderfs_test.c

...causes Make's implicit rules to run, which builds binderfs_test
without ever looking at lib.mk.

Fix this by simply deleting the "binderfs_test:" Makefile target and
letting lib.mk handle it instead.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: 6e29225af902 ("binderfs: port tests to test harness infrastructure")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/filesystems/binderfs/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index c2f7cef919c04..eb4c3b4119348 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,4 @@
 CFLAGS += $(KHDR_INCLUDES) -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
-
 include ../../lib.mk
-- 
2.43.0




