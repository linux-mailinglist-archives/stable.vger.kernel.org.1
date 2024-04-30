Return-Path: <stable+bounces-41835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2968B6FF3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1967A1C21C9C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6F12C473;
	Tue, 30 Apr 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3j8E/FO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49295127B70;
	Tue, 30 Apr 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473704; cv=none; b=dGCAfW5J4AyE9bNAd7cLhl3IJ6w8WoIDOY8TPHkzOLfnP03hWDYG7QjbL1a1W/NZegdWmYMMqpKRa2Egq2kR9v7VcDBv80vjj+8x01RZbAMHSPoTffyKoH0pONjyCVzVtz+tvhBBcz6fDw8lbcTPZp8Cd87RNMVvHaQkJDTJVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473704; c=relaxed/simple;
	bh=PD7AQffOmYiwZ3qYYM3m9al8l4CrDvezHmzgu/swMrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlG369DD5JDz5jlLTT7KMGWzRLYydI1CdrMHF23wSEszRjq9hMNmCRNGofugUCdLdT5SteUDyI2xqTGnWXHS5C2WUd3TWOPqNe2NGpoAH+Y953sCiIMvAuWSg35nlSLOcCI+4qgTyW7gGASWwkWljPwxfQ3X7V3zYtjhbRPHFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3j8E/FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD9BC2BBFC;
	Tue, 30 Apr 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473703;
	bh=PD7AQffOmYiwZ3qYYM3m9al8l4CrDvezHmzgu/swMrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3j8E/FOCDAFUIWovdR4swcSvHR9c2GI2D3SmP1j4MIuAosL+SLadMQ/XriiDXL3Q
	 p4KQ5BKoAz2xDlRHkXTSDZgzhaizXZZuUs64ZFmXpCwW6hDOlQUpoBbR00WETMsyyO
	 SF7eC2+//z7iDMNqWWhchplNIyQe7xdyuPgCKzpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.19 11/77] selftests: timers: Fix abs() warning in posix_timers test
Date: Tue, 30 Apr 2024 12:38:50 +0200
Message-ID: <20240430103041.455656659@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -67,7 +67,7 @@ static int check_diff(struct timeval sta
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}



