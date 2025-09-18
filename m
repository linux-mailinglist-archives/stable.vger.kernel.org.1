Return-Path: <stable+bounces-179920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5CEB7E2DF
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E39B7B8B6E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8057FBA2;
	Wed, 17 Sep 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEYSzazF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7112BE622;
	Wed, 17 Sep 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112802; cv=none; b=I44YVQ5rpBNmLdVbbXST7U5qFJjHsLbyC4kH4iWx1BObIIJruVVGNUnU84fhtaAvxOt8r6TJqWcVq5A17Z4Y1nMb7LhMQa/RPCkaEfrNzNFYSlvUdpSMWSIoff6LOShdss1wKjZDJsqItixFFQpHm/j5doz/ph8x7VuUL8JQCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112802; c=relaxed/simple;
	bh=vQeSEQbSY+bc9TFjXqWhgg5phcNMExWvDFnssqZrpLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buTWSBmGBg1m0FRVXsZPFthsJmW4IJeuMKlpMY+Z0kAi1kf1ZweuzudGFf3A+JnnmPjwnzuHzvCCROJBeljGgYOBij1gV9m86yE7knZjpVB6c9IiFn1laMxefTP5g5i8HqUIOEJkvCO/1A6Z+G+MTNtxqkww3MY4GrP8s3sU7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEYSzazF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638ADC4CEF0;
	Wed, 17 Sep 2025 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112801;
	bh=vQeSEQbSY+bc9TFjXqWhgg5phcNMExWvDFnssqZrpLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEYSzazFFEUEzLX8Mh4DcLh3T+XzxmF41K9Aqv0elSsK82rbXtt8I5nxeot28Jicb
	 rNms1/fEhKacktddi1sGwKes1bRVZcrx6goOA9uebUPDHJW+GbRj/woN+i2WJ2qvQo
	 L8unJGv0IygWuT8vaIvMfF1Why+YQ0BJBYXCUD+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.16 081/189] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Wed, 17 Sep 2025 14:33:11 +0200
Message-ID: <20250917123353.843701670@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sang-Heon Jeon <ekffu200098@gmail.com>

commit ce652aac9c90a96c6536681d17518efb1f660fb8 upstream.

Kernel initializes the "jiffies" timer as 5 minutes below zero, as shown
in include/linux/jiffies.h

 /*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >= 0))

When quota->charged_from is initialized to 0, time_after_eq() can
incorrectly return FALSE even after reset_interval has elapsed.  This
occurs when (jiffies - reset_interval) produces a value with MSB=1, which
is interpreted as negative in signed arithmetic.

This issue primarily affects 32-bit systems because: On 64-bit systems:
MSB=1 values occur after ~292 million years from boot (assuming HZ=1000),
almost impossible.

On 32-bit systems: MSB=1 values occur during the first 5 minutes after
boot, and the second half of every jiffies wraparound cycle, starting from
day 25 (assuming HZ=1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset.  The user impact depends on esz value at
that time.

If esz is 0, scheme ignores configured quotas and runs without any limits.

If esz is not 0, scheme stops working once the quota is exhausted.  It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when it
is considered as the first charge window.  By this change, we can avoid
unexpected FALSE return from time_after_eq()

Link: https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2050,6 +2050,10 @@ static void damos_adjust_quota(struct da
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {



