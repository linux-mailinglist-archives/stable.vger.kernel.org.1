Return-Path: <stable+bounces-237553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEp6KFwn3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:26:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9B3F1663
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F36F303F725
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5D7341649;
	Mon, 13 Apr 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uazlPAY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554433D6D5;
	Mon, 13 Apr 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099752; cv=none; b=L8mjQpW1fwxL+nd/PgkNhinjuFW3LDuNDnBeYJB00pMVtCilmEgPSknKmLWyHGuMcvnaK9B+ZWnm+sohCZtGkx+/1P7kvXmUUb1MamTg9WMXU/e0/0+WkLcJPjT9RATt2nFoEd7N7lsxBGGOdck1RdAUpjgK2A+OhgmkL2iTjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099752; c=relaxed/simple;
	bh=Jh8eSMQ2Vz0WxWuY/o6pi/Wu55wWlNIi4kIQQt38DMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Php+TB3kMa/v+FnqBm/8bTrohtI+JcehkrD+8E2uT3rLB0DxYTlcJEuPAsR38Xwu6FENBqxKlaUDOCw8SDVxkkyaXKhMy5W9GrjXxWRKW9ilqDS0aKVCNPWjKHWCZt/XZlW8M8idOTDzzK/HTPM/L2SxmvkfIn3vIKDzHOwLySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uazlPAY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C83AC2BCAF;
	Mon, 13 Apr 2026 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099751;
	bh=Jh8eSMQ2Vz0WxWuY/o6pi/Wu55wWlNIi4kIQQt38DMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uazlPAY7sWXUOzrPDVjw+GfxBrOLAkXJvq/qI6rn3XZC2xNgMBDHtwTJ9VmJ6nRFC
	 E/kmbYuSLenrJ87jQei4HhTw1BrkQplQ7diVPPAhXxUrtCtGtNdJQrJYuaGJ8ypDNN
	 RUwU1sOsWCI10e8BhVZh/h8ShugJtnWmNaBnnJuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 418/491] mm/hugetlb: fix skipping of unsharing of pmd page tables
Date: Mon, 13 Apr 2026 18:01:03 +0200
Message-ID: <20260413155834.675985260@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237553-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BC9B3F1663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand (Arm) <david@kernel.org>

In the 5.10 backport of commit b30c14cd6102 ("hugetlb: unshare some PMDs
when splitting VMAs") we seemed to have missed that huge_pmd_unshare()
still adjusts the address itself.

For this reason, commit 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all
pmds for hugetlbfs when register wp") explicitly handled this case by
passing a temporary variable instead.

Fix it in 5.10 by doing the same thing.

Fixes: f1082f5f3d02 ("hugetlb: unshare some PMDs when splitting VMAs")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8efe35ea0baa7..99a71943c1f69 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5787,11 +5787,14 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	}
 	for (address = start; address < end; address += PUD_SIZE) {
+		unsigned long tmp = address;
+
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		huge_pmd_unshare(mm, vma, &address, ptep);
+		/* We don't want 'address' to be changed */
+		huge_pmd_unshare(mm, vma, &tmp, ptep);
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
-- 
2.53.0




