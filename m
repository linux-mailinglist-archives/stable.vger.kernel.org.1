Return-Path: <stable+bounces-177943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C441B4694E
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 07:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623323AD510
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BC254876;
	Sat,  6 Sep 2025 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="JeXk2Tvi"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B08265281
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757136499; cv=fail; b=O8YWPFHWyHfxdIGKP+QCdVm58tfQNF49eKDYAcen576Gr3/mwK5bNGU/0BFR/Ul/l81C2b0qIpA7O5IBxcs3x3YwxlzFfY3AGJ7UAIO73qkpBHfEbvbGST57AvZXcFW/XXGr3fdXEsqgC2KqrqASLbDMEP3Fv8AZ8y9Ee5OFMh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757136499; c=relaxed/simple;
	bh=pETRy8rhA0hxRZ1BBEG41TrbYg9iRVlCqXol5zEiTOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4HLcsm/eX2Cg5WSCLT0YhnhN+MU4fZlZtwymAL/bUNx1OY/YUFxAB7MlhDC/asepcKBOvCWqvQjNX1rE3QP8T3By40RdfYM3ozUE+XvbYIeGExQyreBYzYRqm8qegqrQCdH6Ss4tZ/PfpPA9Gbr+yweaxoypxApXgwRwZglYhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=JeXk2Tvi; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757136497; x=1788672497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pETRy8rhA0hxRZ1BBEG41TrbYg9iRVlCqXol5zEiTOM=;
  b=JeXk2TviznNbAxPCoZ4NPIyhQPpuN6AiCHcowKAPqbYLYq4fH3i84ZMX
   HmFQxwbOWCNSh564Dz/ikuQFqV9+mT6QO5ZMJMtnYqMj1U8vBe6ABs5nZ
   Uli4upBDqw/S3atLM8zXD2pIzfL9Uel21i8KoyQKVcvEJlozainSl6x5f
   Zm74kJjs1atk/vk441BtUjtkEOKo5HI7Xp6/XiMx8ma5iUWj0P4HyXiS7
   a/l7zrM6Kso8y53fD0ZB/4Twq9xqKuhH5AA/iQj69Q5KSGWKoC2e9zyIc
   dYE/2qExyKyqu5lBwV+sI8S1ko9pVVjoQnp1Kr8ZBjrX07fmFD1UPx70R
   Q==;
X-CSE-ConnectionGUID: rj/MeVMJTGiyomFOFVBXBQ==
X-CSE-MsgGUID: MonvBVliQGS5ORzG0I4SPw==
Received: from mail-bn8nam11on2113.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.113])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Sep 2025 22:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW/ts4qju1tRjMpuQWVMMFfaZcOgjrKamtXe9sY0/rp+WLeSkY1fZGs5bZzelmV/h92x5yFjzCmh60zXNerRHKO1w6ZUSseoaNwkbVicqjhzEYLJhYKDl1Oy66vqE5AToJ/pICOevwLYY/345Q8l8j8+Sjc364DNfrpHQpgMiN9WthrD0PpMTxaPcUYALUBsRrCqZmj8FoVE/+n053DWB4GAUnT6CJ40VsU3qu1H8CDWtXcy0tA9D1Cg0jOK2EMQAXMuFSuegJaXoI3sfGPiEzVuWdUHOza1XxggieaG1hIrGSnt9GICNdN6THBCsno5RJ+byvSPQYzliudKUa06Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwgLdXdB657AA5GjxRid2KimHke+1rp8X/Imuxy0vok=;
 b=NOzRSs7zOJuhZS9MESYWX5XJzw2uMUb59+LU6ZRBeXlxi1tduzOWQ5yGrTGqTQSCV3g47jyc6hnsMvF9JUCGC+zJpU0sDhpT/3nItZyQrTDbnw7cVLhSlB/Jgnzh6kLvEd0giT+op9yayzfJ924hvxr98lr5z/ci+7ybMIapol89C+xpg55opIuSUFLdQsODpjEYjMqFc2OjCloH9cDkDj16B59Wqh9SpjCDGqL1hzKZHp3u6q3pvop4SPZ5z9xkziFwBl6CDwnap07ASnd+CbF5VYUErp7Xh0F6UK309e12lomzt+xM7/+H6whRQ/ZVS1JHmc3nDmV5BT2Dl4DFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MN6PR16MB5260.namprd16.prod.outlook.com (2603:10b6:208:46c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sat, 6 Sep
 2025 05:28:07 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 05:28:07 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jonathan Bell <jonathan@raspberrypi.com>, Keita
 Aihara <keita.aihara@sony.com>, Dragan Simic <dsimic@manjaro.org>, Avri
 Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v1 0/1] mmc: core: apply SD quirks earlier during probe on
 5.15 stable kernel 
Thread-Topic: [PATCH v1 0/1] mmc: core: apply SD quirks earlier during probe
 on 5.15 stable kernel 
Thread-Index: AQHcHlZWa8U3rh7ATE+Zrr8dVIH7SbSFoT7w
Date: Sat, 6 Sep 2025 05:28:07 +0000
Message-ID:
 <PH7PR16MB619605AB192112222A5333C5E502A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MN6PR16MB5260:EE_
x-ms-office365-filtering-correlation-id: abc73ba8-e494-4ca7-5619-08dded062948
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1TOS0Cn06UhQ1xy3AEC9MswbbZ5I6gKs1uPRRnIC7IliRaTadbCYKYyEWzUd?=
 =?us-ascii?Q?Pzr5tHJUS+6omOLFhz1FyZt19ecbdLudW3egt4TZSZc6nmKYLNSoo0Da8dJj?=
 =?us-ascii?Q?Pjd1PFUzUliXAQXVp8xzcgthJjXw9wa6EqgbSoFsY+8unCyiD7q1Qcb/LYnR?=
 =?us-ascii?Q?TE3euldSntBqacave1SEgXLCn8dpaVhXEk+C2HriR5ixi48NblS24u2M2Ep7?=
 =?us-ascii?Q?PXTlM8xwOu6X6qYCDjU2UDVVOIXKDBKkRzBf5tYQHynqqsH1TRMwq4kFFoRz?=
 =?us-ascii?Q?EW+9w5qXiiEWjGcjvPFmSsmfyjdldhjuBlsRGGCHGh+h/ZrtRPqEWRdTnDbJ?=
 =?us-ascii?Q?6vWqd6iw0HMcd0xhc6TnMho+UkxS77rR+59V0xdi/iwbjxgAdpuXDeucGvBh?=
 =?us-ascii?Q?CFaslXP7T9AX9cJsMa5pQ70+gQMDsPDW6JJsmlxCNDdi2A1LROizui6EApbK?=
 =?us-ascii?Q?66ypjUiAjJOzaFPiYM/tUZVoTtsTOGY9RdqgVIqaF0a8mqhNRzYQKjIKCQ30?=
 =?us-ascii?Q?9XMqKgrD9waNe4fn+9Gqf1jLkRxCUJbzudm2KnFWjPLkPNdzjR39b3v0ZwNi?=
 =?us-ascii?Q?xOtJObebQyIaw9A7Dvf/IEe2QZ0KqsiL+7G78qMyhDBbfseR8JFHBapPEpDc?=
 =?us-ascii?Q?P6c10WGgDRxc+Lg1AsXByIVj3Wf+GvYG62bLJ3ue6F/FnX1SCeTaBEscOqi1?=
 =?us-ascii?Q?6gQkXr4XM1LbY0RLnAT4lfzoq41VQPjPEW6WhoAYmaCFnMMFJjuB+zMuOHfu?=
 =?us-ascii?Q?liMlmDNRiutgqoO5XDT9d1FOTFWsxyy0RCdOTmYec3n1WkfUHSAtHUT9ugJd?=
 =?us-ascii?Q?Igl5cgnVCDw3V1aj4B6qY5XU7iw8YZQz6kG6z6ICjWmj/wNNsXpcWb1P1yM7?=
 =?us-ascii?Q?yrSbU+xyFxuZKUQzM+TpaDMW/BJMo7h9GHDH2gKtWBA89oO+tmnWGhrJepCx?=
 =?us-ascii?Q?Fo3K75QU5fc/wc5F8apzBM2/UWd/OIaoY424sgAj1RS2XNKPkpGy/5zw6EUE?=
 =?us-ascii?Q?x2K37Tcqv6De/qfE+s3fzWa3Q5+4eTGqSAeW9GUnzgPofTRmg/L2JcIC4kCM?=
 =?us-ascii?Q?qR1GmxB74XokUKiY5wEElTeTHJe/qv/DLxRsb0rfbTDOWoRILVWBQimR9A/E?=
 =?us-ascii?Q?v8fSEtPLgw/5Lt6k4/H/zL8ccglKkIi8a2jLUc/NwbNidG7ZuzjeOPo6EN5Z?=
 =?us-ascii?Q?RAM9r4Rhpal9jY1/iRPFSm+H/BlwWegaNrNTnm4H6/RXJvI+4v5i5ERRd5Xz?=
 =?us-ascii?Q?49SJ3Uu7O/gw7z5ZJzDhMAQLhX71snxOtKymBtCXOcvI/p2WxaATy/C9hGG1?=
 =?us-ascii?Q?m4y1PABtZX5hFkhIf3A8S87xPGw6XHil8isiS1znH++W1sIiklCtaw3BWS49?=
 =?us-ascii?Q?F5ZJbq6jvnqG0p5nptbw3h2jbVPENG60qiMjSzUZKoJRCbC0tOe2HcdzfrOJ?=
 =?us-ascii?Q?ia9FjwW0BoTQ79D5yPppRtXjm7WcBxHuPOTZTg3S0qneQ60x7BuMAQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ols6s2oXCYLaOXRvojeEGLGYYRJXg/LG/bW3w3pIJ+7uRv8j5QcH1rUK8uPA?=
 =?us-ascii?Q?PAmrZsgtVd0LDsdxafAQsOTMPPNolSMZhmNpzei1NevsmZ7oEHq7QT7OAIC3?=
 =?us-ascii?Q?pZxQcqXM1oOoH1P1arrEP3k9LcPFAvbG9EJjxIxAgJ2gQc0StbM+RL016A1z?=
 =?us-ascii?Q?/5hZFam/i2jA6CkQK79t3TQ0pCDO+HkZBGDJcArKUysMbyvKsl0Q5t+J36O3?=
 =?us-ascii?Q?Tt+X0PcfR16EuxWG/LcQwH863YZFDBjpewziFc7YeFrsQL9D4xQb0b3hn7Jv?=
 =?us-ascii?Q?momCGcHPoCRqan61sC48/Om8ssf06ayVSNo1pprcLoGUqtnTD4avBi1jRqrI?=
 =?us-ascii?Q?+oJxfBeB1qIf5MWx73PY0qz+FvmDSARE5k0HcXoJes1ewpPIgPvPwjniakap?=
 =?us-ascii?Q?C2WRmOVklg/cj0LCf1JVapgQEQMzddzxRxy2TIVUQ6n/3XZwD/wk2YN+u0ev?=
 =?us-ascii?Q?WpqEidJxH4pyrnTA6JouPzcRSm4bKGGBtDojMPGp4w4h5aIYLJsje2RvvCwD?=
 =?us-ascii?Q?wsoZVOjxHT4pOFKkMvGoAmDxsBohpv54fEuW35vA4CoBVuaRFgH+N2uka0Et?=
 =?us-ascii?Q?/mE57yfopY0x+SD3h4mJ5VdwV05gmnFFJJDhxicDIFDYoPODF/g49xZDn9CM?=
 =?us-ascii?Q?Qc0TrLn9FvXN3Bow/WVnQR+aD/u3MTqxhRota2G/nE3fPIxR9mz/UOdJFo4+?=
 =?us-ascii?Q?n1xvuXtTJ0iQmwfLqPXFdMoHgNEKffyDhIqpLZKAvBDna4zm06c6gKwdlrMg?=
 =?us-ascii?Q?yD8940VctI4cB8c+8QOA9UU7rVng0Md3+9eDhkBfYCZLrDhyuMwgl08Vx0fV?=
 =?us-ascii?Q?DFkFeLJNKD2LMfGEQKnGj7aVyXN2MRYoLz8vBAOeSi/AGQK3mmHUs2DEOjmV?=
 =?us-ascii?Q?qLmtH5kvWTOuABeb0WMmEYBeeyF5ctmCxEmW7LwugylTrwQ0q+K8iyWPoQIh?=
 =?us-ascii?Q?qK8/lp/dXnzcxA0XkSLR4+NZ9+aUZX8/vbsXde6noHdgFLolxDsDdW54nmi5?=
 =?us-ascii?Q?uNv5oj/1JmLoinj1YKYsIIqRc6n8gFilwZWvQBFgt4h5JjjmKohLbT2IDbag?=
 =?us-ascii?Q?VdRX1/38Qf9R1esVVMhOp4BlC8VtjsZbnY9U8AEew3MwjQHlj7M6RmOrW7j6?=
 =?us-ascii?Q?03QzbPMu4SYd072Iggm7AznpFEr3Rsm06EEdd3bd1M4pFFMa3GjYMuahMeMc?=
 =?us-ascii?Q?pi9yUnofM+aQaceUP0eeSlknmuGtUR57uTud1NZh0QchwqfpGcGdpShivE7B?=
 =?us-ascii?Q?/Tz21xJM4RY0gOrxD2NMoy0Numt740HbG5GTz5NLYCFIKmd0IFWRr7FsTYlm?=
 =?us-ascii?Q?epCyhMfmDSkVfGKsIjNyVdI9Vu3ksMSMC7Dps4bxuQIi/3yNNx+rb5vVVW4D?=
 =?us-ascii?Q?j2BDov06kqWcKb40qrdHJbJEtsWe0oYQfut1P3PnlIAbZfY5mVfPzNDCaAZp?=
 =?us-ascii?Q?gDTEqJINQIqHe5TR3+3G3KB9SRrgwpzSOCNvMZLRLuL+NQ2v8uZ9cKavmEkE?=
 =?us-ascii?Q?ZN2hJBT7kUNm4nT8BF2XyFCoScvfb4GWO6NDbzVVCM7qw5ZQUMDq30hJUGl3?=
 =?us-ascii?Q?evhQQHRksPBPWpUX50/fAfmOCvm7MI7CaiIY+Fkb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bMM0ceQzPAtwXmMhW0aRZYCxcQrc7f+H/VT4N0n/nLPOSBhoRkIpasG42cjGWNrH5waXobC/fRLis4glmBG/1viTiyVxjTXSE5Nro4u1eT5ldRMDec2P6U8j7WHvdxGh+LaJp2wm85MKIW4YWSVoYC2Ji7rs/QlkG3zoEJ2fzbmbb6P4Syfs4AtxAbK9jOl2KQzXER5kGhsHD5TY8kPl+kksuiB1QS1iA7QZJojlvO/yWt+BtwBL2FUTnQf1V7pFwR04W783nOh9EUMQOs4v8w3ZTuGRh0xxufuSFTNVKXA+UU16uD9wp2f/zV2nhmEuL5bDr4QhzXGymm9LmXZSklRYo3cFqKfDUYfHZIhMA94lrz/VE6JHhjkREZc8Ijw0StKZ2HsaVxeXjZFnYdoHwHLUjJ2x1rloj1Wh3Mm07JsVBTG4u0VgTtYtXhxR50jqEflrXPDtIuvq5Y75rKu4RB3eb8bQwwoTBc6+wdzvs5FSJonq05xlsLrKlLW8iqWTh/iLDZV5t3lCaKtfL9cHw9w3PhQODmISQkBRyRucIlqWz4x00qDgHORUhLNC7+voCD5ap3lqLbUDR46Ntyy9z+BBVWMcFyMNhyOTkmNQCtFmcc757EQPNZB7Qzsbfm4/6coG/CMmGmNmjzmewAHgpw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc73ba8-e494-4ca7-5619-08dded062948
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2025 05:28:07.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibLgV12G3Puk+4d7Vjy4oqaCvHJ/8Hhk4Pm5e6P7CorFjn5GEgSlnGPIiNquo++GUEIzD4MxfXhBod/0EXvxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR16MB5260

>=20
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> Hello,
>=20
> I noticed that commit 1728e17762b9 ("mmc: core: sd: Apply
> BROKEN_SD_DISCARD quirk earlier") introduces a regression because since i=
t
> depends on the backport of commit 5c4f3e1f0a2a ("mmc: core: apply SD quir=
ks
> earlier during probe").
> Without this patch the quirk is not applied at all.
>=20
> I backported the latter commit to 5.15 stable kernel to fix the regressio=
n.
Thanks for fixing this.

Thanks,
Avri

>=20
> Best regards,
> Emanuele Ghidoli
>=20
> Jonathan Bell (1):
>   mmc: core: apply SD quirks earlier during probe
>=20
>  drivers/mmc/core/sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> --
> 2.43.0


