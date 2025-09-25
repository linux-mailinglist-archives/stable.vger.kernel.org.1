Return-Path: <stable+bounces-181678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001CB9E072
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6C7A42D7
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A571FE45D;
	Thu, 25 Sep 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDcaqnpq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129228F4
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788630; cv=none; b=iFh+pBlS+kb6/jMfhDQVopd9oVS+TLOFcrpBHZPyeYsrkDzGx6H4q5nXHL3AhSogszmVhfuAENkWr1duAb0DKFbVrhSeVZ0UY1neOysp6Hzd6nz9JzdJu2l6RaKZXnVsQbOZ/xJQtMHGOSfGzf9Zqz1Frhq8gYf6Js1aHOPR6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788630; c=relaxed/simple;
	bh=avPqV5k125U3I3x5MMQi/tjUXDzdZCdJLGYwX6wdoO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK8vWFkT8taa68TmqGt4zYDMgOGHOQIzeQNPgvV4bg7ZL+GBLqVaFu5P9nP26WRIKKt17Cn2eSioifPaKmdSUNtTBZ0AynbyE+jSHQca5HQq2d4pcKLTT519ftGSKIuPU+hng3NU+Xcg8K1PvqgLDVFpNtD61eXK56qskFSDDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDcaqnpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhSbD5B6IBnwKu21md5JvzsTHBApvKSCpLrxMRXz0O0=;
	b=LDcaqnpqTa1jnHB3FACsZsHUCPN5Xyb5WrOFBWeYI0VslRYp6Ac1dfF59QuAFS0WwnoKhB
	+wh1y2r/Rxu+uOxzblYqnviNG22JOTZWU7fKpQCtM7DSnQnA7ke49wY6DMYD5RwrCx24Wu
	C6Tf83rHdev638urXCSDOYrpBvSzL1M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-PgFaROf6N1WdWV8V1mIubA-1; Thu, 25 Sep 2025 04:23:46 -0400
X-MC-Unique: PgFaROf6N1WdWV8V1mIubA-1
X-Mimecast-MFC-AGG-ID: PgFaROf6N1WdWV8V1mIubA_1758788625
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so291022f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788625; x=1759393425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhSbD5B6IBnwKu21md5JvzsTHBApvKSCpLrxMRXz0O0=;
        b=vJLSt9KCWeP7bKVv8S2mMaALkuTnuuuJAVvbeDgefRJAEKT7CvQRXCv+xhXakAluF+
         Dpinv/my4XlIDDIeLnLqDhAtuswtUgzYAxsljS8QBZX1+GQ5pnLYUZK6tK8bX7MMIZnq
         0XOnnJaY1q3bFXAEYCRTXeEEIa37XOms8AYnVuaUC7uIggb0WoInL4LY9hMW8mb3nVvx
         dkLA0Qwk/nZ18CtsBkKxr0hjk3CN+QKoOLJ7qsvAw640Ly+CACjpPUv2QCDeR+p3yfOU
         t1aRCLKYcftjbg1hH+puIE1SwOodNrh2QEx59X5zuFXaMtuOsDdWQ17qUufiMWCG3H1R
         X39Q==
X-Gm-Message-State: AOJu0YwmXe87/lv8exKFlM3P8SWZSOA402YCvxhhB70VEtzZAULFBBmr
	FHx0sdSdMzf2/WtQYyXrM131mjczi0ydYrZzj9opjZMWr79QL0yyHK5JvT0TK/PPU4wlGRh0XD3
	//jiO8tRxOpItk5YLuaU667K6/dKzfP4MDsOCrWAmq33+RaawbW7QFayQzQGvko5a/qsD6qjMWU
	5PCuxHHB/vwztrCQ913fUavOzrycvdLvCtn09B+qRa
X-Gm-Gg: ASbGncvoNXJXvdyQg36VGtd94FbMLlXVxqHQy5qMNrlzQEvxdzB2VFqpeFqrG9l73zL
	uKeSjqQFGRCSYoZZo9oLgblB8B2N6nnQEaZSDFtQJycBrJJ6UDaxJJyjPcRAbY7Vr3H7yjPgD+I
	A3MyD0qQ75/gXsE6slRFbNIFe9FhhS+mNzf4ZvIPsxIeUN7450gxkKzOoW28fNRbFQpFu+F0unh
	y++gfLmHz7ilR7fIlDYdW8iWDQyvSPTpzHA4GKZ3/G5Ul5q2m4WUZu/ViOZOp4MAhJS8Zq8D4Ee
	slAKi5D2sDf5PelDsiKkX8fBw5mlGqyegzjoXjSjz3wWVzF1fFzzTyNn4oWaZftdRAY2zMqQoNO
	nJcrPiIkAdXNm2O0t0bMPC8XWfQ==
X-Received: by 2002:a05:6000:200b:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-40e4c1dd9ccmr2003068f8f.55.1758788625375;
        Thu, 25 Sep 2025 01:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkNiCkdhIZKuI0E4i9LV6sIBB71hg0FAowyLArQNJUOTpu9g8z2WgXGseImIfZM4zfRLDFzA==
X-Received: by 2002:a05:6000:200b:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-40e4c1dd9ccmr2003044f8f.55.1758788624900;
        Thu, 25 Sep 2025 01:23:44 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb89065b5sm1962986f8f.17.2025.09.25.01.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:23:44 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 6.1.y 0/2] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:23:41 +0200
Message-ID: <20250925082343.3771875-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025022402-footprint-usher-aa6e@gregkh>
References: <2025022402-footprint-usher-aa6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just got reminded that I never did these backports.

Patch #1 is a clean cherry pick to make the fix in patch #2 easier to
backport. One minor context conflict.

David Hildenbrand (1):
  mm/migrate_device: don't add folio to be freed to LRU in
    migrate_device_finalize()

Kefeng Wang (1):
  mm: migrate_device: use more folio in migrate_device_finalize()

 mm/migrate_device.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)


base-commit: 363a599da6d9d9aaeea97fceff615580e845c72b
-- 
2.51.0


