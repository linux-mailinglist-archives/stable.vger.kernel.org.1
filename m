Return-Path: <stable+bounces-255084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNAXNF2IGGpnkwgAu9opvQ
	(envelope-from <stable+bounces-255084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:24:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10E5F63B8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3DA83074025
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7D408026;
	Thu, 28 May 2026 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZEhEWdFr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034A407CE1;
	Thu, 28 May 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992338; cv=fail; b=Z1x4N7g5+G2i6Yi1FWj30YjFZ5dufMCpGlI/mv3vvSFEX8ecztjNZwsTFo71A7XtI7J4d8GDHokvNTyrg80LCTd8MufeAJeDQmElieyjiaZ4+PYtXJ1r4CyMnxX6fiXCmrimlUf86mxMzDYhRBdEHosX9TngqYQusRkX2Mk68rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992338; c=relaxed/simple;
	bh=lNQwlcu9mfdDx1+jCBNtADn445QuJAe9eT9m9lyTefE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=FSwOOtoebwPCqfwTm/zBTMixQM3wmPRrh+uOhp7VuWyY4+2jpHOOs47GEMJz8PeFZsj2FT43/+EXoA6v/5Y+HHq0cYcBH1znRRN7Afc9nrElvTV8fAAYXIzh4+3lLwwSNdr2+m/3mwWYRrrVttK2UTn0keSn6fsppe2gvLNErG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZEhEWdFr; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SD4k533139211;
	Thu, 28 May 2026 18:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lNQwlcu9mfdDx1+jCBNtADn445QuJAe9eT9m9lyTefE=; b=ZEhEWdFr
	QpHfBeFIWiLQYJdyeg8AZrjjHZTHPLoK1VpSLfla34met3qZybXWjMsvWGDHHglB
	Ie1ZKOzRpksR4Qe95RlhSB4GPhfk/N6b0czR9R01yPhV4O8Nyq4yh0GXdTwU1L9I
	D9agRj6FUyhL877QYHvaQAHlmTOpAuZ7dowq29f1PFNrN1nJQhZl9fq15qwRRJOL
	dc6celF+v5bJDtfzFulMRClbh8iQJZuEJVdTjaBnXd2KVZ7nZKNtdrlY0pNrc4d4
	eOTHae5BCmOZKyuYju1vuz8efRX2UjJYmvw6kEzJpl2HkdhiptrU4bJj93jjetfD
	wRV2LYRbkHU86A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887madd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 18:18:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV0Uu7Num8lylF+KGN3wwj/vYEv+rlnjyuIw+HJraNToLciLXqMMEA8M5qAIY9IYsH1Sj+R8VD/5pSu4R6YHkRJn1KhCdMRJ2ehICIaSe4JECf4ZnCrXVqa+U4MKELOhYwNEOHFcfU892CdalJo0/cxeiDG+UkFchAksMRGtons286QNc8kcN+ndChUwAHCgvwe2hiYQETibS5Ro57pd/itaxjySM2w6k8ngNyGXKp0ecCmmwGpQ8embcuV2yH2Adbr2Hy1Pi0omg0yurWt45w1Pdc4DyhyrFRXvor703vQTMyEXrYWBD4/ewd2gSwq7MAoB9S0qHAWOjtNksP3upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNQwlcu9mfdDx1+jCBNtADn445QuJAe9eT9m9lyTefE=;
 b=jNpqWGlPBVO7CYsidmoW5/ZQRDMZWhHjprtiIBDK4PXFMhHz0lYLyKEuJGoH5nWUwB+VlIy8uB7XEV36Bq73gZhrncWR1Do3BXyIwzIkjxuTTxWOsFT5Y2ZkMXrYtp8r56cRIMkxk5r0zyGJ62umebZDWn44gO2CIu+lbiN5cMq8E1O0z4SGZc0ZQGnj0o8lPntrKLVMyf7BmX8me89invEjrHc35QaDCXIZW7hBKdpddhrh2URuSrZfo4/LkpMT6AcHtjevfpTESFjMkHOFlrAcbxtCSN8j14W0ys5rMn1x3tF6Tg3NE01zodoYAdd/S1taWhfpitzf3QyxLIfyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4500.namprd15.prod.outlook.com (2603:10b6:806:19b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 18:18:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:18:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "jhapavitra98@gmail.com"
	<jhapavitra98@gmail.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] ceph: fix OOB read in
 ceph_osdc_list_watchers via uncapped outdata_len
Thread-Index: AQHc7p2q7qug9Lp7FE2ziSSI5xdQmrYjv6EA
Date: Thu, 28 May 2026 18:18:51 +0000
Message-ID: <5b7d6b21f7c34661fc9430b828b4c5a3be6446b4.camel@ibm.com>
References: <71578c12a1b9d37aa2a39c8d1415084e0dea9216.camel@ibm.com>
	 <20260528122911.813491-1-jhapavitra98@gmail.com>
In-Reply-To: <20260528122911.813491-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4500:EE_
x-ms-office365-filtering-correlation-id: 9029cb6f-32d1-4a7c-96ae-08debce591f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|22082099003|18002099003|4143699003|5023799004|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 4F0nK94vi9UDFiy3SGzAFkZR8/kMsbvy88uZlwc1B8wpZbR30gZ4j4DWRjJGaLmtsyaqLHAXprwy/N6ZAUSsjsyqJFtGwTVnp45u/qM0JGmZA8rNUlaVUgm+65QzF4uUVnZqbH+v7XorXianXL8J3BZhuw+SF/tC8VU1/5zS3KWoLD/4PUg44cLNxCdsHMhOBsY0KJVNZXJnB3mCFpG7gE2j5IDgWqT6Oj8lGtEUOSNpochRNBzaT4uQzhOqkien+O5mznOEhn9E39eXqu3xmhOqbFFLBwFa/WJEPQ/4/4iEE4csGLSN/3AT9lTOXHK9v0omzOBVxNdm8kupABZb2lv2sBiVzXtCrEa0l8kWJfPqKmR/Zk8XoUfSIZU3p4M3teH3xDI3JgodY/psj+vARAyaBWuOf+LSjCqli/u6s1bbawxEW8CGMXuLMoHFY12Ktg7plM09fxREzCKSXf6HY79F0mX9Hx4ERSwwnC+YTBRRNA2CVP3egsjww2D1njpRzF8mGdwgBkTMzvZLHc1py+BxAcfKvM7SIUNE64dRAfzF/R3kb+/JicTecSqed65ImBjw0vJMnH9Sigco/erOcRMhi8NFNcImG02eVS+6+MlEBt3op03lgvjzrlBchTdUtGJaZCpls8rzB3k4oNDF6XdOmTEKN6qv0eNAccOivxZfw+9IgzLSP6DgBFRjEtLq8v6+i27nV04JzsHMYrlV6k9pc6lz1N4DNiYrD76PKaJhvot40AuLmVdPnN4/OZjH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(5023799004)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0VTVWFidGpqNmQvYjFZOUtwdzYxVkNUZ2ZCYU52QXJYUUNncDVLUGlqakRP?=
 =?utf-8?B?TkJhNExTeExCK1B4cVVnRnBZK3U5Vzk2YmlKaGdOcUxsRHhGMUJkZWFLZktB?=
 =?utf-8?B?aUNGQXVENmpaa2NLYlBQZ1BoWUFCc0F4cXJtdlBrbFB2dzBjaTZkdllWbC9N?=
 =?utf-8?B?V2ZPOENHM05EVXROYXhFMDAwMk5OZ1BTVUtpbTVSVHFxVUFmNGhDQkEyUndR?=
 =?utf-8?B?TCtvSzlndFdRdEtNbnlhUXVtSjM2UEdMSEc1YWw4WVZOUkI4MnJ2RWFXdjBL?=
 =?utf-8?B?ZHo5QS9LTEN6R2tmazcrRUk0Z2xFeWJxcysybDV4b25HUjdCei9USUdMNWFo?=
 =?utf-8?B?ZlZPeXFtS3pBNytOUWd4L2lkUFJoN1k2MWNCNEFBT2hGc1RTR0MvVTFJa2x4?=
 =?utf-8?B?SW1ET3JCcTdyK2FIekhscXZpTEZlZVprWFA0ZXpnR1BIdFFha3N6cE5HU3Az?=
 =?utf-8?B?RVFsMkJSLy9JK09oeHpFOFRkVTlmSHFJS3NLOWEvbWlRUDFiQTNVLzBxVmdq?=
 =?utf-8?B?Z3BzdVFPNUJGZmducnpoQ1VlWDEySitBL0Z4SU5TWExkN29CWENMRWx4NVVi?=
 =?utf-8?B?Y0x1SVVkemZSVUY1eHlTWVZUdHZWQ21POWtyZnh0dGhhUDQ5NExxcldobzM2?=
 =?utf-8?B?U2VOcXRjaGtiWFRyK2xmM25INGxmeDZJRVBzdnJEQ296M05rQ2tjSkllUmZF?=
 =?utf-8?B?SnFPTUxYZ2FWbVYveU1vQnkwNlIxZE5CcnlxSlZaLzZZMWo5cWd0UGJTNGJz?=
 =?utf-8?B?aW9BTVVWTnQrUFRITVMvVU16N1p1RHFIMFZtR2hZdHFVYmIxSXR4aVRDdDk4?=
 =?utf-8?B?ZFJMN0VCOHI1QUhTc1BoY3ErMGlRcGFmZnVTVVlQM21SVXBnWFhibHJXMEFP?=
 =?utf-8?B?V0Z2bWxXM1RXcXN0SlJxdGlNcXhJNTFwN2VYNk00b1lBRm96dUkzei9LNzZx?=
 =?utf-8?B?SERqazcvdkNQQnhYS0c5ZWVOa2VEbk9yRjd2b0JObG4zeldhdk1WUmRJWXFh?=
 =?utf-8?B?d0dZczA2dHpIWWthckwvMmRIeU9TbG56Tnl2VGpOTWRlSTY3c1JtNFlJVDcr?=
 =?utf-8?B?RGw0MzlHUHZtWks0U25uN21SditIcjlIT014MFVlMXprRHNNWWJvTU1DNWM2?=
 =?utf-8?B?QUJZZkVicTlHMFlTM0lZNkp5ZlpjVU1LQ2VVa0F1TDgvZFdhMG5ZejRSUHdw?=
 =?utf-8?B?dEE1U0JaWC9lVXNLdk9EeGZoSVdnVHB4UGlVSG1Rb1Q4QVEwMjY4WVJ3bWti?=
 =?utf-8?B?L0doOW1qQmZUdWlOVlNOMkFDM0VsQS9kWHgvOTlvV3hobWdUaVhLa0lxeWdI?=
 =?utf-8?B?eTB0eW41cVBzRzNoUmlKcEIySVI2cFo4TXJpZjRKL2VmanhXS1pqdEdXbFFO?=
 =?utf-8?B?amtycEVzNndpOEEvWXp4d2NsdC95NlZUUlUvYnJkUmozc1VSYzd3d25zSkZu?=
 =?utf-8?B?eHF0RFd0MHJyRUlZMjNLdE9FcytJMDgyMmtocDlZRlR5T0EzVkJGSkFFSGhH?=
 =?utf-8?B?amNrZUJVT29EVmhRbUJOR1k2TWUyN3dkMXZVaHl3WUFUTllEQXNhUmZ5ZDB4?=
 =?utf-8?B?UC90K3hHZzFURnRPT1prMXpvVFpvTFBCM2dhN1JxMDdWRG1WWGlhV21MOHFQ?=
 =?utf-8?B?TVYyQjBYMzN2R1dQMmJPMHZ5dVVXbjZ0OFRqUjBYMlZ3VlRLYUxZYk1PSDl6?=
 =?utf-8?B?VEtwY2loYWpWSXlHZlFDejJDY0lzcWVtNXJwMHNqUTUxYlFnRCsvdzZoZ1VX?=
 =?utf-8?B?QVIzbGhneGNNc3laR1hYYlFrb2Q5eUZRL2V0Z29UTVJJNVJ1Ky9MNGg2ZDJz?=
 =?utf-8?B?aFBVQ0ZmY1hKOVVsRE0zZk1xZGJkZGNyV2FUL3BMWXJUZ3hmMDNFUmhsSEJu?=
 =?utf-8?B?QWJ4b0E1RlJrZnRvQ3hGTk85a0lPcUZvdnRUSFhycTl4Nlc3TWF0MWI4MU0y?=
 =?utf-8?B?K1ppWmxWT1NrOUFGcitoUTducjNkVDVxbnByMEFteW5MN0JwNTF3Zit6UC9u?=
 =?utf-8?B?Vi9KVWFPMFQ2UHRFa2Vlb3BreEgzLys1cnQ0SEREZ2ZSZ21qMC90cjROR2JP?=
 =?utf-8?B?RFlTZ1grUGh0M205T1ArQVRWcG1UK3AxRHNsNW1rNnVBQk9nQ0xVVmY0Mm1Q?=
 =?utf-8?B?emFyaFRxR2NhUTZwdXZoRHNMK0tJeUs4UFRXTEdVU0tnZFhEMVRwR21PVCtO?=
 =?utf-8?B?T3Z0eWdKV1hwU2pSK1FtYlpXcjFSaTJyRXNXODdLOWF0NzlTMzNIcWFWVzE1?=
 =?utf-8?B?Q3c4dDJDZ3NvUnNhOFdHZXVNT0FFVG01YVQvcEYrUlA3ZVh4TGtGSHBTaXhN?=
 =?utf-8?B?TkVzdEJLL3RoVnhXUTdDNUIxem9jbDVsWmVFVzh1aTlWKytuQUdiaGdWSk1Y?=
 =?utf-8?Q?wAR/NrOeyR49FrRauED2dqDQSp2grqUXbQdn+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D0DCD7433660B43B812D85D6CBF5D32@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JT/GCnCWxIDomK8HRZNhITxXSG0PJscIvA8TFszgYr/YY+mEou8R1BItkd4I1sL75Wz7o2eGZoLM27XPILIZbazEQwXR7nADhARCk9536Xepou2MkR2R29W6bVokc6W1mDpavsW8U5xlyPmPrRIhh4i5tkgZKpA+flGHELv+NMBhxX647aGM/d9QAPpluA7pP6U6qBBhAkuIn6OCjmWow74J6vwnhcyieZbpKfGKrnUgDPHK5iTDEzLxJlmyk9NyL7+1bvuRqYLNnmMnXWtaoChmK3KUjPwu88idzZiO62WgTYvFvUuFB6sURP3789K2bqxTQIvgnSRFaj4Fi36gQA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029cb6f-32d1-4a7c-96ae-08debce591f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 18:18:51.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMOMRJbnU3TCnX/BzB0Pm7qFoPhkjQt6shnu/MyEyNIVSeH7oxGVn6pGEcjXYLHb1RPAD15rgEv4IJwncwI2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4500
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a188710 cx=c_pps
 a=1KNXh0H2uH8UbroYoe6UKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Oda_Zuhwj9KJcjqWiIkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qoisfcMJoW72dTQZodXjwCcRnDAjQ4x-
X-Proofpoint-ORIG-GUID: gUZ7n8U2yMywaWUVDuRDBaR5aZiC_j28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4MiBTYWx0ZWRfX4ZWfHZCIsgk1
 7NolvykEwFv0o2/9ri154nNaySVRr6YQOCf1dTk0OyLbkmIHapop0GtAWb2kfQazJHHeP3mOU6R
 a0JC7g5kuBytZAOHhg6hhhWrg63uvmnagLt1LZfvbFdBE3xDa3Zg2y4wvtHQJO0Sa53XmyliMbj
 1nA6YUXtnw6503NCeqqhMz/YczLmt4mb0C0advj2G55+kolevmjsxeF/wl9PhrBxF898KWB4B+e
 MU1fezy8uiaNn0/uFSVc0E30N1J92pj4PgSPPB+aZr8icmZsI/moGPuWUtI//eDz+pRZsxlU23i
 P5YXJb7ZnjfCrs+err5FM37aG0pP6/FRSyl8kiGCZI1phGwzDZLDBABENTSrTXYzqebrCNoO2EQ
 iHlsnfIdUknEgKigUg4kA7dgPumPhOxy73PQJLV3eWK7XE7zklkhdKpzBVXzZTezXq4oKfix07H
 aaMXm5Kht5IJMn+YDdg==
Subject: Re:  [PATCH v2] ceph: fix OOB read in ceph_osdc_list_watchers via
 uncapped outdata_len
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280182
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255084-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2D10E5F63B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDA4OjI5IC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
VGhlIE9TRCByZXBseSBoZWFkZXIgZmllbGQgb3AtPnBheWxvYWRfbGVuIGlzIHdpcmUtY29udHJv
bGxlZCBhbmQgaXMNCj4gY29waWVkIGRpcmVjdGx5IGludG8gbS0+b3V0ZGF0YV9sZW5baV0gd2l0
aG91dCBhbnkgYm91bmRzIGNoZWNrOg0KPiANCj4gICBtLT5vdXRkYXRhX2xlbltpXSA9IGxlMzJf
dG9fY3B1KG9wLT5wYXlsb2FkX2xlbik7DQo+IA0KPiBUaGlzIHZhbHVlIHByb3BhZ2F0ZXMgdW5j
aGVja2VkIHRvIHJlcS0+cl9vcHNbMF0ub3V0ZGF0YV9sZW4gYW5kIGlzDQo+IHRoZW4gdXNlZCB0
byBzZXQgdGhlIGRlY29kZSBib3VuZGFyeSBpbiBjZXBoX29zZGNfbGlzdF93YXRjaGVycygpOg0K
PiANCj4gICB2b2lkICpjb25zdCBlbmQgPSBwICsgcmVxLT5yX29wc1swXS5vdXRkYXRhX2xlbjsN
Cj4gDQo+IFRoZSBhY3R1YWwgZGF0YSBhbGxvY2F0aW9uIGlzIGFsd2F5cyBleGFjdGx5IG9uZSBw
YWdlOg0KPiAgIGNlcGhfYWxsb2NfcGFnZV92ZWN0b3IoMSwgR0ZQX05PSU8pDQo+ICAgY2VwaF9v
c2RfZGF0YV9wYWdlc19pbml0KC4uLiwgUEFHRV9TSVpFLCAuLi4pDQo+IA0KPiBUaGUgbWVzc2Vu
Z2VyIGNhcHMgdGhlIGNvcHkgdG8gUEFHRV9TSVpFIGJ5dGVzLCBidXQgdGhlIGRlY29kZSB3aW5k
b3cNCj4gZW5kIGlzIHNldCBmcm9tIHRoZSB1bmNhcHBlZCB3aXJlIHZhbHVlLiBBIG1hbGljaW91
cyBPU0QgY2FuIHNlbmQNCj4gb3V0ZGF0YV9sZW49MHgxMDAwMCwgY2F1c2luZyBfc2FmZSBkZWNv
ZGVyIGJvdW5kYXJ5IGNoZWNrcyB0byBwYXNzDQo+IHdoaWxlIHRoZSBwaHlzaWNhbCByZWFkcyBj
cm9zcyB0aGUgc2xhYiBhbGxvY2F0aW9uIGJvdW5kYXJ5Lg0KPiANCj4gS0FTQU4gcmVwb3J0IChr
ZXJuZWwgNy4wLjAtcmM3LCBRRU1VL3g4Nl82NCwgS0FTTFIgZGlzYWJsZWQpOg0KPiANCj4gICA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gICBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gY2VwaF9vb2Iy
X2luaXQrMHgyM2QvMHhmZjAgW2NlcGhfb29iMl9wb2NdDQo+ICAgUmVhZCBvZiBzaXplIDQgYXQg
YWRkciBmZmZmODg4MDBhMjI5ZjllIGJ5IHRhc2sgaW5zbW9kLzU3DQo+IA0KPiAgIENQVTogMCBV
SUQ6IDAgUElEOiA1NyBDb21tOiBpbnNtb2QgVGFpbnRlZDogRyAgICAgICAgICAgTyAgICAgICAg
Ny4wLjAtcmM3LWc5YzJhYmY2OWRhODMtZGlydHkgIzE1IFBSRUVNUFQobGF6eSkNCj4gICBUYWlu
dGVkOiBbT109T09UX01PRFVMRQ0KPiAgIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMg
KGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTcuMC1kZWJpYW4tMS4xNy4wLTEgMDQvMDEv
MjAxNA0KPiAgIENhbGwgVHJhY2U6DQo+ICAgIDxUQVNLPg0KPiAgICBkdW1wX3N0YWNrX2x2bCsw
eDRkLzB4NzANCj4gICAgcHJpbnRfcmVwb3J0KzB4MTcwLzB4NGYzDQo+ICAgID8gX19wZnhfX3Jh
d19zcGluX2xvY2tfaXJxc2F2ZSsweDEwLzB4MTANCj4gICAga2FzYW5fcmVwb3J0KzB4ZGEvMHgx
MTANCj4gICAgPyBjZXBoX29vYjJfaW5pdCsweDIzZC8weGZmMCBbY2VwaF9vb2IyX3BvY10NCj4g
ICAgPyBjZXBoX29vYjJfaW5pdCsweDIzZC8weGZmMCBbY2VwaF9vb2IyX3BvY10NCj4gICAgPyBf
X3BmeF9jZXBoX29vYjJfaW5pdCsweDEwLzB4MTAgW2NlcGhfb29iMl9wb2NdDQo+ICAgIGNlcGhf
b29iMl9pbml0KzB4MjNkLzB4ZmYwIFtjZXBoX29vYjJfcG9jXQ0KPiAgICBkb19vbmVfaW5pdGNh
bGwrMHg5YS8weDNhMA0KPiAgICA/IF9fcGZ4X2RvX29uZV9pbml0Y2FsbCsweDEwLzB4MTANCj4g
ICAgPyBrYXNhbl91bnBvaXNvbisweDQ0LzB4NzANCj4gICAgZG9faW5pdF9tb2R1bGUrMHgyN2Mv
MHg3OTANCj4gICAgPyBfX3BmeF9kb19pbml0X21vZHVsZSsweDEwLzB4MTANCj4gICAgPyBfX2th
c2FuX3NsYWJfZnJlZSsweDQ3LzB4NzANCj4gICAgPyBrZnJlZSsweDE1Zi8weDNiMA0KPiAgICBs
b2FkX21vZHVsZSsweDRhOWEvMHg2MzUwDQo+ICAgID8gX19wZnhfbG9hZF9tb2R1bGUrMHgxMC8w
eDEwDQo+ICAgID8gc2VjdXJpdHlfZmlsZV9wZXJtaXNzaW9uKzB4MjQvMHg1MA0KPiAgICA/IGtl
cm5lbF9yZWFkX2ZpbGUrMHgyZWQvMHg3NzANCj4gICAgPyBpbml0X21vZHVsZV9mcm9tX2ZpbGUr
MHgxNWMvMHgxODANCj4gICAgaW5pdF9tb2R1bGVfZnJvbV9maWxlKzB4MTVjLzB4MTgwDQo+ICAg
ID8gX19wZnhfaW5pdF9tb2R1bGVfZnJvbV9maWxlKzB4MTAvMHgxMA0KPiAgICA/IHRpY2tfbm9o
el9oYW5kbGVyKzB4MmEzLzB4NjQwDQo+ICAgID8gX3Jhd19zcGluX2xvY2srMHg3ZS8weGQwDQo+
ICAgIGlkZW1wb3RlbnRfaW5pdF9tb2R1bGUrMHgyMWYvMHg3NTANCj4gICAgPyBfX3BmeF9pZGVt
cG90ZW50X2luaXRfbW9kdWxlKzB4MTAvMHgxMA0KPiAgICA/IGZkZ2V0KzB4NGUvMHg0YTANCj4g
ICAgPyBmZGdldCsweDRlLzB4NGEwDQo+ICAgIF9feDY0X3N5c19maW5pdF9tb2R1bGUrMHhiYS8w
eDEyMA0KPiAgICBkb19zeXNjYWxsXzY0KzB4ZTIvMHg1NzANCj4gICAgPyBleGNfcGFnZV9mYXVs
dCsweDY2LzB4YjANCj4gICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3
Zg0KPiANCj4gICBBbGxvY2F0ZWQgYnkgdGFzayA1NzoNCj4gICAga2FzYW5fc2F2ZV9zdGFjaysw
eDMwLzB4NTANCj4gICAga2FzYW5fc2F2ZV90cmFjaysweDE0LzB4MzANCj4gICAgX19rYXNhbl9r
bWFsbG9jKzB4N2YvMHg5MA0KPiAgICBjZXBoX29vYjJfaW5pdCsweDQ0LzB4ZmYwIFtjZXBoX29v
YjJfcG9jXQ0KPiAgICBkb19vbmVfaW5pdGNhbGwrMHg5YS8weDNhMA0KPiAgICBkb19pbml0X21v
ZHVsZSsweDI3Yy8weDc5MA0KPiAgICBsb2FkX21vZHVsZSsweDRhOWEvMHg2MzUwDQo+ICAgIGlu
aXRfbW9kdWxlX2Zyb21fZmlsZSsweDE1Yy8weDE4MA0KPiAgICBpZGVtcG90ZW50X2luaXRfbW9k
dWxlKzB4MjFmLzB4NzUwDQo+ICAgIF9feDY0X3N5c19maW5pdF9tb2R1bGUrMHhiYS8weDEyMA0K
PiAgICBkb19zeXNjYWxsXzY0KzB4ZTIvMHg1NzANCj4gICAgZW50cnlfWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHg3Ny8weDdmDQo+IA0KPiAgIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8g
dGhlIG9iamVjdCBhdCBmZmZmODg4MDBhMjI5MDAwDQo+ICAgIHdoaWNoIGJlbG9uZ3MgdG8gdGhl
IGNhY2hlIGttYWxsb2MtNGsgb2Ygc2l6ZSA0MDk2DQo+ICAgVGhlIGJ1Z2d5IGFkZHJlc3MgaXMg
bG9jYXRlZCAzOTk4IGJ5dGVzIGluc2lkZSBvZg0KPiAgICBhbGxvY2F0ZWQgNDAwMC1ieXRlIHJl
Z2lvbiBbZmZmZjg4ODAwYTIyOTAwMCwgZmZmZjg4ODAwYTIyOWZhMCkNCj4gDQo+ICAgTWVtb3J5
IHN0YXRlIGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoNCj4gICAgZmZmZjg4ODAwYTIyOWU4MDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gICAgZmZm
Zjg4ODAwYTIyOWYwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDANCj4gICA+ZmZmZjg4ODAwYTIyOWY4MDogMDAgMDAgMDAgMDAgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xg0KPiAgICBmZmZmODg4MDBhMjJhMDAwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYw0KPiAgICBmZmZmODg4MDBhMjJhMDgwOiBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0KPiAgID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiANCj4gICB2
YWw9MHhjY2NjYWFhYSAoT09CIGdhcmJhZ2UgZnJvbSBLQVNBTiByZWR6b25lKQ0KPiANCj4gRml4
IGJ5IGludHJvZHVjaW5nIGJ1Zl9sZW4gdG8gaG9sZCB0aGUgYWxsb2NhdGlvbiBzaXplLCB1c2lu
ZyBpdCBpbg0KPiBib3RoIGNlcGhfb3NkX2RhdGFfcGFnZXNfaW5pdCgpIGFuZCB0aGUgbWluX3Qo
KSBkZWNvZGUgYm91bmRhcnkgY2FwLA0KPiBzbyB0aGUgdHdvIGFyZSBndWFyYW50ZWVkIHRvIHN0
YXkgaW4gc3luYyBpZiB0aGUgYnVmZmVyIHNpemUgY2hhbmdlcy4NCj4gDQo+IEF0dGFja2VyIG1v
ZGVsOiBhIG1hbGljaW91cyBvciBjb21wcm9taXNlZCBPU0QgaW4gYSBtdWx0aS10ZW5hbnQNCj4g
Q2VwaCBkZXBsb3ltZW50IGNhbiB0cmlnZ2VyIHRoaXMgYWdhaW5zdCBhbnkgY2xpZW50IGlzc3Vp
bmcNCj4gQ0VQSF9PU0RfT1BfTElTVF9XQVRDSEVSUyB3aXRob3V0IGZ1cnRoZXIgcHJpdmlsZWdl
cyBiZXlvbmQgT1NEDQo+IHNlc3Npb24gZXN0YWJsaXNobWVudC4NCj4gDQo+IEZpeGVzOiBhNGVk
MzhkN2ExODAgKCJsaWJjZXBoOiBzdXBwb3J0IGZvciBDRVBIX09TRF9PUF9MSVNUX1dBVENIRVJT
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGF2aXRy
YSBKaGEgPGpoYXBhdml0cmE5OEBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MjogSW50cm9kdWNlIGJ1
Zl9sZW4gdmFyaWFibGUgaW5zdGVhZCBvZiBoYXJkY29kaW5nIFBBR0VfU0laRQ0KPiAgICAgaW5k
ZXBlbmRlbnRseSBpbiBjZXBoX29zZF9kYXRhX3BhZ2VzX2luaXQoKSBhbmQgdGhlIG1pbl90KCkg
Y2FwLA0KPiAgICAgcGVyIFZpYWNoZXNsYXYgRHViZXlrbydzIHJldmlldy4NCj4gLS0tDQo+ICBu
ZXQvY2VwaC9vc2RfY2xpZW50LmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL29z
ZF9jbGllbnQuYyBiL25ldC9jZXBoL29zZF9jbGllbnQuYw0KPiBpbmRleCBhNjcwOTNjZjQuLjc1
NDVkMzYwOCAxMDA2NDQNCj4gLS0tIGEvbmV0L2NlcGgvb3NkX2NsaWVudC5jDQo+ICsrKyBiL25l
dC9jZXBoL29zZF9jbGllbnQuYw0KPiBAQCAtNTA2Myw2ICs1MDYzLDcgQEAgaW50IGNlcGhfb3Nk
Y19saXN0X3dhdGNoZXJzKHN0cnVjdCBjZXBoX29zZF9jbGllbnQgKm9zZGMsDQo+ICAJc3RydWN0
IGNlcGhfb3NkX3JlcXVlc3QgKnJlcTsNCj4gIAlzdHJ1Y3QgcGFnZSAqKnBhZ2VzOw0KPiAgCWlu
dCByZXQ7DQo+ICsJY29uc3Qgc2l6ZV90IGJ1Zl9sZW4gPSBQQUdFX1NJWkU7DQo+ICANCj4gIAly
ZXEgPSBjZXBoX29zZGNfYWxsb2NfcmVxdWVzdChvc2RjLCBOVUxMLCAxLCBmYWxzZSwgR0ZQX05P
SU8pOw0KPiAgCWlmICghcmVxKQ0KPiBAQCAtNTA4MSw3ICs1MDgyLDcgQEAgaW50IGNlcGhfb3Nk
Y19saXN0X3dhdGNoZXJzKHN0cnVjdCBjZXBoX29zZF9jbGllbnQgKm9zZGMsDQo+ICAJb3NkX3Jl
cV9vcF9pbml0KHJlcSwgMCwgQ0VQSF9PU0RfT1BfTElTVF9XQVRDSEVSUywgMCk7DQo+ICAJY2Vw
aF9vc2RfZGF0YV9wYWdlc19pbml0KG9zZF9yZXFfb3BfZGF0YShyZXEsIDAsIGxpc3Rfd2F0Y2hl
cnMsDQo+ICAJCQkJCQkgcmVzcG9uc2VfZGF0YSksDQo+IC0JCQkJIHBhZ2VzLCBQQUdFX1NJWkUs
IDAsIGZhbHNlLCB0cnVlKTsNCj4gKwkJCQkgcGFnZXMsIGJ1Zl9sZW4sIDAsIGZhbHNlLCB0cnVl
KTsNCj4gIA0KPiAgCXJldCA9IGNlcGhfb3NkY19hbGxvY19tZXNzYWdlcyhyZXEsIEdGUF9OT0lP
KTsNCj4gIAlpZiAocmV0KQ0KPiBAQCAtNTA5MSw3ICs1MDkyLDcgQEAgaW50IGNlcGhfb3NkY19s
aXN0X3dhdGNoZXJzKHN0cnVjdCBjZXBoX29zZF9jbGllbnQgKm9zZGMsDQo+ICAJcmV0ID0gY2Vw
aF9vc2RjX3dhaXRfcmVxdWVzdChvc2RjLCByZXEpOw0KPiAgCWlmIChyZXQgPj0gMCkgew0KPiAg
CQl2b2lkICpwID0gcGFnZV9hZGRyZXNzKHBhZ2VzWzBdKTsNCj4gLQkJdm9pZCAqY29uc3QgZW5k
ID0gcCArIG1pbl90KHUzMiwgcmVxLT5yX29wc1swXS5vdXRkYXRhX2xlbiwgUEFHRV9TSVpFKTsN
Cj4gKwkJdm9pZCAqY29uc3QgZW5kID0gcCArIG1pbl90KHUzMiwgcmVxLT5yX29wc1swXS5vdXRk
YXRhX2xlbiwgYnVmX2xlbik7DQoNClRoaXMgcGF0Y2ggaXMgbm90IGNvcnJlY3RseSBwcmVwYXJl
ZCBiZWNhdXNlIGluaXRpYWxseSB0aGUgcGF0Y2ggaGFzIHRoaXM6DQoNCi0JCXZvaWQgKmNvbnN0
IGVuZCA9IHAgKyByZXEtPnJfb3BzWzBdLm91dGRhdGFfbGVuOw0KKwkJdm9pZCAqY29uc3QgZW5k
ID0gcCArIG1pbl90KHUzMiwgcmVxLT5yX29wc1swXS5vdXRkYXRhX2xlbiwNClBBR0VfU0laRSk7
DQoNCkFsc28sIHRoaXMgbGluZSBoYXMgODUgc3ltYm9scy4gVGhpcyBzdGF0ZW1lbnQgc2hvdWxk
IGJlIHJld29ya2VkIHRvIGJlIG5vdA0KbG9uZ2VyIHRoYW4gODAgc3ltYm9scy4NCg0KVGhhbmtz
LA0KU2xhdmEuDQoNCg0KPiAgDQo+ICAJCXJldCA9IGRlY29kZV93YXRjaGVycygmcCwgZW5kLCB3
YXRjaGVycywgbnVtX3dhdGNoZXJzKTsNCj4gIAl9DQo=

