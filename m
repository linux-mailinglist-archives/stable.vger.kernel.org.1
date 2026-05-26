Return-Path: <stable+bounces-254345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X8OPN3+bFWr9WgcAu9opvQ
	(envelope-from <stable+bounces-254345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:09:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D45D6141
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EEB830A98E6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44293D88F1;
	Tue, 26 May 2026 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="NdbTXC6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGBF0Cz2"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-c5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCA3CF699;
	Tue, 26 May 2026 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800723; cv=none; b=XGxA5/btpmchwk1tfuMBtX+269vhrRG9G8foNcDaW6JKp/6cmt2F2Sh5tHrX2t1DdcptrGv500ucSTBKcbwsslTFsBC+3Slc8kSZb5ge13zs0yx51gqNU3qWTUWqUOJ5aAzbPVsTbHoNIOKyflXRLCTznjipHDItbl4BDBKi3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800723; c=relaxed/simple;
	bh=Q1x0vzo4Fcg7T40t+fkqOjXDWYibC3Uzz9whKJveh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AncZ+XfRCLFS4P9RLQELSBcmgxEsN7tIKmPGr4qzOutQIKXkn4fS1rq2E99+mRNkrw6p1ZvNSnptVn1UbmlaQs2DD3aNB7TCr1MPfsSDMBT6AX4AULH0zARjzE6hWK7b7vul/Pvg3KK5vP3NMYmlNndLoYW7bdo+EF/jem5YLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=NdbTXC6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGBF0Cz2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B37E7A0084;
	Tue, 26 May 2026 09:05:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 26 May 2026 09:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779800718; x=
	1779887118; bh=E7L0m3RyuvBx1kNYpnyZCnh1DhseUWlMTVoo0K5ue5I=; b=N
	dbTXC6nfKnkuwTtmDny+2aqIfJfyc1pBOZW+8mXnJyJFIEx+jT73avZVDg/Jdvjw
	Nzv0eaYnrGmJoaCuXRXodkKmc8sK4BAknIxuTjQ52wqoDGzcFYg+Ha5WVQU6B0hK
	rbjOB49DcM5AXfYsIoNMqTJWHx+4EOd6goiLvaSou0h7pn3VDDyzOHlInzHUIjZI
	/+RNwRPiMw2v4NO05bqJRe7dH6zRyPI1ApCqipYeUWHgpltb1WLwcC6MoH+hp6x+
	fjf3GmwRmT1FYvAr08Xppk0iWSgXdFzF9jJTzvbGTKiTsOTW5+jdlMmZtCwXc9jb
	M1z6MHUXBOf129pYYVm9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779800718; x=1779887118; bh=E
	7L0m3RyuvBx1kNYpnyZCnh1DhseUWlMTVoo0K5ue5I=; b=IGBF0Cz2M9jn/2BO1
	XqK9E7mBCfZ+0kW/I5mbgVnQ3I/ZSgJ1JA9UWnFdlkX0WAKHtEFH0bH56UQ+mynW
	5ki0M36q2ccwgGP3XTCdjTJhlyPmamMRg8v5lv4UZnxYmBDNinnd4HTHKAwYPR/K
	3o6I0AjjhRjolYHVK0IAMYcpUTrSyqbWT57Wa+oqNiMFNb0o/GJYHa5V4xsSZ/8u
	yoelRdT6Bfx/CMs5cTRDsWD8v5scZ+xazieiEp7R2yyv4p1Zl8kSr3J12JKbqkap
	12f65rOvP5garDUHPksiR0Fg75ChENNaiX+TMqd9+BsvP17+PxsUA527yL6LRl9A
	tH7YQ==
X-ME-Sender: <xms:jpoVajmJ6WfrbsSPGTVkEfrekOjzMs8zWXbpbWq639ZzOL8HiMj6cQ>
    <xme:jpoVan5a9eUB6O8v9m3GLafW_NDDs1LTXe1HLng_jFNy7Zk_TuZGvaWkINExq3vDP
    DGWUdYumCw5GpXqnvpJawBcKsQXLCawD6YluV1OJDhLauBRnmT1lA>
X-ME-Received: <xmr:jpoVasmQdD8CIIlXVC6KWxrECud1Y7qt1SFMnXGGYVE9wBSKkgpulwbJgGhw-Q>
X-ME-Proxy-Cause: dmFkZTGhhOzazjqDbg84kXmGQIriAJ7A5ZgfZ0KyuPxd944l9VDoz0auYhNa1nywHIJo+A
    1950kHkKTkQx9lnfSbZcx/S8Mcmt8P0l8Wb8fN0f+wGCwnBkoWy9vl20eCC3tZZX+sH7av
    Dlxe1oS29Zt+/zoZFzy+yh5aDbHDzc3iUaHQ8s1Xon6Q6ulUL8z0cPYFRnxsd9cUuaOOeC
    grd5OyNgyo2h51fT3APjemmY7PM1ZW9p43vVXIU5xFLcMabfv/O6RwCJbL3XPnw5Oz6kjj
    h/H6ZW2FJischjgbFlb1Y+t4mjYQn8Uqjf0DstcwPvag6qa0D5BtHhYNV9zEgkVoBIpvsV
    HjeUxvJUyBNj4Et00jMB7yxNstb+ga+iDaignJA2Z1TUx07nEuujPXNVC1yKIQAZC/SRzt
    KO5DpEJq+zywyr4tZxV7LPwshOrBc4oFzAodKrcv+DCEH47AMqMlDsNbdlfSfkf4eUkFiA
    6FrzrMB9pHbLNpLe7gvkO33hNIIfH5mGXcbOUp8UxYISR022hjAtnUUAcDxY697CtAxQpP
    zVqAPTUv6uxCKk4KV2zALF7uGWHWgp8gpR2UBm+3CtgTzS5njazyXneppcKKltY4vTsOgH
    bM2isd0gIi4bl9y8nut0ap6qUmCIjBrJ5uh6XU6vK+q1gGHoKXBVlBAI4d+w
X-ME-Proxy: <xmx:jpoVapSB3NiLJAt2oBY_qVX6PeATrFh8ryxFpUGzBAGC8q-RLv9mnQ>
    <xmx:jpoVaqnfDl3OkB8GHiY4njTmrqhqpBg9k9wlUxREioGuLZDzM7yPPg>
    <xmx:jpoVaqOpVyT8PispWbGQbpRrC7IAGA4whXvqq7W6Gedbn55oLSAMEg>
    <xmx:jpoVaq0ExCIZGsrjGeGe4IOoij7eUukPqrEf9m-HIIND7l0QFYp6bg>
    <xmx:jpoVarbEJal-RJM_emCreopxr2MC6yXgAvxyIpdvxoEPhTt6JhxAGLql>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:18 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v5 01/18] fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
Date: Tue, 26 May 2026 14:04:49 +0100
Message-ID: <20260526130509.2748441-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526130509.2748441-1-kirill@shutemov.name>
References: <20260526130509.2748441-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[shutemov.name];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254345-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shutemov.name:mid,shutemov.name:dkim,messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 401D45D6141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

make_uffd_wp_huge_pte() arms the UFFD_WP bit on a present HugeTLB PTE by
calling huge_ptep_modify_prot_commit() with a ptent snapshot that was
fetched without the corresponding huge_ptep_modify_prot_start(). The
start helper is what atomically clears the entry so the kernel-owned
snapshot stays consistent until the commit; without it, the hardware
may set Dirty or Accessed in the live PTE between the original read
and the commit, and huge_ptep_modify_prot_commit() (whose generic
implementation just calls set_huge_pte_at()) then writes the stale
snapshot back over the live hardware bits, losing the update.

The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
pattern for the present-PTE branch. The migration case stays as-is --
migration entries are non-present, so there's no hardware update to
race against.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 fs/proc/task_mmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1e3a15bf46f4..e21a38ac745b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2610,12 +2610,16 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
 		return;
 
-	if (softleaf_is_migration(entry))
+	if (softleaf_is_migration(entry)) {
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				pte_swp_mkuffd_wp(ptent), psize);
-	else
-		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
-					     huge_pte_mkuffd_wp(ptent));
+	} else {
+		pte_t old_pte, new_pte;
+
+		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
+		new_pte = huge_pte_mkuffd_wp(old_pte);
+		huge_ptep_modify_prot_commit(vma, addr, ptep, old_pte, new_pte);
+	}
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
-- 
2.54.0


