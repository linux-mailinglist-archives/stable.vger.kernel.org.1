Return-Path: <stable+bounces-37878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08389DD33
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F222828FA
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36F130E20;
	Tue,  9 Apr 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ERlAp38R"
X-Original-To: stable@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11021010.outbound.protection.outlook.com [52.101.229.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B201304BA
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674029; cv=fail; b=tpLtxDa6pv8+JvvOsWXxglXv/WEZhlC2Ef1yyKeogHRYjf5u+9qYrrSZajhrWuc4lGbrLEPX2Hzbuv504jTP8XQRWkCV3JQQRiY3uJ1HIdER13P5u7jkly1Il7YSBngpKmoy2cBwRXu2+oh88camcYI0XZDtVG7tSQOoE84ubbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674029; c=relaxed/simple;
	bh=xx4dfL3RbGiyFlODPUo0S27j1OuBs0E3+VAx8+LRHQo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MFnNccURU9ITA1B/2HZZqgnAI1NGfVeUpEG8yXAtWHy74o4ajhcdIVgvFmcB/XlJeQeWduE4THEIg0RmDns7iqOLzxnLzJ66ma/+waqUQxIYTZ+BkhdVwsPfpiRBFWNscBaB7xckK8StSXSpVpxe52mKiUAcdGqaLGb9iRJn/Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ERlAp38R; arc=fail smtp.client-ip=52.101.229.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbDrCIZLhtaI90ZIxzNYT9JMhUSHehs91sLZxOrPEVy1XbOBpQYrXBTNSlqzOJeCxWYlhjeUdeUYsL6fW6VwTH5npfoTZ+iPAoK2Iycy4zcktv8syt6VfbjcIX8q0UO/wU0yB8r3lv3psEG1n6hi93JVR3dPOlVUP+jN6YQPl9rBZWwr18oFM2xOppOHoPYYbpearyKmQZg93YMv/HF4OkFcmVOQjEpJtgku/mSXkWcKEdl9SvYLagXFRF5d1Cns1bkz3aZkGySy19ghJ1YltM3K6+6ZdWfShOXBG3abPd4oscMGtVzky5Ki2Z0ztJVaImSHuaahIOd9higk8VULcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx4dfL3RbGiyFlODPUo0S27j1OuBs0E3+VAx8+LRHQo=;
 b=Zrnr/vGjTnbfmlopMv3oSn6+wII+cm+pGZSRJRdzQ8UQaU1vLoX0QzC3PvlWW3nxBCpVYeAdEMD/aRWT9AvbhLpDr9YOXVW72m3O/bvTifXg/oieGLfoXcd10AB4pW2dBvOD+ceTKAhrxoPnGjQ46uq+yBN1Ue8gGz/rBlEwPLjWrOe1X2tc67EXIFe5kXZeuNcM+BuiFQ5bLelSLyeB3q+lJ2JCjjtJRNeH2GqaG2DlYDGaIkuaGcSapSMhC9mGTz+OnXcEBae658oFuEuqHrCk9flF4oTV4ZoFvd9KJ+RqyoWvqVgUfFaR7I2pQ0JKv8OYriAezs3ONcc9Jtjpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx4dfL3RbGiyFlODPUo0S27j1OuBs0E3+VAx8+LRHQo=;
 b=ERlAp38RYTLnAcmIxRGfQh5mUic/TgKkofuFD89sh6Ua0oftfqJtEKIX5LwmH6FSLtwZ/KOZ2nMui/sXfVgQM9Ys4wlv/00jfW8jgA1rEfNg3PhxWXycCJBlCVmrpWZiinjS1PriMNQrMB/t1jOE8L7Y/PiDt5mgnkXPMuAVCT8=
Received: from TYCPR01MB6478.jpnprd01.prod.outlook.com (2603:1096:400:98::5)
 by TYCPR01MB9337.jpnprd01.prod.outlook.com (2603:1096:400:195::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 14:47:02 +0000
Received: from TYCPR01MB6478.jpnprd01.prod.outlook.com
 ([fe80::322c:5a9:9c63:6ecf]) by TYCPR01MB6478.jpnprd01.prod.outlook.com
 ([fe80::322c:5a9:9c63:6ecf%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:47:02 +0000
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Backport commit ed4adc07207d ("net: ravb: Count packets instead of
 descriptors in GbEth RX path")
Thread-Topic: Backport commit ed4adc07207d ("net: ravb: Count packets instead
 of descriptors in GbEth RX path")
Thread-Index: AdqKhm8FMyBHJxUoRZC9/e2ig2xN6w==
Date: Tue, 9 Apr 2024 14:47:02 +0000
Message-ID:
 <TYCPR01MB64780A9ED53818F6A9D062ED9F072@TYCPR01MB6478.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6478:EE_|TYCPR01MB9337:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eWhZ8fb6zz5hVobxtJidjTIVgrxMJyiGtAPIiINie02DtfjPrWMnbdtWxgNmhfz8E6p3kVhNbvx7Xf0LQ+TqAn7UiYoJgQau00WfnoxnH9drZEn3lb5kgLBEsfb04fKjshtYbAxQegSL+qSkJISQ70jTNetf5srG20DFwaq6gBFsxoQadReFfU3Up6fj/MT+tVQKnfw9PNavoY5ylJw2/v/Muiy+0ci4TNQjKlBvqCHRc45zfPruRNbSf1t/gyBdt5McyhOJdL79BTZT32+Ic+D+EPbe4jLWXETThdZts26ThHUcXTStszrzhFEhAv6yC2LqsrGC0lArc9m2I8JMv26zH1mNKaqmcx4TLo5AF4wHZ5XIJsPDla3qtEbHIHWK5wm7UWs7dSgiYz6nF+97JS4po4XDq+Df60gHlVBlysfGvKc0d1uXWQW+COuwwfLPxs3oMuknqeIVNdC+8GxwsFMnvn9lAdYTRCB0/TyBWm7lsoLpcBasw4GAjA4EeMTUwe5Zb9ynJhibU37TUQ5Wap1B0NhKiFRkIqY4JpRn9sW1kJyiFBNsngUogoKkaMHxfPvzGvyxSY+HOz30DHsZCsTchnC2d2imIBEXVsR3ecKKZpC3/KI5T2xYIzEF6ltzXvVp4Ht/RdWFAJovVUInPZWCKSZ6kIKOrO5HbSrHyA8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6478.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RmJrNd+rX2HgtZdL2YN+DMx7Sy6uf7YvqVzXOUHXotfIbz/kGYNFqkJMG/91?=
 =?us-ascii?Q?R2nhvuUYCRyuTN9tbis33fGNlLMK26wrYTWuHsaAg4Vepsx7Y99Lz0pVm16N?=
 =?us-ascii?Q?I5xGi9Z+0RaPeFHDYmff5SGSvOb/XpUvWDegL4cSNV4d4LoH+VzRrKieBrWh?=
 =?us-ascii?Q?Gld6loCEObHyQBFIQY9E8Szmun+YeviBnAVz7bYbRu9j+uMWDDrDwkj8ykei?=
 =?us-ascii?Q?2Ds7gZaNnrcWSFVfbO42tOd+oVetpPPtb3pc5AocDms+L/TgirERvyAV+XVZ?=
 =?us-ascii?Q?AENNwU1O/6ZPcfT2p7UXab16ISayydx1TK2fRMAQsUdvsPyDtWS/pQx1WpsF?=
 =?us-ascii?Q?zPBFnLPoRPKqmsaW9KcbKsJBCqTMnR0+EDtg0JWzQH/rZQGwBPossXerBpf1?=
 =?us-ascii?Q?j6mjFQIrPYZJnDs3YJrDAXQeQ9zwkbAIcNpKIEKupBcV8YVGig1MD1z9kF9r?=
 =?us-ascii?Q?ZsrdyuR0qHPlLjt0suuKBja5GSpYtEvbKIj9j4jBG3cWiORMPuPJLGGMGPyv?=
 =?us-ascii?Q?Kbz8uK1mNEAHCWaOA+mdKjv/6vauYNvo1mr+0EcM5x8BaM85lBkGmy79SvHk?=
 =?us-ascii?Q?xf0CRIsE9qIQhJ2hUJU7Zj3yp3hX+SCjgNe/TYMrK4ShSO4s/k1qpkwWbiYt?=
 =?us-ascii?Q?Le+lYJB6d/pQ1szVQkLBaUbJK8+iWrUA2sect0qvqhZZauyys1mY0snJ6c+r?=
 =?us-ascii?Q?ddqsZnvfVeKirb00TaUIvyMjx2w2f/BXnUJisTgvUaxz9tHE+DIODtL492yf?=
 =?us-ascii?Q?u2Em9KuiSUug/wjtJbVMNEZ2Y7yUN4EJgZXH/izb0vyLVjhDHvnl1cRFpO3q?=
 =?us-ascii?Q?aUraeR0VM7QbuSogpa+DhR3S/tVVby7eGLl5rykVoGteOHsPte4grIR9EYqH?=
 =?us-ascii?Q?k8F6FyOOQ1XrGTw0jdo9aNmfxuBdCWSWkxmE08coBH7GdegVdRlFJOolmKAg?=
 =?us-ascii?Q?7FE/41w2hzwaiJjx+aDV8yN84QaDRChdz4VjtAC7IG4BUfEvQ0wjJZBSd35d?=
 =?us-ascii?Q?8T0CvJgP0T6Sr5KdDt+A7hsngWQp89R+7YPNhlv9OaHl0/lKj2tQOtZw3KBM?=
 =?us-ascii?Q?O9L8jEt0vcKlJ3xgI2Nmj9D1nJb09CDq5LV5ENbP+RFl7mWIyr6NymnBsNB9?=
 =?us-ascii?Q?XV5TQqfuRqoOG1TtYqC8T9qGE7IJk0Lix+EXkrdYYfPOvjalFAuCigUpAOJG?=
 =?us-ascii?Q?qYv3/lPoglSefti35bl2iCYb1R7id2N8KHtg1KE2fPwFpwFGB+oqCKrcfZe4?=
 =?us-ascii?Q?NUX3d9uHn/S2fGxdzSs6bZDyL1cM/P2FWgyUPnfXvyKZJK4FfvZNR2fCorqB?=
 =?us-ascii?Q?tyqpzZ/MYTm99dtZb+J2wCt5BcXRDrHnKVRLpaSQ5dJEsPTct1A5Yb0pRX6E?=
 =?us-ascii?Q?EZ+emf3O9OYwWxCMaR4Suk3ajMgG1muYPr1PFltAEizMAv3E7uj3DOH0quNp?=
 =?us-ascii?Q?Z8fc42LPlJerFTrcWfPCYOn8MR88k57RA3OW2NiTuBGfXBxeUDTdoTg+Cw8f?=
 =?us-ascii?Q?dlNQqc91OEVjg8IwefbQ43afwotgl9QTHlWxQz38pQJ2132nvP8Z/0FyiKbF?=
 =?us-ascii?Q?kNRKakD8gQPocjTPJiKJfNZXIxgBjq9BNj3AwVhjoaTuw4kE9qnaYeExkQba?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6478.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7589b5-bd3a-46cd-ebf1-08dc58a3eb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 14:47:02.6938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcEgqU6BRrkJkqkaBfy04EUBkvcr11q+bSxc/XeXQ9TBjbD6SQxgrCpDwtaTBEIS4EX0aUDqRSQkuLZRPVwR9xJN41VwqWgMy6D6YRvFIMtTkIdzDGtdtYnxav2vuwF2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9337

Hi,

The commit ed4adc07207d ("net: ravb: Count packets instead of
descriptors in GbEth RX path") is a clean cherry-pick for v6.1 kernels.

It fixes the value returned by NAPI poll method. The NAPI instance is
serviced based on this value.

Thank you,
Claudiu Beznea
________________________________

Renesas Electronics Europe GmbH
Registered Office: Arcadiastrasse 10
DE-40472 Duesseldorf
Commercial Registry: Duesseldorf, HRB 3708
Managing Director: Carsten Jauch
VAT-No.: DE 14978647
Tax-ID-No: 105/5839/1793

Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.

