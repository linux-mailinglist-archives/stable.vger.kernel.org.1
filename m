Return-Path: <stable+bounces-238602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LKUKdu/42nJKQEAu9opvQ
	(envelope-from <stable+bounces-238602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:31:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DC421D24
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E73133046240
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6CA31ED68;
	Sat, 18 Apr 2026 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QurXQ/H5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2063112BD
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533441; cv=none; b=Y8LCaWRK4xB4+RPsq+1YM+dOyLFMJxMIYTi+DpQRdKes/CzWS0qMyFpUoi0dFBhg9Qx7HJSNJkddWREoRguJMmAyPZ/Dm7IiwZZdTkHPEZZWeEV0skq2wDyHsNoMicaCXTMfS8c2sQAU0lSAyGKPZ0gNMCAUmHet0cbnVt2y1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533441; c=relaxed/simple;
	bh=ezf//pPazx1mLelB2gmRNccf8HxZrkHgU//I5FWrCyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uldn3xxYsZ7ukEu4jl5UAa/7RTy4Y6z3LuGSbojzjmJnNTyPNu7KnIJMAIfVrqsSpZYc4GhiXwPji4PLoiGbgZ665mqFBTxHlw4XL4kd+76Ocl41ulUn4Pl6qrWbA2MKUivzT/hch//I/E98j9r3DB4+BZ9rRAPzWti36VDmykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QurXQ/H5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so314567a91.3
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776533440; x=1777138240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1YbAZG9CJiEeAf7NGLPiDB355/n4BunXq6TPbpCs08=;
        b=QurXQ/H5ToZI50kQGmZb+B3u4q4k9XFMiYZ+KArrL6tEn5Xjfy4DfzaDDuXnYlAC+i
         1V5oC06DP6uwk9ZBRC3jZjEhKg1k2ZhT+3Q/9uGW7uqAkPAEBMF9QjxvF9Efxies3L0H
         pbqtYt59yj5MgxOcvSWl4iUxHEIo2M+O/CAdnFqhd/7CCEH6957MWtIe6xstZ5OzjxVk
         /Mw9UMLCSxg/g/iHeC8BvZxO4cghs70Xs4c1G8lz4RQjgGsS1rQ8+VnC6FYnXyIsfz48
         mPyZBZLFAO6SEbtAzVtWJdKUfrrX/RtD+FM0quWR0I8qjoNxdBMWwvtQWLJ2D2c8Wq4R
         YqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776533440; x=1777138240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1YbAZG9CJiEeAf7NGLPiDB355/n4BunXq6TPbpCs08=;
        b=SXAGqR6vTvn+NgzzRpA+L1kLM+2EhINPVNPJB6bKGmk4JaNU1cY+CKweRGCEChVCIq
         idVx58uO7FWJvW3i4mR52ACSCbWqyFT9dK5OHrv8I/TR521p1yFSYFESImI3Y/OU4c1G
         If7130cqSf8xI/z8p3LP6fzqntfzt0hC0u5ZWZaf5av6jaJZ4l6E6ta40xhYuuAflKg9
         5q44hTLIYtpoAvllkDdj6BsKwckgRNT2Pcu9KQz28BAH3DCrNNbun/TX6xpn7xilMK8F
         cHitS9XaNklShi251LUMWPmnad9FOUoI6kKoC7aeQauWbvR0wI0Z1eRS9rU8pG7nSYvY
         P9aA==
X-Forwarded-Encrypted: i=1; AFNElJ8BzycSdHmBnTMsJLJByX1RXdU2OqNcEYhm3mmD/1DAgo2m+NHwHHQK+koo54ufW99xr+HAMZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEhVfss/BMHopcWrDz42uWjjuIrm8u+10PNyFnDwhdEqJunR1
	HCJknosM1QKoTu0Mb+ypdv5ryY0HEMjbxkXpbTk3FYXP/KxisBqL1oOJ
X-Gm-Gg: AeBDiet157Mq5L/nqHVY4kpqKsmLQyBICG2BpOCVONUj5fsQAFsJo3yWtlY29hAL/9H
	gqeqrZc85tV9//n3WqfRVkBPVQarZ/JYgXSz4fdBPDsKgKe8NbHtBpyoJMGygd7dXtwo+mcHplp
	AABJdBA6rOEFQjlwtCPtJLfDfEHs7Udj9WmU7pKLEifl0A/Rf6GcpovzUjMWCJlWw8pfbQ4Fm9C
	gXbk7v2ApVX/tFVsQAOBa6G8XwA+/LS7EdR6t5a6mZzeLXJRT/gPtNId49TRv5Rrh6H+vxSn9pT
	QhJeEMvNrl9XUn7rnj4BnUauTz735J4JJcoaZa3m2j38LyOXWkLzofWKF1pDY/eXSBEL70Ko30E
	XbTQ6K70sAGE/sGYuWFCS94NtVGMljG9I2WNGLyQYnAtC9TR6brvXPmFiLkEFgSW0coL5grDnfR
	FU7TMUHUx2GklUbI21qiqiiTbWn/Q=
X-Received: by 2002:a17:902:c40a:b0:2b2:ac6f:f6a with SMTP id d9443c01a7336-2b5f9d679e8mr42742655ad.0.1776533440022;
        Sat, 18 Apr 2026 10:30:40 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm69694965ad.7.2026.04.18.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:30:39 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	smfrench@gmail.com
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 2/2] ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()
Date: Sun, 19 Apr 2026 02:28:44 +0900
Message-ID: <20260418172844.1333378-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418172844.1333378-1-charsyam@gmail.com>
References: <20260418172844.1333378-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,vger.kernel.org,suse.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238602-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 684DC421D24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rcount is intended to be connection-specific: 2 for curr_conn, 1 for
every other connection sharing the same session.  However, it is
initialised only once before the hash iteration and is never reset.
After the loop visits curr_conn, later sibling connections are also
checked against rcount == 2, so a sibling with req_running == 1 is
incorrectly treated as idle.  This makes the outcome depend on the
hash iteration order: whether a given sibling is checked against the
loose (< 2) or the strict (< 1) threshold is decided by whether it
happens to be visited before or after curr_conn.

The function's contract is "wait until every connection sharing this
session is idle" so that destroy_previous_session() can safely tear
the session down.  The latched rcount violates that contract and
reopens the teardown race window the wait logic was meant to close:
destroy_previous_session() may proceed before sibling channels have
actually quiesced, overlapping session teardown with in-flight work
on those connections.

Recompute rcount inside the loop so each connection is compared
against its own threshold regardless of iteration order.

This is a code-inspection fix for an iteration-order-dependent logic
error; a targeted reproducer would require SMB3 multichannel with
in-flight work on a sibling channel landing after curr_conn in hash
order, which is not something that can be triggered reliably.

Fixes: 76e98a158b20 ("ksmbd: fix race condition between destroy_previous_session() and smb2 operations()")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/connection.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index a26899d12df1..b5e077f272cf 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -237,7 +237,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 {
 	struct ksmbd_conn *conn;
 	int rc, retry_count = 0, max_timeout = 120;
-	int rcount = 1, bkt;
+	int rcount, bkt;
 
 retry_idle:
 	if (retry_count >= max_timeout)
@@ -246,8 +246,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
-			if (conn == curr_conn)
-				rcount = 2;
+			rcount = (conn == curr_conn) ? 2 : 1;
 			if (atomic_read(&conn->req_running) >= rcount) {
 				rc = wait_event_timeout(conn->req_running_q,
 					atomic_read(&conn->req_running) < rcount,
-- 
2.43.0


