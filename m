Return-Path: <stable+bounces-239736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJGnIsNa5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:56:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F372B4303ED
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B976231E22DC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A033EAF9;
	Mon, 20 Apr 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YgN5sFib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5B280CD2;
	Mon, 20 Apr 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701085; cv=none; b=KxkSgvph37RzFaiu47bkrDsVHkcmCdAhYey3IAocOefBbl7W6sxTVW7RixjtqXvaOBfwMLosE/AK/2n0pXVD2uffpB0v5SknVbbfz8iecSyeAx5Zjp0stQdti3ciZ1cmWTgjhPUJSO1l7DEiF0H6WodZjojZzUasDFeXt4ZJK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701085; c=relaxed/simple;
	bh=H0k+KnFlQy5tgYlBFg/eLlTGq1ZsukSiboRgPLcwH0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9hN33OF1VDHMaI7fg/A6wpPAPkE5pu509+Ls2eKb9cBRJ2zN8XRuRZMXE3/btUSLYEprAfmXKm4BrgBQ0gV9UopZmwNBI/op6xFmFVgOtSR9/I1lEzU6ny5Rt9yVRODWNNCXFfWYs9cj5qwpYb1POIJqjYHLhgq12HFPj2jU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YgN5sFib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EBBC19425;
	Mon, 20 Apr 2026 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701085;
	bh=H0k+KnFlQy5tgYlBFg/eLlTGq1ZsukSiboRgPLcwH0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgN5sFibf1vxcwXXQJGlWe8oV/TSFxmUS+3jsr+EhQtfnPXHjzRZa5OWnB2h3F13d
	 kKLvEreP7D27liNaVMWjanxy5+EPUA5q2YWpmxhxwpV3w4HPxsvZIidfKukkVcTt37
	 oLtZLiZX96HJvhXPEjvGUMuw5sptw1lJotx2uesc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 174/198] ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()
Date: Mon, 20 Apr 2026 17:42:33 +0200
Message-ID: <20260420153941.879142829@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-239736-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yandex.ru,syzkaller.appspotmail.com,linux.alibaba.com,gmail.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,c16daba279a1161acfb0];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,syzkaller.appspot.com:url,evilplan.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email,alibaba.com:email,appspotmail.com:email,oracle.com:email,linux-foundation.org:email,live.cn:email,fasheh.com:email]
X-Rspamd-Queue-Id: F372B4303ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit a2b1c419ff72ec62ff5831684e30cd1d4f0b09ee ]

In 'ocfs2_validate_inode_block()', add an extra check whether an inode
with inline data (i.e.  self-contained) has no clusters, thus preventing
an invalid inode from being passed to 'ocfs2_evict_inode()' and below.

Link: https://lkml.kernel.org/r/20251023141650.417129-1-dmantipov@yandex.ru
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7bc5da4842be ("ocfs2: fix out-of-bounds write in ocfs2_write_end_inline")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/inode.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1505,6 +1505,14 @@ int ocfs2_validate_inode_block(struct su
 		goto bail;
 	}
 
+	if ((le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
+	    le32_to_cpu(di->i_clusters)) {
+		rc = ocfs2_error(sb, "Invalid dinode %llu: %u clusters\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le32_to_cpu(di->i_clusters));
+		goto bail;
+	}
+
 	rc = 0;
 
 bail:



