Return-Path: <stable+bounces-77585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A29861DB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628571F2C8D5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D20217306;
	Wed, 25 Sep 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC55H9C4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52C18EFDC;
	Wed, 25 Sep 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266379; cv=none; b=PODmFrrpF7RVjg4bXTunjHMaKli6XF8LanvuuoH1FBJuXC1c3IA2FUYW1w0y3dnkzZREe62jNMDBShIgb+R0N6Y0J3X1icgitVs9XT5O0zLZk0EHFyvrh76+uStGJ/+cwtfMzCn1dXhmq91cvp/7UU2cxTcGr0T6O7z+UcECpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266379; c=relaxed/simple;
	bh=/8bbaxOVkO/telWX8TtdIY6zIXNORdjn83x/VWJ56s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQUBVOBLWAjVn7PSWqsPtzX0EzwOtpDs238qcBIrRvXHLcXCwbe2JiH61GFSATh25Q3Y/ORFD4t7KgUHYPqjBpu/mWrqH5LCqkHlX065E2KYLsEYEEznbsFKtv1+JvVXohYIHaTibmhc8hOk6YNo7LcOugbKcDTwwR+ZF4jqm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC55H9C4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC405C4CEC3;
	Wed, 25 Sep 2024 12:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266379;
	bh=/8bbaxOVkO/telWX8TtdIY6zIXNORdjn83x/VWJ56s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uC55H9C4TRNvPsVmLjbuztu8v+QrLcw5R98WsSecyvcxkUMAg7UjEX266Bpt1nF8f
	 MzT8jZQ3NRvQdymQ5MbmkCuFXSaDSqfZLDd4rBOo3qfGqZ7lziLLP5i/gvg667u/dl
	 g+bCuj6wtk24gckdiyGLksrLLZPG+EUKLa7jzVY881xcTydbblnstG+05R+O2ZMAMN
	 hGrvEnDaIIv7xyc3+OkTqrEoczOmhTmCrF5K5xAru8+/KrLFGkqOS5BKTehGlm+1Mv
	 noHZ/gve4VCx6jvVTBgfYiv/uics0FKHrvQeftqMzreNZsiY6NM0DtY+pOCVQK1ELe
	 fxD6dogR4p37g==
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
Subject: [PATCH AUTOSEL 6.6 039/139] ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family
Date: Wed, 25 Sep 2024 08:07:39 -0400
Message-ID: <20240925121137.1307574-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 390f4be7f7bec..90ce87ffed461 100644
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


