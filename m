Return-Path: <stable+bounces-236148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAUAFTcP3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8263EE1E1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C6A3300DCE8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E333BBC0;
	Mon, 13 Apr 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gasi3Ut/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F27262F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095029; cv=none; b=ifH6DTLJ3v8erJ13Vau4yIs8QIBayeX9co02rU4U8h/h/W/8Os+h/nyYcSkuhsWzlJA5m4ZUxkWSXG6YRpPMyDnxyL6AxK42aYvEJuUz3UBfKLiZOH6hCDJ+4DO2EJ6s9BVMziVHkGi+sx2b7a3p+IUWqQ4CJ3vuNBBv2o6s7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095029; c=relaxed/simple;
	bh=M0bVPkrbbIhDenLowMcleSfAmGwfFjbyg+hGjP2nJ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl5FkstH1I1EvElIjyHyIRBaYxWsyCBgZ7thfQNhzy6Tf2inG0POFneNZ8GW+ckPiP9qXS2xykE6pzvkAWOqrgG8p3jAaZdEHZE1XrHPacpy4mjgGS9LigOBRhCdm14TqDrgtmDjMtthTZzg9+xNaFCR448j7bk7lk/h0hSdQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gasi3Ut/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA28C2BCAF;
	Mon, 13 Apr 2026 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095028;
	bh=M0bVPkrbbIhDenLowMcleSfAmGwfFjbyg+hGjP2nJ60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gasi3Ut/7xrwwnnks3gcIvOGXKkwWKOaZP++Q+AL+3IzvTwHdch/96/BK9w/d9Jr2
	 EAWzw0aryir2Ogdqn4D07xn+7nNTtMQY6SluFOozxwpp9nZ/r0bKvfnqkkD3E123Fl
	 h5R6RFtXrplDpIPcHrh/F1D1G6J7SIu6HuzRYQzAQTgUCCT437CwwoB2EkCuMCBuzB
	 yVbmoOKO4hRj4TgPXXe89RCyVl1p2maj0zQKIsN1m0R20hYt/B6gOSLiKTaL42JksF
	 B4yraBJBUzfm2+hCYhsqEJm9MVrbSkJcb+xTd2rRt/MzqQ5xkzf3+pS1gQEnNGOKhE
	 IbX9fr9ojWIgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
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
Subject: [PATCH 6.1.y 1/3] ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()
Date: Mon, 13 Apr 2026 11:43:43 -0400
Message-ID: <20260413154345.3124558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041352-oppressor-guidable-7094@gregkh>
References: <2026041352-oppressor-guidable-7094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[yandex.ru,syzkaller.appspotmail.com,linux.alibaba.com,gmail.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-236148-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c16daba279a1161acfb0];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA8263EE1E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 fs/ocfs2/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index a1f3b25ce612b..7115d2091cb92 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1419,6 +1419,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
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
-- 
2.53.0


