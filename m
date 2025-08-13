Return-Path: <stable+bounces-169424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FDB24D4A
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC4388725B
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA221ADA3;
	Wed, 13 Aug 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtuiWIH1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01941FBCA7
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098425; cv=none; b=RPEkJghl6yFp9QA6b35vn2p0SgbgjLl49MEti4viK+GlH/sIgO9Rq1DEc5QcULO8bbJkcZFR7n2XQq4Ed5a8/viOjMFumhJhg4ivUGv8cp94uIrPGQU1dQLrLWpb9wFcoTQl/b3rpV6wB7vUN6RDq2/idh+zYYvmtY8GGa8aoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098425; c=relaxed/simple;
	bh=J0Olzhfp398H83g4qgU0KwPikf1DxIDwgtT/Xr4oxYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMxrTqDWqRsEmfHYm2Bu476z+ngDAulZdo90R3bknEMlr0nqsSzgzapMJOgvr7M83agbawnC+tvkILQvpFsykc/kzeRsPcx5MgHuREH2nSlFzgvIFFzrKFVoyF3bmegmRftBJBBKLu/fvSdZXAyt4ObEnMrAwH/y9EMpH6g/Osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtuiWIH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luPG1goyuiBS0FvRsoCQ2oyoviuaJXbbLcf+yNSBvlU=;
	b=QtuiWIH16bBqSlwM4uoOPOiu71LOv/cvT6fqugsYlJFEFZF2WTsxi6H93wXWNGf99sX5mu
	4HL2jJrR3ABGDJgcRJieoZckYXZ7y8b2fycFn9vNkM/d00UhKMP/EABtmLL9nfwuH+9/kn
	zvyED05jFpaNVMSA6kYfZejEB8X1QIA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-TZZsYMgQMr-uP0tn0Z8EQw-1; Wed, 13 Aug 2025 11:20:19 -0400
X-MC-Unique: TZZsYMgQMr-uP0tn0Z8EQw-1
X-Mimecast-MFC-AGG-ID: TZZsYMgQMr-uP0tn0Z8EQw_1755098418
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d4b5db81so36722795e9.2
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098418; x=1755703218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luPG1goyuiBS0FvRsoCQ2oyoviuaJXbbLcf+yNSBvlU=;
        b=Bdl0zXFfT1/hx7gZpzKhiPlHDN9GTRpbcoOQms2NY3xo5Cm+yE0XZw9Q79c6mcem2h
         hrbetu5vbo9YCxYjFuQQ4wlDcnF1+KMIwXiej31ySPNp8Bh+oWouH67vnrQ2oeOPnYUQ
         XSpIeWjTan+/kQDKn5h0vxqZzds4qknD+5a7YJ4443vqUxSXoTl9HjGdlZw9zBZzUcLC
         ajFyCj/OlVYR0QFbsTqEB08Pe73+YRo4T4uFDCvPh8RVwkIx2VXJu0HDepCpT/2wCkdr
         3hWhvpUxcMdR2paNlC5gQFh6LsnAYUqnYPDZ3OllMnoWYml6Vz2lP0loOyOH1Gj3nFuq
         +VUg==
X-Forwarded-Encrypted: i=1; AJvYcCWRcYWzr/At4lJwA1FTorowgJ+b4iHSCxNNzdQSLUouS6pUdNeWYIIGEJl8t/MgHWAMAx4wrYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUmWxuErFb7jl46IomkNQDKPXXWzv6NkO/1RYak3ONlZBthfI
	xHKUIONoZAkwZOJv7oxX7MkSe8gHOh5ju47h8+tYSCQacy7mb4Gf1SF2MrJvlbHayLzoUmtO1Eb
	6lbAbtHnIF5l3bfKr54yCj51jMcVhTwKrJ856GFA24OdQKOOKzwHySRDmnQ==
X-Gm-Gg: ASbGncvlfD6PIFFok3H5Qq+2f17z7IJiV/pBH3jUvlWjDEO46o8PAvuMJFlS9ZSlAfl
	VfsZCrw7k/WJ4tbIY8/PckP6yk460bVoRTT5TpbqwCMs4xiuYCI0ExfWWjyExR0Q9Whr5hZkWpR
	/6EmhsXUEYqP62K6ZjZAycG2W6oLh2GHGxFsC3RbH5FkM4y9hQcas3scmFgZAMHECuTi0u1pF0c
	HeiGatww+LhztcnWff2pXDrich3zDBNo5wc1XVoXPLMZz6tComyDKZdHdAY4MP0un4IEei+LjUd
	g5s4e/Uh5dvyzYiFtjj0NeG5zNpCbTdcHWQGb+c4LfNiVp0yN9GpRR3vBJyHxgJ3zxD9L9mDrBL
	O3Rh70+DunFPF
X-Received: by 2002:a05:600c:3b16:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-45a165dc92bmr36316405e9.18.1755098418143;
        Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhftQeRBnMTP79oYeBPrLVQFcy0YoWKK+VKIdNr6Tz5JmKc8vfXV57DQ7KTU8XyYnvbwoCgg==
X-Received: by 2002:a05:600c:3b16:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-45a165dc92bmr36316075e9.18.1755098417643;
        Wed, 13 Aug 2025 08:20:17 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48584381f8f.68.2025.08.13.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:16 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] fuse: check if copy_file_range() returns larger than requested size
Date: Wed, 13 Aug 2025 17:20:11 +0200
Message-ID: <20250813152014.100048-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813152014.100048-1-mszeredi@redhat.com>
References: <20250813152014.100048-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like write(), copy_file_range() should check if the return value is
less or equal to the requested number of bytes.

Reported-by: Chunsheng Luo <luochunsheng@ustc.edu>
Closes: https://lore.kernel.org/all/20250807062425.694-1-luochunsheng@ustc.edu/
Fixes: 88bc7d5097a1 ("fuse: add support for copy_file_range()")
Cc: <stable@vger.kernel.org> # v4.20
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5525a4520b0f..45207a6bb85f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3026,6 +3026,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
 	}
+	if (!err && outarg.size > len)
+		err = -EIO;
+
 	if (err)
 		goto out;
 
-- 
2.49.0


