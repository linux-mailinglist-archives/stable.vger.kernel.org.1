Return-Path: <stable+bounces-192882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3EC44BD1
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 02:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A70D3B10DA
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300820FA81;
	Mon, 10 Nov 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZ9DZJzM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q1XoikXo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1E34D389
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738488; cv=fail; b=psRzEJi2tIdtGdPAYxAeDA62g0a6Iy7UbT6ysFMT+pN2ES5tf0MU9sF6A7KSsyzHJ2Vzxz2Z2n/UGdVHQnIM97E8wGViucOrELjyix6QSECs+yWhPqU36AhdeZrIKqgaOYzuV5JS0vjtYuwTzC/rO6Le4qu2xpJ625hkqJPDTp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738488; c=relaxed/simple;
	bh=PGietY3rDiHbG+C4GgAsFJ7ystdFbHR86f4KO33eQC0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRtZwW6Z1beEolRo97qxteOjsJRr8IgTPPR/rdUuiPwLa0JwFAZQSMFuaWI3WW8edduS1GuWealvXdzyhgeYbd1uYYH/IAODKuooNNwtWHLAZpQ0cTRCVnFtALJMw6XJaeesro3SdtuQZsdtWIwYe9l0LKlckSgmvIGV6oucHJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PZ9DZJzM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q1XoikXo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA01xSk002470;
	Mon, 10 Nov 2025 01:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PGietY3rDiHbG+C4GgAsFJ7ystdFbHR86f4KO33eQC0=; b=
	PZ9DZJzMq1vvyD1Mxzk5PjdWP/N6IXVH0TdhhHGi9t2p5j/qDnFKWrm+F8i6hRF3
	IkhNE7dLL5meYCqllhSFDjOAPyxKRMqhBquTm02Vs1ffoHhlUU07rCL2S7IdHs7Y
	PH20JT0lQuBJN6tqucUUfN7nXUe5BcevhERCrCBIf4HjjAIuzas1+TPx4NU9kWEM
	bZWy2tXzFvW/HKnJ3fq9be1iBlNq9pHlh0J71HSYmSlQRIcjoobAMhxtwOdDV9cn
	xChB1JCltvwKt7KHq3CT64HUPRFBNTJqaOKIgzOLKi6qFxviibzyo0JjjMMqeAkp
	yILHLVZbIjREYXIu84ADtQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ab39vg64g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 01:34:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA10ZJa020284;
	Mon, 10 Nov 2025 01:34:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va7hbfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 01:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO5yqjt4xdruy15Uq8nd+3yO8W7LqwaJA0Usz+i8khyxaXEYWnkOdFoJyhd7OI0ul9YyhCoKIjZCq/bRq5BuoTBWceL6wVxyvDovu5yjgKX3i3YF1/tsKAQEqflq7N/5aoZor3wR8rJPCAztZei3ok6er4p93wPRXuBbkbfdubBJ9ztWRqjKq25SXfs2ns03sgyAWcnvqIH9bpBVjr2Azq4O9mx9XfgvmLXwj54y3JNUBrwvIaeIBnBPrvOgX8rfyn6tgoh5dR+WYN1QVwHjduprdEbCzpoaLf6bmQiCBa2RJ/CWauI14fG50WhtvGkQfy52YV4Cfn7S0Kw1vm7usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGietY3rDiHbG+C4GgAsFJ7ystdFbHR86f4KO33eQC0=;
 b=BGe910XhXkM5bK8rxr3Yg31Ba2D1VAJx43j1+WO2Rg5PC2cbFl5RN/e6bbxP3CFqcve5LUjR/WC7LGzDVhWc3rS3TWp7k0GBShybXGPBXCX+ksDhaepyjA8qEQxzMn7XYTQ2zxUxNgraBK1tR06t7RzPE62Wtg+TzhcvnprEbkFAIpeyWBjr5vAGHPswllTnwI0kVF7mKkiW55+L/PGCNscdZrVxXrQpAo/3BQ9N4OZRdMWdDqysZhbGpT1N7gUvuwcG8PYXhfMPAyUD66g/8ID3Ku5TC9yWzCMpscjTfpi1uNTKrdUqR6kePShZSVLfeYfK3CJPohStK8ye9VYHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGietY3rDiHbG+C4GgAsFJ7ystdFbHR86f4KO33eQC0=;
 b=q1XoikXoDeDvyavI1WDT9UgfHPe9Rd1UDST3J33xYT5XbCkEN32GXyhtepAZFZQKlRH0gqRZkJvAMYwK4yTZyJiSAkeJ45N9gCF+UT9mwXewPF6NXGZrZ9rFaFDgB7r3oPuE15F8y6wKyrKaiMOZtDJeXk8fpJHqsXgsFLESF84=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7137.namprd10.prod.outlook.com (2603:10b6:610:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 01:34:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 01:34:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: NeilBrown <neil@brown.name>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Thread-Topic: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Thread-Index: AQHcUcJB/OQ5De0J30iW654xhNyjHbTrF2kAgAAJcYk=
Date: Mon, 10 Nov 2025 01:34:41 +0000
Message-ID: <13CE7B6A-3A1E-4C79-AAED-E1DA9469872F@oracle.com>
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
 <17e85980-9af9-4320-88d1-fa0c9a7220b1@oracle.com>
In-Reply-To: <17e85980-9af9-4320-88d1-fa0c9a7220b1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7137:EE_
x-ms-office365-filtering-correlation-id: c9dfd28a-dd08-4977-6008-08de1ff951ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0lJVjJYV0hUQjNUbHNkV2cwWk1IcmNPK2EvOVZlUVA3MldlYnlKN0pCS1ZG?=
 =?utf-8?B?ekVEbGorb0pqWERkRVcvWC9venBEeTJSU0RwcmloQWNXWlFGUFR1N1ZBMlpM?=
 =?utf-8?B?UXBwZjNPb0g4cnJ5U09EN2Y1dnFLcmFHbWVhV1RnZmJtUDJFMUhObGRwSG1n?=
 =?utf-8?B?WVpwVXdOdjUya1g2bnZrQ0poZTBkbG9ndnFwRllYRHk5VzNKcWFrVE1qZGIv?=
 =?utf-8?B?cFNCUFZlQzlNaG93QXRjVGtGZ2xZa1RNdGFrYU81RGxJTzFJSURqYm03bTVo?=
 =?utf-8?B?YjNLNVlGQXFTVHg5U3VtalBrN0RuOFdERSsvUlBXZWdCMjZIMzdZYmIydmFh?=
 =?utf-8?B?aFZ6Vmt5VWxBNUVYa1loK1pkV2RFaDBpdk9lOHRqcWc5eW1HY1BFSzhQUmx1?=
 =?utf-8?B?Nk1IWGVYbCtPN1plTEo4MlJBSnAzWDErZ3ZKa2ZQdFRvcmVPSHNxV1YwMFEy?=
 =?utf-8?B?bVQ5cTJXUVJPRk9aQ3ZqeWNpeDl5eStZdXFVMWdXemdmU3lwNEVnaWhzaEN5?=
 =?utf-8?B?RGxBV2FqcFMxTXRFT1RVMU9pR2Z2QjUzeWNNaTRoN1UzbEt4ZUgvS2ZpMGRG?=
 =?utf-8?B?Y2ZrQUJaaHVLOURiOTg1aldOTHNhSElBTWgvcFZrU3RLOWluZ0lLZEtRMko4?=
 =?utf-8?B?MVFic1ExL0dHb2xsMmZWWGM2S1FpdzhOT0xuY2RXdUlCOExXaG82Z0M3TEtX?=
 =?utf-8?B?S2V6c1pidlZBMms5c3Y0eUU1RXowTFpTa3RsTytCVExIQkF1NTFJczJxa0pN?=
 =?utf-8?B?WUVQbFJCcHlpbWNWeDZzUEtSdTE4bWNWZzFEZmFncmU2MFNHdVhGN0JaUklj?=
 =?utf-8?B?dE0zaWxOd2UyZkFleFpMS0toMkc2d2NBTzlYczdlaDlMWVcrSEdtN1RySFFO?=
 =?utf-8?B?SGRUQ2VhWEVXTXM0Wk9vbEpja1BmZjErSURIaWJCbW9TaEU5U3VDWVNFcU52?=
 =?utf-8?B?T0JoeWxQcXMybkJMMm1Eb1RQVjl1L3NEV003ekJpR2lKbmtsV09XWkRmcytZ?=
 =?utf-8?B?UXVVOEpFSVhScC9PcENzVzN2RkI5bFdFTm5GTjJpekdUVGd6VjIzL0F1M2FF?=
 =?utf-8?B?K3BBTVc3VS9uR2tMUHoyT2RYd0lPMXZWb2hRbXNyNGlwR0Fjci9RdTJRZUZq?=
 =?utf-8?B?YjJ2VUxLeXdiekJ6NDVJK0tkSEV4aFFiaUllVkNMdU0wd1p5cDJLSXlsTlRa?=
 =?utf-8?B?UVhKSHBGLzRTSkQwenV4UjdWeUFMV0JqRXBJNyttYUpLbmlxL241R3kveHd0?=
 =?utf-8?B?TlhuWDdlUFNDcDdkY2VuT0M0TzBWUzhOVlVSOTdEMHBtdUQyWmx5VHFlL1ZH?=
 =?utf-8?B?Z3diZGZ0SzRiQ3NOcHNBRS9pZUU0NUFwM1FVa2lIbUlkYUl3ZlE1cXB3bkZn?=
 =?utf-8?B?cjlVVldTbnZSWVUrSlRoU3VBLzNNdjJDVVVOOER1YzU1Zk9EbWwzNXpTZjBZ?=
 =?utf-8?B?Y2paRlBrVXFFcUoyakVRY0hUSklONzRyVVBXZFl5SnppWGhXMVc2a3RtRkVP?=
 =?utf-8?B?V0JZK2kvZURsQW93Z2xPWld0WTlIcmhDYjk1L0NGMTlJclhnV2hUbFJ5UVo2?=
 =?utf-8?B?MmRIcG9keWtrRU5uclFUbjZrcXJtZWRwWXpCa1lhOExka2hiUEVmQTFnVEFP?=
 =?utf-8?B?RldNRktTT0JIdmpLZjhMbytOVzJtdUFOREx2RG9xUXB6T1BmMUJoMzBTVXJX?=
 =?utf-8?B?QlhFc01BNm0wNHpaZEZpTmR2VlhOc2NITXowZVAxK3g3MFA1enJmN3FzVTJM?=
 =?utf-8?B?T3JCQU1WUEUwekQrMkNFcEQ2VldJc01xc0VjRDdscGdRWnBkWkdHVEhuL2Nm?=
 =?utf-8?B?MXd0OTdOQ2N0b0RHM1psZWRQRTdVVWdWR3NqcmI1OE0xTkxlRDNkMUlwby9w?=
 =?utf-8?B?d1BJYWhPdXdJMGcxNVE4TmlpRGtINFdyVFZQdWxKVnVwRHdPSXVmbkNHQ0ZT?=
 =?utf-8?B?UHBMMTk5bXM0WEpXL1Z4UUVucDVRSjFPWC9wUVBmVkhPQVhkYWhwNGpHT0lE?=
 =?utf-8?B?OUtLVGNWWUJCcXpQNW9ncllObWZaaVJucmZDRGhaTTlEUEUwbUZhODRZbksw?=
 =?utf-8?Q?15f6Xy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWFmMzlUYVFzWk5vYjF5NnNSWXdCMWlyTFVWNGtrUnBiQlAzQ1ZoWGYrdGF4?=
 =?utf-8?B?QXBTYzBUNzdTM0poUkp3RkRnTnJpSjI0ZDYrY1VKTFBQR3NQZEJZaXZiZ0hB?=
 =?utf-8?B?Q2RUUWtnMHlyemRLUXdZNFBiVVB5VjNwNituMFVnNkIwRGJvT3UvN3pYc3Jw?=
 =?utf-8?B?Q1ZrSS9ENjJIOWtEam1idmx3VVI0SWE3RTRWRUMxRlNRTnlJajc3OS9ubktU?=
 =?utf-8?B?bFJaaWRFRWpQbnJHSTljTVE3Wm9OV0ZxQ2luWVYrRC85UVgyU0J0WVovMDFx?=
 =?utf-8?B?Sng1OWdYdGtUdjhSSmZXU0xkSzRYRVBYY01LazJZbTFXbDFiT0NOV1J4Y2tT?=
 =?utf-8?B?YXFEWEJPNXNOaFdmNHVOUjhGZ3FpRFNvYVc3Wk1iZHBtcGUyUWhxRTROc21C?=
 =?utf-8?B?MkhXUHh0ekJWWnVYTkZ1MVBmK1dVR1Qvbmk0T1d1U1AxYkhZRU10YlVOdytD?=
 =?utf-8?B?UkJjblYrdDcvcThjMmdFclNqd2ZldWZIRHh1NC9uelhRaWN4TWEvSTFkZ0FI?=
 =?utf-8?B?YnRDR01QS1NkcTMvS3ZOa2c0Sndnalk4VnduMFZ3WVVITi8zV1BaZ01NRDlO?=
 =?utf-8?B?Um8xeExGdmR6VzN4UTVZL3VhWXR1YjBCTVVOdlR6MXFZaDNUUTlkTmZoTmtP?=
 =?utf-8?B?OU0zRkpuTUdrK1RFQkFlL3lWUHRUYW1maXpnRDB6Y0N1d0I1UjcwVzhZYmNF?=
 =?utf-8?B?WHlSL0JEc3NLM0pBdTd2dHpsMTVFVDJsV0RXWUpIWVZLTnE5Z0dOQmk4MThV?=
 =?utf-8?B?ODhJN3JyK3RHejBiemRnNXJKbmV5YlBPTVNFZlNramtwVDF4dnFuMDBBSldR?=
 =?utf-8?B?cXo0R1p6TnVISmRTcXltV2hsTnRsakUrOEM1Smx5ak54eHZCSGxQTkJ5RnJZ?=
 =?utf-8?B?d1RYWDd6YnpOcjRuMEdHNGRaQ1lOeGI0eGEzclVXT3ZNNmRpS0d1enUwaFpt?=
 =?utf-8?B?MHFvSFUwWW12VkpDSWZ1UE9pSk8xSXFPVlBQWTFtYVZLbkFVY2ZsSEd2Ukdx?=
 =?utf-8?B?VmJkZlo4eUxlRURVdnNDV0h0VEVVUjFTa3hLd3NKTmFJQnpPMW91N29sUHVY?=
 =?utf-8?B?TFNORFFDajBwZGVMQXpKdnFIajlabEM3MmtQcXhYREZkOHVPakdoeUJmNFpu?=
 =?utf-8?B?YU5SYXZJZ3JKcTNaZXZnMUhYMkR3TmY2Q2ttbTVOeElZb0drSVZZdkFuZVo1?=
 =?utf-8?B?QjZyRDBJcDAzamU0VlduSERMR1VjSnk3bEdwaWJkcjBERUk2RzRhTTJ4Y3pC?=
 =?utf-8?B?elhCc09RVHZ3Z3JWM2wyRUVUZEdWNmM2TXNnYjNBOFpTYjBMZnRtRDZmOUZr?=
 =?utf-8?B?N1V3aVpsbXNoZFJFZzJHV0dEeXRBTzg4VERGVlI2ckg5ZGl2c0lVTkF4UVZQ?=
 =?utf-8?B?Wmx0d1ZON0I5dDhLZTlvMHlmSDFJeFpNalhxUVYwUStNNG9mZkFHQ29DeFFv?=
 =?utf-8?B?RWtvVWRPT2haNG10cTdHVldXOUZsM3BwZHNTSUwzdDI5ZUN5SzE3ZEo5em1F?=
 =?utf-8?B?MlhkOWNnNlRwRmNOODV4amIxOWlXQ2FzaFpMd3d3MzlocERjYlcvK3pEWVM3?=
 =?utf-8?B?bXZQK2N0c2NEbXFaMHl2OEpYQ2hjN08yeGZNQmJiYW1Tb3BOd1hXWGdSVElI?=
 =?utf-8?B?cGlrTGk3ZnorZ0k2cUxRcy8yZXpRRlVmVEdTVmJhakhHQUgvY1NDVndMYmRB?=
 =?utf-8?B?UXhBVUlJb2xzV1NjalNvU09EYnY2YklJOGlkOWlvWjFOWlQ4NE9JclBkampO?=
 =?utf-8?B?TjlaSTV5SlVtVm5XSW9YTyt5cWdabmVHeXRXY1NyMUg4VWNkYTU5dTQ2ZFRj?=
 =?utf-8?B?STBFRk1HN3RFWnNlZXRzdTJHdkNvelAxUVUxMTI4NVE3SEt6U0FuZ3lmSDRt?=
 =?utf-8?B?V291bHVESEZkWlR5NVdvRndoRlE4MnVMejlXSjVEaXN6Q29xamFUUW1TV09X?=
 =?utf-8?B?MUI5czZsZXU5MGwzbVBzME54ZGFCZHZ2R2l5RDhIUFNQbklLdG9IUkM5LzFJ?=
 =?utf-8?B?Ulp0bjhnMi9vSVJBcUkzMVEveFdiWHYzNitxem1aUExwNGJGWlVZVStMYnFx?=
 =?utf-8?B?STFpU0swOGFqWVp4SHUxcWZJa01MUTlmeVpMOHRJSE1wNThDb0xYWlYxRzVP?=
 =?utf-8?Q?qAlmBqPGsBepKLy6NmvzfbyqM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Huo3Rp69Tcc5Nm+2c1xSbJCAbhQpl10QNw51/0HVNbU6zAjE7e/lpTXIes/PncwYQbOjRGsU3Qmtiw3oqMiZI5qsuOmHgDj9rWLX0uJm1o8coIgnXFSKOa+0t3iZGUH6eloxd9SUDFsB4xsUfzmk/mvBHnN7awXZ7LzOg8KNP4xsdeGmwJzQmIDG7qD85I02qr0a+OeiIPzZ1O31eIZg9ppod1h/1bJVUZwcsTYIPXyqkxFsiAxq+8/0WzmxoT72pwkmyfLdJYpucSt3sAe/UXuBGPtEd1W+03+5Xu8xI4BW6YaUpNJWW7ZNs91CNAW34g0MlkkCGW4lOVpl0IwMFCWzymtRyJXFpD4nxJ+BghBMWWpLeVSDQUhJS7E+/9M/WFa8gll7QrUD56sMIO/YOdlp3BLoBHG5GRhgULvLvlkfTze1XGsg5vzAU1wB5Wr2IW/9QtOd9J7ySZL4/TPk8J9ugEgjW03NhoxG9owVvWmwpin7JAQwwHLfwh5lVPn/y3ibfVJbwWXq+dyG6rczWjGEIKzMtp1Omc72+zbJZW5QQkliwYTm3O2maQUUgdsBVs+ZbxyLaPKWvIc8jMndPAnDnx0rgdLEXehJwbhYqWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dfd28a-dd08-4977-6008-08de1ff951ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 01:34:41.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYmaVhpwzbJmdNoBoR4ctetMrnWArseVKN5yBlVWVrW6NNem/OyD46tEsbD9ZqgKtQkercNe4m0ru7SZp2TBhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_10,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100012
X-Proofpoint-ORIG-GUID: G3zkDKV6MojDHgEK42VHsup-rRiovxhp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5NiBTYWx0ZWRfX4tggsWN0XtpK
 6F2Zk7f+2dX7QJV7SyioQ7Y4TaCbpRq7I2ZivbP98+YkISKU+blAmE7uuyO99BqIOhpSyhwWmAB
 bFoJWri21xUiow91atLA5sCnp7MvqgRiGBnYROfZkroksrChKod0sDuVIyxmeIX4ypE/tAMEvby
 d5eLu22N8iJXZkjVr0UOjYMf9RuleaNE9qVZ7or+WGtUygwcm4ND21+94n3To9VmW4sQmsjxE0k
 qCT/lU07dr6z+1nOzNuGpgCJszhAW/owqmsXWND3g/Atx+4zn7yxZIhqirhcar9Ee3r9PC2FNbm
 IAdX7fcjma76Q0GVCuz19a5LZAlOd68IQ/qIpGWDVtzCR/6h7cDM5VWK2rFmBO48SMz3dOU58LN
 chFxfDD5jtYuwVSmhs3dNZk2Ea/V5w==
X-Authority-Analysis: v=2.4 cv=A/Nh/qWG c=1 sm=1 tr=0 ts=69114135 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=yY04rvkgPePB3f1cVIQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: G3zkDKV6MojDHgEK42VHsup-rRiovxhp

DQo+IE9uIE5vdiA5LCAyMDI1LCBhdCA4OjAx4oCvUE0sIENodWNrIExldmVyIDxjaHVjay5sZXZl
ckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiBBIHJlY2VudCBjaGFuZ2UgdG8gY2xhbXBfdCgp
IGluIDYuMS55IGNhdXNlZCBmcy9uZnNkL25mczRzdGF0ZS5jIHRvIGZhaWwNCj4+IHRvIGNvbXBp
bGUgd2l0aCBnY2MtOS4NCj4gDQo+IEkgaGF2ZSBhIGNvbW1lbnQgb24gbWVyZ2UgcHJvY2VzczoN
Cj4gDQo+IFJlcG9ydGVkIG9uIDYuMS55LCBidXQgbWlnaHQgYmUgcHJlc2VudCBpbiBvdGhlciBM
VFMgcmVsZWFzZXMsIHNpbmNlDQo+IDIwMzBjYTU2MGM1ZiBleGlzdHMgaW4gZXZlcnkgTFRTIGtl
cm5lbCBzaW5jZSB2NS40LnkuDQo+IA0KPiBBdCBsZWFzdCwgbXkgdW5kZXJzdGFuZGluZyBvZiB0
aGUgc3RhYmxlIHJ1bGVzIGlzIHRoYXQgdGhleSBwcmVmZXIgdGhpcw0KPiBraW5kIG9mIHBhdGNo
IGJlIGFwcGxpZWQgdG8gYWxsIHJlbGV2YW50IExUUyBrZXJuZWxzLiBJIHN0cm9uZ2x5IHByZWZl
cg0KPiB0aGF0IE5GU0QgZXhwZXJ0cyByZXZpZXcgYW5kIHRlc3QgdGhpcyBjaGFuZ2UgL2JlZm9y
ZS8gaXQgaXMgbWVyZ2VkLA0KDQpPZiBjb3Vyc2UsIEkgY291bnQgeW91IGFtb25nIHNhaWQgZXhw
ZXJ0cy4gSSBqdXN0IHdhbnQgdG8gZ2V0IHRoaXMNCmNoYW5nZSBpbiBmcm9udCBvZiB0aGUgTkZT
IGNvbW11bml0eSwgYmVjYXVzZSwgYXMgSSBzYWlkLCB3ZSBnZXQNCm5vIG5vcm1hbCB1cHN0cmVh
bSBtZXJnZSBwcm9jZXNzIGhlcmUuDQoNCg0K

