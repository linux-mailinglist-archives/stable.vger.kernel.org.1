Return-Path: <stable+bounces-69847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52495A569
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 21:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2587F283E8C
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734616DC3D;
	Wed, 21 Aug 2024 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cntX1w29"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A89137745
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269817; cv=fail; b=kpKYVT9OZPF391JChtoZ46JEzGzUxUr41zFPUc/h486V1Vfd/A3GOYkQFXXiaZTxf4qQpkfZQqhNvUJJie4B6P5Ytkiq+H8C+/63OaZ6P8rbZ33jKtHOOA5Oy/idNbBGdSdaR9tIjgbOnQzRQIZASCdi1z609AvG7VKg8n5Zcw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269817; c=relaxed/simple;
	bh=+kVB5S8WS6UntoVsie7hwvzMPagvKhD9zzGa0jmM3XM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B1h0oIiIKFeV4YE6JVFlyzyX3J+pL3URrb1+EViqyZ164/+/q8RQx7lKsteD84+uemWZiMDWRympC7IuW0/xyJwXsIHz/rIb9VtLBpPx//Me/YlgdKylgvvUkQuE9pLcBE3My5Fph+wEjJdlCjUkwRl1eyRLYP4/BbE4i9Kwyhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cntX1w29; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0tPI56+mc7b34zsweb3pg685oudU9hpG3x0dLARloKB/zeV+aBsnMgTP891xXw2scxoobhGU0/Bmi2qsnLHdDOAi4EHf7EA2+bBJujyHW9OGZkvPCQl5A5XhCqqooEjrsqHNX06p2KVDgF1szv8GeWjj2r2rENyY6F8Qmtvb/MMrr93HhrhS0mXQamcsK0ct/8nSSQT45Br9FFD60QMrPjfz6a5+OWKknUx2PJbW28YAS/NR/92R2KLh6BuCiUDYAr8DyN/RI+z6YzhIjw36gBN7zxzAsIHGTD9pT3iGpIgtuvHmCN9jqE1pCmndia/zNK7MerZN+pt2TPrtEN//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn3UngjTFhDWBbn+6WVb3CQyFX0obb8z5URH37vWxIk=;
 b=WRW56YE87oCHA0geAyHeJlxE0SPQWKHbsoUTPEbdW8f3te91Mawjw/r65uE0Oyqi/Gtu2MfYebu+/YB7iNTrIJq1CbaQIKPwbdoJdjB+WcYKtmvAajSz8oS9uFJRcpym7oJPo5Ti4mbDMktDntB7mvqJHQtTlZ14ybrhwf1oDtHEK02OhUPB1kaLuP37oQwDLWuugkQtQK5771qwQlHJoIk6d4+COErhKAgtsjtvIobcv5H8bWFNnx/WtqwKmkDSNCucODyO4AJ7y/AR7M3NPMGdXd+zHL/baj3E/m624XbMuCBHu8E3KuOzeAJ+Rw+fkwd8/D1ZSU1KKgaSrBF0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn3UngjTFhDWBbn+6WVb3CQyFX0obb8z5URH37vWxIk=;
 b=cntX1w29dgkbG/Q3xcqDUAc8VLReF2QDlYEcMH7vyf5QcGZiRQlTaIrOphn4q+9ifJX78guDJNZKXwGj92ckxrO7eE21wEwUg79nZl+pByycOg0UGa9u463nSueP3MhVtTbCYJt+LtQTEvNgKn6aIt1MLh8ilDPFSvFTdwz5PDE=
Received: from IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 19:50:13 +0000
Received: from IA1PR12MB9063.namprd12.prod.outlook.com
 ([fe80::2eee:d305:3a90:7a86]) by IA1PR12MB9063.namprd12.prod.outlook.com
 ([fe80::2eee:d305:3a90:7a86%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 19:50:13 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Jiri Slaby <jirislaby@kernel.org>, "Li, Roman" <Roman.Li@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
	<Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne"
	<Wayne.Lin@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
	"Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Mohamed, Zaeem"
	<Zaeem.Mohamed@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Topic: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Index: AQHa8rxP3sui2PAPUE6lTVPfU52mPLIyHndw
Date: Wed, 21 Aug 2024 19:50:12 +0000
Message-ID:
 <IA1PR12MB9063C51DD1792ABB26EFAF15E58E2@IA1PR12MB9063.namprd12.prod.outlook.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
 <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
 <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
 <CY8PR12MB819387431D6D6E754929ECB9898C2@CY8PR12MB8193.namprd12.prod.outlook.com>
 <0d12eb50-c51b-496e-a931-9ce8fb6a1455@kernel.org>
In-Reply-To: <0d12eb50-c51b-496e-a931-9ce8fb6a1455@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8a133693-9463-4ed7-a9e7-c22e3e2a03c9;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-21T19:44:13Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9063:EE_|CYYPR12MB8937:EE_
x-ms-office365-filtering-correlation-id: 89fdf996-c3f6-48fd-7326-08dcc21a78bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHRwTGswVEFGWlNKR2dtYkZ1ZGt1US80dTdFbjZtM2Q4NXpSMDUxRjgvcU9i?=
 =?utf-8?B?OENrVm83Z0NxUEN5ZngvQXhldEpYV1ZRYkRXZmpyUnlKS3lUZ1ZBbmtWcjE4?=
 =?utf-8?B?T0M3Zys4NFZIU1BXeko0UDhrRHdndkZWV0xTRk90TFVjYzI5RkM2Q1NobElm?=
 =?utf-8?B?SUtwbXBhUlp2ZHBrbnNSNkN0aDcrK045N012TG1VaExydERlYWgySXhNcjFP?=
 =?utf-8?B?R3plV05jN1F2VE41MjFEaC9QS2RUQURFZnlyTVhGaGdna2Z6WkRFVkNyTXNP?=
 =?utf-8?B?eEl3VE45TTIxVWlMTEpyTUEycnk0ZlRKY1FlVjQzTWtqVS9nV3hzZ1AwczZu?=
 =?utf-8?B?dFJDakxUd1Bab21hVWZ0cThuQ2ROS1hmT29FQnpseXljcFpPY0RFN05VQ3B2?=
 =?utf-8?B?UGlvQ2hsY1dsemg1YUJmTXFkZ0EwMVlRcEhxcGFxS1ZYQTJDM1UwNTk5TmtY?=
 =?utf-8?B?djFHMWx2VmdQemhlQXhSOE85SUNsL3ZqcmRzMldIL2I5NlhwYy8zOFdpcTFq?=
 =?utf-8?B?Y1dVNXFPZmlUT0tjeU1BaC9sK21YMUlETWFPWTd0ODJnVVU4bzNSMG5RbVYr?=
 =?utf-8?B?NGJPaXVOQkVHK0QyOGltNjBZekQxM1hLRWNIWVUyMmVpTllJSWRHNTRxWGk1?=
 =?utf-8?B?OGM5bklYQlRheUIxS29wT2F2NUR2U1BoRHM1THdpMmFVYi9nWTd1RGtJUnZo?=
 =?utf-8?B?bWJGeUV2OHQxdzQxVUhTL3VNWkdNdUhlTjlQTWd6RUltN0R0TkV3akNheE0v?=
 =?utf-8?B?L3RuK0JVbE5ObWZiVmF3UEgramNxajBGNUxiWnR5YXEzY0J4VGVxeUN2Y0JD?=
 =?utf-8?B?ZVVzVVQ3WURlNG5GTjllYk5iOWw1MXdCbHhwS3luYlFKZjFNVy9FRHhWTzVn?=
 =?utf-8?B?bkQrM08vUGwvVTdJajNSQ3AyUno0VTVDUUpXVTl2ZlZnVmVrN1RyM1VhWnRv?=
 =?utf-8?B?Q2I1RXFBdWRXSzZaNDQzWXVDMFp4Vm5XUDZjazFiOFRUK0V2b2k0QkNyUER3?=
 =?utf-8?B?bjR1UjQvSXI1ODRmV0VvZVFwQmpONlo3U1VRRFhtVjg4NkxkOEJsVEVnczIv?=
 =?utf-8?B?L3VLekhRY2hlcER3QlRKNkhlMCtPcTZ4L3IxOWEzWVJSVk9pUHhPUmtZeDds?=
 =?utf-8?B?b2s0K3pXLzBzanpRVGFzRDBlNUdhd0pwUGxUZnVmWWZ6WEpZQ1dpVnN6eXY4?=
 =?utf-8?B?dVQ5bzhmVDRxR0V3dEdnR0ovaFo4M3E2L1RwRTVsbnV5eVBrYjFRTnpHRlFP?=
 =?utf-8?B?S3FXc0xxbkxhYjVmS3RSN2Y4bTE4VDNPYXVCWUdVVkFlWm52Yng5d3BndFVJ?=
 =?utf-8?B?OFNERHZGZTZBek1uWDNkYTY4cFV5ZzBvdGFnZjA4ZkJvKzBmVm81ZThFdElr?=
 =?utf-8?B?b0VXay9HT2t5TldrbWxoWjJUMVBGV0FXbm9yU2pwaEMycHJDeUw1NW8xUWlW?=
 =?utf-8?B?Q0huMzNhZmF4aEFTV1ZoNmdiTmNtNEhZdVczNllFMk9DdnNvVHJkRnRiMXkz?=
 =?utf-8?B?RWY2bFRWY0VpbGpSWFFQMHhlNW5JeE9NTEEvczYwZk85THNScmlqV2RZbEpE?=
 =?utf-8?B?czlUYWpTSUY5eHozWTBZanovU0J0MUdlaUlTSnlOQktsNTVXQVdMUnY5WHU3?=
 =?utf-8?B?S3N1aWZSSzY4Uzl3aG1La2diS0tZbUp2TmxRV2VwbkMxcDBxdnpCM0VZWU9k?=
 =?utf-8?B?OURBVHVtaURBQVdTZVJ4RldieVVrbHY1NWF6bFh3b3FIVzdYRUlHMnFuQzZC?=
 =?utf-8?B?WHFzbVZnTEsyOWV1YXlzRmRvR2R0dm03NlNLejhOY3BXR0o4Ym9XQlFLdGpI?=
 =?utf-8?Q?MG8F8MSRwOkZlQZOACw8YT9C1xWdrbdNf//VU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHd2eFJwRXcwQU0yaytRWW5DV2pPbkZiVldhTE5kaXZLNk1oc0hPUDFYQ1Ni?=
 =?utf-8?B?ZFJHTzVLWFQwTHIzQ3hmb09uUFdjeDBtc3p6Ry92ODVFaHFkT2pIR21rTzVq?=
 =?utf-8?B?ZEFFNHFHbTFRdENjVzl0Y2tUOEw4YWwrYU9yYlZCVUxtemZ0T29pcTlIMzcv?=
 =?utf-8?B?L1RzaFUwMEhSS1ZOakIwTjJwN0F1dVlZSVJSUmhKOVhMUGQxMmtMMmhzeC9z?=
 =?utf-8?B?RlBYMWczdGNSdXUrbHdmMTVEMzNFd3FVQUNFNjJXVk5DUzEwQVZJYlM0OXNM?=
 =?utf-8?B?dCtQTENsVzdVQXAzQ3ZvSk9PNmdvSU03Vkx5WExMekJIanBOaVZCT2ora2xv?=
 =?utf-8?B?WWpBRUhsaTVWeHFCZS96TTA5MGxpcnlFeXRPaFRkOGVud25ONm5ZV1I2RDlj?=
 =?utf-8?B?RlRTOHJncHNtRHdHNE9KdVM0YTVLMlJQc3g3cm81RytnK3BXUDJzbHY0Wm5G?=
 =?utf-8?B?MW01UnZXb2x0azFXSkN0Z2JKY29HYURXME01d01RZ0I0VEE5U3VyUEJuYnFC?=
 =?utf-8?B?RlJxZDhCdVpoaHVNeEZGZ08zQ2dUNWxldlJlVmkyamt5UkU5N2V2Z2NiQW1x?=
 =?utf-8?B?N1ZPYk0xTzJOdVc1OGd0RzZ2NVdMRFZ5SWpJc0V6OEl5VkMvakxGWHNtaTlx?=
 =?utf-8?B?L3hEVWVZM2FSMzY2K1FUMmhiUHN4dm5CL3hsdVFFOGZmSXdTaFdwbTA2eDZV?=
 =?utf-8?B?eVFwNkNlQmJGMzBNaVg4bVR1RDZwK2RnU3BRaHVsVHN3N2tkb3FrNEl2Zkpx?=
 =?utf-8?B?cElqNUp3QXNNV3NOckV2SHo5WHFXTGV1UWJtRlJOMG45T3FDaTBmRVpab1VJ?=
 =?utf-8?B?dUYwbURxL0Z4NzVhTzg0THBzQTZMWlhOR2RvOStTNnRpR3MzK042NDI3Vmp5?=
 =?utf-8?B?NmhDcmFyTmNrQmZ6cjdpbHp0RmdFYjJlaWEvV3gwK3RUVWhIa2ZOTERCaXNZ?=
 =?utf-8?B?Z0ZLcGJPbDFMcUJBRHI1bW5uOW9menNRbnUzWHp1b2tyeXNKeEp4OHQwdGpG?=
 =?utf-8?B?bmpKVmpWeHhKekVKM0s4NzJSS200NUhWbzlVdk1DcXowVVFmc2xDVzRSRGU1?=
 =?utf-8?B?bnRNS2d5U2E4TTNnb0xPclVXVGFPZURNWVp6OHVQbFNkRHZIQUU1Nm8zTE5j?=
 =?utf-8?B?VmM2UW9Ibi9tZXMzWkF5b00yazlVM1IwanhKT2pyUk9Hc1ZLVHV1RkVMN2sy?=
 =?utf-8?B?SW84VTVTNkFBOXl3TDhuaU1IMXcrcllDU0tDb0JsUDhWUlc4bk03UDZKR1Ay?=
 =?utf-8?B?SDNrdGdMcU9oLzVubm45VmdDRVVnUE81NERRS1dzaFBKOGhvanNRakpTK0xp?=
 =?utf-8?B?KzVCWkhMNTRGcTZDWGxnVWo5cGRFM2tzU2NHc1ZlTkVGNGV6dDJzOE5OZ3A4?=
 =?utf-8?B?Z2VoZXFLdzRWYUVqT21MNzFVdHdQVENsMm9qY0N1QlNCNzJtU2JoK29ZZFpL?=
 =?utf-8?B?L1NEdUxUOWg0Z08wVFlBQlpxQmEzdTdpSnhWWjNJczhUaDNlWXBzTEE4RUE0?=
 =?utf-8?B?WUlpcWwyT0V0R25ScmhnYXRnaVhpUEpHdFhCV3A1ejBLNEc3TCtOcThVbi9Z?=
 =?utf-8?B?VmZTYXlWUjZwakdRbnJxR0ZQOUErMElNYmRRS2ROSnNHaXhUM3VZbTVWUkFC?=
 =?utf-8?B?aS85NWpvdUpCZndZWHFhYXMxM0tqVEx6aVU4MFk3M0t1MU5lQ3JMTW9RcjZZ?=
 =?utf-8?B?OEhHL3RpYjlSM291c0lRb0dIQTdsWWJGbFEveWFDWlZpWEkxWmFGaXBIRGVZ?=
 =?utf-8?B?MTUrTndxcnB3QzlZYmJjejVha1F5ODMyR0lCWHZCZmQxajRMQ3ZETm43QlhC?=
 =?utf-8?B?MGxXN2EyQklJSW04S2I1Q2p5b2JtVlR5alo5bzMvUU1HQURUSkhMSVpFdHhU?=
 =?utf-8?B?U2hBamxNM3ovTFMwUFRNdzVXMm5lWDk2U1g1REJyRytrQzhXSmRCL0VsOEVp?=
 =?utf-8?B?WkFyYnlycHpIeUJyS0p4L0pjbWpXZVNSMWZ0Uzh0elB4UmFzTXVRUUU0eTN1?=
 =?utf-8?B?OFZCcFFHdnVsMWswSXE2dWVoNFNYVGVXZlBSaXdQZm5tK0NyMmhpUVQremZn?=
 =?utf-8?B?WjMyM0YzRUl4RGJmaW1RamhsYWhBTFRMYTFyb1o3RWF3bUdXNVVRaXdsK0c3?=
 =?utf-8?Q?d8jY=3D?=
Content-Type: multipart/mixed;
	boundary="_003_IA1PR12MB9063C51DD1792ABB26EFAF15E58E2IA1PR12MB9063namp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fdf996-c3f6-48fd-7326-08dcc21a78bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 19:50:13.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySM6WS6SOWzORESI5Wwo/6Ei01FjXSkIUJITEEI70bHYZ7rYBIJ/bAID3lmMNvft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937

--_003_IA1PR12MB9063C51DD1792ABB26EFAF15E58E2IA1PR12MB9063namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KSGkgSmlyaToNCg0KICAgICBQbGVhc2UgYXBwbHkgYWJvdmUgdHdvIHBhdGNo
ZXMgb24gdG9wIG9mIGxhdGVzdCBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvYWdkNWYv
bGludXgvLS9jb21taXRzL2FtZC1zdGFnaW5nLWRybS1uZXh0LCBhbmQgZ2l2ZSBhIHNhbml0eSB0
ZXN0IG9uIDRrNjAgb3ZlciBMZW5vdm8gSERNSSBvdXRwdXQuDQoNCiAgICAgVGhlIHBhdGNoIHBv
c3RlZCBpbiB0aGUgZ2l0bGFiIGZvcnVtIGhhcyBiZWVuIGJyb2tlbiBkb3duIHRvIGJlbG93IHRo
cmVlIHBhdGNoZXM6DQoNCiAgICAgIjAwMDEtZHJtLWFtZC1kaXNwbGF5LUZpeC1NU1QtQlctY2Fs
Y3VsYXRpb24tUmVncmVzc2lvbi5wYXRjaCIgYWxyZWFkeSBtZXJnZWQgdG8gYW1kLXN0YWdpbmct
ZHJtLW5leHQuDQogICAgICIwMDAyLWRybS1hbWQtZGlzcGxheS1GaXgtYS1taXN0YWtlLWluLXJl
dmVydC1jb21taXQucGF0Y2giIHdpbGwgYmUgbWVyZ2VkIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0
IGFmdGVyIHlvdXIgdmFsaWRhdGlvbi4NCiAgICAgICIwMDAzLWRybS1hbWQtZGlzcGxheS1GaXgt
U3luYXB0aWNzLUNhc2NhZGVkLURTQy1EZXRlcm1pbmEucGF0Y2giIG1lcmdlZCB0byBhbWQtc3Rh
Z2luZy1kcm0tbmV4dCB0aGlzIHdlZWsuDQoNClJlZ2FyZHMsDQpKZXJyeQ0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwu
b3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMjQgMTI6NDkgQU0NCj4gVG86IExp
LCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgU3Vu
IHBlbmcgKExlbykNCj4gPFN1bnBlbmcuTGlAYW1kLmNvbT47IFNpcXVlaXJhLCBSb2RyaWdvIDxS
b2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Ow0KPiBQaWxsYWksIEF1cmFiaW5kbyA8QXVyYWJpbmRv
LlBpbGxhaUBhbWQuY29tPjsgTGluLCBXYXluZQ0KPiA8V2F5bmUuTGluQGFtZC5jb20+OyBHdXRp
ZXJyZXosIEFndXN0aW4gPEFndXN0aW4uR3V0aWVycmV6QGFtZC5jb20+Ow0KPiBDaHVuZywgQ2hp
YUhzdWFuIChUb20pIDxDaGlhSHN1YW4uQ2h1bmdAYW1kLmNvbT47IFp1bywgSmVycnkNCj4gPEpl
cnJ5Llp1b0BhbWQuY29tPjsgTW9oYW1lZCwgWmFlZW0gPFphZWVtLk1vaGFtZWRAYW1kLmNvbT47
DQo+IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxMi8xM10gZHJtL2FtZC9kaXNwbGF5
OiBGaXggYSB0eXBvIGluIHJldmVydCBjb21taXQNCj4NCj4gT24gMTkuIDA4LiAyNCwgMTY6Mjks
IExpLCBSb21hbiB3cm90ZToNCj4gPiBUaGFuayB5b3UsIEppcmksIGZvciB5b3VyIGZlZWRiYWNr
Lg0KPiA+IEkndmUgZHJvcHBlZCB0aGlzIHBhdGNoIGZyb20gREMgdi4zLjIuMjk3Lg0KPiA+IFdl
IHdpbGwgIGZvbGxvdy11cCBvbiB0aGlzIHNlcGFyYXRlbHkgYW5kIG1lcmdlIGl0IGFmdGVyIHlv
dSBkbyBjb25maXJtIHRoZQ0KPiBpc3N1ZSB5b3UgcmVwb3J0ZWQgaXMgZml4ZWQuDQo+DQo+IFRo
ZSBwYXRjaCBpcyBhbGwgZmluZSBhbmQgdmVyeSB3ZWxjb21lIHRvIGJlIHVwc3RyZWFtIGFzIHNv
b24gYXMgcG9zc2libGUuDQo+IFdpdGggdGhpcyBwYXRjaCwgaXQgd29ya3MgYXMgZXhwZWN0ZWQu
DQo+DQo+IEJ1dCB0aGUgcHJvY2VzcyBpcyBicm9rZW4uIFlvdXIgYW5kIEZhbmd6aGkgWnVvJ3Mg
c2VuZC1lbWFpbCBzZXR1cCB0byB0aGUNCj4gbGVhc3QuDQo+DQo+DQo+IEJUVyB5b3Ugd3JpdGUg
aW4gdGhlIGNvbW1pdCBsb2c6DQo+IEZpeGVzOiA0YjY1NjRjYjEyMGMgKCJkcm0vYW1kL2Rpc3Bs
YXk6IEZpeCBNU1QgQlcgY2FsY3VsYXRpb24NCj4gUmVncmVzc2lvbiIpDQo+DQo+IEJ1dDoNCj4g
JCBnaXQgc2hvdyA0YjY1NjRjYjEyMGMNCj4gZmF0YWw6IGFtYmlndW91cyBhcmd1bWVudCAnNGI2
NTY0Y2IxMjBjJzogdW5rbm93biByZXZpc2lvbiBvciBwYXRoIG5vdA0KPiBpbiB0aGUgd29ya2lu
ZyB0cmVlLg0KPg0KPg0KPiBJbnN0ZWFkLCBpdCBpczoNCj4gY29tbWl0IDMzODU2N2QxNzYyNzA2
NGRiYTYzY2YwNjM0NTk2MDVlNzgyZjcxZDINCj4gQXV0aG9yOiBGYW5nemhpIFp1byA8SmVycnku
WnVvQGFtZC5jb20+DQo+IERhdGU6ICAgTW9uIEp1bCAyOSAxMDoyMzowMyAyMDI0IC0wNDAwDQo+
DQo+ICAgICAgZHJtL2FtZC9kaXNwbGF5OiBGaXggTVNUIEJXIGNhbGN1bGF0aW9uIFJlZ3Jlc3Np
b24NCj4NCj4NCj4gU28gYXBwYXJlbnRseSwgc29tZW9uZSBpbiB0aGUgcHJvY2VzcyByZWJhc2Vz
IHRoZSB0cmVlIG9yIHNvbWV0aGluZy4NCj4gV2hpY2ggaXMgYW5vdGhlciBicmVha2FnZSAobm9u
LXJlbGlhYmxlIFNIQXMpLg0KPg0KPiB0aGFua3MsDQo+IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0K
DQo=

--_003_IA1PR12MB9063C51DD1792ABB26EFAF15E58E2IA1PR12MB9063namp_
Content-Type: application/octet-stream;
	name="0002-drm-amd-display-Fix-a-mistake-in-revert-commit.patch"
Content-Description: 0002-drm-amd-display-Fix-a-mistake-in-revert-commit.patch
Content-Disposition: attachment;
	filename="0002-drm-amd-display-Fix-a-mistake-in-revert-commit.patch";
	size=1443; creation-date="Wed, 21 Aug 2024 19:40:57 GMT";
	modification-date="Wed, 21 Aug 2024 19:50:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMDQ3MWY1NmRhMTc5NDRjOTkyNDA4N2Q5M2RiZWU3NjRhODIyNDg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYW5nemhpIFp1byA8SmVycnkuWnVvQGFtZC5jb20+CkRhdGU6
IE1vbiwgMTkgQXVnIDIwMjQgMTM6NDM6MDAgLTA0MDAKU3ViamVjdDogW1BBVENIIDEvMl0gZHJt
L2FtZC9kaXNwbGF5OiBGaXggYSBtaXN0YWtlIGluIHJldmVydCBjb21taXQKClt3aHldCkl0IGlz
IHRvIGZpeCBpbiB0cnlfZGlzYWJsZV9kc2MoKSBkdWUgdG8gbWlzcmV2ZXJ0IHBhdGNoIG9mCiJk
cm0vYW1kL2Rpc3BsYXk6IEZpeCBNU1QgQlcgY2FsY3VsYXRpb24gUmVncmVzc2lvbiIKCltIb3dd
CkZpeCByZXN0b3JpbmcgbWluaW11bSBjb21wcmVzc2lvbiBidyBieSAnbWF4X2ticHMnLCBpbnN0
ZWFkIG9mCm5hdGl2ZSBidyAnc3RyZWFtX2ticHMnCgpTaWduZWQtb2ZmLWJ5OiBGYW5nemhpIFp1
byA8SmVycnkuWnVvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCmluZGV4IDk1
OGZhZDBkNTMwNy4uNWUwOGNhNzAwYzNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYwpAQCAtMTA2
Niw3ICsxMDY2LDcgQEAgc3RhdGljIGludCB0cnlfZGlzYWJsZV9kc2Moc3RydWN0IGRybV9hdG9t
aWNfc3RhdGUgKnN0YXRlLAogCQkJdmFyc1tuZXh0X2luZGV4XS5kc2NfZW5hYmxlZCA9IGZhbHNl
OwogCQkJdmFyc1tuZXh0X2luZGV4XS5icHBfeDE2ID0gMDsKIAkJfSBlbHNlIHsKLQkJCXZhcnNb
bmV4dF9pbmRleF0ucGJuID0ga2Jwc190b19wZWFrX3BibihwYXJhbXNbbmV4dF9pbmRleF0uYndf
cmFuZ2Uuc3RyZWFtX2ticHMsIGZlY19vdmVyaGVhZF9tdWx0aXBsaWVyX3gxMDAwKTsKKwkJCXZh
cnNbbmV4dF9pbmRleF0ucGJuID0ga2Jwc190b19wZWFrX3BibihwYXJhbXNbbmV4dF9pbmRleF0u
YndfcmFuZ2UubWF4X2ticHMsIGZlY19vdmVyaGVhZF9tdWx0aXBsaWVyX3gxMDAwKTsKIAkJCXJl
dCA9IGRybV9kcF9hdG9taWNfZmluZF90aW1lX3Nsb3RzKHN0YXRlLAogCQkJCQkJCSAgICBwYXJh
bXNbbmV4dF9pbmRleF0ucG9ydC0+bWdyLAogCQkJCQkJCSAgICBwYXJhbXNbbmV4dF9pbmRleF0u
cG9ydCwKLS0gCjIuMzQuMQoK

--_003_IA1PR12MB9063C51DD1792ABB26EFAF15E58E2IA1PR12MB9063namp_
Content-Type: application/octet-stream;
	name="0003-drm-amd-display-Fix-Synaptics-Cascaded-DSC-Determina.patch"
Content-Description:
 0003-drm-amd-display-Fix-Synaptics-Cascaded-DSC-Determina.patch
Content-Disposition: attachment;
	filename="0003-drm-amd-display-Fix-Synaptics-Cascaded-DSC-Determina.patch";
	size=1242; creation-date="Wed, 21 Aug 2024 19:40:57 GMT";
	modification-date="Wed, 21 Aug 2024 19:50:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NjJlOTgxZDlkMmQ5ZDU1NzA2NjQ4Yjg2ZWNhNzc2MWUwNDgxODkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYW5nemhpIFp1byA8SmVycnkuWnVvQGFtZC5jb20+CkRhdGU6
IE1vbiwgMTkgQXVnIDIwMjQgMTM6NTA6NDQgLTA0MDAKU3ViamVjdDogW1BBVENIIDIvMl0gZHJt
L2FtZC9kaXNwbGF5OiBGaXggU3luYXB0aWNzIENhc2NhZGVkIERTQyBEZXRlcm1pbmF0aW9uCgpT
eW5hcHRpY3MgQ2FzY2FkZWQgUGFuYW1lcmEgdG9wb2xvZ3kgbmVlZHMgdG8gdW5jb25kaXRpb25h
bGx5CmFjcXVpcmUgcm9vdCBhdXggZm9yIGRzYyBkZWNvZGluZy4KClNpZ25lZC1vZmYtYnk6IEZh
bmd6aGkgWnVvIDxKZXJyeS5adW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMK
aW5kZXggNWUwOGNhNzAwYzNmLi5iNzdlY2YzZmI2MGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5j
CkBAIC0yNTIsNyArMjUyLDcgQEAgc3RhdGljIGJvb2wgdmFsaWRhdGVfZHNjX2NhcHNfb25fY29u
bmVjdG9yKHN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG8KIAkJYWNvbm5lY3Rv
ci0+ZHNjX2F1eCA9ICZhY29ubmVjdG9yLT5tc3Rfcm9vdC0+ZG1fZHBfYXV4LmF1eDsKIAogCS8q
IHN5bmFwdGljcyBjYXNjYWRlZCBNU1QgaHViIGNhc2UgKi8KLQlpZiAoIWFjb25uZWN0b3ItPmRz
Y19hdXggJiYgaXNfc3luYXB0aWNzX2Nhc2NhZGVkX3BhbmFtZXJhKGFjb25uZWN0b3ItPmRjX2xp
bmssIHBvcnQpKQorCWlmIChpc19zeW5hcHRpY3NfY2FzY2FkZWRfcGFuYW1lcmEoYWNvbm5lY3Rv
ci0+ZGNfbGluaywgcG9ydCkpCiAJCWFjb25uZWN0b3ItPmRzY19hdXggPSBwb3J0LT5tZ3ItPmF1
eDsKIAogCWlmICghYWNvbm5lY3Rvci0+ZHNjX2F1eCkKLS0gCjIuMzQuMQoK

--_003_IA1PR12MB9063C51DD1792ABB26EFAF15E58E2IA1PR12MB9063namp_--

