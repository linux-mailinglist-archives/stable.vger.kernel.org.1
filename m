Return-Path: <stable+bounces-179303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3530B53B60
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FEB54E2FA1
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB9369973;
	Thu, 11 Sep 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dDCpe/GY";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dDCpe/GY"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023081.outbound.protection.outlook.com [52.101.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C91C54A9;
	Thu, 11 Sep 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.81
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615326; cv=fail; b=fvnk6ymAFtXU7jbN88WSh/K87EwiK1Z+I2SlVUj6Xajs/hjymU9JK14GgelZURPQIyxtDpBIWfqcuRXXWZ0ZWkk8GuoKsncbhDwOyYIr/T7HJYpx4pE2RoqBRznXtj1B8vXs2NLhc32KL626ZOVIL/8mM1droFBv4wcQfOgKb28=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615326; c=relaxed/simple;
	bh=jhMZhqkB/mR2FDovw/G9d40icME0WpwdNH09Y1C6q/0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bgFndd5QIld/4fYC82PklnjQTxbpgS1Xz1g9ApsTks13IWKvApfbvilc/Jgz1kxsiFBgDYO493x0FlTmnXjW/aUr+qEpnw72Lm/iKH7RVCSdQ28Cp5T23I+UFoIl1xTDxBK01etkDi9NyNtvyD+0ntLB0UOzsHvsZhcbarOekLg=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dDCpe/GY; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dDCpe/GY; arc=fail smtp.client-ip=52.101.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S3a3RHp3SEftDSg2yTTMspbD5GYMdG6zQelS99ZBkHscoQT5ZTJazdcgM+Fm8zs3dNW6RUT51guAkno48lRfK+ciWFHpc/4mqinY4n13KgSFdUjC6L4ZZsGWGO4UusREOMJPFdE3DNTbuuVZTuRvziExJHPKdPtkCspncQbgr4rwwc5IGZmlbe0PLdXGMG00spYNQaV+iJV3EglEpMZiKg8rycepaBxelGgHlIPz2414D9W/FJui1snVwsNDDDGA5cNKbe8mqoM08LJRQz+zTFeWJ0oVY8DWAWfVw1UWyxTagMHy+y23jDCLMfAF+vSx3Ux50fIPSvZ7hCuUHyn0Cg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkJVM39IeuH12EBHasq4aAxwlN5R7GQMS808+O/4394=;
 b=N1I5IPvMHczt87F+6ZY5EPiU8LtSdYBtqDknE5JuYJlbTzvkuFhNSI4dI3IWTre1E2BMBwnmcNNmJqffNOjkJdHaLefvTD9L57a/a4zUG6iT/8vZEOPc7B3fv32pj/ZnsOeEW5/aO9DRJYXDdm3wS4Dm6GCHq5MLpv7G/enf4XbebLARCyDAKlZlOVnEG6TawI8CKExNEV1+phGp32Raf+1qm6CSB8x53OlzDqHBVGXFwWkxCjgMrhxhfWu8aUtWHvFmHfD5lsl8tOXSAerjmJNg6uhzirbY6OU3W+KwU/BM80uOp+VegC7fBgyci4App09v1lwYUHxv8FHZCLNDeQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkJVM39IeuH12EBHasq4aAxwlN5R7GQMS808+O/4394=;
 b=dDCpe/GYM4HOsS2J0czIB1+5xAcEh4wdDzIBZETEDxtiayx3W661OamVue8sr/cEUGXG8LdDPaxH//GSuvLSNuwYwLLYYc5f0DIOKXxT7dwmL9LU4znkFdRJrGKJUmErUbruIjOpE14SZi5ymbVu24+ZTgTcu7mEDG1SN3EBX1s=
Received: from DUZPR01CA0327.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::17) by GV4PR04MB11426.eurprd04.prod.outlook.com
 (2603:10a6:150:29b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:28:39 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::be) by DUZPR01CA0327.outlook.office365.com
 (2603:10a6:10:4ba::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 18:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 18:28:39 +0000
Received: from emails-1836632-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 004D57FFC6;
	Thu, 11 Sep 2025 18:28:39 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757615318; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=hkJVM39IeuH12EBHasq4aAxwlN5R7GQMS808+O/4394=;
 b=QkUU+6BxZ3fKLog1CPJcWgRW5E7OObMRukMvsiSHqZAvU7XYL+TT33ekd/HEfwwtoi1+t
 YrN3bZ99hRSyCiV9aOcIvarMsdWfar3RJzEsHVRnUQrb5eXg8j6/5werVunCbMLXsDQ8MPQ
 f41FhsHKZ7Wmi6XTeByhF3QvY8iWukg=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757615318;
 b=MrRjxVYGX4q2+QKGdUggrn5DITzeebH1bPZGqcWtwsEsamxQv2N4NuXVHpKt9cdWx3x2X
 tgyabBEDdpqymwPdy0Xn8M5yk+FlNksqGLCtuVfsQ5tUYwzWzecb8sfyUTSgIknrWTj89cd
 a2DQtVUykzNweqTgibv6mv5Tetvkmp0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqXYUCwvcKhIHI9ZJOEShYm7bkDb2gdownGqlhSq5hXAQlgE27IXUKT8GcQpVF+9W66JPpXZ4aCZOapfayrVC4eCmKzaRiirEZ1Tb+znIR0Cggd+H4S3xS8cUQEU5c4ZAk5AI1dcM7eBArsp8DQkHYsMs9q6Ucuh5JMnIntNrwe7ShTsSphwtKtmSGJhpLWbhzpMuGxLg/IKglR4493724Jdoz7pVk8SP8FoWA5IOdZw4wNZS3AVI8NVvKGuHQbJEbgHjcpJFYVg89H51nB6gtRIfACPhLkDmulZ/GblsTz2/IyZuUAdbnMbrnn3iYCThB1K+CNK7GZOlWmfDiWJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkJVM39IeuH12EBHasq4aAxwlN5R7GQMS808+O/4394=;
 b=eYgjwwDIw3C4oMHBRNco57mN0h2E/nGSdVMI5UieacKYR5smlhvgLgNPP/fnVG7L28eRdC41twHHZ4HHPNCUydQ3i+AwGnEkehKtmu1t/Ob6WMcv9uSKzToAX+ERW105V1rdLs8M3nj1hmlSbREO3mn12MNW37XDcMnbL0zROoTsvbktxgvhsxR2ZZEoE7qencckBiNQmxh1D73m8SbRsf8+zs8tdOup2MIO1WsZMVfcxq/3vhl6E91+WhkfH1/8QtMGf6Omm33b9Q8CFfJ9JRJRPlVjk0vazrLkVB/00tnE+V/t2dyK8BVBwT+sWZUipRH8WiC34u14cwCsvoR21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkJVM39IeuH12EBHasq4aAxwlN5R7GQMS808+O/4394=;
 b=dDCpe/GYM4HOsS2J0czIB1+5xAcEh4wdDzIBZETEDxtiayx3W661OamVue8sr/cEUGXG8LdDPaxH//GSuvLSNuwYwLLYYc5f0DIOKXxT7dwmL9LU4znkFdRJrGKJUmErUbruIjOpE14SZi5ymbVu24+ZTgTcu7mEDG1SN3EBX1s=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB11488.eurprd04.prod.outlook.com (2603:10a6:150:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:28:28 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 18:28:28 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/4] arm64: dts: marvell: cn913x-solidrun: fix sata
 ports status
Date: Thu, 11 Sep 2025 20:28:03 +0200
Message-Id: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMUw2gC/32NQQ7CIBREr9L8td8USAO48h5NFxR+7U8UDNRG0
 /TuYg/gavJmMjMbFMpMBS7NBplWLpxiBXlqwM8u3gg5VAbZyq61QqCPVqg3lowTV3GLw85rpWk
 Mo9UT1OIzU82O0X6oPHNZUv4cH6v4uX/nVoECLWkplQmtNeZa0p0D5lc8+/SAYd/3LwdMBy24A
 AAA
X-Change-ID: 20250911-cn913x-sr-fix-sata-5c737ebdb97f
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|GV1PR04MB11488:EE_|DU2PEPF00028D03:EE_|GV4PR04MB11426:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf8e0d0-e865-44a7-df4e-08ddf1610736
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QnNmMlFRT3dJTU15VXlhSCtEVDFuOWUrdzFWR0FNWUF6S0JycWpEODFqMldO?=
 =?utf-8?B?ZmU4dGthSHpGb3o3d0NIVm9WTUx5TjlNZTNvbXNleWt0eUVXVXFqcjB3RC9B?=
 =?utf-8?B?ZHRERXRxQ0FuWUMxb1JRbU5ianliTGNNUWU2WWhIZmdjUndNS2xobS9ZODBD?=
 =?utf-8?B?aVNGTFo3b2JqaGRmcG1BNFBCRFlBZkY4SmM2S2lIeWttdzV4UTRMKzdqUlJl?=
 =?utf-8?B?eWJia3V0MkFUdy9mQzlXY0FxOEhRdGphSE1jdFFRR2hhaWNMOGE0N2RkNzB1?=
 =?utf-8?B?VUNvZmNZRm16MjlKUmFFQm5FYUlMYUtmZ2pwSlcrRGZ2NlhlMmNtUmRpZnBh?=
 =?utf-8?B?MVZ4NjZhcTluaE90MWsvSkttdmpZcTlZcmxtMlU5dVQ3YlNnK01GRi9WQnRv?=
 =?utf-8?B?ekVJYktTNHdOV1dkQk93SEs2LzBscXRzMEhaaFdROG8zS01Balc1TXNVYVRJ?=
 =?utf-8?B?ZFMyVGg3K1dOUWVMd1M0NHNwUlV3UERaN3Y0UFIzc21ZM3BiUVZyTDRRMG9R?=
 =?utf-8?B?bVJDYVRVUzYzV1B1c2REeHNhOUlwRVRFN241dkxuQTZxMlhJQ1MvbTlIYmdv?=
 =?utf-8?B?S3RtTnJETTF1eGdsbkN6YmdkditnUHp5UzRZMHhlT2h4cFZ1cVFNQU9mNHhV?=
 =?utf-8?B?d3A5ZTVlQVZXZlhaMXpOM21oL3lkU1dXRTBmMVJZTHZHSUhVMTJSeUpJcVIz?=
 =?utf-8?B?eGg0aW9EbVdyemNoYXpNUHNieEFLSEhKTmE0czh3ejBvNWZiWTMvckJ4MmpG?=
 =?utf-8?B?aWtRWEt4bmJuMjNEOE9XdHJLbDZyZzh3UnBSclV1Tm1wWlJyNWpXTEdmZEsz?=
 =?utf-8?B?VlovT3ErWWQ0QzZjS0c3YjRlWkx2cFJIL21RR08remg2V3BOU212SHZJTE85?=
 =?utf-8?B?VkpyWlcyejhkUjVTN1YrSU9tTFdlU2ZWWWZiajZlemh1NjRLV1hOR2Jwd3ht?=
 =?utf-8?B?UXJVVTFtMWF0YXBNK2JpM2RlNVVxUnpydzhCbkQ4amkvek1GaGk1bHRxRzZ1?=
 =?utf-8?B?MHV6SkZOc0NTb3VLMVQycXFwa0FpMk9vTlhmK2VJRFppclZuaTBvZzNlajRq?=
 =?utf-8?B?SlVmaEdTV2Z4cXZpSDZFYWhsckFUWENzQStscVJ6aEtsQ0FEeWNrbC9TR2Jq?=
 =?utf-8?B?ZS90cjZrNzFSZDU2YlN1MG5kNXpIamZTODc4YWdJdnd6S3o0RFJLMlZ5a0NT?=
 =?utf-8?B?Q2VpWUJXY3UzVTN0NDYwYUQrVkJZQlNlUVByZXhBT1pWRmY3eHFDS05kVXhv?=
 =?utf-8?B?bHNlRW5YajRUT01OeWdGbnFmVjdmWW1CK3RMTytEMk1XcW1FejlSbm42M1pO?=
 =?utf-8?B?NElEdUI5c2xDeXNubHg3OU9reVJSd0g1a1llT1c0S3J4NzliUmdYM2Y3eWRq?=
 =?utf-8?B?SWdtcUxKM0toc2RMS0J0b29TRVB4VENoZVlabVl0Q1A2K1NvSHZZWll3M3VW?=
 =?utf-8?B?d1JPRGNxY25ESUIwOWNXUkZ5dFlIUmZRcENmMW1ESi82c3FkWFhjZjQyci9T?=
 =?utf-8?B?VXpmU0VQT25JV09zRDVYakFwdzY4ajVjQXFOT081a1E5TTloaEswWVMxclU0?=
 =?utf-8?B?eVd3cW9xcThyN2YySjExT0oyaCt3OEt1M0JrUDFsMVp4OHBya2pwbkx3eTNi?=
 =?utf-8?B?ZkNCeFVNdjNRQTJtZGtwZXRHSUpBVzQ5blgwQjRRRlNrRCtWcXFHQmZMclQ3?=
 =?utf-8?B?MVdLdGxKN1hldHpBcFAyK1lLWUVrWTdWM1NxckxyWWJTTFBQc1d5SzYwenBl?=
 =?utf-8?B?b3VnVzFFclpyREV2Y2xqanlzUzVmQWZycG1uaHh2RnBxRXlVTGFEUlRGSlY3?=
 =?utf-8?B?MkIzbndjNjh3SHYyRWc3K21US3ZGSm00bTdyaUVySmh2ZmtwN1pnQ0NoTUpD?=
 =?utf-8?B?TUY0ekkvdDlnUTA1My9EaUwxakpUTTR1VzlUNUl6VFlCZVRtMlZmU2ZwajdU?=
 =?utf-8?Q?NbQBfvDMzj0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11488
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d8c8ee99d53a4495a6e4215ca99f8757:solidrun,office365_emails,sent,inline:747356389351dbbf289619dd077559e8
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bed09571-1898-47bb-aed3-08ddf161008e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmQ4Q25adDl1aytESTFKQ0xnd0VLTW9KSHlDdElPMHE3SlRYRTgrYm15QVhy?=
 =?utf-8?B?ZnZGU3lvMm1pbEFTdWVTRGkxV3ZnMUQzeFRaMW9vVWp3V2xKK3lENWRoQS9E?=
 =?utf-8?B?Wkp2YTJWZjR3djZCMXpuUGR4NDlJZHVVeTFwRS8zT0NDRUxkYWhrWFFqaUNF?=
 =?utf-8?B?OWJYZCtsRm85aU0xRjVqekhIdTRwTEtNdjBpb0c2TVJCUHl5ZFFYRVU1ay9x?=
 =?utf-8?B?dXVCVU9ZZjlaTFJiNG0yVzc4WUxUUEtnRjVjTEFZdzBENlZDNkQyQUxjWkNy?=
 =?utf-8?B?WHpVSzRReTJSNWI0UVRzNWo0Sk9UOEhNN0lOM0M2a3NnZ0NvYmlpWFlhY1NK?=
 =?utf-8?B?Q1NOM05VWmp6NUVWaUNadG1JcXVJdWFuSXF0bjRtekVjS0NyQ3IrWUgzR1NK?=
 =?utf-8?B?SnhDclZLQ0ZBSEZpSzVSamNjeHVYQ1IrZmNOMkdzYnRENXJOc005V3NYYlMv?=
 =?utf-8?B?TVNHYzFRUDhkSzdNS09JTXFCUUt0cUJhTkNGcmZVKzlSOGNjNHlLazNnMGVj?=
 =?utf-8?B?VWRwUi9taVMxc0FET1MwSmtsU2g5YTdvdXBuYkp6WmFmNFkrRnJST3RuU1Ju?=
 =?utf-8?B?T0Z2UkMwWW5NMzlyMXdxTDMrRVJFTVd0cUhuY2h1Q2pnVThYWHY5cjhZYVZ5?=
 =?utf-8?B?dHc5V245UDhtYzBLTXpQN2VDcEpaWjltaWhZa29oQVlFWXV1OTUyZm04L3NN?=
 =?utf-8?B?aVhUcjl0N2cveDhaV3dkTGtnL2tlSWdmZG0wQTJoYzA1WERCYllHUk9VcnJI?=
 =?utf-8?B?VTZjZndobFhUZ1Y0U0hlM3BHMjZjN3V3WWdLL3VHTTVidkdvY0lZT2piQ1Fw?=
 =?utf-8?B?M0sybUFmYTFKT3A1K1JIczBweGlLVzkyUEdhSmY0bElTLzE5MXNJVXk5ZEpS?=
 =?utf-8?B?SFY4UzRLeURMVWhpM0tVU0dOZzA5TmYyZ1R1WmRKS2lMRXRidG9xZEdjeTFL?=
 =?utf-8?B?K0FzM0pkU1dDZkNzYW9yRjBWYUswTHEzbFJ6VGxubnUxZk5ud3FZaHVsZWNt?=
 =?utf-8?B?aUVvVUJKUHNtNVFpQlJ1YTlqVlhtZStaTjdjeS9IWjBSaUlNLzg5RzE2ZHpy?=
 =?utf-8?B?OEZkQ2RmQnMyRHZwS3R0N2VvN3cxYlAxditsRUE0aitWT1ZkZVcxaFZheFpI?=
 =?utf-8?B?Q1UvZy9KR2l4dUdmT2xhVWxpeDVaNWw0Z2pOaTh6YldxeThIb0g4akg5cGRD?=
 =?utf-8?B?YjlJeFF6TU8rSlJzUkJRa3g4cUhoSUg5SlVuT0ZPOG9UVmExTjVSNWlJSCsr?=
 =?utf-8?B?Qk1xTUVXdVRSdlI1TzBQODdsd3dXMkpaZVk3Z1p1dHNvTmZOWDhvUDFiOC96?=
 =?utf-8?B?QzJ4Vzd4MmwrUTYyU3VMYkI3Ykc1ZTA5R2I1OG5EVG5LZzVQOWxhYXFyUHZV?=
 =?utf-8?B?RWFNSk5yU1RPbnBPODZWUTljMWJWQjRlWVhIbGJLT2tsWU9iaFg4Q1YyWDhT?=
 =?utf-8?B?eUZtdkIwY2hkb0NYL0hHOEJkNlo4eTRyU29XMkpyVXp0Y1NhcUNDSzhCRnFQ?=
 =?utf-8?B?UWlqZUJ5cVpud2FlVk90SDRVYVRQV3VKbHFHdU9kZmtNakp5Z1NPbHhESzVn?=
 =?utf-8?B?bzkyQXBhTEgxUjRBVnpWTjRXSWZQUDFISTFHZWR2UGpBYmxObkhTcEpwSWo2?=
 =?utf-8?B?NjA0eE1qeFVZWmUyRFpLRlMxSU1QdkFGS3ozYWtZcHBEd0VoNnl5Tk0wU2lw?=
 =?utf-8?B?YWpLTDdTNm8zS0cwdVBXdWdkbGJ3akhoL2tTVVhjUUdqdUlsMG1QQjB1d3c1?=
 =?utf-8?B?d0IrckZ3ZmJuL2VhOWZDSDZHZmxaNHQ5Q0RPNDkzcEZWaUEvMDkzQ3BiMjhJ?=
 =?utf-8?B?amR0WVFTUmZnUUZDVk9NT0hWZXgwQnVkNm9QdTQzNEY1dmV6cnA1MkRoM1JX?=
 =?utf-8?B?dGxRVnBuQ0dGM0VzeXQvcCs3aGtEbU9lbUNTMU1tVHJEd29jdDA1dmJzYlF0?=
 =?utf-8?B?WWVxVDg1a2p3WFNhRDY2UEl2TkFrdjk3aGdHVDNlb1F4SWRvWFF5Z3lHWTdB?=
 =?utf-8?B?YXNYa2swcVc2RHBHbTlRUHVwUWdjaldibFVDcnJ2TXNuekE5YXc1TGI2Wktq?=
 =?utf-8?B?QUFOenlqSEFWdkFPdlV0MVJZOUdGVXdMMklYdz09?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:28:39.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf8e0d0-e865-44a7-df4e-08ddf1610736
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11426

The SolidRun CN9130 SoC based boards have a variety of functional
problems, in particular

- SATA ports
- CN9132 CEX-7 eMMC
- CN9132 Clearfog PCI-E x2 / x4 ports

are not functional.

The SATA issue was recently introduced via changes to the
armada-cp11x.dtsi, wheras the eMMC and SPI problems were present in the
board dts from the very beginning.

This patch-set aims to resolve the problems after testing on Debian 13
release (Linux v6.12).

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- fixed mistakes in the original board device-trees that caused
  functional issues with eMMC and pci.
- Link to v1: https://lore.kernel.org/r/20250911-cn913x-sr-fix-sata-v1-1-9e72238d0988@solid-run.com

---
Josua Mayer (4):
      arm64: dts: marvell: cn913x-solidrun: fix sata ports status
      arm64: dts: marvell: cn9132-clearfog: disable eMMC high-speed modes
      arm64: dts: marvell: cn9132-clearfog: fix multi-lane pci x2 and x4 ports
      arm64: dts: marvell: cn9130-sr-som: add missing properties to emmc

 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         |  7 ++++---
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     |  2 ++
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts |  6 ++++--
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 22 ++++++++++++++++------
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi    |  8 ++++++++
 5 files changed, 34 insertions(+), 11 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250911-cn913x-sr-fix-sata-5c737ebdb97f

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



