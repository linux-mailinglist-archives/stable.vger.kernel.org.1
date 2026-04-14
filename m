Return-Path: <stable+bounces-237698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDTMNLma3WkAggkAu9opvQ
	(envelope-from <stable+bounces-237698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:39:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F13F4D1A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB9D6303C006
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CB2D0601;
	Tue, 14 Apr 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="F40SQdFR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23A4A0C;
	Tue, 14 Apr 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130727; cv=fail; b=JBRtasIcssJHbsbQfjpWluCdW4UDp3QixYeOSO5zONUtu+I+Fynp/cXRjSze1gqYBzlPtpvpMCR39eZqP5TaG0AFA4UQ8EaVrbl5MDvlMlknj8k1CmqohonZQCkwpI7R6u5ctO91bkUSmx/d50/g+y0loMV2HN2mHlAYocmrmng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130727; c=relaxed/simple;
	bh=Jkiy30uB+xl61/F3c/Jfg8lsuNuOqLQ/NtInDm5xEbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zu73SnFo91qWfwaLkthwwmSt/JcMO+kE/0e/sebbg1FIxgukeU4TW534lPSZkW9kbQg2jNvgVds2pUU9nUQ+oTs3w6xzX7f9siZ2iwDTpOS6NwvxLj2C5fy/oQOknme1r6XQizPftg097wYgfQNj3jowbxccLeXZdprG67Gkj2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=F40SQdFR; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E1E41S3319528;
	Tue, 14 Apr 2026 01:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QQhv7R27IeO2hBeqglhgXCrDVEJdQcRd7ZQDjeRdVcI=; b=
	F40SQdFR26F15UgL7jfxqsIzq3EB5uV73P5dFN2ACVykG0yO4S6txgoY/oyUglRh
	DuEWDzuuxdwZ1j063Vl8CaCoOmtiiVlDMPATf+nCisQdo2tJfy0rltsXhgRZ7RK5
	axt9pKuY/fNZIZnGKIeDd5i9ySvWA71KMMC4jpCx0pLkKglA9Ugg6aEQajVfN1Kd
	SBneFdDHy5MhryxObDK1ERv5qpTa8RlsjA4ZfSV1ASSLjaaSWevuMWg9ALq1i2h7
	lly/9NOh+4O77Jd2FkmVJQeJVHOLCYack+pa0vbf6C8s5D5NasHE23frhvJ5rhb9
	4CG35ak2L3wP00y409MXGg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh87a868c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 01:38:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfGgdd6oqifczgus6Y0XEzGIF+AHedniPlxl1xYAARU7vWQpyOPmN3SMCSvVp6XePhMJ3TPIksL1KOSqn6h18iTELcWYPKVR0hFzQ9jH7AgWiMoofUM+A5WTUjKdys/yEmouqCPcnz+ku9lv/cJsJ7Z3dKb+SN+GJYDWXqexur5Vu8AMwZ5H2spGYWeeD8ztOPxII3vo6Zu+rmf/6naqxqreIn5k6VGB79fzbT6FMt6IHklS60PfsutIKj9vAxC46ilCGoMTpKiJe4/0Pv4ZwsHjPKVdhLZRm0Ktq1Ps+OsfoZ5PhOEU+YsTjVLUgVmN+fp/FWgLfpdZlbXh+WFNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQhv7R27IeO2hBeqglhgXCrDVEJdQcRd7ZQDjeRdVcI=;
 b=Tlf+px/T6XuJReqYlsvbvVNKJp/E7kUD6PWXgp3gXzqCSOcePgwz0+8tjrVEEicDuxLckzzr0tRQHEboCoqtN/SLckLyGAflSLx43Wi5VKRXmxDwKPCI5e9R8TrC2tDsa/4zUqQsnYt6rbT/Sd1VAAVV7IRDu5k4kRSdFisoj6tkAs8TemglqLg5gQ+cTMW1nFILaSIwthlQS4zLmS3eXOIIkMTYktZqXBWFV3TQsAAFXkzZINMmav4WJhPt05mRz8QNnVtrLM5GMvlIcg0UL/3R9D0IQkNb8cNdTGJR8vuKK7DDA1czn1LZ67h2MlVbk72ryI6w8YGlHfxMcN7PgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15)
 by SA3PR11MB8074.namprd11.prod.outlook.com (2603:10b6:806:302::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 01:38:05 +0000
Received: from PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::aa66:357:3ba:7162]) by PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::aa66:357:3ba:7162%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 01:38:05 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis
	<regressions@leemhuis.info>
CC: "Berg, Johannes" <johannes.berg@intel.com>,
        Friend
	<netdev@vger.kernel.org>,
        Linux kernel regressions list
	<regressions@lists.linux.dev>,
        "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Topic: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Index:
 AQHcwOon+EXpRGfVfkKIJTxR0EbLd7XJePpigAICbwCAAaZzGYAAFfSAgAAVTuCAAAGWgIAAAuQggA+mYwCAAA+xAIAA1PP4
Date: Tue, 14 Apr 2026 01:38:05 +0000
Message-ID:
 <PH0PR11MB5593FD5696ADFC879A237E8DCD252@PH0PR11MB5593.namprd11.prod.outlook.com>
References:
 <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
 <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <2026040349-chowtime-freeload-5ca4@gregkh>
 <DM3PPF63A6024A9E931C940F849C60FAF9EA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <58f6e74d-480e-4e0c-aa66-68dfc1de7421@leemhuis.info>
 <2026041330-groggy-ruse-5e27@gregkh>
In-Reply-To: <2026041330-groggy-ruse-5e27@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-04-14T01:38:04.693Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5593:EE_|SA3PR11MB8074:EE_
x-ms-office365-filtering-correlation-id: 6a16b88c-90c8-4ffa-27ec-08de99c6798f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 IId7NlKwRXKvPNxlQPX6mtozc8XTF9k6T2VNQ87xS4k+fyb1F5kLK3G59/zrWwleZUkrci8RIo7NU9J0/Z1UgAnvkM3UqtghoI1zGjeM0G4Fsd6tTwcxlHl61YZ6Ekw7r4loDFvg3PXLzFq676yMXrBAkQUUDNAA/J27zOunT2QtMMx5Oe2eHo6DyBLJLxkT9rthqqKnm2DG+VxmlSiDwxo7CVhB+w6mplZxr0SYjbUQX3jOEBYpAr2UEfO9ot2YpIqpjNxIMd0NEqBvly/5cE2/VTF5KLysGp9G4ie31vz23akrVIoAvLSnOkpXla8ACE/ljckXb/zGcmRYs5z/o4oP/8XJoCDDSV4VBOvrPv6MQKsQHzumE5yqkuJPjnq87zCsWC+djaGb7rFdf3+tFoHHm/f5J9kaPSWEmFXkcLCMKjn5hyhIYmJfj+fGf0mjCYkJmL4jXZ5gsUZWk42jqHJmDOxFyAkKE0DAIyfxkoHi9FRb70uezowU9OBtI3y8PuPnBJx9E4kwNTr4EAtKU46OPza0Y9mcW/HFYkym9Gb4KfeZAjlSnedfMzIHmZYwe9q8w1ZepP4awe8MBWPQVPaav/RDBAnduhhpo/WmIiC0BgN6pNe9Eg5sqXMKrKIqTCHtII/4fsZXjJrQeDohle0K9qkOFYmQYhT0qOfenhcykSopGB6jsvx6MTcTB6t0DXpDCM/gvnsSTQSohlrSMQx785sTAPz+PE4UmAhCaURV1Ffg028uDeWg+YKt1NPN/PXWr8yKmx7OQ10wLHQ1UlaWOCSoCSYpKG9brQ7v8Mw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sPSpLp8sS3yEg9HiaHqQP7pxWivZcNko/bnq6sFBlq7vTtjV9SufZL2XMp9s?=
 =?us-ascii?Q?4AVr0uUbe2B6lF79RvPUBiwx9QDpJeKouzSXY7RpOc0sqOht8NoloLdYNikz?=
 =?us-ascii?Q?RpCxjNUyVRJe9iqP6MMiL6l+HyG/f8hHGQy0sOv9toKHsXZDA8Gy0yaBium4?=
 =?us-ascii?Q?b9ovXFpNK0KT7aezNyvTLgDl/PNtvIrnml5Xmbc1L8r1XSW/QhXsECl9ZzlP?=
 =?us-ascii?Q?ngFyl3Lwls0tKffh3CGOpRS9kTCJZe+dpuULDvYSm68kOHqYMANS1no7wrIS?=
 =?us-ascii?Q?ZCFGDIzmf/bMkNPzcaKDDcR3MwK0gBvJ+vIDgcFbFxDKxzXk50C0fZJWf5at?=
 =?us-ascii?Q?qmlXuvQ/lgZmUPOs2wu3d1DCmJYYC6YPwJvqRzv+xcTj//nhHPiXHHmy8Gyz?=
 =?us-ascii?Q?82H+0rjwhJAIfVGW33fvLH6M/AZT8bUwcyBHJmbdj932x1uSiWF/p4hQFA5P?=
 =?us-ascii?Q?5bzaAOab9lui0J1MBiV/TYwksUJRb4faZvegHK8l2opYqKAVh0seEc8JpJf/?=
 =?us-ascii?Q?LljFuxVdbEw8Zr3KmVPXkDLoBuCVY8dZUbMxVtbk4bj7N/+dUF81VqXDYr0r?=
 =?us-ascii?Q?cTDTny/A34E/IqNKsRaOTGnQOvETJV0FJGTLi3xSkw28GP30WHtIMcfVzycn?=
 =?us-ascii?Q?THtzTuietDluBnpkhmRALeIGm02mcp/1KWJXWzMetxMvYCa80JsNLcH6RkmZ?=
 =?us-ascii?Q?k2Te+BsIswESrZr+D7xvF/1FiK5sMmfA5KnDOhYXFzRGRCfyg+WLXi2M7B5K?=
 =?us-ascii?Q?Py76jXnN2uYODmby4i3P78pNaNJB6IFQPpAFefjtskrTzR4YAcHrjj/YvSHQ?=
 =?us-ascii?Q?TnJ9qOVDSa4bJ2JmaQpivs69RMo95Fd3Tq96Me3i3CwH9yPyd3IOdCHm5fj0?=
 =?us-ascii?Q?e9BnwAFwPvTmZ5lX9sMZNRsymqK1ptj1It7WBKEMlCHGpTPomoSp3NepL4ud?=
 =?us-ascii?Q?LLIFO6Uvt1RtwLW8IubWSCGTRIFxoj8agTx2CqotqauA1wSQ/uMExxdf3X0A?=
 =?us-ascii?Q?xX/VRb0FFYFj7rEoJMJSVZjyy9kRjvtwBGJ3Gl+IehRDdAgLJrZM7s7bVd9W?=
 =?us-ascii?Q?Dp9VXtKz74mLk9yKEFeUr/JMcwywxFb14Ohc1lI+ErSWBAINY69r6uJz5kID?=
 =?us-ascii?Q?wvvCWLurmkz7SSp4dAz9tFKyxgv8i1A7yF+dfy3x4l0svatH1AXCv97dcNBR?=
 =?us-ascii?Q?C8wPqxZbjBZzCs+WMB0lSyJOSrAUw8DExv4G3inYAHqh+MMh+VsrBZ11CLHU?=
 =?us-ascii?Q?/UwavKM3dbWu4wBJA4NJQgQV6GrQtaau1f12kw0Pzzt5hOTt1OJyNC+skZld?=
 =?us-ascii?Q?E/s6qYD1ZsRsPHhBX2QctgToew1bsx6rj9whBwPWTnc1yJ7Cnv0jkPoV2Shf?=
 =?us-ascii?Q?gFDGyazR8wl5JMMQu1y1bgIctcy6RK0GtOMkvdB09FT6a+zCwZohDSoYeo4B?=
 =?us-ascii?Q?iXQkDRTN+Oqx3BiFVZyNe+FPgPUhH58yRnuO7wK4241zZScGhgcbhWHU5rhM?=
 =?us-ascii?Q?xX9tWQPL1KH4b192Y39Bjol/Xmp24gC8wgWI6vWFJU7PcnA+xWdrOoB2/QZW?=
 =?us-ascii?Q?MFCyu8K/SK3NQU5IAkSGP3wBtpTWdsyJJ8oNpE81klo1b20nhWwqGPqp9afB?=
 =?us-ascii?Q?jSaM9iCOVhKnplWwHKIvOmkHuilxw1wZuv1iv5oAa6iDfWplPFNDYvbkONh3?=
 =?us-ascii?Q?6b1bEnoXFp5VgzTXiYKUGKCvsaDHs2U6AFO2fdE+PRvXkKPbd5+qbkMPNzib?=
 =?us-ascii?Q?RUBZhN0NSA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	k2BVjXriN/WRweDa1kSQSMrgvUYAXBxXbFlkIo0dSJn/Q2h2F95Nf7TeT+InF7yGIGwUm4fM29SnXu7ZL+XfRP2E5U4tGEIDzRRUtcnrfE932JX+lQ8zrqWexSjco+7wMYZ8xYvp38/sz65V61z3n5vUSMh8PvYUUe80wUKL2sSZbcik7tlgTxfdy6m+9qhNTZCBB9nPJa4uZCUfw7v9RV8W6uTKhC0bIdj1B+X8/hbw8OBCQWly3EI8qjiBzmiUQeXCxnz03zOHFs6MMQ6caBy28PJMjRlnHBbppsN++zV9fa2y5fBpeqKIv6Z2pjU+ik4aeNV23aKvYOxZZC5DrA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16b88c-90c8-4ffa-27ec-08de99c6798f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 01:38:05.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkzBboBSR7Kf7xK/DB4udNsYz+ylZzTebbZnc4o7+gWe9nSaCS60R6RWXOYZC+2KUM9YW8VFlyGwVK+Di4fuKihArIXWxrGIhiStkt3qwXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8074
X-Proofpoint-GUID: rcPxCdGUVOUn9Ze_TB_v353j4M-woMAk
X-Authority-Analysis: v=2.4 cv=Q4jiJY2a c=1 sm=1 tr=0 ts=69dd9a86 cx=c_pps
 a=xOrz19RqOvhMowGYDVTMqg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
 a=5BGjBZgeKs4dwjv0aCQA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: rcPxCdGUVOUn9Ze_TB_v353j4M-woMAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAxMiBTYWx0ZWRfX5My1qXub+yQT
 AztCph88/YLnxhZVwTZBt7UURQPEIQsGKmFHuCvlaUDQ1B5Vsue7yGIF99QXYQm/bSX+kSbddM3
 NyZMxxwhJDFlZeIdcxijpTSKbMiGWJnPFkBQm1NKFG+9pyCOaU+/11rqOh6s8XS+V/txRLTF4Rs
 nYGPGS9b7MKUIqwuTEY3ae0+JHHSfIeRpIxk9WjxOQdN2COjHFZ53oAh7xVQNk3IX9xfU5Ld7pB
 XUvNQAo+71z88wSKJfcjgaiX0Vb18B4KW6ZUHajYZXIIHo2nXaTur+XQjRVrxZvSdCDiTtMWXf9
 1P9HqB2QAruWkSpo98dsiUwG6s/AgnJ8TIvUwLOf/3LottVeSbhAC3PcLaghwdyU+AIX4+/nw/S
 SBNst+Sx+jT/nyvhK92khhuU/owiA0Mnr1+/SzQOmpE7cOY1KGwh/QYe8Jq9PMh5tq+s6E3sU4+
 SHPHCtEgmMWv0GKt9tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140012
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Guocai.He.CN@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 420F13F4D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OK, I will send a patch later.

________________________________________
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Monday, April 13, 2026 8:55 PM
To: Thorsten Leemhuis
Cc: He, Guocai (CN); Berg, Johannes; Friend; Linux kernel regressions list;=
 Korenblit, Miriam Rachel; stable@vger.kernel.org
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Mon, Apr 13, 2026 at 01:58:56PM +0200, Thorsten Leemhuis wrote:
> On 4/3/26 15:00, Korenblit, Miriam Rachel wrote:
> >> From: Greg KH <gregkh@linuxfoundation.org>
> >> On Fri, Apr 03, 2026 at 12:44:48PM +0000, Korenblit, Miriam Rachel wro=
te:
> >>>> -----Original Message-----
> >>>> From: Greg KH <gregkh@linuxfoundation.org>
> >>>> On Fri, Apr 03, 2026 at 11:08:46AM +0000, He, Guocai (CN) wrote:
> >>>>> No, The mainline have no this issue.
> >>>>> The changes of 0c4f1c02d27a880b is not in mainline.
> >>>>
> >>>> That does not make sense, that commit is really commit e1696c8bd005
> >>>> ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") which is in
> >>>> all of the following releases:
> >>>>  5.10.252 5.15.202 6.1.165 6.6.128 6.12.75 6.18.14 6.19.4 7.0-rc1
> >>>> confused,
> >>> The change is indeed in mainline, but the locking situation in
> >>> mainline is totally different (that mutex does not even exist there)
> >>> Therefore, the issue is not supposed to happen in mainline.
> >>
> >> Ok, does that commit now need to be reverted from some of the stable b=
ranches?
> >> If so, which ones?
> >
> > From every version which is < 6.7.
>
> Greg, do you still have this in your todo mail queue somewhere? Just
> wondering, as last weeks 6.6.y released afics lacked a revert of
> e1696c8bd0056b ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") --
> and I cannot spot one in your public stable queue either.
>
> These are the commits that according to Miri need to be reverted if I
> understood things right:
>
> v6.6.128 (4d7a05da767e5c), v6.1.165 (0c4f1c02d27a88), v5.15.202
> (31344ffecd7a34), v5.10.252 (d91240f24e831d)

It is, yes, my queue is huge :(

It's fastest if someone sends me the reverts and I can easily apply them
that way.  Otherwise it takes me a bit to do each one manually :(

thanks,

greg k-h

