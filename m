Return-Path: <stable+bounces-231391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PD8HSily2mhJwYAu9opvQ
	(envelope-from <stable+bounces-231391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE4D368346
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BA3A30EB8B3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915043A75AC;
	Tue, 31 Mar 2026 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf+9/QaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BE29D281
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953183; cv=none; b=AQQdp7Nh+PqtePfzEovzhEhlYoIWhsXzKFtuv8yZ0KLxObmobJC6LK4HvjcuXZJoLNoOfAWMRvrCi04G/UpwhrnBMrBzvsoFJDXxIrSzkbHYIOkk+qmvxf41eR1NVe8YLK+EE+a5VdG8lbpI/sfKnPbTLgrGU6XwwGfS0zk9cYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953183; c=relaxed/simple;
	bh=kLmbVdu/BXacw1J2Jn+sIS1O5IlKQvG5ppWJoa1iSp8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmaQCEsjakzPGw+NW4n7q2u4GeV8eJcTYpyJk1956FEJwWQZ+9QbnVVBOfM0GoWGVNM6GgrE1fR69JWtUpEyyp2jaAXXKgyr16mbGZYDLxo+R3+sNSYb9cMeZvEWTyCM+v2uo3HN/7scXPCEk19nDS7Slz73B1Wh6OEDRUj51cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf+9/QaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB944C19423
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774953183;
	bh=kLmbVdu/BXacw1J2Jn+sIS1O5IlKQvG5ppWJoa1iSp8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Gf+9/QaZs6jy1Gd5H8E5aBEYuVXWxeugISVxzq3SrY3dP7vRz3y5J1kFosm/PyJFS
	 NsHtZ9l09gf+7QLvMFu30CFp+X0SWQ5OQz+PoLrBrnhan6PM5Avme1bQCP/994Gqbl
	 SdE4rPTButKadU/UQXV2lmYpPOBref5TsazywWWKgWQZF123qrI79voqxI8p4DWZqN
	 gYksBNsVm+CiNI39fTBo5kY9shB3bjSZDfoCy1iFBKJzX2mJjLOn6eWaV2tu8Qn9Dd
	 l6sclgznBZ2k+hHrGxnK+J2eouyWKSRYOiXTGQBy57cndXLzrLnkgkfN3n4kclIgpG
	 okpssmBaXHnVg==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] mm/mseal: update VMA end correctly on merge
Date: Tue, 31 Mar 2026 11:31:55 +0100
Message-ID: <20260331103155.92038-1-ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033044-debug-embargo-40fb@gregkh>
References: <2026033044-debug-embargo-40fb@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231391-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,bluedragonsec.com:email,chromium.org:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: DDE4D368346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously we stored the end of the current VMA in curr_end, and then upon
iterating to the next VMA updated curr_start to curr_end to advance to the
next VMA.

However, this doesn't take into account the fact that a VMA might be
updated due to a merge by vma_modify_flags(), which can result in curr_end
being stale and thus, upon setting curr_start to curr_end, ending up with
an incorrect curr_start on the next iteration.

Resolve the issue by setting curr_end to vma->vm_end unconditionally to
ensure this value remains updated should this occur.

While we're here, eliminate this entire class of bug by simply setting
const curr_[start/end] to be clamped to the input range and VMAs, which
also happens to simplify the logic.

Link: https://lkml.kernel.org/r/20260327173104.322405-1-ljs@kernel.org
Fixes: 6c2da14ae1e0 ("mm/mseal: rework mseal apply logic")
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reported-by: Antonius <antonius@bluedragonsec.com>
Closes: https://lore.kernel.org/linux-mm/CAK8a0jwWGj9-SgFk0yKFh7i8jMkwKm5b0ao9=kmXWjO54veX2g@mail.gmail.com/
Suggested-by: David Hildenbrand (ARM) <david@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 2697dd8ae721db4f6a53d4f4cbd438212a80f8dc)
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/mseal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index e5b205562d2e..c561f0ea93e8 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -56,7 +56,6 @@ static int mseal_apply(struct mm_struct *mm,
 		unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma, *prev;
-	unsigned long curr_start = start;
 	VMA_ITERATOR(vmi, mm, start);
 
 	/* We know there are no gaps so this will be non-NULL. */
@@ -66,7 +65,8 @@ static int mseal_apply(struct mm_struct *mm,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
-		unsigned long curr_end = MIN(vma->vm_end, end);
+		const unsigned long curr_start = MAX(vma->vm_start, start);
+		const unsigned long curr_end = MIN(vma->vm_end, end);
 
 		if (!(vma->vm_flags & VM_SEALED)) {
 			vma = vma_modify_flags(&vmi, prev, vma,
@@ -78,7 +78,6 @@ static int mseal_apply(struct mm_struct *mm,
 		}
 
 		prev = vma;
-		curr_start = curr_end;
 	}
 
 	return 0;
-- 
2.53.0


