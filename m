Return-Path: <stable+bounces-44843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00B8C54A4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C871F21479
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1A40862;
	Tue, 14 May 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMha5daI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB447F4B;
	Tue, 14 May 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687337; cv=none; b=gDg6aeCnVjUs7GkTSNZdYmUIlhAWcBTRClfCwiuIIv+QJZrzcIOkqujEQRDZSoAeIv7K+Uh2ibwMheYL7JjTu4Qx5vIOwgH+8LzIWRFZPdGUFDph1q3ec2ui5mO/rIccbfBRvcjE8OcaiG7Y3O9K+AyimSHGe+u4rqFW6iMSCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687337; c=relaxed/simple;
	bh=MKA2MYFVyNCeV60E123SOfPmN6v5KCyp9aYEbVbZ4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyxxgPAdDaiAaxktKF2IHUNLpz+xNTB1L81Le3Hu8EtkNzSxeTKdSiQnQ3YQ09T0nWEndev97n5SvI4d18Zi1pbJQLg/Wqi5ua5VscF4cmPWtxfBstsPp2B3iaiXs75St6tkCfXGTD27TRrRQl1mvZg3vU5ygumh9FIfavNcVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMha5daI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5384C2BD10;
	Tue, 14 May 2024 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687337;
	bh=MKA2MYFVyNCeV60E123SOfPmN6v5KCyp9aYEbVbZ4JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMha5daIBzyEvOo+FmQjhh1WPaBNySBDyapHOsHTVt+M1py+CT6JkXsTmfNOIz7b6
	 Q08PuYeOKjyXdbUSt9EkCifvB7jVdhguowUInryZLH6MCH7r71BIgY38Hb2AQ8dLFC
	 kwhlCC34eECVxGdax6BFOoRz+2TzRpDT2PcmHfLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 020/111] s390/mm: Fix storage key clearing for guest huge pages
Date: Tue, 14 May 2024 12:19:18 +0200
Message-ID: <20240514100957.892993327@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

[ Upstream commit 843c3280686fc1a83d89ee1e0b5599c9f6b09d0c ]

The function __storage_key_init_range() expects the end address to be
the first byte outside the range to be initialized. I.e. end - start
should be the size of the area to be initialized.

The current code works because __storage_key_init_range() will still loop
over every page in the range, but it is slower than using sske_frame().

Fixes: 964c2c05c9f3 ("s390/mm: Clear huge page storage keys on enable_skey")
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Link: https://lore.kernel.org/r/20240416114220.28489-2-imbrenda@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b5a60fbb96644..ad4bae2465b19 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2627,7 +2627,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 		return 0;
 
 	start = pmd_val(*pmd) & HPAGE_MASK;
-	end = start + HPAGE_SIZE - 1;
+	end = start + HPAGE_SIZE;
 	__storage_key_init_range(start, end);
 	set_bit(PG_arch_1, &page->flags);
 	cond_resched();
-- 
2.43.0




