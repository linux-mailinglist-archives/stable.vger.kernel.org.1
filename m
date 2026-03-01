Return-Path: <stable+bounces-221494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCg8Faalo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:34:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E25781CDAE8
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B5430E785C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1C2848AD;
	Sun,  1 Mar 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVT0apkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3D2727EB;
	Sun,  1 Mar 2026 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328405; cv=none; b=jtiiOzyd/kaubp9Mzc84P7CWgQvHprwVoDotWfVqUtfeKJnePEuT/A5aP0wLUesWMDRxGkmA0QsBQcIc9PPT/7NYe4n1axknOeBnMsXUxvF/w7JChLOYIcUWBpGwK8ODpFeptgnlRl1HLsbx0EPlxGItKD1BjZES+RLnE4Y6w+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328405; c=relaxed/simple;
	bh=3fVMHjFYmq3eUCJtUX1P07OM7HpVPhocNNPPUg0EatY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RE2NQSyYL/RS7BoF+7kErrbw7w9H2e6ayYOMyFMhj+lYVYlZN9upaee2QsezArMM7DApO7+DfcKRX7Ze371Terim5sKzES4bpewEXthmIvn+gCtn0lHcPsQZ+HJp2QZr6sfdGWOD9MhiHHijpzh6qb57+jzyfpAXSg8xKwOCh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVT0apkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F10C19421;
	Sun,  1 Mar 2026 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328404;
	bh=3fVMHjFYmq3eUCJtUX1P07OM7HpVPhocNNPPUg0EatY=;
	h=From:To:Cc:Subject:Date:From;
	b=BVT0apkJSKc+VB/4gIuX5J+8u8akKjIkPwVkGYWGAH6l7UrulZ3ykiFc7o2/LJZXX
	 4EQDltl9OeYTA5vIt4o3fZ1LZw2vm7nb7N9jDEYTLPEdRXej2Lz/2vMjzaUfDHxOW4
	 2Pews54PoXzhn64vQE6T3CWJrwvtpi86SKyOiY5rDqFP0mudcnjq8L23BzAoP5IDv+
	 6uXqltz2aFdMsDhA/bzC4F1VbzDFW9Z40HJXOx8ZEzoFU2IV4q9jq3kmhPsVYSN5Ca
	 8JnvfLatsyFreR7cXbr20s8LJy73Ykk+PVzoxx3qgWUth67Sppz0H5KXct5IACsozy
	 NKH9qqkd/fbug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	metze@samba.org
Cc: Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>
Subject: FAILED: Patch "smb: client: remove pointless sc->recv_io.credits.count rollback" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:42 -0500
Message-ID: <20260301012642.1684141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-221494-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.268];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talpey.com:email]
X-Rspamd-Queue-Id: E25781CDAE8
X-Rspamd-Action: add header
X-Spam: Yes

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6858531e5e8d68828eec349989cefce3f45a487f Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 22 Jan 2026 18:16:51 +0100
Subject: [PATCH] smb: client: remove pointless sc->recv_io.credits.count
 rollback

We either reach this code path before we call
new_credits = manage_credits_prior_sending(sc),
which means new_credits is still 0
or the connection is already broken as
smbd_post_send() already called
smbd_disconnect_rdma_connection().

This will also simplify further changes.

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/smbdirect.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index f2ae35a9f047f..c9fcd35e0c77a 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1288,9 +1288,6 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 					    DMA_TO_DEVICE);
 	mempool_free(request, sc->send_io.mem.pool);
 
-	/* roll back the granted receive credits */
-	atomic_sub(new_credits, &sc->recv_io.credits.count);
-
 err_alloc:
 	atomic_inc(&sc->send_io.credits.count);
 	wake_up(&sc->send_io.credits.wait_queue);
-- 
2.51.0





