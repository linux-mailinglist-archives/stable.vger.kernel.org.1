Return-Path: <stable+bounces-144208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA875AB5BE6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950C01888602
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3162BF983;
	Tue, 13 May 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gLMFiJOY"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41432BF3CD
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158850; cv=fail; b=FL0jA22K36GLwCrGypKgcK7aBZjglzgo7/zAsLDCuSow+yvwApGAAlV3gXhvYvbg0cCEJEql3SGNPmM25pwsuqFTopU6jmU6LrKGWDKBT5Ul0ROz3t/gCBA4lp+YAlEPGVgPexQOcR99ekvuNp/SKeg24wW529oDGJIDU9ZZRro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158850; c=relaxed/simple;
	bh=VaWkMVOmyhVlWNYbKE4N9AtyN7YLHFTG5Z/5eC/+GG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AXibT37BretnCE2wGUvQ9wt72dLl/cKMwo9oGJco1891voIWzp9GvpOzLd8H8IdgyLu6lMAo7yJzK7qLnVCQ0xa6r0cGr3oV8We1ncaPnOSv3PrXb4HDbBEGIEB//PuaBGMX2Y6PItMpKI2CL2cf0x+4I53C/35qhf051Yq7BOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gLMFiJOY; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBzmwELFMhBi613Hcrh0f/iAtqZOzDemBmJhDSGHptLr8cDcCaY+AD+4UOoJXgm5hsvHlH2bbemlz9Vn5JZxrmZ8y3JOEcC5zQk9kRgeaItTt0KsxSF83DzN7iYM3ykQ806vwiHWlhMAmRsqUCWWayVRfMXaT06TFtNv/Q0QA1e9OyNc1TwEK+jO3VpXzgSVk7WAwWrKz8lbPzYkeUDWzNj1c5Hf1ZrYF99pZ95uLY6WgHbdDbXMgti8ifYs55w7nE2hIW3OWZhJYir5HgtYht7vP+++0ezNZu6pDVdX0mz+gAiXarmp1YZlTkxkWhuyHHbQ9ry3o3xRo/09Ieqobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaWkMVOmyhVlWNYbKE4N9AtyN7YLHFTG5Z/5eC/+GG0=;
 b=tAFGKOcQe8ahQGSReghwaUde9zO+jQ1pRaWiz112fWbtz8lnHUgpbboC++M6n6ULYcJ9mbLXoD3eny8+04QmVKSy1e1qKNZLkJNT2QvrshK+2TD5LUnWY/ndWKOa+GGXT5OdMnNxXZG+rvQsClX2AJ1kF3ivHywJZlhXFgInbV9lPDhEa1O4kRVYbYNGLL5Hra/HwN9OcnvOsoaSeQXx8s68GEkUfNEuwSa7Z2J6x7KgGdAWbBvGUcd+6PWESQOPlVfzE7OL+chOokUwyhy2RnyZ8+DxG3LB/uFrlFqj2d3NSKr+nDJdtE0WCvNIF2eJ6PNKxjX9c9p23RnXidfTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaWkMVOmyhVlWNYbKE4N9AtyN7YLHFTG5Z/5eC/+GG0=;
 b=gLMFiJOYAHFqrjSo2WUT1Nyokki7l+wKf7lgHme//oylFjhy21VznuO5AdydWyrFxb4tZF7dIPu7SlJwjRK4bxBqHsHMHfoCTfnbvVACxA8d77yKXm2zGHjr2QDDdNE60JJK8xKZCKyriD3ydwiIKAx3cgYxh82mKKijso2Y6wI=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 13 May
 2025 17:53:58 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 17:53:58 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny"
	<Sonny.Jiang@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
Thread-Topic: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
Thread-Index: AQHbxCQ0NEjaVFU6C0K1l9AaYwbYeLPQxG4AgAAAxYCAABFHwA==
Date: Tue, 13 May 2025 17:53:57 +0000
Message-ID:
 <SJ1PR12MB6194CA9BCEAB6A35205822449596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250513162912.634716-1-David.Wu3@amd.com>
 <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
 <23d465ec-a15c-43ae-ba1e-052cf342ba43@amd.com>
In-Reply-To: <23d465ec-a15c-43ae-ba1e-052cf342ba43@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=eb87ef47-79f8-43ac-aef5-2cff48ec160a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T17:49:31Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|LV3PR12MB9332:EE_
x-ms-office365-filtering-correlation-id: 28db4dc0-16c4-455c-ca69-08dd924722c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tm5pOFdFNFBxVEpjUXI0bk9PWTlBTFhPOWg5bFNJUUpqL1VvN0NHM0R2cE5u?=
 =?utf-8?B?aEx5WkJTUE5kYWxWbW9KRWphZGRmV1FzQUtGdHdYQ3hzSXhxU3draWpPQ2dB?=
 =?utf-8?B?Y2p1K1ExeG9YOHdjQ1ZHYS94d0E0WEtrV25ZZEwrSHlZUDB0WUJSQld1QWNi?=
 =?utf-8?B?L2FaK256YnhsdEw2Umlab3M3VEttcUlkdm95ZG14ZlBjRWVkd2FlcXU0OVN6?=
 =?utf-8?B?ZWpuZm1hMDloR1NjcXRMQ3NoMzJmdHNRcTNZVzBZNUljbHhCSTVyS09uRUl1?=
 =?utf-8?B?QkFmQnoydjFDakdxWmdlT3FDY0JPbVhUWnBBSHlxZjhrT0xNZXJHNXU4Njcx?=
 =?utf-8?B?RzV1di9jR0hCSitMbnJZaHZRQlhSdDFjNi9ESGUwUHhIUk9JM0RRUDZmdXpp?=
 =?utf-8?B?eEZCWWZXRDVmSlpZcE1KTjRGd3JlRG1aTTBoUXNIeU9KUlNoNmFGaXBPbEFs?=
 =?utf-8?B?amhuNTRWbzJid012eW1VcU02TGJhbDlCNU5BMHJTUlNnOE4xUnlGRTVwb3VT?=
 =?utf-8?B?L2dFeGZTaThhU2sxYjRxbWdPRzhhZ2dYRWNRck9hTDJRNW10RjVPVmpMWktO?=
 =?utf-8?B?SFE5YWtXZkRwcy9Wd3RQZng3SHk2aFJkU2FQaEJtcE0xNEVNV0JMTUtWM1pC?=
 =?utf-8?B?cEhyWHkwbGo2K0FuYnBJdmNPVWhvL1VCd21KZlIzOWQ2azRBMXZrSUY2SGFr?=
 =?utf-8?B?WEtUYUVrc1g5WXNudnJsNGluUHZ3dTlCV3FLRXFINWhvMUtoUzZHbGVSMCtP?=
 =?utf-8?B?MDFMNHdzRk5iYUJrZXRiaWZ1a3R1aFN4RTV0b1N0aUsxdWxjNFJReGF4L0N5?=
 =?utf-8?B?YnFmbHhXME03aG5Pb3BzeFJ2Z2ZvcGtyZzZIT2EzZ1doc1AxUnBZMCtVaEly?=
 =?utf-8?B?TG1YZERmV3Ara2NUb3BpdFJObkdYdDRBck9KOElvZlJuUndFai9JNHcrY2tP?=
 =?utf-8?B?UXc2dlZxdmp4cnkxNm51d2c0VzRMeG1UTXJhUGtoekd4cm42cCtJVzcxR2Rt?=
 =?utf-8?B?VnB1SjlSalNGZ05nSWtFZmZJOFBDWnVFc05KYXZLWUhCMXVLVXdOUDV0REg0?=
 =?utf-8?B?QnlHWDBudGhoSHAySXdDWHhoRjFNT1g2WXFJcGw0S01pazd4ZU5PYXN2cjl4?=
 =?utf-8?B?Zm1SVGVYUmlkZ0ErQUM3cUc5QzdoV3RIRnQrR1FnZ0h5MGVjVTJRdzZZZmNH?=
 =?utf-8?B?a3d6ZU1jdmYrSEsxWHU5Y1dVblEyUjUrbit4TGduYndYR25qMlBwRXpXQmI1?=
 =?utf-8?B?a28xUGJlbWtmQWtxYUpPNlJEUnlmRnhnZU81cE04ZU1PVTdmWjRzTnVSeVpB?=
 =?utf-8?B?Yi9wUGFkL0x6TXl4R0YvRVZsSk9LRlQrSWdFT2l2bVo1NHliQm5hQkFnaWlO?=
 =?utf-8?B?ZzB3NVhGOWJlODYzbGV2MmJRMkxJbm5UZnBEUkV2dDIyR2V2MWovV3NCR0ZV?=
 =?utf-8?B?Wk1JSWpRL1dscVhlenFDUHZwSHNlSEZJWlZuZDU1eGdOK3UzYmJoUWtsL0pp?=
 =?utf-8?B?SnBGc1lOYXFGSmVWOHlUaFB5cGFYSEcvL1hxd3Y5cHRwbldlWDArRzRwWC9I?=
 =?utf-8?B?R2wrVSszd2l0NzVjV3F4SUVPREx4eFFqbVlSdEQreXYrYXU1Sng1V3M0ZGx4?=
 =?utf-8?B?emNQL1BjRlQ5d1pRTHBEN3F2VjNpbW9zOFJZcUhLVzdIT3pBbi9Fbk5VbTk5?=
 =?utf-8?B?dkg4TUtZem1YdkNqU3Z4VDBWbHpqNmwzaEZRNnVWOUF5a0ZCMzBmclczYXRP?=
 =?utf-8?B?MUFRbk9RMXc2NFpteXhYU1FEaXYzZ3llaWtFVDhaMVdXbk4weFVZL3VhSEFl?=
 =?utf-8?B?bEU3b3JKcGJPR2pES3RjTDB4ZmtpMi84b2EwM2tEQkUxMGl0TzRsS0VtVjBN?=
 =?utf-8?B?VjRjZHZoRzVicld4blFDS0VsbTJsNWZXNWR4S09JNHcxMVplRERmU291SzBL?=
 =?utf-8?Q?UrILPknBQ9U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkVMWVZZUFFNVFVJTitJL1EvbW16VG4xeEpUd3hGcTZlYWo5SlZTL01XeWNY?=
 =?utf-8?B?Zkp1NjlXbGh6eGZJbmhGK2hYNTErNnhKSkJsNG8rcCs3d2p2ZzQ5dnpVN2hH?=
 =?utf-8?B?VHVNeWRnRks5RTNlTlMrbzV1MlN1WHdkeVgxa2l5d3B2QzBmZW83QWJUKy94?=
 =?utf-8?B?b2JQY0FkM2czU0NQZTBBM3BwdnA1dWl0aVluamc3Tnd3UXRHS1Vxd1JZQXdG?=
 =?utf-8?B?RC9oWVdkUVlSKzRwMDNCdUlheUtjOStwZGF2cmZwV0J1TGdiYVE0TEROcGEx?=
 =?utf-8?B?REkyL0tWQlpRNkRhQ2pMa1E1WU1uVmoyT2lGU09mMzNURlpTRWFUNm54TGhB?=
 =?utf-8?B?aHVSZ3YyVFo0WmNOcWt1ZG1zLzJPYW1mbUM1eVRZb2tlbzFhaFcxNmNtQVVF?=
 =?utf-8?B?aXRFV0FkM1NTaGVzTmdnRXl0UGVjdGRUMlRnT3VpMnF2bGIybUxLUmlGWkx4?=
 =?utf-8?B?TGJMaUYzSmZuZHUveFFxUjNuMTVGYmpkZVN0TWF1ZTlqRzBEb0xKWktiK2FX?=
 =?utf-8?B?eVdlV1l5M2RlVUFuSngrRjVRNWZYVS9maU8xRjJHdlBMM3dXYU90Y1lqMlRD?=
 =?utf-8?B?YlppanEvOW1HYjhuSHdGZ2dVc3h2S0VUaXJndGFkVFFrTUNTdmplckhUMW8v?=
 =?utf-8?B?NitMaitpTjBvZjRjU3JrVUEvM0lJWXNCOFBDSVV5WHN4Q2I4cUtRZHJmWUR2?=
 =?utf-8?B?NERrejMzZW5ZazBnRVlUL0pHRmRPZEdMajVObGsvTXVEZVM1WXpBSHBTdFZJ?=
 =?utf-8?B?b3pteTJ3UWpneno5eURxZUl0L1JnYlY5MGJRejlNV2xwdWthNDAzdy9BOU9G?=
 =?utf-8?B?TzVDbEJnbGduRHdJWDY0dnNDdEJDa0VEYjI0Vk4xUXJDVEM0YTFrbEZEdzVK?=
 =?utf-8?B?UWh6Tkt1SENYRHdDcG5yRjhRUHIrb3lNWjFRdWt2QmRYdW9EcVJJSWIvODFv?=
 =?utf-8?B?N3MrVklTZFkzRXBjWE9zMGMwL2xLZEpEQTY2UDZuU3kwejg0OUxJS09lczR5?=
 =?utf-8?B?RWlobE9QTDdhZTRubkFya2FnR1pCYy9KS2czYVBEQ3J5NFc1NEZabGZxeTZR?=
 =?utf-8?B?bXV4dFRINk1tYzdiSmhyek9oeWphd1J6QUw2cWV0aXB2YUNBek55aXRaUFBj?=
 =?utf-8?B?SEFvbjZjdmJnNUtJcTVUVnVJaEJTLytzZzFlM1RYbjc2UHNlSXZ2VmxrcUxL?=
 =?utf-8?B?UTJqK2VtTC9GNG9mVHhtTXhxeDBzQjYrVzI5M00zMHJaMkMyLzlHdlQ0NFNn?=
 =?utf-8?B?U042T2t2aHZSSnJNQnFRRTA4NUUrVW9lNHdTOGs4WmRpTGJ0V3FKRzZ5THd0?=
 =?utf-8?B?c2l0NEQxckFadGh5OEtUeDFoSTMyZTlqT2NBUDhLVGw5OUdRQW41bWQzY3J5?=
 =?utf-8?B?emZQQndQbVRzMy9Ib3paY0oxckUwOHZiQTI0TDFEbUtWQkJ2d3hlc05MRzlG?=
 =?utf-8?B?U05JMFZmUzBHLzB5S09zcmtLMExWS0c5MlljMlFrbHYzTnR5U0dmbGljNU1U?=
 =?utf-8?B?WUhkOTlXUXJ2djVBazdsemJ2THpRSVV5UHdBYWZKdUtYeHE3dldXN1I2eTR2?=
 =?utf-8?B?dGtsSm1Zc3NaaVRxeUFkQk44WXRwSW10YzNlL1FFaXNyeVRVS1ZMMXNQTVpp?=
 =?utf-8?B?NHNpM1RGUEE2cE5GS1VzYjRxWEhPb3FrNTZFRUdmUVE4a0pFelpEVDZVU2cv?=
 =?utf-8?B?R0JsaEY4c1lZRUV1NXNyaHdCc1ZRYnBVUVkvckRER2Z5bnd1R0dvdDFiZXRZ?=
 =?utf-8?B?a3pWT2gwUVJSTXVTaWpZNEoyZnh6cHhMaXN6NkJOV3VTaUY2UHV0d1Q3RHYv?=
 =?utf-8?B?YnZiVktOckJPZVhuL0lmdUpWd0U2S2Nwd1F6Mm5IN3IvQUNIQW1Ga3BOcjla?=
 =?utf-8?B?TmhLcUdnOGRkajlJdW0za2pBTVlwclFaSzhHYnJnc0N6R3cvSkZ3dzc0ZXVP?=
 =?utf-8?B?OXRpZHBGdncyWng1V3R5ZUkweU1uODk3MmFnU0F1RUtGT3lSeHMwSnBVZWlv?=
 =?utf-8?B?VzFRY21xUnR0TVlCenYvQXg3OVNFOU1mMkIwcnQzYkRmN2Z0aGJ1WmVsTUY0?=
 =?utf-8?B?K1l4WFNuZUFwVTdoTWlXL3RjZ1REc3pWcFBOVU9SSW8wd1VLODRybUsyQjFM?=
 =?utf-8?Q?XIKU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28db4dc0-16c4-455c-ca69-08dd924722c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 17:53:58.0269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdRbpahFbpXoOSWd9Jsz34x2YOnbJruLTlwNwfwawGe/WtEM9Rc577XkoN7CHalK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhlbiBkdW1teSByZWFkIHNob3VsZCBub3QgYmUgbGltaXRlZCB0byB0aGlzIHJlZ2lzdGVy
IHJlZ1ZDTl9SQjFfREJfQ1RSTCwgaXQgY2FuIGJlIGFueSB2YWxpZCByZWFkYWJsZSByZWdpc3Rl
ciBqdXN0IGZvciBwb3N0aW5nIHRoZSBwcmV2aW91cyB3cml0ZSBvcGVyYXRpb25zLg0KDQpUaGFu
a3MsDQpSdWlqaW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXdSwgRGF2
aWQgPERhdmlkLld1M0BhbWQuY29tPg0KU2VudDogVHVlc2RheSwgTWF5IDEzLCAyMDI1IDEyOjQ4
IFBNDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBXdSwgRGF2aWQg
PERhdmlkLld1M0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVAYW1k
LmNvbT47IEppYW5nLCBTb25ueSA8U29ubnkuSmlhbmdAYW1kLmNvbT47IERvbmcsIFJ1aWppbmcg
PFJ1aWppbmcuRG9uZ0BhbWQuY29tPjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDog
UmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHJlYWQgYmFjayBEQl9DVFJMIHJlZ2lzdGVyIGFm
dGVyIHdyaXR0ZW4gZm9yIFZDTiB2NC4wLjUNCg0Kc291bmRzIGdyZWF0ISB3aWxsIGFkanVzdCBh
Y2NvcmRpbmdseS4NCg0KRGF2aWQNCg0KT24gMjAyNS0wNS0xMyAxMjo0NCwgQWxleCBEZXVjaGVy
IHdyb3RlOg0KPiBPbiBUdWUsIE1heSAxMywgMjAyNSBhdCAxMjozOOKAr1BNIERhdmlkIChNaW5n
IFFpYW5nKSBXdQ0KPiA8RGF2aWQuV3UzQGFtZC5jb20+IHdyb3RlOg0KPj4gT24gVkNOIHY0LjAu
NSB0aGVyZSBpcyBhIHJhY2UgY29uZGl0aW9uIHdoZXJlIHRoZSBXUFRSIGlzIG5vdCB1cGRhdGVk
DQo+PiBhZnRlciBzdGFydGluZyBmcm9tIGlkbGUgd2hlbiBkb29yYmVsbCBpcyB1c2VkLiBUaGUg
cmVhZC1iYWNrIG9mDQo+PiByZWdWQ05fUkIxX0RCX0NUUkwgcmVnaXN0ZXIgYWZ0ZXIgd3JpdHRl
biBpcyB0byBlbnN1cmUgdGhlDQo+PiBkb29yYmVsbF9pbmRleCBpcyB1cGRhdGVkIGJlZm9yZSBp
dCBjYW4gd29yayBwcm9wZXJseS4NCj4+DQo+PiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVz
a3RvcC5vcmcvbWVzYS9tZXNhLy0vaXNzdWVzLzEyNTI4DQo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCAoTWluZyBRaWFuZykgV3UgPERhdmlkLld1M0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzUuYyB8IDQgKysrKw0KPj4gICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzUuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjRfMF81LmMNCj4+IGluZGV4IGVkMDBkMzUwMzljMS4uZDZiZThiMDVkN2EyIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfNS5jDQo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMF81LmMNCj4+IEBAIC0x
MDMzLDYgKzEwMzMsOCBAQCBzdGF0aWMgaW50IHZjbl92NF8wXzVfc3RhcnRfZHBnX21vZGUoc3Ry
dWN0IGFtZGdwdV92Y25faW5zdCAqdmluc3QsDQo+PiAgICAgICAgICBXUkVHMzJfU09DMTUoVkNO
LCBpbnN0X2lkeCwgcmVnVkNOX1JCMV9EQl9DVFJMLA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHJpbmctPmRvb3JiZWxsX2luZGV4IDw8IFZDTl9SQjFfREJfQ1RSTF9fT0ZGU0VUX19TSElG
VCB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgVkNOX1JCMV9EQl9DVFJMX19FTl9NQVNL
KTsNCj4+ICsgICAgICAgLyogUmVhZCBEQl9DVFJMIHRvIGZsdXNoIHRoZSB3cml0ZSBEQl9DVFJM
IGNvbW1hbmQuICovDQo+PiArICAgICAgIFJSRUczMl9TT0MxNShWQ04sIGluc3RfaWR4LCByZWdW
Q05fUkIxX0RCX0NUUkwpOw0KPj4NCj4+ICAgICAgICAgIHJldHVybiAwOw0KPj4gICB9DQo+PiBA
QCAtMTE5NSw2ICsxMTk3LDggQEAgc3RhdGljIGludCB2Y25fdjRfMF81X3N0YXJ0KHN0cnVjdCBh
bWRncHVfdmNuX2luc3QgKnZpbnN0KQ0KPj4gICAgICAgICAgV1JFRzMyX1NPQzE1KFZDTiwgaSwg
cmVnVkNOX1JCMV9EQl9DVFJMLA0KPj4gICAgICAgICAgICAgICAgICAgICAgIHJpbmctPmRvb3Ji
ZWxsX2luZGV4IDw8IFZDTl9SQjFfREJfQ1RSTF9fT0ZGU0VUX19TSElGVCB8DQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgVkNOX1JCMV9EQl9DVFJMX19FTl9NQVNLKTsNCj4+ICsgICAgICAgLyog
UmVhZCBEQl9DVFJMIHRvIGZsdXNoIHRoZSB3cml0ZSBEQl9DVFJMIGNvbW1hbmQuICovDQo+PiAr
ICAgICAgIFJSRUczMl9TT0MxNShWQ04sIGksIHJlZ1ZDTl9SQjFfREJfQ1RSTCk7DQo+IFlvdSBt
aWdodCB3YW50IHRvIG1vdmUgdGhpcyBvbmUgZG93biB0byB0aGUgZW5kIG9mIHRoZSBmdW5jdGlv
biB0bw0KPiBwb3N0IHRoZSBvdGhlciBzdWJzZXF1ZW50IHdyaXRlcy4gIEFyZ3VhYmx5IGFsbCBv
ZiB0aGUgVkNOcyBzaG91bGQgZG8NCj4gc29tZXRoaW5nIHNpbWlsYXIuICBJZiB5b3Ugd2FudCB0
byBtYWtlIHN1cmUgYSBQQ0llIHdyaXRlIGdvZXMNCj4gdGhyb3VnaCwgeW91IG5lZWQgdG8gaXNz
dWUgYSBzdWJzZXF1ZW50IHJlYWQuICBEb2luZyB0aGlzIGF0IHRoZSBlbmQNCj4gb2YgZWFjaCBm
dW5jdGlvbiBzaG91bGQgcG9zdCBhbGwgcHJldmlvdXMgd3JpdGVzLg0KPg0KPiBBbGV4DQo+DQo+
PiAgICAgICAgICBXUkVHMzJfU09DMTUoVkNOLCBpLCByZWdVVkRfUkJfQkFTRV9MTywgcmluZy0+
Z3B1X2FkZHIpOw0KPj4gICAgICAgICAgV1JFRzMyX1NPQzE1KFZDTiwgaSwgcmVnVVZEX1JCX0JB
U0VfSEksDQo+PiB1cHBlcl8zMl9iaXRzKHJpbmctPmdwdV9hZGRyKSk7DQo+PiAtLQ0KPj4gMi40
OS4wDQo+Pg0K

