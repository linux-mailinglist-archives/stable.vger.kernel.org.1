Return-Path: <stable+bounces-128113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55047A7AF5D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A4517729E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9242586C9;
	Thu,  3 Apr 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJrplCWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5E2561AC;
	Thu,  3 Apr 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707999; cv=none; b=ZlaiT9iCvaQMXPsFBZb4WuCFWNOO2MKX8z0nRSME72XzsfMZS0wB2LVptVtBS7iYjMTSEBf/8rh6QG+BnaAlgP3DAE79Lw1LIUjnWLzzQ59KNo8l3UGGnIZcJ4wFq/yBwxNyp/g5Lpo/Vv3+2UkCayNzt0PqKbCVRcyElkL548U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707999; c=relaxed/simple;
	bh=p4WEQc/g/dzlD2OLiEdzMYJMBo88GrdIO9065zpmUCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqU0By1FlasAKEV8wMHmq83nwNdLupKhSLAO7IC4oPL7g+zJx2OFQr2ChnKbANjibBJ2wuzaJaIUjl0gZ2GSWepZOrTD7bBZbWxlE6f/w/re6Cvnvk/S8JXTRi4HZtR52JZlOWOJb+IILvtRkBtzqMn/oGEMa+EsbMZgqF93grQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJrplCWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC897C4CEE3;
	Thu,  3 Apr 2025 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707999;
	bh=p4WEQc/g/dzlD2OLiEdzMYJMBo88GrdIO9065zpmUCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJrplCWZJRvrkniEnRlI2XtF2bp88vgFd4dMHk7QzAYVP2KjBvqRrpr3rg6xlepiA
	 EjgYopay1zVuyVvGWKQCSZL8h2aSPczVlObFk1CMnu5JPl8xXcvgp1bOs2ujt8Wx37
	 ki3u19EVHI0EJFrS0Kjr60yPWv3iJsqLw8CC8dnkfx38+fArfZuAKsGYzbSlDvvQgn
	 I8k2/HBtxChFUanGNDcxLKp0QfJpRgH6iPGAfIlmmF0SvVWYOEwSwHFThJ0PyghaNp
	 69QuxfJ3VG4HiVksgwLdB5w7IvarpFJP9ZRkgo5A2zOlByT5z7xa/LgxwxFh9gZ1ew
	 zttkJrJdjEAfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ayush Jain <Ayush.jain3@amd.com>,
	warthog9@eaglescrag.net,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 19/20] ktest: Fix Test Failures Due to Missing LOG_FILE Directories
Date: Thu,  3 Apr 2025 15:19:12 -0400
Message-Id: <20250403191913.2681831-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: Ayush Jain <Ayush.jain3@amd.com>

[ Upstream commit 5a1bed232781d356f842576daacc260f0d0c8d2e ]

Handle missing parent directories for LOG_FILE path to prevent test
failures. If the parent directories don't exist, create them to ensure
the tests proceed successfully.

Cc: <warthog9@eaglescrag.net>
Link: https://lore.kernel.org/20250307043854.2518539-1-Ayush.jain3@amd.com
Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index aecea16cbd02f..2109bd42c144a 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4282,6 +4282,14 @@ if (defined($opt{"LOG_FILE"})) {
     if ($opt{"CLEAR_LOG"}) {
 	unlink $opt{"LOG_FILE"};
     }
+
+    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
+        my $dir = $1;
+        if (! -d $dir) {
+            mkpath($dir) or die "Failed to create directories '$dir': $!";
+            print "\nThe log directory $dir did not exist, so it was created.\n";
+        }
+    }
     open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
     LOG->autoflush(1);
 }
-- 
2.39.5


