Return-Path: <stable+bounces-70229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B695F31E
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174A6B22886
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D20189514;
	Mon, 26 Aug 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mOaJWds0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBD53362
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679444; cv=none; b=hMJNCvMuD9Oz4enWv22SpjR9rL+g7XoatWuOMDTSrnfALFClf63Wy799k4oRnNjZAlhRj3TcEQfBa+UXFiz/qjv08tUG52Fd6aa5X4/aOcgaMV1nz2THpQ49jk91EfGclpsM6GMG8g4VqaJgYnVF2KH/eN4ooPFp85xhKx5TKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679444; c=relaxed/simple;
	bh=dXNQedJI3f0N1m+PvIq0BYAvi3KPmz0LKqDA9mY4234=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N+pB02nJCom6E15UmBF4aiPGMywcTAL3DixYyO3FQw2NKg6Avu5tALsGHZCX+rdJmTi4JtyOS13wPxDXvM8OyfNehbDxCQo1rlwE3ZO1XjfXMSLJl8JKafq3vR8LoT1hIl12CwtuDN6UJvRTT4zcjieUAabv3i5MP8swSP9EjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mOaJWds0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95282C52FDA;
	Mon, 26 Aug 2024 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724679444;
	bh=dXNQedJI3f0N1m+PvIq0BYAvi3KPmz0LKqDA9mY4234=;
	h=Subject:To:Cc:From:Date:From;
	b=mOaJWds0UG80ta6j2XndERuULNQc2K44hDoybdGOyJWgwGR4QiUVskQDQRxWGbqxN
	 mGVAVIkYsAiyURdcXjguVIbJcsnaaMAKftQJVUaE5ihadh1zBkCOx85wRHkdiEp+RU
	 fjZWJvf2z5Zsx09sxPjRD03kfffetUI1E+pF5D10=
Subject: FAILED: patch "[PATCH] mptcp: pm: re-using ID of unused removed ADD_ADDR" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 15:37:21 +0200
Message-ID: <2024082621-unluckily-aghast-028b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e255683c06df572ead96db5efb5d21be30c0efaa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082621-unluckily-aghast-028b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e255683c06df ("mptcp: pm: re-using ID of unused removed ADD_ADDR")
4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
327b9a94e2a8 ("selftests: mptcp: more stable join tests-cases")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e255683c06df572ead96db5efb5d21be30c0efaa Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:19 +0200
Subject: [PATCH] mptcp: pm: re-using ID of unused removed ADD_ADDR

If no subflow is attached to the 'signal' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the address entry from the
list to cover this case.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-1-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cae2aa7be5c..26f0329e16bb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1431,7 +1431,10 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= ret;
+		if (ret) {
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			msk->pm.add_addr_signaled--;
+		}
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}


