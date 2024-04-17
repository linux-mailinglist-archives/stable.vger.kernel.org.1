Return-Path: <stable+bounces-40063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E18A7C74
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C611B20B8A
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DE43ABD;
	Wed, 17 Apr 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G8R4BqzU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="G4GPYt1i"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367317F7
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336244; cv=fail; b=OE8HOiFhjKoVqWmAOYetBbMpBUzkPp6VH9rJ7ewoGgMG6C6eE1sk5H9tpB53x21GWYIiVdVHeI4eoNDeivP4nTIrsTx1vkwWlKbqpHzzi2K/9Z3hZszDFoAAcPyxADhr7lYoqWQU0JypanrdRIA4AMkjzwecZjgZmJVVm28Mnxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336244; c=relaxed/simple;
	bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sn85Gzmt7bHQtfjcZijqYDa0VX5P70hQA0bZyzNlH9lRelW7UWejhcr5ucN3Wm7ARpij5jRglIFdacIOHbOAmZRKE5CP71skJYDR62EKILMRkNlvFlQ2oxyDpEgkxrPhzcKh6Nbjxz/zntnVx7Y/g608IIOZZskkptoX9ISIXAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G8R4BqzU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=G4GPYt1i; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dcb35368fc8511eeb8927bc1f75efef4-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
	b=G8R4BqzUhCNLLeJcnO+wBGvQbW/PRTg8KRrEzEdcCwiCd/1BnnfK4mxt9iYEKgpght+PAb8GWCPLCNbPukCfmOS7TEBpNedAVXg9bdnWl/bxK5K8CqWRJvUNy298pEQNobRblXJm3UGBxBdlBe8WWK2jij2fR37XDht4q2wpwYM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:2e149d71-f3aa-4d65-ba34-fc1782b5a15d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a2c44686-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dcb35368fc8511eeb8927bc1f75efef4-20240417
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <bo.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1705069190; Wed, 17 Apr 2024 14:43:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 14:43:54 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 14:43:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao2Ohb+9Du5il5M28ULrWbNDE0FI17AORflpvIJzuzJqlOsbEVrmT2zbjF1xdypYs2TkQvjVN/kwYd57fEN+5RIzX4sHIU3KntqC6f3/ukPge9Fm99KrHzOqprf1bZQB225fdvjJkt6ou+/OqhQ5CUP7noVa2XjJbLObv4Y7azgQIap7IYASFPd7oDEcxEExhDXnDM36+421kYhGbxi+E+i902Y9ax3yX/47H1/sqiEW3ZwXnPkaFFgXBALuhfRDrNRplzyBrVkOiiyo0EqWxmLemYYqimbZqYXZa6eias7+pt4TesO2Ws91pt+beyWlFlf9GhJS9RI7ZeXGq59jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
 b=KAZUZVEiGdQ5fTXhptjmVhMhLW0gDZgdTEi7ka6107tE/dnj7oJa/bM1J6w4at6IrhrPrZeeiWAM9cfyyeDGv4+ubeEOo5pOo4j9iDGSAO+ZuaTgxmaj1jJvn+vuEjB65wFFuwPoQgDwslEUqFYrIudif6X+A9Vcc8T+kw5WMAFcEkv05dMMlK1qviNX7h2n/h7TboSey9bLOz69oDO6BUVQDVFXwpvRRxDoyzipdm9B0OZN/eH497SiQ2f9T5o+o9ioH1vAC4mYpuUx2vHKi+3M1xzClvAcMd6VPMKY21ywnUKW0JUcNwU8H2St9tsxAZpy+zXrxNT+GxSGsUkACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLJLkdu1eG3aYeaIaJjDCLzvHHgut44I6fIvdTpMqTE=;
 b=G4GPYt1i8oTvDxb597qRmZP3uY2zGA1vR35aacO5aWffo7ZChJq2YWfshA82TK4mQ9OEfqA9swapZ6rAOoJR3qmT+vq35+ohID9EJTjjyifNRjVRwkCw6aSPk4rIX2pc9H4saNrq1BApFycJtlI4RTVgR7C3DVwU9vvZDjVi3Q4=
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com (2603:1096:101:8a::9)
 by TYUPR03MB7088.apcprd03.prod.outlook.com (2603:1096:400:355::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:43:52 +0000
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6]) by SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6%7]) with mapi id 15.20.7452.050; Wed, 17 Apr 2024
 06:43:51 +0000
From: =?gb2312?B?Qm8gWWUgKNK2sqgp?= <Bo.Ye@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?gb2312?B?Q2h1YW4gQ2hlbiAos8K0qCk=?= <chuan.chen@mediatek.com>,
	=?gb2312?B?WXVnYW5nIFdhbmcgKM310/G41Sk=?= <Yugang.Wang@mediatek.com>,
	=?gb2312?B?WW9uZ2RvbmcgWmhhbmcgKNXF08C2qyk=?= <Yongdong.Zhang@mediatek.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: =?gb2312?B?s7e72DogW1JlcXVlc3RdIGJhY2twb3J0IGEgbWFpbmxpbmUgcGF0Y2ggdG8g?=
 =?gb2312?Q?Linux_kernel-5.10_stable_tree?=
Thread-Topic: [Request] backport a mainline patch to Linux kernel-5.10 stable
 tree
Thread-Index: AQHakJKb8KIqbhJ1wUGJJmREWgDn9Q==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 17 Apr 2024 06:43:51 +0000
Message-ID: <SEYPR03MB65315CAF65EF8749571E3DD1940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6531:EE_|TYUPR03MB7088:EE_
x-ms-office365-filtering-correlation-id: 9eae4370-b7e7-494c-2f83-08dc5ea9be66
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?gb2312?B?Y1FKUElqbUh3dTY0Q21BUGVJcDBubVNGZlo3MWI2QzE5SmQzZFhlZVJoZHJm?=
 =?gb2312?B?VE54N2RMbGFiTTd0cnVRdGVlQUx5U0EwaU5oc1BjaEN3ajZaQnBBcTgwdnNs?=
 =?gb2312?B?VDdBR3ZYSHpJRXhPb3YzWFg2NkMwNm5qK3gxcGUzZTZyYWFrYnVzclBNTDZC?=
 =?gb2312?B?SVh2WGdwRk5BY05jWFl4S2Fmbm1xdEZrZldzNmUyeGNVbU5iZDBWTSs4ZGtY?=
 =?gb2312?B?a292K1ZaYmxIZkpZbWRjVkdZTXl4MWFNdTJieGxJMEFYZ1VJMklpM2RhdXNw?=
 =?gb2312?B?SzByY3MyV1gvUDI3dW5mU1d6TGxtOXY2UnR2OFlyTFRadGlIUEhmSUxyU055?=
 =?gb2312?B?RFFRanVCWFMrUmRlaU5XUFdGd0xhNTFjc2RMTlQ0aXBBUnl1TTErWWZWU3k2?=
 =?gb2312?B?K3lRc04yRGVZTWNVSDVZejJMbTJ0MFNZbUNPdDdwd0NEQjB6MVJia0E1aW5E?=
 =?gb2312?B?K2tOUDJObTRqanM5L3lPM2VXdVQxR0djK2pBN1M3Z2hPUytQZHlhV29IWmRz?=
 =?gb2312?B?QWFkdktqampVRGxCV0lveENuVzlRZEgrK2ZCdlhkTFI4cnRWQjZLN0V0TzFl?=
 =?gb2312?B?OGFIL3ZDeHhBd3NDMTRxM2xLWSsyeW1tMWpxRDZ5QmxzOFkvVHY4UjQrTUMx?=
 =?gb2312?B?YlE5L1BlaHhrYXNPQ0o5UnlleHJyM1VKQ3NYYmFxNGE3STlLUStiNStXNERL?=
 =?gb2312?B?Q1ZBeFNnNjcveUlxOGoxUDV5bEhSOWVHRys2QUNUTWh2VGk5TVg4L3pndmNm?=
 =?gb2312?B?M0FYYy9xdGc2Q0ZUUDd2amNSQ2h0OTRwME5lSXViZlZDdWdjeUtJUVFwdVlC?=
 =?gb2312?B?OVVRSFhJUEZ3ZU1uT1lGaDZtbnN3S2Z3VVV2Qk8zaksyeHRwUmd0ZXRvdzVh?=
 =?gb2312?B?Vyt5Vit3bDJINlc4R0pIcHdzZWFsWUNXWGJwbDM3Z1Bvb2RXb3dSV09iUHNy?=
 =?gb2312?B?Uk1TMjFVYVpQLzltNWQ1K01UVlc2NUhaRFBMVmlNUktSaDVsTHd3cFpiK29Z?=
 =?gb2312?B?WnU4VHVGbEVlVnNtM2k3VVh5aUdBZ3hjcnB0UU4xVUNZZGtON0VvbXNzam1a?=
 =?gb2312?B?MGgweWZBeEZobEM5Z2p6YW5NUmVZc242MWtyZDMxekJOSlVrRlBnLzBicllG?=
 =?gb2312?B?Q3FnZG9XWW94ejdVbHRjNDJuNVJqcjJMYyt3Z1dDUHVrVjBaRjh4OXloaktz?=
 =?gb2312?B?VUNnZzlYTHVCL2Y1YlE2Mzc1ejVwM05SMWtYZkllaDFIaHQxK2N3M1RlcjA5?=
 =?gb2312?B?MEZjMWpPN1VrUk5zRXJmVjBGWjQrWXgzbXhVcGFFVUtZTWUwYTJ0VUJSNjR0?=
 =?gb2312?B?ZWJaMTcyVGkwckFOaGJ1MTBpL2s3NkI1UEtEYkoyN2dsMTA2VEQ5b1BZWjAw?=
 =?gb2312?B?Nlg4YVhVMVZISGRDQ1Jua01JKzhIbXVMUDJaWEtFVkhES3NqbVZ2VUp3UCtK?=
 =?gb2312?B?bjBoYXhqM3hwMDB1UDNlTlRVQll0VXI2aGNSWklTZjlzRW5taWZjK09DSnZx?=
 =?gb2312?B?OXZyWGRCbjJ5YzBxYzEyU3RGVmZ1U0N1SEFvM3pLdHR0Q0dvWlQ5M21BeU9r?=
 =?gb2312?B?ZXdiL1BrL1QxK1lhUWpQdXN0dEhqUFpzRGJYYmFZK2d6Rnd6UHBHanFTQ0lt?=
 =?gb2312?B?dGJKdjVFUzYza01uVTFRbFlkTXJnSVF4MWVMUDBBOTMxZ3VzUXZJRjdEWk5j?=
 =?gb2312?B?QXJNL3NhazBnSWtlM0d5KzNYNmZna01lcm1SWE4wUWd6ZXFYNE5SWERJd1dh?=
 =?gb2312?B?cEtmQ2NsdzY2WFhZNDVBbHc1TE5Qb05BZFRBL09ydzdITkU2ZC9VMTNKWncx?=
 =?gb2312?B?Zy83US9tOEdKV3JSYk9YUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6531.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VFM2UFR5bk4yZ1RaOUZ0c3BibHBhNVNJOGNZTDJ3VC9PZ21EcE5qNkZhU1Vk?=
 =?gb2312?B?SG1tb0ZkZDlqM1VWeXhHTlpDdFgyZXcyRnd6NWRWTFZxMlZPS3RXaFFya3NU?=
 =?gb2312?B?bWM2YUtydlo4TXBNQVZ4TC9aYVZ0MGE0amkxMkJzSjlQNUhFNEJwOFZ3bXVk?=
 =?gb2312?B?TFZLcWkyeTBnd0tCWlJEQVQ2MWxpS2F5Rk9vT1dhcjRYTzNFUUhPRUhYNVBH?=
 =?gb2312?B?RjZaU0c5eUFURkxqSDA2ay9kQXRsdjdocGlQU3NaUE0zVHZZZ0dnZmo1SVdX?=
 =?gb2312?B?SXo5cmpTSFhlV3diTkpWY0RIZFQ0MW95cXR6U2tySDNYRjduQUdQSkRibXkz?=
 =?gb2312?B?RHZiMHNoQnI5RHFNNHZDS3FPQUFGckJkQ1NDM2luWFJvZHcxZGRyVjN2aXlL?=
 =?gb2312?B?S3FnTlJYcnoyNnkzTlpoczJRMEVWRGVFNVdZYlFGYXlYd21oRWEwOTl5R0Fx?=
 =?gb2312?B?LzB4WmtGTFZZL2lNNDJnR2E5b01wc215ZjVuR3dDRnNYY29ROTAxR3M3MmU3?=
 =?gb2312?B?UHhEWjZUUnRUbGhGT0t4SjBJSDBLRmJOVlRLbDVoTkYzQ2JJYmZwYXdSTjEz?=
 =?gb2312?B?MXJUWHlHckREU1BQYi9JWG4rT3RDclJiZzBGNWxqRkMwdUphU3BNSEZ4Q2lF?=
 =?gb2312?B?WkNKalhrVVB0VEdiU3FIQlFmYXFFMGJINEUwOS9pczFZcG1kY2VJaHNHSkVS?=
 =?gb2312?B?aWcxdTBFRG5BT1ZKUDcvZ3VjV0ZuSGo2SDYvS2oyQ3JGTExwREdoZm1TaU1P?=
 =?gb2312?B?bE1JOUhEYURmN1BtUkFCZzFmZEc4ZHhCdFJrMmJ3T0RkSm1YRkQ2SmdKS01K?=
 =?gb2312?B?S2RHdm9qN0hsMDVDN3ZhMVJpbFR2QVZFYUJwVlE1MGdCaERBLzg2dEtFdUlJ?=
 =?gb2312?B?OWtiUVJYK2MzQis5ZUZSMHliNTYvRlRuWTBrNVdjS1hNWlI4ZGFnalVJTktq?=
 =?gb2312?B?bVYrbHh4NjRTVXFOeVdqaVB2VS9TTUJ5bzdNZnRJWEtzaEhKeFB0NFJGcEti?=
 =?gb2312?B?S2JnKzcvSVhKMHpuZk93TmRDVUozb2IxOURGTWYrRzZkS2dVMGxacFIrMk9Z?=
 =?gb2312?B?RHpBL1ZQeVNpN1JTMDM0N1NwMHUxSnhpaHdaZkpwSGxwT2RlUTBuQ0MrRWZC?=
 =?gb2312?B?U3NyemFjb09zN1hJL3VLcS9hT1JaZG9WYzhqaDQ1UU5TY1ZucFlGL3d4WU1l?=
 =?gb2312?B?bncxZVpvNlFPMWtjTWZRTkNvTWNsdGZMRUxYd0crclhVejVDeTBtcGVXY0RQ?=
 =?gb2312?B?QjdIREtPYXNiOHQzYitLbHJ3VjVsNGFHVkhrVUZtMVhMK0liSDRpSzUzMVNl?=
 =?gb2312?B?TnBXQVJKUW85Q2VVSWhXNWVzR0luQktnNWJIekc2MFpySi9lNk0yRjUrbVZC?=
 =?gb2312?B?RTdEMitIZFBRYWVHanZsSERjVFR0QTJ2SDlwUzRUZkhvN3FkSDZIOU11VXVC?=
 =?gb2312?B?ak5FSG5OdklqWG1KemtDUW1Fa3RzNWNQWFJRNGdLOXdTSU1DNi92N1g0ajgy?=
 =?gb2312?B?WnNiU0I0RnlINXViSzlkU3l0OEZPWnRMbmRZcjU0endIMFpXc2djYzJTQ2l3?=
 =?gb2312?B?TmFneWU1eTBOeXNiaWQrNjZpTm9QMUtqVXNRQVlyMFYvbXhLeTN3YUlEdVJt?=
 =?gb2312?B?QStOc2tuMERjR1M4NEx1UnpuOHVvQXBJUmZqRVh0WllXNFZ1ejZTek1tK2Iz?=
 =?gb2312?B?dTdaRm9ZYU9EQm5sMDFzOG9JR1JRLzNBc3RDcWVlLzBQRVZ3Rkh5KzV2U1hS?=
 =?gb2312?B?RUx1V1RLWTNUWGdOOHBSNXNBeHk1OHJwc25RUWNvRTJOUW00M3NYWTdTbndn?=
 =?gb2312?B?d2lodXlZRkNVaXd0MG1ldVgvUDFjQ3NCZ291aGtuRTVjMXdUUThyOE05K1A0?=
 =?gb2312?B?R2NNVEU0NjRkeVFxdmszcFo5R1QxdHVjWVJqUXdWbUZ1SXhMSHhSQWFGQXJv?=
 =?gb2312?B?VUh6bVpHbU44RmYzYmdoMHl6UlRPVzN2b0FzUGUyYnJET2NTT0dPaWQwMUh3?=
 =?gb2312?B?Q0VCNGhPellsTWpTZkNTWFU3aFUxMzJlN1R5NXVuck4vL0pkT2ZNQ0RDZFVO?=
 =?gb2312?B?aWFobmV3NVZTQjVTK0wvQ2VFME9yMDBTS09CY2tuK0RyWGtmUTFPTWtSMnRq?=
 =?gb2312?Q?pCo8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6531.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eae4370-b7e7-494c-2f83-08dc5ea9be66
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:43:51.6014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKrSoxBEuPmA1cveO49iYWB7uLVkXILhglGrtDj1kK4iTHR7VNzbW6d9C25Guwnr7QzrDwnsPZw3lrnKgnANXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7088
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.140700-8.000000
X-TMASE-MatchedRID: Pcf9tAO75fA5n7de8a8qbsqXjImgj58bsuIso71Vk6KwzmZL6lfcdaPF
	jJEFr+olkZ3jZ7ODxXyIoJQ67PqSrsVFjkZTkchyNtDyE2Cl4w1uCpSBdG4ThsK21zBg2KlfuVf
	c976pNyqJJPff8/hMR6wwiqhirI4lmhHQww/DmPVFWEETbq5NSvwNgAzF8116xNxlEFDc5GXHtM
	BP/jXy2fh0UMxNN2q2VGMhh6J/ibp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.140700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	99A3911078EF04162BB110BE4E568FC3FAADF09149F8912B1C82B482C870F7782000:8

Qm8gWWUgKNK2sqgpIL2rs7e72NPKvP6hsFtSZXF1ZXN0XSBiYWNrcG9ydCBhIG1haW5saW5lIHBh
dGNoIHRvIExpbnV4IGtlcm5lbC01LjEwIHN0YWJsZSB0cmVlobGhow==

