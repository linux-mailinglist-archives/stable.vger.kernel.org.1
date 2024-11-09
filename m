Return-Path: <stable+bounces-91977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B769C2940
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83D21C211C8
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A31C6B8;
	Sat,  9 Nov 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="G5RDKvfZ"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023110.outbound.protection.outlook.com [40.107.44.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EA2BB09;
	Sat,  9 Nov 2024 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115975; cv=fail; b=J0PICC8RXWiKSP+yXh21WqKxfB38j7ne+RahDPQgGMSqJ3+WxZ+ZTUNHyWzE5qHbqSKHzW5/WE1NS+UULpG2pmiUsiCyJz73uD+b9xM8UWLbqYQyMIvSDyWBOVsDBfU4h3ABEQeT/I8MYXX27tbnBnzdo6dUNn1On/G7Q8vDa6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115975; c=relaxed/simple;
	bh=bclkpdtxxBliChApMV/CbQvd1WD37Q94TToKsYKGdmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fq95rOZzCxVjSNvJt4C8eQwTu9yQkksEuNiYEgMQE/L9R6neziMJ0R1Ssf/OXnndX74caTjB4CxolyEPNW92/QGFmgdBfAPnQE3LPiX+3CTQgNm6ep+VRstoolXenq1YDGb1uiBRn9/MA75nX8UMi53Z2QUTezWkI9N2nfhgdrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=G5RDKvfZ; arc=fail smtp.client-ip=40.107.44.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4X1Gd7y0BEvB/L8zVdQ9Dete964bSYa74SydoTne7LcUH4QciX6bSuUCR4ER51J7fvPeg7lqSU4Eq1YduRKQW+Mxa9UP3xbjWv3xKteHEd+0UeLhXHl6kQnTHT+YS8nhUvAeZqnowcW5x+JCeKG4sQBPz8jEuNAK5Ej4H1Ue7fPEGGLXZ/BAVD0ns7ARwVChQzJOhdlBBTUSM58Yvs4O4edZk2Q/UK9mxvldoKg6TYldp+nXhoDZRJT2RqBc7AFlZK2+KmQviXDdvIeM55M99LpD5SQ/sSAOwlqnuJRldtbH3ARLTL97sIuMFpiE/61uyvpgkr/FrERp97kDAIezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bclkpdtxxBliChApMV/CbQvd1WD37Q94TToKsYKGdmg=;
 b=Di1pmA5gKZhwm+Sa5hotU4LCr98X3Jos77LcTHHfDZl/nEehZVjKCRmjkBClPPu82UMgOcb4ksMssZFISO1F+1ZHw8mJ7stsyB+8cWM8HosmomaKsLttgLd84CNRE51nUxqk1U08HrsAZuvqhfxuaayoSpWXWSIOygXIAIO4SgTeUHTUIA6oQFCOSyju5KWKcyOHE+ii6SShuVKOLfw2KHkrNtOGHFf3oPyV4ljRUA+KANwqVSSdEodC0vcziISWHvPPhaUJyAmLGWXSkDtmUAB9fQAggMLlO+rh66rvbpL6D44U829ucgh5B/VvMwkbEjKOh7kW6aEn9obvM+cHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bclkpdtxxBliChApMV/CbQvd1WD37Q94TToKsYKGdmg=;
 b=G5RDKvfZroPZ2sCpmcrvO76iBIShQvWZqu0eU0H5Uf0WOMbdQpS6c9BkQIa/NYx2R6LbujyYVYItG+nfuqu8ld4+xu4JxxXQttq1nS0BnRBVp4OYhplso/fjHnqcUHuJt6BoFqhQIlQW3S+UkTaiXTQjf1azgLPI1pgmJdtv6AhSmypeYtX8YXhoxRQ4tfqu5cC1P2IiqVAHR9cCqFSv5IHhSEIRxxrbDFjLtVlNPyz7Ua8OMlycP9DerCDIfOCP5W8chRWR4MLZzKNOEgxDCTkbSwl5jH99eGRLxwNtijx4r2Lzl7JZIlI/p8HP+RzCVpwIKWoMHZ6523qdkQCFjA==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SI2PR06MB5242.apcprd06.prod.outlook.com
 (2603:1096:4:1e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Sat, 9 Nov
 2024 01:32:44 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Sat, 9 Nov 2024
 01:32:43 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Angus Chen
	<angus.chen@jaguarmicro.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIXSBVU0I6IGNvcmU6IHJlbW92ZSBkZWFkIGNvZGUgaW4g?=
 =?gb2312?B?ZG9fcHJvY19idWxrKCk=?=
Thread-Topic: [PATCH] USB: core: remove dead code in do_proc_bulk()
Thread-Index: AQHbMcKnsvbN/5y29EeFRefkMZ0wv7Kta/SAgAC+IuA=
Date: Sat, 9 Nov 2024 01:32:43 +0000
Message-ID:
 <KL1PR0601MB5773E73C0161E6222E55E1D8E65E2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20241108094255.2133-1-rex.nie@jaguarmicro.com>
 <160ed4e4-0b8b-4424-9b3c-7aa159b8c735@rowland.harvard.edu>
In-Reply-To: <160ed4e4-0b8b-4424-9b3c-7aa159b8c735@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|SI2PR06MB5242:EE_
x-ms-office365-filtering-correlation-id: 0233694a-f53c-4273-3b1f-08dd005e686d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?WkxQUExiNGNhdDBCNXRGV3VVSVFHTnZjcE1pWFQ0U3p5NUpKejdTOVVmRkhT?=
 =?gb2312?B?KzU1aWdVZW1TY0I5OTVZWDZlOTdQdVFMaG90M1Z6VUpFbzhFeVd0N3VsSHV3?=
 =?gb2312?B?TEs1QWUwcG10M2xXYktuOG9rSUFUYXJ1cW1mY1I2NnkveVhtQ0dCYnNURFN5?=
 =?gb2312?B?VFZMNDZQSkFiQU5kQ0NsaWZ6U0JQdmluSXdiTExJQkxZTGI2a0xWN0psTjZK?=
 =?gb2312?B?VVU4amN2UEMzc0tNU0VKcUNZbnFtNVdKUUhWaVQ5UVpOK01ZK3MzbGJ0cHQw?=
 =?gb2312?B?WE5NZmhGZkVrMTVkSXMwbmpYN0w5azFRbHNXcXZIUVg4ZXdlU3MrT2wrcm1u?=
 =?gb2312?B?enlRQUt1UVNlWkNIYkVZN24zeTduWmdMWHpkbFlhK1FuVnBxdk1ZeDBlaUhv?=
 =?gb2312?B?Y0FLOGkxTGRSZkJiZjhtSU1nNE5Venc0VllmVndSR0lQV3lLSHdKZHhIZzY2?=
 =?gb2312?B?SXFzL3NNbE04ditGWUxTQWhLV2UwOTkwQWRLam9lZFFJWTM3d3VCM2UwTG1U?=
 =?gb2312?B?dGlpeDlKUDZNQ2FneXlzSVU4SjBwSTVGNHFTemh3WFB1VU5uQzRiWmdkL1pR?=
 =?gb2312?B?d2QxbE96eGZlY2Rsc1h1SnFhUnpkcUZDTUFjRnBZTzVlcjFZZlFDUSsyRUdQ?=
 =?gb2312?B?bnhVSU9UUWRwR2JGWDArWHp2VUs5K0c3Y3JoOXAyd0RMZWMxRkp5N3ZuN29y?=
 =?gb2312?B?TUdQb1oyVGV0RmcrVlNTVjVuVWxxR1ppSUdLZFRvQkpwcVRmM0cyM0w1U0xs?=
 =?gb2312?B?YnNPZFRPKzZBQURqK0dRb01CWmhEWCtveHE4RFgrZEs0Y2M5UHNySFRLT1I4?=
 =?gb2312?B?ZFhSR2xEeEJNNkFpcEl2ZDFQZzg4bkJGNFZXeVJHbmJobkd4RFR5djVQMHU4?=
 =?gb2312?B?SDhmNGhyc1RWUU0zTFhJMnRRT29PRmRodjFLbW83WmdQNndmU3dnVEZpVU9q?=
 =?gb2312?B?WHRSTG84ZUhUYmYycDF5MlFIZVQ5YzU1dHJ0UVdMYktlTk0yNGt3UGUzV3dM?=
 =?gb2312?B?WWdLMkt1ZmV5aHNIOWt4Mytidnp1MWRyZ2N1S3J5eXE2Y1gwaitMczluV1Bu?=
 =?gb2312?B?aTczU3V2cWVpMXdwTzZpSlc2K2dBOVNtOWlQUjI1Tm1OOHJ3aWZrcWpVSG5u?=
 =?gb2312?B?NmJDRVQvTTQwVzluVGFON3ZQc1A4akxaYkpTTHdMbUNnK2pzYjVYUVd0TlR5?=
 =?gb2312?B?a0VOdHJUUHBaOW9lNkI4Qnp4V3p3d2N5c1cvRGs4NFk5d0JYN1p4UWpHUlg0?=
 =?gb2312?B?UlhBNkdvUHAyUEtWYVplSVlDQzJWWVhDL05Xd1N6LzRrNzhrQmxTUGV0bHJu?=
 =?gb2312?B?bkc4c0I2K0JtdmtEWmwzb3JPRzlHRG5ZUVBSQlZnWWJtRFZ0bHo1R1Bad21Z?=
 =?gb2312?B?dTBDT3FrQ0Y3enZSaHd4NXlJc0FWYzN6N3R6RUVGY2NLZjVtNlUrSUowRE5J?=
 =?gb2312?B?TkkvbHdPY2lZNFY3bHh2ckk0RkhHMTBtVE1ub3NmcmlQMlNZVCtRQkMreXMy?=
 =?gb2312?B?VjZKQW5Jb3BYQ21abnk4MC80Q001Y080ZDA1cUhxcUlySDBHN0VCSmNSQ0lp?=
 =?gb2312?B?MlA2aTBDdm00NDgyaWRhSnBoVFFWaWN4SUFlU2g0djFuK3pTTkZwc3p5MFFq?=
 =?gb2312?B?TDJNNitoVUJTUVJjSm51dXpvUXgvdTEwSGNsMnRZYU5MQ2ZVTmNWaVFVeVBh?=
 =?gb2312?B?Q1FZajRGaXpUaVZlMGVKMmk2d2JSTzZQQWRqaFFDQ0pKeXFXdW1odGlzcUZI?=
 =?gb2312?B?VUVzRnFOQ0RCdEcwODBjRGRhL2RlSUJHekN3SjVUTTh3Zk1DbVRjL0pqcEVt?=
 =?gb2312?Q?jkG09uy6spgOUSSwhH0BQn6wkhgRUfYezImXU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?U3FWanZVREdIUlNjSk95cktRYnRiMXpxTjR3NnczV0hWUktIdllJZWJoUmw2?=
 =?gb2312?B?b3VnaTVDbys2a0RSUmU2VERUdGJJcnFFMWJWNjI2RFVobmpEd1RqbzJ0Z1li?=
 =?gb2312?B?QlErVHVkc1JRdm9aMFpvd2o4eFBuZ0dUUm9YYzZwZmJrYjFyZEpyNVdJRXpq?=
 =?gb2312?B?R0xTR0JFNldjSEF1c2VTUVhwdDYvWEhoaXlaQXJzWURqRW9ZMDJLV2JkblVS?=
 =?gb2312?B?MXdRbXdVT2xlbEFjS2hqRForTVJOeE9DN2lraGlTWXVEUUtaM0dtSnBoSlM2?=
 =?gb2312?B?Y1hhY29lbUkrSElnKzBwaVJIVndSUlJvZ2s2UTRvcXl1Y0xyTWJBSTd4b2VV?=
 =?gb2312?B?ZnN2ajRVaGFtV1JWUG9RMFBGc3Q1NUlqZUptK3FEUVg4V1BMenRkY1QvRENj?=
 =?gb2312?B?S2FWNjN5anZXdUZMdzVMUVUxSkdjNi9rRmtRQzUvUzZtT2ROczJSNURTNTdC?=
 =?gb2312?B?endTd3ZhenNUcURRelF3eW01RDJkc0lMSVhOYVJyckJhSzZUNG1PQ3pyT1ZS?=
 =?gb2312?B?VnNQNlVua0NiS1pCK1VGOGlKbUlBWlVydllPYTZseDFwTllpbVN5QXlrRzVZ?=
 =?gb2312?B?UXdYVFdTMzRFa29aVWpLTWRqeFdmbnBES1lVMDc1SkFUMTIxS0FaM2ZYN2hY?=
 =?gb2312?B?L0tPUVZNaEU3Y3ZYcUNXRnBCem15bDJZVlBDWUJiZWd5WGpJY1RNQlhEeDVV?=
 =?gb2312?B?aGVjTG94d2VHQmtyWklLV3hrVFhQQ09FT3Z0aTA3NGt4STRuQU14UUFEZS83?=
 =?gb2312?B?czYvOUljeWpadDl6TUxzOHUzZ1d0TENqdURCT0liNVI1ekVReW5xc3g3eUY4?=
 =?gb2312?B?WTd2anNENDlXV0Z3NThvVFd1WmJIalhsU0J1N1ZqYzFJbitENUwxcCtWSHQ3?=
 =?gb2312?B?RUlQVi9xRTg2QkhacEZ2U2pVRVgvUTFXeUFCV1RVNU5JVE05SnQzbUlONW11?=
 =?gb2312?B?RHJOOGI5Z0Y0ZmZ3bWNNNDJPcGd5N1JRUDkvdjIyUS9SZFU3cnkwcFlOdlM5?=
 =?gb2312?B?MGhuTDdaeFVuY25HbmEycE1EeSt6Y0NmWG5xdm4wV25JNXMyMmhOdHFRMUZq?=
 =?gb2312?B?R0R2YzJCM1JCdjF4ZHgrWmxGQzNOQ2paM2QrU09EZ3hyYlN1TENzNS9EY2sy?=
 =?gb2312?B?Yjg2MDNpejBIcUtBMkpPczJ4S29aSTZrUDZDemkxU3d1aGZ5Q3o5VHRJV29y?=
 =?gb2312?B?emgrNUJDR0lyRW1iOHJrU1dPTUhwYzg1REdRbU04dWMyaGZ5NUEvNTJsb1g2?=
 =?gb2312?B?SlFhWW5icmdBR3BjeG5VWENTZHAvZEp6OXljYjR1Umt1aXBwSTNZbktOaWRX?=
 =?gb2312?B?L0dDVm5DRkc1ZVlHcVFud25RNmtYSng0K21TVnlSbUFlNWliMTM3VVdIdHlx?=
 =?gb2312?B?Y05xM3ZhS2ZPdmxFZXB5eU9YWTFGQm8wcHlkL2lWYk9oN0dwZXVHV2M3emxQ?=
 =?gb2312?B?VkRYWEgrQU5VamJGazFKUFd2Q1NncTg5eVpIcHJWMGJmT3ZKd2lGc09IemhJ?=
 =?gb2312?B?bW9GclhMYUwzZzJzYmkxdFU5Q0lMbi95QTNKWWExVTYxMHdYTEtSWG5Pb25w?=
 =?gb2312?B?SVJNc0xvWXJCTm84aXJRNS9DRUJwdEJ4SEt3NHhxcnowZWhUdDU5YUJOaitP?=
 =?gb2312?B?TElGWTRkWnJjd2cyTWkrMmdDb0NrQ3J3UEg1bnlGYnAvaC9YZFhvOXRtaC9a?=
 =?gb2312?B?NjRwM0loM29kN3NqY0JucWRFNXQ2MXMwSzNKTkZkdDh2MGt5Zm5CdEk1aHVZ?=
 =?gb2312?B?ODE1emFhMXdPWmtVMFd1V2lHeXlmVVR2Q1Frck5HOHZTRCtSYVRuWmJNQVh6?=
 =?gb2312?B?MmxLVXl5eXE1c2g5ZmVzWlR1RlVvZ0pXN2draUszTU1FTkRWazRxNVlhVGQz?=
 =?gb2312?B?MXJWcHBRQUNRY3puclZoKzBpRnN4N1E4clV3UGpGTFc1OWJOb1VuYlNRK1Jn?=
 =?gb2312?B?Y0hTZTF0UUczNjR2V25sVWhKaTFyQmNsZjJmMDErYnl6UHBiZHRMbzd0RUxl?=
 =?gb2312?B?WDRVcUhFdWlDRE1YYjhFaVFTRmhPZ2hMOU5pNjJkOEFqVVFHRjZZNFkyWkhW?=
 =?gb2312?B?L3NrUnB0ME1BYzJQeWV2TGV3TmZONkRJRGhNU0wveGlZM2o5Y01PQ09yK1ZE?=
 =?gb2312?Q?HufuKv4h0uHGtspjb0B3VJXiK?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0233694a-f53c-4273-3b1f-08dd005e686d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 01:32:43.5093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzIhi24vrHafYhRZNOCiTpGtmEbiGwuLXx4O29c8XBBZmRTjuddCetBr1gjBgH93MDnvOis1lYmnuGCA7e3Q6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5242

SEkgQWxhbiwNCglUaGFua3MgZm9yIHlvdXIgY29kZSByZXZpZXcuDQpSZXgNCj4gLS0tLS3Tyrz+
1K28/i0tLS0tDQo+ILeivP7IyzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVk
dT4NCj4gt6LLzcqxvOQ6IDIwMjTE6jEx1MI4yNUgMjI6MDkNCj4gytW8/sjLOiBSZXggTmllIDxy
ZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4gs63LzTogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPjsNCj4gc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiDW98ziOiBSZTogW1BBVENIXSBVU0I6IGNvcmU6IHJlbW92ZSBk
ZWFkIGNvZGUgaW4gZG9fcHJvY19idWxrKCkNCj4gDQo+IEV4dGVybmFsIE1haWw6IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBmcm9tIE9VVFNJREUgb2YgdGhlIG9yZ2FuaXphdGlvbiENCj4gRG8gbm90
IGNsaWNrIGxpbmtzLCBvcGVuIGF0dGFjaG1lbnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9u
IHVubGVzcyB5b3UNCj4gcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBGcmksIE5vdiAwOCwgMjAyNCBhdCAwNTo0Mjo1NVBNICsw
ODAwLCBSZXggTmllIHdyb3RlOg0KPiA+IFNpbmNlIGxlbjEgaXMgdW5zaWduZWQgaW50LCBsZW4x
IDwgMCBhbHdheXMgZmFsc2UuIFJlbW92ZSBpdCBrZWVwIGNvZGUNCj4gPiBzaW1wbGUuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4g
DQo+IEFja2VkLWJ5OiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiAN
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvY29yZS9kZXZpby5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9jb3JlL2RldmlvLmMgYi9kcml2ZXJzL3VzYi9jb3JlL2Rldmlv
LmMgaW5kZXgNCj4gPiAzYmViNmE4NjJlODAuLjcxMmUyOTBiYWIwNCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3VzYi9jb3JlL2RldmlvLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9jb3JlL2Rl
dmlvLmMNCj4gPiBAQCAtMTI5NSw3ICsxMjk1LDcgQEAgc3RhdGljIGludCBkb19wcm9jX2J1bGso
c3RydWN0IHVzYl9kZXZfc3RhdGUgKnBzLA0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPg0KPiA+ICAgICAgIGxlbjEgPSBidWxrLT5sZW47DQo+ID4gLSAgICAgaWYgKGxlbjEgPCAw
IHx8IGxlbjEgPj0gKElOVF9NQVggLSBzaXplb2Yoc3RydWN0IHVyYikpKQ0KPiA+ICsgICAgIGlm
IChsZW4xID49IChJTlRfTUFYIC0gc2l6ZW9mKHN0cnVjdCB1cmIpKSkNCj4gPiAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gICAgICAgaWYgKGJ1bGstPmVwICYgVVNCX0RJ
Ul9JTikNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+ID4NCg==

