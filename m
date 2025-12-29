Return-Path: <stable+bounces-203487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FFCE6655
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDC0D30069AD
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299822F3618;
	Mon, 29 Dec 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rru5ukHU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fmBn5j8W"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3619D065
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004971; cv=none; b=SYFPcmGrlA6nzciwCJYwgg95sm+3Fbj6xmFXoMzBp9qHt/eSeC3SMvzaRi6dj9yOQBrcRDFkWfiWa/jbcIvhs1SieKohQfqAP6xVEY6aVB+EOYVrk1GFgIraJZ1FvEECAt7Ek2qxLxNrCCCSkZHyEMc0O2K/DYcrIvbAtKe6OIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004971; c=relaxed/simple;
	bh=Pc8e+pp7p6i6HMm7KEhfgmtCTmbOT4hNYIxGiQKg+B4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ai2XQZd/BOJNYlla5ED+9bd4Q7h42r7pGHFPYep7BbRkPPELo85M2SY6trv38kWEnGOdwOMkr2EYwaGmIDsOPvhc+cGgjlCgmKHnm0pVcRk0O/XDYPHOStAT8VDBHSRDO4KhAECJhZm7JWH+yB6SE8mtmWZEij3gMDlV6Ef+JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rru5ukHU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fmBn5j8W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTA0wQ44154610
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=84jGZ7ZSC4WVxRFYKZtE7e
	uop94RbHLxBmtr9Ml0uQk=; b=Rru5ukHUYzW0gaMm+OPje2AYjd8shdFk24IsMS
	NYs3J6mqeOzQU5VXrEMJaAoNSOp23oM/qdJ64BrabjXEV1Ovihs0U6nLq3QFcck7
	+ViZbkkyUCtYgKDmXF7oz0UfKDYT5OMUie40FmchJaTmIaIbUr3jPrcnQCl4KvqV
	9o0dZmELDkqE4o7zsvf8zALUqQf6FUlZ8q23fve++DvFdxguuM4dz57dQGkBlupp
	z2Ksw28hx6JPB1J26h5CtnxONcyil5ZdZ8KekEp9zx0ywklbFcqDguE8SSDH7I0x
	Og3nq1rGe798k/HsPNSwcJEiaLP3R1PpPIqOjIkvRz1wYuGA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7u5m333-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f1450189eso82915385ad.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767004968; x=1767609768; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84jGZ7ZSC4WVxRFYKZtE7euop94RbHLxBmtr9Ml0uQk=;
        b=fmBn5j8WCy/9+5n/xkBtb+gDkMFZxRBCQ/SS0R6cwhEslteDHhuc9YHbHQIfb1lQPn
         AP0LN/vOgoKWkjoI2rZdNN9unO7bCF6e0NBFxfKo7scoM+2tgJP/OYj42W8gdjaHGYej
         IO8cCHnt3UXGFtxyRRMRshJvIgB1kg6S7+EMrhgTaPMUOcbGAXuo2JECV1fV60/holK/
         m8SFevOB5q4ivA662hAvpKWJyvG8zUt6ckbkaqigMQq/602F6jRfdtiLsswRrFGuzoBF
         owRPLie6dlLOgEZeZJLjyfQAmdNZIwKqcOJ8dhxiDgwUUMV425tmtiVdYdqk8gkWYji7
         O2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004968; x=1767609768;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84jGZ7ZSC4WVxRFYKZtE7euop94RbHLxBmtr9Ml0uQk=;
        b=tZQnQDPYu33HQKYCL6V8jJq8mxni6V6XwqTsejBri5mag3ZVd8hFOwLTyVzlBSN/FE
         Ov+ZHtt9Qr5CshbUx7GkfxpWomJzklKtse2FnI+xylzVpcpDhCASd3gTrciPMHI3C2mO
         fTlZ1Q/E9Kd9kNq4J4IlToj4BZ/GkqoLKksOyFN6f7aAZmCegUcPe2kVXzYqqVSiUgaj
         7HEdnG6LQ8PeQCA/URtb8fKd+E4k4iEIWfoFLrCfuTKbf/iIu7zxiBOF7U0jHeB0YFfl
         94tcu3uw8iIDRyo8unm5HPaYp2OLYctoxiAG9TozXO2xWUv9THCTvvDLiE69xCw5hRhZ
         21gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW28675rK38+fXuqT+ph3MGvCzgQqL6ONQ7xo1h68wMHnF9bj5SaVFhLYvSKvX2MLteNNDjEgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhV6F45pc44UTk/sAzacPKG3MJE9HLT+u+lNhac1U2K4ejP1BJ
	2fip0c408pvxMDc5mM7TBNoinZxr8WxbG+LVZcoDy0ROQAu8chma//gB+ZcU19MnXN/HXpidaMG
	AtM5tr0Kv/tClj8a6tTppN1aaArNY1Dk6pyiv6UsBjFnFp91xAvfhvi7YBR4=
X-Gm-Gg: AY/fxX4AVe2mVito8X8M/zCSugXY8PQ9XPFn0CFbKh440ecHZIWku465jhpYoAxGKDb
	pcUVN3N+SxwVzws9QK5FNIuRNJuYq2GGCblxTRFTnO5sbB94jaP9wyMS1syXK3qDHVGhyNcS9nA
	u2X2VGtTGrFlm4TDFk37MxtfpbpM5GCvGmGkg7KiMB1VNcT3Zlz9fButi9VJ4mqIJn96NpbmNye
	ZJvgwwf/XoaD0QSZVNJg10y9iPz+tO/6V35C66LgC+GHb2WPmKMynNOt+3DmzGNYAgUl4ev7AWY
	tcYY190g7wj6iw1Cc2AIfOldEnIdeVF9BLRLF1GmN52/DfHC2b9hRd+aWbwQ8rDJBjXxCnX7HNc
	mrL0oiEKfBrsjoR4F+c+TwfCfUrJE+7zkGmSTltObSMB7
X-Received: by 2002:a17:903:2291:b0:294:f6e5:b91a with SMTP id d9443c01a7336-2a2caad1ac5mr394155875ad.13.1767004968314;
        Mon, 29 Dec 2025 02:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvDHMjenLpKspQqCMQIXNVHnUA6GWy+2xfF2XuP8qmMkdtBzejdc7b9u4BVmfjT1GPiP/PRA==
X-Received: by 2002:a17:903:2291:b0:294:f6e5:b91a with SMTP id d9443c01a7336-2a2caad1ac5mr394155385ad.13.1767004967484;
        Mon, 29 Dec 2025 02:42:47 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm273412365ad.59.2025.12.29.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:42:46 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Date: Mon, 29 Dec 2025 16:12:40 +0530
Message-Id: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBbUmkC/22M3QqCQBBGX0XmupX9QbOueo8Q2cYxB9KtnZJC9
 t3bvO7mg3PgOysIRSaBY7FCpIWFw5zB7grA0c9XUtxnBqttZax2itBPHYdu4LeqSdd6IOzdpYH
 8uEfKequd28wjyzPEzxZfzM/+7yxGaVUhut7t6wOa5hREysfL3zBMU5kH2pTSF4czDyGtAAAA
X-Change-ID: 20251203-ecam_io_fix-6e060fecd3b8
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767004963; l=1576;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Pc8e+pp7p6i6HMm7KEhfgmtCTmbOT4hNYIxGiQKg+B4=;
 b=gzKqNstDG5S7x48NHsnQsYGAWFsBPtTfLJ+u5OTfc5PIgAwQRp0rY9p7pHWe0HRfQJGdwAo8+
 i+hc4+5NLrlAkbW9q2x8Jz9zJA8kw8lkKwP48ArTPIZIqUFpNhtHADF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: gYIbWphklYX0MXK2i8RqdClNMD8sVCzY
X-Proofpoint-ORIG-GUID: gYIbWphklYX0MXK2i8RqdClNMD8sVCzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA5OSBTYWx0ZWRfX0WvjUghIAepB
 6L9Mu3FBa1WPYuwcc0dunKFN1UsBO5h4RJN/etS2WmAGezRMX7njLR7qFG6VEH1UO0++0jgsOXg
 vgIPBXPSujWZVElCRTNe7z+zeuIDxM/atskf4WkMs8hDpKxKUDviMl1rYTc5kA8/Ad6NEsu58E7
 pUvPuijmv2HJZkyExIkSzT1S5Bk5jto09mzxcj4LEJyvHJFGRxNOQDcl1PExNOtIvHhe/GBKYzy
 ue3QyuDg+mHUFJmPWLW1rIOSi3qvKTmwUHCPtQ+HjK46kti7V+bS6XA63TpDZFjskiKsb5BQKoo
 wGbf/V3S+bRu96WuHgjEz+Gv3nK0B7rgz3uxQNqpSYamPcbWMCtC1CRx8i9sE5V/E8kxxGskjQQ
 7MuNuKdMclUUFy1gXzoUa2C7LHcuKR7SIDoovi1szb9mTmWaEdFaw99i2ln5GS6EarV7AlbVuZT
 qWcR1ELq+hPvo9ubF9g==
X-Authority-Analysis: v=2.4 cv=DptbOW/+ c=1 sm=1 tr=0 ts=69525b29 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290099

When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
before configuring ECAM iATU entries. This left IO and MEM outbound
windows unprogrammed, resulting in broken IO transactions. Additionally,
dw_pcie_config_ecam_iatu() was only called during host initialization,
so ECAM-related iATU entries were not restored after suspend/resume,
leading to failures in configuration space access.

To resolve these issues, the ECAM iATU configuration is moved into
dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
when ECAM is enabled.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Fixed the index 0 of the ATU window skipping.
- Keep the ob_atu_index in dw_pcie instead of dw_pcie_rp & couple of nitpicks (Bjorn).
- Link to v1: https://lore.kernel.org/r/20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      PCI: dwc: Fix skipped index 0 in outbound ATU setup
      PCI: dwc: Correct iATU index increment for MSG TLP region
      PCI: dwc: Fix missing iATU setup when ECAM is enabled

 drivers/pci/controller/dwc/pcie-designware-host.c | 53 ++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 37 insertions(+), 21 deletions(-)
---
base-commit: 3f9f0252130e7dd60d41be0802bf58f6471c691d
change-id: 20251203-ecam_io_fix-6e060fecd3b8

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


