Return-Path: <stable+bounces-65267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930F9453E9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24CE1F23922
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436514B061;
	Thu,  1 Aug 2024 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kev009.com header.i=@kev009.com header.b="GeiNHcFe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD813DDA3
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546130; cv=none; b=JkM4oeNziysbgSWFybXkwulXh8fE7bAUkIwGWELfeRyNwbuLRPdXF0Lw7kZ3M9y+391zJaPHu0yDJ/7d1hqXZQZKCXTktqdSe6uFyFBoB9/9v0tklYO1D9hRxLBH/YgLjBHoikFGmIER26/p4mm9esDq+KrRxCZXyZu1Hx3RVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546130; c=relaxed/simple;
	bh=ouaxn2NcW67BXplYvI5175YWP+upBfvE611Qk+dIGbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADSpZyOagb9T9xA64h0p7W7Jlx9mOYTua7ggkvc+fs9MR5EmjQFj5GjNBRFPZ854ilAOylKPuYdUCWXuRKhDkO18t+YHhW9fkylch6kj0ViFx4kfa4XnM2OOoen+SeGM+PfRfXu0c5SmRbY7nDtKtVTGu86MCPZxu9aWpvpBUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kev009.com; spf=pass smtp.mailfrom=kev009.com; dkim=fail (0-bit key) header.d=kev009.com header.i=@kev009.com header.b=GeiNHcFe reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kev009.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kev009.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so5082586a91.3
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kev009.com; s=google; t=1722546127; x=1723150927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZBa5hQNDCUK8nFbEn3l9dAtyANR0fie1mHylb7O+/8=;
        b=GeiNHcFeROPukD5j3SjcMXRvMufh0nBm7JmJUWL16/lr2akegQz5qWdlHuAkW+gh+7
         wElgwcbOw0JA3tcp7qXSxo/77lu6kFDHyBttbXg1BVarcUpOTKzeLIGVwnitTKhh8fhZ
         k0qQHb0pGzP7JFqzySW3FUFrPIzsNpzKafsro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722546127; x=1723150927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZBa5hQNDCUK8nFbEn3l9dAtyANR0fie1mHylb7O+/8=;
        b=kCoVIhicJ7XWgX1KUYmLFDeQDHbc9yPr8PtwZCan90g2ZGv2Dp6PhYo7W+vuoDALZy
         yZgRCz1HJuL22ZONQ4Jx/5Jzr25dLFBk4+CQTfL/NjNgBsvSWzpUkt5aPr3zXZfTRdca
         tJQH/uqo8AaoHoOPyVUfSoZuUdsfZQGpDZwLnyKgIdbhrj0vSmRnNq2UAMsFNG/DtXwq
         LKYTtIJP1awUzw/q/bm7ypCaXSIX7rFcWdAeBoGqguZJ1UFbIC8rVA9GLC2HXTZ7AtNC
         sTzO4F9oktbb/uRdARJHcl3OzcXZxv0Vto9EKeWAeCXLsxDYXnwP7AamLwe3VM+DQ/Gt
         hp+A==
X-Forwarded-Encrypted: i=1; AJvYcCWrM2wMirP0Ulg9jFd/OCHX5Ynw1bpw8f50flNEj+jlYzlIQCGCh5fy1MoJOcdVcAwRhEFnxEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PDOv/n6Yar0OkhN9vZ6f3KECX4n0ubgAd4Dh3zEfIJ1jJxT7
	4jnXsTE/d6N4hx9NugN1AOlOysaD1G7dn3z1BIs7i7SvbcEJWOw7T+GzYGiwcg==
X-Google-Smtp-Source: AGHT+IFTkoLsxIFBjWusXPyAlMPN2id+iqTdsbfgYbH/nzk9F1qJtDu3RaYTbE6JaEP5B5bJ7nGZjA==
X-Received: by 2002:a17:90b:1a87:b0:2cd:2f63:a447 with SMTP id 98e67ed59e1d1-2cff95696cbmr1704521a91.36.1722546127047;
        Thu, 01 Aug 2024 14:02:07 -0700 (PDT)
Received: from kev-ws-aurora.cv0.bbox.io ([38.196.160.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45c3afsm3837085a91.33.2024.08.01.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 14:02:06 -0700 (PDT)
From: Kevin Bowling <kevin.bowling@kev009.com>
To: dhowells@redhat.com,
	keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kevin Bowling <kevin.bowling@kev009.com>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: Print digitalSignature and CA link errors
Date: Thu,  1 Aug 2024 14:01:55 -0700
Message-ID: <20240801210155.89097-1-kevin.bowling@kev009.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENOKEY is overloaded for several different failure types in these link
functions.  In addition, by the time we are consuming the return several
other methods can return ENOKEY.  Add some error prints to help diagnose
fundamental certificate issues.

Cc: stable@vger.kernel.org
Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
---
 crypto/asymmetric_keys/restrict.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index afcd4d101ac5..472561e451b3 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -140,14 +140,20 @@ int restrict_link_by_ca(struct key *dest_keyring,
 	pkey = payload->data[asym_crypto];
 	if (!pkey)
 		return -ENOPKG;
-	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags)) {
+		pr_err("Missing CA usage bit\n");
 		return -ENOKEY;
-	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+	}
+	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags)) {
+		pr_err("Missing keyCertSign usage bit\n");
 		return -ENOKEY;
+	}
 	if (!IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX))
 		return 0;
-	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags)) {
+		pr_err("Unexpected digitalSignature usage bit\n");
 		return -ENOKEY;
+	}
 
 	return 0;
 }
@@ -183,14 +189,20 @@ int restrict_link_by_digsig(struct key *dest_keyring,
 	if (!pkey)
 		return -ENOPKG;
 
-	if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+	if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags)) {
+		pr_err("Missing digitalSignature usage bit\n");
 		return -ENOKEY;
+	}
 
-	if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+	if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags)) {
+		pr_err("Unexpected CA usage bit\n");
 		return -ENOKEY;
+	}
 
-	if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+	if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags)) {
+		pr_err("Unexpected keyCertSign usage bit\n");
 		return -ENOKEY;
+	}
 
 	return restrict_link_by_signature(dest_keyring, type, payload,
 					  trust_keyring);
-- 
2.46.0


