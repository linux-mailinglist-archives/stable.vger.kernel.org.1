Return-Path: <stable+bounces-227817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDaMClt8v2ls5QMAu9opvQ
	(envelope-from <stable+bounces-227817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 06:21:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56E2E8407
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 06:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF76F3006696
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 05:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84A2857FA;
	Sun, 22 Mar 2026 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtLM8DVR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D770808
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774156888; cv=none; b=mSadJ/OQdozsq/kMAk7b1ybauooxsu89sdVseJ/pl3wk3LjDcsk5UeHbqF7Qm6crO95K6KQxZOOTdsRn2aajE+AYpS0BdwqfUpDftxuE9qH+HJ6vI0INKLe2UlGYhxl3dK+3wvFzs4PwuL2yoVqvwxnF7qsroPauBLEvl4F4Rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774156888; c=relaxed/simple;
	bh=mxzSb9+OwfykPBvJNQU2/8e5LLlhHkhSiQjzPwBRR0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cadr7Z0eIGnvOu/6mtYljfFk/sQeE4ekYX+IOiwKhyE/CULocmMDOjf1ee7X/JPcmvszetcMD/tM5e5qXLylNo4fpxkgH56DX+szrwh43fuCG+iJMyIRbeVKbvxkrOlpIu+rpU7+WXHdqSIR4iIQtv4KtoogVQ+R6SIVk+5lxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtLM8DVR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3151513f8f.3
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774156885; x=1774761685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lc7WXv5QbRK7FJAPa9CcSx+GAiaj9ytLHKKih0IedjA=;
        b=ZtLM8DVR+B1V7is668hA9V50W8S+FKSiJmBaXeSK3rjng2iLthpUITXIJHZ842hMv/
         8Sz6xjq3i/T/7RVZufNqfHdPJCrzn6HCbcNfE41CF8UAsNyCtp9XGA5/Dvv4nu7cT9lz
         7D+UJexWL3tIDZ0YIOj4FwMYFM2BQS5C6W39sSsdMyPERiIBElN/pWm0ZHj1HUCqGPcT
         WcRA0VqUBOeJS9MkODNlBY8/KAIwgLCP1iQFjGmUufTMSP4NVGMbOivs6usg2U6hg7zA
         XLzWG+OiRm5JxzbNDvl0E5gnRrQOGJLalmZ08Gl2irLtZVyCAcYZF9pID7lIRV9HuW7/
         uLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774156885; x=1774761685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc7WXv5QbRK7FJAPa9CcSx+GAiaj9ytLHKKih0IedjA=;
        b=afqbUGOSt6kB8zHjyNcrtAk2gFtClBPczotJDGoaXotHSeJsmX8lBHESOzKUIB/MJk
         vBn5i0Y3TxdpLChW5rpyscs9Lrp8jedNUkyQS3xj1KbhmPYXGSSmI1kPnPHIYA7QwlPS
         lZrc4kfAqrORFRvK/4EHZ2tITkEp4UwYx7LHVLmSyCST0ogrljcA2M+MW4uuOy93ZiED
         84eHJtEPYyD9EwDsA6uQX5AYHog22zo/9r3ZTXmc2eRaLQmmS9cv4gey4vcanU7JqnhC
         MWZnCGUI1ArXDnUdY58/Qu9ef6tN2t6Z07Wl6Ht5Q3yVQAboYXkRXE8bqBGx0stQ2kur
         voIg==
X-Forwarded-Encrypted: i=1; AJvYcCXfQ80X8sJD+h/Xg4lV/w0EoxNw/JVBWPuSem0qBMLxy6LGegOa9rywoJ6a2WkfJr0jCXUQy6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkBqH+FcIOMbN5We9bkq15ekuxISKaShK8etqJNOa0Bu9CNhX
	0m4OA9Dpq4SmFwkLGonV4JSeydUOES9JS57ul3PrqUaki2QYowugicnB
X-Gm-Gg: ATEYQzxR2gOjMBwbLC8uviUoTCjwJrTOPd/D5C67TcQHygcGZsCIT/UlZeRUD56GiK9
	AZXJwi5ixMmh+FJ3JerSqgtsRX34DN5y0KzE/n0MjCfgrlRAymspsC1YoY8k+tWDstFUrTQk3X6
	+G3WBFRNSFwVIC8N5ybBZHQAwiy1NNraB18GGEIwRAyWYAfmbOpIzK76x68zgW0/k447jWJ53kB
	4IugMg+uDZjxBJBCDXjpF+ShFXwoWIW86QmcXXgCtiY0cCTUJzPTxzdySsnikw6nam7ZRtVlxU7
	MxSRJnHz+kCG/ZqcAasISBkD4BQaM4iNF2r7sRtcZjNJW8eYNti6mFLIVpZvAvk1Kk2lCEXz45r
	9XbzqBJhka99EKwm1IHOOzRjOLpTaTzO95IUKAuvf+B8WYVofUXR/D/nriABw/zu/QUe2WcEDD9
	6eqRlnKYxBR97aUdLSb++FtnEBn4CH3TRYTuc+bU2aoBN7wfBJu3GCb6c6EQbVuj7C11IFr2Rkj
	ECsWA+DYS23
X-Received: by 2002:a05:6000:26c2:b0:43b:3d44:6624 with SMTP id ffacd0b85a97d-43b64232862mr12944534f8f.2.1774156884544;
        Sat, 21 Mar 2026 22:21:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm19494208f8f.16.2026.03.21.22.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 22:21:23 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Mina Almasry <almasrymina@google.com>
Cc: linux-mm@kvack.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/hugetlb: restore reservation on error in hugetlb_mfill_atomic_pte() resubmission path
Date: Sun, 22 Mar 2026 05:21:20 +0000
Message-ID: <20260322052120.14021-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227817-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AA56E2E8407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the resubmission path in hugetlb_mfill_atomic_pte() allocates a new
hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is consumed. If
copy_user_large_folio() subsequently fails, folio_put() restores the global
hugetlb pool count through free_huge_folio(), but the per-VMA reservation
map entry is left in an inconsistent state.

Add the missing restore_reserve_on_error() call before folio_put(), matching
the first-attempt error path which already handles this correctly.

Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 88009cd2a846..d6ea11113f1d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6295,6 +6295,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 			goto out;
 		}
-- 
2.53.0


