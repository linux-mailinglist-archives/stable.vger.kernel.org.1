Return-Path: <stable+bounces-218149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGYJIEhRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4C18EF73
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36769313B46F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43B1EB5E1;
	Wed, 25 Feb 2026 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MEzXspTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BA4369A;
	Wed, 25 Feb 2026 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982932; cv=none; b=mRAWPrhOfra9gjbjjYYrywi5JZ0iqW4HQ3uZJE5sDeiMrwOPvQQiBAHNLPfBXxK0IuoUGVduZXtQTqOph/IT8P3UbKSRdF7BvPltLnmoiBJ6K9B/SWEfJz1N+cfRiucXD0693eOghmUD+2tCLSYGLydzjRGs1skj1QjPOBzzhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982932; c=relaxed/simple;
	bh=TBpea5DEwJ0Mb1wlML6QjLLRrsGPCMPw6svX5qJHoQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxh+7pLuTU/huJWfHshm+1m0LyAXurrA5BDhemfL1Gew21Ids9y15ZW21hzw06yNR6mlxK6DN51szhjSZ265XRp4CN8yk5ZeOiTrHsGfjOYCEXTGgoENM80EanimQhn1gPAjWMO0WodFFh0VTpj0ngVf9hZVoS/z4rNoG8sNHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MEzXspTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA42FC116D0;
	Wed, 25 Feb 2026 01:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982932;
	bh=TBpea5DEwJ0Mb1wlML6QjLLRrsGPCMPw6svX5qJHoQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEzXspTSABCk6MXsHG0PSNR0HkLCWlRfY5Yuz+M2YR20ClZyHPQmrFXwZzR2EDY2+
	 iTvugT5ur/KoX9JVuijrYXsUQBpuvzQawGhUeHkoqEd70/HOyXjICev1fUI6P/TDBj
	 yoQhSLuhvYzllD6pyY1Ea9s89t/Q4YkJKgGCjpbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ella Ma <alansnape3058@gmail.com>,
	Tom Lendacky <thomas.lendacky@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 109/781] crypto: ccp - Fix a crash due to incorrect cleanup usage of kfree
Date: Tue, 24 Feb 2026 17:13:38 -0800
Message-ID: <20260225012402.356413434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gondor.apana.org.au,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218149-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F3B4C18EF73
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ella Ma <alansnape3058@gmail.com>

[ Upstream commit d5abcc33ee76bc26d58b39dc1a097e43a99dd438 ]

Annotating a local pointer variable, which will be assigned with the
kmalloc-family functions, with the `__cleanup(kfree)` attribute will
make the address of the local variable, rather than the address returned
by kmalloc, passed to kfree directly and lead to a crash due to invalid
deallocation of stack address. According to other places in the repo,
the correct usage should be `__free(kfree)`. The code coincidentally
compiled because the parameter type `void *` of kfree is compatible with
the desired type `struct { ... } **`.

Fixes: a71475582ada ("crypto: ccp - reduce stack usage in ccp_run_aes_gcm_cmd")
Signed-off-by: Ella Ma <alansnape3058@gmail.com>
Acked-by: Tom Lendacky <thomas.lendacky@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index d78865d9d5f09..d0412e5847625 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -642,7 +642,7 @@ ccp_run_aes_gcm_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 		struct ccp_data dst;
 		struct ccp_data aad;
 		struct ccp_op op;
-	} *wa __cleanup(kfree) = kzalloc(sizeof *wa, GFP_KERNEL);
+	} *wa __free(kfree) = kzalloc(sizeof(*wa), GFP_KERNEL);
 	unsigned int dm_offset;
 	unsigned int authsize;
 	unsigned int jobid;
-- 
2.51.0




