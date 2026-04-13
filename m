Return-Path: <stable+bounces-237479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GsxOBsk3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:12:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB003F100F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 806CE30B0CDA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6E325490;
	Mon, 13 Apr 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kDgWbFug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466A3203B6;
	Mon, 13 Apr 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099561; cv=none; b=Qh7Gra+CORuLqINUjZFQ+WTvis/9HSvLLffUxKi2VFbA+owHNKWkXCZkqkIc4UmDH0tGEVNupTE5lZA8jt9ivFeEcSjkxpCwc6OzzaheJe80BhLwuEsOzRFnZuq/3R5iYUOwwqBsk0IdPnADjUB6cd0eKWHphIPQy+h0sXaA6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099561; c=relaxed/simple;
	bh=9Dip2lUNe56WJDLRZ5H5BzENCif2zWLL4i8CNDlzoXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMCuj/8CkQz0f6Biwu4wcv+AdNgyqXK2N5+96SHqlXa3F5JgrlSCxHKdrFA/abfzqb4ElEflPOPoOHWv9wbL0ytSTjw45zrS2USf2Aezr2O9lh9mRSxFlIyxoPUJcFCe9c/nHHa1UMKz2BK8Zz8wC5kN/IuwAVQQ/MpIoFT/8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kDgWbFug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760DAC2BCAF;
	Mon, 13 Apr 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099560;
	bh=9Dip2lUNe56WJDLRZ5H5BzENCif2zWLL4i8CNDlzoXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDgWbFug8Re2f5T3geBu0WbkdVymkCClbS232cpH3l7ArMCQi6ToAYB41yjeQuhh3
	 0YDv0Lyrac2sC/ao0tBONH7tbsKoxcOdXsind1BSSXQQU3RnzXlPtt8/bGajQ0rOv0
	 TEg5IFyRNXl0P9/CvnXpGOJ6mV7t42oL9nnxV7d0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 355/491] Revert "drm/vmwgfx: Add seqno waiter for sync_files"
Date: Mon, 13 Apr 2026 18:00:00 +0200
Message-ID: <20260413155832.329434416@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237479-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CB003F100F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 7db6c88bb52f3b7525a06110cfd208990c49f8b4.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 26 -------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 361f96d09374d..daea547704ddc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -4039,23 +4039,6 @@ static int vmw_execbuf_tie_context(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/*
- * DMA fence callback to remove a seqno_waiter
- */
-struct seqno_waiter_rm_context {
-	struct dma_fence_cb base;
-	struct vmw_private *dev_priv;
-};
-
-static void seqno_waiter_rm_cb(struct dma_fence *f, struct dma_fence_cb *cb)
-{
-	struct seqno_waiter_rm_context *ctx =
-		container_of(cb, struct seqno_waiter_rm_context, base);
-
-	vmw_seqno_waiter_remove(ctx->dev_priv);
-	kfree(ctx);
-}
-
 int vmw_execbuf_process(struct drm_file *file_priv,
 			struct vmw_private *dev_priv,
 			void __user *user_commands, void *kernel_commands,
@@ -4249,15 +4232,6 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 		} else {
 			/* Link the fence with the FD created earlier */
 			fd_install(out_fence_fd, sync_file->file);
-			struct seqno_waiter_rm_context *ctx =
-				kmalloc(sizeof(*ctx), GFP_KERNEL);
-			ctx->dev_priv = dev_priv;
-			vmw_seqno_waiter_add(dev_priv);
-			if (dma_fence_add_callback(&fence->base, &ctx->base,
-						   seqno_waiter_rm_cb) < 0) {
-				vmw_seqno_waiter_remove(dev_priv);
-				kfree(ctx);
-			}
 		}
 	}
 
-- 
2.53.0




