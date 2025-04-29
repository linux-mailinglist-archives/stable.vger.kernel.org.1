Return-Path: <stable+bounces-137313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85945AA12C2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055084A53D2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E524C067;
	Tue, 29 Apr 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDZhY1m1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C4244679;
	Tue, 29 Apr 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945695; cv=none; b=oog7EyuDto7cWKfqtJPiFzbS7SXrOPg7LmyLAEDSIEFRcwCOFlwJgaes5MJYxmv1Mop+17CfHvOCcvE5HyITTB/tKrPxB2JBgCe7ZWTTTpWRTYKNNaMU3KSaQngg3SV5Afy2zyqig+AmkvDC0T8HErVT3iR7IkXCLvul/wCHja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945695; c=relaxed/simple;
	bh=RANYuYNSGY3U7R6uHrrkFAqzMo8JwLnoC/GEhmMsMq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJX5IANXOnnZr0b6aWi0Q0I1OBlKNvPRRe9tTQhroQm2Kl28ue7YmhEE+5t/NcnTQx27ZBdZirATp+kZSJ1bLzx9SNLuWID4+gpaNO4MnF4eQpqpYCRU8EwH+0DiAqFqtxpej70+sBBjWrqmnvVCF1I2c8uxM+Pg8z0iBUbD5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDZhY1m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E9DC4CEE3;
	Tue, 29 Apr 2025 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945695;
	bh=RANYuYNSGY3U7R6uHrrkFAqzMo8JwLnoC/GEhmMsMq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDZhY1m1IPSQFJd+vno5VxLvvqLLM/3pbdy3iz+q4aS8qf1lYm6057QvAfMPf0sNC
	 NPKIuqPR21hk1kAwSMJnUMu8GC6HUdDsRtye/cW8GQBpQ/VaqmzSmDGJzi6nRTcoXT
	 IKa2c0z63ngtEAmrojhlgKYB3Uesn/8LvjJO6TRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li RongQing <lirongqing@baidu.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 004/311] PM: EM: use kfree_rcu() to simplify the code
Date: Tue, 29 Apr 2025 18:37:21 +0200
Message-ID: <20250429161121.205444213@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 1618f635bdf56f3ac158171114e9bf18db234cbf ]

The callback function of call_rcu() just calls kfree(), so use
kfree_rcu() instead of call_rcu() + callback function.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/20250218082021.2766-1-lirongqing@baidu.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 3ee7be9e10dd ("PM: EM: Address RCU-related sparse warnings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/energy_model.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3874f0e97651e..72655eff6fc52 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -161,14 +161,6 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
-static void em_destroy_table_rcu(struct rcu_head *rp)
-{
-	struct em_perf_table __rcu *table;
-
-	table = container_of(rp, struct em_perf_table, rcu);
-	kfree(table);
-}
-
 static void em_release_table_kref(struct kref *kref)
 {
 	struct em_perf_table __rcu *table;
@@ -176,7 +168,7 @@ static void em_release_table_kref(struct kref *kref)
 	/* It was the last owner of this table so we can free */
 	table = container_of(kref, struct em_perf_table, kref);
 
-	call_rcu(&table->rcu, em_destroy_table_rcu);
+	kfree_rcu(table, rcu);
 }
 
 /**
-- 
2.39.5




