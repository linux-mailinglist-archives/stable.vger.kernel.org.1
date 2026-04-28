Return-Path: <stable+bounces-241635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGvbOAic8GmGVwEAu9opvQ
	(envelope-from <stable+bounces-241635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E5483F56
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B40CF3005987
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C53AF641;
	Tue, 28 Apr 2026 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwOKDpiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BE2D1931
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375847; cv=none; b=WtBHAZFeQGOw+MFU8MJZ/omiLhy62FOwZWk3bU13L1yLc44dJwnGQxhu9etC0Df9iubY1N/hP2Ik3TTWVpQ/GCAGBLbMI80XIhdowXMfCPIPaC9BVa9IopqkuowBojXJN10zL/XnKmr1h+WfMgaIaaVDHA0hc+DBhvN8bQJiR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375847; c=relaxed/simple;
	bh=x6Uv0MthFJaHnLCh7NMFD66PD52OOBjgYxHvakLPsCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuPEQ5a75S/acWJZDJpxQiOX6AlT7Rd0ih9eHiwsHX9jljMEggLyQHBGmHimZrgnXzf6O+rSvv4NRg/vWstniAtdB0HQaajMdFg/ry/JoJFVDQRoTntnhsjr7hOPMkwRjnvk9AjVp9XDQaJcTglaQNxz8YY4Hrbl/FOVxWDGbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwOKDpiq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso6149270b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777375845; x=1777980645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Ct8Le8BV/CkL7dz/X4QUOvjolhlSF4pzodVhQ1Ejs=;
        b=gwOKDpiqnfhnEBAqJ5EOR6rE1Yj7oKrUgCM41ITyn02vpvgjkLxtNd7/mlaovvOoTn
         xnEX9j5qJqQ+yWO+G662xyDnb/YXX855eC6Sc7OAlKtqnfZxKpwPmP73a7ttYqcpzNg+
         hWJE5jBoTBxQts8jVi0uh6CblFHVGUOtcB75BC568NWef2wyV69fKRwwNF818HvvCtxv
         T9bec4fYgFAyQ5ueubuMpVX22F6m62iJyztPG/sfycUuL5tr8AtAehIoxOXkd591tC3l
         U29VAtr1h3IMCYM7WjbuxXRn/JlixWZAfCrrNFgqgWR1wqJaiRfuO4jdou/F/3EcYiTK
         mcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375845; x=1777980645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1Ct8Le8BV/CkL7dz/X4QUOvjolhlSF4pzodVhQ1Ejs=;
        b=cMuL8z74poc1lFNnj9fTpYhmLaxYD0xHSfH8Bes5toprcD8/8Fwpd2nvrPs+jF8Wq0
         pLjhb5cv2TC7uU8GrRLxOK2pSJ3zWFepwI+GK3yw3ZIeyXo+D78/pjOlwRYiNZond08v
         EoSQVvTMH9haB67Ho74NGQdPXYrw38zdVfInZHJdN174wcGK922g41Zv8YOSOXCuGT+X
         tdaGhImL2CYuOvLmmU9Uj5PdDDhA1H9UnJmMgREO9mkPrWDvvYu42IIAFQUCp6JbusLo
         P2VBPMJAqBSJIzJF2YjUZHIMllrNLgSDCHqxC33UQGI8FZPzgCAVCitiivakV6L71ZQL
         Rudw==
X-Forwarded-Encrypted: i=1; AFNElJ+uEaOxC/8dofkUJkpnM7DWeI8uFiU1GkVULGRWlqlRfGq3bk2Yme/QDt/HWB9Pzto39pHhA6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANrO+whTVBXsL5dykK1SQp68FZ8rr62pweEOb3w+Mve9uIYu6
	wBoTTbs9kdjz954tTJnnJ6zSi8UfdOOCrLKqQgPa8Vo7il9H7qovR4rx
X-Gm-Gg: AeBDievXvOS/4QFke7iONGRQuj6RoD6FQqFkTvKUz2xIeL7k9ntOlQiA+m7WjAuJCIS
	D8jqTiwMIKkERnhO8hzxi4WNXNQZmXrekoDn4zLKvrlkXg3/EbDThfDP4UP5k5CIvf0pFZduYz3
	cJru8gtxAGqY2IqasAE0li2hwTPOT4jmhsux47G+QcyFvnogpEW94Y1Rc04M0s7fyF4tOFJGIW4
	zQVBqEbnAQTefnLndppIV0kcpGgupImitE9ZUs0fQde6ifWqSuD93ZrJqA/7neATIWJtwwAfA5C
	jIZ7q5CAuVhe9obMLJi4SMu0iDSEl85LZZOw7MrCFTrXoNavk9MYQN06ztYoNghvJc8fTVMqVlK
	WVgxd64frF4BfZLNBEM1v57skF0gA1Jd8iTA4KLI1nlw1ptRfaVUGuvsA7kD1/bDPDkbwTKnHHI
	KclNQOuR3UgoYCCyykSKymSDKu9PUtUUlvb9dJEXTyGddUr/8vssYGhlb1HYayTA/R9EidE04FW
	Gan
X-Received: by 2002:a05:6a00:181b:b0:82f:4191:da10 with SMTP id d2e1a72fcca58-834ddae0572mr2816395b3a.6.1777375845004;
        Tue, 28 Apr 2026 04:30:45 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf6b111sm2455545b3a.52.2026.04.28.04.30.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 04:30:44 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mawupeng1@huawei.com,
	Zhao Li <enderaoelyther@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/hugetlb: fix max-only subpool accounting on alloc_hugetlb_folio failure
Date: Tue, 28 Apr 2026 19:30:38 +0800
Message-ID: <20260428113037.88766-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428030712.66256-2-enderaoelyther@gmail.com>
References: <20260427145247.84157-2-enderaoelyther@gmail.com> <20260428030712.66256-2-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 811E5483F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux.dev,suse.de,kernel.org,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241635-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

alloc_hugetlb_folio() calls hugepage_subpool_get_pages() when map_chg
is set.  For a subpool with max_hpages != -1, that bumps used_hpages
regardless of whether it returns gbl_chg = 0 (rsv slot consumed) or
gbl_chg > 0 (used_hpages slot only).  If the allocation later fails
before a folio is returned, the unwind must undo the used_hpages
bump.  The old cleanup only ran for !gbl_chg, leaking used_hpages on
the gbl_chg > 0 path.

For gbl_chg > 0 on max-only subpools (max_hpages != -1, min_hpages
== -1), hugepage_subpool_get_pages() took only a speculative
used_hpages slot.  Drop that slot directly under spool->lock.  In
that configuration hugepage_subpool_put_pages() cannot restore
rsv_hpages, so the direct decrement is the exact inverse and is
race-free against concurrent puts.  This matches the used_hpages-only
part of hugetlb_reserve_pages()'s out_put_pages cleanup, but
restricts it to the max-only case where no rsv_hpages restoration is
possible.

Mounts with min_hpages != -1 are left unchanged for now.  v2's
approach (hugepage_subpool_put_pages() + h->resv_huge_pages++ to
back a restored rsv_hpages slot) double-counts global backing under
concurrent free_huge_folio() and creates phantom reservations under
concurrent hugetlb_unreserve_pages().  Safe cleanup of that quadrant
needs a coordinated fix across multiple call sites.

Reproduced on size=20M hugetlbfs with the faulting task in a hugetlb
cgroup whose limit is exceeded.  Vanilla leaks 6/8 hugepages of
subpool quota; this patch leaks 0/8.  Verified under QEMU.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v3:
- Replace v2's hugepage_subpool_put_pages() + h->resv_huge_pages++ on
  the gbl_chg > 0 branch with a direct used_hpages-- under spool->lock.
- Restrict the cleanup to (max_hpages != -1, min_hpages == -1) where
  the direct decrement is the exact inverse of the speculative bump.

Changes in v2:
- Skip the gbl_chg > 0 cleanup when max_hpages is unset.
- Add hugepage_subpool_put_pages() + h->resv_huge_pages++ on the
  gbl_chg > 0 branch.

 mm/hugetlb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f24bf49be047e..cfdeaf6394c5b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3025,13 +3025,24 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg);
 out_subpool_put:
-	/*
-	 * put page to subpool iff the quota of subpool's rsv_hpages is used
-	 * during hugepage_subpool_get_pages.
-	 */
-	if (map_chg && !gbl_chg) {
-		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
-		hugetlb_acct_memory(h, -gbl_reserve);
+	if (map_chg) {
+		if (!gbl_chg) {
+			/* Full inverse when subpool_get_pages() consumed rsv_hpages. */
+			gbl_reserve = hugepage_subpool_put_pages(spool, 1);
+			hugetlb_acct_memory(h, -gbl_reserve);
+		} else if (gbl_chg > 0 && spool && spool->min_hpages == -1 &&
+			   spool->max_hpages != -1) {
+			unsigned long flags;
+
+			/*
+			 * For max-only subpools, subpool_get_pages() took only a
+			 * speculative used_hpages slot. Drop that slot directly.
+			 */
+			spin_lock_irqsave(&spool->lock, flags);
+			if (spool->used_hpages > 0)
+				spool->used_hpages--;
+			unlock_or_release_subpool(spool, flags);
+		}
 	}


--
2.50.1 (Apple Git-155)

