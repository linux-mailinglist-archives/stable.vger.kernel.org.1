Return-Path: <stable+bounces-169423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF12B24D41
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06551887AB6
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7DC219E93;
	Wed, 13 Aug 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehYLU645"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637B1FE444
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098424; cv=none; b=ZCpv61oci8bb547iyvvuOY/jjNUQ4pQZNsc7Ikl8Pto3eNXrbBfOGnK6FLJCCRqqt/pX+Gpn01abUnyzMZvmirghdnIgcjH6REztNQ9FdcGP++RHRt2YGIo2tUi4kSMjWf6cpf24Wrux2BaFZGJ2xGHrpQ2GO77MVc0JxBgjDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098424; c=relaxed/simple;
	bh=zelzCXFsoUxUzfvWcdsoKzGEhp3Vd+Zs2nB56ddoPgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/Z1f5YmaHqVgKwBfjdQQT/3uKMspWVQlWK2tot12NMQF2FSTyP2yP/OX+dckvizdzWBfQBRLdirr0PoOOz+IK0s4voPzoNNGgQ6DKnP82nAKlTCnQDcGp70Umdbz01+REloZQGpWWM7tyfjl1bYZhQGVSiiEBY7y7lVVMB7RM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehYLU645; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qs+uvqsTAq7/QLzhBjesvITe8yceIRYOS1EXK24w9kY=;
	b=ehYLU645vPfQMQ0yjaHm68Z2hrH22co2snUYi9Cj0qNdAF2gSVW0hPTE0URAoTJgZJgKHn
	FUNXpzSSBEJGx8gETlNICdCBj2Qo7b6Q+r95M0gzXe/fGeZio5MtF8nlvrpxjQMdndJiv/
	RTQR5RvzZe7KfZVttvdJzricS4bi+Pk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-izXIVqlrNxeyqvkBSLdHjQ-1; Wed, 13 Aug 2025 11:20:20 -0400
X-MC-Unique: izXIVqlrNxeyqvkBSLdHjQ-1
X-Mimecast-MFC-AGG-ID: izXIVqlrNxeyqvkBSLdHjQ_1755098419
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458f710f364so44293665e9.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098419; x=1755703219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs+uvqsTAq7/QLzhBjesvITe8yceIRYOS1EXK24w9kY=;
        b=J3fjbwqT5BAg8cl4FVlE09WSTzekcmlloT8N/ounx4pRBUoacXWlHSjOSgFoETxb0F
         RRgc81O4JQh2CxYHq56uGonk8b3DY1Ro2axGxRV3T5o8Ji6BAfYaONEFYiQZHDXQjQKU
         o10tgi59BLiLnY5SoOMN6zBq/7d4D4/rw38eElBf/mLXE3kur3AsWfPJgUgQB+J65WhF
         sscP4yWOiFOPvPb1fcsb11SWbuPZ0G7uGq3d7x+Q9qRrD/IWOfOlipPW1vBlimcFyB15
         +ylP/EUrfVgm8s7U7lEa8z/wW9jlWIWggOHU3kYJw8nc6jb0dmtsFUvBelqsc1n3szMK
         RGvA==
X-Forwarded-Encrypted: i=1; AJvYcCVNpiB2sS4rqhPoMzg7c78KuPeClghvVc4JOODGxF/E/usT0JSWWHcYp4XR9mneVhTSOye3bi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZirADFighw9u5FMSxsyEvpLVYLK9iMUNe9zb+lb/Xq45H+Fd
	zgGMuHD1jABIrgowecupSoZ34EbW23xDfLfKUKtk13Ta/wxYvnB6uYRkjGolp1JuzQAL/7yKleH
	P1U6MNWbMY/576t1EsElTwpuDkGBAgGugoW4Fh1h/vai0i48CkNTjV5kdfJbtKXIvzPau
X-Gm-Gg: ASbGncugC7PTL82MjRaqa+m+1xL5q2oEcYU64Ba6Nfu5NOEw7VQDTf2wppkntbF+xj1
	hUPfUbE/xUyeaVvTK/chvEMI/AJhlk4FdYZKfSTuk+6S8yzMk3ilMF3pOrMwst1QN9QsLvgbghx
	QVDR63P+bg6uZ9NLYz3hEnBD5Iuv6gvpVSEA439ng6pWsA+S4g/u2Kw/7YqyVuGFUCjqLdgwd2h
	KjllrjfHPIefRchgSxkZ62i8UEcFaJaOioXqzBYA13yDrlM1E91qOHPNR+H2ehmrmb1UWho5xaC
	5c4+dLwgIcIq8Tr9FSD1ieEnpJXZnEmNb9MW+Mp5nzTZwHQhqHrEFFrIwB/WoyiZqbKjJjwZWUA
	nlV/2jYOsVrIO
X-Received: by 2002:a05:600c:4587:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45a16593b94mr36973405e9.0.1755098419118;
        Wed, 13 Aug 2025 08:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYxQu8lTH95YgRx2lulP9ABmic2/Mc6Q2gPRc6slnYatyLjXPS6dzwX3uETbvh2aVpOD1Dg==
X-Received: by 2002:a05:600c:4587:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45a16593b94mr36973125e9.0.1755098418717;
        Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48584381f8f.68.2025.08.13.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Florian Weimer <fweimer@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] fuse: prevent overflow in copy_file_range return value
Date: Wed, 13 Aug 2025 17:20:12 +0200
Message-ID: <20250813152014.100048-3-mszeredi@redhat.com>
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

The FUSE protocol uses struct fuse_write_out to convey the return value of
copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
interface supports a 64-bit size copies.

Currently the number of bytes copied is silently truncated to 32-bit, which
may result in poor performance or even failure to copy in case of
truncation to zero.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Fixes: 88bc7d5097a1 ("fuse: add support for copy_file_range()")
Cc: <stable@vger.kernel.org> # v4.20
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 45207a6bb85f..4adcf09d4b01 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2960,7 +2960,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = len,
+		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
-- 
2.49.0


