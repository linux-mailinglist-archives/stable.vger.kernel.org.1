Return-Path: <stable+bounces-148117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BCAC82E3
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 21:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20743AAD83
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F394B218AB3;
	Thu, 29 May 2025 19:49:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1897E55B
	for <stable@vger.kernel.org>; Thu, 29 May 2025 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548146; cv=fail; b=BsBW2fa2nba3VZFIwnnbYicP7xGd3uIa6Tk1x7QYjhPAxh49u9vl0vKq3yIR06AqmLCTyu3rqLyDCJlU4Y7/w/mshoyXXsqVxvHokusoVfMgdWHViR7a4ORquNd+/lkGRI9jqXqOC6Oz3VRi14wndeXVFMAztU/9TBqdB/NJ+fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548146; c=relaxed/simple;
	bh=ozdSSCOeSDJqb7hVexAxxkjcfc0P5ERwjFhBRMptc24=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=XjkJ1IOE91vDKbmib97e4sZldmCKs2iZD2/uPWVRMrWKt1GMc3ZJn1dSy5EgpQ/QBBgY7eKY+gTOcbvb4hci8gR+yiQc6RVf1qk6zNnxfn7bBvtXyqjYY/O17574dUyr6/xLyEwH/4WSzfYzwotQiMWnf9C2J+QgGkcwiTs1XX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54THFhbx018369
	for <stable@vger.kernel.org>; Thu, 29 May 2025 12:48:51 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46udmm5ekn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 May 2025 12:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZmBQPriktqSVMt2ksoQacPcJflU8+WFUJ1d/LQBwqUCQC9Len7Fu4Q02wvJ91EulyG9MRBI8ZAjHANrDWP66UAsI9OpIp6S1TgqZGNcuTsYAcEd2AWNAa2hvCpUnItFgXt144RduHH3ydpslqg1WW0If/mfz3m8L3O/DYM5RBRME17EEOs/fs0y97fYesWEve2zknLdVEn3Z9hrXSwuSnKEa6PW+Cu54+vg2OEMh6Rgtwm4Za2QRKxy6iW8BBxLLsNiXjBjfDoXq7tTKg0/CCFVoddcdIvkx2cK25JSw+qRD47ecMN9p0yYvsyCDvmB8Odveldlt62TKO8ddgb3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrvI0IuTmL4adxVMiA3JTH96W/tqYbddocRFEZGJBBA=;
 b=xNkx5e7TASJMTCjVQwHww2n0/kpudyAfAw77l2yYndiAnIQ6+bl+57GD1+jNXHderRJ/KNqvT+ueCm7IOi6lStcBVqAa+9G1j76oJ/y6WJro2kF+PdLnYHJhHJZ03rCgR6CfBPFyS6tEq3oL0XvPF5LVM7A4qEE3BUriyLnMLUAABR1s7mgo6ligJSZPeJDpnnV7kinIl7YB7uCabBUsGWaZu5TnCSgFL/SyYG7yLvDv03ape+C9I07vb3cauwv5vlFDIsJO1FZH6jw6VHXboyPbKVXvUhPvbsmvvfv7wPbssCsG00hMtOHAD0LW8nlFw91mRuAH/jXf2zb1mCatFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by SA0PR11MB7157.namprd11.prod.outlook.com (2603:10b6:806:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 19:48:48 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%4]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 19:48:47 +0000
Message-ID: <929a9cbf-1059-4cfc-bed0-88e8fe931560@windriver.com>
Date: Thu, 29 May 2025 13:48:26 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: Are there any internal kernel ABI/API guarantees in -stable releases?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:256::28) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|SA0PR11MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 986f4e29-f5e3-49a6-2abd-08dd9ee9d3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RklkcHhpc29hNlJlTVFHbmdBRGhxUjl2bUZhUUhqZ0s0K3VKMFNFcnZ6ZGJq?=
 =?utf-8?B?TTFzMlpEZ3pScEJGeVB2MDUrZkNWZDhFOWY3V2t0djJFUzZJc1ppdU1qTnFM?=
 =?utf-8?B?SnVJdEhVdXcvaG5mL0FxUGRPYnFoMGIyZUlsdHBFWXZhdHg2WEVGT282WFpU?=
 =?utf-8?B?eHZIbUNtODVPcXdRb2FOTmlQQjN6YlQvdEw4VzNLdC9xWFRuNVNRU0kxZXlC?=
 =?utf-8?B?THVpdmFHNm0zaWlJV3F0cVZMYWx4T0Y5UENtWHR2SG9VL3B1aGV1UWhmZ1B5?=
 =?utf-8?B?cGdLTWhwektlektYa3AwUFIxcWtBai94Tjk5ZGoyMGJ2UU9KVjRnb2pYcjZn?=
 =?utf-8?B?K3ZhQVNqeHFhQ2dNbTVuL1lRNi9idEZINEw1WUFNeUhOK1pCeTVCZlEvNUFE?=
 =?utf-8?B?UGZYdXJUWjRIUitqVDlQTU9UTWZNWXVKc0VyaXF1UUMrR2FWaStUWWsvQUZY?=
 =?utf-8?B?azRvMEtFR1lnaTYvRmVRTkl1dnhvMExNVG5qaDBmT0tVTTM4MG5DcFFRWkU4?=
 =?utf-8?B?V3FIZFFJNmlYeXlOd0ZrRHNRSGxjQ3NrUUhNT2hqMUhhRjVSRGJyck9lelB1?=
 =?utf-8?B?N1ZEWHpPLyt1YkROSHNVSzdjK00ycUszbEJZWWE2akhWeS9lc2tIUG9mYXlk?=
 =?utf-8?B?eStYMkh1bUgyWGlLYStUN3VmTFlEQXcxanhlSHBoUlBIanlwOUp0bmRtNTVw?=
 =?utf-8?B?UjlJeVJ4V0dDakpReGZtQkxmbnkxY1ZLNFgyZno4bnNSblZIRTFIZTJUVTlu?=
 =?utf-8?B?ZFMzb3FmSE9UR1RGWVg0VXArWWRkM2h6bUUwT1RPREt0SkkvRU5FMVVlbHJn?=
 =?utf-8?B?Z2hudmNybVRrL3ZRN3RUaVE4SWVKcEcwVy94SnBiRmNvazEwNlBvUWRBYks2?=
 =?utf-8?B?VGppS2ZMenhuT3VYaFB1MTVGVDRMaXFQQVg4Q2FjaURsai9JbGwxVmhnSjBB?=
 =?utf-8?B?Q2cwL2lmN1FpS2xPT1pMV0ZRbXo2QU9zblpEVnNObGlIUTR6a1NMZGxFa1ZX?=
 =?utf-8?B?WFhXKzlzeW5IclJzWDFSVURxTm5vQXNrd0JYZEZFcTUxYnowNG11RVVnKzda?=
 =?utf-8?B?bG5LSUwxSGYzdHlhKzNYSzhiVmYrNUpLT3d2NTlEUFIzazBMRlNVTkZEYSth?=
 =?utf-8?B?d3J2bFpwRUt1S0xNMnNHQUNucmRacUpvU3c4ZFlWd0hrRS8rOVUwNGJmSlE2?=
 =?utf-8?B?Y1ExeUo3cWdHRFRSd3l6YjIxeWd4WFRnQlcxL2hVNHJBbUFrOUw2eS9ncGVu?=
 =?utf-8?B?eXM3SFZpUllONGswYi9JTGlva1RiY1hjYk1qVU1yVHI2ek5SSkp5dk93OU9s?=
 =?utf-8?B?MG9QNUFMZVZ4ZjR2dWo3RzE4VnJ6dmxheW84amJOT21SL3RJMG84LzJKWnVE?=
 =?utf-8?B?VmpXMVB2QVgvTDNvdmpKdWRkd1FkYVBiNXExNHYzVHlnREFIVEhFMWxWVFVZ?=
 =?utf-8?B?N3l6TkEyN0V2cmRZOGZxbThrRURDYjY1eGlSTlcvWUNtQ0tpODV3RExweW1h?=
 =?utf-8?B?MHJIdmtUb1RRNW1GR21QTkFVakg1RTJScWRKUnl4eTNxNm44dTZUK0NuSVZh?=
 =?utf-8?B?NjI2TjBzckNVMC8wckZ5aDdqU0IrS0VYUlQ2TVVBY203bTR5dzRVdjFYZWEz?=
 =?utf-8?B?N3VtWnFEcDNaSmdMaUdBWVNEczZBV2ZxbDliZEE4MVNqSjU3VGVlL1B4VjFJ?=
 =?utf-8?B?cTdLeEMwUHpISXdkZ3NDSkRhcEQ5cTFQNHNDKzVROVlwcnlKMDJvZVhzeWpN?=
 =?utf-8?B?SDZpc1phdUxaeXZKRTBOYmZwQUk5YnZqaWVveGxZY3hPQkN1ZkxQQmppSzYz?=
 =?utf-8?B?YlRjT0FReE44TmlRRlA5Uk5CZW1vdGttL1NjQW5UOGVaaDVwUmlJYlVNY3FX?=
 =?utf-8?B?YnV6V1ordmFqOTRqY0IzNjBFTlRUM0p5WWZLVXV0TnBJNUxacStZYTNrd3VO?=
 =?utf-8?Q?mOOsT+1gNrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JYZk9pVEZaT0RFa2ZpWVRCQjNuK2hwV01qeTdhUHZRTGM1ay9FSW5BSk9y?=
 =?utf-8?B?ZTBza2IzYUtrY3grc1Rra3pWTjZ5TWtxbUFjRzhuakc2dzQxRlFpWVN6Y3VS?=
 =?utf-8?B?QStVQmh4a25IWTVkWUdLQldxU1BUK1NUSSs2ZGVXeGlTQlhLWURXMUVFV1pi?=
 =?utf-8?B?NGZneUUxTE5KOEZpSHpPcWJIdUhhUmMwNGVyMVI0dWF3aGd3RlFtY1hvVnlN?=
 =?utf-8?B?WSsvUFh4ZVFJNnZlOUlza0t6QW1BUjlmcEo0WElNN3RqWUVNaUtrQWIxZzNF?=
 =?utf-8?B?Zk1GazJsdzh6bmNCcVo1eFVxclF2OXNGWTRHZ21NNENySXE2dU02TUhYcVlz?=
 =?utf-8?B?MmhwL0M0RGdObWppeUJWbS82cFhwZzZiNDJGNWhZRDJpZlhSV2lmZnpmd0Yz?=
 =?utf-8?B?TDFmSzdkaFczZkdvMWtpbTNWNWUxOTkwb01aL0I4M0dmNldaaWtKekZ3R0N6?=
 =?utf-8?B?N2xyUTFwZngyY2IwYVZKTnRHZEViS09aaFJML2c3RlhtU3RuZXBjb0VTSTV2?=
 =?utf-8?B?am4vbDhibGljaHNuemZOZG40cElKV0FNL0dBZGJCZHNrbGt0MkJpbWtHQW9X?=
 =?utf-8?B?RmtpWXVRU2t1enBWSU5iZzlsYnorSHE4Wm5VZDZiVDlEeG1qVFBoVVUxNzZ1?=
 =?utf-8?B?YnRYa1FoK2krQkVvWHJXRVRtdVduL3R0dGs1VFR3R1Y0THhYSDJ5MlBUNS8x?=
 =?utf-8?B?YmpWK1VuSG5lSUZCRGJlM1NQYk5PanRZM0ZTNFlQQXd2YUhjM0dWd29PQURh?=
 =?utf-8?B?cEhlUzB2WkRqMXZ2U1dCcEFhcVFoUENubnpMbGk2STQvM2VmUlNiM1FwWFVh?=
 =?utf-8?B?VEdZdnRxRVFFazZiMGJMYy9QUTk3REtVSnhwbitmQ09vb2R4WEV5OStGTDdK?=
 =?utf-8?B?ZGJtQ0xybEp0MngxNTJwSStvNm1aV2EvU29zVGV1OXgxQTQwaVIrRkpPWm5a?=
 =?utf-8?B?U0N2UEFOQkYyTlVoMXh5eDhFZFhDaHVxeEdNUjBraUw5SWN4T2NTMFhBOVho?=
 =?utf-8?B?eEpYR0ErVWlnczZ5dTlKalVzYnB1UVhrci9ONDFIY092WXpXeDJxWUpHbHpO?=
 =?utf-8?B?amZuQ2lodjhZcVlqS2dpL28rcXM2YkVtcVEyUnp6TlhBbmd1aWdFUG1xUGVQ?=
 =?utf-8?B?L0ZxczNWRWNDbEp4R0k1YXNjVUFaUVJoWGR0dW9PTmtiWG9TdkNyWnhqeDJU?=
 =?utf-8?B?c2YwTjRsSUlsQjRuNlZaWllvc1JWTFBpMURFbXZVRWFQRDVFdFVqSnVjT1F4?=
 =?utf-8?B?Wjc3NE42eGNRVVYyQmM1NUpzbGZ4dGtlNnRmbTZrY1FkVTF0QkpiUDFRdEtz?=
 =?utf-8?B?aXBTVSt6K1NLejIxYllScFBmWWNERjFlYU9KeTdRUkNCOWRZY1Nwa0NJMHZt?=
 =?utf-8?B?RnBxeWJEQldZbGJOQUhCNitjMUlSRmlFUmVtZEZqL3Zobk9mS21xTGs5RDN0?=
 =?utf-8?B?MVY5bHFLRU1XY054VGZMS1hQRmFKeGhpeXdhb1NTazNQS3I1RmJ2VjBTTFZI?=
 =?utf-8?B?Q0pxSVg4TXdTTGJkRElQcWFXaU1UWjdzY2hSOS9adVJ2MWVkUmNGR0ljZk43?=
 =?utf-8?B?M1JzVEk0WkRGaGpFWHBwRTlyVnhuMllIWWxxbWp3MnZQbkRva1daOTRhWmhE?=
 =?utf-8?B?K2lEUVhLc1JUbWc3bzJEQWxsVE9GZ1pYN1ZXZlU0S1duSlh2OWRXK1lyQm45?=
 =?utf-8?B?K21XdHR1WGJHUG1ETzBOR1pYcDc3MHdQU051b1RST1JCTkpRYXQwQUI4TlJO?=
 =?utf-8?B?S0tJTDJRR0FpczlVekZYVXV5YytHMkl2ZndETGxMZC9teDJTdDJVdE9Zb1V0?=
 =?utf-8?B?QXRRVmhXTW1LbDN2YVU5R0pjNElWVHBZZnRNNm9Zc0crekg2dVJYejU2U3Iv?=
 =?utf-8?B?czNiTmprZXI4YituNVZVY1FpWFJoQ0pObll1RDBZekxWODM3dHVHZy9NV283?=
 =?utf-8?B?ZVMzVmc1Y1JwRVoycVQralcrc0duUk1uejVCYzR3di9FdFRseXpQVU56dVJj?=
 =?utf-8?B?YU5IRVNwVUVzOVhpV0s4Szc5VG1Kd2FzS2lZaEJKRnhONk9EbzJVRVZxaFAx?=
 =?utf-8?B?eU5idGtjcnFuR2J4Y1VPa2hPQUlsLzBWb2k3ZW5JOEQvUnNyZDBkV1FBMEpB?=
 =?utf-8?B?SWxrd0VqL1JYQkNsRzVGNFBxYXR6RHRoUUZVWER1R3hyYnIwNGJHNFlEeEMy?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986f4e29-f5e3-49a6-2abd-08dd9ee9d3e4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 19:48:47.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7kawFJEF+A7JxmKQvl9RmcEASPAzMZexTFOufHPiMIaUV3cROSEhUCC8PF+jPSyYKt2Dps4S9cGDxyUibCxq462/9ZsPOqYNCGFjnfZFoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7157
X-Authority-Analysis: v=2.4 cv=WpErMcfv c=1 sm=1 tr=0 ts=6838ba23 cx=c_pps a=ctj7NoW0B2AnaS6DRTfWnw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=m_29cCSwlVzsQKok-24A:9 a=QEXdDO2ut3YA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MyBTYWx0ZWRfXw84V966ekt4r FpLWcTonsiKshpkAJ3Zug4ffk0vjjJWKeRiEiazun6LXBPePV0QvdgZW8blFM2dOC8T9mbUMzxZ hjUbTUWNuN4Vc39yxodpphFbWlbBa3VF2rUMXZj+QQI9RdLJsYieJLnvhAUYOtCMQWJnwQr+BF4
 qZ0D5aFK2O6g9UMGkkrNtRkaFUXOoKjuIKzYkOm0piKXIz6lEyPCNkTrZqdLYb8FVGIa5al8U1t sBq13tw4b2X+hd5iKSWmGuZHRndhlSMasNkNOlfutZDO8V0PYeCkNPaYn4z2Izld4jPzLA6ruNC vbzGfDYa/atUydRsiHjko5tEplrl1FZHmL4DkDm177+Qrnzp4F0Bugv2pq4dVl0eY3euRcB9ZVU
 SNb51Xeam2RIgE5//mJJ3+ajxdrMOyn8OdwOnWYarTJwN6IzDaDBAW1nSiOQZDLppVdrfRBs
X-Proofpoint-ORIG-GUID: ntX9SwGNby_X1zIIPk1RTqiWGe3jKZvI
X-Proofpoint-GUID: ntX9SwGNby_X1zIIPk1RTqiWGe3jKZvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=669 clxscore=1011
 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505290193

Hi everyone,

Looking at 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html 
there are a number of criteria for patches to -stable releases.

However, there is no mention of preserving the stability of internal 
kernel ABIs and/or APIs.

Do successive patch releases of -stable kernels provide any guarantees 
that they will not change ABIs and/or APIs, remove functionality, change 
behaviour, etc.?   For example, would a -stable commit be allowed to 
make a change that would break an out-of-tree (but open-source) device 
driver if that's the only way to fix a bug?

I know that during the development of new major/minor versions 
developers are free to break ABIs and APIs at will as long as they fix 
up all the in-tree code.  Does that still hold true for -stable commits 
or do things get more restrictive?

Thanks,
Chris

