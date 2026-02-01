Return-Path: <stable+bounces-212993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HJ47OThOf2mTngIAu9opvQ
	(envelope-from <stable+bounces-212993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 13:59:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B297C5EF7
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 13:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F863011C7D
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4833CEA7;
	Sun,  1 Feb 2026 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b="LviLFJ70"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020098.outbound.protection.outlook.com [52.101.56.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E61329C49;
	Sun,  1 Feb 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769950769; cv=fail; b=ff+Os/KSBfYZZBEWYEJ70Q2DZ8pomx6EcekCV+xivS9011Rjp9qpxqJcGWO4icHKZBlwPUWeAhpRj+LxAmaN5AGRfDflH5hwDExDtGItHJB3m4URQvngu8p6GvMc0L9QQrwcWmuLvNCCsS+FkHW+S5WuiCJFq0ebaQUSl40eS7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769950769; c=relaxed/simple;
	bh=n641RqGjd2HxYe/BkklN42SzDOTopAL13M8zbm42mJ0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VT6oUsTkYgfToEkgjNdKunK6tHJNhwyhULrGNJOE9dITscKEqdbf1LD+RlIjNThN1TpCpyYUMgcGxi7yHq0jk89lyNR39CfwGZ6PC3D0XipIf/9rGcBTkBb4yEUFC1Si+43PwHFzvin5KAVK/Ucspavi8MiA4NR13UZhu37MvDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu; spf=fail smtp.mailfrom=purdue.edu; dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b=LviLFJ70; arc=fail smtp.client-ip=52.101.56.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purdue.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXXxgRwLIvZHyq+E8l/kT+Oti3de+2vMh4EUimTafV68VjlOTTeaTdW0OavaIkEYAWaTkvPViBU4pn8Pq68KtOUbO9TCnWtQeteFSOEe/g8BIIPEd04pzz5NN3SB+bwDKxutz30+sQ7CMBYBHJhTne9Lypbv9iyyMI+tjmK3xx8SPESyDVVcjnJDyM4tmL8h9LLqfNoZwKPQtOGkqlP8eODKso8kmPj98IYN4Y0WAwSpZ33k8o/oFQgxMPOWDZ4BX1RU8Di63Yuz4GjW2gv0K5oE5PuAjuSdqnBGodm1wmylTIzXkD7AuO2Blu8TMcJLOtnfX7/i12P9NHIG3SA6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n641RqGjd2HxYe/BkklN42SzDOTopAL13M8zbm42mJ0=;
 b=HHtl84XxjDBq2/HNHtb8ytAPpSQUyOVYTv4WvP7QRBRhbKzJReRInPX8yUNFCkCRl9S9zJGjTbIj7G1kPUtliKU71kjuxL/nJ+MzqAa2TOWE0J2pg1YxEoyN4aLId3sC2SqCDhFmAtQx535esLsgIX31fffIVKtn5MH0m3kmvGOAqF5U2aSzx/bx3azGExIWeiPejxSNhp/cvzGcXuUpGDekbyiotUWkdeHNZJCTlvgE3rR5UzgsN5b+ZvUdiF5ajsxjPDACpdLAsUyu8OdgBbHw5pc6YpQgOIGrZm9Y4xaeQFbS71YYPtasJ93sAQtrugV6kC9frS82ulO7BaMSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=purdue.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n641RqGjd2HxYe/BkklN42SzDOTopAL13M8zbm42mJ0=;
 b=LviLFJ70ZfiEiJivfoFlkIAERbBxrAZZOXDS2v+e48zd4QmiAmmRR0vmP54wQLCt96RPeSCjlWJVnkvftp33qpNvJeZbR87O3JnjPiYsk9E9Otud9KOa2bCQjA1SqiXxJgciPyaiieBjNhylJEHOxtdrQj7FHI0vBUnZSUYBcw4=
Received: from SJ2PR22MB4268.namprd22.prod.outlook.com (2603:10b6:a03:544::6)
 by CH3PR22MB5524.namprd22.prod.outlook.com (2603:10b6:610:1d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 12:59:24 +0000
Received: from SJ2PR22MB4268.namprd22.prod.outlook.com
 ([fe80::27f2:a46:c2b4:7fbd]) by SJ2PR22MB4268.namprd22.prod.outlook.com
 ([fe80::27f2:a46:c2b4:7fbd%6]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 12:59:24 +0000
From: Sai Ritvik Tanksalkar <stanksal@purdue.edu>
To: "kees@kernel.org" <kees@kernel.org>
CC: "tony.luck@intel.com" <tony.luck@intel.com>, "gpiccoli@igalia.com"
	<gpiccoli@igalia.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "anton.vorontsov@linaro.org"
	<anton.vorontsov@linaro.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH] pstore/ram: fix buffer overflow in persistent_ram_save_old()
Thread-Topic: [PATCH] pstore/ram: fix buffer overflow in
 persistent_ram_save_old()
Thread-Index: AQHck3p8S1APpp4Ks0+aPuSt6/COng==
Date: Sun, 1 Feb 2026 12:59:24 +0000
Message-ID:
 <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR22MB4268:EE_|CH3PR22MB5524:EE_
x-ms-office365-filtering-correlation-id: 8761a5aa-4553-46e4-e4e8-08de6191b980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|786006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2U2aS9obnpPdG41eHUxd3FON0VpU0hLYWQ5NEp3MjJaRi9DcUh5OFdZbk5Z?=
 =?utf-8?B?T3YzVXdxdlNpbUI5eWdKSzE3STBJQm9TRG9TbUJXVjNvMUxYWmZ1VlV5UHZa?=
 =?utf-8?B?cFhMeE5DT1ZxRW5acEwxTDdVM0lVZmk5R2N3TG1mZnBRY2ZkNzBtM3lwd0Nm?=
 =?utf-8?B?WWdiZURDU0taM0RHR0NJQkhabW5Fbm9kL3A3UjIxa2Q2Z3owRk9ES2ZvNXpl?=
 =?utf-8?B?RGdlTmZyZHFEWm5FUTdWZ0ZHSW5nM2daUDdnNHdLcVQveUYrZUd6UHY5TjVJ?=
 =?utf-8?B?cGNoVDFNTkNIdDNTejEyUjlUaWtiQmhCQ2g4SHhWbVYwVUs1SVppQXA1K0VK?=
 =?utf-8?B?VWNGTmFwUkQwVWhYSGNDUktrdjdwMnN4YTdDOCt1bEdlbDZZZlNKN2tPM2cw?=
 =?utf-8?B?eGI1UisrNW1KZWVNUjNjWnVWT0lmelJSZmVWdUpyMXBnbmFaZ0JHK3ZJSUZm?=
 =?utf-8?B?MFBOdVE5UUl0cDRTSHU2ZVJ0cjB6Wkc4WEZkQTJVM2c4VlkyZEVjVUV3YlJH?=
 =?utf-8?B?NUVBV0RwRTc3ZUZrRmdXSWdEUm1MQzc3a21GTWtlTndOTDZhanpDYnhJdERE?=
 =?utf-8?B?YVppU25CcVY2N0RQbWxWUk1uZVl6eHlMR0FUZi9EYU9OZjg0UnFmbUlrQlNI?=
 =?utf-8?B?NXV0dmVpV2taODZmSnRtNjIwMXdxMW82RXNkWFdVem1WbUF3Zmd6WWh3a2dU?=
 =?utf-8?B?bFhJQlpPc0JPaWIwT0ZDNjVLellJQ0ZiTWFhbGJRT0NudC9jSVBhdFFyUDhw?=
 =?utf-8?B?M01LSFdSZTBQemx0SXRvUWoyYmI5aEdrNGowZ3F3dzg5cDRZbEJCVndjK0hn?=
 =?utf-8?B?UmQ4WmRNbUo2ZDE5RDQ2bVVPd3FTMFJqZEU4RzlwY2hnRSt4NGJNVFlKZGpn?=
 =?utf-8?B?NXpOM2IvaXNsT1pKYU5SUHE1d3dKbmg3RFQwUUg2elp6UmdmZzYzL3E3MUZN?=
 =?utf-8?B?WG9oUHZsdjZXRGozUFcyMkhIOUYzUkV6TUIyVU9BQjY3T2dxWnVWNU9aWU5T?=
 =?utf-8?B?b1pBWEJ6OGtaVnhLdmRxVCtYcW9scXphNzJoSTJEVisrakRpSm93Qkx1MDFi?=
 =?utf-8?B?b283QVZVNlB5eUQreTJhRWJGeGhlZmFpVS9aWkxLRDU3UjNSSU10Z2ErWWNi?=
 =?utf-8?B?d1BNWGladUxjTTdmV1IzVGEwQyt2d0I1U3hieUtYN1NRY2tWWWN3ZmphL1Ew?=
 =?utf-8?B?ZDcySWhpRDVJcTNjdTdkTGVrU3c1MUF4cEhyYUJRWVBtRkFpaVVyQ2JlcVk0?=
 =?utf-8?B?MVBWN3hvWlRYWE1iR2lYWEhSMENjU1I0M2E3dnQ2RUlLT3FXUGtCVjJDS0xF?=
 =?utf-8?B?Q0oyeUloTUlkbmhORHQ2TmRVWGwxeDU2QjVEaEhncnV0Qlludmhla3NmNmp3?=
 =?utf-8?B?WjdiYi85bDk1TmFtVzlDQ3k1eGVQSEtwUVIzQlZIVHRZSDZFN1MvSlkzWUtw?=
 =?utf-8?B?a1BQTk10eWhqTWltaHVxaE1Cc2V1T1hSSm40OEtQL0hNUFMzNUkrMGU1NmYx?=
 =?utf-8?B?M0JRZFllWDBvNkdaT3h3emF2L0NNWFEwT2xwMCtwZTdjWUVSa0hsOWF2V1BS?=
 =?utf-8?B?UDZnMzUwS3VvUnRaV3BvRDZwZW5OL0U4c3cxMU9YYUgwazhsVm1LSEFVRkJ5?=
 =?utf-8?B?dk1ydGpWNnEzbWFySUhDY2lPdGNDVUNkaHFBbGVKdG8wYTNPbGwremNtU0Y1?=
 =?utf-8?B?OE9WamhpTytncUN0WFcvR3hzVmk2Y1BIclZ5citpU0U5U3FwYnhmRkplbzRn?=
 =?utf-8?B?ZzJzb3U4MmJXcDRhTDVuUEkxTHF1RU5jcGxXNlhSVy9lQno2SGFFTnE5b2FF?=
 =?utf-8?B?cDVGdndWNEhIS1JrV1VtZlhmNndoUlBnNmxHVTFheXdnMHdJNGZZSkVBZ3lE?=
 =?utf-8?B?dSthQ0M4WVM0SkZDY1VkOU1hVkIzZDlMdmlxZUl2TzkrS3dnSEx2L3NjV0xy?=
 =?utf-8?B?S08yODlWeDQ1Y3laUkh1bEt3eHlKS0VWNnBkV3hJTTd5VDNQZWtyd3k3aGsx?=
 =?utf-8?B?WjA0WU5vN016K0xNNXBEVlQxN3FuVjN0TVN4dUFqcGtqK0VzUHNXTWpVQ0R6?=
 =?utf-8?B?K1F5QjRzNGVxQlM3WWMvL21xMmxsUVRwVTEzb3hFbHJvWm5DaUQ1MnYydlNv?=
 =?utf-8?B?cElVam9lU1o3YkhKbkpMSkZsZUhza01GcWpxRjB2Q21hRy9OcWxyb0FpY1Zq?=
 =?utf-8?Q?sPRlnW2dL69v6uA+yQBcX2M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4268.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHJLWE82NVpMUzlPNVlsOWVDaUlHQldWNkc4aVdEVXJ5OWJva1ErNGJUMCtK?=
 =?utf-8?B?dzJnc3N6cG53cXl3MCswNldPK3hoSlN1UlNjSnFzekhEWWZTZkZGdzgrUnpC?=
 =?utf-8?B?eERXTnVkL1I1d0ROdGFVRHZsYmlFaEl1SGZmeURaL0lqTU0xTzN5SFVYRlU5?=
 =?utf-8?B?MXlDWURjbkJPYnR3TXVpbDAyRzl4TGhuSlhIbmNrNW4xZU5MdVBWdG1NTnpX?=
 =?utf-8?B?MXR2WXdjRThhd3dlM1Nzd1VsWXM3QTJGZjk0dDY1OVF6ZlFNZXhvR0hhNkoz?=
 =?utf-8?B?WWdjaWRzMC9vckVnS01qWVFzdTNWSXhLRGlOSWt0VDNyU3AwWXdsS1VNZzR4?=
 =?utf-8?B?K0U0ME1FZE84MFNxTXQ3blYyTVE1MmNCMSs1dHplUnV3UnlqQ2dYNFlGbnND?=
 =?utf-8?B?Zm5LczNXNi9VM3doSVJGSFdqZVFFQWJVWS8vL21CSCtSaDFwRTBxZ0x1R2VQ?=
 =?utf-8?B?UVBneFBsS082cmdTVlhpTFRHWDJYdGhCU2ZybGlrSzM0SmlxR094b2lFMndr?=
 =?utf-8?B?N2QyUmJVaXlOYVhBZDJmZlZVd0NmSjB3RGZPMDY3R0k1WTgvaXBnK3NPamU2?=
 =?utf-8?B?NkVqSldPVVlLTnVvT1hiLzlSQldZdTBmRk9EODJ6VDVlTnVyeHRrNlNBczAz?=
 =?utf-8?B?UEgyWUw4eG9XTFRwTGN5MnI2amw3QkZyUDlkOWZ1SVE5QjhuUll5MU1DK2xs?=
 =?utf-8?B?SXE1c3M5VWFjazFRK0NkdE05SnpkajZ0cTdENHpZSm1hUmFHbGl6QzFTL0RF?=
 =?utf-8?B?OHVkeWhiMlBsalRuS05mRWd6K3RzaDNXYU9QcFZsM3dmSmZ2RDkzK2Ewcmln?=
 =?utf-8?B?ZnAzbmhiVDR6YlVCbGs0SGF6eWZFeXBDRDhnZjgzTkp6TmtlNDRLNmszOGpN?=
 =?utf-8?B?aEVoYmEwWkhCVSswa0NLdTFCUXMvZE5vTlo0T05WZjBMMVEreUhuYWVuaFlC?=
 =?utf-8?B?ZVl0bTFadzZ0bkhjSUhVSjVNRTB0K3hDVStNSXJqTmVpQ0ZjUFN1WWh5d3Ir?=
 =?utf-8?B?eWN4enVJb0hCZWw4UFptcU9GS3pUUE8vUFdWaTVlTEZER3Fqc1FTMzFJRDNN?=
 =?utf-8?B?OU1LazFxMTNZbk9uTTluTVhBM3puTS9PWXZqbXNQWkZEZGF4Y1YrUGxENmlq?=
 =?utf-8?B?U1VGZGlhV0xZYU5NdThzZ29iWVZ4SHlmaURuN1k3c0Q4N2pSNXV5eFgxU08r?=
 =?utf-8?B?R254OWdQc251OUg5V25oUGRVek41NkVmQ1BEUzBKRXhqMmZySGhmMjFqR3Bh?=
 =?utf-8?B?enYxeDV3YWNUenBpeHdIZFMyNzRyREdkdzl2bndlZEpXTDNMMXlhWVMxQTZY?=
 =?utf-8?B?OVJtdnBNWlRGc3AzOHcyOGt0eTVkZFNqU25EbnJrSXBmTzdLL0o1WmFvNEpS?=
 =?utf-8?B?emlaenJteUg1VEtoc2dTdlcyQVZhSFpvRFIwTkFTUVVsZkZJOUdlaWo5Nnp4?=
 =?utf-8?B?NHhsREFQRjE2aEYvVlZHNkNzQlBsNXBTTkprd1lmUDY2VWsrRmlPMVdEem8x?=
 =?utf-8?B?dWJhQ1RjY3lzajk3Ukx5aGxQeTVlb2pENVd3Q095MlFENU4vRWQ3M3cxWHpI?=
 =?utf-8?B?QkFOODNMWS9WZTNzd28zdnVKLzJHbndobkVLZEZPR0p6RERNWEVMWHJqZk5z?=
 =?utf-8?B?MzhkazVsNGYzcW8zMlZCSlpRN3Yyd3ZaaXBwcVkyKzcweGhLUis0Tzgwa1pP?=
 =?utf-8?B?MGxIRzBXZlRtaXZReUM1elVhMGw1VTNZWUY3SzduNnZkKy9GYWhEN2JmK0Rt?=
 =?utf-8?B?UDg2WW1rMnpkb1h3cHVoTVA0c296d0xHM2pUNlFtNkdVbWJ2WTJOTjQ2cVR2?=
 =?utf-8?B?MjNZWklkVHVGZmhYaWpYM0oweXZRUG9MbkwrS3l0MkpXNDNYNlcvVCtlYkh6?=
 =?utf-8?B?T0cvY2p6aGRDdzJ6Y0R4NHBucXdvQXIvSEw5MVdqS1I3aVhVSmVGa2cyME1j?=
 =?utf-8?B?T0FIUFBQUURET3g5NC9zaXh5L3ZZU0lyL01maDdGZVRnYUZhYk1nWklHOXJC?=
 =?utf-8?B?VFAzUFVlcldrUU4wUjNwVG9tVjJUZE10OFR0SHFvWFVtSnB5R2hlRmdESnNk?=
 =?utf-8?B?L3JWWklSa2V2UU1sblFxOFREeWdha2J3Rk9lUkVoaG55ZE9pL0JPU3BFWkhK?=
 =?utf-8?B?a09CRG80b0ZjdU10TXBVLzlab0pjWmd3RHR5S0Vhc3UxNmN3U040am03S0Fu?=
 =?utf-8?B?THpxcGRrNExTMkY5OU00S3paaVYxd1lnSFg2bllaUk94cWd1Yks3eklMbFVy?=
 =?utf-8?B?YmloaTNHenJ1TjRVTnMzc1c3SVBsMFZzUFRSTkNPWDdybDhReTBlSzB0azVE?=
 =?utf-8?Q?5D33HZVoYBKxLnpjqq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4268.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8761a5aa-4553-46e4-e4e8-08de6191b980
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2026 12:59:24.3070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqqkNkfGBGnNzOZTD+mMOOesPxAp3luPD3u/i+HotVd3CwgZdKb+NSxvgoQd3JYdf4Kr5xeAxh92RoAzGWr2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB5524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[purdue.edu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[purdue.edu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212993-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[purdue.edu:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stanksal@purdue.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B297C5EF7
X-Rspamd-Action: no action

cGVyc2lzdGVudF9yYW1fc2F2ZV9vbGQoKSBjYW4gYmUgY2FsbGVkIG11bHRpcGxlIHRpbWVzIGZv
ciB0aGUgc2FtZQpwZXJzaXN0ZW50X3JhbV96b25lIChlLmcuLCB2aWEgcmFtb29wc19wc3RvcmVf
cmVhZCAtPiByYW1vb3BzX2dldF9uZXh0X3Byegpmb3IgUFNUT1JFX1RZUEVfRE1FU0cgcmVjb3Jk
cykuCgpDdXJyZW50bHksIHRoZSBmdW5jdGlvbiBvbmx5IGFsbG9jYXRlcyBwcnotPm9sZF9sb2cg
d2hlbiBpdCBpcyBOVUxMLApidXQgaXQgdW5jb25kaXRpb25hbGx5IHVwZGF0ZXMgcHJ6LT5vbGRf
bG9nX3NpemUgdG8gdGhlIGN1cnJlbnQgYnVmZmVyCnNpemUgYW5kIHRoZW4gcGVyZm9ybXMgbWVt
Y3B5X2Zyb21pbygpIHVzaW5nIHRoaXMgbmV3IHNpemUuIElmIHRoZQpidWZmZXIgc2l6ZSBoYXMg
Z3Jvd24gc2luY2UgdGhlIGZpcnN0IGFsbG9jYXRpb24gKHdoaWNoIGNhbiBoYXBwZW4KYWNyb3Nz
IGRpZmZlcmVudCBrZXJuZWwgYm9vdCBjeWNsZXMpLCB0aGlzIGxlYWRzIHRvOgoKMS4gQSBoZWFw
IGJ1ZmZlciBvdmVyZmxvdyAoT09CIHdyaXRlKSBpbiB0aGUgbWVtY3B5X2Zyb21pbygpIGNhbGxz
LgoyLiBBIHN1YnNlcXVlbnQgT09CIHJlYWQgd2hlbiByYW1vb3BzX3BzdG9yZV9yZWFkKCkgYWNj
ZXNzZXMgdGhlIGJ1ZmZlcgogICB1c2luZyB0aGUgaW5jb3JyZWN0IChsYXJnZXIpIG9sZF9sb2df
c2l6ZS4KClRoZSBLQVNBTiBzcGxhdCB3b3VsZCBsb29rIHNpbWlsYXIgdG86CiAgQlVHOiBLQVNB
Tjogc2xhYi1vdXQtb2YtYm91bmRzIGluIHJhbW9vcHNfcHN0b3JlX3JlYWQrMHguLi4KICBSZWFk
IG9mIHNpemUgTiBhdCBhZGRyIC4uLiBieSB0YXNrIC4uLgoKRml4IHRoaXMgYnkgZnJlZWluZyBh
bmQgcmVhbGxvY2F0aW5nIHRoZSBidWZmZXIgd2hlbiB0aGUgbmV3IHNpemUKZXhjZWVkcyB0aGUg
cHJldmlvdXNseSBhbGxvY2F0ZWQgc2l6ZS4gVGhpcyBlbnN1cmVzIG9sZF9sb2cgYWx3YXlzIGhh
cwpzdWZmaWNpZW50IHNwYWNlIGZvciB0aGUgZGF0YSBiZWluZyBjb3BpZWQuCgpGaXhlczogMjAx
ZTRhY2E1YWExICgicHN0b3JlL3JhbTogU2hvdWxkIHVwZGF0ZSBvbGQgZG1lc2cgYnVmZmVyIGJl
Zm9yZSByZWFkaW5nIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTog
UHdudmVyc2UgPHN0YW5rc2FsQHB1cmR1ZS5lZHU+Ci0tLQogZnMvcHN0b3JlL3JhbV9jb3JlLmMg
fCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZnMvcHN0b3JlL3JhbV9jb3JlLmMgYi9mcy9wc3RvcmUvcmFtX2NvcmUuYwppbmRleCBmMTg0
OGNkZDZkMzQuLjhkZjgxM2E0MmE0MSAxMDA2NDQKLS0tIGEvZnMvcHN0b3JlL3JhbV9jb3JlLmMK
KysrIGIvZnMvcHN0b3JlL3JhbV9jb3JlLmMKQEAgLTI5OCw2ICsyOTgsMTQgQEAgdm9pZCBwZXJz
aXN0ZW50X3JhbV9zYXZlX29sZChzdHJ1Y3QgcGVyc2lzdGVudF9yYW1fem9uZSAqcHJ6KQogICAg
IGlmICghc2l6ZSkKICAgICAgICAgcmV0dXJuOwogCivigILigILigILigILigIIvKgor4oCC4oCC
4oCC4oCC4oCCICogSWYgdGhlIGV4aXN0aW5nIGJ1ZmZlciBpcyB0b28gc21hbGwsIGZyZWUgaXQg
c28gYSBuZXcgb25lIGlzCivigILigILigILigILigIIgKiBhbGxvY2F0ZWQuIFRoaXMgY2FuIGhh
cHBlbiB3aGVuIHBlcnNpc3RlbnRfcmFtX3NhdmVfb2xkKCkgaXMKK+KAguKAguKAguKAguKAgiAq
IGNhbGxlZCBtdWx0aXBsZSB0aW1lcyB3aXRoIGRpZmZlcmVudCBidWZmZXIgc2l6ZXMuCivigILi
gILigILigILigIIgKi8KK+KAguKAguKAguKAguKAgmlmIChwcnotPm9sZF9sb2cgJiYgcHJ6LT5v
bGRfbG9nX3NpemUgPCBzaXplKQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcGVy
c2lzdGVudF9yYW1fZnJlZV9vbGQocHJ6KTsKKwogICAgIGlmICghcHJ6LT5vbGRfbG9nKSB7CiAg
ICAgICAgIHBlcnNpc3RlbnRfcmFtX2VjY19vbGQocHJ6KTsKICAgICAgICAgcHJ6LT5vbGRfbG9n
ID0ga3Z6YWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7Ci0tIAoyLjQzLjA=

