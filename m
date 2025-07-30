Return-Path: <stable+bounces-165497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D31B15E27
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853117AE9DA
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F82853EA;
	Wed, 30 Jul 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV0xNxd5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C3283C9E;
	Wed, 30 Jul 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871308; cv=none; b=AggybJT7AnC5E2IT7oesIYref7N0dKdDZgP+hmeLGaizjym6a4YJM//qXHRadpGtxAy+mpg4WwxG4/TrWNkDJ8NUPNvkpLTo2SrBM5RnhmK/YSzs2W7vc002qzKKI2f0t6iaRXh9gGfMr1J0ebgdV2blyj86TZWQ6QTCFQrIt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871308; c=relaxed/simple;
	bh=35Ll9xxofGzgF2fAFYclr6uQbCmrsABQ+SYc+WRqi+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF/PqVsqfWLAfsOu4qDgZt0DKYK80XQ8N0LpqVC2Ve/OzO1egxuT9PUOFm5g4JKU8yT2BawOuWicna3Y5rkkWHARQQYCQ2IWUMokh87d6z2Yw0FI6mwQjO2C3dO/g9wagl7g5dSGd0w4yC910FdLMdQUQOFQhBetbJz3C25MnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV0xNxd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF76C4CEE7;
	Wed, 30 Jul 2025 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753871307;
	bh=35Ll9xxofGzgF2fAFYclr6uQbCmrsABQ+SYc+WRqi+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV0xNxd5N4nY3cxcaPaBERnXxKnkgbMbBUrhboop4iQiL9EixCe8XighiR+ntlTxq
	 xnooR+/ZAn/NOK/FzngaqYbcqyvsjgMEVCLPQwZoShh3lbbJ3t11ybsQzti3QavmA2
	 g7L5t2u0BirmXBNw+wENCAuaZQB6UMjtp6/ZCKPgmuYoHY1D4//rWKTdx+2jH5QaPF
	 cmjt7NvvaMQT1huzFXRjFA8DDa9PMKoLY98wjw6UedOic891MUmp5zvwKL9LR6B+Jf
	 OVNSCefo0xVidTAluQzyjY+c8maRvLEecwjgBrBIBoBCleZf5hKjGD6dYPw0ikalKs
	 wUQTGrialmAHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 2/3] selftests: mptcp: connect: also cover alt modes
Date: Wed, 30 Jul 2025 12:28:09 +0200
Message-ID: <20250730102806.1405622-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025072839-wildly-gala-e85f@gregkh>
References: <2025072839-wildly-gala-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108; i=matttbe@kernel.org; h=from:subject; bh=35Ll9xxofGzgF2fAFYclr6uQbCmrsABQ+SYc+WRqi+Y=; b=kA0DAAoWfCLwwvNHCpcByyZiAGiJ87qjuTimG1LU60P3ZJQxUaI2DuCLAX86+z6Bg6w14rgxj Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmiJ87oACgkQfCLwwvNHCpfqxQEAvMIP 0AylzoZKNqaCiagbMM1vkxroa/TiyjmtWAlPzIUBAO5JCiFmnIa0j423uNwhyzseUUKl2d9zhLQ wjPSqR4oA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

[ Upstream commit 37848a456fc38c191aedfe41f662cc24db8c23d9 ]

The "mmap" and "sendfile" alternate modes for mptcp_connect.sh/.c are
available from the beginning, but only tested when mptcp_connect.sh is
manually launched with "-m mmap" or "-m sendfile", not via the
kselftests helpers.

The MPTCP CI was manually running "mptcp_connect.sh -m mmap", but not
"-m sendfile". Plus other CIs, especially the ones validating the stable
releases, were not validating these alternate modes.

To make sure these modes are validated by these CIs, add two new test
programs executing mptcp_connect.sh with the alternate modes.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250715-net-mptcp-sft-connect-alt-v2-1-8230ddd82454@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Drop userspace_pm.sh from TEST_PROGS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 1db5f507d983..ffae6cc66e28 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,8 @@ KSFT_KHDR_INSTALL := 1
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
new file mode 100755
index 000000000000..5dd30f9394af
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
new file mode 100755
index 000000000000..1d16fb1cc9bb
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"
-- 
2.50.0


