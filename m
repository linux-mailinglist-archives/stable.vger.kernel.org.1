Return-Path: <stable+bounces-42496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB88B734D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B36E1C2320D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4883012CDAE;
	Tue, 30 Apr 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufm9Quvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8C1E50A;
	Tue, 30 Apr 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475852; cv=none; b=JfVL1F1iaicvcnVGe/wOjzKl2BlUpSj2bZm6JhihcC6BpDc+w5PDeEYU7cpQRrcIqLUqiM3wOQvRfUG8dueAelWwuctIC2NmLABZH5sj2hvmi9+eP0pWmW9ZE/ZrfQUF/QRiuMnsNAGFwYu/DJSWHLl8KBuMvXumMpo33pfi340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475852; c=relaxed/simple;
	bh=yJ+Bcv45cR+LvesUdPkM9xhzOeMc5jy88F4QF5xeRfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA9vYg+lNOyaRvrEoZDRd5qxuc8qnsqyc+u9GPSURTIsjlxTWodnmRVXNWMsNzCirvizRFqp4Q+uMuTW1xh4dZryY1e+Nqm4GSOXh7/+ZvpkiY0wG3EF/t9Et7eJPiqJOq/Gfrou/Podmc4bPkHB54eYLg4hEj8jWz20S9+SsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufm9Quvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B52C2BBFC;
	Tue, 30 Apr 2024 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475851;
	bh=yJ+Bcv45cR+LvesUdPkM9xhzOeMc5jy88F4QF5xeRfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufm9QuvyjNjRteKxrfq9yd1txaKN7wNAdmjO2Be3ru3OOBMKV7T7upqRAyVfz2SiH
	 ZUG+U8rYyOi5jMNvx58R+jYiyP2JxPdS0hwKaNTa05PzCjyUTKf6OoFifOT+sCEKYM
	 ssHa+CdykxgZBxc1YM4RP2p4IwowVZKEyM1MvBVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 38/80] netfilter: nf_tables: honor table dormant flag from netdev release event path
Date: Tue, 30 Apr 2024 12:40:10 +0200
Message-ID: <20240430103044.543303303@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 8e30abc9ace4f0add4cd761dfdbfaebae5632dd2 ]

Check for table dormant flag otherwise netdev release event path tries
to unregister an already unregistered hook.

[524854.857999] ------------[ cut here ]------------
[524854.858010] WARNING: CPU: 0 PID: 3386599 at net/netfilter/core.c:501 __nf_unregister_net_hook+0x21a/0x260
[...]
[524854.858848] CPU: 0 PID: 3386599 Comm: kworker/u32:2 Not tainted 6.9.0-rc3+ #365
[524854.858869] Workqueue: netns cleanup_net
[524854.858886] RIP: 0010:__nf_unregister_net_hook+0x21a/0x260
[524854.858903] Code: 24 e8 aa 73 83 ff 48 63 43 1c 83 f8 01 0f 85 3d ff ff ff e8 98 d1 f0 ff 48 8b 3c 24 e8 8f 73 83 ff 48 63 43 1c e9 26 ff ff ff <0f> 0b 48 83 c4 18 48 c7 c7 00 68 e9 82 5b 5d 41 5c 41 5d 41 5e 41
[524854.858914] RSP: 0018:ffff8881e36d79e0 EFLAGS: 00010246
[524854.858926] RAX: 0000000000000000 RBX: ffff8881339ae790 RCX: ffffffff81ba524a
[524854.858936] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8881c8a16438
[524854.858945] RBP: ffff8881c8a16438 R08: 0000000000000001 R09: ffffed103c6daf34
[524854.858954] R10: ffff8881e36d79a7 R11: 0000000000000000 R12: 0000000000000005
[524854.858962] R13: ffff8881c8a16000 R14: 0000000000000000 R15: ffff8881351b5a00
[524854.858971] FS:  0000000000000000(0000) GS:ffff888390800000(0000) knlGS:0000000000000000
[524854.858982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[524854.858991] CR2: 00007fc9be0f16f4 CR3: 00000001437cc004 CR4: 00000000001706f0
[524854.859000] Call Trace:
[524854.859006]  <TASK>
[524854.859013]  ? __warn+0x9f/0x1a0
[524854.859027]  ? __nf_unregister_net_hook+0x21a/0x260
[524854.859044]  ? report_bug+0x1b1/0x1e0
[524854.859060]  ? handle_bug+0x3c/0x70
[524854.859071]  ? exc_invalid_op+0x17/0x40
[524854.859083]  ? asm_exc_invalid_op+0x1a/0x20
[524854.859100]  ? __nf_unregister_net_hook+0x6a/0x260
[524854.859116]  ? __nf_unregister_net_hook+0x21a/0x260
[524854.859135]  nf_tables_netdev_event+0x337/0x390 [nf_tables]
[524854.859304]  ? __pfx_nf_tables_netdev_event+0x10/0x10 [nf_tables]
[524854.859461]  ? packet_notifier+0xb3/0x360
[524854.859476]  ? _raw_spin_unlock_irqrestore+0x11/0x40
[524854.859489]  ? dcbnl_netdevice_event+0x35/0x140
[524854.859507]  ? __pfx_nf_tables_netdev_event+0x10/0x10 [nf_tables]
[524854.859661]  notifier_call_chain+0x7d/0x140
[524854.859677]  unregister_netdevice_many_notify+0x5e1/0xae0

Fixes: d54725cd11a5 ("netfilter: nf_tables: support for multiple devices per netdev hook")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_chain_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 35aa4ea942051..8c76ca4d86a8a 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -336,7 +336,9 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		return;
 
 	if (n > 1) {
-		nf_unregister_net_hook(ctx->net, &found->ops);
+		if (!(ctx->chain->table->flags & NFT_TABLE_F_DORMANT))
+			nf_unregister_net_hook(ctx->net, &found->ops);
+
 		list_del_rcu(&found->list);
 		kfree_rcu(found, rcu);
 		return;
-- 
2.43.0




