Return-Path: <stable+bounces-179870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73BB7DF28
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B80D2A00E4
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8F1DE894;
	Wed, 17 Sep 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWQZCTvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD91337EB9;
	Wed, 17 Sep 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112664; cv=none; b=Zi0Q9syJvgBwZ2K3kJcXiHEe7XFu7q5YPCk3rn7esZI3aXBYA7+kE4QFdu+9KJkTwKE+SGFbZHaumKtAYrszzPheg/872vZ7vE9BloGaQhvZKqkoEQ/ktyLn+jpyvlif6yP57Txf28sI/lLwBulO0zGWC/6rJeR66V/9O+Fap9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112664; c=relaxed/simple;
	bh=exKJOFmVKY/kmer3Iv8Rgk3EFOG0qubH9/JBy7tJNBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi5NMqcg+fsyY1rEHWoMGjrIxxNfXboM21Wcy3k+oNfpLJDgQCt8cpnMPyGxuPrjEDZXpF2E7JB/ntVn50deg19yM+6UAtoftUsf3WSIAWQnBdcwI8zSLPOtAZcTeHI5cLn3rab7jZ7kuhFq9OaQonaTu1B9EJxaAtGNbM71WUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWQZCTvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38650C4CEF0;
	Wed, 17 Sep 2025 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112664;
	bh=exKJOFmVKY/kmer3Iv8Rgk3EFOG0qubH9/JBy7tJNBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWQZCTvZaQM3Y7slf+d+UWEDBdTB8vEu6E1UD8Z3EnIG9UVsv87p+Sch+Jr9dbVLD
	 OhLQsWgbZpGPWhXCFeHwGB2MUUewCp8+q1GEinSExnTEUyj/BqyiAyYTflf1e8RdsL
	 E+klb9H8qRGv7qwwo0mFbM5fXrC7aI0wGfHOBruM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 038/189] s390/pai: Deny all events not handled by this PMU
Date: Wed, 17 Sep 2025 14:32:28 +0200
Message-ID: <20250917123352.789878516@linuxfoundation.org>
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

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 85941afd2c404247e583c827fae0a45da1c1d92c ]

Each PAI PMU device driver returns -EINVAL when an event is out of
its accepted range. This return value aborts the search for an
alternative PMU device driver to handle this event.
Change the return value to -ENOENT. This return value is used to
try other PMUs instead.  This makes the PMUs more robust when
the sequence of PMU device driver initialization changes (at boot time)
or by using modules.

Fixes: 39d62336f5c12 ("s390/pai: add support for cryptography counters")
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_pai_crypto.c | 4 ++--
 arch/s390/kernel/perf_pai_ext.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 63875270941bc..01cc6493367a4 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -286,10 +286,10 @@ static int paicrypt_event_init(struct perf_event *event)
 	/* PAI crypto PMU registered as PERF_TYPE_RAW, check event type */
 	if (a->type != PERF_TYPE_RAW && event->pmu->type != a->type)
 		return -ENOENT;
-	/* PAI crypto event must be in valid range */
+	/* PAI crypto event must be in valid range, try others if not */
 	if (a->config < PAI_CRYPTO_BASE ||
 	    a->config > PAI_CRYPTO_BASE + paicrypt_cnt)
-		return -EINVAL;
+		return -ENOENT;
 	/* Allow only CRYPTO_ALL for sampling */
 	if (a->sample_period && a->config != PAI_CRYPTO_BASE)
 		return -EINVAL;
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index fd14d5ebccbca..d65a9730753c5 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -266,7 +266,7 @@ static int paiext_event_valid(struct perf_event *event)
 		event->hw.config_base = offsetof(struct paiext_cb, acc);
 		return 0;
 	}
-	return -EINVAL;
+	return -ENOENT;
 }
 
 /* Might be called on different CPU than the one the event is intended for. */
-- 
2.51.0




