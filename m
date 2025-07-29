Return-Path: <stable+bounces-165025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D896CB146F2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 05:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0D3B799F
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 03:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8342206A6;
	Tue, 29 Jul 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHwhGwNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331F4409
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753760941; cv=none; b=Yn22bc8V01xyhZs0QOtoYRZBFPjphiXxxS+0npQQfYwjb/dhlxxfnM1pI1bwBHCAeJkaP9C44J8f++Pw/C+2jBoNuRdgR3SS3Rz1Xp0OE9h2vmy6qL3gP/kFr7wl0IZDzc9zh+nHxzQNWOnqlwD3FaCkjwZE/WxI0qITRv5wEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753760941; c=relaxed/simple;
	bh=HrS2NRGsU89Fl1gLQsoPVZq+/5j4piGtkeRYO0CfXdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OznqjqVKVPRXC53tZUwDQNd6+GboyybLB6/C+1MKOAXBc5UBKoWCBO14hGejO4oJ2zRGLh8sEeNshRvODga9NTGb1wpEiGeRe+AYur+pOQ1UPUXvc1jONY5BoNdPDxbEpKk7xGDSmqTace5x+pOdoVde65fESge8mmXEoyt2Igw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHwhGwNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3623C4CEEF;
	Tue, 29 Jul 2025 03:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753760941;
	bh=HrS2NRGsU89Fl1gLQsoPVZq+/5j4piGtkeRYO0CfXdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHwhGwNzfyb7NpRkylhA4t5S92N5qOc0eeWAlQCiiJ4WVY6phvHWGXWF/LP5OAgHy
	 M2EtujKNH/GapC1XCEdU5pYVOeYo8eNZghb3H7mtFu37s0WeVM38aNyVWVd0348zzS
	 glv8mmb3ylPc6McdyU7D4UJScflgep78NXcHSfkSb6YCBdvu2ICZ1Wet/aGW65iDkV
	 bQsXYZBvUCf9k8ukuKJwhREJIgQCENtIdULXfR7QaGRvZNURR0iOhkR28Ua86iL5mX
	 MpMvDx37kwn66xTA1a2ywbxWFhmaphw3aZpsnIkQECl8NmupxQCfGvdgdpopieOUu1
	 lfwKmM/Hjzvig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: connect: also cover checksum
Date: Mon, 28 Jul 2025 23:48:56 -0400
Message-Id: <20250729034856.2353329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072855-ligament-reliable-75fa@gregkh>
References: <2025072855-ligament-reliable-75fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit fdf0f60a2bb02ba581d9e71d583e69dd0714a521 ]

The checksum mode has been added a while ago, but it is only validated
when manually launching mptcp_connect.sh with "-C".

The different CIs were then not validating these MPTCP Connect tests
with checksum enabled. To make sure they do, add a new test program
executing mptcp_connect.sh with the checksum mode.

Fixes: 94d66ba1d8e4 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250715-net-mptcp-sft-connect-alt-v2-2-8230ddd82454@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ exclude newer test scripts ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 1db5f507d983..14333a1f11d8 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ KSFT_KHDR_INSTALL := 1
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
new file mode 100755
index 000000000000..ce93ec2f107f
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"
-- 
2.39.5


