Return-Path: <stable+bounces-255807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD4nBUKmGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:32:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1885F8E54
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9175313A4FD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C23101B0;
	Thu, 28 May 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGemehbt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DF254B1F;
	Thu, 28 May 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999935; cv=none; b=pOXvyUgz1PlFIP7QOxyzhJQ4P4LBzioQuhW6nRjxqi14i9IJXOnT6JA196y/0jgqvCiagG9G9LnsHFV6gWtnFiB8+xDtVR3DM40XRuFEQPwWZmsfVRvw7EvxGkefRs4IbFau+Iq49Ul8RzWx7LXoe6EDf6bRIkmH/m3kDVjqLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999935; c=relaxed/simple;
	bh=eS9Z5shYSOl++QwW3YllQfTdmMkqn9TulyEGu4SeEsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMdjhfN2PKuFH8OlqdtUXLRX9eowjSRDbidS/JqF1uDKdieH6bvMD3xqnznOI4eiSFxLTqEnrd64utDXdiF2Cy4wGBfKqPA2IMxdYOatcxn/xmBA/3nyOQRp6YhhjSiWUr7nJa1ekrhhpKF8DEEQR+FefrtWPw3IUqdxLQpgJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGemehbt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922431F000E9;
	Thu, 28 May 2026 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999934;
	bh=q4CMrm5u9Q8R/OCBnKRtBvDtnZIftc1WDvL6nzzM3bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGemehbtGdF6TwPYph8mN1cLjMryuhZN3kHWG7DQenbxV/mG6FvmuU9rvgmDrmwI3
	 /wfWO6qHYgn84PKK5BUWO7ftTWEgShMmBjDvBsrJ0FsxTUSua3sH/Pq62gY2nv0YFl
	 zejAG+ejWaIC8dvp+YivSXc3tkkFhNThK6iUqYuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 244/377] netfs: Fix leak of request in netfs_write_begin() error handling
Date: Thu, 28 May 2026 21:48:02 +0200
Message-ID: <20260528194645.447216446@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255807-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,manguebit.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BF1885F8E54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 5046a34f0643441f05b0253ea64e1a3af87efe14 ]

Fix netfs_write_begin() to not leak our ref on the request in the event
that we get an error from netfs_wait_for_read().

Fixes: 4090b31422a6 ("netfs: Add a function to consolidate beginning a read")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-19-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 762ff928bc878..085cd392bf5ac 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -686,9 +686,9 @@ int netfs_write_begin(struct netfs_inode *ctx,
 
 	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
+	netfs_put_request(rreq, netfs_rreq_trace_put_return);
 	if (ret < 0)
 		goto error;
-	netfs_put_request(rreq, netfs_rreq_trace_put_return);
 
 have_folio:
 	ret = folio_wait_private_2_killable(folio);
-- 
2.53.0




