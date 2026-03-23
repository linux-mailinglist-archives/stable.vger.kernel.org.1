Return-Path: <stable+bounces-229249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B4LGC5vwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10B2F8DF8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76AE43436B78
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA781DA0E1;
	Mon, 23 Mar 2026 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sJZNCoP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187E248F57;
	Mon, 23 Mar 2026 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278528; cv=none; b=O4o3uah+NUvdkswiMB+ZQSFRcH1JJma5xIdSZh8sx4U5G87R1x05v4ACo2cE9+sd8GZikYZ0brVHfVv9G4zNlUwG06+zYWMN9g/7YFGOCeQiUp1mLH0ERcC2T3YIAMe+GtG11X+xGxSOSDFfHhqvUCsFfZXuE3yFppzAsn6tRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278528; c=relaxed/simple;
	bh=jpefQbD0cW1TjZRw3JvLmI3JBw2ki9Wq81u9CRlh828=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpIusgJ7CwtUdU6lwmcv9U2FQPdhrNvTKdVqtIe2UkV0nDi+ZzaDGlpkyFxzv93uJi6fav7GhWCrKxdlKb+aKaNRawiZ6rVBCwzxQD4pAEvXJ8VRzvM2rIECQVNW6Qbt/6M4Ls28GevoU/PAwnrpJ599AfCkoAx+Qh2mwpq+LiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sJZNCoP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB30FC4CEF7;
	Mon, 23 Mar 2026 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278528;
	bh=jpefQbD0cW1TjZRw3JvLmI3JBw2ki9Wq81u9CRlh828=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJZNCoP2YuXOV7zx1cob6tVvzv1ZZCr356lrqzg3rsNxdoo7JWG9teSwlAi5O09h6
	 GgT1w7Qc8zJSN3ODsxgAu5DcymAvRO6DurbD4cjEac0LMt5MLWeFP9+c6Gcn6mHJnw
	 5pUkOqMJCUUlB5VAvmUUFDFRzZP8KfaXbuZJkW00=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.6 337/567] drm/i915: Fix potential overflow of shmem scatterlist length
Date: Mon, 23 Mar 2026 14:44:17 +0100
Message-ID: <20260323134542.169846284@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229249-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AF10B2F8DF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

commit 029ae067431ab9d0fca479bdabe780fa436706ea upstream.

When a scatterlists table of a GEM shmem object of size 4 GB or more is
populated with pages allocated from a folio, unsigned int .length
attribute of a scatterlist may get overflowed if total byte length of
pages allocated to that single scatterlist happens to reach or cross the
4GB limit.  As a consequence, users of the object may suffer from hitting
unexpected, premature end of the object's backing pages.

[278.780187] ------------[ cut here ]------------
[278.780377] WARNING: CPU: 1 PID: 2326 at drivers/gpu/drm/i915/i915_mm.c:55 remap_sg+0x199/0x1d0 [i915]
...
[278.780654] CPU: 1 UID: 0 PID: 2326 Comm: gem_mmap_offset Tainted: G S   U              6.17.0-rc1-CI_DRM_16981-ged823aaa0607+ #1 PREEMPT(voluntary)
[278.780656] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER
[278.780658] Hardware name: Intel Corporation Meteor Lake Client Platform/MTL-P LP5x T3 RVP, BIOS MTLPFWI1.R00.3471.D91.2401310918 01/31/2024
[278.780659] RIP: 0010:remap_sg+0x199/0x1d0 [i915]
...
[278.780786] Call Trace:
[278.780787]  <TASK>
[278.780788]  ? __apply_to_page_range+0x3e6/0x910
[278.780795]  ? __pfx_remap_sg+0x10/0x10 [i915]
[278.780906]  apply_to_page_range+0x14/0x30
[278.780908]  remap_io_sg+0x14d/0x260 [i915]
[278.781013]  vm_fault_cpu+0xd2/0x330 [i915]
[278.781137]  __do_fault+0x3a/0x1b0
[278.781140]  do_fault+0x322/0x640
[278.781143]  __handle_mm_fault+0x938/0xfd0
[278.781150]  handle_mm_fault+0x12c/0x300
[278.781152]  ? lock_mm_and_find_vma+0x4b/0x760
[278.781155]  do_user_addr_fault+0x2d6/0x8e0
[278.781160]  exc_page_fault+0x96/0x2c0
[278.781165]  asm_exc_page_fault+0x27/0x30
...

That issue was apprehended by the author of a change that introduced it,
and potential risk even annotated with a comment, but then never addressed.

When adding folio pages to a scatterlist table, take care of byte length
of any single scatterlist not exceeding max_segment.

Fixes: 0b62af28f249b ("i915: convert shmem_sg_free_table() to use a folio_batch")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14809
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20260224094944.2447913-2-janusz.krzysztofik@linux.intel.com
(cherry picked from commit 06249b4e691a75694c014a61708c007fb5755f60)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -151,8 +151,12 @@ int shmem_sg_alloc_table(struct drm_i915
 			}
 		} while (1);
 
-		nr_pages = min_t(unsigned long,
-				folio_nr_pages(folio), page_count - i);
+		nr_pages = min_array(((unsigned long[]) {
+					folio_nr_pages(folio),
+					page_count - i,
+					max_segment / PAGE_SIZE,
+				      }), 3);
+
 		if (!i ||
 		    sg->length >= max_segment ||
 		    folio_pfn(folio) != next_pfn) {
@@ -162,7 +166,9 @@ int shmem_sg_alloc_table(struct drm_i915
 			st->nents++;
 			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
 		} else {
-			/* XXX: could overflow? */
+			nr_pages = min_t(unsigned long, nr_pages,
+					 (max_segment - sg->length) / PAGE_SIZE);
+
 			sg->length += nr_pages * PAGE_SIZE;
 		}
 		next_pfn = folio_pfn(folio) + nr_pages;



