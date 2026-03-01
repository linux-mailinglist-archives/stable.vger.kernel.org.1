Return-Path: <stable+bounces-221450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH89GhOlo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C491CDA48
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4335C314EFDA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A227FB3A;
	Sun,  1 Mar 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+yMWeeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D32727EB
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328295; cv=none; b=Hhb5uIdNDzKdSzU7P/Wsoxey0sBWAa0Pazsz8heAJY5bfk7JqbrJaDHiDQSNlZhViLvITK9vwvrwIpd/3c0SjL34qwpOq8NlgCew4mDi4qUE31FeBD3x0NhcLaTbCBRM2zvX4M8w6zXHLoFTebrLnIsaJUqjtsKCC8CI0+b0az4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328295; c=relaxed/simple;
	bh=q2iLO8KbI9ALryCX6/wUxMqfWYriV0dYXQW5wrcui7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWTxMQR2/1bSAHyHHcpHveVCD4G5RJztVsIS7JZ33G4DCvfRhgOk25aKW/CMmgIhLFa6SI58Ji/S4cja66gKb8cl9wW9cSh7R1M50AUA9k5s21MWirVFqTelZuRVoyOf0HBY65SFw91CHT0zXK2D4tmAJvAQUYOCm77j7zeqnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+yMWeeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23773C19421;
	Sun,  1 Mar 2026 01:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328295;
	bh=q2iLO8KbI9ALryCX6/wUxMqfWYriV0dYXQW5wrcui7E=;
	h=From:To:Cc:Subject:Date:From;
	b=X+yMWeeXj1pvQIPqcbKcmDHMpkw+d1FdTTM8zlMEOipUyBCtnhcfR2TnoxqfEfVam
	 Y6VLdllNMi3qy7EMIbca7ySGK/E0vX3kU7AY4ykt/RYJLGZE9FJ/X8a2E4OO4mLrri
	 Qdlvs2sr7afIW191kTtd3t1p5lDKQRbdYZ1Egcvwak2ZJxzRx0k+ru9kK6LFqHOLzY
	 hMZ1KrtIG0Ept+RgXfzqM/gp17PzuYZiRRNRzV5QVLFHbsLaqbKybg8uChvOxTiUNd
	 cI0Q0kiMga9Zcds0v9ynDzF6YoR1pxCQPJKStJGetd7k/ziJj9aae9ol9RxzKk+kfU
	 JlZgmkhgRlC0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	williamt@cadence.com
Cc: Max Filippov <jcmvbkbc@gmail.com>,
	Chris Zankel <chris@zankel.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: FAILED: Patch "mm/highmem: fix __kmap_to_page() build error" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:53 -0500
Message-ID: <20260301012454.1681859-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zankel.net,linux-foundation.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221450-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3C491CDA48
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





