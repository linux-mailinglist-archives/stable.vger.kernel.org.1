Return-Path: <stable+bounces-231960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O6KBD78y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:54:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAD136D5D0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6986330D948B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03E423A8A;
	Tue, 31 Mar 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0dPB279h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D33EE1DD;
	Tue, 31 Mar 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975511; cv=none; b=FCNOVNDCHvgWbjvmMhyzA3/eVESYFz8Aud4au93PJeZrPLEbkGX9OvZtOe52yTz1WXOscyA9w3kNglMLVUlgpCjxXqGbKqQ9Lw0KGyhOeHTuU1DRo97pTKpuYgkvDNCsBZ3vnRId8Xoe+okZpA8uIGM92cXhmpUanDfLd642e7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975511; c=relaxed/simple;
	bh=NJ/UgWBcK3B9zx0QZMccaCCuaOdd0NQ58/b7/B5VAKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGywDNZfoYAD95olCcL0//0trqkIb8DPLw2YbO1+n3IVMtypfGRawfCUu9cwp567ghGdxhWbK6412nRmk6Otshy3pM4sgpfwhDi6st0VbEAIvkLNd9xOsiWTmnXv0ThFQ60es/NO3OVOJc9+2E9EZT6VdA6+tN+Mu0O80IxpN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0dPB279h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0552BC2BCB1;
	Tue, 31 Mar 2026 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975511;
	bh=NJ/UgWBcK3B9zx0QZMccaCCuaOdd0NQ58/b7/B5VAKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0dPB279hDk0n30nX/RS1IqBrCjHgQCXW06zG7JHVyMI+0IYwOLhXd7k1T+QAJHBEm
	 pXoXY5WgfN/iZQcw2BomE49vroPiXconqs/z9htbqGcGlSDQwbqKJwSu94R5Xvp8It
	 H6AVfGYEeoG+eMKCvtLIzkPhhVY6kRIMCPeASb1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 323/342] netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retry
Date: Tue, 31 Mar 2026 18:22:36 +0200
Message-ID: <20260331161810.799414796@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-231960-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,7227db0fbac9f348dba0];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: BAAD136D5D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit e9075e420a1eb3b52c60f3b95893a55e77419ce8 ]

When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
in netfs_unbuffered_write() unconditionally calls stream->prepare_write()
without checking if it is NULL.

Filesystems such as 9P do not set the prepare_write operation, so
stream->prepare_write remains NULL. When get_user_pages() fails with
-EFAULT and the subrequest is flagged for retry, this results in a NULL
pointer dereference at fs/netfs/direct_write.c:189.

Fix this by mirroring the pattern already used in write_retry.c: if
stream->prepare_write is NULL, skip renegotiation and directly reissue
the subrequest via netfs_reissue_write(), which handles iterator reset,
IN_PROGRESS flag, stats update and reissue internally.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
Link: https://patch.msgid.link/20260307043947.347092-1-kartikey406@gmail.com
Tested-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/direct_write.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index dd1451bf7543d..4d9760e36c119 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -186,10 +186,18 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		stream->sreq_max_segs	= INT_MAX;
 
 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-		stream->prepare_write(subreq);
 
-		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-		netfs_stat(&netfs_n_wh_retry_write_subreq);
+		if (stream->prepare_write) {
+			stream->prepare_write(subreq);
+			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+			netfs_stat(&netfs_n_wh_retry_write_subreq);
+		} else {
+			struct iov_iter source;
+
+			netfs_reset_iter(subreq);
+			source = subreq->io_iter;
+			netfs_reissue_write(stream, subreq, &source);
+		}
 	}
 
 	netfs_unbuffered_write_done(wreq);
-- 
2.53.0




