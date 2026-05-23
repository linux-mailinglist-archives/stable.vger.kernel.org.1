Return-Path: <stable+bounces-253884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gXzGGjwrEWqniAYAu9opvQ
	(envelope-from <stable+bounces-253884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:21:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326E5BD1AF
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F11633002D3D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40028C035;
	Sat, 23 May 2026 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E44O6uwj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932BB672
	for <stable@vger.kernel.org>; Sat, 23 May 2026 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779510069; cv=none; b=LhGgdY7FOq6MZDpSUw5TIto9rvYf1nMWdpCBS+mDR09VtiS5HM2EC++rBILDdkAzPMkxOg8esDpAkVP+NMthGsqsmulVS4WVeZRP0FEtrI5h5nbZ0hq3KCjTzvmhepZuT7iEE/ZZtsFHCYGIu0w8tqKs1EL1lITwjWjDpWNSUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779510069; c=relaxed/simple;
	bh=mVg/T5HYjgFU7eMUwI0GAnZvdunIU8AoQenlq8cq08I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0exOoBBN9fh278HHTd0RYNl5wfLmBbpW/yHS1GpgCmZsLDy+8B8Bx3aO4qZGtK4dZDrOsSCjWTP8EggOAfP+WVhXhADhNnZGnkE9J+Uo+gWBvivNpFFK8JyOGfsg5Q1zbKNeNyR8XSleRd3ULgEd2XShHuf50+Ub/eHHPyLtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E44O6uwj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c82a6278a4cso6126500a12.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 21:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1779510067; x=1780114867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/Sl4PO82ChheiWAx9Tl91kUcgmggvPPYrF2yLqTz6g=;
        b=E44O6uwj+ddFa1TjEyWnISGASGMHIecuy0ONjCTTso9DH1oC2zgkJuYz4eUbRIlBhD
         kcjmYa/s/9mj+scU4mjmQi5pZqqND2C6bFaeA8yX6Tu8GWGia3jL7QfT3wRIeFNLsRPt
         Ueyi1o5daffXK9p0JA1JsTJLP4+LSiX+UWU2+/kKn8dcM21e2/Th5sqE+rhj5U5UBKyc
         8Kp3uW9RpxxSBpEgAhs8ak12EJQqXsgDLVzzo3hfbGovsxLpREBDyekzZt+YINKPosDO
         j2oN2/CssFf79udiu6uZYLFnsqU1kXXMDH+HOQAt7LCAL+sY0kqv7tcYTFDBhJk/Ma9A
         DrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779510067; x=1780114867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/Sl4PO82ChheiWAx9Tl91kUcgmggvPPYrF2yLqTz6g=;
        b=T8CF6hpTW27f16CoARbyUbkcOF+pV3vnNGh9u2W22HCPIHMWFBJoPmNPB7AqY+7s/v
         TrZ+1wVaPcurZhf1QLFRa4FpKwLdU7cWGT9IvlFpIkKm9LOy1SiI/tFHcrTOEwq2WIVy
         mfAnbgZo6kMyw2Evp797J4nWuZw+Vm++80o9sSHLJkEyncubOBJEwMDMJ7SoDFQdSy8S
         x4nlJMPHgsatPNn4TS+qjx5xcjt2MKWUtIzPoczuZGwBdyCf3N04vE8Upo7tmU6Os4zs
         sZqz6J3gTHJpgTcwEZvgNkJBIqGMKvskIFhEi3Agj/NWNNYr4F+c7ViK/0Y4EaOrHrtd
         /QkQ==
X-Gm-Message-State: AOJu0Yx/GwTWibhclUJCl9cqfBQ1i8xP/Wze+/u31iktlqqDI1mKjUwu
	Ugu655BwtfVCh/RY2BpNc+kp+5YOyABwecq4ifIHRGHfofsNjQySdSpo8zBG3EZPDco=
X-Gm-Gg: Acq92OE95JoZCJCo02tTaAYltRGw7Sad2BhqFE/dhN0NF0/mPoQJts/AxwSiFDD8OKr
	god4XTurRmi3Y3s5eJjv+T3vLoJWXo46ENwUKwz7T54+ruDZERhpxO/BClDhKIT8oY/WgDXRbgr
	VXsjdB/m3frI+sd7xGRDi5uYfBKjmfuDv7i8bBsbPv3WsJPed3yBhLP2taYgiwbTSc4hKX5DsNe
	OobvhUdN9NEq/Pr3Ac6lWTZ3mFla17YbZAtbCcE/nggVet9zrLJhHsu1NkoMf2z0nOfaCXviYT9
	C3ua21GNNlf4TINLhcEw+Y4a2BbFqa5ZN3XSvSeEp/DL6cbwJ1/ejmE20FQlg4QtOCBC9TrKNMw
	0dxtK49APegGGXdmaBHugIRZhL2opmg4A0Nc29p2eEcorf9li9tiNRfKHg/h3i7EmG4TBkSnTpF
	zl+LlHSaf62iziMlKLRwLQrK7YOa5YNUEzKeh5rp2BLi8KjQ+cBeU8OOo63yi/FQ==
X-Received: by 2002:a05:6a21:4d8d:b0:3b3:10e1:a883 with SMTP id adf61e73a8af0-3b328f4a760mr7138152637.47.1779510066555;
        Fri, 22 May 2026 21:21:06 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8520561e94sm2962104a12.22.2026.05.22.21.21.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 21:21:05 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	tongtiangen@huawei.com,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [RESEND PATCH] riscv: mm: exclude invalid THP PMDs from page table check
Date: Sat, 23 May 2026 12:20:52 +0800
Message-Id: <20260523042052.35476-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuiyunhui@bytedance.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253884-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Queue-Id: 7326E5BD1AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RISC-V THP splitting uses a temporary invalid PMD state where
pmd_mkinvalid() clears _PAGE_PRESENT and _PAGE_PROT_NONE but leaves
_PAGE_LEAF set so the MM code can still recognize the PMD as a THP split
in-progress entry.

That temporary state no longer describes a user-accessible mapping, but
page_table_check currently treats it as one because the RISC-V PMD
user-accessibility test only checks whether the PMD is a leaf and has
user permissions.

As a result, when a PMD-sized anonymous THP is split during a COW fault,
page_table_check can account the invalid intermediate PMD as a live PMD
mapping, and then account the replacement PTE mappings again when the
split installs the PTE table. This leaves stale PMD accounting behind and
later triggers page_table_check failures such as a non-zero
anon_map_count when the folio is freed.

Fix this by tightening pmd_user_accessible_page() so PMD page-table-check
accounting only considers leaf PMDs that still carry either
_PAGE_PRESENT or _PAGE_PROT_NONE. This preserves the THP split semantics
required by the MM code while preventing page_table_check from treating
invalid split PMDs as live user mappings.

With CONFIG_PAGE_TABLE_CHECK=y and CONFIG_PAGE_TABLE_CHECK_ENFORCED=y,
tools/testing/selftests/mm/cow completes successfully on RISC-V after
this change.

Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
Cc: stable@vger.kernel.org
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a1a7c6520a095..ecea48affd7aa 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -976,7 +976,14 @@ static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long
 
 static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
 {
-	return pmd_leaf(pmd) && pmd_user(pmd);
+	/*
+	 * page_table_check() must ignore THP split invalidation entries created by
+	 * pmd_mkinvalid(). These retain _PAGE_LEAF so pmd_present()/pmd_leaf() stay
+	 * true during the split, but they no longer describe a user-accessible
+	 * mapping once both _PAGE_PRESENT and _PAGE_PROT_NONE are cleared.
+	 */
+	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) &&
+		(pmd_val(pmd) & _PAGE_LEAF) && pmd_user(pmd);
 }
 
 static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
-- 
2.39.5


