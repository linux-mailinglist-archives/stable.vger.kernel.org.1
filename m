Return-Path: <stable+bounces-39510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73A8A51ED
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B0F1C2288E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85F78C80;
	Mon, 15 Apr 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLR6mExd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27378C86
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188335; cv=none; b=SOSY5qfdH2U6jE2zxY+fgcIzq4CTlnRQLR48D3rHCl8RdJexYY7Vx06TUOXoQqU5SdItpkFGqM2LEmJ0VBfrMntvsvJTVvYVU3OpdNJQMHHqL3ZouIibr6+xCnB2dtUAwdwcfldZMA+WaEzbj6+df/o8b42JGMPCJyHs0FM5O6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188335; c=relaxed/simple;
	bh=1SUh9j1zak2utz/PPpBFT6pw/S1D8+8aGUnBOV+HFIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJTo04XOumLVq7f9GpF9TzyiK9FSOqdfazM4dYIZtR/8qzJZJ+touDxonolXJDAWfHaBAOM5dSGxJgZUP9TncdkGRm64fHAO6Kax/qvRUizJ7QsCmbKF1u2WnfmyOqBdYCF7Yaz2eiK7l2jvhQSBOMbaklOZ+DZt7odhidmYETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLR6mExd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E35C2BD10;
	Mon, 15 Apr 2024 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188335;
	bh=1SUh9j1zak2utz/PPpBFT6pw/S1D8+8aGUnBOV+HFIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLR6mExdxqZX6Y+eUh49BnVLGx9rE9R6WSvrxKO41IfBGPmXfDo04QWcQynSvx12O
	 n3vTjYnhIjjhERo1+GUmkyWZXB7pUA/RrlfvHiD2JPCPnlatnoIjVwR+vE67cX9ZQn
	 YucUtvpKPdM6yx6Eru5gJP9GjV5SQm/qKQj9l4Mhe+O/k3nUf1aDnZA0T0RibC9Zcx
	 cEnO17IJEXwvT2wPoG2eDN9Kw4Bw0VwtHUWZR/QkW4CLfOkjxQSouIbUIsUXKM+kkR
	 K/6elLM5SHjQpkPidlJttVcBhpfnvaiixm8h+vPip/B2Eo/+sBugKrbrtgLdOfAeNk
	 MHIfDkU/jwxUA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 033/190] PCI: qcom: Disable write access to read only registers for IP v2.3.3
Date: Mon, 15 Apr 2024 06:49:23 -0400
Message-ID: <20240415105208.3137874-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit a33d700e8eea76c62120cb3dbf5e01328f18319a ]

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

Link: https://lore.kernel.org/r/20230619150408.8468-2-manivannan.sadhasivam@linaro.org
Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index fe710f83e59bc..431bc0e4d3eec 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -730,6 +730,8 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->phy_ahb_reset))
 		return PTR_ERR(res->phy_ahb_reset);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
-- 
2.43.0


