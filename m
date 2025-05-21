Return-Path: <stable+bounces-145843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A65ABF784
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6705016C6
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143B221DB1;
	Wed, 21 May 2025 14:11:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28711A3177;
	Wed, 21 May 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836714; cv=fail; b=QdnxOTeLGhMH5W+EATQpd/nXE6RclytO1SwRbBMNWhhwCZ5lTnhd2/NnviCbyJpDgFPbHtaZcUSrZLRwnR7LdQDnF/X73ZCyvpLf2OU7KfXH5jirYlp9fYSHxD/EbELHHIyjtworuojE72mvyxLTqTDj7UKaXwxJ/sJBPwsZQ/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836714; c=relaxed/simple;
	bh=Y/81Dutxz32cJzaWS1psgmSQp4oIXpeoaM5RaS8zoMI=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=PHy5hYlsPG8R3o8brOU3xpxQqIvqNUyTPUvGyUeyAdz798nCbLe8J30ayauUQH7jApeWUAbFaEiljVdT1ID/QG5+X9/iOtZrvpo15jNA8CJJEPzyp1yUMarn8iLyYi1GoVPzMpzeE0RoON1PnxGHTUiqxK1B5IWv1rzdPJhSFMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCFYCr001026;
	Wed, 21 May 2025 14:11:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfwsehn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:11:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCe+G48x1FdSY6PZQEnrYxfANFUNS7phnhTDiVEMOA/0r588B27Op6k/sCYua1G6Suw011ZbW5NWHOyI84QQWpIqd353/7ywOLA8AGEbLImtiK0dk2KKPKuuLQQzVa58LsmFmvV2vdDmyc30UH7jOlEwlo1Xp8GEQRoZw0UojI0Cttp7mJK/U8Tt73xRA4bA8TghKs5PlcOXeo94Ypgit+h2hJ91THCZtRBWMlnLR61gio1m/5dqA4In3DeNGLdTxHOJQk2+UDWZyr1VAp8iS1WFra2suWXTmincnhfG4ddP09s2HW5D95WwXtqXuB9heDydJgSMpFF+OX/ZdaPRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1hwEcjUrRomYN95h5yERarBJQZey4ugFM22FgpOCSc=;
 b=cn4iFsLAlzBJGlZBUOedtYGNgllrqHPe7CQm3jB+6GtpGUanJvFaM9wPGJTftc2IJIvhWqpMxIz/kqUbZlhIViwzbBS8OrfG8wOLSFNNmNIidHqr2xNtS4lpF6eTNYAFzQGdlwIW4+e+HblUqbF16JiZl1iTpTW6jPl8TaT37F0manDGVZ3dDjdtRQW6BzxSauLpQMUFt2NJCW7CWk66lLETce0YzLA7X7rXZrLSluj2QY8dbocSWmruWKRzbTxw0/czny5ud7mLZ+JbqyCecVu8DTtTYf1OuJarNi6LptBxFicqf+fPCa24Z+c4utg912lwxNplssz34EjJ8h+7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 14:11:40 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%4]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 14:11:40 +0000
Message-ID: <6bb8f01e-628d-4353-8ed5-f77939e99df9@windriver.com>
Date: Wed, 21 May 2025 22:11:16 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: chuck.lever@oracle.com
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Subject: nfs mount failed with ipv6 addr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|DS0PR11MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e0227a-21df-4d78-e006-08dd98716814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnlReHR1MVJyM1puZ3AxU1kyKzJBY1o5Zm9WQmc2SjFseWljeWs0K3VkYWEy?=
 =?utf-8?B?UXVvQjl0WGtrRkVzRVpIaTZjS3NCQlVUWkd2clBlZUhwbGFVR3dqUzFLeExu?=
 =?utf-8?B?YlE5UkpsczhGaVMycUxqdExMQmtLU0NOY1RpMHNFWmxYUHBha3Q1SkNLUFRi?=
 =?utf-8?B?dFY4S0ZKcTFBaHUvMHRqVHFiVGVZN0hPci9FbG45bStSd2tPU2JTbjU5QWxu?=
 =?utf-8?B?YUpvR0JuVzd4cU9FVnc2Y2NmTWtKdThrSUJzT0xjWktGSEh1eHkwYW9keEtK?=
 =?utf-8?B?NjRwNC95WHJpTmsyaDJqUTcxYnNiZTZ0bk1TMGM1dndLNk9jNTdrd3hFM2pP?=
 =?utf-8?B?QmdqTWlpaGNrc0JCa1llUXRndG92cUdXNCt3bW12aS9hSmZIbEdsN0JwSVgr?=
 =?utf-8?B?cDMyckZramhzL2hJOERYY3RuQUNWWUlUQWVGWUVTWHkzaGQraTFYQjNnY21i?=
 =?utf-8?B?Zzg1U0RKM1MrbU83L0lwdEFJR0dZNUhCQTBnaHNmcEhaWnR5YUc1SlNxNk5p?=
 =?utf-8?B?dEtRUHpoa0VSbWYwc1NEYXJPQnBEamVqWEFwWEhUcTJKd2s4ZzVlTFFtaWlM?=
 =?utf-8?B?R0tTNE9ra3VjUkpqTjN5SHZGc1JJS2t6Vzdva3BrRkRUTk5ZYi9reDZlVC9D?=
 =?utf-8?B?aHJLSGtPY08vVm5pK2FtVWE5bnNVMGZoWk13YzBoVno3N2lpYzNZa0EwaWdK?=
 =?utf-8?B?U0VmeW1ySmhLUU9sNTlXWGNhN29jN2JKTTRNRmxmSU1mVnZPNnUvUFlQb0pp?=
 =?utf-8?B?ZXZRMktLRWZQbUhVdEFBbXc5ZnA1WHh6Yk5EeWJqdmVxR0lYdVBiSERLNzhJ?=
 =?utf-8?B?cU9weGFHR3R5b2pDSGVYWWwwTWNTY3BNNlZ4QlBvVzJISmFXRi9janR6VmZH?=
 =?utf-8?B?OWYwSmpSQ1ZTbWFJVE9GSE96NlpKS05KSGs0RU1GQXNZMlVycTNoVExlSzh1?=
 =?utf-8?B?azNYRkwzVTlyZm9FbTVuRFo5ZWtOMDNWeFBmb3N5aVJ3TUxmTGp1a3BaKzNq?=
 =?utf-8?B?V3M2NytsaUQrRGJ5aXdpQnpwK3RGaDRCU1lYSTk5ajRyTkp5dytVRjFNa0RM?=
 =?utf-8?B?ZDNFVEx1cUZpeEtiYXdJZDVTekJBS3VuZ25vbDJhTFFqOTB5cGlsWmRQZkZX?=
 =?utf-8?B?TVMrRUg5U0E3ZjJpUEhld093NVRtQ0V1Nk9LT1lEbXVjL05oV3JFeUdXc0N6?=
 =?utf-8?B?amM3THVZd1h4aERIT2RFM1RGTnhKYWhrTXQ4SVdwbHVhWjN3KzFhTnlEMTlL?=
 =?utf-8?B?U1pJakwyUlc3WTVKL2VDaDBnd21PTU9QNEEzWGN3OFNrRmFneGxhN0loQzV3?=
 =?utf-8?B?ZTFYUTBoNnF4YXNuZGdPc3NkYlhrdnA0amsxUWF0UktuSnZiZmhxTlpleWxN?=
 =?utf-8?B?eVVHd1pPcVM0dXRoQXNWaittL3ZpWGhwM2hTcXZiQVE3WUJDQTcyTzNTRjg4?=
 =?utf-8?B?dGhpRFdaUlJLSEU5RjRWa0JVQ0lCS1F5QWNoRXI3Z0oyZ3BuT042SVNoZUdI?=
 =?utf-8?B?dXJVNSt5L3h4WitKK0ZpQzZYMFc2QklCZ1NmQVA1b2IvTlBRQ2ttekNIMkF5?=
 =?utf-8?B?VjhOb3ZpWS93cTNWZ1lJUXdwNzhZYm9EOE03bnVwbXh5b2kxYlM3enY2S2ZZ?=
 =?utf-8?B?akRpQ2xsUWs2TkJoQ083ZE84YmZHTm14cFA4NSt2ZjQrZ0drL0NNN082ZCtK?=
 =?utf-8?B?OFdzSi9tRFhoR09OQ1JMNWx0aHF5ZGorNjJ4akZOS1hWWnRHdUJ6YVRSaUEv?=
 =?utf-8?B?MUhQUXExRjB3eGlmK3IxWVhBWi8wUjlpTDhxNEtyVStWN1Ric1RlcWRSdWhP?=
 =?utf-8?B?R0R0ZmVXeHNOeEh5SnFSMGJsbTc2TW5XRUFzdTNtTDAvVUpNaGNjZmdYT1Vp?=
 =?utf-8?B?UVM1R3B6aEltR0prZUJ6MnlBYmJRMVIrN1hMYVVqaDZ1VkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjhlSUIwYXVwRzkxOXlWZWNTalp0YjIvZWgzeXdBZTNMU0x6V3pqMTNJVHFi?=
 =?utf-8?B?a3FIcGhCMVl0ZFFrR0FuR292cllOWks4N1U2UTNzMjE3NWFoSnRqK0JFK3VY?=
 =?utf-8?B?UnBtT2VDTUlvRVhkMUkwakZWQVJmSUhhYndEOGZheGtuT051N3dLR0xhbWd2?=
 =?utf-8?B?dkVIRG9mdkpqak1LcVd2d3J1VitoNlFObjZIaTd5YzRlY0xGWG8rSXFmeCtD?=
 =?utf-8?B?cWJ2TDJBL01GV1FZQnJ3d1ZiRkVkUzlPRmw5N3Z3R01yMjdkZ1I5UDBxbWcz?=
 =?utf-8?B?MVZRMmNGK2s4SXk5NkIybERtRHp5bnZKa3Uyallnd2tTOHp6VU1iRFBFeitD?=
 =?utf-8?B?VlVpNWRHY2FmTlVicVIzQU5LK25SODJBMWt0L3hlQWVQaVhBUFY5OWEyWUpG?=
 =?utf-8?B?TzVDL2dDcXkyWnA0bjg0amtNWnN3czZMSlZjRXhxRFZOUWdOU2NVYUZmTEx1?=
 =?utf-8?B?YXdpcU5vR2oyNzZhbWNLaXE1RGR2a0dtdnVuT1BKL0Vadko5Y3VsWnU5UnRI?=
 =?utf-8?B?c0Yxc2xheFJ3dVNCYzRMZm5vM2RvUVRGL3NSd3JnNG94bVZ4WmI3NVJOSWYx?=
 =?utf-8?B?SmdoRXZRKzcwdkFTSkhuU0huOXcyVjR2WStYL1BvQ3BzWXJ1Vk1qb2VwZkNo?=
 =?utf-8?B?T2NoMms1WDNabjhxOFlYYUt2bkc1L0NyN1V1NmN0VzlOVjdneFl3NlR2b0Fq?=
 =?utf-8?B?UWpSRHU5WGFwb2QwN3IvREJ2VTVxZk9JdzZkTWVVa2I5Tk1DWUN4YjFZNmZk?=
 =?utf-8?B?b1VRU25VeHpraVBOWjZiNVVzeGVTL1FEYVVlTmJkSWREKzdtblZIN28rUTFQ?=
 =?utf-8?B?dngzYWcvYXVlYlRVbXBvVkw2aHMzUVp0UnVXRTNXRHRjanc0d1Bwb2dUcGt1?=
 =?utf-8?B?bkxaL2kzRXlxdlR4VG5keHJYVG1lTmtXMFhKU3hjM051cHpzeWtENmhBWVpq?=
 =?utf-8?B?Q2ZBVmpxUVBoQUsrWDdOUEhIdnhTZkRKR01wZzY5NHNPYkRwcCtsS2ZFMFJr?=
 =?utf-8?B?Vk4xd3U0N3U2VkdMMkFOdkllZUsxNkxUS2xtdUZYNGtBaEtMenBOaGhsejlS?=
 =?utf-8?B?Ymczam4zaWxGTk5GdE0vQ0F6TVJFSzJzSnJSOE44STFJQld2aHNqbVB6V3dC?=
 =?utf-8?B?SlA4Tmp3RzduZFVkTTFXeWpnaHNPZ2hnUC92cXIva1NUczVmNU5ZTEFPQ0xB?=
 =?utf-8?B?UkNINDJmMHVKMlcxczMzeVVEM0pzSWVTT2FYaExNSHdJK3VqaHBMNmhSV2dj?=
 =?utf-8?B?N0VXdU1FK3V3VVVIN0xDcXd6aUJJNTg3TnhWSk5ZbGJtRTcwaEVCVU9hWVB3?=
 =?utf-8?B?VXY5azg4eHNoaTZkT3ZSWU1uOWlkbDVTSkR1TlZETElIOWFOT0lzaDJHME5R?=
 =?utf-8?B?T2pkSGtZY0xrWFlMOWVaalVIWkVwM29XYkFMK3VMNk5DQzJ3bW9MdDhzM2Rm?=
 =?utf-8?B?RG5saDhZa2U2U09WQ01reUN0T1o0Z0xmbWg4VWp1N2s5dVhJTGNSTE15NWhP?=
 =?utf-8?B?TzNrOFZtSWJiWXQ5NGQweDV2WUsrTVlSdFhkM21PYTEvU0pWRGQ4YzAxZldW?=
 =?utf-8?B?cVhUWkZqcUZyTkVpYUozWWlLSmxKRkxqTGRjRG1FRWd4THJqbHVieW1UYWtG?=
 =?utf-8?B?QjhZL0duSHI3MzRTU2dxaS9ZV2FaVnFRZjFYaTQvR0cvb2RkMm80NGkzZkpL?=
 =?utf-8?B?VU5HWEdmK2F1K0g3Zi9HOGZadUNuNk9LMkFkOVk2MDZHNklvWnFtSjVHSm1L?=
 =?utf-8?B?dS9VRmE0UmkrU1RSb3lHZkZjMFZQanVxVVFzaEJ3WkRkTXB0QVU5NitiQzg5?=
 =?utf-8?B?TEZ1NElLRWpRekFCb0RWRkM5c2I1dFVHcXh5K1RtNENlMDBORTVTV3o0MlFF?=
 =?utf-8?B?RGM0amsxV3h4Q3BUL1JtOGdTSGZDNzl0NTZoK21oQjA3RlMrSkowMWpnWGFC?=
 =?utf-8?B?V0ZvRDFkV3oxMmhXZ0RVUG5UWUpTRkdiMVpOeUV2Y3kwK25NT3cxMHowamJS?=
 =?utf-8?B?V3dqNTUwRHhmcytOZksxTmg5TXJLSDBqSGdYUDZoU1h1M3hDM3p0bEtuK0Jq?=
 =?utf-8?B?ZnJNNFdFeGtteVRQS0ZKd1VVQm1KenpJUnA5SUVDaUdPN0JiVkUzTGxiR3hs?=
 =?utf-8?B?SGRhc2pub0pWZnRsby9RY0hoa25sQTRNWFFqM1p6dis0YXVNWGdHOEpZcXRW?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e0227a-21df-4d78-e006-08dd98716814
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:11:40.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdD/VZH6geCNup1OYMTWBkCFyya5zThbGS+nCUNQuQr4nUowiyso3OkzpiJHCF7nGWJ7Ccz9U5u3m14NnfGbOWRmbNQwS91R5/teHcWckaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzOCBTYWx0ZWRfX74kR7geIArU4 Lg2p5gNJQsmfCy3upLiZQ8mRBeAL2oAD0/9MONCgWAUdQK+KS9KOVAnF9cG15KIWuJ6Y+K7zVOP 99HvEQekf5ZbMToWyijH2NHqmokL52RyhsYl+N2q22us3GNpdYYCT3rKVEcY+vR1SHVsj4oA369
 /IBMOhoUxb8w/LqA/UhIYCZaX5YotACUfDdCr0CUEN8X5F9SzTLHhEIM4poHqFDWetr3u0vgS57 vh/Vjm5dNacIKcS3wQbf7DWeEFQz2ENCu46nPja0I6fjjmW3hLPoK55kgftGOD47ZR8ThIK629g 0xpsFdp7DAp/sPimjMT7LsCg7Ek9uSFTnt/wLrWaqpaw3HOYpQLFKupmAH28oh6y2h831hA3qLS
 +8XsaGNj5bWQ2VaEAEELgwvyGx4t6Vq7JEuPIHgHxH3N0NysmOrxp2mfSDey4ZWw/7E8F6Hl
X-Proofpoint-ORIG-GUID: _MQjsk28r9S6714Ju_ykQKRKVzNe3zWm
X-Proofpoint-GUID: _MQjsk28r9S6714Ju_ykQKRKVzNe3zWm
X-Authority-Analysis: v=2.4 cv=b6Cy4sGx c=1 sm=1 tr=0 ts=682ddf20 cx=c_pps a=OemXRkCljtmPz/OzEC+nkg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=4x1uw_1Qg-QOYtC87tQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505210138

On linux-5.10.y, my testcase run failed:

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
mount.nfs: requested NFS version or transport protocol is not supported

The first bad commit is:

commit 7229200f68662660bb4d55f19247eaf3c79a4217
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Mon Jun 3 10:35:02 2024 -0400

   nfsd: don't allow nfsd threads to be signalled.

   [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]


Here is the test log:

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=/dev/zero of=/tmp/nfs.img bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /tmp/nfs.img
mke2fs 1.46.1 (9-Feb-2021)
Discarding device blocks:   1024/102400             done
Creating filesystem with 102400 1k blocks and 25688 inodes
Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
Superblock backups stored on blocks:
	8193, 24577, 40961, 57345, 73729

Allocating group tables:  0/13     done
Writing inode tables:  0/13     done
Writing superblocks and filesystem accounting information:  0/13     done
root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /tmp/nfs.img /mnt

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt/nfs_root

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /etc/exports

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr-test/bin/svcwp.sh nfsserver restart
stopping mountd: done
stopping nfsd: ..........failed
  using signal 9:
..........failed
exportfs: /etc/exports [1]: Neither 'subtree_check' or 'no_subtree_check' specified for export "*:/mnt/nfs_root".
   Assuming default behaviour ('no_subtree_check').
   NOTE: this default has changed since nfs-utils version 1.0.x

starting 8 nfsd kernel threads: done
starting mountd: done
exportfs: /etc/exports [1]: Neither 'subtree_check' or 'no_subtree_check' specified for export "*:/mnt/nfs_root".
   Assuming default behaviour ('no_subtree_check').
   NOTE: this default has changed since nfs-utils version 1.0.x
root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo hello > /mnt/nfs_root/hello.txt

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt/v6

root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
mount.nfs: requested NFS version or transport protocol is not supported

Thanks,
Haixiao


