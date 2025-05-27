Return-Path: <stable+bounces-147442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4222AC57AB
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E238A6065
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534DF27F178;
	Tue, 27 May 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9w/jdYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FB3C01;
	Tue, 27 May 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367355; cv=none; b=Xwi/XuBpKRFRiaIYZ0vvNSdJqLup0/+23YDBo6CwUCj5TP4D0jUgU03eLkhQlByT+2I7HYGeEiFYeYYYitU9EHx/N5qYXVccsIQEU2dopE/mcgZ+PaiZ/7hf1St6pcZuJgNg5LLzk5/S9UO1r8GIoaGA7QVsPxRdfZxaqH1eArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367355; c=relaxed/simple;
	bh=/gkIIJJK+D+54mJX6/NXDPg43L6JyEVdz1vejA4Dzks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRXbpbbnSuhrJ/fOHAOm8qdbmlJ1tWq75RpGsoxfQNjjtnZorScV7kstvzTfsKMj5PXmDzyHByAUwbIw/YMT/Bzvd9qT2GIYuDYi2MMpZzI9eoTYK6Wn0A5brqLFOYdq0ilk91khjkM+jjLsCiXTw0ss3xSy8TVpUyw0hNYAO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9w/jdYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA14C4CEE9;
	Tue, 27 May 2025 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367354;
	bh=/gkIIJJK+D+54mJX6/NXDPg43L6JyEVdz1vejA4Dzks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9w/jdYcX5sexdncy0SIN/mc9xwrIHBxvu6G7CWqv6gQA6OqPGiaVT/N5AsFAxeJK
	 KAzc5tirDW6zdQEJnwczFCgR5WyRAdOurhMnTQ5e78ALZaUxQwdDna8PzhK98meP0J
	 906RT01rEtyO5rl7NXzAtjTwQpxKKWgV9bNXlW68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 361/783] cpuidle: menu: Avoid discarding useful information
Date: Tue, 27 May 2025 18:22:38 +0200
Message-ID: <20250527162527.784011854@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 85975daeaa4d6ec560bfcd354fc9c08ad7f38888 ]

When giving up on making a high-confidence prediction,
get_typical_interval() always returns UINT_MAX which means that the
next idle interval prediction will be based entirely on the time till
the next timer.  However, the information represented by the most
recent intervals may not be completely useless in those cases.

Namely, the largest recent idle interval is an upper bound on the
recently observed idle duration, so it is reasonable to assume that
the next idle duration is unlikely to exceed it.  Moreover, this is
still true after eliminating the suspected outliers if the sample
set still under consideration is at least as large as 50% of the
maximum sample set size.

Accordingly, make get_typical_interval() return the current maximum
recent interval value in that case instead of UINT_MAX.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/7770672.EvYhyI6sBW@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/menu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 28363bfa3e4c9..42b77d820d0fb 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -192,8 +192,19 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
 	 */
-	if ((divisor * 4) <= INTERVALS * 3)
+	if (divisor * 4 <= INTERVALS * 3) {
+		/*
+		 * If there are sufficiently many data points still under
+		 * consideration after the outliers have been eliminated,
+		 * returning without a prediction would be a mistake because it
+		 * is likely that the next interval will not exceed the current
+		 * maximum, so return the latter in that case.
+		 */
+		if (divisor >= INTERVALS / 2)
+			return max;
+
 		return UINT_MAX;
+	}
 
 	thresh = max - 1;
 	goto again;
-- 
2.39.5




