Return-Path: <stable+bounces-181675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E9B9E054
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4BE189D0EB
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578426FA4B;
	Thu, 25 Sep 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmD4U3T5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A119CCF5
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788403; cv=none; b=KMP6s+kpgLSTKWyhREXOpFfwr3lraffSNA5O254QCNl0maKeUYw6sAleFibJir+/UhgysfLVMMfxG1wOUz+iM1rdPLU64gdM+kkmY9rmB3nAmP8npORlyIxQahCjXkLfNm0MJPCPQEn/X2cBRwoM3Od5yRAfAp8Nsg2ETCD61Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788403; c=relaxed/simple;
	bh=GNrF7hX2unDHG25Qn42VoP9x/Qpyuzr2Oc7luQK545s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHelcvQihNmQ+kOEjmRoquVC66ldSZjQ5kGSgl7w4xWv8sqHbpljkdiluguMVnMqwm5zf5GIjV+nshmJLfdv0W60jcGC07i69nqXSSVB+EshdC5KiPplkTk5hpWUD5PxKvidsdA5MlajFBEJhjcw8XWfCQAZHR/O2/5QwnoQH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmD4U3T5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1t0bS/zAY9iopE80cgTjwXzkA8jYIY/Q7GpXwMjltYo=;
	b=SmD4U3T52BNYYkR1iOLceD4b/f0kLRLM59AICKWKhla/68COxaHOSDm8tx5b61oJM+3a66
	/JSDumflIjmdSNk11Tr7Ygd5D3P5D5Xr1Pila/TS5faL+K3DwgZsqsaItkzUTgPPtjfXEz
	L09UETWz2ECXsaJSEzp4Hc/fcByt9No=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-stnxYWxAM--nGRe_rdiVdg-1; Thu, 25 Sep 2025 04:19:57 -0400
X-MC-Unique: stnxYWxAM--nGRe_rdiVdg-1
X-Mimecast-MFC-AGG-ID: stnxYWxAM--nGRe_rdiVdg_1758788396
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e198ddbc1so11972525e9.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788396; x=1759393196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t0bS/zAY9iopE80cgTjwXzkA8jYIY/Q7GpXwMjltYo=;
        b=s4wRIUTbt8AK74AgfH5kyyQz7SzSoN3PU3RJoeZdz5cp3yKUHoxW1Tp+JcX2i9Lt14
         hDJTFM6sXPYiizrNZpTtIpRDWr0kb8erQL0zknWB6r9qj+ZXVDdX2YeU0Syx3DtMfKeP
         jC3Hlp4YY3LffgTz66ggrU/dNadLZ2ZVDXIx0SfysnSCcKnLcl80w2hbX5g6tRTW2fpg
         Q9ArYe3RRyaTXZBZw7uI/dTG29VoBDxFAyM4/HbIeujtpMX5WcdmdB+gCSnE+QLYc6KP
         9ib3n3smiRQko3sHBXAxmnZ9TeeRFZyqQUemivmFHpKgIhCRwhxQv4BrdMsGKk1PXWv9
         ITmg==
X-Gm-Message-State: AOJu0Ywcqqmv5DIvKBneWzDq6x6D9howNFzXiUxKEuNAV66xlPLHVc0W
	CoOLq51IYxkTWv1SPmXRe9nY3nOnUpokEqb+wXrn92oAU92goLFNQujNGb+LIr8I+klbm2I8EFV
	sMr02A3MjTScLW24eTniP3t3C1p3DRQPRiZW8SkY1MJSoBAZSACwrQgoludJ5ysFJ9zfO5OebnR
	bxVPvNCZQkInPXWkY5S8OJEgvWq5PFQeMhmd99d25R
X-Gm-Gg: ASbGncs5uGJ/sQHMC1QNim1xpMQnn9iDHdsEsi64enl3QlI/p4mpn4YAqnnJzKGDTbw
	kBG8lrBXrdsNX7MJ1e1RbZVwwlKDoNvZW33Keun4NSQn4uHOTii3+oNVhYy5v62BxU+iZyQV1SS
	L+Ydba+hQaZXKwxWehJjviRj6PiW6I8ltBne8xb2OieSPHfRWnB3SHi6U69sC2Mwj6K9b589W5R
	Y2X6qkFlE2UKFlFzBWZnuFJMgNPYy1ae06SBHYAx0SJ09hEA5tSrpG6gkGPlqooaVB2WjrST6JL
	PAc/hs5yf1qn1z6o2a0Z1bDbkGzwwZQiqJKn3/1J6OcCBTdZQtBiQ7OAlOmtGrBrUM6NSGCt6k0
	aYSIRxr6CCli8qcgvcv5ufDtgIw==
X-Received: by 2002:a05:600c:2d08:b0:46d:c045:d2bd with SMTP id 5b1f17b1804b1-46e33c3f06fmr11492005e9.8.1758788396252;
        Thu, 25 Sep 2025 01:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9p3zKaofr2Jjf8QTeBuQTz1glQCxqmdRM6Crbu83X0gj3w72xS1Iufz10mbgLqExIlQHWcA==
X-Received: by 2002:a05:600c:2d08:b0:46d:c045:d2bd with SMTP id 5b1f17b1804b1-46e33c3f06fmr11491685e9.8.1758788395797;
        Thu, 25 Sep 2025 01:19:55 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33bf701dsm22324085e9.24.2025.09.25.01.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:19:55 -0700 (PDT)
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
Subject: [PATCH 6.6.y 0/2] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:19:51 +0200
Message-ID: <20250925081953.3752830-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025022401-batting-december-cf51@gregkh>
References: <2025022401-batting-december-cf51@gregkh>
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


base-commit: af1544b5d072514b219695b0a9fba0b1e0d5e289
-- 
2.51.0


