Return-Path: <stable+bounces-52590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957990B989
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4215A1F21A1D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC919A295;
	Mon, 17 Jun 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8pg2yAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AF19755F
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648303; cv=none; b=DN4FLmTv5Kny8kWIYb02a4DKBVLfYrNdmt3B47BVTM10sdcfR+mXavdAA9m5/f+z4S9Xafujt2699LOUDvQc1ZsGuJSEF5aCnhXaqB/x8RvZAgjYdPn23SFLrRHAo0KWc01RPyOuz42XT343qFYHV5/yKS0pKrastSyL2Ckrgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648303; c=relaxed/simple;
	bh=lElnvUof1pTCHGrzQg3zQVS7RHtm9tTdIDqnUljcv2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H6hOeQvlohDDgWQMdtdEifo+RuR3dr1qxOPBs8dQ55Ijhqt9JAVZdHBgkuFMoWA8OFgMSs/5iopxC1O2SXvda7+3Ns0oixeHVdQnB/Sz9P0xWeZE5Si5asCvmCd8V1YC2qTlLH86MHC2Ul1g2OxXCTwie09DGxhwryaOwFi1BQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8pg2yAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC45C2BD10;
	Mon, 17 Jun 2024 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718648302;
	bh=lElnvUof1pTCHGrzQg3zQVS7RHtm9tTdIDqnUljcv2s=;
	h=Subject:To:Cc:From:Date:From;
	b=Q8pg2yAbxifEpEUYevPKkBkt5+sKo4ZkuiiGEgDsFYey78xEayBUQqiEzJ27x/CtA
	 M15Hs7ZDuXiih34si6xa3hTslIvwGWXGPSiiH97lfMhVH353UzWZ5+TYaHCwlDfWkm
	 SVow9M0ntKkps1QR7jY9MPAzzHNEmbXkuWxSbrbw=
Subject: FAILED: patch "[PATCH] mptcp: ensure snd_una is properly initialized on connect" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,cpaasch@apple.com,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:18:19 +0200
Message-ID: <2024061719-prewashed-wimp-a695@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8031b58c3a9b1db3ef68b3bd749fbee2e1e1aaa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061719-prewashed-wimp-a695@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8031b58c3a9b ("mptcp: ensure snd_una is properly initialized on connect")
fb7a0d334894 ("mptcp: ensure snd_nxt is properly initialized on connect")
54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
a42cf9d18278 ("mptcp: poll allow write call before actual connect")
d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
3d1d6d66e156 ("mptcp: implement support for user-space disconnect")
b29fcfb54cd7 ("mptcp: full disconnect implementation")
3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
7cd2802d7496 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8031b58c3a9b1db3ef68b3bd749fbee2e1e1aaa3 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 7 Jun 2024 17:01:48 +0200
Subject: [PATCH] mptcp: ensure snd_una is properly initialized on connect

This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
is properly initialized on connect"). It turns out that syzkaller can
trigger the retransmit after fallback and before processing any other
incoming packet - so that snd_una is still left uninitialized.

Address the issue explicitly initializing snd_una together with snd_nxt
and write_seq.

Suggested-by: Mat Martineau <martineau@kernel.org>
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-1-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 96b113854bd3..bb7dca8aa2d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3740,6 +3740,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
+	WRITE_ONCE(msk->snd_una, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 


