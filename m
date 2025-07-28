Return-Path: <stable+bounces-164947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D564B13BEA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7CC17C861
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984F25E834;
	Mon, 28 Jul 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dkH74h8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB680263892
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710539; cv=none; b=CEMyfLzcmjAOaUfF+QwEuPw4E1hC/AQewkzJqhx2d7WqJe6U8gXIzguQMH5lsEvXpT1orJ0bH7O2rRoLjjcBgfQEPnZ8aCysxjCcDOHgz+i0CsckqxG+FKxLHT7F2/zRu9y+82YIiTKyClaMpPzticFyM5aYT8aw8CW/P/BZAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710539; c=relaxed/simple;
	bh=R/UHfNdNw3SGYnyOXWdKdwoYJBcLtsKO4X8q3lDBm4k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mlVTyIVOId26pnETZyDd+WKNK+L9s8S/rnR/LdejR2WGbrpqH+Xlqrz+A0V1FlL2zGqGA25tfRBIacdNXoZ9cK6BlrtzDyzkuWWEhHl7ZANfxi4K3tP1lsmvYDRAUkcqDsYyVjdjcRk8RRPfpJrcIlFgno5NF6JsXSfouNeNJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dkH74h8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095B4C4CEEF;
	Mon, 28 Jul 2025 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753710538;
	bh=R/UHfNdNw3SGYnyOXWdKdwoYJBcLtsKO4X8q3lDBm4k=;
	h=Subject:To:Cc:From:Date:From;
	b=dkH74h8+AW0wU6pE9qf3ugduTYUM4cQo14Bs+Oj9SZAcb0kj1BhevI2C2+hsfdWxE
	 9Xh+sC1q2xLbVuhKxc8e8PhRTcbFdn/s0ykhO+CgB+yiKopt0yWZJYtPZ19vyYF+mD
	 baf1SOi0MCuhv4XEPqQb7QDTSxhE7rT6rNOBMqFM=
Subject: FAILED: patch "[PATCH] selftests: mptcp: connect: also cover checksum" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 15:48:55 +0200
Message-ID: <2025072855-ligament-reliable-75fa@gregkh>
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
git cherry-pick -x fdf0f60a2bb02ba581d9e71d583e69dd0714a521
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072855-ligament-reliable-75fa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fdf0f60a2bb02ba581d9e71d583e69dd0714a521 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Jul 2025 20:43:29 +0200
Subject: [PATCH] selftests: mptcp: connect: also cover checksum

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

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index c6b030babba8..4c7e51336ab2 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
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


