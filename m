Return-Path: <stable+bounces-251059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK1NBszsDWo04wUAu9opvQ
	(envelope-from <stable+bounces-251059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:18:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C7593453
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DE0A3162FA5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76A3DD528;
	Wed, 20 May 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJwVCUD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78735F619;
	Wed, 20 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296995; cv=none; b=mhN75F1VBU1V4r5MXY4pus2XjRYvWJ73MvpwQBin9CtCfj8NUSREmvWKpv/UtMzCWAEHIOFzlSmHqtP9ynsS2FwXxbBjkgsv112qJXnbBNmmChP0vLWFa0I7ccTTnRS+W6e8tdezGN/zTn6tYfKopl8zfjYcH4JQC6m+xxjluGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296995; c=relaxed/simple;
	bh=OTUw56Tsn84dixGxlXTHr4zarcgaXQCoaG1wgBXrEjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ1aN5xCrvWXAsp1FwRaA5jxVc3C+N/Pp8mJ9yBJtOpHdpte4tRISC8b6QUWiXDJg5YB72NQJdPAIG6GhD00M8b90vzevb20MxtOxq7BYJD9FCBLzymAxMT1LVFhvpA7zR1r7Yh4iQA8awtu5+lwbHCJkmKSuEDBtoyURMNVD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJwVCUD3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DE91F000E9;
	Wed, 20 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296993;
	bh=jJgVeuC9LkdSzWtiVkPzlOf1Aq7iaLlw8tvFZxVmxgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJwVCUD3786B2jGzugGqaa/3yHXzTzIZBHSHToGi9gqJWuyJ2+LknoVzfeFUHrsmK
	 jt3fivMVfg7i/yC+yprFL8Mm6XsFXr6z8h2qjz8OVS+WTX1EL9CMQVm57gqMrTgaI7
	 r7HH1GFAZeXV4q5V87wZVVUSjhNwjtmnSEcLow5E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 1011/1146] drm/xe: Fix potential NULL deref in xe_exec_queue_tlb_inval_last_fence_put_unlocked
Date: Wed, 20 May 2026 18:21:01 +0200
Message-ID: <20260520162211.114572172@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251059-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 851C7593453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit f8c4151d50b12923b67819ebf03c1c6782c984c1 ]

xe_exec_queue_tlb_inval_last_fence_put_unlocked() uses q->vm->xe as the
first argument to xe_assert(). This function is called unconditionally
from xe_exec_queue_destroy() for all queues, including kernel queues
that have q->vm == NULL (e.g., queues created during GT init in
xe_gt_record_default_lrcs() with vm=NULL).

While current compilers optimize away the q->vm->xe dereference (even
in CONFIG_DRM_XE_DEBUG=y builds, the compiler pushes the dereference
into the WARN branch that is only taken when the assert condition is
false), the code is semantically incorrect and constitutes undefined
behavior in the C abstract machine for the NULL pointer case.

Use gt_to_xe(q->gt) instead, which is always valid for any exec queue.
This is consistent with how xe_exec_queue_destroy() itself obtains the
xe_device pointer in its own xe_assert at the top of the function.

Fixes: b2d7ec41f2a3 ("drm/xe: Attach last fence to TLB invalidation job queues")
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260409003449.3405767-1-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit 96078a1c68bf97f17fd1d08c3f58f5c5cc9ccd65)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 8ecdf949f9e4c..3a60a2fb9cf96 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1574,7 +1574,7 @@ void xe_exec_queue_tlb_inval_last_fence_put(struct xe_exec_queue *q,
 void xe_exec_queue_tlb_inval_last_fence_put_unlocked(struct xe_exec_queue *q,
 						     unsigned int type)
 {
-	xe_assert(q->vm->xe, type == XE_EXEC_QUEUE_TLB_INVAL_MEDIA_GT ||
+	xe_assert(gt_to_xe(q->gt), type == XE_EXEC_QUEUE_TLB_INVAL_MEDIA_GT ||
 		  type == XE_EXEC_QUEUE_TLB_INVAL_PRIMARY_GT);
 
 	dma_fence_put(q->tlb_inval[type].last_fence);
-- 
2.53.0




