Return-Path: <stable+bounces-230160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLftAMiSwmkXfAQAu9opvQ
	(envelope-from <stable+bounces-230160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:34:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B380309805
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8524930DA7B0
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16E3F99FE;
	Tue, 24 Mar 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FdCdk6AR"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010010.outbound.protection.outlook.com [52.103.73.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B703D47C6;
	Tue, 24 Mar 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358844; cv=fail; b=rJPc3nuEWbn5DhRSATn1w9/hMlo1ogLutP9LttwESTH4ba934ZogwesT+hwbcENugI5s0ZOONfUQ+bPx232ZTFXA6S35GE2moRwaAMhlDxSTxpClqqA/79j52jdblwHWc6jRXxw4l5/CTfuXBI5Q5MQ1v+bplP9yHNUnE7bB+VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358844; c=relaxed/simple;
	bh=7eTgcOsSf/zafDS/mvE47EEK2cVXSzKpL5ByzwPYj34=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=BGK3hAkPMYJUcU+q46X+i8NuC3oO5T4PUiQZ8q6k0CRs+FHExQHwdidfFxPwuG5fl5QTmMppDucBASXor7sQKZNW+wb4vXS14It+/mH8X2o5Hb/HcwoM5jF66+mul08dGIiqe33HuZS61pKo4FDYnwYbC7UMXIp6zbCZudCyKLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FdCdk6AR; arc=fail smtp.client-ip=52.103.73.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA7UB/TSU8Okv5lsYfZq16KoZvsoJqYG++H8r0v2yBg+JxusY922TUqUMmYuKEnShM/7Riz27VGwDcbBp4/j0eFtxYHGzDml35pu5btNCqqFUC7Jk+G470olDhDuz2kW7YLF+YEBgv0lG2MAG4vH+s0RDzFAKA988xUSi2R7KGIjT2ffgIt0BlFbMt3iwkR1bQCpb86KoHM2wac8oFWPxGmqLbKY/2u+YcSboitzgzOjc4SAx6ztxlycfXzacXEHA7jJGgTkK7EQIf2r5Yu1ibWfUWLNsnpV+rU/5eNcz3XT61/eh2hHjsVUtEsz/Mr34B8qgSq/h9kB/QyRIj2Z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txnF2ZAYwggJnkO4C6L17t0o1ARa6qWgEzNHonj+hUs=;
 b=GTxxoSe5+ou1Y6FgIjeAdpVCqT79A3EcRHY1PUF/GIz5pKlInoBTHdBnyzCfa7ojbJdA44+pL1EExCIY0kiYcpxkEsQZLGOEszuoWF0+0KVbjX5rmeQpnvzOv5TWJ1mHhOz9SlbQRycNoYxfI+YmUYwbAOzg2RQtQ9v2gzn/B3oD+pt7L1cyQ4F/PqH2msvLY//k5t+AWtuUb3CE86wLUFLg79EHDSo6kTNCK1cJCiBS4NXcQzOFhjdoKCrDzJL0hvSQr+RqYP6BCBS1ZKqd4kRxpjXQ0eTa5yBsxrOq6vRgkD5oduye8CncsI9JwqFIbYDTJrieXHws1s1gvUGp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txnF2ZAYwggJnkO4C6L17t0o1ARa6qWgEzNHonj+hUs=;
 b=FdCdk6ARg5OONQoOibmbYCovGN/ucNp4AZqaolK8+CaUhrEIWppZf62u+G2yKbSsZgaqMmFKUc9Y9VzXB5RirKSdonqB5F5iXuiR5VdhWRxpOSczIP3q8wI/+1A69XObm4zcxgmKXvcdzckCfG1LRDISi1hU1DK/zkjwH0pPw/ybh8LYXp+UcTY6x637xPSQLFZQMes7JnsrN1XGeK6CLDSHk/1hIFdwRt1uAnE9rnuu8Wlgu3aKGn/8Sheqnnhk8u/NR7XHIvOupeUzDCKVczbM5rEDlmBhTFJraMov8MAbgHP8C6GDMNxRaXkv713/I19MDWqXrpnmv5k3KlsK5Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB10402.ausprd01.prod.outlook.com (2603:10c6:10:2f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:27:17 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 13:27:17 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 24 Mar 2026 21:26:06 +0800
Subject: [PATCH] Bluetooth: btintel_pcie: fix off-by-one in RX queue bounds
 check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3bTMitRiXYtkYwPDVAsLC8M0AyWg2oKiVLAEUGl0bG0tAHv5bDB
 XAAAA
X-Change-ID: 20260324-fixes-8c301e8881f0
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=7eTgcOsSf/zafDS/mvE47EEK2cVXSzKpL5ByzwPYj34=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhsxDE96e1E5U3z/xamg0k35fYPwdNpbSe4tPz5rf/uzru
 oQ7bYl/OkpZGMS4GGTFFFmOF1z6ZuG7RXeLz5ZkmDmsTCBDGLg4BWAim74zMnw8F1B59e/N9jtT
 +lpZVwSdm/W/o3H7lmNLfQ6zbVq54bU9I8OkTJ3DCjMfpgdOOxx7/1jnJ6bz9Z9nPOv3e/xQ3Md
 Zcg8rAA==
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260324-fixes-v1-1-c1d2f8022b4a@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ae55ec-9a59-46be-b911-08de89a90fb8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|6090799003|5072599009|5062599005|23021999003|19110799012|15080799012|461199028|22091999003|8060799015|8022599003|24121999003|41001999006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzUxeU1HTHdVK1ljNjNvcWM4U3lKZ0s3aHJwNG1VZERha3lTcTV2Ui9JQ05w?=
 =?utf-8?B?MUVzMXcrWG5SM2Y5OVVoVm54d3hLd0I5MVdjK1pXaTFQeXNSWWlnd2hHczNM?=
 =?utf-8?B?djkrcm8vU0NFL1lFYmRSbkZhTSs2Wi90Vyt3SWgwVXlEcTFKelFWekpxK2FG?=
 =?utf-8?B?RVNQcWZuTENLZkZBdkpWQ2t3WVI4bmJyRG1zMmQxcjlrUXRwdVBPd2pZV1lz?=
 =?utf-8?B?TTBlRjRqeDJRVUJOUTNpVGhVekltazlMdS9uOUlwMXEyaHN2SXQvOHJ1YWVC?=
 =?utf-8?B?UUF3WlFpZlEydUNURW1rSWExelBnempMRlEvNFBLVVZ4MTQ4a1FMQlA1aUty?=
 =?utf-8?B?QXNlakZ5YnJLL2RLdUduQnRLYXJtOVhYK1VFSFhXTWxQeStTaXZlVDFlU2FT?=
 =?utf-8?B?blNDc2NaM0RsNzdlbGdYNVVlNHB5K3dDVGRRWTZid2tBd2s3UkJVRDAvbm55?=
 =?utf-8?B?Mm1GMDlvSVEvakp1SER6amZtUjRVVG5ReWM3RW9CV3lQY1VQVENXTGw5ZkdF?=
 =?utf-8?B?WlE5cnFSVDlOOWRHcTJtOHZSRXVjd00wRWFGYk9Qdm5jZHNVaE85RzJmVCtO?=
 =?utf-8?B?RTNreDhucHJRUmpmQkkrVlBqR0QyN29YVTdMblp0bDh2Vm1DTjJOMkhISFpv?=
 =?utf-8?B?N0pZSkwxaUpyTWsvcHJDSU1DUVNVVVBjZkNaUE1ZTCtoWk9sdDNEL2NueDZr?=
 =?utf-8?B?bWl6M2ZUVUdoUG9udWxTeDlEZW1mak4zazh4M0lKNnUyaWcwdTVRWWMvdC9h?=
 =?utf-8?B?Qm1LYlgvTGpheWErZFVWS3A5RnJnOXpGSzFpL1ZsTG5zMkNicXEwYUhnakVv?=
 =?utf-8?B?UnFoNjlrSTJRYkJrdDJRN3hCUHdvdVhpZVlHNmZLTlNnOWtpVGtMYUZkRUhw?=
 =?utf-8?B?MTFqbWU5Ris1TEZlNW1RanRKMkdobkM4QnBlRUdXZ2tTSEZWZjJXS3lWR0Zt?=
 =?utf-8?B?UjRmTit4bzdMMXNxQXk0QTR5eE1Da2p4OTZ4ZS9yNi83dGJ6ZE5tZ01MVjNq?=
 =?utf-8?B?Rm9PcjVHLy9tQThGdjRFNE5idGhGK2NtKytMR0ZuOXNEUFVxN2tDbmtYUjl0?=
 =?utf-8?B?aGlILytMRHluYnpXRUtDbUtkM1hCeTlQL0ROQ0xuaGp3TCtBREVBVVVINm04?=
 =?utf-8?B?bUZheXNxMk14OW5FRCt6K3ozUHFNZ2FQZTFNbkRvd20xTnBuMUhieWgxRVJS?=
 =?utf-8?B?WXpPR2lNZGt3RzNtMzBYQlF3eHVyeHJTMFYwV01RT3E3U3VkSzUxeHdCRVcy?=
 =?utf-8?B?QjNlbWdKMzlzUFRMNFR2dUJFYkgzWlVobVpYZjBVMFNoeWdQUm5Zc1IzOTFv?=
 =?utf-8?B?aEl1NklaT2lWWXc4em9RZSs5U0doc241L3VzSjdmNjVta0FaSzRaZHUvcmpw?=
 =?utf-8?B?QUFYQlQrZFFjMkZzSXdRcUJrWFlqY0p0RXdDSnNES2owZDNma0llTzJ0ekkw?=
 =?utf-8?B?Lytsenk2MFpFRkxHcjJ5MUYwdi9peTJFMHZ6TVlnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmlsNlhKYU5lT3VWSHZCV05CYXZsN29sTmI3L1JpNldjcUFFaVl1eHpHUjhY?=
 =?utf-8?B?NktlMEkwRXdTVXJEalF2TUJhUGFiZkJVaVVKaWFtR01HWUkwVVAzRUxjTllY?=
 =?utf-8?B?MlMvRm5IWXZlYXlsdHhvbUUyMHVGdmlRSHBCaUNhUG5kY1RrNlZ1c0NhUWxZ?=
 =?utf-8?B?YjJiQU5kMkN0blVPWjVmQWNpQzZiSjVUaHlndHpZOXkreHBXM2xqK08vMk96?=
 =?utf-8?B?Q1lhQVdibWREazA5akZtTEIzVno3M2VwNzRuVEVtbXk5d2pKTGZNSG1sQzR5?=
 =?utf-8?B?UjFZTk5qNXh0cW51ellObE9hTnZBbEdQNGFEakp1eUJlNmt5N0xKeDZrb0FP?=
 =?utf-8?B?R2tucWFhVWZNV2Ezc1FmUENaYW5rU0hvSUkyc29VZnZvRWJLWUlOTW4yUXNm?=
 =?utf-8?B?U21CdTkveGN0UHNXMmpIalAxb1lpWExueTN5cEt4NVZiNG15VnIvNGNwY1Jl?=
 =?utf-8?B?VjNlN0xzdTdKQkY1WnBvc0o1R2VvekI0dmdrK294OS80TENRNVRqVVplSzJH?=
 =?utf-8?B?NWZqMW4xKzhYZzJhbERvYitoZDBUNVZnQUduZXRsVEZwUVZLQ3dFZndFbXhm?=
 =?utf-8?B?UFcxTmFMcmk4OGJLT09GZHZ5UE1DUWY3NmxUMFZ1dFlkYTNiUVBnTm9mblNI?=
 =?utf-8?B?a0xZbjZhQUxnUGxYS2IyM3lLbGdOL0VUVjJGYzRUUHU5M09SM0ozRnhma2hS?=
 =?utf-8?B?QUp2T2RqaG4zRHV1ZkxESGl0VmhlTmprSDdwcHV5QTBpL016dW9BQ2Rmellx?=
 =?utf-8?B?N3VzOUhUZTBUamVmN0lsd252Q0FZWlJneEYxUWpHUXh6RDhjL2N3cFo0OWRG?=
 =?utf-8?B?K2FKLzdCeEc4VVVzK3pEV1Njek9IdUExS1JvQUtvTTllQ1hERmFoMEtvbzdO?=
 =?utf-8?B?djZQOFZEOEdzOXNnYy8zcVQxTlhmWFNaaUlvOGFiUTlPb1lMdWZ5Zm9pdG9l?=
 =?utf-8?B?UFlzUHdSOFhUZlMvb1pseml6aWZLM0FaYm0zU2F6V0JjM3lNd2JOdmN5RnZM?=
 =?utf-8?B?Q0xndWJ3Z2JyR240U2JwTjNzQllQYXh4dG03NEZFRWFIbUxrQmRKS1Z4Z2gz?=
 =?utf-8?B?dElHQmtFQUU2OGlubWpuUWY5QXowK0RSY2ZsL0tudjVyOFZaQ0ZGRVF4clZu?=
 =?utf-8?B?QlozY2d4NHR5Qitzcmk1NklseVlhdUNRdE9PbjlXanluek9VVmdMNUNjQk9n?=
 =?utf-8?B?SzVNOVJib00zWERGUUUxVXFtREczdzlnd0E0UVJlYklsbW4wRXRLc3ptSDkx?=
 =?utf-8?B?UHA1R2xoanJ4NndCeDA2VVlIVHhnZEt1cU05N0lGSEcrbDFXV1A0WUd5V0VG?=
 =?utf-8?B?VVRtdFJtekl5cWNPSyt3R0V2Zjl6VW9DbnQzckFERy8xeFBVdzlpeW1iNWxJ?=
 =?utf-8?B?QlNtalpuQ2FFcUg0TS90eVNQYWJ0VnJwMmhPZTJmREFmODFsR3ZDcFhJUDZ4?=
 =?utf-8?B?NFBJNnBBV2dZOHRyUWFkdCtVU0hnSUdGZ2ZDdzF2cG81SmRYWlRIU1lyZEcw?=
 =?utf-8?B?cUUzTFlWRXJSMDVSdmpwNlBTOTZvTnJBODI2R2pJeFdkNWV4US8zdzZuSFMz?=
 =?utf-8?B?bDNPY1lhQzMrOWdjYTdiWEpWbjNsczdTZkVrbWZ1YzlqSWVWeWFpK3UwbGtz?=
 =?utf-8?B?eDgwVGMrQnZXYlVBK1N5ZzFPZnorNjVaZ2JOZzNScm9jbkFuVkFzOEF0dHlZ?=
 =?utf-8?B?SzRnaDErUXZTaWdYZ0FKRWM3MUFFZmVyTHVlS1FxRmZORjh1eThYcUJCakdB?=
 =?utf-8?B?Qzh6dEJ3ekF1cUM1RUhJYlpUa3Yyd1BLcTB2Yk5Ra1k1QVp3ZXNuK1oxeDZX?=
 =?utf-8?B?YTFFcnhpSnBtNUVKOFpnUi9BVHBkRC90ZFlaWjhFUU9wLzNMYnZTaXlla25D?=
 =?utf-8?B?eHhOUU9wYlEwZjl2SE5hK3MzZ0NuOUhCM3FibUMxK3dPN2c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ae55ec-9a59-46be-b911-08de89a90fb8
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:27:17.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB10402
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 7B380309805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

btintel_pcie_submit_rx() reads frbd_index and validates it against
rxq->count. Since rxq->frbds[] and rxq->bufs[] are allocated with
rxq->count entries, valid indices are 0 to rxq->count - 1. The current
check uses > instead of >=, allowing frbd_index == rxq->count through.

This causes an out-of-bounds access in btintel_pcie_prepare_rx() when
writing to rxq->bufs[frbd_index] and rxq->frbds[frbd_index].

Fix by using >= so that frbd_index == rxq->count is correctly rejected.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..cbadcfe86321 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -460,7 +460,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 
 	frbd_index = data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
 
-	if (frbd_index > rxq->count)
+	if (frbd_index >= rxq->count)
 		return -ERANGE;
 
 	/* Prepare for RX submit. It updates the FRBD with the address of DMA

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-fixes-8c301e8881f0

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


