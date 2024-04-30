Return-Path: <stable+bounces-42839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F382E8B8309
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 01:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF464281E73
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EE194C93;
	Tue, 30 Apr 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="W8cFtS4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26221E49F
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520061; cv=none; b=MYoOM8ZMeoqdBvMEdS8krpfmBrBEtNm2gENx3TAhfpJXyBqmvU5UAvuaMXRMeQu/b/gKdC21Qm9p7IdKZCWdQ4BlfKvMVcHt+gVVTQ/4pXYb8N/UUkwX0if+CYJv5EvHXp6hqUxd/Xuo7Ddn/rFpul8867UC/r3YNIm3fWB3JI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520061; c=relaxed/simple;
	bh=CUdqUK8/ValitmyBS+xb7YLi69r/oIOYAQs2ZwGykDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oeoi5q8yR4084N1Cy2GU3wbG/W41Mbm9pKD7QAukbUKGL3OUXYAVo3F+81Qh+3/utGzYiDBwUdJQIoja1JfmZBI7wYFDF6Kn8qoYzr7DKnwOTUUF2pFg7ZbhhFX6f9jTLXLAcrHshGZQhgYM0CxxQpT1u/Pg3mEOgU5m6NO6pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=W8cFtS4E; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 99F0D3F56B
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 23:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714520051;
	bh=So8jd530nHImAmOdJRTzED7+Hks3FsBcGAx8HTUU2jE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=W8cFtS4EbJWmIDdQJmXb+Hdmfv/noL2AzcRRKJogBkiXlsxxHS0NTHA+VH1ADbxEO
	 U5BM6qAaLWntrRaCpIfB5+K8h2TZ6fgueREcFQ3MjImu+nPWeI0L19mjk/dQKi9uAs
	 trnbzcIcaUxMr+AxMEp7kpI00K9PVHKPVAo/qdWVCBTK1ZED710PjXj759GwWn9vzH
	 SyhaMGROqrAgSLwhTfZPn/JvAtp/DKVO1LMqvxkDxAYgRFGwKb3xS0r2hYi44JBS2/
	 6gydKHgqEvXap6x8AzIhuc/TArntCrRln+KXFG7gZ/M1EWav7mOxCARyUS7DBDZDT0
	 +nZLc6QaJbDAw==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ed0e1f8faeso253368b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 16:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714520050; x=1715124850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=So8jd530nHImAmOdJRTzED7+Hks3FsBcGAx8HTUU2jE=;
        b=poSI48MYbLb4erb2Mj/ogHuZ+ZW448dWFHf6K2oXrwXeBFwmKuFS6IKbGCfJM1/KDP
         EjMzX7GNipVgQSlnit9OXpMZoq5Bva/ESQgySrp0KeCxrogsKvkLOjayTXqVMagUXYS5
         3k26RweLDaO39V3+DcDvP4ggNCQqaStUiepvPF9xT0K7SGDtXHeCHXF/SRL4OrjxM3Pl
         nLMqG4eGpvNTyboTJJuDpMQ++dkMbB1jv8Rlr0ZbCDUXod4HMVSdWtAH8NiFphUMQQTo
         nkAZJnhp+XhnykXdBqeK7GckRWQxa9XqzMy8ThlaD2V+4O2mNV8FKjdrsnvJsqtsmReW
         WnjQ==
X-Gm-Message-State: AOJu0Ywvxyv19LLyabhbqsoB5INkMllljhzZW8qFF/41+qcKxuWkb+e0
	+mKLJDxaa+v321aje7J+Kdv5mcW12BCt7Zd3SIOD6ctQNotU6IKcmihkEisUObdOpRPgDLbRClg
	e9m6WbLvevDAaIZY6VcneSDi2UW1b/mTv/O9+GZfl5i+3qlVo03Le3PTtLeayqeWMoWkm3JZDvB
	3JZw==
X-Received: by 2002:a05:6a00:3915:b0:6f3:8467:fc8a with SMTP id fh21-20020a056a00391500b006f38467fc8amr5983392pfb.10.1714520049684;
        Tue, 30 Apr 2024 16:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpNrI/rGgjF6Ht2JVe+WLB2w3JkbqcdKBRxWFjpqJcR85bWFuQh8IKQbWA7iF7Nb1/zaQ7fw==
X-Received: by 2002:a05:6a00:3915:b0:6f3:8467:fc8a with SMTP id fh21-20020a056a00391500b006f38467fc8amr5983371pfb.10.1714520049225;
        Tue, 30 Apr 2024 16:34:09 -0700 (PDT)
Received: from localhost ([122.199.27.104])
        by smtp.gmail.com with ESMTPSA id h17-20020aa79f51000000b006e71aec34a8sm21611308pfr.167.2024.04.30.16.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:34:08 -0700 (PDT)
From: Liam Kearney <liam.kearney@canonical.com>
To: stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@canonical.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: arm64: use simd_skcipher_create() when registering aes internal algs
Date: Wed,  1 May 2024 09:33:26 +1000
Message-Id: <20240430233324.344622-1-liam.kearney@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 crypto drivers duplicate driver names when adding simd
variants, which after backported commit 27016f75f5ed ("crypto: api -
Disallow identical driver names"), causes an error that leads to the
aes algs not being installed. On weaker processors this results in hangs
due to falling back to SW crypto.
Use simd_skcipher_create() as it will properly namespace the new algs.
This issue does not exist in mainline/latest (and stable v6.1+) as the
driver has been refactored to remove the simd algs from this code path.

Fixes: 27016f75f5ed ("crypto: api - Disallow identical driver names")
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Liam Kearney <liam.kearney@canonical.com>
---
 arch/arm64/crypto/aes-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index aa13344a3a5e..af862e52a36b 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -1028,7 +1028,6 @@ static int __init aes_init(void)
 	struct simd_skcipher_alg *simd;
 	const char *basename;
 	const char *algname;
-	const char *drvname;
 	int err;
 	int i;
 
@@ -1045,9 +1044,8 @@ static int __init aes_init(void)
 			continue;
 
 		algname = aes_algs[i].base.cra_name + 2;
-		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create(algname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
-- 
2.40.1


