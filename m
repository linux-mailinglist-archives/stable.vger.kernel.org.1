Return-Path: <stable+bounces-224945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LabEwces2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:11:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD3278939
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D0293012B74
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE33FFAB5;
	Thu, 12 Mar 2026 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GK2UbOQB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0438C423;
	Thu, 12 Mar 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346308; cv=none; b=KVfN64CY83fqlJ8a/XpeDrK6rmNuyBPv2g72LCvSBmaP/QjmipgF2O1zeg8pKpQ7HHGq7JYn3mMNdBA1tTm8X3dCX24nDDWpMPoPmCNnoULzkquE9ahRHCP1+9onsgojxKu2aiqLGrkY/0rCrxQ1QCx6maPIL4K+e9LJ1gl4rP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346308; c=relaxed/simple;
	bh=lZGLq/RRVHkFpqwsfF4Qltw8XpRzcMpDX2uztGwBjcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6yrBuZXDXTxxZOWplDHOcha/wBjSKUFFi9/5WQZYMSN10nJwwIftxSSSXQ0z12zK/+KuGm0WHazWHIZ2cKS+GJXv50T4VTMjViTA43jdt1Ez1tgiTTUKCkwynpT3dn0bL3If+Qaesbnp4xXsg9XMxUs+OwwU72cYpf103Dwyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GK2UbOQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD899C4CEF7;
	Thu, 12 Mar 2026 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346308;
	bh=lZGLq/RRVHkFpqwsfF4Qltw8XpRzcMpDX2uztGwBjcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GK2UbOQBxvyQ4FM6sjjIbiSe96iG0XvqWoTo29xHCkWiT/Qd3oN48VfxhCcYBiaD+
	 Q1/O8C8GUMvlF5/Jo2+ZaFAYJS0kaNYp1dvs24Fg6MUjmSj+RGS8Z5KfLoOJuTGZnR
	 58QzfccYKJg+UM4DwdKFhH9cr6qEaZxPYOeoTku0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuzey Arda Bulut <kuzeyardabulut@gmail.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 002/265] drm/vmwgfx: Return the correct value in vmw_translate_ptr functions
Date: Thu, 12 Mar 2026 21:06:29 +0100
Message-ID: <20260312201018.224936188@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,broadcom.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-224945-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,broadcom.com:email]
X-Rspamd-Queue-Id: E4CD3278939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0c1bd3acf3598..6b921db2dcd23 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1161,7 +1161,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	ret = vmw_user_bo_lookup(sw_context->filp, handle, &vmw_bo);
 	if (ret != 0) {
 		drm_dbg(&dev_priv->drm, "Could not find or use MOB buffer.\n");
-		return PTR_ERR(vmw_bo);
+		return ret;
 	}
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
@@ -1217,7 +1217,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
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




