Return-Path: <stable+bounces-146162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA69AC1CA5
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 07:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980347ADA8F
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E0222590;
	Fri, 23 May 2025 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g2AWIets";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y36P67ZN"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F52236F7;
	Fri, 23 May 2025 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979393; cv=fail; b=aMS9CV0ZBnkGFxNwhqbb3O//Z8emo8DdhbPnlhmZ7D3Bh5iWUTkHvGIaoZWJaZ/oQTEDnRY1s6UWeDamkov62MMQ0a5SpE/i+ppz7wjwIMLZcs1LqsUZOFoqYTa3CmmVLlB3MeEVMGOLQFmJXMLNqoLEwpPRUfPbkbSBcU+Ok/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979393; c=relaxed/simple;
	bh=GR45srqe6BhT6S4Hg24YW/cHsEYs4Em/+4mxoZbOEGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ce29Vqh/PeVaNM22Wn1UuPLZLYPhcEFtGEdV3hQMRbTfK+ZAtflaH3jQxCwnIx6MCWMMJZjLVk5ouNv78s/X5NJiXhvjdAVSJP1tpMUBGpVHFOgmz6cxhkkaWIXwI3ARlQjU+XzCrPwMPm8Z2LwDZfVl+IIRO9PnW7VdKUjG/wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g2AWIets; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Y36P67ZN; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747979391; x=1779515391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GR45srqe6BhT6S4Hg24YW/cHsEYs4Em/+4mxoZbOEGM=;
  b=g2AWIets1/HkLrZtN47hK3+j00sqDeju1x4WCKL/GCvzZ25L67LxDhFU
   PLeWMwMLDLTmtZ2AXKG3+KJqytmKEreTX9uBfaQY2/HOjGQHY5M6wf/x4
   VnS2GFCu+HfHe72gwfAWecKwqXpcPHXpQL6Vg2lzgmAyoIX86AyMoaXBG
   otFFnzN92pj43VchsOyk/r/VJAgT+SyavgQtiQItjnwnk0gect78PIF9k
   zi4zf9bccMY77pMX7fSEsowSrEbh/1EDddlI6gIKgHr9iOo0327sVvJVO
   sIti7OTyiZfAkg4Gw2TH8pRRVmW4Zbj59N/6Fkyw10eoan9R3S3e5voZK
   w==;
X-CSE-ConnectionGUID: FlgWj0F+TESCCwcluvu59w==
X-CSE-MsgGUID: vaIMKASQQ2erUMhAUdy9AQ==
X-IronPort-AV: E=Sophos;i="6.15,308,1739808000"; 
   d="scan'208";a="87835646"
Received: from mail-co1nam11on2080.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.80])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2025 13:49:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqi094UUKUpYHSuzmThshvCkpnuuujbJoySXosTAzAeGs5WKMlTqDhj/19qnFbyQGqBwx3ls3+5gU30WoTxT8eK7co4wlX+ho4bM3yvIr36GFKQxf7QbQPFq/xTiNWptTvx9mPhQmtaZ38Ej1XIq2f98yURX6QMtCWphxGwND9Iz4RnixJvJ6ldmt7Tz90Vg/L9rpaiaLHImZWyy6s/GT+UJS/rqh+VzITeqTUMn/XVKlpDSmix5kq+6W9du5962YmDSld9bxFjRhNgnZ+DoduHH6l03jUALgig0Vj09jag/O+S4CrRUqHUQmcM12Ju5bmVyvy4ddJoVKvUqV0IBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR45srqe6BhT6S4Hg24YW/cHsEYs4Em/+4mxoZbOEGM=;
 b=kNjZaldN82MsX+WQ+yiSCrtbaW4XavBRZczZPzp7dZmLjwlrg0o5cv+qwO/1jj0SN9vIB+G2usn3bTDDPBHPLnSSISuyhPT+7LaG4QifIvl7nXuqgeUsUcg+BNF93z2Mu5UO8EM76ibt5m3DEG6MOgb3lNq9o1YLTQgorEYX8lS9cCSl41pFVzYPj51P1DloOmfsfWkYwuqwPsjruMVMKtwcRojHBMoGf/yPcoj3/WYCCTxxb50hLKDCW4YNCnclxMyitHR9u8AvuKV/xuPdBTOti55k+96Jw8z7z9kFJUfwIGQA2i/ERcIP4xnXha7SBssAaU7MTSutRGscWxBiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR45srqe6BhT6S4Hg24YW/cHsEYs4Em/+4mxoZbOEGM=;
 b=Y36P67ZNW6YXVz9jyV7mS7wRjUWvc54ZxZKgvRpRJLqTHUGNUNR8SAyxBynnFIJUdr2ejrJ3iVQpOZ2HhEfsivGV3yxrz5Z9ky6kCd1nxsTpGANXzMU3iEMzg2SvzOGRkroGL/zZR8yt6o3+1MxS+Wiq4HWRVHoI0bj+eLGvqEo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8254.namprd04.prod.outlook.com (2603:10b6:806:1e5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 23 May
 2025 05:49:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 05:49:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
Subject: Re: Patch "btrfs: zoned: exit btrfs_can_activate_zone if
 BTRFS_FS_NEED_ZONE_FINISH is set" has been added to the 6.14-stable tree
Thread-Topic: Patch "btrfs: zoned: exit btrfs_can_activate_zone if
 BTRFS_FS_NEED_ZONE_FINISH is set" has been added to the 6.14-stable tree
Thread-Index: AQHby11n3kSPyqIwdkK/BLoAOXn7BLPftjmA
Date: Fri, 23 May 2025 05:49:41 +0000
Message-ID: <e13efec8-eaa7-47e1-9c67-06d7524a0c36@wdc.com>
References: <20250522210607.3118447-1-sashal@kernel.org>
In-Reply-To: <20250522210607.3118447-1-sashal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8254:EE_
x-ms-office365-filtering-correlation-id: 210a5d73-1eaa-4715-18da-08dd99bd9d07
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnRnK3hucEVvM1NQRmFHcDdtcW5tSi9sMVB1RUZ6Q01iRnhGeU1SQlpoYnYz?=
 =?utf-8?B?TnVHQUpNYnNIeUpnbThvL2p0L1IrUFZJcEU0NU9KOTRVdk5HbzZiRWxqVUVq?=
 =?utf-8?B?RWcxUDF5aHo3Y21WR0wzUkNoSDYzU1c1QnRrKy82cjVTMHJSVWlCSWIyZSsx?=
 =?utf-8?B?Q2txdjJWOU9qRlpBeENjaXFDMU9oZm1QRXVocnJZbExjWUpoWU9NVXJPRjFV?=
 =?utf-8?B?VmtWSUxuck5yb2kzRDN1L2dyQTFHOEZJQ0ZlN2RURlNIU3pCeEVwaDdMMjQx?=
 =?utf-8?B?YWtIQXdRRWd2R1Fiam1yZ0dZN1Y0MjlrNy9GNkNNRmZZa3BLcEQ3bWVHLzJN?=
 =?utf-8?B?U1RUc0pISWRiUm0zdlVLcmdncmJ5VXZEMFg5OFdkUFNqai9ta240QjVCUHlq?=
 =?utf-8?B?VzJZNWNYNmlUQm5WS1RYS2x1cWVkLzM2WlJ0Rzd6OGpVdkphdGRBVEhBbUhp?=
 =?utf-8?B?SG1ORXNKSnVzTTFYUHhTTm1aUHdiOHdYS09ydUVzNERTQkhsWUlJVDdzZDNR?=
 =?utf-8?B?MFB4WFhGckoyL1N3VmtlTGozV2pDYXphb1VjbXJTYU9Od3NuSFE2b0lIaTRn?=
 =?utf-8?B?a3lWeExpdTZGNGlkK1JWTE5ETzh0TkU3eEs1Z0ZzK1JiL3ZKTWl0NWFFcWlP?=
 =?utf-8?B?RW4rWkgzOTJKNUxRbmJGdmwxMU5JNnJBSTZTcm5HL3BQcmc5SzcrdDFrU09p?=
 =?utf-8?B?aEhVQ0dRay9KczZ2OTM4ZVBTTUg3SW90L2ZxQ1hpaGxtRGExYUZocnBodUox?=
 =?utf-8?B?WDRweWdyMFIwL0hmRVg2aHRuU3ViMnVHMlBQb1QrQXlBZW9weldIaExnRFND?=
 =?utf-8?B?V3B3eWgybHg4UjJ0Z01JRU9ESlZScXFlQlh1ZkVaZEZqK1VQdjlCOVFqd0Nk?=
 =?utf-8?B?bE1JVEl0OVlqdEJEWE9TMTRLTUhpSmcxNUF3MXJvLzRScHI5azBLa0I2S2JC?=
 =?utf-8?B?VjlhTkNEVjRDcGFDWE11U1RVSDJXU0VLNmFaU2xDVERtcUg1ODVXOThoTHNn?=
 =?utf-8?B?dS9JeGw1QTZ3UlVOSkZJdHNUblhLTXdLV2pBMWtsZHRUOGZPdkNzcUx0N0dH?=
 =?utf-8?B?ZGFncVhWb1VLVGdBRU0vVWRBQUVyNytMOTVFVXl4NmlwZ1U2Sll2TytQOXJZ?=
 =?utf-8?B?S0U4SmJoWWxYenNQTURJbmVPd2Rzcit4K2xKMk53VXYrMUpmK2JYb1BsWUla?=
 =?utf-8?B?WHQ5S1FKL3ZKdFBuMXNwcitvellYeFlGLzl4anZEQWhHZ0RHci9LUzF2OXpG?=
 =?utf-8?B?T1gwR28rMXA0RDNJYkhZU1RHOU5UUlpVZGIzalZnRjhZTUNVbzdWRjEyemZp?=
 =?utf-8?B?bGNQOTJZVkpzai9hTXh3SkxYMlJXT3Q3MHRaNGoxUVRxRS9nQ3pOSVIxWlNN?=
 =?utf-8?B?U3k1Qm9lOHVCcEtJZG9ZcUNWWWlFMFNPRkJScDh1R1J1cVJaOEZtbituZndU?=
 =?utf-8?B?d3QrYS9sbVhCT2hEVDI2WVpCMHpuOXpYalJGak9XbDhQQ05BVGJWL1hRTzY0?=
 =?utf-8?B?S1daZHI5Mi9FdlppZlQySnYwYkZKdHlLdzlJSEhwUVdBMndnbHYvMk91K2hJ?=
 =?utf-8?B?eFZPY3dpTVVrM0Q5em5uNTc3WVRKMWQ3dVl3OExwRE85KzZsUUxFRzlpa05a?=
 =?utf-8?B?N1FxR1N4Nk9pKzMxaVVubWZscW1ZaUlvQysxNkNnUFhsdlVkdXBIaVBqMEJK?=
 =?utf-8?B?bVdOUSsvN09oRVFuZFoxTEg4K1FBMUhHUzA3OUl3WVMxWHBGWkxaa0taK0RY?=
 =?utf-8?B?M1JnOGc2bHN6SXUySkNKOURBTlpPRlhkbEM3aVRrUXhPQjJNcGtmaWcrb0Zq?=
 =?utf-8?B?OHV3REZ1SW1pNFhJaFdYOEZyS0tqUDdQRzdwSDJ5c3hzRlEzbFNBb29EUHll?=
 =?utf-8?B?V251bUlNVlh1MGFTZG5wK0ExYmQvN1ZOS2JuRUp5RGhpVDNyUkdndm9DdC9I?=
 =?utf-8?Q?47Y2gOJFUHs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGZJd1hQZXl2c3hNWUNGMUJEclFOZDlLaE1hU0dJZk8ySExNSDZWZFNMWlRG?=
 =?utf-8?B?d1JpdmFrci84UFExbmhMYVo4Q0VWOFEwTFZLUTFyY1A4a2tITjVmTWE4c0M0?=
 =?utf-8?B?bXE1NVdZeklaNWtBU1d2YlVYUkYwUElZVEZUcDU2WXR1UW9Gbk1ZeWRlcXhn?=
 =?utf-8?B?bVRzWkppZjFMUTFLVnNjUEQ5L09kV0FpUklleWhaNDJVaHhtTGlkN3F0Q0wy?=
 =?utf-8?B?c1FmTmdvcDJIZW01YkRDcVR3ZjVMM25UbENiWk9Eb0tweTlFbUlBUWs3a3ho?=
 =?utf-8?B?endQUWorYjBXV0piZS91YUsycHJIR1J6QWxHbUdVTXB1NlVKSjNQbWRVOU00?=
 =?utf-8?B?NjZxRm04ZzVVb0FOclpkQU9nRmhvbWEwQVc2S0lrS1dtckw0eW5mT1M2MEZt?=
 =?utf-8?B?Z1M1c3EzcDkzL1ZIMlZ3NWhqb1EyVkx2LzdzSmZJOTRPT1FJSUZ3YTZScnJl?=
 =?utf-8?B?MDJtSWZoTnNRcU4rRTVGS0s1MW9nblhLNUZlYjNwak0rcndmN04rcW1BR1Vw?=
 =?utf-8?B?QVhKa0xIay8vSVB3VUpYZ2hPeDJoczh5Y0R3cHZZdXhNQUdMNG5BbVJhdHJI?=
 =?utf-8?B?T2hYTmtpRXVKenV0MHpKKzNmZ0N6NjI1TXRTY3JLTSs5a0NtYnp0M0tDV0M1?=
 =?utf-8?B?MGRWQU9YRE5KcjdpbFlQanpBREc5UjZyYngvSkxEOUJBS0R6WGo5YVpjSFY5?=
 =?utf-8?B?ajVVcUt6ZTVYN0NvTmxpNmNCWnlYTEZsU0dnbDBCb0FTSkhnUmdGcEMwMGJU?=
 =?utf-8?B?VEx4bzQ0VjB2eUxuQmhqZlA4dFJmYms2cEtKSHdVeEN2eEZCa29PdUJyVHNV?=
 =?utf-8?B?ZjlOeVpxSzh6MFlaUVB0ZnczRVR1czdsQ1pyRFJpdnhqSGFyUzVIMnVYZWYr?=
 =?utf-8?B?MkIrREtVRGVvSEprWVFoMzZheFBqN3FhK1FWSDRwVkswcWtHVXZZTWR6Wk43?=
 =?utf-8?B?UTRZZTU1UnJMYmxadmZ3aVNQbldlMXkvaHRSM2Exc3FVRkE1cjN2YjZIN0NN?=
 =?utf-8?B?WmEwU082UE1iSUgrV3A4TExYSFNSbnM4VVFaT0I2N1M0ZEhXY0lEK1RWREpw?=
 =?utf-8?B?TTMxYlFBTStEYTVOTmtmNWplMmxrN2RzQkI4cWN3WWlwZzBwTW5jMW1yQUJD?=
 =?utf-8?B?OVg1R1E1N0tLMzk3TjNaSHFuM3o1TW94Y05LSzNmMVpMb3RXWXFad0tkSGdM?=
 =?utf-8?B?dDJNV25qTURzUjBlNHBOUWdxNldBUjVYWEdLSmlDcktpNzFIb0FMR2xuNTd0?=
 =?utf-8?B?WnFBR2k0WDZxZE1zeHVSUDQrS3RpZ0hkSjlMQXEzbGJxbnlHT0U4ZWlrRnp1?=
 =?utf-8?B?Z21RR2VrbG1VZllCMUZlMGpyQjk0SG5MNE5aYi9YSWJCWFdkV2N3bjZ0YVh1?=
 =?utf-8?B?S0czcG5FaXBJMFJ1WnlpU3ErUXRueEphL2FBdnVjZTVjd0NFVDZlQ2JQZURO?=
 =?utf-8?B?WkZZMnZZZHhxbXgxYjhIVFNXcWtqVEJRVWVMT0VCajIyMnVucjI1V2pnYVMr?=
 =?utf-8?B?WEY2OUNvdE1PQzEvbjExUWc5bHBNcFBJVUxKdlh5YkpxUEFuY0ZXTkh5WWps?=
 =?utf-8?B?Mi9GeUZ4SEJkNE1ydGI2cDRNVzJUR2pLamZNeDF3dkgyOTBmYXMzVFFUM08r?=
 =?utf-8?B?cFJBWkFZaEVxcmxzQStjZDVzSmlTalB4ay9NVkxGN1RpL2Rhc2UxUU5WK01S?=
 =?utf-8?B?MGo0L29KWmxCVlIyc2kya0Q2UzZuZkpxeE1qaGlVeXBUZ1BHZnRmSHdDYWhO?=
 =?utf-8?B?eDBzU2VjMitMc09yNWUzTzNDbjlXanl4OWFhTFdxK3ZmdWxMdmdGZTF0cWUv?=
 =?utf-8?B?V2VjR3BBZWJaSTZPb2YwT0hDbnRQOG56WkQ1enMycEpXN2pBZ1BlT2RhWkJD?=
 =?utf-8?B?N2h2ajVzMFhITmMvMFg4VFI3ekJDemwzUzR6SGV5TDR4NmxsZFFvLzBPVjVi?=
 =?utf-8?B?SCtkeEtqYnlQRzh0a0VHYmx2YklIbG9CdmtTR2VRdUxoNUVBZmRXRFRGQVp2?=
 =?utf-8?B?c1d5aU1aL0NjcU9QSXNrcXlpSGtOSWlOTXlOM0wvSVMyNDU2WXg0clhjTlJj?=
 =?utf-8?B?TU9PMlloR1gwSDVvcDR3aDVxMFFVNElrWElsMjc1aENNOTFuM2tZNlBoTUxK?=
 =?utf-8?B?M1NmRndCNXZzSFo4dExjTU5Iamd5ZVFMTVQwZ3lta3BJMDFNM2VQZ1hOVmZp?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD1150BBAF697E40A289AC0E8B3E1FE9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PfmiIK80/3TOHL9S9rhmlOas3xwBGknR0yihzY6N+Wtk3iIkOl3NNik1agQJvymEVdaDREgqbDq9ks/8t4yUIcgAKCts4La/sI5FI4e0jyuIkjlvBlvTx0XQaqiYR6DBjxQTj+v7UcRhlwa8hKYaqVqbSSksJe3tRHJiEgYPoSgTYbLu2CsJNla6qUQMag44cqCJA6kt+hq+eI1TGbcZBOlrHo8J1qNpDrwdY+CMoryItv8pgto+KPALRi/MC4PWMwgYcnDhNUg048jGdQ18oZYlK2I0B+5Z2vNCR4+mYUDJMTFlSHgVRT+EBp/o9Fm2N33/wIDqI4IIV9Ig4Pevzum7UHyDFGz0DQANbr9sMVXGQrm/he0CWTEzuZQPpY7iDrTeiQ8fRfMKUaOZ6RkbQ6zGvqPZiybZOLXNAujtu2aISkv55RKpmEH8Yu6VJtoImO20B6vGyla9xQ0m2ckfaXCwztB7onPTsaPtDBawzPAZgc4crKmioGdd3h1dVUDEdNkSmjqYBa4wS0jvoNhDVD8BPgaSYd4yPua6bEtOgG56bTf6gPAzdzmR1XZ4Xs+/ujnNlq4I14ePu6+sBJ5Ic6zrfSQSMSOn3Z/w6Lj2qb+n1Ye1u8T00Ph1mZoc1wmY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210a5d73-1eaa-4715-18da-08dd99bd9d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 05:49:41.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftQrVGsoHwFc0O1UQU/mak1YMhyvfPZuhFGVaBOPMb2O00Oz4U80MbCn90/7g7U4v4BUSFDw3r+/ufh2L/qxU6h7aFN1oyPnsi+LJd9qYT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8254

T24gMjIuMDUuMjUgMjM6MDYsIFNhc2hhIExldmluIHdyb3RlOg0KPiBUaGlzIGlzIGEgbm90ZSB0
byBsZXQgeW91IGtub3cgdGhhdCBJJ3ZlIGp1c3QgYWRkZWQgdGhlIHBhdGNoIHRpdGxlZA0KPiAN
Cj4gICAgICBidHJmczogem9uZWQ6IGV4aXQgYnRyZnNfY2FuX2FjdGl2YXRlX3pvbmUgaWYgQlRS
RlNfRlNfTkVFRF9aT05FX0ZJTklTSCBpcyBzZXQNCj4gDQo+IHRvIHRoZSA2LjE0LXN0YWJsZSB0
cmVlIHdoaWNoIGNhbiBiZSBmb3VuZCBhdDoNCj4gICAgICBodHRwOi8vd3d3Lmtlcm5lbC5vcmcv
Z2l0Lz9wPWxpbnV4L2tlcm5lbC9naXQvc3RhYmxlL3N0YWJsZS1xdWV1ZS5naXQ7YT1zdW1tYXJ5
DQo+IA0KPiBUaGUgZmlsZW5hbWUgb2YgdGhlIHBhdGNoIGlzOg0KPiAgICAgICBidHJmcy16b25l
ZC1leGl0LWJ0cmZzX2Nhbl9hY3RpdmF0ZV96b25lLWlmLWJ0cmZzX2ZzLnBhdGNoDQo+IGFuZCBp
dCBjYW4gYmUgZm91bmQgaW4gdGhlIHF1ZXVlLTYuMTQgc3ViZGlyZWN0b3J5Lg0KPiANCj4gSWYg
eW91LCBvciBhbnlvbmUgZWxzZSwgZmVlbHMgaXQgc2hvdWxkIG5vdCBiZSBhZGRlZCB0byB0aGUg
c3RhYmxlIHRyZWUsDQo+IHBsZWFzZSBsZXQgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+IGtub3cg
YWJvdXQgaXQuDQo+IA0KDQpIZXkgU2FzaGEsDQoNCnRoaXMgcGF0Y2ggaXMganVzdCBhIHJlYWRh
YmlsaXR5IGNsZWFudXAsIG5vIHJlYXNvbiB0byBiYWNrcG9ydCBpdC4NCg0KVGhhbmtzLA0KCUpv
aGFubmVzDQoNCj4gDQo+IA0KPiBjb21taXQgMTEzNmQzMzNkOTEwODhlY2YyZDUxODkzNjc1NDBh
ODRlNjA0NDlhMA0KPiBBdXRob3I6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQo+IERhdGU6ICAgV2VkIEZlYiAxMiAxNTowNTowMCAyMDI1ICswMTAwDQo+
IA0KPiAgICAgIGJ0cmZzOiB6b25lZDogZXhpdCBidHJmc19jYW5fYWN0aXZhdGVfem9uZSBpZiBC
VFJGU19GU19ORUVEX1pPTkVfRklOSVNIIGlzIHNldA0KPiAgICAgIA0KPiAgICAgIFsgVXBzdHJl
YW0gY29tbWl0IDI2YjM4ZTI4MTYyZWY0Y2ViMWUwNDgyMjk5ODIwZmJiZDdkYmNkOTIgXQ0KPiAg
ICAgIA0KPiAgICAgIElmIEJUUkZTX0ZTX05FRURfWk9ORV9GSU5JU0ggaXMgYWxyZWFkeSBzZXQg
Zm9yIHRoZSB3aG9sZSBmaWxlc3lzdGVtLCBleGl0DQo+ICAgICAgZWFybHkgaW4gYnRyZnNfY2Fu
X2FjdGl2YXRlX3pvbmUoKS4gVGhlcmUncyBubyBuZWVkIHRvIGNoZWNrIGlmDQo+ICAgICAgQlRS
RlNfRlNfTkVFRF9aT05FX0ZJTklTSCBuZWVkcyB0byBiZSBzZXQgaWYgaXQgaXMgYWxyZWFkeSBz
ZXQuDQo+ICAgICAgDQo+ICAgICAgUmV2aWV3ZWQtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5h
b3RhQHdkYy5jb20+DQo+ICAgICAgU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gICAgICBSZXZpZXdlZC1ieTogRGF2aWQgU3Rl
cmJhIDxkc3RlcmJhQHN1c2UuY29tPg0KPiAgICAgIFNpZ25lZC1vZmYtYnk6IERhdmlkIFN0ZXJi
YSA8ZHN0ZXJiYUBzdXNlLmNvbT4NCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8
c2FzaGFsQGtlcm5lbC5vcmc+DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBi
L2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXggZjM5NjU2NjY4OTY3Yy4uNGEzZTAyYjQ5ZjI5NSAx
MDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KPiArKysgYi9mcy9idHJmcy96b25lZC5j
DQo+IEBAIC0yMzQ0LDYgKzIzNDQsOSBAQCBib29sIGJ0cmZzX2Nhbl9hY3RpdmF0ZV96b25lKHN0
cnVjdCBidHJmc19mc19kZXZpY2VzICpmc19kZXZpY2VzLCB1NjQgZmxhZ3MpDQo+ICAgCWlmICgh
YnRyZnNfaXNfem9uZWQoZnNfaW5mbykpDQo+ICAgCQlyZXR1cm4gdHJ1ZTsNCj4gICANCj4gKwlp
ZiAodGVzdF9iaXQoQlRSRlNfRlNfTkVFRF9aT05FX0ZJTklTSCwgJmZzX2luZm8tPmZsYWdzKSkN
Cj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICAgCS8qIENoZWNrIGlmIHRoZXJlIGlzIGEgZGV2
aWNlIHdpdGggYWN0aXZlIHpvbmVzIGxlZnQgKi8NCj4gICAJbXV0ZXhfbG9jaygmZnNfaW5mby0+
Y2h1bmtfbXV0ZXgpOw0KPiAgIAlzcGluX2xvY2soJmZzX2luZm8tPnpvbmVfYWN0aXZlX2Jnc19s
b2NrKTsNCj4gDQoNCg==

