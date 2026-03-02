Return-Path: <stable+bounces-222503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5T4kH+37pGn+xgUAu9opvQ
	(envelope-from <stable+bounces-222503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 03:54:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B291D28F1
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 03:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8282300FC6C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823B25B31D;
	Mon,  2 Mar 2026 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genesyslogic.com.tw header.i=@genesyslogic.com.tw header.b="atmt4pNf"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44A1A9F90;
	Mon,  2 Mar 2026 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772420071; cv=fail; b=Y/M6pNQ01AvQ0oeTnyj4Pn+uF/fA9NhjFCGxLIcwhffhfDujSNLKYynyN+9CO7JdVQKEtJAx+qpKFXZ2lmubL83IZyVS8DpiNo0q8FoI827kjW9HMPZqhhBGzKhyawj29RqlE2Qdlz8pqCD6Vx94T9Sz+BJ1rLoPfu/J2O4JCAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772420071; c=relaxed/simple;
	bh=6ycUeMPczJfrObVenEyFCAm9v0yCsqBuPwhLpdE3E0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ck+VF8DF1iSs7bzybqGLI9wRE0U/QSEbvMptwSaIz5prCOybu0vYY1rPz5ONjfaJHjnYCNSjJv4xZB3aDlaxsrjBH1aMqw76f8g7uHr4P0LtV4d+nkK0HyD/SJVxOc0XIX7VmRDm+M+iC1Tq4o71POwD1Nw1SdfWcR7tf6UgcWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=genesyslogic.com.tw; spf=pass smtp.mailfrom=genesyslogic.com.tw; dkim=pass (2048-bit key) header.d=genesyslogic.com.tw header.i=@genesyslogic.com.tw header.b=atmt4pNf; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=genesyslogic.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genesyslogic.com.tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsL5hsXne160C9KcLG9RIsaJrJrNidSGGKZm5Wt9MH0dZyFKSY8YzlIo5zGMVFdQictN67I8rRnShDOWlBr7tEOJYC+D2npmU32VL29S591fUPy2xsY9EKMVp12pVqzgxBGw/WxeWe+HSF7dQUnta/IRrx87G1/DOwaPKObVdxRvjBHdENEsCUHkYuhc+ENZaCzLEllq+jsstSUbcFaqHlp8XFixcLZ6DQzSXnGhyGQp6HkuxISViuZlf3vcvrY+c0ZzFd49zGu4HyEqVF20+zXr/6gX4xpiP6RMIbjbqOJUjycNR/UQWoOqi9NCaPoajxtXVMtW9U6bvLiNraMJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ycUeMPczJfrObVenEyFCAm9v0yCsqBuPwhLpdE3E0M=;
 b=ygTTTP622z+9NKy80KU59zVjvGFNt9BFXzyNeJOqnzo9A8NM/Mb0R1mzNNwe8LWMJ5HL2zpuMCu9cscwoR82Xj/HmC11LK7yxjj+eWBFOzVQC8KyeRkCFSgPzqKI+i0CKvVFLN1p5HP/7prfgUl7Ou5vdC1RngDhdY/GV+DaXIehKxvWYZmiXxRzYzlXVKrv8p9FxJ/fzSHac+RDoz/V8J2JY/5znhERW1HMXKw7/9vjWdKCb0KZnIMbwriU3dnNteHPqieRnqteeuXrQPV7dGnjCK/7IUI0GdRh7E4JBI3sTjJo4cZxonvx08SPnFgG3mrjMII5A6AmyrHvLpW2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genesyslogic.com.tw; dmarc=pass action=none
 header.from=genesyslogic.com.tw; dkim=pass header.d=genesyslogic.com.tw;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genesyslogic.com.tw;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ycUeMPczJfrObVenEyFCAm9v0yCsqBuPwhLpdE3E0M=;
 b=atmt4pNf/rSeDW9fQ3R1QdIqFzz+p/yaXLDBhEFYpyyewX6ZBZJRzs4zyY24DErVo7/6KywD2P+XqdIeC4MrAXL145pgGamvgZ9WTXIzetw7FokkVw8yq7dAaGQ0QF4nK+50byyfm4ZyhiwWuU5mqKeQErRTLJMbvjMOaEa9k8lKzaXEalUCHT0yVDeOGrYFeojqu/LnGOLTIvFJ6t5BcrI2AJ9Yr5lm5o/5+3hvjBW8UHKZiu+RSob4BZ8/nQkhpIb4tTQAPDHQiZgTaizGLoa/KpYz0SUKtE9VMYv9Xy+4EkHetGb4mecrE6m8ypr3XAQXv4ewopZc/i42JOD4sA==
Received: from TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c0::6) by SEZPR01MB4552.apcprd01.prod.exchangelabs.com
 (2603:1096:101:7b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 02:54:21 +0000
Received: from TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 ([fe80::7c4:a145:8415:c272]) by TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 ([fe80::7c4:a145:8415:c272%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 02:54:21 +0000
From: =?utf-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?=
	<Ben.Chuang@genesyslogic.com.tw>
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Adrian Hunter
	<adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Thread-Topic: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Thread-Index: AQHcp79PqTiwM0fxS0ulc6tUeV09C7WWQ/2AgAEPD4CAAxoHAA==
Date: Mon, 2 Mar 2026 02:54:21 +0000
Message-ID:
 <TYZPR01MB42609CF11A0C011930B4C067D77EA@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
References: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
 <1e71a22b-48d5-4a5f-87d5-860a6cb9a04d@intel.com>
 <752b26fc-45e2-4c4b-aa9b-48a1112b837a@linux.dev>
In-Reply-To: <752b26fc-45e2-4c4b-aa9b-48a1112b837a@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genesyslogic.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4260:EE_|SEZPR01MB4552:EE_
x-ms-office365-filtering-correlation-id: 7b5962e6-2f93-4075-f83c-08de7807015f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 BqoSsimjEiPXcc/Xn5PM7iB9pYjJlZLJfKCCzEcSo9tyKedxzdubwqBGw4EhFNdokcdY0tcp8lpEBzRRym+guS7Vs3sr5VgIe9z5QpgAor5YC5TRo5bh4rj8iGs0HVLDSFs0FwfFpmwNvVx+iAQ1wG8Mi+d6omeDw2zSCilRIIo/67C5wg4L3y2VxMrRGG403UKbF5xQFYoYE6fRncnFjJw+0b6MA9oRXnmBxPCCobKZuxRpUJbbNn4jAoG62u/VcHV4Pt8igUdSQ0GUhjEBLlYBBIH6k5Yiedc40pBEQOZBqbEWoZHmTbREtx6H+e6zCLAb1UI30HDMZolnYAm3TSPrK9juizVyHXVkeNv31S2dviP0Id5fGzneAHFU9oVD4o0bm7Jg2BqvdVaQE7dFarSxcx1Gp0DcDxAbTKJFyvuoNHRNUsL5Mbut41V+WE9p445q4b2P7iPsRXJDMrdgWDtde+gPDDbgkkGmI52XhmSbvNm7MC5vN8U+8kK/NUjRCmeLWrqgeKzyxnEGSgRRmRwjc7OdPpJ7l1HhsbgbTBCohvrU2dUXCaAIdNaBO69NDGQxgLfWXjo1DcPLpHEyslY1BoMSqqraS/8RVw6+Wx8R8pNyW8KcGZv/h4QmEBuPV5N9Fr8qui5N+RhbgzV0ZOCVL3lO1nsQEHA4xNgYNYyLHLRwZX82VAVXa7cGDuhzUm3lgoMCFJaBXi4GO+Trph/sYXTeYgmk+oIO5AeJOdHPbQa8Y0Jvj5sAZ9SykNaCshza/GDupaMPD5F7Rr8SknoHymaMNg+SNUB5G0M1YoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR01MB4260.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnZ1OHMrQkVPb29hbDBOWUpQWUN6SExxY01NUWtOU2JPU3pjZzJnZ3F0eTVC?=
 =?utf-8?B?dXQ1Q3hUZ2U1czF0d2xvNlV3Nk9icHVCcmNDdWRvOTd5d0o3VSsxQ2djM2Rq?=
 =?utf-8?B?VlozWk9uVTRyT3dKb05XY1RlRzRVMVdweVVMejlqQ2lXSTFIZHU1aWI1NE01?=
 =?utf-8?B?NEtEOFlYRnJXVjFLNHlRcjROKzFTWFVSMlloMldHellDYnM3NWVWeWg5bEMv?=
 =?utf-8?B?NWpSV1lBQlVlL3ljZ0tnNGhVb05PcFBSQzc3eHpCR1RMdmR4T2t3YmJ0aktW?=
 =?utf-8?B?VWNmMFdCYWVtZE9kRkFjbDZhNTRvZHJOQld6TWhKalBzRHhvY0E0NFNPOWVH?=
 =?utf-8?B?cHFJb3IxRUNkNmpERnRlck4zZm9PRlJVNEJsU016ZEd2c3dMWGhuRzBCc2U2?=
 =?utf-8?B?OXp4UnM3dkhPYWpRdWhCV1IxTXZPK3Z3ZUNHNGlJSU01cGYxcm8xRFplczBP?=
 =?utf-8?B?MXBxcDBISFVwNXJ1S0V5N2lScithZVlZQUtJWE5GUjBZUXlKUzhYM0IzdExj?=
 =?utf-8?B?MEFVcXdrZW5MVlAxSi9ySmI1VWlNaVNSenpjbE9vaU05c3ZkQlo0aHE0ZEJK?=
 =?utf-8?B?MlBKaXN4T3I2QW5vTmdPMU5CWDBKUTRzR01NelNnQi8xRUNCeXhLVjV2UXFW?=
 =?utf-8?B?cEozbTl4Y0lYZUlSa0FqeWxDakx2OWJSVVJ2OXZJdGF4dXUyTisrb3RUbHZr?=
 =?utf-8?B?RGxrUkx3VHdVbDBQT3diV2U4S01zYVNsS01BS0UzalpkOEVDUGVzbENOTnFj?=
 =?utf-8?B?VUw1bFdBM3AwM2RnbWhUcVZuWDV6VElPTEhXbHVVYTRwR1pLNDVoSGdnYUkr?=
 =?utf-8?B?ek5kcHdERVd6dkVYOXJpQWN4QytPbDgvWnovbWxrNVdLNiswUUdkM3B5YjhF?=
 =?utf-8?B?NTV1eXBaNXU3VEpKeFdnd1pQZ3BWNnZTQkdOeUlaYVNsMXY5Ukg2WUdlaC9O?=
 =?utf-8?B?YXk0UE83YU5qWjFSSkVnbnZNNjcwVjZNQWt0b1AxcVBuSlhISWJyTE1ROE9L?=
 =?utf-8?B?ZVEvR1hIMGUrT29Ob256OHF1OUxrZVNJSGhYMmM5a0xQOFZmUDRrcHBKRlZN?=
 =?utf-8?B?TFVZcExuVGdjMjMwUVhoajJZZmIrOUtSQlRsUy93MGZXQ3BDcng5N2JNcm1Q?=
 =?utf-8?B?SSs3T3RVSk1JcXVzbFZESnpmSnlEazJ4SG9CUHZVdUdTZ3BYNTdwOE4yYnpX?=
 =?utf-8?B?UG01QVBKdC9ldmZ1cXFRbnROdGdKYVE5NTlXbzR4SkJ4REtNcExpdUlrV3FZ?=
 =?utf-8?B?OUJGbHpuLzJFTHh0YlpUbVM5aHRvSzh0VTFsOSt1b0NObE1UZk1NWXQ1SDF1?=
 =?utf-8?B?aU1yd0NUNGFLSXdqb2x6MVoveGphcVdHbDVtNWE4SGZrWGszZEY2dk5KU1Ji?=
 =?utf-8?B?SitSM1ZaeEp3Q0h2OE1nUVdjb3BESFNNdE90VmRzTWhIMzJjNTA5cjQrUjVI?=
 =?utf-8?B?TXFRSlBaN2dPTyttNVdCWkltTXg3L0pnaitkdW1PbmxuZDZxcEVrSWFXZXVF?=
 =?utf-8?B?MFFrSThwRjM4R21JemRoMHBkZDJJS0lIcFh5ZHFtSlNlRzE3VzFEMWlTRThs?=
 =?utf-8?B?ZXJ1ODZHeHRyOUZaR0hXd0RVSUFNdExsRmxkYlNsWUxOVEhJSjR4UzFGNVE1?=
 =?utf-8?B?QXRsWklpRllnSU5PWVNXZTJGNnIxKzhBY1pKNm82VGRRU1hRK3NCaE1BUTJV?=
 =?utf-8?B?bGVhWHZuOTNRUjdLbEJMVnd5d0ozeGovWG0wMDUySjNyeUxjZU5kdEVJZXJr?=
 =?utf-8?B?RlhBMXh0cDVqeHV5c0JzMTh6ZVd2WU55TmRWbm9aMDJvNHc4R2k2aXltMVIr?=
 =?utf-8?B?R2V1S01jekQ1SFM5d2J2TThWblVKM3Z2ZG1peVgxYTdGbHJTSWJZYzY0bWk5?=
 =?utf-8?B?cWlkVE00STdJREszRG12Q0grSTJ4ZExkaUxhZTZWSmxWMUVwenI4azNHdGI1?=
 =?utf-8?B?ZkNsTWh3Y3dlY3dMZDNqckRDRDJvN0prV0VxdENjenZkRnZKYkxiaTFQS3Mz?=
 =?utf-8?B?K21nb0w1eU9RdXVnUTQyb0JMaXF1TElvWmtFUHEvYVVBWU5Sb3hVbXNaS1pp?=
 =?utf-8?B?K1N0MXhzdWpZU0ovbzVuQjZLNU9RT1dKVjNqenV5dkFJL3JpRmpySHpRc2hZ?=
 =?utf-8?B?SE1NQjJLeWx3Q1ZFUWp2b24wdUpTcnZvQkY2WkVNaHRLNC8wTkJsa0NQTm40?=
 =?utf-8?B?WkVpY2UxUE44N2VoRzFqMFRSVXJZSlI4a0duTlRBdDArT2JXK1JzcWs3bUFI?=
 =?utf-8?B?eGJPNWJDaTRDS2w4Q0I3YXVMV2NwOVAzWjlSNFRGYzlmejAwQnNTZXFPSktU?=
 =?utf-8?B?OG5IcGpqVk5Gc0tYYjBKcHRnbkJ4elpmYTJxTlVBN0pOa1o3QXVmbDJ1b1VL?=
 =?utf-8?Q?P8KBv8/GMGxoQurs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: genesyslogic.com.tw
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4260.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5962e6-2f93-4075-f83c-08de7807015f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 02:54:21.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e753840-bf6b-40a1-9645-185818deeb52
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJyQwTwgrX+CV05aRGZuKIKor3nEv/CNiLtLa6bGXYm8fqDhSqvAm05D6axDIqO7/UtBhjQh9SvH9IeUewS/RkL3eKunHLgPXeSS2ICgCkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4552
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genesyslogic.com.tw,none];
	R_DKIM_ALLOW(-0.20)[genesyslogic.com.tw:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ben.Chuang@genesyslogic.com.tw,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[genesyslogic.com.tw:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: C6B291D28F1
X-Rspamd-Action: no action

SGkgTWF0dGhldywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXR0
aGV3IFNjaHdhcnR6IDxtYXR0aGV3LnNjaHdhcnR6QGxpbnV4LmRldj4NCj4gU2VudDogU2F0dXJk
YXksIEZlYnJ1YXJ5IDI4LCAyMDI2IDk6MjcgQU0NCj4gVG86IEFkcmlhbiBIdW50ZXIgPGFkcmlh
bi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+
OyBCZW5DaHVhbmdb6I6K5pm66YePXQ0KPiA8QmVuLkNodWFuZ0BnZW5lc3lzbG9naWMuY29tLnR3
Pg0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBt
bWM6IHNkaGNpLXBjaS1nbGk6IGZpeCBHTDk3NTAgRE1BIHdyaXRlIGNvcnJ1cHRpb24NCj4NCj4g
T24gMi8yNy8yNiAxOjE2IEFNLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+IE9uIDI3LzAyLzIw
MjYgMDk6NTksIE1hdHRoZXcgU2Nod2FydHogd3JvdGU6DQo+ID4+IFRoZSBHTDk3NTAgU0QgaG9z
dCBjb250cm9sbGVyIGhhcyBpbnRlcm1pdHRlbnQgZGF0YSBjb3JydXB0aW9uIGR1cmluZw0KPiA+
PiBETUEgd3JpdGUgb3BlcmF0aW9ucy4gVGhlIEdNX0JVUlNUIHJlZ2lzdGVyJ3MgUl9PU1JDX0xt
dCBmaWVsZA0KPiA+PiAoYml0cyAxNzoxNiksIHdoaWNoIGxpbWl0cyBvdXRzdGFuZGluZyBETUEg
cmVhZCByZXF1ZXN0cyBmcm9tIHN5c3RlbQ0KPiA+PiBtZW1vcnksIGlzIG5vdCBiZWluZyBjbGVh
cmVkIGR1cmluZyBpbml0aWFsaXphdGlvbi4gVGhlIFdpbmRvd3MgZHJpdmVyDQo+ID4+IHNldHMg
Ul9PU1JDX0xtdCB0byB6ZXJvLCBsaW1pdGluZyByZXF1ZXN0cyB0byB0aGUgc21hbGxlc3QgdW5p
dC4NCj4gPj4NCj4gPj4gQ2xlYXIgUl9PU1JDX0xtdCB0byBtYXRjaCB0aGUgV2luZG93cyBkcml2
ZXIgYmVoYXZpb3IuIFRoaXMgZWxpbWluYXRlcw0KPiA+PiB3cml0ZSBjb3JydXB0aW9uIHZlcmlm
aWVkIHdpdGggZjN3cml0ZS9mM3JlYWQgdGVzdHMgd2hpbGUgbWFpbnRhaW5pbmcNCj4gPj4gRE1B
IHBlcmZvcm1hbmNlLg0KPiA+Pg0KPiA+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+
PiBGaXhlczogZTUxZGY2Y2U2NjhhICgibW1jOiBob3N0OiBzZGhjaS1wY2k6IEFkZCBHZW5lc3lz
IExvZ2ljIEdMOTc1eCBzdXBwb3J0IikNCj4gPj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tbWMvMzNkMTI4MDctNWM3Mi00MWMNCj4gZS04Njc5LTU3YWExMTgzMWZh
ZCU0MGxpbnV4LmRldiUyRiZkYXRhPTA1JTdDMDIlN0NiZW4uY2h1YW5nJTQwZ2VuZXN5c2xvZ2lj
LmNvbS50dyU3Q2Y3ZDg5Y2QzYjllZjRlZThmNTgNCj4gMjA4ZGU3NjY4NzQ5NyU3QzRlNzUzODQw
YmY2YjQwYTE5NjQ1MTg1ODE4ZGVlYjUyJTdDMCU3QzAlN0M2MzkwNzgzODgxOTc2OTgwMjglN0NV
bmtub3duJTdDVFdGcGINCj4gR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3
TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNE
JTNEJTdDMCUNCj4gN0MlN0MlN0Mmc2RhdGE9eGRuSklCNzRYWjRMUVlCZ0hzZU1aV3ZEU3dPMW1n
NHgwakNOeHFNTW9jbyUzRCZyZXNlcnZlZD0wDQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcg
U2Nod2FydHogPG1hdHRoZXcuc2Nod2FydHpAbGludXguZGV2Pg0KPiA+DQo+ID4gQmVuIHdyb3Rl
ICJTbyBJIHRoaW5rIHlvdXIgcGF0Y2ggc2V0dGluZyBSX09TUkNfTG10IHRvIHplcm8gaXMgcmVh
c29uYWJsZS4iDQo+ID4gQ2FuIGJlIGhhdmUgYSBSZXZpZXdlZC1ieSB0YWcgYWxzbz8NCj4NCj4g
V2Fzbid0IHN1cmUgYWJvdXQgdGhlIGV0aXF1ZXR0ZSBvZiBhZGRpbmcgYSBSZXZpZXdlZC1ieSB3
aXRob3V0IGFuIGV4cGxpY2l0IHRhZyBpbiBhbiBlbWFpbCwNCj4gYnV0IGhhcHB5IHRvIHJlLXNw
aW4gYSB2MiBhbmQgYWRkIHRoYXQgaWYgaXQncyB3YW50ZWQuDQo+DQo+ID4NCj4gPiBOZXZlcnRo
ZWxlc3M6DQo+ID4NCj4gPiBBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+DQo+ID4NCj4gPj4gLS0tDQo+ID4+IExpbmsgdG8gUkZDOg0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNjAxMTcyMzQ4MDAuOTMxNjY0LTENCj4gLW1hdHRoZXcuc2No
d2FydHolNDBsaW51eC5kZXYlMkYmZGF0YT0wNSU3QzAyJTdDYmVuLmNodWFuZyU0MGdlbmVzeXNs
b2dpYy5jb20udHclN0NmN2Q4OWNkM2I5ZWY0ZWU4ZjU4MjA4DQo+IGRlNzY2ODc0OTclN0M0ZTc1
Mzg0MGJmNmI0MGExOTY0NTE4NTgxOGRlZWI1MiU3QzAlN0MwJTdDNjM5MDc4Mzg4MTk3NzU3Njkz
JTdDVW5rbm93biU3Q1RXRnBiR1pzYg0KPiAzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlp
T2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lm
USUzRCUzRCU3QzAlN0MlDQo+IDdDJTdDJnNkYXRhPWhHJTJGc3ZKYTlmRWZFUFhJY0I4MSUyRkcz
M3BieGc1NFN4QzJTWDVXdUt4Q1p3JTNEJnJlc2VydmVkPTANCj4gPj4gQ2hhbmdlcyBmcm9tIFJG
QyAtPiB2MTogdXNlIHRoZSBwcm9wZXIgbmFtZSBmb3IgdGhlIHJlZ2lzdGVyIGZpZWxkDQo+ID4+
IC0tLQ0KPiA+PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktZ2xpLmMgfCA4ICsrKysrKysr
DQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1nbGkuYyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktcGNpLWdsaS5jDQo+ID4+IGluZGV4IGIwZjkxY2M5ZTQwZTQuLjdhN2JlM2Y3YmVl
NmIgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLWdsaS5jDQo+
ID4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLWdsaS5jDQo+ID4+IEBAIC0yNiw2
ICsyNiw5IEBADQo+ID4+ICAjZGVmaW5lICAgR0xJXzk3NTBfV1RfRU5fT04gICAgICAgICAgIDB4
MQ0KPiA+PiAgI2RlZmluZSAgIEdMSV85NzUwX1dUX0VOX09GRiAgICAgICAgICAweDANCj4gPj4N
Cj4gPj4gKyNkZWZpbmUgU0RIQ0lfR0xJXzk3NTBfR01fQlVSU1RfU0laRSAgICAgICAgICAgICAg
ICAweDUxMA0KPiA+PiArI2RlZmluZSAgIFNESENJX0dMSV85NzUwX0dNX0JVUlNUX1NJWkVfUl9P
U1JDX0xNVCAgICAgR0VOTUFTSygxNywgMTYpDQo+ID4+ICsNCg0KUGxlYXNlIG1vdmUgdGhlIGRl
ZmluaXRpb24gb2YgMHg1MTAgcmVnaXN0ZXIgYmVmb3JlIHRoZSBkZWZpbml0aW9uIG9mIDB4NTQw
IHJlZ2lzdGVyLg0KaS5lLg0KDQogI2RlZmluZSAgIEdMSV85NzUwX01JU0NfVFgxX0RMWV9WQUxV
RSAgICAweDUNCiAjZGVmaW5lICAgU0RIQ0lfR0xJXzk3NTBfTUlTQ19TU0NfT0ZGICAgIEJJVCgy
NikNCg0KKyNkZWZpbmUgICAgICAgIFNESENJX0dMSV85NzUwX0dNX0JVUlNUX1NJWkUgICAgICAg
ICAgICAgIDB4NTEwDQorI2RlZmluZSAgICAgICAgICBTREhDSV9HTElfOTc1MF9HTV9CVVJTVF9T
SVpFX1JfT1NSQ19MTVQgICBHRU5NQVNLKDE3LCAxNikNCisNCiAjZGVmaW5lIFNESENJX0dMSV85
NzUwX1RVTklOR19DT05UUk9MICAgICAgICAgICAgMHg1NDANCiAjZGVmaW5lICAgU0RIQ0lfR0xJ
Xzk3NTBfVFVOSU5HX0NPTlRST0xfRU4gICAgICAgICAgQklUKDQpDQogI2RlZmluZSAgIEdMSV85
NzUwX1RVTklOR19DT05UUk9MX0VOX09OICAgICAgICAgICAgIDB4MQ0KDQo+ID4+ICAjZGVmaW5l
IFNESENJX0dMSV85NzUwX0NGRzIgICAgICAgICAgMHg4NDgNCj4gPj4gICNkZWZpbmUgICBTREhD
SV9HTElfOTc1MF9DRkcyX0wxRExZICAgIEdFTk1BU0soMjgsIDI0KQ0KPiA+PiAgI2RlZmluZSAg
IEdMSV85NzUwX0NGRzJfTDFETFlfVkFMVUUgICAgMHgxRg0KPiA+PiBAQCAtNjI5LDYgKzYzMiwx
MSBAQCBzdGF0aWMgdm9pZCBnbDk3NTBfaHdfc2V0dGluZyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9z
dCkNCj4gPj4NCj4gPj4gICAgZ2w5NzUwX3d0X29uKGhvc3QpOw0KPiA+Pg0KPiA+PiArICAvKiBj
bGVhciBSX09TUkNfTG10IHRvIGF2b2lkIERNQSB3cml0ZSBjb3JydXB0aW9uICovDQo+ID4+ICsg
IHZhbHVlID0gc2RoY2lfcmVhZGwoaG9zdCwgU0RIQ0lfR0xJXzk3NTBfR01fQlVSU1RfU0laRSk7
DQo+ID4+ICsgIHZhbHVlICY9IH5TREhDSV9HTElfOTc1MF9HTV9CVVJTVF9TSVpFX1JfT1NSQ19M
TVQ7DQo+ID4+ICsgIHNkaGNpX3dyaXRlbChob3N0LCB2YWx1ZSwgU0RIQ0lfR0xJXzk3NTBfR01f
QlVSU1RfU0laRSk7DQo+ID4+ICsNCg0KSSByZWNhbGwgdGhhdCBzZGhjaV9yZXNldCgpIHJlc2V0
cyB0aGUgMHg1MTAgcmVnaXN0ZXIgdG8gaXRzIGRlZmF1bHQgdmFsdWUuDQpTbyBwbGVhc2UgdGVz
dCB0aGlzIGJ5IHJlbW92aW5nIHRoZSBjYXJkIGFuZCByZWluc2VydGluZyB0aGUgY2FyZCBhZ2Fp
biwgYW5kDQpzZWUgaWYgdGhlIHZhbHVlIHN0aWxsIG1hdGNoZXMgZXhwZWN0YXRpb25zLiBJZiBu
b3QsIHBlcmhhcHMgdGhlIGFib3ZlIGNvZGUNCmNhbiBiZSBhZGRlZCB0byBnbGlfc2V0Xzk3NTAo
KS4NCg0KQmVzdCByZWdhcmRzLA0KQmVuIENodWFuZw0KDQo+ID4+ICAgIHZhbHVlID0gc2RoY2lf
cmVhZGwoaG9zdCwgU0RIQ0lfR0xJXzk3NTBfQ0ZHMik7DQo+ID4+ICAgIHZhbHVlICY9IH5TREhD
SV9HTElfOTc1MF9DRkcyX0wxRExZOw0KPiA+PiAgICAvKiBzZXQgQVNQTSBMMSBlbnRyeSBkZWxh
eSB0byA3Ljl1cyAqLw0KPiA+DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoN
CkdlbmVzeXMgTG9naWMgRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZToNClRoaXMgbWFpbCBh
bmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgY29uZmlk
ZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCBvciBvdGhlcndpc2UgcHJvdGVjdGVkIGJ5
IGxhdy4gVGhlIG1haWwgaXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgbmFtZWQgYWRkcmVzc2Vl
IChvciBhIHBlcnNvbiByZXNwb25zaWJsZSBmb3IgZGVsaXZlcmluZyBpdCB0byB0aGUgYWRkcmVz
c2VlKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIG1haWws
IHlvdSBhcmUgbm90IGF1dGhvcml6ZWQgdG8gcmVhZCwgcHJpbnQsIGNvcHkgb3IgZGlzc2VtaW5h
dGUgdGhpcyBtYWlsLg0KDQpJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9y
LCBwbGVhc2Ugbm90aWZ5IHVzIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGVtYWlsIGFuZCBpbW1lZGlh
dGVseSBkZWxldGUgdGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgZnJvbSB5b3VyIHN5
c3RlbS4gUGxlYXNlIGJlIG5vdGVkIHRoYXQgYW55IHVuYXV0aG9yaXplZCB1c2UsIGRpc3NlbWlu
YXRpb24sIGRpc3RyaWJ1dGlvbiBvciBjb3B5aW5nIG9mIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkg
cHJvaGliaXRlZC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo=

