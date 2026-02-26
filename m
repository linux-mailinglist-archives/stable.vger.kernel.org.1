Return-Path: <stable+bounces-219818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LXYKPVYoGlPigQAu9opvQ
	(envelope-from <stable+bounces-219818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:30:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D481A78EE
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E763014133
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118F3AEF30;
	Thu, 26 Feb 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Z8FX2Hcd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD020DD52
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115350; cv=none; b=QQUTigXmrxtLb+J3q+0BIEDk5GtvoivjdFjA92LJoswntg5tjR+/GcLGssDMm3VOf+yMGhmL67ERz8fETFx+KiC99e+iLoJ65uYAxkjqQJNkiKHliI0nYrr5AQZbtQdB/k+oyC4DagiywapBpFVkY6L/ICHDg7whhedAftWpbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115350; c=relaxed/simple;
	bh=wewAWdVy26NTuoODuywZxXrcf+iJudc8CGVvVaWrPZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ATs81VxOxzeEilXu8PEwlOEbwyrvnTseELaXXhRdyS76vB3AjYqTAFjGbzMZNH/Y3dcG/wS6BICWF+zxDp/YNVyAIsM4fZgZIexkVLkktljeUW7ReE5xqjGlcqHKM93MNxFX3BfiBpmUUxMkZBlfAqnzkgVWSBkyPoSsxSy/KVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=Z8FX2Hcd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-827270d50d4so982369b3a.3
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772115349; x=1772720149; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9s+UpFhge3zc0ML4d1eIWQzLbCji6+36HhEypvv/XJA=;
        b=Z8FX2HcdFb8O5WXMrm9D8ZG4iwgR2ZbGw6fvll4P5XeiUXIr8rLvtm73qj93m7N9bJ
         EBQ5O9JrKNYY38FH15jbXlLtkc6bwb68cWqIOYzcQg9qRUtH6GLnwv+GOCdGiFbOPPtZ
         CDEzqRSrZarQ7ZlNyYteqwfbAXDmx8T2NE2ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115349; x=1772720149;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s+UpFhge3zc0ML4d1eIWQzLbCji6+36HhEypvv/XJA=;
        b=nPY2ey/Gi39JRuv5dNsDMpMmoXxS8vagUSxsuuPXrs0wbX7P+2HJ/y+iRjxssKwmyt
         HSyimokgcaTYmKa8IHCUfzWI8qxvzVmvjxJNfuyxt+AC76EZ9kIoJmp0VcHqA7iPziWX
         UPueD9wtF5mcmnaSeeeZrs78rI3RMvweyWz0/Wks0yjHObjUkRnsewc98MR80Za4iswv
         Sa80dVrSLjjg/85YpN/bUyWKv31HJIOULybM7XrM9S87naS4HUkxZFIRq6Pd4ceCj0qu
         oh05Tszx1WQ++UMqjgsn1t3dgW4mzEzwl7lr46adgqemkiNls3ctc21xPFetx6Cdg9jc
         xPYw==
X-Forwarded-Encrypted: i=1; AJvYcCXVLM3VL7hfoRi+2SmEYxCI3q8pKH091dh8KICmRkuh6IAD25drVxhQpskqMVfgCOBeu1BDEPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVNV3rUy1Boh106jbJy5i4hqncRkbQp3UJGOZNglkubjchy8D
	rfFeur/7UVR18C+L1Q3I3u3VCs9PlcJA/1DXP8kpJbfuJiPlPzuG5WVRxoTszq9OSJI=
X-Gm-Gg: ATEYQzx96GiySjmED4smx4GzbFx32PNvkyCFTab8yTJbV0Ohr+LB1tBqNShjvLKa8Y6
	7aEr4QxymfIZorDLwm+5nsc/FW3wGN/Am6VAp8fxgT/R+z45QmrLNZO6MimGb99BuzOk6CTpZpe
	LS7QLKTUffQPwrurP/tlTtP3317FB+YaAe3Bf2UvqezhsDw1Oge5aJkL3TLUmS1WVpvJGMvoxwd
	JFzfoo0OqKjqsaOK/BiR2ZaazUNRgBk62d7lD1IvY61JIdlMPyeC1cuBZJdbK8Zi9QiU7nF4KJQ
	Mhvm2XcLjQjEiqyvjqLy7kQu+Ea1epQgDfluA5TY9wejzGsqyS1VlCC2Gxf2svcbRmLRoK8AbLW
	08jhRuUz1bS66a5XTRKP5mqc6mR51H1qBWpHnKSxKBVmIIRCw/YkgSYgWzdDPdgBbd7zTraFWz/
	ksoVZ5IDdvp4dfnZafQQ==
X-Received: by 2002:a05:6a20:9395:b0:394:58eb:48fa with SMTP id adf61e73a8af0-395b47aa1b8mr2354656637.6.1772115348571;
        Thu, 26 Feb 2026 06:15:48 -0800 (PST)
Received: from localhost ([154.47.23.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82cf64sm2301093a12.25.2026.02.26.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:15:48 -0800 (PST)
Date: Thu, 26 Feb 2026 22:15:31 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/huge_memory: Fix use of NULL folio in
 move_pages_huge_pmd()
Message-ID: <aaBVg6nPQz-WvyzT@chrisdown.name>
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
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-219818-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chrisdown.name:mid,chrisdown.name:dkim,chrisdown.name:email]
X-Rspamd-Queue-Id: F2D481A78EE
X-Rspamd-Action: no action

move_pages_huge_pmd() handles UFFDIO_MOVE for both normal THPs and huge
zero pages. For the huge zero page path, src_folio is explicitly set to
NULL, and is used as a sentinel to skip folio operations like lock and
rmap.

In the huge zero page branch, src_folio is NULL, so folio_mk_pmd(NULL,
pgprot) passes NULL through folio_pfn() and page_to_pfn(). With
SPARSEMEM_VMEMMAP this silently produces a bogus PFN, installing a PMD
pointing to non-existent physical memory. On other memory models it is a
NULL dereference.

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


