Return-Path: <stable+bounces-71590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601D965F00
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D761F2500F
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278817C20F;
	Fri, 30 Aug 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxC+Fp4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6317ADE1
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013355; cv=none; b=UPSvncdv2i6fAptN5/Dem8kz56OvhfHBnI7S02pNuP45ulnPz3OjifyPpxcfzViz5XHVLFO1sYaSDIcLSg+QGDnou7FiT+KZ2PoY712ujHQrOtBzv8148jscX9T+PPpd1+PS72Bw7OVGbJ1EnFUaMKberSzoDwYoqSphROp3ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013355; c=relaxed/simple;
	bh=oBCjlrMFOmWsCjGH/yQtOkboeeGsRie05Br/Hg/cooU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gD5DyPuHT4vn1yqaFpEYSVO4OBeu50E8knQw3WKqShUABEBYcUW9cNHTk9dzFwocZnVXfKp+kV7473O2sYJAjv2zqPbEzQfWKcjaW1uKd0+KPsYl51yVurOSLJYSRGd6sLkJayQM0NhHfJXqZaXqYC7OW/LkLwPDzP/I6fjQRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxC+Fp4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62F2C4CEC2;
	Fri, 30 Aug 2024 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013355;
	bh=oBCjlrMFOmWsCjGH/yQtOkboeeGsRie05Br/Hg/cooU=;
	h=Subject:To:Cc:From:Date:From;
	b=VxC+Fp4dxHYAwGZ+rYsCdAuMmF/X0h/0snedppF6tR4up1B7WhNesyFDa/FsxwnnJ
	 un6cQG+aYR3Uzk21UNX/cF/4bjjbyd//kxpBz5JxL6GlKcmWh1qvlCGBI8dq7cNpit
	 fu2pAitq3KKzQTOCSVD3BT7wqOskW/3+11Lx4Aws=
Subject: FAILED: patch "[PATCH] mptcp: pm: send ACK on an active subflow" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:22:32 +0200
Message-ID: <2024083031-diffuser-strongbox-b85f@gregkh>
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
git cherry-pick -x c07cc3ed895f9bfe0c53b5ed6be710c133b4271c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083031-diffuser-strongbox-b85f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c07cc3ed895f ("mptcp: pm: send ACK on an active subflow")
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

From c07cc3ed895f9bfe0c53b5ed6be710c133b4271c Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:27 +0200
Subject: [PATCH] mptcp: pm: send ACK on an active subflow

Taking the first one on the list doesn't work in some cases, e.g. if the
initial subflow is being removed. Pick another one instead of not
sending anything.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 42d4e7b5f65d..ed2205ef7208 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -765,9 +765,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	    !mptcp_pm_should_rm_signal(msk))
 		return;
 
-	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow)
-		mptcp_pm_send_ack(msk, subflow, false, false);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			mptcp_pm_send_ack(msk, subflow, false, false);
+			break;
+		}
+	}
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,


