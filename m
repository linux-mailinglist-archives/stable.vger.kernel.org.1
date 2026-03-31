Return-Path: <stable+bounces-231344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOeKLfZ1y2k3HwYAu9opvQ
	(envelope-from <stable+bounces-231344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:21:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F1365079
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E19430CC938
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E93B6C11;
	Tue, 31 Mar 2026 07:11:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7063B5318
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941110; cv=none; b=lpwjUO7QjBBUgA0ByZ/6SoCtBEV8nUbpGbczNKxC3scIaUDooNeU4JMvUpYwyHkRGq6GvXrr0TydGCckzWtwK/i/NylRzPpPqSyI75F9zrfG46eHJfGSuzipoX/+MOpe5jPXG8Om8lqdtb6vnKDogmqpfV8FNX0BftjC7ZDLJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941110; c=relaxed/simple;
	bh=0f3xzzz8ag9SNW7fb5jqQqPgwNvN6ZIv9z48me9iRiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TP5tLVKhjbSd/F9odBZzs97UqvCn+ANzEcfR502T79L/OFjtlFcIL7EI+TKJghdZcHRN31x452eYIcOw6BQu1DEB3UBDm0MXH7V/nClQiChmwRgS0IuJmTK3Q5UtWkFy/Ad2sjKSJNojqEEtQUnVI9cFLsQU1PSMzjnv8YyDt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1774941099t14806ba7
X-QQ-Originating-IP: +nL0vZovCMrBp6hTi9EZPmMc8xhqeBn1iAA2s+VSSKg=
Received: from w-MS-7E16.trustnetic.com ( [115.227.224.139])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Mar 2026 15:11:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14711434964415801438
EX-QQ-RecipientCnt: 13
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Tue, 31 Mar 2026 15:11:07 +0800
Message-ID: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mnff/9wu0oJYBaph783tGB90hZbKcLWoBk1t4ukQ7QC3ln8zuo2BvVYX
	Uggjt+pHJIELWO/A81i37sq2P4bHNqryOaW8l8OxogMtzlxJ5QMzBM0boeVxDaRHLl5RbvF
	Hl1LSM6YI8A2fE/1xzxButtHrMPmSLoxS07F4VROIYWsm2TWb/rRYKIXiJS6T8uH0tJAMS+
	62OuEkCf7csvMCfSLL4C9NuVKboMAZKDtbHnz+CHM/A2nBiyXYvV+6xhKM6kYp0/1x0LGU+
	SUMc4Jhb4YuASsRzMgWZNfn+Do2MPMB4yQ2I1THEOw5UD4NNFUDLQ9sPVB0ln+8rBPMrLDl
	yvOqQj63UL9e3UQNXKX7t3A8Mo/JTFFlY2A3qiI8CvE+puvO2lwaCPc3d4KXcDlR/wFer0W
	kJZ7dOct+VfEW9Q/L0trFJ0znzM8WgKzJAebL5uorq+IEBeA2OQSQ3vKEFKhf9I7jE/G72B
	pqbJYrPffeB9xcA+2Yjr/pAz4k5H4R2TbJ7qRUYMnxQHmWIEaAkE5XtPSuXJhNPygF4azzh
	tQtg9xanU5OmFGktmSw0vIETCDnj0/CepuxNuASmxcGu+laFUsZ2gs0JdQIPWBEYAiGVJFD
	gh1pbjzs0ddMhm5yL8ljowXbNAsgkYQvTdXFyp6P4kBQCZKvRCZIEcW+jIm9jAsUL19+QVR
	xZY6Stf17d+lyzO+HiJcMbK2vUotWfYEoa/g5vdGCU8L0Dclzl52w1FdYv4URskNSWvYtnB
	9sPgPj+nnF6f7wU0sZ9AT5oNFZoeszBkSsNA+jy0lbF9r0dwS+NYiLFkn3PBxpOr0azXNJW
	1p0xV1xK4qM8eTHwHkPu3D9NtIyDvf7vwpLCvR7XNm9MFnY8qxYT6bjrHOah00edfo0YbQ0
	evrClrhOvlG5RRkzdgDyYQGpzn7+mfXs4TRkJDF/ZPA2UefsJ0RYTf8tDtRH+O9twIhPGck
	xnaXUstHYQRW3C0JRBbe6h2lyw5L6NCKZXk56hmCK8ngENAKchw7KRUqyjyYTUisSk+b5uf
	GuR6EGN3dXSIkDaS3qRHpxB1+yNw1MxhZGabDqgIoc1IGE2aGDZp/wd4UH6Xg=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231344-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,intel.com,gmail.com,trustnetic.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 298F1365079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For the copper NIC with external PHY, the driver called
phylink_connect_phy() during probe and phylink_disconnect_phy() during
remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
upon module remove.

To fix this, move the phylink connect/disconnect PHY to ndo_open/close.

 ------------[ cut here ]------------
 RTNL: assertion failed at drivers/net/phy/phylink.c (2351)
 WARNING: drivers/net/phy/phylink.c:2351 at
phylink_disconnect_phy+0xd8/0xf0 [phylink], CPU#0: rmmod/4464
 Modules linked in: ...
 CPU: 0 UID: 0 PID: 4464 Comm: rmmod Kdump: loaded Not tainted 7.0.0-rc4+
 Hardware name: Micro-Star International Co., Ltd. MS-7E16/X670E GAMING
PLUS WIFI (MS-7E16), BIOS 1.90 12/31/2024
 RIP: 0010:phylink_disconnect_phy+0xe4/0xf0 [phylink]
 Code: 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 f6 31 ff e9 3a 38 8f e7
48 8d 3d 48 87 e2 ff ba 2f 09 00 00 48 c7 c6 c1 22 24 c0 <67> 48 0f b9 3a
e9 34 ff ff ff 66 90 90 90 90 90 90 90 90 90 90 90
 RSP: 0018:ffffce7288363ac0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff89654b2a1a00 RCX: 0000000000000000
 RDX: 000000000000092f RSI: ffffffffc02422c1 RDI: ffffffffc0239020
 RBP: ffffce7288363ae8 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff8964c4022000
 R13: ffff89654fce3028 R14: ffff89654ebb4000 R15: ffffffffc0226348
 FS:  0000795e80d93780(0000) GS:ffff896c52857000(0000)
knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00005b528b592000 CR3: 0000000170d0f000 CR4: 0000000000f50ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  txgbe_remove_phy+0xbb/0xd0 [txgbe]
  txgbe_remove+0x4c/0xb0 [txgbe]
  pci_device_remove+0x41/0xb0
  device_remove+0x43/0x80
  device_release_driver_internal+0x206/0x270
  driver_detach+0x4a/0xa0
  bus_remove_driver+0x83/0x120
  driver_unregister+0x2f/0x60
  pci_unregister_driver+0x40/0x90
  txgbe_driver_exit+0x10/0x850 [txgbe]
  __do_sys_delete_module.isra.0+0x1c3/0x2f0
  __x64_sys_delete_module+0x12/0x20
  x64_sys_call+0x20c3/0x2390
  do_syscall_64+0x11c/0x1500
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x15a/0x1500
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_fault+0x312/0x580
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __handle_mm_fault+0x9d5/0x1040
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? count_memcg_events+0x101/0x1d0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? handle_mm_fault+0x1e8/0x2f0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_user_addr_fault+0x2f8/0x820
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? irqentry_exit+0xb2/0x600
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? exc_page_fault+0x92/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 02b2a6f91b90 ("net: txgbe: support copper NIC with external PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c |  8 ++++++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c  | 11 -----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 0de051450a82..b4f95b3188dd 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -474,6 +474,12 @@ static int txgbe_open(struct net_device *netdev)
 	if (err)
 		goto err_free_irq;
 
+	if (wx->phydev) {
+		err = phylink_connect_phy(wx->phylink, wx->phydev);
+		if (err)
+			goto err_free_irq;
+	}
+
 	wx_ptp_init(wx);
 
 	txgbe_up_complete(wx);
@@ -527,6 +533,8 @@ static int txgbe_close(struct net_device *netdev)
 	wx_free_irq(wx);
 	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
+	if (wx->phydev)
+		phylink_disconnect_phy(wx->phylink);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 8ea7aa07ae4e..7268a0c101f3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -294,16 +294,6 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 	if (IS_ERR(phylink))
 		return PTR_ERR(phylink);
 
-	if (wx->phydev) {
-		int ret;
-
-		ret = phylink_connect_phy(phylink, wx->phydev);
-		if (ret) {
-			phylink_destroy(phylink);
-			return ret;
-		}
-	}
-
 	wx->phylink = phylink;
 
 	return 0;
@@ -657,7 +647,6 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 		return;
 	case wx_mac_sp:
 		if (txgbe->wx->media_type == wx_media_copper) {
-			phylink_disconnect_phy(txgbe->wx->phylink);
 			phylink_destroy(txgbe->wx->phylink);
 			return;
 		}
-- 
2.48.1


