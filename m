Return-Path: <stable+bounces-50928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F3906D78
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9654A2857D0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E317148837;
	Thu, 13 Jun 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O343KCcH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD321487DA;
	Thu, 13 Jun 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279800; cv=none; b=CioEJO84/5rHlHpfcA2OegtUlgH6NmT4186MTx/W8tQaIOWxi7gNVnVRSuJDfphulB8cLIPPMIGCHpz9rgmL9Em8I5sW00WxH1ZdP0rLATIiZSZU+aNefQEPp9YbnutgC2rNZfbfdVDvF0SgN1v1jDsuZKb3rnulMvLDLyR89iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279800; c=relaxed/simple;
	bh=tsMtXSHs8gphnbDQau4+aHOqPDasavfgvHn5cyfJSWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwpyy8dEgPAriYQ4jBhbmw/oJuXIR1YqNd5+eylmFQ8NIGBvOEuFXtPmY26JbNUYj5VQXMiJ1gJxneJDLmJ8jo6FZek2WVSlvhJSLVjkZgymFMtamXjTmQ85QA7jZzBtjiR/+4ClP0gaSKQn9HQy9+OHyrjB3Y5H8/vvpg0Bwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O343KCcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BCCC2BBFC;
	Thu, 13 Jun 2024 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279800;
	bh=tsMtXSHs8gphnbDQau4+aHOqPDasavfgvHn5cyfJSWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O343KCcH23vj69jUMjk84o+dQCNs/Je80APU2hwGbt+mosqAAq4IIb0hGD8hIkqyi
	 kROLX/Mw5zPs15mClgvSD2ty1lBygJCUog6HQ4H+wprnD7zkrGcVe/SIziZB8H+3/5
	 tmHgHDVf0O15co8KVvUe9mt+5zpR/fFfvXcBbdo0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xingui Yang <yangxingui@huawei.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 040/202] scsi: libsas: Fix the failure of adding phy with zero-address to port
Date: Thu, 13 Jun 2024 13:32:18 +0200
Message-ID: <20240613113229.318929703@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xingui Yang <yangxingui@huawei.com>

[ Upstream commit 06036a0a5db34642c5dbe22021a767141f010b7a ]

As of commit 7d1d86518118 ("[SCSI] libsas: fix false positive 'device
attached' conditions"), reset the phy->entacted_sas_addr address to a
zero-address when the link rate is less than 1.5G.

Currently we find that when a new device is attached, and the link rate is
less than 1.5G, but the device type is not NO_DEVICE, for example: the link
rate is SAS_PHY_RESET_IN_PROGRESS and the device type is stp. After setting
the phy->entacted_sas_addr address to the zero address, the port will
continue to be created for the phy with the zero-address, and other phys
with the zero-address will be tried to be added to the new port:

[562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)
// phy19 is deleted but still on the parent port's phy_list
[562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
[562240.062680] port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port

Therefore, it should be the same as sas_get_phy_attached_dev(). Only when
device_type is SAS_PHY_UNUSED, sas_address is set to the 0 address.

Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Link: https://lore.kernel.org/r/20240312141103.31358-5-yangxingui@huawei.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_expander.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 173f91ae38f02..295941e41433d 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -256,8 +256,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id, void *rsp)
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
-- 
2.43.0




