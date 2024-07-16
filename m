Return-Path: <stable+bounces-59663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079AE932B28
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E111F232AE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D119F464;
	Tue, 16 Jul 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z5w2QHHN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2919EEB1;
	Tue, 16 Jul 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144526; cv=none; b=MzN35R+7ZnQ49WxobmTKXrK7gIPybJUxkEvrMSg9aeqBi0sUCxQzjI9ckO4OJdSGa8H0f999IZRYweBD6ldRev9tSlmRPXJXiphKPZKSptxcwSh6m4aUccDQbkMsh3AGl/OGHYh+/NtBo09+ZrHUmRkdkqvAKcQtL8mMZdfc46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144526; c=relaxed/simple;
	bh=vROyVmyUCogV5zhs9vReVc5GlGkFo6uVvfQN0lefpFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQRtOgppDwwSPXbjbnh8oxQiaVHaT8bMtIbsxaVq1nzcjyfxltdqFldH6Gih6f7mUQm/eYcL03aiGprhUV+wwNSe8dxnS8bpV5DtXoUV/wpaTjVYRA+MwzU+gSOchSwrwBEZ3GUTyO3vOlbaxKN8ThnPeHyPHVP4LEtySnhasU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z5w2QHHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E64BC4AF0B;
	Tue, 16 Jul 2024 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144526;
	bh=vROyVmyUCogV5zhs9vReVc5GlGkFo6uVvfQN0lefpFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z5w2QHHN8XpNNoECsbKJkeoVywqn7m6Hxvku6RFErpxRoLGYp3B5K/uyiys3rWSMn
	 X++Yhf6n5azCnMnSNpPWJXDzcEds6kHhMe+9646hJ5A5Kj66sY+iQXqAdk7YSxvAiv
	 kLXBTqEqfQUsCqO7Tota/dFazglLKTWIKmH9C0as=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brendan Higgins <brendanhiggins@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 022/108] kunit: Fix timeout message
Date: Tue, 16 Jul 2024 17:30:37 +0200
Message-ID: <20240716152746.854244413@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 53026ff63bb07c04a0e962a74723eb10ff6f9dc7 ]

The exit code is always checked, so let's properly handle the -ETIMEDOUT
error code.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240408074625.65017-4-mic@digikod.net
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/try-catch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 71e5c58530996..d18da926b2cd7 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -76,7 +76,6 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	time_remaining = wait_for_completion_timeout(&try_completion,
 						     kunit_test_timeout());
 	if (time_remaining == 0) {
-		kunit_err(test, "try timed out\n");
 		try_catch->try_result = -ETIMEDOUT;
 	}
 
@@ -89,6 +88,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		try_catch->try_result = 0;
 	else if (exit_code == -EINTR)
 		kunit_err(test, "wake_up_process() was never called\n");
+	else if (exit_code == -ETIMEDOUT)
+		kunit_err(test, "try timed out\n");
 	else if (exit_code)
 		kunit_err(test, "Unknown error: %d\n", exit_code);
 
-- 
2.43.0




