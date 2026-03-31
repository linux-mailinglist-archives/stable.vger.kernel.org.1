Return-Path: <stable+bounces-231830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEYzA2/8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150736D661
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3FC329092E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D8A42EEBC;
	Tue, 31 Mar 2026 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wB45YcbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A842EEB8;
	Tue, 31 Mar 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975179; cv=none; b=ZSxMOoHcCdJsS/lVwoh+RS1QQrmDsnGAm17U/RBNSZcSeRGmi/OxBbjvW7E5geEKrqEoVh7tj82AY6aDTrYxTXjdt9BHQE9yHtBFX49wUtPs6VoGagCEr+IypbqL2BDSIOZBKilppyoX0dJ2KKmwVLSsweWOix8auhqWh2kZQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975179; c=relaxed/simple;
	bh=Ya910JVZYBoxOBBBSRAjWMzN7EKNDSEOOBMsCK06gfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UizWaGXX/aByxkeyriiMBD6r6GbTBbKqYB+xesdp62xslO6Wi8QzMkikBRMlGHzeH2uoBbu1atuqwBD6qOVvAWp9ie0eTzlXGOHmKeN49lRDdPr2m1K1T7uZkOGWkblXyE590yht23V0Ww/1LA2+5GUw+nAz8l1Nn+lHfqBtw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wB45YcbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD39C19423;
	Tue, 31 Mar 2026 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975179;
	bh=Ya910JVZYBoxOBBBSRAjWMzN7EKNDSEOOBMsCK06gfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wB45YcbW3zcMsnM/Uk4hj+1fu2LEh6Wek5StWLFDZUtLcb4i7DF0zTsMF1nNq7ezL
	 jef+E0mBr3fOogUDWRNDPj/oeHXIC6mOmsgYXrdHXydHn2wEot9EcPx2QdH8q6h+ls
	 PgF0kUenBkZiCnxKnQFvwNYjqDsb8AB3pqZMwfyY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <nicholas@carlini.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 193/342] io_uring/fdinfo: fix OOB read in SQE_MIXED wrap check
Date: Tue, 31 Mar 2026 18:20:26 +0200
Message-ID: <20260331161806.096460844@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231830-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,carlini.com:email]
X-Rspamd-Queue-Id: 6150736D661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Carlini <nicholas@carlini.com>

[ Upstream commit 5170efd9c344c68a8075dcb8ed38d3f8a60e7ed4 ]

__io_uring_show_fdinfo() iterates over pending SQEs and, for 128-byte
SQEs on an IORING_SETUP_SQE_MIXED ring, needs to detect when the second
half of the SQE would be past the end of the sq_sqes array. The current
check tests (++sq_head & sq_mask) == 0, but sq_head is only incremented
when a 128-byte SQE is encountered, not on every iteration. The actual
array index is sq_idx = (i + sq_head) & sq_mask, which can be sq_mask
(the last slot) while the wrap check passes.

Fix by checking sq_idx directly. Keep the sq_head increment so the loop
still skips the second half of the 128-byte SQE on the next iteration.

Fixes: 1cba30bf9fdd ("io_uring: add support for IORING_SETUP_SQE_MIXED")
Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
Link: https://patch.msgid.link/20260327021823.3138396-1-nicholas@carlini.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/fdinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 25c92ace18bd1..c2d3e45544bb4 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -119,12 +119,13 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 					sq_idx);
 				break;
 			}
-			if ((++sq_head & sq_mask) == 0) {
+			if (sq_idx == sq_mask) {
 				seq_printf(m,
 					"%5u: corrupted sqe, wrapping 128B entry\n",
 					sq_idx);
 				break;
 			}
+			sq_head++;
 			i++;
 			sqe128 = true;
 		}
-- 
2.53.0




