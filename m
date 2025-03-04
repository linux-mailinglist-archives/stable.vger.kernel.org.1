Return-Path: <stable+bounces-120263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C746AA4E60A
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C317F144
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F724EA9B;
	Tue,  4 Mar 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="unEOjHLu"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084D27E1D2
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104269; cv=fail; b=SSIZ9qe3PvkCJujArVEM9/Nh4rARyro+poiJTwWyNc9oGKyvkW2PZ8woYvgoaB1jMVTlhfz8Gvg6iAdzSqyMaT9vz/Bf/K8xs91P1vgXX36bYaJsyrWccXIglXiciA3QI/CS0+LgJGpHvKZDVn5UPw/t2N9k0suiYqLSv+ERnIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104269; c=relaxed/simple;
	bh=bDoScIKbNzqH7B4Cv3wsUY4ON/3OslGA8q81wW25eQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVec7GWlHVjSK3sUNlwJlJX7/Y361c0ZCK12YKZcYWyO/ImYHMN3ad000L+kWqlhpewafJemPKkrypQ1jve0tT4O+NQeck6OUn9srJLobjr4JmOawM/6QQx28K67grGg24++9wK1yCSjiGlexMPqwrzpBBeX/pCr18MLXJl+ie8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=unEOjHLu; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV4kgCpLYb77swYRlKgKIzrGoTyYHFF73oOXqFA0tdqpXgX9FQcY03otdN+Foh8gnFyKFdIpJ4AlbD68Dk9RbBaw6xYqV5mBLrImUGyB1Qk2bMP00nMcG6DzJZO6Qv+I9caRQ1tIyvDYNLVSqc/wmOKBsv+aDTVO7GlFMKQXv85H/8Zz2H6tVfY4LzaMHnaSSReF8bmTWzcQ8WQk3W58VrkR0cOycM36LFRugitM2fzBJfoyyy5ONNIgKn/ErNT/dElBwPUfI6NjkDq/Ij45zIoOvY9aD3GCJte4Qe2SM4j2vxqo1pOa+dbS+lWVRE1+epNyAvP2PO9Ghiu12EdjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPrFxUbhueuROFLOJ2NgMrOK7Orah0jo/s6Llivwl5M=;
 b=W/r54EsZF/pY+uMyU8n2AIjvFczllwbVp9dyIhQzrpn5VFprlFmYVRGVxr9E422ZfmSCA9N3aSBX4JtQ/liqpyUkL15uDAS1juF5K7tYF600n5cb/BK5G/lUtHI8zBaMPndli6QvrEWRGnW13ZunoBZV1CcTlOPHvezwBfphkRG5ATtxiHM2akSi4CJdWIvKxAfUmqwf6jK86EiN/ec1f9psyDA1AL5wURUzODBGD4gf6XDqvkLMWD7rzY7yPEJh/3ol6t2wuu1L5GdwVnt2qbY4Q7lXXmhTQD5Ep3GdO+np6BtKC7agWxmYNps7qKv5PhUiS+AjzTNyg0OPeKV53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPrFxUbhueuROFLOJ2NgMrOK7Orah0jo/s6Llivwl5M=;
 b=unEOjHLubh/emqMrsbrL1P0b8bZSugIXviPipuzYEMlCFtkDAdg5MYtBLi1jmwiO87GCt1xChnw0myqFUxhUwSjFnvFPN3DXqkrV/v2Xbgh00CEF+gTvFL9pxUU/Vev+JJuYbYXapOomlECuS2wcyuf4wuNNn4bijK8guFwUkNW4+yE4rAM7WmjvbHy2mts9dpBFZwe6vDv82H/PHDQSrdibB9km6o1g5WejWlbUEY91CJVyJ0q3KMxAva2hsybfvsSjrY15ax4C/JhharWmDxvOXuDmvraRNHvgI7Z4bNke/ZI19U5tdIlS2hFLL00R8Llker4Hw3nvaS2O0QZ8iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:04:24 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:04:24 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: andrei.botila@nxp.com
Cc: Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata
Date: Tue,  4 Mar 2025 18:04:01 +0200
Message-ID: <20250304160402.180548-3-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304160402.180548-1-andrei.botila@oss.nxp.com>
References: <20250304160402.180548-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AM8PR04MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c09faff-74c0-4b42-97cb-08dd5b363b92
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFZpdjlqa1RXckNZaVdNanljN1A3aFNadFlGUHZYTXQzcU1vUnc3eHlnOUVH?=
 =?utf-8?B?a3c0K2RmaDBxc05aTEsydk9ueUo3bk5XTHBzUkN0d0xsMkNLbTZsMnhqbEJI?=
 =?utf-8?B?bllPdFJ5d1d3VmNrZHZ0ZVhVM0MyVVBUb0U3UVJsaU40Y29ZallnUTJoNmJx?=
 =?utf-8?B?OHNzNGFqeHBjb1l5STNMZVZzUWtOZzhHcFVvKzVFNU8rbHVmS2xWbWYyajcx?=
 =?utf-8?B?L0FKeEtnbVBIcmw1MCsvZER6c2srL21kRUZ6SjMrU3dzV3ZTb1llamZDSS9G?=
 =?utf-8?B?Z1R4OVlzRWt5bTFMMitFMzlDYXV2VXZ5UEkzRmNtUitnMmZQQk5lRHJISncw?=
 =?utf-8?B?R1p2RjJFZFMyVzBwVGxNaGVyclRGVGRkd21Od3hBTEwyUWxaeGk2dVZDWHo3?=
 =?utf-8?B?MDNnRUtQMXo5K2RnekRaYXdkZGhKeVVBSHNoUXRiQWVPWkxaTnJmYWR6UlhP?=
 =?utf-8?B?MllZMWpac0wxRTV3anBGcG42UTVISlp3WVRaRHlIOXcwZ1RJc3dxUWtVOUhK?=
 =?utf-8?B?WGtGTkFpT0I3Q1FiYVFxeGFLWmNYaDlYdmFYZHhFVU9VMTdyTlhUTmt1bThJ?=
 =?utf-8?B?RU56cTBZRllhQWpKYkJCVFYrS1lTMWdZYkhrTTNzTlRiSm52dHZWNUxsN3Jl?=
 =?utf-8?B?K3A5S2V2MzljaFRMMjAvYllVV1VsSkVXSFNxQ2hCTWhPRXdGVUpxQmV0aDlH?=
 =?utf-8?B?R1BITDBWT3dsRkxLZmdTWW9PSGYrUWNWcmttNjQ1MjJLWEVjd3Qxd3Urcmpp?=
 =?utf-8?B?NFJhamlZQVRobzU2eEZZL1VnYVNyRWo4STdNQ2g2YUtyRVN3OWpQek1ZZzlL?=
 =?utf-8?B?N1dHOTYvZ0xoTkxvZDJnMkxCY1E1MngvWGJqN3V6R0tvdXFCYkdaOElZdTdj?=
 =?utf-8?B?TllKM04vNWZCN2d1NlIvSTkxN2lyTFdscXd1Y0xtSnIxRjZuTlVGb3ZzRTZz?=
 =?utf-8?B?d1cyWTFSVlk3eHR3NU9sR05uU2piZm5vT3ViSHZ3dVpwMVE2QXFGWTJrZmxh?=
 =?utf-8?B?M0RuMFZJZExrNHVwTDRHWjdCYlBrQW1XNDNFaTBYQU1wNmdVcTQ0Ni81Nksy?=
 =?utf-8?B?K2k3cE04SVVxaGlvanlkdlA3bkhqcFE3QmppcmhLWUtDNVVyVmtzcW9vdGFU?=
 =?utf-8?B?Z1lNbjBOU1dQOTFBVlo3WHBPUmxGb1dYazRMQTdlM1dZTmxiODNMZVg4YUxY?=
 =?utf-8?B?TVJyNGMvMUJqOXNMblhkdks2eWNkU2l2L1oyL2xCRWdxS1Qxbk90cUh1S2FB?=
 =?utf-8?B?SzNhUkIrS0FLUU50VXd6VDhCbElnNG1PQnZTSk03SFltcVJyTFgwbmFmci9R?=
 =?utf-8?B?dHFaczFwRE9tUno4Z0c4cFhCeDFVWi9nMnpjY1NSM0VYSGVHaHFpRGhTMTFt?=
 =?utf-8?B?RGRIa0g3b3g0ME5EZWNwc1Z6ZGxkUDB5di9ZN3VseDJ5Znp3UDZ1NXRsK0NT?=
 =?utf-8?B?aWN3bHZaZVR5VkNjZVVTeU50KzhuWE9qTXdrUWY1QVl0bWE2UkU5U2NNdEJt?=
 =?utf-8?B?dmx1bXFoSGdrZ0kwUENpc2lXcXQwejB3NjYrM2pCdjBrNld6L2o2K1RYektR?=
 =?utf-8?B?K2VkbWwxQ3NBMnBGelJMYWUyRTZCeXF1UUtXeU1vTzBwd2JBcksvbDh2OVBI?=
 =?utf-8?B?WUZtOWxvMmZPa3pRNm51amZZY3lkUGZwdUJXRGUwY1VXazJ5TnpSSHd4L2xV?=
 =?utf-8?B?SkxlSTVLV0VLMTNtVkVyOGg3Wnc1dzUySkt3NUk5Y0ZRQURncm50VWtRcUNv?=
 =?utf-8?B?N2VPWG92bldNaGZ0VnFSclNGN2FiTFp6bEhPZGVVSHhYeG1sZXB5eHUwcWN4?=
 =?utf-8?B?MCtUYnNwM0JZS0g5Q05TcUJKbjdFc053ZkFsKy8xMVNUM1E0U0hNaWZ3RUdW?=
 =?utf-8?Q?iF8pk8oWYaTq0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGpReTFIYWJQYnRpUUFRSFlWbXZsYWdFY1ZQbmNTNytZMEl1UUtPL2NRN2x3?=
 =?utf-8?B?Q3ZUaG1YYXRjZ1BZNHMxcUhuM2RML2VWMWpNemg3RngvcXkvRS82dUk1S3Vl?=
 =?utf-8?B?OUc3OWxUb1ZKSzMyVEt0QTFZZFRHenZPWDBRNlBiRU9pUkVlQTVIQ3dickVJ?=
 =?utf-8?B?cDBxVUp3MjJTcXo3c3RUbXZhVy9VN1I3VHpTZlptY2RtZjRud3N4ekpBS0Zv?=
 =?utf-8?B?Sit5LzE1SWZOR0l2aFA1Sm1XNlVXOHUvN05zK0U5eDlaN3pLL2FaTFQ3dWFR?=
 =?utf-8?B?V0RQZmFaN1Y3MTMzY2R6UWUrUUNXdEtSL28zK2VWU3RMMzBSeGt6R05YWnZX?=
 =?utf-8?B?TVcwQVp0UlFnbE1SU3h3Y2pNR3FSeGUwblgrZWl1RUJlbDFFU3NjeTU4SFZC?=
 =?utf-8?B?cUN6VWxMSWU3N2NhQVhHTlJtVEZWdE5XdTRzUmVjR2NKRkI4VVc5ZUpaTkxj?=
 =?utf-8?B?YUJiOGNhUkYvVUlhRVpsSCswTXZ5b244VEJaV2JDdEtlSUYwaW93WFdRTW1U?=
 =?utf-8?B?cnVFLzRCdGFuaWxGM0pwNmxQRnJUYmdEUmRIM0xNOXBYenBxYXFVeVNvTy9R?=
 =?utf-8?B?czV0cnZ0c3ZTa2N5azNIaVRjZmtITW5XV2p3eVJqcS9PSHg1VmYyQkJZVTFa?=
 =?utf-8?B?S0JVWVVXZncxSC9rVVl1dXJDbE1LaEhqWEdyUk82elZVRzZDd1pwamxialVW?=
 =?utf-8?B?b3dkOEF3bDBEWnlXcjlFMFVXbVJlV3lOMHdocXZjNXBIQ2tIRGNMYVl5ZVFa?=
 =?utf-8?B?aDVrU0hEKzA5dTJ6M3VMTEtZbEJIb2VlMGI0ajIwNTd0SCtJdHB2ZG1ndHJv?=
 =?utf-8?B?NVJxSzJmZHA4a3lCMndWL1lzVVZ2NFRDdjdncXFPdlBiSkMrdVZXazh4K2wv?=
 =?utf-8?B?Ri9UcEdOSDQ2OFVoaDJ2MjBmT2hpVklSVWNTSE9hY2lhWm8zWW9wSU9iNko0?=
 =?utf-8?B?UStrZXJSdVgvY2lyMldYRFp3NTNUdWhMd1EycWtNdE1uQTk1K3o1ZWlMb2J5?=
 =?utf-8?B?L0ZFMEFHZEc2VGl1VGFRZlY1NlptZVVhREg3WXpVcEdCd2lUU2xIMGRyN1Ix?=
 =?utf-8?B?K0hORWVCbm5VZ1h5bktxWGwvWHFYMWp3dmFiNUFwRTMvU3FkcG9vWERObVZV?=
 =?utf-8?B?RlVkOXYvMVNWdnorK3hBcUk1a2hNSERpdnJhbStSL3UvazBBcXkvZ1NtOUJ3?=
 =?utf-8?B?eXlCTkt4UHpGRStyWXBQVzdHeTlQZ2dJeks2Y2NWdVo5ODlZVXQzTlhkb0Nt?=
 =?utf-8?B?ZGlzZTVsaGdSdnRhNTUwbDEwaWZuSGEralFrMVB2WnRvWWl5RHV3eTJwRmds?=
 =?utf-8?B?REw5UTBNcytLd1hjb3B0ZklPTkV3c0FYQUVzV0tWTzVwejkwZFk4RVJ5dTUw?=
 =?utf-8?B?NUhVYWswS2YxRFMzd2o1RG1TREpHeVlVaFRoTGtvSmlUbFhyKytTUm53U1F0?=
 =?utf-8?B?L3dGU0VDUzFDRXpiUGVqdWlpUkRvUkNRSEIyZGtkb2tMOVh6SW02Um9XZjQ3?=
 =?utf-8?B?aUthM21UL0tXVXpscHJHS25wMkk5MlhsNklFQWJqYkQ3bDE3UkZJMnI2VXJT?=
 =?utf-8?B?dzY1MGFWaHNsNzF1UXZpRWVGMXZ6bm5WT3BzRktFMllJMUZVbW5YcHU0SDU0?=
 =?utf-8?B?MW4veURoUWkxdzdBWWkzd0RqMWM0UThwZzdXYkFJa1pSeFVFdmo0aU91RnJt?=
 =?utf-8?B?cWFiMXhJcG9ReUo0YU1rR040bDQ5ZG9OZHZwNU9iR2RNWWpyUGQ1YUFZR3ln?=
 =?utf-8?B?ZTkyVVB3Q3hVUFVyTWhGMUJaMS9DREY4KzZTd2lnMEV6K2NWTzhybnRJTW53?=
 =?utf-8?B?dm9sS2NnNDJ1NEp1TTVZYURHMStsNGRrWjFzYzRiSjJnUWh4Qi9ZcklaNDhR?=
 =?utf-8?B?YW5qdE03RExRVUtpWVNLMHQvc3c2cmM1K3d1R3FhaUs5ZEVhTkYrWXBWNGx0?=
 =?utf-8?B?TGhJcS9HaEVsRzRKZDFmUldnQ1VUZ1BTNUJEZGNJMW9TNkVzNnFNY3B2L3Ix?=
 =?utf-8?B?Y2lkUENISkFRWVlzYTU0UzFyeVhJVEp6OVBhOHJEbzgyNlN5S1FLWVdpRkRs?=
 =?utf-8?B?RHdNWm9iUlZQVDRHNENsSHBNTFJpUnRhMFhjODB5ZnkwcGN3Q0xoOWFvdXd1?=
 =?utf-8?Q?ZsyldBgJsQyHH417EtNJ9q37J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c09faff-74c0-4b42-97cb-08dd5b363b92
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:04:24.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qoxsxqxdgz8DSnX3/Mf6sb6iO2w41bWXS/k/4lUcqxuVSsBXmSdj2JMQIoiEyoiJupsF/7XArwh4FNK4vGicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7874

TJA1120B/TJA1121B can achieve a stable operation of SGMII after
a startup event by putting the SGMII PCS into power down mode and
restart afterwards.

It is necessary to put the SGMII PCS into power down mode and back up.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 709d6c9f7cba..e9fc54517449 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -114,6 +114,9 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SGMII_BASIC_CONTROL	0xB000
+#define SGMII_LPM			BIT(11)
+
 #define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
 #define EXTENDED_CNT_EN			BIT(15)
 #define VEND1_MONITOR_STATUS		0xAC80
@@ -1598,11 +1601,11 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
-/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 & 3.2 */
 static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 {
+	bool macsec_ability, sgmii_ability;
 	int silicon_version, sample_type;
-	bool macsec_ability;
 	int phy_abilities;
 	int ret = 0;
 
@@ -1619,6 +1622,7 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
 				     VEND1_PORT_ABILITIES);
 	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	sgmii_ability = !!(phy_abilities & SGMII_ABILITY);
 	if ((!macsec_ability && silicon_version == 2) ||
 	    (macsec_ability && silicon_version == 1)) {
 		/* TJA1120/TJA1121 PHY configuration errata workaround.
@@ -1639,6 +1643,18 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+
+		if (sgmii_ability) {
+			/* TJA1120B/TJA1121B SGMII PCS restart errata workaround.
+			 * Put SGMII PCS into power down mode and back up.
+			 */
+			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 VEND1_SGMII_BASIC_CONTROL,
+					 SGMII_LPM);
+			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					   VEND1_SGMII_BASIC_CONTROL,
+					   SGMII_LPM);
+		}
 	}
 }
 
-- 
2.48.1


