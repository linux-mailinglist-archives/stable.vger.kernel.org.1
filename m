Return-Path: <stable+bounces-244320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGw6JjDg+mmGTgMAu9opvQ
	(envelope-from <stable+bounces-244320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C504D69BB
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A46E930179D9
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12DF302756;
	Wed,  6 May 2026 06:31:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635319E97B
	for <stable@vger.kernel.org>; Wed,  6 May 2026 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049069; cv=none; b=DVGE8WpyaMxmWRo3Au7suquQFSqYZxK5H2AEsIJ6M5h03izecZoUWSeZ2/ogH7DopDmpWcCUyWB1DHtSGdg3EKsUmlrsDsrx7X8LEM97Mc7Xri8YEhlWIWJK0u4A3ovhU6dQkd6JTYDWhWrYINf5hW9duRO1X8Oi7spjo6FWtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049069; c=relaxed/simple;
	bh=6zVJUEvbUaRhzUNEM9sbcPUQC6JO46thF3fLM0Scx50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAN0DxJ/mi+eeYOb3+qukvqPTb4GFcuowQrQ+1H5+nVP0Iznxn7n0EE7igDAVDvsaXesPZQiZyrUoGGluAa/vS4ahERI5dFC/dnGUM6lmMOTcvMmwQcXLHxJEjYtx3dXohhRX9HEF5HIteDi41X7VCqFL4WWyWpirug6r3/u/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1778049009t8ac73aed
X-QQ-Originating-IP: cCtPN0ZL1aIrap5QDwH58zNFz43Jt3vGreWcraLNJIE=
Received: from w-MS-7E16.trustnetic.com ( [60.186.244.4])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 May 2026 14:30:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7816696291691624219
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: txgbe: fix RTNL assertion warning when remove module
Date: Wed,  6 May 2026 14:30:00 +0800
Message-ID: <FAAC012B43535C92+20260506063000.658745-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026050105-ascent-escalate-2044@gregkh>
References: <2026050105-ascent-escalate-2044@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MSFJXbmR8y2eDw42JHt2NB/LrOCOvtOGYvBrMho9Hs2IR5ZElB0VuqJ9
	WC3SwpNMDvF5X7U178r9gMutUW4Goa10+zdTKyw1QPb0j/jza2gbQXr2uw/D/cOkNsVymCP
	Sv6I33oNKjXLKjRcUr8fxphGx4mhRgKxQdkmA68t6jaZWCtUmn9sAdG+9YdEEri1jvdzIjI
	mgwzsarLz31BEQjuKYiYvLdXh5331iQ7WFPHxmFL95jgTudAhDm4mONFi2qL+NI5z//3Psl
	hPLmbNFLpHFMj0PC1ImHISK+75lPfjum99f3Xe8r55Btx+PEGXWIY5pa8cvAakH20qXlBXW
	Fmt7vvBGHuiLgIN1kfZw5X5/fAJVWDscnKCUjyhfloCjHop3mwQm+sLJ2hd7/TGcQw7hxYc
	LjKX3yuZWu4Nxz84fow33JzKvgNMOTh2SasHO+oRo5N4qflTZh2/IZVkDlU6k3lj2V9DI1R
	0ATMtVPh2p9LHCFMLydV6C/ZgXfIBvG77RtVDB8zK6M6bdaRTGE+CFHyJ5yEU8lrClIEmn6
	2Y4ZelDUtZUUtaiRd4StMFWBfNDl0QY5tLctvIz4zvcLP5UK6h0VFZc9rcYvubE7egpbSFv
	/NooCIShEp97z5c1fqNaJWH1Gjq81FUkKmX8oLDSAh+9+aRmK1gnNbASqfIP2xzerLuVHES
	8GP9HhOW+qvtBivrhDunD7MvWfJbKmtz5soWvcliLVH2J78HWq2jcziOOMlQ/0c67IzNJh5
	XqCURxnM0r7oEByYiAMlKk5nElRopmQIMmjiG4YY4Y2LUE7GJ6+cVycaY2RdKPqLoNTKqP3
	vK3mou2vqVXb6pm6TYSIJLmLXQbd3ZMwR9TVJnj2qadMY4PyPeTYU/LmJR7icDy4iJB/dSM
	775fxnCKua8CqC6Epu2UeQFuy03u3pwWMFOjfzMNi/wl+ywEbcddsvkzi6YYHS8kysjPLz1
	cpCHBUdE57oM8z1ox3pQ68MrlSSd94CE2gbuvWRubnrLOnXhQjAfLysuNYXtK2Y3fi1ohAV
	EYAJhkYdjA061+VpxPxqaKzx6ZQlaw69Jv3oyPpt1EkANJtEe4XZDenoIzXnGdYqVCnwqjl
	Z6ah397fdf1JExif991HHil3I3/d1QV5gWdcwHwsWLS9VPz0X/U05PCj3FOrfz1Rw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 08C504D69BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244320-lists,stable=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

For the copper NIC with external PHY, the driver called
phylink_connect_phy() during probe and phylink_disconnect_phy() during
remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
upon module remove.

To fix this, add rtnl_lock() and rtnl_unlock() around the
phylink_disconnect_phy() in remove function.

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
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit e159f05e12cc1111a3103b99375ddf0dfd0e7d63)
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 4159c84035fd..2494a3a171fd 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -820,7 +820,9 @@ int txgbe_init_phy(struct txgbe *txgbe)
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
 	if (txgbe->wx->media_type == sp_media_copper) {
+		rtnl_lock();
 		phylink_disconnect_phy(txgbe->phylink);
+		rtnl_unlock();
 		phylink_destroy(txgbe->phylink);
 		return;
 	}
-- 
2.51.0


