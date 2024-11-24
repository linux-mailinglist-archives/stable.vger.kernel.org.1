Return-Path: <stable+bounces-95198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0F9D747D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4744AB47613
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727F23A2C9;
	Sun, 24 Nov 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocPTPzoB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B291E25EB;
	Sun, 24 Nov 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456306; cv=none; b=KTdPn9F5u7v6KL/JFUAE/HsGX2ucnIW5VwCofxODBJv9ECiqXrN+GetoCqoi7277X4s245gk/heUSGPfWISW8ZvRrP8VX9HweM1WWICeMdBznyEeLaDyIYt+qYCev/rGO6CZBn1hXAgWXJ2lYEJhzPf1fWrociqjmsTk0j8IXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456306; c=relaxed/simple;
	bh=Dwp/aMXUNtBpX3FIaNI6rUQnp9o8/mvwz6IW95drRM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJJrxBjt3w8lNpcfootyH733f1z7dqeftATaKm2XH/BSDsrApRkQCC3D+ZRHBH6act0Jtw2RqpRWPpiJE9vYkXztbT7lBkvyVX1w7Jg78OGyLLZE1uIIV2GPaQs+omQOr27DPOvUQ6n6g2L4I/4MhCT1I41Gi2ZasmKnA8ILjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocPTPzoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA41C4CECC;
	Sun, 24 Nov 2024 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456306;
	bh=Dwp/aMXUNtBpX3FIaNI6rUQnp9o8/mvwz6IW95drRM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocPTPzoBtoJMiwVWqT7SttTFnfRBvJyTJAPJM38qz4ksbmSsIjM91dx1HdxdBu13K
	 Qb9mvbYRRKmIyoW6Bc/tlEP9HqXgx7gPL0xIsmOEy4d4LSXQJb4u43kUbV8TNDA29O
	 0xZMXSDQDJ1ATj9msIZC8oiFphpzb1QhECKB055r8jNU/wAB4eQoPtOERjGtP6H6P/
	 sCLHn3istzpwKN3MOr5TExKLo6LTmMpeHZC2VjVUSz5MQnY8RdcmLkgzKfPAynK3lO
	 qI1XRDxB3LBq5rC96a76EP98u8tLoSzzi8GuNuPgTwRu5lTX/3dYhBzmMXyUIHuJlO
	 a1x1n2/rDruiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	gnaaman@drivenets.com,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 47/48] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:49:10 -0500
Message-ID: <20241124134950.3348099-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0de6a472c3b38432b2f184bd64eb70d9ea36d107 ]

Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
data checking") added strict checking. The err variable is not cleared,
so if we find no table to dump we will return the validation error even
if user did not want strict checking.

I think the only way to hit this is to send an buggy request, and ask
for a table which doesn't exist, so there's no point treating this
as a real fix. I only noticed it because a syzbot repro depended on it
to trigger another bug.

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241115003221.733593-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c842f150c3048..dd0965e1afe85 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2865,6 +2865,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0


