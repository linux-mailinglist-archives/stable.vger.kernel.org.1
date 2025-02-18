Return-Path: <stable+bounces-116900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD33A3A9CD
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8BA3AB0FC
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590172236E0;
	Tue, 18 Feb 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGrHFzju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CC223300;
	Tue, 18 Feb 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910496; cv=none; b=F/nyEnWyG26u6MXdHv9xmmhbRtxJPzvslS9Mz8tE6cakEWNxOkNP4zW4saOzrzVRsBWmf0RjvmAliyxPJDhrwojh54NAvOOYYmtQuCy/5anvm3SrKcqtyrKnPw65O+qy0D+4/rIN4TCV4CF1MS+/WDosM35/HJY7aAbinawpNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910496; c=relaxed/simple;
	bh=psUnPTN5sn4UjiS1mKpHKJxcp9RPSnp/kvkd2uig5vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itorDQ51KQu7GpBq64p+XbOrNt29+/nUSdpzQCFXhu9dDkXhi4AOdvBKYtJj5ojHf3Zbn/7h2hTrZ59qqiaPifDt/OjKogYfH3cCYE8e6qO27LMavDDTo71mNvpRdCWBR5GUDQERE9r4FGyZUsl5EFY2t7NI1pD1AqRfDpilbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGrHFzju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EFDC4CEE4;
	Tue, 18 Feb 2025 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910495;
	bh=psUnPTN5sn4UjiS1mKpHKJxcp9RPSnp/kvkd2uig5vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGrHFzjuaeR8s1zcNEUGwKsLcraqn9OEfD5Iq+jGEpOPJgb9MX0VCrugtGdLKVQID
	 BzRw/AotnOZQSvgU9IDFzkz5QS8TqWxUNX4xnA7YJ2PIujXo7GauKiZaoUpKLog+Xx
	 0YLc7yHEUn6LRmd8OIS+y5wxJfW+3XZEmCEchoiBk52nvri4vTPllvVL63K1SNj/VJ
	 NomOpYvYEyqBLy2HnnwjOv22xPaX8tg1fI8SZGE+9S9p8DpJSRLeB2PLEPDOwHgNwu
	 7+UX/AhxcqgGrt0doaL3R6zuNqUlm4kJhCErasUwRn3ui10NA//XAuw5m87R99YSmK
	 8Lzs40i/ZSOww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 16/17] Xen/swiotlb: mark xen_swiotlb_fixup() __init
Date: Tue, 18 Feb 2025 15:27:40 -0500
Message-Id: <20250218202743.3593296-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202743.3593296-1-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.78
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
index 6d0d1c8a508bf..7f108bef54e64 100644
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


