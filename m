Return-Path: <stable+bounces-137103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4073AA0EA0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F21B60ABF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F62D3219;
	Tue, 29 Apr 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="f9aDRZJP"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017A27CCD7;
	Tue, 29 Apr 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936585; cv=none; b=hm7MIFUESqjaSu3eSBaJXyk3A0tZpngGbTDEk510rbcOkzzq+uEtUTm6CGywDPQiWOm5GH1LmqMQHace5JiWLSRFmc2kww6pEHhZFOGPiwvlkrwBt09YFCrxvkGzfJrMvBj5YalvKvPNJW4DZTPYIXDTCXH73970tCA9VZDVNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936585; c=relaxed/simple;
	bh=mSi10ExAIIaQz4/WSNbeci6hSI9+ZpJrJWvqtowmjAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUK6ucePRs+jMClcHcIX5c9d/82X1BUWUvSyD8hM3MM4hktu40kaJGrBXODA16JoRd6gbWr3a1nppvBJbKUVcZ5M6sp6fjSwymLMkQ2bphrB/P48EcyViYKcCS2kKeTgwvsvxxU6V/jqrfp6Fr23CdK6VLbjSJ5WdQBIZA6ERhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=f9aDRZJP; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-3.centrum.cz (localhost [127.0.0.1])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 0B1AE2066045;
	Tue, 29 Apr 2025 16:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745936574; bh=zcz3KV2j9DGPThJRRrNIl1X5dqrILd4s9iLxPnBmOwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9aDRZJPq3ISnnxofAMOSl9GJu8xXrwiQrXqNNXt58DoxUbj3OeGIum+5hy9canqA
	 1lkPogCxu/rBwG8iIfE2ppbkf2ZMs6uLkhT+aXvmsrpZdqOA8OHzyltImZYEKCJnzb
	 G6akwzulKzmBsRNuIqVq+hsnzTuiD1sbjA+UhX5Q=
Received: from antispam64.centrum.cz (antispam64.cent [10.30.208.64])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 092BB20164EC;
	Tue, 29 Apr 2025 16:22:54 +0200 (CEST)
X-CSE-ConnectionGUID: YpSGceRmQye+NjdaFecdsw==
X-CSE-MsgGUID: nVQDrnWZShShA9j8GCQ5Sw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2FUAgBZ3xBo/03h/y5aHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?YFKgzSBcYRVnWqGM4EgjEkPAQEBAQEBAQEBCUQEAQGFBwKLMyc4EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEGAQEBAQEBBgYBAoEdhTVTgmIBhAAGIw8BRhAYD?=
 =?us-ascii?q?QImAgJWGYMCgjABAzGyY4EyGgJl3HACSQVVZIEpgRsuiFABhHxwhHdCgg2EB?=
 =?us-ascii?q?3aFEIMOgmkEgy8Ukw6LEkiBBRwDWSwBVRMNCgsHBYFpAzUMCy4VbjMdghGFI?=
 =?us-ascii?q?YIRggSJCoRQLU+FMYElHUADCxgNSBEsNxQbBj0BbgeVQ4NkB3IcQwllxU+CQ?=
 =?us-ascii?q?4QlhE6cexozl1IeA5JkLodlkGsbpDGEaYF+gX8zIjCDIlIZynt2PAIHAQoBA?=
 =?us-ascii?q?QMJgjuNYYFLAQE?=
IronPort-PHdr: A9a23:7DIe1xLD1W0/wyHy/9mcuA9gWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSTA9mDsbptsKn/jePJYSQ4+5GPsXQPItRndiQuroE7uTJlK+O+TXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1sI
 BmssQndqsYajZVjJ6s+1hfFvGZDdvhLy29vOV+ckBHw69uq8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQwSX6HQTS2kbjBVGDRXd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54
 Kh1ThLjlToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+dlc6jDYd0VW3ZOXsdJVyxAHIy8a
 ZcPD/EcNupctoXxukcCoQe7CQSqGejhyCJHhmXu0KM6zeosDxzI0gIjEdwJsnvUotr6O7sdX
 +2u0KnFzi/OY+9M1Dvh6oXFdA0qr/GWXbJ3dMrc0VMhGB3ZjlWKtIfqMCma1uITtmiY8uFtU
 vigi3Qkqw5rpzig3N0sh5LTiYIJzlDL7z55zJwpKty5UUN2Z8OvH5RMuS+ALYR2Xt8iTH9yu
 CY80rAKpIK3cScKxpg6wxPRa+GKfpSI7BzsW+ucIjZ1iX1qdby/hBu/70eux+7+W8S60VtHr
 iVInsTPu30P1hHf98uKR/1g9UmiwTaCzw/e5+BeLUwqlafWK4QtzqAumpcTq0jOHC37lF3og
 KOLeEgo4Pak5/r7brn8uJOROJN4hhv6P6kvnMG0HP42PRIUX2eB/OSxzLjj/UrkT7pUlvA2i
 azZsIzCJcQcu665HxdZ0oY95Ba7CDeryNsYnXweIFJefRKHk5DpN0zSLPziEfiwnVKskCtxx
 /DbO73tGInCL3nbnLfge7Zy9VJcxRI8wN1e/Z5YFLEMLfLpVkPvqtDVDgU1Pg62zur/DdVyz
 IIeWWaBAq+DN6PStEeF6fg1I+mPfoAVvSzyK+I+6vH0kX85nUUSfbKz0ZQLaXG0Bu5mLFmBY
 XrwntcBFn8HvhA+TePwjl2OSyRTZ3GpUK0i/DE7FJmmAJzZSYC3hbyNxju0HppTZmxeEFCDD
 W/od5mYW/cLcC+dONVhkj8eWrikUYAhzwqjuxXmy7pjNOXU4TcUuo7i1dRt/e3ciQky9SBoD
 8Say2yNS2B0nmUVRz45xax/pEl9x0yA0ahmmfNXCd9T6+lOUgcgOp7Q1/Z6BMzqWgLdYteJT
 06rTc+lATEpS9I82NsOY0d7G9W/gRHPxiSqA7gIl7yNGZM76L7c33n2J8Z70XrG07Mhj1Y+T
 stVKWKmnrJ/9xTUB4PRjkqWjbiqdaUB0yPW7meM03eBvEFCXw5sS6nKQXcfZk7OodTj+kzCV
 6OuCaggMgZZzc6CK61KasDmjFlfR/fsJs7eY2SvlGe0HhuI2LyMY5Twe2kH3yXSFlIEkwYN8
 naCLwQ+AT2ho23GADx0CV3ve1/s8fV5qH6jVU800xuFYFZl17Wr4RMVm/OcRO0J3r4euycut
 S90HFCj0NLSEdaAoBBhfKpEbdM7+1hIzXjZuBBlPpy8M6BigUYTfgYk93/pghF2DJhQ1Msnt
 nUnyCJsJq+CllBMbTWV2db3ILKEBHP1+UWXZrLMkm/X1nWVsvMG8vcxrlz5lAi1EkM5tX51h
 YoGm0CA74nHWVJBGan6VVw6ol0j/+myXw==
IronPort-Data: A9a23:rpmI7aIjTJoZfwztFE+RFpQlxSXFcZb7ZxGr2PjKsXjdYENSgzcPn
 DYYCmqFa66PMWX3L95xOo3n/EwOuZ6Dz9IwSgQd+CA2RRqmiyZk6fd1jKvUF3nPRiEWZBs/t
 63yUvGZcYZpCCaa/krwWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2+aEuvDnRVrQ0
 T/Oi5eHYgL9h2Qlajh8B5+r8XuDgtyj5Vv0gXRhPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/t4sol
 IgS78zYpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkl/7
 cc3Iz03aymSiqGQwr6yZORnit88eZyD0IM34hmMzBnWCLM9RIzbGv2M7tJewC0tg4ZFD54yZ
 eJFN3w1MUmGOUcSfAhIYH49tL7Aan3XeidboVecv4I+/2za10p6wtABNfKEI4bQHp0Lxi50o
 ErAwV3VGBclBuef8jqso3D8qcT2wBjkDdd6+LqQs6QCbEeo7nYCARtQT1yxrOOlkWa3QdcZI
 EsRkgInt6s78UWxZtDhWxSj5nWW1jYYWtxNA6g/7SmO1KPf4ECeHGdsZjdCcNkOsM4wWCxv2
 FiUmd/gGT1otvuSU3313rudszK+ETIYIW8LeWkPSg5ty93ippwjyxHCVNBuFIargdDvXzL92
 TaHqG45nbp7pdUX3q+/8HjZjD+24JvEVAg44kPQRG3N0+9iTNL7Idb1tB6Bt6sGc9nxokS9g
 UXoUvO2tIgmZaxhXgTUKAnRNNlFP8q4DQA=
IronPort-HdrOrdr: A9a23:ObIzvKGGm2sPaHnppLqE5ceALOsnbusQ8zAXPo5KJSC9Ffbo8P
 xG/c5rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1NWZPTUO0VHAROpfBMnZsl/d8kbFmdK1u5
 0MT0EHMr3NMWQ=
X-Talos-CUID: 9a23:VeA6gG67VOsqT1+1Z9ssxVYvNcsoSHjk3XqTBU20AEhkQ7GOVgrF
X-Talos-MUID: 9a23:O4Q+6wZNZj9OYOBTsQHVqCtkC/VT45+uIREPwbotgpS/Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,249,1739833200"; 
   d="scan'208";a="91223060"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.225.77])
  by antispam64.centrum.cz with ESMTP; 29 Apr 2025 16:22:53 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp10.centrum.cz (Postfix) with ESMTPSA id 44AE080911A1;
	Tue, 29 Apr 2025 16:22:53 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Subject: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Date: Tue, 29 Apr 2025 16:22:37 +0200
Message-ID: <20250429142237.22138-2-arkamar@atlas.cz>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429142237.22138-1-arkamar@atlas.cz>
References: <20250429142237.22138-1-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

folio_pte_batch() could overcount the number of contiguous PTEs when
pte_advance_pfn() returns a zero-valued PTE and the following PTE in
memory also happens to be zero. The loop doesn't break in such a case
because pte_same() returns true, and the batch size is advanced by one
more than it should be.

To fix this, bail out early if a non-present PTE is encountered,
preventing the invalid comparison.

This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
optimize unmap/zap with PTE-mapped THP") and was discovered via git
bisect.

Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 mm/internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index e9695baa5922..c181fe2bac9d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			dirty = !!pte_dirty(pte);
 		pte = __pte_batch_clear_ignored(pte, flags);
 
+		if (!pte_present(pte))
+			break;
 		if (!pte_same(pte, expected_pte))
 			break;
 
-- 
2.48.1


