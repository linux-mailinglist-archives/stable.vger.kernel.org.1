Return-Path: <stable+bounces-168431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0208B2351E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED9D6E6047
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1F2EF652;
	Tue, 12 Aug 2025 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+e8BbDn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767772FDC33;
	Tue, 12 Aug 2025 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024145; cv=none; b=VakgjP4MtNdd8nIJHuScb3wB0JJfwoX0Qtt/+L84V8cwB9UHQM/QZ8xkWJabOIud6hjQng4uCgIi28EEqHVf8wmppYTe84O9K0wzivdFry/GQ0RzSMctXXkKEAQhKaNG/WB1h4tVN3pSsRCgTITTFz2F2bGYQ1LCnhEY7Et44iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024145; c=relaxed/simple;
	bh=877TOsAoZr7KajgDuuB2aFswCdHbrWsie4Fs/emXWbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJYa7VnfRZn7LWAozs2ehDUIvfRb6ekBDuK8SOhGfQCmNc+lVm5KYRSrHyQ028k4HPIHzGv99ywEgrDS2JSsKZLi5AIjRGjgrPsTXJz1zibQVtx0WbDDEAL1dNNFuUqUp/VcpQ/4tbqnUafj6G2duIRWoyE173pS/UXlpag4l2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+e8BbDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71B9C4CEF0;
	Tue, 12 Aug 2025 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024145;
	bh=877TOsAoZr7KajgDuuB2aFswCdHbrWsie4Fs/emXWbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+e8BbDnzWPnnrFz/ghv5oy4LwT6TaHrrVf0hLug0AsXR7N5AnnJGVlBu0RwuV5Ly
	 tO5e0CWq/hY7w4dTVzSa8AGuDThWboKu6qmby2nCPCLPkpSoHWStBTOA1ORPw6i3XL
	 s0Sk3/1zXHiGXgciqvtmo6XuIqeExVPbRZ6iKujM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 288/627] ipv6: fix possible infinite loop in fib6_info_uses_dev()
Date: Tue, 12 Aug 2025 19:29:43 +0200
Message-ID: <20250812173430.268613358@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f8d8ce1b515a0a6af72b30502670a406cfb75073 ]

fib6_info_uses_dev() seems to rely on RCU without an explicit
protection.

Like the prior fix in rt6_nlmsg_size(),
we need to make sure fib6_del_route() or fib6_add_rt2node()
have not removed the anchor from the list, or we risk an infinite loop.

Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250725140725.3626540-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2aeca451aab3..bf71c8ce002f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5958,16 +5958,21 @@ static bool fib6_info_uses_dev(const struct fib6_info *f6i,
 	if (f6i->fib6_nh->fib_nh_dev == dev)
 		return true;
 
-	if (f6i->fib6_nsiblings) {
-		struct fib6_info *sibling, *next_sibling;
+	if (READ_ONCE(f6i->fib6_nsiblings)) {
+		const struct fib6_info *sibling;
 
-		list_for_each_entry_safe(sibling, next_sibling,
-					 &f6i->fib6_siblings, fib6_siblings) {
-			if (sibling->fib6_nh->fib_nh_dev == dev)
+		rcu_read_lock();
+		list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+					fib6_siblings) {
+			if (sibling->fib6_nh->fib_nh_dev == dev) {
+				rcu_read_unlock();
 				return true;
+			}
+			if (!READ_ONCE(f6i->fib6_nsiblings))
+				break;
 		}
+		rcu_read_unlock();
 	}
-
 	return false;
 }
 
-- 
2.39.5




