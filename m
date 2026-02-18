Return-Path: <stable+bounces-217212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOWcNhA2lWnfNAIAu9opvQ
	(envelope-from <stable+bounces-217212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:46:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3E152E4F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06E6305D6F3
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 03:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9E2F1FFA;
	Wed, 18 Feb 2026 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ilHGQfyK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EB238C23
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771386325; cv=none; b=GHCzb1DItLD8MznDPhij2FDQxoamfjD6Grvq4kPwXCPC4bmkJZOlkS1JRsR+nunKzdVwnZNVGOKQvM/ccSHK1cOqhNi3d5XOsOwvPO5OIrQhJ+D+6wp1UezG1A/8m1L5VGXpQggxSG53Oy/hRJkdDQce6mdHWMUvmKKoqzhRq/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771386325; c=relaxed/simple;
	bh=OO+NigkBMF0SIS55og3IgmJ9tMZiAHxJ8+r91x7X/T8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LZgX9AP9Fvgr6XwdOY/1b4sJd/DzN/t0kWVEJYNAbxIJP1npl/sytlA9EUZITCdKDKoKA9DPqWToOlUAZ6+v4QF9YYMNDRmNXtZOPRkkH4K9K0B+vHQdZ5tTe4LuyRCalKAgBqs1fVyVKoCIYI/jaDonKhP9HGPka1MBEzMrYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=ilHGQfyK; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7bced39cfso50291685ad.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1771386322; x=1771991122; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrPqeRMVexCnZ04Cs9L6s3qrPGGSz8yolplFHjrk3wU=;
        b=ilHGQfyK+y03AcOihhMZVFnzmsc3wH0Lju3VYANLul6ICCdVp6z62iwzX8eo+434ma
         OPUWVlu7jJRtDn0XCNwgOI06ByeUImw4Wf/IpQ/3tHwbOHEvp3KI7XlmKdRDSg9Zr7F6
         bBJSXY2Mqb0FcqWbxSXlBliCtQB0xDxf09+kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771386322; x=1771991122;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrPqeRMVexCnZ04Cs9L6s3qrPGGSz8yolplFHjrk3wU=;
        b=tfr7a9eKuPRCo+b0PiFl5fnVdBfODWry5qHYppyx8MaSZFq5IQQDAiWdihnofhe+Pl
         aNQW8G/9aSw9J8ZndrgHVrQ3Dwv7hvh6v+m6dIaOlbbubfDmqq9W/dv4WKW3kZ3dxGZK
         VrdsJWHEYMDc72YptrrSvsn3oVOXSjNzWtTapMuCokq5y/sQrJJGGfi9A41g1OFR82bS
         SZ6kyPDqwt6bLzlbighfXD+oQ0XD3gbagJnvhnEGxQ/8tpB4Vao589Vyp5ZmkKBDUzwp
         qkAiRJd1YSlcp5IhkvBd32XD1PMNDveO9Qa7ElKaRB6bq7lRj7SxJc5Klgv0scBvXaM5
         0rQg==
X-Forwarded-Encrypted: i=1; AJvYcCWfVOD5DuBj88WeXl19Sq5vQpnnWDGDljypimcspb3L/wsuDyR9a21cufzfL+dm/WgWvbMI2Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynarJPltICKY3jtwQwJXpPFtQsssoOz4L/rZ9g3vWvbdjMqImV
	7oN74Q4VgCrLbvIq9UFvytlL+TyakLzbDlT1sLj0wrilY9TUmQENzNBPHk4+PuYgEKA=
X-Gm-Gg: AZuq6aJ0WEebR9Cva/RCMbvxijseMaMZEQzgX39NxN9syhW3vY5a9n2sG3mTcy2yUt9
	h00jKx2bV/oU+sVJRczTn5L7gCSD1VzZf9SgStd+LtoG7jj3WPi+K43WD7sDvDp5uvLdV0xYNh3
	srpc20kbJYx7rGklLt874FgdQcC90a7I2sINnpWtJ/5NyIN9mtWpFuq/1ycjo2qDwe7wDaLGKVC
	OfARW/f4jJ4DfmkGv6+R4KzFHaDhuZDVet37MyEK2uW8yPlDgRPoPXfQebyEr0XuG8/8jLgKzTA
	vmUemLl+wbmsyvMN1qcTZlexhGWJCDRLV7VEpi7vyqFuys4nSmovpeFJ0ZiSvp2xHqyOKfodAk0
	2mk1JtARjzARgo5zGSCStVUnOt58LbIc/FReaDvcWe2OUcKi0B2b3cXSdISJUE53ScOBUKkc/11
	SPhVgLBEeMGIQEutGnQSux
X-Received: by 2002:a17:903:1c9:b0:2aa:d6d5:773c with SMTP id d9443c01a7336-2ad50ec36f5mr6655225ad.25.1771386322192;
        Tue, 17 Feb 2026 19:45:22 -0800 (PST)
Received: from localhost ([175.139.248.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e3f54fasm19644387a91.0.2026.02.17.19.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:45:21 -0800 (PST)
Date: Wed, 18 Feb 2026 11:45:21 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/huge_memory: Mark moved huge zero page PMD as special
Message-ID: <aZU10aBZxCHfmjeB@chrisdown.name>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217212-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chrisdown.name:mid,chrisdown.name:dkim,chrisdown.name:email]
X-Rspamd-Queue-Id: 57F3E152E4F
X-Rspamd-Action: no action

Without pmd_mkspecial(), vm_normal_page_pmd() on architectures with
CONFIG_ARCH_HAS_PTE_SPECIAL does not recognise the moved huge zero page
as special, incorrectly treating it as a normal page and corrupting its
refcount.

Fixes: d82d09e48219 ("mm/huge_memory: mark PMD mappings of the huge zero folio special")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/huge_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fed57951a7cd..5f908cdb11f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2795,6 +2795,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	} else {
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
 		_dst_pmd = folio_mk_pmd(page_folio(src_page), dst_vma->vm_page_prot);
+		_dst_pmd = pmd_mkspecial(_dst_pmd);
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
-- 
2.51.2


