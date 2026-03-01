Return-Path: <stable+bounces-221510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK1PMHaWo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 724581CAC77
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DD73301688A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381672848BA;
	Sun,  1 Mar 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jugKI9S6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6D284662;
	Sun,  1 Mar 2026 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328448; cv=none; b=YxWUKSx9/SJ3I2dVdvhg370qyV0btykUal6tUhkf05CPO6LMKEpQx15qmPFv3vvSG4hnSPs6OsMHGmU+njPbXCsiTFbyWr53Ui9fwo+UehU2/G9wLTL1JLVj8mRXdq0GEWdodYMJBFC481VwfMaCCy1CGj2+mriukjgYxWNkIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328448; c=relaxed/simple;
	bh=G3aPOi1L33nKULcSb6WdgCAHqNgUJhOGgvkeaQevj6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7ZoWmvNpdSLjIF6gitGsD88FcnLX1gEloCOkMYdrhfNN9AN8kdNmenIj44xVNpY2lrVYIVW82HgpTzzBp8iwXSC789/u/ACcUu38AbvERc+yhuuKvreG8PVGDINLNNgpTxRkcJ2zRKHGlKe+ZW4MBDeteCU88mKf9/FnSaJy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jugKI9S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F48C19421;
	Sun,  1 Mar 2026 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328447;
	bh=G3aPOi1L33nKULcSb6WdgCAHqNgUJhOGgvkeaQevj6I=;
	h=From:To:Cc:Subject:Date:From;
	b=jugKI9S6PkOlAzXtZS33GWlPAXpWy+Afh6Z6JZWXjfDbzQlKeATVR/dWhTMIYytnw
	 nkYwwESFONS3zy6t9/bMTr2PFDBPN6S1w6soit2Aw39KCtzaWqLTmiK4n2R+pp2ByZ
	 VoAO07v0QPYzvmx5X6C95qC8dVnsmzN7a/0LHsHpfFH7zi9t5/ULJznvhFuvzvZ3kA
	 Ykq1EUNiDyKkTBc92x88/iAg7qpWKOXmrG+79fAjD+zpHws+wNKDEkO11ShGf4Cy4M
	 hx+XsdotfltUn9uJU+b2ByctvoKdxEtltvmEbY16z9bTnfdqN0L5xQoBZNVWJo38Ti
	 ck69Ayo9+t68A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	git@danielhodges.dev
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:25 -0500
Message-ID: <20260301012726.1684924-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221510-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 724581CAC77
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dd2fdc3504592d85e549c523b054898a036a6afe Mon Sep 17 00:00:00 2001
From: Daniel Hodges <git@danielhodges.dev>
Date: Fri, 6 Feb 2026 15:41:46 -0500
Subject: [PATCH] SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path

Commit 5940d1cf9f42 ("SUNRPC: Rebalance a kref in auth_gss.c") added
a kref_get(&gss_auth->kref) call to balance the gss_put_auth() done
in gss_release_msg(), but forgot to add a corresponding kref_put()
on the error path when kstrdup_const() fails.

If service_name is non-NULL and kstrdup_const() fails, the function
jumps to err_put_pipe_version which calls put_pipe_version() and
kfree(gss_msg), but never releases the gss_auth reference. This leads
to a kref leak where the gss_auth structure is never freed.

Add a forward declaration for gss_free_callback() and call kref_put()
in the err_put_pipe_version error path to properly release the
reference taken earlier.

Fixes: 5940d1cf9f42 ("SUNRPC: Rebalance a kref in auth_gss.c")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5c095cb8cb201..bb3c3db2713b1 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -39,6 +39,8 @@ static const struct rpc_authops authgss_ops;
 static const struct rpc_credops gss_credops;
 static const struct rpc_credops gss_nullops;
 
+static void gss_free_callback(struct kref *kref);
+
 #define GSS_RETRY_EXPIRED 5
 static unsigned int gss_expired_cred_retry_delay = GSS_RETRY_EXPIRED;
 
@@ -551,6 +553,7 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 	}
 	return gss_msg;
 err_put_pipe_version:
+	kref_put(&gss_auth->kref, gss_free_callback);
 	put_pipe_version(gss_auth->net);
 err_free_msg:
 	kfree(gss_msg);
-- 
2.51.0





