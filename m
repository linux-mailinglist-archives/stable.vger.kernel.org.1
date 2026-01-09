Return-Path: <stable+bounces-207697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D4FD0A3D1
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495AB32512CB
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808A35C194;
	Fri,  9 Jan 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3avrs8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3235C188;
	Fri,  9 Jan 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962789; cv=none; b=VzUMcYzoGOVij7wx+pqPZo7CJzJKE3mvp0N+NX1MEaqH9lg0PjMZs3QH0yo2AYTbN6LG1B3E/sGMTm1VNOaxX3xFcft77E366Tc7ecEoLn92BPoCMFfq04ST04tmyBQ95tVMVZS16QiMqDNukN4/xA3DVedXNA1wWsg0Ph/jl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962789; c=relaxed/simple;
	bh=91/0aviGNe8jhfWVkcK2mnNIDCW8Wj0t8et7mDvPVo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYvxieYCQl8qWCyn34TBKaAadRtWe/mpHbaPFwMNRVyqvGujiokM8m/BKdV/qAiD1FSQCPTw7i9ZCu3Q4mklp6m5LHyo/vPYs5gC72VV8JHiAHCduY1nQcBZekSQWqJGINwU9g80/28KPXMDT4uEeVFypsQOycfwQ5EkbfP3sqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3avrs8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE24C4CEF1;
	Fri,  9 Jan 2026 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962789;
	bh=91/0aviGNe8jhfWVkcK2mnNIDCW8Wj0t8et7mDvPVo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3avrs8LDpuWBHT3SIsM6hJgbnxEsLVHgHgpbAb/4qTQhSHg2tBiUqh9xDt2DdzRl
	 heijig4WcxI1sru7a9MKcSaAY0PwLcc9f+InmaXNaUmNAr0u7dDiB41Cn9LEYzHCQK
	 zInuuRyJuEbj9dIohCpnOAAvSdevDOqhgv3AGUKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Johan Hovold <johan@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.1 456/634] iommu/sun50i: fix device leak on of_xlate()
Date: Fri,  9 Jan 2026 12:42:14 +0100
Message-ID: <20260109112134.703761994@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Johan Hovold <johan@kernel.org>

commit f916109bf53864605d10bf6f4215afa023a80406 upstream.

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Cc: stable@vger.kernel.org	# 5.8
Cc: Maxime Ripard <mripard@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/sun50i-iommu.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -824,6 +824,8 @@ static int sun50i_iommu_of_xlate(struct
 
 	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
 
+	put_device(&iommu_pdev->dev);
+
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 



