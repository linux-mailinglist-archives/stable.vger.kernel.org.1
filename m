Return-Path: <stable+bounces-220727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCNkAjZBo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 858E51C6F94
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD90530A5705
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5243FF1CD;
	Sat, 28 Feb 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvcFglo9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D43FF1C4;
	Sat, 28 Feb 2026 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300608; cv=none; b=H7nYV78X0ftg/VcwZh8IhhKsgZbkDt4GBkTVfxBQGT5fG4sPhuoASIApJ52kdFD8wqvwflbMtzQN7l38IjZYxq5NV1c/OejCV1WE021R2KuPZoHYz5Di5Ard9ANuS1su8pCFHSY+WlW7ym/7xY5OHPC0Iv5ISlksgQzvkScDmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300608; c=relaxed/simple;
	bh=rPZ0E3UF0nIX9XVviXncYcH4hqlHR+MaMB1bcTB+E+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfyLHvKn8D2RFR1XQwgqAzjC/Wo/K/AHPmoAKmvAjmJa7ngjx6DdTttwzRlJcTXwJg4WP+2G2hlQbb5sLAkHmLElcteU+cK+XwApLRWgjos5JkdFSEnKzppWnlqkAClh81/Y/LRiYCBxSJKF4NJh3bB0ob/MUN70GaNTRGRJMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvcFglo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB98AC19424;
	Sat, 28 Feb 2026 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300608;
	bh=rPZ0E3UF0nIX9XVviXncYcH4hqlHR+MaMB1bcTB+E+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvcFglo9n7914P5N+GkZ42frC5/yk0aU/0PAJU8zoc2a0bpvj6Tv9Nm1LDw0msf+Q
	 2FYnLiqP2iMQbNww63whEdhps3rgqtaHbDnC7fV28W8KsM2cngx0OiLYXsFOTyjwlI
	 I9DwjuFnWt45s4kVAbsZMwg6gB2DpjWAWpjcsZZripiG7Z/pCrzqCY4h8Gdz0WNHa2
	 iHwjQssdK79P37sqMe8rBiw/Bg8iSszBopSxYEueREGEgjmI1PpOF1YvIwnBdD8TmW
	 fLtf+sJ32WSoX1dIuxrHU4c4lIx5RVkBCegHPl7qOjF3WqE00HKCz3BBaxKr8zjdCK
	 EMqbM/h+U0V5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 648/844] drm/buddy: Prevent BUG_ON by validating rounded allocation
Date: Sat, 28 Feb 2026 12:29:21 -0500
Message-ID: <20260228173244.1509663-649-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220727-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,gitlab.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 858E51C6F94
X-Rspamd-Action: no action

From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>

[ Upstream commit 5488a29596cdba93a60a79398dc9b69d5bdadf92 ]

When DRM_BUDDY_CONTIGUOUS_ALLOCATION is set, the requested size is
rounded up to the next power-of-two via roundup_pow_of_two().
Similarly, for non-contiguous allocations with large min_block_size,
the size is aligned up via round_up(). Both operations can produce a
rounded size that exceeds mm->size, which later triggers
BUG_ON(order > mm->max_order).

Example scenarios:
- 9G CONTIGUOUS allocation on 10G VRAM memory:
  roundup_pow_of_two(9G) = 16G > 10G
- 9G allocation with 8G min_block_size on 10G VRAM memory:
  round_up(9G, 8G) = 16G > 10G

Fix this by checking the rounded size against mm->size. For
non-contiguous or range allocations where size > mm->size is invalid,
return -EINVAL immediately. For contiguous allocations without range
restrictions, allow the request to fall through to the existing
__alloc_contig_try_harder() fallback.

This ensures invalid user input returns an error or uses the fallback
path instead of hitting BUG_ON.

v2: (Matt A)
- Add Fixes, Cc stable, and Closes tags for context

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6712
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Cc: <stable@vger.kernel.org> # v6.7+
Cc: Christian König <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patch.msgid.link/20260108113227.2101872-5-sanjay.kumar.yadav@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_buddy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 8308116058cc1..fd34d3755f7c5 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -1156,6 +1156,15 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
 	order = fls(pages) - 1;
 	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
 
+	if (order > mm->max_order || size > mm->size) {
+		if ((flags & DRM_BUDDY_CONTIGUOUS_ALLOCATION) &&
+		    !(flags & DRM_BUDDY_RANGE_ALLOCATION))
+			return __alloc_contig_try_harder(mm, original_size,
+							 original_min_size, blocks);
+
+		return -EINVAL;
+	}
+
 	do {
 		order = min(order, (unsigned int)fls(pages) - 1);
 		BUG_ON(order > mm->max_order);
-- 
2.51.0


