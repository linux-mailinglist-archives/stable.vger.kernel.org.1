Return-Path: <stable+bounces-165067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77AB14F26
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCB189F802
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5191C5F06;
	Tue, 29 Jul 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlW6YB6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59F41760
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798823; cv=none; b=Eajp4an5scMtcCb9+S3uiCVM5OkRJxStyuzi26/dv2WfgBuM5I7muTIdZ/eHV0djW2T6rp1OjYMVKyWph/8DKB6YylpeIDfN8Zjr7bYVJ20fFuMOBGqgR5zJk2EK2AFWDSqmW2P3LrNTCZ7Qk/KpvHHQhVmDTxBlOZohqnsutRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798823; c=relaxed/simple;
	bh=vbo0v4akldbvZhMXxadwa4Jax9xvpaVKpifT93YDPEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L17W8E3EkuXYXMvjdYKe4USLHg/qpo+GqhbdX36dZ9r/yWU2W9ujMFjijGxFDhbrwzOag8Ls6cXSj+KHIIOMBhA1/MRqS+r/QdfZYGGPD8Qt/fMbeKHiyy0O8jV+NiCy+goAz1FSBvUGOsblnQpMUNqz8zGCMvqmgcIt87n6aE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlW6YB6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2978AC4CEEF;
	Tue, 29 Jul 2025 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753798823;
	bh=vbo0v4akldbvZhMXxadwa4Jax9xvpaVKpifT93YDPEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlW6YB6BHDFe0GCkSoi64ZUdFZc9tWijBQlqcgTfXjWnrddqSbioA8W948J2AxLq1
	 5nOZrW5PdPJXKB1cCMbKw7KwZFPAZPr9zQA39dCgPezKXXm1BCnorIqq1/mE3TxfmJ
	 zZahAPhyztL3enmKL8cB7b1XwkXGyp/obMgLc3mWwJAhruiNDMK5nXX/sVCjMnS+7V
	 rBxoKp72LeL2NEGsTXLs8iG2kGUxFvjykXnDhFvUCgDqoX9oitD5pP3ZzW5nclWCby
	 BrSOirj6za+7F86i12A23GMZwAq/DCE6g6x1xs4ESd7rDMEbNjyCt86O4w97xCgiWP
	 sApHAewKnzzeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: connect: also cover alt modes
Date: Tue, 29 Jul 2025 10:20:18 -0400
Message-Id: <20250729142019.2718195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072839-wildly-gala-e85f@gregkh>
References: <2025072839-wildly-gala-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

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
2.39.5


