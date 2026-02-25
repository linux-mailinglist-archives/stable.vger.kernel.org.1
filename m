Return-Path: <stable+bounces-219251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DipBGienmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:02:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B77192C5B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17FD0311342D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF02C11CF;
	Wed, 25 Feb 2026 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RNSNZHt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27142C21F1;
	Wed, 25 Feb 2026 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002593; cv=none; b=DAj3MEnMkx8l+mxzdw9pWJLMG9/5jJPClit6KAu90/vk4A+6poF7Fb3HfYQChbE0kPjIw09y4cZsrLwZ0DWl6v6bNS+QKgkSb5BvucBx5BOMcRKI7jMbNJKGCocLLgftCG5f+8erfaPHn+s8d8bdaCIlJ/2NMVQIXDw0HKt7wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002593; c=relaxed/simple;
	bh=XV3F0g0ZgUsbdPlzBU5ZzkPNKNiNZCookWPYvQ5FX5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKjb+AT4W5wlmNE2dxx6FgUqm+EYRBKplY2JIGka9NNLsh6UaJfN6nZqjpkDF6mnKkz/HixQLiSpvQru68nn79uLYN4572R0WYuTA5TL9DB1pulwY/mNDFqLBgnE0F0/c5rdmI0bbOahABzk+hcgG7rAiqBqwwXYlfzCYO0NHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RNSNZHt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797FCC116D0;
	Wed, 25 Feb 2026 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002593;
	bh=XV3F0g0ZgUsbdPlzBU5ZzkPNKNiNZCookWPYvQ5FX5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNSNZHt+v9w64umsXkppk5RRPFXGDlrgbVbPtniDbPCmbYWznKJ6kl1GiXNE9/QcB
	 xvNFrrnStCzjEkjrlT/N2UCkPDvKqRVlBFozTNSPFApLrPjvIIYwqL/jnlx/s83Rfs
	 wPCl5rNBXKr6miAajlSjYThU/fOxky7ZTxJIvNPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Honggang LI <honggangli@163.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 337/641] RDMA/rtrs: server: remove dead code
Date: Tue, 24 Feb 2026 17:21:03 -0800
Message-ID: <20260225012356.839926444@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219251-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65B77192C5B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Honggang LI <honggangli@163.com>

[ Upstream commit a3572bdc3a028ca47f77d7166ac95b719cf77d50 ]

As rkey had been initialized to zero, the WARN_ON_ONCE should never been
triggered. Remove it.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Honggang LI <honggangli@163.com>
Link: https://patch.msgid.link/20251224023819.138846-1-honggangli@163.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 9ecc6343455d6..7a402eb8e0bf0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -208,7 +208,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	size_t sg_cnt;
 	int err, offset;
 	bool need_inval;
-	u32 rkey = 0;
 	struct ib_reg_wr rwr;
 	struct ib_sge *plist;
 	struct ib_sge list;
@@ -240,11 +239,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	wr->wr.num_sge	= 1;
 	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
 	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
-	if (rkey == 0)
-		rkey = wr->rkey;
-	else
-		/* Only one key is actually used */
-		WARN_ON_ONCE(rkey != wr->rkey);
 
 	wr->wr.opcode = IB_WR_RDMA_WRITE;
 	wr->wr.wr_cqe   = &io_comp_cqe;
@@ -277,7 +271,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		inv_wr.opcode = IB_WR_SEND_WITH_INV;
 		inv_wr.wr_cqe   = &io_comp_cqe;
 		inv_wr.send_flags = 0;
-		inv_wr.ex.invalidate_rkey = rkey;
+		inv_wr.ex.invalidate_rkey = wr->rkey;
 	}
 
 	imm_wr.wr.next = NULL;
-- 
2.51.0




