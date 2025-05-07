Return-Path: <stable+bounces-142094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A7AAE58A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F317BE3A4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861A28C021;
	Wed,  7 May 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bPhXRsE6"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8EC28C01C;
	Wed,  7 May 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633040; cv=fail; b=QL3yueClQGAwFW3lNobNexbtwA3kEwuIHmCfYtKvN1EedkzlSZXS2A3t6MLfqKxaUW8fcO28Qnz6zwivNC+qVz0LtX2HxPefY8oTQM3famKSxy52xxF0Hk6FCXJ1ksBNnBEEcFUT5eL3aRv9lh4sSl1s5ca9Xy9Dcy4Fu5OLUUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633040; c=relaxed/simple;
	bh=+zzM9CHAcJM2rCZnJwBrIeWpTybxyKmoCDiUDCsZ2q8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTyBQQVkUXDXCJ082cTAfkxKeCB7JEmONyDFGKg2YemUas3ApY6Q+Eye8zkjSf+cZVOqGdhWztU7oKuynaEptbahtipgLj8qfK4XJG/kSFC3at6Pr1B40FQ2Rej/Ohe8uwXJ4U8nrmZfl+AnFhvr1belCNJjG4bo0ZXf13g8Ieo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bPhXRsE6; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rz6IfPS/ff64AFjxOa+M9vHPdElaOE7BzXO6z5pyYJWDR+4JToW6WyhPGPeJYvL/d/LYfmRX+L/C33IvsH0PtVksNYGhsJoumP8JttBLasoSYHIBSWa+aT0W7V6e0R/w1tpGUOXogYzSqpLbos/fzNIkI2Z8WmWxCuKb+qvXYyQ802FDN9PONnx/SWTSDpa6ckwG5Ohi0pbYgcj1tjt8u1g3xnXupHYcqII9YxmKTGTy73Qh78RsAhArbN4BQbVDxTvlcWrU/ToxUpBaq46VgtNA2/X89i/gHKfkYMFIli5jXKG2Bh5wVd3Aa/XG1oma8cvT1m7QlZA338xh56Pkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN5Dwn+EzPsypNIbTlATqtMVBUssiqryh6kQzikDyT4=;
 b=FfQzKU8sRyHg6bfxGe74v4SbOQFGO6CSAF2bgQBz2F/dCzaQN9d175WOX8JwpLcdklLJ1aFFDI4RniIpQQnMonv9/DhRL1KzoM04D1WwAdJ9yD+QIgtUO8Pm8kSyEhLY6idI5ESMBoeps7lV58DR+/vkWQMt471unwSfD7Lu7/upJaWDSuir4czAp1WMbjROhSefnwTdt8V4L7yaKx1CbsjBASwrmdXIv9+PCVqajOI8FZ+Fnm1ANtxRg9hNYEXOfwQY/cLG8gEJFMaQGSh7qox4hpV0tMGfcmhF7KgYH7Ni6YFAxz3o+Pv7T4eTW532b9lxD+gHzxvDE4K6WfSCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN5Dwn+EzPsypNIbTlATqtMVBUssiqryh6kQzikDyT4=;
 b=bPhXRsE69TF3QkTvuFhwwnfNyLzpTEeoXNIh6kXkZxVX6vR+XVZbr3Umiibh8tOpcauyuP+6xRjZImxD8uNIUNsia64DgqYhmi02x1MPz7wFN+A/C/iMU4WxvL0Aw64ejvezBKleE8H3rNjlm0b+IuflSfKYyePAZOBWSY5cXg7Af2R4BOWteUQWPKI/WiPIyA+myW3ZFNqPMIY+oOHqsiv/dgSt/FsIwDwtYOxcFFxiA7NSthWykMZumaJMaBXejH34r03RyOQKc4Bq2mmgniVRXfcSzhDpv17jcbOkGHHy0RAotzBTfI8G6HTllAuRz+x8/rkAXHif9aE+SD7DMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 15:50:31 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:50:31 +0000
Message-ID: <2928a808-c4c0-4ef2-a6d7-79e7053c6915@nvidia.com>
Date: Wed, 7 May 2025 16:50:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: tegra114: Don't fail set_cs_timing when delays are
 zero" has been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 webgeek1234@gmail.com
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20250507154327.3165360-1-sashal@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250507154327.3165360-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 86473df8-f127-479b-46dc-08dd8d7ee577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFZBODgyK2FtQTJpMjhPdlMvaHE5akpMMG1hT1l5amdVYXpqOXdWWldBM3NO?=
 =?utf-8?B?OU54TWNaRElwUmRXT2t4eE5xS0JDamZFdWdBcjVvSzJPb1hBYmxIcGtyTFpS?=
 =?utf-8?B?NVdBY3pHbUNDa0pEN1kreXEwVnRaNEo1QTU4Z2kwTDI5SWZnT3ZlUXVCcld4?=
 =?utf-8?B?KzlGbXVVRk9DdGlNM2I2TzhJNjRsb3lJRy9LUFNielZuT2twRnU4NjUyM0hm?=
 =?utf-8?B?bEVKd0hUOEFaMUZkUHhGK0VKT29SbGU1YXdlUmcvNkh1ZEJiMjY5dUt4MGVX?=
 =?utf-8?B?LzJiL0tSVDBMc3ZqK3BVUmFMdXFxcnNkelY1K01ydHNibHJHOS95V3lWK1dT?=
 =?utf-8?B?enFFUE40Unh5aU5tNHg1bExFWWZPdDQ4YWM1MGRMRE9KK3IwbDRBNTRLWVcz?=
 =?utf-8?B?bEJrNHhnbFFmeTdLMTlCNXFyMjdFYlpoN0lVa0diRGEvSjhpQkl0K3pVU3VL?=
 =?utf-8?B?NzlrNi96REIvMjFobHFqSWwxTGU5UER4eXR1WmFPSm9FTThqMzZoa0JYQUtQ?=
 =?utf-8?B?S1Q3RDh3WTYrR0hMK1RneDEzOXNWejh6UUl4VDZicis1Y0ZHTEdYUEYvQk1v?=
 =?utf-8?B?aDViL3VZQThQSU9LQ2tiNGpKbVBZYUVZM3FxT0FmbXdiN2NzS21nL3QrQUdY?=
 =?utf-8?B?bHlIQUdKb0s4eFc4dU14RUVEVVhzdDlOSWI5MmMvQ2FRZEtONTEybWZ2VE5X?=
 =?utf-8?B?QmRpMHBFdWR3WTRaeUUrY3Y0bHEvYTkzeVRvRWtBenFNU3g0aHF5TUpIa3B3?=
 =?utf-8?B?QndhNGZML0d3dlM1K3dYNDdCcWVHRTdDbEJLZ3ZKY3Z6QnlpN3JpaXhOTDhM?=
 =?utf-8?B?MEtOVkVqSEwxT05oS0ttSlBYK2JaUHM1N1M5RFU5d1VZeHE5bnEzYTNnRnFS?=
 =?utf-8?B?bEFsMzdjK2cyQkRoeFU3RWRaTlg0S3VrQ3RTNTN3UVlEOHhuZnNldDhianU0?=
 =?utf-8?B?eHBYQWFkR2N4WUUxSEgwZ25hdHoxajNsMldjT1ora1hlcXNEc1ZTSEFlNDl2?=
 =?utf-8?B?OVBGd2o3dTFMVWs1M2ltNFBHVDlJM1pqRWg5eFpRdFBxd041aEhQNTFhUXFS?=
 =?utf-8?B?dm1IRVdKalVvQmxnSkZJallRWHk2S2sxaXNDZWhFNjhsbEtMWTFCSkU1Mjgv?=
 =?utf-8?B?M2xoNE1rS3llSkJJZUtReTVTZWVEUE5ZOExjQzR5OFk1MHlVSUIrNzJBM1Qv?=
 =?utf-8?B?VXZuMU5TZ0tydzZQN0dScW5YWDVDQUJZWkhEOUkwYlNvMGczaHhPMG1aZnVu?=
 =?utf-8?B?eWpDMUMwbjArcjVWZHRGQUUzNDRpV0NkSmV1TDVqcTJlWmN1OUlweERyeU1q?=
 =?utf-8?B?dW9tSlExR2RPdzNKOHk0UWxRWTdxUkJpUGNET3dKQUdzYndmQzFySCtTWG4z?=
 =?utf-8?B?cXNHVUl0ZDZKOWxnS0lhdGhmbTVRSHRWUWprQWZmYTNGaFNIc3RCblMzc011?=
 =?utf-8?B?QzJqeWJUcWdzYlR4ZVVVVDZybjJ6WmJtVmlVU2hRNlg2OHlDRDRpY0w2NUU1?=
 =?utf-8?B?SEQrZXN3ajdQUGZ1eDFEZlJyREpIb2tNbEZOQmY2NzM5YWlLT3p2U3NZRklD?=
 =?utf-8?B?SmhyckpHVDV3eTlYaVFKdHZscm1kV3dpc1BhQkJaQm82TCtJVklodWI0WUtV?=
 =?utf-8?B?Z3lSbkRlTkh1WWZ6aUlLb2U4R1lsUVpLakpnUkcyNTdMNU1aMXVsMnpQdWJE?=
 =?utf-8?B?bDhmYWNhWnBrVzRLWnNVSG5SYWdPQlN1L0dRemQ3UkYxWS9wQjZsT0pvQ2x3?=
 =?utf-8?B?S3F0cHBkamJYS2krOWhmMXE0bkJDKzhBUFhQTFpGOUUzOXFjbktQc2JGcGxs?=
 =?utf-8?B?a1o0c3hBVXhZYXRPTDBCeDFOTjVtY3FySmFFaEV1akMwSVppeFNEMy9ZMGIx?=
 =?utf-8?B?QnlDOVo3S1BuSG5zMTBvUGo2N2M2Q21LK0FLSCtiMHZvOUdhOXBUNTRPa2tv?=
 =?utf-8?Q?33gEMXlxBt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q05lUk9vb0hrM2MwRmNCa21VR0J2R3UvUXVzbkk4MWNzWjVSeTd1aWswZ0h6?=
 =?utf-8?B?VXhVSSs4b3VwYkhORGpNeGhoc2tldWI2YVBsOHVKNWlFRjdjS0lDbzNDbnoz?=
 =?utf-8?B?amRJK3RQZEZVSVRnMVFGOUV2VG9vZjU1ZFRubTBaNDhHNTBYUXN1ZkZtQkth?=
 =?utf-8?B?dk9QM09Na3VOd3JYcjFCYnV1VVNKTDI1VHpqWVE4RFhuUHJTVVBDbFd1NTNI?=
 =?utf-8?B?T09VZ1FpZ1JvQk5LM2VOY2hoNlRER0k4OG93dldxNTBGSC9xM2Y5NzY4Mnpa?=
 =?utf-8?B?Vk9VUnNDMG1aaS94UVIrczhTSWxPdnQxU0ZXTFEyNEdWM2VnYlBod21RVkQ5?=
 =?utf-8?B?LzQ3S0FKNXRzeTJQNUNsWHd3b0Zaa1Ewdmx6REFZdmtKQktWVVpQR1QraTdx?=
 =?utf-8?B?cGtEQy9FbkxKbUZhQS9mbW04RmlDUVFKMWhrSXhINTUxUExSWVROMHo2Vm9s?=
 =?utf-8?B?UjFyNHFTZ09qMkd6NWJ3MlF3OEwxODE2UWlBdCszRitWajhLTGxpbUxseWwv?=
 =?utf-8?B?OXUvc0ZpdVArQkJ6bnBnZFJMRVFoaG5QT2VJZ0xGOW5NdGtzT2E5S0lEWXRs?=
 =?utf-8?B?ZVpvYzhxaVBsUTVPUEUwT1EwSnlSSDQ4a1hmOVk3MHBTT0lvaXZua08yR3NQ?=
 =?utf-8?B?T0YwUGFZZlV4eVNkU0NrM2RVbXF5RFJIQ1lSQjIwd0NYVGR6WW0wV2tTSkcx?=
 =?utf-8?B?ZkRQaTljS1hYYVpuck1SNG1rWjlTb21hQVh3MzVsNE1TOXlZNGNpWUlhcktZ?=
 =?utf-8?B?dEprdi9HbjlEVk1ndW9jYkRwSzBMOU9kdVVWb1BGN3NjK3pncy8wbU1obTlv?=
 =?utf-8?B?T1lmQ1pYZ3IwbzJndWxRMW8yekMycUdJd0p3M256SlFMNTZZdXc5UkZQclVj?=
 =?utf-8?B?MjdQQ0NCeWp5TjFCb1VCYWFwd2hGY1d1c3krYjZVd2wvZG8zR3lWUGlnejZK?=
 =?utf-8?B?dFRJUGpqajFXUi9kZHEvUXByaDhCRGRvbkRKcjNxWHMzQkhRbHBCUTZ5QXE5?=
 =?utf-8?B?Mm56L0x4aDRvT09pM0VUOTRsemJZeDRNeWt0RkFDTUs2ekN0YlNwbWNxemM2?=
 =?utf-8?B?cGo0VG04MXArSlc5RHFSQlhyUjFVeGx1ZFNtdkJLc3ZNOGFNb01FVkx1ayt5?=
 =?utf-8?B?YUdQUW5hRitlZGIyWkxRM1VBbFphTlNPcjdFUStSdXZrUGxNcWROVmlONk5M?=
 =?utf-8?B?NnRPZGg0WDY1OGtjL293SUtZMDFScGN2VXFWaWhhaC9nNFRyamhuUVpqZUZ6?=
 =?utf-8?B?MW1JVmpWM0dNNW5vYlBIazZXa0pqVFE3cDZtL29xL0w2QUJzTnNJVGJKOHlx?=
 =?utf-8?B?Ukg2ZlkrOWJyMVEwRThyTFRwS1Q2eWZWUHljTFdFRGw4SWswMEpQTExVSjZz?=
 =?utf-8?B?K0Fod1d4eWVJM2FuNWlremlUbWhqVWlPSHNFTHh5b2Jma2IrRytRVFl6NjhH?=
 =?utf-8?B?YmlaZDJJM1NndGZIbWdHYi9xNzFuRmNmZVU3UEFHM3dRSGVqZWM0djk3d1dn?=
 =?utf-8?B?YjZISUg4dUIwbDVZSU1DanBOUG5vM0w2UWduWDdERUlGdlc5aWRYSm1aUDl3?=
 =?utf-8?B?QW5Ib042VDA0SVZpaDNPaXl3c0ppSUM4aDQyaEdFd3l4RkUrTHA3czQ0ZXV5?=
 =?utf-8?B?bDMyUlc5TFZ3L3dGQjVmZTBmVWZ3eGcrblgzdFlXOExXYWlFaUp0N21jdVBD?=
 =?utf-8?B?ZVYwaHkwSXk2ZEo0VUJnM2pwUDkyK3EvQloyTFlpVGdxNjFXY1lHN2RCQTRj?=
 =?utf-8?B?QkQraElQNFlyQ09OV2FSOWJuVjlIZngwOFNEdTlqNktDUG1zbjJyb0hrYzdY?=
 =?utf-8?B?ZXVaSzlYT0xyNXFzZjFTWCtlZnVqSWNUSnN2NTNLb1B4OHlURGppV1hyTXVU?=
 =?utf-8?B?YUtmMHBYVmdEWUw3T3RYMU1MSDhCYllOekhYYVpXVjhza1M1dUh2VlpHbmtD?=
 =?utf-8?B?eGFGUlI5RVdTSitMYk5lY3RYNGEzSGlqSmVKZnVpN0htZWhtRFg2SXhyT3dK?=
 =?utf-8?B?SnF5N2Y3Wk5FMFo5azd4dnhDQ0dZUkxrYXRMdkF5Mm8zaDBBdGg0UmpCTkdZ?=
 =?utf-8?B?b0p6c2JiQ1Y4U1V6aFNVL3JiY1UyNzc4dm5wUEhWN1Aya2xBSVNHYkhTRnpZ?=
 =?utf-8?B?RXJEMGlFSFlxTGYwODBhTEEvcUdBelpldlNSTjM4d3ZBU2xiZ2grRExRazUr?=
 =?utf-8?Q?00U9jquiqfrv3umNsWWsw8Ic4RyM9iTCoQzMge+6KYd9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86473df8-f127-479b-46dc-08dd8d7ee577
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:50:31.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E00sRn2E8tUQkrxBIzkSXzbcOE7vXg1fscwp9AU4WhWU3qfLllPn/09+P88gqHA75B7S/ukh/WCb9UGmblKIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106



On 07/05/2025 16:43, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      spi: tegra114: Don't fail set_cs_timing when delays are zero
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       spi-tegra114-don-t-fail-set_cs_timing-when-delays-ar.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please don't queue this up for stable yet. This fix is not correct and 
there is another change pending to correct this change.

Jon

-- 
nvpublic


