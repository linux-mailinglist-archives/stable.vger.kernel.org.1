Return-Path: <stable+bounces-258871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAvpBkstG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:32:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB1611F18
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B2463028F3B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB83C8C62;
	Sat, 30 May 2026 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eky/o40E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B13A7848;
	Sat, 30 May 2026 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165820; cv=none; b=RaOGGVS6YGM39bOle6Bem2mloO6ZOZxUKyh7vg7D9tmtGE+Dnuu0/TTi5ZZxTuskOZWssfzjTwvBR93vLw5d3MbnoyLEng5CuhIC0vAsziLs79QcIjAEIIZ0SmW4EB2rep1ClGvyQT6HwNjgn8KpLZRLBmGr1KQ5KIpe0IDWMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165820; c=relaxed/simple;
	bh=rk8Gbsqi3LdylGNphbJPCEic4J9yqDFJlP4iPH/ysAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhT4n5GAPo1iVy5EVJJyYuSH3VoXguFhl8myg+WtvAnkICbcf/ozi2ffrzcLH5Sow5uUWrX1Xm4FpL7MFaQ6Qt2h/kwS6BbuR9V+xey0de5627Zvp5Kp7AmxYULqMDULw+AHnwBuYRX0l1zxDQOr0Ce11rDDPDSeMawAI+62b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eky/o40E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42E1F00898;
	Sat, 30 May 2026 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165819;
	bh=QyTH85m3dJ8ile7YGN7EjzGlB0iQov0uGOnxxBEBi3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eky/o40EXQpmBcNrwOC62DKdEDzg9JTH+slfro+jE1BH7+aRoX6eO8+gLMx8K/nlS
	 e86Wz7akWNd9vwtwgAt9WzvY0RUGhgGOP6NNutAX3pcfNDpRWOCkQW6kUiChnZZxND
	 Eq3Gs8NdbHvRtf3bdjyUBKTybA5ABxQZneXUZ4ZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.10 192/589] crypto: ccree - fix a memory leak in cc_mac_digest()
Date: Sat, 30 May 2026 18:01:13 +0200
Message-ID: <20260530160229.953267587@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258871-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email,apana.org.au:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BAFB1611F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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



