Return-Path: <stable+bounces-146173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A3AC1E07
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF54E7158
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA77283FE8;
	Fri, 23 May 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ctx1TFa0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925F27FD7D;
	Fri, 23 May 2025 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987019; cv=none; b=PXofgVujxqDuJ/0UPMT0/06+Ps8f5pV+dlksLufSrpRQ91TyBpe1NFHBlba3pxTCn9f+sLdNqwVQMWr1bfbZB69jPytc3fYAiyHxDe+Z2aysNr39C8TJtrlJyQO1Uvm2yoCK5deW2L2Ph2EoMKIPKX81yOQtDuRpvOhoyxRxpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987019; c=relaxed/simple;
	bh=2Iq3z0X5R3bizHxa30uwclq6qACe1q2NN63KWDE86jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EDXs3B+k/B66JZpP/khFlXKb7eNIagX+6iOiiBPJZ5zFCTbpiSp7HxN0/auGv4V2r6sdMKcrR9NFzsqUZG2CDwljcvANucUkCR3414Y1YLgutKlSP1+2RStKAgYPBIM9QoprTdiwVaVIYEbljDHFRP5lX4NA6xRwDtw7gvFs008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ctx1TFa0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vJipil0cqUzIO5C86s9nT5sWioLswuLrRSkBtn/rbWc=; b=ctx1TFa098sAO70pCD4kM7Zwx2
	tEVOM954qdunTTATCokfjyAj36gajiC0F8OAvEuM3ocfsfh7p0DMg5gBefJaIp2rYreWN20POdHLF
	fifkUbsDWzfQoIs7lNfWHNN8V1ItcYs98XVvcAaWHPzhlEeVeL8h/YEsGsYKIgtBiT1GBkGXCA4Vx
	oWv8gwCZvugND3LMvcRytWoixEpKx9VVWZNJM4LBF6ZOkLRgTCQpR7dLeEPfTWxxoOGsX6SaqalXf
	J/EBfX0dTt7Iusy3QC/xZMdqfPTE2djQAb/SUqdHp+AOCjnux1eGjS9dbQYNCPM4+HRMAUeb3IDLA
	/EAMwg6w==;
Received: from 53.red-81-38-30.dynamicip.rima-tde.net ([81.38.30.53] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uINGe-00C54C-BZ; Fri, 23 May 2025 09:56:36 +0200
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Fri, 23 May 2025 09:56:18 +0200
Subject: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
X-B4-Tracking: v=1; b=H4sIACEqMGgC/x3NWwrCMBBG4a2UeTbQRqvBrYiEcfyNAzItE29Qu
 neDj9/LOQtVuKLSsVvI8daqkzUMm47kzlYQ9NpMsY9jP8Zt+LCbWslqeeaCLNPLnvAsbIJHQJL
 DwPvLTlKiFpkdN/3+B6fzuv4AICXyZ3AAAAA=
X-Change-ID: 20250523-warning_in_page_counter_cancel-e8c71a6b4c88
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Cc: revest@google.com, kernel-dev@igalia.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

If, during a mremap() operation for a hugetlb-backed memory mapping,
copy_vma() fails after the source vma has been duplicated and
opened (ie. vma_link() fails), the error is handled by closing the new
vma. This updates the hugetlbfs reservation counter of the reservation
map which at this point is referenced by both the source vma and the new
copy. As a result, once the new vma has been freed and copy_vma()
returns, the reservation counter for the source vma will be incorrect.

This patch addresses this corner case by clearing the hugetlb private
page reservation reference for the new vma and decrementing the
reference before closing the vma, so that vma_close() won't update the
reservation counter.

The issue was reported by a private syzbot instance, see the error
report log [1] and reproducer [2]. Possible duplicate of public syzbot
report [3].

Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
Cc: stable@vger.kernel.org # 6.12+
Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel.txt [1]
Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel__repro.c [2]
Link: https://lore.kernel.org/all/67000a50.050a0220.49194.048d.GAE@google.com/ [3]
---
 mm/vma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 839d12f02c885d3338d8d233583eb302d82bb80b..9d9f699ace977c9c869e5da5f88f12be183adcfb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1834,6 +1834,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
+	if (is_vm_hugetlb_page(new_vma))
+		clear_vma_resv_huge_pages(new_vma);
 	vma_close(new_vma);
 
 	if (new_vma->vm_file)

---
base-commit: 94305e83eccb3120c921cd3a015cd74731140bac
change-id: 20250523-warning_in_page_counter_cancel-e8c71a6b4c88


