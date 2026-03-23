Return-Path: <stable+bounces-229907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO1jCuV7wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:44:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B42FA4EE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471933186828
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6353BD62B;
	Mon, 23 Mar 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBp2ZQnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C063BC67C;
	Mon, 23 Mar 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283184; cv=none; b=Ai2hZD18D0+/MYZq0SYbzmlNxz59UEum548mJmFDNKn/cAa5jq/0cyFak38++V4UXVUTF2yltYj8QLbKBKB5iftQrfMiAJQcObjsKK8fpA5fsAQ0+14cD8ed57V7n1mns74VHWjptpCi0HwfZfjKeoDPStLJbgdZCW+1YFTEHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283184; c=relaxed/simple;
	bh=PqdT+JZ+uxTrO2aPvHiGbbdMfsrlkAUo4qBDctlD5xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC7VX2SPm4qD/dneXRjIVCM5JH2OAmAF/V7Rvfr2sJ9MW8VLstw/sjoHch2G3XE40EzS0FWKY4i1l4B7QGvLY8ocSQ3sywzRW9XUVnozBEA5rbD4xGgSUQegbNH3KP9XjKCiUzKZd+M/qQ0pVvWVh3G3O8ugBJgfmbEqoHjHjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBp2ZQnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44634C4CEF7;
	Mon, 23 Mar 2026 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283183;
	bh=PqdT+JZ+uxTrO2aPvHiGbbdMfsrlkAUo4qBDctlD5xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBp2ZQnvHMXTxn6l9FZUWIAc0lAovkKu8xwpdxtdz1OgACrjCGpooM9QDeeP0Wq6X
	 n846vjXIyrl7NTwOwJG7ArMHsZNBHU5g4pT+9foWTc+qIzdsjRlFibQWuDhxaauGDY
	 iwsBbBPYzaGQBYgilmgOl1ve0CWmBfeMvhpgoT5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 434/481] net: bonding: fix NULL deref in bond_debug_rlb_hash_show
Date: Mon, 23 Mar 2026 14:46:56 +0100
Message-ID: <20260323134535.781281317@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,asu.edu,kernel.org];
	TAGGED_FROM(0.00)[bounces-229907-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,asu.edu:email]
X-Rspamd-Queue-Id: 736B42FA4EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 605b52497bf89b3b154674deb135da98f916e390 ]

rlb_clear_slave intentionally keeps RLB hash-table entries on
the rx_hashtbl_used_head list with slave set to NULL when no
replacement slave is available. However, bond_debug_rlb_hash_show
visites client_info->slave without checking if it's NULL.

Other used-list iterators in bond_alb.c already handle this NULL-slave
state safely:

- rlb_update_client returns early on !client_info->slave
- rlb_req_update_slave_clients, rlb_clear_slave, and rlb_rebalance
compare slave values before visiting
- lb_req_update_subnet_clients continues if slave is NULL

The following NULL deref crash can be trigger in
bond_debug_rlb_hash_show:

[    1.289791] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.292058] RIP: 0010:bond_debug_rlb_hash_show (drivers/net/bonding/bond_debugfs.c:41)
[    1.293101] RSP: 0018:ffffc900004a7d00 EFLAGS: 00010286
[    1.293333] RAX: 0000000000000000 RBX: ffff888102b48200 RCX: ffff888102b48204
[    1.293631] RDX: ffff888102b48200 RSI: ffffffff839daad5 RDI: ffff888102815078
[    1.293924] RBP: ffff888102815078 R08: ffff888102b4820e R09: 0000000000000000
[    1.294267] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100f929c0
[    1.294564] R13: ffff888100f92a00 R14: 0000000000000001 R15: ffffc900004a7ed8
[    1.294864] FS:  0000000001395380(0000) GS:ffff888196e75000(0000) knlGS:0000000000000000
[    1.295239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.295480] CR2: 0000000000000000 CR3: 0000000102adc004 CR4: 0000000000772ef0
[    1.295897] Call Trace:
[    1.296134]  seq_read_iter (fs/seq_file.c:231)
[    1.296341]  seq_read (fs/seq_file.c:164)
[    1.296493]  full_proxy_read (fs/debugfs/file.c:378 (discriminator 1))
[    1.296658]  vfs_read (fs/read_write.c:572)
[    1.296981]  ksys_read (fs/read_write.c:717)
[    1.297132]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[    1.297325]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Add a NULL check and print "(none)" for entries with no assigned slave.

Fixes: caafa84251b88 ("bonding: add the debugfs interface to see RLB hash table")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260317005034.1888794-1-xmei5@asu.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_debugfs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 5940945266489..624bf1f745266 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -34,11 +34,17 @@ static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
 	for (; hash_index != RLB_NULL_INDEX;
 	     hash_index = client_info->used_next) {
 		client_info = &(bond_info->rx_hashtbl[hash_index]);
-		seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
-			&client_info->ip_src,
-			&client_info->ip_dst,
-			&client_info->mac_dst,
-			client_info->slave->dev->name);
+		if (client_info->slave)
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst,
+				   client_info->slave->dev->name);
+		else
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM (none)\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst);
 	}
 
 	spin_unlock_bh(&bond->mode_lock);
-- 
2.51.0




