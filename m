Return-Path: <stable+bounces-227927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMutE/EHwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:29:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8E2EF128
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38E38300334B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8F370D48;
	Mon, 23 Mar 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ir87Tici"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85018383C75;
	Mon, 23 Mar 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258158; cv=fail; b=S9ehR7kAW1aK3iAxv8nC9r9AHy1lJcuMNuK2TcmQet25eP+SbUg3jPF9wJJNRigLM/p1ZFKXzDsmEL2B7j8yYqm1B6CVad7jhuy4VYr1TTAD5J2v2lcenuE5A9R+c3/G7upZAc17TLzbiruPvVhYe+6Kn6SYZJE8DW8Jy1gJKwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258158; c=relaxed/simple;
	bh=RQkd3vwAMYZExKDDZ9alff+X0uht1Ix6BgaBDQ8mgas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kIWSsvbfAqCw6cQEZufI+xsGuiAthT4/P5RW4W+XVrAbNwqU1WnYap+HgdwsdYoayDgCbByW1vXuLqO4gdXrMqX1xSfbnL1KTUTu58h7KMQuVuwtwQhCKCKTR3L1VIVCF1rE5rpw7zbZVRmVIMpS3yS4qgT2obCTHIFs4ELyvEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ir87Tici; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoNULSdg7fFgxeHYq/AnCuJXnWfh/ESJ12/DrV2elxib8gwp3rceVwqXbr/VlIBc8kO9v0DYAZD3MB3vKUJ/J55knsJhADcXkZ8U6LwfqdeOqDnX0nVfqM1cP7cnUiwPq/a88p9ANhRR8nOu09IdNeNNCi55qRpEvK6RDHk+zksXoP3+XgtHejmnTUL60HNs26yeJqlLbjeUIlzWL1KFoTse1E7Xxisq3ZEDdO07EPK/ZTM4E1BV5mQtDR41OwJNADMxv/aqKK02RlI9m0nU2r+3z8b8b+UkH1KDRnoYRfKR8ZwFNRpKMzQIrP230NrH7u6OfPz5gzE2FaIHW8OKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JaQLPEtiDHMQzBiZWbnYPKDI51B5s+DioSDUoEWXLc=;
 b=b+fPS+RUifSL1MnMLUgDa2qwHkF1a1OHj/M440c18FN+RFPrP5eqAnKDRy1LCx1zmNiqbytTGwzTbpP+tfbBHVyYD9fNZeyZN6s2mfoNsbirtaZ7iFjOsx02Yox1TFMISMucf2I1WY/vT5Pks0EKWt+0fxVHdRpg4ORV2/8E4lVwrlKKP8a1gC81u33HCkw/cisueTJfp4kMn5Tan3HrfXD/+hkGSEt8s3z0zFETMNoug+9TwqJ4QXyH8Uc8QZBhZC3bfduLsiPuLh05HPHGlNmTTUUhNPKTB/29AnicuGDyGCez4fnyX2K9CbRVa2z4uHU66lkagXP2XnHit0DCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JaQLPEtiDHMQzBiZWbnYPKDI51B5s+DioSDUoEWXLc=;
 b=Ir87Ticih/XZaKDIi2P07ejJNIPKGBoOrFamuvdeacQNG+OAiGh+wEBOguyV4jT+ZR9fl5lHmiLLwyY59PXlTTEX69mXfxc5NJBLIovayY3y1QIbct/om09c53lIskYglTVES2wdVGA5NwqPQs4aoWvQq2lfgQsGQE82Bg9H+Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPFD78AA37BB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 23 Mar
 2026 09:29:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:29:12 +0000
Message-ID: <0c0fcc34-a3b5-4c9a-9095-854eb6475abc@amd.com>
Date: Mon, 23 Mar 2026 10:29:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 for 6.1 0/4] amdgpu: fix panic on old GPUs
To: Rosen Penev <rosenp@gmail.com>, stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Sasha Levin <sashal@kernel.org>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Zhigang Luo <Zhigang.Luo@amd.com>, Bert Karwatzki <spasswolf@web.de>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Roman Li <Roman.Li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>, decce6 <decce6@proton.me>,
 Wentao Liang <vulab@iscas.ac.cn>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260321054453.19683-1-rosenp@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260321054453.19683-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPFD78AA37BB:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4583c5-5137-4def-ff17-08de88bea4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ejct2COMi6WGMkfE+rY0fvWs+kLHSEQ2MrvEUOoxD8vPZ9inRX6NjP1xowzA/zUBbxXMkh9fT113ows0qzB7+NSYTy0Zx13klHvv2K/KUMi0oXj7WgdXCi1QHVjX7JSDkL3GpjCmptsteVpysk9PHxCk7WH5hdTCdy5u8CkqNFA1xXmEVjPLlw8c6xoIeKikMhHhskAdAssuGdh12KR/MPfPl/NH3sipa9FoYqyaq0Qa1G+k5w/MJejQSdEFF3hXwWspffHy9bhej3pjuPnmwlNLQkUVhTTQcc5SYVAkQTbZPob0XJgs6nAD6ikqZve4ZF6T5jHeaDHXLfgAsRZttk1ETuDgkQ5FfbpMBKa1t6LGyO/UmeCCQfqP1m+Mfd4HdZqdhXznrMbbbRP/y2b+uwjCuJ1OQfVQFXIG732s5rauGmyIwTc8Ruw1cOhROcD5ZPYurEW31ByY32AC/rfjIdda9Jyrdbm7rW2qN6cbgnE60nrvbt9WM3yTaa1j5aYvxjeVklymPFOvXV4FHU1rTccGxO4UsebmdlOWtSZufKTBtW2vYYZrFrvBlsz/hWunhjCXPSf+t7NkIXg9eZuXxywWpQ+y9tCUgr+cBtQfNlcYW8kI8s7nDYrrYGIcY2eRoJnp4o1ppMC2SLxkPKD3twOG+OQZeXc6JvUa8YS5iFoaxW7xniJTvxR52Aaa/wmK5DsyUIU0PmcspoqeCVfDHU+nlhnsQHHzNumrMskaCAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1Nwck1tWnRoSUZ1L1J0L2o4c1NMaUN3QURMUDRxZkk4eW4xejlxNG1SN1Y0?=
 =?utf-8?B?aHJTMlBybWtKS1l1K1MraUJ0dkhTWW51a1M3YTFaeXkwR21HZmt0WGZEOEpV?=
 =?utf-8?B?M1RwVnBoZWRneFZtSzBpQk9KOGxGeXlPOFRlcDM1amJhODN1aHlyOWFqc1NU?=
 =?utf-8?B?VGNacVZ4SWJzUllIVW1hYjJWcUE3REVhSlgybjQvVWxzL0tKUnc4WW9NeUVs?=
 =?utf-8?B?YVZvdVk2UmlqZ0QyQXc5MVpDSDQ1RDMwQXcvRzRSTk9aYnVnK0VSOWhNenpN?=
 =?utf-8?B?WDRzcklmUDY1cDdLNFprcVVhdjkrdDRqaTA4T0twcTJvZi9uYWRiMXFtU01m?=
 =?utf-8?B?eXYydHVpb1ZDR29hNnpJb0s4cm14L0FNTkJKeDd5R0w5Qy9HUEIvYW5WRCtk?=
 =?utf-8?B?SVg2Sk1oQncyMUpWVk9nWGZWQVhmaEZaN2VtbFh3WGNXT1MyTkhqT3pWaW1K?=
 =?utf-8?B?K05INWpRenI5NUpUMWp5RC9zbGJBTldUUFYwTndPZ01CU1lVM1pNODl1Q25Z?=
 =?utf-8?B?S0E1L3plUit4cmZYMTRvU0pFN09LWE9tSmJDeTgxbjk1bTM4NWpsRFd2blFm?=
 =?utf-8?B?NDI2ckYrTTBLbGpaOEdBVWVtQUwzZ0JwbG9SNGg5OFFYVmpLWUFFaXJHNGFN?=
 =?utf-8?B?dVhCS0ZwcVViZUY4aG5iQzhKczlvbElmV0pOS0JmSnVLYUVZQ3d3Zkl0RXJJ?=
 =?utf-8?B?S241QThxelJrUFUzMVVQSjk4SEU0N3U5WXl5MERIWDdEL2E3ZEZRazFwSENJ?=
 =?utf-8?B?ZFZrWlg4WTRUOFR2ZU1sdlV4M0xRM2lnS1U1RWx0MUl5TVZaenBleGVKZDl2?=
 =?utf-8?B?cUYxeXZ3dU5XMmV5ZjhNMFMwVGx3NEFYWEJONWJQa3BIS084TEViV2RPMUFu?=
 =?utf-8?B?c3FlT2FqdWtiT0lnMXR6VjI5enRrNUptbWc0K0VkeDZtd2xWNW9wMWd5OHJo?=
 =?utf-8?B?eDlWMm9qakxsQTJQZmQwZUhwQ1I1K3krQ0pzbHJFekJ4SXZKZzB3Qlh4NWlZ?=
 =?utf-8?B?R1c0SnRCUmUzeDIvQ3VMY0xMdENmTkMyeU14bnJCdjd4NzZvVU00MExNVGtt?=
 =?utf-8?B?Z2l5eWIvMy9oczF2bXpYSUhBSjE3bGJ0Z3VnNHdDTzFDUXJSWGZYczUyMHE3?=
 =?utf-8?B?SWh0Vy9sSXFDbUFLMlBYN2xram9ya0phUExHNFFSV21kZEVVZG81N3NxQ0hM?=
 =?utf-8?B?V2k2TklBZm0xbzF3RU1YekpsT2ZyWkwrQXhlYkNPYkpzM2JsVEZ0cTU3Mis0?=
 =?utf-8?B?VVRlT3hUaVVQQzhjUWFwZkdiS1ZWZ1hXZk1KclRwTVdmb3laMHMzY3V3dXJt?=
 =?utf-8?B?eWVVUkxMNTd4Mk1PQ1RrcE45NWxKRVlqcVZNbEhLWUtNNVdCNWdCUU1ERm96?=
 =?utf-8?B?T1BUMW1vUk5ibGpzMmVzcGM1L0FtYUFZVFFROTJqNFRhK0pqQWZrQW85K2Ni?=
 =?utf-8?B?Y09RcVJKZ3BxNWExeXdpRklZSlM5RzlRZTVQY09KY3NlZS9VL0sxeFVsRDU3?=
 =?utf-8?B?VkZNQlNJNXhpUDBycVkvYzRlV3NuekRYeEVYbDkrb01GN0RFYThaU0VwOVZW?=
 =?utf-8?B?S2VMUktmZENWd0hvcmN5Qk1keHd6UTQraDdHSWZOTlZ0QkQyUlRUM1pTNWEr?=
 =?utf-8?B?V1djeW5wVUtuRkhLS3htbnB0UXgvaHBPMklGVGVIS3RMeXJ4aUg1Q0ZWVmVM?=
 =?utf-8?B?dFZ1TmxVOWQ1c1VHamorMzlWWlhDNFpaMThTUzhkQU1oRlFzMUM0MkpRVkpS?=
 =?utf-8?B?bW1Kc2tPUEVsR0dXdVJObWc2THJHSmQ0b3ZxS1ExeDlxWStIUG5FcHVRN3Ny?=
 =?utf-8?B?dHJJcllaYzdCdmN1cERkZXJDb2dwN05NSzdScUlHSzBwQ2V6ZmowLzF1SklZ?=
 =?utf-8?B?WU5KZ0JvTVI2TEVOSkIyZlRMM1F3TjhQYmFzcGVZbE04MnRsWXo0bTJCSnk0?=
 =?utf-8?B?L1VTNVFyWXBiaktGUHZ3Y0pQb0tRdmRCRnBGWk50YUxucmNHRjM1bThYRWpl?=
 =?utf-8?B?ckE1dy8yYjBtbmRLMmdsR3JFdEpubExFM21NTGovT2liQ1Y5T0dvWmdlUnlN?=
 =?utf-8?B?bVAwSTAxV01DRlpZcG1NcmN4RUxJYkFQMGlpRFhrOWVNamdQcmlSZWJONGhG?=
 =?utf-8?B?S2RUOVlaTVg3UjdET1AwUkl1UE5TZEtZKzF1K1hwbTlrc05kTERrcDZFamJJ?=
 =?utf-8?B?akREK3VIZllCdUlYQzV5ckwxSUVJMVpoZ0ovWXZkVFBOM2k1VTFlcEo3ajFD?=
 =?utf-8?B?bXk5VlZId3hFcFVvVTdRbGNGMElidVAwSHVxcitFaWhtRnQzTUEzR0xuSFE0?=
 =?utf-8?Q?J8nDMWDTkVwTF86AXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4583c5-5137-4def-ff17-08de88bea4b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:29:12.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO5thiae3HV7fx1AVovFO9/8r77Z8O1t89cHMLZq5BA+Uv/Bb9YUmGQi0kz8yom4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD78AA37BB
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227927-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,kernel.org,linuxfoundation.org,web.de,proton.me,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1F8E2EF128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 06:44, Rosen Penev wrote:
> Because of incomplete backports to stable kernels, DC ended up breaking
> on older GCN 1 GPUs. This patchset adds the missing upstream commits to
> at least fix the panic/black screen on boot.
> 
> They are applicable to 6.12, 6.6, and 6.1 as those are the currently
> supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
> backported to.
> 
> 6.1 needs two extra backports for these two commits to be cherry-picked
> cleanly. Those are
> 
> 96ce96f8773da4814622fd97e5226915a2c30706
> d09ef243035b75a6d403ebfeb7e87fa20d7e25c6

Acked-by: Christian König <christian.koenig@amd.com> for backporting this series and those two additional patches.

Regards,
Christian.

> 
> v3: Add those commits to this series and sign them off.
> v2: Add Signed-off-by.
> 
> Alex Deucher (2):
>   drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
>   drm/amdgpu: clarify DC checks
> 
> Timur Kristóf (2):
>   drm/amd/display: Add pixel_clock to amd_pp_display_configuration
>   drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
>  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
>  .../drm/amd/display/dc/dm_services_types.h    |  2 +-
>  drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
>  .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 13 +---
>  17 files changed, 126 insertions(+), 81 deletions(-)
> 
> --
> 2.53.0
> 


