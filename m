Return-Path: <stable+bounces-167257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554FB22F38
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451E87A7744
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60462FD1D6;
	Tue, 12 Aug 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IP3Rmm7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63B2FD1CE;
	Tue, 12 Aug 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020212; cv=none; b=NoRKH90NNBbsZhHU9RUrAVsfbZSLceuqrm6cGzQfQHw+dMC0DB437H2RXtLSzLEadq1Wf0zywUGDtax4Dwsx+9O6+On3bahE4shy1gfomCgE8A1VOVFG18JGhDv7ur+qVNOEiE4Dtv3VBiy/jqs0wYcfaAqv3SiSoFvIiuyPsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020212; c=relaxed/simple;
	bh=bJ6iaY2+kpc1GRNx07qoeVcF2HzvNER8JbubmpSyCOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZRdX9nbEDkNOWFOMdGe+sov19P9PaoVg432STYWm/1edo2CARq9+jIGDJfAhkUV4vXpnBQwH3l+ukv9Y/AUDMiRPqXx4XCvV5gcj51fJuaKCtryM80GXaXLy9K8vzAjbXceNldtDb/3BEBKrhHH++QOLxxXHK09HWQVAkMs8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IP3Rmm7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801AFC4CEF0;
	Tue, 12 Aug 2025 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020211;
	bh=bJ6iaY2+kpc1GRNx07qoeVcF2HzvNER8JbubmpSyCOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IP3Rmm7JIKey32rO2ge1WFhnsXTkpliuRwq3X72oSznEFWyNAHoIF2tylNvKEcE1u
	 1JelvRPTvX6cjQkUtiI2gaWBKJ9n5FrK7IfpRpqkez/4XekMrQPRDl0/cD9dnKbHe7
	 BOHY32pjJhdyVnYAHgqc8xY0p4gvEVR+I+aB2s3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lonial Con <kongln9170@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/253] xfrm: interface: fix use-after-free after changing collect_md xfrm interface
Date: Tue, 12 Aug 2025 19:26:40 +0200
Message-ID: <20250812172949.228854758@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eyal Birger <eyal.birger@gmail.com>

[ Upstream commit a90b2a1aaacbcf0f91d7e4868ad6c51c5dee814b ]

collect_md property on xfrm interfaces can only be set on device creation,
thus xfrmi_changelink() should fail when called on such interfaces.

The check to enforce this was done only in the case where the xi was
returned from xfrmi_locate() which doesn't look for the collect_md
interface, and thus the validation was never reached.

Calling changelink would thus errornously place the special interface xi
in the xfrmi_net->xfrmi hash, but since it also exists in the
xfrmi_net->collect_md_xfrmi pointer it would lead to a double free when
the net namespace was taken down [1].

Change the check to use the xi from netdev_priv which is available earlier
in the function to prevent changes in xfrm collect_md interfaces.

[1] resulting oops:
[    8.516540] kernel BUG at net/core/dev.c:12029!
[    8.516552] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    8.516559] CPU: 0 UID: 0 PID: 12 Comm: kworker/u80:0 Not tainted 6.15.0-virtme #5 PREEMPT(voluntary)
[    8.516565] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    8.516569] Workqueue: netns cleanup_net
[    8.516579] RIP: 0010:unregister_netdevice_many_notify+0x101/0xab0
[    8.516590] Code: 90 0f 0b 90 48 8b b0 78 01 00 00 48 8b 90 80 01 00 00 48 89 56 08 48 89 32 4c 89 80 78 01 00 00 48 89 b8 80 01 00 00 eb ac 90 <0f> 0b 48 8b 45 00 4c 8d a0 88 fe ff ff 48 39 c5 74 5c 41 80 bc 24
[    8.516593] RSP: 0018:ffffa93b8006bd30 EFLAGS: 00010206
[    8.516598] RAX: ffff98fe4226e000 RBX: ffffa93b8006bd58 RCX: ffffa93b8006bc60
[    8.516601] RDX: 0000000000000004 RSI: 0000000000000000 RDI: dead000000000122
[    8.516603] RBP: ffffa93b8006bdd8 R08: dead000000000100 R09: ffff98fe4133c100
[    8.516605] R10: 0000000000000000 R11: 00000000000003d2 R12: ffffa93b8006be00
[    8.516608] R13: ffffffff96c1a510 R14: ffffffff96c1a510 R15: ffffa93b8006be00
[    8.516615] FS:  0000000000000000(0000) GS:ffff98fee73b7000(0000) knlGS:0000000000000000
[    8.516619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.516622] CR2: 00007fcd2abd0700 CR3: 000000003aa40000 CR4: 0000000000752ef0
[    8.516625] PKRU: 55555554
[    8.516627] Call Trace:
[    8.516632]  <TASK>
[    8.516635]  ? rtnl_is_locked+0x15/0x20
[    8.516641]  ? unregister_netdevice_queue+0x29/0xf0
[    8.516650]  ops_undo_list+0x1f2/0x220
[    8.516659]  cleanup_net+0x1ad/0x2e0
[    8.516664]  process_one_work+0x160/0x380
[    8.516673]  worker_thread+0x2aa/0x3c0
[    8.516679]  ? __pfx_worker_thread+0x10/0x10
[    8.516686]  kthread+0xfb/0x200
[    8.516690]  ? __pfx_kthread+0x10/0x10
[    8.516693]  ? __pfx_kthread+0x10/0x10
[    8.516697]  ret_from_fork+0x82/0xf0
[    8.516705]  ? __pfx_kthread+0x10/0x10
[    8.516709]  ret_from_fork_asm+0x1a/0x30
[    8.516718]  </TASK>

Fixes: abc340b38ba2 ("xfrm: interface: support collect metadata mode")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_interface_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 85501b77f4e37..45466fa4ace43 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -871,7 +871,7 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
-	if (p.collect_md) {
+	if (p.collect_md || xi->p.collect_md) {
 		NL_SET_ERR_MSG(extack, "collect_md can't be changed");
 		return -EINVAL;
 	}
@@ -882,11 +882,6 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	} else {
 		if (xi->dev != dev)
 			return -EEXIST;
-		if (xi->p.collect_md) {
-			NL_SET_ERR_MSG(extack,
-				       "device can't be changed to collect_md");
-			return -EINVAL;
-		}
 	}
 
 	return xfrmi_update(xi, &p);
-- 
2.39.5




