Return-Path: <stable+bounces-239561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI/IL7Rl5mlmvwEAu9opvQ
	(envelope-from <stable+bounces-239561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C0431E65
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE26328A993
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6F3368AF;
	Mon, 20 Apr 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oEudqxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F59329C6D;
	Mon, 20 Apr 2026 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700568; cv=none; b=tW5yJb7u14fgW2DLa4z2JAOr6xt7ZjPI4Re3BWyWtACHngFuXkEHQuRYElO+7/jhWqcmT7luKHJSWY77hU/KFMU/ezD7eDMJ04XklQQUvh/grqAmY4SEpTIW5+SLbUMJuNq5GV4k4uL97KQ1Eb8ITAusB7sBGxU4jcTmVwSbysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700568; c=relaxed/simple;
	bh=LWaBeTjlM0N8NwGEAIrVj71DWYIaLIGoEGEuqHhNB9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuKJ9H8GcDiN3rN4Yt3UPoPRXcOwnfP52XqWWYuaArx7pikqK2Z3k3aCJdAW+yIjiE5uAxkNVlooAiwhSiIh45t1KgwcHjCu4WlVmVe/2gJoiyeBNyPQjMz5t33ryr1715X+7HS83KWrOMmiM31nPJaqc4Dc3e7MmocDvesbK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1oEudqxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BAEC19425;
	Mon, 20 Apr 2026 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700568;
	bh=LWaBeTjlM0N8NwGEAIrVj71DWYIaLIGoEGEuqHhNB9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1oEudqxTWGd3A/q+CrTHwAP/sIlPYBQPa0R4J2Hjygc3QMz4bvgmf43zZqq/ktJ6m
	 G+1KTnrnYOLA3PvFAeLit818UcqyIIzYBuE2QTMryh/uxJWnSsGiix6suu7qKsKbJy
	 6jzeeihwUxqEs/TLkA0Gt+wrf5jwGo6KJilrBcNA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4b4093b1f24ad789bf37@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 6.19 215/220] nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
Date: Mon, 20 Apr 2026 17:42:36 +0200
Message-ID: <20260420153941.767517316@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239561-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,4b4093b1f24ad789bf37];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,dubeyko.com:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 4D9C0431E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -524,6 +524,9 @@ int nilfs_dat_read(struct super_block *s
 	if (err)
 		goto failed;
 
+	err = nilfs_attach_btree_node_cache(dat);
+	if (err)
+		goto failed;
 	err = nilfs_read_inode_common(dat, raw_inode);
 	if (err)
 		goto failed;



