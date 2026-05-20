Return-Path: <stable+bounces-252048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKFKLqz5DWq75AUAu9opvQ
	(envelope-from <stable+bounces-252048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF50595925
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 101FE30DAA6E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84953F44CD;
	Wed, 20 May 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Us6G3qBL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912223F0A83;
	Wed, 20 May 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299609; cv=none; b=h26el/rrxSUYuVxHRoWjh3MFRKda20xDSehAq6WBXd7twXJPAQNOsQ6F+mavP+Fe5UHDvwLQJLYHX1yWnFa8NictSKcDZgUpN20cmTapgJq2t1/kyUBgGanMZSVgL3jkwlYsMpYqpZMQ9infC82wLgaHIibBD8SxEC4Bc11E1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299609; c=relaxed/simple;
	bh=Sd7Dvc9rvbQNh5/mbTqiLhR48g62d1gGw5esoGV0oXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paMa2GhpgHbDdaW+b26MmbWUw1cIDbnJloTVSySxopSW2BM0z2dQR4EZRjb4kftkDNmebziyzIaAvEnfTicwfPtvYHAnNwAyui3p9gy5JtZQo1sWOTILajdTmUkCfftzkmqLJvidVJfuIWdFtWZXWZqlWg1zfcJtORtxH7D1hYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Us6G3qBL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C6F1F00893;
	Wed, 20 May 2026 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299608;
	bh=nPlSxMS3WNYI+CTv9NRObhh8rjfxvxPDrtDLn46J4Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Us6G3qBL7SrcXZbc2zWKa37pgIB233EBwE/CKelBVIskdty1cmQlQtLRdARsoZv/M
	 aIrFIYjHgkMCCIYbFC6ZJj7SNbuEvdF805MfJmxyqF2Qx5hHGclviWaVoAJJtjs7iM
	 dHxknUMQ/ET+cAWCOev/90V/CR6tJfZDwixiXQ8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 835/957] drm/xe/gsc: Fix BO leak on error in query_compatibility_version()
Date: Wed, 20 May 2026 18:21:58 +0200
Message-ID: <20260520162152.672323119@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252048-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: BFF50595925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 3762d6c36549accea7068c4a175483fafdd03657 ]

When xe_gsc_read_out_header() fails, query_compatibility_version()
returns directly instead of jumping to the out_bo label. This skips
the xe_bo_unpin_map_no_vm() call, leaving the BO pinned and mapped
with no remaining reference to free it.

Fix by using goto out_bo so the error path properly cleans up the BO,
consistent with the other error handling in the same function.

Fixes: 0881cbe04077 ("drm/xe/gsc: Query GSC compatibility version")
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patch.msgid.link/20260417163308.3416147-1-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit 8de86d0a843c32ca9d36864bdb92f0376a830bce)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 83d61bf8ec62e..8371ec002e4ed 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -166,7 +166,7 @@ static int query_compatibility_version(struct xe_gsc *gsc)
 				     &rd_offset);
 	if (err) {
 		xe_gt_err(gt, "HuC: invalid GSC reply for version query (err=%d)\n", err);
-		return err;
+		goto out_bo;
 	}
 
 	compat->major = version_query_rd(xe, &bo->vmap, rd_offset, proj_major);
-- 
2.53.0




