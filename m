Return-Path: <stable+bounces-254607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB56CO4EF2rT1QcAu9opvQ
	(envelope-from <stable+bounces-254607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:51:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0845E6379
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06598306417F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39563372EC2;
	Wed, 27 May 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="GGctIw34"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0D3074B1
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893132; cv=none; b=fGxmEB4Hdrex3oNdUJapp9DzclVzeR/FLYM3LaGZkCrixLrqqjWhFf3JJmDAFEXzIMXejHqL9uzPeu8XeNmmKvLTlfHx6COkLZBbzm2rwpsUdw40Er1aFUA+3Z55N/ydx2cA3mbceSZfszKc2ivDS2+gFbwq91oyK/xm/aG9fgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893132; c=relaxed/simple;
	bh=ajg4Nsba04ee04fLh3WFBCK4NGYixkmq1qRWqM+yo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyHDWd7lbk4uvA8pEd7zpsqZ9mCxwc5DhYWGxc0EcgPBpEx673sjTpd6Mg05rweLok6n7E3+7Mb1N3NmsfSgbpoml1pyHBV3MM6WKbU6SrwyH4OJACsL3MYpgNL++Kj4QmjJIbC4pu/K4jOMm+QgR9O5BvZMlHkMgUi2PYxTU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=GGctIw34; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779893129;
	bh=hG1lWNbeUjBtC1lSP2ZjSpLTXw35ebgcjZMiyjrD1GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGctIw34oNtgfFO69/vXYdvhDCB7C0jAQ/lTnn3GQRH9IrL1UyUp0vNuNd3GXiPrG
	 77PizUrs3VvUzf2D9X3p+zrP3XYRejYpmtLXyFwCvuklfDjWWMm5JZtLlwbDEtmaDw
	 cbcwcJ9krUsoOs9xKjJFRy3eXcrHl0Mf/mO8FJEU=
Received: from stargazer (unknown [IPv6:2409:8a4c:e1b:e231:5a6e:b99e:242d:222b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 06F60659C8;
	Wed, 27 May 2026 10:45:25 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y 6/8] drm/amd/display: Fix dc_is_fp_enabled name mismatch
Date: Wed, 27 May 2026 22:44:26 +0800
Message-ID: <20260527144428.1095001-7-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144428.1095001-1-xry111@xry111.site>
References: <20260527144428.1095001-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254607-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[xry111.site:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,xry111.site:email,xry111.site:mid,xry111.site:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3D0845E6379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 57ce498faa1e4d358bf44b5df575874c22922786 ]

Fix incorrect function name in comment to match dc_is_fp_enabled.

This function checks if FPU is currently active by reading a counter.
The FPU helpers manage safe usage of FPU in the kernel by tracking when
it starts and stops, avoiding misuse or crashes.

Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 8ba9b4f56f87..172999cc84e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -59,7 +59,7 @@ inline void dc_assert_fp_enabled(void)
 }
 
 /**
- * dc_assert_fp_enabled - Check if FPU protection is enabled
+ * dc_is_fp_enabled - Check if FPU protection is enabled
  *
  * This function tells if the code is already under FPU protection or not. A
  * function that works as an API for a set of FPU operations can use this
-- 
2.54.0


