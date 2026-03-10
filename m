Return-Path: <stable+bounces-223742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPeUK7KLr2nJaQIAu9opvQ
	(envelope-from <stable+bounces-223742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:10:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1182449EF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 671E13020E85
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A733B8956;
	Tue, 10 Mar 2026 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="EjJHYaP8"
X-Original-To: stable@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB933A4F35
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112230; cv=none; b=ry7GD7H6P0HRriqkFzTm5oIMCE+XsREcAsGvZXnt/SQnjf6bPPp/6mTek2J7+WQCh+YBLeslMRM+vNPhzJJeq/cFGbs4Ycc18YvTOWwC5gYvThETF7C78v/Eblevf6zVxAKJCxQl+xyatmnh0Lfa5GfcTZQ9QmORsJJoYIyyGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112230; c=relaxed/simple;
	bh=cfwLVXFdj37og/RHm0uXsOCFQ+WS2Pv92LVVeBHIxao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoCTtQMUHpva/KN95+ZHxfycUvTVZEz8mU0pWfe06fGzLqXIz4WsZLTzBGsANqfrHFWrSYE/GAEZ9DTvnpF6tp0Ep3WzisCoIp1hvACwmDn5Lwj0YvZMBEagrqTq3CfeQiC5zjqvh+2EQUam/xdJdH9burziG1dy0fZtLmd+JRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=EjJHYaP8; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773112226;
	bh=n9nXfBjiGOyRuUo5cxPsgCNLzkaiz4s7BuO6ctzS8X4=;
	h=From:Subject:Date:Message-Id;
	b=EjJHYaP8wZv7VgGL7VtdtY8QO+oPEeLVcwAwPlsbvCbwX3ab0/433wGqt5oMDnCF6
	 50FKBfsZjugW+hHm04ZucYa47Jb7chkK4q4n28DUhXcjTr03Wfd2OrS3+iFH9QRlu0
	 5zLFYd9bZmquyGKstpy8v9gPqe2PFKoHEQD1l0o4=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.22) with ESMTP
	id 69AF8B9C00004255; Tue, 10 Mar 2026 11:10:22 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 8930297602215
X-SMAIL-UIID: 0F7EAD5C376F4073AFB8022533207912-20260310-111022-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] dlm: fix possible lkb_resource null dereference
Date: Tue, 10 Mar 2026 11:10:19 +0800
Message-Id: <20260310031019.3572626-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E1182449EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223742-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,sina.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit b98333c67daf887c724cd692e88e2db9418c0861 ]

This patch fixes a possible null pointer dereference when this function is
called from request_lock() as lkb->lkb_resource is not assigned yet,
only after validate_lock_args() by calling attach_lkb(). Another issue
is that a resource name could be a non printable bytearray and we cannot
assume to be ASCII coded.

The log functionality is probably never being hit when DLM is used in
normal way and no debug logging is enabled. The null pointer dereference
can only occur on a new created lkb that does not have the resource
assigned yet, it probably never hits the null pointer dereference but we
should be sure that other changes might not change this behaviour and we
actually can hit the mentioned null pointer dereference.

In this patch we just drop the printout of the resource name, the lkb id
is enough to make a possible connection to a resource name if this
exists.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
[ The context change is due to the commit 9ac8ba46a701
("fs: dlm: handle -EINVAL as log_error()") in v6.1
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 fs/dlm/lock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index b9829b873bf2..ffe12593a8b7 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2923,10 +2923,9 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	rv = 0;
  out:
 	if (rv)
-		log_debug(ls, "validate_lock_args %d %x %x %x %d %d %s",
+		log_debug(ls, "validate_lock_args %d %x %x %x %d %d",
 			  rv, lkb->lkb_id, lkb->lkb_flags, args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 	return rv;
 }
 
-- 
2.34.1


