Return-Path: <stable+bounces-227870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC4uI1qGwGkKIgQAu9opvQ
	(envelope-from <stable+bounces-227870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:16:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB22EB3B9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B58D30062E4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2514315A;
	Mon, 23 Mar 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="o7zgbhIJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C825339A8;
	Mon, 23 Mar 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774224983; cv=fail; b=bgwt0aS2CPMfb+JKl6k3u3SEWrbleEdX70iMp74axjCuicefT4/J2kS/K8nMskvXYDrW3/fHqaRdFY5iFc1ambCxyfobvZ5BzKnHYYspDi9iOnqG6+Ia+cfhbVTKwdro1gR+JQY5vQ+EUPpUzLqU6AObP7zeaeQ2t8hjbm2/KhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774224983; c=relaxed/simple;
	bh=jybpYuD402nK+hUVCml6mNr0/kozahOTYc67ag+y6Xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2k/ULNFbKhUJV6UV78Rc3g+qFXiLNMvKuxRDNWn6LSW1a14gUjlzHl0I4XHRM+5sLFKSqyFPUT+6TcqU7M/U1kfYJBHjJq6UeUVI6yhOpdBib/AqU6zhLo9nXYsfWaJnP23NTJc4hNsIMGBkOIM8WBq1Z1jdkvXJy8I/BDQ18k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=o7zgbhIJ; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MIq4MX2097332;
	Mon, 23 Mar 2026 00:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=jy
	bpYuD402nK+hUVCml6mNr0/kozahOTYc67ag+y6Xk=; b=o7zgbhIJFVf05NcugN
	CkRGRNj9zKsXhiu/sp6r2jLnH98tIjVPmqYI6HnFP6X4Ip936BIAT4Nx87QC+/wB
	L9nv5R9ZHt+abKl4KiDQrq/YmLa5W0LxqzxDg4fFuhJjB3l09UXnUdXDRuqewtfZ
	o23TTLkIiBvHeahnX/rcjfFy+dAymjDpRBRb7g7yCZ7x4VWC/0ZZ73Wy0hMUcYhn
	DWfgmU50mK1p7Q4XY3HCoViXdTeI5B6IfoSV7dugHL9zpWroR+INBU1LbLATujsL
	lYYHSfqxPdXKTb4S1tnS8WDImp5bHxoyhVSMlviEcxqD2MHX9DDgNasxs+00cJeL
	5qwA==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d285bp3ae-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 00:16:02 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id A91B1801639;
	Mon, 23 Mar 2026 00:16:02 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 22 Mar 2026 12:15:51 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 22 Mar 2026 12:15:51 -1200
Received: from SN1PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 00:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKSXLjtf8GLkeRa4PSwZAkpw/1Ph16gum9JOPMnjHvuAWqNMpLwGroWbQunHNpaju1OS+gBvjEGCxTiMVIMLiH15gigStK6D6aenA/oKlfxLtmhJn3BDRodSGLf+3LCYACbNvd2EVome7R9g2oQ4zOdHzJWOzVupujjJgy8IW5rShv9UwLAQQatfYAIAZ0D7GSC9bv6biy84nryvVxXVcLDJaV6yis39qoD+j6Gx7Q9lUWYSU1dyWmeGVtalrcj1/OT6ufXa77A4AmLpw1VADNnfxgM24E5WjiNKqIuOa1JscSr8NaydWuND/NZvL9uD/yeLfMMdfAkC5R2DEPnHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jybpYuD402nK+hUVCml6mNr0/kozahOTYc67ag+y6Xk=;
 b=LN2pV/xfC6JS2w75wKiyw3GqZQPE+5A0CfqIct/oA0DhgrNNg2/ZcA0u+vVI698EpB+iTzTOYj0yJG/lisDiy8O/vO1ygZ+nnK9K1GnApeoJcPyKTjvkfTIkYPZXlY17riK9zl1i4cvc7Z5r/MPD5xFj7WCvLzGvbpzsGzanz9PbY3zbhvj3qoiS+IvAarDRl/eIuLQKgXctLhSkyjfq9h2laPdIvT3BRhJ6MQl7wcfL45r9ge6lhzl7pAqTF6EWtH1BL9gvD2JzQlvmvDiwhTAFHorwMRucIP/0fFD0QWXL9gabjItk4I20fMapwISgRytwYLjOI46uECBY/mxOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:203::11)
 by CY5PR84MB3100.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 00:15:46 +0000
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6]) by LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6%4]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 00:15:46 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus/ina233) Fix error handling and sign
 extension in shunt voltage read
Thread-Topic: [PATCH v3 1/2] hwmon: (pmbus/ina233) Fix error handling and sign
 extension in shunt voltage read
Thread-Index: AQHct8YyGIr43f5PJUmoqzHiXGlXE7W6npOAgAAAg4CAAKWrAA==
Date: Mon, 23 Mar 2026 00:15:45 +0000
Message-ID: <20260323001528.92392-1-sanman.pradhan@hpe.com>
References: <c7be3ee6-174d-45cd-a9a7-17a7aad8e8cf@roeck-us.net>
In-Reply-To: <c7be3ee6-174d-45cd-a9a7-17a7aad8e8cf@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR84MB3535:EE_|CY5PR84MB3100:EE_
x-ms-office365-filtering-correlation-id: 3ab43bc4-aba2-4e61-9a17-08de88715443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: vrbOYuWd1xEFA/giE4Z2nPTNjKXBIld483XbKxgSk74InC2qBuPL+Fhtl/Y4pBuPYFJPhpnU/RSFYFEK9MTxf8cHgp60YmYPmuTX5qZL6s+DJNUonua70bAiHSCwBJn5gXk47M3B/37RWPHpcpd+vtvqJ+QSWn/md/YAoVVGGDj7cf675ol+nFyUiY2HrM4w+JLBkFEfqICbuA7tfzMyXAe4xA4Y7HvivCaHByLf8nIFgqqT7jIdd8uS3DICFl0eQ5IJmlKetOgtoBlP3E0fJI76k5YO3zv75vLJPHZwAnCj3eeoxded990aZZuL4WvHmcJNo/eJZnttcB0LzWWOk61SrFQq26+y9xUHp9PnlvJm8BZ9xGpi8yq2mlSTQZLaevG4DDP9ahJeApa5AVUrDys3iTx6+QtwrCPpIYE/vFatwmalR7/gGSkr3p3flAyZIhYWmAG/T8uzLDm/+DcQ85PvHoy7dP33xFmKeXp0W5ED/Yqqixo/bIQ141tB97hbmVvsjTKQUgskkmQBsHIjGFYtthaQOpW+fHofmuf0PgVzMjt+ToEVJ2j52Xa1Pp0KJcwkj54dK+v51Ys4T9Mz94+Pa+JjXd2kCww6HYtlJ5QV3DiMfcIHCxKJnoCWKuN+x2j/Y6RNcM324OeaCGRkocpUecvEo20E0ljLkXACfWXNMbD/B1dmJIn1O0nsjw/ya62aPWKJi0Gvb6QgnEqO+zTsFGzAx8k0gRRDwVenFQ3BqH7mKLc0kq+hsVsRwP8+/bWN4MvKgI4ajqgHzXRGKROanXVWvyNVDFp42FanRpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L2h10bsuF79sWBvsbBnBX4iolRNfggBgC5m/Hswnpx8taPHojvNDgPEakf?=
 =?iso-8859-1?Q?3SWadwMbHu9nCs93OAifWIf3N0a3Jd4e8SOEUFgXPQBvzpalOXILPuiX7e?=
 =?iso-8859-1?Q?+3sOBWnKXyAqLV828vl2tg50VNl6fnABnYu71zWztx9RiXM9FpCTgwvROs?=
 =?iso-8859-1?Q?woW/OfYzwcSdLgxa9b0gz8H6SHtIu9K8RxrhGqP9lSLgpyy9iaHg+CRrdN?=
 =?iso-8859-1?Q?tJxTVj4QBJWnrlj3F7gAVm+6/2GeQ3evNWRB/m5R9f0i/CFL/vzyohHbdl?=
 =?iso-8859-1?Q?AX9uRAfgzR/+/qEIyDT5lsxDtC2fbH7e+DZUMTZ4sNAJYAimmLTsG98oDs?=
 =?iso-8859-1?Q?bmFBcXvW/KtZtgJxfVaRzFIK0uW4VK1Ll+2B55JqxTWhmsZ1/rTEowuxV/?=
 =?iso-8859-1?Q?UsAvtp9OQhVpsVO/TqX6RY3j9FD45dl+qb9QLlUIJYo63EGkFJsAE6w5RP?=
 =?iso-8859-1?Q?NvR53BrEZUdBn3B61OZ9iodcyQgO8SGLf74UO/ycNkGt5y1EC67YC20YTM?=
 =?iso-8859-1?Q?JRZSix6HFe5Rqfo4SHTs2ycpy+WScW5gwss8MDYUOQMj6x39RB/kwwWaPK?=
 =?iso-8859-1?Q?kCkiQdCdg7SAVu5WUJqiQqMI98kG2nK9c66JLXpAq+kErx1J/Pg0cnlEaH?=
 =?iso-8859-1?Q?BxdUIWETKcgvym4ryFzVSmXpDyJ7wdB74l97fWjmTzFgFr7hMDFno5eF0e?=
 =?iso-8859-1?Q?xDopuIV1HIIDpkNbVrocXoSEbjBctE4OoK2ez9zsaHgCPmdOfa/w6sDw25?=
 =?iso-8859-1?Q?3fdiJzPiHgvE24Wm0/x1OJBqJofrd44TyYr89kS4951/c2aTPDLMQO4BJL?=
 =?iso-8859-1?Q?5q8a24QdKE60s6nK3lujJkOksiyhostHKoSAzNBv0C2jre124duuclnNMo?=
 =?iso-8859-1?Q?CvNcX85Whyt5i+RP4dpphlr+wdjXtguXYht/ueLJwvr71gwK8smJi4+AN9?=
 =?iso-8859-1?Q?rYRr00+Z9nazFvhqCTLuGxemcG6W+isvIlgcUwfvCPMmSQmmpvuVDuaEFq?=
 =?iso-8859-1?Q?8kV8XYHE0zFFJ+9Ql5RBElDhjg7sq3ZrTEQNV/hxPMeN0i2iLwM+zMRoeA?=
 =?iso-8859-1?Q?8ZhO4nd5P7M66ck0SV/HY/CV0mq+aw8qHJFt90K2TXJdEOGVRUgPKeZtvQ?=
 =?iso-8859-1?Q?ByvG7qLQrdNWzoMr1ErecMi6Tv/MsFP2WLwi572leCYuA3mFJqOyh/vRpn?=
 =?iso-8859-1?Q?8WOQNa4tHBrC0OmHoTZKPVXIyYyEQCh7gnsOJPROnKqTdSVAIQfy2RFTKd?=
 =?iso-8859-1?Q?UGpxMzwjfk0wIjK9yesMsjbIADxWNUDNpZD+ZPLTPgFntweWHCTlflidO5?=
 =?iso-8859-1?Q?oe1MQNSsQ1YHMk3c1hq6HqLoFLiM8hY8nh4wjXTYpYFkL8bZTUr3OL3Ip/?=
 =?iso-8859-1?Q?3gf7Xeu1Ks3tQAOn94h9CzFjtrV3g6dmZmXxGx0kFdRJ4d/0oEs5t+n4Vs?=
 =?iso-8859-1?Q?TPU6U4YcBqOPKYiGE6u9IwQDqHtlBXRULZK0+MMoUneM3PNhj/Qslj7IHR?=
 =?iso-8859-1?Q?VKtacrL2xJqd1mCpD0f+2j+KvSgh1L5bOoBofkArupkrys96SLzXeL4ud4?=
 =?iso-8859-1?Q?8gtMafI/9TZySGj8hwZUjkGLPGSmXMZ4VtwH7E6IfiHFfSAkSi01GtdpNa?=
 =?iso-8859-1?Q?rUJdc/F6HPQbXJ6rKDfD3SJiZt7/XSV6l2bWuFnLpqlWZ+WkaRYARzVMSt?=
 =?iso-8859-1?Q?hFdfnFzUcJdWJnder8o1cqDtLqns+BA7TWHKxomz44ifKs1uZZaDUU4Tg9?=
 =?iso-8859-1?Q?vEp7fD45yrJgLdDYLhNIuDBq2EyhQwLm9gN6YzoO1812AmIM1iO8atH5XP?=
 =?iso-8859-1?Q?839eZKFpeg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g/VPZrqVyDtAPNJNVEnrUHY8FJOI9LqsMWsB13Ed/CQreF6IUr4ROVfwD+IZgGCMGGPeQIabKRumEQX/CbxnCL4XTAaG47IvHyZNS1LdEOLRVFyPNqFu3mZkBIBxYaIvwzG43TcHnXwwVgOIdhBbL9Gj5dEFGjEgjTbqnt2/jW7EIuzWB/YBUYeoSMwkPb+TTC62AO/yfFDC1u9ed/yz5v1iXkOCDxxnuwIHsB/iw34QU4Ta9a2tGk1oivqFH9+EbcX/w53L2OkHvX31H3M9pH16lApNqOKxykKWMDRKl+KAe0LmPVvRpR9RJfiHZ8uKb16kVIRSZ15PtheHtmxW3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab43bc4-aba2-4e61-9a17-08de88715443
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 00:15:45.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRw9JozK0bpeGHEojuIgN+7M+0hvAKtz8uXm/3cZAJWoaikwNwN9oY8cXmVzsq8dOoP2mqqmDzfEJzkWsHgyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR84MB3100
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: UfCHDsmuv3-282hcL6GI0p0b_-Ss52Vc
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=69c08643 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=XwqhR8XQXY4uuT2q-jkA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwMCBTYWx0ZWRfX6fzUFX0PeFa0
 mA/WLs3+l6doMO/q0z/yVxL5fUrty39HKzr2yghJuPCWPUDlu+uNBeQ/YcGByjtK7GeUmxJKFtr
 +cUV9i/DvlTAO/6dsai2zgu9uDzqn8qzPwVjJohNpfCDsw8RODqWwDCcYRecokzqsWT92p+1R0J
 k0ZU/5OIGSxjwBLlZPAHFLUNxnc2pVrF7ucwYm4VHyjHtxoau7dG+jPOtnvqNCC+c3/+HDN1Jit
 jOXdUzbGW7KrccSKfOZq4W73tr62Kek9bcEkWyQ6bmI89F+5IbGAFk5BXGPqFet2w4Kqd8pYQWh
 N139Sot+mPHOgW6xnlxLluyD0q5ZoLmL3J6KO54sJZacEyvW7DWMKqhI1xwTXRpHyp355CTcp6b
 P+0s9/kxh+tBulwrDgKsdf/tIqrt+zlM9/MBGXiBzlzE1pfQfxlWw7pzyDUYTc/eApj7WCdEPI0
 uhkO0izTV1xOrrylM7w==
X-Proofpoint-ORIG-GUID: UfCHDsmuv3-282hcL6GI0p0b_-Ss52Vc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230000
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227870-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DFDB22EB3B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for catching that. That's right, clamping to 0xFFFF =0A=
is the correct approach. Appreciate the fix-up and =0A=
applying the series.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Sanman Pradhan=0A=

