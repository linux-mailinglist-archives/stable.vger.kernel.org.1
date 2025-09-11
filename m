Return-Path: <stable+bounces-179285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF3B538E5
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69449B64BF3
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799E356905;
	Thu, 11 Sep 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ZKq85ukR";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ZKq85ukR"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021096.outbound.protection.outlook.com [52.101.65.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508A3568E2;
	Thu, 11 Sep 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.96
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607261; cv=fail; b=AKU+ROVmRVAdzTI1OME/5pBPJ04N02S0XCEbCbh8ERkbAiWwVoOSh4nVRlYiW5n+7rSf1YHStBrqj05Px+m9lJoWBs0mympkiEFh4qjxVSCUbpvEmrsYLWGBU76S+U3q+A4SsWwZZoz2bm/1+URXc7tWt+BPkS/AhF2HAmPXYt4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607261; c=relaxed/simple;
	bh=D2H3OXrSwkb6k3LfRX/q8pT7qaENyZXI2u1l7tdxAxE=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=NC68SOz8xVtWetTSKERnJwe9ajRMjd/s7TumDkOjOOcQjMp5t6eM6rymcyyw8RIY2tNNbty2GN351s6EqqGXzPIJ7v4xbsz7wfy+ClSA5JdUw4PrKciQ5BdPj7IPgXro65BKoYsZpWm6oIboLujV7M0rGeMgenNo3DJ+6IYYl4c=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ZKq85ukR; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ZKq85ukR; arc=fail smtp.client-ip=52.101.65.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=V0mO4ME9MtjomfDZJyRU7JvRa31ht9PPSAuWm5solL/kFR4xDnxKbR8pnLHaYjRa4PpgCGOoUqVvpyX0IMy3SiqTAQ6kMDiQ33XK4CBFM4YTZ8b7ZFSzlLT6mGdNF51JKUf4kCfJT13yJdVbSiqbs0ImCAifgWNef+ZvAB+Il4344IcIp0xHUhaiFxtkSNYpUrK0hS2WzXyZebbM0F8rzfdII8fqBEJxYspUObrRXUEWkHZpTse7QLXEuCBknwXKK1Z6qlKlOo+2EdfZAfKwvO11s2vVGlwkgPuGemzbmjvqPh+BZ6Nvr7wVkoKQTKN+SAjzxfSJU4V9UNcU/22w1w==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR743wMyCmhR7+Iq312t1zCnWmP6CReIiW9ZJxNmkrg=;
 b=OlWIBT+SaMOtOZ3kkAOu70fyr4S1OVOeQV7gNx5fH9/R2SoStUfKMpNi58t64ofSb1kYcElWAmTyRb20MYt0ilnM8zxxaldbAU5gLlrkBmaiEWMmJ/axb/DMiiXI28POzT+je6cdTG8zSJk/gugje9ioeaCboZH7AJVWxpwrli+v6lMFCckC/997gG0LVTJx1MXlPjlofof8YmGhGu9ftpZJ6WPlKAWIcw5d5PjOV8Q3cLY2XVRq6VPmWu+nv3+2G9TqltygygtsFIBrgn+CoXkUbcjJuQk2zghL8HjLnrpXLGK9XcoiZz1r/GEU/getfT+T41ummfstYMRv/yp+mw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR743wMyCmhR7+Iq312t1zCnWmP6CReIiW9ZJxNmkrg=;
 b=ZKq85ukRG5Cu4Dtgnp4b8XTJeRdTUrWmkHlNF8oNiJ25oeCwJ90AusLxT/Cepj6XLIdPMypKVe76fZ/d89MZG7ei++5ZiYIkmPPwndXTwjbLZHtx5z46hxZwtFPhBzz5AV9I1I6IxqL+OE6cjm6JtjZOCAF66y+MN83+n0dVqc0=
Received: from AS4P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::15)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Thu, 11 Sep
 2025 16:14:13 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::35) by AS4P192CA0021.outlook.office365.com
 (2603:10a6:20b:5e1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 16:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 16:14:11 +0000
Received: from emails-942396-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 6027B8060F;
	Thu, 11 Sep 2025 16:14:11 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757607250; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=vR743wMyCmhR7+Iq312t1zCnWmP6CReIiW9ZJxNmkrg=;
 b=h4/rVNCOvvsv+h2DAUij5aeB7rmBT6Ae9DKlbtag11uc9omPFL5Zt/mzz/BubtiUmRx4v
 taa7m0kj/xfXc+jmEDLpyYcxOmtL3e/JtcZqr/97xx2o/ZjxD2XzTQKdwTrhjk0cy29KQ/e
 IvTNMl2SkgFhO3qYrE58l5XgV3dNAZo=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757607250;
 b=A9cTmgJNENSRlmgV5AVe51QaSCrxO09ZYmdNKnpdpj9vZRYVA/UdIHyGS7f2iYxwBwQVL
 h4NbGGgUUEOSHy0Y0TaZHRfdweACv21L4GAOZTsw/E38mbVzbJTCOXr5OjSlsVVe5cXpGtd
 pALF0XGVeuQpEHQqae3+f3CnWrPbanA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihmDXR5fT7ifRlBYfChsI3xaQMY/0GpS2Fwsf5eunIpuK6pyK7Nl6ankzcyqsMEdmbQWufsO0bxpgARFKAZHYJKqRMk3DiKV3wSdQjh8w7K9LxtlrAJWJ/3Mujgh/RQxbV3tEDipYN/H/Ff9lzDkbcj1ru9BaBrZK2d8bxHJTd3nS1aOvCk+SUUm+LFLZCQBMgfv6Zd+o11ebxjK6Rj4cLejGBnYavc7D54lO4c+teObZ7kU5bABDKm2auhQgGaOSr9k+lb0JgWeaS57JEbTROyxwcAoUEHW1I4GC4DktU+rzstncPZOAzhtJjdcPBvumh5v6NwwgTYbDWAF+cw1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR743wMyCmhR7+Iq312t1zCnWmP6CReIiW9ZJxNmkrg=;
 b=tAbgNDPg+uDo3i04VDrwznTenYCE57L+KJwX0cTNNpHVULIsZg0+3jb1J6lagmAbi3BvU34Ou2uKNTOjCDHukoCuXZvrcpNqQrRKrsBmlHGXq24rTiUt9dj2j4q9luuSSUFqUth0ZRizTF6BiKYjVc6Rhv4Fw5q+FuUQIiCj+GwJdfmK8kGUWgyYWe21sbPfWuNj87BoT8Q24GC05BVZ6uyLSW+M7IN2Hgu2XSL7PFw1IJw7BThT5s3Hf7orG2MIDRkPEC+M0bT040iGFJU+zqgwX8N9TeZxHt+z4qcgbdDhJqHi3wGb4p0/ykzu5/QIKTT/QV0p/Gi4CFwB8uTqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR743wMyCmhR7+Iq312t1zCnWmP6CReIiW9ZJxNmkrg=;
 b=ZKq85ukRG5Cu4Dtgnp4b8XTJeRdTUrWmkHlNF8oNiJ25oeCwJ90AusLxT/Cepj6XLIdPMypKVe76fZ/d89MZG7ei++5ZiYIkmPPwndXTwjbLZHtx5z46hxZwtFPhBzz5AV9I1I6IxqL+OE6cjm6JtjZOCAF66y+MN83+n0dVqc0=
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by DB9PR04MB9722.eurprd04.prod.outlook.com (2603:10a6:10:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 16:13:54 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::fe8:fd92:aa32:e816]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::fe8:fd92:aa32:e816%3]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 16:13:54 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 18:13:48 +0200
Subject: [PATCH] arm64: dts: marvell: cn913x-solidrun: fix sata ports
 status
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-cn913x-sr-fix-sata-v1-1-9e72238d0988@solid-run.com>
X-B4-Tracking: v=1; b=H4sIADv1wmgC/x2MSwqAMAwFryJZG7AtUupVxEU/UbOp0ooI0rsbX
 A3D8N4LlQpThal7odDNlY8sovoO4u7zRshJHPSgx8EphTE7ZR6sBVcW+MvjGK2xFFJwdgUZnoW
 k/afz0toHWUJMBWQAAAA=
X-Change-ID: 20250911-cn913x-sr-fix-sata-5c737ebdb97f
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To AM9PR04MB8747.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR04MB8747:EE_|DB9PR04MB9722:EE_|AMS0EPF000001B3:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ee4a84-de9d-4310-9a38-08ddf14e3ea8
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Sjh6UXJScGkzZHdsUk0ycVRKOG9DMHdzVTJ2dUF4T1RoQytJY1MxRW00VzFx?=
 =?utf-8?B?aWZYd1ZpT0JvWTYrdk1NWjZNcGl1emlJZ0x2bWduY3pJa25vcFN3dlVOMVVG?=
 =?utf-8?B?YXpnZXdvL0RCM05uaFJYdEloMTdKZmw4ZXkrZzY1VUdPVWM5eFlxUGE3WDZR?=
 =?utf-8?B?dE9ITUhhaVdSWVVNMURuSk02bmVDcEZIWDdtNHcwWmFlbHJlRGtoTWE5ZTZ5?=
 =?utf-8?B?bGozcVI5YzNqR0ExNGt3Ynl4Q3BvTGkwSkVBTHg0VXd1ejBwTUlLZ0VmWExa?=
 =?utf-8?B?U1NCVFl4M1VmVnNOSTZ1dGZmWmxTUlVZMlhnY1owZ1k0U2l1VUxtcWY4Lzk5?=
 =?utf-8?B?QXVZMEtPaHcvVDdCczg1VHNhSk9peUFVdjYzR3lTZytnd2oyNkRtVDFmazJU?=
 =?utf-8?B?NVpPNEJvWmRldWVJZFVnMDF5WG90UDVqOTJBaHZBTXhOZEY1TjhuQmUyZXh3?=
 =?utf-8?B?bGRLNkljU1o3ZEhOOEdNeDlwVzhNTXQyejFybjNtZDR5Qk9LZG0wWHg5NXFt?=
 =?utf-8?B?bEdudXhhUlpNa2FjQ1g3R21BM1V5NWdqNjl4VldldWZmaFJCSUdhdDlmczJs?=
 =?utf-8?B?SEpBRUNPWXdMcEVvTDBSUjJVUmQySnVzSU41NkVyalR4T0tmcTdZY1Y1TFl5?=
 =?utf-8?B?elQrT0JMYWdaQTdPWDhtS3lrVnNXSi9vWWhvSGU2dVhOaUl0b2JHTDMyc0pB?=
 =?utf-8?B?bHNvSWxpVEtKeWFFL2pvbHZGMUQ4VGFEZnVlVFZlYVRrOXFYVjdicnpNcUha?=
 =?utf-8?B?TmN3MXNMQVJFa1hla1RpaTFCdmROL3ZEcktiM1VXZGV0YStaM0xXdnBXLzhZ?=
 =?utf-8?B?cms4WE9LbVc4TitOOTRJZ2JJNnBGQncyY1c5WDl2eXF6RkZRMnBiVFB6Nkhy?=
 =?utf-8?B?Sll1YTY2RThKMG5UYWVEdGExYkZleVdYRnNib0gvanlGd05ZR09lUFRWSTUv?=
 =?utf-8?B?UjFXdVk0eWJXMU9wUUIwL2V1OXdIenVhbDltUzhIODJ0a1M5a3dqS1NpSlFl?=
 =?utf-8?B?aEIzWi91M1V1ZkdDN0w0NThDOFZ5L3didW91ZWptaTkwWHdkK0ZYRC9qTjdF?=
 =?utf-8?B?VFp1TndFMlNKUXIvNEwzVnlDOVBRR1IwTnlSWVNqRzZDVDVPWFZ2U3pFTkQ0?=
 =?utf-8?B?c1VEVElLaGRQWWNqWVlWV1JoTGdpL0ViUWd6SjNWdDRxMFBnZTF0U0dCc082?=
 =?utf-8?B?a2ZldTIybXV0R2NFaklhRGZuazBTOStNcHY5aVlYYlIvV2xNZ0p1cXU4Rnoy?=
 =?utf-8?B?N2p3bjVDd3JjdzllRDZiNmdDUzhjZG1yeGg1MGdGS3VncmdWaHdxUWFNM2hj?=
 =?utf-8?B?WTdzOVlmaWtvdThadERKWUVhSHU2aHE3MkhnRlVnRTdhNEhKa0ZXL3V2ME1N?=
 =?utf-8?B?M1I5SVpZVUZ4RFoyTWVsNmlITXhZMW1vRS9IN29aanpjSjBhVnhkOFQ1RGZF?=
 =?utf-8?B?ajJBdzF3YWd6eEdtckVIWlJ1SkM5SzJWU01zVk5RYkcvR0hFWlRqTjVqd3ZV?=
 =?utf-8?B?dzVsUytsNHhFV0RpS25KYlNqWGhIMzdDU2FQU1JYa2hFMFpuQmhObzl5Ny81?=
 =?utf-8?B?MndaQTBETC9INDEwTGlPKytRbmpyUjVRajlLYWhpWFU2TXZWWHZCRkp2MTRO?=
 =?utf-8?B?aFlMOVlmd0xXZWw1SmtJRmdoWE00TEJpSERhdEhJLzNLRWcvNzdvS0J1MFl4?=
 =?utf-8?B?ZHVzRnFEZHlBTEo5OGMxblpSK2lTanJqTlNDWHR3S1kxZEkzTTVpSEhLVng4?=
 =?utf-8?B?OTI2enBISVhJbk02a0ZtUC9laXhEdnF4T3FaWkpzYzBzQ2FEdlFmcVIxYXpx?=
 =?utf-8?B?RHQyZDhBSDlRaSs4ajU4SUs2NFdDdDlpUzFGQWNDSWdaVnBDQ0pNUExKWkJu?=
 =?utf-8?B?UENMcVpUSzZmakptQmR4MXZsS1ZnU3R6aUlJQmh3ZVQ3bnZpWHZWQWFjb3oz?=
 =?utf-8?Q?sTjhR/BAKYA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9722
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 7ec8b9fa17114eb69432277b43e0bcf4:solidrun,office365_emails,sent,inline:80f421753e7d738e92e1b0e1cc69c744
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9a1660b7-f659-47d9-9782-08ddf14e33fd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDZLREJUdjZpZDFWdVJNY1BFS0g3U2tsU2N2UWVOMWdoZkNRY29kTXlFdSs2?=
 =?utf-8?B?SEZSandoMW9DVGRJOVhwRGlkUi9ZWmh0S21CdzExYUJFbldRSHEyZFhJWkE5?=
 =?utf-8?B?RUFvR2xZNTh3WUQwQVROZm5LZ2NSMGZPZGkydlhSeitMemFPL3pSS0JMdk93?=
 =?utf-8?B?NE5JMzJFN1c4cGhyTGdYZFM2R0E2SXNZODNVejZSdVE4Sk5lU05aVXZvU0FI?=
 =?utf-8?B?TVJYeDUzdW50aEYrdXVmMzNSRm5KeU9GaGVoNk9tTTJVaWdGa0g0SXhEZ0RM?=
 =?utf-8?B?UFNqOTlwelBpbitpZ3hOMXRON3ZYb1RYRkVkRDFhdlFXbUNtS2pUZG5tMDdD?=
 =?utf-8?B?dTFKTjhFbjZYelFaUnlrNmo5WVFqN0F3UHFzOVcrU2VKbWQyYUVzK2tyTVFy?=
 =?utf-8?B?aVpjbHFWUGFXWk1mNFRoUG9uMFVTSVo3bTN4Mm5zZFpBUTZlVnR6RndXWkk2?=
 =?utf-8?B?cVMwdzVVR3gwWEVISnpWcUx0YUZ1SU16YVQrdDhnWGU3UDVVN05QZENjdVh3?=
 =?utf-8?B?VjBUZVJQREgwRTNia2hwVWhnRmZEc3RIUDdKazFnVzZ2NWh6cG10MkUvSmJW?=
 =?utf-8?B?emUyZTNzVHEwNkVTMXVOWXN1Z081akVoV3h1WWhER09aMTBET2dhNEpFTmVU?=
 =?utf-8?B?VzE1eHF3QW4xNGsxd1FGTGJZaWNZajlVMjRmdC80YTJ6NVd1dm1EQ2VzaTU3?=
 =?utf-8?B?REE1eGlpMWxSYWlUUFIxWnh0NnZmSjk3enlxMHh1bzlsZWRTeEZuZmYwM1lY?=
 =?utf-8?B?ZXVtRjNrVjJjakFjOVE4eCtnMXdZU1hYdDNVaXZoYmxWY29PQm55dnhDN2ND?=
 =?utf-8?B?T2ZxUzg2bXJJTEJnN1pDc1BScmNFcFFJRFhHYkkvcEVtejVrY2hiVDRjWGkv?=
 =?utf-8?B?OWtkdVcvUzZZT2dYNVR3Vlp2ejJyYVdUd1ZsT2V0cU9aM0dOOUxqQUJhYllj?=
 =?utf-8?B?cnR3bldUYWNuRFFyUEdFdi9SMkFyRTdyNlowZEU1TkJ2b2VTdU13ZXFuTXJ0?=
 =?utf-8?B?L0pOaDhlSC8xU2RKQnlyT2wrSDB3NkZMYy9ockJZSXhYSnRGTUZwNFFtbE40?=
 =?utf-8?B?U3FIYWtpUXJydGNtV1grSnhYN0JVVE5aQkwrZWFOMkJwemJRK0YweENodkVI?=
 =?utf-8?B?MVZrZXJWeGcvaWhZc1N1UC8rRlpZNzVmK2IxVW12cEdsUld4UGZmTklacEtN?=
 =?utf-8?B?UnJlQWJjc2lONDFiU1k3OUFlZ2hUN3NlTlphdnVNOXpvTFBFRGo4cndvU0xK?=
 =?utf-8?B?VXEvVTlqVTdHdGQ4RHhoY3pnU2ptaEJCVVdQVXVlTlZzY3ZIQUpBWnFuRlMw?=
 =?utf-8?B?OGMyYm5Wc2hpYlZtNUREWUM1eXFkQ2NCN1ZnMUkwOVhFUGhDc1BQUklmY1RX?=
 =?utf-8?B?UnUxeGkrelRPUGhmVmFxZEYwUTM5czkxVFFBSmozM2tGNm01VkFBMVhaZ0RV?=
 =?utf-8?B?cmhQeWlpdFJnWEFoNW55anJmR1huSWw5ZmJ5YTNGb2htRHJzemhNMDh5VCtZ?=
 =?utf-8?B?WkRKbCtvaDhuMU50eUdYb2NDNi82Z3NGMTJOWXc0M1doYnZRc09wWFNVb2ls?=
 =?utf-8?B?bXd0NDBoTDdYaUkzN0xYd3JmR2gwaHRwMGpMSTJpSm5mMmx6TzY1dEdNejEv?=
 =?utf-8?B?TlpWM0c3K1JlWGJRK3V0cko3VmJhSytHUkhOZGt3OFZvNlk4cFRTaitpOTBX?=
 =?utf-8?B?UjRiVG9FZW05Y2JiRTFsdG5VWTZ0UXBMNDU0Zm1Na05mb3Qyb2tFYzhoY3FF?=
 =?utf-8?B?TEl3OVZKR29JVlBlUVlLTlFFN1RMUTdHTUFVUkNzZGplTmV1ODAvZVZscG5L?=
 =?utf-8?B?dlNOYkdZS3lPUWFCSHF4Q2RiTFFaUERWRE5EY0RaaHVBQmtMdDVOZEJmbHlB?=
 =?utf-8?B?c3JxSC9IS05VejJLQW42bCt0YnpzWkprb1RaRnJwM0xseWhtdjQvMVBDMndP?=
 =?utf-8?B?bTA3dHkrUG42TG1VTEF6dmZGeXluMWNOa0xtTnZwb0Q4MUh2TFFOM21lcyta?=
 =?utf-8?B?amlJYk1ldk1Hc0tMbS9ocUs5NDFkU0VyZTBRODdJVGVkZFdOaVJ2R1lxMDBZ?=
 =?utf-8?Q?LWoJqA?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:14:11.6582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ee4a84-de9d-4310-9a38-08ddf14e3ea8
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018

Commit "arm64: dts: marvell: only enable complete sata nodes" changed
armada-cp11x.dtsi disabling all sata ports status by default.

The author missed some dts which relied on the dtsi enabling all ports,
and just disabled unused ones instead.

Update dts for SolidRun cn913x based boards to enable the available
ports, rather than disabling the unvavailable one.

Further according to dt bindings the serdes phys are to be specified in
the port node, not the controller node.
Move those phys properties accordingly in clearfog base/pro/solidwan.

Fixes: 30023876aef4 ("arm64: dts: marvell: only enable complete sata nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 7 ++++---
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 6 ++++--
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 6 ++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
index ad0ab34b66028c53b8a18b3e8ee0c0aec869759f..bd42bfbe408bbe2a4d58dbd40204bcfb3c126312 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -152,11 +152,12 @@ expander0_pins: cp0-expander0-pins {
 
 /* SRDS #0 - SATA on M.2 connector */
 &cp0_sata0 {
-	phys = <&cp0_comphy0 1>;
 	status = "okay";
 
-	/* only port 1 is available */
-	/delete-node/ sata-port@0;
+	sata-port@1 {
+		phys = <&cp0_comphy0 1>;
+		status = "okay";
+	};
 };
 
 /* microSD */
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
index 47234d0858dd2195bb1485f25768ad3c757b7ac2..338853d3b179bb5cb742e975bb830fdb9d62d4cc 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -563,11 +563,13 @@ &cp1_rtc {
 
 /* SRDS #1 - SATA on M.2 (J44) */
 &cp1_sata0 {
-	phys = <&cp1_comphy1 0>;
 	status = "okay";
 
 	/* only port 0 is available */
-	/delete-node/ sata-port@1;
+	sata-port@0 {
+		phys = <&cp1_comphy1 0>;
+		status = "okay";
+	};
 };
 
 &cp1_syscon0 {
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 0f53745a6fa0d8cbd3ab9cdc28a972ed748c275f..115c55d73786e2b9265e1caa4c62ee26f498fb41 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -512,10 +512,9 @@ &cp1_sata0 {
 	status = "okay";
 
 	/* only port 1 is available */
-	/delete-node/ sata-port@0;
-
 	sata-port@1 {
 		phys = <&cp1_comphy3 1>;
+		status = "okay";
 	};
 };
 
@@ -631,9 +630,8 @@ &cp2_sata0 {
 	status = "okay";
 
 	/* only port 1 is available */
-	/delete-node/ sata-port@0;
-
 	sata-port@1 {
+		status = "okay";
 		phys = <&cp2_comphy3 1>;
 	};
 };

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250911-cn913x-sr-fix-sata-5c737ebdb97f

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



