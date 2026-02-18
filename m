Return-Path: <stable+bounces-217210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOCmOsQ1lWnfNAIAu9opvQ
	(envelope-from <stable+bounces-217210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:45:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEC152E29
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32ECB3032051
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E32F28EB;
	Wed, 18 Feb 2026 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="jvTt5FML"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2132E62D9
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771386303; cv=none; b=uKkxZyaSJNTz0Ik+jo5VWwq5UmlyfU/IA1fwLHENeXJCz/E+KkDgsdjwe7KzoAjt+LtcvtCKVafI6WPSbjUIdwIDcXJ6vlQ2/5T5E/UXs6SWjwQy+nT2skwMOBGwHexG8ENnaUtwIzE8ARtwCx7G7ySsSz7piS3PF2bHkQ6A38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771386303; c=relaxed/simple;
	bh=rNmCxRaZrL47s2niGfkvdqO2nlBKiWdDYvrmKiWxc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j9AZeIppdr3rC/CrZ6e+uclq6v1x0BGAZADcPyTLmBv3VxPa2WFKRRfcKGq/FF4LceaMPOikCEFuC0tuhWeyFuP2EO+HTGGSzw0BBP9gGd1ZrctLs5S84T/TeI+fEnivceZM99jzMXlmMYQmLixgtVS+uUDzqOQz7xNb+M3AJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=jvTt5FML; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a95de4b5cbso44633825ad.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1771386301; x=1771991101; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJWFOiWF36F/VYxYvq9ObLBGauZxL9efpCybptIgmjg=;
        b=jvTt5FMLDkZanx3CdPU6R57rdBJ6tBfsh53TTRBJ1rwgLlqU2IWmSnRC1Gc+XxNgY+
         e1bn8AhO24Zq+yUFh42LJ69ur7ONR5NqrExVDsQd9TrUSlB1ZjGkEeC/YfjTQbdO7c4p
         gJgiLu5QbHpeAmSxoDBttdP+QVXKcnbxX4xjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771386301; x=1771991101;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJWFOiWF36F/VYxYvq9ObLBGauZxL9efpCybptIgmjg=;
        b=hqecbdFk3GTulGv/uBdPCg01gONoLVMwplHRnufrDLrVUOqhYfD7aRd5vs+nQzUQDs
         CWI0xAkUuFBPBeqx7tFibQiuALRBDlrZIMx+PiD57qLgqsXoJWtTAntkQHxiyZB1IXoJ
         W6ICslHYcjoXLV67hOHDwMomxhpS+mr3kS/CDJW3oryqHBpatKa3yqH22v+FCObf4p8f
         cJ1MS/8YOKNP1Crqo8wphWe05YJ/WjxskjVnE3TvGuiiHXyl2HAUeW4Ev6AWqOJez0zX
         YnhZsoDhmk5vMqeguxKPaShYkQPFUPu5xYLNXo5st7u2tUinXR2aFWrEfyvBFqm4Fb/W
         eHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGLy1ytZUzd1j9XB78Jsmnl2EwnvYnUKzarLfCZMpf5Al+UGoEav+Ohx2A7KvuT5qcXPx8Vzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpT2dbxPpwoclgUpGB6c3apiNdlKaivqNTC7VI56Y+O/HyH5b
	UyectO4ko2TeSpI2xrYpMXXzCZNPhyUg9yQR2HW/x2pm6/wG2zSQPtQ5El2oyKtzrJ4=
X-Gm-Gg: AZuq6aJN+1U8CSNJa7GVK/kxaiFUvkI4+7RoivVer1AaM6y7ff9sCe9OR+lEbf8ScCu
	nvNhVKmgR8jZ2733T3etyRFfVMo3VaJOETqZ+HthXVBOIGO8RWEQz5CWEmemzabRtcolzmD9kpk
	p5Idu2Mu0M8nbyaJI1Ly4qsQQ90nM7QNvIeGgyxzN4hITDIkO4kebngav2dD3RHkGUbPm5rTKWu
	OJ003/ilwYQJkOU33hxEoD55yndyaYUYCIHLTcjANr6gx+JeIjQquzNTBxrV2Zycxm7NfloRIQU
	vFPe1xjyS9sbzx9p3aL8/CccZUJW0u0x0MD66GBHvEBljnThhmK+PXKR9lYWoD1sohfq3ZtFVZy
	rHyo4anjY3NK9Yl5j/wjge1KvvvRlBZuHgaMazN5t6OjJBScqLkLnnSXPTl1q2BIMq22HEbDuAv
	ryQtbZT1op/eE85fekp2Rm
X-Received: by 2002:a17:902:f60b:b0:2a0:bb05:df4f with SMTP id d9443c01a7336-2ab4d053111mr152329315ad.44.1771386301369;
        Tue, 17 Feb 2026 19:45:01 -0800 (PST)
Received: from localhost ([175.139.248.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d58e7sm118526155ad.45.2026.02.17.19.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:45:00 -0800 (PST)
Date: Wed, 18 Feb 2026 11:45:01 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/huge_memory: Fix use of NULL folio in
 move_pages_huge_pmd()
Message-ID: <aZU1vSmn5aF8xvJj@chrisdown.name>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-217210-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4FEEC152E29
X-Rspamd-Action: no action

move_pages_huge_pmd() handles UFFDIO_MOVE for both normal THPs and huge
zero pages. For the huge zero page path, src_folio is explicitly set to
NULL (used as a sentinel to skip folio operations like lock and rmap).

In the huge zero page branch, src_folio is NULL, so folio_mk_pmd(NULL,
pgprot) passes NULL through folio_pfn() and page_to_pfn(). With
SPARSEMEM_VMEMMAP this silently produces a bogus PFN, installing a PMD
pointing to non-existent physical memory. On other memory models it
is a NULL dereference.

Use page_folio(src_page) to obtain the valid huge zero folio from the
page, which was obtained from pmd_page() and remains valid throughout.

Fixes: e3981db444a0 ("mm: add folio_mk_pmd()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 44ff8a648afd..fed57951a7cd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2794,7 +2794,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
+		_dst_pmd = folio_mk_pmd(page_folio(src_page), dst_vma->vm_page_prot);
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
-- 
2.51.2


