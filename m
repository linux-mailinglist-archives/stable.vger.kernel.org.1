Return-Path: <stable+bounces-247922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF/NCC5EB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:05:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202A552A53
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D5B030AF086
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511AF2DC334;
	Fri, 15 May 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WIbLk7Mb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345B22FF22;
	Fri, 15 May 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860418; cv=none; b=X3CVV1EBOcIaJQRchi7P8B3acpLVJpsf5HJ2CeV22cwsrgEJFPYi/v/LfdmFhiikrI00RlBrnMC+iOtlll1WNEwrIB1oUfIcY6esyy5Dk/21KiYBV2Mju2eVH9TiIXAQJ6YqH7FwU37/CnkNh+o/nWOJG0ndTj56ymiORkJm8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860418; c=relaxed/simple;
	bh=o3pZ+2C+VyHJqvgU0aimSnB98bks3wHjUDuaXmGZk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnLsXaI1oNVUGLBE+RdQwR7oEFnfiLmIXNMjnSEpPiTYXoNblyHw0KtP+j2HdtdHUeExtA0QSVoZfAYj6QIbwwdbpmajDFoE9ktnmugjbMO6ZziN2m+Tupx2kIeQrnNE/ipUfh1yF+j7sgU2rnCauPpULrrWIxoOZUg3oTJ1/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIbLk7Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A958C2BCB3;
	Fri, 15 May 2026 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860418;
	bh=o3pZ+2C+VyHJqvgU0aimSnB98bks3wHjUDuaXmGZk5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIbLk7Mba1/3Q2NzPcLcWhWGFc9pQKC/p1r7UbxcfoJKYYRhPNSWqGDDutSuwR8cF
	 /y+qmOvntqk/Uf0QT+QkmRo8B+NA7gKxdhm8hBHZRFxf76JAzl0oxP1WPc5b7n1Dym
	 6k5gt6D+uNqhJExdBCLSvcYFUXf1K3rVxpYfSR8o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mattheq Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 081/144] drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()
Date: Fri, 15 May 2026 17:48:27 +0200
Message-ID: <20260515154655.404879386@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9202A552A53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247922-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

commit 111ab678471bf1f90d078d5513bb086b70596c3c upstream.

When xe_dma_buf_init_obj() fails, the attachment from
dma_buf_dynamic_attach() is not detached. Add dma_buf_detach() before
returning the error. Note: we cannot use goto out_err here because
xe_dma_buf_init_obj() already frees bo on failure, and out_err would
double-free it.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Mattheq Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260408175255.3402838-5-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit a828eb185aac41800df8eae4b60501ccc0dbbe51)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_dma_buf.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -299,12 +299,15 @@ struct drm_gem_object *xe_gem_prime_impo
 		goto out_err;
 	}
 
-	/* Errors here will take care of freeing the bo. */
+	/*
+	 * xe_dma_buf_init_obj() takes ownership of bo on both success
+	 * and failure, so we must not touch bo after this call.
+	 */
 	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
-	if (IS_ERR(obj))
+	if (IS_ERR(obj)) {
+		dma_buf_detach(dma_buf, attach);
 		return obj;
-
-
+	}
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;



