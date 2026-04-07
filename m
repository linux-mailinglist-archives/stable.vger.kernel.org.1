Return-Path: <stable+bounces-233531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEyzJ4rS1Gl/xwcAu9opvQ
	(envelope-from <stable+bounces-233531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:46:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA233AC45C
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8050D302EEC6
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3B3A5E7C;
	Tue,  7 Apr 2026 09:42:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F026ED45;
	Tue,  7 Apr 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554954; cv=none; b=Y838dgW6A79XZvuAkpBSQFacc06HlenL0uRq7+QW3WHpKSq2WARPON+qTbFAjZsY3BBwVVMW6cbr2/beeVo/JOx/f7/Pyepvf/hHAj2ybaStju4seJkvgwKTzioG3x+QjrVv6vLMYJ+dNv3kXQrvGfmXClHUlv5jOe1ltCkeF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554954; c=relaxed/simple;
	bh=Y7ZnMXEFIEemEET8vrnmFEFBonhOELzPkEsKH3dqgKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ofe7hH15EHXyejr1qvIDhsL0LQTQasN0Rv8CW3CQgNfzNcow1ilrrwLEPd6NYns6xuBLSNBOcuVGlwTt4/lqIX8mLe/v5uhUxvhf8MzwSYdycOeo5o9NoKXS3oHi9hoPmTXKvBY2k6JsV4vuMRzWzPaZt3mu0Hslbjnee1odjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1775554856t4604b7cb
X-QQ-Originating-IP: OVA3AjnluGGBB4XcG7C//Qjq9AZrRV4YZ0LZvpCcQss=
Received: from w-MS-7E16.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 17:40:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6970311505155291080
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: txgbe: fix RTNL assertion warning when remove module
Date: Tue,  7 Apr 2026 17:40:41 +0800
Message-ID: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MWdgP8+gtiFRLnOhkuZH/p/+sYFPjRX8obKadQV50g51gITSe2lF+N37
	0aJPeDAU7BpOO3uT9ktDmZqmPTx1r+8mZec9jdsqRCxXPnxbLVzOBu1wrCOzlUyTQx71CzO
	3OJP+Ylnqi2YfS5fqBZ9+ZGYUKKD2Ql/F27ZQLr/ZeDzExuaYYOUwn9Iid9wkE7c8Jowp+J
	eAYp10Q4OGLGY+N3/uTR87dks9kxiQU8jBrb4837xhzemLUfSdz8Atuim4Va5GQml9H00ea
	Ybn2BqLIDsUjLfoGDPgADYzLhmSSjTd0VKMrYETFE6vX7ZIS3HqXu3FPi79RkHJJv7hzADe
	Z9x8lxGWxafgsMVQlCGDffBf9HaRn2p1GQMLXIvTHpqstW26IB/Tr5AGpAEcHYZgTki5UPM
	Z2Eb0wN2chIlGkGz5mC5axQf8Sq5VJhZ/HJPPmcb+g1WNElSRQ69DPNpoRE4vDtoshRgSw9
	MhuAJ08s2v2ldTw3n4BzsAKUgQQXiv+3FyJAD1N4a5yGb7uSFlzF01YE6etg3iBxV/pVDB+
	hyHyzle8JMFRVb9ud2Oj0hDAqNRXnTwfrKK/5m6c8AWzgCWMhWfudTuhgJmnXqjcur3N3gM
	VocbOP/hnEBD80g4sWPQswFhg2AOFleaF2WI+alWCrJkwtYSthOXNZRgOAc+UeP5GRptOb3
	zn5eCPo2m0RToogHCoFeN8GXrdT47w8zD6SmIcK/Our0+507UrlNBm3rsVEO6V77Z9z0srB
	rpnl6TDkDjxNOQ77wRceyZMOKcv+EPN8Ayc7SrmuwRtLFodzF1wA/U4FCrFWVYrKCChHfeK
	gxAATm6OhrczGXXyF10Vg/Z2Qev2YXqxXhEj9EPulFRS6/X5HEa9uLuCkY5zd5xjGui6hy/
	hl3mOCYPxukqlW6SiMvfse09rOxOiItOl6sGOQMvDErTGjl1HuGvC1z3jjP/OMqi9vaH4qK
	4sBT7ira1yCoKdsfui/Aac47IG57VUl91eVD+Rhy05m7YIWJ8qM/hlNejQeSZMQyD1hhpg/
	BMLRXo6kTqEoRt6T6lk5Jtsmo5t62unU1tdYaV51gzzvv5iTQczh1tJMd6tM88JovUzeqyt
	/d+UFh4MRKf
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233531-lists,stable=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.526];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable,netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[54.206.16.166:received,115.220.225.134:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DA233AC45C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
v2:
- Add RTNL lock instead of moving phylink connect/disconnect functions.

v1: https://lore.kernel.org/all/D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 8ea7aa07ae4e..dc9f24314658 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -657,7 +657,9 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 		return;
 	case wx_mac_sp:
 		if (txgbe->wx->media_type == wx_media_copper) {
+			rtnl_lock();
 			phylink_disconnect_phy(txgbe->wx->phylink);
+			rtnl_unlock();
 			phylink_destroy(txgbe->wx->phylink);
 			return;
 		}
-- 
2.48.1


