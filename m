Return-Path: <stable+bounces-218884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO/YM0hWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:54:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DD190230
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B08E317DAF9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0C27F75C;
	Wed, 25 Feb 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKpU5KGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292A26E708;
	Wed, 25 Feb 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983772; cv=none; b=UTg0ovEOxJKAhAHtkGC3pdAb1u6uThANBJ3aG0iJt4HAcTwVbgKTDoPccvYoGT5Q5qECM2/Sq5poCJgQIrJ64E88nakE8yDzh9mZm5u1Iia5Y/d696rwX6oekzehA1FzsCdTSpy8H8vffJhstNoXW7CpiI6qRyGe8tpiOHRZ4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983772; c=relaxed/simple;
	bh=oJoXa+k59EZ8+V7HST92Q8aSlq45I7RsBVUb72qTtvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVJs4FLRp8os57KFw97ABtzheykXMLlMI0Dlcz+kOPz16//erv24n2CyuURYQO56gUZ58R6tWvPAyrA5gqljxZUX1IlAZxOKIRq1XxF+GzEVByP6Uvyvlk8B+pbsdxdyV10G8uQ1ARzAD4u0b6ykPsVmn46ZpfT03bzDwoaSv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKpU5KGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB250C116D0;
	Wed, 25 Feb 2026 01:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983771;
	bh=oJoXa+k59EZ8+V7HST92Q8aSlq45I7RsBVUb72qTtvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKpU5KGOedbns5ePECghJqba0DhRe9Hv7kcJPwe5Zhq61CVh3tPBREP3CrdfT9s4r
	 tb5PSb9ZAZTllnoq6HcNF9Ly8fQdUvv/X4uHPm5cVRPe76lmJfRhenvzbmQGMqqBdr
	 aIJjAil5H4U91p5rkwd+13n/CxKDSURHt10SqGp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 062/641] io_uring/kbuf: fix memory leak if io_buffer_add_list fails
Date: Tue, 24 Feb 2026 17:16:28 -0800
Message-ID: <20260225012350.554805857@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218884-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,kernel.dk:email]
X-Rspamd-Queue-Id: 391DD190230
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 442ae406603a94f1a263654494f425302ceb0445 ]

io_register_pbuf_ring() ignores the return value of io_buffer_add_list(),
which can fail if xa_store() returns an error (e.g., -ENOMEM). When this
happens, the function returns 0 (success) to the caller, but the
io_buffer_list structure is neither added to the xarray nor freed.

In practice this requires failure injection to hit, hence not a real
issue. But it should get fixed up none the less.

Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/kbuf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index d974381d93ff7..308ef71bcb286 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -669,8 +669,9 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	bl->buf_ring = br;
 	if (reg.flags & IOU_PBUF_RING_INC)
 		bl->flags |= IOBL_INC;
-	io_buffer_add_list(ctx, bl, reg.bgid);
-	return 0;
+	ret = io_buffer_add_list(ctx, bl, reg.bgid);
+	if (!ret)
+		return 0;
 fail:
 	io_free_region(ctx, &bl->region);
 	kfree(bl);
-- 
2.51.0




