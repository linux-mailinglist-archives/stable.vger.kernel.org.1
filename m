Return-Path: <stable+bounces-86523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB89A1011
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0FE1C20A73
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310718732B;
	Wed, 16 Oct 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk7One6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F71DA26
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097403; cv=none; b=OZWHI2ihVzLDAokmpuzbjnwLhdTTne045hq7TG2rW3uSyECClj01OR018NHhnqz2KUPQ4avr79OiTxwFRoN/+QUy2X5djq5zvdzc81x8KBDhcZbbI+lhvW4CWgdLNjHsPr3P8hP0uP+v6iWm8qE77Xqsqd0pO6jNfg2af/aTe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097403; c=relaxed/simple;
	bh=BkEnKSbNtLqPQnfmJHKI+3Ipjpz8Tia+zKhMXsljliE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ck0fbesuER9OgNs16yHHYuqaQF7ZRcB+UGqcj+o6fJJpYDxd17YeBu/Mj62kzI6XPqfhWORrPpDVv4opE4QUHBitRbJ8OyFSPSmE6NfEoYx5VX3i16gvLNGP9YgUO8Om0f1Mn0aC5d61aUxbDrugXFvM9uKXMABUDesdBKIb10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk7One6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3C7C4CEC5;
	Wed, 16 Oct 2024 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729097403;
	bh=BkEnKSbNtLqPQnfmJHKI+3Ipjpz8Tia+zKhMXsljliE=;
	h=From:Date:Subject:To:Cc:From;
	b=tk7One6+zPuG8AGvfrHd+zD1MO9QZP/GcUBOmzhHbgq91CP4tDVZLWEUe6UqdIDkv
	 eZBsJpWDLhMer3GA6kyyFhmeeDAt9chUywR+Po1kHB19JYusC2Zmkt3JnNHHjBM5bd
	 MnmUwhx8EkORECzOH2lJaBHTE+rP5yqitpQbtDl5SV6ItO0ZL5Ie5aJdMpEcXxPq2b
	 eO4fzknELXbBSyZQAt9xull0RCBJag07YMsfZ8dKGzNG8TrOREXS5eNBmdtWeLNAks
	 YVpYHHYw2KgwYg1ug86vUWz4mcO+49qTM6G1ttNn33VmEns5wx70jDrBsYnlmVYoNg
	 OZmsyxO3x+2pw==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 16 Oct 2024 09:49:49 -0700
Subject: [PATCH 6.11.y] mm: vmscan.c: fix OOM on swap stress test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-stable-oom-fix-v1-1-ca604a36a2b6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKzuD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0NT3eKSxKScVN38/FzdtMwK3USzxCQjc+MkQwtDcyWgpoKiVKAw2MD
 o2NpaAMtVrsdgAAAA
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, yangge <yangge1116@126.com>, 
 Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>, 
 Hugh Dickins <hughd@google.com>, baolin.wang@linux.alibaba.com, 
 Kairui Song <ryncsn@gmail.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

[ Upstream commit 0885ef4705607936fc36a38fd74356e1c465b023 ]

I found a regression on mm-unstable during my swap stress test, using
tmpfs to compile linux.  The test OOM very soon after the make spawns many
cc processes.

It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
(mm/gup: clear the LRU flag of a page before adding to LRU batch)

Yu Zhao propose the fix: "I think this is one of the potential side
effects -- Huge mentioned earlier about isolate_lru_folios():"

I test that with it the swap stress test no longer OOM.

Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/
Link: https://lkml.kernel.org/r/20240905-lru-flag-v2-1-8a2d9046c594@kernel.org
Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch")
Signed-off-by: Chris Li <chrisl@kernel.org>
Suggested-by: Yu Zhao <yuzhao@google.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd489c1af2289..a8d61a8b68944 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4300,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (zone > sc->reclaim_idx) {
+	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;

---
base-commit: 8e24a758d14c0b1cd42ab0aea980a1030eea811f
change-id: 20241015-stable-oom-fix-a6ab273b1817

Best regards,
-- 
Chris Li <chrisl@kernel.org>


