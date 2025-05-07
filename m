Return-Path: <stable+bounces-142061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DC9AAE0CD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EBA1C05CA2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C978528E;
	Wed,  7 May 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="vRqVlbrs"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A24B1E56;
	Wed,  7 May 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624746; cv=fail; b=iYq5UlMYgNUGD6KCRbLfHgJ6ybgT/BM3lB0dwxzKlU9v5pe7/f5P0yidID5UkBUcAYC0UbfjFB84Gtn0KR1YL00sGNgrcobVZ+owhdqhptuJnyLYlwFIlleBP7MHxw4i/3/K3VtyDB/+Dg7aWr1tCqwjV+JDObVbK8fKSw4lWu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624746; c=relaxed/simple;
	bh=qeIK3Ey27ZmNuMYJmMVrhz260iEnSmfnLvY/cZLd2XM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uqxywLCDOJCFLIPgePkZi6CenLZhAsRzLM74v8/kA3vludMEgL4IWSkTtRymEA0n8eCw0W6dsfPVVbHm+9GQ7GTFo22JE7XcZysoI5Dq+RYsHfX5prNUMKq8/2P3iIYRogBrkmUrtKSoPGhRw8RB90preBzDikoiM1iZatJUAs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=vRqVlbrs; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5K+gXnBF2ii7q0ups2Hn6Ich9HMHjguaO2AzskltmK3pvrHW0PiTkyS+4IHZUjj45poCO7TRzZ4W8yEpC39k+u8AmbwW6R4dG0QurPalCLvsYqCaFe7WSRiop+MK7VNga7AONX5P6ENBBtPBq7BGolu7Dvk6iR7xOUoprmaiIgge3KERvX5YYnXQ1trUrl9inBqbYiNuQj849PvRzH0MuSdCvo8aIltNCyy3LOhIJogmggHiRP4hAAm9y+Sx0G2XG4p6QlzNabKKZkg5K9Q8bzFT8TA2FD1DO3lR4AP9gpUz3Wm8fo4tNhCIn3hQ5VKFU36vy7+gKqgjDz7weRKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeIK3Ey27ZmNuMYJmMVrhz260iEnSmfnLvY/cZLd2XM=;
 b=Njgd3Z8b4cB44XqZrXCMGnf+imfFmwPdOAt/fos4f8jmSuEzkI3lfEsq6TACYFYp+PW8JLpw9EvJV8mYR2vrvuAyS517+gEr8zAS0WGfIRrJZX2k7kFluR+CrxwodxNLzighXe4SHD1u5krcShI45KLDM+O66Qf3vi+yv2NBAXH1oaduuZWWalaqf+M7im7z94kjpIPNcxenr6OrdBEbWzqxY9sfFQ5KdftzUZuFmtZRrP8xrt4VxG2FygqGOQvvdGznca0HDHimOlFg9KDm7u8Sr4xwWlesOmxC/SB412l7Bm3jJ0G6kB6KF/RC3M9yfaWXwYIxzZF+II5gbFprzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeIK3Ey27ZmNuMYJmMVrhz260iEnSmfnLvY/cZLd2XM=;
 b=vRqVlbrsIBQ98ywMvxzETGodz422ZZSLcQy0A5ec/jH8n0fAsi35fokARfS7SHmsnOZt5oMD9DuF4NB59XbJA1Cz2oTNZLBAFMqUdn0ij7AOjTjBGTl3r4YXG4Uy8vlnVHLW5QYbo0gv9mh9e/cHZP1LUEUE+cPygRFaMFv2wuHUoMxGDRRD/C29Zy8bGgXtx3eMXjT2tAY+L7bD0MFNROno58FPhAdBs0rhXqF8ebKdhqOKgwxWnmDDCkDYsj13bwpq9zCHkH9LnHv/1hYiumgNrccAtJhT9bv+sLvv7pkb4yvA3uAGELYns7ClYFqz4mhpzItHtxX0MAoTPOmEQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
Received: from VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:123::12) by AS1PR01MB9592.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 13:32:18 +0000
Received: from VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 ([fe80::ac38:4740:6a66:b5ba]) by VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 ([fe80::ac38:4740:6a66:b5ba%4]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 13:32:18 +0000
Message-ID: <c9723c0e-3b8e-433c-ae34-40c3b4c34b1b@kuka.com>
Date: Wed, 7 May 2025 15:32:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP
 is enabled
To: David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v4-1-4837c932c2a3@kuka.com>
 <4610064f-04f0-47c5-aff9-2584958f71fb@redhat.com>
Content-Language: en-US
From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
In-Reply-To: <4610064f-04f0-47c5-aff9-2584958f71fb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:123::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR01MB5696:EE_|AS1PR01MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0477c6-18b4-491c-ca2f-08dd8d6b9636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVlqN3BUY0oxYmNkT2JmQlVsN2R3NHRhSG05K1o0ZmZnL1U1NWQrMnE3YXRV?=
 =?utf-8?B?SG9HOVJJVER3bnNpSHVaM1FSNE1IZE1EUnJpZE81NXRZZ1dDcVdteC9lcjZD?=
 =?utf-8?B?YlhrcmxwTDZlZ3dNUmpjeDB5aFdnMDRKUS9rbDlWai9EYThQMFVKK08xSmlK?=
 =?utf-8?B?L2hoeURBWW5tajlobitxbUFFN2dmdmEyRlR3aWZFMnVwRDdVcU1ldFAxcUt4?=
 =?utf-8?B?NElNYU9zbGd6V1IxZkZFbnNJcVNUR2dkN0RMdDdIYi9wbEl1LzlQNWg3MGxE?=
 =?utf-8?B?SWh2bHJRd0RucE9oSElHN01pVXdtcnpZM3dNUmtQS2liTndML2xYZ3FNYTFK?=
 =?utf-8?B?QXFibExya012dU9BeWlXalVsOFh5RzJnSlNvSklWdVUwYk13K1ZHbVB2Z2h6?=
 =?utf-8?B?czlJWVhncUxTTmpiMWV0QXhWdHpkWEhRN1IwelNsZk9kS2xvUUwwbGUxajhY?=
 =?utf-8?B?cHBEZ0FXYkNOdU9xbTVDWjlMbHBrcmRZd1BLZEFKd0dOYkZpK08wQ2NRa1d2?=
 =?utf-8?B?MExtSWllVjZzM2tIRXZPVGhoQ3Z4a2VpMHIzb05ub2hXTkorWmRTUU92dlhx?=
 =?utf-8?B?M3ZWUVFFYVRWLzBZVFYwaENXa3FRaWE5Zkt4OXNtdE9OWTUvV0dyWURBWE9M?=
 =?utf-8?B?RExzU2J5ZUFkYjhrSmtSNnhGS0ZxOWc5OE9QbjNnaWcveWsxaGhVc1FlckpI?=
 =?utf-8?B?SlMxZUFSNUc0WVRoNUdhei9GZlhFZG1aMnNIVmlRMWFNcnFPVDBPYUdCV0V6?=
 =?utf-8?B?enpBVlhaTGhQcGcvbThwdVl5SmRNVEdnZ1RKbUE2TVE2eHYyc2FWcmVSaWt1?=
 =?utf-8?B?S3kxWmpqN2hjZlJxYm5YR1dqU2dEd2hYL2phNFdSc3V6dnhaRk40ZTlmS1lk?=
 =?utf-8?B?Um9oMlVKT01nN1pubmxZLzdZWTAraG1nVHpZZW9LM0xLSEY1Q2JFMC8wb0NP?=
 =?utf-8?B?RmVJQTFxOGQwWG5OeGhESHowbVhIYUM0bXFLL2tmMS9lSmJSQVdOeXdBTWVI?=
 =?utf-8?B?T0dva1pWT3BTM2hnektnQStPUkt6bHRQUlRpeVdWVGRJVnU1SXZrV29NMXpq?=
 =?utf-8?B?aHl6bzFZQk4rU1NUbDFNcUFhK3J0cnVVL3RHOUVaRlRIMHdSdzVMODRRWlJu?=
 =?utf-8?B?L0oxNmtETFgxY0R2N3RHOFZkc0RIUWNzNFhtV05zRVllK3ZTOGVRbDJTRk1S?=
 =?utf-8?B?ZW0yek8zdFU3NkpBTnZvNVJRRU80dy8wSEZtR2tKTFUxVXdBNUtJTTNDN0JX?=
 =?utf-8?B?Z3V3anlJV1R4MTh3K05vVTZzV1VZN3dYTlRIY1VQSnc3ZElWWmRkM0tvYmVl?=
 =?utf-8?B?cllLVVJZaGFTY1U3TTd3UUNCTE9lT2h5MTExNGNsdlpYZkE1bDJSNkZjN1Ft?=
 =?utf-8?B?QjQ4U3lPdVpoZURRTklBMGlnQUFYRndaNXhVTnZEUmpPWHZKOTNSMmRLNVps?=
 =?utf-8?B?TEdhNTJsMmJ2MktjTlB3TEdrbFpjTzdaVVhkeUlEalU4bnNIajBvOGtsNHRO?=
 =?utf-8?B?TFNqQVIvcGs1WnU5T2NMWS84UUxwOCtDNXRRZWVQd0YxZUUvUHAwU0RzTkx6?=
 =?utf-8?B?VzNKdUZGSktuU2FkNmVHRnQ0N3EwSDBCaFJCQXRoM3c2eHRmdkFOd3l1V2pv?=
 =?utf-8?B?eVZwQjBMTjNiY1ZLNmVFUm5YanF3NnFXYklDcy95WDJwTjQ3ZWZqSjdtbXl1?=
 =?utf-8?B?Um1QNExoZ2VjY0h0ektOUVM3MWo3T2hiL0o0SW1LdE5YZHg0YkRmTkFBbE9Z?=
 =?utf-8?B?aEdjYUZCSnNmMCtBaDlLRVRnYko0MWdhZ0lCeXFjeGVBdHYvZzhPSUZzNHZo?=
 =?utf-8?B?WTNSdnNsaENlczl3Z3E2NDFQejZtRnhSaFU4MHFNbDZCU2l3U0xReVJFSVN1?=
 =?utf-8?B?ejBaQVc4V0RSbUl0SGNjK0ZXMGlybWhMenhESzRaOUlydDFOM3BaRm5LRFRH?=
 =?utf-8?Q?36L2sLTXKKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR01MB5696.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjlnaVI5THBHZnVxVDlaS0pjU003KzdNQU56QjZmTi9GMUQ0RzJBaDNTR1pI?=
 =?utf-8?B?MVM2RWlvWDhCTjNVbC9DUkU1bzIzUGE5bk5lQmFiZUttM1Y5SlcveUdPUmQ0?=
 =?utf-8?B?OThzQjFSdmx2a2R2ZVNJcTA1SVdzOFNUam9LLzNwcUZMcjYrOXcvd0F2bGRF?=
 =?utf-8?B?QVNzYm1DWG9BUVZwUlZILzdkeVRqM2RGTTE1cXNYWkliNHNLTCtHUTUyWVZI?=
 =?utf-8?B?ZTVTc0xldmwzc3VNdGxManMzcncvQWNEOTF5dGFDdGVBMnRPOTA3eXo1N3hM?=
 =?utf-8?B?L0V1bS9xcFduS3ZjVGdTZjhtd2Rxa0Z5Q0tIc2Z6Zk43WWkrNFZUaHA3MlFt?=
 =?utf-8?B?Vnh5aFo5TjQ2dUdzb213VWhUWlArSTR6S1dWMG4wejhXakcwa2V3QkpZT280?=
 =?utf-8?B?bDl4ZHZadWh1eFZkQWtzSFo5ZlhTZ1JLQlEzaUxHYU1TZVZuRDFNTjRBZGpH?=
 =?utf-8?B?VWh1Y09HVnlINDFUczRPYmswM3Z5RkFxYnhJcHZFUGovelYrS3pvcFppTGZH?=
 =?utf-8?B?T0p6c2ZoYmUrMHRrVmxUWjNEWlUrM1Y5Y1Y4czM2T3ZPWnZ4bUVHQlo3dzBO?=
 =?utf-8?B?NGxYOWtUSytGU1p6b0xCYmdGTS96bXpsVDRCdkNra0FrM2NHRm50akVjSnp2?=
 =?utf-8?B?bDgvTndDSExWc05sYkVGN2JXbWk2Z1FoSFErMkp5eTdXeVo4TzBVRkRVdzZq?=
 =?utf-8?B?Qk9zK2JJTVVjMVVHdDRweDJhYW9XZnZyRmNmV3VqV2dnWlR4ZEV5OFRhNDlk?=
 =?utf-8?B?SDVGbVc5OVNRMnNkZnZlenE2UVJwWW5PMjIrNjNudkF3cnc0QW83eWJCNVdN?=
 =?utf-8?B?c0wvQmZiSnFzNy84d2tMMTNpQmFWYTAyK0d6bGlxV2lvdFhGa3p5bnV4ZFlv?=
 =?utf-8?B?dzIxSk5iSWhDZzc4VnhFdlhzeFJaNlpRVG5yQTBRU1FtOXo1em55R015ek16?=
 =?utf-8?B?YnlmWUgvQWkreGtSTDZkb1ZrMnBjaDBiOVd2YWp0TmJocXVxc0xObHZWRk9h?=
 =?utf-8?B?ekhuQmFxSW5tR2sxMDY0amExN0RhZWZVS3plOXYrMG1WM3J6QnZRZ1I0VmZP?=
 =?utf-8?B?UVB0Zm9Ib0g2ZTlQaG12NkFna1ZUNW92T1ZWN0lwd1l1N3lOVVB6REN5ZHgz?=
 =?utf-8?B?aUtGMytFQUZhSGUxQ2UrY0loN2crYXlMRWorNkV6bk5ueTQxVjBsdTgvSlha?=
 =?utf-8?B?UDlTNjA3d0hiNU9GdFpDbGMzN2FEQjRYRlpRUE1ubXowQWpKTmpWUmkxY2Fp?=
 =?utf-8?B?YmJjc3VtdWhjSkh0YW94SmZEd0dCVWduRU9xSlFjdTZvdmRnN0liY2VGeXZQ?=
 =?utf-8?B?Qm56azhJaitTV29ZMnlFNUcvYWd4NFNRNzVpV1ErRWw1anJBeUVZZnpWSktr?=
 =?utf-8?B?cytFSFZGQVN0ckVsUmF0WGR1TURNeUNrUVRqTzJUc0lqaFlqSWFTdmhOYVFT?=
 =?utf-8?B?K0hjME1HeG9IdmpyOU56c1NyVzYzM050c09yZzg0c0NvS2dLNnlJQWZTWnc4?=
 =?utf-8?B?WmpzOEV3Vy9FSmlvblpnUW4yUUNENDRGeHdPV3JkWU1PU2IvMEpsZ2ExSUdm?=
 =?utf-8?B?Sjk3Z3dKRy9sL2NCcW1iWHBGSkFVUUlrSWcwaHRYdUR4OFI3VU5iaHRGSFR2?=
 =?utf-8?B?cEF4UGtmMHAwTmEzazJEaEo4dkZaTlMwbVdMZWFFWTdYT1V4aXRsTFRBVXZX?=
 =?utf-8?B?V28zcG1HZXFlSmdzc3A3VC85NVd3UjVOWU1nZkh5WHN2L3lhMWZ0dC9LN0Vw?=
 =?utf-8?B?MHFzdWJweUtaOFpseHJGMmg3V2ljUGgydVNCQlpmNnZyWVN3cnBQMlpUdGFY?=
 =?utf-8?B?M2I2SFFISERXbUVMTXZadjZlMFVTeG5rT2tJSXpJUjFHSXNUUUoyVEIzd1lJ?=
 =?utf-8?B?VlBMV1I5LzQrTFNvYjZ4Si9QWk1hM1hSOW1rc1F4dVlvbWNaYmZ6VHBxSzhU?=
 =?utf-8?B?TnY1VVkva0FOc2lJMVBMUXZ5TElaNHVNaktUTkV4Z3g0U2NFaC8vc2dkM3Nj?=
 =?utf-8?B?WjhFSlFWY2pGamRDcUMvSGllc0VqRlNNZGszaUY1d2RZYWVjNTFLL3pqaVkw?=
 =?utf-8?B?SnZmNGtFUGJUREo2UlJGSE54enpGQzFKUTdTaUZEVW1nelRaSTg3UGxFeklu?=
 =?utf-8?B?UXpGZ1c0NE9TcU1DaUh6bGpOYWVYbXU0em5zMXZtTU0xZnBGemVOcFhrZVA3?=
 =?utf-8?Q?fXQMmtUw25EojmJ8sp1QnUk=3D?=
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0477c6-18b4-491c-ca2f-08dd8d6b9636
X-MS-Exchange-CrossTenant-AuthSource: VE1PR01MB5696.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:32:17.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHjtr2B2n7pi87aL29KkXr7UoeUz7f8pJW2vC3UpA18ftOguyrNTlteUpdAYE5t8ad7UApqskQlAk3+/8KNoZ4QtN1DT6u1mmIsqidgIRAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR01MB9592

On 5/7/2025 3:18 PM, David Hildenbrand wrote:
> You only fixed it in the comment below the ---

Oops, sorry. Thanks for pointing the error out :)


