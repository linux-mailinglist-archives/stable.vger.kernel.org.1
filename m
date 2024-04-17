Return-Path: <stable+bounces-40125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F078D8A8DAC
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 23:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E34C1F21415
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC752F71;
	Wed, 17 Apr 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1vxw9cw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3084CB36
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388725; cv=none; b=rUJVyySgI5AykpX4cDyPWokZ9nEGo0gr1tWv6BaQ3eU/gjlBlkqkJ5Xy7+3e/ekkXqT6QZEKJlz2PiVynOnY4vwzL3NOXdLKV247VfQF83DXF6Q4gMdakaZBIIc/cX0sL72MXPlY8v2zo79XCyaxcyZL37Hq9DlyssQvR7SnJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388725; c=relaxed/simple;
	bh=8hBBeVGOfwuGovj1gkEA8TNtFgFkqBM5g9BIRvAXat4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9o7dzpr96wwdEabVzseOMFKEHSWsqDgCpkXOr+0ERX6RPS6IhQk1oWDJGwJrqiPd3+E0zxFjqZqAY0YJBUjSZSLjO0oYZyD2UVcS9ILQ3tPA6vR8cNJNZx//HQQAvERDITnshSMo8OcdAxrrmFwb+gERh0YtVIIdfn23DdSV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1vxw9cw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soVIv7S/cFD39BpNRdoqoVyCZSY1hvphkidLWmkZkAI=;
	b=A1vxw9cw79OVMzi3moPVCH3xEObzbBCpBF9AqmPG4bDAZHeR+9QmbQAMinP/c/c/LovRgr
	W/XvowUossX2VGGdsSfNaPO73Ziqvy1A+pj4g8t/UwIazhTS18LFN4VhL2R868uiGryC48
	oRf3KaLtCYHkcKfoJX/8gd6usjcoN+o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-O9_lPoCbPZCy5yjhYZU1-Q-1; Wed, 17 Apr 2024 17:18:41 -0400
X-MC-Unique: O9_lPoCbPZCy5yjhYZU1-Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a04b4edafbso451126d6.3
        for <stable@vger.kernel.org>; Wed, 17 Apr 2024 14:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388721; x=1713993521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soVIv7S/cFD39BpNRdoqoVyCZSY1hvphkidLWmkZkAI=;
        b=EJpyfhGL61iB6+0KmsjShkJIZV5XbZXOkJm/e2wYWFZ0aZrTt75Zs8ffxQI4c+fpG/
         kLvfavhfzO3W//3MMjUwIO8iLsDeAhHPTfk7dMCk9hIEqaInDcfl1ldWd/c/L1Pr4UkT
         XkjUOBtkJ59mbm7bfD0nFA1SmJ1EzyuuOf4h9zQ0LbVFQiLpBPx921sLJgRKaFhjg85X
         Y6JpL4tmzOEQrSLE9kuAdj7oDYcECFRTODcxWJYqgleeB7xCy97DY30Egju7ENoj4lIp
         DEq8XuIv0J/yVmNrEFWPGpnWhj/YQzpOZeMuxskCd9Bja1Cn+AsCilstP+hjdrf8+iiC
         3jyg==
X-Forwarded-Encrypted: i=1; AJvYcCUw1bzKejwFKA1sMm+eAtfYtIhWGYm277tsmzKkXWjSEzKNxUuAulS8L0bR7TRVCMvF4w8d7wfhbQhuA1jaU2KGhlcHjpo6
X-Gm-Message-State: AOJu0YxuuNICoeqDI1viNuVp2tzpNcbyglxr3Agp6jWi4FM2VOLPY6AL
	nJo3tJWqYm2yP1nizeAeB6ebou7v5apDq+gRojNsP9IbMG1xsSU/XY41GaYw3B2bv3Zz5mIQ7Vf
	q6pueO8s7VTpxrMKFNyX6SpfU9gJTFrJzSpzN6i+tm/kpfFWFplQIfQ==
X-Received: by 2002:a05:620a:40d5:b0:78e:db4f:11e8 with SMTP id g21-20020a05620a40d500b0078edb4f11e8mr665740qko.2.1713388721123;
        Wed, 17 Apr 2024 14:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF29e5f56ETIzCUQyLUa1pQN9jUqXmcKYHsWC/k2I1kVI2Yma0QJE36x4pPxkZnbBNtERvaag==
X-Received: by 2002:a05:620a:40d5:b0:78e:db4f:11e8 with SMTP id g21-20020a05620a40d500b0078edb4f11e8mr665713qko.2.1713388720577;
        Wed, 17 Apr 2024 14:18:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b0078d667d1085sm18692qkm.84.2024.04.17.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:18:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com,
	linux-stable <stable@vger.kernel.org>
Subject: [PATCH 2/3] mm/hugetlb: Fix missing hugetlb_lock for resv uncharge
Date: Wed, 17 Apr 2024 17:18:35 -0400
Message-ID: <20240417211836.2742593-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417211836.2742593-1-peterx@redhat.com>
References: <20240417211836.2742593-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a recent report on UFFDIO_COPY over hugetlb:

https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/

350:	lockdep_assert_held(&hugetlb_lock);

Should be an issue in hugetlb but triggered in an userfault context, where
it goes into the unlikely path where two threads modifying the resv map
together.  Mike has a fix in that path for resv uncharge but it looks like
the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
will update the cgroup pointer, so it requires to be called with the lock
held.

Looks like a stable material, so have it copied.

Reported-by: syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com
Cc: Mina Almasry <almasrymina@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-stable <stable@vger.kernel.org>
Fixes: 79aa925bf239 ("hugetlb_cgroup: fix reservation accounting")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 26ab9dfc7d63..3158a55ce567 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3247,9 +3247,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -rsv_adjust);
-		if (deferred_reserve)
+		if (deferred_reserve) {
+			spin_lock_irq(&hugetlb_lock);
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
+			spin_unlock_irq(&hugetlb_lock);
+		}
 	}
 
 	if (!memcg_charge_ret)
-- 
2.44.0


