Return-Path: <stable+bounces-221095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMnRFKxNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D51C830D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD8D23005EB7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C5736D9E9;
	Sat, 28 Feb 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5YHI4Y8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86C301EEA;
	Sat, 28 Feb 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301444; cv=none; b=dGGz8fazNC1Y6hMaABEzZ8ZCTlstOFkA2Ng0T7WxmIj7o3gmjkAPnESlqprh/9LmQ7yH7Nf6ZrzFGM87Owwaiy/tvc0AqZPJCuMp3kYw1BvOVjdgN/zWKbNuxvLBcZ1TWP9OcyHjsqyvErE1Eb1UJcW4VqdGFEdCx6kSvApJzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301444; c=relaxed/simple;
	bh=kPudyH7nbluIudSpyr7R5koi0ddGjH9W/uedgxMMGr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON1Ml+3s/BIZ4Gvjd9DKCAn1ZK2BFHLmjVaE55LhbuPmJWgMhLc8EuMMHssuA5T7m74/EYUGzXzaWoxUXip2Yucnjg2xmTENK20yAVjZSiPZ64P0EDxqpXruu3EfB8xeGzbhX0MX3qWJXbe+Sw2xq1QD8TbdoK9lHutzOhQXcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5YHI4Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F8CC19423;
	Sat, 28 Feb 2026 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301443;
	bh=kPudyH7nbluIudSpyr7R5koi0ddGjH9W/uedgxMMGr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5YHI4Y8LinHXtLSqYCpjohx6VSNZpcuBlpMLCbMYE3WftVvESM3HbB2z2VFypMUp
	 GRlR/Sx6GyKzMNqMb3LF+3OBEgzV0mHhg2Xii4zoCQsb6IIus00stT+jo3t7LvtBFj
	 VpdN6XIXrlTLLKzT9vVrfxh8wyDjC1CZavDetUH/e2Xgi3HI1QwnuvK3M4gX3BVYpZ
	 wKQdlIKWjx8bkxw3yGOkrc80jh9JgbH98jGeQ8pRqibVBxhYm7u3EPliQm+u8z7spN
	 yj+MQyLKs84VvzR9k6UQkqRhH4+LIH0zk7alzyBgujcDLhk6PutKnjwj57f8H6lEQK
	 mWyVlm/SXBnAQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 630/752] io_uring/net: don't continue send bundle if poll was required for retry
Date: Sat, 28 Feb 2026 12:45:41 -0500
Message-ID: <20260228174750.1542406-630-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221095-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: BE0D51C830D
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
index 43d77f95db51d..2e21a4294407b 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -516,7 +516,11 @@ static inline bool io_send_finish(struct io_kiocb *req,
 
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


