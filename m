Return-Path: <stable+bounces-1525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C607F8022
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BAB1C214B3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75D364A7;
	Fri, 24 Nov 2023 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T8X0YBNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452133CC2;
	Fri, 24 Nov 2023 18:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ED6C433C7;
	Fri, 24 Nov 2023 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851618;
	bh=71CvJHkazMPOF+zDjyCUEeWOzG3d9hGaClNk2ePOxWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8X0YBNUx51DPfCBk+zlbJSrK0mvAYbSv4PxR/xS6/CHf5+5wdhd32l0h/0VYLHG1
	 4QbEusN5Xj+UvjsWYeRdAllrN19Spv8Hkj4dJQZbzER7//mn/rZth+OyKOQGVsW5fj
	 zCUJ7/Z5aupUybRtkK4OjuHSGYcXmdmyqPHI9n5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/372] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
Date: Fri, 24 Nov 2023 17:46:33 +0000
Message-ID: <20231124172010.646682119@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

[ Upstream commit cf77bf698887c3b9ebed76dea492b07a3c2c7632 ]

The lkdtm selftest config fragment enables CONFIG_UBSAN_TRAP to make the
ARRAY_BOUNDS test kill the calling process when an out-of-bound access
is detected by UBSAN. However, after this [1] commit, UBSAN is triggered
under many new scenarios that weren't detected before, such as in struct
definitions with fixed-size trailing arrays used as flexible arrays. As
a result, CONFIG_UBSAN_TRAP=y has become a very aggressive option to
enable except for specific situations.

`make kselftest-merge` applies CONFIG_UBSAN_TRAP=y to the kernel config
for all selftests, which makes many of them fail because of system hangs
during boot.

This change removes the config option from the lkdtm kselftest and
configures the ARRAY_BOUNDS test to look for UBSAN reports rather than
relying on the calling process being killed.

[1] commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC")'

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230802063252.1917997-1-ricardo.canuelo@collabora.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/lkdtm/config    | 1 -
 tools/testing/selftests/lkdtm/tests.txt | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 5d52f64dfb430..7afe05e8c4d79 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -9,7 +9,6 @@ CONFIG_INIT_ON_FREE_DEFAULT_ON=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
-CONFIG_UBSAN_TRAP=y
 CONFIG_STACKPROTECTOR_STRONG=y
 CONFIG_SLUB_DEBUG=y
 CONFIG_SLUB_DEBUG_ON=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 607b8d7e3ea34..2f3a1b96da6e3 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -7,7 +7,7 @@ EXCEPTION
 #EXHAUST_STACK Corrupts memory on failure
 #CORRUPT_STACK Crashes entire system on success
 #CORRUPT_STACK_STRONG Crashes entire system on success
-ARRAY_BOUNDS
+ARRAY_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
 CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
 STACK_GUARD_PAGE_LEADING
-- 
2.42.0




