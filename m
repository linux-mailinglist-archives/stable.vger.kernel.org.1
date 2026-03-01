Return-Path: <stable+bounces-221707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPqcD4Kbo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CC1CBFBD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E2F325003B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90E2E7637;
	Sun,  1 Mar 2026 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzMNRBQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1102D3EEA
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328945; cv=none; b=m3Yp9ShsdVgccMK0vcupEbdjUokGFa2DHzocN0KdEomsStEFV/3gNT1Gc549KLgW33EG+lCr3apiWqBkM8jjNEKJstelunKmMMxAzXimpgr2x0j4o2g81w64DcfJOgJej+iIzRYut4/Nh6HipnLWBmSUM9ZEsr6xTrv/k4K2W8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328945; c=relaxed/simple;
	bh=Nl0mnI52GrpE5DPaxeEY3EOBXIawluoU8XfW6848HIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0/ENV37BTRb8eHeCP7EDgilACAoztspICw+mOq2SPyNjUN8QwQ0LeiHt2q6wKYst2GD0Ut9xVF+sEsxWZo33zArbeDWXRtMYN+ghb9g7Dn9XwAtdLcqdQlx7WtEFrJgT3k5Y0mFElTi/3j2wSMeqVj8NdQPfU9pI772VKhLjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzMNRBQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B146C19421;
	Sun,  1 Mar 2026 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328944;
	bh=Nl0mnI52GrpE5DPaxeEY3EOBXIawluoU8XfW6848HIM=;
	h=From:To:Cc:Subject:Date:From;
	b=dzMNRBQuFhmdDHMH4Ki1HnsSzU/VexuA0ZMgP+LJe7AjYORt9dEr+jkSlfMgZxeuE
	 iKJLf0FAI9iJacXRPtNUVWFCtt2jhfJ/xioNCYEusMpb5zQsQqZVviveCY/c6Rcec5
	 FH4X991/L4QgfqSGmM2RaqKDcubjsPTwq2InSjwVwGIzf2yJHS06rmtRJYDAX1rOK8
	 rmjjCgpoUqnAesOuzkOaFl7CZo8sZhqFz3i/eUDJM1i59PIfEk4ZXHQqUWNctHCfDD
	 /AObwX3xd/ywwYIdvqmKoIQSLm4VlaxxRl4QuyKawjgEaivNJbN54ePw6xw+L9R30B
	 SRdxJvUZ92lhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	williamt@cadence.com
Cc: Max Filippov <jcmvbkbc@gmail.com>,
	Chris Zankel <chris@zankel.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: FAILED: Patch "mm/highmem: fix __kmap_to_page() build error" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:35:42 -0500
Message-ID: <20260301013543.1695499-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zankel.net,linux-foundation.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221707-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zankel.net:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 8E0CC1CBFBD
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94350fe6cad77b46c3dcb8c96543bef7647efbc0 Mon Sep 17 00:00:00 2001
From: William Tambe <williamt@cadence.com>
Date: Thu, 11 Dec 2025 12:38:19 -0800
Subject: [PATCH] mm/highmem: fix __kmap_to_page() build error

This changes fixes following build error which is a miss from ef6e06b2ef87
("highmem: fix kmap_to_page() for kmap_local_page() addresses").

mm/highmem.c:184:66: error: 'pteval' undeclared (first use in this
function); did you mean 'pte_val'?
184 | idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));

In __kmap_to_page(), pteval is used but does not exist in the function.

(akpm: affects xtensa only)

Link: https://lkml.kernel.org/r/SJ0PR07MB86317E00EC0C59DA60935FDCD18DA@SJ0PR07MB8631.namprd07.prod.outlook.com
Fixes: ef6e06b2ef87 ("highmem: fix kmap_to_page() for kmap_local_page() addresses")
Signed-off-by: William Tambe <williamt@cadence.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/highmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index b5c8e4c2d5d49..a33e411839517 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -180,12 +180,13 @@ struct page *__kmap_to_page(void *vaddr)
 		for (i = 0; i < kctrl->idx; i++) {
 			unsigned long base_addr;
 			int idx;
+			pte_t pteval = kctrl->pteval[i];
 
 			idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
 			base_addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 
 			if (base_addr == base)
-				return pte_page(kctrl->pteval[i]);
+				return pte_page(pteval);
 		}
 	}
 
-- 
2.51.0





