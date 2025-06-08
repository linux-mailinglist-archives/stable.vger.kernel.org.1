Return-Path: <stable+bounces-151908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF6AD123E
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177027A4FE1
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD99620D50B;
	Sun,  8 Jun 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wufzc/He"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E41A5BA3;
	Sun,  8 Jun 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387323; cv=none; b=MR2nir7325FM4LuAwunZFwMTEwZY6y3vyeQVYbfDF6DQo/nS9Ycm6Y1KU/WSNns4GL3AMhW8OQ6UrgloHeeoJtqpJzCv7HYKK4onMeKrYSLFr/lPWyhZmxaonFJK1TwJP1aEo/hbPw5BrTfx+FHj34Mj2SKDpdLcKtDur6ZWX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387323; c=relaxed/simple;
	bh=ukfaGnC9FzxyOsq41/jN8zkC5meZM7qlA0Na784FqJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNGCmT06cWrABVeB4JtPAIQwCs4L+2od4QwX4++mY7KvOP/eImsaewsZFI3Ax4rXVBWgaORyRbCEJFbY+W4Dj2mEH9Iw2Z9l8oQipGGspagTkkW5cK7TjUqgR04J5rzVPJppcezsVc0obrhB07zgCAatR/OBH3ZKQXK+gBQQFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wufzc/He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE76C4CEEF;
	Sun,  8 Jun 2025 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387323;
	bh=ukfaGnC9FzxyOsq41/jN8zkC5meZM7qlA0Na784FqJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wufzc/HejEJlR6eDD2h0guqVu/Oin2+tq9o4NiCBZCNJs65WZmRxwsQeEH9GFAzMR
	 NqII/dAD+IA5v0x+nR22Pfg9zJG3tF37jI2vupurZ8D7+LjILdxEILmooLwp7Kvfb8
	 IAzZbxS3wN0tRzvv7cDofik5HqHvRiICe3qF2WdGVJgXG28KLNBI30tIS4a+SKcNyn
	 Ky6O28VlVxQaL/6MsjAeIT0PSSKe74vQUIAUCkk25VL4/tDfcSmacMktfNEU94C8Sd
	 BUWN/nPpWoZ1u6GSO1/jsijd5gclkdn262tpZL0EUhU5Rhd1S9PlIrvc3SaIDKSs4N
	 dGXE7EfIcRi4w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wenbin Yao <quic_wenbyao@quicinc.com>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jingoohan1@gmail.com,
	mani@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/10] PCI: dwc: Make link training more robust by setting PORT_LOGIC_LINK_WIDTH to one lane
Date: Sun,  8 Jun 2025 08:55:05 -0400
Message-Id: <20250608125507.934032-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250608125507.934032-1-sashal@kernel.org>
References: <20250608125507.934032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## **Primary Justification for Backporting**

**1. Critical Reliability Fix**
The commit addresses a fundamental PCIe link training robustness issue
in DesignWare (DWC) PCIe controllers. The core problem is that when
`PORT_LOGIC_LINK_WIDTH` is set to match the actual lane count (2, 4, or
8 lanes), ALL lanes must receive eight consecutive training sequences
during the Polling.Active phase to transition to Polling.Configuration.
If any single lane has poor signal integrity or is faulty, the entire
link training fails.

**2. Minimal Risk, High Reward Change**
The code change is surgically precise:
```c
lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;  // Always set to 1 lane
```

The fix removes lane-specific `PORT_LOGIC_LINK_WIDTH` assignments from
the switch statement while preserving `PORT_LINK_MODE` settings. This
maintains full functionality for working configurations while improving
robustness for marginal hardware.

**3. Standards-Compliant Solution**
The fix is based on official PCIe specification guidance (PCIe r6.0,
Section 4.2.7.2.1) regarding "Predetermined Number of Lanes" and follows
DWC hardware manual recommendations (DWC PCIe registers 4.30a, Section
1.13.43).

## **Technical Analysis Supporting Backporting**

**Comparison with Historical Similar Commits:**

Looking at the provided examples, this commit closely resembles
**Similar Commit #1** and **Similar Commit #3** (both marked YES for
backporting):

- **Similar to Commit #1**: Both fix hardware capability exposure issues
  in DWC PCIe controllers
- **Similar to Commit #3**: Both address link training problems with
  clear technical justification and minimal code changes
- **Unlike Commit #2**: This is not a vendor-specific workaround but a
  general robustness improvement
- **Unlike Commit #5**: This doesn't remove functionality but enhances
  reliability

**Code Quality Indicators:**
- **Well-tested**: Includes `Tested-by: Niklas Cassel
  <cassel@kernel.org>`
- **Vendor-originated**: Comes from Qualcomm engineers with deep DWC
  hardware knowledge
- **Maintainer-approved**: Processed through standard PCIe subsystem
  review (Manivannan Sadhasivam → Bjorn Helgaas)

## **Backporting Risk Assessment**

**Low Risk Factors:**
1. **No architectural changes**: Only modifies initialization values
2. **Backwards compatible**: Working configurations continue to function
   normally
3. **No new features**: Pure reliability enhancement
4. **Isolated scope**: Changes only affect
   `dw_pcie_link_set_max_link_width()` function
5. **No external dependencies**: Self-contained change

**Benefits Analysis:**
1. **Broad applicability**: Affects all DWC PCIe implementations
   (Qualcomm, Rockchip, i.MX, Samsung, etc.)
2. **Field-proven improvement**: Addresses real-world link training
   failures
3. **Future-proof**: Aligns with PCIe specification best practices
4. **Progressive enhancement**: Improves marginal hardware without
   affecting good hardware

## **Stable Tree Criteria Compliance**

This commit meets all stable tree requirements:
- ✅ **Important bugfix**: Resolves link training failures
- ✅ **Minimal risk**: Small, well-understood change
- ✅ **No new features**: Pure reliability improvement
- ✅ **Contained subsystem**: Limited to DWC PCIe controller logic
- ✅ **Clear problem statement**: Based on PCIe specification
  requirements

## **Conclusion**

This commit represents an exemplary backport candidate that enhances
PCIe link training robustness across all DWC-based platforms without
introducing regression risk. The technical approach is sound, the
implementation is minimal, and the benefit is broad. It should be
backported to LTS kernels and any stable branches supporting DWC PCIe
controllers.

 drivers/pci/controller/dwc/pcie-designware.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c6..d40afe74ddd1a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -752,22 +752,19 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
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


