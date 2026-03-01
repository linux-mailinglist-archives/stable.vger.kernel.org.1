Return-Path: <stable+bounces-221405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB8+G4WWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22AD1CACAB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBB0330817C5
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B995280CD5;
	Sun,  1 Mar 2026 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYNEqeiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9F430BA3
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328177; cv=none; b=n4A11ZGR5YD3zZnFbepNY2BBWCpHpfWE/D3FAVegbXo8lZxCh2DeTIC4i5QrCrqem5hpstPvCOCsAoOnJNSadB3pL/kHVSHE7Kg+wyvxFro43TdDMArxJHk6zdbhx6yzaAHqVNVAabIn+1xT855r0j+s1LCAI13P2wv/TR5NROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328177; c=relaxed/simple;
	bh=CD22GsfcD8LTC/ZqADJ6I6CL4lJ5jv2EThLz1A8XVO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=spjopO794EmrCnkniMEk4Fw+TGYXPfv/7GiHgHlhIsdjooXlQw1US52bYcREVvAqczfYF77L9WXzF+I0yTtH8wXKT0PYdSFBGU+DwMyVUquWyXkYQ8RQJgkAd/uQPXWZ6R9V3U/P/BPS56Sf/IE/YwfcZzZDwfFoCfagqtbdc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYNEqeiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC20C19421;
	Sun,  1 Mar 2026 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328177;
	bh=CD22GsfcD8LTC/ZqADJ6I6CL4lJ5jv2EThLz1A8XVO8=;
	h=From:To:Cc:Subject:Date:From;
	b=XYNEqeiE5QaEJrxH8psddDAI1+OhQVaYx0rPuNRU5F7ZXsmNJaNTzAsuFa66VsHPx
	 lCpXOv6D3v1k36pgPOhWbx1+NZmq9F60JNuvGvR4hY32YYStVUPDa2z88fJhilLaxL
	 HtF+aZqYvb4PkVKS51tSP5QspGFJPpXJIp0utbJwyqQzbos+FAUzclXjXkDD69nyKx
	 XXM8tox2eOYmSp5Cl2BJXIE+GWs/x9ajMVFLkCxNIdElJi6KQDDp4JTPyy9yfLh5x6
	 fMzunvdPzMCq6yhWo0XZFYr6q1WXZvzFrwH7O+h6I1l2VLnkTm2O0fAK5966pCLgty
	 IVxrPtP9jLYCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sanjay.kumar.yadav@intel.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/buddy: Prevent BUG_ON by validating rounded allocation" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:22:55 -0500
Message-ID: <20260301012255.1679520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221405-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url,msgid.link:url,amd.com:email,intel.com:email]
X-Rspamd-Queue-Id: D22AD1CACAB
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5488a29596cdba93a60a79398dc9b69d5bdadf92 Mon Sep 17 00:00:00 2001
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Date: Thu, 8 Jan 2026 17:02:29 +0530
Subject: [PATCH] drm/buddy: Prevent BUG_ON by validating rounded allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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





