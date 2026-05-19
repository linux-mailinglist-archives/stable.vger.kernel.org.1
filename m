Return-Path: <stable+bounces-249708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHetMqnsDGq9pwUAu9opvQ
	(envelope-from <stable+bounces-249708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 01:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C34585EB7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 01:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45CE301FD4F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D435E931;
	Tue, 19 May 2026 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeHnFgUy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E978F2F
	for <stable@vger.kernel.org>; Tue, 19 May 2026 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231910; cv=none; b=mqV4esWl7JCznzUxOjUTNRQJEuWk+UCtLu6LmLtO3U3ERxaCdtfovJm8su35ecSsOYABPAorI6Gab/1OXNuqp37i3hII2q4uKtj8EHSTkOzz/C/XLFTCg2oMGClvawSD8MxO2OeAnRyEnjvX2Ot2oafANv56+UUXWtYK1MwjfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231910; c=relaxed/simple;
	bh=kmljMs8Rf1PVvpETVY9rWE5evYqbcKNafcvaVomh9aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbhzPZ4nz8otyduyBcqe7Ay/iUzHwZGqCNZCFs6Munah/gKD/7VN6536S3RjmhvuJcwVxrTzpOS9pruN1cd5zn5REUiMvlaaO7w3AtB4K8Ii9+s1UWW0vSS9Wz+aW/ieoho660iiXNR9Qy4JSbTnjWr6PkDVkcOhnYoT0RqhrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeHnFgUy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so45365695e9.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779231907; x=1779836707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BL0u1dhtcx4RdNvWcLeas7d26YUbe0kObwGLJD5YkoQ=;
        b=IeHnFgUymFEHamfPbsJqgwAaKtIlKsImHI4VhxEDvEQiBYHFi9/ar0PRW98jkEwQlv
         6PLM0KHbat6pYSOX9QzZLAheJZtXgew394XqbzEBEsVswFCQfFRUaUcnhi6q3Wnm/piD
         ESQNx5KwLbspeZKk07xZYM7W5q26iWEjlDhdHwHOAu1ckStcEyo6SJaWpz19tyrkJO02
         D/THVJMet+pZbCQj6mgK/+COXG5fOflSMoCYpTjZ4h8A2vM1YPaCuW7yCqpGTMUaMK3S
         //Ah+lXX16rMEQjxDsxLZfNr4SOmN1jrLAiHzkajDUoftL6DAEHjG01mfTdJwJe9d+Nl
         mjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231907; x=1779836707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL0u1dhtcx4RdNvWcLeas7d26YUbe0kObwGLJD5YkoQ=;
        b=CxXc+sNiMURyx/4IvuLqrBrrEawl6vEuEcx9xTENN7uIyVMHcfIC7MnnEcPW1K7WTb
         oAKUlwDfXaGF8Au4Gq1H8iGt5Hm7Hl1CUx2x98EivzouioiyLwvlFV1YR+wpdARhW3Bc
         lzTbz9z3h9iQCMwyT+zfrECjLQtD27xTT1w0gZ0huRNLT2Zr7KD772NwCjq0IoQsTE7R
         A5Ps3ZSi3tceusMFzbhPTXhSouhD1X+Tr6GwowdKq86EVy/cPTOyr+Qw2xPiSaGbx69C
         JvN+LpAE+2dyyAEKoPlkDSF0KvVVVvaIq8uQ48KA6B2BkURYv0rI9EkZG69NFisAw24R
         MPxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LaQ5suvpg2jPzLSL1cSiQgnBLp8yb1uLCb2/t70eaWk+jdmRIDQOJo6HIUxY6ybsHinVqwIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBh1B6P3n/mvuHESvlMA7MJ60NuK5wrrHaH2LBRA7Frr5diTu
	7eHUxp0CK9leKQqPfNSLiFeLmJriwyExGkmtQAE0Pu/jH/x1fYbnFfgu
X-Gm-Gg: Acq92OGbxyKkGfPho9s6EE13MGkH1Ldqperr7K/jVaJJBGUvzfWQB/14e+YSDi+ntLg
	8p9fJP4ilrNpuocIsCCCS66OeGQelF8lgQrGeHTxdtjVdnXaVIg0ZC5jIM9rFwxhnT0akfiqxUG
	1YBQg3jSTY9dzoEWOzaxe0dZMDE3I0D2mVEbEDYbeEBk31f4oa6wT0zhHPuwwQtbiYO6Zxa40Yc
	9Z9G+UPAcXR4vKGtdfmWsEHB4frYRDeTcKBHS2/YPtXrKZUn3DleDBYjoFX6bBRB4wOSh2Dwcex
	20J83BkCU+X87WoUzWo7genFWME9gqU/qJq26tdkjIfqKyJ/OCjogPkqN8lIdHq1dsOebAwYzCW
	82HB8sSUJ/cKIlMjR1kacas75EN1ARN3Zdu2VIaSl+/t8XckPajpYRZqie8IWWD6DK8EU6g8Skn
	m9QlfUEvOe/3zedpJ/50sbbDhqe/j5IFT84Nj3LTaU4N4uc2IahD+Ha3FubVt4tH9rdsTT2DxLx
	depSMp7y8U=
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48fe60e13d1mr327492765e9.3.1779231906632;
        Tue, 19 May 2026 16:05:06 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm45197684f8f.26.2026.05.19.16.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:05:05 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	david@kernel.org,
	almasrymina@google.com,
	osalvador@suse.de,
	yuehaibing@huawei.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] mm/hugetlb: restore reservation on error in hugetlb_mfill_atomic_pte() resubmission path
Date: Wed, 20 May 2026 00:05:03 +0100
Message-ID: <20260519230503.121293-1-devnexen@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,google.com,suse.de,huawei.com,kvack.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249708-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 36C34585EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the resubmission path in hugetlb_mfill_atomic_pte() allocates a new
hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is consumed.
If copy_user_large_folio() subsequently fails (e.g. -EHWPOISON when the
source page is hwpoisoned), folio_put() restores the global hugetlb pool
count through free_huge_folio(), but the per-VMA reservation map entry
is left marked consumed.

User-visible effect: on a UFFDIO_COPY into a private hugetlb VMA where
the resubmission path's copy fails, the reservation for that address is
leaked from the VMA's reserve map. A subsequent fault at the same
address takes the no-reservation path, and under hugetlb pool pressure
the task is SIGBUSed at an address it had previously reserved. One map
entry is leaked per occurrence.

Add the missing restore_reserve_on_error() call before folio_put(),
matching the first-attempt error path which already handles this
correctly.

Fixes: 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage copy-on-write faults")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2:
  - Add user-visible effects paragraph in changelog (per akpm,
    required for Cc: stable).
  - Correct Fixes: tag to 1cb9dc4b475c (per Muchun) -- the failing
    arm only exists since copy_user_large_folio() became int-returning.

Andrew, please drop the v1 currently queued as 270157aef0d1 in
mm-unstable.

v1: https://lore.kernel.org/all/20260322052120.14021-1-devnexen@gmail.com/

 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4b80b167cc9c..c6dee98840db 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6270,6 +6270,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 			goto out;
 		}
-- 
2.53.0


