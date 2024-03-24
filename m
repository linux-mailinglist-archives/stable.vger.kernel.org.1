Return-Path: <stable+bounces-31602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105E8897AF
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31041C30F06
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F5158DA3;
	Mon, 25 Mar 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGyRJeo0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC11145B07;
	Sun, 24 Mar 2024 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321996; cv=none; b=W6ZKiB44zRcpfo+OpxDS0c5pxb1KIGt9jnmjcgKOjKO5ZXc4r9zOh0X0LYDpPKE/NYFg6Sd2skW43Idn1pTX5YE7Ssj1prMM/BNN4GZdLju44EBsu4voIsh1Bl8MTtZYVhOXxJnBMcyenYwO4AmzW5++ESq78OUvwL2M5OA1Pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321996; c=relaxed/simple;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTz+D5jKL4yQ+w47IBI5WPaCrR7Rlq9HjHYYEA1GsOyWjnJtGJFrGgaKpyQO7Y+zoylAXEJy+PLBHoIw+84TxXqnKXQdxvM+Cw512LDVLMiXQV5a0iSc1sTLeNJRsRzdn4GoeY9dGpn5q9ZiAikwsfAcRmyCZXIZHkxGcKHQIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGyRJeo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB1C43394;
	Sun, 24 Mar 2024 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321996;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGyRJeo0nzynd2sxyFbaewW8L8JwfHTSWj0dEVf+1FI3FwOHLHrgzaC600jNJM+Uw
	 yFruXxYbfGiO+TJ2CaDWNzyc9XzvYRa3zBBwM1ZQt7Rk99RHpZ2kcaX4ALpzpgxmi3
	 vkUwZr00TWWjTQ5Jy+jeFpNDulwIai/1VxJiUrnr+7L9NaVNYz0glufvMGR2VDZX35
	 /iwtHi0wp5EgHlBF41gfxEyzTsFBAJxyo+EU7NVl/AxELK0x+dH8gHKHUcYSfn/q/n
	 Qr7ZiM27DFRHXxf3UXESEmAm0zOKgCxhpmPLE+5JDCphSuu1f1vDLRQ3HdQ6bVINit
	 KETDVH+BqhThg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Latypov <dlatypov@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/451] lib/cmdline: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 19:05:44 -0400
Message-ID: <20240324231207.1351418-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Gow <davidgow@google.com>

[ Upstream commit d2733a026fc7247ba42d7a8e1b737cf14bf1df21 ]

The correct format specifier for p - n (both p and n are pointers) is
%td, as the type should be ptrdiff_t.

This was discovered by annotating KUnit assertion macros with gcc's
printf specifier, but note that gcc incorrectly suggested a %d or %ld
specifier (depending on the pointer size of the architecture being
built).

Fixes: 0ea09083116d ("lib/cmdline: Allow get_options() to take 0 to validate the input")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/cmdline_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index d4572dbc91453..705b82736be08 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
 			    n, e[0], r[0]);
 
 	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
-	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %td out of bound", n, p - r);
 }
 
 static void cmdline_test_range(struct kunit *test)
-- 
2.43.0


