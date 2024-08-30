Return-Path: <stable+bounces-71593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1002D965F07
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722DBB25B96
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1618990F;
	Fri, 30 Aug 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8YmUGYt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57D17BEAD
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013381; cv=none; b=ohtSRZuAdNqC+MllTun4CUuT2vJ9P50mUwhyIrAIFraGIBn4X1W4192vNf1622nGuk/7NDAIoEZIhsj5aDHXPZeRAo7R33UHTGwpRJmsSFWT6mKlgVw/JPq5EU8wNeLrfcbMEszupcZ42dZ73PdxCp0H4v9rS1voljq1ePWaDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013381; c=relaxed/simple;
	bh=k0aHb+HNw7scpSwvROtSeKuK3+zI821LTzF4dubg0rU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QM8++TgaFqTUY6zoe6lfI+U5g3NB303psUHGRcb+V46C7Rykz2SOz8FLFV3SQKlnwCN5S3pAfR8hLni16BwokixNXQHbxGedDVct24uWhemsNpe38sBPHhh1iX2pBLVqHZvKamRhNPHAT/AVzb2Z99CGzg/gDrIBEgo/AMtGVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8YmUGYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56569C4CEC4;
	Fri, 30 Aug 2024 10:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013380;
	bh=k0aHb+HNw7scpSwvROtSeKuK3+zI821LTzF4dubg0rU=;
	h=Subject:To:Cc:From:Date:From;
	b=V8YmUGYtutMJQeQYbM+nKfhKEhD0sjfGCVEYC4OlWslwbei/opDKIKeQsDy8OpS8c
	 j5WTOqtzwT6ZlXzY7CS7jB2a2DY6swP7KmyIj/T+U9Uxea9nt0oLI+VTSpDWP7JY3F
	 FkUgXxoOSQYkdvm4VTYI0DwyQ2figy57imMw0Owk=
Subject: FAILED: patch "[PATCH] mptcp: pm: do not remove already closed subflows" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:22:57 +0200
Message-ID: <2024083057-italics-abrasion-ab81@gregkh>
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
git cherry-pick -x 58e1b66b4e4b8a602d3f2843e8eba00a969ecce2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083057-italics-abrasion-ab81@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

58e1b66b4e4b ("mptcp: pm: do not remove already closed subflows")
967d3c27127e ("mptcp: fix data races on remote_id")
a7cfe7766370 ("mptcp: fix data races on local_id")
84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
f1f26512a9bf ("mptcp: use plain bool instead of custom binary enum")
1e07938e29c5 ("net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}")
1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
fce68b03086f ("mptcp: add scheduled in mptcp_subflow_context")
1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
740ebe35bd3f ("mptcp: add struct mptcp_sched_ops")
a7384f391875 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58e1b66b4e4b8a602d3f2843e8eba00a969ecce2 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:32 +0200
Subject: [PATCH] mptcp: pm: do not remove already closed subflows

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5a84a55e37cc..3ff273e219f2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -838,6 +838,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)


