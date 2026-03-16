Return-Path: <stable+bounces-225499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OVHE995t2lRRgEAu9opvQ
	(envelope-from <stable+bounces-225499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 04:32:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99C2946D5
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 04:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 499D03012EBD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67021A459;
	Mon, 16 Mar 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AlRrNYQR"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6F20ED;
	Mon, 16 Mar 2026 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631963; cv=fail; b=EB5qNoRlB5CtN6X5V+7Q33aF0Jn5+y/MjGSwm3krf4z+Y25DS4sxEdD8TqUv8cQMIA8QaY9TzO/oGcHiNPxmB8dBPp1e2h9VL97liA72eNrMTy14Z2ofy/mqXXXfnlwKM3npXddNn5z2hfy6uUa8pBdkFJ8v1ImTxfNEXchW1lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631963; c=relaxed/simple;
	bh=BcNYQImCLp9fe+8v77mYQksnCuoZ1LQYU8fkCZSVMH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbJvseIfaYstCoZpq/NrWdm0UpudZPDlXS/UTx4xJQmPQtI2Iu9s43K9uWZap2ZFiRcWqAAdXWNeG5YQqpEVe8LIJpGPEtz/6Kl+ojOn4sVnPnXzMSUVzg11JVQ23G2i6mHySI7iB9DuXFwhSwFW8iSw1GiMHyvmCtisADafzQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AlRrNYQR; arc=fail smtp.client-ip=52.101.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQc1W/J+4aGKVjvewielWbZ6RbMPmkB1ejcTaZVMmrUnT/q0nDsUPA5BoCjP8Zvtl+Da1/Z5xQx33pwYh8N0XNM6rVctI5ld56ToqyLBPcB/V3JpaUkFxTN4Z+9CxquHRSrjOW4WqRKFHKbR00uIWZ2pdjf/0zvYvHXkMh5KhOdopPGY4m+ryfk/IOZO/yQi5vcWhzzPycCny6uzzuJVWQiSmAassqwtty0m+1zczKxAb5XsQPXlfTZ0Ej7RNpawnDasr5LSAQG1+b+Bc70pq/bLu7CTLoAnxQgN8+2HErLuKu1a6kXp0zdp8z+Ov5ueADhtt64RBlMSChVYdsMOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcNYQImCLp9fe+8v77mYQksnCuoZ1LQYU8fkCZSVMH8=;
 b=Qn2N1+zBkBmRFdxTwn54dvsidOyvFuUhGOUls+626ovk4clgdajSW5An4FVCddR8ndiHH3psZjjdZRwM3HXmib1xaIBzoOGZJ/BiCXfgprQ6JzAdcnx6Xd9JvRhcdSz0PAVpR7bpzmKTsJ/jMmutfapiAqTxwq4YCf/Xe/tbNGcjU4vQf8JPSVD/Ioq0UV2Lwbysh5v/q3i0FrbtrgtHU9T9GtfplWgQGSoi1a1gvjJLu7L4rLEYlvNq2A1Or7sE/13KvnSUxVb6IMNlol/Wb5cZ7LX0ikf/GqA9+A5igZ1cjs3wu9U+7yO3Uu+KnnS8eVRO+s5lU2J7kpkf+WDX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcNYQImCLp9fe+8v77mYQksnCuoZ1LQYU8fkCZSVMH8=;
 b=AlRrNYQROgz5lwCeMF8LKYL2z+KRQwzrppBoqSBZ6VRes4PRVofUfvjsRfF5GxcpNu9msAvMHdkS1/DTO1A29sJeOCcWa22hU0V0br68F7Ee1IbTfFG1QbYA9qm+6M08Earq1M2lH7Z6yyWMXIIBIoEhAmqDOlEi8CAvXd9KhSc=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 03:32:36 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 03:32:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Junrui Luo <moonafterrain@outlook.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Topic: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Index: AQHcs8hNugauCCvVHUGPs5pxhSEgSrWwgedA
Date: Mon, 16 Mar 2026 03:32:34 +0000
Message-ID:
 <PH7PR12MB6000A8C0694949AA83702AE2FB40A@PH7PR12MB6000.namprd12.prod.outlook.com>
References:
 <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To:
 <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-16T03:26:58.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DM4PR12MB8557:EE_
x-ms-office365-filtering-correlation-id: 6cdf4433-d10f-4770-51b9-08de830caa05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 i67h+9q+Sdbis5DzIc/p9EaPI8/FFbKifCakAAVe2nbdyH4E4ijoQ0ujtqrW0Z5hZxsEdUEreNm6Ewntn1mpYvzIzrvCWFAdmqkNP7LIUSn4wvKYy+7l6GpkBuZ5U18T1QJkbTB8o2snYBh/ZNO2Aaw8ylADHxct1HlFfLMHk8GyZG9RW2LMTRyNtZErWdTRE8RD19rkVBkcpuqpgzcNhLajc1jUnzKz9Sz3KdoY6ayx3svqCdO8LgtJQK+2Pqg8TeAkp0pkpJOMi6E3DA09a+gal09dqhuKt2syQ7oeZ/qvrAhAfj6wpXrEaHKmL2caey65nX1DzQbgg9e1d55WNUBMyQpgFFMT8ar2OjjTqaz57xYFzY//Eq8fRUGtBbLhujkbEzM+fhxCW5VfO05Dl8QZIG234CDeitXOaojrkufJkQRZ2JWCTS56nNsPRY2WTc/pU3oZI4/gI4rOHtg5iLCHNdsc3bvx8pMRgO0HhFYbb5CtULS3ZGPKRVRGG3V7pflUBNCJvVcC/uKmptCS4MCw06t28hV9+OiUo0Ee7PSYtWn1PxeQTPNquxqCVBFH8zyWDcHLDPBEsH0fKXz/ja4zfg36NSHGoKN2ikPtFPAtFmqKU7Ky+NkpogaFTeg1xnu+HPU6QYbapycMab4V1LhU4LYc684FVX31H/WWQ0YXX8SdYqXY+I0QK00B0Cqpn7Iyrk9tG9UeML/cf2oBVBn0FqWu21qMhGltX6mxYyi/lXnOmMTeehckmW6L48eR4/vFa8ogqushJvt1B2wlsgX6I4jRoKUbx+s+CMgZaSw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6000.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkVXRXdYc0Nvcm9wc044eE51SXhHc0xac01Cb05TRVFOUGJ3Ri8zc0E4Z3hJ?=
 =?utf-8?B?Wjg1RVFuNUFpRXdvdGRraWZMbWVSZmxhYlRueFB1eEVyVE1UZUpDTjNkSm1K?=
 =?utf-8?B?cG1TTGU1QTdKbXpHV3g5Rm5lbm0yby9KQWdLYUwwS0xncjkvT1QxcmdoQ0FT?=
 =?utf-8?B?TXExTENQOG05M0F5RWMvem5WNCs3TFArMFQvVTVUcE1QRm8zclgydU5LaUQ0?=
 =?utf-8?B?bDR1VzBLYW4rZ1RvT0kzdWhVSTRTeWRpYWRxTWFCUVpQNVlYMmF2Mmk0dlNJ?=
 =?utf-8?B?SW1vZUtHUWE3U3RReThQemlDVXRMUk1WS3JkUU8rTDdBK2ZhK3NSZDNZRUln?=
 =?utf-8?B?dUR5TGJGMzcrZFpZSXFDazlKMWcxb2NLWWhRNDNmc0VCNkpGYUR5U3d3dFNh?=
 =?utf-8?B?cWFoeThKSHhmUDkrVFNxSHA3UWUzTVdwVFRlMkVwdjBxcTNudXlGd0V3d1FQ?=
 =?utf-8?B?eFNqbXFvYVZLUlJlUlBXRSt5NDlCT1dWQlliVGFpbDNBL3AzeDNoTFNxQ1hz?=
 =?utf-8?B?QmNFQ3czQWNUV2gzZnl5ZWpHaGJjKzVpSDRYMG0xZGJrMjYzMkhTaFBFSFBZ?=
 =?utf-8?B?ZExPV1A2QURLeU1CZ0V3Q2lBMVZNSEtCSytnNDByQnpPbkxlT0E0VEJtL2Zx?=
 =?utf-8?B?cWdVbnRTRVA4a1RNZ2Z1OEV2ZTMrTHBoVklTWXFBb2NlQWlqdVk2UGt4MW80?=
 =?utf-8?B?aDNVWDBDeGNkS29UazZ1czZNa2lDT0pQcjhHQnBhRE9SZnowS1JrN0pLYk9x?=
 =?utf-8?B?UG9SMEhiZ3FmQXNKTnVtaXpnL0xScnYxcjErM3ZwK2ZaZzdrdW42R25Qc0dQ?=
 =?utf-8?B?NHU4V09YSTJyb3VkZGltdGtFL2dBNVNHUkJJK0tvSkFYME5ESjdTVVBwOUpr?=
 =?utf-8?B?ZVczeVNDb3BWTnprcld1UkhqYnR4SkUwZU5MZzBOS1ZFS09KRDJpbVpoaVhU?=
 =?utf-8?B?c2NmbVBxSCtHb2E1bGVwR0hZdE5Bek5jQ2FHSGxvNEhacmk0ajdQdmtMdGpE?=
 =?utf-8?B?S1pWWHUxS2ozdmgrWWJiMlhSbDFudlRjTHdGb0hiUy94YityaVEydm03TnVR?=
 =?utf-8?B?bFZKTnljVm9hQWRMdUU5RFpDdThjTHd5Ym1DYzFrOG02SUtLczZ2VVVXNyt0?=
 =?utf-8?B?WmlCMWV4UHBUTXJsZjN4NXF2SlE5bUpvbjVTSHJBbmFCYXBwN2VObkVBS3lt?=
 =?utf-8?B?SlpRMnE4SVNWWmRsK3hRS3B2SGtjQUhLeWV3UEUvVmRtVlJJMFdETHM1dmJt?=
 =?utf-8?B?eEVTNmZMRzJJMnArUjJQbDdmRThXOTBBZzJlSXQrQXg2NTlVSHZlNmpvY2pa?=
 =?utf-8?B?MTNRUXZQV0ZuY3NoOEZ0b3pnZlhGSG1YK1FPbXkxODBQeVBJTCtSQU42R1Y4?=
 =?utf-8?B?R0Vha0pKdzZUZGJ5aUdEaFRpblR0MnVnVi9SZjJKZXV6aUZmUlZzVWxZaUp2?=
 =?utf-8?B?b3JxTW4xN0JjaTI2VEVmcGVSQzBDVksxcndpQ2xTaXp3SEl1VzFqb05yUERi?=
 =?utf-8?B?bW9UYWdlSis5OTlWRnllcmlGUCtpNm9XS1VLOVgvb0lHNEE2Rzg1b1h3NE15?=
 =?utf-8?B?YXFCV1RKd1g4VFdOa0ZleFZra3o4UnZRNUlJUnhSR2VTOFNVeFRHTkdzR0Zw?=
 =?utf-8?B?SjZ2enZsb0hpTmxuYUFoVkIzL2J1cEtnYllKVWFwRldScVZmYlpHajJYUDAw?=
 =?utf-8?B?RE1HdVIra3ljZUpkZU1FTm9FTFo1WVBETERQbjcvK2JaMTN1OVZ4L2FHN1BU?=
 =?utf-8?B?VEV1Qm8xcWRaeDVMNmt5dFpDTENsWHJEY3dOMXJNSHZkMFdpNXcyTWMvREtC?=
 =?utf-8?B?NERPa1lvWjlhSzcwNG0xQVZ1aU1Dd0R3Q3VHZmh0MllSTkk2cExwUkVCMFVF?=
 =?utf-8?B?RU9EdXBSWVdZWmlkaWptUktVM2ZLV2QzZUVMYkJPWTkrUUNrUEFkcVhrMnFB?=
 =?utf-8?B?b1JZQUFWdTFqaDdNdmZEMXJrc2FXaGNyUEcyQi90Ym1LUS80NTRDaVllSVhR?=
 =?utf-8?B?am1wV3BCVVduOGpGbk8waUt4enhQUlUwK3dvOVV5Mzc2RjR3QlVVcGZFMHVF?=
 =?utf-8?B?c1Q3N2hyaEtkQ3FZYlFLcTNKeE96OXNHSlFWRnZYTGRTZE1GTmRSa2ZrTVU0?=
 =?utf-8?B?WmpUdUR2WjFMVmxGM1I5a1hUS0taUDZNMmJrT0lORlhqZVRwQm1HdDNXejlk?=
 =?utf-8?B?cEhuZERtaUd6cW1YcW5jeEhWbENtemtmOGhIS2hSKzRkaGlZOXFlQy8xRHYx?=
 =?utf-8?B?elVFTlkyQ25YbEdqY241VGx0UUtuNHRCNVhabHlkWHViQ3VVeVJmeGxJUFJa?=
 =?utf-8?Q?xhpJbxt4R5MijeBdZ3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdf4433-d10f-4770-51b9-08de830caa05
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 03:32:34.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jz5rn75or3jg6f++0Em81iAFTZfa3/PrTKYDmchUwbw9FMdAFi6n4Ze4ogonJ0vO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225499-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com,amd.com,gmail.com,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Prike.Liang@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,aka.ms:url,lists.freedesktop.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ffwll.ch:email,outlook.com:email]
X-Rspamd-Queue-Id: 9B99C2946D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W1B1YmxpY10NCg0KVGhhbmtzIGZvciB0aGUgZml4LiBXZSBjb3VsZCBmdXJ0aGVyIHJlZmluZSB0
aGlzIGJ5IHdyYXBwaW5nIGEgdW5pZmllZCBoZWxwZXIgZm9yIGZldGNoaW5nIGFuZCB2YWxpZGF0
aW5nIHRoZSB1c2VycSBNUUQgcmF3IGRhdGEuDQoNClJldmlld2VkLWJ5OiBQcmlrZSBMaWFuZyA8
UHJpa2UuTGlhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVucnVpIEx1byA8bW9vbmFmdGVycmFpbkBv
dXRsb29rLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDE0LCAyMDI2IDExOjM0IFBNDQo+
IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2Vu
aWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGF2aWQgQWlybGll
IDxhaXJsaWVkQGdtYWlsLmNvbT47IFNpbW9uYSBWZXR0ZXINCj4gPHNpbW9uYUBmZndsbC5jaD47
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgWXVoYW8gSmlhbmcgPGRhbmlzamlhbmdAZ21haWwu
Y29tPjsNCj4gc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgSnVucnVpIEx1byA8bW9vbmFmdGVycmFp
bkBvdXRsb29rLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBmaXgg
bWVtb3J5IGxlYWsgaW4gTVFEIGNyZWF0aW9uIGVycm9yIHBhdGhzDQo+DQo+IFtTb21lIHBlb3Bs
ZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tDQo+
IG1vb25hZnRlcnJhaW5Ab3V0bG9vay5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBh
dA0KPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0K
PiBJbiBtZXNfdXNlcnFfbXFkX2NyZWF0ZSgpLCB0aGUgbWVtZHVwX3VzZXIoKSBhbGxvY2F0aW9u
cyBmb3IgSVAtc3BlY2lmaWMgTVFEDQo+IHN0cnVjdHMgYXJlIG5vdCBmcmVlZCB3aGVuIHN1YnNl
cXVlbnQgVkEgdmFsaWRhdGlvbiBmYWlscy4gVGhlIGdvdG8gZnJlZV9tcWQgbGFiZWwNCj4gb25s
eSBjbGVhbnMgdXAgdGhlIE1RRCBCTyBvYmplY3QgYW5kIHVzZXJxX3Byb3BzLg0KPg0KPiBGaXgg
YnkgYWRkaW5nIGtmcmVlKCkgYmVmb3JlIGVhY2ggZ290byBmcmVlX21xZCBvbiBWQSB2YWxpZGF0
aW9uIGZhaWx1cmUgaW4gdGhlDQo+IENPTVBVVEUsIEdGWCwgYW5kIFNETUEgYnJhbmNoZXMuDQo+
DQo+IEZpeGVzOiA5ZTQ2YjhiYjA1MzkgKCJkcm0vYW1kZ3B1OiB2YWxpZGF0ZSB1c2VycSBidWZm
ZXIgdmlydHVhbCBhZGRyZXNzIGFuZCBzaXplIikNCj4gUmVwb3J0ZWQtYnk6IFl1aGFvIEppYW5n
IDxkYW5pc2ppYW5nQGdtYWlsLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogSnVucnVpIEx1byA8bW9vbmFmdGVycmFpbkBvdXRsb29rLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMgfCAxNiAr
KysrKysrKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L21lc191c2VycXVldWUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2Vy
cXVldWUuYw0KPiBpbmRleCA4Yzc0ODk0MjU0ZjcuLmZhYWMyMWVlNTczOSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiBAQCAtMzI0LDggKzMy
NCwxMCBAQCBzdGF0aWMgaW50IG1lc191c2VycV9tcWRfY3JlYXRlKHN0cnVjdA0KPiBhbWRncHVf
dXNlcm1vZGVfcXVldWUgKnF1ZXVlLA0KPg0KPiAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV91
c2VycV9pbnB1dF92YV92YWxpZGF0ZShhZGV2LCBxdWV1ZSwgY29tcHV0ZV9tcWQtDQo+ID5lb3Bf
dmEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDIwNDgpOw0KPiAtICAgICAgICAgICAgICAgaWYgKHIpDQo+ICsgICAgICAgICAgICAgICBpZiAo
cikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShjb21wdXRlX21xZCk7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9tcWQ7DQo+ICsgICAgICAgICAgICAgICB9
DQo+DQo+ICAgICAgICAgICAgICAgICB1c2VycV9wcm9wcy0+ZW9wX2dwdV9hZGRyID0gY29tcHV0
ZV9tcWQtPmVvcF92YTsNCj4gICAgICAgICAgICAgICAgIHVzZXJxX3Byb3BzLT5ocWRfcGlwZV9w
cmlvcml0eSA9DQo+IEFNREdQVV9HRlhfUElQRV9QUklPX05PUk1BTDsgQEAgLTM2NSwxMiArMzY3
LDE2IEBAIHN0YXRpYyBpbnQNCj4gbWVzX3VzZXJxX21xZF9jcmVhdGUoc3RydWN0IGFtZGdwdV91
c2VybW9kZV9xdWV1ZSAqcXVldWUsDQo+DQo+ICAgICAgICAgICAgICAgICByID0gYW1kZ3B1X3Vz
ZXJxX2lucHV0X3ZhX3ZhbGlkYXRlKGFkZXYsIHF1ZXVlLCBtcWRfZ2Z4X3YxMS0NCj4gPnNoYWRv
d192YSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2hhZG93X2luZm8uc2hhZG93X3NpemUpOw0KPiAtICAgICAgICAgICAgICAgaWYgKHIpDQo+
ICsgICAgICAgICAgICAgICBpZiAocikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBrZnJl
ZShtcWRfZ2Z4X3YxMSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9tcWQ7
DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICByID0gYW1kZ3B1X3VzZXJx
X2lucHV0X3ZhX3ZhbGlkYXRlKGFkZXYsIHF1ZXVlLCBtcWRfZ2Z4X3YxMS0+Y3NhX3ZhLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaGFkb3df
aW5mby5jc2Ffc2l6ZSk7DQo+IC0gICAgICAgICAgICAgICBpZiAocikNCj4gKyAgICAgICAgICAg
ICAgIGlmIChyKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKG1xZF9nZnhfdjEx
KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX21xZDsNCj4gKyAgICAgICAg
ICAgICAgIH0NCj4NCj4gICAgICAgICAgICAgICAgIGtmcmVlKG1xZF9nZnhfdjExKTsNCj4gICAg
ICAgICB9IGVsc2UgaWYgKHF1ZXVlLT5xdWV1ZV90eXBlID09IEFNREdQVV9IV19JUF9ETUEpIHsg
QEAgLTM5MCw4DQo+ICszOTYsMTAgQEAgc3RhdGljIGludCBtZXNfdXNlcnFfbXFkX2NyZWF0ZShz
dHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlDQo+ICpxdWV1ZSwNCj4gICAgICAgICAgICAgICAg
IH0NCj4gICAgICAgICAgICAgICAgIHIgPSBhbWRncHVfdXNlcnFfaW5wdXRfdmFfdmFsaWRhdGUo
YWRldiwgcXVldWUsIG1xZF9zZG1hX3YxMS0NCj4gPmNzYV92YSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzIpOw0KPiAtICAgICAgICAgICAg
ICAgaWYgKHIpDQo+ICsgICAgICAgICAgICAgICBpZiAocikgew0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBrZnJlZShtcWRfc2RtYV92MTEpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIGZyZWVfbXFkOw0KPiArICAgICAgICAgICAgICAgfQ0KPg0KPiAgICAgICAgICAgICAgICAg
dXNlcnFfcHJvcHMtPmNzYV9hZGRyID0gbXFkX3NkbWFfdjExLT5jc2FfdmE7DQo+ICAgICAgICAg
ICAgICAgICBrZnJlZShtcWRfc2RtYV92MTEpOw0KPg0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDAy
NTdmNjRiZGFjN2ZkY2EzMGZhM2NhZTBkZjhiOWVjYmVjNzczM2ENCj4gY2hhbmdlLWlkOiAyMDI2
MDMxNC1maXhlcy1mNDQxMWFjODVlMjINCj4NCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBKdW5y
dWkgTHVvIDxtb29uYWZ0ZXJyYWluQG91dGxvb2suY29tPg0KDQo=

