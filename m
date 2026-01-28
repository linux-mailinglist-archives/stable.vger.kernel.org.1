Return-Path: <stable+bounces-212610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNVTKfc0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:10:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC0A5350
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4C7323ABCE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AFA285C8D;
	Wed, 28 Jan 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p/A4VOnq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DE3033E0;
	Wed, 28 Jan 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616097; cv=none; b=Yv0jxxL9gdHxVO/gB8wJjv0TOlwU0XjufMeW5vYM81HibYBZNCbrjN93wHm4l02j0xz0LRiqJj+vbaHVtd2/Fr8Jjwhzz05PdRGYUoa3DvtvyRwhL6ZLyMBvg/HZHNloGbDy0XIypZiV3DCp5MmnfzNgU3HVcUcV2nzO9hvA8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616097; c=relaxed/simple;
	bh=PF0/V373qVoTYf67I/rZDaOA+DwtR7XN+ieORdBDVos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgDnSBA0m2YLVGHEIeTXbrWi9q2ajZkqjeRICB4VduxG6UFl5dOCecgsIuOtarsPfydk5zTsgAzxYiB7MZ1ldhQod2HErXW5pv9ecQVSPCrXssjQret6+UWl1mFTYU+kJxlXVuocbZlwFx+kcWVDlsQl2p+fsEDmSl8GOkH9Kdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p/A4VOnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A6EC4CEF1;
	Wed, 28 Jan 2026 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616097;
	bh=PF0/V373qVoTYf67I/rZDaOA+DwtR7XN+ieORdBDVos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/A4VOnqdj9pJyfklejPGh9N8FcxD32/u6e3QUxfzJM1Z6ZAC5x/ZNIkZug3Sj/Il
	 JGLqyA+nvE5BosmFT39HBNqMqHbaVaB9GhBAi3HsXv01JbCsoK/kLd6AqIXzCjzLdn
	 MClKRZ0dZNdyUOfIgyzn9EAez0M7eNfs1f8drK4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 6.18 173/227] drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)
Date: Wed, 28 Jan 2026 16:23:38 +0100
Message-ID: <20260128145350.675725256@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212610-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00AC0A5350
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 604826acb3f53c6648a7ee99a3914ead680ab7fb upstream.

Apparently we never actually filled these in, despite the fact that we do
in fact technically support atomic modesetting.

Since not having these filled in causes us to potentially forget to disable
fbdev and friends during suspend/resume, let's fix it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260121191320.210342-1-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -351,6 +351,8 @@ nouveau_user_framebuffer_create(struct d
 
 static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
 	.fb_create = nouveau_user_framebuffer_create,
+	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_check = drm_atomic_helper_check,
 };
 
 



