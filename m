Return-Path: <stable+bounces-246789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KeXKnA8BGoqFgIAu9opvQ
	(envelope-from <stable+bounces-246789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE06530027
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B6DB308E808
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8FB3E3D98;
	Wed, 13 May 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hjKZoq+1"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806C3D75B6;
	Wed, 13 May 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662368; cv=fail; b=SC8+3OiwSh+nPZfxYiZEP2V6HyTy/2V7KGMa3+KaUBsmmnF3Ex2PUOzY5bAp4aYNUeyStauO5MP2WbVdcbGxdxEYOG3dGLQhFjqdnJcVZKIPQI1I6fuh0QldPUbHYHBxrvJc9gEthvk+QsMRve0Y8LcXm/p47MMK7bPDivOAcPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662368; c=relaxed/simple;
	bh=mqMmHe+aw+rPULMGJgGDSNkBzeRU5RPKN2WpWXnM8cg=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=pTcNG0U8I4aSZ49sr/87vjzfPO912LO2G2XmW5y8LA6qZxMXEOuywl8KDlxLCLfprPJBWarPvZHbpG4jRaV/uUY3kfRdi3lnBBQCKd2R4hN00PrypUtsLiKorZIeEHjmPXRIJLbmkNGWuj9IPolkTStCosjzvDoyCGs/ynlR4zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hjKZoq+1; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuxsFjZH8yKvvHYoMkLKOW3N7sF1ZP1yUdSM8FySMsmAsC8YjAfy+EYeoleJi2Mk7hlSaa2+lAYOFYiHirlYG1O4VLE0U13LKEEGsdjX+GCSN2PB3xm8du6Vg+MRfGUKPoWjb80/W6o4kVdDYyE/btRzl2ANJ0nbYAa7/hE54gda5pxqO85VHQ76xcJghBHDVqR4R7iXj/Df8+pO+LS7IHQEhBjnK5YNtxE9W5wnTCy3o73vfiS1YvMyf8RG08TJaRglqpNIPBY1xw76EawNL3BW8r9FFtE1NkCnJck3+lTF1rGkrmNjL9CqAA4KkAZgpm6My6dK5Ev/s12JRlSVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zED0R+JxsSER9TSRZZFwlhTOXRjpk8TFf7yR0vqUMV4=;
 b=ax45vNkClyOXIwnj5LWSG4ZqeoULHZhdAj7smKxvfqrrBmP717Wp8lzcHXBy/lmARJY7UDdrFKW+hwlzv9Q1EOVBHCUj5p3YWqp7FUBfPyorq4gVTlrekSY7u+Ohgh5YwAlwvur9xEdBKlLUVDWpjBak0R75Y5MRga2VHOK+OD6jbYm/hlRXAg3sLaw1nOWiOQC0lLvszxpuUHDnN/2Ab34gA5btCDhhraloXWlspom7SUb7FEHjctFP9udnUBPwi7UCSwipgqc24Ml0ZdNrcso30wQeH0zgvu76OtwMwZNh6FxSaRDWufP8bWajeaVlIvjJfpkRFwrAhh7WjNadgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zED0R+JxsSER9TSRZZFwlhTOXRjpk8TFf7yR0vqUMV4=;
 b=hjKZoq+1ZKcVYQjs6xx2IxaSHjsrFdV1Ns/MUvF+5FAF+tDIc1609nWua0cGm/UWFkxjPziSY7KnOnxnoOkuOu4XbruCGudSA6ByCdqCysHZfUbSAvDtHjvDtDuFXZK9NzOT33ayRN5dHwo63yVGc2BEIH5HGhgRP7HKxreAIpvE02WVKEhEBpKQM7ETbNSy8RVK9zOF0nWzpkVRB4Rfv9xKc48avWJoEqI03scSHBPS78oLZsIJGmgiFFkuDGMZo1cWCIuvGfHdPLEgeopr6E5fhKMLKjDWxxyE249+UAuFG9/6jVg/l/ld4w7fCpcX53FO8dg4y/0fSBIA5/xtuA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB5600.ausprd01.prod.outlook.com (2603:10c6:10:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 08:52:41 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 08:52:41 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 13 May 2026 16:51:50 +0800
Subject: [PATCH net] iavf: validate num_vsis in
 VIRTCHNL_OP_GET_VF_RESOURCES response
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881AF11C45AEDC0D4CA89C1AF062@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAKU7BGoC/x3KQQqAIBBA0avIrBN0QqGuEi3ExpqNhUYE4t0bW
 j7+b1CpMFWYVYNCD1c+s8AOCuIR8k6aNzGgQW+cHXXil6pGTxGnFJwJDuS9Cv1B1gUy3bD2/gH
 Q8ggxXAAAAA==
X-Change-ID: 20260513-fixes-26ec29fa50a5
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mitch Williams <mitch.a.williams@intel.com>, 
 Greg Rose <gregory.v.rose@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=mqMmHe+aw+rPULMGJgGDSNkBzeRU5RPKN2WpWXnM8cg=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLBbrpataXt3Wu89TwTPX2NJl0Y/EXRLibcazNbJuf
 9Wa+MFO6FRHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATETuJSPDMUXVhC3HJ6/I
 EprT9f3B6meNIv8z5gdG3SjZnj95xmab3wz/0y6kfm6W2rbWzOWZQufNsODnBeUqPMeygt7e2zo
 9anMwPwBRhUyp
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::13) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260513-fixes-v1-1-e87ba5993191@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 140bada4-a5f3-4cd8-0a02-08deb0ccfd4c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|55001999006|24121999003|24021099003|22091999003|5072599009|8060799015|15080799012|6090799003|19110799012|23021999003|52005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGRJZXowN2oyS2FlVGZFVGhVSXRQbzRsTUJRSlhFWit4aUU4eVdWaW85elhL?=
 =?utf-8?B?WFdlYWRoMkxsVzVjNVBqUG4yM1JmWVJ0K1kvcTRYaXFIWlZXdmR5SHVQR2RS?=
 =?utf-8?B?TU83c1RlMDMxbGhtVlIrWlpPNldrMXZhc0xCeldMT1ZPR1pOeHBYMVhCeFkx?=
 =?utf-8?B?K0tlbHdrZUtnTkdncitnNHFubzdlc3lpT3psTmEzaURUTGJxTUR0Zk91VnRV?=
 =?utf-8?B?QktQZW5ucDVLZ0J2ck41K3d1TU5aaVF2Nlkyc0xKbzg0MzdpUkJWRE1OQnpv?=
 =?utf-8?B?SDhzZkZxVWo5Wm1NdlcvenNtSWVGamtYVVpXMGMxd1pDUWVaM1R3UDluOE1T?=
 =?utf-8?B?R3BxWDJnOTc4MEZwYWFWMHpWb0FqY3I1SEV1UUxxNmNZZklueXh1dzdzMnU2?=
 =?utf-8?B?VkRCOGZLNFprd1dvOWdmaTBGT0dYKzBmRFRhYnpxSmlmNnhkbmcxZ3o4Nkgy?=
 =?utf-8?B?cE9tWWFjUlg5d0VpMktZVVRFWEQ2VkJ0US8vVElTWVF5S2tFR3QyajhFWmNj?=
 =?utf-8?B?YXJhL2hVY2E1NlRBY3FyQXdkeGViNU83SlB1ZEFBclcwWUtKL1RnZkdjSk8x?=
 =?utf-8?B?d21iV3pUSVU0Q1c0UllSZHVlSHNtRDZJZnErRU4xanovMFpieEZlZ3dMNFND?=
 =?utf-8?B?TWlCSWNPRTUwcDI3aGd1SThwQVFkOHdPekozMjZQVWErN2VlamwrazZoYmh2?=
 =?utf-8?B?MVpHWUhiKzZ5SjNPTDRlYkNSS29Xa1poMm1UcUo5eWtabmdYQWxXcWpYM2hG?=
 =?utf-8?B?cDVoN2YxbXVwM09ZZEdoWVpMek1tUmdPOHA2cFNkSGxrNEJ2cjlvQ2VtQ3Nz?=
 =?utf-8?B?dFNOTDI3bmp0OFRpdCt6MllHR1VNRXJHbExOTXc1VWpxNm1PTkFkbHpHNTRX?=
 =?utf-8?B?Z2Z2YmFBZWYzaENlNTNoQS8xbUxRWmFHTWdQU0l1RlppM1dBeVZVZ3habWFs?=
 =?utf-8?B?WkR6WU5LMzg3L3hudUs0QUR3ZFRPL1VQQWJxdDlJNldSWXJYN3hyamFIYjU2?=
 =?utf-8?B?N2gyUXVHVSt5cExnK2ZCZEtzUlJZbitjUUNnNnl4T2l3MjF4bW9rMWQ3Ym5E?=
 =?utf-8?B?ak4xT1FjbmF5TGw3T00xRE1jTEdsNFN5eWpGNTNLeUVQVWt4Um5wcGRxbklX?=
 =?utf-8?B?YVozSU5laS9yNjRQeGxScFVJbjdGNjFoY2ZVbWh0TGdOWGVKQXBhWklFTlZP?=
 =?utf-8?B?cWxneHc0OElSckFZSmh5SFRVbTcvUFU0WUFKYkZUbDNTZ28yQXNJUjF1MlQ4?=
 =?utf-8?B?STVUY0tFY1FhMXY5WVJZb1UyVjk1cWxGU0kyZ2NQSXZMN3BmYzdkKzd0SGVR?=
 =?utf-8?B?T2gwMjRSK3p3OWNzT3hqYXhWN2dzUFE5UE1FTnJ3b2kxWTJwMzZtZ1VjbFB0?=
 =?utf-8?B?anRxQkVkbmlaa3M1RXZBZTNEVlRZc2hMNWNWc1l4eVZxOVIyZXlVQXBWcW9p?=
 =?utf-8?B?NCtaNU5ObUd4cTJKUk15ZVlXNitnWGljNUUvYmpxYUx6MCs0Nng0TzZza3V4?=
 =?utf-8?Q?IuDbOuATPXQ2X+SFuFsr9zBuGro?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xLU2RxNFBzeXB3VnFDbHlBTEFxRExGWWFPMktDUzBSaWY2SnZjK2hFYXk2?=
 =?utf-8?B?bkFsOU5icjZkSk5qOG5wSjdnV0ZRT0hscHRHRnRpSFdxNXk3NnE2anhBWEZV?=
 =?utf-8?B?N2ZaRkxmTGFURXkybGhNOXJrbUJ2OEdqMmtsM1NEL3N5OUVla0hGZCtJdlFX?=
 =?utf-8?B?bXl3RlRnN2xoRGJJbGtHZXlMNTNWWUNMRi9nb0dkU2VucGtFb0VaK054RVNX?=
 =?utf-8?B?UmtwS2lCQ25ROWh1bng5ZWlvSkpvcC9TZ3pVMWFTNllzV3oxWG1vbFJVZzF5?=
 =?utf-8?B?eE1ubkZDYXV2QUNiS3Y4SzEvQlkzY3lTZHArM0FwclZvbUxkNjB2VzB3Y3JI?=
 =?utf-8?B?WTZ6YmNJTFZaWE1CYlVSZmp0dUhRcVdQU01oYlY5alBxc2RVdGtVQ3BDSkNk?=
 =?utf-8?B?QXllNVd4K0N3Z2dUcm1WYytyOWt6WWN6Q1RYT3NCb1orZ3dreGp5eC84MDE5?=
 =?utf-8?B?U3VFNjRERS9yRjNtNnNYZk8xOGR4RmVYUXhobG1lbDBqZThoWHlqdGtaYWZx?=
 =?utf-8?B?ZHkxU3pKK0NPU3YyWEttbmJhNVoySW9UU0c2eWRNaGp4eUs4UFNycjdSSlE1?=
 =?utf-8?B?UDd2dnNkcU5KOVNkVUdEaDhISzZMZzlGenBxNmROYVRMTWk2ODlNQjN5MlJp?=
 =?utf-8?B?Q2JGNk9ZTGJZRG1ESVo3UjU0TVZOUjFPVWpEdlZyNVJCQ1B0c2g0SFVEUExI?=
 =?utf-8?B?MXBqOHlXdjc0WE9nQjBqOXhsWi9PbjRrRHg0N2QvcHFPVXBoeDNtaHZ3TEE1?=
 =?utf-8?B?LzdNckNkUW5GWTN6Q0IrSGNubzRLOGZQMU11ODlMU2dyUFFMVmQyaHd1dlJt?=
 =?utf-8?B?bG9CRzlDYXpKZnRKQ3U5YnVJNGU2M1hNeWNIZi9oZUlEeGhDa3FXOWJTd3Vv?=
 =?utf-8?B?Wjk3TWdoa1MyenZIZlk0MStHSDlnbDNNckZXVFZ4Q3pQTzJKVWhRTmpHZXcx?=
 =?utf-8?B?Y3VpOGtLUzUvS3Y5OWlYWTMvZVREdDhXa3BSdTZMcjhoM215WU9WV013UWJ5?=
 =?utf-8?B?TVB3b3o0OEJvUWRHMThacExFNTVFTlZtY0pNditYckxnV2pnV2JUbm9YYy9j?=
 =?utf-8?B?NFRlZjd4OG80UVZoS1VoT2ozeUxFcktiTStScjZKRm1mcVJqTE9CQk02RzNR?=
 =?utf-8?B?VFFmSk1mdzdGRDAxWmhkVEF1S0s1RzBEaFo2RlJxQzNROVp0ZDhPVVFiSnd3?=
 =?utf-8?B?ZlhvVDRHb1RxVGh1ZlRISit4RVVkeWlpTDMrN2RwSk1tblVMK0hKOE9BU01y?=
 =?utf-8?B?bytqZnFUS2QxWXY4djZFanE3Y2RHcHJ1L3Z4OVhoQnc1UE91dkFiRFpvMWV4?=
 =?utf-8?B?YXRJL3l4b0Z0YXJsTVpzcFVyOHhodkZPN0x6UzlKZ1dmMGdLQUppZkV0eWQ5?=
 =?utf-8?B?aG42VE5uOTAzeGZkUXBTMC9oaGRzcU9ReEFNa3Y0RTB3TmZZMWErWndIVFo3?=
 =?utf-8?B?M0dsbGtOYXE2bmNkbUN4QlhWV2RGZlNYUEdXSmRXN0pXc0FVck9GZ252b3lX?=
 =?utf-8?B?Y0lwSVhjMTFNQzJaRTB3cys0ekt6QllaekNDd284L3FTa0xUZER2S0tESVdh?=
 =?utf-8?B?cjc3TDJxTEFZU1F4UURGVk5FV0FOdnNoeVpRU0pxbzRqWWtWWHFrNFJ4NzhC?=
 =?utf-8?B?SlJSNFp0QlBQTmdYN0lhTWkySjROTDR2aVdnK0w0d09nZXdkckFESElhUG5x?=
 =?utf-8?B?dnhaZGw1KzFWb3RHYUc0ZW14L0R3TUpESWFZNmtIeWY5STR6bWQvZWVnSENS?=
 =?utf-8?B?SlZMKzNpS0JqeUJVTm5zTzkxOC9EWGNLVmlJbTY3eWRlQXdMZ0x1WHNYQ0ZO?=
 =?utf-8?B?ZHNPbTljb0lRaGtqRjlxaWhjQ0ErLzNPVmt0cmVVdG4vRXlDR3VtaWJPMGY1?=
 =?utf-8?Q?Myby0QtHAKttp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140bada4-a5f3-4cd8-0a02-08deb0ccfd4c
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:52:41.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB5600
X-Rspamd-Queue-Id: 4BE06530027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246789-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Action: no action

The VF allocates a fixed-size buffer for IAVF_MAX_VF_VSI (3) VSI
entries when processing a VIRTCHNL_OP_GET_VF_RESOURCES response from
the PF. However, num_vsis from the PF response is used unchecked as
the loop bound when iterating over vsi_res[] in multiple functions.

A PF sending num_vsis greater than IAVF_MAX_VF_VSI leads to
out-of-bounds accesses on the vsi_res[] array.

Clamp num_vsis to IAVF_MAX_VF_VSI in iavf_validate_num_queues(),
following the same pattern already used for num_queue_pairs.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a52c100dcbc5..2ebfb65a6f3b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -254,6 +254,12 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
+	if (adapter->vf_res->num_vsis > IAVF_MAX_VF_VSI) {
+		dev_info(&adapter->pdev->dev, "Received %d VSIs, but can only have a max of %d\n",
+			 adapter->vf_res->num_vsis, IAVF_MAX_VF_VSI);
+		adapter->vf_res->num_vsis = IAVF_MAX_VF_VSI;
+	}
+
 	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260513-fixes-26ec29fa50a5

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


