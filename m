Return-Path: <stable+bounces-230415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IPxKoKlxGmZ1wQAu9opvQ
	(envelope-from <stable+bounces-230415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 04:18:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001632EB11
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 04:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 946643043AFD
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0C392C31;
	Thu, 26 Mar 2026 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eZiJF6Z9"
X-Original-To: stable@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9233921C8
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495093; cv=none; b=RILBaaoXZWZDZqcp5wOiRb5WTGKaRwAaBxuh53zkm+0Rk3R0ocdFXulVr2xU8tI2MFw9gqeOwGjM7cf5SRUlD8qFzGt9trs2totnX03KI635MoEuCfDqQ7aKFl/no0hwi+bZrLiqvuVEoe5bRhUW/qvUFuh5rR1N6HzA+pnS/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495093; c=relaxed/simple;
	bh=5bQ84/Wihhmebd3SLk75uhUtAKAKqbgl8lGfkH6WarA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BtycBKv3DMeQamOuBYdr0D25PMY1SqVwbafTyWJwltPWqBeWi0Biy5CQDvXYgnFN7K1d7jxGP0r02+GtT6ml20SSdO27XZse5wFithSdkzgIiqEM7GAOQQPMIxGaiir7qSEIMBRnWZarmsSpXexnqJtzsx8kfC46999MZEbacWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eZiJF6Z9; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774495088;
	bh=0hO+1H0a1Ekui1yDC8Wvpu+rnMGfVRgZsrKomK+irs0=;
	h=From:Subject:Date:Message-Id;
	b=eZiJF6Z9csDG05GdLpxMPmudImH5DVegbmgd5vVDBq/pO60xnywkDsVU6GunHAX3O
	 JbKgmG4K0ZgVdl/yeqkqexRTG0nJRAayoikvvwzhqBg6SGvEi5T2sDL0haIzboB5E2
	 z87+wBzIme/f7Xtd2evEXhOsPrPTv3/BASwRcsFE=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.23) with ESMTP
	id 69C4A56A000046CB; Thu, 26 Mar 2026 11:18:04 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 8625828912926
X-SMAIL-UIID: 1F4593A008014914B8E50DE26C6AF9EC-20260326-111804-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wang Yufen <wangyufen@huawei.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] netdevsim: Fix memory leak of nsim_dev->fa_cookie
Date: Thu, 26 Mar 2026 11:18:02 +0800
Message-Id: <20260326031802.2410719-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230415-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,mellanox.com,kernel.org,sina.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:dkim,sina.com:email,sina.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6001632EB11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wang Yufen <wangyufen@huawei.com>

[ Upstream commit 064bc7312bd09a48798418663090be0c776183db ]

kmemleak reports this issue:

unreferenced object 0xffff8881bac872d0 (size 8):
  comm "sh", pid 58603, jiffies 4481524462 (age 68.065s)
  hex dump (first 8 bytes):
    04 00 00 00 de ad be ef                          ........
  backtrace:
    [<00000000c80b8577>] __kmalloc+0x49/0x150
    [<000000005292b8c6>] nsim_dev_trap_fa_cookie_write+0xc1/0x210 [netdevsim]
    [<0000000093d78e77>] full_proxy_write+0xf3/0x180
    [<000000005a662c16>] vfs_write+0x1c5/0xaf0
    [<000000007aabf84a>] ksys_write+0xed/0x1c0
    [<000000005f1d2e47>] do_syscall_64+0x3b/0x90
    [<000000006001c6ec>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

The issue occurs in the following scenarios:

nsim_dev_trap_fa_cookie_write()
  kmalloc() fa_cookie
  nsim_dev->fa_cookie = fa_cookie
..
nsim_drv_remove()

The fa_cookie allocked in nsim_dev_trap_fa_cookie_write() is not freed. To
fix, add kfree(nsim_dev->fa_cookie) to nsim_drv_remove().

Fixes: d3cbb907ae57 ("netdevsim: add ACL trap reporting cookie as a metadata")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Link: https://lore.kernel.org/r/1668504625-14698-1-git-send-email-wangyufen@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The context change is due to the commit 5e388f3dc38c
("netdevsim: move vfconfig to nsim_dev") in v5.16
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/net/netdevsim/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index a7279356299a..d8f91bc38f40 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1582,6 +1582,7 @@ void nsim_dev_remove(struct nsim_bus_dev *nsim_bus_dev)
 				  ARRAY_SIZE(nsim_devlink_params));
 	devlink_unregister(devlink);
 	devlink_resources_unregister(devlink, NULL);
+	kfree(nsim_dev->fa_cookie);
 	devlink_free(devlink);
 }
 
-- 
2.34.1


