Return-Path: <stable+bounces-192976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9CC48582
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1945F188D0B0
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8B2D7DF9;
	Mon, 10 Nov 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8wQgrRE"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6ED2D7DE7
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795877; cv=fail; b=PHB4OX6Kig4ILryGBc+wCYL/Ai3kChYIs8sZ5B+TnEqkDcmas1hGQeEHpJ6Lw4dSmSL/Y4jSkLcBLmrDHFEkpz5KNiBq/i/zXyJInLi0s4JqPz+LHZGSZQVLpkeMZHlBFcuEEJv1HvVNJeNAJjRgeNUl0pHkinfut7oYLaeQs3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795877; c=relaxed/simple;
	bh=Js/gyehqHFsfShYZK/OVu1QlskLVETt9iqlPI+MaLrY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txVSxZCnCUSg4jAHWhVooSSK4qi8He39baabHuhDo6GrRsApETxl/ck+jdIlPeeREBHR9YUJ7gu8Jz9Bjurqya9pe+y9FHGo4/wOeJOJ2BUKlpFnbKcbbaRMpX//DTVGEmwo4Imd3B/iSFAGIPDnAiWKP/ugMs/wxPB0ybBd4Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8wQgrRE; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDsKfBDcPwomUVmSQFcD/7bsmpLAvAb8QmQ0DnD6AIuqZ5yYc8tKRsEXDx2Q38OpqKn2JkeDCkc7xmgBaTENK0zdsKG0V1pFAGoLxXlotqYRBHezzzjprPdM1nZ1aRpTk1iKd+sumspJUYHPikYswgXtD7/YWNMmYqKoN10MsxQHzaicU0QRobWUzltK0X+yGq0MxPRP53KdHIfFYneOD4BLeoY5R1cFiblhICOjDsivu/TWXZXA9zsCy7wTiqcl/A1SwD8UrWERrNU9ZIdmdV1/OYp4Tyd7KLKk3POUySTjys1sI+otYMDLeAVsyRPaagG+kXAJ8vUJ/Ymzi5wPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2juLH/f5JW2b1Tm9FLbHWxyOMpFSYos6KYcLctAZHU=;
 b=XJTApejJBLkS2mVpCZDhttaXq2dUZBp6i77+ndNvfHqRiwUZ8JO3/CSQMOsP3hPjot8xKf1ywrZcV81+U/jI7Le7VTbc4v0KkXb6FnclOYnr/jY0MC/xfPXkRJ8qIbO+2rQ2R284DFZvSqXosagNPFcAUobVrPlV6cxDCpjPgjSrurKJFa1wdl75/3JgfJ9LKpsjOzrXHTsv4ErZbOrG5b4J8lUg8fMEVmJtciInxpKef/3JpDXDwYvJe00ZRP3EYRc6/zBRoFHJvyGXc6hwZOq1cWBeTxp9ZNUERTAo3yqzoX5pSgmqN7WWEMNHd3KnCnDMGSLJTMKT9O7SqfBNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2juLH/f5JW2b1Tm9FLbHWxyOMpFSYos6KYcLctAZHU=;
 b=Q8wQgrREIK2nVLZ+YmICksZOrWnJE7cB4Q71NOVVUg1kYH2FHanEWQomhl7c614cNgV8hqglnoVIXXMjQ3XlaQphxlaahSYYYXCzebIMl7i/jZQDHpMSl5MA3sjq9Mlms1/Leod61oOR1EVPwnjTP6SnG0bPHKGPf2BS3TkRlQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 10 Nov
 2025 17:31:12 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:31:12 +0000
Message-ID: <6941d0c7-31c4-4792-b97b-7ff25860b97e@amd.com>
Date: Mon, 10 Nov 2025 09:31:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "net: ionic: add dma_wmb() before ringing TX doorbell" has
 been added to the 6.12-stable tree
To: stable@vger.kernel.org, mohammad heib <mheib@redhat.com>
References: <20251108172617.167174-1-sashal@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20251108172617.167174-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: b3131f9f-b752-428c-1a2c-08de207ef178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm5JczlXZit4VWdNL2pjdWFRc1ZtcEljN3FzVDJpRWl5NG50MWw0blIyZjQy?=
 =?utf-8?B?Z0JQTk1wamVLaytLdXo4L0Y3TFFrUThZdWFTOHlFVHlDWHV4ZXBJYmhRcitT?=
 =?utf-8?B?bHBQTTJOSUJrSmZ4ZEFEV0sxSVgzKzRDN05rOHhlaTl2WFB2eHIyMUgrY1lj?=
 =?utf-8?B?OWRqUldIUDBWUGJNNHdXeGNFaVNqUE9sdDBkWlNHM1hYYnQ3MGwrLzJqamxF?=
 =?utf-8?B?QjFIOEVSWkJXMTdwU3ZFTjFRL1Y2WkRWc2p0cGdZTGNIZjNBa0dVMWtUT2xN?=
 =?utf-8?B?S1pHaTBTTE85aTVwbUZuNi83T1ZOZE5td055TUZKWTVQZXpMeDlEVHdzRFRE?=
 =?utf-8?B?cTA2bHU3ODJWNjNzcUdNNjZabXE0azNzQjMwektnUWdsdlF1MTdyMVI3Vng1?=
 =?utf-8?B?bGpKa0xNMVBsc2VCdTEzR25abElPa3BpOXdXekhickdQM0ZQcnM1Q0xMUGs1?=
 =?utf-8?B?YmZERDZUQlZyeXZsNDdHTzZYcmpKK1pOWUNYNUhoUDEzUmhSS3h5Wmd2OW9i?=
 =?utf-8?B?KzR3WWE0MU1TZ3hjMlVoNFM5c1gyYmhrZjRtTnN0eWhhVjJtUGdxd1JoZHh4?=
 =?utf-8?B?UFNsUEFvVHlzU2cwSFNKNXZiUUJOV1ZnMUZWS2xzWVhaV3NqdjJxUzhENnBu?=
 =?utf-8?B?REZQVngvTDFSN0NLV3pIN1hUZ1VBQW9oeWtLZ3c3cWM1cyt0SmR0SERNN0J3?=
 =?utf-8?B?eFZJZEo0UHhvK3lGSDErREdwVm14dlhEeTk0RnhBckRsSWZUdUZma0JoajJj?=
 =?utf-8?B?bGl3L01IZ0FxbmRaOW1ZNkZHcnQ1SFFFaFVlRDZ2L1h1bjJyQWxFVXZ2WUJo?=
 =?utf-8?B?cVRTS3I3YzRyVlQ4SFNWdGJQVTVZMzFsMDA5b0c3cUxwTy9lVjVLSmw0M0dQ?=
 =?utf-8?B?RFJEU2N4ZE8vM25weGMxUC9nemhYYnJxTXNLRVBDUmVBWXpVVi9vWjVIQ0Iv?=
 =?utf-8?B?TU5QUWtNWjF2dFJXcGxjY0xUS3ZlL0MrMXNCWmF4eTdEZ0F0VXJzYldXZWdq?=
 =?utf-8?B?Q3J0M0FlRW9vRi9DaGRjQTNXR1BrVFIzNVU3Mi8vTWs3NnVFNFkzSkNLSkQ5?=
 =?utf-8?B?TXNqUFlXcEhIMzg5Q25nM0N1bTlSK2U4eFMzMVo5UTVQaTYvVm1pamFYeDQ4?=
 =?utf-8?B?c0pMODZva1pIcUxmWWtQVGpOYzFXb3k4Nk1QOGd3U3ZyMjF4VTJvZEgrS3N2?=
 =?utf-8?B?YkhZeGtyUnNJekJPb2twR3VYc1ZYdDNGY3Nqc05pcVE1OXptR3BMaElJUmM5?=
 =?utf-8?B?c2drM3BweXpLVWpTamtad1RWa3NtUXd5UmRWckJlZjJjTTJoY0g2REpiTG44?=
 =?utf-8?B?R2ZSY1dqblNkeVlUQnJjendBNW9CZjRsUVY4UG9qTjJUVkJXVC9VV2hmS3F6?=
 =?utf-8?B?TFRRMUppODFFRk9Sa1pHUVRIZDBtSWhhWDJxeDN0WSt0endpOEtiYjhNR3NZ?=
 =?utf-8?B?T1ZxOEpiTmlYc1Rub2s5SzR6SzM2bFFFSk9nbHoyT1FOeG1pMU9JN1JQQi9O?=
 =?utf-8?B?bkdWc2ZjZWQ0M0E3ZkljMHhMRHFjb2ZzUmFjL3Y2K2U3UjFhQnNnaXdKSlBC?=
 =?utf-8?B?V2UxYkdzQ3dXNFVPUXlDN3o2VE1nRktwMjlZM2hyNCt3NWF3Zy8yODhra1Vs?=
 =?utf-8?B?Wm1HakE5c0Z1anoxbVc4S0NXVE15cmhkblNkTmVyNFZlUCtHKzlhZ0p1ellP?=
 =?utf-8?B?bkV3cVJoNFRaRHVXSWJTZHJITkRaWUU0SkVNdlNYOWFDelplMnozcjVBSTBi?=
 =?utf-8?B?ZHNHYWszYjFKMVEwaEpBMWhNL1VnQThDUGkvUG1aVTNvZmJQWjNSSG5QaG01?=
 =?utf-8?B?S0dsNHBpY05DeW1ZbVZuclJtUExGUXZXTmE4ak5Ka2ZnWDJwcHJBZWFjZk5Y?=
 =?utf-8?B?Z2N5QmxNVFo3ZUVJT000M2wvdTB3SzloTGptcEVrbHpFbVJBYmR2aHRZRUVp?=
 =?utf-8?Q?Omf6HTkdPng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUl3RUtxTHJLblZHSW5xN29mQktUUllVbVVUcW1EdE1VSzMySmdKRUhNRU9j?=
 =?utf-8?B?WThnd0dZRWVlNW9XaVBnQWN2S2xDYlEyQThZTnVldzcxdm1IMUxoUGRJcWM4?=
 =?utf-8?B?cWl6d3NxY0VSVjQyTVEvNjVuSVVqeWExdXBaWUcyNVBDZ3IzK2ZTa2ticTdk?=
 =?utf-8?B?OU85RVNnSm9JWmY4NXlQZ3VOMkdYcDVIMS9rSk9taFczR3pqMWRSZkdLeEQ1?=
 =?utf-8?B?eXlON1FNcFg4Vk10ZlhnZVArSEVTK1RVY0FlYkl4SHdIN0N4ZkNBM0hHUVRq?=
 =?utf-8?B?Q0tzWVZNTEFvNUVPdnQzeTZZNnQ4dktiMmtxeGR5cVJEaThISmE5NTNoZTE5?=
 =?utf-8?B?VVd0UFNPRFN1OVRDVVV0NlNJZGV0T2dqQy9Va2IrUVJaWVpRK3JsR2pxK3Rs?=
 =?utf-8?B?VktEWUl6cDFYT1pDT2lTV1ZxNUZrcVU1TVdWZ2dNZy9LT3VWVzErcityaWFE?=
 =?utf-8?B?MVFvdUNGRzR5NVFyNlZheFVCN05JU1p0bVIvRm5WeEhWU3VCQitRWE5ybHpE?=
 =?utf-8?B?bldXQTFpOWx0V01laURZcTZYRWhYSlB2MTdXdkhzVlcvN2FGYllkck5KS3F5?=
 =?utf-8?B?K1MyQll1SDNMYXRyWThhcTYydGdLNzZzY3BRTzZ0ZmxvUk9PZGgrL0lkN0Fl?=
 =?utf-8?B?b2RjQUl2UGI1NlNvV3F3TU9OSUl5MjR6NVBid25PZUNpSUFMbTArS1BXdHpO?=
 =?utf-8?B?QjlBTTlROUhSSnJsN1E2emk3U1hIK2RFQXRMZzAvQUZmaDBWbXlqZEw2VzNT?=
 =?utf-8?B?OVdPR0ZvNVU4NWRMNk1aeDF3TnN5czB2d1dPZXpGcnZXQ1prakZSSWUyMFhL?=
 =?utf-8?B?OEdPWVZiQ0lYUGpXcnBaU0NyWXQrY09makpHbEZUWXpnMVlFcVdYaDFjZ1pN?=
 =?utf-8?B?MkJVUGF5K1hqRE1HbjgrSDVHQ3J6VStnWTgxWDV5cXEwc09zVnN6akRWOVJT?=
 =?utf-8?B?NU13cjA5blZRM093MzdUU21iMVlQWi9tOVNjV1NDZjcxKzV0RDk5QlR4WnNi?=
 =?utf-8?B?QVo1VzA3TXEyaXVFQWtKM1pxMGNwNTNBcHQ3czdrU2thWVNWWkQ5KzYvTVBV?=
 =?utf-8?B?UE92UmJEclJETndoTFZyZTBqR0xTRjRxQXR2b2ZQQWJCUDk3K3o2U3N6ZHFi?=
 =?utf-8?B?YXYwTVJpTjF0aitPcEF0b24rNER1RlNodEplWmFWNCtLdDlONzRsekhPS1lY?=
 =?utf-8?B?Q1Q1U0UxQ0FDZkhMWGgwSDJPanQwTGZQaFQrRS9SQUhPTWV0bXYwMnpSaWIz?=
 =?utf-8?B?SnBDVWJQU3o1RTJpRXZzMTU1dDNMUGdWTUV6c1NDT2laYU5lT1ZqR3YxeGhE?=
 =?utf-8?B?c1ZDNDFIOTFDMDhLZm44eHJJOXk0MnFjVVZYWUhUYWtRYVNuT0NybTl3aGgy?=
 =?utf-8?B?TVhxQzBtN1UzeTdtbWt3OExXa3lNVTJhekU1V3pWWkdDTXBKRUZ2eG9kYVBw?=
 =?utf-8?B?eFcyallNRndWTnZpUTROTEFic3pQZjV4bTl3ZnlrRXNQUUZkS1gwTzJRUHZ2?=
 =?utf-8?B?UmlveXFTTldnSldHSXBPYW1PN3hTNWo1dmV5YmRoVFB4WU5iOThVZ2FwRW9R?=
 =?utf-8?B?TzVTa3dsTE9YZm9Jbld4ZXZJTkFJZkN0K25oc3RZRWVNTGIrdjJjVlM0Undm?=
 =?utf-8?B?c2pLZ096Vm1hQjZSSko3QUZmQ2hOOEp2MExOUSsyZVpNV0RjWTlFWktITXVO?=
 =?utf-8?B?ZDk3QUlwajBzMWhON1JCYzNlUFZaM0xlblBUcVNpMnFyR1hybXRXUEJuNzBV?=
 =?utf-8?B?THQ3a1h4eVo2R2V0aDN3cTFmaEV3dnlZOTJ6S2p6QWo5VWJmSTNkRkVveDEz?=
 =?utf-8?B?YzhSRHlkYjlsWHVuMUxEdW81aXZSSkFnL3RvOXNMT1l2SXFMYllQNU5za3JS?=
 =?utf-8?B?UHNGWWZIQ0xJT2ROalVrVS9VTjlzSlpsNjA3V3FtQmRyN1RrcFRvRCtvVTJs?=
 =?utf-8?B?R0pCMXFFQjUzZlY4ZGJLMnJEdzZZeVNvSkUydjZFY3htREpDa0R6WGYrekRm?=
 =?utf-8?B?dXBtSFRpZG96YzlleGNHNGRnY3lXMldyK3h1RlVsK1JjVXp5VXZRZmQ4Q3V2?=
 =?utf-8?B?THNLSkU4dGlhZ2VEbVlNc3FiNXloaEZJV0JRVHNaZS82M2lwdjJtVi9sVzYw?=
 =?utf-8?Q?U95idhN2wOG+Ayy0Yhl9HykwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3131f9f-b752-428c-1a2c-08de207ef178
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:31:12.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEfTxG6NIB1xE+Yr6tClGgaYgJ0/6Js5Fw+zsBsaYLuD31/pDDetuHDuKmtGEoKDTwzQI/XxGDbIyysxq0ZV+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830


On 11/8/2025 9:26 AM, Sasha Levin wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> This is a note to let you know that I've just added the patch titled
> 
>      net: ionic: add dma_wmb() before ringing TX doorbell
> 
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       net-ionic-add-dma_wmb-before-ringing-tx-doorbell.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 05587f91cc2e8b071605aeef6442d2acf6e627c9
> Author: Mohammad Heib <mheib@redhat.com>
> Date:   Fri Oct 31 17:52:02 2025 +0200
> 
>      net: ionic: add dma_wmb() before ringing TX doorbell
> 
>      [ Upstream commit d261f5b09c28850dc63ca1d3018596f829f402d5 ]
> 
>      The TX path currently writes descriptors and then immediately writes to
>      the MMIO doorbell register to notify the NIC.  On weakly ordered
>      architectures, descriptor writes may still be pending in CPU or DMA
>      write buffers when the doorbell is issued, leading to the device
>      fetching stale or incomplete descriptors.
> 
>      Add a dma_wmb() in ionic_txq_post() to ensure all descriptor writes are
>      visible to the device before the doorbell MMIO write.
> 
>      Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
>      Signed-off-by: Mohammad Heib <mheib@redhat.com>
>      Link: https://patch.msgid.link/20251031155203.203031-1-mheib@redhat.com
>      Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 0f5758c273c22..3a094d3ea6f4f 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -29,6 +29,10 @@ static void ionic_tx_clean(struct ionic_queue *q,
> 
>   static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell)
>   {
> +       /* Ensure TX descriptor writes reach memory before NIC reads them.
> +        * Prevents device from fetching stale descriptors.
> +        */
> +       dma_wmb();
>          ionic_q_post(q, ring_dbell);
>   }
> 

I posted on the original patch, but I will post here as well.

Apologies for the late and duplicate response, but it's not clear to me 
why this is necessary.

In other vendors the "doorbell record" (dbr) is writing another location 
in system memory, not an mmio write. These cases do use a dma_wmb().

Why isn't the writeq() sufficient in our case? According to 
Documentation/memory-barriers.txt it seems like writeq() should be 
sufficient.

Thanks,

Brett

