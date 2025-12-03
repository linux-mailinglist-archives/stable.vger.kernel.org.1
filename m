Return-Path: <stable+bounces-198166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03803C9DE9D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 07:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1FDE4E0500
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D427FD75;
	Wed,  3 Dec 2025 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kx8idC3J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OZmoSAZP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DC23EA8E
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742828; cv=none; b=G6j/icHSVN87ISydvN2LvwgnFwBSIoe3jJQe27FSKK0K2bgB5p5IcFSq/9iqzGg+xTFMChcClBAj+zd881H3gVanb5v2+mqBpKWVArLYzLj2zrssxmsruafGo8RpQXeYvpGEWDYfSAtFl9Ao5ZlFoVuvRpp7W6xWoc98iX8Z/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742828; c=relaxed/simple;
	bh=O6VXjYhONpDzeHFKxTbME3vLAhP4zYZw3bePDYIq6j8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YD9XXo4M/7XIoJc0820IgJySdc1v3I/qFl9T3bKs42UhMRZekgXHt5lOqG+cNSVcZeuIk/zdcoxluKXjqRncj2szC4N7x/PAKIeh80n3lAHquK71KH9i5PQ9yLMNo3CIDRPirnKMoPgYO9lASNKmBgq66dOdl3CvgAiPwuBFl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kx8idC3J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OZmoSAZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B34ojCQ385375
	for <stable@vger.kernel.org>; Wed, 3 Dec 2025 06:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uyzrWmEsvcaw4LvkKJsEXU
	IHPC+49vjLKv0Ts47vC2Y=; b=Kx8idC3Jue2frCINMqTS/86eUo3vC0YEtCu47E
	+P7rLRqeM4njb1Ku3V37UIY05fTQ++IakboWLSsBi7uskjIXuPBF0i4xgdzC5l0t
	7UrAhyKtT4eQevSVgVNQ3aJmMUJebgtbeNjjotcGCbGPxwxxBoVwYSQoCgpRynLg
	9H520nzQ3Oupd9wPe/HlRJ/Kr8lvlEqOITXLrujYc8Vld2QDwTX7gAGCaQXV6tTw
	qLZwiWYMQOj6eRi1+abaJaleeHY8B1xOPzT+Fc3tzQMNMDuFjTqjzOk3+589dZZX
	5+L5bnmXEGsNGWuMW5vbrX95TPw7YyFXO/hzhgMIBa6cWrMg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at5db1tfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 03 Dec 2025 06:20:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29809acd049so112464185ad.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764742825; x=1765347625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyzrWmEsvcaw4LvkKJsEXUIHPC+49vjLKv0Ts47vC2Y=;
        b=OZmoSAZPJsbSNZQth0S1yQWRE+e1muxWyWZa9JG4IvO23ES5ceLrTgcrpORhowuHlY
         MM3jsv22zWfOKk8I/urRrGBGeqcMd8rPyRejp4mX3bvIHHrqdK2T8QN8ksitoOQ0huUF
         Y9rnURbg8+/b7v2EYHYS6b96+e7GdYnTyH3vefZK4OOnRBfofKrUPbVYQlMA+QViZq+/
         bR2XGnl8+5whk9zc8QTSS4qSUYb6YFc/0s05uMnmG0w0PzUW9j+h/9tFkhPvxzKSg2YR
         7lvZnnR+Ir+5Qf2zGub40pCTdBVwZspgCqXc4Cm0TjXT3TiExEYG9W5z+c4dSgO+6f5l
         Ldew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764742825; x=1765347625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyzrWmEsvcaw4LvkKJsEXUIHPC+49vjLKv0Ts47vC2Y=;
        b=rjVkR0LUbgF8RRDf/Xr14uGkuROeXm/xqBvoFaKiGZmvymDyCTI2cJq4t7plDIyJSR
         6p5FLgQBYRSVFgWxmyOxjQse86VOSMPoIWUoF4XaRgfFHfksmYNr1wkGdI4DZOgTvW/G
         AIXekhzL8A7g2rN+YqsqG1eJHr2/N/i17MylLj+EhAyS6bf+P903xDuunqLsSDHbBgoe
         zm68blBDFXNOC2WtVgV5EVzfFtmEyQw6DaVzm/wPAMd/bpyY3vcFVSinVn+6gqNZXYUx
         DpiCneM9p65ajnOTUGYMlZZC+SvBH/fWp2Jz8zGceXOq5hxzSbg03RSe83kXvj10vSVi
         CkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM47arx4d4ZDA2OIDLGlZqGiO2HVBVKu8xxolMz51iCcpFfdcZgDa1TT4URqXtGTBGNqIg9tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8TQjM7o57S1VdGpwgRfZaQhZqzwzvWwDHWes/fFqlClPBVK2
	kncYuuPwBqfFc0mO4ROWs9jWmcA6P2e0hbJhcXs8qnRWxLYVptP1P5v1Jv+uNCqoqGPV43L3RJU
	7VlOF5V0ednbXB7+ssQtBRXfAdqDuMoxnTCzheAo8cgi1HNJXnCoDhi+UFvk=
X-Gm-Gg: ASbGncvusO3zySgsIxZJyPnsztOPQzr+Gf1XjO7ObSuhrIF12SR+3lsI0xboI3I+FQ7
	QiNLQRZWZg0ubFlsvkNno/CCpNzP/ZCata32+I1BWJYIHwKa4bfSucHZWQVmEOegW0iGzWAAFM+
	p7b2OvIQz2GmbvysZMfeaolljMj+ydffzhxocet/Lxu7/WFSAIBT2uJrOANgEmT4753mRGwk9Fb
	zhl9XNg5HgPyTGmGPId2xLVmrY+ZWy5/XR+PkeB/UKNHhkiNQZRLMZMMLWR3Pnu635fsQtXlFVv
	jRMsxmQNtUEm3R9IYzbsBHygTk8uEiJW856cU1Jfp5iOgOqQ1jF+O8FZGsvwwTElDEucDuukO3o
	wG0jojp9oVgUHIZMIqVeGacJ4lcJg3uH5pxIZNNI5SLRt
X-Received: by 2002:a17:902:ce09:b0:250:1c22:e78 with SMTP id d9443c01a7336-29d682bd7a9mr16751455ad.1.1764742825068;
        Tue, 02 Dec 2025 22:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJyL5nhaIRoacNGDcQQ0qUgdJEwdvY7apkPBlkWmgG0wCnwygqaNMZwqJk48YBkmW6QtxMMg==
X-Received: by 2002:a17:902:ce09:b0:250:1c22:e78 with SMTP id d9443c01a7336-29d682bd7a9mr16751175ad.1.1764742824590;
        Tue, 02 Dec 2025 22:20:24 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb4026bsm174263015ad.71.2025.12.02.22.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 22:20:24 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Date: Wed, 03 Dec 2025 11:50:13 +0530
Message-Id: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3WL2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3dTkxNz4zPz4tMwKXbNUAzODtNTkFOMkCyWgjoKiVKAw2LTo2Np
 aAGpIy+tdAAAA
X-Change-ID: 20251203-ecam_io_fix-6e060fecd3b8
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764742821; l=1260;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=O6VXjYhONpDzeHFKxTbME3vLAhP4zYZw3bePDYIq6j8=;
 b=n1+i8oCdi0pTfHhqwG1mvIznX0nXhoGf4DP+av3oR20Z/6hnaakf2DhiE57Gl6OWOVUzkP7KI
 zosdOMK9djFBZezNlQqEU0YVWgZzbDTnoV/Hso+DQsJK4IiySvtNxu+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: Vk1es4Lg1Jmpm4J-aS9JvpxdYPqSBgDy
X-Proofpoint-GUID: Vk1es4Lg1Jmpm4J-aS9JvpxdYPqSBgDy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA0OCBTYWx0ZWRfX/hrSd8c+tBeM
 wNplo3q0ZcWBPAKc8dqbSUsHiS6ZFGIWM9xrYPi/HNz4V5lL/LRtbYLKpGWZ0DY70wGp76zTOz4
 gZcAEyfU7N40PIwFg7u4xaCezxPSPCXEvaCUlPhCxLv/B5sIvaqDJMMtB5IIYZEYfrtnaqNGBM0
 GrHCq/q9jVyXQ+OlRma7LxsNdJz2hH7GR7C1cLr+40c8/Y4Kfl3uS+/NpmOSwjC6+kTXBytlTRV
 +V8H6Z3Gjr6LW6yZW4oluHPLX7cDc1JFdxeKa4CPzmaWjMx5QBpfAq2/VwOCQIgkfHtrUdV0Tlm
 x1TPvBtoTyC0eCi8UxYc2SSh1yksTOMViH9fU1QYLn7YOn6R8sodP2/BrU3Avc21zW3rNg6zRFE
 aHY9OssfnCzGsiIwSvRFKLUsh4c+Zw==
X-Authority-Analysis: v=2.4 cv=VoMuwu2n c=1 sm=1 tr=0 ts=692fd6aa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030048

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
Krishna Chaitanya Chundru (2):
      PCI: dwc: Correct iATU index increment for MSG TLP region
      PCI: dwc: Fix missing iATU setup when ECAM is enabled

 drivers/pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 26 insertions(+), 16 deletions(-)
---
base-commit: 3f9f0252130e7dd60d41be0802bf58f6471c691d
change-id: 20251203-ecam_io_fix-6e060fecd3b8

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


