Return-Path: <stable+bounces-249297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBLFCL4dC2o2DgUAu9opvQ
	(envelope-from <stable+bounces-249297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:10:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7056E683
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C86302EEC4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885648164F;
	Mon, 18 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="h86c7QF/"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4B48B389
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112415; cv=none; b=IJEsL9tPaZzcBxm25E/bXu9tNf4X57Um2l/5cyZMtAYcV/uvL0HA+GmWxyGZoIYdJAuBuq4YV3szPrscDTTPfgO00KH/Ndx3UstaKdM2l/WchVcV8iTzIofqGmQoN5O2KT/ISJeB5i3izGHWtaeujY1I+eDT2H7oaMkJY3ro2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112415; c=relaxed/simple;
	bh=hN//C+6iSuLWrlrke8jTPf3i3Up46Cf0abiY1Odz8PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwD4tBvJhZEx4kFwydqmy00BeNFp02X+iKHCv1yQ9BTYoJ/CU50sW9Rb8XnbbhJxVcwJ8nZRV5GuieroBngExMzf/1vscbXsvGaXbjhfz14eOsWFoELFP/C8XYameQjjH8sZ8rrOyxHEEC9nkv4yvOs57FDnhKleU9cVn7cSgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=h86c7QF/; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1WmejweJGHojR0/4xZCjXb0R5xm+GiTyWqwBEXRANRw=;
	b=h86c7QF/m9+comReSWPDOgUns9H/8dLexuGZOfQ+63k4jBeWYx4UbMcXDTAjO1ME5K3pGs8r5
	bOjagifXzL4/TTF4/v+o7GhtSIGDKY6EcOVEco8NJqVEB3eU+9Gh8BkwEQMbco3lKD7OTjKejQh
	UZSLnPwnO6cLmRuv+H5PgN0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gJzbG29kNzLlZB;
	Mon, 18 May 2026 21:45:46 +0800 (CST)
Received: from kwepemr100008.china.huawei.com (unknown [7.202.195.119])
	by mail.maildlp.com (Postfix) with ESMTPS id 263064056C;
	Mon, 18 May 2026 21:53:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemr100008.china.huawei.com (7.202.195.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 18 May 2026 21:53:25 +0800
From: ZongYu Wu <wuzongyu1@huawei.com>
To: <fanghao11@huawei.com>, <liulongfang@huawei.com>,
	<huangchenghai2@huawei.com>, <linwenkai6@h-partners.com>,
	<lizhi206@huawei.com>, <panjunchong@h-partners.com>, <qianweili@huawei.com>,
	<yangjiangshui@h-partners.com>, <yinzhushuai@huawei.com>
CC: Michael Bommarito <michael.bommarito@gmail.com>, <stable@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5/6] crypto: krb5 - filter out async aead implementations at alloc
Date: Mon, 18 May 2026 21:51:59 +0800
Message-ID: <20260518135200.3573377-6-wuzongyu1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518135200.3573377-1-wuzongyu1@huawei.com>
References: <20260518135200.3573377-1-wuzongyu1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100008.china.huawei.com (7.202.195.119)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-249297-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wuzongyu1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 79C7056E683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Bommarito <michael.bommarito@gmail.com>

krb5_aead_encrypt(), krb5_aead_decrypt() in rfc3961_simplified.c and
rfc8009_encrypt(), rfc8009_decrypt() in rfc8009_aes2.c set a NULL
completion callback and treat any negative return from
crypto_aead_{encrypt,decrypt}() as terminal, falling through to
kfree_sensitive(buffer).  When the encrypt_name resolves to an
async AEAD instance the request returns -EINPROGRESS, the buffer
is freed while the backend's worker still holds a pointer, and the
worker dereferences the freed slab on completion.

KASAN report under UML+SLUB with a synthetic async aead backend
bound to krb5->encrypt_name:

  BUG: KASAN: slab-use-after-free in t5_stub_complete+0x7d/0xc7

The helpers were written synchronously, so filter the async
instances out at allocation time instead of plumbing
crypto_wait_req() through every call site.

Reachable via net/rxrpc/rxgk.c, fs/afs/cm_security.c and
net/ceph/crypto.c on systems with an async AEAD provider bound to
the krb5 enctype name.

Fixes: 00244da40f78 ("crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt functions")
Fixes: 6c3c0e86c2ac ("crypto/krb5: Implement the AES enctypes from rfc8009")
Cc: stable@vger.kernel.org
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/krb5/krb5_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 23026d4206c8..2b20284fa0ab 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -165,7 +165,7 @@ struct crypto_aead *krb5_prepare_encryption(const struct krb5_enctype *krb5,
 	struct crypto_aead *ci = NULL;
 	int ret = -ENOMEM;
 
-	ci = crypto_alloc_aead(krb5->encrypt_name, 0, 0);
+	ci = crypto_alloc_aead(krb5->encrypt_name, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(ci)) {
 		ret = PTR_ERR(ci);
 		if (ret == -ENOENT)
-- 
2.33.0


