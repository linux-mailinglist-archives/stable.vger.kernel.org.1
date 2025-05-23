Return-Path: <stable+bounces-146170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB8AC1DC8
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150311BC730D
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 07:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781C221260;
	Fri, 23 May 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="BfSLr7By";
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="EdFxhhGt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-009a6c02.pphosted.com (mx0a-009a6c02.pphosted.com [148.163.145.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CD20C47A;
	Fri, 23 May 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.145.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986051; cv=fail; b=kpTS0Z1c9k5SIuhA4HxhiFoV5Pphu0VJcpOoFb858+KIzjq73eSuInxw9S4/wiOx3bqRENCXdUgO44rkFF9/oZZ182qJ/BDE229rW9Y/S81NqCn7OhlNlxtXhFho1oqzhCRPI4uVOgygRHkenHIG20EQT4g2gNkQginqslh+ve0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986051; c=relaxed/simple;
	bh=zTZpB2kN0MgYmjemU2VPPfZsRPfnwaCMf7aF9oe+sYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0zS6rLA1iQfCddLcGUC/Fq1h6QIWHgx6XVa71kE+kFhm5Bbi+hMChVM93IRdDE1amXSH1+9qTLH3B3svJJdF1VAs2qMKw0lyvXUgk6Gxc/mEucZkR/1MXxrwioJBf2Bi32SyU6rYUsQp6x2FmN1R9cjF/xaFHDLgL9Seu/7yoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=BfSLr7By; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=EdFxhhGt; arc=fail smtp.client-ip=148.163.145.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
Received: from pps.filterd (m0462404.ppops.net [127.0.0.1])
	by mx0a-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNskHK002164;
	Fri, 23 May 2025 15:32:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20250420; bh=4
	wCbHCYqha3yMqSZvL86haP4dYP0y9XjdURhp7QNOTc=; b=BfSLr7BygcFIQpQnW
	F0E9uBDcvQFbJnF5Aw+YDS2RQYQkmVBz9yUcz7r9M4+njoyriDqkfY4cNnlrh460
	koOAttUXZbor8PPRa/cV12CzPLD/ww7y1lK0wE9QvUZa8t1HK1p9iGqgcUm+aWNn
	tBfTp9mfvPyAkVz/FBCRQ8RXciUwSJawLAPyXLgOUXX1BTFhWugvyzEKlvRBwXVL
	IP9HGSHenyA03KsD6rw8Usa5jABhEOzzgKGq/phTkc2AR0PQ06K7x/3FYRhvCl4n
	/Lsz531dk/R40cUr1hcMU8t6maMtt7XPTKU+s0rBnrO4fg0eDM0//31HvczM3a+V
	zNyYA==
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazlp17012051.outbound.protection.outlook.com [40.93.130.51])
	by mx0a-009a6c02.pphosted.com (PPS) with ESMTPS id 46rweyud7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 15:32:30 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1VAAw8dr1SxWVmzRYnxDhYU0tHQR9FcOhlN5EPWqaetzy4SAO+AoFC2l/4vkKYLlYCRbe/Ob2MRLXm+wZHYBW8+qU8FxEXqFnqDq/i3Re3JhF8Bpe6QrR0IRNxFDMxmh1mRVg2I64KvjF51S3NcyKmwQ23WhbkOBy2SkVAHa7jdavCDiN4jko8g6fvpFa7iCfK89KQu+248ftzy/RaoILOe/JCzYkcowxKAf0WLBTy8RPNRUrZtcdWhMFsTOyaY2v9TW/K79ukXQ+m6AJZcQ2jYz13M5wfVDOKlPfvBcBadiQYAfcTobAnyylnCvxr4cJfaKf8L4kFtkv5/SfRHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wCbHCYqha3yMqSZvL86haP4dYP0y9XjdURhp7QNOTc=;
 b=FQCN3hGqv6gcTQD+6i7jN3trqttfJ7jJz456vwLx6MoYhZDuSZZuy+zbUT5VqdckqwMAK0dHld0eeGJDv3RQqCnZ4cEzyAAnSkB+sPoFEakH/ifQwD6Hj/AiG47aSP2rBV2ESUmpfAQ4Jc1ZCAZR9ID1VH2sPUy85bvviBCXQOLKYXHau2hLpx/vNk/S5nBfjaC9Azc/VAnW31WQ+et801uL2pKCERYwVlhNv2Y7jIftOKiQaZlmdsUs/cYwaSyNg18IOOQtZseniP8vCYuqlP6ZpKLdNC3wLAJH5+kpfozydQ238PvQMeNa4s2QV8bTmiNgryB3DZetgZNElV6tJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wCbHCYqha3yMqSZvL86haP4dYP0y9XjdURhp7QNOTc=;
 b=EdFxhhGtoFD0RBknTozGLUVzN+m4XjZ3TxRWt+pA8RlgMKJ9HQLGmbLjZO6Fx5nBXjemr7aKZwxvMzDwYzwG4Cj1e3ITM9Qzj3Dqs6HgbOjaYWbZDWgKGBzAvPVL35qzto1chATsZqGVGIkhhTu3vi8Gca8e/z/3N5dlWlUC/V3JSMU3Md1NgCwdaTU7AL0ZOUQXxFVWNgnvk+L55l4icPJY0AGkA8j1Pe9S7eyHWfl45gaD/sm/PyFNGiTVQZ6O5CWzmnPB9c/RHevV4Mqn0XXCUwIVnRDw/kydoUU/PslDw33T+/yY1uRdjwdjfI67p4gysI02wzTzLxNMPgbG1g==
Received: from SEZPR04MB6853.apcprd04.prod.outlook.com (2603:1096:101:f3::12)
 by KL1PR04MB7707.apcprd04.prod.outlook.com (2603:1096:820:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 07:32:26 +0000
Received: from SEZPR04MB6853.apcprd04.prod.outlook.com
 ([fe80::2671:6554:520:7a2b]) by SEZPR04MB6853.apcprd04.prod.outlook.com
 ([fe80::2671:6554:520:7a2b%7]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 07:32:26 +0000
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
Thread-Index: AQHbxXQ9unMxMxdDJEejGFz5av66RrPTZbkAgAxVnEA=
Date: Fri, 23 May 2025 07:32:26 +0000
Message-ID:
 <SEZPR04MB685354203C242413D1EBE96CB098A@SEZPR04MB6853.apcprd04.prod.outlook.com>
References: <20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com>
 <aCWuCPsm+G5EBOt/@home.paul.comp>
In-Reply-To: <aCWuCPsm+G5EBOt/@home.paul.comp>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR04MB6853:EE_|KL1PR04MB7707:EE_
x-ms-office365-filtering-correlation-id: 7d3a55ec-5dc5-4f1d-be42-08dd99cbf74f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WsHvE7ypwn/b6ggIMJz+zRQyr8QGinr/QGKKyDqb76zCvPbAeT3VSDrwdfQK?=
 =?us-ascii?Q?awFTsf630Vw2t5kdOJWmAdmljhQ0fbmiARCdLMHtO0AKw9LsooxgTnu9p6uw?=
 =?us-ascii?Q?h+/IYxBoao1SDRYRmJGyOEa7LW9wvWFJjsM+ixyCWPFKASWFj8LxDhnN3qsA?=
 =?us-ascii?Q?ecpWEIwUV4tbUy4+hkaU77BCB6SOr+Y/uAX4EZwsqZausLoI+930c9q1/yGx?=
 =?us-ascii?Q?7Rw4QWW/hB4KBYFFSkGaORQqRCeqAcjcrUZ/sgmQD/jw51tu+b4Q+y0dkCVs?=
 =?us-ascii?Q?8LvznE8EjcJVjPXpy+iPYcjYQcFX6t8+xytYCrlpe9cwl8u1Uv7tVU7XnTab?=
 =?us-ascii?Q?Oo1Tk46tTliqczKv8AeUyjxe4BMuSAuFgkSAl38Po0gsF7ZRr0+iRYvjTaPj?=
 =?us-ascii?Q?mH2o23+jAxvgPct5wIZJPJDWFm7E8FB5ZTDfg+04VXwGnP//1T5YmuWoXks2?=
 =?us-ascii?Q?6u/4iPWziJldCMRFAddyFIz7bEYL/AGCN4JGEJTbxpYfRGMHyGWXnC6qEMSS?=
 =?us-ascii?Q?EZN9T2QyHT383B8DUrcudOcHqjV2r2LwS7WpKtRIrqGaslET54kXWCQE5ED+?=
 =?us-ascii?Q?IJRFIygQepy/GPiOLo+IeL4Rpb2MV1o/6j/wid6ly8UJ3HilkDxG7bDKVMRW?=
 =?us-ascii?Q?2y3Vn364eLq5p6IlVoytJ9oeaBBv9JB/kV0FRMQ72m7GL3+9zM5lQOdnfG7U?=
 =?us-ascii?Q?IHFg8fH1kVIBV0FicmxIYFP1HddpE41l+WQCxVunnQjHRKOP5IZutN5AoU4j?=
 =?us-ascii?Q?xYvvm5aLcZILrq1hapTfqFMJOmKKIj6IDjd8swxOuDuMXp2dK8WzM7uCEqGM?=
 =?us-ascii?Q?ZGJGigjpVWc287L6Al338BUqWhHcpq9MM1F9+NB93bY+NG1nwkVXrBv44BBM?=
 =?us-ascii?Q?YccqI11nbMTpYf9XN9cvar91vpLqQLETIP6cqWlbv1QQ9nYCo1+Nm1kmoQqf?=
 =?us-ascii?Q?HbngHh7P8RlvRfPLJKgKxhjzlRYo9EwGc7ZHk2JZxDfcmhAXJl6PjTs87dr5?=
 =?us-ascii?Q?YtHiVmeL5rXU8d76rSQjqiamI3lTl9nw/Ac3eZp+LXBiImhRAGk/qqfTYt10?=
 =?us-ascii?Q?UQhZg5Hol8/w5ksIvO1e8u/mQhJpVny6gYnYC5hMmUiaXgdw/t6LMx8pmsIv?=
 =?us-ascii?Q?inj9Zyeyz0611oigjyZeqPKKLbcyQLRH7n7q68dtSjKdHMsQ0yqm9KH8HOr/?=
 =?us-ascii?Q?2VibqjXDWTsANwEkMXTF7VsTIE26Y/wnsjHPc66BAttofjZB184r7ORoN2IH?=
 =?us-ascii?Q?ZJ9bLjxttktaCPMAmnQrDCvZCSjpNE5WopcQDqHk/Fe6HANb8VV8tL3K7uXr?=
 =?us-ascii?Q?TPDuz43+cTkSMSPzaKHqgBsQ76hYwpyHBF6IHJ0YXBXnundFBuujPLWrlY5g?=
 =?us-ascii?Q?O+90WyyfwUkfkH3FPMgg2XbS1I/q+cQqacn2RFdTUTI+ESIf+Tl0WqjXM6dC?=
 =?us-ascii?Q?eJEADTBrEeo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR04MB6853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Odlm37iOGyd6Px8MuTmyziMXTwRse1RGWbgjwIcqUEKLiXMFoIQMUST68uj7?=
 =?us-ascii?Q?5E0HpDD/Rs67+yj45CuJGSUlNYsYtl4EeJJV4F6jw+695RV07CUf6+OBN5MD?=
 =?us-ascii?Q?rlKJfBbYRqKOJ8pIU/rYBnN5fhhYQAhni56eCTb5XuXdFADnGw3fITFQcOTf?=
 =?us-ascii?Q?I7LAiqMIi3z0ye6ig+o2ZRpw0+3Cdby9eL4aa0EkAmcXzqJ23ModR/b6ijGG?=
 =?us-ascii?Q?9Ztg3pK9VgsYy+Ujre4R/bvB+lnClX4MMEIpMguvnpKrtNwAhRgj5hQOcuAG?=
 =?us-ascii?Q?q3blE1Dk8AhLfb32pkV67ZYEQOitPYhyhDEzrww+gwvXaPLCIPTFLH6JGCje?=
 =?us-ascii?Q?r24XcCeafU71t0gXByvC3ca9fbcniNL+JxlrX7RL0e9ck4J8be4BYC0VltoG?=
 =?us-ascii?Q?yDQuxnd9PCS5pGmvjsnio47PI6thCvE9GiakGJ4BWbIM0IuI3J51AZ4mdxEN?=
 =?us-ascii?Q?FUMRg+UDQSCCccOI9kulc1GLlsOJS+Y8XeWiMO9BB523Eg5ILrZo5GUg+X4B?=
 =?us-ascii?Q?wVnKScKIdrcDSirsI9F0heH21fKw6cmcwSG53pB5+X/XtHeMw+LnffprO1Op?=
 =?us-ascii?Q?mx/Vvbmyw/NA8gR5zO0gCMgJuJhQUTbq6Ak6Na5Slm8JP9dYCkCCozTwLUvM?=
 =?us-ascii?Q?vOK/HBbq1jaUSxmjzo1leDBoNePTs6ldP/rKi56dabgKsmbuVDFPKDjNY0PV?=
 =?us-ascii?Q?SaeuMRrGIcTXz6pymLYuB037wUBDS0Ht3SsKVASS5DlWPCE1/zM+FkgJ2eno?=
 =?us-ascii?Q?8zvlknDew9xNdfIhBD9FsoNzmUrw/slucmY3pw0xdi4gvh6rQm3zQ8Ogu5Im?=
 =?us-ascii?Q?S7GS+UBEpX1XkyZ24fuFlEJq/oAr6mbJtMXYR3v4XhuRUZvFYrB6fnFSLk6b?=
 =?us-ascii?Q?hwbgAqEN9m0f0P7stjbkfmu/RnKBkss0xuvbIgl5jRJ21zJp+m01D5eeXZSp?=
 =?us-ascii?Q?4SV+E5qLLplRJwTN3Hb+MjalRHLw+7y98KMiDfLjX3wvFFzzrzxT0a1KewW/?=
 =?us-ascii?Q?aMhvMvwNPajSyoJbjRocwQxLSKhyUaGOr86+b6kEBflZ5Ifn4Rxa1vLkCjtz?=
 =?us-ascii?Q?jiM13waOl1tyiWBTpFO5zbmfuIWjiF/lVfpV8xXhqWxHTus/dIxY2Ntisqyt?=
 =?us-ascii?Q?d0hs7qNqupy5yjZSarqBrwYkoIgSl2oP3rR3LZBdGgE50PWs30Clc4CVjNCM?=
 =?us-ascii?Q?OFC7FJA3VNEG2YJjLOz9oizZHw9DV44Q8la5o1P3BryIjRA+8NfhimDCDgSK?=
 =?us-ascii?Q?g0l7qoLms80cn+PvrLiZrFhszExJiEHtbJyLw5yZGE+HsQU8z6xpWY/bx8vS?=
 =?us-ascii?Q?UM3oFxyOysL87gJlXqT1Ob84oDlWVG4Kj/ydVO+6wT8HzzvlSMCsiV3MUR/g?=
 =?us-ascii?Q?AlY2OdYiJPAsvpU335TdooYy6vp3OmDEj4AZmfLmuMF8iLP4ZbCEkxKymluY?=
 =?us-ascii?Q?SCiyCMMF22maYJZa1ZnZ8V+jzgaWzgaxMFfGGD1y4mFv4MYMSWIr1dvpf/Tf?=
 =?us-ascii?Q?+/TyWZ6/7XYtRi/Z8uqGI7qUUNb8gUdHKnR8PmwdDn2HhjZRcczfbBtONp/U?=
 =?us-ascii?Q?3n9WRZbr9s5/J660E4HP7Xsj9MZDRTpPrzuERdp+?=
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
	/qc9J9JxnZV7IJw2v62S4+qYzv6ZE1vpVg2MCTkJ9SdxmkDWpBzwd0L6QffScgEGonlo7nq3Qi1ErJWSD56/P+IMp7pcWsWJXqRLdeCjUz2b/OtZFwoynHI59Dnc2C4YzO1zR0GyvQkFzAJEi/JOfgug2iJixuYhEO+kDEe84x55odvx753gpqwvKwVSm9cv5KNMmKdjIQgWBY1Xb41TppQg5M34vxhImhFu5RO79fK0C3aGrFrIZrCo3D62xf9w7Gsxkqch37pfV1MsyWGac0ArpQvdXOomeZF6Wx8OrCIdbds1+sKOxpHIiZqjadSc+9WtSAf2Sz1HNZJMftmcZ+jXQ3jp03cUj2zTJnOjdduE7ynKCOdeByYQEj91eJqDgucvDkurG5dla904oNq6X76fRxci1A4gdvgogBvwGMSHTfWDNDH4o3SW1NOEEBzOI9w86foAFqq9D7fmyI89Vi61sVOF5sQ20xTj0MkOpT8rqpHA9n+xtcgIfmAMwER3esmtFkZZ8tJzkWee3FFwEmyMThpRB6VLJMFRupcC/jbGjtKh4TyXOHDvLkQjWtME4iaaz6lEZr+eUC0GL3+hnvdMeOz1FNC3WBDLvoCJHJZMgSRxrClVJSQNZoX07Hpd
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR04MB6853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3a55ec-5dc5-4f1d-be42-08dd99cbf74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:32:26.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUSnWE29f6fNuKRtMiNOEh9oAf7/4hH8zxrADzZMCknzwW1bphn5nKRo0epdvHoO8bpZGSBq+nY6wV+V4BuEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7707
X-Authority-Analysis: v=2.4 cv=DcUXqutW c=1 sm=1 tr=0 ts=6830248e cx=c_pps a=NoeV5uI3RRAbvH9fnRMG+A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=4AL28aEVfeMA:10 a=NEAV23lmAAAA:8 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cPYzWk29AAAA:8 a=2VGnaFk_AAAA:8 a=jT_9lS9cAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=7NKhIj1OJCfFSAS0NJEA:9 a=CjuIK1q_8ugA:10
 a=oSR2DF9YFqZEN4IGatwP:22 a=xuWaqJMTYXf3QM4Ho2sr:22 a=Ec8Bv2-zM_L_lWdDgjzK:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: WffH5azKyrsuSdwEiBgUFxlRPKLWF7zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA2OCBTYWx0ZWRfX7u4Ppk8+M33B bMTxA5QrlGSslLKEETv1pe+oykaxEPT5EiZ4TWqt08JmFljW2bgES2ytSg2/71LSJ6zaOhSk8Ps S5xjTJ+fQ6n/+jvgOWRwf+CPzd4aY3IycMks7MUS+mTonhaGanufBn9oFbHdH70QZ31qXl7RJcU
 Xe+XEy3D1OB/jPDRLlDSc6m3Q6rM4kPhu73SdgbhowINcuFyg1jjpJweFI+BlY3pE6aVHh7w95z LIQWeAcCFGAjFNrHGxcC3dwIFwyg/XdNC/rF8HalOnHaWAng2VhUoV3h5qxz9Yy5+nY2Rjtipzd QnM4ehOtN3vERw8AN9ydOqB10ltVFMHuuFk9ElqiAA9KNCYowfnAX7yHA7pTpPAkjwOiV7/n3NP N0gSNT6v
X-Proofpoint-ORIG-GUID: WffH5azKyrsuSdwEiBgUFxlRPKLWF7zN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505230068

Hi Paul,

Sorry for late replay, it takes some effort to change company policy of the=
 proprietary.
For the questions:
1. What upstream tree did you intend it for and why?
 - Linux mainline
  We are developing openBMC with kernel-6.6.
  For submitting patch to kernel-6.6 stable tree, it should exist in mainli=
ne first.
  Reference: https://github.com/openbmc/linux/commits/dev-6.6/

2. Have you seen such cards in the wild? It wouldn't harm mentioning
specific examples in the commit message to probably help people
searching for problems specific to them later. You can also consider
adding Fixes: and Cc: stable tags if this bugfix solves a real issue
and should be backported to stable kernels.
 - This NIC is developed by META terminus team and the problematic string i=
s:
 The channel Version Str : 24.12.08-000
 I will update it to commit message later.

> -----Original Message-----
> From: Paul Fertser <fercerpav@gmail.com>
> Sent: Thursday, May 15, 2025 5:04 PM
> To: Jerry C Chen/WYHQ/Wiwynn <Jerry_C_Chen@wiwynn.com>
> Cc: patrick@stwcx.xyz; Samuel Mendoza-Jonas <sam@mendozajonas.com>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1] net/ncsi: fix buffer overflow in getting version =
id
>=20
>  [External Sender]
>=20
> Hello Jerry,
>=20
> This looks like an updated version of your previous patch[0] but you have
> forgotten to increase the number in the Subject. You have also forgotten =
to
> reply and take into account /some/ of the points I raised in the review.
>=20
> On Thu, May 15, 2025 at 04:34:47PM +0800, Jerry C Chen wrote:
> > In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't need to
> > be null terminated while its size occupies the full size of the field.
> > Fix the buffer overflow issue by adding one additional byte for null
> > terminator.
> ...
>=20
> Please give an answer to every comment I made for your previous patch
> version and either make a corresponding change or explain why exactly you
> disagree.
>=20
> Also please stop sending any and all "proprietary or confidential informa=
tion".
>=20
> [0]
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbp=
f/p
> atch/20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com/__;!!ObgLwW8
> oGsQ!nQ0Zkq6AxOKAJHbUUrTRnNI8fJNt7itufBwUXkkZU1-yfFo3h6Vm55K_mqr
> 5Ur5kw9wE9cMVgIdoGCL3u2DhhqA$

