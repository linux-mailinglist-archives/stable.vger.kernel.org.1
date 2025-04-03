Return-Path: <stable+bounces-128093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22FDA7AF1D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2941C16CBBC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDFD22FE08;
	Thu,  3 Apr 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qATQtBhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7B22FDF1;
	Thu,  3 Apr 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707952; cv=none; b=E8wkXyBRrWv9Anrqsov3Wvv4UCzuSQCq+/9LTYW3ZNeI5U5kMQEIGe0N1K0GeQ2ABYpC8vdut+P9TTOWJoyk4IxEVVNjkVzsPAzfddCacepAOdAOQEIZYa9smAM0AxKhVDlspA47x2IM0Cr30zDG35+/Z0ZwpALy3uJlnfTXRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707952; c=relaxed/simple;
	bh=C0rzBYNNb4ENBZhA9Ok/RWvXh1pfO11RMazZKC84JgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiAw6Fd9CLYCgPt2PJkJnWOESz7CJV/BOXZBu20OnB9AsrFA2u4R+o8UbmrMwA8waf2ZvBmm658YD6D7z04rkOH4TG+cS7jdBTjX1BfFdPjWamWmSNRa5zKAq0O7SzxL8hG3PZclRgvaJZq7GpYS38NE+w0LniDZQH1an25FdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qATQtBhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9686C4CEE9;
	Thu,  3 Apr 2025 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707951;
	bh=C0rzBYNNb4ENBZhA9Ok/RWvXh1pfO11RMazZKC84JgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qATQtBhGCo0qCkyA/iqFK6NXgpaLBjOwdriYogu0RAgze2ov57FO5+QE91DHVWWZ4
	 rF2vaC3g0Iig9qenbwAn/oSkhRLLBzuRQmjlEhtNN8NGSRbsqVXQ/Da6L98/OVisW5
	 ADK6lU9kkLSs3DMoBZqwWHaTZJ1QPHuNCFR5mwiEvnmfmQ/WsiNQgubbTVEF95n4YP
	 ENQWQnhHsi1ZseyZhHYOvJ6PHTwHRac0dS98BrBoNGeqaVS7tM4DKObIhSJM7pcnzy
	 PzBBNIqY6COHIcS+iiYwwh0GoQDs3WvYFdpBFsakjBSphNPNDvx0L8U7XbJzJEq8N3
	 0vWI2CJ1AlBIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ayush Jain <Ayush.jain3@amd.com>,
	warthog9@eaglescrag.net,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 22/23] ktest: Fix Test Failures Due to Missing LOG_FILE Directories
Date: Thu,  3 Apr 2025 15:18:15 -0400
Message-Id: <20250403191816.2681439-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 83d65c2abaf01..3316015757433 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4289,6 +4289,14 @@ if (defined($opt{"LOG_FILE"})) {
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


