Return-Path: <stable+bounces-127997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0CA7AE0D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225B4188173C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD619CCEA;
	Thu,  3 Apr 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV696Xw1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235F151985;
	Thu,  3 Apr 2025 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707712; cv=none; b=Yor3TQUh3iWn/ez2dr3027hHgcp3Km2TqilRuBA9Bpr1c97JlXDO1+pIpzcRguiXO71BM6mwdL/cwqfPx6djGqP61tXX0oXF1BlNWR0DHd/d82TdqdyNO6CNUGeRNH6ZStsdK6wXpCIJ/Nde8BlUPMOzJPFjXzkOAUki24kt24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707712; c=relaxed/simple;
	bh=hO6U5WrxRVAMYwkM/iIS3xZ9VwrEt8WUz9xANMqLcvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lE+HXyrVxP26cqWalByUjmd1C2HBzlwY7xSXqBsFkFWT8bXE7DWIcDMYNmF2fKu7+IxRR1+2ECy4B6zO4PtDgcRYu0jHbA68Dz3t5MVVEsLpRwg5b6ex0owD13XmWrdIZBt0YtNAE3lBBhyzRzsIENbJST1n+r5GjSgqsb3raJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV696Xw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99286C4CEE3;
	Thu,  3 Apr 2025 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707710;
	bh=hO6U5WrxRVAMYwkM/iIS3xZ9VwrEt8WUz9xANMqLcvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tV696Xw1we5ax0duJyozkQM2nIYImEqe3UCIQDSACMxrbOoTJgjiZxhsrASAYJl/s
	 OYCmPHxBZlPRdpygrlaZx/z+TMyj0qhtGk51rA38yLUjMckyXd090oNOoEhU4RyRqA
	 6Myo5fwBNLU1V96omQ41gylU+b8LByvvvvcPaYVQt5GLKmiRVnrhHRc1i5m3/iZd/r
	 u+ltRw2HvJBfoptuzXIy6w16qCpwLdnS0V4FzT/uFuQFhjoORRv/6HvzkKWjbpeNNb
	 BlewLa79RUtfAS6isbh/CTGhabBN1QF7ASnqk+qO4EGcscPjSQzvdOifizJAoSOFsO
	 485aCelnEHVnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ayush Jain <Ayush.jain3@amd.com>,
	warthog9@eaglescrag.net,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 42/44] ktest: Fix Test Failures Due to Missing LOG_FILE Directories
Date: Thu,  3 Apr 2025 15:13:11 -0400
Message-Id: <20250403191313.2679091-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 8c8da966c641b..a5f7fdd0c1fbb 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
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


