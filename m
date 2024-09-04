Return-Path: <stable+bounces-73006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65096B996
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D032824E4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089E1CFECB;
	Wed,  4 Sep 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMCnUcLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B31D0146;
	Wed,  4 Sep 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447801; cv=none; b=l+YqqHHEvXFuQT4//LFNHKuP1iHGCRP6QEl/JMOL6K5M2Yrp066YSOOfGZRvtUjiTAfswfb6GTZyhFY4B+1daac14ULNai9yIN8CxYKZmwGFkCJFV0lJY9+BKx2KkbUZfFVF/XDE4CD7g79O79LuzAT9dWnuT+DIJZhBGuHQsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447801; c=relaxed/simple;
	bh=s7pS7oL/MX+Sa7j4G6xrDQ9RdUABxAkZiWQqX73kIck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMYX9AKdsODcdRjc0B7Cblf6E2jC3Oe2v8yACtnHRV+txVOwZHfWeNIbJ+xcrUntaZS8G9LJHrn10t65kdoWpyI1o7SfTGFRt315Eyka2ddoiZrgHPHetySHxw7zkARqxXp9W7jbUQ+ghlg434z6cEXjfck9oqN4pdP7kXLhVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMCnUcLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411CCC4CECE;
	Wed,  4 Sep 2024 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447801;
	bh=s7pS7oL/MX+Sa7j4G6xrDQ9RdUABxAkZiWQqX73kIck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMCnUcLokscQoRdZ2MJb5kuqcy/T2Z/T8bV6DIDb/iwEqGOA7eH279LNfOHOrDZoK
	 hyrX9VxEju9B+JRczcr2w+3XHOjavaKj8f36T+AH7PIGo7gHLgbPYhTyDGLcSx7rKB
	 VehNP/M9SroXKNGaBCv6qNs36rn74qK/pvVJFhdRUEt46+cHscI3caXVFt7rJpYRsK
	 0/928eMMvH3qz83RL/5aFqTzmNg10+oAReU69vyrleCqS5pjGxpFab+nUTPk0th8ZE
	 vFMTBAncAOxnoZ47/YO8z0HqshPL33R75x9echp9XH1cBvW0McYW2mfaWYcdqdNw1u
	 QUeXgbFkf7hPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 2/2] mptcp: pm: fix ID 0 endp usage after multiple re-creations
Date: Wed,  4 Sep 2024 13:03:09 +0200
Message-ID: <20240904110306.4082410-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904105721.4075460-2-matttbe@kernel.org>
References: <20240904105721.4075460-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=matttbe@kernel.org; h=from:subject; bh=s7pS7oL/MX+Sa7j4G6xrDQ9RdUABxAkZiWQqX73kIck=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D5qujF5A70uJcGYXIXoq3AMxr+Pdqi1pY/rc NqU2vylU7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg+agAKCRD2t4JPQmmg c8p4D/4jCMOjWfT4IG2R/ujup+mRODDku7ZMhylTo1iD8m/oW+OZMb0oL3xjBd5Ua5OwJQDoFac +oTysoyGpiys3bKV67MmO2LpG4XLd8gGNS42qZ5wVBtc3imFcHboVKlmVYMQYgQGRzCNsPrXqBj veKOpYw7KkFQPSE0qO8hCL9rmMvGsnq4oglXh59+M7NSoz97XOLc6Yt3qUs5GMpBGhD/w88/P0N QeyFpP1aAr6k/HwRcEIZcFpyPM+2u3acloJ+JVuo71IP8A6VC4vORF4y066y+76CmXa74eKkhzg KDx7ZJ6MILEIHCHHtKDkvf3RvJkQqp+55QKaIw8XrNU1m5SovofX7rWQYosZdHYULSd5JxohUBN IaYr2yxlKhBrbAz+TBrwk+2cdaROYxL8g+uMAS61mr62W+Z9IBRI53IP9sQZpREJWGu7DDSuFJ/ ua5dRyYAOwhl2gyS+enGXiV/thVlMhrXjcOWRV60TRhnsRjV+8PUtTOIvFk7C5MvTeVzVoLXl28 TtqfF0AoxGjMSYgcLmxzDu5gXnzGSvcrRSTqd8Id70gKWLPnpe62WTNGw5D6qsRBZ96AyPT7Sb6 wjewupCQZpwZl1LWzgKxQAG7g4DAwI/B39/FidIqdE/Mw6JbSBtJ+YwQZx5M7SksI66nN2ST7Ki dtX5KcV7LqZzb9g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 9366922adc6a71378ca01f898c41be295309f044 upstream.

'local_addr_used' and 'add_addr_accepted' are decremented for addresses
not related to the initial subflow (ID0), because the source and
destination addresses of the initial subflows are known from the
beginning: they don't count as "additional local address being used" or
"ADD_ADDR being accepted".

It is then required not to increment them when the entrypoint used by
the initial subflow is removed and re-added during a connection. Without
this modification, this entrypoint cannot be removed and re-added more
than once.

Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Reported-by: syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/00000000000049861306209237f4@google.com
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c834de47bddc..2f8a13589ed6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -627,12 +627,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
@@ -758,7 +759,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);
-- 
2.45.2


