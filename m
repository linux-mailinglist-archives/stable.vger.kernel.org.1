Return-Path: <stable+bounces-236738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGc8Ah4f3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-236738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFC3F0048
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20729319B0AD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96A12E11B9;
	Mon, 13 Apr 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmEKxcTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AB26CE32;
	Mon, 13 Apr 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097666; cv=none; b=FNvykYEdAsNkkLlpesGrGGqeZ/oWeIm4N37lcYXWGibNABAiMa4Ik+JxpdC3gCNBCH9BLKaBnTD2mCp0bIoS8idSz6S6u5N+LnM3yESs9QYl6W8CAecUcjJkQVCfBk8E+gaRjEraSeNxNmQWE5rt71x5q29HLk5wdZuYnzkMj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097666; c=relaxed/simple;
	bh=jTaSkeW9QzkKj7vuINH+HjReSLrbvKkJyMyPVhlK6Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4Wikh8MwgfuLDAWv3VKovqtFI1NGW+n/phBkkG679vS98HtTjzcnX+4DFskKHglNBJQI/HQnGnivx9ZoVOTDVmACMgRXYnJWXo3FZkzilbJmdper/gxziD+oz3y4TMf+WJNMC4Lb6UqjNs82mQ41avPB012uSO0qd7YXSHb8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmEKxcTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422E9C2BCAF;
	Mon, 13 Apr 2026 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097666;
	bh=jTaSkeW9QzkKj7vuINH+HjReSLrbvKkJyMyPVhlK6Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmEKxcTsEyhFfW+Ds6UZ5361W9HcBtI28z0iq6rYvm7W0KOABGSFxXqYoH2qYnLtN
	 1hG3JRb60q2Qy6EQVm7CWWbiUns+Y6HY9kyFDR+M0enVnJyVxkhlxF85HBWHVM4Jtf
	 0bC8RVqYeL0QQ3TFxojgzK1J3xGLk/60zkVrT4CY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 5.15 224/570] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Mon, 13 Apr 2026 17:55:55 +0200
Message-ID: <20260413155838.846303776@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236738-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,samsung.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,samsung.com:email]
X-Rspamd-Queue-Id: 5BBFC3F0048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

commit d4c98c077c7fb2dfdece7d605e694b5ea2665085 upstream.

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -251,19 +251,26 @@ int vidi_connection_ioctl(struct drm_dev
 
 	if (vidi->connection) {
 		struct edid *raw_edid;
+		struct edid edid_buf;
+		void *edid_userptr = u64_to_user_ptr(vidi->edid);
 
-		raw_edid = (struct edid *)(unsigned long)vidi->edid;
-		if (!drm_edid_is_valid(raw_edid)) {
+		if (copy_from_user(&edid_buf, edid_userptr, sizeof(struct edid)))
+			return -EFAULT;
+
+		if (!drm_edid_is_valid(&edid_buf)) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
-		ctx->raw_edid = drm_edid_duplicate(raw_edid);
-		if (!ctx->raw_edid) {
+
+		raw_edid = drm_edid_duplicate(&edid_buf);
+
+		if (!raw_edid) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "failed to allocate raw_edid.\n");
 			return -ENOMEM;
 		}
+		ctx->raw_edid = raw_edid;
 	} else {
 		/*
 		 * with connection = 0, free raw_edid



