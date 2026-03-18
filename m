Return-Path: <stable+bounces-226937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMxzOOD1uWnnPwIAu9opvQ
	(envelope-from <stable+bounces-226937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A602B4AEC
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5ACA30927C0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61F19CC28;
	Wed, 18 Mar 2026 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb6rXJT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7763CB
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794777; cv=none; b=LRyL7Ob1LrdwwpriqXSdJlArORGPpJqDsNeXy+hJNtNDbahRZ63ckNEd3jACKM3T4uptkbAMizdwnFadSl85+j4HZPtun1gu+4uGIvYKkCNhuFhzOn6WPYdY871MfgXyVc73SUnku2LOu+RlQ25fquqtLjzcUmBnlF9RV9WbWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794777; c=relaxed/simple;
	bh=q4RZwHYlh1AIIVgFs9YR/SooUq5UnLLRrujp94XtdPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN/qxsWDI6B3iLSfrydjnxbxGTOIRDQ8Ys9zbbtFtIms6kwnDebnkbJiRE6I6s4MBGnfdt0V4GClDOJXAKyOPvKON5gSavPoWB3+tpHxTUoCanWB9OuuyVRA/9Lc5ILAuDKKwezBde6E1j3KgYnTTA7FzjXq44xhXG8SuIubV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb6rXJT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E7C19425;
	Wed, 18 Mar 2026 00:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773794777;
	bh=q4RZwHYlh1AIIVgFs9YR/SooUq5UnLLRrujp94XtdPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rb6rXJT9fFML3oox7V4GLy5zp83sCfuwvLt54kamA8ZAHQzNo5Ja7DAv+AamuGN5W
	 6PjE7ShBBKEELbBu83bMdYe+i2z5Sr8TP5Yxc9MnSC1+c9J9DOws7Yw42hFL9IE++F
	 Ume5SW02Zdk7InTQGSCcPmRl8Evp3MniLK3pcfUGh/Jlt0Y3lWsrvTzLIVcn4g24Wz
	 uEtsI7u+EiKChsytaS+wTvZFrDZkr1gEvTwyeo8fgT+S+tn0ppeLkq9X3jF4xo+EYl
	 LMvUyRoSdXmTaiW/ekhcv9U9dturVHGKynpU+EOKlR+QlbqeyvaTd3jy5BGrtKfyod
	 ejedPqNPl1eDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/xe/sync: Fix user fence leak on alloc failure
Date: Tue, 17 Mar 2026 20:46:14 -0400
Message-ID: <20260318004614.407161-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318004614.407161-1-sashal@kernel.org>
References: <2026031722-spectrum-cocoa-0d75@gregkh>
 <20260318004614.407161-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226937-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 65A602B4AEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 0879c3f04f67e2a1677c25dcc24669ce21eb6a6c ]

When dma_fence_chain_alloc() fails, properly release the user fence
reference to prevent a memory leak.

Fixes: 0995c2fc39b0 ("drm/xe: Enforce correct user fence signaling order using")
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260219233516.2938172-6-shuicheng.lin@intel.com
(cherry picked from commit a5d5634cde48a9fcd68c8504aa07f89f175074a0)
Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 04c2f44ce0147..90944218a5906 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -206,8 +206,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 			if (XE_IOCTL_DBG(xe, IS_ERR(sync->ufence)))
 				return PTR_ERR(sync->ufence);
 			sync->ufence_chain_fence = dma_fence_chain_alloc();
-			if (!sync->ufence_chain_fence)
-				return -ENOMEM;
+			if (!sync->ufence_chain_fence) {
+				err = -ENOMEM;
+				goto free_sync;
+			}
 			sync->ufence_syncobj = ufence_syncobj;
 		}
 
-- 
2.51.0


