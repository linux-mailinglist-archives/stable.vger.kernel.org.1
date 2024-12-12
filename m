Return-Path: <stable+bounces-100983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB99EE9C7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392FE280F80
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC9216606;
	Thu, 12 Dec 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQKKWCBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C38218594;
	Thu, 12 Dec 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015843; cv=none; b=pAlPjF4v6/3SodCG0osxdtPPHgSG4nxCjwr3z3eLseaw5KQh0i69GQQAJxGRhwrTE2K6wq3y5NjozUUytq1+HN6kZ2Z2me3AlVyhXDPgfNaYwQViXvh4vUhEhmEnHPRGT6PrmrX8ETrYwkVgW+GiqTPhgJiBENr+r1MKIyS/m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015843; c=relaxed/simple;
	bh=5WVXJuLIATHnji1BulnNgrBnsrdU2aX9i5wyMCVyThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxkuOeqkRCi4uHHiAnjFl5durfTTrPK63vmS79UQGZxyntMne+IWcQA2ObNNlR7z+LGFKgxWIXwh39NprkGHbhEFO7Xs6bvz+SNpJ8OcVmkW36+d+ni1Zqw9rDQqTswwfpNBVKpnxnQ2CJ3N7vj8mc3/cpkxv3F4apKijYN7piQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQKKWCBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C19C4CEDE;
	Thu, 12 Dec 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734015843;
	bh=5WVXJuLIATHnji1BulnNgrBnsrdU2aX9i5wyMCVyThg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQKKWCBpH6pBQyMVfi6sz0mHKujbWhxbzgihSnfHhPa9XRKFOP7Am4pbqFKk1NBbu
	 8iO2Z7ebY9v4v/O5YWYdDH0WYryP3B49I0knbljqd9UXJMZKU0RMKhmvjdpp8wzV13
	 g+e9AzuFuQCsX8SMDykUouSoQsv3/H0hWedsifHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Wiesner <jwiesner@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 030/466] net/ipv6: release expired exception dst cached in socket
Date: Thu, 12 Dec 2024 15:53:19 +0100
Message-ID: <20241212144307.876431172@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Jiri Wiesner <jwiesner@suse.de>

[ Upstream commit 3301ab7d5aeb0fe270f73a3d4810c9d1b6a9f045 ]

Dst objects get leaked in ip6_negative_advice() when this function is
executed for an expired IPv6 route located in the exception table. There
are several conditions that must be fulfilled for the leak to occur:
* an ICMPv6 packet indicating a change of the MTU for the path is received,
  resulting in an exception dst being created
* a TCP connection that uses the exception dst for routing packets must
  start timing out so that TCP begins retransmissions
* after the exception dst expires, the FIB6 garbage collector must not run
  before TCP executes ip6_negative_advice() for the expired exception dst

When TCP executes ip6_negative_advice() for an exception dst that has
expired and if no other socket holds a reference to the exception dst, the
refcount of the exception dst is 2, which corresponds to the increment
made by dst_init() and the increment made by the TCP socket for which the
connection is timing out. The refcount made by the socket is never
released. The refcount of the dst is decremented in sk_dst_reset() but
that decrement is counteracted by a dst_hold() intentionally placed just
before the sk_dst_reset() in ip6_negative_advice(). After
ip6_negative_advice() has finished, there is no other object tied to the
dst. The socket lost its reference stored in sk_dst_cache and the dst is
no longer in the exception table. The exception dst becomes a leaked
object.

As a result of this dst leak, an unbalanced refcount is reported for the
loopback device of a net namespace being destroyed under kernels that do
not contain e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev"):
unregister_netdevice: waiting for lo to become free. Usage count = 2

Fix the dst leak by removing the dst_hold() in ip6_negative_advice(). The
patch that introduced the dst_hold() in ip6_negative_advice() was
92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b22
merely refactored the code with regards to the dst refcount so the issue
was present even before 92f1655aa2b22. The bug was introduced in
54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually
expired.") where the expired cached route is deleted and the sk_dst_cache
member of the socket is set to NULL by calling dst_negative_advice() but
the refcount belonging to the socket is left unbalanced.

The IPv4 version - ipv4_negative_advice() - is not affected by this bug.
When the TCP connection times out ipv4_negative_advice() merely resets the
sk_dst_cache of the socket while decrementing the refcount of the
exception dst.

Fixes: 92f1655aa2b22 ("net: fix __dst_negative_advice() race")
Fixes: 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually expired.")
Link: https://lore.kernel.org/netdev/20241113105611.GA6723@incl/T/#u
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241128085950.GA4505@incl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index cff4fbbc66efb..8ebfed5d63232 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2780,10 +2780,10 @@ static void ip6_negative_advice(struct sock *sk,
 	if (rt->rt6i_flags & RTF_CACHE) {
 		rcu_read_lock();
 		if (rt6_check_expired(rt)) {
-			/* counteract the dst_release() in sk_dst_reset() */
-			dst_hold(dst);
+			/* rt/dst can not be destroyed yet,
+			 * because of rcu_read_lock()
+			 */
 			sk_dst_reset(sk);
-
 			rt6_remove_exception_rt(rt);
 		}
 		rcu_read_unlock();
-- 
2.43.0




