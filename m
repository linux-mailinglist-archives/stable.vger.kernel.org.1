Return-Path: <stable+bounces-231967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEn6HZL8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429836D6E5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A6BA30603E3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6632E6B4;
	Tue, 31 Mar 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oxglHowv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414F25D527;
	Tue, 31 Mar 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975529; cv=none; b=J8ezd1WdtLu7Fw3Cs0RU4WLT+rXjkxwyJsrnem9szF3uCS7W1BnU4VGvPYTPOSgKmrkbb0Br/LpofDUxRfHJIWvoOa4L0XfYgXfD/Bd2Z7et+1O6BtWuUllhRhR9Hbsds+7ED5hemi+WDxHrnUzuNas3ZAxiOwU2d1Ev0ma0vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975529; c=relaxed/simple;
	bh=XNnUaPeBzKe3zSDBf8fN/VYNO8M0aW51n9t4bec64TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOXpc2xBDeHHb7Sm+vQ/OJKP2VmC6QYoM9xBYRso3+zf3NNqYN0nMRmmi6HxPcxRPzj8swPyw4KlaGrr2aZD9TloWi/W7YGy7N52vDXHRics31R/bOEfJTjBJ5i49QxEeyxqXHvGcMnEe1JhhgU+g1ubV9XVy8QGK+Z7BAEPUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oxglHowv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20655C19423;
	Tue, 31 Mar 2026 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975529;
	bh=XNnUaPeBzKe3zSDBf8fN/VYNO8M0aW51n9t4bec64TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxglHowv/hR3iHuf7bTEdGPlN7TIz+iWyKR9bfhHMXBU+ytPjrfL/maCeGhSbiSCb
	 kvhkV+JWfP2LkGCqNmZqTFrR0Pz9fNX0bIS06od/DNmu/iz+educC+EUWIlzzJ6chP
	 hPhClioo8I43HDaLQs2ETIUWutZ+0HMY0zGGwyaI=
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
Subject: [PATCH 6.19 330/342] netfs: Fix read abandonment during retry
Date: Tue, 31 Mar 2026 18:22:43 +0200
Message-ID: <20260331161811.049703731@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231967-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,manguebit.org:email,linux.dev:email]
X-Rspamd-Queue-Id: 3429836D6E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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




