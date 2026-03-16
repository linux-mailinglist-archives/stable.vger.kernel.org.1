Return-Path: <stable+bounces-225644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOV6IGhCuGmLbAEAu9opvQ
	(envelope-from <stable+bounces-225644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:48:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9B229E832
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD95303BB17
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770FD339878;
	Mon, 16 Mar 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RS6yv6jP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B31F8AC5;
	Mon, 16 Mar 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683092; cv=fail; b=oqTEd1EuugnHnofeKSG644FtB1nEukbaTj16r1hTTMgzH9E7Q3t7/xNjs7INWUQL8+Mel451+lAOVVkViz1eTqF+9UbomKBkNrnUmC7sTQF7bUpFwpB3CtxnsU3FUXSce33Bop7+TmsmRGfUJQLb+6kxPuEzL3nTHvc4cQLJFRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683092; c=relaxed/simple;
	bh=7SIngGKf1byomCDClK9mUuDoiFZQJM/BZhHeKympZ+k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=WHs3AdAZFU05ItxQwSB/XqaBYFlZ9MlaaONUP+9ImIQVktJJB4RZya4GkdS8zIhlArd866jms7xa8v9m/ky2p60tiSr5gMrmD6mSPu9zDhrf9H8crW2uYV/risksr78+euoLRx52whWbfE0GNnh7iMhLxE6ayAND27kYjOxsHlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RS6yv6jP; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9Z8Bh3775990;
	Mon, 16 Mar 2026 17:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7SIngGKf1byomCDClK9mUuDoiFZQJM/BZhHeKympZ+k=; b=RS6yv6jP
	fmT0EGfzg9rAnDlDtw0Tb7CwbjQ6AS3UPn5p/Y7i5TR1pUOIzbYdxl9/Iw1oCl+U
	8fCLxINcp6wltGvHg5VVNO7GUj6OD1Z66ueQlDZOpogIrp0CWZ6H2KJe4+uk4Swq
	aHPz8UbSDdJPEs6VTM0OB47zAqJUmI7JVs1mkpQ9cGYHIVFPidClU9rjxqTJEVq5
	CGkbWOdiYwhDDm56XNAbaymbecTsg5+bVllVoAVBhi9NdSP31HKkVBLfV/dwnKkA
	4bZu5IBQQcqGtgKbhjQmNM9oUsEwqNAVbeF5BcLVQiH7ZOSk1Z0RUUi5HiZ2EipL
	fR/bLN9klDx5fw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs133c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 17:44:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2WxReuWFaNYOklyLjJ77aOga0HdKw7kPG8MFVkUrCkSPWrSggQtYVfdYWlUHy/ddglKFzxJSrg9sW4K8499cvm7F4Hq38k9/ogN5Qz1AC/E9PnI41f5Wd1Uwslk++uOUfF2OQAKOTted2VbJFZ503UErV1xnsUlvRj2RxCOv3gmo+1v2Ivvtc6wDle1lcy2ECLINmH+1AJJ2YDF8GFV7AhEj9JLZqeCwSTwFkhtlM6FV9laNnPGMbhYYv4vHy7T6hoFPFyC6EbhsUdpH93ADZVy6sl5MsG31J+oIGJ1uMwbdPENYE/8Q21zFmISA5lqkWIKFedj6e4MNfiysCGLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SIngGKf1byomCDClK9mUuDoiFZQJM/BZhHeKympZ+k=;
 b=NwrVrr6I/tYSWWOOg4Hfb5o22FtxLJFvNuXu36Jz3P+N4eeSCrTTmvxIGn6OK1bRDv48sNq86RtY9lT0DylSmIKQraNvZMHmLGeU8lryWaKSwPQ9lZsKskjL1baffyBD6DAtwy2bsc3AD4rS8LfBVAdb648sfcj2qgJPtNyhVvneQtlJ1FL7lsuQls6/qsbBznFtaYYl8HgRPg+2ETlvPRVbINuFnRc8chOgisj0UjH4EPE1G3f9kcDJl8vUZHBfEss+GAJ6lWQpqsbfAZUoRCcL6aanupaiAQXSUGXdDi4TV/Lip6YvhozBgZB0nvBaX0cSxb6Ktk6e+20ncmm88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH5PR15MB6964.namprd15.prod.outlook.com (2603:10b6:510:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 17:44:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 17:44:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "cfsworks@gmail.com" <cfsworks@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: Milind Changire <mchangir@redhat.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [REGRESSION] [PATCH] ceph: fix num_ops OBOE when
 crypto allocation fails
Thread-Index: AQHctNMAHAS87kiUwEy+mTF102JALrWxb28A
Date: Mon, 16 Mar 2026 17:44:37 +0000
Message-ID: <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
References: <20260315232500.251088-1-CFSworks@gmail.com>
In-Reply-To: <20260315232500.251088-1-CFSworks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH5PR15MB6964:EE_
x-ms-office365-filtering-correlation-id: 2d499f83-da0c-4f77-f989-08de8383b1b3
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 O3pXVTd8mBLGHbfZGD4N+1Ku0K2rGGRe0K4GxtAqxjRWUPR93FNIQ93IgvEfXdhA0JzQ+qgDOcCrZ70KSwEcFSYpjzDmeNd7TGopytD6yqoop9+np46rzVr5iRvrjKKZB6d+BA1EOXZE50cikARhZWbBIVNMPkOOlow6oQMZTgy4nzqhlSohopacBXg3WpDNOV6ZsZ2Mh5wzMfxEocU5a22V06r1BBgpUgCiTcDlm6QGc/QQJJn80P3US2zkgsER0+rSI2mQeJ0eIR1uUlCkzhdN9xvGgfrVfrBc43oiA0zyQiEe6zX/M1wTGSNRuHSubOvMiSxk689zKCVsF/JLGOZtPrPs9i2eu5wn13Vp++dW9klJMZ458oWC29GUHZDSU1xwmDFvY6BxWxirmXSJMFsvFNED1blX5LvQOGmUCaWkPg9w/0voimrmMwWlflRzZoRM3MVs7JuJGd96yBEVSENLYVYqHYZxbAGGQczy2JI0pahLRcKmNrKaTjBes1kJKjfOBy2DzRb9z8iyCCnEYFcg6hzjdgyJbS6HacNyb5c3CWRC9iw77eRT/Ibro8BJVTaU0BF+bh5OIDOfn2RaprZYkTQoY2/vU8PTB+Vtqlt7HB7wW2A8tziDA6ZxbzI8CdonBYCoPdEAooXhLqSuCTQgn8227J71L01xKIogQ1x7jwGFwA1REPV8j2nYn4LB/zw2MZz4r9V2xHq4QhIY9JhIG76HX2xsVBp1ct320yAxj7G+nUSOJhe94P2EEjVxvC/a97imsgTJmT+fB5jIkgYo69pjxCsiT1Zhu/Umnuo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzY5VmdOUW95Q3F5M05Da0RtY1ZRYTFkL0ZYVUVYKzZSWWRuRnlwSVRuTmN2?=
 =?utf-8?B?SThjWkJKcERYSFRkcG54K0dDWllGVzhva2JxdW1qZEVaSy9qbHVkYkdpTzBL?=
 =?utf-8?B?V3dkWXZDYVl6NVU4SFp3akZPMzMyMUczUVY3Mit2QWFPSzY2OEhoZEdIWlE4?=
 =?utf-8?B?eldCZUt1K05PbUdjZjBSTmgwWUJCL0ZrOFdFN3pOU2YxTTVYUmxOT3pYcmt5?=
 =?utf-8?B?SzNlb054endqNmd1QjlGMDFoZjF4L0NBRGF2TGo3cTExOGtDOVUwN0xHT2t4?=
 =?utf-8?B?MWcyRmtpOVlIWk9EbVZLRFFtUSttK3I2QWsyOSs5YVg0a0VsRGlzZnA4NzI0?=
 =?utf-8?B?NWVGcCtvQmQyakJST1BoT1RnUThiVzQ5bllBUTFMMmErQm5WZ1krSWdPakZj?=
 =?utf-8?B?QVJMeGhhNU1ZRGxlT2tvUURIQmY3akVxOU9VMW8yNGxVcE1JZFRqR1hCN3Jy?=
 =?utf-8?B?Z3d2N20zTXZuU2M4L2o0NnpVN011bitoUW9XRzNDMUdLY1NNODRiWmpxeEo1?=
 =?utf-8?B?akFncmNOY2h4Qmp1YktzVityNDJORXJtcGFEUHpJZ2ZvMWhnWVovOCtzVVhF?=
 =?utf-8?B?Y096RmV2ZWU3MFlvQUY1VEdZa2psV2o4UnpJYkE4MWlBdWR4UEZ0RHNXS0cv?=
 =?utf-8?B?V2t6amVlMGV1V1lOc1VSSFU0c0ppRlpoR09OZFdZRFdHeXRocTRGZGIwa3FT?=
 =?utf-8?B?V3lUYVRxVFJQaHY2WE5BSnZNZEVZc0tpVTNPdDdDdGdRaFY5V2dsVGZBc2pB?=
 =?utf-8?B?Qlp5WWkxQXQ0bXdYRWVsaXU5ODVDckZMakxGYjIyZmZ5dkx6YUhvamxRcU9V?=
 =?utf-8?B?cDJBdVBYN2JlU2dKYytWMWdLQTU2d1lmVERGNURzWmNVajFOZHp3dUtOOVRm?=
 =?utf-8?B?MC90UzZOaTZLME56L0ZFSWtKNUpZOG1jc1hVczgxZGg4SS9pU0lpbVZGOVcy?=
 =?utf-8?B?SDY0YVdHb2tGbUtnNzhicXk1dnRyNVN3RmhQWDFFVUppYnJkdjlKSVRlN1R5?=
 =?utf-8?B?UmZFTVhNQWRtV3hnRVRvc3ozcFBHT2tHNWFMRHBSNlFlSFV0anNrQzRUdzQ4?=
 =?utf-8?B?bmVyZDRqZWR1a3BZLytQVklVZHQzZDQ1Q2VIREErQzBXcVJGcjJlQU92TGow?=
 =?utf-8?B?NEwwZTFodUUzL21MZkJwMExWcHBkZVVyRlpLOVVEK2Exb1I2TkZWUnBCZ2Mw?=
 =?utf-8?B?QVNhdVJKaGpaanRzcWtGb01VdGJkVWpEajY4Q29qeVFLTk9HWXNFTTFaSXhR?=
 =?utf-8?B?MkU5dWwrVWloMjk0MmFFcXYzK0twSDY3Sk85Z1hqTjdjMkN6UU5wYkRoVnFY?=
 =?utf-8?B?SGI4THFJUGFCUDhKM0pPekdWUTRmQmpRbDZyNldLWm81cFcxcURmUFU1czM2?=
 =?utf-8?B?VHRXR1lKWnhWcnJWWGFYaHNuVzVXSEU0Q2k2SXVoRkRCdTJzYzJRcDIzZlZR?=
 =?utf-8?B?Z01JL09zaHVTaUlSNUVtTXNGbEFvRkRPZGVhWTFMbnV4dkxEcVJNSXdXbG1H?=
 =?utf-8?B?enk4Mm94VS9FOHdtNXZ3SEZPNStPRDFJRGR0ZmlUWFlXa3ZEK3VLVlVrb21w?=
 =?utf-8?B?T0VsNkEvcUZ3MkFaTTRONXV2T21XUTY0dUdQbzM4WXNRZ3pkdmNjbFhlM0Y5?=
 =?utf-8?B?dys5QUo4YThLd3Rzd0NvemxZekoxUXdxQlJiYXNuckJQUEJadWRRc2d3K2ps?=
 =?utf-8?B?VzR6Ukdpam9sRjdSelJCSkxJVGFuVUkwOE5odUpJd3c0ZUpyU2VaL2Ivck8r?=
 =?utf-8?B?OG1uckFOa0w2SmF6YVlRQmcwanJ1SjhrUTdObU82ZEFsM3lKTkJWTlREbnMx?=
 =?utf-8?B?V3JQYTh0NWJHVm5LRjhJYzY2cHNHbzlWRjB3ODJhT3g4Q3FvNlZpVGRtOHhR?=
 =?utf-8?B?SEw3ck5BbFcwSDBHUnZPVUZVOXA1K2llZkFYdVRDNnVGS3BoYkxqbklsbmhT?=
 =?utf-8?B?Z1FCR0ZiUmFSWTJSS3loQmdOc1loYnpSdU5xMGRPOFZvNVMrSko0MnpibS9L?=
 =?utf-8?B?V0Nhc1dmY0JqZE5TaTk4OVpVUTFDM05oVElrSEdlaFlzUWxDaERjUnpxUFow?=
 =?utf-8?B?VjNqNk4rbVRPQ3JHektSeXZ6c3o5OEJmbTd0OWVETVplMStTbi9jMktsajRq?=
 =?utf-8?B?azd0UnVNWWRhRFkycXFISDJVVURTYit6NCt2MHk5amVySTlGN2s1TnNYMzNZ?=
 =?utf-8?B?TkhGcFRsV3NmVkFLSk5RWmU0VlNTcTlrK1NDQkIrcGdyRlNmQkJpeDFoM3li?=
 =?utf-8?B?NFlmanh2UEtMSUZqdWtrYmdtbmFaQzNWS1hNU1ZqSXVLZUZXeXcvWGFmWWoy?=
 =?utf-8?B?cUJKVWJTSCtRYmQxc2I4Ull0UXAxT1BvWTh6Y01MMEFUYnE2YVNqMkFDZ0kv?=
 =?utf-8?Q?ofFLe333WLQzYmum128tq1Mpd2dsj/RXy1YOe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <719D1347886D7148B1B0D815F2968F40@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SIm5/TyVadw5nvsbpSppQzYV4ZMRMKIaEY0G+yduaCgGYISJUwBXrNvBl/M7H5jvYRVifcfBNMRh6zMK1rBlR/mF/zWaQJSIBIaBCLdfNcJUIWBzj8yIhePIJgFU6WdJ5dUiFMrwO/zjgsCGlT3+/pWiU/7HH+sK2UVsVHh3sEytDZm5LBx7f4BLKl62TfcAILDz2csJKNDJSx9SYJM3PjSBLhuz2qg/pG+uc7cqU8SZXMIYWAnYUw64nfYldVwj9K/aoqV6n1cgAC4Wvh6a11fi/QM+vVB+fP2lWfTYbhIe6feKC8BDvASj0PpUvGkZAH6j6oGiAVgfB4g9KZNGQg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d499f83-da0c-4f77-f989-08de8383b1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:44:37.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /J/GOG46KvFXx7NnXLOn7J6c1Jb+gD9f+qaEcC3CaGyn2u5fmUHyF5tAVv08/eOO7O6lq3fACRro4SFn2AL8qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR15MB6964
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b8418a cx=c_pps
 a=TIoD7Y9874wd1wHQAFcRHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=9YsvZOoZ0y-oEnSvC40A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PwKJ43FhJp5S2D-oxKu1F3MMwvD3EfOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX078nb3cuH6yu
 3TsQb8fMGTVx8y56waWHXWNLtgS6ULpXrtuu0sf3b1+ODMb3UhU88MC/6eziUJkV7KlSJ1HOmC5
 nIfFc6V6W9m2v4E1N2InrzSWTwD7hSVqIHb49sH+VvCu2h189S2Tddwaj96jiNOBoiyhI8DHjGe
 SgK6fcYLuRq4p+sE4sNZuzrC0nLp4LLtpGJ5rbwza+iUENOsOaBQ7xv3LgqiLjc5p/C5Jmh/bag
 SwSvUj0+JNDofuF0djJ1RSAvfaT/YQtzTdOLDq5LLIYCIKeypoGbkJXqTSM4Qp4mj//NWuJwTqF
 gmvclB03c81ahypstIEVeJYsXpO9B9evYfu/j/zeHWrVLS8uO1t2aYID6bxTD/3XluIGUf33oOD
 fcDY1x26tiOndRZHgJAy4yy4zm1ukcHeTI3416iU+kOHAlutwua3lc2+64yE2ESChl+0SkSHXjW
 Oe9zn8GQTMhm6nt4yiw==
X-Proofpoint-GUID: WgWu-qIM4EzxJSZX9D8y0b0VWE6aPepa
Subject: Re:  [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160139
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225644-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB9B229E832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDE2OjI1IC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
bW92ZV9kaXJ0eV9mb2xpb19pbl9wYWdlX2FycmF5KCkgbWF5IGZhaWwgaWYgdGhlIGZpbGUgaXMg
ZW5jcnlwdGVkLCB0aGUNCj4gZGlydHkgZm9saW8gaXMgbm90IHRoZSBmaXJzdCBpbiB0aGUgYmF0
Y2gsIGFuZCBpdCBmYWlscyB0byBhbGxvY2F0ZSBhDQo+IGJvdW5jZSBidWZmZXIgdG8gaG9sZCB0
aGUgY2lwaGVydGV4dC4gV2hlbiB0aGF0IGhhcHBlbnMsDQo+IGNlcGhfcHJvY2Vzc19mb2xpb19i
YXRjaCgpIHNpbXBseSByZWRpcnRpZXMgdGhlIGZvbGlvIGFuZCBmbHVzaGVzIHRoZQ0KPiBjdXJy
ZW50IGJhdGNoIC0tIGl0IGNhbiByZXRyeSB0aGF0IGZvbGlvIGluIGEgZnV0dXJlIGJhdGNoLg0K
PiANCg0KSG93IHRoaXMgaXNzdWUgY2FuIGJlIHJlcHJvZHVjZWQ/IERvIHlvdSBoYXZlIGEgcmVw
cm9kdWN0aW9uIHNjcmlwdCBvciBhbnl0aGluZw0KbGlrZSB0aGlzPw0KDQo+IEhvd2V2ZXIsIGlm
IHRoaXMgZmFpbGVkIGZvbGlvIGlzIG5vdCBjb250aWd1b3VzIHdpdGggdGhlIGxhc3QgZm9saW8g
dGhhdA0KPiBkaWQgbWFrZSBpdCBpbnRvIHRoZSBiYXRjaCwgdGhlbiBjZXBoX3Byb2Nlc3NfZm9s
aW9fYmF0Y2goKSBoYXMgYWxyZWFkeQ0KPiBpbmNyZW1lbnRlZCBgY2VwaF93YmMtPm51bV9vcHNg
OyBiZWNhdXNlIGl0IGRvZXNuJ3QgZm9sbG93IHRocm91Z2ggYW5kDQo+IGFkZCB0aGUgZGlzY29u
dGlndW91cyBmb2xpbyB0byB0aGUgYXJyYXksIGNlcGhfc3VibWl0X3dyaXRlKCkgLS0gd2hpY2gN
Cj4gZXhwZWN0cyB0aGF0IGBjZXBoX3diYy0+bnVtX29wc2AgYWNjdXJhdGVseSByZWZsZWN0cyB0
aGUgbnVtYmVyIG9mDQo+IGNvbnRpZ3VvdXMgcmFuZ2VzIChhbmQgdGhlcmVmb3JlIHRoZSByZXF1
aXJlZCBudW1iZXIgb2YgIndyaXRlIGV4dGVudCINCj4gb3BzKSBpbiB0aGUgd3JpdGViYWNrIC0t
IHdpbGwgcGFuaWMgdGhlIGtlcm5lbDoNCj4gDQo+ICAgICBCVUdfT04oY2VwaF93YmMtPm9wX2lk
eCArIDEgIT0gcmVxLT5yX251bV9vcHMpOw0KDQpJIGRvbid0IHF1aXRlIGZvbGxvdy4gV2UgZGVj
cmVtZW50IGNlcGhfd2JjLT5udW1fb3BzIGJ1dCBCVUdfT04oKSBvcGVyYXRlcyBieQ0KcmVxLT5y
X251bV9vcHMuIEhvdyByZXEtPnJfbnVtX29wcyByZWNlaXZlcyB0aGUgdmFsdWUgb2YgY2VwaF93
YmMtPm51bV9vcHM/DQoNCj4gDQo+IEZpeCB0aGlzIGNyYXNoIGJ5IGRlY3JlbWVudGluZyBgY2Vw
aF93YmMtPm51bV9vcHNgIGJhY2sgdG8gdGhlIGNvcnJlY3QNCj4gdmFsdWUgd2hlbiBtb3ZlX2Rp
cnR5X2ZvbGlvX2luX3BhZ2VfYXJyYXkoKSBmYWlscywgYnV0IHRoZSBmb2xpbyBhbHJlYWR5DQo+
IHN0YXJ0ZWQgY291bnRpbmcgYSBuZXcgKGkuZS4gc3RpbGwtZW1wdHkpIGV4dGVudC4NCj4gDQo+
IFRoZSBkZWZlY3QgY29ycmVjdGVkIGJ5IHRoaXMgcGF0Y2ggaGFzIGV4aXN0ZWQgc2luY2UgMjAy
MiAoc2VlIGZpcnN0DQo+IGBGaXhlczpgKSwgYnV0IGFub3RoZXIgYnVnIGJsb2NrZWQgbXVsdGkt
Zm9saW8gZW5jcnlwdGVkIHdyaXRlYmFjayB1bnRpbA0KPiByZWNlbnRseSAoc2VlIHNlY29uZCBg
Rml4ZXM6YCkuIFRoZSBzZWNvbmQgY29tbWl0IG1hZGUgaXQgaW50byA2LjE4LjE2LA0KPiA2LjE5
LjYsIGFuZCA3LjAtcmMxLCB1bm1hc2tpbmcgdGhlIHBhbmljIGluIHRob3NlIHZlcnNpb25zLiBU
aGlzIHBhdGNoDQo+IHRoZXJlZm9yZSBmaXhlcyBhIHJlZ3Jlc3Npb24gKHBhbmljKSBpbnRyb2R1
Y2VkIGJ5IGNhYzE5MGM3Njc0Zi4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMg
djYuMTgrDQo+IEZpeGVzOiBkNTUyMDc3MTdkZWQgKCJjZXBoOiBhZGQgZW5jcnlwdGlvbiBzdXBw
b3J0IHRvIHdyaXRlcGFnZSBhbmQgd3JpdGVwYWdlcyIpDQo+IEZpeGVzOiBjYWMxOTBjNzY3NGYg
KCJjZXBoOiBmaXggd3JpdGUgc3Rvcm0gb24gZnNjcnlwdGVkIGZpbGVzIikNCj4gU2lnbmVkLW9m
Zi1ieTogU2FtIEVkd2FyZHMgPENGU3dvcmtzQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBo
L2FkZHIuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMNCj4gaW5kZXgg
ZTg3YjNiYjk0ZWU4Li5mMzY2ZTE1OWZmYTYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvYWRkci5j
DQo+ICsrKyBiL2ZzL2NlcGgvYWRkci5jDQo+IEBAIC0xMzY2LDYgKzEzNjYsMTAgQEAgdm9pZCBj
ZXBoX3Byb2Nlc3NfZm9saW9fYmF0Y2goc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+
ICAJCXJjID0gbW92ZV9kaXJ0eV9mb2xpb19pbl9wYWdlX2FycmF5KG1hcHBpbmcsIHdiYywgY2Vw
aF93YmMsDQo+ICAJCQkJZm9saW8pOw0KPiAgCQlpZiAocmMpIHsNCj4gKwkJCS8qIERpZCB3ZSBq
dXN0IGJlZ2luIGEgbmV3IGNvbnRpZ3VvdXMgb3A/IE5ldmVybWluZCEgKi8NCj4gKwkJCWlmIChj
ZXBoX3diYy0+bGVuID09IDApDQo+ICsJCQkJY2VwaF93YmMtPm51bV9vcHMtLTsNCj4gKw0KPiAg
CQkJZm9saW9fcmVkaXJ0eV9mb3Jfd3JpdGVwYWdlKHdiYywgZm9saW8pOw0KPiAgCQkJZm9saW9f
dW5sb2NrKGZvbGlvKTsNCj4gIAkJCWJyZWFrOw0KDQpXZSBjaGFuZ2UgY2VwaF93YmMtPm51bV9v
cHMsIGNlcGhfd2JjLT5vZmZzZXQsIGFuZCBjZXBoX3diYy0+bGVuIGhlcmU6DQoNCgkJfSBlbHNl
IGlmICghaXNfZm9saW9faW5kZXhfY29udGlndW91cyhjZXBoX3diYywgZm9saW8pKSB7DQoJCQlp
ZiAoaXNfbnVtX29wc190b29fYmlnKGNlcGhfd2JjKSkgew0KCQkJCWZvbGlvX3JlZGlydHlfZm9y
X3dyaXRlcGFnZSh3YmMsIGZvbGlvKTsNCgkJCQlmb2xpb191bmxvY2soZm9saW8pOw0KCQkJCWJy
ZWFrOw0KCQkJfQ0KDQoJCQljZXBoX3diYy0+bnVtX29wcysrOw0KCQkJY2VwaF93YmMtPm9mZnNl
dCA9ICh1NjQpZm9saW9fcG9zKGZvbGlvKTsNCgkJCWNlcGhfd2JjLT5sZW4gPSAwOw0KCQl9DQoN
CkZpcnN0IG9mIGFsbCwgdGVjaG5pY2FsbHkgc3BlYWtpbmcsIG1vdmVfZGlydHlfZm9saW9faW5f
cGFnZV9hcnJheSgpIGNhbiBmYWlsDQpldmVuIGlmIGlzX2ZvbGlvX2luZGV4X2NvbnRpZ3VvdXMo
KSBpcyBwb3NpdGl2ZS4gRG8geW91IG1lYW4gdGhhdCB3ZSBkb24ndCBuZWVkDQp0byBkZWNyZW1l
bnQgdGhlIGNlcGhfd2JjLT5udW1fb3BzIGluIHN1Y2ggY2FzZT8NCg0KU2Vjb25kbHksIGRvIHdl
IG5lZWQgdG8gY29ycmVjdCBjZXBoX3diYy0+b2Zmc2V0Pw0KDQpUaGFua3MsDQpTbGF2YS4NCg==

