Return-Path: <stable+bounces-220543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA8kEbM8o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:06:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C71C69BE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 037A53078FA6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC863D2443;
	Sat, 28 Feb 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/8lLlLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402313D16D2;
	Sat, 28 Feb 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300426; cv=none; b=sqwMA5x8wBrM9ZBez8lZCmWoNAnODNnRt7l90FRzZpvexFwG+P2HUGRQS/LlE/i5O6K956iT8x/0n60beFS9GGbp63RXJZxRdd3Pn6mtjoNc0fH/U3nQ9LLZ7EU3qQt8GXjP9cOjs78bgYjhsBfA9eP19SbbF8rxKOQAiVIkO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300426; c=relaxed/simple;
	bh=YRK9ONJlnM2sOe/cu5jE1EbEEdK76nUezm1zHZimbN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3x6lF6Ofn7LJr/knk701Cd6nQpmLQD4AnPGp6Z1LQxUXTu2d612z5gNWSMLO+fWwDRVBvEvQHGLqwct/QegEj6md0VBsV9mg4SBDuGRKQMNArPS6NPUkRjF6Fpn/acz55YRNv3jKrXnqyu7PyQilgXIJ7uHzQP4U01AOAVryI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/8lLlLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F665C19423;
	Sat, 28 Feb 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300426;
	bh=YRK9ONJlnM2sOe/cu5jE1EbEEdK76nUezm1zHZimbN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/8lLlLY4ioxQ9SNLEIJrJDdHoub6bdfJX0Q55nFWNAT/AqdEzYdxRKNhF8vlrXQu
	 wr3QSldv6XonA54+5H+3VdSZQRdUMMjO6yZ4h10VR48sXpwQJxAqloeleQgVL4DNry
	 cEltmxKxIpZ6+ht7WfqX1rNJrCz2pF0/hOny9oWZh4WZKjF7PT9JBqmJe9KJmr5nLy
	 1PfL0HANXflhgzSqnRFoJCjkHOR/Y2RyK0GE6KQGNZn2vTbT1FIL7P6580pjxmRh/s
	 tqtQbYK8SL+aDhbIvAMyglBrftFdTWeaUxPcimy+mawI6LVqi8itnwKL7+egBoV+eH
	 YHQQp2yylJmuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Carlini <nicholas@carlini.com>,
	Stefan Metzmacher <metze@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 464/844] ksmbd: fix signededness bug in smb_direct_prepare_negotiation()
Date: Sat, 28 Feb 2026 12:26:17 -0500
Message-ID: <20260228173244.1509663-465-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220543-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA4C71C69BE
X-Rspamd-Action: no action

From: Nicholas Carlini <nicholas@carlini.com>

[ Upstream commit 6b4f875aac344cdd52a1f34cc70ed2f874a65757 ]

smb_direct_prepare_negotiation() casts an unsigned __u32 value
from sp->max_recv_size and req->preferred_send_size to a signed
int before computing min_t(int, ...). A maliciously provided
preferred_send_size of 0x80000000 will return as smaller than
max_recv_size, and then be used to set the maximum allowed
alowed receive size for the next message.

By sending a second message with a large value (>1420 bytes)
the attacker can then achieve a heap buffer overflow.

This fix replaces min_t(int, ...) with min_t(u32)

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index c94068b78a1d2..dcc7a6c20d6f8 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2527,9 +2527,9 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 		goto put;
 
 	req = (struct smbdirect_negotiate_req *)recvmsg->packet;
-	sp->max_recv_size = min_t(int, sp->max_recv_size,
+	sp->max_recv_size = min_t(u32, sp->max_recv_size,
 				  le32_to_cpu(req->preferred_send_size));
-	sp->max_send_size = min_t(int, sp->max_send_size,
+	sp->max_send_size = min_t(u32, sp->max_send_size,
 				  le32_to_cpu(req->max_receive_size));
 	sp->max_fragmented_send_size =
 		le32_to_cpu(req->max_fragmented_size);
-- 
2.51.0


