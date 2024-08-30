Return-Path: <stable+bounces-71587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA69965EF6
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4F01F29AB7
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756D192591;
	Fri, 30 Aug 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/86Vb9Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF517BB16
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013305; cv=none; b=WBqbi7IQCxch59gErtQEgs5PfILWg4CRggR9FJf6HMwKZ27z7mo2FbZavAnvZ36C+lU65aW6t+EtVsjhw1DR5hCdOLwWz862lb+3dXEpUM1OhtRdatnBaoDA2yVQMpumHFZxvhxCJ/vZpadpULSISudY3v8/OoQuKVAqGo5QkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013305; c=relaxed/simple;
	bh=CDLgyuSV9PjYzWkrcLnnkJgsMoRvvIRuXgu13xW64ug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CADb5KFCjaDbHDD75Rj6GwHQnOGx1IjuENfCjD6AHWVmN9tn3Y24KLt0VscPX5X5I0MUHeRNERug/kkeDq7a8XsM2QbcrXV/u/+tAKf7Er9I5rmCB/J8ZVPa8Ost6oRN/13c6BKXOggo35yGXSYMX7n6Y9yzYNaNfTRHQgijbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/86Vb9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF0C4CEC2;
	Fri, 30 Aug 2024 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013304;
	bh=CDLgyuSV9PjYzWkrcLnnkJgsMoRvvIRuXgu13xW64ug=;
	h=Subject:To:Cc:From:Date:From;
	b=v/86Vb9Y6IIQQdWirUZ0QSyW5YjV+YWKnhNpIdkdjpevtqrL416++VY0vc2ZyuYpG
	 TRp4pRUhviR+kqJHDK49DQehWv3W6piiqjwCcOIbdeU0L84uYBUfsZh+G0l/U6l7Rs
	 dwhG6WCzCB3Pj4mwYmUaeXb1mxR2QcthJ2ZIi2Nc=
Subject: FAILED: patch "[PATCH] mptcp: pm: reuse ID 0 after delete and re-add" failed to apply to 6.12-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:21:41 +0200
Message-ID: <2024083041-irate-headless-590c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8b8ed1b429f8fa7ebd5632555e7b047bc0620075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083041-irate-headless-590c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b8ed1b429f8fa7ebd5632555e7b047bc0620075 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:24 +0200
Subject: [PATCH] mptcp: pm: reuse ID 0 after delete and re-add

When the endpoint used by the initial subflow is removed and re-added
later, the PM has to force the ID 0, it is a special case imposed by the
MPTCP specs.

Note that the endpoint should then need to be re-added reusing the same
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8d2f97854c64..ec45ab4c66ab 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -585,6 +585,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -609,6 +614,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;


