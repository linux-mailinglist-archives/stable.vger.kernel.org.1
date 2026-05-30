Return-Path: <stable+bounces-257041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHlPB78SG2rM+wgAu9opvQ
	(envelope-from <stable+bounces-257041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:39:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3060E55B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DC6F300E3DF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555B32B11E;
	Sat, 30 May 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luxwV225"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345A1DE4EF;
	Sat, 30 May 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159163; cv=none; b=pGKJkt5bxTBPdWE07Dcvt6jLnOlzLppbk8wuyfu2nxMu9HZl5DQBUer5fxJI+uU0Kgwp8deD979wjsr7hEHW1q2bj8B95X/GMLboAtrEvs/J0DOAecHHDMosuZVAAfhxoEjbesHsSbL9xxT1Fy+uIwhUfE6WM/V/GXGv+kCfknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159163; c=relaxed/simple;
	bh=W06y/WswBr81hpv0PDDx6SNlpPMJ/lN5rwMQYkUnw+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJsKwHn+GnjB45btuTmv+S7b1JBWHrVDuJdU7azsL5tIw7sEIAUUs3jRuFGyKmMZh49g2e5MBevsneR3uNAiLDVBIrT76U6BewxlK6kEomNbFx6s+l3ZgkFNxfUZ7JaWfhb72+8KBKTWLmlH6K540RpKAWq3BtErr6y3Oq7Bfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luxwV225; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E41F00893;
	Sat, 30 May 2026 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159162;
	bh=qmZz7GyvfMKKZsn8mNX5xbgHhJ7f3flY6yW6r0TYmS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=luxwV2252oumvYkUjrkiDI7BrGCy/2TTGyOTt9aDNj2ibtbouwW7aR3uZwlxASkXZ
	 uXEg3feyStktCPk59RnYoXyYsJjPTtKlBHWv/VSsWpCjcufF551Dvd/SFaMdPJn2as
	 g9iQ/WuCJA5mYeDBf/9wxkWp2Zab7aA7dnQ3gwvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4b4093b1f24ad789bf37@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 6.1 106/969] nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
Date: Sat, 30 May 2026 17:53:50 +0200
Message-ID: <20260530160303.245212836@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257041-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,dubeyko.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,4b4093b1f24ad789bf37];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8BB3060E55B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepanshu Kartikey <kartikey406@gmail.com>

commit 4a4e0328edd9e9755843787d28f16dd4165f8b48 upstream.

The DAT inode's btree node cache (i_assoc_inode) is initialized lazily
during btree operations. However, nilfs_mdt_save_to_shadow_map()
assumes i_assoc_inode is already initialized when copying dirty pages
to the shadow map during GC.

If NILFS_IOCTL_CLEAN_SEGMENTS is called immediately after mount before
any btree operation has occurred on the DAT inode, i_assoc_inode is
NULL leading to a general protection fault.

Fix this by calling nilfs_attach_btree_node_cache() on the DAT inode
in nilfs_dat_read() at mount time, ensuring i_assoc_inode is always
initialized before any GC operation can use it.

Reported-by: syzbot+4b4093b1f24ad789bf37@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4b4093b1f24ad789bf37
Tested-by: syzbot+4b4093b1f24ad789bf37@syzkaller.appspotmail.com
Fixes: e897be17a441 ("nilfs2: fix lockdep warnings in page operations for btree nodes")
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/dat.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -526,6 +526,9 @@ int nilfs_dat_read(struct super_block *s
 	if (err)
 		goto failed;
 
+	err = nilfs_attach_btree_node_cache(dat);
+	if (err)
+		goto failed;
 	err = nilfs_read_inode_common(dat, raw_inode);
 	if (err)
 		goto failed;



