Return-Path: <stable+bounces-1940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007127F8212
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CA21C228DC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D34364B7;
	Fri, 24 Nov 2023 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QkTE+aQh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4242C85B;
	Fri, 24 Nov 2023 19:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8CDC433C9;
	Fri, 24 Nov 2023 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852650;
	bh=FK0BAiZWX8xl5uSPbzzQMqJjAiknSGQXl+IY4mKcNYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkTE+aQhT7uUlpM4hUH8ooldbFJKRJSfOWQRqi6tKfYOkim0dVLy7HgwWbsF/aihc
	 Ds1C+tilnV0/0OYMYEYg8hjkYx/qex/sg9xerAbbGZkbPMdBFlyVP1jw3AAM3/D+o3
	 xhnv5rShFuftfbM+M7NXOtnODLCr1IViazV9N+UE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shigeru Yoshida <syoshida@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 069/193] tty: Fix uninit-value access in ppp_sync_receive()
Date: Fri, 24 Nov 2023 17:53:16 +0000
Message-ID: <20231124171950.006813605@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 719639853d88071dfdfd8d9971eca9c283ff314c ]

KMSAN reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
BUG: KMSAN: uninit-value in ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
 ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
 ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
 tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
 tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x75d/0xe80 mm/page_alloc.c:4591
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __page_frag_cache_refill+0x9a/0x2c0 mm/page_alloc.c:4691
 page_frag_alloc_align+0x91/0x5d0 mm/page_alloc.c:4722
 page_frag_alloc include/linux/gfp.h:322 [inline]
 __netdev_alloc_skb+0x215/0x6d0 net/core/skbuff.c:728
 netdev_alloc_skb include/linux/skbuff.h:3225 [inline]
 dev_alloc_skb include/linux/skbuff.h:3238 [inline]
 ppp_sync_input drivers/net/ppp/ppp_synctty.c:669 [inline]
 ppp_sync_receive+0x237/0xe70 drivers/net/ppp/ppp_synctty.c:334
 tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
 tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 12950 Comm: syz-executor.1 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

ppp_sync_input() checks the first 2 bytes of the data are PPP_ALLSTATIONS
and PPP_UI. However, if the data length is 1 and the first byte is
PPP_ALLSTATIONS, an access to an uninitialized value occurs when checking
PPP_UI. This patch resolves this issue by checking the data length.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_synctty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index f774b7e52da44..e37d9a05f3077 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -699,7 +699,7 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 
 	/* strip address/control field if present */
 	p = skb->data;
-	if (p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
+	if (skb->len >= 2 && p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
 		/* chop off address/control */
 		if (skb->len < 3)
 			goto err;
-- 
2.42.0




