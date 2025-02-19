Return-Path: <stable+bounces-118297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41485A3C379
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE0B17163D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19DA1F4189;
	Wed, 19 Feb 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="bvvl+RIx"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0BF1E885;
	Wed, 19 Feb 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978336; cv=fail; b=hse2LwVmINYZm8HwFp12gxcCqpO1pMSivbqXpKhTuq5Pmm/tQncEXM1POpJ+6kFm7uSat2ZvRcMWU84w/2rpY/T2ZN+R+y7NlCUjUwLLE43LRO/soq8hSgLwk+BTHxQkE7Kk94YZyN+n+/1pgY1Kn5DVhprlr4NyLPw8chkrbmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978336; c=relaxed/simple;
	bh=wZmUzaeZjB6gy+TqBUcAL6ciVyed7MAGaRHz1ZyEzPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CP5H2sNkbWLcq3YaC4oWlC5WAPOxjcQ+9tqvvXiOH6Vs0DdkljYlWjCveF/Z0L/kK2GmTfd+MZubMayejsdbKR1+Oht/WchYdyt2oNQA7Y1OhBWISVvwl2h3hxO4lDZ3dORj2EzrM1g4LMTUhXt+Sq4dxMzcOMieSzWPtBb8E5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=bvvl+RIx; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGbNbRGXxzIA8/PkjWclIEM2f3ceK9nlEI6XJavETMPemKlJJoHQzuxVLqGbHSgFAeVDr1IAyRInhILEMHs0bE6BJtxs7YWjBtQOzUVwdFHcf76ic8ZcnncJNJYIkN56ek/ZyRGsfLYRm+8kPiK3nD5XhKNaw1HbIjXEUnS5CGl4JiNIkxDNwjKyPJClRiWqz7Rb/Z93ektmyDXKICXAMtFt44TsmGX8w4242hGI4FEwgZUlIvZhTkcE9cFFS709swb73MQUGto2ewCDPrCt3IqOAIy6hN1e7cinhclBYPggM8MuSn5Fz2KXAoIUixSm0lWxzAECTIp0UHApVawWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZmUzaeZjB6gy+TqBUcAL6ciVyed7MAGaRHz1ZyEzPI=;
 b=fY/vee0xXa9cyqqCf3etPopeR86HmvRjZzGDkjmrdM+vsONxiwPDAASReQCoc4xdmxvUW1VSmQnQF73w8Yyg9KVdHQZ8fyPlpLgsHtKlBzsmHsCNSHzlp7LDFbKSBOcLU4kOsBS7bvCcYCzPNj5YJmymxJqzBOoTOfDapyVfWtamYCPryym1Jb5WlVmxuD8J+69AqlYWeTrutd9uyDF79HlbJosW+8cd0mWsmqelpFDnNQxj6uarhynj4NpjllJ0/S0Uc+51qa2KP9hGCVotuPeWiXlFrm2f6o6rNFqDdOAo/L11GClwsbS1egV4CEN65Miy6j+VEha5x15ADf9OTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZmUzaeZjB6gy+TqBUcAL6ciVyed7MAGaRHz1ZyEzPI=;
 b=bvvl+RIxFbQT4gjOmTRJLIj6no1ZyhOH3grWn3U1xOXx+8FmmgidpEd7EKeHXlUsU9wCrfVreImUtJXG2LIbZXDHB24LpXL44LS/p3Vlb4bbGOWtFbtRTlcsG6kg37EbjsTWsR7HTsjCMdug01n0YUOrBVDuzRJokRbV+38j9sTS55l3qEirOsIVBL0l+YHoYX77PbEVzbEkKxqyHsNUZ52l203iAlqVBbv7Pb7w5Malni0pBth5lSDnlipU8U+4d6spS4GH7F+AkPvax+BOgcCTNyHeNLQUPMTZsIcuyvmQGenekCDr6OOPofoKGlfzYVyriMy2rVuhq1QKQejgKA==
Received: from BYAPR10MB2616.namprd10.prod.outlook.com (2603:10b6:a02:af::10)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 15:18:52 +0000
Received: from BYAPR10MB2616.namprd10.prod.outlook.com
 ([fe80::263c:bb57:12dd:b77a]) by BYAPR10MB2616.namprd10.prod.outlook.com
 ([fe80::263c:bb57:12dd:b77a%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 15:18:51 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "pchelkin@ispras.ru"
	<pchelkin@ispras.ru>, "richard@nod.at" <richard@nod.at>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "yang.tao172@zte.com.cn"
	<yang.tao172@zte.com.cn>, "lu.zhongjun@zte.com.cn" <lu.zhongjun@zte.com.cn>,
	"wang.yong12@zte.com.cn" <wang.yong12@zte.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] jffs2: initialize filesystem-private inode info in
 ->alloc_inode callback
Thread-Topic: [PATCH 1/2] jffs2: initialize filesystem-private inode info in
 ->alloc_inode callback
Thread-Index: AQHbOSDW2WKmxrrjS0S2QDHBQjrZnLNPUOYA
Date: Wed, 19 Feb 2025 15:18:51 +0000
Message-ID: <ab62d0cf3782e8342b29639af420691083274228.camel@infinera.com>
References: <20241117184412.366672-1-pchelkin@ispras.ru>
	 <20241117184412.366672-2-pchelkin@ispras.ru>
In-Reply-To: <20241117184412.366672-2-pchelkin@ispras.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.55.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR10MB2616:EE_|PH0PR10MB4774:EE_
x-ms-office365-filtering-correlation-id: 076bce18-198e-4309-9ee3-08dd50f8b7a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUhYVWI2bDVVOWhTY3lqKzUrdndrRG5qUjRZUDlEUzhCM0VrRHEwL1liY284?=
 =?utf-8?B?eFQxS3ZpdXhiNnhZdU5USWhoQm0zZTl4WHI3TktFYTQydFBrZHFlODBxZlRP?=
 =?utf-8?B?dmE2OGdNTjZtc3EyL25TenR5NnhON0E1Z0ZPRGRtVjdBNkxkdnZDWXkwSHZ3?=
 =?utf-8?B?NTYxcGo3TjZuSVM0K08va25PR3VrY0haallEd0Y1aEsrSkxleTh0SVJYZUxt?=
 =?utf-8?B?WitIWmloY1g3TmZMYTRnd2tOLzJvZG9XdVBxeXY1Mk4xdjBRR1luTVBJeUN2?=
 =?utf-8?B?aGZyTEIvcGpiOW80QWx2NFhOcWUzcTIxV1FHblNPeGdOT3Z0akFvbFNoMkdv?=
 =?utf-8?B?dHE4YnNSWEQ4S1pYWDYzY1BZcDF0blhpOGJ6OHlyU1Z4ZVJlUXFaakpZQVFX?=
 =?utf-8?B?c1NKdC91Um5YbVlWVWM2Q1BiejFLYWxoaHlMTTQzNVFiQnc0bTIrZk43aHF6?=
 =?utf-8?B?MHV1WUhLUGJxejhLYnplcHk4UHo2RnZmaHZqN3hBN3IvZ1l5V05vSkxEYmxi?=
 =?utf-8?B?aFpXSEw4YUxjQUxkU0F0NG1obnBzVUFMZ05abzJFZzBPM3VTR1pEVWpsWkdm?=
 =?utf-8?B?WEh1czMrdXlwV0cyUUZXOElxRDRaNU5EZDFBVWNiZlM1d3ZYRDVIeGdyNjAv?=
 =?utf-8?B?NktUaGFrcjZoOTBKWVpYZDFKRStuRFMvRHBESm5EVlJxNkxMSHhqT0VnVHE1?=
 =?utf-8?B?Q3hyNk5zL1dKV3NacUF4d0lYb3VyL1p4c2ZHTTIraHNIenVlbjhNZStKVjZw?=
 =?utf-8?B?OGZySnhKUEJscnZhdGdRaW1JS1B3RThXRUZrRzd1WXpWYUxpUnp3dm1maC93?=
 =?utf-8?B?ZWtkSi9YeGp1V2ZDRU43WUxHUEdrbWNCdzBpNnV4RERmZzJZM2lneUsxYnp5?=
 =?utf-8?B?THE2TVBxTloyd3JSVTNpL2hpVjcxaC9VVFJCT2VXNkQ5aHlHMnFtVTIyZFJT?=
 =?utf-8?B?MndQMWZjK2ZyQkFZYmF3T21jaWc0d1U3eTBLTG9TVUNsQVBsa2dQUmFZMEsv?=
 =?utf-8?B?ZHNHUmJwakNLdXNGc0ZlMzFJK2hFR0tRTE5nVGE0QkN1ZWNxOHJCTUhUZXBj?=
 =?utf-8?B?azNDVmpFYTk2VnBIcC96OXVJRkdvdytDMW9HM2k0WVFGcnU3ZEtQVDhnYnNx?=
 =?utf-8?B?OXFpVkQ5SFNkY1dZdVFnTEdqZmNZaHJqL3dDcVg1T1FGMmduUHhaQytoWU53?=
 =?utf-8?B?T1VuWEVGZXJCSUVka1ovTGdGWkgwVjBWQ3dpdXpLem1EbG5TZGRpMjJST1Ay?=
 =?utf-8?B?QzQ4cXRUajI3VXd0QlFObUdpK0VqT0YxWm02ci90Y1dzKzhveVhLTDFEbGl4?=
 =?utf-8?B?TU01NjV0RDFCMDIvRlFTVzVQV3I1NmZhWWJ3MGlQT1kvZ2FNSWNxNGhOZGp4?=
 =?utf-8?B?Q05hMkhyOCtVUFl5cG0za2k4ZmRFcnptZktVUlhJZUE5aWp6eTRnSXNybzNQ?=
 =?utf-8?B?UWpRK0RlRENwVUNYaU9WWDB2K3lrbFh1K1RxaXNBQVNpb3J6aDIzeTVNT2Nm?=
 =?utf-8?B?Z25kNDAxMmo3WmpMc1hzeG1KSmdKMExCWnJqWW9DQndva1Mva0lsNjRKVEJk?=
 =?utf-8?B?S2k2cndqNVc5SlFRWmg1VGhYUnhERkNWTGhUMmNiekJrMnFOK3J6ZTYwWk1k?=
 =?utf-8?B?czJsdGd4alYwRFE5TEV0c1JGMThzbUFXTzNiSXplbzM2S1JkM3ZyQ0d1MDdt?=
 =?utf-8?B?M08yZjA3SlplUU9sZXlFcEU3eXNVaXRaNkliLzc3UUZPUSt1bjlGTE8wY3lk?=
 =?utf-8?B?UUVRSFFId0dTcDU0RE9qVUFRUXAvV25pUEhyMlloczU2VERlZ0tmZ1BHUDdU?=
 =?utf-8?B?TUN3UWw1blp2b3NRSnlEcTQrT2ZZcnpKSC9kZXVBUmNrU3hoNGtZTnE0VTNT?=
 =?utf-8?B?OFZNZ1dYRFd4WjBuWjhZaFYvTlA0WEFhZ3V2NVdtalQxWWtuVXRvaFdLenZM?=
 =?utf-8?Q?mPZFKfqOdJ4SWaLlBR5NP6AcxG/Ga4VR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2616.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MG05eko3bmxRc3VSYnpCaGlMQVNJQ082MFVyRjZHMmRqaS9mREVsVTIydHcy?=
 =?utf-8?B?Z0hId1k4UmlheFJNb1ZVNlV5K1NyNy85UENvWnNHTEwzVVhBL2ZyZC9VY3RS?=
 =?utf-8?B?U09kd2FhajA2SDQrUzhSY2pubHZidUxOV2diVGtaSkhxTXRyN2pjckNkMStH?=
 =?utf-8?B?L205WEdvcEJJNzRuVWVhNE9FTm1pZXM2b2dHSjZSM2xhaytTb2tSUFlRb1h4?=
 =?utf-8?B?NzhEQ1lYcGJoYVNvR21ab2FPUDJFOXBjMjRjOHdlY3RDV3BPVnZ6VkxVT2U0?=
 =?utf-8?B?eTJ3ZVlIRjNSK3ZQRVUxZFN3QStCNDc5dnhlM1RKNGQ1Z3JsM2VXQ29jbVlw?=
 =?utf-8?B?ekNLWUVzcEg2Z29PWWcyRlAyZkowdHlsc2VqdzhaVjgwcURkM05reUhtbFRR?=
 =?utf-8?B?bDAxcmF3UzBRd09HK25XN25ITytkd01oOUhXbDNXZWR6b25LdkVsWGNpbkNZ?=
 =?utf-8?B?MjJyTWZsMURQN2NCakF1V2J3K3gwa3FRbEx2ck0xNHNsd0FHVkloRUtnMzRm?=
 =?utf-8?B?SitwNkE5YWJaS0xOOUdnN0tYTEUrUHo0UXh1c29tSFFqbHBPOGxJLzV4MHVE?=
 =?utf-8?B?LzNYSUtJT3IzcEdRQzRuRlVkeS85T0puMWZtQlZsUERpa0tPSnF5RWRrTGdp?=
 =?utf-8?B?Q2xtN2szaG1BSUpRR0RicG1sN0VaQjU0TlBiM1huT0JELzFGNHJPcC9mMTlz?=
 =?utf-8?B?VHlVY1VzQllBejZMV3RUeXhIcUxucDc5SFlmVFMxeGxVS3FTM1ErVzFTdG51?=
 =?utf-8?B?L3N6UXFndlZmMlJab3k5ZmxDa0JQTDl1T2NGWXpHSmdaVEQ4UllHeGNPdXk5?=
 =?utf-8?B?YUtyVEhYME0xZ0UwaGlPelJFUG9lWHA4ajhCbkJrTDJ3VVNDZWsrM3hIUVBJ?=
 =?utf-8?B?Q3pDR1o2Y1dvVG55TEc1c20rWGJsQWhBR2NNdFBUYnhkNmE0Zk9OTnVyOENt?=
 =?utf-8?B?b0QydCswTzNwL2xOREZ1UGlJU1hiMG8vZ3N4ZlhjSUZ5RDlOd0l5NWNlSUts?=
 =?utf-8?B?NXB1b2xxS0trdHZ3M3hObWM4bTdaUDdpZ3NVd2NPUGZWbU9nOVFiU0g5WnpL?=
 =?utf-8?B?bGxQOGNUYndESnQ4ckNBcmdnbDlHaXBnZWF5VFBNd1VPZTYwdEtFNU1aQjJn?=
 =?utf-8?B?bk1yWUd4eDltMGMzMUtlODh1ZjNjeXczUi9mZFdEQUZZUFZFcU9wOHpaVVhk?=
 =?utf-8?B?cWd2MW1hUHkvZ1RYZmJsc1FURE05eUhrYVB1UXNDazFwZDRnN0VjUW1ic3ZX?=
 =?utf-8?B?OHd4Zm4xYjdyblZJR2xmMThhZGlVUzQxOTBMRm95bmYrWE5KQlg4akRVajJZ?=
 =?utf-8?B?a0VYQW9idU5Ic2RUWHJwWnlIQUVobWRmei9FcEthRVJyRmp6MEFtR1krN1p5?=
 =?utf-8?B?ZGVVcXJ4U0xuZTZFbWdPMGZ4TDd0UXdvb0cwallGa1hGM2huNUJrWHVMUTdC?=
 =?utf-8?B?b2JjQTlFdUlKS3ppSkhwWmFjd1FpanVHSzBIMlN1dmd4Wk5UNXZ4YzdKTUVp?=
 =?utf-8?B?ZFlaVS9ycXhqd1pzUjhYMHhYREkzZHhoM0VDRDJLNVBoNmZKL1NoeDVLVjF4?=
 =?utf-8?B?L3lLOXZJVW1YU05UelBzYnVBYnRyeDE3dGlXcnhGSStnZThzbzMxT21IajZE?=
 =?utf-8?B?QzNteU5wSnFKV05ubmlhdXJIVXllQk9MYXdMNEdrM2ZQOW9OZ2liQmF6cm0y?=
 =?utf-8?B?Q0wwQmFRci81RmVkWkVHaTQ1dUtVazFkbWFUT3VTMHJrdjVVL3BuRkZmWXNK?=
 =?utf-8?B?cGZoa0tVUFJreWFVaGFNYk50ejlnZzhQVjFHM0NLT3hRU1pqNHJIbHlNRGt3?=
 =?utf-8?B?dEk2SytEVU1GR2NqeWNnaVBMT3BhYUR3OWNqRUM4Q3hFL3JzbXdaclV2dGNn?=
 =?utf-8?B?elVCMzhIYU5ERWRCMXJ6eTlEWnQzcE1PUkM1cDlrSjUxZE50Rys5cUg3eDZY?=
 =?utf-8?B?OEVRU3Jlbmozc3l4bHRORThzQjB6Vnl4ckR5M2NhY3VzMWRQQzhDRjRkNDIv?=
 =?utf-8?B?TXFYZ3l3U2FKS1hENTlFN2I0N3orWUlab09aTWZ0NS82WCtzTVFRY1VBKzRO?=
 =?utf-8?B?WmNJUmNMdUNiV01HTVpDTWZtMHJ6YThUS2U0SFRxNHV3b2wrOE1xNys4MC92?=
 =?utf-8?Q?HEy/Ll2m1Eog1vhidPxaHfvyl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7E8C0AF662AF846868EF8CB68D29564@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2616.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076bce18-198e-4309-9ee3-08dd50f8b7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 15:18:51.9048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tn4IL13OBlB8x1pswhcvKYp3dV9J7Sg1dMIUzZYCDl3He8qanE326yD19qFwKJztgz4db9idSri8qcwp29fwHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774

UGluZyBNVEQgbWFpbnRhaW5lcnM/DQoNCk9uIFN1biwgMjAyNC0xMS0xNyBhdCAyMTo0NCArMDMw
MCwgRmVkb3IgUGNoZWxraW4gd3JvdGU6DQo+IFRoZSBzeW1saW5rIGJvZHkgKC0+dGFyZ2V0KSBz
aG91bGQgYmUgZnJlZWQgYXQgdGhlIHNhbWUgdGltZSBhcyB0aGUgaW5vZGUNCj4gaXRzZWxmIHBl
ciBjb21taXQgNGZkY2ZhYjViNTUzICgiamZmczI6IGZpeCB1c2UtYWZ0ZXItZnJlZSBvbiBzeW1s
aW5rDQo+IHRyYXZlcnNhbCIpLiBJdCBpcyBhIGZpbGVzeXN0ZW0tc3BlY2lmaWMgZmllbGQgYnV0
IHRoZXJlIGV4aXN0IHNldmVyYWwNCj4gZXJyb3IgcGF0aHMgZHVyaW5nIGdlbmVyaWMgaW5vZGUg
YWxsb2NhdGlvbiB3aGVuIC0+ZnJlZV9pbm9kZSgpLCBuYW1lbHkNCj4gamZmczJfZnJlZV9pbm9k
ZSgpLCBpcyBjYWxsZWQgd2l0aCBzdGlsbCB1bmluaXRpYWxpemVkIHByaXZhdGUgaW5mby4NCj4g
DQo+IFRoZSBjYWxsdHJhY2UgbG9va3MgbGlrZToNCj4gIGFsbG9jX2lub2RlDQo+ICAgaW5vZGVf
aW5pdF9hbHdheXMgLy8gZmFpbHMNCj4gICAgaV9jYWxsYmFjaw0KPiAgICAgZnJlZV9pbm9kZQ0K
PiAgICAgamZmczJfZnJlZV9pbm9kZSAvLyB0b3VjaGVzIHVuaW5pdCAtPnRhcmdldCBmaWVsZA0K
PiANCj4gQ29tbWl0IGFmOWE4NzMwZGRiNiAoImpmZnMyOiBGaXggcG90ZW50aWFsIGlsbGVnYWwg
YWRkcmVzcyBhY2Nlc3MgaW4NCj4gamZmczJfZnJlZV9pbm9kZSIpIGFwcHJvYWNoZWQgdGhlIG9i
c2VydmVkIHByb2JsZW0gYnV0IGZpeGVkIGl0IG9ubHkNCj4gcGFydGlhbGx5LiBPdXIgbG9jYWwg
U3l6a2FsbGVyIGluc3RhbmNlIGlzIHN0aWxsIGhpdHRpbmcgdGhlc2Uga2luZHMgb2YNCj4gZmFp
bHVyZXMuDQo+IA0KPiBUaGUgdGhpbmcgaXMgdGhhdCBqZmZzMl9pX2luaXRfb25jZSgpLCB3aGVy
ZSB0aGUgaW5pdGlhbGl6YXRpb24gb2YNCj4gZi0+dGFyZ2V0IGhhcyBiZWVuIG1vdmVkLCBpcyBj
YWxsZWQgb25jZSBwZXIgc2xhYiBhbGxvY2F0aW9uIHNvIGl0IHdvbid0DQo+IGJlIGNhbGxlZCBm
b3IgdGhlIG9iamVjdCBzdHJ1Y3R1cmUgcG9zc2libHkgcmV0cmlldmVkIGxhdGVyIGZyb20gdGhl
IHNsYWINCj4gY2FjaGUgZm9yIHJldXNlLg0KPiANCj4gVGhlIHByYWN0aWNlIGZvbGxvd2VkIGJ5
IG1hbnkgb3RoZXIgZmlsZXN5c3RlbXMgaXMgdG8gaW5pdGlhbGl6ZQ0KPiBmaWxlc3lzdGVtLXBy
aXZhdGUgaW5vZGUgY29udGVudHMgaW4gdGhlIGNvcnJlc3BvbmRpbmcgLT5hbGxvY19pbm9kZSgp
DQo+IGNhbGxiYWNrcy4gVGhpcyBhbHNvIGFsbG93cyB0byBkcm9wIGluaXRpYWxpemF0aW9uIGZy
b20gamZmczJfaWdldCgpIGFuZA0KPiBqZmZzMl9uZXdfaW5vZGUoKSBhcyAtPmFsbG9jX2lub2Rl
KCkgaXMgY2FsbGVkIGluIHRob3NlIHBsYWNlcy4NCj4gDQo+IEZvdW5kIGJ5IExpbnV4IFZlcmlm
aWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU3l6a2FsbGVyLg0KPiANCj4g
Rml4ZXM6IDRmZGNmYWI1YjU1MyAoImpmZnMyOiBmaXggdXNlLWFmdGVyLWZyZWUgb24gc3ltbGlu
ayB0cmF2ZXJzYWwiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBGZWRvciBQY2hlbGtpbiA8cGNoZWxraW5AaXNwcmFzLnJ1Pg0KPiAtLS0NCj4gIGZzL2pm
ZnMyL2ZzLmMgICAgfCAyIC0tDQo+ICBmcy9qZmZzMi9zdXBlci5jIHwgMyArKy0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2ZzL2pmZnMyL2ZzLmMgYi9mcy9qZmZzMi9mcy5jDQo+IGluZGV4IGQxNzVjY2NiN2M1
NS4uODVjNGIyNzM5MThmIDEwMDY0NA0KPiAtLS0gYS9mcy9qZmZzMi9mcy5jDQo+ICsrKyBiL2Zz
L2pmZnMyL2ZzLmMNCj4gQEAgLTI3MSw3ICsyNzEsNiBAQCBzdHJ1Y3QgaW5vZGUgKmpmZnMyX2ln
ZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgbG9uZyBpbm8pDQo+ICAJZiA9IEpG
RlMyX0lOT0RFX0lORk8oaW5vZGUpOw0KPiAgCWMgPSBKRkZTMl9TQl9JTkZPKGlub2RlLT5pX3Ni
KTsNCj4gIA0KPiAtCWpmZnMyX2luaXRfaW5vZGVfaW5mbyhmKTsNCj4gIAltdXRleF9sb2NrKCZm
LT5zZW0pOw0KPiAgDQo+ICAJcmV0ID0gamZmczJfZG9fcmVhZF9pbm9kZShjLCBmLCBpbm9kZS0+
aV9pbm8sICZsYXRlc3Rfbm9kZSk7DQo+IEBAIC00MzksNyArNDM4LDYgQEAgc3RydWN0IGlub2Rl
ICpqZmZzMl9uZXdfaW5vZGUgKHN0cnVjdCBpbm9kZSAqZGlyX2ksIHVtb2RlX3QgbW9kZSwgc3Ry
dWN0IGpmZnMyX3INCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ICANCj4gIAlmID0g
SkZGUzJfSU5PREVfSU5GTyhpbm9kZSk7DQo+IC0JamZmczJfaW5pdF9pbm9kZV9pbmZvKGYpOw0K
PiAgCW11dGV4X2xvY2soJmYtPnNlbSk7DQo+ICANCj4gIAltZW1zZXQocmksIDAsIHNpemVvZigq
cmkpKTsNCj4gZGlmZiAtLWdpdCBhL2ZzL2pmZnMyL3N1cGVyLmMgYi9mcy9qZmZzMi9zdXBlci5j
DQo+IGluZGV4IDQ1NDVmODg1YzQxZS4uYjU2ZmY2MzM1N2YzIDEwMDY0NA0KPiAtLS0gYS9mcy9q
ZmZzMi9zdXBlci5jDQo+ICsrKyBiL2ZzL2pmZnMyL3N1cGVyLmMNCj4gQEAgLTQyLDYgKzQyLDgg
QEAgc3RhdGljIHN0cnVjdCBpbm9kZSAqamZmczJfYWxsb2NfaW5vZGUoc3RydWN0IHN1cGVyX2Js
b2NrICpzYikNCj4gIAlmID0gYWxsb2NfaW5vZGVfc2Ioc2IsIGpmZnMyX2lub2RlX2NhY2hlcCwg
R0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFmKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gKw0KPiArCWpm
ZnMyX2luaXRfaW5vZGVfaW5mbyhmKTsNCj4gIAlyZXR1cm4gJmYtPnZmc19pbm9kZTsNCj4gIH0N
Cj4gIA0KPiBAQCAtNTgsNyArNjAsNiBAQCBzdGF0aWMgdm9pZCBqZmZzMl9pX2luaXRfb25jZSh2
b2lkICpmb28pDQo+ICAJc3RydWN0IGpmZnMyX2lub2RlX2luZm8gKmYgPSBmb287DQo+ICANCj4g
IAltdXRleF9pbml0KCZmLT5zZW0pOw0KPiAtCWYtPnRhcmdldCA9IE5VTEw7DQo+ICAJaW5vZGVf
aW5pdF9vbmNlKCZmLT52ZnNfaW5vZGUpOw0KPiAgfQ0KPiAgDQoNCg==

