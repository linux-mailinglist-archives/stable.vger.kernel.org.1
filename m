Return-Path: <stable+bounces-73132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF596CFEC
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653FBB21D7F
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA80192B63;
	Thu,  5 Sep 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="T4u2gmig";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="1P98VINV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DA14D2B3;
	Thu,  5 Sep 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519712; cv=fail; b=pU6y6kBrtkOmKB40FvvdVvYXr/I6rKAEFLU3VGBuOuQiCmn5l73I1uzrtA9tumEIWtBRyyLW3cfSOvALPQJ5ooq4DF9aoI1geJ/TgDee/FbBjPswIVgYEKYnrhnf/GLpzNjNQSwERMimFEazU663aj57uXNVsXMIdXzJbywXd2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519712; c=relaxed/simple;
	bh=PcqrmKbu0DUNH3A+QKwO8dc2ydopc1rTjA5D1CfZ+k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWyPYHVyKau/FCMSOCTnRInChYplgjFn7RYEbWtcgnvR41n9DOassK4cPSel5UNImwOfRY/xhZmhzvz+qdhdd+KaQUJzClKm+BXl4Oxx7GS6RSiOUkHBuXtxq4LD5sUh3jStJPlrVfgw5h0tnHj2CV/+7ZHskC3NvvoWURbwyoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=T4u2gmig; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=1P98VINV; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484M0Z2o025324;
	Thu, 5 Sep 2024 00:01:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=OMl7bGZOIQhrWGDNvwDF1W+AqPyJQTeLY0wX+xCW1po=; b=T4u2gmigu8k6
	ZD7R+PNHrsFimeI5OVYSM75u5IDw8EEeVl8pUfOuFyMR9LMIKwXSfhmVxTTogGHR
	U0lwRt2UN+Vth4pwadugl68iSIgNpOwfUMxVGl2TWsN6wbAfh9fwsSaTL2nL+oZt
	WHpAGJWXvwdg/Xz8QrrlYti0jsZzdQDu31yH6rzQvlo8b23h06SeyRd4U+PoSlf8
	f79MWQVAagWLIIjKEZBXB9MGEqbI0zSVQdjmPagVB/XCVNxN9LDM7j0nUNrV9ACn
	49qFWtJRbJQydFhnjTJ+J2xnk//REam6DhkaMGdXuXbVZdKYb6HRwMDUAH+y0Kw8
	sG8KqAxutg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010005.outbound.protection.outlook.com [40.93.12.5])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 41bxrvgxtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 00:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY1ZZ6bpUHrzQkbDGmYf4nzDF0j1MXC8dcP5h9eGnRO7Lw6rh+2+NhCjQRvPkdLBnD9/FMpy+rCJNZCGUWDXa5Vg6ezBCmaCD4htQuh8N0gbTjECqVDUmk0oB5z7n5U5Cc+FPcjRaq5Xc2FN1CIe+EeACUZJ6Dp5ohT+swAKSE74f0WssAyZIDqeGtfZfizHsT7Xm4zyq3fVGe1diEYMVnP60/ThD2mJXrvUv5+w/kXcW6a8gtK8ePbs6N2UhgJ3F4SKd50QYFBJiZKWW5AtpDgBM7Pp5VzlOY8lk3IPUzkqFHfOB8JNm9Ffo3VlsfdnOHs+jQayz/GMwnLLKwa+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMl7bGZOIQhrWGDNvwDF1W+AqPyJQTeLY0wX+xCW1po=;
 b=qYUVJ291avO1P6C4pQsrO1d4qMJwBJK8PURz6OGa7G5bsL12wnGrAEQPgjPqtBN3hvBNF6e5WaKfGvPHpMwXTrttA2bPs0tfOyEAWsUbBOUi+vpqAfMIkj3I24YQ2e46DIq51gtWAaExPcy61qHdiTjL2jk7iad9z6qbhX5+x91Lclhmc4D47QYT1ZGHjXDn6O4BXnNsT/RvwnztWQNWBMarBqiR7tM2kU65igl+3oBZxhePpqg8VRjF2M4hRgYv1hXnIf4nlqL4LfCSZMxAEz5KEG9T5CkKCNAWmh1r2pOWFnjsSvWINbWkyn0v83ce2MPUYGsMeTSeojuHMy9udA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMl7bGZOIQhrWGDNvwDF1W+AqPyJQTeLY0wX+xCW1po=;
 b=1P98VINV/dyxtxtx5C+imGEqitOfJDsAxo8uBGPNlm3jyBaHJK3AVFUP6+a+FIwckx/Hzxu/QCNzP8xZZo6T3WkxUQ4IvXNVbhN/8fiFrmU/OxZUxmqQuhC4tdNUKIsOELHsQbv5cf22syenIkxMZNzMEW2NGpm3573dvj2828M=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BL0PR07MB8210.namprd07.prod.outlook.com (2603:10b6:208:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 07:01:15 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:01:15 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: FW: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Thread-Topic: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Thread-Index: AQHa/2D1v7Tx38XDdkOfqL/qNaUw7bJIw3GA
Date: Thu, 5 Sep 2024 07:01:15 +0000
Message-ID:
 <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240905065716.305332-1-pawell@cadence.com>
In-Reply-To: <20240905065716.305332-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWEyZTg4ZTIzLTZiNTQtMTFlZi1hOGI1LTYwYTVlMjViOTZhM1xhbWUtdGVzdFxhMmU4OGUyNS02YjU0LTExZWYtYThiNS02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9Ijg0NzQiIHQ9IjEzMzY5OTkzMjczNjUxMjQzNCIgaD0iWStLTTE3QVFIbmdXMW83eU9OTzByam04clU4PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BL0PR07MB8210:EE_
x-ms-office365-filtering-correlation-id: eae2dbb4-58da-434e-2b8a-08dccd7888dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VmXQRgTbIPdFc3Uc8LE4pY9Q/IqpB7wsWuLWgShPXneEQneoj9ddcAOB0Hxs?=
 =?us-ascii?Q?rxMu7juFkUJvUf7puPXn3IWRBvQYIFJIhVQNNEY3eE2Qi1Uh37FiWUDS3bGJ?=
 =?us-ascii?Q?wuVh4Z8AO8LvmXV9JiUgwfwwq87UHTt/gQ9J2SPnGeupBFUPdcpl+7wlKzYE?=
 =?us-ascii?Q?LpICh8bcuZCQTz666u/CNjFj1lcU0kH0SChXoziQ09nX8uJ7TeHCgCuknSY9?=
 =?us-ascii?Q?7v5tdYvBdSq6Q4EUMr9BTWks7cdF4NJK3pEZgnCX5zAkkFmpDxU/e3H1LuLT?=
 =?us-ascii?Q?sJGxXeisostldqZ99RMLZM5xAqXXC65/RrKWiRMvUePt36fepylSMyE/oKkJ?=
 =?us-ascii?Q?kgW0gP6/zvJhVM2fqbIy5wpEPCEAqJ0S6JItm9Jl3852iOMrtqhBg9u7USdP?=
 =?us-ascii?Q?pvSYMlpAsm2XQRJtFUV27X9vxi9NgAAF6iz8bcpzl85OBMi5tzIFXfKIWl65?=
 =?us-ascii?Q?s1otJ1Q33aWb4q8l+S4TGI7Vj4XrS4ZpxVVzGrRsuBY6pNwPH2fIIoZ2WcOG?=
 =?us-ascii?Q?ezfY/rb0gRXxMjVbHMroOVBfY4uC4aYe95Xu2woK7J2te1FUZWvdsKEw+s10?=
 =?us-ascii?Q?79/ywukTPd6p9+GA1Jd24N2H8JMCBVBacij+Ag7+6zrgLz/dQwY0vYHGPHBC?=
 =?us-ascii?Q?XDl/8wEhgxGJ0j745K5+f6dKKHZBeClkOrsayvMBCxA/5WrO1YLOdYj78qUg?=
 =?us-ascii?Q?lEQxsXB3h+YASAd+7E/nobt1UPghdcbrEtzN3F3QIMeEROwgLBKUJ/3ftBZh?=
 =?us-ascii?Q?J6M1idezXsNNyHG98rJNLTNEVOc5UDd0oBKLf2Yqnk+k6+xII1mQheBiHDxW?=
 =?us-ascii?Q?Ic2PaxFeizEeDv0seqO7bux6ok9hUUg4OAV4lzBw2cI52L+6VoyqvpOLGULW?=
 =?us-ascii?Q?NJmt1eWKWSzhXObs3LlcezlhTk04RfjoKhg3JWhnATvnrI1Im/JwUswup9IX?=
 =?us-ascii?Q?Bm7aRXz+zT6JMprAet6TCLbPcyQzzzseeqogTrg/RRioxP7AQfg1kNjqNh8W?=
 =?us-ascii?Q?AoVcpD0Iti9K5Tr5la06obZNPZYAbHemDryGaf0O3Xz6iE/2EoxboYb5zbDZ?=
 =?us-ascii?Q?gWaE7Ht20243SLo5ARp7QgF936kswMawr61TpDuezdX5v8HSnt8PazpNJUpG?=
 =?us-ascii?Q?HqTv3B6FSmrCujUKCG0SW1UdWtJeH2azMnqQ8fTMQ6DnIxvW1zSktuxiWaXx?=
 =?us-ascii?Q?vmR681GXnX7Tkkk1qUV8aXUyU7k2B7zulgkMoST7SJe7hRQkFLhw6pQgSkIx?=
 =?us-ascii?Q?eM8nHVKH4K/NdNQSEWUiHsYrWqtCtBztXys7BcN0KZ8VMtwCuG9fvP9yM228?=
 =?us-ascii?Q?lBDEf7thIBdmJQDWrBw4693xmRk3dlCybJOWjcTS4lP+jPl8KobFoA10zYak?=
 =?us-ascii?Q?/4Kja/vdN1mXcbIlsi8w4RyADqUFaOAEOVb5Vlwn1T++u22hAQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MC1anLCNEfSoq6O87WtD1IKCuB3Y0dT26RC1MplhkdFuVMxEMYmf11/2OOmN?=
 =?us-ascii?Q?mfjuKazTfvS7UfwznHv4iF+drWUFjvoVojolDsFNs3VM4IlwfLF5j3XFiMkp?=
 =?us-ascii?Q?br5d9oLCY1HPLmiUdVXVOH2Mokc+KniPRACkMlh9syBJfBgnlrO1goDy2hu+?=
 =?us-ascii?Q?+91CbIgjChMmVZoacyYrcXCRtDCX3K5OSyWWVSL18GacUntq+ivYkDfoFRf3?=
 =?us-ascii?Q?UbOqx87LZjEvpvoByObhoILwBzhp+j7Nyqp1lq7bVIHGOq79qfxk/PrNyOs9?=
 =?us-ascii?Q?76l7tG+JyzHR+m1e2xNfEaXdCWlPyjf7N3KJOGVmFQ/ithADnERJA7wIQY2n?=
 =?us-ascii?Q?dhldYEN02eDXieifhei1d9so8NKOcQycqDLG9jskQkhB+rPhve5K1iUG1Cbh?=
 =?us-ascii?Q?TqCBSvLcOqjJy/hEQkPohG98WDuW/yJn8JO+EFwm/mHpiXgli4JqH8Enr9/H?=
 =?us-ascii?Q?iNWOM4mvqis6UvayCtUBeItDiYTEj8IHyJEClnZdzM7xdgR5fNYTQaZhfPev?=
 =?us-ascii?Q?FQebqY/keXYM7oteYyO5khzpMk5qk/IcESWJIcIdbqw0WxOLIbwGWN/Zb4eL?=
 =?us-ascii?Q?1136zw+HAip3rPHyuZkMDR24ZA+VFMIT9lJ8GZ8u2/ryEweBdciWuh6Y49aa?=
 =?us-ascii?Q?tqJgyBAOmvQ9J9fBJgwt8/NyG4xBN0sddfEDZ3tt5ktQ0QCpLMXgwpBr2Yri?=
 =?us-ascii?Q?6p66VgAQtxGh3wfNtTIrFqMzr23AotX1iQh9EI+8Ur3ZOFIfFUfeeaxJb+Sb?=
 =?us-ascii?Q?Wc3tYe9UwA8dj3cynDY8HMrYq4aBoM657sQfCVhStozsUeN63sMhIOu35+dK?=
 =?us-ascii?Q?uTOL3+/rfRopY9Pfv7eUf+8Qzos/iWLo/yJ0B7GGfIXQQd/jcmTw0pg8eaG8?=
 =?us-ascii?Q?9wtNJS/DmtMiAKZUOJHebfKKV2kkND2J44D+8JB1oib9Ic+m6+t9e+R8xObK?=
 =?us-ascii?Q?4njsGu/8lf/qJ4xv82/BkFPuMY82goiUpKGXL0QHFa8UWotD228tjcOcpfR3?=
 =?us-ascii?Q?NcUxkvOgXqmX69HE134aUB4nLHPKJelbFIvIjl+YtFUccPxR+TmQ1SkaEATs?=
 =?us-ascii?Q?ojHLXo2csiR82xTHrHXCyFufP33G39rXOCJ81vJetoBH1075mw0q2AKNCCnu?=
 =?us-ascii?Q?uR0CF68CxRiU4g1e3CuyLo6u5eTLc0XvT5B19wFiCVttqzQQAwpyfDn8DbsS?=
 =?us-ascii?Q?bwCbK5qL4pJ2EFs2Mf2bddouFLUuxqeJzjg6EhbbcjvC/bCl//gg3lJ9PQWJ?=
 =?us-ascii?Q?GELgn1b82BZ7Gooe8US3UnykZXj8S7bcnjLkRKua8m3aXW5acldqhvoFlrqc?=
 =?us-ascii?Q?v8rpsuJVc6DMPC268GHJfqzinkhkDjtjFqXUnmQdJVHuCMBFgO5i1KguzzAy?=
 =?us-ascii?Q?3bT6qqGVNfVOeCnpzQH9EhedAZGDwMm88TkXCcwVk4PA7fyDcUzYyDnEmbk7?=
 =?us-ascii?Q?lF2nLE3na4k17+IZaV75LncGFHAqekTU9Y7h6xrkZ/VTe4LfnyfFM/0SHyXN?=
 =?us-ascii?Q?bqBVFVM35U6grWaKmNTavFElIm8MrjNobK7ZgHiH8u3UgfmTTY9g+pvrtCkW?=
 =?us-ascii?Q?Lr6J/e6HEW6WS0U2slAm/gEXfeo+rWuf1WqS2oN1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eae2dbb4-58da-434e-2b8a-08dccd7888dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:01:15.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msQSACY+M0qL7tFU2YVB6qglZBjiqpC6/YTwWjf3HvN5wl9kb1hHXrj6ULKTilpaFjfg+UlKtd1t+1ZTtrvLRMwdqAmQg4qZN28DzmHbrt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8210
X-Proofpoint-ORIG-GUID: sFJ0rsAqE3ywZ6utkHE6bpQYPmv6xIeU
X-Proofpoint-GUID: sFJ0rsAqE3ywZ6utkHE6bpQYPmv6xIeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050050

Streams should flush their TRB cache, re-read TRBs, and start executing
TRBs from the beginning of the new dequeue pointer after a 'Set TR Dequeue
Pointer' command.

Cadence controllers may fail to start from the beginning of the dequeue
TRB as it doesn't clear the Opaque 'RsvdO' field of the stream context
during 'Set TR Dequeue' command. This stream context area is where xHC
stores information about the last partially executed TD when a stream
is stopped. xHC uses this information to resume the transfer where it left
mid TD, when the stream is restarted.

Patch fixes this by clearing out all RsvdO fields before initializing new
Stream transfer using a 'Set TR Dequeue Pointer' command.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v3:
- changed patch to patch Cadence specific

v2:
- removed restoring of EDTLA field=20

 drivers/usb/cdns3/host.c     |  4 +++-
 drivers/usb/host/xhci-pci.c  |  7 +++++++
 drivers/usb/host/xhci-ring.c | 14 ++++++++++++++
 drivers/usb/host/xhci.h      |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index ceca4d839dfd..7ba760ee62e3 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci =
=3D {
 	.resume_quirk =3D xhci_cdns3_resume_quirk,
 };
=20
-static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci =3D {
+	.quirks =3D XHCI_CDNS_SCTX_QUIRK,
+};
=20
 static int __cdns_host_init(struct cdns *cdns)
 {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b9ae5c2a2527..9199dbfcea07 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -74,6 +74,9 @@
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
=20
+#define PCI_DEVICE_ID_CADENCE				0x17CD
+#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+
 static const char hcd_name[] =3D "xhci_hcd";
=20
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
@@ -532,6 +535,10 @@ static void xhci_pci_quirks(struct device *dev, struct=
 xhci_hcd *xhci)
 			xhci->quirks |=3D XHCI_ZHAOXIN_TRB_FETCH;
 	}
=20
+	if (pdev->vendor =3D=3D PCI_DEVICE_ID_CADENCE &&
+	    pdev->device =3D=3D PCI_DEVICE_ID_CADENCE_SSP)
+		xhci->quirks |=3D XHCI_CDNS_SCTX_QUIRK;
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >=3D 0x120)
 		xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..a1ad2658c0c7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1386,6 +1386,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd =
*xhci, int slot_id,
 			struct xhci_stream_ctx *ctx =3D
 				&ep->stream_info->stream_ctx_array[stream_id];
 			deq =3D le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+
+			/*
+			 * Cadence xHCI controllers store some endpoint state
+			 * information within Rsvd0 fields of Stream Endpoint
+			 * context. This field is not cleared during Set TR
+			 * Dequeue Pointer command which causes XDMA to skip
+			 * over transfer ring and leads to data loss on stream
+			 * pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
+				ctx->reserved[0] =3D 0;
+				ctx->reserved[1] =3D 0;
+			}
 		} else {
 			deq =3D le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 101e74c9060f..4cbd58eed214 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1907,6 +1907,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
+#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
=20
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
--=20
2.43.0


