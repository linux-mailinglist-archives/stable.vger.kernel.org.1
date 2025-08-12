Return-Path: <stable+bounces-168554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C135DB235BE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089693AE2F9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3C2FA0FD;
	Tue, 12 Aug 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPKw5jee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500C2CA9;
	Tue, 12 Aug 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024560; cv=none; b=XHx6jDqxTFYbW+cYxg4fOUBZUYPaVa8KGcLulkoduxaA2VLG5sfm9ym3AfIbDFlROQirV7RdEBnYO7D+VghMikcj0VVqnYBN3ZRMJ4UYn6AvAiTlQ4dGU6VMc3NYSRtqkgUDyh7yBjMA45ng1DHlXjGprkeZvDv90fYrqh/u5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024560; c=relaxed/simple;
	bh=FfDOd6Kmg5GQmTxNw+0plDsTIokY0QDHEH8jKSSEUOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmA9YljIOO2n0wuS9waZe1rD+2JVikS0+cLLmbkIl6x3/COCzYNmBu3AdcYdBWRfgQkyYqiSWK78DkQFN51yKFD3ucrVAHPQgoLbOw5lHAVQlvmxDhJNL2EWQlf8ui5K5bkM3lyzKVrf4lWK2IGn5dfIC+RXunKPKP2Uc+oAVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PPKw5jee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A78C4CEF0;
	Tue, 12 Aug 2025 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024560;
	bh=FfDOd6Kmg5GQmTxNw+0plDsTIokY0QDHEH8jKSSEUOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPKw5jeeYALcIvqVXV7v0s03ioL8uCBjMzUDVS9ChZKNDf+Ko4CGeJl4QY1w6xLbp
	 4twfzaucBo71cTKa2f0+A4GF80MIVklIbt+8yf88BsXA/bMP/sAFU7pB16Ah2JqIJy
	 B+TCqNbw6uQztUjurW2rwhLkRD0Mw4gqnhI5cA64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 409/627] PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute
Date: Tue, 12 Aug 2025 19:31:44 +0200
Message-ID: <20250812173434.841850475@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

From: Manivannan Sadhasivam <mani@kernel.org>

[ Upstream commit 61ae7f8694fb4b57a8c02a1a8d2b601806afc999 ]

__iomem attribute is supposed to be used only with variables holding the
MMIO pointer. But here, 'mw_addr' variable is just holding a 'void *'
returned by pci_epf_alloc_space(). So annotating it with __iomem is clearly
wrong. Hence, drop the attribute.

This also fixes the below sparse warning:

  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17: warning: incorrect type in assignment (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    expected void [noderef] __iomem *mw_addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    got void *
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21: warning: incorrect type in assignment (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    expected unsigned int [usertype] *epf_db
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    got void [noderef] __iomem *mw_addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38: warning: incorrect type in argument 2 (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    expected void *addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    got void [noderef] __iomem *mw_addr

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250709125022.22524-1-mani@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 30c6c563335a..577055be3033 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -510,7 +510,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void *mw_addr;
 	enum pci_barno barno;
 	size_t size = sizeof(u32) * ntb->db_count;
 
-- 
2.39.5




