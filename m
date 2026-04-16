Return-Path: <stable+bounces-238370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB6WDepb4WmusQAAu9opvQ
	(envelope-from <stable+bounces-238370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:00:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C60415254
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 451333051EBB
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0F38A71E;
	Thu, 16 Apr 2026 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="W2nPO1DL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988F3203B6;
	Thu, 16 Apr 2026 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376793; cv=fail; b=O7dPgYZNIxmmYMdxkFdjaQ0rCL4Cr9wc+jV23rEeJ35p385c5h1QtrMYUsSesUaFzdgKK4n7F3riLULrNTdpr5zppSUr4qW7j3MLJMmkvYYY39MW1J/V9ATzeUNqiCI4EmlAUlIBdU+KWPp+8ChI1pvipVauavAogijsu/sGF7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376793; c=relaxed/simple;
	bh=oETJ07LXbdtGRv5hqr0DF0lsODZ0d+VD5YYoWO1HpN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2Dqq0qij5bDUUABs6Nxp3jFEEDLJpqo2/OISwFU5tOtwTxMlp2UW7eHfdnsuJ+skkpKTcrz8Cx35m1QaGU5hiE0FUVbJ+m4ERwSXrDNJQJTDex9MENNGQL+k7bEPbB3E6Opf+2LDO1dZEpgKCHxrDG939PPyfmZtzOdwedBgto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=W2nPO1DL; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GK3AmR2714091;
	Thu, 16 Apr 2026 21:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=IE
	s6xCP2+LNw63xeVefbV/Td78gCYsJKkGh4xxR2Y8o=; b=W2nPO1DLg8mbV3jehn
	FfBGEvmHLJpj2dGlv+o75+C3B9nrzk2FK1FDInTmaCqHgnghe07YvL1bbGopwaQ8
	qGQ1MIjhMBefEz308qhejGJ6CHp+0kNoDIpZL0oXY4FEFID0PacRZiBneliSQSoD
	3SVVCPGGn78k/N7DUVTJF53vfZVwd2uX/uvGd0ZDSCmAroNVc2JbTjJWi5e5cwT0
	ncSYKSTUZfUB6q5MUBhePCo0vDBNliepvHyYKsubybfZD6+NZ4AE7Xb6nZEIJ+Vd
	BNbalzpmHR3ycF3rttYKqtPxnwUpvL5Lx0wOQiYxemb1UY/whCiE58AxCj8aIu3y
	t0rA==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4djxwfyht8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 21:59:34 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9F981267;
	Thu, 16 Apr 2026 21:59:33 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Apr 2026 09:59:33 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Apr 2026 09:59:33 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 16 Apr 2026 09:59:33 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 09:59:32 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtOn87wVbCi+pU7wvFfKMeOkU5c44jOhcVTaj4kU4CvDiQE+9A3OBQj0vU/GzpALWAf2QJhlCC5M9P0Xq9r19YXAwkDpD6qCvYL4m48Y51vmlOKss5w7zxVHKXjnDw+Rgzz1R+U10+LldH7wj04XahC9Nydsq8cS/w3WRjzUSC76+ELbNTTMKsCg41k6tpMxEMrmiN20RxBqiun/veYYFXfY+IAolG+9bUG4FbeyGsHwFKsXD4Fb4i7ltqpwssD50u2JD6Mn7jD2/VamNcTXxi3zdR2Uryc5EQJH8Wdm07F+169WsEr4JV/M/oRJSHUoeih/PiBf0r/0eRik3StFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEs6xCP2+LNw63xeVefbV/Td78gCYsJKkGh4xxR2Y8o=;
 b=toEYUOSPJwNo00Bb10vxtjcIsJGbwjOrLhwkuLwvSJex2vbM8DOc9tt8Oqow3221AhV1kkdDdEK6SeBnlahjoGN96sFdk2zd+HvT8H2OEyMAnggv5bbpAv1Oybm9rr96ccKTmFeoTHmzOy7kjra/oIiq5SLBzz+qO1mBhjoLl1od+RQA4CK6Lm6qbidBH+QWcI+3Xb8s8vD0L02DxIwEt290HY919JMmDhx7GXCkuvCkZgWdl91Vkuct4KWl3RUI1fq6p/Cd/BKQMx7/Ad7tM65K0caiMsLFXaBUUAEm5yU2Vkjh7167Gpar2H/KqwjG20MjYwj/aiE8tH5eV+nCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:203::11)
 by PH7PR84MB3250.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 21:59:30 +0000
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6]) by LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 21:59:30 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "alexandru.tachici@analog.com"
	<alexandru.tachici@analog.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/2] hwmon: (ltc2992) Clamp threshold writes to hardware range
Thread-Topic: [PATCH 1/2] hwmon: (ltc2992) Clamp threshold writes to hardware
 range
Thread-Index: AQHczexNjyghzGFYcUu1C13GFiC2Vw==
Date: Thu, 16 Apr 2026 21:59:30 +0000
Message-ID: <20260416215904.101969-2-sanman.pradhan@hpe.com>
References: <20260416215904.101969-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260416215904.101969-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR84MB3535:EE_|PH7PR84MB3250:EE_
x-ms-office365-filtering-correlation-id: 8a5029ac-9299-4393-1ac5-08de9c036fdd
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: gbSRhHQnVHpEDIVuee8Bibthn3P8tViEt3IjZNNU+U23suDjwIdULGSNd/71vs3oFClDNL4XRjkV5JQLToC0uArlWJMn/0GLxopT/HRH3VGsPwRO7Yinhlmt4X30LXrdvrY+PL9m9C3O0ZkybtxbsKNP10yN34yQHywbs4e64/r3LXMLAa01ZJxgW+L+5z5SMRW+tYge3Fy77pq5St7K/vCPhEvlCk+yqbHljLbihe75m+bq9Rcg/cJCj/BuURn/rXBKVyBxRwYXYjwGeyRdk61ojQo3aedoIYwGrE0+rUu509v9xeGpgOUQehhg6tajKdXchF61EcY+UGz7s7SYuk/0JRoRoP80OBYruyjToGZvcpl47Bd2ILA3swxZ6kLC54YiYIjDVCOFQONJniow+Z7OlMJgJp/OmUuidc3mDt1RFhlGDnl5T7QM9NobJYxAPwhC0nba8qTPLbuIXh96JEOGFWFaca3FyTVbnJtdT9xor+pDCkO0fnlb2xpfYgvTbNArAf7M8Eks+jGN8lqI6iSiil9QHrZ7bqxluRrMoPXg7IIuKM8lhG0naFkAjIYkPjQPVU/F8LrGTiaITlQtrBaQCSLOfjSYxtXjpny1fXLID1LLnU8EpZMnvbWXosnw4VCSlcYy+QB9J+sBjRWZY5KlXFptVlEWbcwcrtMeHQrgfj6P2BBYTWqhd7QLcNx/x99NjsQJw6j4sqY2tPeWFPElvHZJBYYuaTIMPyjgbCwQe9fzN5DPvkn8dlB7P+xF78w84kb5YaKsYSHG8pHWKGseLu5Zl4t6HPoAlErftps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M+2PoBU8y/ZB/kX3X+1YmT6DGeTrZIzj/SGGFMKy7HYoKNfGYcczNbk/4D?=
 =?iso-8859-1?Q?HU9ad0W3W5d3U2SIrpQxWmekNiyG+BjVlLNHgpugLzZC/Toz/J/gY8UZwN?=
 =?iso-8859-1?Q?3SvXdTOr/KqRe3kh2FTMpK4Q+iXaQw+dfBDBhcjry1TmQeZr8fOekis8bA?=
 =?iso-8859-1?Q?Ct89stpE2mbRIY+ys2HfMJRACeV/Z5+Xl2t7DqmoS2HR+yhJgLQAE8TbBn?=
 =?iso-8859-1?Q?oHVOQbbEYSkQ3jW+LDk6Tx6bpV8dcnoGG1AfoCmsz9TD/nFRy84dHDfHO5?=
 =?iso-8859-1?Q?9afFg++B7WBcwCcZYwmkaWIct/T08Lb9y38Wk9Yd3nQ1NwoGW+p/5zqVyF?=
 =?iso-8859-1?Q?Tu+OAsjgFV+T850NuCd/pb6TTd1ggdYB9cHdGuddrEsIfcAFiUXoD47ia9?=
 =?iso-8859-1?Q?15KYiYdOqpNBZpb8J7J8cGfiezEKkpiDgeKM5g6tsCkP7vSPgLsa1jedUk?=
 =?iso-8859-1?Q?p1A4jUwgQQ4GPhG/+yujMaE4rlP9agrno4AKxX7+OXZWpPa5yYnZjqMCjf?=
 =?iso-8859-1?Q?6wF1RhJob7MZLWVTBEw5p4chqA0na+/wVMnmk1xN7WH14tysfxNVy2ddjw?=
 =?iso-8859-1?Q?uIFpod9q8uDouEgTvWWM2VCkcV0AeyOMSr4brBs89gC+LdnPtN7okY2OrI?=
 =?iso-8859-1?Q?bONVz1bshs86CPmsGl5RxIvtM/PIGhB7vMi0Ag2AVTOgjvuh5kO4GRdwsy?=
 =?iso-8859-1?Q?HBqfMIXOIiH/m1y8j7HSrD7gswusyOreWfC0IcLmOCu0MzGpMN8KdZ9bxX?=
 =?iso-8859-1?Q?Qk+Us4B7pw1ppIIJaZ88oZk+6ptlSrqls6raIAAIV8s8JpKVbacSfJnww2?=
 =?iso-8859-1?Q?6fwFC7G908PSDiErRQuGY1SJ6MbfHR4nMonaX3wV5FkVqWenOTg82c3UYz?=
 =?iso-8859-1?Q?jt967UrZwigfJSbYXaaGG+8x5u7hMi8Zy2HGp7UHy9sAB2/+sms4q1mlPH?=
 =?iso-8859-1?Q?8U2UH6F0Q/WobUrujgHUnVlD34NcSbk51LQpP4a26gL105l0POvfjcguub?=
 =?iso-8859-1?Q?CICnr6q+0IH6wL3IM06+oQuZtU4D08zZR9UTdr2hLmkPZH3bjwWpKkHK4x?=
 =?iso-8859-1?Q?0Q4v+Qibzhrq+3OjiNpt5+/jRWLuCX1wy9WsXIdUaPp2Prs6dsGOvJYyRM?=
 =?iso-8859-1?Q?hNbzCXogAhh22ehQ2NLL1JgA915bx68T4uGackNONiYPHDZJEmIkXpjI2U?=
 =?iso-8859-1?Q?8U02+8IHUHr4L42I6OLmso/x6jsNe+yf2/+vjJijtdz5QemAdvXDseBGy1?=
 =?iso-8859-1?Q?n+X5Fgv3MvfgvPgwvDloy9AZoDWrSC8x413a4O1h/Obmav8rikHTE71Mja?=
 =?iso-8859-1?Q?X53sGHlcnIfTxeZ6kM1TcUVdQ7/Sy0tjkbjgWgb1WQBhq78uuk5wnt/Thq?=
 =?iso-8859-1?Q?wPHz4VFrTCzf/lSrWfak6mqCwrAy00B6o2O6U9inUyznuvXZP2jl5yGdu3?=
 =?iso-8859-1?Q?LyijfhFzuFjrdkZMMVx5p6XLHxYudDHcCYDwDgXSfq77S7xe9saZVIo3PV?=
 =?iso-8859-1?Q?Mglfmc7TVueH9Q7Sq5AckvSLvuO33ORVTcBKZEhsiHMaj8/+Ov1M1HKYhx?=
 =?iso-8859-1?Q?IkMnyaVS1UGptgzEESiHguk4KQxG+rT8fl6AuHZH5WKgTMVtfNdoE4/n60?=
 =?iso-8859-1?Q?K6oyioVqIb05rZM+y8acxsSUR/50u6iMoRPxMwrzdwMExav9pK5f5eku7Z?=
 =?iso-8859-1?Q?hKoRt7P9GgQ3RrCxPBJyoG4ulG0kG3MhRgg7Up5hqT5idTUT3lw7Z/xFvo?=
 =?iso-8859-1?Q?g7gPsWlsyCePOxFTDDhnllzhQzYUs9VFCStKTjKqqRZHcLcnR0zUO4aWCf?=
 =?iso-8859-1?Q?6fFXuvfE8w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lWII6j97i24GBhH86SJ2IBgEu8YjfCeNDwPcgcvYM7Ibzfn1E7gGrpYhANfMIqs0dwNx/ugpsI1HzqGIAJj7LiPRbsLoL/HeoiD53AH9djyLaO0Pagr6grxL4IrENePfLE2A/kTGvXs9d8vVJEWpjsLRJTObfJ9lRckPEfHvE9LO91JRTlZJdZ3vfLaRzQWIOXnJTEHnpBKhAuMfosbmyM/qU6g5qRbhUP8vvE/OnBPZRb27n8TYym1T70B0h+AXKwB0EdNzXedAnu7+hzxU3TQZZvR1BK1J9LsRg8KKaUZJO3/Vg7Lc1NfozyKB4JF/4ViJcwoH8qkQrhmSxsi2xw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5029ac-9299-4393-1ac5-08de9c036fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 21:59:30.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxz6uAqBs3bRRrdC3geWNUzuxrpRLGAanKOLcPRRYduZ8jWDTo4RwimK/5FTeYomW/lg+Oz5j7/TU7Jzwjww1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3250
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: d7ZnCzbElvp_UW_S9V94EJG9VX0C6WyV
X-Authority-Analysis: v=2.4 cv=YMKvDxGx c=1 sm=1 tr=0 ts=69e15bc6 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=9F0IhLLRAQ_6tfZunWoA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: d7ZnCzbElvp_UW_S9V94EJG9VX0C6WyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIwOCBTYWx0ZWRfX4orRzvAanuTI
 thN/bC9YWYshVKI5JKi7hPiEV6JJ06GIKnsUonCvMkhhfNVqCVeOtsubds4tAs8YOK4a5jHFZdz
 8vM2wyMLvKf3dCK741nJLXkOePMvT2Mlej40GR/J0MWImK9PiQxAnE0xbbVgo+HeQSuv5Y9pqmJ
 z4ubQC51wsSpg8EGF5rAsmN41BWNNFD6REBxUHOOIU83iBUHj5ZXiR5FP6hoNRcjXcvrg0sD4Gh
 /U/fpkrSPgq6l25tHS+EhTPFJX5nGEyhZ4LPAwUjJP0kcMPT6zcGkJMvMsF1ztkdr01nzBVdevh
 S4YR3E/o2klcDn7yI8dkTm50GRspWHCFYQUigAfXEtZTMnfchUpgKXydqukAsk+RM/UN0PZZL5A
 xZ+PskPFb4+yDHetU79/REgSd1WsROkqkUx6kA4XGe5Lrn7cvnpKq5809zDyjBCvUpxunpR1BtB
 tootge8B3OqxyTj+aqA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160208
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238370-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9C60415254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
ltc2992_set_voltage(), ltc2992_set_current(), and ltc2992_set_power()=0A=
do not validate the user-supplied value before converting it to a=0A=
register value. This can result in:=0A=
=0A=
1. Negative input values wrapping to large positive register values.=0A=
   For power, the negative long is implicitly cast to u64 in=0A=
   mul_u64_u32_div(), producing an incorrect value. For voltage and=0A=
   current, the negative converted value wraps when passed to=0A=
   ltc2992_write_reg() as a u32.=0A=
=0A=
2. Intermediate arithmetic exceeding the range representable in u64 on=0A=
   64-bit platforms. In ltc2992_set_voltage(), (u64)val * 1000 can=0A=
   exceed U64_MAX when val is a large positive long. In=0A=
   ltc2992_set_current(), (u64)val * r_sense_uohm can overflow=0A=
   similarly. In ltc2992_set_power(), the computed value may not fit=0A=
   in u64.=0A=
=0A=
3. Register values exceeding the hardware field width. Voltage and=0A=
   current threshold registers are 12-bit (stored left-justified in=0A=
   16 bits), and power threshold registers are 24-bit. Without=0A=
   clamping, bits above the field width are truncated in=0A=
   ltc2992_write_reg().=0A=
=0A=
Fix by clamping negative values to zero, clamping positive values to=0A=
the rounded hardware-representable maximum (the value returned by the=0A=
read path for a full-scale register) to prevent intermediate overflow,=0A=
and clamping the converted register value to the hardware field width=0A=
before writing. The existing conversion formula and rounding behavior=0A=
are preserved.=0A=
=0A=
In the power write path, cancel the factor of 1000 from both the=0A=
numerator (r_sense_uohm * 1000) and the denominator=0A=
(VADC_UV_LSB * IADC_NANOV_LSB) to also eliminate a u32 overflow of=0A=
r_sense_uohm * 1000 when r_sense_uohm exceeds about 4.29 ohms.=0A=
=0A=
Fixes: b0bd407e94b03 ("hwmon: (ltc2992) Add support")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/ltc2992.c | 37 +++++++++++++++++++++++++++++--------=0A=
 1 file changed, 29 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c=0A=
index 1fcd320d61619..1069736196763 100644=0A=
--- a/drivers/hwmon/ltc2992.c=0A=
+++ b/drivers/hwmon/ltc2992.c=0A=
@@ -431,10 +431,16 @@ static int ltc2992_get_voltage(struct ltc2992_state *=
st, u32 reg, u32 scale, lon=0A=
 =0A=
 static int ltc2992_set_voltage(struct ltc2992_state *st, u32 reg, u32 scal=
e, long val)=0A=
 {=0A=
-	val =3D DIV_ROUND_CLOSEST(val * 1000, scale);=0A=
-	val =3D val << 4;=0A=
+	u32 reg_val;=0A=
+	long vmax;=0A=
+=0A=
+	vmax =3D DIV_ROUND_CLOSEST_ULL(0xFFFULL * scale, 1000);=0A=
+	val =3D max(val, 0L);=0A=
+	val =3D min(val, vmax);=0A=
+	reg_val =3D min(DIV_ROUND_CLOSEST_ULL((u64)val * 1000, scale),=0A=
+		      0xFFFULL) << 4;=0A=
 =0A=
-	return ltc2992_write_reg(st, reg, 2, val);=0A=
+	return ltc2992_write_reg(st, reg, 2, reg_val);=0A=
 }=0A=
 =0A=
 static int ltc2992_read_gpio_alarm(struct ltc2992_state *st, int nr_gpio, =
u32 attr, long *val)=0A=
@@ -559,9 +565,15 @@ static int ltc2992_get_current(struct ltc2992_state *s=
t, u32 reg, u32 channel, l=0A=
 static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 chan=
nel, long val)=0A=
 {=0A=
 	u32 reg_val;=0A=
+	long cmax;=0A=
 =0A=
-	reg_val =3D DIV_ROUND_CLOSEST(val * st->r_sense_uohm[channel], LTC2992_IA=
DC_NANOV_LSB);=0A=
-	reg_val =3D reg_val << 4;=0A=
+	cmax =3D DIV_ROUND_CLOSEST_ULL(0xFFFULL * LTC2992_IADC_NANOV_LSB,=0A=
+				     st->r_sense_uohm[channel]);=0A=
+	val =3D max(val, 0L);=0A=
+	val =3D min(val, cmax);=0A=
+	reg_val =3D min(DIV_ROUND_CLOSEST_ULL((u64)val * st->r_sense_uohm[channel=
],=0A=
+					    LTC2992_IADC_NANOV_LSB),=0A=
+		      0xFFFULL) << 4;=0A=
 =0A=
 	return ltc2992_write_reg(st, reg, 2, reg_val);=0A=
 }=0A=
@@ -634,9 +646,18 @@ static int ltc2992_get_power(struct ltc2992_state *st,=
 u32 reg, u32 channel, lon=0A=
 static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channe=
l, long val)=0A=
 {=0A=
 	u32 reg_val;=0A=
-=0A=
-	reg_val =3D mul_u64_u32_div(val, st->r_sense_uohm[channel] * 1000,=0A=
-				  LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB);=0A=
+	u64 pmax, uval;=0A=
+=0A=
+	uval =3D max(val, 0L);=0A=
+	pmax =3D mul_u64_u32_div(0xFFFFFFULL,=0A=
+			       LTC2992_VADC_UV_LSB / 1000 *=0A=
+			       LTC2992_IADC_NANOV_LSB,=0A=
+			       st->r_sense_uohm[channel]);=0A=
+	uval =3D min(uval, pmax);=0A=
+	reg_val =3D min(mul_u64_u32_div(uval, st->r_sense_uohm[channel],=0A=
+				      LTC2992_VADC_UV_LSB / 1000 *=0A=
+				      LTC2992_IADC_NANOV_LSB),=0A=
+		      0xFFFFFFULL);=0A=
 =0A=
 	return ltc2992_write_reg(st, reg, 3, reg_val);=0A=
 }=0A=
-- =0A=
2.34.1=0A=
=0A=

