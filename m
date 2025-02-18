Return-Path: <stable+bounces-116914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0FA3A9F1
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8DD3BAB0D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E9274250;
	Tue, 18 Feb 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5AHp70j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DF274248;
	Tue, 18 Feb 2025 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910526; cv=none; b=dk6/p4+2t8wDpedOSOJpxyKepGmD/NZaiHMRcieaKpnn4vIYBx70Rn1JgM1IaD5/a2rg98BsPZhRa0Mp5trt6eKrMyTlli2kcfdxeHaLCmRRNEngUlMV00OSpS6BonAKm9ouJUh5i0L3aLdNtYcC4wwc4dqwjcBkvHxAaZJTylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910526; c=relaxed/simple;
	bh=bQdm91Yl1iqCE5K3ojwjgZipgckujmqzZusDskuX2rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifFPixuhSbHNuh2UBV28Anj6XtSWb/EY9BuhXWPWz8qUaQkQo+dz9ZCVcO0tHD9qUHjlQovIxjbh2qHchBi2wj3G/zf69V4G4KFEiVnBU9LuBl2ehb1og+6J1hmM6Pl9zxxfvug8+P3E2UmdL5PMsmUqipTJ/na72iVZnvCRSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5AHp70j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EA5C4CEE4;
	Tue, 18 Feb 2025 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910526;
	bh=bQdm91Yl1iqCE5K3ojwjgZipgckujmqzZusDskuX2rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5AHp70jgOYoxE505706KtLUT7SOzZzDxz4VaRixpXU5TnXmvJb7cWmPPX7kcxAT1
	 nadjVDUJk2RQi3OKbzTGUPUpkQb3U0Kxu7Yzi6r+DRkShL5Typsp+BgQk+v8Hh5X1I
	 tWeAIuDGPp8D7LaS+NKH6+WfW9uxhT1zv4W8Uex3R59asHGJ/KRBZ9OfnrhIUD3g66
	 jZYXCM7R9RrX6RKR73p8mrGevROdpJ6N0KOyO7vp0TKZWNZSo5Ouwl6RO33Ft8Bb76
	 OiFI0ZFbgBdZt5o7gVWofEnDPFCwJRlWB+QUex7JU7cnRpCtsmpeKofvihCEr/L6FG
	 H1w+phMDXjCaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 13/13] Xen/swiotlb: mark xen_swiotlb_fixup() __init
Date: Tue, 18 Feb 2025 15:28:17 -0500
Message-Id: <20250218202819.3593598-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Jan Beulich <jbeulich@suse.com>

[ Upstream commit 75ad02318af2e4ae669e26a79f001bd5e1f97472 ]

It's sole user (pci_xen_swiotlb_init()) is __init, too.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Message-ID: <e1198286-99ec-41c1-b5ad-e04e285836c9@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0451e6ebc21a3..71ce0cd9e83de 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -110,7 +110,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 }
 
 #ifdef CONFIG_X86
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
-- 
2.39.5


