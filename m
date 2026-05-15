Return-Path: <stable+bounces-247407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DScG3TDBmpdngIAu9opvQ
	(envelope-from <stable+bounces-247407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:55:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C426C54A2FF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9957309039D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBF63939BD;
	Fri, 15 May 2026 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TUDRmxeH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277323932F2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827863; cv=none; b=Z5gnHhYh0p1hKL5XyjZvKqa8YNOmwpHKnKvcwyW7/v+nSi1KLCJIfcbMzUVyzKHktHR++TqthgHpbABQUZTWX6DA8nFXmgLcvQe7ePgX/gKcwJ6g7CZjWzcH0dLt9RtYmOUsVOTEUkZDkSnNQjjAlVULHuf4QlM/Sl6+57aVrIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827863; c=relaxed/simple;
	bh=fG46zS+mEuG0ZF5WPcHOg/keWT+xuU43HV4g1r30VJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H/2kA8YzYAGvlNOn73kRAcAX9CYHKx/ndBrvTx/O+Cv1KTsAJzJFJ7QSGgI3U6qSxMDpy4bNC7RbcZwHNXhN71/Xc6u+JNuTN18yXUkNVg5YxDsrstP+R2XnO3JQfwsXzG0UB2qt3WK26nzJU/hYWNsHqU46PS1ylRE6zxMYSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TUDRmxeH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365d8e43759so273537a91.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778827861; x=1779432661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kj9jmbyJw9FvmITdQiF7/TYkM1yUzeyIU1nsfZGgTOo=;
        b=TUDRmxeH0eSGcj6DuGlfeG/8VADlRnZiU/WFS9ia35zKv1+Me+CwJkxZk5DYGFolit
         Ksq+NSNqFb2gWA8E93LpYj+abVOmp+Nci19Ol22IJJ2Tap0/zv7d7aoYKcLw/J/agzWL
         BRTMkLIaAZ+n8MKJCxybunyKn3p1XQviFV8clQgA+n1h6FKLwV93w+q1xsvjmV/Pg2Yt
         Y2BM3L8ozoPBDdYDxpoXTU2GpN6AXTT/50dQtMsP+EU+qhkBeIuEQ8wfrI/s17omj9MA
         41So92641eQ/AIvXPIajyBFR3KFsdVvoShfgE+s+KG8vwCP28AVPxhtYQYVaJ9v+o6fZ
         hGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827861; x=1779432661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj9jmbyJw9FvmITdQiF7/TYkM1yUzeyIU1nsfZGgTOo=;
        b=WFxydM+LwsIM4IGc7/8kD01bxZKZhPgULnKzRR1aOO9B0AqCpQ2WA+0kn/24NFxYPy
         xw7IcYA99RMuQDzrHaXa0vJjdDKwKEQtxUroI86DmluPMRlR6LtmR37HkyzA/jkuImO/
         iUxAMM5i9COhG5XSkmESLQkobIgNWDIonbs+o6l7nXI/7lNRMDKaTHQrguskhhLKPu+O
         VCR4zWkKK3kQ8s3opuvzN9zaN4bto/Q0meR6SaEfaUQCtPWOEOSRt7nD6JB4JxTT04nU
         ywXirkG68kMKRSLbMijw8w/Vs8J2mltG5+qRAF8+ZTdl007Hwf2tbD1LQxc7xkFFG9VG
         cudA==
X-Gm-Message-State: AOJu0YyJGgeEc6DOGRxk3br4Ze4758bHvNX6/3VQS9y3DqBcAYMj003R
	gvtZzDl9toVqfs+bWf4FJmS8UIyuDZNiv30MmOZyzk5QnW05F/XsI3LC1pd65KJgAjM=
X-Gm-Gg: Acq92OFn7ScphicjuNGCH6z8vPf11LVmqMDRryNnX0uCafUnsYXYNZJbl3sNId3EPA6
	2bej1eo12hlqsCDh3VvkocW7r+vWYSqqNpigQNRXDjhQadp/lN7rnhbcbVzaOY+JKTr6U4Qwz07
	H/0VEv6sAifSkg8riP7xYmzR1mUS69nhOm39WueEJ+UI733Bdy99D9aqdiI9l5vlXntWa1+FWD7
	cplrZLNbCiBYL0/uph/Jhh/6yVwGP0qcPpqp+nT4KgHE6JcxqChBC3QFS1wu52dwKGs69INj40s
	nKw/mOYid64yZM0An8H+5T6y0aQA8zG1OBokCANPAbebxB1U76fLZ3MsCybJ/1+Q3/cEy04CyBx
	4p3riCD6963IAVcS58djjcnY/U62mqNrLrmY+Hz6bZ2sJfd6jlNb7J35/9+Xgu6NCQOeXp+fCM1
	MwpJI0/oTHBCWryes2iNYlZuRGV38n5qs5hiJTpnj2VHP+urU1gYQsG9WUJeTPU+p8
X-Received: by 2002:a17:90b:4b8f:b0:366:5283:cddf with SMTP id 98e67ed59e1d1-3695149a001mr2017973a91.9.1778827861236;
        Thu, 14 May 2026 23:51:01 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm1734353a91.2.2026.05.14.23.50.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 May 2026 23:51:00 -0700 (PDT)
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
Subject: [PATCH] riscv: mm: exclude invalid THP PMDs from page table check
Date: Fri, 15 May 2026 14:50:48 +0800
Message-Id: <20260515065048.94564-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C426C54A2FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuiyunhui@bytedance.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247407-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:mid,bytedance.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index 1725f0861f6c7..88c599fda5779 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -1209,7 +1209,14 @@ static inline bool pte_user_accessible_page(pte_t pte)
 
 static inline bool pmd_user_accessible_page(pmd_t pmd)
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
 
 static inline bool pud_user_accessible_page(pud_t pud)
-- 
2.39.5


