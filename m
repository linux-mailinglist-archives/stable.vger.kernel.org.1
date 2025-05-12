Return-Path: <stable+bounces-143703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2BAB40FB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC561466A24
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696E255235;
	Mon, 12 May 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qz8trQQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380B1C3BEB;
	Mon, 12 May 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072806; cv=none; b=BheiyNnZUu692URYmFxuMBxs+hRHYbbtSglQzl90NFFP1pnlpevsODefnrywqEMMHu8EEzXp1zAmbb/rMLq5dpABctIhGxCwlv/T1xrCidP4vb0huJNBoMTHpDmcSCPPXPic11RgJ3aUh2W324m4QhgrN0Rcs2EwfuS8IZWuozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072806; c=relaxed/simple;
	bh=1PWF4k0wwLW/W1sLfjFooB4D5fYC/7Q+XV8Cy8FuOYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCOv+OTfKCWp0Pwe2A9TFK/jmhvUBjQI1XHX0pPv9F6BB4gsRA58AmC6Mdj7n4QdmtxDGeQ5i3URQSMYHfAZSkzVUeVIamT6s/fMi8KHYGxi9wzSKxjtpJm7dNf5VBaExIAJWPVwSnDj/7YYQTyb9ckiPuoQOXMGk2vheQbx0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qz8trQQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF6DC4CEE7;
	Mon, 12 May 2025 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072806;
	bh=1PWF4k0wwLW/W1sLfjFooB4D5fYC/7Q+XV8Cy8FuOYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qz8trQQ3vw7PeA/PT2vT9WQasAqSND8cu3rvLFiPJw+uffubhT0f5L7DJLQBfGMwn
	 8SIDF2GV3eo/Knk4T/BvToZJZY2ohCKzMXh3EcLqOjeSu/QnriaUXsGdeXjriARuqT
	 Zpq1Cpc4YCFzhFXaFu2Y4GA7wjh+dZbrwthgHeXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kota Toda <kota.toda@gmo-cybersecurity.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 033/184] netfilter: ipset: fix region locking in hash types
Date: Mon, 12 May 2025 19:43:54 +0200
Message-ID: <20250512172043.069852281@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 8478a729c0462273188263136880480729e9efca ]

Region locking introduced in v5.6-rc4 contained three macros to handle
the region locks: ahash_bucket_start(), ahash_bucket_end() which gave
back the start and end hash bucket values belonging to a given region
lock and ahash_region() which should give back the region lock belonging
to a given hash bucket. The latter was incorrect which can lead to a
race condition between the garbage collector and adding new elements
when a hash type of set is defined with timeouts.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports")
Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index cf3ce72c3de64..5251524b96afa 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -64,7 +64,7 @@ struct hbucket {
 #define ahash_sizeof_regions(htable_bits)		\
 	(ahash_numof_locks(htable_bits) * sizeof(struct ip_set_region))
 #define ahash_region(n, htable_bits)		\
-	((n) % ahash_numof_locks(htable_bits))
+	((n) / jhash_size(HTABLE_REGION_BITS))
 #define ahash_bucket_start(h,  htable_bits)	\
 	((htable_bits) < HTABLE_REGION_BITS ? 0	\
 		: (h) * jhash_size(HTABLE_REGION_BITS))
-- 
2.39.5




