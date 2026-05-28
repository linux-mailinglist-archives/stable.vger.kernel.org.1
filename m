Return-Path: <stable+bounces-255062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO8HCTN2GGo8kQgAu9opvQ
	(envelope-from <stable+bounces-255062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:06:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FA5F5660
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 181C430E60B1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EE3E9F95;
	Thu, 28 May 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VDV7slXi"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010076.outbound.protection.outlook.com [52.103.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7D3E714C;
	Thu, 28 May 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985663; cv=fail; b=XUBqolasI6JhXnBJ/1WnfbwSz/Ls5Iritpg4ry2OtrX3rikcLEmnshGx+JbyzA8DNW9G2HuK2gpWMrRL84MgCFkElsmcSpnZnhgpT7d67rB5Z/8HtHZjuaCKoJoa1VxTyinsSwQc7f2pyH1EOugFW3cSC7LueTBvWFA87NrWZSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985663; c=relaxed/simple;
	bh=6iKNH3Hd9SdxVQgNsiG/sfLGO5rCfs5jUEUBDWd44JQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uD4KSH+M6joeDJpk+tVTgjGAH2eCPrQirujTd/z2knTuZrRzhY3S6M6fFRD1buo9X6nmtQ5ERh6doN9FxYVOVKpUtp/5GIfkjqaopyrW61aK3IOaFkTeLzH51VBYkBWH0RJ1//WVX8A6VBE2gw3DXVNMN2+hpp1jwu7C+GrG2UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VDV7slXi; arc=fail smtp.client-ip=52.103.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWuC3iikMonhEoU9xH1AYSx/gTLQdwx+mzGy61yKZjrDa5MgzIRPa8L+uHS+lqBXnxoocLqRqRk5j9GDFLRqUQQOoSOxRMPdzqk9VehKHOnN/u/cZPg1KxE+zvwROxsU8SO/cpbEyBVqYB+8Pt4RrqZeHauSNYj7c+FkfPKfmSNOe0awucLwX5pH3vXFveCUGHXqTboJyb9275D/V0JBI64kM1rvIpMPgWsu6kMM+FmSLetsGQGRTqSIYEZGYBElhQ0fBo97ZqnO1nZjx0vtVbeLWNC3ZBEzNNG5ND6xroC+I4+KeIauyCQDrtY7ej+ISD3ZhUjtXD6paVVkcq9qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iKNH3Hd9SdxVQgNsiG/sfLGO5rCfs5jUEUBDWd44JQ=;
 b=zR49QCquWszPryZivFRQkTidQ7YM83NAPC6cCakU5PfHbXDQnBbbnMIN9ZaFiZ3gFaAr+MjUZmA6bnYdr5SI26DVxCaTwuQS+/Bdf/5Jx3K5ERn/FWK9Yqv5MMHBz4mK2n09FAwyVDZ9j8LUqCOXr7PIy3ATY4Uolm3Eky2GycEGUiLXRlrDpgHAIma2218v3N0wBbFoRx3xj1ugzdZnsSPV4hMIkc4LDgbrnhu2JM1GLC6oIFuRoOOGi5CjPPdzQUuwx8Rn2LwWYyrT0N1MjQSnVsSUpyMfvr4FqsJRYOkEO0YYQflw3txFDyUmy4Hg2DvN/FnmHyAVVb5eIzuRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iKNH3Hd9SdxVQgNsiG/sfLGO5rCfs5jUEUBDWd44JQ=;
 b=VDV7slXiH3MnwHmG8d4feQkcJwx3E9BxtyZI73JKw8vTHWKORIJPn7mzIZweLmZh9Gu5vWZJ+HW7qgbDuPqN8UmoxDddRPRXWO2y0A/3rdfK0tDRMQhaBGLBLYo46IohFExj6kug091yVxcUZ/BMcexXvEsy54zchrMwBvMUUyervURGuZnUqp1NtSunVAsnzx9IKdOwuexPnI63Y1rRNr9E2rNouvAiHa944ZuOfw6PxkWP5qN/Gcm7pkIg4L69Jb4aAY2i71ZGFKsEKWDrZ7BcvJ2+LdhvMCJ1EcY93i8oFDNTiFxYcDFxaERRiJLS/vvDSJpHvBPw0quLQ0RIRg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB6953.ausprd01.prod.outlook.com (2603:10c6:10:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 16:27:36 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 16:27:36 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Geethasowjanya Akula <gakula@marvell.com>
CC: Jakub Kicinski <kuba@kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>, Linu Cherian
	<lcherian@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH net] octeontx2-af: cn10k: restrict LMTLINE
 sharing to same PF
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-af: cn10k: restrict LMTLINE
 sharing to same PF
Thread-Index: AQHc7r7kINcZdMltlE+LU1EXeIHLEQ==
Date: Thu, 28 May 2026 16:27:36 +0000
Message-ID: <E32D37DE-5401-4CC8-98F0-8EA944C331D1@outlook.com>
References:
 <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260526180233.4323832d@kernel.org>
 <CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
 <20260526185224.0c65e38a@kernel.org>
 <BL1PR18MB4342FD927BAF986D33299F74CD082@BL1PR18MB4342.namprd18.prod.outlook.com>
In-Reply-To:
 <BL1PR18MB4342FD927BAF986D33299F74CD082@BL1PR18MB4342.namprd18.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SYBPR01MB6953:EE_
x-ms-office365-filtering-correlation-id: 77640604-f3e8-4747-acf9-08debcd60742
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|12121999013|8062599012|8060799015|19110799012|15080799012|55001999006|31061999003|22091999003|24121999003|51005399006|24021099003|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2l2Ti9laXF1bk5ESkxtRStIZUZBU2hwQWg3b2lqR3ZCUXNJbXYvTlN6R3ZM?=
 =?utf-8?B?QnhDOGV4bVByUVBBOERpa0lka3NmWHhOWUwxRWZVUkczUHhxT3VxcTlMRmhL?=
 =?utf-8?B?S1FxT2haTUppemtGU2JvTWcrT3B0ZVFjSGZqZWxhWEVOcm0veHc4eGxNNEVo?=
 =?utf-8?B?WEpIRm9nb2xwenJEb3N2a0prTW5aUTIxWnhMNThVZ3VsZWNYRE53RHZDWlYw?=
 =?utf-8?B?ZmNwYVgzam0rS0RYTUwzWTloc3V5MDA2bjlwUHpsUEtwUldjb1lGRCs2UFhj?=
 =?utf-8?B?RFJOVUdKVHh5N3dBSGNFUGY3U1ZubmxjZzdrMkNWSmtldnZHL1hQZU9RUXhj?=
 =?utf-8?B?NHArREg3ZEdVK2VPc28yQTZJWDkyYkgyOGU5ck5NNTEzU0p2cnBtb1lxM2dL?=
 =?utf-8?B?WFJoVTdrZUVWN0NtdHpCU2hVQitwZytHTGVhdEdUOXFYcmpSWHZweFoxN2xJ?=
 =?utf-8?B?WGJFaytuSnhpN0gvL0ZPSE01elJkelJvS2U5aDhmZ0MxV2hFWGhVTmgwUzVU?=
 =?utf-8?B?Q0I1WlJIUzJod0g3c1ByZ0NDQk9ieDFWcWoxWFdNWmdPR1hpQWg2UlZVaEJp?=
 =?utf-8?B?VGU2b0dqM2JueGNiYUQrZ0l3SDJRcUZqSVp1d2ZqaTluMWFPQnZKZUt3Um8z?=
 =?utf-8?B?d3F5TGoyUHlXNW5ENTd2MU96bVlXb3YwbTN5L3ZhV3J6TFlnWW0yRG9EblRM?=
 =?utf-8?B?TWRDQ05UaVpQckJ4Z3RNSzk2ZDV2ZUpmTjFZdkhzb0JNNzE1ZEI3WFljN0pV?=
 =?utf-8?B?V25uL0xnU2lkYUJ2ZFUrQ1RnekpSc0lFd0J6bGZwdTRabDdhSzlIWmV2dWk5?=
 =?utf-8?B?VTZydGhSd1FFWmpSQ1lIcEZBZThENngwNzhoRjUxeTR0NE45NitCZk53TzdP?=
 =?utf-8?B?ckVtV1NpMVZtSXd5cVFlK1lickVNd1Mrd2FTa0FIdmF6Q0NHQ0lBTmNUVU9G?=
 =?utf-8?B?endQZkx5MGVpUUN5amRrTUxYNFlzcHZXb2l0azI2c2dycmJmbm5nMDBjSHZw?=
 =?utf-8?B?NFpDeHBOc254eERlQmtiYXpQeWxCcWQzYlcxZGp6cVB1dGxiaUZwZ3RFZUNC?=
 =?utf-8?B?UGNiQ21nb1VCc002dzV2c05jb2kyUTY4QmMva09ZT1lwNTUyczQ2WlVUNmpG?=
 =?utf-8?B?bGpmQ1g2Nlhxb3J3NExxMlJvRVN4TUZwMVF1Y2xyRTdvclJYemlzcUhtYXIr?=
 =?utf-8?B?WHZnZzR2aVZQbWsrcEJFdGdwOUQrTU9CdGhkcldLN1YyY2N6a21kVEdtRzF1?=
 =?utf-8?B?NHVqZm9yQ3RmVW1mQWVSNlhmMkFKR2doblRHSjNmSFNhUEFEOUZCcGd5Qytu?=
 =?utf-8?B?MzBkTkxGK096SWRDK1F1b0NiS0lGVUV2RjZDYXNackhCZ2w0ZWhmYVBTRHVt?=
 =?utf-8?B?OWtvUnpMOFZOZE4xZmMzbkozR0VZZ0UrN3ZWS3hnUFF5RGw0bGZCUDh4UlJi?=
 =?utf-8?B?d2ZMdGtJc3FwejV1c295NjZpeW1PRlNBNCszRWtGakJ0Q05OV1hSTmdRdlR6?=
 =?utf-8?Q?aIw8tw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzV6dWlIcVVKa3ZicGEyWFZ4MitzMTM3VW5XbUgzenJXaGxpdVAzRGVvLzA0?=
 =?utf-8?B?cThjY0UxcEsyRmcxQVRVdk5IQ0pVS3FrbnBoZGVVR1l3QWNzVjJQd0orOW5w?=
 =?utf-8?B?YjNva0V5eG5ZZGZ2NVFvZ3k1dytJY1RjSmdFNGx5TlZFWUx6b21IU1hLd25i?=
 =?utf-8?B?VUhVSkRpVStjVGJURXNvY001M1lVbmlINnU5TnR2WFY1WjFIN0hJVmFoWWVt?=
 =?utf-8?B?dzFNa1VmcXpZVk16a0FCSWpCK3ptbzhvUG9WOUVwWC9DVlp0YVdXNzVSNHBD?=
 =?utf-8?B?ZU93c25qaVFtVjhiMDJBbk5VaWxOSFJjZ1cvNVhVQk9LOXpGMDhCZGJmanhm?=
 =?utf-8?B?MndVbktoaXZGZ25RT25obUdSamVqRDdHNVJUcHJ5d3VkOWczRkpDeFBsL09Z?=
 =?utf-8?B?RXFqOENmVmg3SXZ0K0F0YU5rN09CSDA0aW1FTFRGZWRnS2s2VnpTZDMvc2pQ?=
 =?utf-8?B?VzNhd2lkTURSSEhPY014TmJpVnVFMTVWdWpHUmxlRU1XUHE3dWhZSG83d0Ns?=
 =?utf-8?B?aVhQM2lvS0JacjdsYkNudldyQkVvTEN2cnFWY3dLNXg0Y3NiTzJ0Z2lJNytV?=
 =?utf-8?B?OTdFUmhkc04wSVFGaWtpZERTV1U4TFhsL1V1Y0VpamhGRFo4bWRobk5LdDNH?=
 =?utf-8?B?V1ZGdUNveG1kTzJNRlM3VitMMGMwZzZJb2NSblo2REx6aFMrSHlSVjNqQ0Vo?=
 =?utf-8?B?YURqblpYQXpNN1VRNVRQa2lMTzVIR0duTkpxdDFOUkxnaFRUNkpYSElYV1JZ?=
 =?utf-8?B?SktwZ2ppS3A2VmlLNzFoSk9VV1NWd3JNcWNqa1o1aWVoY0NRNkJqSisrYVlR?=
 =?utf-8?B?NVRmNC9La1FZOEpTZ0pGdnd4ZGtINWpvWnVzMDFIaU9sSmFLOHhReEFKS1Ja?=
 =?utf-8?B?dFljc0VJZkZseXkzcXRjeEJYUzVxOFVkUks3TXNVeEErZ2RSS0xaZlZwUTJZ?=
 =?utf-8?B?UkY5S3I4Q2FVODJwcVliU2s1Zng4enVUOWRXUVo4b1BGaHR1RzRZV3ZoR1lp?=
 =?utf-8?B?SUNDV1VPODVGOHhjK0oxS2RCY0daczZFSEYzRE8yRldXYW1qVllkM0JBM3Zi?=
 =?utf-8?B?V1kvZkg2SE1IcHBnbU0rTmtlZ1pMc2ZqQzRRcDFhR0NidDhCdHZ0ZjBWZnJw?=
 =?utf-8?B?N2JHcklVb2doeWNvQkVFbWx3K3grSFhwcjdlODdJWWlUY1FxaXNQRWlUQzFt?=
 =?utf-8?B?NXFxUHB0UDdiNDExaFhZeFdxVWtNYjBUQm1UWUNidEl1WUZzWGg3M2lGcTV1?=
 =?utf-8?B?NnhrQS9acFVPQWRpRFBXMUlNNUIyZEJEQTc5N3crQWlQVldNZDFEYWpLZFN6?=
 =?utf-8?B?eno2bWNnUmZnZzRDRmxRSWlQT2RVT3pNQkIrc2M1RlRFa2hpNWF3RXNxRktI?=
 =?utf-8?B?ekVJMFdTaHcyWFZzdm5vT0tjZmRtSm5WMDhicVlnN0dWd0E5bFlnVlFyNUpa?=
 =?utf-8?B?dWVSeW0xSkZudUs5KzRDUGFlYzU2V0JCS3B0TnhValVsRTdPaU1TQU0rV0ky?=
 =?utf-8?B?Y0liZUlTOVh5Z0QxOUE5V2VQZWxFUGtOZ0NtNTBMdkh3UEcxMzByajFad1ow?=
 =?utf-8?B?R0EyZzhPNG1QVDJEczMwaEI4b1JtaFA5cEtrV3RaVFFKMkZEc3hCckliZ05P?=
 =?utf-8?B?ZURUTmtFMDk1Yjk5YnBaTWNzMGJEUVFuRHdVZEhDOVQ2UWY2bUMvUHhoSE91?=
 =?utf-8?B?cGlQbUk1a3lKQi93eDdaT0xTa3pYaHY3YnpZUGF5M1FieWM5SW5mUG9KZUla?=
 =?utf-8?B?eFhHc1NrdUpPYTZ0NFdteE9NYmdoeGJ5RFdoNW9XU1BHZm5zc1hnWkRlL0Rn?=
 =?utf-8?B?WG1zalBxREZCNVVhTlREVFFTUzdycEJUQmFjY0NyU0FaaXY3M1BFQ1prUzh5?=
 =?utf-8?B?RDIzd05Hd1NRSUpLdFRKUTdiWWdISkI5LzdlOFZvVlBIMlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683FD110A660864EAB4163F76D50ABAE@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 77640604-f3e8-4747-acf9-08debcd60742
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 16:27:36.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6953
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255062-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CC6FA5F5660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBNYXkgMjcsIDIwMjYgYXQgMDU6MjA6MTJBTSArMDAwMCwgR2VldGhhc293amFueWEg
QWt1bGEgd3JvdGU6DQo+IEhpIEp1bnJ1aSBhbmQgSmFrdWIsDQo+IA0KPiBUaGlzIHBhdGNoIGVu
Zm9yY2VzIHRoYXQgdGhlIHJlcXVlc3RlcuKAmXMgcGNpZnVuYyBhbmQgcmVxLT5iYXNlX3BjaWZ1
bmMgYmVsb25nIHRvIHRoZSBzYW1lIFBGLg0KPiBIb3dldmVyLCB0aGlzIGFzc3VtcHRpb24gaXMg
bm90IGFsd2F5cyB2YWxpZC4NCj4gV2UgaGF2ZSB2YWxpZCB1c2UgY2FzZXMgd2hlcmUgTE1UU1Qg
bGluZXMgYXJlIGludGVudGlvbmFsbHkgc2hhcmVkIGFjcm9zcyBtdWx0aXBsZSBQRnMuIEluIHN1
Y2ggc2NlbmFyaW9zLCANCj4gdGhlIGJhc2VfcGNpZnVuYyBtYXkgbGVnaXRpbWF0ZWx5IGJlbG9u
ZyB0byBhIGRpZmZlcmVudCBQRiwgYW5kIHJlc3RyaWN0aW5nIGFjY2VzcyB0byB0aGUgc2FtZSBQ
RiB3b3VsZCANCj4gYnJlYWsgdGhlc2UgZXhpc3RpbmcgdXNlIGNhc2VzLg0KICAgDQpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcuIFRvIHByZXNlcnZlIGNyb3NzLVBGIHNoYXJpbmcgd2hpbGUgc3RpbGwN
CnJlc3RyaWN0aW5nIFZGIGNhbGxlcnMsIHdvdWxkIHRoZSBjaGVjayBiZWxvdyBtYXRjaCB5b3Vy
IGV4cGVjdGF0aW9uPw0KDQoJaWYgKGlzX3ZmKHJlcS0+aGRyLnBjaWZ1bmMpICYmDQoJICAgIHJ2
dV9nZXRfcGYocnZ1LT5wZGV2LCByZXEtPmhkci5wY2lmdW5jKSAhPQ0KCSAgICBydnVfZ2V0X3Bm
KHJ2dS0+cGRldiwgcmVxLT5iYXNlX3BjaWZ1bmMpKQ0KCSAgICAgICAgcmV0dXJuIC1FUEVSTTsN
Cg0KVGhhbmtzLA0KSnVucnVpIEx1bw0KDQo=

