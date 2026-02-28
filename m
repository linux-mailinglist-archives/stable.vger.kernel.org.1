Return-Path: <stable+bounces-221108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eObOMXpIo2mm/AQAu9opvQ
	(envelope-from <stable+bounces-221108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 301921C797F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3893304261
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E337145F;
	Sat, 28 Feb 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dah1gQN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA937145B;
	Sat, 28 Feb 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301457; cv=none; b=J42u+67QmsExoLFDIynYEX3NE1TWC8nuyqSfjdW1hw3oU7ej+c7+WuBDgLrTntoYj6pFrNtzELaOlcsJarp/dTZfnRaNLrJWw0wRvBhfNqsa5bERNzlXF6eBG5ZcQOdeRRRoXGtSF649CpQeQfjBR8PeLSe4zObg9aXfOxE+Ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301457; c=relaxed/simple;
	bh=p/4gPF3ZN/FRGXXtNkPOfBxIWUVxOFF+fANm7CRbjSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNaistWh4gLfQ9ZxMBbYpAA1uPDR1SUl0yMXkOIoqYl2vbmcTjCleIw9hA1IOb7Nh098CcI14MAaF5h3thLazMv8Esb3VKJrThRgc/OuO6oHCatW2aRVycKole8V6gs8/iBhNJAsRgV4/Zb2NeBovUqsnkKuI4sjk39ezM7CKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dah1gQN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50603C19425;
	Sat, 28 Feb 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301457;
	bh=p/4gPF3ZN/FRGXXtNkPOfBxIWUVxOFF+fANm7CRbjSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dah1gQN0SuRRKXTZVvV3xIWnK/DYCoaQ+zrU/i5z8w37jQDkLq12f5xzSEHMe6fEG
	 utyCArOKTtdJw14Fh2WUealZEI+KUcFQJRFkO3KmmMVTeOQEJXD4RrYqtLcQrWou8/
	 bozBNFy+ljyNZ6+kvuyTt2G3nUWZOkHnp6cOyaZb02iN0NB5BFcUqcMZ/FX8QPUCL1
	 lxwNj7pHEvg5KaK7T6lUyxrUeWeLfABZ1ksHbhgze6OHNtO6zcP1x5KVPyC/i7dPZ7
	 38VqW5INM3RJ6WQMROHZpKOG+gbGNtsCumaC3VClQxdT8kiqtQmbC4JMO4DPWNkaMT
	 CAG15sO3d52+w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 643/752] ocfs2: fix reflink preserve cleanup issue
Date: Sat, 28 Feb 2026 12:45:54 -0500
Message-ID: <20260228174750.1542406-643-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,oracle.com,gmail.com,live.cn,huawei.com,vger.kernel.org,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221108-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,oracle.com:email,linux-foundation.org:email,evilplan.org:email]
X-Rspamd-Queue-Id: 301921C797F
X-Rspamd-Action: no action

From: Heming Zhao <heming.zhao@suse.com>

[ Upstream commit 5138c936c2c82c9be8883921854bc6f7e1177d8c ]

commit c06c303832ec ("ocfs2: fix xattr array entry __counted_by error")
doesn't handle all cases and the cleanup job for preserved xattr entries
still has bug:
- the 'last' pointer should be shifted by one unit after cleanup
  an array entry.
- current code logic doesn't cleanup the first entry when xh_count is 1.

Note, commit c06c303832ec is also a bug fix for 0fe9b66c65f3.

Link: https://lkml.kernel.org/r/20251210015725.8409-2-heming.zhao@suse.com
Fixes: 0fe9b66c65f3 ("ocfs2: Add preserve to reflink.")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index d70a20d29e3e9..64ba3946f8408 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -6364,6 +6364,10 @@ static int ocfs2_reflink_xattr_header(handle_t *handle,
 					(void *)last - (void *)xe);
 				memset(last, 0,
 				       sizeof(struct ocfs2_xattr_entry));
+				last = &new_xh->xh_entries[le16_to_cpu(new_xh->xh_count)] - 1;
+			} else {
+				memset(xe, 0, sizeof(struct ocfs2_xattr_entry));
+				last = NULL;
 			}
 
 			/*
-- 
2.51.0


