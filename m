Return-Path: <stable+bounces-65567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2539694A9B8
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C661F2A817
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09B97D412;
	Wed,  7 Aug 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NIQYoqO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231A763EE
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040108; cv=none; b=Ri/n72Qb6RzgWR/xw9q7pwsCEw8IUGV3I5gle17WxvtMRzyXNfoPdtPvNQHffPB3QEKbr2uwG2/vcb+xGbAxrBx8DiJ7r6J/CJNbJ1qn/ZYk8wthqOaq3mtOKfQVt7dCOVvKwDvBLw0si4UFRnL/31xiHWVksfwCMARuUEY24nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040108; c=relaxed/simple;
	bh=jQFKhJxW0nbHsrudodklahqRY8zJWqojvuPSQo/UegY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aLldAebe1O2UTJeoQvLoW6QC2lKtYoV/0VMP6UuXjoHzNg2WaKlVrXUTXq7EvmwMq0br8QdrKtxUMWS/AY22LpHvsDroF5sjQ0W/PJue690Sp8Ni5mYm6t35ZGPyv4Rfj4BAN8MQhMI2jM/DSUpDt9zUO+9tnlsH/UnC25ZLPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NIQYoqO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85F6C32782;
	Wed,  7 Aug 2024 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040108;
	bh=jQFKhJxW0nbHsrudodklahqRY8zJWqojvuPSQo/UegY=;
	h=Subject:To:Cc:From:Date:From;
	b=NIQYoqO4Tt34Z3hIe9vbUh60DPA/BJUxR5rbtVVdfq83ptybxlbYec79GzCyk9G0p
	 eyxwHMSdO1Sy4YckqRFAQp0br9sxsCm/Zu9QBKF/mkRBLP4RNo1BVc9SS/N0yjqpTc
	 r5hLxgHOvEbrmQ8ivn3NvaA5VIbtta9wizngxrjg=
Subject: FAILED: patch "[PATCH] mptcp: pm: only set request_bkup flag when sending MP_PRIO" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:15:05 +0200
Message-ID: <2024080704-coconut-decorated-b5ae@gregkh>
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
git cherry-pick -x 4258b94831bb7ff28ab80e3c8d94db37db930728
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080704-coconut-decorated-b5ae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4258b94831bb ("mptcp: pm: only set request_bkup flag when sending MP_PRIO")
f5360e9b314c ("mptcp: introduce and use mptcp_pm_send_ack()")
892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
a657430260e5 ("mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags")
c21b50d5912b ("mptcp: Avoid acquiring PM lock for subflow priority changes")
702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
982f17ba1a25 ("mptcp: netlink: split mptcp_pm_parse_addr into two functions")
8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
c682bf536cf4 ("mptcp: add pm_nl_pernet helpers")
0e203c324752 ("mptcp: reset the packet scheduler on PRIO change")
4cf86ae84c71 ("mptcp: strict local address ID selection")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
90d930882139 ("mptcp: constify a bunch of of helpers")
33397b83eee6 ("selftests: mptcp: add backup with port testcase")
09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4258b94831bb7ff28ab80e3c8d94db37db930728 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:25 +0200
Subject: [PATCH] mptcp: pm: only set request_bkup flag when sending MP_PRIO

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..7635fac91539 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,7 +471,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	slow = lock_sock_fast(ssk);
 	if (prio) {
 		subflow->send_mp_prio = 1;
-		subflow->backup = backup;
 		subflow->request_bkup = backup;
 	}
 


