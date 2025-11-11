Return-Path: <stable+bounces-193121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E33C49FAA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6241883999
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DEA246333;
	Tue, 11 Nov 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYNpcXH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBC4C97;
	Tue, 11 Nov 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822348; cv=none; b=gv1RusJ+kGd1dOGevXQWVV6e1ui5NFK+OdQiCPjgLHLHPxEqpohIoEttSNZlmI0cbaGJ98pAL0eF8e57bnQt+HvdMA53IqzohLwVg2E+RbO6//QLR7pVo2SYOMku/UzoULpMjTbbv+SNW4liXAE+NSqDx174vbBbFUbQduB1yHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822348; c=relaxed/simple;
	bh=LeGgMlEm07JV+uKnEAqmN7Gfz8OPYabgiVM8feizpC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM2vQWCn0oVs0EiGV927cVCG6nsRjmkEgoL+cRPJGwvkGY9Q9GyZw80PyGZ8rR+Hawc6t+nzPitAy18vIsjQkclUUDQUJl7Oo64vbv4Z5GjqcvSzIrR1DhwI/WbBR+/tKfEpcT7MPOj7DU69uO3NEhJST4qP855K8KXueSCDvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYNpcXH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E550FC4CEF5;
	Tue, 11 Nov 2025 00:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822348;
	bh=LeGgMlEm07JV+uKnEAqmN7Gfz8OPYabgiVM8feizpC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYNpcXH8Wn5HkMxsZEadOkoTNqVQOyhhfYNyDxjM+hqhkL21T/fdIoEeBDbTZf61C
	 oN4juzHwofD/4RvogaSyFsL8rA96RRdGOlj0GCiD5I7rSQ72OmW7GhhqX/Zsjbsxdc
	 q9p51UEaXaelP/Yq6bl894+kbSpK0lBhf908UL+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akash Goel <akash.goel@arm.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.17 090/849] dma-fence: Fix safe access wrapper to call timeline name method
Date: Tue, 11 Nov 2025 09:34:20 +0900
Message-ID: <20251111004538.589812859@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akash Goel <akash.goel@arm.com>

commit 033559473dd3b55558b535aa37b8848c207b5cbb upstream.

This commit fixes the wrapper function dma_fence_timeline_name(), that
was added for safe access, to actually call the timeline name method of
dma_fence_ops.

Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Akash Goel <akash.goel@arm.com>
Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the rules")
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Link: https://lore.kernel.org/r/20251021160951.1415603-1-akash.goel@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 3f78c56b58dc..39e6f93dc310 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1141,7 +1141,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 			 "RCU protection is required for safe access to returned string");
 
 	if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
-		return fence->ops->get_driver_name(fence);
+		return fence->ops->get_timeline_name(fence);
 	else
 		return "signaled-timeline";
 }
-- 
2.51.2




