Return-Path: <stable+bounces-252156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHQKO+36DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A23595C23
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C80530D660E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A43F7ABB;
	Wed, 20 May 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZWCr2eI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0730675C;
	Wed, 20 May 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299937; cv=none; b=V6i66sjK4J2sYdQfEC5BJzuocdoufjJYD2NGXtK3NOUhNW/Te8gb/G4Oku4alHmZGQcMUdPsEZG66jrD8q9TGRqDJ/apEgvSVnh27ScJ8v45/z9ayH+J9HLJNIvREb346VnEKq3rkdhzFHuewSyc0IEXTuRBnMnv1Ng9OdryHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299937; c=relaxed/simple;
	bh=Jj2DZ3GIYaiYcIB+FrG+aaXoP5Z1Nahb+jHnfXFu6zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgYWqgqHGRUoQDhQryaKMpN/xi1BsOdVAiKwcKvNDcKruLiXMUEQefV0V52b5RMhnrOUKEMB2VHnAX2cTXTSaujO6GwjF3qz5sT7UGQj7J4x4rf9v4+FO7Dfz4PrsIqseWWdOuPzj0HYqzumjM7TMfbhp/tOwKY8kjsc7A6RQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZWCr2eI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE4D1F000E9;
	Wed, 20 May 2026 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299936;
	bh=KmII14Q4iAsySlNF3g37ylRU9+NXih6R0HpwrGXsy/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vZWCr2eIu+LHP0RC9wSg8exRrlop1XQeqCKLHolHKCjDVoos5U29dtJk4r3rwgmvW
	 plYEqS/GMuM5zyXk4Lszg6hf+Oo8+LQ5mw5JwN4m/+1f0N0IrnShE/063kESdE/4qR
	 DVgS/dO2P+O74IA6MDLjtJNdCJt30/j861aEkgvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Tejun Heo <tj@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Christian Koenig <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <dev@lankhrost.se>
Subject: [PATCH 6.18 944/957] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to -ENOSPC
Date: Wed, 20 May 2026 18:23:47 +0200
Message-ID: <20260520162155.072238355@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,lankhorst.se,kernel.org,amd.com,lists.freedesktop.org,linux.intel.com,lankhrost.se];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252156-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,gmx.de:email,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 91A23595C23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 591711b32681a04b57d00c2a404658f8419a081c upstream.

dmem_cgroup_try_charge() returns -EAGAIN when the cgroup limit is
hit and the charge fails. TTM has no concept of -EAGAIN from resource
allocation; -ENOSPC is the canonical error meaning "no space, try
eviction". Convert at the source in ttm_resource_alloc() so no caller
needs to handle an unexpected error code, and clean up the now-redundant
-EAGAIN check in ttm_bo_alloc_resource().

Without this, -EAGAIN escaping ttm_resource_alloc() during an eviction
walk causes the walk to terminate early instead of continuing to the
next candidate.

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.14+
Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Maarten Lankhorst <dev@lankhrost.se>
Link: https://patch.msgid.link/20260508160920.230339-1-thomas.hellstrom@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c       |    2 +-
 drivers/gpu/drm/ttm/ttm_resource.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -739,7 +739,7 @@ static int ttm_bo_alloc_resource(struct
 		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
 		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
 		if (ret) {
-			if (ret != -ENOSPC && ret != -EAGAIN) {
+			if (ret != -ENOSPC) {
 				dmem_cgroup_pool_state_put(limit_pool);
 				return ret;
 			}
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -384,8 +384,11 @@ int ttm_resource_alloc(struct ttm_buffer
 
 	if (man->cg) {
 		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
-		if (ret)
+		if (ret) {
+			if (ret == -EAGAIN)
+				ret = -ENOSPC;
 			return ret;
+		}
 	}
 
 	ret = man->func->alloc(man, bo, place, res_ptr);



