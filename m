Return-Path: <stable+bounces-36821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FCC89C1EB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FDF1F22805
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FE7BB1F;
	Mon,  8 Apr 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nh/uARtq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D932DF73;
	Mon,  8 Apr 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582439; cv=none; b=Z8uYjeEuh7aFqVQ60RKRLsxtzLh47WDoLWmr50RQ6msQF0vlxL8BNqs2hlPMWCrVlpRrUpxbwDUD8HCrCWnh4vztJqYxuB+K9YjbRCHq4d+HGNuyKikx+7jIuKJCtwxTyy9UkZvRFTltIrKcSmTiQem1gFTSgEfhKLQytFAcmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582439; c=relaxed/simple;
	bh=n9x6ok8IImWtzPVDMWsTqfSjXIWwmp0w6UsVUf2qeFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM0fsbbBvakUw7pFMfknoVb5852/upEkktIx2Nol6MFFo0BLzDQ4OVVkn5oUQwoo0/sCVNdw4jrfBxOoFJl0s0XV3ugRoGIrz8xOeEUIKC6gz3RsBRBAO/Oy5VkQT/WxbGqSFEBDEY+vfQhS3S9gurv0CANoTajzOSdkl2YTcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nh/uARtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE05DC433C7;
	Mon,  8 Apr 2024 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582439;
	bh=n9x6ok8IImWtzPVDMWsTqfSjXIWwmp0w6UsVUf2qeFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nh/uARtqtvAaLWyZB3KbzutQGuc4qMHBGlLZe+u77ch5ObAK+dIjkws78jfs+j/NP
	 V1HfE6Yio9WXYnd40/rBTlDznOw8egnTl/qLBI28HiouDFL/eieusfNLJYY4JZfOWk
	 JRQcvKCxblUr/tSTPF8vHQqpvyGpRoEqcWBPCv6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/138] s390/pai_crypto: remove per-cpu variable assignement in event initialization
Date: Mon,  8 Apr 2024 14:58:39 +0200
Message-ID: <20240408125259.497391381@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit aecd5a37b5ef4de4f6402dc079672e4243cc4c13 ]

Function paicrypt_event_init() initializes the PMU device driver
specific details for an event. It is called once per event creation.
The function paicrypt_event_init() is not necessarily executed on
that CPU the event will be used for.
When an event is activated, function paicrypt_start() is used to
start the event on that CPU.
The per CPU data structure struct paicrypt_map has a pointer to
the event which is active for a particular CPU. This pointer is
set in function paicrypt_start() to point to the currently installed
event. There is no need to also set this pointer in function
paicrypt_event_init() where is might be assigned to the wrong CPU.
Therefore remove this assignment in paicrypt_event_init().

Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Stable-dep-of: e9f3af02f639 ("s390/pai: fix sampling event removal for PMU device driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_pai_crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 7eb138b07e7be..4b773653a951b 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -213,7 +213,6 @@ static int paicrypt_event_init(struct perf_event *event)
 	 * are active at the same time.
 	 */
 	event->hw.last_tag = 0;
-	cpump->event = event;
 	event->destroy = paicrypt_event_destroy;
 
 	if (a->sample_period) {
-- 
2.43.0




