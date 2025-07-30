Return-Path: <stable+bounces-165498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE3B15E26
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C0E18A4E5D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115728F53F;
	Wed, 30 Jul 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdt2nleq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29012877D3;
	Wed, 30 Jul 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871309; cv=none; b=m2PU6BeU2wSK2wVOeOj+euq2SOMY4nnEclRGx1BDez5cMSftHM30OwZTlmabaqpjJsw4lSYKm2yFb+2QWe5Js3xowzofziq3Hs/fh0zmc19U/unFLprhmcUEybLdHam9irLgfarQwEu36QC0SmK2WLI4nUcbZeyg1puxbjixqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871309; c=relaxed/simple;
	bh=GEYnqcMR5594gInHSr4nTBeJ1R7OaIqgfXWyukkdHDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHZE61DXRo12AeKUup/ixrbV1lbbD/CwSBz+YR15duJM/I3cMSoCjcU44I+LSR+k/o21oMfmbV0XJM3Oix2m61eHNsmAVrdGor85PPP/OrWD/ddvX+RE/jjNt7xuTjQ8vWusB85ajOFYyPfhJFGVvV+DpZkSwJTtPVxSFOFVUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdt2nleq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22D9C4CEF6;
	Wed, 30 Jul 2025 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753871309;
	bh=GEYnqcMR5594gInHSr4nTBeJ1R7OaIqgfXWyukkdHDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tdt2nleqT3w0tGDiBM2JemHKuHCsKAhlol1LGSd+4stwDwy32XNSxBTU1tyP/4ZNA
	 Mr22mdB6tpcoNR+s3kIsrtGz/KsDZagcXvx4MiA9dAcPtk/Qb4R+GINeXTVkrRAJyB
	 CU3v9/Lvm6KtvwH1EzTEGuiWxXBp1Z6ZxZPfqoKaeeSRuIvFfVlphr7rZwOb8Vq4D9
	 y4P/N5IVedU7FQ5IY2UK4KXLiDW6y2r7N29Tzj7TgrFggWocZQOduVR6q+3q00f+du
	 Frb9irg2acUO4lQlLTATNuxXYUmZCi2J8XRMX52PSnDUSKDzTT+3f31MezhRDLJJhX
	 UFiUQaLAnLUBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 3/3] selftests: mptcp: connect: also cover checksum
Date: Wed, 30 Jul 2025 12:28:10 +0200
Message-ID: <20250730102806.1405622-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025072839-wildly-gala-e85f@gregkh>
References: <2025072839-wildly-gala-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410; i=matttbe@kernel.org; h=from:subject; bh=GEYnqcMR5594gInHSr4nTBeJ1R7OaIqgfXWyukkdHDk=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI6P++538+S8uytx4r3S6KUF06es3ZujXFNp6WzayQD7 xSrVw7GHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxsmP4H7FxmQ1fv98BOYvs iMNd2xfvc3pRsTrOaZNElV1mjWXvQoZ/2srnUtv/PWIy49c0KC3OcGkWZ2tIkr3fcb/m93s/GyV mAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit fdf0f60a2bb02ba581d9e71d583e69dd0714a521 upstream.

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
[ Conflict in Makefile, in the context, because userspace_pm.sh test
  has been introduced later, in commit 3ddabc433670 ("selftests: mptcp:
  validate userspace PM tests by default"), which is not in this
  version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index ffae6cc66e28..1c9c3fbb39ee 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -6,7 +6,7 @@ KSFT_KHDR_INSTALL := 1
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
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
2.50.0


