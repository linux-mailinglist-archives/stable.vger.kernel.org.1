Return-Path: <stable+bounces-83951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390499CD51
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836891C22652
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DA17C77;
	Mon, 14 Oct 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMuIZ0Oi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03920EB;
	Mon, 14 Oct 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916297; cv=none; b=QO2qRd0KuFBD55+CGIO6N6ADbkQCEGhSgU0BlLMgOla4Ist/1a6ekaT9ahge6o59wwmy5dxSF9tTZDmwQG1C5vW/a6e6kmZAqnBLPhAj/4Be4OmXhbXerQke9cGoS1MN9mn20DsDdcyDnWTKdQgUQfkll48HTfbw2GEebzCGJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916297; c=relaxed/simple;
	bh=VMsg7KM3r0D2jle2EoEKFe0HDmKYqyXYF/T+ST27+/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf/Y/EQ1fRjUgPaRHfv2TxDYO7HFKDpfGyydLxGaXWarwNK7RjchYpD/FT6ovrzAE8Fz4rRternVCPES0nXaJhsx6+FRhNTABIIzsUBC6mg/JDXyq67Ha4CT/+sB9CtS5hXCnrTw129iMSQ6YclBjQzWgWNZzby6UnYArTLMv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMuIZ0Oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E04C4CEC3;
	Mon, 14 Oct 2024 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916297;
	bh=VMsg7KM3r0D2jle2EoEKFe0HDmKYqyXYF/T+ST27+/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMuIZ0OiYxInWuTIXGDfEs49r8RcQNUT5oStQseA2Cdbqj8q4WFSO+V4Yb7Nm73RW
	 c7YlIj0wsyPBg7Il48eop4S0V8BR+ZhQPRh80D8bl2n1Dc/W/X8hF+J0lMfN40DMiM
	 OdzRP59EUWXlaxS+whi6m4GePWSSH2B+/x24ftPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 142/214] vxlan: Handle error of rtnl_register_module().
Date: Mon, 14 Oct 2024 16:20:05 +0200
Message-ID: <20241014141050.529591590@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 78b7b991838a4a6baeaad934addc4db2c5917eb8 ]

Since introduced, vxlan_vnifilter_init() has been ignoring the
returned value of rtnl_register_module(), which could fail silently.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's handle the errors by rtnl_register_many().

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c      |  6 +++++-
 drivers/net/vxlan/vxlan_private.h   |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c | 19 +++++++++----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ba59e92ab941d..02919c529dc2d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4913,9 +4913,13 @@ static int __init vxlan_init_module(void)
 	if (rc)
 		goto out4;
 
-	vxlan_vnifilter_init();
+	rc = vxlan_vnifilter_init();
+	if (rc)
+		goto out5;
 
 	return 0;
+out5:
+	rtnl_link_unregister(&vxlan_link_ops);
 out4:
 	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
 out3:
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b35d96b788437..76a351a997d51 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -202,7 +202,7 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 int vxlan_vnigroup_init(struct vxlan_dev *vxlan);
 void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan);
 
-void vxlan_vnifilter_init(void);
+int vxlan_vnifilter_init(void);
 void vxlan_vnifilter_uninit(void);
 void vxlan_vnifilter_count(struct vxlan_dev *vxlan, __be32 vni,
 			   struct vxlan_vni_node *vninode,
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 9c59d0bf8c3de..d2023e7131bd4 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -992,19 +992,18 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void vxlan_vnifilter_init(void)
+static const struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},
+	{THIS_MODULE, PF_BRIDGE, RTM_NEWTUNNEL, vxlan_vnifilter_process, NULL, 0},
+	{THIS_MODULE, PF_BRIDGE, RTM_DELTUNNEL, vxlan_vnifilter_process, NULL, 0},
+};
+
+int vxlan_vnifilter_init(void)
 {
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL,
-			     vxlan_vnifilter_dump, 0);
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_NEWTUNNEL,
-			     vxlan_vnifilter_process, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_DELTUNNEL,
-			     vxlan_vnifilter_process, NULL, 0);
+	return rtnl_register_many(vxlan_vnifilter_rtnl_msg_handlers);
 }
 
 void vxlan_vnifilter_uninit(void)
 {
-	rtnl_unregister(PF_BRIDGE, RTM_GETTUNNEL);
-	rtnl_unregister(PF_BRIDGE, RTM_NEWTUNNEL);
-	rtnl_unregister(PF_BRIDGE, RTM_DELTUNNEL);
+	rtnl_unregister_many(vxlan_vnifilter_rtnl_msg_handlers);
 }
-- 
2.43.0




