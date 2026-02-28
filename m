Return-Path: <stable+bounces-220894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmqHS1bo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:16:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E41C8E51
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C498A3478810
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175FA367857;
	Sat, 28 Feb 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhMPZS2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E936784B;
	Sat, 28 Feb 2026 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300783; cv=none; b=Q6yQFOWsZGVipWgnsVZmtzcCRdmxtuWYavpougUNb4isvN3iagn9s5KnFACmoFWz0z6PHo78B8d4XucrhotW6pZjKKBmC+cBc2W3uaYoIXlJkrm+FaffKy/35PzNfMVXTwdHWVhCJOywdr43vgPn4Mq2qdUh/Tuv6Op5zqGh//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300783; c=relaxed/simple;
	bh=JB0I4pQvCKHiqn6le86sQBGFZc/z/XZ4cik2Xy2pCC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSMt1GQ5x3MaY7jpIoEpfglTCBJahjclyoe87+oQGDcUzjOqg0QZjsfD57ZCqJso+6RHbk8NBzKJQcb393IOAg5vbDrS46QacAsBtLilC6kZAdPmB5X88dlZgFKt6IFfmY5qWXTYeP+hEwgp7/FcmNde/pF8HvqEhopEAvFnLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhMPZS2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262FDC2BC87;
	Sat, 28 Feb 2026 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300783;
	bh=JB0I4pQvCKHiqn6le86sQBGFZc/z/XZ4cik2Xy2pCC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhMPZS2TsaiYnZaW/TiYVJVeT76so0nXFo3QT0RZIkdZ+CdKYVPG+R56kdjpuXNGo
	 mNKZ7fX5SZ1ONSJq7mEWAxheCcNNHjlhbAFZlsazCa+tWS0CiEMdhFgZL6Sz0PADmH
	 Pv9le2Uxmg6mOfdNHVqNNH7ThnPx/7lRV1jf+ySn6JyvBMl0hwqGX8CohLP0tyvtes
	 n/fz7LPks3YjN8SgOKvuYjbwxB3x6JFyT1c7Ot/9rZ1JnU1H3vdf638IjXfTPbRx2T
	 xys4cJHvEDNtG0BNVENs5VHs4nEPZrj6+LTQ8kzOulF/zSNZixgFl5WbPlIDdaqbd+
	 GvnW0ntHF8lrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 815/844] io_uring/zcrx: check unsupported flags on import
Date: Sat, 28 Feb 2026 12:32:08 -0500
Message-ID: <20260228173244.1509663-816-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220894-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: DA6E41C8E51
X-Rspamd-Action: no action

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 7496e658a76a61758b20e27cea8abcfeafe3aec4 ]

The imoorted zcrx registration path checks for ZCRX_REG_IMPORT, as it
should, but doesn't reject any unsupported flags. Fix that.

Cc: stable@vger.kernel.org
Fixes: 00d91481279fb ("io_uring/zcrx: share an ifq between rings")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/zcrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 84e37900c0682..d41aa01a26d31 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -677,6 +677,8 @@ static int import_zcrx(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (reg->if_rxq || reg->rq_entries || reg->area_ptr || reg->region_ptr)
 		return -EINVAL;
+	if (reg->flags & ~ZCRX_REG_IMPORT)
+		return -EINVAL;
 
 	fd = reg->if_idx;
 	CLASS(fd, f)(fd);
-- 
2.51.0


