Return-Path: <stable+bounces-138608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD74BAA18C6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862D21BC67CA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941AF2517BE;
	Tue, 29 Apr 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dxz4nEbC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3922AE68;
	Tue, 29 Apr 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949787; cv=none; b=uINrWZktEPYitBq0CWAZ/snI7ayHpM/qLs5YAA7isbrcSiGLIy8iVEE1XL6iqDLky9cv01t19VVEkFfcrmTQJFO/VeP3R7FrGe/Qm6/U97imfnNN8OIF/VW80aIDAmLNHXIYR9ErY+BtC6aAE4T0To5bqqgYBnCRrenFglnZ518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949787; c=relaxed/simple;
	bh=UT49XqNd90+MZJjpLk1oP3bUh5RO8WEcv7RA8hysEcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDHsKozjt0YqdeQW7Z7j6su0MkgXi7CD3QpXuooLQubjpWWx3E6TC5W9LbBKXG1e8Y2HEQd9V16K8TfRK2AwdO4F4bGDz5AV8gKOz5ogTDcOR9xXjLbm5fkf2qu5fOHoSe6vv/5w3DvKySXh+jMeFI7Hfyhd7gxZfpuHQweQQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dxz4nEbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4826C4CEE3;
	Tue, 29 Apr 2025 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949787;
	bh=UT49XqNd90+MZJjpLk1oP3bUh5RO8WEcv7RA8hysEcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dxz4nEbCFfWZoIw22ocULhdRr6FKe1382N9TxdZg/XQa47Lugjk8ItAUYRUnryoQk
	 7jxPma+0T2HtpvYoAL6b3PA1TXgrh1Y+3z3pZsDv9s/keJ+152lIbo6t/b5ZxmPj4E
	 rHqiXLc5PuJo6mJe4KW935SaeTBWLfdQSUaNsgao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 055/167] iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
Date: Tue, 29 Apr 2025 18:42:43 +0200
Message-ID: <20250429161053.995928104@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 07172206a26dcf3f0bf7c3ecaadd4242b008ea54 ]

Return -EINVAL instead of success if amd_ir_set_vcpu_affinity() is
invoked without use_vapic; lying to KVM about whether or not the IRTE was
configured to post IRQs is all kinds of bad.

Fixes: d98de49a53e4 ("iommu/amd: Enable vAPIC interrupt remapping mode by default")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250404193923.1413163-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5d34416b3468d..4421b464947b8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3589,7 +3589,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
-- 
2.39.5




