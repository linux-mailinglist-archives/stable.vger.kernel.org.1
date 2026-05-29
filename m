Return-Path: <stable+bounces-256675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOCyBbbTGWodzQgAu9opvQ
	(envelope-from <stable+bounces-256675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:58:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BC606EC8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B1233372A9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AF382F0C;
	Fri, 29 May 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6AlvV29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B393822AB
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075459; cv=none; b=OHJLeBLxIZvLDaUiETiqyzE4zJo2BQn0HycQxXIFmpQoLoLMPc1MQw307Sish88KzZpcDZtLzpqvXFskdsUEKNkuzVJHMUHPQp2N1tOtPtODAsJTK0jaZsCw5hn82sFW0koSkjp7qJBmS1FoZQQKl0If021zHuE6uQgygQcu2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075459; c=relaxed/simple;
	bh=nxvHsHswlUDcFohXoUUYbb3RCJcKckvf5pmldrrkpR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK7sUBI+vSRGBz5FWLwnBIzAFUp87cgpYqBgnJTrBkimD2hI8bBkfhGS/RAeUfzs5hbo76ozY+RtdS5dnCsD3zXnMBC3LtWjU6Wh+r8A84WMVmL8UY4jrQpiVwYllvkqgseJSKY4LIAL90VgkBAMzVxpHRbWj6/sTy7eo6vq32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6AlvV29; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E1B1F00893
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075457;
	bh=XeG9LCEJFa4u0fWY5Mnfc8ZMY6z2gJj23YToDXVIM3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k6AlvV298J7B5Eoue3iYl4bQIQbJ+ixZ0z45rAtgZN7IkZ1Y5pA7xnJUxPKbiusks
	 hJXXdEv+QMVAL7yPj11Gw9pQWqb3afimWuOX7CPC+p3duCi7e/0Dof7fZFx8Use60W
	 x6MSEuVvwcnE+lRKy9DW9I3JB6EKwM4XSkrvTZFtJm9hEfAIoTm4tX5HCQT1HiW+b4
	 Z0ulg99csBPi+KLy8Of+/aLfm/Px/5ZJ1EDOtfw9Bg8A6u60RJ0hYSw8sau2JEBE4v
	 ErnQqtQEKXzyn4u0BkCEsVstgOtn4mWH4MroQl7xPmb1fR+k3n1kXjHyS5u/72xle+
	 NZ6cEJ4+/7Wpw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0EDD9F4006D;
	Fri, 29 May 2026 13:24:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 13:24:17 -0400
X-ME-Sender: <xms:wcsZak-NgfpOzhZZuL_DUVc6QSlV7NKTafXAW12NDzu5Yi__Z2OXog>
    <xme:wcsZajPEXzq_kv1SnUAjaG7zgbEV3QwhcNZFhX6PqT8mXSjKXzjWRIl0gKg8iGpY7
    Jy_0eQBHzKapQgv-ZMZwhAAd7wfLo8rMHRKDiK_FjbJiQeWAI3oVnBk>
X-ME-Received: <xmr:wcsZaoBm-pZZfQj0I4SXoa4BGVXUD_UVUbb6cwmVde0u3BhL8z2ZyuL9jaGtaQ>
X-ME-Proxy-Cause: dmFkZTFrgX5MM3DUSJ7xzqsXiT9K7Mp6hFpPFfxmC0MA+iN7AjFohwvWx7oxJHZ+5oTsa/
    eNprXeJ/674yJe1dHbWF7GZb1XnToVb0R4autdIDJiozLrBStYEb9fpXa/2JrApUqbrre1
    LdBuyJn9i8qKcJffyvK1YIhy0raIMBiWiOnHjwA5r86k+Zhi6bSohRFuPzPhOdP14jnWJI
    /xiWZuCo09JkwaiWtT4Gp2J4EUMHafSQnln9uaxNuylCfDh3CVEdSw0SaHR74GjGjlbPAf
    5lIf5oHRJw+wgkoNP7G5YvX9mPChAnbwGYXnMrRN1deEijcEXsq+k9G0Lzj5Q5OMaNJVHB
    4OOwyJkq6mBqr043+j7zRMjiXH5kV6zXX7/bgSmKaz/4+CS2nFJJ/vmFn/GaYqZ+ipcj+9
    zaCSc4zsH8zhnIMSsXMMe8+k11/OpeFmN4szkrGrgFc21nOEwGIKONCBFrCimY714mJP5y
    eKIrJe8HvjiBOndrTcALefXl4v4JeJuPsrnHxXfOBEoBkarzNgrbvXTpxFmHceYD/BAmlo
    sLsztvo3cGZYIOqO78ihV6vneu2kX8mZI5NKqYckQd3GswUUBMSNKmUqO3ygONGUdHdS59
    BfN7xsE7X4zcmiX30qSzkdNfO6eHulZVz1QW+CycnZ7Z16VTgUR+37tDLTVg
X-ME-Proxy: <xmx:wcsZanPwXsySgx8tIW5IH8ELE20ra9TtJi9lyZEs5dOgdbS_BIG1jw>
    <xmx:wcsZaveVZS4i744WZ1v7MJzcReHKQY9oYsVHlt5-hQ_G-6AltmbUXQ>
    <xmx:wcsZao63dhUGYiSYrJ_Dx7kTJsIx2ukNhbQ9vwY-BjKlpnzp9f0Bbg>
    <xmx:wcsZahIJ1e721__wC-Z9iskTxDan-x0gIATk8VBCChuhleyP980ptA>
    <xmx:wcsZaiVQ8z8F4yAQbed8dFKYJ4N-Qxkj-lmKCWttfOwkJqFTMyze0OY4>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:24:16 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 5/6] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri, 29 May 2026 18:23:29 +0100
Message-ID: <20260529172331.356655-6-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172331.356655-1-kas@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256675-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 665BC606EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


