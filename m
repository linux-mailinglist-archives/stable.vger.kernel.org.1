Return-Path: <stable+bounces-39500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC198A51E1
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE521C21E6F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBDD762C9;
	Mon, 15 Apr 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfniNqDV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99C76045
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188305; cv=none; b=ZE1XBXXfXJQM6Bqc38ecgiG5k96G1GjpGGXHrH0kukfQsdT/b4Obsny50d6ZnI7QZ0UDOljMforiltMYGMkIBKhXQlTE5sMxtjnXkr2fumt87UykGOIgs0ma8y67fdX6qmdUhLqjIRUCGgeF9pHDuVUvM1T1d1t4e2VLxeZ7R+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188305; c=relaxed/simple;
	bh=AL/7Cgx5mPufdRMLUwLyNmFQTZyzBDZ07VR1MqLd9Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKndYBCMB1RB+qvcvQZuDkIxX1e2HSyxtWEBfK9NlTcJ8Fn3Z1q+y5G2PHeLyxfCS+ANPUNmI8RKXfiU6N9sfBNFBAxlfsd5vcX5jNWzNKTltlfDYZqJ3qGD3ePZliZAHzqwxO23t1tbNLEZLLOqevYDn8wyfc70HBFvSoPKL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfniNqDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18421C4AF07;
	Mon, 15 Apr 2024 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188305;
	bh=AL/7Cgx5mPufdRMLUwLyNmFQTZyzBDZ07VR1MqLd9Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfniNqDV/NaBBqUcY3FcVQmPeQbadE/Y7a+CVt4Zb4yWO+9wuKDU0nUSyEjC5eYiD
	 oEi79ntaR0vSYUSJmtVYUdf9Aogi/bmivBy359+4WpYV1hW7X359D3WAnP7FKJ8d/8
	 RDR8Tj0E6Vh/xluUbRTqAnIWry5ShW9i2FUJKHjG/YRJckFehOUdb35XfNkITkavKo
	 GrtsVlRTrHpLFMC780Y0KMNVW4dxEsY/Q/ptzZ0sbNWYvVD/LZJ03Wx8d3CCntpFbl
	 KoTrv750XpLd/NaJBShlQZDzr3JyPvbn3XUTqVMMc3n8gTicxINT8Yhhc2D60Ud0aY
	 gcBlYJtecTLMA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Francis Laniel <flaniel@linux.microsoft.com>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 012/190] selftests/ftrace: Add new test case which checks non unique symbol
Date: Mon, 15 Apr 2024 06:49:02 -0400
Message-ID: <20240415105208.3137874-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francis Laniel <flaniel@linux.microsoft.com>

[ Upstream commit 03b80ff8023adae6780e491f66e932df8165e3a0 ]

If name_show() is non unique, this test will try to install a kprobe on this
function which should fail returning EADDRNOTAVAIL.
On kernel where name_show() is not unique, this test is skipped.

Link: https://lore.kernel.org/all/20231020104250.9537-3-flaniel@linux.microsoft.com/

Cc: stable@vger.kernel.org
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 0000000000000..bc9514428dbaf
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
-- 
2.43.0


