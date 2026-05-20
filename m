Return-Path: <stable+bounces-251191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HAqDB4YDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:22:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F9599822
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F074324B587
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC93A3833;
	Wed, 20 May 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NgnUC/Ld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D18347512;
	Wed, 20 May 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297337; cv=none; b=AhnqBGqqu5fItU4rE0UTcPLpVLGzHk85cm5BOEXAWWYRjDozuhF0jpDFCN3YyOYO5DbELfpgYocD8iQl/GCFl63hIJrqx0Pk/Li9CUV6wWR3hvg8CqCmuCOnFTnsL+HilEOTuEhlET/k2PEkOMoJcNEPn54smpFkZJaLMTxBZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297337; c=relaxed/simple;
	bh=X4/WeDS7VSO7ZvjK0M0/b24Ud0ISeBJHCf3zKevNdXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9rPkCYOD5bP6oJFp+NITU1Iwmg4iAwsYTwS2AIWnzNQKT5eQeDEDr2g5GQinCvyqIS0uXhQ9+m/LnbIpvT/qI/YpC1gF1Bgx9B4kAn+rDShsrm9cbN+JA8738ly/q+jqkuQ70ITCsFDnhDfqOvVS6ma+eY5XGtuL5ypk9xseFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NgnUC/Ld; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E08E1F00893;
	Wed, 20 May 2026 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297336;
	bh=2gjZmZCviHuawBNnpoS7CFujlo9II6+xEUM9DY+wGyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgnUC/LdPEnfJFiYR/SEI+bTM10IRj7f90WoNexvXMJmtAWbFJP3YL+V8D+ga69wq
	 +7MhyghpWi8Clunff1QW5kwus27RLn50c877UhytR+2Q1FMPQqAqS0vRN7g1gRGRF5
	 oUwN8mKiONEAVAhmipHvAWT+KwJpA3+T3QfPR3K0=
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
Subject: [PATCH 7.0 1133/1146] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to -ENOSPC
Date: Wed, 20 May 2026 18:23:03 +0200
Message-ID: <20260520162213.891807759@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251191-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,lankhorst.se,kernel.org,amd.com,lists.freedesktop.org,linux.intel.com,lankhrost.se];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,lists.freedesktop.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,intel.com:email]
X-Rspamd-Queue-Id: 853F9599822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -740,7 +740,7 @@ static int ttm_bo_alloc_resource(struct
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
@@ -398,8 +398,11 @@ int ttm_resource_alloc(struct ttm_buffer
 
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



