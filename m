Return-Path: <stable+bounces-230153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBihJ4KGwmkAegQAu9opvQ
	(envelope-from <stable+bounces-230153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:41:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C11A30875D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12F9F3011A77
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D23E5572;
	Tue, 24 Mar 2026 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DgUtu7HX";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DgUtu7HX"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021127.outbound.protection.outlook.com [52.101.70.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E483D646D;
	Tue, 24 Mar 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.127
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356095; cv=fail; b=A3A7kPNE/IFy3p97BLVbFs7zrCtoqhWZL45dp8/nAE+jiggbXka+fiZAO5haIxMPwlh2gS0IcBUPClSmM31+qmPDumeqv2AtZwzl1kZdlNXYwQ051H8BAvWCQFS1F9qAh53mAf4FN3eCca5A60L8kKGAkrDF20N+OcplMeSbSk8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356095; c=relaxed/simple;
	bh=V6LNThxA7AlHQPp24L8MIaaxOd1ida+jspVkLDqsSyw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QGimrXSdZRr6nZWd7AhHfKrZBfuxdwD0s7dK2OQlIJxK27Wc0l90emsEMhb2PJtCPhfsHzzYpiVdCPktxF1nnAQkBgN9VAHoHmyMVev/7xkY8REYfgY8uj+J+9uhrFVfJbyQmSvmXVA+shQZvXaQysFJpii25w5fjT8fPe0Moyw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=DgUtu7HX; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=DgUtu7HX; arc=fail smtp.client-ip=52.101.70.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uC3tbrLHiS5ayRWEv4ynrtWrkHVpFLiQMddooOpAGK44bUGxHKJAFHOiDaN55JrL5S1mYZwQnEX11Gz2V31juChU7KVVIhq1cYPtmVoRpxlL35RnDRm20JDa0Rl2SZLV2OtRa0d8OHkdJgbr6A1JDuM9ZDW36uud5zpzqEuKhCTwGtaTCDV+apsqZ1//kIPojkKZM0kV7FCpoCc8xYqrT6Na84wYxVozJa+NhrW4FhezJuQIQXAx36T0pZDyD70CrTGGjVWl5vFQ0mUt1lpYZNUNQeTMQKPMwMuAbLXubse+2psoqYOry+9ENLkK5tUfTfbpt9rKY6NZzCfArA/Uiw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td4rGv9ZjvfO5Zp4Pl58V3v5LWSjIkuRcL02xsawGmQ=;
 b=RCNDKTLxmZKmS3JPGmRDxPJ122oNbX98uHfOs/KSZJsUT5FQA6XV2b/EzQ0DH55KLQFcK+FkAkuuPR2+eW0UuDDM4m/rrk1c77CG+mDWlfaANWl3UIB2uCG4mnQ2OJGYRezJgWhNmJ6xtP+Aa57eTkLJ+cb35uKbIOYLG/utynix08qImUZZ2p7B9HdWbfCnB9MS3oEMfRUmtZqDki/JTA6C5Hi9ENZWkij66jRcIoekStNyJ5q+kHgmUK+2k8owJ4eJGUFCNOEp2oToQWg303Az0wMseiHvHyXUHuv65nYJDF7RqYKNFtkgfp4JGlXH+8xzI93OBPDuSNlXD+uskw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td4rGv9ZjvfO5Zp4Pl58V3v5LWSjIkuRcL02xsawGmQ=;
 b=DgUtu7HXoP84g7MBNNQvix0loSgfo2ykteGzIDx79AohJi5ujES3gtO0+uKMxXJ1cN57RpK0+yhCcMMPaps47947TAx8VFHxusougOzjzGI/s0sOp9jpzlpNnXH5pxVge/O9l3L8UrQy3sFPs5Dgc45v47GKCqm72FquROZLuOI=
Received: from DU7PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::17) by VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 12:41:32 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::4f) by DU7PR01CA0048.outlook.office365.com
 (2603:10a6:10:50e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 24 Mar 2026 12:41:29 +0000
Received: from emails-9342560-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-81.eu-west-1.compute.internal [10.20.6.81])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 685B180791;
	Tue, 24 Mar 2026 12:41:29 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Tue Mar 24 12:41:19 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxqdZdRaagaJU3A29+BUPexilnoonuCgBgzvkd738TvK/+U1/p87pWOyeANuyeMNu8VBRZFqK/HanVxXXnI1J3R5A3JVvkUnqcW01O1b5LE1pYRoFtAtWdMoj9WNPGfBWabuSP9Me5llAJ4BPsINQcUJ8xFNQvT/3yDfjLx0akZMQMKQ6a6D2xruME4dMwqpuxHomfONctVg7vxWM4fNNsTbgCBzJLLvjrqbrIVGT+mDfdgfkExbuGHym8l2hdGd7rWVCjer93rvavMRBzQJyf+lNBOj3SB1IFjXD4M0EmOJ0gSeDvxV5jckye3mSpAh9MhP4khIw5b2Qmi9YhzZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td4rGv9ZjvfO5Zp4Pl58V3v5LWSjIkuRcL02xsawGmQ=;
 b=nE27QAhqFgHaoU62/F+Scqh6mYFHdJQ4FHHM0NdnqUqgYSJUODI693qCdW4E15iGcqYSRDcDGG3xDAN7917mhYFnDiDMz94kDAxt2v2dVE/A2NIYUg+pgOc7zVTAoX21ZYI60xM0YzjrlDfl+ddXh4b3UAn171WJKj9YEdvzfxnHlObU2Zye4qnQpfZpB0G9jDPgkPj7He9vwhH3RsrNua0qcl8ajsC2fGosGw90zjyyf/ZnxgiblHPzRLVXrdnfWX22DJWhXwg1hU5fyNdWSYShtp9j5MLTYa79xpvXthYwz19ju8j9Vm8/dkym4CbaSVJg53m0DzTKd0jVJvLdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td4rGv9ZjvfO5Zp4Pl58V3v5LWSjIkuRcL02xsawGmQ=;
 b=DgUtu7HXoP84g7MBNNQvix0loSgfo2ykteGzIDx79AohJi5ujES3gtO0+uKMxXJ1cN57RpK0+yhCcMMPaps47947TAx8VFHxusougOzjzGI/s0sOp9jpzlpNnXH5pxVge/O9l3L8UrQy3sFPs5Dgc45v47GKCqm72FquROZLuOI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DB9PR04MB9722.eurprd04.prod.outlook.com (2603:10a6:10:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:41:12 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 12:40:56 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v6 00/10] arm64: dts: lx2160a: fix pinmux issues, update
 SolidRun boards
Date: Tue, 24 Mar 2026 13:40:54 +0100
Message-Id: <20260324-lx2160-sd-cd-v6-0-8bf207711848@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaGwmkC/23PQWrDMBAF0KsErTtlNCMpcle9R+hC1kiNILWL1
 ZiU4LtXMRSC8fIP/Mefu6ppKqmqt8NdTWkutYxDC+7loOI5DJ8JirSsCMkho4HLjbRDqAJRgDv
 WnUcWH0S1yveUcrmt3Omj5XOpP+P0u+qzflxVZorWkgXWjsCEpniPEbouR+OEg2N5r+OlCEzX4
 TWOX+ohzbS22wyLR72ZMRNoaPOik74zvcM9gP+BnT9mBgRJyVhih5jyHmCeAM0bwDQghD5mYsx
 93gXsM7BdYBvgWdKRtPU28RZYluUPOusyYK0BAAA=
X-Change-ID: 20260304-lx2160-sd-cd-39319803d8ad
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|DB9PR04MB9722:EE_|DB1PEPF00039232:EE_|VI0PR04MB12302:EE_
X-MS-Office365-Filtering-Correlation-Id: ac43dd9f-3a2a-4cbc-68da-08de89a2abf3
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 OUmqPaJhP6Uhoc+PNPwXS1szmIgn/hULrDIjVE2DDOFg1qsEY6xfHSuDOqdS2TOr8B63bRTNDVom4anEbEp4IAsMix3he/HzcFqi7qO3ecgIKKa0A7PJV1v336DqeiaSHEAcSibV5XhO6elNPA4sO5N25AKVwmFnxykZvxhPZ8S5FOD2IbU0yIlLiZUL0dyMApBmTHfyuTgAUMcvcHYY3/QEH1t0WJndD2Qbz9wV+MAWGpJq1/LB5Lnms/uSx3IR5WlQyuAdUmEDmy0sRFe4rzxv02KVbnEH+Lb5ShC+Idpdo6OV36M1wYYuDZ8x6lcYZXfZmPqP4NZcBNTn4CUSl9H2KpdyKXgBO71m/gD5doxz12bJlxthfdeTOo4vLXQMYGeZg3gmACNXqi2AaBMxmGCXGKWnI6fhX9GwbIHbuUGB6eQK0EVV27cXEGzw33XzqJZd9zxrpoetxvLUWF4J0OCMzN8beKN+BkUvsO6XRe32ZsZv+XGM68aJCAWV0QxyLrmJ4E8sDaC1ZeIe2Nb1g6/I1WVTVGm0/xH8p99YB3yoKbXoFiJ9qy4ewRLry27XnfpvvZQ2RijysS9qMBXJl/v6heM2+uFTLBuo5TA77QHL4KtF5qMBd/rE4QSV7o8ITcNOPE/qQ6d2IxfG6zdtzOCtiubxaSLfZZQGzdBpQ0melGYHvaZoU24Gs9Ma/Htwsffi4UirnHYTM8A+JOK1sG7VfE/eaJZ7zKI5/IrYxmbP0oheKOJLMEcuxRp/jdmn
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 TB7IyiM1S0XfG9DE93ol+9Kscr5cJ4m6sfWCWxp+1BQTG8U0I8YoOTVYq+h7I+ODIXLFOzi4uyE/fwsZlyzY5SlTekwX7Wdbs8g/GRY4WKShyK2gpqm80qaTjzvlSk5i6j6RxVP4r5Ng42nbkPYEUNPvb8uHEBz2zoqJd0Emzw8CBa3+JTKdsipernfwwm0FlwvS89bmqxu0eWBKJKgOfYiFgjRQRzH3DBqf7eTJTk55jZ4DQcMprPpHeNnFsRziUPmkzdu4y8mCNmijkrHS+oazhybeKj1FCBOuN65rvQfX5lBR7yKLSCONc3YCXczddM1WdR73TBJYhhpT04+Y4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9722
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a9214b1348b44f219ff6881dbf4d49ed:solidrun,office365_emails,sent,inline:167ef90dd5433cf33d467578846ac289
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f8abf2f7-b4e0-44a0-6304-08de89a29800
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|376014|7416014|1800799024|82310400026|35042699022|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1mqJCDN+nOuZ7Xz1gtNNlrWXltuOreWp3ec8he8ILxQGde+NgjrYfc1TAnaHVhLe5cDh9xn8KdjsL0eQaGAlzy7c/FRv/T3yBx9lVu4iLy+rCuzXbL5QrEpuss/+0di+CUpAm+I5KNLmY5uCYZAS4ezWlxmoRDY7s323WCWdgcfM8+4qicTxbG4t+GN8b9BvgR+JCqmw1H3rVW+S9LilAp23oT0qGGIl48VdZZFnASrwJuVu/dNrFAZAZVx+sMJVGjW8r/0vU1AbMAyZ4E76FXJgBmRTpOCf+dmTNloaQtnArwrWo6BLjmtDAfHGquSSpd4q7HtnzVZiqXOXTkN2GcApipfePtE+lIDw/udXL0BZjc9m8gpzz5CUjy9/qBpz9oHVBh/61fEXarw2R/c/0HXG0tK0YW+I4GqGqliGV/Supv8OBWf+nPwMFCMw7TTMg1QliLsLTYDshyc5j6xvepAMYbG4WmRqQ9Ll098Rl7L1t6avn+xPloGG9iQsmLx/XQNqq/VDi4q254qY6dJwqOZ6yHuflo8YTTGxm/+Lo9xK6WB90r8XjcOP/vqF2Qns3K724eUw2sX0qIw+uVo8yk5cFNXSvcwcSTpEgbipERzh8nhOCrShpOcGLbqC70huWt642gk5npzy7Om0lStRYzk+jE6hqDi92ceL5twf9suGlb3u0rGlMRGMLnlsJpUZV39ZWXna0amQ9LR84npRkX1eOKSgu0ypY2EnbanOPP8=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(376014)(7416014)(1800799024)(82310400026)(35042699022)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/5H56ITSTy5mEBJNyTGy/cRf4XLUqk3hmnbY4NecPlNl6BdCE/RwNcSCls5zIgbD/4cjG2VPtHPllN0QvB/X0f5zUPeIQFs8FmKP1YRT5rGgJeVBLasQeqkfaQ+9W/j6iyKZL+tOGRYBfbEohe8BPld8x/qmKqDgn12YEBgYI40EEQY6ErBllcw+gxs0+fH9uYDrNgnFxlmwuPs2gV2zgE8AaURccFPMrLXWop5odAYEvQcFtYPP7yiWaXiN0c9znTXr9GY9dDo6COpMbZX5bbhpCY/qyzQ8tAU0Qhk6aWA5/caf4zH18nZAsFlpiq+i8KR9xGYX/WbklQGzzJ7wVwvhctWdnF0AyUEPZl0TbedrXU8+LkX/AL6A0kF2SatebQT8k6khD2UxrqLdJK4sxswX2rZ2ymQz0Pvp4cjw3Cd9jNRxzAnSG836q31gp2nc
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:41:29.5314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac43dd9f-3a2a-4cbc-68da-08de89a2abf3
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12302
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230153-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1C11A30875D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a bug with microsd card-detect & gpios pinmux on SolidRun
LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog.

Then make small additions to SolidRun board descriptions.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v6:
- added pinmux label renaming reasons to commit description.
  (Reported-by: Frank Li <Frank.li@nxp.com>)
- Link to v5: https://lore.kernel.org/r/20260314-lx2160-sd-cd-v5-0-83de721585e3@solid-run.com

Changes in v5:
- simplified lengthy commit descriptions on patches 1 and 7.
  (Reported-by: Frank Li <Frank.li@nxp.com>)
- fixed i2c6 sda-gpios reference.
- Link to v4: https://lore.kernel.org/r/20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com

Changes in v4:
- separated each logical change into its own commit, improving
  readability for reviewers.
- Link to v3: https://lore.kernel.org/r/20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com

Changes in v3:
- added separate patch providing all pinmux nodes for RCWSR12 register
- abandoned revert strategy, implement minimal fix for solidrun boards
  only.
- Link to v2: https://lore.kernel.org/r/20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com

Changes in v2:
- changed to revert problematic commit, workaround is large effort
- Link to v1: https://lore.kernel.org/r/f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com

---
Josua Mayer (10):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux
      arm64: dts: lx2160a: change i2c0 (iic1) pinmux mask to one bit
      arm64: dts: lx2160a: remove duplicate pinmux nodes
      arm64: dts: lx2160a: rename pinmux nodes for readability
      arm64: dts: lx2160a: add sda gpio references for i2c bus recovery
      arm64: dts: lx2160a: change zeros to hexadecimal in pinmux nodes
      arm64: dts: lx2160a: complete pinmux for rcwsr12 configuration word
      arm64: dts: lx2160a-cex7: add rtc alias
      arm64: dts: lx2162a-sr-som: add crypto & rtc aliases, model
      arm64: dts: lx2162a-clearfog: set sfp connector leds function and source

 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  10 +-
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |   2 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 183 ++++++++++++++++-----
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  10 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  19 ++-
 5 files changed, 180 insertions(+), 44 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260304-lx2160-sd-cd-39319803d8ad

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


