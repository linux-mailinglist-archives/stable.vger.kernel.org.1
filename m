Return-Path: <stable+bounces-47284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53EF8D0D5E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899C21F20FB3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471816078F;
	Mon, 27 May 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CVmnHBUB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1E15FA91;
	Mon, 27 May 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838145; cv=none; b=XimtE5FcMZH18eEanjhXTzUQhyqVTgBPL697AnplBF0zNDTdMeNd1a6oeIQ8H0kcaTXmxustfQIMEUH6IGADqqSJNmTxfum3WrbXvKderip1fvJV01zVBnGqE1OLqD6g7WDpVVfaGaZ+abnS6vrlG5Xhxo+u8dMJ6BUt7kUfO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838145; c=relaxed/simple;
	bh=1WgC4IilniYf0SgOU36OaTCKopIDloRSoKXn0E1Q9Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzfZjr/68LegLpjUPBlQYXzpRLhQ5r2hqbG+HVRPcdOxkRG699k9U98ez51BfS32txOVzM5wf0ixlcp4VO1lMCGYwD5d61JXL5LYgNAVwaL9FPV8KYb3JoVlx/9KUisgYEU21YsdGtKeBgT+8MpemVS9o2KZXL1ihCSCa8qCvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CVmnHBUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B00C2BBFC;
	Mon, 27 May 2024 19:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838144;
	bh=1WgC4IilniYf0SgOU36OaTCKopIDloRSoKXn0E1Q9Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVmnHBUBzcdytoPm9neDpptH3y2u4ShVouS4N8QYwHpG2cq9PArm1yICqihn9B7vU
	 EYU04AVDe8bNGl52zJRpi4QkGrfm1UlbrZzasStBSrzI+GvrVBTIgdzmj1D83e0aMh
	 0XC6lipFuMYeDuyZTc03XEKPE7JvBWAQAY6FxH9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nico Pache <npache@redhat.com>,
	Scott Mayhew <smayhew@redhat.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 283/493] kunit: bail out early in __kunit_test_suites_init() if there are no suites to test
Date: Mon, 27 May 2024 20:54:45 +0200
Message-ID: <20240527185639.567521831@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 5496b9b77d7420652202b73cf036e69760be5deb ]

Commit c72a870926c2 added a mutex to prevent kunit tests from running
concurrently.  Unfortunately that mutex gets locked during module load
regardless of whether the module actually has any kunit tests.  This
causes a problem for kunit tests that might need to load other kernel
modules (e.g. gss_krb5_test loading the camellia module).

So check to see if there are actually any tests to run before locking
the kunit_run_lock mutex.

Fixes: c72a870926c2 ("kunit: add ability to run tests after boot using debugfs")
Reported-by: Nico Pache <npache@redhat.com>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 1d1475578515c..b8514dbb337c0 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -712,6 +712,9 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 {
 	unsigned int i;
 
+	if (num_suites == 0)
+		return 0;
+
 	if (!kunit_enabled() && num_suites > 0) {
 		pr_info("kunit: disabled\n");
 		return 0;
-- 
2.43.0




