Return-Path: <stable+bounces-210959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIVBAL00cWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:19:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF625D065
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1C7C82994A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9BA3A35B9;
	Wed, 21 Jan 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTLrv+ja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C634A783;
	Wed, 21 Jan 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019961; cv=none; b=FhDefz4jvBetQWxmNPOlgXz/RiY/IGz6JUCKAb7hocXXTBhm0ehrDOjLLdlU+7cSQdvi1gW/sc35f1dvwwt85P1YOEfTutZ/YieugO5JirLE2AA6YaeAKlcNzXGiWHSosquZEMKFX3yeFlBbnoJF6UFYZsbCfKmyW/DjCDRfGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019961; c=relaxed/simple;
	bh=HZe7uo34VVqp1p5S0ryb7w1Od/uoK9w8/nniKxHWtqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSsdKYThxuKujfZ0pNJy9e4jzRgom9Og8F7ENcFbwbqrqBW5+gJMPMDeifnMS7LPERzX4bVvfyGLqJ1X+KMT+aJrilXh9q1HmWPtaDN/MUCrdGz++GvTopNWvvRqugUKeuDTMYOLYxFGBTzMoPUEKeoR8JLwuNFnhCFaHfp+5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTLrv+ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB620C4CEF1;
	Wed, 21 Jan 2026 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019961;
	bh=HZe7uo34VVqp1p5S0ryb7w1Od/uoK9w8/nniKxHWtqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTLrv+jaRgkyiRIkqW8tIBxObgFrAr/Pi6OhBGJHBv7mPMi8IiXFjm/RsD8zxUwgb
	 UUwP6EK6n57USHZRa21y1WblNgCZU5WZYRN4HbMh9ce+6rBa9hhFC0Nt1BnTVOJ9sU
	 mEzsspPtfgq35hfIkJ5EO26GAbfeobljKUODJgvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Forbes <ian.forbes@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 019/198] drm/vmwgfx: Fix KMS with 3D on HW version 10
Date: Wed, 21 Jan 2026 19:14:07 +0100
Message-ID: <20260121181419.244204750@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-210959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,broadcom.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8FF625D065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit d9186faeae6efb7d0841a5e8eb213ff4c7966614 ]

HW version 10 does not have GB Surfaces so there is no backing buffer for
surface backed FBs. This would result in a nullptr dereference and crash
the driver causing a black screen.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20251114203703.1946616-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 54ea1b513950a..535d844191e7a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -763,13 +763,15 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 		return ERR_PTR(ret);
 	}
 
-	ttm_bo_reserve(&bo->tbo, false, false, NULL);
-	ret = vmw_bo_dirty_add(bo);
-	if (!ret && surface && surface->res.func->dirty_alloc) {
-		surface->res.coherent = true;
-		ret = surface->res.func->dirty_alloc(&surface->res);
+	if (bo) {
+		ttm_bo_reserve(&bo->tbo, false, false, NULL);
+		ret = vmw_bo_dirty_add(bo);
+		if (!ret && surface && surface->res.func->dirty_alloc) {
+			surface->res.coherent = true;
+			ret = surface->res.func->dirty_alloc(&surface->res);
+		}
+		ttm_bo_unreserve(&bo->tbo);
 	}
-	ttm_bo_unreserve(&bo->tbo);
 
 	return &vfb->base;
 }
-- 
2.51.0




