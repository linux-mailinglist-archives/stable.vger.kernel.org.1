Return-Path: <stable+bounces-77386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C94985CE1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCDDB23017
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DFD1D1752;
	Wed, 25 Sep 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv27oM4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AFE1D1748;
	Wed, 25 Sep 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265594; cv=none; b=sCxNp4HpvpEZcLOOdVAnbOlR99T+e/YcQdglyaz6n2vAZGtgJPMkDL41Dof5TaP7fzkG8j9cubzJf1MMf86D/EzZxtQ93TwfNy4ynEnO7zxvnngBM0hbi/34IGl1DdfjaIC1oOMsKY/Bh/WJizJZpHuuZkU6qjEJFPn9tCPPTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265594; c=relaxed/simple;
	bh=Dg6F9/TsOKG9pUqppnD8udwkdrd50YCxFON/evrdAGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef7+IIHXxCszDUiuq90IqydoBunl/UCHbHOsJzRD/yOZCWQ8RwpnSnPF2/brQke2noiZvZZxyv7UhvsX3bH4slyW7ZOZ3IoUYQL5DgMQiEmxqiqX0VsZwOiy23LzUvFxGVlggcghmUT29INYmF8+aa8428jJ6mV2XJpm2IWrvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv27oM4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C1FC4CEC7;
	Wed, 25 Sep 2024 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265594;
	bh=Dg6F9/TsOKG9pUqppnD8udwkdrd50YCxFON/evrdAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dv27oM4Eo4pTF1V+zt/GACB5+zD9F+JCH7ZlfpUQat8axBlI5vgAyDKRUaDS/bzRe
	 4S/WRmoKuO6zixcrmTa0XKwtwBuDZdBTXyRr7I4Kow0PTURvUqu2eOWtE+hJWvVvGN
	 D2wiH/8iZqz3EUDrycynceeKY4ow6CZB8k9oMJGnA0RkTUltJsmKieb2RbW3PFWJz4
	 BEyGpSbFR1Rnkb8cwLTf1LcnGgtBhoV2+EsYWTF7WsIbBPpv4p3dFfBiAvniMGfJBy
	 iZ/05/pqyh1w6nkLDCDm+3pbqeO65962YDx1fyOT1iW9B7edSmmzIvV4u7sVqOGS1z
	 3NHMVq99ws10A==
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
Subject: [PATCH AUTOSEL 6.10 041/197] ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family
Date: Wed, 25 Sep 2024 07:51:00 -0400
Message-ID: <20240925115823.1303019-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


