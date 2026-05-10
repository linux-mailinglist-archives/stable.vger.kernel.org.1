Return-Path: <stable+bounces-245089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJfQDegTAWoFQgEAu9opvQ
	(envelope-from <stable+bounces-245089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:25:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5D506CE8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29AC3011778
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAFA3ACA58;
	Sun, 10 May 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWSFukBs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3E3A544C
	for <stable@vger.kernel.org>; Sun, 10 May 2026 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455516; cv=none; b=l+1kiLXAzWkEqkPHp+SlA4YOe2lItvD50v9SvrMCtMoB523ayLmNrXaP5GXS46hvzQpXyRJjYkedgCmpJs/2yaY99fC4U3mmfrsrKXNxMJDPvUfhfu3ZTn3+tNfHK6qCF27vWi74P7zEGSvPjX6a3VwyQxgCiJZowCRkS/RVukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455516; c=relaxed/simple;
	bh=/8xhVXrz8Q3xpD7n94ZUl2QrHgwje+BwlZ2z4YrUPuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnOc9qwVDzU9QmddBv7h8REtJd65DpuwZ49nXujxsTvyy6Y2KkllgAG+PJYQn5LyPxYJTJTqM7Pt4njHXLse/wAaFO5nuSz921BHpiccT5ylbABsf4IFEy5NsNwHsg8B6QOa9sNBE9KjgToGZJYAtRnRKNxhNHNJbLYMAivF1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWSFukBs; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bf02533706so31596837b3.0
        for <stable@vger.kernel.org>; Sun, 10 May 2026 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778455513; x=1779060313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOy80O60KUIlyR9w5AQAgpnG4tbnSWNzRVhKEWyyTiM=;
        b=PWSFukBsuCDiJKYHM2AhTDVXUMY6qTVT+shRweNH6zUcpDuTqUIVWpapzBAhQWCRo5
         DwCRRoz7b+jorgtjI8zNlA4PUXwN331i5g8ugB0YGxEOMtrZkFaK5JXZogEEnXRusL5Y
         s7lTG4zv17VpA93jF8GyWBPa5UAadom+Bfv8AwdT0DazeVXTipShUmf5HmV73JEsfQM8
         cw/ZUBqogbATcUFvoaOKXIU6dBst+hjM9G3sQklRVI55wfRLujCLgoIXeBC4wz0lnvQD
         WeUzquPTwg7qRAmjgn51HEiWB2d7blMUimSfmTu7yS3taiHcEJIT2jzRTtGduiK+KMhS
         FQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778455513; x=1779060313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOy80O60KUIlyR9w5AQAgpnG4tbnSWNzRVhKEWyyTiM=;
        b=kd5GU9SQhjrYhKwATO5hZ8NnCv/rEMZ0wzf5F7fpZdnePH5RcD0t4/Z2VqdcIz7KEO
         uaDNXgiGEK3WKdsb41MNyk3mAbBkRUuCRT3sYj01kRDBIjkK297SlR+xQz8JWYsSH0t/
         4+Z+SGaIMP7cuXLxThNdT/41AHzIYHFM3IA7g06Wt8CA8pyfNEUwkOUQxRkn0RE3/Nhg
         rLa4u3SiQQz6JpThR89uwxYO5DZT55ZbbRqpaXnP8CfRp7W+25n2fIjtasnJ15L5BN3Y
         0S7axElL8UTSVizi//2lItu2pI/+qxdtOv1JF3CShlA7GvHHDgt6EAmwO+ybdNOVFgAV
         eNzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uKOeUrnMQOPZHCZFu8uJbzZmQlHitGC3D0H4kAOLud5nCJzJw8fojVXJw6LrSfN/TlUdE8OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPGfAHgsHNqx7PkLrSvoUAIEDw00+9EBsTD6LQH/19o4qoVZP
	EdPnSA8yqcsjDaAQabq2FECv5DMjudXALyAvbO+UnflgbopbhhO3DFbU
X-Gm-Gg: Acq92OGUprQ+0487pzowrWGFrGvhlkDuDx2MB5wcATKJtM0PILnUZRZcSy/A7MyymoX
	5Ci8MsiXGbbAeQwBBfwLU81kAvvcePgddvRwlOEtPt07P9KQWyofPynSDXQkYaAaufPxpaqlV/E
	+xr4jEvT0xJWExLZ86a9b3oF7+fklJ+YADoTIUFRPiCxE+me8eOmPvscPhQVzBgWf05obOEjW5/
	rxNL4jMAu7EVT6ki9yuOKf6CNiN9yDpaAtupkcC6fbK0e5ZEKIU4CDrH/uBkR9YJmwXeDrYnRWY
	XuTCUqST2G5UKxHPl0SQ4PF18KUVc5IxKxpJu7MEu2o6qYM82Wtl9BAbVgchPFG+LVBq4U5hXaG
	OYBvVUa1pW1IlhKBcm2nIoXO9eprPBLuO4lgKHeMARoErKEz84cTYN/V9VgfwW9HV/uWeE0b6Hb
	r9S2fBNj8bnxxLnWWcoMIfqnfQT8BeJ6AnNHfOB032BRInqjwS9v9ZLcwdj0JjV3R9r4RF0iQc5
	cEOJfvdUY9NpfK4BJCT56kApdWqrVs9wX6ieJZ10Bw=
X-Received: by 2002:a05:690c:6f06:b0:79a:7157:879 with SMTP id 00721157ae682-7bdf5f37cf8mr216629967b3.50.1778455513123;
        Sun, 10 May 2026 16:25:13 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6656d218sm137549197b3.22.2026.05.10.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:25:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: krb5 - filter out async aead implementations at alloc
Date: Sun, 10 May 2026 19:24:55 -0400
Message-ID: <20260510232455.2245650-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502132506.1936358-1-michael.bommarito@gmail.com>
References: <20260502132506.1936358-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7D5D506CE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245089-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,auristor.com,lists.infradead.org,gmail.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
2.53.0


