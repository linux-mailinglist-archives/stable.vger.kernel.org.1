Return-Path: <stable+bounces-69990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902195CEE0
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4EF1C20B9F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E76193411;
	Fri, 23 Aug 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLuRa4eT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F7188A2C;
	Fri, 23 Aug 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421751; cv=none; b=fJkOGlz6BKfIb2+P7gWq7TyCGWwfMA6m35x1D3fybZrt10koZanJZr64tmMByzccyf0nGYXdCrW+W5uRiJxbU8wYTV9vuf2ka2Syfzmn8b7jkJhEuiw51N5ElVHwZ5RD4oVRN4vMW++7iH1rVbLfc3zeSW8upcKcWTi9TErqwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421751; c=relaxed/simple;
	bh=/RShPq1g4mDnRTWgrbpNgTpnIXZD8hJBZnDbdoLjntg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad8J5DMfmNeYDH9l8HZP5S6ln+ZL2ouUANkuCXV3kd2aZWCW1FSJKt1Qr7yK3mPlHDPrBKGboy1xguP2RMx0eOMfAos/MiDt2QxdKtueYYGCG/0GYXbTBfUdCchoq4v43xYFRfErTIT6YrXCpz/r9pt5zXTUfFJZT2oyquyIG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLuRa4eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC64C32786;
	Fri, 23 Aug 2024 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421751;
	bh=/RShPq1g4mDnRTWgrbpNgTpnIXZD8hJBZnDbdoLjntg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLuRa4eT/eqJELoxz8dlWpRpH6G28Di3osq35mAtRwfTqLa2uEwSxqDEkcVjajbfB
	 wTQfxzHhJzLQdfjVKQPnLVQTVbuXSvRWH+HeBcFs2jCfqH2yXSQJNOMI+7yA6ZsWFJ
	 Gq9KccgCxaYU8CxDlGqH9dpv6tPnnQbhXQJ6C0UqjyPFucykfgc6gZcjrteulkw94I
	 RIFMQk7vrdVYO9f6FBH4tJ9tSUJuS9Oz8ArjSz2LfJfzgX6yKQtkNIKRUtYi10Rt6G
	 ZH99gEO4Xb8plTwrtDXUR9dDBmXTiXDPONfxfOEuVxBYJrSJ9SvmX4jgPhZFoyqawW
	 2yzzLZkYaoH8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Gow <davidgow@google.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 23/24] kunit/overflow: Fix UB in overflow_allocation_test
Date: Fri, 23 Aug 2024 10:00:45 -0400
Message-ID: <20240823140121.1974012-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 92e9bac18124682c4b99ede9ee3bcdd68f121e92 ]

The 'device_name' array doesn't exist out of the
'overflow_allocation_test' function scope. However, it is being used as
a driver name when calling 'kunit_driver_create' from
'kunit_device_register'. It produces the kernel panic with KASAN
enabled.

Since this variable is used in one place only, remove it and pass the
device name into kunit_device_register directly as an ascii string.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/r/20240815000431.401869-1-ivan.orlov0322@gmail.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/overflow_kunit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index d305b0c054bb7..9249181fff37a 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -668,7 +668,6 @@ DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
 
 static void overflow_allocation_test(struct kunit *test)
 {
-	const char device_name[] = "overflow-test";
 	struct device *dev;
 	int count = 0;
 
@@ -678,7 +677,7 @@ static void overflow_allocation_test(struct kunit *test)
 } while (0)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
-	dev = kunit_device_register(test, device_name);
+	dev = kunit_device_register(test, "overflow-test");
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
 			       "Cannot register test device\n");
 
-- 
2.43.0


