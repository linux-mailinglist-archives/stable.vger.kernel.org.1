Return-Path: <stable+bounces-243292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOdCFKyp+Gm6xgIAu9opvQ
	(envelope-from <stable+bounces-243292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:14:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1A4BEDDA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CA0B30454DD
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE283DEAF6;
	Mon,  4 May 2026 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4L8gYLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4B3DEFF8;
	Mon,  4 May 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903512; cv=none; b=MI+wWEEW7LXi+qe525EyytybcP7hAvAbELTJTx8qi8ONlr5/ubY5SacyE0FF8lyNDzyVcp015LJa8LbdIb3mNqnCbGO6sWy+gvUxBRD/aedlRGWkB9xN9FK6+ZM7hieuYeJ2xFPD1rd8p8lFSkJImioHNd5VFAXPRsPX1kigpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903512; c=relaxed/simple;
	bh=77GPda1b/nBvZ/rAWONlw6whd/0/C4kwm9rGKHlnjqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb5F/gxtJ6rYXBHi1HK96/fVB3j1E+aUrTunG0dGWHsJNktnc1PTgQz4GKPEYuSpBfeeUfHGMeUStaT5GbvI6aWDFp45jOnzfbI+v/zQA4RZ3PH+OAU12NnLv7gY4tHEgthHovnd72NwyGuC5WLe7sOTBc0bgUHvWn4iAgzVeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4L8gYLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B67C2BCC4;
	Mon,  4 May 2026 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903511;
	bh=77GPda1b/nBvZ/rAWONlw6whd/0/C4kwm9rGKHlnjqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4L8gYLOPUff3Nws59VhB3fKmCLJShKilflMVcmm1r4aVo4LolP/6jiJpUzuWQL0O
	 aMIrZMn2EOyakKh+zhFb6AYG19ZWyqY0Ig1QMUQUYPNdu+stp2ukndQYg5cMzWtICX
	 8iSlhacjtoibDkc1EPOJZbVgPW228uFLjQoZtFwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 7.0 262/307] crypto: ccree - fix a memory leak in cc_mac_digest()
Date: Mon,  4 May 2026 15:52:27 +0200
Message-ID: <20260504135152.670667211@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 47C1A4BEDDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243292-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,iscas.ac.cn:email,apana.org.au:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 02c64052fad03699b9c6d1df2f9b444d17e4ac50 upstream.

Add cc_unmap_result() if cc_map_hash_request_final()
fails to prevent potential memory leak.

Fixes: 63893811b0fc ("crypto: ccree - add ahash support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccree/cc_hash.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -1448,6 +1448,7 @@ static int cc_mac_digest(struct ahash_re
 	if (cc_map_hash_request_final(ctx->drvdata, state, req->src,
 				      req->nbytes, 1, flags)) {
 		dev_err(dev, "map_ahash_request_final() failed\n");
+		cc_unmap_result(dev, state, digestsize, req->result);
 		cc_unmap_req(dev, state, ctx);
 		return -ENOMEM;
 	}



