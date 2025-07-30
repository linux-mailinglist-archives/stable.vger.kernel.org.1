Return-Path: <stable+bounces-165505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69DB15F28
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D4F163279
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F628031D;
	Wed, 30 Jul 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENrvLc6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EBD515;
	Wed, 30 Jul 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874302; cv=none; b=SIkeFG1NjGwwxK2ZK+S9NPLKrz4eG3BF3aHvdFRY/+I81bpwBthEzPmHgg88o0xdGp1kdXZ1/32hg5DvWH8w+fX9pHiuEUtj16Woku/vRO9oD4oIQJdUDjo1zfqpSRs6HKm6d7IfstbGVSCe0Lknv4m8vFRRUwEmWNi235B0bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874302; c=relaxed/simple;
	bh=+fqn07KLf9ZZ6cvR+nYWasO+4p4hMPYesqH2YCv9vJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwIMz6cs22gTR9Id1W5B6B41o++MAe2xucFjvCKmSAexfOTvw+lZ14OqziTTAF/N201nn/mPcH1Tu1clTfw562eKE8oaR4Ya8b3+UhfAAixZWnTqfELUGgXaXlPoRStuzwVWAml+J912HZWbyx9uxSOJkwCawGbCLKQ5Jr79N+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENrvLc6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F159AC4CEE7;
	Wed, 30 Jul 2025 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753874300;
	bh=+fqn07KLf9ZZ6cvR+nYWasO+4p4hMPYesqH2YCv9vJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENrvLc6dGD7CXz5fCB0BOIg1i2nAczKNvGrnxOSKpQhIJYvhuMz/E8O2vx08WTVvQ
	 JmnlQlbLiUtebcqnOr10wz1BnishuAGmwD7X7opyV7k9huhi076dJjyvms77T23/Qe
	 EDKRoctDEgLjuwhR3q797QNyOsHptuMyPIma68apIbqizURw9JISSGzRnJl9d3TgZd
	 z2HLPWZlA2fvXjMrgTEROPGCBGBg7C1M/9fiMWDQZi3RS7/mI7A6vZiAanv/GvC5hy
	 IRY5dx+BACLiSP0uCHOaOOJYUH9/ot4EqjpDTl6GUOsqWszHKI8Rgt1nv5x/u76MhW
	 TwlILJznFes3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] selftests: mptcp: connect: also cover alt modes
Date: Wed, 30 Jul 2025 13:18:06 +0200
Message-ID: <20250730111805.1659125-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025072839-machinist-coherence-ab5f@gregkh>
References: <2025072839-machinist-coherence-ab5f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=matttbe@kernel.org; h=from:subject; bh=+fqn07KLf9ZZ6cvR+nYWasO+4p4hMPYesqH2YCv9vJQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI6/+dN23GOnfFExzUWuWBz0VYldf8an0ecU7rryvS+q h4TtL7RUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJEn7xkZmj4vXCM28azu4SDT /2dKX9zwWibS/9KTq6ZR+tiujJtN8xgZNp1eu/dTeWfyhNI59mvPlq5T/HZutvxvoWuZXzocdge +ZwUA
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
[ Drop mptcp_sockopt.sh from TEST_PROGS, and drop "sendfile" which is
  not supported in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile              | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 7072ef1c0ae7..c77ce687ae2d 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,8 @@ KSFT_KHDR_INSTALL := 1
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh \
+	      pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh
 
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
-- 
2.50.0


