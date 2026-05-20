Return-Path: <stable+bounces-251456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCVPJaX7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E59595E1A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8113357620
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCB37754D;
	Wed, 20 May 2026 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyIRE4I3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F53D75DA;
	Wed, 20 May 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298029; cv=none; b=Bw+DG0zsqf9FkbdlGPQ9othwVyyFrv+CFjHia+/sysnm2dPWuk4mDODPrQ/ESrcSwOdiMv74I3jTJ7loqEBB6oWje8PYYuxHBr6AL0Od2V+/bGMGjN5T3jtditcJuaWossEK0AncwnLlgM+/7mhDEXsvbggpAoqv9GNZr620QBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298029; c=relaxed/simple;
	bh=6lTilhFJUACOG1QW5K/hsvHR7TEcC8dVe2GhORPYvyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHlREopQ/0dSZzhTbgcnVimsOUMD0/+QWBlYui3lbZ0OC9WGn+sgmplAVxC7vH696J1GI5THb1Nnv7uo0bqgLy1FsStk+P3Pqz5TEap+EJhrTMKoOieqRXL682zKScdoa1S5nno5lEtPMy4L8cL8o/B3aPJCDWOJ0fRuqm+xoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyIRE4I3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E101F000E9;
	Wed, 20 May 2026 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298028;
	bh=IDirwOMY8xXSKlqWzIU4d6EtxpFGW9P8n5ZwszIllbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyIRE4I3UEXyNXN0FdMmta4xf1OSz9miRS9P8QzeOR2hT5booyg1qHZUQXecM6fsy
	 US/ucQYLZQHaNbqhblzy+KVnPpcDjDfjXeAxpwtNUyl/nyh2jg+TIF72BRjpXLnrAp
	 W0SWoKnFdsA3rpRW0bXx1Cqe/qTKOPHhBv0qczQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenkai Lin <linwenkai6@hisilicon.com>,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 254/957] crypto: hisilicon/sec2 - prevent req used-after-free for sec
Date: Wed, 20 May 2026 18:12:17 +0200
Message-ID: <20260520162140.051933147@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251456-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: D6E59595E1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenkai Lin <linwenkai6@hisilicon.com>

[ Upstream commit 67b53a660e6bf0da2fa8d8872e897a14d8059eaf ]

During packet transmission, if the system is under heavy load,
the hardware might complete processing the packet and free the
request memory (req) before the transmission function finishes.
If the software subsequently accesses this req, a use-after-free
error will occur. The qp_ctx memory exists throughout the packet
sending process, so replace the req with the qp_ctx.

Fixes: f0ae287c5045 ("crypto: hisilicon/sec2 - implement full backlog mode for sec")
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index c462b58d30343..2d0b248c59ebd 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -230,7 +230,7 @@ static int qp_send_message(struct sec_req *req)
 
 	spin_unlock_bh(&qp_ctx->req_lock);
 
-	atomic64_inc(&req->ctx->sec->debug.dfx.send_cnt);
+	atomic64_inc(&qp_ctx->ctx->sec->debug.dfx.send_cnt);
 	return -EINPROGRESS;
 }
 
-- 
2.53.0




