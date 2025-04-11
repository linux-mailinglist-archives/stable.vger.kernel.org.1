Return-Path: <stable+bounces-132218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668A1A85831
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CD54C78E1
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4912989B6;
	Fri, 11 Apr 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LHH5HYuU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cU8sJOx8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3B1EE017;
	Fri, 11 Apr 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364406; cv=fail; b=WkVWeu8EJ7tSxsqOuUnUJhoAvlgewWAnumm69p+J72JqRDD5WXKfLzYvoV/OGC5LMc0syFX7cs6EIKhyQ0ulkWhuyBBJhQlbaPvsCO8n8Zs9sq7lYrz8bbE7+UtHxE4gJg3W0oX+G6X5DyGtBRow6OiGzoVoLrWNMt6XDAMjfmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364406; c=relaxed/simple;
	bh=ifXzVh82ybFbMFOVoMsvz4SqnUuBD/ntXPVxwrZ+a2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6JApOvZlnFUSCaE+ZaDJVyMT1tYMF+pAbDeHeSvLuzP9Yn3wWS1WomjOcbwVYCfpAuyuprbBoy6zkSAJxfNjymyCHwZjd28hUVbbsK/R6ylGIHetLGnnx70IZGspDx77i01RKoA+0DcJb9xxlELXteCa4Bsdat4g/lbzHtJv4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=LHH5HYuU; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=cU8sJOx8; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B8NQKq001987;
	Fri, 11 Apr 2025 02:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=A2zYnSdvUJHowH4cvRHlvYT3yEvq8huV10bhKJmYDyo=; b=LHH5HYuUlo49
	Z+6El89KmhpbIJhpgVUp0xiHTQVJmlVjzGxmhjj7La77V9GSNJK+xvV8mxi3txB2
	AxntVoS2yujJk3yyX7uo3glK/A93zwRF7ucJrB16vjWWQdR+ouYSUpHWQfoRTvQ0
	42a0EgUTHdwE9W6J/yHASDum+4XnWw1x0SQqNoo8Efx4bp2yKT1UWk3ruHWsxz7Y
	YeJr6qAgJrPx1LxQTxrhWANDqdi+oKaQSErvlhV73DauEGsAl+FCK9Zk403AJKfE
	bFSPt3fU1ANi6PGz9yBZvXYyCja+a1E73OmlzTzLQyDJnyPQWL91OG655ASeOaqh
	B69u5aT/aw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2y6e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 02:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNcWp7btITotqq413+VP4rCIjUsVJnEi0eXEl//swNNjC/LY6QfptpYWZg7B6G/BW17CygWN2udu3eBlVtebfi8Dmc8Lp+e3ZHolvAzQWnEVcitKw+Ufr6sm0DoufhYFfuKaiTNLCD9xSy85gPg90hZ63GUF6JopyUy8NJXZzN23rB4h+CQvV5R8RM+mPGNjhMQAAM3AgHyB/a1Hb31wr6izQME9k0XPTlx0N2DK3Gqb9JP6AZUbnSW955abbeCq6g3xrHvbhug1796j44YydU4ki+5LxZfWuJFoYoKazc8X8gamLQaUZwC2uScngDpzvMGXj/vdIDiFvlM/KEN+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2zYnSdvUJHowH4cvRHlvYT3yEvq8huV10bhKJmYDyo=;
 b=NDWjvFnRob+/qRf3LpRE/z+1S7SgQRxVbDiJ+5s/uLU99DknaR6lHXK5bED21NTnMsGo+JIT/M8XHXrz8wVXplXfzRDsa3gHrzPfpn31gpC21SAoT5VsK5ws4O80qoiWopfReC7YEt6DLwRe2+3q3PBtialcOC8BmkDlRWGRBqwg1GntEstrWWFtuhg12PU4zxClW7OA9aeihiOXeiG9rMn6L4EyNas6Yb6wKf8M4qox2BISOaZqnE4PBN8mscgJR3IXIP8qOwP98Vy2he1F+u6BU1BSt7UcYluiiI/3o2qOTN+cEDdFWNCoLzRZd2UR6eD2Qqf+p3o0gv4pgSq00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2zYnSdvUJHowH4cvRHlvYT3yEvq8huV10bhKJmYDyo=;
 b=cU8sJOx8ue06q6f5RucHcuWn6ESCLdyoVO5BbPrjSYlEzF3nppTQ611fa9OyEjHceV9iwwd0ylzw0x57vW9PdYNXZh/5qcMs9V84nVtLux2Ag3x0Fd1qt+JTYMpYaR0zIREa+hSChKavcROsU+FhY4rxOtQuhTCORrMsD9htlmw=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ0PR07MB7552.namprd07.prod.outlook.com (2603:10b6:a03:278::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 09:39:42 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 09:39:42 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Index: AQHbqemXS6B5IuQjiUyJckm8ZGIk1bOcgYzQgAAf8gCAAZTOMA==
Date: Fri, 11 Apr 2025 09:39:42 +0000
Message-ID:
 <PH7PR07MB9538E0DE72D3A4C0B8A6DABFDDB62@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250410072333.2100511-1-pawell@cadence.com>
 <PH7PR07MB9538959C61B32EBCA33D1909DDB72@PH7PR07MB9538.namprd07.prod.outlook.com>
 <2025041050-condition-stout-8168@gregkh>
In-Reply-To: <2025041050-condition-stout-8168@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ0PR07MB7552:EE_
x-ms-office365-filtering-correlation-id: dfa89f1b-3201-42f2-382d-08dd78dcc954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xYlBK/Ktj4hkgLwsL034kuh+ApAPSXnjTm+lxZ6rqe2ipjv23wJEwMZpk3wY?=
 =?us-ascii?Q?WKVxoro3WlDyA8rD4yO/vgNkU1+EA4ZVImOSLPKYA823e5wtc3mdQGQ46vX3?=
 =?us-ascii?Q?AUqBugElDbeiHCGb7OxhlaErr7VRWB6gTgcF016vYAw7u1EFfrV5MMKZWS5q?=
 =?us-ascii?Q?8xdO5VTjpud11KReAgUuWtcUb0fEMrootR2TbSnDDZuZtU85EoN5Gxas7Pr5?=
 =?us-ascii?Q?emmdqw8QJLSkSiqtIgvW/d7ScmJhMOkCGAZvXo+7gYDAC/VeLWOD8Z4QsIBR?=
 =?us-ascii?Q?b+ZHnKehZtKvu3KAz1EgksBE4/M6GVNiMg4ro9HpRtGWb7hB9vdV8AkT1gnl?=
 =?us-ascii?Q?BGBzHSDtrTjjZpNYGFqeqDnxyArU259U0I3Qu5KVAoZLfcDIXYobUv/i+8wE?=
 =?us-ascii?Q?P6+S1bZ+VzHTu6jxcGFFq6TE5bgDNSfPH8YL09L3BvZkQHqYrFxunHH4LRua?=
 =?us-ascii?Q?FRUmWHmv6H6hOYNroj+7lpcxE/ghb/iUKvzIDQjQAUI2YW0v8acfXSuKM+DJ?=
 =?us-ascii?Q?fE0BsepUdzH4+SBC+fZ5gzPuUmMa8lxviddRxMDUSg3OM0kFBSN+ZS8P96CZ?=
 =?us-ascii?Q?itrwJeLGLevjMSNMTHqZXen6YyePEzlHqX/lNBIiTdh2SmlWwH/2WKg52h4i?=
 =?us-ascii?Q?dBXBmIuXUgyX4wPY36yX1VicgImZJkGiL5WNeLJgtR7bYvdQlZdmBZUmnFg6?=
 =?us-ascii?Q?BsXQZ91qQNmNCB14sx8huXeQpm/eqa5sqf+6aWGqnWCziVhJoBhwD8cWwcfR?=
 =?us-ascii?Q?x4Uh9f9wYQQfw/FRKyOqNm0A9dvOOsoTfhMRhJP2L9eBjBqJfO5XI640QTzG?=
 =?us-ascii?Q?KbikzEihtTHKNAKeW2MTSN3dQyvthelTApC7MYDOcNl9tBen+fNpDxY2pS6H?=
 =?us-ascii?Q?tCJWSnqCIFHptd0JrC2MGS9CiHlgxfbgkDAwfbEMqMQCxFC+17oGIRmVzejG?=
 =?us-ascii?Q?o/C7vFt8ns0mDS1a6Pk0375zzk0gGgtPeqva2BUQkl9uTuBGTHcG40oH7OGs?=
 =?us-ascii?Q?FlCkG4IF+lEgTwN23YUgc8hZ4+jxVz/vq1dUvplT2t5UHP2Ucfa8OQ/3lyqq?=
 =?us-ascii?Q?1l5/k2I4FW+WVlbmcqPuCVOJ4mMIffzaPZOPxb0MwenWC1QdRni8uLruA+Ck?=
 =?us-ascii?Q?FkndHSaCuvA6vePC08aAgyoZX3y3oCp4aQqlYKFNIl25e+/qAH7TGSLk1TQ6?=
 =?us-ascii?Q?yPYPhD0WXg4iG6Vvz8WMv/x3i7PGxN+asLoGWx3y5BhptRUbl3mHnwf47p3V?=
 =?us-ascii?Q?HifVSsHJvNyZjDH1NC+Fqp35MP/HsryAPxjnhkmR4b8Cpt/ZomC/ebZKAcvH?=
 =?us-ascii?Q?jwP+M3EqOyMdr2Fg7ED9dCnYnXyYFl6IReKD9v+/7pwmkiXmNRFs2klW1iai?=
 =?us-ascii?Q?qyBXtBQuXY1xzw5pu/Uew31LDkVmXRCPmhUPlRibCGaO+H5AdUlNOAJFbGcf?=
 =?us-ascii?Q?bfOfgXcagQDCVnswPd8czeepXNbca6gj3URyCDr5U8jJ3yEzmeTdCVp+MFET?=
 =?us-ascii?Q?ka2763Nfvza2Quk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YHJX+XE1vlCtt/UcMlxVC9ISDKvscdjNRWEjPqyjibvpXw0KGLnDB6o+BC9m?=
 =?us-ascii?Q?jnWiplHesw9o/j8uddr6taH0p3v5lleLHbxmIvnPKUx/DJO7Li62l8SJ3HZK?=
 =?us-ascii?Q?RXvbbiw3FW4L3c+mSFgiZzVRpXzDyA5h3I48OP9pNorekt+gNgmnT3ypdUMe?=
 =?us-ascii?Q?8KiKyb9A8fKoKR6IuvUAbDTbXB+P/DOYB86y9f6wLllz6rdYpEqRIIVCp+Xw?=
 =?us-ascii?Q?n6MolqPbAOO7dSd/LmfjqkYYC75MpIcLsjJ+lHw7O3a7NkwIZ3tSAM72YDDy?=
 =?us-ascii?Q?4g8grEvyRnv55/k+J5elTZ4Q6kPIYc6HN9H32MmDmG1Qe/zojZycCLWdm35v?=
 =?us-ascii?Q?EeVo1UxbloikK0l3tvGEAwyCqm+WvPARbk9B/8Mola3TMAdcA9is8jzS3XDd?=
 =?us-ascii?Q?aVY+VRpKtmi809CIkelN0dErhRcSQ0g1N6txg6oDRDGvZHvZ1uSJfSns0AAW?=
 =?us-ascii?Q?UzlwxFCTbmq5/yEI55znbjJqPj9wmQtszVqUmNab0sVmXD1KXvz7cioHccK6?=
 =?us-ascii?Q?UVvsZAuJZYzqPOzv2tdmSbzjBWRIRSb3E40wa9R8vf9ysZWmZP+TGlbv0AbB?=
 =?us-ascii?Q?mlkhdyKAV176q3k8wGjxNRebjC9ev6DGUs8R65sdzwQbRSTWP1GkygT5HmbV?=
 =?us-ascii?Q?yGPgNGRLCpKSds1lZzA5c/Fa2Lr5k+OaSR/BCgNK2TRZNVspy4A2byGDLekY?=
 =?us-ascii?Q?UcjMvbqpt0V3MYRoLxHjR3pvtfHugW+4/CRv4hyrDW3dl8HRN0ClIukbuUGd?=
 =?us-ascii?Q?Tw4oDBW1/icwuS+4PK6si+2F6RxUaW+/YHlsl3orpiyrY0PYEH33goNsOH83?=
 =?us-ascii?Q?rAOj6YC8zKDR8hFBYLRYySlhyMH+AJvDbD2o7WETxl1CmWdcYAp4T7yyEj9O?=
 =?us-ascii?Q?P3RADXUsld3UnlZ9LWqsXItb9ysJi8KpKPfEll5kEbvP00yBcJYh2e2ocOCE?=
 =?us-ascii?Q?NfU9aDB0vyboW++02jqR+803+JUh/HoUZmHqERR8HBHFSlsONiJ2Ums8xdZq?=
 =?us-ascii?Q?0O8gnqaiw4ZrCinwZ0o0ybP5lZ9/X8O6yjPLMbrB4QhBJ7B3BZj23Uk3FglX?=
 =?us-ascii?Q?sc+OMBmBmO8hDGtKMRlS8fCmkNpbF4LV4LkEhToRRctcOcof4jhbpKDN/mWL?=
 =?us-ascii?Q?62tT+yr6I8avGjCBp2kQtAXFEiD8Y4aQhcF6s4oKV5HAI/ovCzPPnsEHM4tc?=
 =?us-ascii?Q?1v+fWfzEEa0qgsGw6eWBE10CM6raEd3Vu/ct0bs4mG7IkPMg8ZuxLUksmMAK?=
 =?us-ascii?Q?Hx3mLYFiXzWXNURYpCzI4V/Rlv1z8A0lwmDI0QbRJ151M+lA5hN4eQjUr8n5?=
 =?us-ascii?Q?cODqkpP0yRYN4kCX2cI6aOB1VVXRmwG4jxw61x2havj60vfgIYiUVohR2DF1?=
 =?us-ascii?Q?AvoP68aPQ9CUmPKOlKFFuIjcUJ9y998RD0+N/h661HhzWJYfqaM0wDgVewZ9?=
 =?us-ascii?Q?4hF4quLJHuCViIsbJ8VMsd9P8ycPeKrZCPb33ijVDuimaGSgRKs5kPDEtz8y?=
 =?us-ascii?Q?xAtQ1fJ/Jtqetwq15c8fw1AZ2BDX41QEKLVVHFeajDwNJ6ZNazT75EIqDaR9?=
 =?us-ascii?Q?G08z/+OZiBy9vIq+QmeMct7gjM91b1ZETkT2TCMd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa89f1b-3201-42f2-382d-08dd78dcc954
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 09:39:42.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hM35kajUjntxD0QXi8u4m88+cbC0xKgUfCe7MRBhnotiFGzIuJX2IEK3KSiT1kzPBhNX2Fai8fdVFrTEtYFzvWS4GBvJf5yJWIRnXJ8s6V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7552
X-Proofpoint-ORIG-GUID: 853_MZhzXrP_Fs2ApGju0SpjcSsTq8Hp
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f8e364 cx=c_pps a=2TzYObwzRp/N0knVItohZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=_yvrbvyXin3ZIJHglYsA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: 853_MZhzXrP_Fs2ApGju0SpjcSsTq8Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=990 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110060

>
>
>On Thu, Apr 10, 2025 at 07:34:16AM +0000, Pawel Laszczak wrote:
>> Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1
>
>Why is the subject line duplicated here?  Can you fix up your git send-ema=
il
>process to not do that?
>
>> In very rare cases after resuming controller from L1 to L0 it reads
>> registers before the clock has been enabled and as the result driver
>> reads incorrect value.
>> To fix this issue driver increases APB timeout value.
>>
>> Probably this issue occurs only on Cadence platform but fix should
>> have no impact for other existing platforms.
>
>If this is the case, shouldn't you just handle this for Cadence-specific h=
ardware
>and add the check for that to this change?

This fix will not have negative impact for other platforms, but I'm not sur=
e
whether other platforms are free from this issue.=20
It is very hard to recreate and debug this issue.

Thanks,
Pawel
>
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.c | 22 ++++++++++++++++++++++
>> drivers/usb/cdns3/cdnsp-gadget.h |  4 ++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> b/drivers/usb/cdns3/cdnsp-gadget.c
>> index 87f310841735..b12581b94567 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -139,6 +139,21 @@ static void cdnsp_clear_port_change_bit(struct
>cdnsp_device *pdev,
>>  	       (portsc & PORT_CHANGE_BITS), port_regs);  }
>>
>> +static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev) {
>> +	__le32 __iomem *reg;
>> +	void __iomem *base;
>> +	u32 offset =3D 0;
>> +	u32 val;
>> +
>> +	base =3D &pdev->cap_regs->hc_capbase;
>> +	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
>> +	reg =3D base + offset + REG_CHICKEN_BITS_3_OFFSET;
>> +
>> +	val  =3D le32_to_cpu(readl(reg));
>> +	writel(cpu_to_le32(CHICKEN_APB_TIMEOUT_SET(val)), reg);
>
>Do you need to do a read to ensure that the write is flushed to the device=
 before
>continuing?
>
>> +}
>> +
>>  static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32
>> bit)  {
>>  	__le32 __iomem *reg;
>> @@ -1798,6 +1813,13 @@ static int cdnsp_gen_setup(struct cdnsp_device
>*pdev)
>>  	pdev->hci_version =3D HC_VERSION(pdev->hcc_params);
>>  	pdev->hcc_params =3D readl(&pdev->cap_regs->hcc_params);
>>
>> +	/* In very rare cases after resuming controller from L1 to L0 it reads
>> +	 * registers before the clock has been enabled and as the result drive=
r
>> +	 * reads incorrect value.
>> +	 * To fix this issue driver increases APB timeout value.
>> +	 */
>
>Nit, please use the "normal" kernel comment style.
>
>thanks,
>
>greg k-h

