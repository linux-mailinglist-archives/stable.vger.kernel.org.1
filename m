Return-Path: <stable+bounces-219954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAmSBsySoWnhuQQAu9opvQ
	(envelope-from <stable+bounces-219954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:49:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDCF1B759A
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A607301F19B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5E2441A6;
	Fri, 27 Feb 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z81e2zqJ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4131961B
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196553; cv=none; b=fyE2Cg3XPI0pNxXFZc5+SQD5+8a95+Rr+cF1lWJBTqV4JqlmEaza1UOyPhRXg4tB49h7/WygW0uHQTgE2rrbaSvI+KhQR8jKVx8flYl3gTjY/VfniOFr5NPZcsZQeRtEW/FOuG+CV6LCgm+YV3GFCrGLuuAJAmCjJnQ2MlBQl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196553; c=relaxed/simple;
	bh=bSFRJZJ310hkH0mXmm7xxXeHEk1fR5P3Y1Odh6ava2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y47FtCpOc9OjTn7tbD/Zs0X++eB8ZFEJn0s8Gg47/4q3OTlOInAT/HFgb/uZWOFJsR82vA3f0PH+wVCOj/Ux20QJP76MYAVSxhcXoUJqDSs+qoFORNTo4AI3LE0KChTH5iPVkA8yrgVaKe6darJWr5lpNjGjWZ7ONPJEFVtcQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z81e2zqJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UmmffV71sbbvZ4GQqm2PxnvbMPlyEsIZdwYLM2swre8=; b=Z81e2zqJXBgdBKdbfbGaB+gzti
	vGlaZpD/QQDVrkhyTgF1lrh9piWnOMla1g1uohuzjAk3R3NOmvwkNHXpc63wJUkGjCNgzJu8lVxKU
	ZZJA+auE6VF9IoKHBQQ0ZKFylW3leJWSO36q9LUMK6umQ7FeV9fWBhL+njiS2nrT1dU6nThBEmrAL
	WhYzJhWKjo20tODFqoWs+bi3uqE8e0xt9uZurB2kjDmcYa9bc0nFTcZOdP8fE5HIjq9y3Fkh3gEaS
	ZQDNc3dZauMcmcUlu5ccNM4dWqGjIrJqKvG83Z2bafV4nbBXxkfXOFG3mk7xKMo9oXyK6IXAlctXa
	zz19krWQ==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvxHE-006WMl-3v; Fri, 27 Feb 2026 13:49:04 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Fix ttm_pool_beneficial_order() return type
Date: Fri, 27 Feb 2026 12:49:01 +0000
Message-ID: <20260227124901.3177-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219954-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 6CDCF1B759A
X-Rspamd-Action: no action

Fix a nasty copy and paste bug, where the incorrect boolean return type of
the ttm_pool_beneficial_order() helper had a consequence of avoiding
direct reclaim too eagerly for drivers which use this feature (currently
amdgpu).

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 7e9c548d3709 ("drm/ttm: Allow drivers to specify maximum beneficial TTM pool size")
Cc: Christian König <christian.koenig@amd.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.19+
---
 drivers/gpu/drm/ttm/ttm_pool_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
index 82c4b7e56a99..24c179fd69d1 100644
--- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
+++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
@@ -17,7 +17,7 @@ static inline bool ttm_pool_uses_dma32(struct ttm_pool *pool)
 	return pool->alloc_flags & TTM_ALLOCATION_POOL_USE_DMA32;
 }
 
-static inline bool ttm_pool_beneficial_order(struct ttm_pool *pool)
+static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
 {
 	return pool->alloc_flags & 0xff;
 }
-- 
2.52.0


