Return-Path: <stable+bounces-219817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKqUAIFVoGlLiQQAu9opvQ
	(envelope-from <stable+bounces-219817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:15:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC51A74FE
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3640302E0C6
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853043B5305;
	Thu, 26 Feb 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="auAcNGba"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982A3ACEF0
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115314; cv=none; b=dvFMa01Q3ZJWIydLcVqVij5rpZo5QjyrgZDJEwy+rp1T6SDJhCxkaFyFPkfFpsojcGqGqwOFYSPrVxdxxCGgxhwjM72KlDlSOjz65SAYJOF7Wl6Qz/z7Z7NMaGJ4kUl1DBc7W7ZuwRd7i7ckw5juMGV3L2NXZyILrXIM/rZRFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115314; c=relaxed/simple;
	bh=fAV9q3PRVVSAs45bjKEg29Ft0mUObDJosrrYhqpDFo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eKnB/9zIHk0YKDWewgGAkUfbTTKZqyh3SCAkGvCVGShc+RpGdlpa4WDfqQCTh3IKnMKc1l/XXsf1TyOO65YVz/yhlsYkpBiOyYD5979vS29GSECYDly2iBO/4mi/OlnTpnpm+MO5UIyDKgrNjTEIFQILzlu7zoKdSIC6L6PLdTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=auAcNGba; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8272ccb554fso788970b3a.2
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772115312; x=1772720112; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FQ+7uigzhY0D9bUb7S9byYQ1qGUM2ULqVMWKZWoKSI=;
        b=auAcNGbaRQONiEC6YkgKXrnq3CztMh6ySQkFkyFX+OWTxejvLwqs3mbVo3xqNFobAo
         J9DzRRPIj3eUIoaM/et6uTQtrXsOSVKuw5A+/SPWQMEexfuMAC68FA64HlIIXp1BaskS
         2unc/mgZTWtI1Oeh688KanCmY63y460M4OnJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115312; x=1772720112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FQ+7uigzhY0D9bUb7S9byYQ1qGUM2ULqVMWKZWoKSI=;
        b=tjQJ+8I5g+LB4otDDvkDt8DvPPAt//3NFvfN55BYt33yt5om9C/kmkp8dd+nrA19/+
         kZTVFIf5a+tkFw2Ji5CbGU/Se6HqkWEtb4SE7LNkkbJKX9SbVzZ0WyCXifhJnS/aWi9V
         ZMOkR376cgp3L1GkHn2w+5yXE0xuc9VDtAsHCZ+xFPy3zzVX7piWE89qW8qH6LTXkcE4
         GLKCRTZzhOxivUz1X+0E08f7/N1EuU5WVk3H04Y3HG0vuhAEZeLBgSNRyugyfjRoeegB
         8PzvB5UjqsAIfYiI9mja+rbi7oUYQRuXNnnZcDgyX6F8BC1yYNbKFb2E7BUEbpCevJD2
         UBNw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8FivRz7I995K5YBhGw8XCrtDEKnS4EE/0xN1alED0+DIzE2fWEn+QZklP65+3dvOvjvp518=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+o+lDDRz5Vv+MRcn+E0ix1oRk701HfXqXRj1mjtOjtPS99dp
	xU86w2675v4ZCSJjtzzpy51uZiA2XpCTKjlEskQ4k2IUjOMORueIgDTsd1r/1y4jYDvuqWHKUVL
	r3f6FJNK5JhSz
X-Gm-Gg: ATEYQzwd7q+Nf46GmwI+RjHKJg9lQwc7ZSq6BSLBubvcCKqqdK8R4S4dgJ762WXsDeN
	RMyWChstzt1wHExFtR8jlYyWGZO2vknjimHinkDY1k78rYAoVUrva5BTfKyceczPONdktzgoBB1
	64ueost0/kCamsn3mEsIkms6ofWNdoGgJR+0kjJQ2QbRFx8NMZb1EfbnPZGPSJIWBfYAlrJPMPZ
	xea0eTXjpkMEiKo6NvP3CQYSRY1B5ReVt8tX0ugZetoUPpw/dgnXGyjKFBBG298pEL42GMQUBKo
	Oc9CUuDzLe3i7r/goi3gLCCitROG6WzwHV2wZR6dbRi30QQGeWU60hkxT8i8aZzOxHC7X+L4Cey
	ZIwKwsWHVbCm1AA6GshAyMvMBUG585hzZQrl6EjpZUJjDFvsy5j6iQXqk+M5TCd39V7rnRM1p9i
	2kMprV7dR8vp/81QlJLQ==
X-Received: by 2002:a05:6a00:439b:b0:827:4526:50d with SMTP id d2e1a72fcca58-827452605cdmr1182006b3a.29.1772115311913;
        Thu, 26 Feb 2026 06:15:11 -0800 (PST)
Received: from localhost ([154.47.23.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05e831sm2569799b3a.58.2026.02.26.06.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:15:11 -0800 (PST)
Date: Thu, 26 Feb 2026 22:15:04 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/3] mm/huge_memory: Fix move_pages_huge_pmd() for huge
 zero pages
Message-ID: <aaBVaHs8rIkNcwM0@chrisdown.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.15 (2b349c5e) (2025-10-02)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chrisdown.name,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-219817-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chrisdown.name:mid,chrisdown.name:dkim]
X-Rspamd-Queue-Id: 69FC51A74FE
X-Rspamd-Action: no action

Changes since v1:

- Reworked patch 2 per David's feedback to stop reconstructing the huge
  zero PMD and instead preserve PMD state from src_pmdval, then apply
  move_soft_dirty_pmd() and clear_uffd_wp_pmd().
- Added regression tests.
- As a side note, I've kept the two mm fixes split intentionally for
  stable backports, even though patch one immediately gets superseded by
  patch two. The reason is they track back to different commits, so
  although patch 2 rewrites the same branch in newer trees, keeping the
  fixes separate preserves the correct Fixes: annotations and lets
  stable pick the applicable fix for a given tree.

---

Two fixes for the huge zero page path in move_pages_huge_pmd()
(UFFDIO_MOVE).

Patch 1 fixes a use of NULL folio introduced by the folio_mk_pmd()
conversion in commit e3981db444a0 ("mm: add folio_mk_pmd()"), which
replaced mk_huge_pmd(src_page, ...) with folio_mk_pmd(src_folio, ...) in
the huge zero page branch where src_folio is explicitly NULL. With
SPARSEMEM_VMEMMAP this silently produces a PMD with a bogus PFN, on
other memory models it is a NULL deref.

Patch 2 fixes huge zeropage refcount corruption after commit
d82d09e48219 ("mm/huge_memory: mark PMD mappings of the huge zero folio
special") by preserving the moved huge zero PMD state instead of
reconstructing the destination PMD from the folio. This keeps the PMD
special bit intact on CONFIG_ARCH_HAS_PTE_SPECIAL architectures and
avoids vm_normal_page_pmd() misclassifying the moved huge zeropage PMD
as a normal page.

Chris Down (3):
  mm/huge_memory: Fix use of NULL folio in move_pages_huge_pmd()
  mm/huge_memory: Prevent huge zeropage refcount corruption in PMD move
  selftests/mm: Add UFFDIO_MOVE huge zeropage PMD regression test

 mm/huge_memory.c                             |   3 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 176 +++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)

-- 
2.51.2

