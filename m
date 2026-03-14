Return-Path: <stable+bounces-225413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PbLFz8vtWkXxQAAu9opvQ
	(envelope-from <stable+bounces-225413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 10:49:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9D28C858
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 10:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6A2300AB3D
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8A1427A;
	Sat, 14 Mar 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VdmynsFA"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010022.outbound.protection.outlook.com [52.103.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDA22256F;
	Sat, 14 Mar 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481547; cv=fail; b=gRPkzVmoD+J6ujkT85Ktg62ZOYpT2E+DufktAl6Zp4Rz1dFxy0Y0+N8IFKeEAe8GtDtJQ6O1fhxs777phEoFv+Ltk1f/0llhoP8PBegac8WrjU1r6a0hkFLPEAldQwKSo5N/j5sWA3GeXFqZtEw4OEbU+MWr9FUt1yOHgk9DwR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481547; c=relaxed/simple;
	bh=wtiz7Yt6lnXYYzThiRjSb2F2qaOn6hwNuvMfXQ/CMr8=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=eJJngcGbQG9/dVOEuAQetsvk8UusyYDdobM0d1h2Ls2LDOrsxi0HBjbjD3O1vp4dd3RC9qXaCvpwgSqoib5PJIm+CsLAHrW8YckaTNbg0xqLZ0vhux3ZDiTDVbiGM/hk+9bGtR4QRlE5jZk1BDSoAp4ODxkVmY2xcxArvtIDjjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VdmynsFA; arc=fail smtp.client-ip=52.103.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL56+cHDIbJAdO/rfevletVLhr0vo9e2SGmr6cYZblK3VkpgxXb86hzafYmnt/7w9uM6Gq+fLvHen11c6WEXUm3YizqDFlSB8ltzVoOplVYJvZMJd/KL0v+IM4/HwGkrs6j0Z+5VBkeKjVX7oA9e+huVv9ILbcEjlWFeaTqGsQ4XkqtvRR3oxsu6JFJWFy/IBgcC3wtmpIc7UrXGi/vGBOzJzM8JunRqqEGbTs+G8K1l1CTMHh500wCHHvF3bgIP0v3jNFSiF52Q2MpSAJByaV3dA4got6sRyUONtOGVv88LrwbCjmJgrpOkfngpe0u8IEaTLzPDsV2Gq5mgPn8Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akZGKYQSVl93tDg3LUmChBVgAXuy88SUG2bJhkdqVTU=;
 b=ChunuKYak0JYSK0a1eJi/x9QaIikpr4Hlv5lDj7Ulys8pjTPE0dJBJ0JD1qH+mTOfp/XTZeJ14v3z8twyzrLvk/zK3opLZXbrGE9qyHAcowbTsy+phTtAYNKAZtoB4x4qMpzcd3LL0bRCUnVYLAMJBP80pS/pbI6kjVFJREn9/33mcbn4AkLjXCMXEwleG19D4EDZXXC1vxs+2m6g4Syy+ySjPslzO2IaFa5sRdKNhidHtDSqJlqPqYAfA1cUGmUH+DlVMfsEvE/XOZoN4hVPHPB7cneuy0iq2wK2FmjHjnbJnhGBn+XwxHj/M46G+n0YehL/43hJ8/DbKMfy0p1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akZGKYQSVl93tDg3LUmChBVgAXuy88SUG2bJhkdqVTU=;
 b=VdmynsFAD1neeec2qvypEXDpRFgysF1VvvguC7U/6E1at4TCiiKI0lMtVLraroEl+n0LrWzoBRREO45eDXpAHF5VZQy/mm5VcKA5beOU3fkf9EnN9XdE5cFODEeYe1b/SX6h5N7iJ9vb5mnsetujy9H9touL3OoANZdIgxogk0cUQ0rSl3CJjA2fVptMmvaxmkdBgF9qT6pw205pCT4tWU3Db0kKapNegCMZ6bIED3X7RnXkf8mN9luQa6Y6stlpoLd1sXgQ0gQUz8gWnb9mo7ei3bypPF3RQ1Kc+4tDVBwkhrAZjBblTGD72PSuCsb8+IiyYRFLRo65bnN8aNGqAg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYZPR01MB7785.ausprd01.prod.outlook.com (2603:10c6:10:169::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Sat, 14 Mar
 2026 09:45:38 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.018; Sat, 14 Mar 2026
 09:45:38 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 14 Mar 2026 17:41:04 +0800
Subject: [PATCH net v3] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NwQ7CIAwG4FdZehZDh2yLJ9/D7ACjc0QFA0g0y
 95dtpvGU/O3X/7OEClYinCsZgiUbbTelYC7CoZJuQsxa0qGmtcNFyjYaF8UGeF4MKjUqJGg2Ee
 g7VDoGRyldZcF9GVMNiYf3tuHjBv4KcvIkIkOjcR2qEl3J/9MN++v+8Hf16Z/XqpO87ZpSWr55
 ftlWT5LS0pT1wAAAA==
X-Change-ID: 20260313-fixes-e1f4d1aafb1e
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shruti Parab <shruti.parab@broadcom.com>, 
 Hongguang Gao <hongguang.gao@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=wtiz7Yt6lnXYYzThiRjSb2F2qaOn6hwNuvMfXQ/CMr8=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhsytuvptMXHz67epBAYY8l5UiZz9f4+f6pWjb378cHP5x
 vT3g7BdRykLgxgXg6yYIsvxgkvfLHy36G7x2ZIMM4eVCWQIAxenAEzk4zxGhscvX6e6cidONyw0
 sn7vxeAfVeT6pSnw3XZpBhnL+hsu7owM+47fEPonNW3Vi603PLfOmMgQsM6P+VbBKjUbX/bXwpO
 TGAA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260314-fixes-v1-1-9d9a143896c7@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYZPR01MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4ab6a4-94a9-4350-249d-08de81ae7281
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|13031999003|5072599009|5062599005|23021999003|51005399006|15080799012|6090799003|22091999003|12121999013|19110799012|24121999003|10035399007|3412199025|4302099013|440099028|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1NINXVXdVFPNnpqK2ZLQlNYU0N0a1Y0S0kwT0N6RW85TVh2YzZtRnFDZ0hF?=
 =?utf-8?B?dyt5dER5enpzdjdzdGFWZXZrczdyRE84alBSK0gwQTZnazRMZUw1cjdjcW4z?=
 =?utf-8?B?MDViV2tIZHVEdWVhemhqaW9FemF1U2JDTEs4SjRVeWNVK1RTejlnb0F0ODV2?=
 =?utf-8?B?TXpqMGRIUkNLbmpoOXVzMktad1F2MnIrUGdJb2FKeFhveWNvdW5VYnZpY2No?=
 =?utf-8?B?c0ZBTEF2Zk1hMUgrNi91M2VUWHdDbjAwRnQrc01xUHRKVEtnMkVvOHVkN1hR?=
 =?utf-8?B?VnAySzlYd3VIQXVUY20zRVZ2SDhiTEZwQVNZdElndzcvYzhwRVQvM09xWXNY?=
 =?utf-8?B?cDlOU1A4NkFjWnRDUklIWDVYUzhiYUFPNzZZVkJodDM0YlcvRCtWaWN5TWsz?=
 =?utf-8?B?eThBNXd1SHFaMy9PazM5UWVwZE5uQWMzdXFSdExWZ1c3M1N2d2VleUhONjBE?=
 =?utf-8?B?enliVVRqNGRRRGgwSlhNSlFGUWNoTnp3UGkwMWxvMFlVR3pmeGdXdjFhUEhW?=
 =?utf-8?B?UnB1U1I0ZmFaVVZYSGM0dmtKVHlLZitnVjJpNGduK1IrcUFlSzVlaEs1cWFl?=
 =?utf-8?B?a2FXclRpV0hqSmFzcURWWUEraisxU0RGYlhYOWFhcDZHdUtERkZmbDRpOUZP?=
 =?utf-8?B?clo4THY5OUVTUWRobVRBVmwvcDVSQnk1VFE4YjV2SGo2aUhnZ2pjZFYzdTVv?=
 =?utf-8?B?ekQyaFpJWWJmRGVWT0JTaHNrU0FjemVoU29TSHdNODgyblN1bVVVMnJXOEZj?=
 =?utf-8?B?VmdEdmk5Q1ZKOENMcndFMVoxdk1XYlFiT0ZNRFlpL0w3c1p0NGNVS0J5NGJD?=
 =?utf-8?B?bFZ2ejlBVFhvWS9nSGRmNFdFakpQbXBTQ2lreVBaWmlOWDMvRmlIS081aWJ4?=
 =?utf-8?B?TWw0akRwMktBWWRlOHJaTEJMVkFVTjBYaCtXa1hDTnAweVNSSFlPYmV6V0Fa?=
 =?utf-8?B?MjFmVjd0RkpiRGNNUnl6Rjd1a1hLWWcvM2xjdGhvbDVMa3FBeUpEMlh0Q0Rt?=
 =?utf-8?B?TXVYek45dkpNcmZRRlJoMlJ0WklmcDJjVzI4d2RuT3FTUGtyKzdURWM4bFBE?=
 =?utf-8?B?eHplOU9MV2pqSVp6TGVTWHNOb05uWi83YW5GTktjUG5UVFZGRmxrdzBYRitH?=
 =?utf-8?B?RHFTWDhVV2lVNXh5UG9OS2NjTnNpNXhKbjZ2TFNMSkhiZ0luUktKYjliaFRp?=
 =?utf-8?B?TkcvSktrcnhleDJMTGtRRUZZQkQrRDlKSmVzZURhaWJVY3lqd25sajNNNXJQ?=
 =?utf-8?B?RGU2Nk1vWGJCc2xQYVBmTTNydVhvRU13Nkd2dGp3NmJyWndVdjRSOWIvUm1z?=
 =?utf-8?B?a2NQZHZBV2ZNTndOMnhYTnhHVW1OcDlsTlV2N0R3bXpIQW9NRG1LRytzZ1Rk?=
 =?utf-8?B?SGJPNzcwWWZEVWltanFRc2RIeGkxWmcrUmVhdHJBNFRGSExVR2dsb1dDNnh0?=
 =?utf-8?B?VTVqS2NSczJYVDhBa2haM0JLZ3JxanZMTVorSHlya0VYb1VyUDVKRzdaMEZQ?=
 =?utf-8?B?VHVIeVFWOXhBVzRlVmhjUHJ4aUs2WkNNQTExRnY3UXcxZ04yK3RPVWszeURC?=
 =?utf-8?B?YUpSUEx3bk9waWJWMXZBb3RCKytWL2NMOGducDNURFA4ejd5aG9QQWRrejZa?=
 =?utf-8?B?TDExLzhTZGRzTzZKTmFHd3lCVDduUlM1bHV0Rld2THovODJPVWFIMEtLUkdl?=
 =?utf-8?Q?F9iNCd8Wn4jeZGotrg7K?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnJCdGZHWTByQmxMRFBQUUhBMFlFblVRdVhKWDBBQ2FTUUl3S0ppYitLUWw3?=
 =?utf-8?B?OUNaZWRGc2RsTEU5UFBSTUt0UzkybHlYY2NBZXY5ZkYrT2s4c0d6WkoxSDB5?=
 =?utf-8?B?c3pXeE1YeE5aaFJUL0tyZ2FuU2tpNElFQy9GS01JQ29mb1BBQ1UzTHEvRlZl?=
 =?utf-8?B?c25rRW1QR2JuRTBEK0JZczR5cEVoM2lDYWYwYU45b2FOR3NERUtYU21TeHBE?=
 =?utf-8?B?RnpNNnV3R0NDNnlSa3h0TTlJdWYyRXNPRTN3aHJyY3dSUkNaU1IrYXJlbEU4?=
 =?utf-8?B?NDVSN3hkS1l0N2hWSFJYLytyNGp5ZnlvODFuU0taWXdyRkZnSzZvaGNqdXpj?=
 =?utf-8?B?MkNIOEl3eXRkc1F3bkw0MitML01SSldPS3lHK3Bla2VYZ2FuaXA1WXBiTklZ?=
 =?utf-8?B?aElwQnd5ZXh5TExVYUhqS2NXR24vWG81bTR1TFc2b2dsM2lTSWRNb0F4OHZm?=
 =?utf-8?B?VjRVMUtkVlVKKzZzRjA2NnBNaDFiMkIwV3ZEQlRhUnprdzlMVXV6TlFJdmM1?=
 =?utf-8?B?NlFHeTNpR0pqWXhuT3ZWUnQwYzluUDlnczNkZWtUZ2ZOdTYweHVLekJQdTEy?=
 =?utf-8?B?ODRMdGRPc1B0WTh5bi8zUGVXU3JmMDNZT0ErNUVTSU9LdUxRTHFxSU5iMXJk?=
 =?utf-8?B?dHNUcXd6R21Qdnp1M09lK2R1R1BGbmkyK1BSTXF4NGhETHZYc0x5VmpNa2NN?=
 =?utf-8?B?aEZmS1NIYTFYMHl5dTN0V2RlN000bWlINGFUajl1UHNrSWlsTTNTSHpudWw3?=
 =?utf-8?B?REdWYUg5THdIS1k4eGdJSnd3WnUzclJPdFArVkkxanZOeGhuaWdVQXNiTDJx?=
 =?utf-8?B?L2tWenIzMWcwMFYyREd0ak1Bc2x2bE84bzZ2UkhGcmEvTWd6VXFkYkI1cWhP?=
 =?utf-8?B?Z0h3eWhRKytvV3poVnhiRDF0RXJ3WGM3T0hQcUVxNDQ2VlNOamwvQUJDQnl5?=
 =?utf-8?B?bHFXd3FDdjFqOTBFVXZFNE90UXhSM2ZNNWRYOVQ1dEVaTHYzR0RSQ01UWk5o?=
 =?utf-8?B?UW8rM0FFOVg5by9FNksyanhKWWt2cFh4N2QyeS9KVHg0ekt6cFdHcXUwWGZl?=
 =?utf-8?B?bnplTVhWMk4xaTFWVnl3U2ZobUp6dG4wbXpkaDJjSHNvdlJYelNJNnFKUlEy?=
 =?utf-8?B?SDlZbHdlNzRnZHpxYWRLUEkrRG9kZTdPWWJOWTYrY0M5L2VTdlFvUUxNakdT?=
 =?utf-8?B?WlhUQjVHZVV6cU9HTEgwOG0zV0lnVTV5NUJ1UWR3akNIYW5wNlFxSWdJZXBj?=
 =?utf-8?B?OGR5Ym1DSXZnUkpOSlZoN2lXc2pYVkpWRkZ5emJna2x3RWRiT3BvbFFyNWJM?=
 =?utf-8?B?WUtwSUxrdSsvNWxYUFNxMFJDVmRVY0hLZ3V6b2JxMzhEaVhlMXNBb1o1eWNy?=
 =?utf-8?B?S28zY1pRKytuN3JlTmpVTXJCYVNONjUzbVVtSE5ZTytaeC90Znh3N0Nrc1Bl?=
 =?utf-8?B?aUdvSm5udWY2UXJleXFJclh0Z0JyQzdGK25xSGpkeTNLUUpKVUZLYUxYRlRI?=
 =?utf-8?B?YnB3enZzU3JGNWZ1aDB2VE9BOEZhdDRTdjFNNTJUYmRqZUs1VXArZFdUQkdF?=
 =?utf-8?B?dzg3WnV3WnhkR3lPUjBmZ2UrRnNramxnQ3NnN3U2bkhZTzYzVW5IRFFYRTNm?=
 =?utf-8?B?ZlNwTmhSWFNhc3gxYjR3bHlyVDFtVWgyMGNmaVJ4ZG05dkRiVTY3ZnZZcVBn?=
 =?utf-8?B?V1k5YnZybGU2TVRFdEQ1TFh2VTR0RmtXOHpucVRNM2VCT3hTOURETE00UWd3?=
 =?utf-8?B?QWxwRDhPYnJMaE9NRDZWdXErYkJYaUNwT3R4WTFrMXlOWFlwRzNmMVZtSmhD?=
 =?utf-8?B?cFc3ZUNqNlFmcWVXKzcyY3NEc0tCeFBQbmJTdG50eE5LTTIvTzJuREcya0pY?=
 =?utf-8?Q?MMV+B9Ljgo0DW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4ab6a4-94a9-4350-249d-08de81ae7281
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 09:45:38.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZPR01MB7785
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225413-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SYBPR01MB7881.ausprd01.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: C1A9D28C858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
bnxt_async_event_process() uses a firmware-supplied 'type' field
directly as an index into bp->bs_trace[] without bounds validation.

The 'type' field is a 16-bit value extracted from DMA-mapped completion
ring memory that the NIC writes directly to host RAM. A malicious or
compromised NIC can supply any value from 0 to 65535, causing an
out-of-bounds access into kernel heap memory.

The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_byte
and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
kernel memory corruption or a crash.

Fix by adding a bounds check and defining BNXT_TRACE_MAX as
DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1 to cover all currently
defined firmware trace types (0x0 through 0xc).

Fixes: 84fcd9449fd7 ("bnxt_en: Manage the FW trace context memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v3:
- Define BNXT_TRACE_MAX using DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1
  to clarify the supported trace type range, as suggested by Michael Chan.
- Link to v2: https://lore.kernel.org/all/SYBPR01MB78817D5AED8035071888D7EDAF45A@SYBPR01MB7881.ausprd01.prod.outlook.com/
Changes in v2:
- Use ARRAY_SIZE(bp->bs_trace) instead of BNXT_TRACE_MAX for the
  bounds check, as suggested by Andrew Lunn.
- Link to v1: https://lore.kernel.org/all/SYBPR01MB7881338BC956C39A9848EE86AF45A@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c426a41c3663..0751c0e4581a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2929,6 +2929,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
 		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
 
+		if (type >= ARRAY_SIZE(bp->bs_trace))
+			goto async_event_process_exit;
 		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);
 		goto async_event_process_exit;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9a41b9e0423c..a97d651130df 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2146,7 +2146,7 @@ enum board_idx {
 };
 
 #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
-#define BNXT_TRACE_MAX 11
+#define BNXT_TRACE_MAX (DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1)
 
 struct bnxt_bs_trace_info {
 	u8 *magic_byte;

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-fixes-e1f4d1aafb1e

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


