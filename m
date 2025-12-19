Return-Path: <stable+bounces-203053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46CCCF1A7
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56EF303974E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A20B2D1916;
	Fri, 19 Dec 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pneMLQ4B"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70941249EB;
	Fri, 19 Dec 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135857; cv=fail; b=jEeUNLiCbSTgxYvPtummdYaYdn+DDJTVbQE+1Ty3+e5n7SO5YK8ykn8z++1GfyG2TqVE5y17VD/D8ezkryRQr+Klzu16tBYxDJ8wiwQEtwhQtGo0mz3c8itG89T0d9rQv43POJdGWGy1NcDPRUtDT8VT0Ztjv1CRQl7tXFr8U+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135857; c=relaxed/simple;
	bh=xxLkKT2MgQGn9F1ZRgUwewvGti3OGWGTyu8PBi/SyZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKQFAOOkhnDtM73TU2WK2w5WLK/oSBlxzsdIBQhIMU7uP/WmLUYQbsv8mKlHeoX4E4uJeB2vhsUgB8VDexzGn+hRuyM4LxJyEnb+cWNeZ5MPomPGS9FytmKkpOCmQPHbni4OCdoEgT4Ay/INKbYMNDcdKv2a+3/geiMNG8xCq2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pneMLQ4B; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ68vuq962892;
	Fri, 19 Dec 2025 09:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cxC9fvLwfyG331VHT4KNo57lFnsd9711kN5L3YD5ePc=; b=
	pneMLQ4BwGQOQ0suX9tDZ9pKPNXtP9T2blM4zYqBsZN1MCeV/fYgqcMQ8PMDYVYM
	g0U4UgaoVEBSCvZ6+liWrNNqX5k0HCdP2pbC6FHn+okx4ClSr/8Ih/Gi1uZJVpIm
	+tX58RzEdcHSovLk44+a5gx3RHhjWpFrH2nC+PkS5oNEQJbsVTWaU9pwkEfAt/QF
	MtO06boltvWC5QSGro7KuZssqt5MSRDCevsN3Fu6h4DzoQ/3gz+IkN+ndBtSWB1J
	E7pn5ENaDrsWiAoxsdXrQKFFbzKsi0KSgCbGoaxv4gIeI43TBwSyqJclGqZaZdWy
	/2wirOQOY0T66PcDssbjcw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b4r2xgmxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 09:17:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8wkqitTU82XooV5s4KHAn/tNDHR2YX88ZJql4eOGKwOM6nykhMcrNrVkpriY0/8+0ELvYy9We/nhMaCROJShNu77gsygFliJK8UGKZazXvHVk1Bnj/Uo2gwBZ9CTKULKF9wVkF6wdTyORnZlv4FQmq+1m91wece3Xx/2dCpgSlydcrOZcdK0AtTTtzmVZsc5rhe8k0L0/MGK/0LFzT8h54mIZqfIQtCd8efmnBwwU724UYbDHGR2DOQV1TX+9udm8xQT7OpGXU4OEIBHuiqk95qWttiOUZtAO/Anyy0TCXCjjegApGqrY3lz8M4uKPF+EPpZYu9cOvXunb6L9fR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxC9fvLwfyG331VHT4KNo57lFnsd9711kN5L3YD5ePc=;
 b=ketrj27eUx3XaTSkVYpBqKkbwlEztoxpIYKpEJBEnVfcoNpEeeEeN9YGaBhNTYiU4XlTGRdK4TLiO0xWNovmv/TqVbJiQdN4cabK+YMreoTLmKsuigfYwZX0EkDIWM3p605j0san8i3D9arRJ7fLNK5RaQlD/w3D/VfMlrqIg2M4G3Di6EQ6KTTgnpwCzsbWIJhmirf0Uxo2Hh88R6nDwbPTxK4sF0gQ2gbQhdV5rzJgMlnevuvzshKONy5KhFQ+Q8ScLqMhPNCoOBS4sMe5KaHuszC3WDft9IpMr9a2r4KzxBlulTG0M2S6mgWPz2tPQVLJa7a3O7Yvv40ohqeRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by BY1PR11MB8029.namprd11.prod.outlook.com
 (2603:10b6:a03:526::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Fri, 19 Dec
 2025 09:17:01 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::56cb:3868:6b6c:193d]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::56cb:3868:6b6c:193d%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 09:17:01 +0000
Message-ID: <d13b87c6-6d53-4a71-9b61-a69e62d555e4@windriver.com>
Date: Fri, 19 Dec 2025 17:16:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: macb: Relocate mog_init_rings() callback from
 macb_mac_link_up() to macb_open()
To: Paolo Abeni <pabeni@redhat.com>, nicolas.ferre@microchip.com,
        claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, rmk+kernel@armlinux.org.uk,
        Kexin.Hao@windriver.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251209085238.2570041-1-xiaolei.wang@windriver.com>
 <f73dcdc2-a63f-44e9-9c3e-c1c6340d099f@redhat.com>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <f73dcdc2-a63f-44e9-9c3e-c1c6340d099f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|BY1PR11MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: bc17929d-4ecc-4465-c912-08de3edf5e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjQvYkRwNXpab3ZlWlppZFQ1UnRHdmdnczV3MnJTVTVoUXE5S2pLZzRENmZm?=
 =?utf-8?B?QTY4SmFJYXI2eW1rK1ZUd2dQa1JMNEliMlcwWjJxeDRXZmY1RDVBKzJyS2dr?=
 =?utf-8?B?Y2JPd3NRUFBNOXJYdWlpcEZnOTZMR3JOYmNrUHN4V2g2ZFUvSDJrR0tPV25O?=
 =?utf-8?B?SkNocVRQTit1amFxSnBuRDJ6c05BWFNDV20yNTVOTnZKMTlkM1FtV2EzK3Nm?=
 =?utf-8?B?blNDN0gwNGxvSTE1Z1V1MW5Sa2hlSTgzdTh0V2xkWVZ2aUpZZ1lYbEVneEdG?=
 =?utf-8?B?aTZKMjlEK05TaVhxakNJZDZjVUhLNXVTdTRHWjJFR3NWdFBjRjkxS0pKWkhm?=
 =?utf-8?B?eGVRdWVRY3pzNUc2bkVlcXFwSU1QQTV6bWp3NnFDaG1Rb0lkODNWZnZXVkhy?=
 =?utf-8?B?UDZGM0RZSDROd2xWUk9XNmVURm15dWJZZ1RkYnFpZ1ovcHhaS29Qb3NHUmRZ?=
 =?utf-8?B?aEswTCt2TFZIZU9CY2JudTQ4SythSTRVM2V3VHpJTjkvbXowOTdKT0dRL0ZR?=
 =?utf-8?B?TUErYzVGYWF2anBpcGdTcmgvV0t4NThJSkh6RjdvZzJ6QlFhcVFIaHFHYTZ0?=
 =?utf-8?B?WTZrL3U2NUtEQmRiT1JWYXAydjg4UVR3M281a25PVEZkR1dmbFJPdWZ5bk5E?=
 =?utf-8?B?SVlEYmpKRHNEcnVDRHVLNTUzdWZnMURZdHhHZTZRV0U5ZmcxQTlrUGtqVVNi?=
 =?utf-8?B?SXVSd0hKMGQ4bFZQOEhTUnBHcHd3K0ltblA4QWh0enduYWNGR2xIYXlmMGp5?=
 =?utf-8?B?M2hPa0pKMEFBR0tnY0htUGI2QXZlMHo2VDV3QnlHQ0ttdzI4d0dqMS83OTE3?=
 =?utf-8?B?Mk0vWUhJMXJWbDloSVM0MFVTMDc4L3VQc1VtMHNwNUtNVHVyMFBGODNyTGhU?=
 =?utf-8?B?ME9IbVc4T3JEeXlmYkhhdXhmWDJyNG9ZNFJYb2Q1NURaVGZ4MEYzNFNIaDlM?=
 =?utf-8?B?L0QzWlZqZnYxRjR6YTl1RjZsRlpnTFVDbXdBRkVpZWh6UVo4YUxDQWxYa3Bl?=
 =?utf-8?B?R2ZDTG4vYUxwWTVxYlVWTEpZWkU5K05hQk8zTktla2dZQkZMWThydFF5L05L?=
 =?utf-8?B?QWNhWmIvQ0xneEZpd2VqeWJKMk4xeFg1QXhoV0hNZGFGSDBkT2U3dGRDQ3ow?=
 =?utf-8?B?aFN2VEFiTjVOc2p0dVBjSHMxbHVBOGZsNG01cVJhLy9PSVlVa3Y4cVFHNDdO?=
 =?utf-8?B?V2FDOVVTWkhtZ2sraFhsdkRUcmljc3pDZVM5RmU2Z0xKNEZEMTFxclpqaXhm?=
 =?utf-8?B?Wk9WODVUYUViYW0rYkkyN2RCM1dqWHJaZ1oyeHpRSkxkRmVWUnVWbC9aZmw0?=
 =?utf-8?B?eGtVbkk4WGFNZjlraWcwZHgyZ3VOdFJvMFVtczIxMCtFMXF3VE1IN2RYOWdk?=
 =?utf-8?B?alZPVU56UnJIZHJBN0dGUVlUaXRycklqY0dUdDE2dmZ4bGRQYU9FNUg3UmYv?=
 =?utf-8?B?QVN6b3djQm5hVzRtckdhSDI1NlZuU09iT1dvb2k0N05XK3FLditzRHdnVHJ2?=
 =?utf-8?B?TmFWMkg2U0xOazNqTFpzeisxMENOWW5oWUlYMi9yTDhIeE1oY0N4MXRBellM?=
 =?utf-8?B?KzB5MHdRQWxVL3k2NTNWTW02QUR1QjN4cE1VZ3RLcms2SjA0dkRPU3hXK3lT?=
 =?utf-8?B?SFRRb09tMk9zNUdVWlB3TUVuaFdtejE3dTR0N3MrVlR5SHRBL3l0eVJaUis2?=
 =?utf-8?B?MXhBcVE4MnVMRndEVVp4d3lUd1lJTnZlcXA2N1Jvd0duNzFlTHp5bWNZY24z?=
 =?utf-8?B?KzAvYVQxRHpNSkdQNytxb1VyRkRUOGE4RndnQTh6aHV6eERSSXNlaFJoZ05U?=
 =?utf-8?B?VTJnYkxQWHoyV2NKOEJrdnpDaDlWWTh0ZTI5NmNZdFZwYnZiNXV1bVRxVjBM?=
 =?utf-8?B?ckZvWmhXak5KU2gwc3VzS3VGZnQycGY4NDNKd3hHS1d5MWErbDVCT3pBVCtT?=
 =?utf-8?Q?tnh8XPPXs2T4liSLFiD9PXbUU8eNyDSr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUxXNEx6WWl1aGNSenhHK0hOUStlaW52MXJaTE80bzFDVUNNc0lCYjVmR0RN?=
 =?utf-8?B?ZForT3pIcFdsd1Q1Qmt4MWdvODFhK3hjbVJDZks5bFFlRXRPbjdCUWlRWkV5?=
 =?utf-8?B?cmNZRGxEdU9Sak5yWGl1bHpBbTZHWS8xOWZSaG9aaUpVc1lPQy9pTG5xd3M0?=
 =?utf-8?B?ZjZjU2hiczBnNzZIcEdzRFhzYkdFWGZ2WFl0cFNVQ1dLU21BMjczejNWb2Nq?=
 =?utf-8?B?RVdoUmlrejBJUHc5RWZsNzNqQ2c2TTFVZGZxUkhoMVdtWWZKUEhGNXU1Z2d3?=
 =?utf-8?B?RDFLU2k4b2lvbTd3QXphTmNZYldmWlowSEc4TkdMdlV6OGV5dzdOR3BIemlU?=
 =?utf-8?B?RmJ3ek9pajhWZ0xpK055YlhoZ1hBM29saHJwV1BHa2Z4SlQ1bldhc3pwdVNG?=
 =?utf-8?B?cUdZZ042c2FJNHcrRXZtdldzRlpqSU9WYW1BbHdKU0s0djJodTVGRjhSbEN2?=
 =?utf-8?B?SEFodkQ3bHhQWnpZS2t6eUI1T1pxUmhjdlRoZS9GWkREOWFWQkR1ZWFyY0Uy?=
 =?utf-8?B?R2VEVVRmRTZZSUpMK3B2VHZkbGJxdkE4VGRxU2dNU1ZQNzJlWnA3QXczeUJr?=
 =?utf-8?B?dFN4N2lyUERPUmlzek5XNEZkRGd1UzA2TG5YRlBHaE13ZGNBR3FDejhXTnha?=
 =?utf-8?B?U1J5WUhqRys4a3JoWUFYRUtCekNFbkFoTVlpaG1keHRaaEZuY2xMTE5uY2Vx?=
 =?utf-8?B?VzRtaldnUkl5UWx3WHhBc2c0YmhHdWkzN0hMdmFyaVhEOEp2em1jNVpXZGJN?=
 =?utf-8?B?WWM1Mloram5TNXpsMXpyZ1NSZldZbWE3KzJTU1g0RW1EZW40RStoTHJIeGp3?=
 =?utf-8?B?NlRWSWFHRFFBQzFmd1Q0QzdtMzZGb3NxcUlCWFovdlRXTEVuVVZFUzdzZTdy?=
 =?utf-8?B?NDZiWkttNzBqTlpvekNvWStuTzc4M0Y3Y1ovc2tCOS9sYjRydXUvYzMzVUx2?=
 =?utf-8?B?Z0V4djJqYThGQis1bFIzYmFqditXemdLcGR4WGZZVVk4dGZIazl2dUJ0cDI0?=
 =?utf-8?B?WWs2RHJoK0MrN0l0Z0ZhL0g5dmxabFJ5NXArWEEwK1hWMjJFTzlPV3BJUVA3?=
 =?utf-8?B?a1VUZlNCTE41THNBVzhuNHFKYkk0TUZtQUppc2Q4TUI4bmpzRjM2RUR6MHJr?=
 =?utf-8?B?SHdVZ3llZDRVT1VtR3ZyTURReVlkZ1FWVnVzNENLWFpqUDd0S28zU292Z3Vx?=
 =?utf-8?B?NXRlNjUvSkd3Z2doVkdISXlsUnJTRyt0cUFOUm5tbTF0K2pjU3A1dVRaQjAx?=
 =?utf-8?B?V1NXOFc2b2RwYnJDZkJWSkhSc2RqbVhyUkx5UytPY1o4RWhMYjIxM1l1clI1?=
 =?utf-8?B?TURDV2RVN2RpQlBOMzhhbDFqWGc0YUprNVRiMzRtVzIwM21DaTFaclhKQnBV?=
 =?utf-8?B?eXg5MjJONkF5T0dlVlVzSk84Tng5N0pQUEVTQTVoUVh1ajk4UFJ1a2pPak9C?=
 =?utf-8?B?VnVjZDBPT3I1UHJsU1lFVzg2SHBQRmRwd0JMdVBtY01wUDU1NXRpcS9lcm1t?=
 =?utf-8?B?YzNyc3hHMGZSdjI2d3hxQUI2TnM0TUlvRkM0M3E1Wm5nZU00d2Y1U0NCVmQ1?=
 =?utf-8?B?U2Zka3dZcHFHajlzWDRmekMrZ3VqRlF2R3JmSzRkMUZVR2RyUXF2anJiWVNr?=
 =?utf-8?B?NTN3R0FOOFd4YXZucFhGeWlkamRUM3dJY000SWhGRmM1dU95Tm8zcXB6Z1Nv?=
 =?utf-8?B?aFVxVGZ1YWVPMXB1NDRodlIxQlp0ekxpN1FjUWU4ajduUXZjYVFnZytQVlpo?=
 =?utf-8?B?T2oyY3JUU2dTRnlXSUVCT1kydmlITjJNeHBXRFBzOXBvbnhQNWtPQ21qMmtI?=
 =?utf-8?B?STZkMXhXT3U5MWJZRzM2T1BBNmRBQ2ZUVDZ5NEpEc2wvYmU4M0dBR1FKd29E?=
 =?utf-8?B?cFBJTExublZ1K0Z6V1UzNHVVd2I5ak13aTRsV1BJYTFSdStPaWY2ZVVDZ3ZG?=
 =?utf-8?B?SG9IdkRRLzdzOXN0ZXFPemZDMTg4SVVhbkpheDNZQ3A4cnk0VnBMb0QyR2tZ?=
 =?utf-8?B?ME9tWGxRYXhYMXhXb2tnVVE5TmZOQ090dnVsZm9JSld3QVZMYXVwa1NMOVJs?=
 =?utf-8?B?STYzeEtOcVJ4VVpCOW1RbnhpS3ZPajAxTktkTCtqODBUNmJKM2dOQzJudlNC?=
 =?utf-8?B?RXZQS24yV2xhdFNHeDlYKzAvcDN1TlZkcTZsRVY3R0QwWms4eFZUT1pmTDNu?=
 =?utf-8?B?eVBaMER1ZGR6N3dpNUdFVHIvZ1BPQXdySU5ObWZqcjlGMjY0M00zSWYyOFRK?=
 =?utf-8?B?bW54U1RoNzBGQURrQ21GTXVvWTlnPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc17929d-4ecc-4465-c912-08de3edf5e19
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 09:17:01.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Lo+or3GCsdUy10ur/Mio4YxYq3Do+36CWw82DwE+S17ZYOXPVSDuSpiwAUpGjucGPosbFakN8bzqps+GJCmJbLjiKWeLfiK//X29RHS0Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029
X-Proofpoint-GUID: XdqjXhwBVeNqb2WlD6wgy7DsEtSzpmRn
X-Authority-Analysis: v=2.4 cv=eMgeTXp1 c=1 sm=1 tr=0 ts=69451810 cx=c_pps
 a=3TwBhgzW/NSYP80ElIqEIA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=qH4bqkF-ow7YOigO4MoA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: XdqjXhwBVeNqb2WlD6wgy7DsEtSzpmRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA3NiBTYWx0ZWRfX5u6pdyIeJLbQ
 cvUXoj8sl/0EGKErPS98bTKhsYHCW0zUGAJSh7ZcSQ1gmL1qtoCWMtH+16zYoi1hFOlm/J0RSzD
 uKyTlzKZLfE0vqBGVctASu4SZ6Qc7KviDoPNm/Zlz5De3ghojhUs1BjvSuA76hAdZ8AdNvM+QdY
 rfF9joPb2OEXSLjhQGf4yTua2DopvAjt2zMldAfDm9reBrmyZmkS4ZLExeDfsX4vafCJyh6+xbk
 EedvlOWnx4vhUKsz6+ZiAj6djK8tMrVOe5wjkJDSLm06oG7QWITkksFLhZzQKsZ6VXIOjBXfL/3
 KfveSx/LzG4ZFiJ1qXdT14FQ0WCHtbwt5YlZRVZ36gkeBVOxIhLdIPYMNGYneft09MZVl+rn5Fb
 VRuYb1IlULrOq+vbkjkfyyLlOBO8rRpZHvF+MiMASegCBWaCHgSYxKV5pP5N1kgGWYPMPxzC70Q
 rzq17GTKAtld3nwoshw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190076


On 12/18/25 20:14, Paolo Abeni wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 12/9/25 9:52 AM, Xiaolei Wang wrote:
>> In the non-RT kernel, local_bh_disable() merely disables preemption,
>> whereas it maps to an actual spin lock in the RT kernel. Consequently,
>> when attempting to refill RX buffers via netdev_alloc_skb() in
>> macb_mac_link_up(), a deadlock scenario arises as follows:
>>    Chain caused by macb_mac_link_up():
>>     &bp->lock --> (softirq_ctrl.lock)
>>
>>     Chain caused by macb_start_xmit():
>>     (softirq_ctrl.lock) --> _xmit_ETHER#2 --> &bp->lock
> Including the whole lockdep splat instead of the above would be clearer;
> in fact, I had to fetch the relevant info from there.
OK, I will add all the logs.
>
>> Notably, invoking the mog_init_rings() callback upon link establishment
>> is unnecessary. Instead, we can exclusively call mog_init_rings() within
>> the ndo_open() callback. This adjustment resolves the deadlock issue.
>> Given that mog_init_rings() is only applicable to
>> non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
>> and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.
> This part is not clear to me: AFAICS the new code now does such init
> step unconditionally, which looks confusing. I think such step should
> still be under the relevant conditional (or you need to include a
> better/more verbose explanation describing why such check is not really
> needed).

I noticed that the initialization function in 'emac_config' is 
'at91ether_init()',

and 'netdev_ops' is 'at91ether_netdev_ops'. It doesn't use 'macb_open()',

so after moving 'mog_init_rings()' to 'macb_open', we no longer need to 
add this check.

>
>> Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up()")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Kevin Hao <kexin.hao@windriver.com>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Side note: you still need to include the 'net' tag into the subj prefix.

OK, I will add "net" to the subject in the next version.

thanks

xiaolei

>
> /P
>

