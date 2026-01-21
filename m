Return-Path: <stable+bounces-210961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNGREak2cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:27:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A25D348
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75DBE829DF9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD525366DCC;
	Wed, 21 Jan 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KB0Vsyu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8A3933FE;
	Wed, 21 Jan 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019968; cv=none; b=SuX0F6w6tt6Ndmupj9aQTjgj3SU/4K6sqkcEZYMAWEQrfoK72fPxz6ZsaZbvJVKSL0WLQhmO2wdNpy1ojAsdyUAQ994n41IjfO7w8QY+6JIbW2QOyRuzd2CdHCuMO6mPRSd6VowQwmxfXIhZLA96RStcfdwVEulrj9a2uilKr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019968; c=relaxed/simple;
	bh=7StmIVjcUlC05xNYA4xJ3G70wpq4WgtBkEbYW/nBLKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1pCsZwMmPKj4sDsHgq1Olq5ce9FJvNGo9ujm4ivBVFHWmdY9DeqBm34q4Syn7ZFjA4AnjUWn3FQj6ZkdvKyWH4WSpvCsOT7ioTlf3wKxX2v3aDP4QmZNFWJMicaJYytgIimGU0WBGnLYicitgarDetG3OqWmuvJIEIscAmpnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KB0Vsyu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199DC4CEF1;
	Wed, 21 Jan 2026 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019967;
	bh=7StmIVjcUlC05xNYA4xJ3G70wpq4WgtBkEbYW/nBLKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB0Vsyu6l4LTRmV0wdbBgiisGo9fPgdiiLoaGD3xQndTapPrMP1qwq/p1Qlp4JSoB
	 RCFYbgZKnasE4jm0DMSdQSyNtGPpba9z+iVzfV3RGsimP4SATQUky4CtP9l1/kLbLZ
	 kvNFJq5I92htF62RviMbS5UYAxBDkNywdCx4w3GI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Forbes <ian.forbes@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/198] drm/vmwgfx: Merge vmw_bo_release and vmw_bo_free functions
Date: Wed, 21 Jan 2026 19:14:08 +0100
Message-ID: <20260121181419.281581448@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210961-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: D86A25D348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit 37a0cff4551c14aca4cfa6ef3f2f0e0f61d66825 ]

Some of the warnings need to be reordered between these two functions
in order to be correct. This has happened multiple times.
Merging them solves this problem once and for all.

Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20260107152059.3048329-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index f031a312c7835..b22887e8c8815 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -32,9 +32,15 @@
 
 #include <drm/ttm/ttm_placement.h>
 
-static void vmw_bo_release(struct vmw_bo *vbo)
+/**
+ * vmw_bo_free - vmw_bo destructor
+ *
+ * @bo: Pointer to the embedded struct ttm_buffer_object
+ */
+static void vmw_bo_free(struct ttm_buffer_object *bo)
 {
 	struct vmw_resource *res;
+	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
 
 	WARN_ON(kref_read(&vbo->tbo.base.refcount) != 0);
 	vmw_bo_unmap(vbo);
@@ -62,20 +68,8 @@ static void vmw_bo_release(struct vmw_bo *vbo)
 		}
 		vmw_surface_unreference(&vbo->dumb_surface);
 	}
-	drm_gem_object_release(&vbo->tbo.base);
-}
-
-/**
- * vmw_bo_free - vmw_bo destructor
- *
- * @bo: Pointer to the embedded struct ttm_buffer_object
- */
-static void vmw_bo_free(struct ttm_buffer_object *bo)
-{
-	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
-
 	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
-	vmw_bo_release(vbo);
+	drm_gem_object_release(&vbo->tbo.base);
 	WARN_ON(vbo->dirty);
 	kfree(vbo);
 }
-- 
2.51.0




