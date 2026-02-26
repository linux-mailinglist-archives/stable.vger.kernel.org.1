Return-Path: <stable+bounces-219819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGa6Ci5WoGlLiQQAu9opvQ
	(envelope-from <stable+bounces-219819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:18:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990211A75D6
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0F6E30501AE
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E663B8D7C;
	Thu, 26 Feb 2026 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GihduFFX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897F3B5305
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115418; cv=none; b=cxTc3ZKKvaF7cVOi3SVoyGXZNZMEkRz1liPEO1klRJrgBl9nbqkMCL4pIGg8inKSPlnK5uMPyXj5ks+XC5VQVCJqqCPMjRzph5jwRTPXc/mkGbtt+MUf3BsJwRu0hG64lOg4kSxuiVZVn9nDLr7ms7KH2Q+N9Nz2hmQ5rxQfkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115418; c=relaxed/simple;
	bh=L9aKGOPdtAWsjsZS+OCQqYtLmBuOWxIu8s84aw62qLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q3U8XFVbubiKtoLl9RMmxR1EddivTYRMzIzkzgif74q7yF9Jk1o0qrGTno0GjS6tuHLb3rLTgLafCtOW7ydDNRABW4gwTEE3haxrVWMSlxyfr+vI+r0T28Iw02EVELqE0YnYRsiK5crP3MofO0G/4BXJNjaMDZSJtTET2FLRDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=GihduFFX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8272c559597so899375b3a.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772115417; x=1772720217; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNAD0DboxzMSBQ7MXxoHQ/ZEV45aIr2CHYOKdSDYsjc=;
        b=GihduFFXF6Y6kLyPgB5OT219gbA/DCULyrfXNqGSkcHzCikDomBGS9IdBbJPdYCpmY
         mPJUgAu7GLt8FX97DCIBRtVVrGDGiZ+HngfDRLr1mt2oL4ddQ+38/9UjV1pq9lUGV4vp
         iYKDiXicAGiM+JkRCvgoVnQwiSnl17MnPSBao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115417; x=1772720217;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNAD0DboxzMSBQ7MXxoHQ/ZEV45aIr2CHYOKdSDYsjc=;
        b=D9T0O48iBhjn+jIeM7BnrHEsY6EYE4+7sPuWwxSzf8o/xCyDMXdeDJtUjXswvsyjS5
         LDKoKmgpiij2arfyfQ8PUeIlKAH7n+ALQN8igOb45eNk7OJ4gzxoSj+OqLE+mUi+ISge
         mKRQPlBjbBSMO5F4fc39lNPW4n7uus4JiY0r5qTD0F64HJttgb9DicGr8XYbfFIJxt7q
         ahVjWTXi6lPpMwI1/22dH3lnWsloX7IhyLbktm6uMLJcd5djpvv7WWLMxih1mR7j9ljN
         lySs7UQCnKS0hWDaTN9XeUluxH5Z/jJC9cwX5XVwmT4/nEL9X4YKYTC4oZpZ6mZTj1Zc
         u2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv7NifiLjeiKe4/7hjgQvhEOEQ0b+7JypjF4wCSwZpCkGJ9TBrdf+QHYrgoV5GC6b+jf7/7z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIUdk2qwA3xfk2b8fyNnM8fp3j6A5NbXL9z89kH/H505STZ0Z
	6Ch5W5s8qXTY4iis6duv0rE4DX07xFp5H863hkHZIdSvZ7fyf/8IuHmKkwfdyDMemJk=
X-Gm-Gg: ATEYQzw5VehXtdVtz4vnb0leFHfkubewhjnkyQRdg16OvEnYSWs+O0jdEobC2p9H7KS
	Z8yHPKIvHAGDe2nxGEVmS/I9NYJhMozHGmUgpTOJHLXAl9r1ONNNL1NewzzJD/b2b/9g042ZE6R
	z6Nkt4ETIiPpqxVLSeMuPG0ZDzdpgDPxiQkQ9/xma2g20sgDcYxXJc5pHIqPmkxbJBtqgXqJqcY
	XvL1xKaVW4R5AWHJ4FejGto8kEgw2y8FSfy/WWv7BrcNgQP0DIpMP+zrpWEgFjkzY7q1M07E8Dp
	UYoJndrdYHwySSmCHvE/zkvubNrtLeG+jt3Y45DTyHZiJb8ClJAb60O9HM7rEjYlJKUcrILS20i
	IJgt9xmiDmdMe7XE/aZTEwn5SQfcarnW9kR7g79uiumteG8ItKBNMUEzVB4a/XYTS/mkw3zfsTe
	L8l2qXTa9jfeKJ56crQQ9NX4rDFj8Q
X-Received: by 2002:a05:6a00:4503:b0:823:1212:8e87 with SMTP id d2e1a72fcca58-8273bfa1f7bmr1954788b3a.32.1772115417192;
        Thu, 26 Feb 2026 06:16:57 -0800 (PST)
Received: from localhost ([154.47.23.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ba6275sm3012040b3a.0.2026.02.26.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:16:56 -0800 (PST)
Date: Thu, 26 Feb 2026 22:16:47 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mm/huge_memory: Prevent huge zeropage refcount
 corruption in PMD move
Message-ID: <aaBVz7eb6-VBCvaz@chrisdown.name>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-219819-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chrisdown.name:mid,chrisdown.name:dkim,chrisdown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 990211A75D6
X-Rspamd-Action: no action

After commit d82d09e48219 ("mm/huge_memory: mark PMD mappings of the
huge zero folio special"), moved huge zero PMDs must remain special so
vm_normal_page_pmd() continues to treat them as special mappings.

move_pages_huge_pmd() currently reconstructs the destination PMD in the
huge zero page branch, which drops PMD state such as pmd_special() on
architectures with CONFIG_ARCH_HAS_PTE_SPECIAL. As a result,
vm_normal_page_pmd() can treat the moved huge zero PMD as a normal page
and corrupt its refcount.

Instead of reconstructing the PMD from the folio, derive the destination
entry from src_pmdval after pmdp_huge_clear_flush(), then handle the PMD
metadata the same way move_huge_pmd() does for moved entries by marking
it soft-dirty and clearing uffd-wp.

Fixes: d82d09e48219 ("mm/huge_memory: mark PMD mappings of the huge zero folio special")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fed57951a7cd..8166b5e871ad 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2794,7 +2794,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = folio_mk_pmd(page_folio(src_page), dst_vma->vm_page_prot);
+		_dst_pmd = move_soft_dirty_pmd(src_pmdval);
+		_dst_pmd = clear_uffd_wp_pmd(_dst_pmd);
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
-- 
2.51.2


