Return-Path: <stable+bounces-205809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A7FCFA6B1
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B1C3518043
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA82F83CB;
	Tue,  6 Jan 2026 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLejAM+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780C23F42D;
	Tue,  6 Jan 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721934; cv=none; b=J6UPaPyhpDPOl5Ffh25BrBSbDY/zpfR10dxgo5InGkpIRf4mvu0QhPdjzXyclkxNX0zEYOfsuLQEOHhXWUh9318DOc3fxuzEyfF/+QtJ4WP3ZtDKaNS5Z36El2uU2a1zWlTCW6zMWVw/Xcr2E3V94hmYgT1WXsodaYh+rkmEBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721934; c=relaxed/simple;
	bh=t9uCWn3t2wtnfHStWvU2kfP7MrJN9DCLS3iumBsRQrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qzyv0eBn/WhIF67QtOzqnBq/Tivl0O0vPdZ6A75Ew2L5vIUuptZY04WG7/zvaejkW9J9X5bCcazOuPcdU/V8EEOuou37sugrhYSaiB182ZIuUSWzj5aa0RUYqx29MdkeNx3a5M+Aj3RJkz38vkg4KhGsc8dzXH+oS1eqCtlN8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLejAM+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E36C16AAE;
	Tue,  6 Jan 2026 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721934;
	bh=t9uCWn3t2wtnfHStWvU2kfP7MrJN9DCLS3iumBsRQrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLejAM+aMnKS3WF54DkvTQKXr8gcsbeGIbAcAs4tVy6rhWw/H2f2iRfrDo5C5qjZ4
	 oySpAK5gNZ7koN7SXP9Kc22WmV2cESlKYDd5uLphd0rlaSR5K1qNg/Y1yCGP5jUm28
	 ksHUTDPbC0RF7A7uJMBjZLSMy4s2rJbUbCYMIlZ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Johan Hovold <johan@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18 115/312] iommu/mediatek: fix device leak on of_xlate()
Date: Tue,  6 Jan 2026 18:03:09 +0100
Message-ID: <20260106170552.001017659@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit b3f1ee18280363ef17f82b564fc379ceba9ec86f upstream.

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
Cc: stable@vger.kernel.org	# 4.6
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/mtk_iommu.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -974,6 +974,8 @@ static int mtk_iommu_of_xlate(struct dev
 			return -EINVAL;
 
 		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
+
+		put_device(&m4updev->dev);
 	}
 
 	return iommu_fwspec_add_ids(dev, args->args, 1);



