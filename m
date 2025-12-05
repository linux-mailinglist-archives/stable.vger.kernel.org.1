Return-Path: <stable+bounces-200103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CDCA5FCA
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 04:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F5930B651B
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 03:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281682566D3;
	Fri,  5 Dec 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OrBiGPVe"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8C231836;
	Fri,  5 Dec 2025 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904758; cv=fail; b=RN7Vb+1TTz8H5OrsdhpTfISFTGRePcfRet4D+HP/xzwSW1+RuKUxllLDiUh+4d1vv2CsyMOqeZM+xu7fIVQFtVFLDz4/0FxMDVVnoESwJRoWeu8UAEFPtj2cIJYKfUEef+rdpBZ0J3aLj0K8wcXc1DL/9xt/6AkEvqEsZgsNDuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904758; c=relaxed/simple;
	bh=WOfz+K50016/2WDQ0Mo9EC2esM+YHY+mEokVDUk4bsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GUKE1r8TQh7uFveFii66AZxXqoGq8s5yR7D8vJ9IHYZMH82R/BHos6QimjXEiTX++yEMKH76xdCAnVPL5/hwp3QGysNOgnxzrN8GRcJtrL6q5Jbd1Ve18bR7p9BJmeWnmC42G7hucuFoEe7Yd55AdCHtYc0X0K7BWMVynLodjnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OrBiGPVe; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/kpeDkiE+id1rEQvUovwAHGl9N0HY28ODKrF0jyhXfUhQLTndcEJiGxki+7byAJIOIWEfArQJdCb3o4cTjQPGW7sy9Xaxi1bjkl7Zxc//73NFsqpVUlI2fbje0TavPsQ7xka/ATxi4guIiacLKcklg296/NMdF29StMarMZE775mqZCPC6M2T9mMwwreK+JAXljwko9A/0FUJbUiZlIlEjqTL+BO9XZ5pMA1fBWFQ4LU7ewjdWZeVWXuy3Wp2KhXKPKan2pwsBTKK7gypFStfqJ9XUOEN/dOFQ1dplcPK5jSBL8o5PXlOnLgQRmahvURkGzOgGLsOkzjeKgmXlYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOfz+K50016/2WDQ0Mo9EC2esM+YHY+mEokVDUk4bsc=;
 b=OMTzM4YssYJ15ZCO7HYCDTpYW9GmLF3FZEPRuynldB87qvl28EZKykwz7irCX+lHW/YwybJiV8y8jHq7w+XXti7S8b96UW3qQXhcl3SmatoI+bBiRsO6O3mwTM85fozkeO+hHzj+cTXk2Anr3fywdHll0P7ANTsLQBVTQDnCG60RjDxYkfRmK71IxglYvh3EhvLAbWe2uDseRhmvaUFq4JKVN3r433Gv597mf+0ZwiLOFXNeuBW9BUEm7oUdIaaEtzHrT17/7ssd0YeqkSaIe2aslk+uxxvl5Iw7iA9/3r3uaCtN/o37R/zUBACbDFIOkRbcrgMj1zvzfq2PvT1dng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOfz+K50016/2WDQ0Mo9EC2esM+YHY+mEokVDUk4bsc=;
 b=OrBiGPVesQtvMaSAcDNr9STyf5+TJ85qNCfTkZFWkGGju5Tq1AwxG39ZuTPMloRBpF1/gdZBLgIn2DdJLDxrhUzbsTv73d3WxhofmdULRFrs3MK1MNc37F0B4I81KOm3YK6AE6jpK4PCEn6KcAHyThhCIGCNiqjJCnHrjIFLiqPn0DK80bv53k1gln78uxs6RQ2fYga2tVYp5D75tgJzzMLVGX1TGWli1cI/X7BFuP7BmxOj4VQ+tSx4eciTMp/1TnV5mFRUVw5sLAB7AkktUjLhOK0GZcKS1hyrFq5qmsLQgJ80kfsZY033jHQHE+Usehp2XHxJLN2MB3jW0/yaSg==
Received: from BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 03:19:15 +0000
Received: from BL3PR12MB6474.namprd12.prod.outlook.com
 ([fe80::766d:eb51:b2d8:7fe1]) by BL3PR12MB6474.namprd12.prod.outlook.com
 ([fe80::766d:eb51:b2d8:7fe1%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 03:19:15 +0000
From: Wayne Chang <waynec@nvidia.com>
To: Jui Chang Kuo <jckuo@nvidia.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>
CC: HaoTien Hsu <haotienh@nvidia.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Fix UTMI AO sleepwalk trigger
 programming sequence
Thread-Topic: [PATCH 1/1] phy: tegra: xusb: Fix UTMI AO sleepwalk trigger
 programming sequence
Thread-Index: AQHcY/9FSyzRzeIUd0+lw928HxaZUrUREpWAgAFRSQA=
Date: Fri, 5 Dec 2025 03:19:14 +0000
Message-ID: <953eec87-e11a-4c32-9d28-1a156b2ec48d@nvidia.com>
References: <20251203024752.2335916-1-waynec@nvidia.com>
 <7d3c711a-bc33-4dbb-a8e5-bcb420d5b536@nvidia.com>
In-Reply-To: <7d3c711a-bc33-4dbb-a8e5-bcb420d5b536@nvidia.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6474:EE_|SN7PR12MB8103:EE_
x-ms-office365-filtering-correlation-id: 2850fef9-9f0e-4edf-ad6e-08de33ad1184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3RRQnZnMzFwU1ZDTW1hTWVSV3dXQkhNUmQzR3Z6VURldU9iWEtOMHp5TGNw?=
 =?utf-8?B?d0Q5WWg3czFoeDNKZS9hYTM0a1UrdmVWRDBhQk10OG5EMTl4clZJT2I2ajY2?=
 =?utf-8?B?akpvTk94ZVkxNXU1UHRaOHlEb0QrSmVBSGw1U29WWDBnQWlrWmVVSnRjZFUx?=
 =?utf-8?B?MVljVzJNWEk2M2IzZkMvTGJrUVY3aTIxYXJ5c1dIN0kxOTFkZm04NVBjVGg1?=
 =?utf-8?B?UjcvTHVJZUl5clN1emFxVEpEcW5CWVBaanE4MlVVdXRBOW5uZUkzTThKb2pu?=
 =?utf-8?B?UlBYVmhzdU5iMkdrQVIyTlJMU2lDcDBjMTlyT0VsbU55ZkVMWjVjSC8weWp1?=
 =?utf-8?B?aFlkWFJGb0V5emFxTTBVVStwNlpPanFlemZYaXUvSzE2dzd2M1Z0VGQ3YWpB?=
 =?utf-8?B?MkptUWJxUVFFOFFRM1IwSU9IcWVhNkFYNzRVWmkwQU9pRnE1bnBFek53M1Ew?=
 =?utf-8?B?Vzk3OVpqbG9wYXRmUHVMWndHVmlWRVRSTS9SUEcxME9DM3RpWS96bis3R2s1?=
 =?utf-8?B?VVZXUDdGaGJMclQ3Ym1wZ0dtREZZdEdtVGl6eDAwbTI3YjZiRnhyQ3RlQ3lL?=
 =?utf-8?B?alRTMmU4dXU4cnlhZzZHNHMwcllVaEg0ZjEreDJFQzh4NFVJbXZ6RVNFd0cz?=
 =?utf-8?B?VkdPVzdKOGtBSndWOHZQZ0pod2pVK2dxRGYrVWduL0ZVUGd3R3ljbDFXV1Qr?=
 =?utf-8?B?ZEpYOVpzdzh4Yncyd3JOU2NpVDBJOVc2dGRFV0IrazJYSTkrdExyV0puams3?=
 =?utf-8?B?TUNXcDJpMHhpOVg4UGFpZXZkNmwwYmVhcVN3UThwblJma2dBTlRiTFFnYW91?=
 =?utf-8?B?QWZMR0lWK2k2ZWp4a1h4WVFTMy9laEVqNHlFZ1l2ZXdmUlcveml0ODc1SWY0?=
 =?utf-8?B?bit0N1R6b0ZPeUlKSVYzSlplN084WkJRcVNtS2dPWFVwUnN1akIrdUJxbHFO?=
 =?utf-8?B?SUdjT0hzd0p5N2lScndJQmN0NHZ5c3UxdnVJbHkyVkpBNEIwMHlyZE8wUnRU?=
 =?utf-8?B?MEVOU3JTM1hIMUtmWk5pdklhZy9DMmZCTEhKTkpTUnhncWFCU1c2V0Z3TW5v?=
 =?utf-8?B?blVBcFRXUERkR2pSK2pQT0VJQUUyZW02aFlITkp2am5aZHRtRGpTMzlzQ1p0?=
 =?utf-8?B?UWRQdXk4VDltSU1nT1BFUFRITGo1MVNUcWsyQnJiUjNUa0d6dCtESEVkT3FY?=
 =?utf-8?B?QjFZYmtsTi9LdldUYlNFS3pXTjJyZlQxMkZzdWNPWC9Dd3VqejlUV3N3a2sz?=
 =?utf-8?B?bVJtdFJHOFpDeHV4aXlkR1pFbzZRMG9FOWxwTmU4cHlhRFpPYUEyZnd4blRq?=
 =?utf-8?B?SVArNlpOdzNUb3R5dWpUK2E5c0xCeis4YkMwNUFLRjVXd2Q3bzBaenJ5YnBs?=
 =?utf-8?B?bDczNmtiNzMzVmU0MEY0MnhmaWRXN0Y5czNKQzZodU1kZzhHUnc5WXVRZ3V0?=
 =?utf-8?B?Q0FVdVkxOWdZN2FsWXFTaFlmMm4rcDBrQ3pvL0xGNjJOOEljeHhWdEVUMk9t?=
 =?utf-8?B?NDFLWUMxU2lXVC9IcXloUExqaFJjZkVGcFltMU13V2VBbHhzOWZvMnlTUm9v?=
 =?utf-8?B?ejhpY3d6V2Nvb1E4bFJJSnE4UmlyNjY4WkVqdmsrWFlWbit5Qk11TTRNUyt2?=
 =?utf-8?B?NWJBYzFPOEw0Z0hSbi9mdkVzMW8rbksxYWVGWEs1dzB6ajEzM0J5KzVZeGov?=
 =?utf-8?B?d1hETk54YzRuK1IyRHZPQ3dyakJwdzdPMW1xbGo0U1Q2cjJNaVhVSlp4ZHNv?=
 =?utf-8?B?Y3ErTEhRdXRmS2VETjhhUjRvVnZzOFBFOXcwaXZxY2V0RFpJWFZDQnRONTFM?=
 =?utf-8?B?cUlUa2VDNTNZUklUNVg1bE5UWnVqcURsOHptOUVzWHF4L2ZHeWNuWCtTRXlU?=
 =?utf-8?B?Y05hUWQ2NXA2S2JSN2NJNXZXcWUzMitQcTlPZUpRWjRTbmJ6U2pSRFFQNmZU?=
 =?utf-8?B?K2FObmM5SFo0MER2cVZhTkptQWMvYm1rWGtXSENBbGpQMkNGM0VBRjlkSGhx?=
 =?utf-8?B?TFdBbzUzdWt2akZldTZRZExxMHFqMzZkWEpxODNVZUdqSWl5NlpKdWl3ZE52?=
 =?utf-8?Q?bGIU+S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0R6ZEE0YkJONWtPb0RzVHExTGpGZU1jZ0NlNjFkNkhydjlsVzdmdG81MStT?=
 =?utf-8?B?ZFF3MERpV2pqN0FGa0I1RGQwVVE4NWUvSE1kZXlzVUNOenU0WTVFTVlMc1RB?=
 =?utf-8?B?ZGdtZ1JvQmdZamVvZXR6Y3ZtZDdVSXhibGhGSW92M2ZUK2ZnVUlNYzVnZkRT?=
 =?utf-8?B?WUxVWUpudjVPbGpWd25JeGFkUE5lMUo0eWhjQVJwRnJLcWRIQnhJaWZRSi9O?=
 =?utf-8?B?WkFNUTNNZFZuaVhpNDFaQWdxc0Yza01NWENZWCtscUFQWGpBb3UybitCNmZ4?=
 =?utf-8?B?akZVbEYycEdqYnhOVGkvU2IwZFZqYUMwTGVYdCtoSEhNLzE3SGhOWXBndkJ3?=
 =?utf-8?B?VGcwS0QzdXMvbG4yU2lWalRUZjcxTy8wOW9kbGM2YnpFVXFqcE5zUzlsNVR4?=
 =?utf-8?B?aCsvRllvRVN2UmxpVFlwMll1ZXJpUDM1RzhPTGg1WTB2ekpzMUlGY3dwM1Y4?=
 =?utf-8?B?QjFxWDlQT1JEeW1Fc3kwVjAwYXgyMlBaQTZQNXlPUjBOVkUyWC9kSW9BMzZh?=
 =?utf-8?B?dmhOOEtlc25wbFBqUkp6d2I0MEtCc0RaVUMyRmpvKzg5UFRITzdlZGxOaVJ6?=
 =?utf-8?B?YWRVdW9Rclk1QXBEYmRpKzd6MnVGeTIxR0RWZFA3TEF3azhBbjdCcmhObkh2?=
 =?utf-8?B?SExQYTBRdU12d1czTW9PbTZ3ZEVkNy9BdDZaUTIrUkhBWG1VVEticlBIVDVO?=
 =?utf-8?B?WUM5eU9NQTM2ZG5XSFdKZHVYVlBTUFdBcEpMcmZnbDUxcmNYUGFTa25tdGxl?=
 =?utf-8?B?R1pHYWtsdWltM2MyR2owZVRma1dWTVBYa2VSMnRZdEk5d2xaQzNSUW5JdGlX?=
 =?utf-8?B?ZlFyd1JKTDdlWTYvK3NmWnM1QzRON2w3TUoyWlNRdXNrUWRBTmFGamtEQytB?=
 =?utf-8?B?RjRnYlFXckwxTGFMOWcwMVRjSEVnSXVHMHIyK0pNeG0yTFlvWW40SXQrVE1S?=
 =?utf-8?B?WnM0Mk1EcWNUbjNZRGpPdVVuNlFQRTRJWmRST21QSFI4cit2OSs2NGc0OUha?=
 =?utf-8?B?Z09JcS9qM3N3b3VGT0piZlROWEFpa2RDSlh3UzY5T2wvRVcxekdFYVRlSnBh?=
 =?utf-8?B?anBQQlRLTXZsbS9meFpFMWFzUHFkSGVKdVhIdEtXR0RZbVcyRHdrNWlQcjNR?=
 =?utf-8?B?SEVrckJESXRrRitsaXJhZER3dmpKRE1OOTRobkJZWHo0TWsyWG5WaHM3cHVB?=
 =?utf-8?B?cS9FeENnNDZXZTdJV3lLd29Mb3NDMm1FbmhqLzNIYmE5d3l3SWl2MGVkZCtI?=
 =?utf-8?B?Uk5DZUxKS1ZSNWFQcEFwaVZvVEhZRzltTnhrbjZjMGlpYkxZeWJpTGVJdEMz?=
 =?utf-8?B?S0VxSEZpd01CVnozVWQzL2JqMFRWSUVLUmYvRWhCOVFVUmtJejkzUXordmw1?=
 =?utf-8?B?d3JPWldqTHFsaXRpVnlaNll6Y0FZSzdxUkNqNWdrcjduVC9pTTlUdFFNK09R?=
 =?utf-8?B?aE5OSzJDclZEWUxyV2dRVHFMamlURjdoSkNyVllRZS92VThJaUJIaTA4Q01Z?=
 =?utf-8?B?SFdSYVhkc0tuRzNXbWREbFZ6QmdJMEpmV3h0Uit2eko1ZXhBTkxVSzhZVjA0?=
 =?utf-8?B?OFJZQi9UTUlnZWhZVG5vazFLVkdCSjBWNnFROWFYMXBvSDBidWYwRjE4RW9C?=
 =?utf-8?B?aGhpTTA1bnlrYWJMSFpHKytPdjd3VjR5ZU56YkUzbnordEVUVVZ4RUVHSFoz?=
 =?utf-8?B?RlVOd294SXU1Z2JHclRhSnJ5NEIvUDFDNVNiMG83d2dFZFl2T3UzbVRUOCs5?=
 =?utf-8?B?UVErUEVVYVEwKzlOTWhxNlZPbTQvWGZKK1Qyc0lWRFRIb1Fhais4Q3Z0SlBu?=
 =?utf-8?B?enJNOVdDMmZSa3FkN1ZJNTNJOEVmci9qeEx3RjA2Rkp6YWVlN1JwT2tXRVI1?=
 =?utf-8?B?RXRHN3A5MFY1aGwxbVloY3hkaHpDejdCbGxpZ0pCbkw4dVRqcGJhd3VoR3lP?=
 =?utf-8?B?N3VVNng4VGpQZjBBdVNCeFJBNGp0cGdycFlabzlVUkJQdEF3SEtnV3NzckdM?=
 =?utf-8?B?U0c2b1ZIN0hvVDdTdEordEFIRzFTZnBrMVpUTWNKWkZIYUpYOHBQY2lJbGFK?=
 =?utf-8?B?MW02eHF5TmxSWElwb3lyM3lBSk1xSlltaXlXZEk2VDI2N0FjakhudU1jL29F?=
 =?utf-8?Q?Y2KsgKrqdNFfjqX5Uoy1dbfXR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F1FF1A74BA47145870398B645303638@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2850fef9-9f0e-4edf-ad6e-08de33ad1184
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 03:19:14.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS8oJpli7sl6lNXtHeItOXclP8EuQe0oWWaIMb7s/hlhfkxM7yvrcxOOuaKuAfOmhMJ2rYRI39U139E6yaUxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

SGkgSkMsDQoNCk9uIDEyLzQvMjUgMTU6MTIsIEp1aSBDaGFuZyBLdW8gd3JvdGU6DQo+IEhpIFdh
eW5lDQo+DQo+IE9uIDEyLzMvMjUgMTA6NDcsIFdheW5lIENoYW5nIHdyb3RlOg0KPj4gRnJvbTog
SGFvdGllbiBIc3UgPGhhb3RpZW5oQG52aWRpYS5jb20+DQo+Pg0KPj4gVGhlIFVUTUlQIHNsZWVw
d2FsayBwcm9ncmFtbWluZyBzZXF1ZW5jZSByZXF1aXJlcyBhc3NlcnRpbmcgYm90aA0KPj4gTElO
RVZBTF9XQUxLX0VOIGFuZCBXQUtFX1dBTEtfRU4gd2hlbiBlbmFibGluZyB0aGUgc2xlZXB3YWxr
IGxvZ2ljLg0KPj4gSG93ZXZlciwgdGhlIGN1cnJlbnQgY29kZSBtaXN0YWtlbmx5IGNsZWFyZWQg
V0FLRV9XQUxLX0VOLCB3aGljaA0KPj4gcHJldmVudHMgdGhlIHNsZWVwd2FsayB0cmlnZ2VyIGZy
b20gb3BlcmF0aW5nIGNvcnJlY3RseS4NCj4+DQo+PiBGaXggdGhpcyBieSBhc3NlcnRpbmcgV0FL
RV9XQUxLX0VOIHRvZ2V0aGVyIHdpdGggTElORVZBTF9XQUxLX0VOLg0KPj4NCj4+IEZpeGVzOiAx
ZjljYWI2Y2MyMGMgKCJwaHk6IHRlZ3JhOiB4dXNiOiBBZGQgd2FrZS9zbGVlcHdhbGsgZm9yIFRl
Z3JhMTg2IikNCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5
OiBIYW90aWVuIEhzdSA8aGFvdGllbmhAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFdh
eW5lIENoYW5nIDx3YXluZWNAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3BoeS90
ZWdyYS94dXNiLXRlZ3JhMTg2LmMgfCAzICstLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5
L3RlZ3JhL3h1c2ItdGVncmExODYuYyBiL2RyaXZlcnMvcGh5L3RlZ3JhL3h1c2ItdGVncmExODYu
Yw0KPj4gaW5kZXggZTgxOGY2YzM5ODBlLi5iMmE3NjcxMGMwYzQgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3BoeS90ZWdyYS94dXNiLXRlZ3JhMTg2LmMNCj4+ICsrKyBiL2RyaXZlcnMvcGh5L3Rl
Z3JhL3h1c2ItdGVncmExODYuYw0KPj4gQEAgLTQwMSw4ICs0MDEsNyBAQCBzdGF0aWMgaW50IHRl
Z3JhMTg2X3V0bWlfZW5hYmxlX3BoeV9zbGVlcHdhbGsoc3RydWN0IHRlZ3JhX3h1c2JfbGFuZSAq
bGFuZSwNCj4+ICAgDQo+PiAgIAkvKiBlbmFibGUgdGhlIHRyaWdnZXIgb2YgdGhlIHNsZWVwd2Fs
ayBsb2dpYyAqLw0KPj4gICAJdmFsdWUgPSBhb19yZWFkbChwcml2LCBYVVNCX0FPX1VUTUlQX1NM
RUVQV0FMS19DRkcoaW5kZXgpKTsNCj4+IC0JdmFsdWUgfD0gTElORVZBTF9XQUxLX0VOOw0KPj4g
LQl2YWx1ZSAmPSB+V0FLRV9XQUxLX0VOOw0KPj4gKwl2YWx1ZSB8PSBMSU5FVkFMX1dBTEtfRU4g
fCBXQUtFX1dBTEtfRU47DQo+PiAgIAlhb193cml0ZWwocHJpdiwgdmFsdWUsIFhVU0JfQU9fVVRN
SVBfU0xFRVBXQUxLX0NGRyhpbmRleCkpOw0KPj4gICANCj4+ICAgCS8qIHJlc2V0IHRoZSB3YWxr
IHBvaW50ZXIgYW5kIGNsZWFyIHRoZSBhbGFybSBvZiB0aGUgc2xlZXB3YWxrIGxvZ2ljLA0KPiBX
QUtFX1dBTEtfRU4gaGFzIHRvIGJlIHNldCB3aXRoICcwJyBhY2NvcmRpbmcgdG8gdGhlIEFTSUMg
ZGVzaWduZXJzLiBUZWdyYTIzNA0KPiBhbmQgVGVncmEyMzkgVFJNcyBoYXZlIGJlZW4gdXBkYXRl
ZC4gV2Ugd2lsbCBnZXQgVGVncmEyNjQgZG9jdW1lbnQgdXBkYXRlZCBhcyB3ZWxsLg0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3LiBEcm9wcGluZyB0aGUgY2hhbmdlLg0KPg0KPiBUaGFua3MsDQo+IEpD
DQo+DQoNCg==

