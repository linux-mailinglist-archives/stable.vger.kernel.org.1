Return-Path: <stable+bounces-217069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKD3NTXUlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FBA15052E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F4363044652
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B628851C;
	Tue, 17 Feb 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzQ6e0SH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A35259CBD;
	Tue, 17 Feb 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361317; cv=none; b=aD+FDExRV0muiDwgVsMH5lEp+8NotyzjOcuOWEyQClDP2HGACvJYLD7IcF+UyLjDqt1/tXdvN5MhgcAz03swKpF0MU0c1DhbxwJMXpv/GE3ouoVlrLE7vVSVlIhsfnxd2PvYj32Mh3JVUBcyG/QPitr6ABlkzppUO8KS8s+aYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361317; c=relaxed/simple;
	bh=SX9VNMEvIy1eb/i9/Axpu/Y6vwVB4/TA9QWUP6OPUZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVK586dhBFkcZCYzAlUW4o3sU1dInW8+9TDqQXh3YdMgm9O3deBH8rJ9dSZvrZ49bcYcnauOuDR2vD/OcpvMAPrWwyzVyFga6gUJIGuwL24l4+zau3ZiKNmRwu3XDdzcDxE0XcR9zJJFqhuNmRobX3nGEyy8iGYlhakV5fimmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzQ6e0SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26CEC4CEF7;
	Tue, 17 Feb 2026 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361317;
	bh=SX9VNMEvIy1eb/i9/Axpu/Y6vwVB4/TA9QWUP6OPUZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzQ6e0SH4QecAfXoBYyl6XvOuOZmw/b57vIJDm87CBNfN5TJouZeSsZKYYqRkongp
	 P+Ki4l9JejPnk835dy4TyYf03Vwl9QJwUz7SgArzEHAQ5E11PPAjqeSY08MPKw9eux
	 Zg23uEmc9NXQHEQs1ryzj+hXApsGyep0UYKPwUzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+9c4e33e12283d9437c25@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 33/64] romfs: check sb_set_blocksize() return value
Date: Tue, 17 Feb 2026 21:31:29 +0100
Message-ID: <20260217200008.755504722@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217069-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,9c4e33e12283d9437c25];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 76FBA15052E
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit ab7ad7abb3660c58ffffdf07ff3bb976e7e0afa0 ]

romfs_fill_super() ignores the return value of sb_set_blocksize(), which
can fail if the requested block size is incompatible with the block
device's configuration.

This can be triggered by setting a loop device's block size larger than
PAGE_SIZE using ioctl(LOOP_SET_BLOCK_SIZE, 32768), then mounting a romfs
filesystem on that device.

When sb_set_blocksize(sb, ROMBSIZE) is called with ROMBSIZE=4096 but the
device has logical_block_size=32768, bdev_validate_blocksize() fails
because the requested size is smaller than the device's logical block
size. sb_set_blocksize() returns 0 (failure), but romfs ignores this and
continues mounting.

The superblock's block size remains at the device's logical block size
(32768). Later, when sb_bread() attempts I/O with this oversized block
size, it triggers a kernel BUG in folio_set_bh():

    kernel BUG at fs/buffer.c:1582!
    BUG_ON(size > PAGE_SIZE);

Fix by checking the return value of sb_set_blocksize() and failing the
mount with -EINVAL if it returns 0.

Reported-by: syzbot+9c4e33e12283d9437c25@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c4e33e12283d9437c25
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Link: https://patch.msgid.link/20260113084037.1167887-1-kartikey406@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/romfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b43..3bc993634321a 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -468,7 +468,10 @@ static int romfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 #ifdef CONFIG_BLOCK
 	if (!sb->s_mtd) {
-		sb_set_blocksize(sb, ROMBSIZE);
+		if (!sb_set_blocksize(sb, ROMBSIZE)) {
+			errorf(fc, "romfs: unable to set blocksize\n");
+			return -EINVAL;
+		}
 	} else {
 		sb->s_blocksize = ROMBSIZE;
 		sb->s_blocksize_bits = blksize_bits(ROMBSIZE);
-- 
2.51.0




