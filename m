Return-Path: <stable+bounces-226936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCt7Etz1uWnnPwIAu9opvQ
	(envelope-from <stable+bounces-226936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F22B4AE5
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF623095206
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB29288D2;
	Wed, 18 Mar 2026 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/nCumVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E063CB
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794776; cv=none; b=I7Ghqhs5ZBjOeOUK7M89UeGYkx3psaUSVtUQXc+I/oYDSzFUay4dRr+pUTge8sUucjCXyHAuF36Af6T4YEUgI3QNwQD2BPL3T/Lno78Loy4skXsNjVXww6rXmzHFMiu4cPtnIZUEjFxMUyV/Mp8fyGGZCVy5iVPCe4S7LO28qSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794776; c=relaxed/simple;
	bh=eAIW0NLSs7I2HlAHQYgfD0jDSACpMI4lS2o1gFyNMAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIzYH5/gcwwSjT0nzYhnHzKnUox0XY8Y57VShQUhVHJTC1dza27MpYmxm5pvqB59FcYIZO4al8RGlZwKz8WqBWQL9DGOBpAQ+lp++FVwlcEqaYu+Wwi+tiokYDLRDt7k86gKjd1sd8eiNWSC/Yck8lZBE2FyrNpJM/Y8hiR1Oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/nCumVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE75BC4CEF7;
	Wed, 18 Mar 2026 00:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773794776;
	bh=eAIW0NLSs7I2HlAHQYgfD0jDSACpMI4lS2o1gFyNMAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/nCumVgSivs+aB2puRpmQOFRijxIA0ai45xa4u3no+kShus57+A+y6UKfy20W23E
	 jCcJVrk1Yon08TPxqxWdBSVmAq2RuHii6S/82X3WMUbyCoH+XSTzwomciPe7iOz52Z
	 8FI3aAkyNGWpJTNr29AZ+kyTimEZcVfZUE/3rN/P0EqQJY/l+/EChp/LHz7RHqMpD1
	 FnkMUDjfqrUa0B6RgGVddNuAyq+jmd1bf/ugQpBcEFSbFnxf15uLw79jn9PQArEC3W
	 FRYzMlMqmGQoYY+nkMB6vaxftzERVc/ChoIIke2Cn3rft50xp/lH+3aM+jChp0QEiP
	 mZJn7E3Mes7FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/xe/sync: Cleanup partially initialized sync on parse failure
Date: Tue, 17 Mar 2026 20:46:13 -0400
Message-ID: <20260318004614.407161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031722-spectrum-cocoa-0d75@gregkh>
References: <2026031722-spectrum-cocoa-0d75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226936-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 963F22B4AE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 1bfd7575092420ba5a0b944953c95b74a5646ff8 ]

xe_sync_entry_parse() can allocate references (syncobj, fence, chain fence,
or user fence) before hitting a later failure path. Several of those paths
returned directly, leaving partially initialized state and leaking refs.

Route these error paths through a common free_sync label and call
xe_sync_entry_cleanup(sync) before returning the error.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260219233516.2938172-5-shuicheng.lin@intel.com
(cherry picked from commit f939bdd9207a5d1fc55cced5459858480686ce22)
Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Stable-dep-of: 0879c3f04f67 ("drm/xe/sync: Fix user fence leak on alloc failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_sync.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index d48ab7b32ca51..04c2f44ce0147 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -146,8 +146,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 
 		if (!signal) {
 			sync->fence = drm_syncobj_fence_get(sync->syncobj);
-			if (XE_IOCTL_DBG(xe, !sync->fence))
-				return -EINVAL;
+			if (XE_IOCTL_DBG(xe, !sync->fence)) {
+				err = -EINVAL;
+				goto free_sync;
+			}
 		}
 		break;
 
@@ -167,17 +169,21 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 
 		if (signal) {
 			sync->chain_fence = dma_fence_chain_alloc();
-			if (!sync->chain_fence)
-				return -ENOMEM;
+			if (!sync->chain_fence) {
+				err = -ENOMEM;
+				goto free_sync;
+			}
 		} else {
 			sync->fence = drm_syncobj_fence_get(sync->syncobj);
-			if (XE_IOCTL_DBG(xe, !sync->fence))
-				return -EINVAL;
+			if (XE_IOCTL_DBG(xe, !sync->fence)) {
+				err = -EINVAL;
+				goto free_sync;
+			}
 
 			err = dma_fence_chain_find_seqno(&sync->fence,
 							 sync_in.timeline_value);
 			if (err)
-				return err;
+				goto free_sync;
 		}
 		break;
 
@@ -216,6 +222,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 	sync->timeline_value = sync_in.timeline_value;
 
 	return 0;
+
+free_sync:
+	xe_sync_entry_cleanup(sync);
+	return err;
 }
 ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
 
-- 
2.51.0


