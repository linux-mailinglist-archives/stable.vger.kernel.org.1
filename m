Return-Path: <stable+bounces-70189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171195F0DC
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6A81F24C7B
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF216E886;
	Mon, 26 Aug 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ujz74s/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4B15532A
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674031; cv=none; b=VY6mmTqxUpc9juAhhPAiRj11ddN6czrDiHddSfl/rrwjUUD4ev6FhqjnBDe2Yazv8oZShYjEKRmsrzCOdYM7236vSO6tBerRtpVrmjx+Fn9+MncXR2/c5XylmO5pTpCfHK3Z3aAbcklVM8ngxbqK54w+Pc0igvRT1dWuEujXaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674031; c=relaxed/simple;
	bh=f5M1JirC14MrYcIjGV9qKIEH81t058hmk3KUsTVDoSA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gda/Tg2y/CEm2iahr2RUMLUX5z82Wv/1ze4cqIvmvQcsi2kVNaNaM4LYv2zm7AnDN4iwblqiQQrLcbeyXpOD2PyaabSot4o+itwdqHx4WtzJ0Uyo2Bdx/T+MTC2517zsVFTs4UtfEMX5xbB6DWSkfO4vP9y/IJAynnoiRXcB1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ujz74s/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DF2C51430;
	Mon, 26 Aug 2024 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674031;
	bh=f5M1JirC14MrYcIjGV9qKIEH81t058hmk3KUsTVDoSA=;
	h=Subject:To:Cc:From:Date:From;
	b=Ujz74s/bGej/QJDzsj9Mq7fzt0nkLtOeg8SWzfF0NmWYI7qWNVP6+ZaI+YJT70/v4
	 H70DDN/JOLHoJ1w4D81G9hzKqx+Q6sGdRuNemJPx56zgf115DR199pP2udWOANiy3y
	 CCGIYoyRLSnNBKlJUi1rYWl7EEI6AJfz+qcPKKZ0=
Subject: FAILED: patch "[PATCH] mptcp: pm: check add_addr_accept_max before accepting new" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:07:08 +0200
Message-ID: <2024082607-slush-clavicle-60dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0137a3c7c2ea3f9df8ebfc65d78b4ba712a187bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082607-slush-clavicle-60dd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


