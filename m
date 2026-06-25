Return-Path: <stable+bounces-268624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9XbHFk9XPWpl1ggAu9opvQ
	(envelope-from <stable+bounces-268624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:29:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2F6C77A9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YmGdH2Ct;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268624-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268624-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E7933053D05
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C70234973;
	Thu, 25 Jun 2026 16:25:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD072459CF
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:25:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404717; cv=none; b=EsxsGGtLPYTyjdyCJE8GQqCFBk0MWw7Kgmcc1c3gEeyjdzMyzO0FYQeTgpETBWatOxLNi7dZHx1QI8+PkGDnjb2D9Go/iwoJ6NRbc3/1w85ydO0VwnzE1ksC9w7Rt+yYggeV5OjvU0OWb7hIHxby1OHSiAt/rn8fjE2hcnM5P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404717; c=relaxed/simple;
	bh=SU954l45fwkWhTsxD5uDX44V/RmqaYS2Opy4fPxDwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCWD42arOaOv1U1SGJhMczIkpA/vw5+VeL4EwDSHUJETdSkvHqNdssx/ELJPU4eAw2bxzqZ8upvfTBp8CR4xiY6eLAjitlLkHstuEkpeaYLeA2xuu0Nfp+l7olSNMWoSUUL77w65CgxCjHczp4xXLON5pnEoKf4Lq0tNryhXhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmGdH2Ct; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0331F000E9;
	Thu, 25 Jun 2026 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404716;
	bh=1t9JWqqLncDjB6W4k45Q5tuUud3abVHaHYLcKLsVzcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmGdH2CtJ+ZA4YczDRoY+WAg3GTMG4/+6WU8OycGrHQjKvX3SwIrDDAhHLxUjSJm1
	 CuCglwsDUmVgjEXkkS0XT7IwmlpIBykBBnDSShipKQ3j/dRg3e0KJTwgiAmdwqg6dt
	 xFsLK+SdeW3Ogzt7u74bTr8g1agENIbzg+x8V4y1jfyE4UgqHo3kfxa+1lLUJOrNMZ
	 ZhpAQenfaYXVp08huxtKuS/rrcW3K/dWqcL6vLQRxG8lnhhkORcocV8thuCEaxs/t9
	 NvvOHS5LtV66dVQtazh0/V7qvzHuUj+WXUGB4Zi+qD62EFIiwe/Fxdq/LI+yI7zF06
	 mfpJf+8Qc2aOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gil Portnoy <dddhkts1@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: reject non-VALID session in compound request branch
Date: Thu, 25 Jun 2026 12:25:13 -0400
Message-ID: <20260625162513.2501233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062533-hypnosis-duffel-ae71@gregkh>
References: <2026062533-hypnosis-duffel-ae71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268624-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:dddhkts1@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2A2F6C77A9

From: Gil Portnoy <dddhkts1@gmail.com>

[ Upstream commit 609ca17d869d04ba249e32cdcbf13c0b1c66f43c ]

smb2_check_user_session() takes a shortcut for any operation that is not
the first in a COMPOUND request: it reuses work->sess (the session bound by
the first operation) and validates only the SessionId, then returns
"valid". It never re-checks work->sess->state == SMB2_SESSION_VALID, and a
SessionId of 0xFFFFFFFFFFFFFFFF (ULLONG_MAX, the MS-SMB2 related-operation
value) skips even the id comparison. The standalone path
(ksmbd_session_lookup_all() plus the SESSION_SETUP state machine) does
enforce the VALID state; the compound branch bypasses all of it.

A SESSION_SETUP carrying only an NTLM Type-1 (NtLmNegotiate) blob publishes
a fresh SMB2_SESSION_IN_PROGRESS session whose sess->user is still NULL
(->user is assigned later, by ntlm_authenticate()). Used as operation 1 of
a COMPOUND with operation 2 = TREE_CONNECT (related, SessionId=ULLONG_MAX,
\\host\IPC$), the tree-connect then runs on that IN_PROGRESS session and
reaches ksmbd_ipc_tree_connect_request(), which dereferences
user_name(sess->user) with sess->user == NULL (transport_ipc.c:687/701/704)
-> remote NULL-pointer dereference and a kernel Oops that wedges the ksmbd
worker for all clients.

Reject any non-first compound operation that lands on a session which is
not SMB2_SESSION_VALID, mirroring the validity the standalone lookup path
enforces. SESSION_SETUP itself legitimately runs on an IN_PROGRESS session,
but it is never carried as a non-first compound operation, so multi-leg
authentication is unaffected by this check.

Fixes: 5005bcb42191 ("ksmbd: validate session id and tree id in the compound request")
Cc: stable@vger.kernel.org
Signed-off-by: Gil Portnoy <dddhkts1@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d029227f2ba616..496e1b50700d03 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -606,6 +606,11 @@ int smb2_check_user_session(struct ksmbd_work *work)
 					sess_id, work->sess->id);
 			return -EINVAL;
 		}
+		if (work->sess->state != SMB2_SESSION_VALID) {
+			pr_err("compound request on a non-valid session (state %d)\n",
+					work->sess->state);
+			return -EINVAL;
+		}
 		return 1;
 	}
 
-- 
2.53.0


