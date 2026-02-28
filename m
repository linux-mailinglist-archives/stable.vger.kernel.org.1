Return-Path: <stable+bounces-221048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F2pMHBNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10A1C82A8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695E330C9DEA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B624C040A;
	Sat, 28 Feb 2026 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMPiVDC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFD4C0405;
	Sat, 28 Feb 2026 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301391; cv=none; b=joJvUZqCwPBKMcnoR3l+/mFZ0iTw/bjBVGqlT6mNsNes9Z0BC0F5x0wQIr64IoxAKN+MA/QVqdKkhA1hHdcZQ3ZZPH9DEJeIOTjLp8SabcSaHhcKcMX+7Vg0+gLdItD/DF56TTCbtQq30nEvTJhIolYkZTVM21QLFCiRo28ermk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301391; c=relaxed/simple;
	bh=4+6XYPFog2/mZcMOM50n0plDhfAHYpcy+28mivGvDkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdMejP2EdstChlc2ZfnNgfFiGCKfX+6SWNKgJd8YIjkrJ+HcZEKfHRSCyiCHFf0btHEqyNQSINgT4654S0ocmzS27IwCPZzEUutS6TaJm9MjNS10rShvJjimWjpNiay6JK0zcqORrotSwmzGN5Doz78ns7fwVlG7J9Q19NyljeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMPiVDC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A50C2BCAF;
	Sat, 28 Feb 2026 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301391;
	bh=4+6XYPFog2/mZcMOM50n0plDhfAHYpcy+28mivGvDkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMPiVDC5YAV9hwgoKv6Eq6OhmxevSzTWJCJ+lVUlBMFbkOQcWkq7VHn6MVSOUIivq
	 DXlPGq7/UmLWupwFyQZiYaKVmyafPBWCRrEgWcjetLDH5/PRspi8lxRFnsu3P0UL20
	 6B4bS1sDyj7LedLmyIjZZL5s4wOPHZZgSBd/JvJJgCDAnU8xFw4/ME5kssxUDRcesj
	 f9ZBS1wwFxTfXANfMmSh9/NIHg4pRuoimhekS/j+grWq8GiTgRReQhLLvpZ0yIkYnR
	 VVdAHzEMQoXhk3/odxMHCJ+1tqb3riAMVGxct/Mc3NozKoMdHxpF9Ta0yH9d2S8RKz
	 739hHzRYbBWoQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 579/752] drm/buddy: Prevent BUG_ON by validating rounded allocation
Date: Sat, 28 Feb 2026 12:44:50 -0500
Message-ID: <20260228174750.1542406-579-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221048-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,gitlab.freedesktop.org:url,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 3C10A1C82A8
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
index 3f1a9892f2a39..640d93070bb7c 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -1155,6 +1155,15 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
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


