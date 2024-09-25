Return-Path: <stable+bounces-77148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3098592A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1623B2810FE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350319AA7A;
	Wed, 25 Sep 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxPgt+Q4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0D19AA57;
	Wed, 25 Sep 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264307; cv=none; b=hZDexT7G1w+5kDX2ZM//noR+/7vTZHu+3uceN/IQGvIm3Ph+5pIwiqPDCyWdNx5huGXBOE/k4bMTord+TXx1PaU+OndWLAGHdAqKviNkW+OCJGKTzMojOfKZgzhimif0CP5vIbgyWvfG+vdvfpS0H6esmkLia3T5tfDE7zvJTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264307; c=relaxed/simple;
	bh=Dg6F9/TsOKG9pUqppnD8udwkdrd50YCxFON/evrdAGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iv7Op0I/p5H62fROlh2FQArn5dSeKPIEZZdgU449yO513gsujm6EhCjEzy81dtys5MQ5r3wO6PxbxlwobKfKqgBQaov2PaPJkG/TTuNMyh+eIItifgO+FP133iosKFiFKzdx5A+9FKFi6weXXzhebp/mLwYkuz7m2uF7uwEDi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxPgt+Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4224CC4CEC7;
	Wed, 25 Sep 2024 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264306;
	bh=Dg6F9/TsOKG9pUqppnD8udwkdrd50YCxFON/evrdAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxPgt+Q44wZBRc9Q9zVyRt1bOdk/Ifq68iGtwplC2ThGfXJOSSQPglstzEUV0RjmT
	 aK2/wL3ICJlV+0s4NRuFhLIKiY0m2UD4yNQJm/m53S/uJpeebc2ybRTibMKIM/Kg5c
	 0p2kjYFgvHK4YDzXU3yKnCDxNp6R82qBhLF7trOUdeX3RDsWfkiqf/JneP3jeKyoj8
	 CkIAndlXwS8RMNwtqzzjRu54eCe6tM5ng/pAQHpn2lwbvEXsH/f5m1RcRqiYcgDbZd
	 q0qfnbIb2UqAob13ebFwAZsLkTmkzC4Hqkd7tHGkMd0h14J9pCorT+3NNrvEkhUeHI
	 GOZX+1tRMTeiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 050/244] ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family
Date: Wed, 25 Sep 2024 07:24:31 -0400
Message-ID: <20240925113641.1297102-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 8fed54758cd248cd311a2b5c1e180abef1866237 ]

The NETLINK_FIB_LOOKUP netlink family can be used to perform a FIB
lookup according to user provided parameters and communicate the result
back to user space.

However, unlike other users of the FIB lookup API, the upper DSCP bits
and the ECN bits of the DS field are not masked, which can result in the
wrong result being returned.

Solve this by masking the upper DSCP bits and the ECN bits using
IPTOS_RT_MASK.

The structure that communicates the request and the response is not
exported to user space, so it is unlikely that this netlink family is
actually in use [1].

[1] https://lore.kernel.org/netdev/ZpqpB8vJU%2FQ6LSqa@debian/

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 7ad2cafb92763..da540ddb7af65 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1343,7 +1343,7 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 	struct flowi4           fl4 = {
 		.flowi4_mark = frn->fl_mark,
 		.daddr = frn->fl_addr,
-		.flowi4_tos = frn->fl_tos,
+		.flowi4_tos = frn->fl_tos & IPTOS_RT_MASK,
 		.flowi4_scope = frn->fl_scope,
 	};
 	struct fib_table *tb;
-- 
2.43.0


