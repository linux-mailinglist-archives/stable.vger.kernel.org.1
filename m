Return-Path: <stable+bounces-192999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F5C49B0C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA160188B551
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B22F7471;
	Mon, 10 Nov 2025 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASWG270m"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B252FB988
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815775; cv=fail; b=P5qxJHWiRy5hkWX2V+fNkwZ7bN6YdJaURehIlrtL/TPYHb8it+HB4v2AiAQcgK/AcY2vHhR//RmkuIznG1ug+qC1eeIOlk/H7n1DQWkKe70K0lJrUnEAqmyZshZJxmnUCzcXX2zWPNishtj86iLuJc4KA3R8gdegfht9CwEMbkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815775; c=relaxed/simple;
	bh=bM2H3zgo1ninZjqB4VCuKMbVnXkzUALKMerFx0mWrRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gip1YH026LDgra2fzxtDtD/b/L2J4yVD15zoED39pNZDTkFPgXUPRO7OotxeQQ0dXGb+nGTqJw18X1/hdKgXvC0a2+KYnS0WNxwM+PlF5yYGQEZywr2m5FN4txvnL8i6SMmUfyABKyF/fqnEvoFyAKZzhJeyqm1wzTRU73CtZvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASWG270m; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoRTyBu9bTlr/z36lfTwXSNp4mLnNEtpcRMYmowaZFYWlsN0JHkBKcTxWMn+o8o4uE89So6ADSqJRnrJZWAnH15+2WLYmwzUA6OkGmGPh2z2ZV2yqTRSpU3PLPUXWGp01szuaaOXVAvqxpo0/sendX3avY0mliyg1r5dsBn8nXA2c2inGWGG8QXlEhRn6JE131TBgrVLEjegxa8ywX7/Qsy1u9hRvTcN3KKCQ4khxVcdrzIUuU9uhP4PgV/oXeWrK9/Me49xBnPEI1wDCCpbj7h/msRu9MvOTTKGvBNSZ2oEu82/m9XLu6ljKzqe67+IjjmkJwq6w78xOwFH4V+SyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM2H3zgo1ninZjqB4VCuKMbVnXkzUALKMerFx0mWrRo=;
 b=s90cEaNGAANGXP8ZIj4ZArnEqiCDMgrZrIrSxbPqFJDQ08wxqNx1OYYVY1LEWw5zdEsU+kgmYE2Mmx3MPGz8n/tcC/e6Mr63BTrjCE4xhEBDHqZWN56+Z6emMWPYxqePSVNZsnOdLUEujJ2g/31OacvlnWmVTOCLtoT3AZ2TGrPKvvOFlIOBr03dYKJ4ydaJXzmJimZ1ZQ86wVfHrn1vrv7ze1EFZguPKqPb6tdwzcA6bOOvihZZz93LIChky4kg5/LzULkut1aN1PduBhAKGhjC/KsUZ0y/i+R9aAP4xtvxYJLeZ05YGROnZG2I6aW1tJeXDctd15NUak7ZWNWsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM2H3zgo1ninZjqB4VCuKMbVnXkzUALKMerFx0mWrRo=;
 b=ASWG270m8EsidkrzPgqjloy+gJQk3P305AZpxpZ6kVi5oAL2UcSGBd/b9SCjYWcEQMNbPelrxBKtkwLT/jtlRnmQh8La9Jk4zC/wZXyQgnje+oDzMG+TEj62K+YKUXx1pma0pyLMT3MNLo7jvj5tTTiWhJK0XOMeqbsSw45XrlZju/T06ClkKneejuzpNIvZ7KbNyZBVy2xvzslCHEopldxdnemZxlXjR20NTR2xxuCLmN9BQxoXigfE42O/vr3Hmz3Cp+pz+LXXb0f7o+mtH0gJXzkAscGnUqJ7s8o+X4q1WMn1uplbO7eOlJu3sySFmNr8Ydc53GTHgFylY4yUfQ==
Received: from CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 23:02:49 +0000
Received: from CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056]) by CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 23:02:49 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "airlied@redhat.com" <airlied@redhat.com>
CC: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "lyude@redhat.com"
	<lyude@redhat.com>, "ardb@kernel.org" <ardb@kernel.org>, "dakr@kernel.org"
	<dakr@kernel.org>
Subject: Re: [PATCH] drm/nouveau: set DMA mask before creating the flush page
Thread-Topic: [PATCH] drm/nouveau: set DMA mask before creating the flush page
Thread-Index: AQHcSoEh8dWTlveQmEOccXmfjOLePbTp7IaAgAKquwA=
Date: Mon, 10 Nov 2025 23:02:49 +0000
Message-ID: <1e9530264e240281738cbdbacd821b21ae1a728d.camel@nvidia.com>
References: <20251031161045.3263665-1-ttabi@nvidia.com>
	 <CAMwc25pOob3aXPH8u2ON7HZ-Bk+a_d9JWg0+wLNOycnFsVWHSg@mail.gmail.com>
In-Reply-To:
 <CAMwc25pOob3aXPH8u2ON7HZ-Bk+a_d9JWg0+wLNOycnFsVWHSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_|SJ0PR12MB6943:EE_
x-ms-office365-filtering-correlation-id: e2cdfa75-9c06-43db-326c-08de20ad4504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXZqM0pMN1BHa093RFRXaHl4M3IzdVhyNTlDS0dPNElVY3NTYWZUckg3b1li?=
 =?utf-8?B?UzV2YTdZVS9qMzVMOUszNElXY21vVVoyaEtTMjFDTnZFOWFJQmRKcDNnbmor?=
 =?utf-8?B?UkdLdmFvRmIzKzBaaEI2UUtqRkQ5VzZJWkxNZVhyVUI1ZTBoQXhXMG01ZHVo?=
 =?utf-8?B?aDVlMStocEVIcTFJcFJXRDlkSGozRFo0L1hMOEZMUDNod2RabWdpcit1aDFJ?=
 =?utf-8?B?UmZqQ01DYXRzcWdmbGQvcmJ2ZTAraFVzbHlnY2V6UFNFdys0cXRHVUdSTk5S?=
 =?utf-8?B?aU00U0NOQWIvSTl2OWswYis3eFh2VzRHTWtwT0NrbHlMd1NKUlFNU0dPOW8x?=
 =?utf-8?B?cTVuVFNMVDdBeDZ6bVAvV0ZiVEZYM3ZRNGd0Tkg0Y29Tc2xoTCtKK2VHMGwy?=
 =?utf-8?B?SGk1bCtUT0l0RTZEZCsyWGxTUjZFSWk3NTlERjE4RFRmd3FKeHBtWmk0OElH?=
 =?utf-8?B?bUxXN0h0WjgyUWNPY2x4dlowWno2RGJ1c3p5aDhFUjd1QWlNTVB0TmNrUXpm?=
 =?utf-8?B?ZDN4ZnNIZEk0Ui91eUlFQU0rOW9Fd3RyWUVuU1VaU2UwWlVMbmZhVy9tdmpo?=
 =?utf-8?B?WDhOQzRBRFBkUE5udHFnc05OYUdnd0tlTGwyQkRYM3A2MzN6MlRJQWpSNnR2?=
 =?utf-8?B?Y1oyQXUwMHB0bXdNMWZhaW9YaWJtSWFsVGMrTVh5V1BlWU50d0Rzc2w5SWRx?=
 =?utf-8?B?Mm14WmRWSnk5YlBDSldUUy8xazVTRlNJSHY2dTVqdXoyVVB0NWdtUXY5aHJS?=
 =?utf-8?B?bTVNT0dobk1GMHd0eUh5QzlHZ2RuZ0JCRkU5MHYyc0JadDJjVlFiM0RsdXB3?=
 =?utf-8?B?eUdGM3dENTcvMEVFM1dKRENDYXlCd2psQUhlSmVCa3ZWb2thNTNqMmFFTWR3?=
 =?utf-8?B?TEhxWnQ2MXh4VlNaS1QxUjhsVE5NZXZiWG1FYlFYMmVzTUE2YVhVQjhaRDJu?=
 =?utf-8?B?c1NyamVZVWo2N3c4KzBPR0laR1JQMUxlcHJOMTB4REIzOWI5ZnNrZ1hlNUpL?=
 =?utf-8?B?R2RWUUpLTHEvSGlPSW1XZS9iVUlxU3dXcjNCQmU3bG9LcWs1RFFheHZlN3Mw?=
 =?utf-8?B?eDlMcG5ZVUoxUkptSkd6NWUxWUhySndvaHhvVnhJSUxqTTQ5R0lOS3gzUTFC?=
 =?utf-8?B?d1FUNGUraE5KMnpXN1hKTHB5UkRuVUlGcVZRUmxmcmZPM3c4bVVuYW1rWWdD?=
 =?utf-8?B?Qzh0VHZidFRvUlNvajRpK0lSdVBlWGJZS3hudmdOaWw2bUpGMS9LaXFKUk9U?=
 =?utf-8?B?eWZheW55YXhzUGQ3VjZZMFAraHQ0U2R1WDlYWmF0MTZra0lpVjVYZ3J4cmh5?=
 =?utf-8?B?V3N1Z3ZydFo3M3pNT0ZQS1hVaEl4aUhwa3VHM2pXVEhtR3JCTCtTcjk4ZXZh?=
 =?utf-8?B?UWFvTXBvMmlPbG1KS3pqK2hUblVWVmhzTlk2Z0tnQURQa1duTnRrWXR0VVd4?=
 =?utf-8?B?aUJNcDZEMUJWUTRENFllMkZUYWljMU8yUEpnZFNMcVBHbVBCYTVDSjBrWkZl?=
 =?utf-8?B?Y1E3LzB0ZExFdmJnWk5oamxGekdBSDlRMnhZNG9QYWxjZlJXN3krWG9NcHY2?=
 =?utf-8?B?U0FvZ3RqL0tjWHdMc29hcnFQOEM3U1VnRUMwVTRuQWRkRklTYnFST2lLd1lX?=
 =?utf-8?B?MFFXZFVmY3FuSnQyVGg1dnc4QkQ0YW1IeHRrRmJpZFhTeVFGLzNDSERGY2Fv?=
 =?utf-8?B?RnBIU0ZsRU4wUHNBd0xOT0hBOGJrZkdnT3hOM1FoMVVKb0QyeVMzdmF6UFc5?=
 =?utf-8?B?T3E2dGIzSm83VkYzMkRlYys4WG9NS0VZV0UxNFhTdC90cEJNVTNyTmZ2SlQ0?=
 =?utf-8?B?VHJRcFFuL3hSei9JZkJVam5WRWhHS0t5MVRzRW9JeERvbXJwUTdlZmVFYjBI?=
 =?utf-8?B?T3hYejBSTVFOc05zVnpYOGtReERjOEZqS2xqTUdzbFBwR3VlS0Juc0NVK1dU?=
 =?utf-8?B?RzFqR2Q0d0FmU2Y0cWhsTDM0R0g2dkwyNDBMTVdaY3hSNUZBSzk1ZGZQYzRB?=
 =?utf-8?B?OUROeWtTWmMzR3dka3ZFVzlFMkw3dmxjd004VFpFQ284UUlhN2VFTnhadGJ2?=
 =?utf-8?Q?C/DxLq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6526.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWYrU0VTRXQ5UUlDaFpRb2F0b2w1dGw1RS85a25iMHJrTEJYR0NvSHBhMTU2?=
 =?utf-8?B?YmxMeXFHQUUwQkxBYUcrZUl2WElWcEFxa0FmWUV5TXAzT0srdmM1WlNhRWtp?=
 =?utf-8?B?aldXd1BONXNVSDZLVHlxN21EK3cyNW0xRCtacE1vanpiMTNuMVd4VHdtVnF2?=
 =?utf-8?B?ME82MUtCeHIxOVpvU29UMWJUdzA5N0JlU2s5cFZJMTVndWJOMVphQ1hrZmNq?=
 =?utf-8?B?bEJiR1E5dEZiM3lxbGYwZFppUDRyN25NUXBXZko2RmN6TC9aRWNUZjRqdDVV?=
 =?utf-8?B?alZyb0dDUXRNY0FqN0FjOTJHY1MxUHhTTThUNWdTb0Y1QVpKMjYvZWE2Y3RW?=
 =?utf-8?B?KzdmWENVbTM3ZWkvaGpIYit2a01mUFlSTDF0MWxEaGExUzZ5L0xqYkd6M3h3?=
 =?utf-8?B?KzMwZmF4ZVZ0VmRKNGVZeG5CU0R1NDhnTURhUTV5cUlDRTFOeEJzTEc2RE9V?=
 =?utf-8?B?T1cvL1VzVCtKa2xLTFdtU3FlM1ZQSENraUxqdUJsTXdwNVN2dkdha1RpR2lE?=
 =?utf-8?B?U0YydHVFa3QrRHRheGFtWjEwLzdUYnFNM2Z1VFpIUEJkVjRFN3FVakh3eEY3?=
 =?utf-8?B?WHNKamhIYnhJT0pyRmYxdVZmV1dVcWl2VEdQM2pLbkxuYTFYMUtSbXVSRkhB?=
 =?utf-8?B?alFRSDYrRkZDdnR2RlIrYVI2aVRWUGkrbmlyNE1zT1FFM2xMU3ZDc2tkVksx?=
 =?utf-8?B?cmdtaWpaSkRaKzc3Ti9jSENncWVpeFV3M2Z3Unc2MEdDWWNPZjVlQ2xDbUFS?=
 =?utf-8?B?ckJhUVkrc0lvOTVxSG1xU3I1aThVcWx3VFF2cXc4U2JERjRuaHdQcHREZkRE?=
 =?utf-8?B?cXU0WFUrOG5GY1VGc3VOcisxdHdDbjJzVERKYml4YW5ydjFMQWdYdW5sN0RS?=
 =?utf-8?B?M2xkRng1MStIWmNGMWJEY055cjd6azJ4OWs5K045T1hOZThML3RKeDdGVU5p?=
 =?utf-8?B?N2ppbjl2WnBRbWt4VVZLTk83Q2NpZG9reWdBVG5vaWNoYUlqOGlXek1jRHNQ?=
 =?utf-8?B?d09QMHkvem9YQWJMaDYvRmVlRU1wSHI4Ryt6dHU5aFBzSCthOWh2aFZTOGxS?=
 =?utf-8?B?Vy9YVmhmSlZDNGhVTXJTSkYzUU1KdG1CSmxuTXhaOXJPdGFiaUppU05HdFdj?=
 =?utf-8?B?RDJUZ0F3VWViaEVDaDhBdFNIblFzczBGM0dZVUpjdnlodmVkR0JqSVdRUlQx?=
 =?utf-8?B?UnBwOXUwdWVWcGtSdXIzYnB3aFAvUUx6c2NCYVR6Q1lNVlVHU0FQN1IzNTVR?=
 =?utf-8?B?Q0E3QjFBSUU0cHJGRFJNSGxVdXFubmR6bjJNV010cTVmMTRRWnRtQUcvVFZt?=
 =?utf-8?B?TWF3N3BvZWl6cnZnRndhZ0paNnVTK0VwL0xlc0REUXZmeDZVZmY1Vmd3eFNX?=
 =?utf-8?B?c3AwRkRoZE4rVWhMVExoeXl3cmhwZ1NEdUM5V2VZZHVIUFZrVWJUNERhWVcv?=
 =?utf-8?B?Y1JoT1pjaXBsa3BSaU0yMytISFh0SjFHV040TG0vTHdhcmdHTGQvUWhZazkx?=
 =?utf-8?B?eHNLUDJLSUtBa29oemNnSFFCMWpPQ2RHanVudlBJbENxVDk0UzFjZ0VmOWU1?=
 =?utf-8?B?SHZ1dTl3ait2Z2RwRlN1ZFdacGJzYy9uRUJNR0wyRlN6VS9udVUzcklFTjN5?=
 =?utf-8?B?MVRHdXFhbEp5eDdidDhTWS81SkwyZTd4bE5BZTA5bUp6bUVwcmlCZ0Vqanhv?=
 =?utf-8?B?SVljZzVObGtPamtHNCsvZTk0OWhUa0o5N0ltYUpBbGlTZW5RTVZPTTVGeFAv?=
 =?utf-8?B?TG9wRDhtMzVGcHNEZmdXeFhVUUtaNWFPRFJiWmNWN0wyT2F5eFoyTEpkSFFy?=
 =?utf-8?B?WUZUNk80MVNyS3dNamRlNDU3WW1CcUtGK05rR25TcVdDWTI1OTQ2OE5wci8z?=
 =?utf-8?B?OEt5eDBEY3FqUGMxdHF3MFJQU2RXYkRyaXpwUmRIUVhhNE1RcHR0eFlTaGcz?=
 =?utf-8?B?NS9MTVF6WlF4OW1QNHFaUThPVi9pRXJMTGxQM3NVbEhGc2pDVEF1VGQrTWZk?=
 =?utf-8?B?WFBZMGYxM0sxV09NbHVnM2hlOXBXdXkvRTl2anYzUE9rM2gvWTJUeTV3K085?=
 =?utf-8?B?eFhLMXZBOGJGbmYvdmh2aEp4VzYvb0Z1aG9MV2EzRVFrcngvWVlXNVhWVmh0?=
 =?utf-8?Q?6cZQXWEj4Nasf43tFGYrW2Pur?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75F9B424FB4BC2498E0615FF6280BFAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cdfa75-9c06-43db-326c-08de20ad4504
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 23:02:49.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rn+DNfrSrN7b5QBW+q03ACOdgyvwz/p2wY9ngLhMAas79E8dz7G0RWoq9++lLAvUxT/fMMRVMoU174hAY+RVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943

T24gU3VuLCAyMDI1LTExLTA5IGF0IDE2OjE5ICsxMDAwLCBEYXZpZCBBaXJsaWUgd3JvdGU6DQo+
IFNvIHRoaXMgY2F1c2VkIGEgcmVncmVzc2lvbiwgYmVjYXVzZSB0aGUgc3lzbWVtIGZsdXNoIHBh
Z2UgaGFzIHRvIGJlDQo+IGluc2lkZSA0MCBiaXRzLg0KPiANCj4gbG9vayBpbiBvcGVucm06DQo+
IHNyYy9udmlkaWEvc3JjL2tlcm5lbC9ncHUvbWVtX3N5cy9hcmNoL21heHdlbGwva2Vybl9tZW1f
c3lzX2dtMTA3LmM6a21lbXN5c0luaXRGbHVzaFN5c21lbUJ1ZmZlcl9HDQo+IE0xMDcNCj4gDQo+
IFRoZSBwcm9wIGRyaXZlciB0cmllcyB0byB1c2UgR0ZQX0RNQTMyLCB0aGVuIHVzZSA0MCBiaXRz
IGFuZCB0aGUgY29kZQ0KPiBpcyBhbGwgaG9ycmlibGUuIEl0J3MgcHJvYmFibHkgZmluZSBmb3Ig
dXNlIHRvIGp1c3Qgc2V0IHRoZSBkbWFfYml0cw0KPiB0byA0MCBoZXJlIGJlZm9yZSBhbmQgdGhl
biB0aGUgZnVsbCByYW5nZSBhZnRlci4NCg0KSSB0aGluayBJIGZpZ3VyZWQgaXQgb3V0LiAgVGhl
IHByb2JsZW0gaXMgdGhhdCBudmttX2RldmljZV9jdG9yKCkgc2V0cyB1cCBwZGV2LT5kZXZpY2Uu
bW11LCB3aGljaA0KbWVhbnMgdGhhdCANCg0KCWlmIChwZGV2LT5kZXZpY2UubW11ICYmICFwZGV2
LT5kZXZpY2UucGNpLT5hZ3AuYnJpZGdlKSB7DQoNCmZhaWxzIGlmIGNhbGxlZCBiZWZvcmUgbnZr
bV9kZXZpY2VfY3RvcigpLg0KDQpJIHNob3VsZCBoYXZlIGRvbmUgYSBiZXR0ZXIgam9iIGV4YW1p
bmluZyB0aGUgY29kZSBmbG93LiAgDQoNCkknbSB0ZXN0aW5nIGl0IG5vdywgYnV0IG1heWJlIHRo
ZSByZWFsIHNvbHV0aW9uIGlzIHRvIGp1c3QgZG8gdGhpczoNCg0KCWZiLT5zeXNtZW0uZmx1c2hf
cGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0tFUk5FTCB8IEdGUF9ETUEzMiB8IF9fR0ZQX1pFUk8pOw0K

