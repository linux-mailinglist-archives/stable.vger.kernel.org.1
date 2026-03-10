Return-Path: <stable+bounces-223867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECUFGzH7r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:06:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24252249F78
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 802C030379E5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92F3806C1;
	Tue, 10 Mar 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmA391uF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B7381B07;
	Tue, 10 Mar 2026 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140770; cv=none; b=Z0akZeSGW1TCFe3nakkBT2vxUGzJyMZyKyHHfF6W2wjRmB80R90UJTFO7sfvRjZ5iCNbSOuK+IqrYBejRSGkLgyUI9w0gfPlQgclTZV+d41CfsOjx0FckErKJkMX44FylGbMjunU8ISznn4zO0oLkPmn4MmAJ0IDxKp7iVTyAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140770; c=relaxed/simple;
	bh=7Ub6PDtqOw1QpeiF7sT+qTep445WVEzaBOPEIg7qrUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVFmk2C+tfEx3nhiaPruQ1lQ/OgENIzP+VDzXBLG4uHNvu9N7NGYN7oxotOPpcszF64JCwntHtWR5s+MuRWugl9pILs86N4HWPnx14/PCDCSePbTqix303D7ABt6rJYR8mqzHDFWVqCefzCe/t9Ym5DUtQkKWO0UsDm9pHvJhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmA391uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB38C2BCAF;
	Tue, 10 Mar 2026 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140770;
	bh=7Ub6PDtqOw1QpeiF7sT+qTep445WVEzaBOPEIg7qrUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmA391uF6B3YxtNHu54w9sbv69z/XOX3ulDAKBCnAKXBRdboMaM/kAwZKMnNmY7sU
	 hZeWynjqrFHSqPwi4zzAlbIXTmoErQt5SlPr1z59fsR2qiOXDS61LA6gLF8iTiO0Pu
	 pAc6ocM2W0cCasOYY48sxyygJ/cKXfGj2eOawCcJgqKkQ6kDvQ/zaNHKRGWH5A/qG0
	 Rfo3hZeuVswwe4Xi53LqHsl306n/oTwtocCjTH9LlwfqUEjOgUG5K6BFeE9vI7D7Mk
	 W/RQbvN6DbCKwy+cuM1SC2aEowQoYZQOXfF2Ap0WR+TaZKEzI2Oh5vlgadKtFndEsX
	 S6iqOD5E2xflQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ian Forbes <ian.forbes@broadcom.com>,
	Kuzey Arda Bulut <kuzeyardabulut@gmail.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 003/311] drm/vmwgfx: Return the correct value in vmw_translate_ptr functions
Date: Tue, 10 Mar 2026 07:00:50 -0400
Message-ID: <7e1e0e810ff1221b8475a67d18b55242c54594d6.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 24252249F78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223867-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit 5023ca80f9589295cb60735016e39fc5cc714243 ]

Before the referenced fixes these functions used a lookup function that
returned a pointer. This was changed to another lookup function that
returned an error code with the pointer becoming an out parameter.

The error path when the lookup failed was not changed to reflect this
change and the code continued to return the PTR_ERR of the now
uninitialized pointer. This could cause the vmw_translate_ptr functions
to return success when they actually failed causing further uninitialized
and OOB accesses.

Reported-by: Kuzey Arda Bulut <kuzeyardabulut@gmail.com>
Fixes: a309c7194e8a ("drm/vmwgfx: Remove rcu locks from user resources")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20260113175357.129285-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 3057f8baa7d25..e1f18020170ab 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1143,7 +1143,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	ret = vmw_user_bo_lookup(sw_context->filp, handle, &vmw_bo);
 	if (ret != 0) {
 		drm_dbg(&dev_priv->drm, "Could not find or use MOB buffer.\n");
-		return PTR_ERR(vmw_bo);
+		return ret;
 	}
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
@@ -1199,7 +1199,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 	ret = vmw_user_bo_lookup(sw_context->filp, handle, &vmw_bo);
 	if (ret != 0) {
 		drm_dbg(&dev_priv->drm, "Could not find or use GMR region.\n");
-		return PTR_ERR(vmw_bo);
+		return ret;
 	}
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM,
 			     VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM);
-- 
2.51.0


