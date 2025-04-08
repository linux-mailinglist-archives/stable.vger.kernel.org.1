Return-Path: <stable+bounces-128874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F8CA7FA47
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D543174138
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6B26562E;
	Tue,  8 Apr 2025 09:50:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174F264F99
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105827; cv=fail; b=Hhkzel4PlBD6reAbcLb+kqt/bcceVhbVYhTV7LCj0lpWTvE/uy3Wca/+KrDk9xJ5dDqGWJgz8hi63puRzDS2KpHyV4dDqsXTakF1XiG9PFai9elhRktJvhmXXxAJVVpR7fQ0xtvI+LggljQEriTRz+5nWYb6YMMveHdFEBHFoM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105827; c=relaxed/simple;
	bh=7MUjgr+KUA3rqt5au8shr014tgQYNly4PUf9dbc3U5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fvzwFrx4VBleyO1cWhbY1AvfRocAgXAHGYvGuoXKUvtNpeGr9oIsMamW3BGwibaYDcDa7UuKfKFCxafx0N8tckmpWcI/1eoMdqT0oCWghQQ0ZruEs09zBcNKbENNsDDwGFsTb+nYZAHfwKhXH3x3VIMZUolEHgoWxzPcu+m7SLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5386uWYF007346;
	Tue, 8 Apr 2025 02:50:19 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4bck4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 02:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNuKS5kZaK651DdGIiv5S6kV1TSSirSTu8zql202E5l+N5udBDy67rU+S3nd3Ohm77dtE358cNxISCe2+KGnNhAMt1KhOAI2HtOXoVKShZWhzC4zo3Kry9LzCw6YPsnl+fHt3/rnAVWEjpCZTDCx/qbibW7ijy19mrk/sJc2KdeGJuWpC1a8Oi6HuIb5h8oVUPvVW8ZsSfxdn3KLQwFaiAoMdQEfJlRZCGm/MLORBr++NCo1IcMybt2mk3zUnR6dkRTCNMKFquYSG6y1JZYgurZvNc4JoHa49L8ccuQnuF3T6A11aqrqj0mYpbR/S9q+w55IPBgF0eENzFxR3ZO0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEfamn4I9o0x6IspxjnF8X0tLKkbn2ijdKSgq33Djv4=;
 b=jtakF0fCMbo1p6/sZuvhPOJD0XgMh1/479l3FPqaOAwKWy4klR6qPgpZKFcRTLwDgNSe/ZFXeqinUUWej6GV3ZUlZzdzv31o+eYpILeBYhhU13dBpOwdIGjs8zIGYKXOCvn03A67PVYf9Jx26R4ZvFirG8+d5KE+JwVY2NYbch165KhWzYxmyavQo7hhzuccM4mw2RjuZrFzhMjS51ym0ZRc+WI5PwtW5jN70Avi5DmBnCkFK0MiMWb54vAY5rN+miQM8rxh7U71F/3R3uJWavesZubTT3D88RmWCfHsfQJ98oS4hjUbOrPxNqOp613MJnsrnfSw0tbQ/voT0pYAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 09:50:16 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::d284:42a6:74bb:5242]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::d284:42a6:74bb:5242%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 09:50:13 +0000
Message-ID: <b1b8807d-f699-4108-94c1-aa89df62aadb@windriver.com>
Date: Tue, 8 Apr 2025 17:50:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org, wenlin.kang@windriver.com
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
 <2025040344-coma-strict-4e8f@gregkh>
 <17b170ac-aa20-4c36-a045-25d2f82e66d0@windriver.com>
 <2025040819-unabashed-maximum-8fc8@gregkh>
Content-Language: en-US
From: Wenlin Kang <wenlin.kang@windriver.com>
In-Reply-To: <2025040819-unabashed-maximum-8fc8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To CY5PR11MB6318.namprd11.prod.outlook.com
 (2603:10b6:930:3e::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6318:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f682a8-01e0-41d8-5dc2-08dd7682c269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STIzb0R5bFpFc0lwOVBsTFZFM2M5LzNVRXowRHd3WUFEUk1hem1lVERwT3Fx?=
 =?utf-8?B?R0FDc05pUEYyaThOQzU3am1HRTVsYWVhbVl1M2VmbDQvT2ZSd0paV3l3bW9W?=
 =?utf-8?B?N0ZsUkFJcTl0emRGbEZZQWFGNE5YSGFOb3U3cTc4WTNJSlIzcG1OdFJHN25h?=
 =?utf-8?B?SEFuNlFKN1pqSENuNnF3MVhDOVR1K0R5RDgxSTltSHlOcFJ5NjdQSmNoQi93?=
 =?utf-8?B?V2dJeTFpbWhaem5EZFNoSjFWK0E0VEl5dnljWUxPeDA2ejdhWXZEdWNIMzYv?=
 =?utf-8?B?NXc5OHduOEtVb2R0dElzejVDclIvRDlvVDlkUEJRaVBINENPcDdIMWFSdUJ2?=
 =?utf-8?B?amZaS1FVQjdsb2IzN0l3MDMybkU2RWpBdzE5VUJ4K2piTXd5aHFuK0tyaFV5?=
 =?utf-8?B?Y1c3eXNFMWV4S2NiYmF4NkpKV1dRUlQ2M2pqZ1E3WTNCMyswdXJMSi9FUkcz?=
 =?utf-8?B?Q3lvVjd0bEwrV29QTmJsUkxITjA1OThKTFFwYXFIY2tjckE3MEVBT0dKZHRE?=
 =?utf-8?B?SXpxNi9keXJlN1Y4ajZ0NzQrZjkxTENvdEFlelN1Nm42bmo1SytrSmJreUJY?=
 =?utf-8?B?ZC9xckpYSzJTSTU3d0JYVW5WblMxd0FkMEdVK1BVU251Yy9iWXpYRmZwUVhF?=
 =?utf-8?B?V2JxRGFhOXY3eGVXMnY4RHRmZCtSRUljSEl3SU03UFNpV05CcmM5ZlNzVEJs?=
 =?utf-8?B?Y0FhdVZYd1BrdThVSGJPT05kSXRZQUlyemkvS0ZkUitEVjdMbjR2WEttUmEy?=
 =?utf-8?B?bmJGNzhUMjdWcDZBVTNNeUhnMExjdk43cHlGdVNGOEMzM3JzOWxrMy96YmpY?=
 =?utf-8?B?a2ZGN0F4UFF6bU1jMDR1eTR1VURSV2VqZTBQMXV1NWFobDcwYklkcnIzVGxP?=
 =?utf-8?B?NWpJMlNyKzg5SEdiMkNOL3JMSFhrc3VRcmJlbVdsaWRVcytzcFR1ZUdzcFp0?=
 =?utf-8?B?a2gvd3pvVm1CM240bnpqWHhiLzVzS2NnMlNhanFKR0lXWGN5bG9EZ2MyaFBy?=
 =?utf-8?B?TDIxQjhsSnMxemU1SWJyYUZsRjRHRFhMbDJ1aExrWVdtb0dsOHA3TlBEc2kz?=
 =?utf-8?B?cXFpVHJMOElaTmhQeUsxUVZJUlF2MjR4VjJYOURGb2tjd0xXVzIxVzlwMXh3?=
 =?utf-8?B?c1YybGg5RGpIM25IVlc4ekg3eEswTll4RTdOaUFZeVVLTHl0RU1iOTF0VEpj?=
 =?utf-8?B?Q1pEN2dIWXMvaTI2Y094QkpLM1NWdTJTUTFTczBLbDNnckJ6aE5qQ2RjR3U1?=
 =?utf-8?B?bXphczdoYTE5SC9SK1VXRFZjNWZuNURaZUJobC9ueUREU29vN2tCOFBtdmt6?=
 =?utf-8?B?SnZuVVRpbG9NYjJNbkRnam5KakpQNUxRaFJ5clpVdkpmUzJXUGltQUlsSDdv?=
 =?utf-8?B?ZXFubjV4UW11Qkw0MWV5ZVduc1pTZ0VPcGc3K1hPcTVmVHkyZ2JVc2xVaGNl?=
 =?utf-8?B?OFBTN2JNTWlCRGRRQWRGa1FIN2c3VWJVNzhaaUxzWEtya2h5eTNyaERHYlB0?=
 =?utf-8?B?aG5JcXIzVnJjTmo4TStBRit6LzFkNHJXTjlIYjJFRWtqRndJVGIrbithSjNq?=
 =?utf-8?B?VTRCaUtYemZHRFB6endncWNwVm5RS1FueDRTYzhGUGN1T0xpSFpxSFVUN25N?=
 =?utf-8?B?TENwZUFuU2tzOXFEOHlOcVVmdmZLYlFzMXJwN1g1NXd3ZFNzTWJzUzU3NENs?=
 =?utf-8?B?WHRQZ2x3TkdRTEhrbUhYV05CQzZHM1BOc24xUDJkM2x3MEdQYXNNWUdpc1Zh?=
 =?utf-8?B?ekNKVE00SHJyNytBUzMxSjYvUTdyb2YzeCsweEQ3NkcrWU9EaEF1emxEV3J0?=
 =?utf-8?B?ajh5QUJZN1NtMFc4bEl2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6318.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGJTZFBPRjR1aWVBZTZnTlVaM010WFlKRytoYWNWaTNjLzBCd0pSN0lDVWlE?=
 =?utf-8?B?cDJUWFBNcW9KOVRsVmp1MUo2Nm5zK05PQVRVMVpxcmowL0RjU2hkTElUU2JC?=
 =?utf-8?B?QWFtcC84YzBTZ2hCeXM3Qngwai9UQ3YzQS95b2JTbEhqazdTekpiME9IQ3px?=
 =?utf-8?B?VXV6OExnZVpHSzdpUTJXQm11RldaSitXQ04vdTJjb2pRNE5aQkRFMWtvL244?=
 =?utf-8?B?RnVlRXdBSU92N2xGRmNiODFnTHZPWWl5MEpmaEcwZW85czNyZ0VQbEZqaTAx?=
 =?utf-8?B?ZkpOWEtOSTdTRk5NbSt4L3c4T3Y0cWNzYmtSWjBoaTdCMFNpRWo2S3l6ZnEz?=
 =?utf-8?B?a3Z1R3hFOURhcVVaY3F5SWNOMlVtdGpQQ2Z5VUdOcmQvSkc0SHN2YzJrRUEy?=
 =?utf-8?B?NVhWNVBQdU9CWVB2WHRneDZiYnR6MkdwNSttOGdHZ0w4VHhOeFI0SHJOaVFs?=
 =?utf-8?B?MWRpTHovU29YRk9mR0k1S0NRUjQ4bG1HVTlJNHo2YXpkRFFzUmc2cU1zdEto?=
 =?utf-8?B?ZmVCVlFFV1dHeDR2TU10M2FlWTIvMUdFN0Zock5MMTQ4OHR0Yjd6WnJjVEdW?=
 =?utf-8?B?eHBaWVh0djRKalcrZDFPWUoyaUZTRG5lbFVyODc4WU56d1VjUnhaUHpiOTh3?=
 =?utf-8?B?cC9HNWtEaUNiS3RnVjdhQU13VTdhVlN0QW9XNk5CRWs1dEJvZmc5aDZXM0FR?=
 =?utf-8?B?a2g5M2pTM296OEttaXF3K1RRSmlmTUdBcGJXd2FrbFZ0VU9NektIbmkvQ1Uv?=
 =?utf-8?B?aFNGL01PVHY5MzZKL0FkUVlkNHhONzFPeXA1bG9iS2RYV0FmcXFlWGZKMkdk?=
 =?utf-8?B?VytLRXFhVzJzU2l4SzhZNkJoQlNZWS9BVjBnYUpXWHEwNEVocXREZ3JwY1JT?=
 =?utf-8?B?YWkzN3NWelVvcjRHelRXUE1yRThaODJuZ09sazg1UlVCM3N6NG1TN2FaMlNz?=
 =?utf-8?B?VnREeGU1TVNqMXlDblYwMCtKQ2c0eCtlbmhpOWRrUXZOMVlZUXFENXFTWmtG?=
 =?utf-8?B?ZlYxa2RjckFLbTlHZk95Wmo0UG9sbUs4NW5pNU42ajdENHB4V0hwZllzQ2o0?=
 =?utf-8?B?aTczSkk2QXFqdUFJZDRqTTdVY0JlWEpTc3hXU0dqUnRDNTQ1VE5vck5yYmJD?=
 =?utf-8?B?ZVJtM3NOVUhvcndVWnNQSmpOUXhTTEs0MTdGRlNJTHpBWTdRamVYeTlUK3Jm?=
 =?utf-8?B?Y29yM1JIK0Q1YTdIL2w3YTJPc3EwRWlkbTVFSGRjVXhPMnIwSDJwNlJNbm9Z?=
 =?utf-8?B?akYrWTQ4VkQ3cjdteWJ1aHZBeXk3Y0FiTjZLZ29mcWxKN05EL1JFR2laeVhR?=
 =?utf-8?B?K1F5cHM1S2tET2RtV0NUSUt0ejRuVVFtaU1GWFpWK29FSXJHbjFBREVLY3N5?=
 =?utf-8?B?b0Z3TjFZRUh0dTVoQmZOb3lhc24xeng5Rm1GSld5MHB1NGJWSXVodmFDV2lG?=
 =?utf-8?B?ZmZNbFA3cm5zTDk5UEhVcnFUU0lUS2ZaamRmUTJRcTdHWkdiejhmQ09JOHNi?=
 =?utf-8?B?K2lDV1hGMU9QMmlvTGdPVDAvVmx3dDVJdVU4eDVFTHZzSWwzSHl2dFliZVBL?=
 =?utf-8?B?VXZ1OUpsdGZuT0RSQVp2L2tLemxTeXYvRFZEV2JCTW5rTUwxRHdtQXRYNlZK?=
 =?utf-8?B?dHg4RVBQdEptaGticGQvbnVReHYyRllrTWJvdk13RS9yUkd1K2QzVDVLdEpw?=
 =?utf-8?B?QmNBQThvR3RVZml5MTZneEhQYU1iekVLUzhOKzRXVS9jSGxrQjlDRmVFSlVv?=
 =?utf-8?B?Zmt2aU1WOXc1eUNESkR0T3grd2huN3ZPaEVUKzJ1WWFyWUh5ampnZDVRVGpT?=
 =?utf-8?B?aVh5TG5mWHAwSmRLZjZRR0hWangva3JTR1FWZEFpRC94VDkwbWc4ZVVvR1dn?=
 =?utf-8?B?eXUvamhHQUVkMTBLS3FpL3BKR0JBWGwvbnphdjliN2I4TVJpYjZLbkk2NUxz?=
 =?utf-8?B?RVl0Zzh0azdYSlI3YkhYbnoyQklwOVowZ0pNZTNhOG4wbmZYRDVtYm5QK2RI?=
 =?utf-8?B?YTVnTkxBb3FPNG5wSUJuK3VXbDhqYkNTL05XZzU3NGNHV2V5RzJ2WER1RDAr?=
 =?utf-8?B?SW5nR2tUdldTOTB5N0h1SHhORWdjajdkYUpBOHg1WndnbW8yVWFSREN4eFBu?=
 =?utf-8?B?czlveXdhd0JvRVVCNFF2TTFQRjkxU21DWWhLblczZFZONTV3R202c2h6L0NR?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f682a8-01e0-41d8-5dc2-08dd7682c269
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 09:50:13.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Cw4FRXHBHHXs0TrFcHN7uUskKD/53DORcYko6FRhv2XIKfpsjd6oK89KPzrwBP2C37MuSyM68NWErt2qwuJOsQTNayHp9Un0pt5wV0DaVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-Proofpoint-ORIG-GUID: -l5UqdAPRy-E2gSFipLBHrmAEnRAKqAF
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f4f15b cx=c_pps a=e6lK8rWizvdfspXvJDLByw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=xfost62yIfx7-QCmmKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -l5UqdAPRy-E2gSFipLBHrmAEnRAKqAF
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=783 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504080069


On 4/8/25 17:06, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Apr 04, 2025 at 03:58:36PM +0800, Kang Wenlin wrote:
>> Hi Greg
>>
>> Thanks for your response.
>>
>>
>> On 4/3/2025 22:52, Greg KH wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Wed, Apr 02, 2025 at 04:26:50PM +0800, Kang Wenlin wrote:
>>>> From: Wenlin Kang <wenlin.kang@windriver.com>
>>>>
>>>> The selftest tpdir2 terminated with a 'Segmentation fault' during loading.
>>>>
>>>> root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
>>>> root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
>>>> Segmentation fault
>>>>
>>>> The cause of this is the __arch_clear_user() failure.
>>>>
>>>> load_elf_binary() [fs/binfmt_elf.c]
>>>>     -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
>>>>       -> padzero()
>>>>         -> clear_user() [arch/arm64/include/asm/uaccess.h]
>>>>           -> __arch_clear_user() [arch/arm64/lib/clear_user.S]
>>>>
>>>> For more details, please see:
>>>> https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/
>>> This is just a userspace issue (i.e. don't do that, and if you do want
>>> to do that, use a new kernel!)
>>>
>>> Why do these changes need to be backported, do you have real users that
>>> are crashing in this way to require these changes?
>>
>> This issue was identified during our internal testing, and I found
>> similar cases discussed in the link above. Upon reviewing the kernel
>> code, I noticed that a patch series already accepted into mainline
>> addresses this problem. Since these patches are already upstream
>> and effectively resolve the issue, I decided to backport them.
>> We believe this provides a more robust and maintainable solution
>> compared to relying on users to avoid the triggering behavior.
> Fixing something just to get the selftests to pass is fine, but do you
> actually know of a real-world case where this is a problem that needs to
> be resolved?  That's what I'm asking here, do you have users that have
> run into this issue?  I ask as it's not a regression from what I can
> determine, but rather a new "feature".


Thanks for your explanation.
I’m not aware of any real-world cases. As of now, apart from our
internal testing, we haven’t had any users report this issue.


>
> thanks,
>
> greg k-h

