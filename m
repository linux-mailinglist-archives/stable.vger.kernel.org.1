Return-Path: <stable+bounces-191766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA4C220C2
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709F21885622
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D724627FB25;
	Thu, 30 Oct 2025 19:46:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C09217723
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853563; cv=none; b=RhdbAcfu1ZN+9PD2a7GttvsbRI+7+8yep2LA+fchOZldaEYls0x5i9ESeK1PpYXtZ5LCDpyD2Sqw66DYMojw0GulebpqJdrZ0MxiBuJguHu7BC3b8LlVeSWxabkdZ50GhHUD0gRFiX6VhI7uo9g7XNIKcWge6evD+ufqdLHSY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853563; c=relaxed/simple;
	bh=D3aB2TPaBOgBaY6ubt/Pj/i2JtfOvsZZ0/j/ioluwnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9I5AignwcECYLAyab31g3IolnrkP13pJv1d0LaKigRlxvSFbuCX+6WV2w2p8REWnbQZN6BZgxp+Nf6e1yXqd2bhWrpENRYLXyAlkecr1e/67tn65cV3yJ/nhlpoGFg3fJ5JfkdBUdYXN+SYFgJXbyplATGzx8BFYAefwkAImss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id D40AD23389;
	Thu, 30 Oct 2025 22:45:57 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10] seg6: Fix validation of nexthop addresses
Date: Thu, 30 Oct 2025 22:45:56 +0300
Message-Id: <20251030194556.406879-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

commit 7632fedb266d93ed0ed9f487133e6c6314a9b2d1 upstream.

The kernel currently validates that the length of the provided nexthop
address does not exceed the specified length. This can lead to the
kernel reading uninitialized memory if user space provided a shorter
length than the specified one.

Fix by validating that the provided length exactly matches the specified
one.

Fixes: d1df6fd8a1d2 ("ipv6: sr: define core operations for seg6local lightweight tunnel")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250604113252.371528-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kovalev: bp to fix CVE-2025-38310 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/ipv6/seg6_local.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index de0b20cd09f0..26e7498206d8 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -648,10 +648,8 @@ static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_ACTION]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_SRH]	= { .type = NLA_BINARY },
 	[SEG6_LOCAL_TABLE]	= { .type = NLA_U32 },
-	[SEG6_LOCAL_NH4]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct in_addr) },
-	[SEG6_LOCAL_NH6]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct in6_addr) },
+	[SEG6_LOCAL_NH4]	= NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
+	[SEG6_LOCAL_NH6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_LOCAL_IIF]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_OIF]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_BPF]	= { .type = NLA_NESTED },
-- 
2.50.1


