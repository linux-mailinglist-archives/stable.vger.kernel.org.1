Return-Path: <stable+bounces-89560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6669B9FF3
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 13:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F51C20D1C
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA3189BA9;
	Sat,  2 Nov 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NzCsfCsp"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CA189B9B
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550049; cv=none; b=MuXo1g3nOnYsvIT14n+jgl5wzMd5r++ic7w4A+3GeVmV0eoIEmGfuA0jpnaOu05ERKFo4K9j7TAfUlF2cqzVE6uyEZHL+SleVOEbUSSbN/KfS1T5gThXMzrJCWhrYEhWX6RxcKV31bxF3RQEmvdmU/RsNxMHaGSvnXAK6Oa0/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550049; c=relaxed/simple;
	bh=zChWzUIgsHhVArpSPejSnuq5tnBS2PpmuYTsVJrsBUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rDwkRYXeQi2xirry36qH3q03BOlrxCsBP1MTauoA+/yqE1z/qdcPA6wayERJicoxa8KQsrg1wW9Jhk3H3gAyEpTSpUoe9DWWhJnEmZPpTExa2DWcwgAU/ONQV5mlA9eODFBGK7AmmaK67/5ZahyEMyLdzMAhlBPHr1YjycaAnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NzCsfCsp; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730550046;
	bh=Vv22TbSbJLiin9JMVgXbm3kRyh4dU13ohGrYSxYcD5w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=NzCsfCspwJEqGdtvQqhnX5RwG/UY9AMFg1xD50hMy25BB0BbljHtmTI9w05KbOEiW
	 Myq+rQM4lpmBiMlNFM6iQZeUe/OB7fiycn8SMrWgj9d7QMLrXvUL9WWMZO8jU4HqQt
	 +PO9tcxO8Gq//bSgNTfisdeSAmfjSC1KlpP8Txz6hrbHezwSvUqhsQiihTcOnP5NUR
	 fc2qpVBbQkLH6i4LEKfBx6EKJpvsL00UXMURPtChNggoXF7IE2MQKLYL6oVK4Bkspg
	 UTxH8p94lkp2dzCvFXNlMKPCRVs4WsQIpWdWwfY/IzV3s4NXGoTb2LkE6SLAL5TkVX
	 hLf5lzq3HrSXg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 3AB4D2010271;
	Sat,  2 Nov 2024 12:20:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] PCI: endpoint: fix bug for an API and simplify
 another API
Date: Sat, 02 Nov 2024 20:20:05 +0800
Message-Id: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPUYJmcC/32NQQrCMBBFr1Jm7UiSGmpceQ8pEqZTOwuTmmhQS
 u9u7AFcvgf//QUyJ+EMp2aBxEWyxFDB7BqgyYcbowyVwShz0MoonEmQZ0KKia+jvNE7Y7UZvRu
 0gzqbE1e9JS995UnyM6bP9lD0z/6JFY0a26NznbLc2rY7P15CEmhP8Q79uq5fy56AqLIAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: sfhaZh0nZ-DIiZWaCO_Sqp6Mmgeg8wi9
X-Proofpoint-GUID: sfhaZh0nZ-DIiZWaCO_Sqp6Mmgeg8wi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_11,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 mlxlogscore=572 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bug for API devm_pci_epc_destroy()
and simplify API pci_epc_get().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Correct tile and commit message for patch 1/2.
- Add one more patch 2/2 to simplify API pci_epc_get().
- Link to v1: https://lore.kernel.org/r/20241020-pci-epc-core_fix-v1-1-3899705e3537@quicinc.com

---
Zijun Hu (2):
      PCI: endpoint: Fix that API devm_pci_epc_destroy() fails to destroy the EPC device
      PCI: endpoint: Simplify API pci_epc_get() implementation

 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)
---
base-commit: 11066801dd4b7c4d75fce65c812723a80c1481ae
change-id: 20241020-pci-epc-core_fix-a92512fa9d19

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


