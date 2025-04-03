Return-Path: <stable+bounces-128126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63FA7AF3F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98B77A58F9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50C26159B;
	Thu,  3 Apr 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUJXApbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52F261593;
	Thu,  3 Apr 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708031; cv=none; b=MQsE6WbWg/lckZWDlSe44NWC7b4+E8jwAylYqOOd5elI0/0YIgtvpkwAq5j2PLE3cDJY5s8T71UGbHVnop0s8UnB1rTeEGzfHNqWcP0Ac4pw5Xma3NU/7O3Nq0NWNkMxura+QWdpakKK8J85RVWXbmiDkjs6PjQyOX68jbHxJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708031; c=relaxed/simple;
	bh=p4WEQc/g/dzlD2OLiEdzMYJMBo88GrdIO9065zpmUCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUU5brdYmERuRWOPVzLzm35vkONdfPhfiWA+sNDKb+wlz9lUFTobO3+66aqfHMcEGzT2mjuwvJdopN+i3THssD1s4SshlVqRRwDAYg1WTmFkq3AoPfUfTAbRw+v9C1yfWgn2Lc0WKT7WfqWPtU8D1eBap6BO4trvoPphelQuzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUJXApbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4366C4CEE8;
	Thu,  3 Apr 2025 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708030;
	bh=p4WEQc/g/dzlD2OLiEdzMYJMBo88GrdIO9065zpmUCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUJXApbWJ034C0PlCzfWrJ1Pa+seG9/HtQk3XLksckg0T7rZrUHcmsk+vUSNglgTD
	 t1lAK9ghqjxuvyLKz+8TESwCOtoFRUn1SPmATH9Nqwlxtd3tuXT75+AUogCFjquG2Q
	 SUcr+3jAvnhARgkwRJ4g26GZH+MFC1e/exT7q/eQIfEIUfTSKokMykJIy7iuTqUvJV
	 jX9yP9+p+VMy6KPOrA+1so9m4nFKf83LR77OVTcrC7JVLrI9+LGayPoxp0/4jqrurO
	 4N6I269IE6cYxlvvAxkWem9EWBr65nts8thFlDGohCYK4GBX9hQxUJzJw7/V4N8RFf
	 zN+NeVaVQsxFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ayush Jain <Ayush.jain3@amd.com>,
	warthog9@eaglescrag.net,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 12/12] ktest: Fix Test Failures Due to Missing LOG_FILE Directories
Date: Thu,  3 Apr 2025 15:20:01 -0400
Message-Id: <20250403192001.2682149-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192001.2682149-1-sashal@kernel.org>
References: <20250403192001.2682149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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


