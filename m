Return-Path: <stable+bounces-146394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FCAC4630
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9101D1895C22
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634DE189F5C;
	Tue, 27 May 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="eMa6ZuGH";
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="vfk0bukm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-009a6c02.pphosted.com (mx0a-009a6c02.pphosted.com [148.163.145.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B011F956;
	Tue, 27 May 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.145.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748312637; cv=fail; b=ProOV7ZZeHV2c44Ky8mHEMSMNUKw0NhO7ab+oWTbn72GmXW5ZIRjF1Y1gxxUcxZogB/HC8H00AaFwlMb4rj1L3O2AWQxZE6D6SHjDU/so8VkSE+87iI7SA3qgZppSArDAfoOBlQkyuNKAF03Z9pqblwyUdZMXBglTJQFAXSEcYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748312637; c=relaxed/simple;
	bh=qsBt1TYLYHi9KvYp1jubb0pSz22aZEqId7ya45doAkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ifcfMkQKgwK/veiZ60FrFX6Kwob96nHykMBen12gT+bIS/Sys+lncbQVRN0CF9NvOO8xR6ej75Hskmps0xGNgb3e0m+Wk5ISQ8TYvMWlOF+i/2brmheabrJE62Fb8FmVdnC8wfVPaKwD908vXIzHNj9aaaJDP42r24iwWQEVnBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=eMa6ZuGH; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=vfk0bukm; arc=fail smtp.client-ip=148.163.145.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
Received: from pps.filterd (m0462405.ppops.net [127.0.0.1])
	by mx0a-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QLipnO022243;
	Tue, 27 May 2025 10:23:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20250420; bh=3
	yGvbEc146X6TVGlj8nnXS6zaF7LqRYPL6Yag8Z0VNg=; b=eMa6ZuGH4Z3+hxvWU
	25rZ8gO1bSXJYRqU2m0keCQSkZHNyoZuh0p+gGHH5hqZ+8/qhLjDSRbAYh65foKY
	OPiTfHBXW+yPTFZBwQh89id8kZGWwRYCuDHx710szz4BfjhePzIotMO7awMhEbzW
	GlNMpgSoECtUNguwMnP43qqQkf6sa9bthAJdsCA6qCLbfIIZAfXj4HXGDeg3j/nl
	4fgMgFR3R40KVrGajw+cLyyahVY8Xn6ELfHJlLk/R641PNkx7nnPcSbsJUB5zKhh
	X5Fw0yd/c5AGutuvFl7qoXylZyTbpC1XkAIEnEKAn+gIpGlK+lHa+z0Wh/CwVY8v
	UzskQ==
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazlp17012053.outbound.protection.outlook.com [40.93.130.53])
	by mx0a-009a6c02.pphosted.com (PPS) with ESMTPS id 46umwf9yny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 10:23:28 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHXcsqEgjtNxSgZp5g912maKI5Yo2ucVFlEuv9n19TvKe6k/kd0ffEgIKZR0D7Cs2RPoDUBwD0t3UrpzX7Wt8CwTvCeBxHU5febapCOl9Gc70TTz6o9ZWhFmZ5MdQv5JCG+aEpizCmhYCRJ8jVBW0TcgdX6cCpjbFYwcxez5cP1mAThHZL+5GaCHxci+IjAtc5Q7wcQ6wllwJtbs6cAvFIWewKEdAcGjRQZtJvsZAkao38tSnbmbqOieuF97YRjpoRUQ3TnOa+rqvBn7wj0LuUH6PnCGjNIj8pAwYZTKgmgTjyqMkwb1WhywJp1Gq22r2CYUuhs5apAglBSlVo76/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yGvbEc146X6TVGlj8nnXS6zaF7LqRYPL6Yag8Z0VNg=;
 b=squm7O0XjSoh2hE+9mo/u6oRq3m8EpyNcO1lEEdIWs+9xXKesZVaPS9xQZg9PtfbNbgK0rpR2hbzS6ZdRfTrjOEL70+sypTlOhHZNgwew21lJ7TZxZl/NyTLezLfUO6ypV3uWYUV9NogIQMh6cFNgwEFtLtnIYELmG/OXH6SOucvdfZo4mbrn1m2In+dLkro6iu7eSc6oE32W5Nz8Sv9zHf0TAQs46OneswYGoGh+T35OWd27U1iHEeH1y+rHB2lp3RbaaV/2X4WHLU/2/c0YuXZlenMOU+WGyXneWK2wOB8neuon/E95uFUqQ8JH4lK31ki+nxGeHayBHBlL7tSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yGvbEc146X6TVGlj8nnXS6zaF7LqRYPL6Yag8Z0VNg=;
 b=vfk0bukmqXy5xLSej52HIyDuu6hw197X47QxSLz9yUU2d9qVALsekOg1QtRn0tFcm0+A2QEkC3NYXw2R6hymUr02cEqvQYK4u1aUQJqxzGFcL/wO69U0q1e9vQEjDn+ci02V6R6NqAVQGJ80GTsACcKEq11HOah8WUVTxxBi/QbOY9VlExbbkNTxU3fB4UwC871UY0iUC1NcHQFcPqe3V5BIZ8RbZPHjERXGxeO7VR49veFgHzy3FvhelkLGVjO3tMDP+NdyQedZRq1bTRcyXX72pYm58E4WQDWNQHlI0N3Uh44bPsyrtD2NuwYEEux7zlMginI6CvxDx3BLJy2dVw==
Received: from SEZPR04MB6853.apcprd04.prod.outlook.com (2603:1096:101:f3::12)
 by KL1PR0401MB6491.apcprd04.prod.outlook.com (2603:1096:820:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 02:23:24 +0000
Received: from SEZPR04MB6853.apcprd04.prod.outlook.com
 ([fe80::2671:6554:520:7a2b]) by SEZPR04MB6853.apcprd04.prod.outlook.com
 ([fe80::2671:6554:520:7a2b%7]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 02:23:24 +0000
From: Jerry C Chen/WYHQ/Wiwynn <Jerry_C_Chen@wiwynn.com>
To: Paul Fertser <fercerpav@gmail.com>
CC: "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Samuel Mendoza-Jonas
	<sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Thread-Topic: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Thread-Index: AQHbxXQ9unMxMxdDJEejGFz5av66RrPTZbkAgAxVnECABa+KAIAAZNLA
Date: Tue, 27 May 2025 02:23:24 +0000
Message-ID:
 <SEZPR04MB6853F47821DED8F259FBD975B064A@SEZPR04MB6853.apcprd04.prod.outlook.com>
References: <20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com>
 <aCWuCPsm+G5EBOt/@home.paul.comp>
 <SEZPR04MB685354203C242413D1EBE96CB098A@SEZPR04MB6853.apcprd04.prod.outlook.com>
 <aDTL0uWIgLRgyu6s@home.paul.comp>
In-Reply-To: <aDTL0uWIgLRgyu6s@home.paul.comp>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR04MB6853:EE_|KL1PR0401MB6491:EE_
x-ms-office365-filtering-correlation-id: c782c3e7-a98e-4407-e4dc-08dd9cc5752d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o8po89lS9EE1RL/heVegLyrUFC92DkMzhLw+TyqYGXcBOngVDH3b2reMeWRS?=
 =?us-ascii?Q?aUkuXY7IniTWFoPom0WCCSa4u3k9T0ZcpwVCg3wpeMACiwoHLppzBFEe3JKS?=
 =?us-ascii?Q?5BvcbGPYk0Tsw84A5nbmkg9puIItRK5NMWzfyIdFquA0c8La6lKmrxqx12O+?=
 =?us-ascii?Q?O9ypj0Aasw/QI3aFiheQyZga9BJuiHGktbdOTPODBvwgQG959GEAub1oIGwE?=
 =?us-ascii?Q?9GisNWTRWn2G43wv4sIYE710h+l+L3n0maSRiWRyHO0q+vy+T6ZjXvONKelV?=
 =?us-ascii?Q?FaJkcxtfOFHJleEnmJHjR5Dt3F+gw2zWHKINdmyZG2ZeHPbn+Tqy+KYens4R?=
 =?us-ascii?Q?m48MyS2Qm/d97cquhYvY3As/5qHEMzxA1JkYnyGzftMTJxg/qvQc0hMFAWcj?=
 =?us-ascii?Q?mhzsyS+ZRUdxB/63neDreRWOMnXdxp5cV6O1e4gs8usDcdHWBvrX0Q4jCPwX?=
 =?us-ascii?Q?ND7qRb+QQ59Utbo5tYjCngiovtiMSUiT88kARcv8fH1sgg7rnIsfHcuvPKif?=
 =?us-ascii?Q?dCkrktqReINPxbrKi3ilyO5rGC7ngfbCm8MArm8Vphx0PHcKe+z0aFwjKXju?=
 =?us-ascii?Q?sDKpWH9XnJLDQq2wYYXuYEvoGoz/07qsElhOrjFD/VWAQ+ALvpQf/N+MEKm3?=
 =?us-ascii?Q?iLCXXiyjK8y/w75FHzX/SI238WeRhlU3wQy90GOZjIyr5Ot2Gj1dFFbcytUB?=
 =?us-ascii?Q?U8h2TcApFAIX5Ty3qWEtkCsDROgVM39zNAbYTTfknfdC9pT644ieEjpGLwgI?=
 =?us-ascii?Q?O5M3M4bTSx37PPS7mqvOhb2K//GGBn7qSoxtKniGXnJwpR0IasJ5bcdg12vs?=
 =?us-ascii?Q?ixsCJ+trn8gm+8phzlriAhgSbsonsu1FxEZ2vAZlb1OIo9QsbhpGJKxo1poh?=
 =?us-ascii?Q?dgtC24iouYmmpif4bYWu+BthgkmyI5zYdayD7EGTFMslYOSU0J2ln8k5dTkY?=
 =?us-ascii?Q?B12JNvaiWw67FEeFf37k6G9FIvozjoPhnzs5bJMOlLXimwChNotDOZeKZNhB?=
 =?us-ascii?Q?kQlx5AVmTySsDF9WoIti+oOX3DkO4jDsbvncTyNfEfoi/oVP9lSrMGUJK3yV?=
 =?us-ascii?Q?CG8Xdei/gyZhKiWwLdNY93xGOGUZAP5kAnsP8bE/+9rQbfqcGM867szz+bP+?=
 =?us-ascii?Q?/LGOSWWLTggXOp8bdUdzOqCgn8xN6WVcmljdZ+zNU/LfBxo7KJbmLngWoiQ/?=
 =?us-ascii?Q?A2rBQoAGboKbDo+X8CBdT1YzfUbSss1mgCloh319NLtUbuVkBLbAKe00K6BH?=
 =?us-ascii?Q?Js/pTQ0unSB1M4HbjFW8/YHn8/D9vVIGTeqJxLTQK63T0rCAUZNxFXi663kt?=
 =?us-ascii?Q?csjEqWXPGJA2EUPGkhSHQXGQzS2Z4BakRuKgSeG8MXlCV5NWnqOOSNXPcw65?=
 =?us-ascii?Q?dWSgML1HdOKRGA0ShcO7BjE23aTlZoKVmE3lASVm5T+bw9l9xTx7G6dBp5Eb?=
 =?us-ascii?Q?k1+BJt2Hl6pfpk+Ydto9P8E2x3lfobrn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR04MB6853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vw5igalryOlpOOgCAHwK+yeLFArOpwrkTJEXPzp+PCGsaXDCRFuHEeL+OY4h?=
 =?us-ascii?Q?AyclqSUrKblha7YEnG+PwwVqgSjdFh1MRDHI6CaVIUwaflXbzedBRxFLN2y2?=
 =?us-ascii?Q?KyDXnzqqeLT0TBKc4nJX1PMN3x2H0DLtBaxPYSwrqwm/EzDQNQ64ffLwtM6l?=
 =?us-ascii?Q?93UaGsrX4VOSDow3jgYXJpNHDvMHfafUGWlODiBSMn/c60zKAegdgWIPXxjK?=
 =?us-ascii?Q?SY17t3/MU4X9ZkbjSG7Acjuv3oeDG6WypplFBJPa0gQD8ygY5c25vX337bIf?=
 =?us-ascii?Q?HZA131vS1m35xBdAB9HjODs4PMK/M9UBUjvDLPbUsGAQuilgDLqu8kETlLGV?=
 =?us-ascii?Q?oqPeO64KRMrvKs2+N5NC4VjCp4WjdFe6TuUt3URLBwoMklA91czINNZMFSeE?=
 =?us-ascii?Q?1anQxD/Lx6f7+RoXV/uDHp913cLkqlJZd25m2C/xYSZT7X5rdhJvkOKCz5U+?=
 =?us-ascii?Q?OzD12y9RhlSQldIvd3+lWw1xhBBnDVu9pZhu/NzQ3m0V7x2Ch5RI4KV7FYme?=
 =?us-ascii?Q?BtnRz2yHoIF6G/R6waFo+tE4hpHOXubGwwM+L74n2rI2nX4qt0DT5Davnf3k?=
 =?us-ascii?Q?ZBPJrE3aiNTUMDOEKwkLtVE6IdHTW03XqGSypNmgTT4OCOu0sp5bW8qH9Eu9?=
 =?us-ascii?Q?85NS32w62cJ+lpTtNmioX0M9cH/B1Q1GMOescHABq3gc4aVaUbfuBi2+gI7U?=
 =?us-ascii?Q?eHSaG11QlAWG+bWfQ1WaH1pZCtHcPSLI0F6x1J8SKzSpuY0K7jh3p5yismod?=
 =?us-ascii?Q?yjWL4PAJbUIpdwO/6UzjINqdceuvoVV0LiGKNgrok3GMm7Hm+SiiotzjZv4J?=
 =?us-ascii?Q?54/XUZJFtewcwFON4sSGUJOlHA/gsR3A+ch2p4vDmI2hPVjIOKIDadLPJQ0t?=
 =?us-ascii?Q?dKAJdwaDDSlP0BbaMSbc3gK79ENemEBejgypdMX/V7hnBbeHmaCXAfKRFd4U?=
 =?us-ascii?Q?wQJ9MkNUz3hgNWQxS5yR3QEAjrWDd1iPz8y6uHX7tA4rsTc3caqRH+6DnyEl?=
 =?us-ascii?Q?+jhJEkOCeXAT0hNpJdlzfhVjsUQWPysPk1EBlhPblAg8Naj1qbPj4vXTHN/j?=
 =?us-ascii?Q?+0abF3JSsra8v+QdJvU9968q05q5566xpBRPb700/NPLFs7A6nlMF6lpzok4?=
 =?us-ascii?Q?6CvxYl7LBV9GLj+1a4xmFCDPJ7Bf0lKTTSxJuyObwB/V0tnJy3eNaDydMMBc?=
 =?us-ascii?Q?r/hOyynBCMGMbrmQUqwr59LFkCNU+xkLJVPzd/5/hA7IPKwDD0V1hwT8E7F2?=
 =?us-ascii?Q?bpsMaeUu9QdfB2bAkRTD7aHHekNo9Vhh7CNGiA7s/xHejtjEZMgs22VQ+mSr?=
 =?us-ascii?Q?lwmMFn2jaxZSC7hqTuiudoaR4I661RCEuMZqzS25lFzkb/WnmAxjpDnxham6?=
 =?us-ascii?Q?hdMSXvE2+BSe9A/TYvYkQrGHbmtNfWaVnj4YUPhYnBNK+WXwSixpQ+aGZBxu?=
 =?us-ascii?Q?ZRlKodEs49jsU1zoGotuj7VP3jpQeU4zgvJk60IvLJXW7k2r2X6gLfh/5/70?=
 =?us-ascii?Q?CUgmJ4/cCpkU995AV8JQ5lP0CNcD5curR9WbD71Ud1hVvOp53FaB+NebPsR7?=
 =?us-ascii?Q?0hrW5gao1QsepK94n2zJU4Ds4UnrHACx2zqbbqCY?=
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
	ZpRby3fwcwjJT9OJiimasR6o2rNSsMd83+ayWIOqNzHkwnuKGyH5HDMlT6b91y/zjBwDSrZbJLsxi4Q1mpqYh1nPQ15a852BHJ9QKdJSzkfStfPpCIw17BhEzZRYBFBkzMEXVsZbQum8K57WxFl9wYjMM6VHLuQM1WTpjyghvrNXZumnnNfVtYY1IwcOWh6Nj925Vho59BdKdzPb3BT1XGH6sYi0Hcy3ubbulkVjq7Xbu2H0kWZgeLG+BwmoiV8VzVlmhXVzdfnFhYmKUb+6YzEM9myBrwzm5e9e+IphZxrqnCDgKWPFiPBby3gib8gHArzkrsO/19tDsl0OhRzIpyWrg2SiOl3wPC02EO5zfIZDm3YJpyCMJT8JBKFEUOtgq7KHOq0HBSFrh/B7Rgulhx3/jUXSwhNGVrLNnLYvtzL5TeK9sGNPB2GlKXNTTRnwner8wY08pj6tbU5SCKMth3Dzw+c+/J8WX47qWAIod/4ifDkOv3OCj6/elkhvRKQxPWSoeCuJxWdROk5KumIb+85Cwu5xBszqxnOHEpgOCO/SEC1CUwISR3nPYIvTPG1r1InTJquFWWvn9qxgH6g4UJpPcuBYgHc36CUQopi0uLYpqGlP73UrUWgGGqBrc9aK
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR04MB6853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c782c3e7-a98e-4407-e4dc-08dd9cc5752d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:23:24.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRnI2YIlKhbHWEl1X9aCsByDguKRlLEWOYNBCloagJ2nIP3RdQdp/jKfcHo6tDneFzwzPTxcB7JKEm6sL8OpNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6491
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAxNyBTYWx0ZWRfX8/+J0EqGWtuN djEZ9xOjf8y8gHdZPV1TXodBrWhbnqTZXeX/jJNfDgiC+JT/qrLR1UXUt43fTpWzmAp60e3CfHM 4F4Y5SCVJQTEaal2GO5/076tVw5VH3IgLE2YEEcEKGoFRprbuPRD7S9qmZH/iciaj34kKv86P8O
 zjzGFSKqzu0olBJBaQN0RvKp4qgWpXWRN7tLk3LHvvuNCP8ZCZS8z/KRjTQvcMfvcjkpguDkPM6 x4lpAUxgQ3JOfeHFEtXD7eTLkPU2Cvbxq6p7DTjtVcRI1KDqzj7f+0RuoQ59C4/QIivYCCigAQ1 SuvyyVVYHmtiU930Cc3avFboRtHTpbpqlMPOWMYSxdv4uPqiWlyg+hYjWueCQ+z45Ra7JKue9RV tKnUBE79
X-Proofpoint-ORIG-GUID: mZyWRwp_fR30oLojVGKYxzZv8sCD8nnM
X-Authority-Analysis: v=2.4 cv=KJhaDEFo c=1 sm=1 tr=0 ts=68352220 cx=c_pps a=1dhF/aCiZyYTsCmGNFLrlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=4AL28aEVfeMA:10 a=9R54UkLUAAAA:8 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cPYzWk29AAAA:8 a=2VGnaFk_AAAA:8 a=jT_9lS9cAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=mZ8fZHlo70N9ZKqyl70A:9
 a=CjuIK1q_8ugA:10 a=dWnlwYyMHzQA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=oSR2DF9YFqZEN4IGatwP:22 a=xuWaqJMTYXf3QM4Ho2sr:22 a=Ec8Bv2-zM_L_lWdDgjzK:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: mZyWRwp_fR30oLojVGKYxzZv8sCD8nnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_01,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505270017

Hi Paul,

Thank for your reply and suggestions.
Since the net-next is closed now: https://netdev.bots.linux.dev/net-next.ht=
ml
I will submit new patch(new mail thread) while it re-open.
BTW, seems the re-open day is wrong: "Closed until April 7th", may I know w=
hich day will it open? Thanks.

> -----Original Message-----
> From: Paul Fertser <fercerpav@gmail.com>
> Sent: Tuesday, May 27, 2025 4:15 AM
> To: Jerry C Chen/WYHQ/Wiwynn <Jerry_C_Chen@wiwynn.com>
> Cc: patrick@stwcx.xyz; Samuel Mendoza-Jonas <sam@mendozajonas.com>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.kernel.=
org
> Subject: Re: [PATCH v1] net/ncsi: fix buffer overflow in getting version =
id
>=20
>  [External Sender]
>=20
> Hi Jerry,
>=20
> On Fri, May 23, 2025 at 07:32:26AM +0000, Jerry C Chen/WYHQ/Wiwynn
> wrote:
> > Sorry for late replay, it takes some effort to change company policy of=
 the
> proprietary.
>=20
> I can imagine! However it's not necessary to send patches from corporate
> e-mail address via the corporate mail server, you can just send from your=
 own
> personal account with the appropriate From:
> specification to attribute it to your corporate address[0].
>=20
> > For the questions:
>=20
> Please consider just using standard inline method of replying in the futu=
re,
> letting your MUA quote the original message for context properly.
>=20
> > 1. What upstream tree did you intend it for and why?
> >  - Linux mainline
> >   We are developing openBMC with kernel-6.6.
> >   For submitting patch to kernel-6.6 stable tree, it should exist in ma=
inline
> first.
> >   Reference:
> > https://urldefense.com/v3/__https://github.com/openbmc/linux/commits/d
> >
> ev-6.6/__;!!ObgLwW8oGsQ!lfBTzKPEhZloN2Uwc85U1tsMWw41Yq8dTkG9oxjckT
> okV1
> > 1cR1AQaKFRrIwg9G02e1CpUC_SUX9aFCoEREqXU-Q$
>=20
> Indeed, and the process of submitting to mainline implies that for each
> subsystem there's a tree which subsystem maintainer(s) use for the integr=
ation
> and which is later offered as a the pull request for the upcoming version=
,
> usually it's called {subsystem}-next (also such trees get tested together=
 being
> merged into linux-next regularly). I guess in this case you should make s=
ure
> your patch applies to net-next (and makes sense there). Neither the curre=
nt
> submission[1] nor the previous one[2] were applicable (see
> "netdev/tree_selection success Guessing tree name failed - patch did not
> apply" and indeed I tried to "git am" it manually to what was "net-next" =
back
> then and it failed.
>=20
> > 2. Have you seen such cards in the wild? It wouldn't harm mentioning
> > specific examples in the commit message to probably help people
> > searching for problems specific to them later. You can also consider
> > adding Fixes: and Cc: stable tags if this bugfix solves a real issue
> > and should be backported to stable kernels.
> >  - This NIC is developed by META terminus team and the problematic stri=
ng
> is:
> >  The channel Version Str : 24.12.08-000  I will update it to commit
> > message later.
>=20
> I see, thank you. Sigh, this 12 characters limit doesn't seem to make muc=
h
> sense, too restrictive to fit a useful part of "git describe --tags" even=
, but it is
> what it is...
>=20
> [0]
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/proces=
s/
> submitting-patches.html*from-line__;Iw!!ObgLwW8oGsQ!lfBTzKPEhZloN2Uwc8
> 5U1tsMWw41Yq8dTkG9oxjckTokV11cR1AQaKFRrIwg9G02e1CpUC_SUX9aFCoE
> FjZPgHI$
> [1]
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbp=
f/p
> atch/20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com/__;!!ObgLwW8
> oGsQ!lfBTzKPEhZloN2Uwc85U1tsMWw41Yq8dTkG9oxjckTokV11cR1AQaKFRrIw
> g9G02e1CpUC_SUX9aFCoEd6rkbGA$
> [2]
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbp=
f/p
> atch/20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com/__;!!ObgLwW8
> oGsQ!lfBTzKPEhZloN2Uwc85U1tsMWw41Yq8dTkG9oxjckTokV11cR1AQaKFRrIw
> g9G02e1CpUC_SUX9aFCoEVccOzuI$

