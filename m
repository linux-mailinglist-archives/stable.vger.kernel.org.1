Return-Path: <stable+bounces-116849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514ABA3A913
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D21899B19
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4E1E9B0B;
	Tue, 18 Feb 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDPQ7CCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E51E835D;
	Tue, 18 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910353; cv=none; b=LiCWrIFNkGx3hEVyjsXUTUm7e8+vmviaENUrJE5XtR81tZMaJxt+oSy+qoVkbfJXQWb60nVHghxPBw5OaR0YehF4dIvwmSIM8K6Qy+8AirqsWbg4NuCayJ/l38GbIYGCqBcZm5UGqv8wrEjnWAzbBLD2mYGoxE8SygAz4p+6l6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910353; c=relaxed/simple;
	bh=M0IrEwfhk3Ww4fkOJEqrwcuhSN2tamd0Xb8zp06AIgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxuYPaUZOuJ1lvKptiKdfCERVnzT0xsvu8XuCJKyUW5zDLW3TFEIIY96qcqspqlrA3unpcnVc6HmPNCUMnmU4Qp7Db0PIyYctSjqeqxBPvyEQ59VZAAKIi4nT9XdeCxcI0fvgmn9G3xyehGHVao/kCH/96E4GgAeZWamOsnSlUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDPQ7CCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E57CC4CEE2;
	Tue, 18 Feb 2025 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910353;
	bh=M0IrEwfhk3Ww4fkOJEqrwcuhSN2tamd0Xb8zp06AIgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDPQ7CCxa9k5P0lv6cTWNDDqNSZpvr3ShNfGZ9pr3fV4sdmufjmahrbtrLUrhJkof
	 fw2E/2ymaUgIIRvM5abUaoiAD5wzgAx8M91+UQh5I3Ay3XIusPevAwdL3DNumpqHoR
	 BxMQ/W2o1PSyHX7AfBFs0lYm4CZRkcQkFlydKQhafjru2ZLyHfQgLOd6VHeFxausji
	 dizFkzEG6zpI8+AP7k43QWWXdcJpwyEYxvlhC67PxJ9uFYqJgF41MBZZh20erDBZ5S
	 b7mrxqbrUPH0xGj/FTaZ89zQFOo8lzgpeAWjL0ypbJlzKl8OpX0LzWkMmRcvo0w4CZ
	 Up0Y0c6ADrXDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 27/31] Xen/swiotlb: mark xen_swiotlb_fixup() __init
Date: Tue, 18 Feb 2025 15:24:47 -0500
Message-Id: <20250218202455.3592096-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
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
index a337edcf8faf7..5efc53475f039 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -111,7 +111,7 @@ static struct io_tlb_pool *xen_swiotlb_find_pool(struct device *dev,
 }
 
 #ifdef CONFIG_X86
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
-- 
2.39.5


