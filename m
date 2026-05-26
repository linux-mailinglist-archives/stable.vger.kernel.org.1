Return-Path: <stable+bounces-254348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PFbK/ebFWr9WgcAu9opvQ
	(envelope-from <stable+bounces-254348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:11:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270215D61EB
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01595341AAFF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FC3DE429;
	Tue, 26 May 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Ji+Qdksv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkWUbR8C"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-c5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09393C9EF4;
	Tue, 26 May 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800734; cv=none; b=mf8GrKCBQJmENJVJoVkNK69XvkwgJjWYB8VmkHU0SNcqA6hAqEkwREfoj1U2vIIhxGitGAdFOi1xOiCz24RznaPxQq2vLYhKhlBQnAbiczLMo7F7RmUfgqRE83ZYgOMqSvxTCsY1McOeJjUKSfBaWQ247Ih7NcOJecnPQvJmI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800734; c=relaxed/simple;
	bh=Z8RkZKWnEMc11dpT7ZbpiSwfS0JebjikBzYVmcK7kbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I29YMKSTZLnxDUfn2cCKRspfFkjn9epsi85zyLgR7crw1KHxLNN8QHgndtBHacbO+3U9naYQBNcZor179b5LN4HrY0TPkBxCCvpdRZntWN8gmKWYAiuEMMae7kBJvxUgv/H1ToAqzaOyW4i50jA8W/ddQ00Po5ec0S4qju0OtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Ji+Qdksv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkWUbR8C; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 401717A0199;
	Tue, 26 May 2026 09:05:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 09:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779800725; x=
	1779887125; bh=YBwKkY/grj7eTubGVS17k23m7rOV/TXg0sGJ6fJ8NP8=; b=J
	i+Qdksv20gAC3RtFnogzYuu25FqSHcEULonL1lRlrS7o2BRSUfo+tE5HTg5ivaih
	g2sXfDL+EO/nlWjxNp+bZTl+7sDqzSegl91NgJ2/xxLYD2qWt6QE5KBLRboaH8qT
	SOFPRtInVPpGDxw5lBIcU3wZWUhpTkqMp7iMpE/X0o3Q92YAKg3TRUZu1hhplYRS
	GgvqOYv3c37fS/80zr2OEM1EH3ktUA/eyShWyrxqR374NVvvvaB3oqAH8l904Obn
	LTXxo8JXpxl57wqk0FzVZMCSMHgi139eVOpm5IeoJyG3JwLZBH8x+q+fAk9Xqbmx
	1jUz+atgx2rYx5PsO6cvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779800725; x=1779887125; bh=Y
	BwKkY/grj7eTubGVS17k23m7rOV/TXg0sGJ6fJ8NP8=; b=HkWUbR8C2VgDKVeEi
	3fFNUpQr18rx/QntnFFe8xmRB+aCvuXp9lhz/Bq0kzAnwfKWM5Sv0Qjm357tNNMF
	LYl8E/zE9X9ryvJI2g0N+MPXGephfbTTa1p84lol6pTHUXVfu2kEV1MLcasQezhS
	JBIz+aEdPDV0oAakwARpNFoDpvC2C8Bo8eswLL6ksHbh695rDWBd/SqujHW8bXI0
	Y3iHY2XtNWW7qVagSMesXd+P8QeCtvP7buHbacK6gEmJUWlQ1Nw8BLDpSSXUlXf/
	IYhBD1tV6N8Rbe85VpYRluMDzAyVSbI7+rJ5qb5KbT2KKrb1QOx0MP9qXPobEaib
	LBr4Q==
X-ME-Sender: <xms:lJoVaqjwmQpR_dfRce5MYXNvCOa-GpW9Kiacl8s5KvkHq_Pjrv1GyA>
    <xme:lJoVasEeU0ST0qFOsHCPQfv-RizLckfphd1RP3HQWECYYNZ5-IHt0MVgJ6pK0acOQ
    YLqYiqTG9zn7eGBj1cc6PNP1JyHThO1OJWKFGpGyyckQEQlt-J4ZBU>
X-ME-Received: <xmr:lJoValBTebOWMckAcwxrqC2ukMvK-K_1FksiLWqWAXXmj4il4FjClHaSOxswnQ>
X-ME-Proxy-Cause: dmFkZTGhhOzazjqDbg84kXmGQIriAJ7A5ZgfZ0KyuPxd944l9VDoz0auYhNa1nywHIJo+A
    1950kHkKTkQx9lnfSbZcx/S8Mcmt8P0l8Wb8fN0f+wGCwnBkoWy9vl20eCC3tZZX+sH7av
    Dlxe1oS29Zt+/zoZFzy+yh5aDbHDzc3iUaHQ8s1Xon6Q6ulUL8z0cPYFRnxsd9cUuaOOeC
    grd5OyNgyo2h51fT3APjemmY7PM1ZW9p43vVXIU5xFLcMabfv/O6RwCJbL3XPnw5Oz6kjj
    h/H6ZW2FJischjgbFlb1Y+t4mjYQn8Uqjf0DstcwPvag6qa0D5BtHhYNV9zEgkVoBIpvTz
    ZnR1foptO7/8jmH5QXxz32AsiOm+BXz6hc/cs5B/azrJ0t+P/mqk1gFTiuuTPm5dA5Vq81
    cJX4YOgsiiWFnHVl2CR8dh5PxgYu8tU+XiYMmMArsrktl7gMkXqC4+Sbs5Xn6kySEhNAys
    mYSAKOa4AxYoEqMuWUhw8xNgM0FzaeXymKeIrC6L2QtadT/OHDmcHIZKIxtLTvXPGciZHW
    lAasq5Z58Qc+qpKkmjjFN0MXay2YvYLghe85s4ABJ6fi1iJVjQD26TVp+3WO6IAh6yMxoI
    vHJCG2WFwICzMtns84mmZs8RKQ3lGJVWcW9XDv21tmktq9h501AtPj0yTmcg
X-ME-Proxy: <xmx:lJoVag-fHOwSkVIhIcgbEuZJ3EheaAFKPruqXtoKKZD7VTEvz8WlDQ>
    <xmx:lJoVagjvOwHKdOZLp8dHu4japn4UurRHA7BXVITvuV01NN0HkLCjNg>
    <xmx:lJoVahaP6hRlgQF-WK719SnmrQE_rkzUv8TiMarwqyYIK1BJR9GFUg>
    <xmx:lJoVaqQIecvWfMmOr0nZddq8kixyt-yQ70ZduCfmhTCEb_89-t78fA>
    <xmx:lZoVagVAEg8PRpsCV8YCg6wu5me45h09voNBCdPvUMWguihk7VgrxZrY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:24 -0400 (EDT)
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
Subject: [PATCH v5 03/18] userfaultfd: gate must_wait writability check on pte_present()
Date: Tue, 26 May 2026 14:04:51 +0100
Message-ID: <20260526130509.2748441-4-kirill@shutemov.name>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254348-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[shutemov.name:server fail,messagingengine.com:server fail,sea.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shutemov.name:mid,shutemov.name:dkim]
X-Rspamd-Queue-Id: 270215D61EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
without taking the page table lock and then apply pte_write() /
huge_pte_write() to it. Those accessors decode bits from the present
encoding only; on a swap or migration entry they read the offset bits
that happen to share the same position and return an undefined result.

The intent of the check is "is this fault still WP-blocked?". A
non-marker swap entry means the page is in transit -- the userfault
context the original fault delivered against is no longer the same,
and the swap-in or migration completion path will re-deliver a fresh
fault if userspace still needs to handle it. Worst case under the
current code the garbage write bit says "wait", and the thread stays
asleep until a UFFDIO_WAKE that may never arrive.

Gate the writability check on pte_present() so the lockless re-check
only inspects present-PTE bits when the entry is actually present.
The non-present, non-marker case returns "don't wait" and lets the
fault path retry.

Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/userfaultfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 35b206cc9aa6..f6d2a1c67019 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2535,6 +2535,15 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(pte))
 		return true;
+	/*
+	 * Concurrent migration may have replaced the present PTE with a
+	 * non-marker swap entry between fault delivery and this lockless
+	 * re-check. huge_pte_write() on a swap entry decodes random offset
+	 * bits, so gate it on pte_present(). The migration completion path
+	 * will re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(pte))
+		return false;
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
@@ -2621,6 +2630,17 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(ptent))
 		goto out;
+	/*
+	 * Concurrent swap-out / migration may have replaced the present PTE
+	 * with a non-marker swap entry between fault delivery and this
+	 * lockless re-check. pte_write() on a swap entry decodes random
+	 * offset bits, so gate it on pte_present(). The page-in path will
+	 * re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(ptent)) {
+		ret = false;
+		goto out;
+	}
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
-- 
2.54.0


