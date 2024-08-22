Return-Path: <stable+bounces-69868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BF95AFA4
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA800B23825
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F201581FC;
	Thu, 22 Aug 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="isFFFhht";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cvU1STG3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3651537BF;
	Thu, 22 Aug 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313056; cv=fail; b=JI+B5KpRW9jYx0acFs2hV6CAKLiVNiT/ibEk5hn6elXh/7jynsk7HsJW5PoicrqqYSKFgnWnapfQSWFhFTSAeHv1nL5dbAwJrIOeEyINLbJSn6mPIBlR3oThoEwHtX4jHoo7uJBRVc7JSNqo6dUhCMZoVM/MuCjtPbpv970wiBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313056; c=relaxed/simple;
	bh=4SKIIFldnFxd7DIb193TLwOvwXtkIaT6zHnF0mJ1vHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soO/gRDg3v6OU2+B9XPjkGwU1nAfOMPGNBqO/k5MHTcYLvsu2zbiosumzalPPVknJavX5/ZNMxzqqkag39whlGIQoBxqzdUA+TROwhrkERJ7ZJ+yhmIicryo3CLusDWUnTOn/8jzXL28JbTZxMQ4D9AloWu8lsZtAon+MpV0MSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=isFFFhht; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=cvU1STG3; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M5EsTH014357;
	Thu, 22 Aug 2024 00:50:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=cF+A4jiSOkuUeRAJFwmWxrMBCuSX7gcrcSG5X2hHZE4=; b=isFFFhhtRj+g
	8/rdK562wU5V6O3nNBnZ20VgwjxjMXL+TxLDi4Qp1+eSjXUsBsLuAMZU1uHozZOW
	lAqt1eEgG/DhWzZNsEefU/SU+MDkorPP25huEd5iOR0AUSvhAg9fxbSsGKCxOgsI
	hB77+oXL5Vm7XY5zK1P9Py6tmOkKyidqHo9ykY+9pCocvIMnGN0H5ynVgpchLoTP
	jALi/QhHKRRACCC1dRoElMUoYG6MMmZkfvvSH0waFK/8W7IEAFk3+vKmxLfwh5P/
	Dpw4eKBUlHEd+eDCkv3zeRo3qdoR7RVvXxWblruhGJtJmZitGDOWgJmtQGNNRLfp
	l3jaNQdzRQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010006.outbound.protection.outlook.com [40.93.20.6])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 412rdu3rb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 00:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVZqT6/6RVxkHJR1/33ePuIYM1nq3knRWsh4My3oLxn01X5kbPO35um+HopTQh3kjFZntUF9IA+ti39C40N3Kb/jBo1BzgeZQ5HZFq03fsKRrKkfn69s3yNL5Am1h6D7SyGH+6bv7EMgL7izcXH1fGyl5+HBI4PsT3WhdUxGWaWT1cVlqULu7RdNbH4VVAmlt1nuhrCvNqYrw4eFsCdVi4WVT4oOilDc2JJhpG6sE4iTwaf4L2UjphZ3XXKCdT/vZZiTGHAo6bu14WkVREoh/uNX9bFYx31a2wwlbwQXn2rsqtRFJD3Wv0UCbGRVMdBgd1v5uU4WbRr4wc3qhBuZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF+A4jiSOkuUeRAJFwmWxrMBCuSX7gcrcSG5X2hHZE4=;
 b=Z/svU11Pyl5p19Bhwo8N6qykKRUxKhXPI4Fh034xYuT3rbkK6+/Vb9Cx7jIrGTWHeB5x8C3ZXGjJHWbSvpkVfgM30RpaB2YgdPhIYmBa+ojFSMdiruPgCcJoMbE/RLkReo6R56+2SpFis6SnoR1ArEy07hDLtuMqp29LqSZt5Rfq1b8/8qpvjoOByXZ5ugYSvVCJj1y8RFH5lHFX8Z6sVgO8F1pMl/CITMW/zu61NE1HMyKaVDDIGj+l/OcGxe7hlyIwOr12lNZZkpS9L2cE/orrrRd/fdQm8BOL7x2R2cKtp/xtP/LuYPWqdDZ0aH0Lrld5zDv1y4R2Jds/XRtmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF+A4jiSOkuUeRAJFwmWxrMBCuSX7gcrcSG5X2hHZE4=;
 b=cvU1STG3Z4q702Zx1PsiKmpFQOobat6fTgq4FHsP/ksGO54CcY/JOzDp1wYgW2fqlP/M1W34qgUUrLpmZxi1GmZ8k4B188SPYnRC66v8mvLSXMgQivAS8FudAG3+zmUgdrAZLVMMrG7N5+c4TPwsr8dFtlbZpkbqzbME2NUMAK0=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BN0PR07MB8245.namprd07.prod.outlook.com (2603:10b6:408:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 07:50:36 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 07:50:36 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Peter Chen <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: fix for Link TRB with TC
Thread-Topic: [PATCH] usb: cdnsp: fix for Link TRB with TC
Thread-Index: AQHa85AgOPYdRptGMkiuacc87d76fLIxOXkggABNOACAAAHr4A==
Date: Thu, 22 Aug 2024 07:50:36 +0000
Message-ID:
 <PH7PR07MB953829F4D174350901CDAC0EDD8F2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240821060426.84380-1-pawell@cadence.com>
 <PH7PR07MB953878279F375CCCE6C6F40FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20240821104308.GB652432@nchen-desktop>
In-Reply-To: <20240821104308.GB652432@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTMzYWJhY2EyLTYwNWItMTFlZi1hOGIzLTYwYTVlMjViOTZhM1xhbWUtdGVzdFwzM2FiYWNhNC02MDViLTExZWYtYThiMy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjgyMjgiIHQ9IjEzMzY4Nzg2NjMwNzExNzA1MyIgaD0iS2VlaU5rM1JYZXBIQlMzbnJZanYzOU8wcWVRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BN0PR07MB8245:EE_
x-ms-office365-filtering-correlation-id: 9e2600a5-6451-4c13-ff36-08dcc27f1bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dTzhoYBFuup+9Vo3ujo50nX4VAieOxKVniT8+pANM4apQgSwVVBqqKHK7iNG?=
 =?us-ascii?Q?1td5G49S/9vlYRUVBGlmUl73NSRRZ0/WVWx+xMrzQAbOyyQdn+dw74euNVje?=
 =?us-ascii?Q?Amy4ArOz6fFqZd+k9kjuNQaf4r+kwnNLgz48M3crC8pnU+QfMwyBICyNM/ui?=
 =?us-ascii?Q?1VIUfllz7e/fPWogsvoK4e7Ko0wi8YFhbuu+4dXhuvRJoSXPLfip997Y2jXd?=
 =?us-ascii?Q?nrVrEbfFlVV6Pif7LX2Mm1YQ0PWp/WJ3kZWbDLLSPBqfe/xgLCu1Zi/Xz1QD?=
 =?us-ascii?Q?OH//p5wpHAqd4VgOnGOUGeuXNc7zIiFrtY2HEi8Kkwh54tcR9IQAMjFBC/6o?=
 =?us-ascii?Q?dwtWtdNy2cmT+M0zx0k+m+iS7YkwiYEVtiWwT8E3E13Kp1Oitr8n4nsppA5c?=
 =?us-ascii?Q?/j4qatEX0/J4MryPMz5qYesWNg5YJz0D+17ZPPIkbwWCpMR/D7zqR4GeQmOa?=
 =?us-ascii?Q?YjAX/cjBbwXgxuE/BpFlT8YytkRjype74Pjmx+gRA9jp4kt4sj5ocdfSYelz?=
 =?us-ascii?Q?DlJgsWC2m0QyAfT7LGixbnX+n1x4hTjbqyoTZSUk7NN5CqPY/tuGYkI0ULaG?=
 =?us-ascii?Q?GU6/zmsvMP8xMIvPovRG09lWyNz//ktnZwj2V9A7oxF2AGy8MoPhUwICAzJB?=
 =?us-ascii?Q?xzFwEMhy8jqXfkXmdzNr0gXwAIcjzglC/LFdQ/1ap1lOnOEfNqC1aFTPyn3l?=
 =?us-ascii?Q?xogfrkPC74sghVzk5Au2xMsclHJL0Qbrz5WVGz4dxqTIkMSidGeM2KtcifmR?=
 =?us-ascii?Q?yBuwIkFz3WxwzrRsdKtHKXF679sszmWCYsKzhTh1YCYleZuI962mz+4J10zr?=
 =?us-ascii?Q?V61UpQyB+zkrBaGq/1NlVOHJ0mjonz7rf8ik9P46bK1nATsFLB6JU0+obVEc?=
 =?us-ascii?Q?TjXUUm+Kzk7rNVcAVPg8Gsdu9YbMub2FWFtfWzEStUQ05jn+EWwboGqi00py?=
 =?us-ascii?Q?/oCOj24pIRdboRZuTwaqov8X2B5iKUqhyN3cqDOt1HPO1UBL+tZ8SJN+BPMI?=
 =?us-ascii?Q?CNZdmVzqQRwnwhBN5n5KNr09Qgj+giTWG8OespjqLmGK/icvoJZwu6Au6DlH?=
 =?us-ascii?Q?jaisfeHHg/HBL5nC48DAbLzFmIN6GTTW1Z4yx8jhn6i4IVV9f/EFtwuAP8fi?=
 =?us-ascii?Q?zjmdyag5trcP3uY8rAtVHlDONBnfEVcT/0ZmI+5+2OycLCE0rEIpBVAuCX/m?=
 =?us-ascii?Q?uz8NG7y5owfg3zAkPrTXJoQF929majSnSUh/Tsm8SZweKCOXcvzETSrxCR3x?=
 =?us-ascii?Q?UsrtrmIkv+8DmBp+fPYsFuemqk12AxeOqzwNJiDPRE05MQDUIgtOX/rWk5h7?=
 =?us-ascii?Q?/dPkOFEoEvhZtcxqpmvZKMlU9bx6qN5zfSSLGiFqh2GJ8Z10PALYCUDCfOAu?=
 =?us-ascii?Q?Q8CEHBD6jUQvHxS9Z8GQ0X2n4jQDqTfuDukq/TICaQO9SLG6XA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tHci2rSEsgAeiGQJZGgvTAoq++R2s+/3X8eUs+ukWhCx1zk2DM2746YDlhEu?=
 =?us-ascii?Q?sfbgyP9wQXQJtsPYr0+LCWee3N5doIFgBXQGGn5RTiBaP17Pc7oHLUejQ1mO?=
 =?us-ascii?Q?bz+aA8W4CkhUfF23vLNOZTwd4TlWzrFw3Bcun59ygB2lBUS/9sveaGvHgOZH?=
 =?us-ascii?Q?de1e82BcGUJ4gA+adh+YiDbEDIgdBkgW6qM0AK3KhZ7AZWzzVm2TaO9+m4fB?=
 =?us-ascii?Q?1U+4DmdZ4xwGxosPNpG9U6FyA1uxndPunPY5qHQ2iHue3dNAZDjOWQGCBKyr?=
 =?us-ascii?Q?/OBWelCrO5oQzv+ykp7slK5gOikLs1DDzObNAJwZytlEFecvWkMPZtGqLmVW?=
 =?us-ascii?Q?3bMss5XC0tniYA8r4JVpqE/djGeoFV3iIS8bW/mR7C+FvMScgd39Y5VYca82?=
 =?us-ascii?Q?ICo0y/7PbBgj1OHiG85y1RLcSNo2L9oSjxfTSLGU2grFqUdBRRVl2ohFSjf6?=
 =?us-ascii?Q?T/HT25erDIA1S+DkDd+Cvs2pzHz+l1V6c52tVthtS8+D4DdKgeNDnA8p495q?=
 =?us-ascii?Q?dxFCSIdNdkCQ260rS1C6+71RXPyBue9NeXnljjFddzTCLfctyoka/dhOj8GM?=
 =?us-ascii?Q?jQAoPBzBUNex50EqfG/qKqwKDkFVkcsh2rXopU2e15tZx97KpaxF9mdzx2A5?=
 =?us-ascii?Q?qtxvqOGKyurZoKSSqA7hwGmPP418OQRS7Uo7bjh8a0J2LB3QwkfiDcTMlRx+?=
 =?us-ascii?Q?P+mhVncIhoZL5iCqBkBDxhmhP4CbePzl+zAAZv8hcnB9U9WLn06uGyG0kgu0?=
 =?us-ascii?Q?NUg9+k/O5A43EsRLAoQ+DNV5D294sQDgOxXhT0jwmhRt6gWZf6Zm9OhmI40D?=
 =?us-ascii?Q?3IX3Ilxx96zAG9ekMjuZUqcpxkjsIz7KW03AIr+Nc5Fk9qpYGl7h9QFsxrdQ?=
 =?us-ascii?Q?8G1R2R4vtC/+PigEh/VKmCkNAgG+CKzwCW3gyPMH9LKpEzVJKKBoow19qCAg?=
 =?us-ascii?Q?Ecn6zfo/BPZrvR55I1++67ethdOQz+643ZsAXQJmbil8Azvl/QayI4uTwQJV?=
 =?us-ascii?Q?uV9GkC1oJresMaTju7rVA922ZuQGW3UFtRnhGehJsNeHRY8ht7XWjiwHSNrP?=
 =?us-ascii?Q?oNWsG9Wvra/FombHLUQpS/a9SZ05VQozoyRGnj5jLBP9uWCrwqLgevP6r58G?=
 =?us-ascii?Q?rtwpL4NVMbC70B/xhW8nUDAZsi5RiBcT35C6fhgYg67ibP1Yb4g7OHG4c/RF?=
 =?us-ascii?Q?rI2vm42xha6Oi5jiUqRbxupxMfW9NyExVZNTcmhPHC6CPcpwQym+T94i/FZi?=
 =?us-ascii?Q?4iDuLuUP5/sgFHLubfxFf+adfBrruSUfiFJ3nadGeo8QV/+8V6aIaQ5RYPjC?=
 =?us-ascii?Q?gHp2uVoMnGThnGpldrJq+5LmPijOPD5SG2YH/96jrak64W8/vkfZGluMcbDv?=
 =?us-ascii?Q?ktyB3rZyjHVSvSvilBiA7yi8wkOw81btgFxPIHDYC3XYrC2r033AY/OL5ENu?=
 =?us-ascii?Q?jv1CsoVAq3b5iyWncL4u2KwaQaKrCDxb8hn7xhIHa0dC4rI6dsTkT49OudV4?=
 =?us-ascii?Q?BZqFt2lhHTbCASQBnC1g1lA8r4x7q97ovUPBygR9GK/2FQFATUP1Mwfc85EE?=
 =?us-ascii?Q?s9Wn5q0sv0nVA64L2blCXDUk6APfl6Tbzn2dIJjY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2600a5-6451-4c13-ff36-08dcc27f1bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 07:50:36.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fLWBfQ49bqYgqcM49TDZPV6blZOKlOUHet2mkyz9HXWJSCsD04A8LYZonOj7lz4FOxNAMY4TC680DMYT5fjPxaKn2HgxrAHEv9M1zbKnZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8245
X-Proofpoint-GUID: _jL-lUw18s0g-kVCIHwf1N_-H8QB5xwt
X-Proofpoint-ORIG-GUID: _jL-lUw18s0g-kVCIHwf1N_-H8QB5xwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_03,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=778 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408220057

>On 24-08-21 06:07:42, Pawel Laszczak wrote:
>> Stop Endpoint command on LINK TRB with TC bit set to 1 causes that
>> internal cycle bit can have incorrect state after command complete.
>
>You mean this issue is: the transfer ring is on the LINK TRB when stop end=
point
>command is going to execute?

Yes, but also TC bit must be set in such LINK TRB.

>
>What's the use case we could find this issue?

I was not able to recreate this issue with standard linux and windows drive=
rs.=20

To recreate this issue I used:
1. device with 2 x ACM connected to Windows OS host
2. UartAssist V5.0.10.exe=20
3. Vendor specific ACM driver

Test scenario will open & close port many times during testing.

Host driver should send clear feature (halt) request to device
when application open the acm function port.

Thanks,
Pawel

>
>Peter
>
>> In consequence empty transfer ring can be incorrectly detected when EP
>> is resumed.
>> NOP TRB before LINK TRB avoid such scenario. Stop Endpoint command is
>> then on NOP TRB and internal cycle bit is not changed and have correct
>> value.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: <stable@vger.kernel.org>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
>>  drivers/usb/cdns3/cdnsp-ring.c   | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
>> b/drivers/usb/cdns3/cdnsp-gadget.h
>> index e1b5801fdddf..9a5577a772af 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -811,6 +811,7 @@ struct cdnsp_stream_info {
>>   *        generate Missed Service Error Event.
>>   *        Set skip flag when receive a Missed Service Error Event and
>>   *        process the missed tds on the endpoint ring.
>> + * @wa1_nop_trb: hold pointer to NOP trb.
>>   */
>>  struct cdnsp_ep {
>>  	struct usb_ep endpoint;
>> @@ -838,6 +839,8 @@ struct cdnsp_ep {
>>  #define EP_UNCONFIGURED		BIT(7)
>>
>>  	bool skip;
>> +	union cdnsp_trb	 *wa1_nop_trb;
>> +
>>  };
>>
>>  /**
>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>> b/drivers/usb/cdns3/cdnsp-ring.c index 275a6a2fa671..75724e60653c
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> @@ -1904,6 +1904,23 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device
>*pdev, struct cdnsp_request *preq)
>>  	if (ret)
>>  		return ret;
>>
>> +	/*
>> +	 * workaround 1: STOP EP command on LINK TRB with TC bit set to 1
>> +	 * causes that internal cycle bit can have incorrect state after
>> +	 * command complete. In consequence empty transfer ring can be
>> +	 * incorrectly detected when EP is resumed.
>> +	 * NOP TRB before LINK TRB avoid such scenario. STOP EP command is
>> +	 * then on NOP TRB and internal cycle bit is not changed and have
>> +	 * correct value.
>> +	 */
>> +	if (pep->wa1_nop_trb) {
>> +		field =3D le32_to_cpu(pep->wa1_nop_trb->trans_event.flags);
>> +		field ^=3D TRB_CYCLE;
>> +
>> +		pep->wa1_nop_trb->trans_event.flags =3D cpu_to_le32(field);
>> +		pep->wa1_nop_trb =3D NULL;
>> +	}
>> +
>>  	/*
>>  	 * Don't give the first TRB to the hardware (by toggling the cycle bit=
)
>>  	 * until we've finished creating all the other TRBs. The ring's
>> cycle @@ -1999,6 +2016,17 @@ int cdnsp_queue_bulk_tx(struct
>cdnsp_device *pdev, struct cdnsp_request *preq)
>>  		send_addr =3D addr;
>>  	}
>>
>> +	if (cdnsp_trb_is_link(ring->enqueue + 1)) {
>> +		field =3D TRB_TYPE(TRB_TR_NOOP) | TRB_IOC;
>> +		if (!ring->cycle_state)
>> +			field |=3D TRB_CYCLE;
>> +
>> +		pep->wa1_nop_trb =3D ring->enqueue;
>> +
>> +		cdnsp_queue_trb(pdev, ring, 0, 0x0, 0x0,
>> +				TRB_INTR_TARGET(0), field);
>> +	}
>> +
>>  	cdnsp_check_trb_math(preq, enqd_len);
>>  	ret =3D cdnsp_giveback_first_trb(pdev, pep, preq->request.stream_id,
>>  				       start_cycle, start_trb);
>> --
>> 2.43.0
>>

