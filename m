Return-Path: <stable+bounces-252757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIqqNR4IDmp25gUAu9opvQ
	(envelope-from <stable+bounces-252757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:14:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 093AC59801D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C506532AA833
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E83F7ABC;
	Wed, 20 May 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POCeOlFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F23340A57;
	Wed, 20 May 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301511; cv=none; b=m6ebLnLl9Vd2fsMqu2IxgXU+28Q9LnraZb3VvzHndSJDJfWsK01CrCcCXgqWs3Q/ulQTkX/9YtIiEMOAPlkhwiUmO5mOdGvlryljbWJK6k0ZkAHWF0KWZuXmzX8nZ9JG2qQrf+dTfOX/p7cUGHcCgeuUuxQnK0SThBHLl1FZbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301511; c=relaxed/simple;
	bh=I7HPuG/pWerkjUawJwkXHHxK5QDN0oOan3gOcO9vVgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iss5FaBSPouYoNO/H6Qr3C6YYG9gVSQ4gDozhSZTdv/sqsIZpZt3ZSFslugjNU5QmYbkNeQnoKCrUD+dqd7KkZPq/NJOGusYWXG2fGGpwePXHRWIwfnpMfLuteFHtR9LnamK9RDDUQcHjOriKmZFXhY8/4fn95vCUD5pHTscxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=POCeOlFZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C981F000E9;
	Wed, 20 May 2026 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301509;
	bh=HLxicSHhk7/wCuItf60ahbljkPUXPziBf9kl1/1aC8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POCeOlFZp+V9wEC6uVryVclco2M6nrd0U+T78EErPGjl4gD8F7QNnnehF466X/rrb
	 p8AS5BtTpkto3NkdxZRIScOtXuJj0+Ar4kXI2MeXPfv249uEM427vq4TArJal9MHXr
	 Si0i5U0Qb4cJ4Y0EQmUfaKCvnivLg9JfCUKcWjWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 583/666] page_pool: Set `dma_sync` to false for devmem memory provider
Date: Wed, 20 May 2026 18:23:14 +0200
Message-ID: <20260520162123.903482124@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252757-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,ziepe.ca:email]
X-Rspamd-Queue-Id: 093AC59801D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samiullah Khawaja <skhawaja@google.com>

[ Upstream commit b400f4b87430c105d92550cee5a72aea01fdf3d6 ]

Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
them generic. Set dma_sync to false for devmem memory provider because
the dma_sync APIs should not be used for dma_buf backed devmem memory
provider.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20241211212033.1684197-4-almasrymina@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5ef343614db7 ("page_pool: fix memory-provider leak in page_pool_create_percpu() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/devmem.c    | 9 ++++-----
 net/core/page_pool.c | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 17f8a83a5ee74..f04a89b0a41fe 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -333,11 +333,10 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (!binding)
 		return -EINVAL;
 
-	if (!pool->dma_map)
-		return -EOPNOTSUPP;
-
-	if (pool->dma_sync)
-		return -EOPNOTSUPP;
+	/* dma-buf dma addresses do not need and should not be used with
+	 * dma_sync_for_cpu/device. Force disable dma_sync.
+	 */
+	pool->dma_sync = false;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 458b040a8655d..2ad52612d8ae8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -283,6 +283,9 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_priv) {
+		if (!pool->dma_map || !pool->dma_sync)
+			return -EOPNOTSUPP;
+
 		err = mp_dmabuf_devmem_init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
-- 
2.53.0




