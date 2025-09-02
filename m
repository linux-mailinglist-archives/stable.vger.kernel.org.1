Return-Path: <stable+bounces-177054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56445B4030A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82668169B02
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5D3064BB;
	Tue,  2 Sep 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kns2N9uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66430505C;
	Tue,  2 Sep 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819422; cv=none; b=EnLqKEPu1ncM5SVUAsfG82IN5N57X30vz6ZnSF5i2+7cjQqJsrnOjw/kT4OGhvmkhOPklQ5ssz1qTc/MtS7SvmljeopW0ma3U8BQQZUwME0ALqb/VOXmH0M0cHCfnsfVWcmdlwdIPPQqENvHK1Bgv52FHeqmmpi546BN4MkKUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819422; c=relaxed/simple;
	bh=aPqCM2QqPcR9wGdDvc1v2HicMhG81p1ecGGt7V4rvno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxNnXjGyIsoACpp/oyIJEGFU3b+dHzIOedrjxYaac2o9q10e6r+YUJYh6r2U7M98NbJg+Xy2mEvz70UeVwAa1Pec2HmZMb5+T2/kA2EJPGdkjlfXdokIRAOiEcDcUiSnthxk5l/axSRBvhCFoPv2SWY2nUlrBdvCVW+FGyPiyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kns2N9uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60324C4CEED;
	Tue,  2 Sep 2025 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819421;
	bh=aPqCM2QqPcR9wGdDvc1v2HicMhG81p1ecGGt7V4rvno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kns2N9uzW4/CqF2YkloA5KOpZJNyVpU8XpGzqfwzUaYEV0CcHNtEuJP1V4FbwNCa9
	 andsVy1T9yDUsA3OCkuNYCXtA7uXLZPEV4PxqL8x7ttv37tHajZZ6++pqfomSoVXuF
	 q8Vm8N2KW3B0BrhsbAosVhoY07ttFp2TsRZMWhtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 006/142] of: reserved_mem: Add missing IORESOURCE_MEM flag on resources
Date: Tue,  2 Sep 2025 15:18:28 +0200
Message-ID: <20250902131948.400368031@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

[ Upstream commit aea70964b5a7ca491a3701f2dde6c9d05d51878d ]

Commit f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse
"memory-region"') failed to set IORESOURCE_MEM flag on the resources.
The result is functions such as devm_ioremap_resource_wc() will fail.
Add the missing flag.

Fixes: f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse "memory-region"')
Reported-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reported-by: Daniel Baluta <daniel.baluta@gmail.com>
Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Saravana Kannan <saravanak@google.com>
Link: https://lore.kernel.org/r/20250820192805.565568-1-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_reserved_mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296e..d3b7c4ae429c7 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -771,6 +771,7 @@ int of_reserved_mem_region_to_resource(const struct device_node *np,
 		return -EINVAL;
 
 	resource_set_range(res, rmem->base, rmem->size);
+	res->flags = IORESOURCE_MEM;
 	res->name = rmem->name;
 	return 0;
 }
-- 
2.50.1




