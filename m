Return-Path: <stable+bounces-126006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702FA6EE23
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA6A3AB8DE
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CE253F00;
	Tue, 25 Mar 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdAuEhfM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15C1EBA1C
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899603; cv=none; b=QyoXIdn1STyqGzSKVvHPacIqUj4PLxklLNG+OVXYa7XzS0/qy64b/+NJ3PQBrZlGV7a0NYIlmydzVmOdFJHsIuuvkPjK19pynIFBgdD0HA9dhtDTCpTahNM5UClxGFQl1jhcOx0ftqCUGLwQXnlEEEX/ST49AliWXWPtAOW2mwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899603; c=relaxed/simple;
	bh=vkbpeFmqD668MPanvRonoQwCZ0BQK81IhaRcc7RnYTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhJkkWVUTk7mmNFc22MGTcIMdcQqLyXzycy3keGYswfTiCbg9n45+vMxt2aS46aNBrxfntAU3zJOQLEdyXGG+0MrJ3HbgXNlF7/ZxdterL6fHPEOWBrZzg3rLyZTAqxk2kmppnXEqImX3qBEiF3hqs8ijLy6gRsT1LMexfzB/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdAuEhfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL/6aR5DxlrxjOnL/vY3X0cqTZslpUhOi/XOXuXLhhE=;
	b=BdAuEhfMfQEehbJjjvBbU7Ve4u6pCdIsoND/YqcigEQuuPbJPrbuz07YQbtSgvKzUL25xv
	XcM3xwVUKMuryOa2cgym1ud5Jj9p1pqbkp7mzLJtyrjzIr8lZtkIAeWYzBxcljPEnPt8KJ
	AcvG8z79YmlNCaiKL0owTvPlWX/GnMk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6ljh4DScM2ScaEDG0u-VTQ-1; Tue, 25 Mar 2025 06:46:38 -0400
X-MC-Unique: 6ljh4DScM2ScaEDG0u-VTQ-1
X-Mimecast-MFC-AGG-ID: 6ljh4DScM2ScaEDG0u-VTQ_1742899597
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39134c762ebso2171753f8f.0
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 03:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899597; x=1743504397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL/6aR5DxlrxjOnL/vY3X0cqTZslpUhOi/XOXuXLhhE=;
        b=Zm4rtlYkfr9SqQlGr0shkjNweOoneb4TSqOd9vTXYpQ9v42mvCpQJ1ztnQN63XSr9b
         25PKVzUDR/3hknfa3n3ISlGYl2Z1CeKIHBk6vNg77PB/Hp4ds/Y5dyG7wdJE7bz5uO1z
         wfUvHizSZ+RjHTjCv086mOHFdxehAJdjcvrrpnt6DsIalhtsmTA5cQ76J1pRp23fypR8
         K4mI8tzkCaRpcOO0gtZlqYsXKrBSxKhoWlgZBOr7/fC21zIVUpzzIsqUEgdpn91KYOFS
         J9//wOhGbfIMx3DLLtLwf/dYE33j9R2Y8ek+YP/AEAv7L0ceiqn2MnKfO+h7nGYn8P+3
         iLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ktxuVyeXqMxOfFjRlYchciXKLb5gOds0XTSYa9tUQECTQXrRENQW7itIqfgCwZ08lRZawG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAF/8Rwtlrhb0Cv8ASSx9RcWunKvdCPbWFsW1nLWThBEBllS2r
	gmUDLjan16puPXUuZq6kVnNURiuAq0UwWLhMOqdxE6OaZ55VTdSaZ8dhQAZlsK6ETVT2DsQT8Vx
	56U+FxD7jlgoFuIXjo+FyREP5hH3n/R30d+KQnJUh2Ahcn0bUPrdHXA==
X-Gm-Gg: ASbGncse+m2TPHerU6Lgn7xb79aCey423bfv6poAONDuv9Tw5Jswv1xk/8pdmIzOsMo
	VqRCvoKJmJa/6BirtXAvLlxsIhs/dhZS/OAF7iXzAox/K+jXUZmhqFBRPIq049W+wyNpcSw5HjR
	ssDUZdP98sgGvo9uL2k6dKNkR98lbylx25ZYY8rgnBEAZyz303uyqVixCF74uZvp+QN1pAK+cL5
	Bc9h0UXystHtUFtQgY7Sx3pkivIDVTzM41Bq9eqyJpRUXB7H9v291TQVBboFKsd4N7lkAd+h4rT
	aPDT5zCMfMxqWMGuV1WWtgbtQUOArzkl0YFvOQKPGyc1i89lT5PpINiUv7isAF/KEj0=
X-Received: by 2002:a05:6000:2cd:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-3997f8edc1dmr15905511f8f.9.1742899597445;
        Tue, 25 Mar 2025 03:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw5sCn6O0eZPQdrxPvOONhB4Ut43Nqsv6iiLVmfKeBePtnVQmM3EmzBo2MGDhKqQ2BMNL+cw==
X-Received: by 2002:a05:6000:2cd:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-3997f8edc1dmr15905478f8f.9.1742899597091;
        Tue, 25 Mar 2025 03:46:37 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:36 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] ovl: don't allow datadir only
Date: Tue, 25 Mar 2025 11:46:29 +0100
Message-ID: <20250325104634.162496-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325104634.162496-1-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory overlayfs could support upper layer directly referring to a data
layer, but there's no current use case for this.

Originally, when data-only layers were introduced, this wasn't allowed,
only introduced by the "datadir+" feature, but without actually handling
this case, resulting in an Oops.

Fix by disallowing datadir without lowerdir.

Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by one")
Cc: <stable@vger.kernel.org> # v6.7
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..b11094acdd8f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1137,6 +1137,11 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (ctx->nr == ctx->nr_data) {
+		pr_err("at least one non-data lowerdir is required\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	err = -EINVAL;
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
-- 
2.49.0


