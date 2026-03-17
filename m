Return-Path: <stable+bounces-225747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCkSCPTyuGncmAEAu9opvQ
	(envelope-from <stable+bounces-225747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:21:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FE2A442B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6F5302205C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2D37C921;
	Tue, 17 Mar 2026 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dNVQnQzq"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010011.outbound.protection.outlook.com [52.103.73.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95037F744;
	Tue, 17 Mar 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728469; cv=fail; b=OpRaQTuwHDWhCxFEKv4O3QWTeaT8oF+jnIDBWx9n6SGvZ1zyHAAZEwhyYVooJ6wBbsvhM7yTnhAK5KZoty7dCCxVH19LlNtUcCysI0/lJTNa+8Iqpe6Mdxv6mM17SgyLsqWdUmhLVq0hwqv/JvsFPGcce3837tV8E4LJq6GF0kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728469; c=relaxed/simple;
	bh=x13RR5UjNqv/2t8FV7UVXxzb3o04spgJerzuD/ZlLwM=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=cPSBtmm8G0DNwUDm+d1XDnaml03jRjS8Bepa65yK1f4ezQKN4CCRaW5YO1g78goz85BGA/tvaG7CwIxlZ/1XvwzhtAI8bP3T6ZrkzH+KiDuMe6/L0+DqFEDLTatr7BxIMJyLQK7HQ0Z7PlOrCR08ipDcUcTIcinsi7sFT90rQi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dNVQnQzq; arc=fail smtp.client-ip=52.103.73.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP+0SnkFM08/lT0ehZAW0Qa/mw0JjoSu042OjGXCFw9VFl63iudgeusANjCOQoKaUtfgaXadanVOIrZG18I5AN+HjveypRet1tkz5FLTG25oSVbaNZwiubTWGJ7WzMbYx6NXEKgd9NyAkne+oIZBS+xGdWiS7x0Z0gCYnxGzVXRukSbD0/cmX9H4uWVwfDi6FtQ7x6qidBWXTEf81ClCTdRtkots2yMfoG8CdgVRRkZUL44AnSv7YfX7xlDo4+1v0fcyG/Fi5+5RymUXdYRO+a+/9mppUKb/oSEqbw9UQk7uSOLqFsC5sPCuh+GpzlzZAJx0QTQmB9Rvbqb9sKv66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnm9+PHxXTOS9hVD+kULQsaFbmbyjZo9YlWumifT40I=;
 b=BgAvUVwoAnLmGmX602Ha7sDRQqgiSW/y6V1hgQbUqS4ebvbO6nWOAvZeFdYgIEmuc3uRNQdGgoBOcog+f0m73iufWJjvzz/RXBLeyJQb4ckuJSjWg8xESPK8RqLPl273iHAjJ2mrt12NT+hDfCfh9RwDFOOEyZn54UnvRuK3MnbSSePFoE68KnNtM7g/TZftiJOaIQ3x9IlRU0fjkJVz8Adh+dxx33XcxY/3L1kl8cL2dUrHHCWijqRbX1TUqnXBBLF/z7PAciI73qPdKl4KqbKDujx+b76uiGl+dNC2nVh+nNxeBeLCfh9qWjIAl/TEwiztDlxWqfx/nxCU9MjcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnm9+PHxXTOS9hVD+kULQsaFbmbyjZo9YlWumifT40I=;
 b=dNVQnQzqfwzoI7gNxXELi7QJDHLjwz+FWZFITBat0VvwQ/cUFDPxs+6c7PIQSzvAZLoNA2SrPK0w+OWDaVTdoFTKjOLCTm9Yus8utZnidLaeoTadEhEEL2buAuCoUDOh1/xd3h6gr43bfzEdMmS1TohvwJzPQE/sCbOnjQustgDGJk8x+KRlb+p+yBA4ibh97BTB1LS5ZqDpp+rUm4Cqe+Z2LCBBOLCR30rQSsy+d3WypOE9D+6OLq73D77+Pj59TlE4+p4pRi1t6C3QQIIQ0obbIZS9ZodjrLvsUy1FOwDdVLWBHkYizYctSW3CnO74j3PDrN4I3acW1/d5g39yAQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY9PR01MB10406.ausprd01.prod.outlook.com (2603:10c6:10:2ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 06:21:02 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 06:21:02 +0000
From: moonafterrain@outlook.com
patches/0001-bluetooth-btintel_pcie-validate-rx-packet-length-against-buffer-size.emlFrom: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 17 Mar 2026 14:04:32 +0800
Subject: [PATCH] Bluetooth: btintel_pcie: validate RX packet length against
 buffer size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nz3bTMitRiXaPUtKREw2QTczOLJCWg2oKiVLAEUGl0bG0tABK2XQJ
 XAAAA
X-Change-ID: 20260317-fixes-2efba1c4768b
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>, 
 Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=x13RR5UjNqv/2t8FV7UVXxzb3o04spgJerzuD/ZlLwM=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhswd794zMtgY258O9OZ48ODnwqnvala9FVpR9oPRdGJlf
 Puda4/Pd5SyMIhxMciKKbIcL7j0zcJ3i+4Wny3JMHNYmUCGMHBxCsBEDsYzMuw7+jdnctTfG7/O
 Ki4+V79UVUPGa9OkbzlSi1ZN7nl6eMUsRoYLwQcX9U269XNWuPimz8dnr12wkEH0ouqLJz+C9jU
 7ynOwAAA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::17) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260317-fixes-v1-1-b6e472140e1b@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY9PR01MB10406:EE_
X-MS-Office365-Filtering-Correlation-Id: edb2c854-7040-48a9-b907-08de83ed5cfd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|8060799015|15080799012|5062599005|19110799012|23021999003|22091999003|12121999013|24121999003|440099028|3412199025|53005399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3dZam1mV0VZZ3RKNjgwdTZUU2xCZXliVDVBbUJkamlac3J3NzZrd1dqbjhL?=
 =?utf-8?B?VDc1UE5EYjM2aStiZ00vTXhzclJvOEtpZTZRb2RrVStBNFlGSWxUbXYrWmNq?=
 =?utf-8?B?UUJyRjBhQlBMYUFlQTlvdEhwSFFNMURFUFBMUXVnZnh1STd2cUYrUDNsR1Y1?=
 =?utf-8?B?RkwvNENqMGR6NnFxWkp4YkhrcEo0N1A2Y2pueFNOSGtoQm1zUGxhSjMrL0NT?=
 =?utf-8?B?TVJXQzVVNDA1ajhONGNtb0FrdEw4dDhyU1U3Qy9XQTBja3lzWEpVWThtMVJr?=
 =?utf-8?B?ZlBpZk5vemNTQXIvRFJDUEdnSXBaVVYyTUtOci93eHUrQTh2UnRyNFRveW1S?=
 =?utf-8?B?UTNBL0ZraGhHaG9RbTdUUUU4TVQ5R2oyQWc5S3ZRODdscURBL0lEQ3NuK0Ry?=
 =?utf-8?B?OUR6ZkduYXhKckZYa08yMVJqcHFyWmQrNnY5MmJEczA4c3hNNWZOSmNGcEJa?=
 =?utf-8?B?ZXdnZzFGVllYT2R2b0FMZlFkNEJraFgxZGxBTUNsYU9xejFrUUJ4UDd4ZmZo?=
 =?utf-8?B?SnhzZzl3UnFrSzBodmMvQlJtZ09OYSsyQkRWbnd0M1R0a0NWdnVKYzZJVzlJ?=
 =?utf-8?B?TFJiNlNkd2tNMlZLallLdHF5emJnY1Q5eUk5ZHNKRWI4QXpSNjdBaHlLT0pl?=
 =?utf-8?B?VmxiLy8rMWk1RExDd2oyV0ZIbWpJQytMa09jMmV5b1ZNUGNpUHFGQVk4cERV?=
 =?utf-8?B?aVBZVW9qV2Erd2hYc3NFNTIwNmgxeUlnUkdRME9Va21pVjY1MVl4TzV0REk5?=
 =?utf-8?B?blVnVmx6NXduQ2ZsVm5Ha0tCTThYOXpaVnhkWmJLdFFPWGs1bGN3YW9KcTkx?=
 =?utf-8?B?N2JXZXRjR3FjTlQrU0RIekF4c3BvSlQvMTBvb01PK3R6bkp1OXB4SlFBdTVs?=
 =?utf-8?B?V1lvdlhqTTU3Z1BkNnowL2dCZ0RVTUs5TFhtbFIrYTJjOEV6eHFsallNUThu?=
 =?utf-8?B?Ty9aVWFHVzVKL212RlNMenc1VGJJTTdidGdxRUZKYlRFU1VpNjU5elUvalV6?=
 =?utf-8?B?UmNabnRoZFk3dEYybWtpRFo3OS9obUVYTkY3dkZYbWpaV2pUQmNDQ0JzZHp3?=
 =?utf-8?B?ZFVYbUJ1TSs0dytwYzRIS00yM0lrYzhMeVRhMXZJK2EzbnlsRVprdFA5OUxn?=
 =?utf-8?B?VU0ySDRubnNoVGFKY3p6eWdPdno0YmdvSDlQNTQyM0JlWG5UQ3lid3BwaHp5?=
 =?utf-8?B?aEh5MVZ5TWFVTURuZjgxMTRmN0NFTm9QcVhXOUtnQ2cyVlVtWnE1bWFwTFR3?=
 =?utf-8?B?RHBTRU5vK1M5bXlEVzA4UDJOVGhoMmFQOGo3SUFUQnlCQkgweEFiaFBrZStR?=
 =?utf-8?B?VU9rSnBhUnN5K1RTWTlKa1RhWEl0YTlWV3FiT1l5UDhLUGp6eGlXcDJLOEtv?=
 =?utf-8?B?WlVTTjZRcDFyK3lrV3Nza1RGMml6K1ZJb0U3T1lJWXd4eDN1ZWdWa09CS01z?=
 =?utf-8?B?ckZXa2JCTmxvcW1nbzJXRFNQUksxRlRUSnZwWmhnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnBMekNiU2FCUG9pb0ErVW15UFhxZ1pNcmp3TWxBQ2daVXRyeEhYWjRUQnhz?=
 =?utf-8?B?VlNaMjZiWmYwdkFsQ0c0ZjdRWXpJa252R1VWd3ZJZWUvY1VmbFlXWDVOWnRK?=
 =?utf-8?B?Yk96cGdBTmh4aGxDZnRBNWFxOEF3R0dITTRFTUdqQVdzaEJaSEFXdW9KOTF5?=
 =?utf-8?B?cGYydngrbGZ4N3gxT0lJVTRuczdROGxZb01rdVc5NEJNSVlndWYxMnREMm5U?=
 =?utf-8?B?b2Fid2kvTTM4VmhLczJQWkUrcEIxWTV3VlJWTU43Y1BnbTJxVjMvV0l5cUY4?=
 =?utf-8?B?Nmw5T3VTS2hBUis4WlRVd2lNRHBmRFlXVUhIaEtob3hMcld1a29HMXlXUGt1?=
 =?utf-8?B?Sk1qbVVlakxwQ2padEZnUlhKblhENlpXOFZaMUNtT2djY25USXd5Q0JCcUxz?=
 =?utf-8?B?MHFDRUsvK0dXcENHV2ZRSXh6VStzeXQxWXdnUlY3ZUd3TFBiYnNnSnVqVFRD?=
 =?utf-8?B?SXlSNGhNR0Fka0M1Y0xWQ2Q2R2ViUTlqYzhPeHpzRkdrTmU0cXlDUXVNVWMw?=
 =?utf-8?B?TnJYbmlCOTFGcEZ5eHZXVzZleCtNZ0JaUmRwbU8wMW5sT2QzRWJ3VHQxbGRW?=
 =?utf-8?B?WkVYNmN1eEFwNUoyTFo2SmNUbDI0UDlpS1NZVzJjaHRVYUIxUUMzQkkxTkdS?=
 =?utf-8?B?eW5CaTNnY0huRWwvYUJzZHl4QmdBTHh3blJsNk9qR3IxcHBNK01LeHhORUI4?=
 =?utf-8?B?STg2VVBLeHNxb1lDQkNGSlhxQ0NGdmlNNktUYnF5NUpyZW9yZVZ4V1piYkV6?=
 =?utf-8?B?VWFtWWhINXNLcERsVG5aS0JiVm51d3ZWL2dSc29tODVZdm40Z3hpWWhJZkZL?=
 =?utf-8?B?NEoyY3hTazlBdFFSc2xGZVp3UDhQTDM0OWl0aGU0c1BkaGZIN3BmaUpaUlVj?=
 =?utf-8?B?bk1wV3FJNXBGZjhuT2R6YXAwU20ybFJHN1pCTlcrOFp3Q2d5dWVwWGJraWpY?=
 =?utf-8?B?Mk9xQVlsdVFuRkZhUFdTc0xPK1o3NTkxMWVWZ1VOTUZwa2lSY0lFYXFEaWlP?=
 =?utf-8?B?aG1JdTRlM1QvRkorSnJXMGo2Uy90bS9JQUpZRjZ4ckhQNVdGN1JUY0VmaTNG?=
 =?utf-8?B?MlNzS1h0dVYwS3Exa3YxK1dueWFOUG82YXBndjV2VG1mdWR3SVlEUElLYlFm?=
 =?utf-8?B?cGxpYy9zbkpFLy9KVDdFT2d1VlRQUmo4SVJiTS9TbzY4YXZsMmhNOUJJVjBG?=
 =?utf-8?B?VjNtL3dlMk5aOXJMdDhaR3FiR3NTUUdTRjBRRkF5R0NxL1NYTEdzeVFDZUtw?=
 =?utf-8?B?UVlwUkhRclJvWWtqY3FadGRTODhmVkNrSDBVZ3NiS0ZPcjhIcVRpQ2J1V3Ru?=
 =?utf-8?B?N2duQkNGek0wNGNHeFJMUFh5QS9OcDJYRWRQZVVOTnBUQ0VQUlhDZ0VRQmZF?=
 =?utf-8?B?SlNydUkzM3p2cUowZEVpU3JSUXp3OHY5UXhDa3IraC93WGQya1FsdFlCWjkx?=
 =?utf-8?B?bGI4R2VhT3N3Ny9DSUpFR0hDZlJpenZNSW9PNm1WSCtkZmREZVE4NktQbDBJ?=
 =?utf-8?B?MFVFMG9JOXg4c0JyS0V4c0N5NzhNVGR0SHdXK0MrekhQU0wvMU5nN0pYdHFQ?=
 =?utf-8?B?dHNaNGxvQjlCR0RMRWV6QndsTGRrRjRYNWltNDNRdGZiZ1pLR0lDU0ZiWkpZ?=
 =?utf-8?B?b3ZLTHdlRGVoR3A5YXhZajgxSGVPR0xPYnA3ZXhXZ2V5VTdEMXJSUHZyVDU0?=
 =?utf-8?B?TUlxMDRRRXFlbUkyZXE4dlYyOTFMWmFkL1JxWU5US2NJU0NOMGFoVEZHa1VS?=
 =?utf-8?B?dEF3S0FrNyttdEdXVk52WjlFbS9GbUhzYXdPSXd6eDdZeVNkZWdKQmx6UkJ3?=
 =?utf-8?B?WEpBelkxNTFIaC9ueTdMNUM1dXhHWGVIdThrdTlMZGNnR3FMTmlsdXNoSXhT?=
 =?utf-8?B?ZHFRdHhLWWgwV2lIaTRLcE9ZQzVVWlJobkdjaGNUa2c3TFE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb2c854-7040-48a9-b907-08de83ed5cfd
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:21:02.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB10406
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225747-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 823FE2A442B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

btintel_pcie_submit_rx_work() reads packet_len from an rfh_hdr in
DMA-coherent memory and uses it as the length for skb_put_data() without
upper bound validation. Since packet_len is a 16-bit field (0-65535) but
each RX DMA buffer is only BTINTEL_PCIE_BUFFER_SIZE (4096) bytes, a
malicious or malfunctioning firmware could set a large packet_len,
causing an out-of-bounds read beyond the buffer into adjacent kernel
heap memory.

Add a check that packet_len does not exceed the available payload space
alongside the existing zero-length check.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/bluetooth/btintel_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..9dd02e8af2a0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1360,7 +1360,8 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	rfh_hdr = buf;
 
 	len = rfh_hdr->packet_len;
-	if (len <= 0) {
+	if (len <= 0 ||
+	    len > BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr)) {
 		ret = -EINVAL;
 		goto resubmit;
 	}

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260317-fixes-2efba1c4768b

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


