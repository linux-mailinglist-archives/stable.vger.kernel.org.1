Return-Path: <stable+bounces-42556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D338B7392
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6C11C22EF7
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4E12CDA5;
	Tue, 30 Apr 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tqct/Xej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31F8801;
	Tue, 30 Apr 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476043; cv=none; b=CMjgB6e8VPilTEJ4aZ+ApJrTCUxbRY6TY0q8vAKvt/MEzPIMuaFBEAJNVe1BTav/S6Hv7t6qyymDH7w6Fq5XTPdll/F5KJ4hJrweKjPVNJBYxJ5w3PSeKsuioxUD0hAg5kJP5rqDL+/4TZT0zVZfiCQhNEWC8xiRsoAqmqUtT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476043; c=relaxed/simple;
	bh=htxm7hd2DYIXPo20g564t+hXnAJyZlTuxkJ/6nt+udg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1Csjw6iteCrxITmFZf0FcyTaxAWcvUt7UG/z2kUfkQW/W5ctYsikApw3RD7EAREMeo7HtaP9x4D+RSI2v70nMpXVYybjDINAbKqxQVvBBMCo0N+MCQ0oGePfNjfYXpZDZnrBzSpoo2UMpDpF1bGu+iNc1DW3m2b0nHkVwHAT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tqct/Xej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A0C2BBFC;
	Tue, 30 Apr 2024 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476043;
	bh=htxm7hd2DYIXPo20g564t+hXnAJyZlTuxkJ/6nt+udg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqct/XejB0yPYvkg75tfIwHB25puc380Yjlr5RqP9BQwu/wKe1V83HKpFxWOV5VMV
	 coMKgtn/7O7cGDmX1Ebs1hCH+rPueBE71oGHYNbzGS3Uzh2r7s2u8QD3aVRUOcwwQG
	 FL0isdW3KmFElIKPKJCsJQLeTiMnEMSl0DXEZnsA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 017/107] selftests: timers: Fix abs() warning in posix_timers test
Date: Tue, 30 Apr 2024 12:39:37 +0200
Message-ID: <20240430103045.171970492@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Stultz <jstultz@google.com>

commit ed366de8ec89d4f960d66c85fc37d9de22f7bf6d upstream.

Building with clang results in the following warning:

  posix_timers.c:69:6: warning: absolute value function 'abs' given an
      argument of type 'long long' but has parameter of type 'int' which may
      cause truncation of value [-Wabsolute-value]
        if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
            ^
So switch to using llabs() instead.

Fixes: 0bc4b0cf1570 ("selftests: add basic posix timers selftests")
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240410232637.4135564-3-jstultz@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/timers/posix_timers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -66,7 +66,7 @@ static int check_diff(struct timeval sta
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}



