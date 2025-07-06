Return-Path: <stable+bounces-159595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD39AF7966
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD120167CE8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152F2EE5E3;
	Thu,  3 Jul 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="twZWD5Ia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3C2EA49E;
	Thu,  3 Jul 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554727; cv=none; b=CVvnv4ANhV2qpFIh9SKRTxNtUDFZcNZhw9JM1TCo48oJj1GoSmP45lTSuUueD5ZSp/2pRO0pKdyueii6vQMGRM8rvoQZv8/RZ3VG850w25zFNXgAtu8TuDcG0Azh0GsUMwI+k52sn+8cfv/3vPsMTlyId1JlYuwsQnNAMvCAsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554727; c=relaxed/simple;
	bh=I2dWn+JAQWgMLWXSaulivVGxGJwZrP+4rtTSxga0Q3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8OJkNHnNDmh8XGC6t7Zjki6Gf1g7YyWM/s1PAglFjlNyUlMH60l6jdEiD/OFQp9VWmvC8r5aN9sSxB8u47BgUpEzWaHOVw910Jqq57qZ6a6+72YP4OI9hWfLubV5lT7mDULxhaCnnARG/rxbmR2VGx5woEwgxCbHxPW+SLbygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=twZWD5Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB7FC4CEE3;
	Thu,  3 Jul 2025 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554727;
	bh=I2dWn+JAQWgMLWXSaulivVGxGJwZrP+4rtTSxga0Q3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twZWD5Ia4wxS2YY/pEkMz8rwXVP2g6VKBiA/UgsDjY+xnKaN9EPmTi9nzxJatNvZW
	 LmdI29nkSa3UaJanDYPf+orPGGo2BAVK1vgCToLjcyfeIZKisa9tZvhyJyteNlAhz5
	 5/UcsYfMgAVOCSobqOj92wnyFA04k0H0+U+8H+Bc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Wenbin Yao <quic_wenbyao@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 029/263] PCI: dwc: Make link training more robust by setting PORT_LOGIC_LINK_WIDTH to one lane
Date: Thu,  3 Jul 2025 16:39:09 +0200
Message-ID: <20250703144005.467184496@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenbin Yao <quic_wenbyao@quicinc.com>

[ Upstream commit af3c6eacce0c464f28fe0e3d365b3860aba07931 ]

As per DWC PCIe registers description 4.30a, section 1.13.43, NUM_OF_LANES
named as PORT_LOGIC_LINK_WIDTH in PCIe DWC driver, is referred to as the
"Predetermined Number of Lanes" in PCIe r6.0, sec 4.2.7.2.1, which explains
the conditions required to enter Polling.Configuration:

  Next state is Polling.Configuration after at least 1024 TS1 Ordered Sets
  were transmitted, and all Lanes that detected a Receiver during Detect
  receive eight consecutive training sequences ...

  Otherwise, after a 24 ms timeout the next state is:

    Polling.Configuration if,

      (i) Any Lane, which detected a Receiver during Detect, received eight
      consecutive training sequences ... and a minimum of 1024 TS1 Ordered
      Sets are transmitted after receiving one TS1 or TS2 Ordered Set.

      And

      (ii) At least a predetermined set of Lanes that detected a Receiver
      during Detect have detected an exit from Electrical Idle at least
      once since entering Polling.Active.

	Note: This may prevent one or more bad Receivers or Transmitters
	from holding up a valid Link from being configured, and allow for
	additional training in Polling.Configuration. The exact set of
	predetermined Lanes is implementation specific.

	Note: Any Lane that receives eight consecutive TS1 or TS2 Ordered
	Sets should have detected an exit from Electrical Idle at least
	once since entering Polling.Active.

In a PCIe link supporting multiple lanes, if PORT_LOGIC_LINK_WIDTH is set
to lane width the hardware supports, all lanes that detect a receiver
during the Detect phase must receive eight consecutive training sequences.
Otherwise, LTSSM will not enter Polling.Configuration and link training
will fail.

Therefore, always set PORT_LOGIC_LINK_WIDTH to 1, regardless of the number
of lanes the port actually supports, to make link up more robust. This
setting will not affect the intended link width if all lanes are
functional. Additionally, the link can still be established with at least
one lane if other lanes are faulty.

Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
[mani: subject change]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[bhelgaas: update PCIe spec citation, format quote]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Niklas Cassel <cassel@kernel.org>
Link: https://patch.msgid.link/20250422103623.462277-1-quic_wenbyao@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc066e..be348b341e3cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -797,22 +797,19 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	/* Set link width speed control register */
 	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 	switch (num_lanes) {
 	case 1:
 		plc |= PORT_LINK_MODE_1_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
 	case 2:
 		plc |= PORT_LINK_MODE_2_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
 		break;
 	case 4:
 		plc |= PORT_LINK_MODE_4_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
 	case 8:
 		plc |= PORT_LINK_MODE_8_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	default:
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
-- 
2.39.5




