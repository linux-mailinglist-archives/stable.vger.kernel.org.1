Return-Path: <stable+bounces-164945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5909B13BE7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003EF189DBD0
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B58264A9E;
	Mon, 28 Jul 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtLSxURy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA326B2CE
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710523; cv=none; b=QN+mmZCHFS1fyyS2MuZ5+EZ+Bi74+FIFL1zhr229ZxtsMPX0JP0T3/EE/7lauZJ6uLqotNURIkDO16kmuXGKo0yvVBX5R0ofMi9wzNh3atAkhqm8YsqThTnieWxODMt+Q89zYj+1zBTrMiMK5PLrOE8coQnLh8uYnr9oNMbObjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710523; c=relaxed/simple;
	bh=ASAkE367mUT0NWAnuRGBVy4k2TD6z7do9b8xAoXPerU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AUaRn2aXSioxgbuE9n+jdGr45rEHhmSxGKbJOtQscO0/GyldUAA4ERZUEz1oVZvyJkYrY7dPNHhZj4CoMQabPsfY09bpEFT48MNjE/agd261O87gebkWSby/+xUn6Xesp3tnjWemUajGkEerAoYGABflFQpnUr1EG9mqQSRqSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtLSxURy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA359C4CEE7;
	Mon, 28 Jul 2025 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753710522;
	bh=ASAkE367mUT0NWAnuRGBVy4k2TD6z7do9b8xAoXPerU=;
	h=Subject:To:Cc:From:Date:From;
	b=gtLSxURy95MurMGxIikyAEMZOCfBz/YxmQYrzTgCaxFkmuWx8EBQjdeojRevHn2sH
	 DX0gqiE0XiD6YUB0UOiWxlegCr5rxCrN2IHg4o6wL4TU1Qx5so5LlS1wnp6QIAtXdm
	 UDpq58uzayK/mbqVtbNYh6PsQbKsZIY5QG7iGhNY=
Subject: FAILED: patch "[PATCH] selftests: mptcp: connect: also cover alt modes" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 15:48:39 +0200
Message-ID: <2025072839-wildly-gala-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 37848a456fc38c191aedfe41f662cc24db8c23d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072839-wildly-gala-e85f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37848a456fc38c191aedfe41f662cc24db8c23d9 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Jul 2025 20:43:28 +0200
Subject: [PATCH] selftests: mptcp: connect: also cover alt modes

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

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index e47788bfa671..c6b030babba8 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -4,7 +4,8 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
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


