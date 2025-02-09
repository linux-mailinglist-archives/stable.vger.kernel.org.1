Return-Path: <stable+bounces-114440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92527A2DDE6
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1E11644EA
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000A1DE88C;
	Sun,  9 Feb 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FmUaeKKL"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCF1DD9A8
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739105993; cv=none; b=Oww2PVCavGay8u8ha6zGFIhBkzViKZ2fuIbjrpFDdbFnSy4dQ6+GnaO+fFOOsyzjw73bNdvYJk31KoC1gCLhwhvt4S494UB0QG2zlDxnnCZunJtf39BqFhlws4xoXvVlMlcIGaZycoY/YtEo/+ZB0xaOxT/LI8JbN10Vwsb10FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739105993; c=relaxed/simple;
	bh=P/GKa9XPQmJ9CzB1PYwPVCJdEP77JN+cmJ6yfUob4OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yx5EDmi9pdF5cdecHl1yWaZ2Xg3U2ujspdtejrPrzv/1EpZwTG07qn4NmmErI3c8wg1xGmaqPIgPHZlCNDz/xmtQSmBvtnXo1W65snECRaDn956I4D+Vnsk6xNpba0ytlB+UlvJNHegzg8mjRGjoCmyA+VbGaC2simAud9EFniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FmUaeKKL; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=2XvnkI/Yi+2dOfaz2a2mLRPaawCsMazgnWp5isa+YrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=FmUaeKKLdWUB4Gdihy9nJcfwtRI0P/ivjIQiZ5RczAM5C1Wb5IrP3YnuguN+PGmCi
	 xbqPidYHFPC0qgXKlrqzXMkbPySQ6ypxkLg2sej3pjtxu2taU7DfFqCziDDehPovaG
	 ENOldRpQyL/DnkMV7ZMvrCYneppc+XvtFSxLvlDHHjZWg2ivH5+PHD06odGUiEMXjD
	 wG9jNy5EX2uEtIrU8RkcV5+inuJoiEJklZWVXIML4qg05NC7fU53LcVdUIXWogGRwv
	 njdyGmKRWV2gy4WPGpYSgtHx64ADLUEZggOCJrZ/sFlTbAALP13kPg6S61U39mk2WZ
	 NN+8O0GH43Tlg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id C9848D0009F;
	Sun,  9 Feb 2025 12:59:44 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 09 Feb 2025 20:58:55 +0800
Subject: [PATCH v2 2/9] of/irq: Fix device node refcount leakage in API
 of_irq_parse_one()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-of_irq_fix-v2-2-93e3a2659aa7@quicinc.com>
References: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
In-Reply-To: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, Tony Lindgren <tony@atomide.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: v-z9xPlaQQ-b5vtzxHURutqMStbFm-Cg
X-Proofpoint-ORIG-GUID: v-z9xPlaQQ-b5vtzxHURutqMStbFm-Cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=802 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502090115
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_irq_parse_one(@int_gen_dev, i, ...) will leak refcount of @i_th_phandle

int_gen_dev {
    ...
    interrupts-extended = ..., <&i_th_phandle ...>, ...;
    ...
};

Refcount of @i_th_phandle is increased by of_parse_phandle_with_args()
but is not decreased by API of_irq_parse_one() before return, so causes
refcount leakage.

Fix by putting the node's refcount before return as the other branch does.
Also add comments about refcount of node @out_irq->np got by the API.

Fixes: 79d9701559a9 ("of/irq: create interrupts-extended property")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6c843d54ebb116132144e6300d6d7ce94e763cf8..d88719c316a3931502c34a65b2db8921f7528d99 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -339,6 +339,8 @@ EXPORT_SYMBOL_GPL(of_irq_parse_raw);
  * This function resolves an interrupt for a node by walking the interrupt tree,
  * finding which interrupt controller node it is attached to, and returning the
  * interrupt specifier that can be used to retrieve a Linux IRQ number.
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_args *out_irq)
 {
@@ -367,8 +369,11 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
-	if (!res)
-		return of_irq_parse_raw(addr_buf, out_irq);
+	if (!res) {
+		p = out_irq->np;
+		res = of_irq_parse_raw(addr_buf, out_irq);
+		goto out;
+	}
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);

-- 
2.34.1


