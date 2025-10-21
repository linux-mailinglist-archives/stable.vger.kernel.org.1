Return-Path: <stable+bounces-188320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904CBF5B06
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 12:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FE61888BD9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7A31329A;
	Tue, 21 Oct 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4zdcDUV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9D32B994
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041179; cv=none; b=EKbEWLkU8ptW/EaztGGlAwZ5covI9+i9jrH+tS8gT02k9cVfkUaRATeDy0T9UkRf816s9UxYFPZ3ZAXlWzYeAbEMGbb9/1rMsBETga0WRegsErajNgF0QvD8lxznJTTl+OfUM+3Epaqhette8VpqCHQWo8l/2jQiycXhSt3S7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041179; c=relaxed/simple;
	bh=JHx3RzN7ekZXT5s/kmXgxoDVrb+4PO8Z4TdtKCJjRPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbA4MPfv6l0JKgxooJ3o7JMWh7Xp4C6BDNtOfxBlhXB4YiIUATfUp6tuX9unkLHcEZXtnnJJfDns3DMbjhyRbOeOKcgMDjBO16NFdZLQ3KU2TIpLRm3lDbx2DMttLUHI9VpYmsFUtQy7+FJr+p5EGfSVkeqwYnE4ByHxtJ2oj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4zdcDUV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcIk1u1LFpf3b4C6lDAgUzkv/HVOGHxfz0isd+tTMcE=;
	b=C4zdcDUVu1KVdWBHMqPXIHCKXog+2s3sIXIQwtAvTDgZYl+djCCDELBQ8VPUyLxbZBUQNn
	D8qscKXrEplUopVUnkHNyMJS9tGejpIr+Kfg0CgTN1Jrryzyod59RmDO92BMAgbQqsxXsu
	bH95/DoUL77AIxDCFdfiWG2UjUPlllw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-C5ZEWUf-Oo2LOn1ibS-Bvw-1; Tue, 21 Oct 2025 06:06:13 -0400
X-MC-Unique: C5ZEWUf-Oo2LOn1ibS-Bvw-1
X-Mimecast-MFC-AGG-ID: C5ZEWUf-Oo2LOn1ibS-Bvw_1761041172
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso6239425e9.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 03:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041172; x=1761645972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcIk1u1LFpf3b4C6lDAgUzkv/HVOGHxfz0isd+tTMcE=;
        b=LlmQP+ZHhaoNksFk4Bwe0dR8AYFn8BqLCEuXch19noonQVK6p8iG/GJKXzPFew6uhE
         lcKoHJfkdlRQ53W/26/kr0QftLPYyPJQoieDyx4yn67bNbEj7+5QDiDGaxTxOKeM/vd+
         uu4lK5ZzgF2FFtr0izgPe4QrqVayBAP/i8hGSypngtZo2tQG6gOWuhPcuTdDFaoqPbJW
         MXGBstuPeV5J1ffxJM2hy28nlvDxX8HBP5YHHGkrVn0Q/COsswva0iGDqVqMkvxk7YLx
         arAcobb/kpcWfiJ1J5yWS4S0pnkQGeaScBFpBSaYGwn/TeIT2WDtocxnIT5C7FwJXUTG
         jS4A==
X-Forwarded-Encrypted: i=1; AJvYcCW4wup8ifmCr4VsvbFwT3KrV58tpAqR7H5YkhKAej0HTL2rdZpVlOr7BPAUShVewYwAE1gPh68=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9wQrDnkyK8FRxEEMlS2571zB3l6tvU7xwWzEQ3zSfwVrREL0
	67ksAfOqSqCwN1Ff1Tmf0PDpVfYGQeZuGqVGjo82ZDdIkt4FMCNe9I/IMdgU6gEZepj53u6TN3w
	wSWOA49np/BXgfjWLVUuEf09F2y2cVEAQSOU/C5rT3TevrxINM/QXM1zAfQ==
X-Gm-Gg: ASbGnctVfQyzXJ7plliHf/onL9drcM6F31quCpCdrEFp7UOav+xiU2+kqBwTOottZ7J
	QA+9FS0U17idF/o4AUBlVrbultrOQ0ewY0cgdLgvkMVPr0WKWjZ1NyQCPiz0jhyir166ZrL5/vn
	iAfBz2Kori47uwf5JhA0EMv+N/2ZdH9BRoAjlTeNp0USyAYJLTIhfUshYv8XqAJDdMjAVMy/4v1
	6UK3FpyTuP3nzhIlXuAbjNZc+hKW+oaRc/QanLD+AqYFX/2kU0dAMYgMjzCGDejV1ncPnQumwi/
	rQ1o5PjXEa5gwrwTyaI5W+nLIfrnffT+dWzJGt3MbL8a+jsNRSejQUDjux3u4FjN+4cEJs6FHCx
	FzcyjM37bPDIoRKIo6Hc0+ThBE7vNm4QxuF4LirwNS4zSvNtJWlfqZFUPap8e
X-Received: by 2002:a05:600c:8214:b0:46e:2d8a:d1a1 with SMTP id 5b1f17b1804b1-4711787c09fmr119127925e9.10.1761041171939;
        Tue, 21 Oct 2025 03:06:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF73SD0i6hnV9Jjn1RH+PBFk3w9kuXlrYaFhYZPnbx3J0Nn0xcYgxIdbLFvh84woZnc9xYOlQ==
X-Received: by 2002:a05:600c:8214:b0:46e:2d8a:d1a1 with SMTP id 5b1f17b1804b1-4711787c09fmr119127665e9.10.1761041171514;
        Tue, 21 Oct 2025 03:06:11 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496c2c9dasm13567195e9.4.2025.10.21.03.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:06:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Tue, 21 Oct 2025 12:06:06 +0200
Message-ID: <20251021100606.148294-3-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021100606.148294-1-david@redhat.com>
References: <20251021100606.148294-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's properly adjust BALLOON_MIGRATE like the other drivers.

Note that the INFLATE/DEFLATE events are triggered from the core when
enqueueing/dequeueing pages.

Not completely sure whether really is stable material, but the fix is
trivial so let's just CC stable.

This was found by code inspection.

Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 688f5fa1c7245..310dab4bc8679 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -532,6 +532,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
-- 
2.51.0


