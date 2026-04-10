Return-Path: <stable+bounces-235526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELsJKypE2GnfaggAu9opvQ
	(envelope-from <stable+bounces-235526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:28:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 318203D0CB3
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004263024133
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18627FB3A;
	Fri, 10 Apr 2026 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Y3UhNfPc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E7279DC8;
	Fri, 10 Apr 2026 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780868; cv=fail; b=pGjRwTCHlu/9FSUmihMnZBAyWvCxq+8JdK6k0wbxNdN0cvCezqM2rvZt+JnXKlg2Hqp/8HfVuiH8AwoFxN6cmgS91y69n8b2DdPqUC0v1P936xNgd68wSSKiUIxRqzl7gi6KdFwuQzoQCS42zWLIkh1tHxVHhcTi+p/14bdxbHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780868; c=relaxed/simple;
	bh=d2NWQ5CN9NUla+F2Zr75qVV+yXqh+KkAXnSpf2Ii6zg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DV3wo4p9SDKP21WG1hYMsHvjyb57NF6ixXsYrVr6HheaRPK5Tu67vZ6X0DZuiFAKpYygulVTCUah/yZ41WekPs74fhgMhuiBnKbtSCDA2tmx3nZ3HB3e2FfNc9Jf63jZSXKpjhdsk8OSYk9XC3XbRcvwdVf3QsJbqRG7bf8W40A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Y3UhNfPc; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NDrfw3116293;
	Fri, 10 Apr 2026 00:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=2OzLI1zrGEacBZlQLsRjgM6A
	9EshFDVX42mR0/h+EVU=; b=Y3UhNfPckdtdpuOjsk5zHvfP/onFS+I1bt14q+I2
	WE0moMUmHCRJo24yom72JLXqDHBBJ5P2pubCmnk1v3FDBaWSNxq757lCQCB2DFc0
	CA6VAfWqmjLFrPzo+9g2/BppSE6AaZHrH7Xi8dZstOwoMIMcLsd9EinCnJoCWrWo
	HLmTFSVNCKexgnzWNAzJ8CLEUIAqAJ5o1blnDcFuxU0p/cdD0pHARYmaDPxlqngt
	sfnsM6a/TVHgfKkn3HxPzMcrrune9AOvXX4S94a07rPJPN/FgOsKXDjWxM+rZCWJ
	8fAwLzHBeP05Dn8kkkyJ6Ue8P3fjnyYjvq0vwNx3JNCkRQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dejkh2j2n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 00:27:31 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 656EF801AC7;
	Fri, 10 Apr 2026 00:27:30 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:26:22 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:26:22 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 9 Apr 2026 12:26:22 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 12:26:21 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUS+OiGomNE1C5Pu8Hq4jCyHxPUfeig3SgNdJQCgLJ4x5FZXauaFfn2jnHRYl47OZvoiNEnOH/VEZ+WgeTcVFzRfRFJvHcM/UyoGbG5t64E03ACSMG05YuFIlu2NVw0i4S2gjcPjGyfhJCeGzNJ7muevNmEk3rSYQpsOxVeWzf1hLoz08oR/NGQfxS4sajF0+pmR59pfYEouzM8NH+u/ZFI0Im+jhr6CtW6VpYl42uBJk+FcI/XYEXF3qLvum/m8z2ZpUL61pzzw6wTCSHGa7d6wWBtlwPITo2pbXdxXWQq+GHQqFxf6AqmctrveYun1U9Nga5qH7QD3ESXna7xnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OzLI1zrGEacBZlQLsRjgM6A9EshFDVX42mR0/h+EVU=;
 b=bs+AbK/tOIrPciCbIriPNFpBQ5/v/jMr0hmewU8aK56B0TnUwIVeCkBIqUNBTcQ8A7gov08NlWsYtElS3POPHCMUQBliwXPz6S9853sFueTkl3in8nM1KtdkZJMaUmYzN01vVx7S1X5rHqiVERWXRJo3s3jh+FPM7s0RdrmEw+zOp/qvTMTbMimwxtWN3tkPAp0MZRsM0cgEzoD7tmCmQayVy45oSmA0Fuz2RqpSDBtjjkslkiR+oByH8Kz2RYe7P0PtuA/oZbpGltzFCk05Uov5KxK/fS8+kTzpEarsDUoZf/fT2LDno3O/C2mWTwR7ct1JamQ8iJ9BMC64IGcCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 00:26:19 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 00:26:19 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "mail@carsten-spiess.de"
	<mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v4] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Topic: [PATCH v4] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Index: AQHcyICm7WQDGHhbY0mjSs5cx++L8Q==
Date: Fri, 10 Apr 2026 00:26:19 +0000
Message-ID: <20260410002613.424557-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1706:EE_
x-ms-office365-filtering-correlation-id: 2bb2cddc-1d69-45af-321d-08de9697c931
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: k6cfJMOAyY9DK/CG4yImma9PWmITkKjNpGd0enFx4m3o77FXN52S5KP7PgZBgHCqpz18yk0s3EzZBkoTqWLt+gQP64IQlSgRyEsQyZRKpmcpEhrubr+ASGmvlaQpgVoLogm/IjY8GClvLAd+xRtPDXi6HiNAr+VgZyRRMbIFxuzKP1GYhSAETD1sJKxq47lhKDHs9Sq0UmC5hJXS2M+jyhCRpzjlr6HHn4tyjLFwwsrMzXUY6emGbDI7A5NryWaQUQBC2KfhKoUqfuNJqDGMRxltdyJqMJSax6cz1eR8kO+yFffDzteMZmqTUXiYv9GUpAQyVyS0c5QRWjG872KAlVeBb7WqVIN08EbgrZ00lIe0ey0GwZrMLRStT04cQT8E5RD6L+j9ld6q+HwYf5CdS5AL2m35lcNYHh/y13oUZR+Djfk4uir4V7fAvdt7+cN66Hl5MvG8h0fC8XFya6T8rXeUJGCXrw2OiLB5wBqhPXf0YJBdFSis4HCJkUJeFO7PP0kl1sSXs4dJXWqsRD5nbN20jDI6xDZ7gESIlTfyRTsFmg2bWfMXvd534ixpsYExc93C9saekJpBhVNAjs4sHOmXgurkU9vHfAmto8c4oEjSisUPnhbmbDQK52G1ChoC9kWGFklN/eQ8sBw5w2Dm8kl3ggwfYgZ2Y9WzOTQ7A+FAUChSaD5CW6P9vFRw/FqCKLxfVEDQo58bcJt9njCBrdTJTCNqloAnvHa8ccIF6fQv7QbTgjTc5TweyaZTQcMiAg1qZkxFmkaIJxHEO6PjvzlrmwLC17+cRtiXWtV1K5w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F2FLZu+hEs9b2L/GcJlPsk9VuoRCaF8mEBfu0AtfFW8crxImp4EmfSyqjz?=
 =?iso-8859-1?Q?XBc4rxmY6gGa7G87dpFZh9A8dAnKjHKTJiTZBb1M8h4OnEtQ9U8dPoNz3V?=
 =?iso-8859-1?Q?4yB6LMcgVZZPKq82DxpN3VXrGMH6aSvOZrEyDbO+PHgPsBqyJgawbGBVpW?=
 =?iso-8859-1?Q?PlLs/MxoL2YBDeVQL3U6uC2ePxMEVMwZDTDqY+Ho4OhBv8mE4Mao5KnCQA?=
 =?iso-8859-1?Q?jlOmMH+OsoBLHGE9OxfJSmHGg/sq4utVDy1of4wiasY7sDk9L08MjuLTRe?=
 =?iso-8859-1?Q?6FUTE5x3doH7qdpZFA7SJ8XpigkuyjVbRThbcZCZ/BggGp/7QPkthuJCUl?=
 =?iso-8859-1?Q?IMLU49leq45tc1fE/oGwCM/DZQnZlkvFf5gjNvEJAMmchT29Q7JFNyZeB0?=
 =?iso-8859-1?Q?WPvn+qE1+8yuKrGN5V4v0Ks9+QVGwWPZJM7u7UAkI8HEfrJmb2bPPIwKW3?=
 =?iso-8859-1?Q?ZjVxRoeoUdKdrr+xBp7asHTUPXheqaioZC0uGp8r3GAlVkFgG3hcf2q2Bf?=
 =?iso-8859-1?Q?gZsVVFuMU3wO4WSIwQCA5C+VkexKKRqpfkU+BNFYAx4JaseoGt53WbQ0jN?=
 =?iso-8859-1?Q?AbasI1+h34oO0sdOiV72xRkNVcCD0zeSESUO2KIOPrMCqvzHPHtLzgOYax?=
 =?iso-8859-1?Q?7616hZRGPwUh9LHmirIQEtUXzHsASBHSkWawJn8x15dIov9GK6BGmn6ei9?=
 =?iso-8859-1?Q?w/ZXH6s+fTuMzW9kWSDKv/fG4PNHpCXPK8f4GugWkyATdbKUfOahV4SZN1?=
 =?iso-8859-1?Q?9FdS6Uq6YLVRLxFAdrPhCorfNssuiRRl9PGN6VQKX54G53OrNF33KBagxV?=
 =?iso-8859-1?Q?PVI/nqe1YkFQFi4/8evLbwMyHV/V7EGpNYZa8G8bIhm1RaJ5XmtQJE88S7?=
 =?iso-8859-1?Q?piqG68Z3oIlOzwtxzxzTvM6syp/uhSVkiB5EbhWyaYrFROCZJ8g8Bzak1g?=
 =?iso-8859-1?Q?+7kVDMSXyd5pAc6lFfdwrcgIgRJsP6TFSzWRs+hFKpdIUl8T8mhPCKu5MK?=
 =?iso-8859-1?Q?lCFl2dd1FBw45fN3XxI3cvv4xj9KVb9LS91q7JqRZeHJH9ESANY6OIUeSL?=
 =?iso-8859-1?Q?mUXjKSgLFD9I2rGqCgKPO5hqnVQZGi/NcFuOIC9KtxxhbRpOMZWnT8IuPw?=
 =?iso-8859-1?Q?E4DtRzRBIHCjpS5/qQ2nNeIChJQqFNRt1g06fg+Qd8gACspModEdoVePHI?=
 =?iso-8859-1?Q?Dc2fWL0lHh+79YvDTEB5HqPGaOo5VhmLmXwSN5gyK4ZQdSrIiqElqhVNUE?=
 =?iso-8859-1?Q?5q6W5qNl1qsJjqxEBfxAz9FGtXtRWeEosrgr5NCEzMj75x9+X7bZkc5pmS?=
 =?iso-8859-1?Q?lNQtaTQ/TWPfZ4ZwQQtMoazUWRjMolVkOS4BSlnUl1i4qIxOHuep3ZiXDy?=
 =?iso-8859-1?Q?QKLgV9sEMgVynulsW5IaEkqusuPCoq8u02ktOCGedqkdSsGRQJJhp2tQa9?=
 =?iso-8859-1?Q?hCzIJi+OXJJOtDTMSC3X7DjB6wzz48xVVxEQAo6I4ewCv7fSPOBPuxbOXl?=
 =?iso-8859-1?Q?P5UmVW3t6+nwbLh2YtRdowTaChAQZ2WxVUBWZjMgua6cSHbMUBnJHNnqJ9?=
 =?iso-8859-1?Q?bWEjSUdFMsng3ACRSFhgLFeoIe9UqdwdG3i1VktPfwVgnMAuANhxYKJhOS?=
 =?iso-8859-1?Q?aYEu9smYn7BLGxFQrGYmXjJpvvDQwIcS2QOkr++LVUAztgyEmaa3b+xFaR?=
 =?iso-8859-1?Q?fbkRV/YjoaTnIYarGA8tE/x2NjENIY60AMvP6dL0c2EWSAPpnQYlO6fteS?=
 =?iso-8859-1?Q?mlXCDvdIFRV9ej5sZxjRcn6CWwBfDwUOfmM6Fxm9RJGLcSEEzsEv18LxYE?=
 =?iso-8859-1?Q?Nb2ozAnNLQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T1azL60NRw+jsMvDKXQJf7UxUhORzHQ1GSRv/M3O9naCVJN/SQwP8O/K9SucZoc+n8lzCOg1y7Q5TT7E6gwcVmrTuDF8KIb8T+gki07EUzBBhzxes3wOhEAuKfLK4Z2C0i/fDDvo/jrxqRdirtU6L6KVObqPad3pL48GbemTbBvrIiRJtZ96GoItq/FotXeLmZENE0/lKRU+JaEtFZ6pSvI7pq/8PHBFOxQN8XHgcOgJP186gBNzHACyrM8diVVdDegyQmA7BfrFpnlMkx/T+cKuBl4OCfR1ah62AYk4+smThZRdemEBYhiY3ztPM/7R/cwZ9kjM8RMHjJMTLUvwOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb2cddc-1d69-45af-321d-08de9697c931
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 00:26:19.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8CO0zaU3m+pV8JskC6dtScKYSsfzzhQXXV4QcwXKvcayppMQKqhrfc/qS4A6GH2xfUWN4LN18J5dXQbB/PhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1706
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=d53FDxjE c=1 sm=1 tr=0 ts=69d843f3 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=X0MvGafI_ScwdR0_kv0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: CzGIP74tla7kI3TGMx9sPna9aGLfofbl
X-Proofpoint-GUID: CzGIP74tla7kI3TGMx9sPna9aGLfofbl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAwMiBTYWx0ZWRfX1ELHrVLkupGJ
 iWG+csT04nlHaLJqmdUDBZr0sxRmshe2hOFz6DzrMlcUHf9GQu3c99SYisjM7KW8ZOLbDXEkcDO
 emoB+/oynToWZzXiq8DXJIq3MI+XHvfS5VoHbZja5sapIhfR4406qlZ8kVfY4gi/6BAggP1MqG+
 qP0PgzRBQQp04wb2Ac+nTSDXFzJkvWpxlyYBOfojTSPv18IYmUOOficXdjy1Ux1MvRdpaXMhdZx
 /zBTFzow0LgfHJfv+0xVnyxiM17vQtJRSTHAVosZ1D+9Eth4H3UhSkvU9WRh1LNoDksTnhV9oVz
 PMvi41Svp2nGHKBXv8aYxjPqgJhtdvQ7ex9wcsNqBVnrnndz0epvyVY5qnXj+zTld/a1SEqd+dB
 Q2CuItYFemLhlGE9iG5+6SRhyUSVpodyUBfQ4NqbrnsyJ95vZKx/hrQTvLGM2NI3q0/FPeQEsyz
 EQYpyW6ZpEPotidfC2g==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100002
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235526-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 318203D0CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
isl28022_read_power() computes:=0A=
=0A=
  *val =3D ((51200000L * ((long)data->gain)) /=0A=
          (long)data->shunt) * (long)regval;=0A=
=0A=
On 32-bit platforms, 'long' is 32 bits. With gain=3D8 and shunt=3D10000=0A=
(the default configuration):=0A=
=0A=
  (51200000 * 8) / 10000 =3D 40960=0A=
  40960 * 65535 =3D 2,684,313,600=0A=
=0A=
This exceeds LONG_MAX (2,147,483,647), resulting in signed integer=0A=
overflow.=0A=
=0A=
Additionally, dividing before multiplying by regval loses precision=0A=
unnecessarily.=0A=
=0A=
Use u64 arithmetic with div_u64() and multiply before dividing to=0A=
retain precision. The intermediate product cannot overflow u64=0A=
(worst case: 51200000 * 8 * 65535 =3D 26843136000000). Power is=0A=
inherently non-negative, so unsigned types are the natural fit.=0A=
Cap the result to LONG_MAX before returning it through the hwmon=0A=
callback.=0A=
=0A=
Fixes: 39671a14df4f2 ("hwmon: (isl28022) new driver for ISL28022 power moni=
tor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v4:=0A=
 - Submit as standalone patch, no code changes=0A=
v3:=0A=
 - Use min()/div_u64() one-liner instead of clamp_val() + tmp=0A=
   variable, per review feedback=0A=
 - Add overflow justification to commit message=0A=
v2:=0A=
 - Switch from s64/div_s64() to u64/div_u64() since power is=0A=
   inherently non-negative=0A=
=0A=
 drivers/hwmon/isl28022.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c=0A=
index c2e559dde63f..c5a34ceedcdb 100644=0A=
--- a/drivers/hwmon/isl28022.c=0A=
+++ b/drivers/hwmon/isl28022.c=0A=
@@ -9,6 +9,7 @@=0A=
 #include <linux/err.h>=0A=
 #include <linux/hwmon.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/math64.h>=0A=
 #include <linux/module.h>=0A=
 #include <linux/regmap.h>=0A=
 =0A=
@@ -185,8 +186,8 @@ static int isl28022_read_power(struct device *dev, u32 =
attr, long *val)=0A=
 				  ISL28022_REG_POWER, &regval);=0A=
 		if (err < 0)=0A=
 			return err;=0A=
-		*val =3D ((51200000L * ((long)data->gain)) /=0A=
-			(long)data->shunt) * (long)regval;=0A=
+		*val =3D min(div_u64(51200000ULL * data->gain * regval,=0A=
+				   data->shunt), LONG_MAX);=0A=
 		break;=0A=
 	default:=0A=
 		return -EOPNOTSUPP;=0A=
-- =0A=
2.34.1=0A=
=0A=

