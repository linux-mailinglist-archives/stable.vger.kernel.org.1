Return-Path: <stable+bounces-255931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEmfADynGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F485F9139
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A16A330022D5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1633368B5;
	Thu, 28 May 2026 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVqYKdqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51525F7B9;
	Thu, 28 May 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000280; cv=none; b=qaweosIOR02uGCVuocOE5udg/k7++LxCNIqccjX8F61N+1KHfQtl75YjAH4VKKO0w1A3ZAqrOqhJbmS+eimxFZnHJzBhXj/FlIAc/5YrlJNtEko1KeOCVuxnnzySGE1VSO7jhmvRWD/ZEjEksOx10Y78u12dAr5q40+uaajLx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000280; c=relaxed/simple;
	bh=t1h/3Q5uOzIQZV8x/muCJwUEnGP3NsuB3B+cZPOMTnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfbNkvh47OKnsvnkVcXYpJmtO0YW2czvqpBlH613tLLTFPPGCw3emk+RiRWcdYSkPxzqI0MHe8RsYZ9956ctXnEmUOhO5WVGqUM6UsRl6WfrvEPtqGOOFlXIWOnKyMYWFtlMs1ylPHXTJB7KY77EB5JgYMMM6ygGPjmyNjTc1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVqYKdqi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFCF1F000E9;
	Thu, 28 May 2026 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000279;
	bh=qIl0QUdHi/15NQrmgimJA6lrbr8xoHILgLUC/W1GupY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zVqYKdqifEgVn3d+folqWsoeeoUPi8G96oMaN5K3DOXLCot3EYXuOZrsaraC4VpJb
	 Dhyp9P1RRkBpYS6+sU13lNLhFOeNZ7HdX7pNoqHlAEllBs80KsR3+9SK8kTWrID2zV
	 qZGtZmZmeZvdfKQEMJaek+xCVq/EQnppqgngK0Rw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 367/377] drm/xe/oa: Fix exec_queue leak on width check in stream open
Date: Thu, 28 May 2026 21:50:05 +0200
Message-ID: <20260528194649.051780585@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255931-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A0F485F9139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 4d25342543c01310fc4e0cba7cb17c775e2421e2 ]

In xe_oa_stream_open_ioctl(), when param.exec_q->width > 1 the
function returns -EOPNOTSUPP directly, skipping the existing
err_exec_q cleanup path. The exec_queue reference obtained by
xe_exec_queue_lookup() is leaked.

The exec queue holds a reference on the xe_file, which is only
dropped during queue teardown. The leaked lookup ref is not on
the file's exec_queue xarray, so file close cannot release it.
This keeps both the exec queue and the file private state pinned
indefinitely.

Jump to err_exec_q instead of returning directly so the reference
is released.

Fixes: f0ed39830e60 ("xe/oa: Fix query mode of operation for OAR/OAC")
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patch.msgid.link/20260514203210.593488-1-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit 339fa0be9e4a5d69fa47e91f4a36574224fb478f)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_oa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 98bfb127eafca..7d04591e297a8 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -2043,8 +2043,10 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		if (XE_IOCTL_DBG(oa->xe, !param.exec_q))
 			return -ENOENT;
 
-		if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
-			return -EOPNOTSUPP;
+		if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1)) {
+			ret = -EOPNOTSUPP;
+			goto err_exec_q;
+		}
 	}
 
 	/*
-- 
2.53.0




