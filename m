Return-Path: <stable+bounces-197552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B024C90D14
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 05:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D17B3A9585
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 04:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A38E2E7623;
	Fri, 28 Nov 2025 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VZJ/Q4+w"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010078.outbound.protection.outlook.com [52.103.72.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883B2E543E;
	Fri, 28 Nov 2025 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764302985; cv=fail; b=R8YfaQXE1pZZfqkGNaHlfwnLTXIGTDQ+CYrTYSzBYY/6R9uluGrdmPqyuyulk2kMXk/3c2Z6kyU/uK1mbv6VtQ4/o4dD8kbCfaDuOgvIhU+QiMvymFlpgehpzsafpHwhu8DzxlMBAbhuzhvI/6lLycfgnneQ4LawV2PIWo9+LC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764302985; c=relaxed/simple;
	bh=WvGXsz/LR7deQr1z3CDbG/eOZ++j4nQ/ML3SWWdFALw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=B6LcCvC9hMfbqse/Qlk6We5aJFLFzrHJd4eqRNnoQEFSggVXMGtEQOzD3DDDcS+L5OmolYKFy7OLtuggu86JKkJqs1Ch6CMHTggmfyAebGC+qlEf6oDjjXB/SO/vxMuDVzFvJc/Eb/fOQyru0s83MnMHW7P2xZve7KkBF8Grnc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VZJ/Q4+w; arc=fail smtp.client-ip=52.103.72.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSRrJCsHMk70LRqE6evLvbMNvipqd7lR+txodDPTOgMNRX3ZaZnBw6uvvjeH9PL6JDYxhoZ1wquNDwY7xZjkyeJG5dJG7iF4qdkmjXSQKORTkYdAn/2mH/mQgTAffTEe8vKcHP8Tla97kLQWKMzae+jnY2xvC1B2qe8PhrQ/KO3XEzAtrcqeFLfSphfKK6ubRqvETAmnrS13Kvt9Iy3WIbpzCbmPWPlDslExl3vAXj1vh6qTwf0wwXbfBKSs9f9sppQ8NAOjhCc6qAlcYqvxVmf6pFdbSV0WxgdVxXDlu7TFlgZHXafjI6qBkjIWg9vrK8TGDwYJDOpaWS5DZed8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3VFOXMaoX2g9s22TUSg12rWF1iMG1kHWpDa4zBNDAM=;
 b=VAuHyvGO107eSr+FHBm+HfOxIYRm/5bomDrR1PMcY0/7trkuRpOesGqjYsYdohc/neaPXgxF2qE3tSJr50xGnDDh5OdeP7ZKmHW4A+75NtPmV9bH3Hhdz+VxY0mHDTVWTPhPaM1KC5PGMpLFL7vGjAX3Vhj51d+BG2kGJNRbrq2ACmZAdestU38aP7v/bl5ujLmB15dR/PqxlcfYWoa0lT7p/Vya7RdnLyHFx1tKc32zVaE4EiYisvp6/SmAoJdr1dQClLhqP2zxBnugCC0K2NTqFVvvCIZXk8CQuri91gGeekqRg8zxuZvacW2SBnQ7tOsoqoyE6FsjkmbCLuwVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3VFOXMaoX2g9s22TUSg12rWF1iMG1kHWpDa4zBNDAM=;
 b=VZJ/Q4+woF3vosUYdoctk+W6f1/9tamojRxSZAaYTAlbgGyJKS+xAa2bkjn5iLpJEa9MywIgct5R2VRujkMcfCwpDogycL+nv0I4zrO0PpUcb3XNfwp++5prcj9qOBV/XWciqBgMcmrcVWzXYM5kZ91WtyJy629aZo4xKZL2Ch6a/qigLVmGPLcjKzVSDhCqbGt1671di7GU4HWUmR1sQISSTJ3bECJlQEwI36oCvuPW2YxKV3OZ0rkarYQl3+lmNwXucsZ1iltyrtXCogLvX6EYiMF5fsEw4FSxgu+22OzxRUYHb0H/Iic2huM9obeBlcMBo7H7OmLpbRbeRr3sdg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB10348.ausprd01.prod.outlook.com (2603:10c6:10:2eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 04:09:38 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 04:09:37 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Fri, 28 Nov 2025 12:06:31 +0800
Subject: [PATCH] ALSA: dice: fix buffer overflow in detect_stream_formats()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881B043FC68B4C0DA40B73DAFDCA@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAMYfKWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyML3bTMitRiXTNTi2TDlGTzRFNDcyWg2oKiVLAEUGl0bG0tAOxbOm5
 XAAAA
X-Change-ID: 20251128-fixes-658c1dc7a517
To: Clemens Ladisch <clemens@ladisch.de>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Junrui Luo <moonafterrain@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=WvGXsz/LR7deQr1z3CDbG/eOZ++j4nQ/ML3SWWdFALw=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhkxNhdI3lftFwkOsdYt2aRifEas6/3Xa80fXgicJGXm++
 7BB1GNTRykLgxgXg6yYIsvxgkvfLHy36G7x2ZIMM4eVCWQIAxenAEyExYXhf+jx/Fs1p8+9eNB1
 mCvhXrH2zoN39jX67G5XubBpndrHiCcM/zP377oqac3AwWWy+8/GCKvsOSuD7jg8uBXGU63wJH1
 7Dh8A
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251128-fixes-v1-1-cdb66b7395fc@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY7PR01MB10348:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4fd1bc-d3b2-4773-f9c0-08de2e33f02e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|15080799012|461199028|23021999003|5062599005|8060799015|19110799012|6090799003|5072599009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHYvejBveDJESDNvQ0d6LzdlUXlEODhBOHRIZkNoMlZzM20zQVEvSnY2S2Jk?=
 =?utf-8?B?b3Arb1kycndtYWdvN0RReGN2MmN1WGNoTlZlWm8yZ0l1Y0tKa3ViY0NTZDJz?=
 =?utf-8?B?dXI4czBDZjk4ZmhseVNaYTRNMFYxRDlveDZ6TFU0Z3d6T0FZOGFEdHkxR3Rn?=
 =?utf-8?B?VzF1bnVLMG1XY3dLekF3S1pIM1JPSWt4aGpwblQxejBJUnRPdVNibEtsS0pv?=
 =?utf-8?B?Zkl5SU5xV3E1MVZiN25tb3o1ZnNoRGY1T1EvVEZnSDVSUmdab3dxZXl3Ky9V?=
 =?utf-8?B?ZWZmNFNjeGQzdkU1YURCZmlRV3RTTTF2UkkrbDVGWVNlcUpUMnpiWEh2SDJR?=
 =?utf-8?B?SWU2NVhoaGFjSzBOaTZHekxIdlJlWU05UlV1dnBQS2tDeFIvNm0waGNLNWcz?=
 =?utf-8?B?VkJoRnRPQkNOYzE5amVabHJlTW5rZmlSU2x6M3IvdWwrOFBudUFuelMzZUtS?=
 =?utf-8?B?QUpXekdoU2pEOFdNTEhzYUdGb3NJOVNaQnl2K3I2Y2s3NEtEcWZ0UW1IY0Rz?=
 =?utf-8?B?anc1UEFTL1kzL1ZuZlI0TlN4L1lZWnk3c1RnWHV3b0hkb083Uis4MmdsV0Vj?=
 =?utf-8?B?Q3BkQVlpVFFEcitEQ1hGWGZiSjlydXg3OFBDL1ExY2xuUU5tbFlkZ1pCaWVD?=
 =?utf-8?B?ejkxRmtPbUUxancxck84VW9lQUpLRWk4TlNoWFZVTXhGN1dXekJLcVVCcVVh?=
 =?utf-8?B?MnBCYzVnTHplZVBtM0N6Q3ZncmRqMlQ2OXQ5TnVUcUpKSWJET2g5Yy84YXpm?=
 =?utf-8?B?UzcycEtjZzcya3dVUk51NnUveFlUTnVpVTltMk41Zk93SEFvK2p2N1ZhVzY1?=
 =?utf-8?B?THl5OStld05zbHU1MGlXNnpwdkhGeDloU0w0NUZFazMyN25VQ1RXVWlhVUE5?=
 =?utf-8?B?dzVEbGdYSXBsbVpHSVlkb1RaY1A0U05aOUxjQUhxaC9hQ3VDSUxQVDIvSGNK?=
 =?utf-8?B?RXUyRWtkSkhNVUM2L1EyRGJmeXhicTlLS24wMEdmOTJ1VUtJYlhEY0FIVmhZ?=
 =?utf-8?B?d2g4WFRrQWpSV1NEOTFURER5VDMyWXdaYzF3WmQ2K20vMDZFd0xhUVJjd1Fo?=
 =?utf-8?B?aXRRb0doTEgwWjlaelNqVEFIeUdZdlhDc2YyVHFibTNtWE9hM3FlTk5VQ0tH?=
 =?utf-8?B?RVZ5b0V4OVlSajk0REp2STNFV0w0VGM3dld6YU1vdzFNVFV4eXk3NFRrV3g4?=
 =?utf-8?B?Y3kxMlRId2hPUXVmODdieFl4endwNnU3TnhwT3l6T1pRR1JBMnBFek9xRFVP?=
 =?utf-8?B?aXB5M2d4VTRodFNGaXQrbGk1c3c3TDVLQ3lGUTREU0hpczFMS0NTazN4S3Nn?=
 =?utf-8?B?WkxFTWEvazNBajNZT3dseDVqZ2p5YUlJUWJJaXhEcWhZNnRzMDhCQnI3dTZI?=
 =?utf-8?B?ZjVDbzNGLzREQ2Q4SnNGWDZjbGtSSFRJcDdEVTJUdEFXNHBmQ1k0dEd5Y1Ri?=
 =?utf-8?B?Y2NXdnpvTHVYeTMyL2x1aENvR3BOTXQ3bUZzaWpSUEF0T21jQjd5djkvbmJC?=
 =?utf-8?B?VnI2cFVOU1NnUml0emExbzR6K3BBeWRqODRaYktVa0JtTVZQYkYzaHlsMmE3?=
 =?utf-8?B?elBrMkNkZW9WQXR3NnBGdmRDU3owa2ZiOUZqOHppYml6cVppY216aWhnWm1t?=
 =?utf-8?Q?DsX063R0r0xpJujcyw8dictpOQYL+0uXTipwXcmsluVc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVFEZGJwcWh0OVRVRzAyak5JTENiTzNXMzFJZGdhWkdISlg5a3g5dnQyTG52?=
 =?utf-8?B?WjY5Wk02ZUFPbmhNSFNYandVSG1iZDhFMzVmMnhDT1lndm4ydG0yQXMvVHRW?=
 =?utf-8?B?UEM3dlQxSzR1OHQwd1p1YmpsTnJITVgyRHl2Nm5xWVFjampOV0dyTWwzdHdV?=
 =?utf-8?B?ZUxabGE5UWgwam5sYzQ5S2FQTEJsZE1RK29ucXlmZ0piMkJQdXlETElRR0hE?=
 =?utf-8?B?VENXSTNYZUdSWjl0YXZub3Q3VHdNMWgwZk1hTi9hZ3FzcjRkcFFXVm5ZWEZq?=
 =?utf-8?B?ZU1uRWoySVM4dFN3c0E3eXBBUkpjL3QzN1ViZjF6dzJ6NlJDZExMUmFldTJ0?=
 =?utf-8?B?TldqZjk3MTJrNDlCUzJadVVYRDhwU0xNM0lFR0EzZlkreXYzdXJnclNJNGlL?=
 =?utf-8?B?WEZMQncyMjEzY1M2S3BlVXhQdjZuc1Zid1ptZ2x2aFNMRk9oaWhGNjRZSE50?=
 =?utf-8?B?dE1hL01jWm5oaFZ4dmJ3bEVsdFd6N2ZUZE1FUkpqUFp2ektDd0FQQ0JKcUZw?=
 =?utf-8?B?VDV6eTdnRXdzLzZGb2ZjbGd4ZU9iWFRZTUFsWnJZNVEwQTBEMjdINFdVOGxT?=
 =?utf-8?B?d1FpMDVRL2VKL09Cci9GdGFBdnEyR3B0NnBybDB0bURlK2MxcWFXbmQ3YVp2?=
 =?utf-8?B?b2FuaVdteitsMEtncjQwdFdOWE9uTFJJK09Ob3k2MjhDRFMyemNYMERDUzNJ?=
 =?utf-8?B?RVFsVGRyV2NFVTdzZkVkTWtnV3dHZUJoVEV3UzN5Rm5IZVhrazRzV1VFM0x0?=
 =?utf-8?B?YVk1MFhhUFRTclRiNS9QVFJqbzloRUJZUTUxT0VlR3VTaVp1aEdheXROUGdo?=
 =?utf-8?B?cnV0TDBheXJWVlhlQlphRW1qWkpNNGc0bk03TkJBZkVycWlDNTd1RHZ2TmVB?=
 =?utf-8?B?R3BrTTdIMWlYSkFmcUR4SEluMXRhM3VZK1R2THFobUVsZWZPRDNzU1U5akdY?=
 =?utf-8?B?bk1ubUpyOG9MVnJVb1ZtZW1SeFRVNkgxSmZyVHdOY0lkdk8xMUNtSEt5MzhI?=
 =?utf-8?B?ekZiQTkyalhXd051a3RhMWRVR0c1SG4yZUZibi9iOVI5WUZIQlNFOWdNeEd4?=
 =?utf-8?B?dnBGaVdPYW5POEE4RnZrMDQ5OVBtM0s4YVBTbzBzMG8vSldoMWF5allOakhT?=
 =?utf-8?B?U3l1aXdDS1NQOVRRQ1d0cTR6dlVjeGF6bGdSODB5czM0MnczUERWWkFXMzJ0?=
 =?utf-8?B?QlhPUDZiTTVtVEZHTWN0VzJndWphZVhiYThsd0lYZFlrdmVaVGdhT2ZSR0xl?=
 =?utf-8?B?QWJteC9PQmdjR0RoQWlQQllmUVc1VjNCS1NaejBLalo1NW1QZzBIMnZ1cEQ2?=
 =?utf-8?B?dENLbDVzZUF0UUY0YjE1VUw4RGU3S0VodC8wcGpVNmdYYzJKQjczTFRvcFU0?=
 =?utf-8?B?cE4vRlVwMmNXMTh2VnZFZ0xob0JDbGRseENyQjg0bVJraWNBME5SeDBKNVho?=
 =?utf-8?B?MkszejcvbFlHSmNuMHpsV0NxOG1JempGYWpqZTRmeXY0ZDlxSENMb0VubXF2?=
 =?utf-8?B?U2NNK3BBdXR1ODRVSkZTOTJJd1M5emxySXdDRUJYZmttdnlqK2lGeEJ6TFFV?=
 =?utf-8?B?UEplVnNZank1dXhrZzlwdFlJajdOYVRTY2ZCaWtpS3ZjVnZmNUQvanV2dzZy?=
 =?utf-8?B?QkxZYk9DNmIwUmRrNllNRXdXTkIvenVRUFVWMmJJVFlqclRqOS9iRHovVTVX?=
 =?utf-8?Q?Ur9b1o+1dHxjOkQC8VDA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4fd1bc-d3b2-4773-f9c0-08de2e33f02e
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 04:09:37.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10348

The function detect_stream_formats() reads the stream_count value directly
from a FireWire device without validating it. This can lead to
out-of-bounds writes when a malicious device provides a stream_count value
greater than MAX_STREAMS.

Fix by applying the same validation to both TX and RX stream counts in
detect_stream_formats().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 58579c056c1c ("ALSA: dice: use extended protocol to detect available stream formats")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 sound/firewire/dice/dice-extension.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice/dice-extension.c b/sound/firewire/dice/dice-extension.c
index 02f4a8318e38..48bfb3ad93ce 100644
--- a/sound/firewire/dice/dice-extension.c
+++ b/sound/firewire/dice/dice-extension.c
@@ -116,7 +116,7 @@ static int detect_stream_formats(struct snd_dice *dice, u64 section_addr)
 			break;
 
 		base_offset += EXT_APP_STREAM_ENTRIES;
-		stream_count = be32_to_cpu(reg[0]);
+		stream_count = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
 		err = read_stream_entries(dice, section_addr, base_offset,
 					  stream_count, mode,
 					  dice->tx_pcm_chs,
@@ -125,7 +125,7 @@ static int detect_stream_formats(struct snd_dice *dice, u64 section_addr)
 			break;
 
 		base_offset += stream_count * EXT_APP_STREAM_ENTRY_SIZE;
-		stream_count = be32_to_cpu(reg[1]);
+		stream_count = min_t(unsigned int, be32_to_cpu(reg[1]), MAX_STREAMS);
 		err = read_stream_entries(dice, section_addr, base_offset,
 					  stream_count,
 					  mode, dice->rx_pcm_chs,

---
base-commit: aa7243aaf1947a0cb54c44337795d6759493fe02
change-id: 20251128-fixes-658c1dc7a517

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


