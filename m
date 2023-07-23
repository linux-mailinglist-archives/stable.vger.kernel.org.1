Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2075E222
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGWNsj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNsi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 09:48:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7CA183
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 06:48:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso26478485e9.2
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1690120116; x=1690724916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PN0I3mx5kl04z6d12K45HEUmzw2YyaJKMPzfeHMS/0=;
        b=IRFpxy3yCQOcujvFQiYo66FWbs1p+wUjTTQkvjVjq3Cwvsc7LeJ1vDoRY5cU/9iVlE
         KSJUOArODalFiVubQuHjppIGW9Z16v+bnuU95XC6XvehH4dwjC5UVP+SHHKNoyGBF6u1
         CiiYjQQnFqedUryLjnFbhs3Nt4KlJmLC3eFgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690120116; x=1690724916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PN0I3mx5kl04z6d12K45HEUmzw2YyaJKMPzfeHMS/0=;
        b=kv4nKq7wc8RSSAjWeDiFIPJJW5xsRFwGZ83YQsWefaT7Nfcvt+x2VLs3RmcmydegTq
         CvWawgHDh1UAfkm7a1ZZBhRlFkPxUzNJFhpooN1KtgddK2TwvapeIC6odfaay3d12nD+
         73/5/1PTdSWH18HmWoVvIUyWmkKkdxX9RsuBXkNt+UoKl6pz8s/EyHwFROyR87KRISBp
         GyYs/+YfEhneSK768UKLn0L88X7EF7e3FYhvBpVkMGAMHDLoQki0tf+Hm3WMD6L7Fzp/
         YsXIuk7D8r/yUgTug+fkvmqVGjHfMbGt9uuCu8KQe6iducFZt2lVDBj4zO4SjJFwAMQG
         1RcQ==
X-Gm-Message-State: ABy/qLZXurk+3r+3qSuIuW++b5u/vewrKhZFhEhQmA+3SCDFT6oE/iek
        oNlPdt0LwcGWiGN4bCHtgv73fg==
X-Google-Smtp-Source: APBJJlHcP7pcIybgBvAykQIxEsrxYu91K5BDP1h3nVdgLqIQdrKWEghLXIRhOuMyPvLCZ0lI428FTg==
X-Received: by 2002:a1c:f702:0:b0:3fb:739d:27b2 with SMTP id v2-20020a1cf702000000b003fb739d27b2mr5118831wmh.8.1690120115585;
        Sun, 23 Jul 2023 06:48:35 -0700 (PDT)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id s18-20020a05600c045200b003fc01495383sm10348021wmb.6.2023.07.23.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:48:35 -0700 (PDT)
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     leon.anavi@konsulko.com
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>, stable@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Petko Manolov <petko.manolov@konsulko.com>
Subject: [PATCH] riscv: Implement missing huge_ptep_get
Date:   Sun, 23 Jul 2023 16:48:22 +0300
Message-Id: <20230723134822.617037-7-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230723134822.617037-1-petko.manolov@konsulko.com>
References: <20230723134822.617037-1-petko.manolov@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandre Ghiti <alexghiti@rivosinc.com>

huge_ptep_get must be reimplemented in order to go through all the PTEs
of a NAPOT region: this is needed because the HW can update the A/D bits
of any of the PTE that constitutes the NAPOT region.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20230428120120.21620-2-alexghiti@rivosinc.com
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
---
 arch/riscv/include/asm/hugetlb.h |  3 +++
 arch/riscv/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index fe6f23006641..ce1ebda1a49a 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -36,6 +36,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty);
 
+#define __HAVE_ARCH_HUGE_PTEP_GET
+pte_t huge_ptep_get(pte_t *ptep);
+
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 238d00bdac14..e0ef56dc57b9 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,6 +3,30 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
+pte_t huge_ptep_get(pte_t *ptep)
+{
+	unsigned long pte_num;
+	int i;
+	pte_t orig_pte = ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_napot(orig_pte))
+		return orig_pte;
+
+	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+
+	for (i = 0; i < pte_num; i++, ptep++) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      struct vm_area_struct *vma,
 		      unsigned long addr,
-- 
2.39.2

