Return-Path: <stable+bounces-70191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7529695F0DD
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0498F289C53
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B816F0D2;
	Mon, 26 Aug 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZdgN2pr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD116F273
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674043; cv=none; b=LFgKd2QCnK1q0AY3HLgoYxoW2plyF9o6HojaPMIqg6+6fL9w/jBhPn5yPQ9UtxlA2XgBqBgEINscMrcxEw6mtm7PFnXciLXl7KNrEfqhSQG11f7VFx8TMagDS/9DtL4L8ZRg9nJkfzVQai7qcvJ3Vb8JBNeY8FQVwBJB1UMMUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674043; c=relaxed/simple;
	bh=tahbRM+Az1jI/Ncg+1WHNh8pKXAh0W1zNg9rJd/3LwA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pNJkEFAjXtgDMCJEpfbKhk7oFSYHs28EcTP+78dH27f8DAW0XQwJHIDeWp6iUsj+hUPFnlwth/1H99Lw+tFUwTunxIU3cXR2vgAhWmXjUYsfOED5OQDcotAQGM67F7f4lNo8XsLGqFo8zGxmDXDfG296rgH8IfN+JdM2wNMFT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZdgN2pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E375DC51437;
	Mon, 26 Aug 2024 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674043;
	bh=tahbRM+Az1jI/Ncg+1WHNh8pKXAh0W1zNg9rJd/3LwA=;
	h=Subject:To:Cc:From:Date:From;
	b=bZdgN2pr1YYFY7pufmpObKlpleDp58NrqlR5zKMopoN64FNMnFiSwZybK9Qfk75br
	 HpYQPDh/CiBJ5HDeTZme1elVMvJK6GNA6KGzBmH4tC463abcn2dUjyVIYPkehze2F+
	 BCg834LOgfu9pgsRquue7PWTfRP8VCXNYqjTnKM4=
Subject: FAILED: patch "[PATCH] mptcp: pm: check add_addr_accept_max before accepting new" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:07:09 +0200
Message-ID: <2024082609-vivacious-jaywalker-cfac@gregkh>
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
git cherry-pick -x 0137a3c7c2ea3f9df8ebfc65d78b4ba712a187bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082609-vivacious-jaywalker-cfac@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0137a3c7c2ea ("mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR")
1c1f72137598 ("mptcp: pm: only decrement add_addr_accepted for MPJ req")
322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")
f448451aa62d ("mptcp: pm: remove mptcp_pm_remove_subflow()")
ef34a6ea0cab ("mptcp: pm: re-using ID of unused flushed subflows")
edd8b5d868a4 ("mptcp: pm: re-using ID of unused removed subflows")
4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
6a09788c1a66 ("mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID")
9bbec87ecfe8 ("mptcp: unify pm get_local_id interfaces")
dc886bce753c ("mptcp: export local_address")
8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
c157bbe776b7 ("mptcp: allow the in kernel PM to set MPC subflow priority")
843b5e75efff ("mptcp: fix local endpoint accounting")
d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
982f17ba1a25 ("mptcp: netlink: split mptcp_pm_parse_addr into two functions")
8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0137a3c7c2ea3f9df8ebfc65d78b4ba712a187bb Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:28 +0200
Subject: [PATCH] mptcp: pm: check add_addr_accept_max before accepting new
 ADD_ADDR

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-10-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 882781571c7b..28a9a3726146 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -848,8 +848,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		}
 	}
 }


