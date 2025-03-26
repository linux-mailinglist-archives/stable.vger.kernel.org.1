Return-Path: <stable+bounces-126671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6031A70FC2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5F188EF6C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 04:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE621531F0;
	Wed, 26 Mar 2025 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qh4HzT9J"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407941A8F;
	Wed, 26 Mar 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961676; cv=fail; b=Pr9O15QSZ/VeN+g+fYhGuLk+ISaTo5BgrETIbG2kieAcEtWf+6rQJJruPAqkv1HAzm/Z/2sRPt2tuzTCqx4NRiL99wyyx3soz15+ft1IDE33JRrGyUOXKlMzVIcs0htozhEhhAjclO1ZiiyJIOAr5EWP9WkY3cLnksnYVC5mzDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961676; c=relaxed/simple;
	bh=TbMlMWmFthvEEA8SLNLOtTiJM4QT2LYWWB9kRZDRWcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/1ougnlEGhZtI//ywowIOavytwwTqFk+Q484crbaMM8jMHGZTm1fUJKz8rnf66CNqL07bCQ2vUk052uweoRQDtzWF1RHsRO8Q9l6xA2Jos0a0RSQ3NqTuSxiyZmAMG5Qu8Ilpgis6d7H3rGvj0UkSHeY3lhi346qYCUlq8LCMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qh4HzT9J; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnlaQwiqdFbJfPFmf6ZxoyyP8hE7VIHETWw9rBddR9tltUV1KQ2jGx53in2mhu8S+CFH6o9Ybv6pE+2+iD+HJ7ERkw16it8iTvJopVPcnMMPfRUs0BBZs40EtGgcyyJx41LrIhCMKaiLtKyVN6+NQt1RL8MJ70A1V/AlmDIQ25gx0lgG3NR8X4HLDiLFKM3t49wck/qZTgvKMR1MzIaQuB5oUutTE1csRb2kvrU4Y01je6KdYS2FdiQ4kjsvrTYCCe8HscaFyx2HI3ah/8iJLGoXpKyR5sgJICzWM9ZkzzIpMNzLiCsO+ev3yfLq5mhoCbHF40rGkHSbM8Bc0MbmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ2kssAw7P3zTqqznct3geqvDcjsZ7rQxsHXnB/t1DU=;
 b=jp0Aqupu1hSw3f6M+uaI/LPge12qdARKm3HTbCs+4USP3iuygSTAaL3Gwsl5B7WFJku522y1MGgu1lkyEHSoBiX7isYW6aHZuOZei+pbXv8OfMOwLY00U14HM7Opoj+BNznHkBCFVEUaH53XWvLMlIIlQbwaOaGR3izNaHMY1ToIw5fuZ+kXPeatZ0S4wBHv1PHm30KMXU3p0ykrqpzZR7+e074c1ztyhxwkXs+dAKQvDbbf3rDat/h56k6w4/8SspJDwxL3az2h1JHcNGbQcYCYhwPyB3FYy0PNY9GJkSmUl7/ZAs9ESD+yWmTnSJLS56OiYDnbcBJaNnPseJsRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ2kssAw7P3zTqqznct3geqvDcjsZ7rQxsHXnB/t1DU=;
 b=Qh4HzT9J5iPObFRTmjLO2ca48ZZBksUwn6IpmjeIopmGeruCLL5w7Arw+np4X2HO5WTlIGRM+vjLMVUJ2BMxtcP72d/B8/sSzO/tx5cUEov3IVR+e1/r/yBI4vUPPgdby8Q+3ehj89VDHERBGVZVMnxLVaRNeG5OSwXfWggh3K4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 04:01:11 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 04:01:10 +0000
Message-ID: <81c922e6-8848-47a2-bd54-1a9f8b1dbdc0@amd.com>
Date: Wed, 26 Mar 2025 09:31:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
To: Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
References: <20250127120631.799287-1-Raju.Rangoju@amd.com>
 <1c44ff09-dd26-489d-9867-8d300a3574ac@linux.intel.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <1c44ff09-dd26-489d-9867-8d300a3574ac@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2c5589-2fe1-441b-bae0-08dd6c1ad803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SktEdGhjZXU0SHZIemliTVFlS1FBZGkvVnVPYXJhVDRoRVhCZit3VmVnaW9F?=
 =?utf-8?B?eGRTQktNN3B6bmtuTDlYY0hVbnNvYkpCdGtIOUNwNVNWWTBGeFcrYlYvbGVt?=
 =?utf-8?B?K2VyWDZHMlFqY1RzMjFSRHoyNEgxRVJkeWpxV3Z4NjNtaG9QTFZBb09xM1Q3?=
 =?utf-8?B?cDl5NzFOSFlqU1gxdU1oYXFkT2IyTjc4WDEyVEIrZnNZb1laRThBUzNnVEdB?=
 =?utf-8?B?TWdySmdPMXpIZUxwRi9maHNmYTEweHRkb2kvZ3VOenV0VnkxWktabFNVdEhJ?=
 =?utf-8?B?eFIwTGZRZmMzdjdUTjBZeXRvVWxpcHIvcjZGWncrNUxLTE5DUlo4WlhSdTRX?=
 =?utf-8?B?anp4elRzTXU5ZFpkOUNKWVBCZi84VktQYS9yVzJBSS9CdkNoaStIbU80ZjU4?=
 =?utf-8?B?VWo3ejRaQjMrV2JWYmNuUkNDS1JZU1V5MXZoMU5rbUx1UzBSUkROenIwTU1N?=
 =?utf-8?B?ZHZqNS9ORzcwaGJzVFlocmd1SUM3akVDVlMybStmdVVncWZoT2U5dUpQblh0?=
 =?utf-8?B?dGZYSDhLUmp6dFZHR09UcU11RXV1ZFBWNUw5cmREbjFqc25xdWlTNngrMFJC?=
 =?utf-8?B?VCt6ZzBLQUdsSTNIaHlSZXZNeXV2WVErMjVWcldDOGhJK3d2Q0pyb0NyV3pU?=
 =?utf-8?B?ejVtR1F0ZTZlWVplNUZJR3ltUTJXQTdoRzFmZUtKZGhoYXRDOHM0YmdnOCtH?=
 =?utf-8?B?dU1RNldsdVp2TUdDZHg3cjNNOXVNc0dVb1FEWTZzVWxDdFBUVFluQ3U2ZDA0?=
 =?utf-8?B?b0xjTElla0lxK1dsUE9FcXRJR1p6Y3RZUk1oanFic0hMR2dzYi9pYkdVc0gv?=
 =?utf-8?B?N0oyUWZqK1ZJQUM2UTVNcXZYb3JYTVgrdmVuNlpWanlCS2lGUXd0VER3UVJE?=
 =?utf-8?B?bm93QWVSZnlKRnFENE8yQXlYTkgyYkUvdUxLS0I3b2dITTR6MTRpYzVzYVJn?=
 =?utf-8?B?RVV5b0pQYUtoRmFUZWJsVTdlZGF3blF1aTZQTFlTbVFVVVVSSzZuYWtsbEZ6?=
 =?utf-8?B?OW5rYzJsbktSQUU2MlBXZWw4QVdtcTRyOVJCekZ6Sm53UktqcHRFWlhMcmtT?=
 =?utf-8?B?KzRsVXRZRVB4aWpLeHhrQ0ZiTUVSbG1QVjZ6TmlvQndrTjUrL3dVaUMzQWw5?=
 =?utf-8?B?UElPOC9NbVo4K2VMdE5ERkpydW9BczlCcGdvbUhQdTRmckh1MnY2bWMxTXpM?=
 =?utf-8?B?dzRVRTY2OTNJNEV2VGtKam5TSmdHNmI4ZHU1cFF5ekFTQWVBckg3YStyR2sz?=
 =?utf-8?B?QUF6WXc1TmxlVGdEbnNPY1JTU2c4RFJPN0NZRWZlOFcvZTk4V0xPUENGck1F?=
 =?utf-8?B?S24va00vNDF0TXUrQUwyWDJwRWlJSUVwYi9CcndISHFlYjRlUnBvdXBGbFMy?=
 =?utf-8?B?TEo3MUpZOUJEaHZ4UVd6SVI5bGMyL21pL0xlMkMySXlwcmN0UHJWK2p1UHVU?=
 =?utf-8?B?SFZXY2c4YWFzdUtBNkZoR2FJbmZPUXJoK2lZQ3RsMW9kcUsxT3pQT1lwRXp6?=
 =?utf-8?B?ZzZlcVJDUnIrTzR2TnlnV005MkJGcnhiclY3Z0R1U05leWpCd2g0NktTNkEz?=
 =?utf-8?B?cmJVVjQ3WVA1eXJ1NXBqcHB4UytQWUxwTUdoTnF5bnN0Unh2Qy80SXU4ZjEw?=
 =?utf-8?B?dnRTNmtRYkZ2UW9vT1Z4QUFUcWNSc3RRV1dlNnVVM3ZwWDNzWVU0STdRQkVs?=
 =?utf-8?B?Y0lkU2ZMTll5eThDa1JRd3Vua2FMSXhRa2loeEJUUGhDRVFQK2tnRjk1TDJC?=
 =?utf-8?B?aVljTDlULytGL05ib081SEtaOUdTSWxGak92TU8yQWVTek5pMVFtRlBHZW1R?=
 =?utf-8?B?ZzJzU2twczF1aUdWUm5mNDdjMFo5SU1QWGZZNGhNQmNKZzhuMktTSGRoYkI4?=
 =?utf-8?B?TEp3N1dDSHNMS0pNeUNKZ1FZTEpFR1JnOVhTekNTbFR1bUFWajE4dkR5c3dK?=
 =?utf-8?Q?jBZMFjVMAns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW9kWGJjZCtOdFJwVWdIQWFZcFJsOTBQM1NwSDZsYzZ5MEdpWUlzbk1nN29z?=
 =?utf-8?B?M0pwYXNCOGI4WG9RMk9PcnRwRXNaLzZKREV4S0dFUHBMVjJDdzEvYWRsSG9t?=
 =?utf-8?B?cUJZdGY3eVZ3NnUxY3I4MnU5Z3d3VWR5QlJGRUpPUEpxMXdxNHA2QUVLNUd3?=
 =?utf-8?B?UGR3U01IcDlXNkkvVlk2RFppS3ZUSFF2TkdNRzZMYnVlczdPdEV0STBLTVZN?=
 =?utf-8?B?RjlSSThkZjgwYXNhN1VqM0xMZ0thaytzM0JQR3I2YkNMY3JXTm1CQTJsR2xC?=
 =?utf-8?B?bkZMM2xrTy9BMkhRWWV4c2lFdU9jV2I5cFc3TUlLYWNIa1AvM0dWRmpnTWJ5?=
 =?utf-8?B?ZnZVZjVCa3drMDhOY3RZdU15SUp4RlByUFRURE1pL0VKV3hWV1ZCVVhTU2ll?=
 =?utf-8?B?Y0pvU0RjUVFwUUYyZDBCMVg5cFhqTGQ3dklXcjE2eE8xNUIwWGh1Qll0RjFk?=
 =?utf-8?B?dFBRWUZ2aUp6MUlIYVBzbUFsa3lnV292TUlIMVNwbzkrL1FXTEMrdmJWckM2?=
 =?utf-8?B?UzE0K3BzZFBrVU41YTN6RTE0QlBsbUxaOUloYjZ5R3VTRnVQWjlMKzU3RnR5?=
 =?utf-8?B?ZFRFeGRhclBvb0h5azFrbzZJVXZ6bXBCd2hBclhkYmhoeGorOU5JSnlpZnhE?=
 =?utf-8?B?UHFYVzk4dzRDcHZJWEIzckFtZnR5K3B3N01kbkJQeXg4d1NBLy9SMloyZGxw?=
 =?utf-8?B?enFnOFZHMlV4VHYxS0hXaENrOTl0QmZvNE9waDhidDBiZ0g1dXJ5RUxTZmVH?=
 =?utf-8?B?c1BKcStUMGJIQUtlL3ZJUVBJOE1wTEl5aC9XWWU5M09PeExncXJPNDl2MWVv?=
 =?utf-8?B?akl2VWJsRkNXcC9aSEhscm0rd3Z2RHU3c1hlc1JZKzBKeHBrMFd4cWh6dm12?=
 =?utf-8?B?bjFoUUlZNFQxZEw2VHNHcGlRekFDVGpITE95Ynl5V2QwSkg4cWt5aUUxSFhT?=
 =?utf-8?B?eHdudjNPbk5BY2tuM29nK1A1TG95OGlTTU51c1RwbFZJZTRIVnpkc1VucFNL?=
 =?utf-8?B?MGtuMUpqRnBwMkpnbkdkRXYxOG95UUZmNVJOeGhsS3ZVL1RVS2VqNlZ5V1Q3?=
 =?utf-8?B?eWNwNnZ4eERHWEcrMWFLY2tPSmF6QkxOUVo1bi9HTmlPT3p2Y1RrMERHQUc2?=
 =?utf-8?B?UlBqUFZlMDdPMTlVMG9QSEVYcDJnNi96OTVZQitzZFQ0ekpmRkNUOWxWNVFR?=
 =?utf-8?B?VUhIazhsOUd1dzhXNnZhNW4xM0tGN0FkZ2p2SjYxT0diNHdva25uOVkxL2hm?=
 =?utf-8?B?NEpZeFZqci9EbEhZdTJNSkE5WFc3NW5yMDhsMU1ZcEtRSjRIakJDZGx1MU1t?=
 =?utf-8?B?WEpUenVOaC9FQ08vV0w1WDdjVlZwZk5wNEJuM0tnNlpTWm1WQ0FpVk5EUlRF?=
 =?utf-8?B?VWFVVUlKcnBFL3BodnJDRXo4S25YQ3Q0b0dmWWtiT1ZMTExTKzNKSTcwUWl5?=
 =?utf-8?B?RmRhTllNVFg5Q290a2l1ZTVHMlAvWVRCVlJKbHNtNWZJNndBR0t4SGZRZVBD?=
 =?utf-8?B?a1ovdGFIazVHVG8rbTVGTVhocTBKU1pKcWlIa3h3NFJnTG8xVVByT0N4cXJM?=
 =?utf-8?B?anhMZGtWRjBUUmduUTJZczJDVWhkaXZmK3d3ME1rTFZFYUxpaE9udXVwTU51?=
 =?utf-8?B?cithN2tVUytZZmloejlIcUVzSGxqcXB4VG9pMUlVMGl4MjdQaEtJcWRhMkM4?=
 =?utf-8?B?bGdPc0lmWVpjdnI4VXA0bXVnVGhwWDVPV2hzTHpQOWRnR3ZCTmJFMjhmNStR?=
 =?utf-8?B?Ti9EQVg4QWZtTGhVZnpYY1VZejhzS3hxaXJibVp4Ky9sTnFNeWVmTkI2Yi82?=
 =?utf-8?B?VnZ1Z1huMk85UjEwSVhXZWdnVXpTeEVrellmYUN5SlVmZGtyaEF2VHJvSUZX?=
 =?utf-8?B?TmlHNVU0U3FVWUNCOWwvcE81RXUrdFJMZG43SlZHT2hPWTY3dkJlOHpCOVpp?=
 =?utf-8?B?SVd5eVNkVzR0V0dnNm5IRlRCRnFGRmd1TXg5RnFTaEZ0RVZVMTkwd29ldDMx?=
 =?utf-8?B?NlgxRjExNmRDSStjdCtSaUY2TE9SeXFJeS9jUVJmcGdWWnlXQkZOaEVsRm9L?=
 =?utf-8?B?SnJZT3lWRzdFeXFFczV4QnlMSUp2N1daR1dSVUlOQ1EweDlvSlFKa0lBaHZN?=
 =?utf-8?Q?/04B9PtQ6GpLweKZOrzp9wih/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2c5589-2fe1-441b-bae0-08dd6c1ad803
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:01:10.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kz1NhN22cDakIFEHp+idWw3is0UxnBpbmlzpxjbwQ+V3cGiAEaqUvofY6tMj+cSN8SQnnOdYs1hGrAxt1HA+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970



On 1/29/2025 6:08 PM, Mathias Nyman wrote:

Hi Mathias,

Thanks for reviewing the patch and apologies for delayed response.

> On 27.1.2025 14.06, Raju Rangoju wrote:
>> During the High-Speed Isochronous Audio transfers, xHCI
>> controller on certain AMD platforms experiences momentary data
>> loss. This results in Missed Service Errors (MSE) being
>> generated by the xHCI.
>>
>> The root cause of the MSE is attributed to the ISOC OUT endpoint
>> being omitted from scheduling. This can happen either when an IN
>> endpoint with a 64ms service interval is pre-scheduled prior to
>> the ISOC OUT endpoint or when the interval of the ISOC OUT
>> endpoint is shorter than that of the IN endpoint. Consequently,
>> the OUT service is neglected when an IN endpoint with a service
>> interval exceeding 32ms is scheduled concurrently (every 64ms in
>> this scenario).
>>
>> This issue is particularly seen on certain older AMD platforms.
>> To mitigate this problem, it is recommended to adjust the service
>> interval of the IN endpoint to not exceed 32ms (interval 8). This
>> adjustment ensures that the OUT endpoint will not be bypassed,
>> even if a smaller interval value is utilized.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>> Changes since v3:
>>   - Bump up the enum number XHCI_LIMIT_ENDPOINT_INTERVAL_9
>>
>> Changes since v2:
>>   - added stable tag to backport to all stable kernels
>>
>> Changes since v1:
>>   - replaced hex values with pci device names
>>   - corrected the commit message
>>
>>   drivers/usb/host/xhci-mem.c |  5 +++++
>>   drivers/usb/host/xhci-pci.c | 25 +++++++++++++++++++++++++
>>   drivers/usb/host/xhci.h     |  1 +
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index 92703efda1f7..d3182ba98788 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -1420,6 +1420,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>>       /* Periodic endpoint bInterval limit quirk */
>>       if (usb_endpoint_xfer_int(&ep->desc) ||
>>           usb_endpoint_xfer_isoc(&ep->desc)) {
>> +        if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
>> +            usb_endpoint_xfer_int(&ep->desc) &&
>> +            interval >= 9) {
>> +            interval = 8;
> 
> Commit message describes this as an issue triggered by High-Speed Isoc In
> endpoints that have interval larger than 32ms.
>
> This code limits interval to 32ms for Interrupt endpoints (any speed),
> should it be isoc instead?

The affected transfer is ISOC. However, due to INT EP service interval 
of 64ms causing the ISO EP to be skipped, the WA is to reduce the INT EP 
service to be less than 64ms (32ms).
> 
> Are Full-/Low-speed devices really also affected?
> 
No, Full-/Low-speed devices are not affected. Thanks for reviewing, I'll 
re-spin the patch adding this change.

> Thanks
> Mathias
> 


