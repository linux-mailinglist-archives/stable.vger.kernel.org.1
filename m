Return-Path: <stable+bounces-228409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGZjFv1LwWmKSAQAu9opvQ
	(envelope-from <stable+bounces-228409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DC2F432C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94F9731A4D4A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB153ACF0E;
	Mon, 23 Mar 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iv13iF9z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43123BCFD;
	Mon, 23 Mar 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275038; cv=none; b=AGezeC1iFs22KO8wtMlX00ZfxQM9VX6WGvoTzaeCmTn7dKhTnri/6a5vQHwjrv7Um3MlKQH4RpRjcy5TsX1zWHUpQL4ZMdCdCpj2pVWnJujSr9ogV8l8vvPSFQeDRnLCg4P2BO4HsXac3IDL/Gft27sGzhRSTHxSDhtaHVXqs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275038; c=relaxed/simple;
	bh=KuD/AT/qe3T6V3N8cluVoYGSFzcPhNZq7uhFsfvThPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ6wAWOu47YnGhxw8Fpul2xq6JElNJfV3/B0wIVtpgBljVedGspewn47+0DU5NeHzOg1iUdRIF6zcSx6wO2FOrZk7Zo6cE1lzDsrSj/xraEXCTHupazNL1jcsYIpJI/wlOql/j0ZW2yOJR3kTLbYaOeTSwJIlI3SRWKn3uRP4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iv13iF9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E670FC4CEF7;
	Mon, 23 Mar 2026 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275038;
	bh=KuD/AT/qe3T6V3N8cluVoYGSFzcPhNZq7uhFsfvThPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iv13iF9zwruyIpSgk7X2TofLMArRwRYUWU1OnGqPqoLdyfVcs/vogRsYyCibL3Umj
	 p87YVch9HZj8oVfAvSoqygeBIQqTrWIgLj+GQNRYD3bEzEnGwjBF/pa8HekTvFJAQW
	 1pchBAi+aL0ABHx6gPl05OGlA89x87kh2TmzpKBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 200/212] drm/vmwgfx: Dont overwrite KMS surface dirty tracker
Date: Mon, 23 Mar 2026 14:47:01 +0100
Message-ID: <20260323134510.110751354@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-228409-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C05DC2F432C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit c6cb77c474a32265e21c4871c7992468bf5e7638 ]

We were overwriting the surface's dirty tracker here causing a memory leak.

Reported-by: Mika Penttilä <mpenttil@redhat.com>
Closes: https://lore.kernel.org/dri-devel/8c53f3c6-c6de-46fe-a8ca-d98dd52b3abe@redhat.com/
Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/20260302200330.66763-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 535d844191e7a..3e8a2f4a907da 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -768,7 +768,8 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 		ret = vmw_bo_dirty_add(bo);
 		if (!ret && surface && surface->res.func->dirty_alloc) {
 			surface->res.coherent = true;
-			ret = surface->res.func->dirty_alloc(&surface->res);
+			if (surface->res.dirty == NULL)
+				ret = surface->res.func->dirty_alloc(&surface->res);
 		}
 		ttm_bo_unreserve(&bo->tbo);
 	}
-- 
2.51.0




