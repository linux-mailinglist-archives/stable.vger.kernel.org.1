Return-Path: <stable+bounces-161810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EACB03840
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74651894977
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75323496F;
	Mon, 14 Jul 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HyjAH8fn";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HyjAH8fn"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021118.outbound.protection.outlook.com [52.101.70.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BB1F37A1;
	Mon, 14 Jul 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.118
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479081; cv=fail; b=gKR3STzd/Ue42LTTvTHu4UyzyAgMM1t5NhZyFuMLCZVH/P0QDCUeWf6Yk9w0qgyM8EfjGKMRZXLcW375vrje9DzrKatF1FSIZu/ABHAb66+69buv8YKZOVhYYfG3OY9ff5OFpSCG2egcjE3Vr8pQn3Ftxx32GqGxfNvfln9MKoA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479081; c=relaxed/simple;
	bh=RqwZzwGixzkysEE1KajakjfYYwlqzGV+9AyM3SaVrdY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=eWcKH1jzeRdj/tMYxEIbXs/awKQkwZVD9ipYyFX6yDioF1PNjaCk7Dd4HlH5Q2PSJ1Z97RXfRQ2P0zRubYKmNOTD3ws9hkfb0RnmoNPofc9NLdcvVR+aMKlZynbrpB9sZNtsmgp13FSmCnHMUh5WwxQ/X2V4xYLemRZk4ve6F6c=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HyjAH8fn; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HyjAH8fn; arc=fail smtp.client-ip=52.101.70.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cWPcgAJ1Vz0as8zBDs1/WwVjIw3xUm7y43xyv9OMkBcpK0HOON7Ou+oE4oCotB8H5+p5dVvmpOzdaI4J6iXhpkq3dMJ9zSz3tZhbaqvB3jJguBC7fofRIf6W7ApCPrAuGfmweRetrVsZrc+yDavKPhNfg8CdA/yDuSQ00P/jqCYEyHHjTqwApN4WKoKbBbSnbNRtc1om3TSq5hobvmvt8W65CGhJ/XRHtOjUzyE1fr2qdRbYzboa2KEO05uWwTSaLFENS0RNx9Nrx7xZW4ngb96IRfMS9pQDajYkKhgoGWKcD/7D8wHOeLraHnbkyluF8s/2+YVluE9dFKjPKSq57A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Tp/l/YBXfmDvKEP4Zu1OxV6DAktNtP0kRM2uiVdtc=;
 b=QA5gK7SzTqvEWEPUelLfA3wcrNSYpZb8I1/bXP7DGKaYt7lM9wGBk8jT8+9pnrkYGjvHF5/J8Us/FKnP74DLRNW8T/RRVC9jDdEH+V6mkEFxprgQKx6Jud6suwZtHIxUhY6HovWfTmTiyP5S0N0bIcZuVqkwen94N3ii4jyCMye5Oa9nwE6EaCj8CqODXQsKHDs+iCghceRwdIuqHeOnr8NvXk2y97f7tsO/6TIGQpkuh2ZGyLplXOIMf9gjnSzOnIBpsWXjPJu2ik9w9dbAmBOZKTt+UfnR5bHybWBpZlEyNRggq6VPqD0aLPs+ep+h4goZd7BR67PEuAiRIZ1FIQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Tp/l/YBXfmDvKEP4Zu1OxV6DAktNtP0kRM2uiVdtc=;
 b=HyjAH8fn27ltCk8uCmT7RyVNXgzFufCkXU0krqbRrhwf2DBgKHEzHsxjGEj8yuzB94VfYYJI9YcvsinUX0J86Oyf6w+EZl8M6qsWSojoleMBnb0mJ0BcBHMV0ghVTnq0TL1UrhzRcOIisACq+dqGPj+y5jVztnCyj+l8MOgN35Y=
Received: from AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::37)
 by VI0PR04MB10137.eurprd04.prod.outlook.com (2603:10a6:800:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 07:44:34 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::e8) by AM0PR10CA0057.outlook.office365.com
 (2603:10a6:20b:150::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 07:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Mon, 14 Jul 2025 07:44:32 +0000
Received: from emails-7721735-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-132.eu-west-1.compute.internal [10.20.6.132])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 47E477FEEC;
	Mon, 14 Jul 2025 07:44:32 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1752479071; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=35Tp/l/YBXfmDvKEP4Zu1OxV6DAktNtP0kRM2uiVdtc=;
 b=P4NbSfiL3WOPJVCRg3UlJyFLTUhg1fXSBVMws1qZNNJwBpJzh6L88Y9kEQwoBkC2jutqR
 cuGPpyjrPeTlL5c3WQ2MMntpkUAkmvVmFdDnSMW5stxNiDwRWzOtw9yMkqJeHmCIwfOu0NY
 bI3sOoVH53lmvDSrS/N6LKY8W1WOu8M=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1752479071;
 b=D1vEP3l+xHGPfOzsbPD7XKmopcTBGI5mlRD0SA5DIZIlxWASE/4VuqtQSxalxqZq4clnv
 BD4ROlalAp5R6sZoUdWNnYBTUH7b0PrbN38HETVwfTLvhFofXbgz/uyAxnLWiDG2IBCO8XU
 Dckf/ftRbFLjL8gvwYBteL+XlZrZSPI=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV+Ffl06VfP6mkpg3ZqvcP3Ajj0ZUL2QNzn0yMN+P1qRDVUDB2cbLYBCmnN0Juq9YHAd+pB+hPgSmKccqRREyrZRr78Awjz131ZVmmSUExsQGDMILSb//vLj/hMkoBnoyDBvjrx5+9h2PVpa/1nzFyJfxLT7xrbQEW3PhNF7Lmf5SWOwdRbEKN6xh6tLekbZuVHTBi852Kb3doG56FcCtZCyx3mce9uSCH95bIPZo94IVypNE/N6Yrt5uEgy2NsT6Iwd1Xp0PxsWhXKe6fn3abr4ensUoWNAF1czudX4S49UVQvY4VfbYgkgO6neu9BXATc5lYWbyTonzYTL+/asfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Tp/l/YBXfmDvKEP4Zu1OxV6DAktNtP0kRM2uiVdtc=;
 b=kQKFysf67jM0vQHEbDk65Xh64FL2LeXQv0YB29gVViInv4H8kgyvw20y2lwiDQvvX6DjzIViiKgjfTnvoc1Lqs7DWXEZVBiWcMV0YrddjWtjYc1MbWgPA67ka6yaND2c6JAGfvqMfFEWryhowxVX/CUWllzXJ7XyNe87AnBFZZT1BVLcYlsvkdBz86nAnVPlEIQERclTXLxqCJH6xN1waFo61wBKYL5Xzf5KhhdB8Ac6+y5aO80q8FlaPCwo+JIoXp7PeATQ5PszykH5IhxL4EfNr7aaI70UwtPP6tpB/OcSPE4zB1K5E5nu8FyJTlbiNJLkPBtMSfwaHDkqVLd6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Tp/l/YBXfmDvKEP4Zu1OxV6DAktNtP0kRM2uiVdtc=;
 b=HyjAH8fn27ltCk8uCmT7RyVNXgzFufCkXU0krqbRrhwf2DBgKHEzHsxjGEj8yuzB94VfYYJI9YcvsinUX0J86Oyf6w+EZl8M6qsWSojoleMBnb0mJ0BcBHMV0ghVTnq0TL1UrhzRcOIisACq+dqGPj+y5jVztnCyj+l8MOgN35Y=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI0PR04MB10317.eurprd04.prod.outlook.com (2603:10a6:800:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 07:44:17 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 07:44:17 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 14 Jul 2025 10:44:13 +0300
Subject: [PATCH v2] Revert "arm64: dts: lx2160a: add pinmux and i2c gpio to
 support bus recovery"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAEy1dGgC/x3MQQ7CIBCF4auYWTtmgIKtK+9hukAYLEktBrSpa
 Xp3scv/Je9boXCOXOByWCHzHEtMUw15PIAb7PRgjL42SJKazoJwXKQwhMWj80h0D6q1LEzHUC+
 vzCEuO3fraw+xvFP+7vos/isEJZ3WUqMSRmJjq9K25LDrgmuMV9Yofy1pjB7zZzq59IR+27Yfv
 P0XN6kAAAA=
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
 Carlos Song <carlos.song@nxp.com>
Cc: Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com, stable@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI0PR04MB10317:EE_|AMS1EPF00000046:EE_|VI0PR04MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: 56498b9c-44ea-4661-ecde-08ddc2aa45be
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eDJobUFHK0FUS1ExdEp3Vzhwb1VqYWVacHVkYzdmZXNxZVpJUjZGNlFkUUpp?=
 =?utf-8?B?WkRQWDJ3RERZMkxMZmFyRWUvWldkV0ZRdFc1YW9Tcm5vSU90cjNVMjJkOE5P?=
 =?utf-8?B?dnErcVBOVVdESWlqc2g3M21Ga2hZU25sOFMvbGhmZEVKSVpld3RrdE9PeE41?=
 =?utf-8?B?aDZJYmFuZ2hsM1RzekhpODUzTThReGJlOXRpdzAxRVpqZlgzdnhLODBwbWgr?=
 =?utf-8?B?Z2p0VFlxa2pLRHJZM3JmUVArZEs0aUxVSDZPTXF0QW9YV0NoYXM5K1lSdkhl?=
 =?utf-8?B?R09Kbm5aV0hLRmhkOEppZnZiUmdTeGpVWFlkNUF6WitLWEdadVlNc2pqV2hY?=
 =?utf-8?B?QUJyL1lGNG9jbnljcjd3bTRkbm83VmoyVitUMHlHZnFEaHlROUxTT0tUUEJh?=
 =?utf-8?B?WlVYMGJnS2pGNm5NRG9yNEdlN0FPRlNpWXoyR0hXb2dZb0pwWm9SQUhwS3Ja?=
 =?utf-8?B?bEFiUVIyZ3A5RVdBSG95K0xGdkRmaDcwWWxGZUhJZ2pCZnIyTy9wb2pMcEhw?=
 =?utf-8?B?dVNCTC9oSmtRdytCQWZjcGZRaEo3RFF3Wk9SZG1FQzAybmlILzRRUTNLMFVY?=
 =?utf-8?B?SXBYSHNGNy81QjNvZGdsWFk2VERWWTdULzZ4bFZ5clg1emJ3SlhpT3J4cDZQ?=
 =?utf-8?B?ODB5VldYZzE1VFJYU2lKbkhnd3FvdE53VEpFZ2JCQ0dZdkZyUHlyV2lhTEFM?=
 =?utf-8?B?c0ZSMm9VR0xaeGVLQUFYVktoSkdrNkZLMlZFMzlxbnd1MmlYTGdQd3hydklW?=
 =?utf-8?B?eTk0eiszbGFhMU13dkJSRHpaR0NtTTFQd0Y0T1hYYld3K3hVVE0xQTVTYXky?=
 =?utf-8?B?QkFyblBpMTZ6aFp4VXlteGI0Sm5WT3dxcjdrbjhoSXhaQ2tWYjBHanc1Tmpu?=
 =?utf-8?B?K3VWRVNVSEZJdEJpSkhkNHlka2ZjUzdZZWJpV3g1cGFVZHZ3Y2poS0M1Z3Z6?=
 =?utf-8?B?VkdyUUhyMVhRVk1DSDV4QmVtWTI4RUJKd0JSOUFZV2xsNXdMckZBcm5MTTZi?=
 =?utf-8?B?aDIxelY3K2FoWE9sWWFpZm16OWhJQkF5UHhHNlVLcENYaWp2c3RDQjRnUDFZ?=
 =?utf-8?B?d3FBZzVuTGtIbGUzeDlod0U4eGFMRFFJVzZxeWJUendCbXF1MjNyVFNrMHk0?=
 =?utf-8?B?NzJjbjh4UmJVbU1Da0xIR1JSMFgzamFpckE2MGhBYWhkTTlETGVmZkxBZ3ZE?=
 =?utf-8?B?NTZ4VzZoQS94Y25rVktHZE1sTHFzaS9abTFyaWQvejZMZ0xMS24wV3V1STRn?=
 =?utf-8?B?bUFXTVZHRkdaQnU5TGJqeHozcmZtVVphT0R0UVJsT3lkMm1OWnhTRGlBWDNk?=
 =?utf-8?B?THdhaXN6eWk0TWIxdTNPQzR0TXI1Ym5YTEplYXY2RTkvdkloRGovYUdETWRz?=
 =?utf-8?B?UVZmczMzQ1pJTHZaYWIyd0Jnek95R29UYzZQa0Rrc0s1NlFWNXFvaUxNRFVX?=
 =?utf-8?B?a1V0bVA0RTQyYlFiK2VwWTByZmN3UGNmWExJQ2xLbUpnVXQ3bXhROGVVaHQ2?=
 =?utf-8?B?UkJ0UVJJWk8raVJheGhWM0lKNXJiL3hRQWF3TjFpYS9YZDJwWXYwVXZXcyto?=
 =?utf-8?B?TnB2QW53SHZMK0orSGN2SmZ6bW9Uazcyc3oyL2gzaDFJaWlreTRCVG9tZXg5?=
 =?utf-8?B?WlBkeHE4dHNkRklIMExWQTd6TFI2TEJnaEJGRms2UG5qU0NIbDZUUzZZUFlE?=
 =?utf-8?B?alY3cEIxTDR4ejArUUg5Vkhwc0Q2UTZ0WWxYMVAwQlVTMFhmazF2TkVKVCth?=
 =?utf-8?B?SCttVFpQblh0a2M4ZEd3b0dTLzZkaHZ3T3dFWE9yNFFZcFFJN2gyQUpkV00v?=
 =?utf-8?B?Y0RDNGFISm9iRm1GaW5lZzV4NDhyeFVaV1lVOXd3bHg0RXAxTUo2ekVYWWVs?=
 =?utf-8?B?QlZmQkthcEZjbmRzS29lSUFvbFBHdER3cUZuLzdRUG5TQXpiU2tLd3pTRlpE?=
 =?utf-8?B?NCtYTDBWQWJpanQ0b3NsN3B6S3FPaVVqdTJYTFk3OEFxdlRoN0E4RXJKd25h?=
 =?utf-8?B?dWlWYXRNb2pBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10317
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 5426c744aef54276902109fb97ade934:solidrun,office365_emails,sent,inline:beee2266ea080f6ea548a2e002906393
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	36fe9648-9629-446d-2f8d-08ddc2aa3c6c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|7416014|376014|82310400026|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clpXMTdhOEJyQkVXbTJOYllEdXN1MkpwYXliRmlmSTJydTZ5bjYreVdIMSsw?=
 =?utf-8?B?c3I1YUY0U0IwSzNnUjJacnlwdytDbEsvTTI1dWZkU0RQWEVuRm5zdXFWR2pZ?=
 =?utf-8?B?WW90azdEUDV5bFA3YkJVa2FGVFExZ0plMG1TTlM5NlJJU3hZV1l4VmY1U2lC?=
 =?utf-8?B?akJQWVNVZFJxd1NOTlpqbEw4cnJxdENuSWhXQS9raFM3MUgwU1JFeUNSTlI3?=
 =?utf-8?B?MVVoL0FwMENkMTA5VExYRmRxd0ZTcndaaWZNNFJlcWVIcFJOQ294T0RlYTh2?=
 =?utf-8?B?VzU0VDJQR2dMekhGSnBsOWxjdGtLTnUyVHJHWEpZNmkrbTJ2amlWNWJiU0ZX?=
 =?utf-8?B?SlNSaWM2M2ZUb3g3K3F5RlFlMFJrMTFnc1ZJL29ManpLdTRROEJsWW9OeVlX?=
 =?utf-8?B?QTI0SnNRYnN5QjdaNzhGT2RQNlBrZHd4NG1XaTJ6NGZSbTFkV2pNVFBRSGw5?=
 =?utf-8?B?VEQ1QnRDTGpnVko1RmRwWVRlY1EwdVBpY3NxVmZpL3UzM3BHNE9TcXJ3b09Z?=
 =?utf-8?B?U05rV3JDK3dQaFNlR2w3c3NuSXVqVHgwMjJxRGxDNitGL3V4eGdwZjB4aHIz?=
 =?utf-8?B?Q0lBTkVXbzdzd25PMFZuWTZ3UWtPZnhibWV5TUlxd09XSmM2MW55UE52OVkz?=
 =?utf-8?B?bGNTT2hJd0dub21MaHMvb3hhUnJobGxzVFlnU29yUGVjRFlkaDNMVThybGNN?=
 =?utf-8?B?U1EwaDVzUlF5a2t3d0hMWVVYZ0JqbTRTRlczdjhzQnJ3MWNUUS8wQ0JMWnQ4?=
 =?utf-8?B?cldaVVZKc1dMbUY4TzcrWWdiMmNteFhzYmxjdS9zV280c2FwTjVoQjhIWVpI?=
 =?utf-8?B?RDFlUWhXbXlhWWtOTG45dHZWeHBtZ3paK0NqTnJNVnVTWVpQelJZTXhlVThh?=
 =?utf-8?B?eVI1NjhjS0ttUmRpQjNOdjRScHY4a3JSZGJoc3BmUGNxRFplNmtoSVhWV0cy?=
 =?utf-8?B?YnB3bjR0cHFNeC82YUlINjNVaXZneStDYW1FM2hrQ2VPelcyOTJmNEgzMWpZ?=
 =?utf-8?B?eUtxYVZWZ0tmbllOMElBZHpDR0JTb0pnWGhSenRIbHBSd2F0YUFTZnl5bXNk?=
 =?utf-8?B?bkVMUjd3anRKelBtQ3RoRmhpV2dZZnBWMU1IK2tndVpTT1N0NXN3ZEc3Z2xV?=
 =?utf-8?B?end3R2lBU01YSGNoVldUaXJIejdlK0QrTVJicWFZaEFmYVU3bkQxbmc1aEFo?=
 =?utf-8?B?Z1d5Y1VjdlRlQVpWVEd0NTlKTUJGNWRBa2RuMG85dmMzOTBoMGhzZ1k0eXAy?=
 =?utf-8?B?dWZsN1dzaVBNamo0TEdUZExzalBwejhOa09wRjNiUXNzWDlBSWZDVXJnbk5j?=
 =?utf-8?B?MXRjVStST21zRFRZZncxcFJuQ243aFN2R0xlb2RnMWtXRlZUc2JDbHJRaU5N?=
 =?utf-8?B?VzRpNFNYcUJ5cEN6UFFPcEVFMURyUWdydjJ4WDNNbytoMU5IaU5qVlI0QnhY?=
 =?utf-8?B?dFg1cWUrcXd0NHdZRDB1aGxzY3F0WXZVWmZJcVFtZ2RQaU1yb1RGSGY4OHVr?=
 =?utf-8?B?WVR5ZzV5eGw4QTZzRTZvaFlnUXo2M0luWXhvbDJ0Z01YZGNncDF3dytqZHlZ?=
 =?utf-8?B?clVSMlRHQ0ZETGJzdFBhNXphZzROSXpiYTNLSXZNZmRHbnpYZmhCeDM0ZzR1?=
 =?utf-8?B?UWtyemZxaGVwSDdwVkY3cmwzeExqUGtLNnp1Q3VyQnk5emlBT3lvcy9BVkhu?=
 =?utf-8?B?clUzZ2JUdmV2QVhaTTFkNDUxYlZpbmtJa1Z6MlBHWXVXSXo2WDFyK2J5dlZR?=
 =?utf-8?B?NC9EcDdiWXZsZnlvLzI2cFcycUxxbzBVY2o5MVdxRlJLRTQ5dTVSNHZqRFBp?=
 =?utf-8?B?K0t2MUUvbVN4YjB2aEpqZGMwNjJlUUY1VTdDYysyelI2R0EwN09MelUzZk1m?=
 =?utf-8?B?SktoNXo4amFuOUM5SGVGbHM3UlFKRFBja1B1Qmc0OXYyZml5L3d2RFBlSjNa?=
 =?utf-8?B?dVd1K3FJQ1JQUC9wVkZOcmRWM0J0ckgyNEY2bzFRZjVNendVdmdlSHE4QWZs?=
 =?utf-8?B?SEx3THg0WTcyNDBSWmFnSDRzV2ErRThuV3VNNTJ5MXZRNG5Heng4VVBud3Ju?=
 =?utf-8?Q?frR1rl?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(7416014)(376014)(82310400026)(36860700013)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:44:32.5964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56498b9c-44ea-4661-ecde-08ddc2aa45be
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10137

This reverts commit 8a1365c7bbc122bd843096f0008d259e7a8afc61.

The commit in questions most notably breaks SD-Card on SolidRun
LX2162A Clearfog by corrupting the pinmux in dynamic configuration area
for non-i2c pins without pinmux node.
It is further expected that it breaks SD Card-Detect, as well as CAN,
DSPI and GPIOs on any board based on LX2160 SoC.

Background:

The LX2160 SoC is configured at power-on from RCW (Reset
Configuration Word) typically located in the first 4k of boot media.
This blob configures various clock rates and pin functions.
The pinmux for i2c specifically is part of configuration words RCWSR12,
RCWSR13 and RCWSR14 size 32 bit each.
These values are accessible at read-only addresses 0x01e0012c following.

For runtime (re-)configuration the SoC has a dynamic configuration area
where alternative settings can be applied. The counterparts of
RCWSR[12-14] can be overridden at 0x70010012c following.

The commit in question used this area to switch i2c pins between i2c and
gpio function at runtime using the pinctrl-single driver - which reads a
32-bit value, makes particular changes by bitmask and writes back the
new value.

SolidRun have observed that if the dynamic configuration is read first
(before a write), it reads as zero regardless the initial values set by
RCW. After the first write consecutive reads reflect the written value.

Because multiple pins are configured from a single 32-bit value, this
causes unintentional change of all bits (except those for i2c) being set
to zero when the pinctrl driver applies the first configuration.

See below a short list of which functions RCWSR12 alone controls:

LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
IIC3_PMUX              |||   |||   || |   |||   XXX    : I2C/GPIO/CAN/EVT
IIC4_PMUX              |||   |||   || |   |||XXX|||    : I2C/GPIO/CAN/EVT
IIC5_PMUX              |||   |||   || |   XXX   |||    : I2C/GPIO/SDHC-CLK
IIC6_PMUX              |||   |||   || |XXX|||   |||    : I2C/GPIO/SDHC-CLK
XSPI1_A_DATA74_PMUX    |||   |||   XX X   |||   |||    : XSPI/GPIO
XSPI1_A_DATA30_PMUX    |||   |||XXX|| |   |||   |||    : XSPI/GPIO
XSPI1_A_BASE_PMUX      |||   XXX   || |   |||   |||    : XSPI/GPIO
SDHC1_BASE_PMUX        |||XXX|||   || |   |||   |||    : SDHC/GPIO/SPI
SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI
RESERVED             XX|||   |||   || |   |||   |||    :

On LX2162A Clearfog the initial (ant intended) value is 0x08000006 -
enabling card-detect on IIC2_PMUX and some LEDs on SDHC1_DIR_PMUX.
Everything else is intentional zero (enabling I2C & XSPI).

By reading zero from dynamic configuration area, the commit in question
changes IIC2_PMUX to value 0 (I2C function), and SDHC1_DIR_PMUX to 0
(SDHC data direction function) - breaking card-detect and led gpios.

This issue should affect any board based on LX2160 SoC that is using the
same or earlier versions of NXP bootloader as SolidRun have tested, in
particular: LSDK-21.08 and LS-5.15.71-2.2.0.

Whether NXP added some extra initialisation in the bootloader on later
releases was not investigated. However bootloader upgrade should not be
necessary to run a newer Linux kernel.

To work around this issue it is possible to explicitly define ALL pins
controlled by any 32-bit value so that gradually after processing all
pinctrl nodes the correct value is reached on all bits.

This is a large task that should be done carefully on a per-board basis
and not globally through the SoC dtsi.
Therefore the commit in question is reverted.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- changed to revert problematic commit, workaround is large effort
- Link to v1: https://lore.kernel.org/r/f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 106 -------------------------
 1 file changed, 106 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c9541403bcd8..eb1b4e607e2b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -749,10 +749,6 @@ i2c0: i2c@2000000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c0_scl>;
-			pinctrl-1 = <&i2c0_scl_gpio>;
-			scl-gpios = <&gpio0 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -765,10 +761,6 @@ i2c1: i2c@2010000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c1_scl>;
-			pinctrl-1 = <&i2c1_scl_gpio>;
-			scl-gpios = <&gpio0 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -781,10 +773,6 @@ i2c2: i2c@2020000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c2_scl>;
-			pinctrl-1 = <&i2c2_scl_gpio>;
-			scl-gpios = <&gpio0 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -797,10 +785,6 @@ i2c3: i2c@2030000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c3_scl>;
-			pinctrl-1 = <&i2c3_scl_gpio>;
-			scl-gpios = <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -813,10 +797,6 @@ i2c4: i2c@2040000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c4_scl>;
-			pinctrl-1 = <&i2c4_scl_gpio>;
-			scl-gpios = <&gpio0 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -829,10 +809,6 @@ i2c5: i2c@2050000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c5_scl>;
-			pinctrl-1 = <&i2c5_scl_gpio>;
-			scl-gpios = <&gpio0 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -845,10 +821,6 @@ i2c6: i2c@2060000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c6_scl>;
-			pinctrl-1 = <&i2c6_scl_gpio>;
-			scl-gpios = <&gpio1 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -861,10 +833,6 @@ i2c7: i2c@2070000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c7_scl>;
-			pinctrl-1 = <&i2c7_scl_gpio>;
-			scl-gpios = <&gpio1 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -1700,80 +1668,6 @@ pcs18: ethernet-phy@0 {
 			};
 		};
 
-		pinmux_i2crv: pinmux@70010012c {
-			compatible = "pinctrl-single";
-			reg = <0x00000007 0x0010012c 0x0 0xc>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-single,bit-per-mux;
-			pinctrl-single,register-width = <32>;
-			pinctrl-single,function-mask = <0x7>;
-
-			i2c1_scl: i2c1-scl-pins {
-				pinctrl-single,bits = <0x0 0 0x7>;
-			};
-
-			i2c1_scl_gpio: i2c1-scl-gpio-pins {
-				pinctrl-single,bits = <0x0 0x1 0x7>;
-			};
-
-			i2c2_scl: i2c2-scl-pins {
-				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
-			};
-
-			i2c2_scl_gpio: i2c2-scl-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 3) (0x7 << 3)>;
-			};
-
-			i2c3_scl: i2c3-scl-pins {
-				pinctrl-single,bits = <0x0 0 (0x7 << 6)>;
-			};
-
-			i2c3_scl_gpio: i2c3-scl-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 6) (0x7 << 6)>;
-			};
-
-			i2c4_scl: i2c4-scl-pins {
-				pinctrl-single,bits = <0x0 0 (0x7 << 9)>;
-			};
-
-			i2c4_scl_gpio: i2c4-scl-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 9) (0x7 << 9)>;
-			};
-
-			i2c5_scl: i2c5-scl-pins {
-				pinctrl-single,bits = <0x0 0 (0x7 << 12)>;
-			};
-
-			i2c5_scl_gpio: i2c5-scl-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
-			};
-
-			i2c6_scl: i2c6-scl-pins {
-				pinctrl-single,bits = <0x4 0x2 0x7>;
-			};
-
-			i2c6_scl_gpio: i2c6-scl-gpio-pins {
-				pinctrl-single,bits = <0x4 0x1 0x7>;
-			};
-
-			i2c7_scl: i2c7-scl-pins {
-				pinctrl-single,bits = <0x4 0x2 0x7>;
-			};
-
-			i2c7_scl_gpio: i2c7-scl-gpio-pins {
-				pinctrl-single,bits = <0x4 0x1 0x7>;
-			};
-
-			i2c0_scl: i2c0-scl-pins {
-				pinctrl-single,bits = <0x8 0 (0x7 << 10)>;
-			};
-
-			i2c0_scl_gpio: i2c0-scl-gpio-pins {
-				pinctrl-single,bits = <0x8 (0x1 << 10) (0x7 << 10)>;
-			};
-		};
-
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250710-lx2160-sd-cd-00bf38ae169e

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


