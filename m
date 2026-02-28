Return-Path: <stable+bounces-220783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDNFLv1Do2li+wQAu9opvQ
	(envelope-from <stable+bounces-220783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:37:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6E1C7315
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33572312D5AB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56865363084;
	Sat, 28 Feb 2026 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAJOqkwU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911649253A;
	Sat, 28 Feb 2026 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300667; cv=none; b=h8ZhSMQ84mN2oZaqAhso7IWamRghDYOQYurWoR9+9gcZD2cMgKTdKKCQYaF6kB45dNP9ok34zUi8KXM0pW3aWb6/geJs1cwLSjAZRjKgUgjlzjkD3/csqfotSF4GzcA7Kr95AXttFIzBAEqfwtrU1ShC2/mYtr89wIc05bi8dpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300667; c=relaxed/simple;
	bh=w5jgtz5DSWUWiVF2tlEtWyl1qNtrBDZobr0H7JY9hkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ixxy/Jt4BuTYA+QiHMm6wOISr568pSsNLklEwdwxQeXbH94r6/DIcRb98Pt5C7Np67AzthrkhLh8B6ut/ofr+lyVs03VAP3jDtLcca1ckDQ7CMycp/osZrSHFPg/BO+Ybl6zM9DBBa5QgLXNPr78713R0PopPfGen1eAvq93khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAJOqkwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDFBC116D0;
	Sat, 28 Feb 2026 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300667;
	bh=w5jgtz5DSWUWiVF2tlEtWyl1qNtrBDZobr0H7JY9hkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAJOqkwU6xkg0qgytiA6LOk1xIHt9sG5SfKbLQvNv27LKDHJTe0SV4WSix3Vpo4wU
	 n8/61hxheYRO2uwn1bsnfeeNDC0qa098drqkw8CJ+qmRIESnyF75l2qzaogJUi+UdV
	 01SCOcbFB2XLGjTz8w6twdAZdb6aVJ/+JjAwGyUI3OZFuiX9sX8OkzXVH618U1w01l
	 6yIWvj4YZb48DjVbwqxEa3ukDhwOwN1lZNU6rG2NIiuzBBF4S8v0bTevsx2/KBf6/C
	 Tuld0/F+sIwUe9HXKpqcSSO5k9jNthXUAXBpCoC1kVVDP5GIuSxLw4HeFahH29tEqs
	 YhLn7tqQDYq/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 704/844] io_uring/net: don't continue send bundle if poll was required for retry
Date: Sat, 28 Feb 2026 12:30:17 -0500
Message-ID: <20260228173244.1509663-705-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220783-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 69D6E1C7315
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 806ae939c41e5da1d94a1e2b31f5702e96b6c3e3 ]

If a send bundle has picked a bunch of buffers, then it needs to send
all of those to be complete. This may require poll arming, if the send
buffer ends up being full. Once a send bundle has been poll armed, no
further bundles should be attempted.

This allows a current bundle to complete even though it needs to go
through polling to do so, but it will not allow another bundle to be
started once that has happened. Ideally we would abort a bundle if it
was only partially sent, but as some parts of it already went out on the
wire, this obviously isn't feasible. Not continuing more bundle attempts
post encountering a full socket buffer is the second best thing.

Cc: stable@vger.kernel.org
Fixes: a05d1f625c7a ("io_uring/net: support bundles for send")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 519ea055b7619..d9a4b83804a25 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -515,7 +515,11 @@ static inline bool io_send_finish(struct io_kiocb *req,
 
 	cflags = io_put_kbufs(req, sel->val, sel->buf_list, io_bundle_nbufs(kmsg, sel->val));
 
-	if (bundle_finished || req->flags & REQ_F_BL_EMPTY)
+	/*
+	 * Don't start new bundles if the buffer list is empty, or if the
+	 * current operation needed to go through polling to complete.
+	 */
+	if (bundle_finished || req->flags & (REQ_F_BL_EMPTY | REQ_F_POLLED))
 		goto finish;
 
 	/*
-- 
2.51.0


