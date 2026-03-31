Return-Path: <stable+bounces-232528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH/vMKgBzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758436E6A2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F5BD3070C68
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11931AF24;
	Tue, 31 Mar 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yS0vNDFq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831B31A556;
	Tue, 31 Mar 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976978; cv=none; b=r5Qm7Hsi95sClAoeHuLESZPSGV1L0YplQzasR0e6xQacEXYC3iygScweoXKUS+FrUjJ9YmKNhGwN5JFypEfB+8mBKOLekCB/hwtKqnMo+2EOU1EZ4YTdisH2sYy63VjoTKiViIR1U1aHNlp/debdVvC0MttJXYm3F45FS9ZVnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976978; c=relaxed/simple;
	bh=UrZk9jDrFXEziCmOyEOirfmAej0mfQW1b6R6nPRJB/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlubwvwh2u1e8AzYgX+8YhdTM30ZI+tbLjxoBI38X+yxCI5gEsmK7HHqd+OZT827vsT7cjdxNtjLtpKaAADePGKPi3yH090LBE4s/LTUTUPq5zWUwZY7a1szDdC2MKvSG3mxQJOY6Y8/+UKxKChkcM6CkRqJ5JVuOPKKE6EH6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yS0vNDFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21F8C2BCB1;
	Tue, 31 Mar 2026 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976978;
	bh=UrZk9jDrFXEziCmOyEOirfmAej0mfQW1b6R6nPRJB/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yS0vNDFqb9/50NKDMmhvYdI5vlWOmXXI1rAD2C4ZDdNzaskgezaL4oLbzdyu5eOaz
	 6jPnP/144Tec0IEiZjWsLUCwvp1BIZK0NFrMYu0MbAuNSSf6vHkVqZ236UJmrFLUyu
	 dE3thGzVdIQ9tgdkf6s0qPU76sIsaZp26nGMTZbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 300/309] netfs: Fix read abandonment during retry
Date: Tue, 31 Mar 2026 18:23:23 +0200
Message-ID: <20260331161804.609393074@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232528-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8758436E6A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7e57523490cd2efb52b1ea97f2e0a74c0fb634cd ]

Under certain circumstances, all the remaining subrequests from a read
request will get abandoned during retry.  The abandonment process expects
the 'subreq' variable to be set to the place to start abandonment from, but
it doesn't always have a useful value (it will be uninitialised on the
first pass through the loop and it may point to a deleted subrequest on
later passes).

Fix the first jump to "abandon:" to set subreq to the start of the first
subrequest expected to need retry (which, in this abandonment case, turned
out unexpectedly to no longer have NEED_RETRY set).

Also clear the subreq pointer after discarding superfluous retryable
subrequests to cause an oops if we do try to access it.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/3775287.1773848338@warthog.procyon.org.uk
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_retry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 7793ba5e3e8fc..cca9ac43c0773 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -93,8 +93,10 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		       from->start, from->transferred, from->len);
 
 		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags)) {
+			subreq = from;
 			goto abandon;
+		}
 
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
@@ -178,6 +180,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				if (subreq == to)
 					break;
 			}
+			subreq = NULL;
 			continue;
 		}
 
-- 
2.53.0




