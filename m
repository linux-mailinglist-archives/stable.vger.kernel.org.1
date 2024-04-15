Return-Path: <stable+bounces-39797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8308A54C9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A121F22AB7
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74578C89;
	Mon, 15 Apr 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fz0HrXHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965C2119;
	Mon, 15 Apr 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191842; cv=none; b=TMMQaTvyKMO79btfhwJPICXBH4V/smSNdTrhcdym+NDldM/ynO2ATY9xVooSjSITkSFTSsEhWSgF7aDIM3RueBEoGnyQZvzPsvIb43LsWYyRm1m1SlY0V28j+gsfyrrdYHLRltkUdVWp5KAOENeiwqCNBTS1dOIv+vJj2LPPA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191842; c=relaxed/simple;
	bh=UVtOsOa6Aq36OQPqY/Slg5Tu4KcpfGfas7/jMwhDxe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1Hy3Q/qIRWlbhXTJs5uQCMg65FePyyfV4qLMH9Zza+Q+6nbAzQMGsE37Miv+fDhz7NYHpTQ4CsXB9IhjhxBL7399ExZWMsOyYc2c4WCbtpIMsa3xCHmBOriSnjJcFwtMWQPlgefxssrSUkwUJftJJmxpPR2Xp2GVSZx9yrFdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fz0HrXHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F09C113CC;
	Mon, 15 Apr 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191842;
	bh=UVtOsOa6Aq36OQPqY/Slg5Tu4KcpfGfas7/jMwhDxe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fz0HrXHjY6MsnmLzacXFDp3n0xPAXDRRYJSpltbYo9epA4qI1Wv7o/Y6jFAZWIwF/
	 rJv0Wxsnqj1t7d4x2kJM98Uf2twyirrtw7zv3skq1bmIJBB9TQ6N8FHysEBppHdIsc
	 duGxzA9/IoIPpvuOOuIShATmVmsx4XxsTdCNvtPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.6 104/122] selftests: timers: Fix abs() warning in posix_timers test
Date: Mon, 15 Apr 2024 16:21:09 +0200
Message-ID: <20240415141956.494645402@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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



