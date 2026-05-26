Return-Path: <stable+bounces-254283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BbMMjpjFWprUwcAu9opvQ
	(envelope-from <stable+bounces-254283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:09:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C66375D3075
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45A453048309
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99C3C9ED0;
	Tue, 26 May 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wPcdkdSu"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDCE379EDA;
	Tue, 26 May 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786036; cv=fail; b=XTCZuSCQiIvEo9rg3rzZ192v9UQnkHejynXu2NJ6+IeSrpy8R3PBgvdeGraT6zS+Ii5rrBRZ3PvqVWgQlO2q7saA6/81bkq14dkCksHfR00cKG3iFWHl3r5R2UpJ0ieRrGGvVnNmtQL1mc3FfXIskQOj8Fw0KSiAC/4CAyg46Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786036; c=relaxed/simple;
	bh=wuuAFz4JnrHecIxuHJ2amnMHS35cTooNByIiDULEJ4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bos4M9G/XHteiMkhI3RPMfVG/w0fer8Min4/ez65i8R9Da/B0lErkdl1gJ1xsqKyWp5/vodZGwK5hq851vNC/PSfR/gJHK5aTC+B8jblJwXB1iIlPgtuSdvvCAuL7QNeld6V25MeAhx89WJiMsSrEwaPqsh7yBI1rqpcoadjF3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wPcdkdSu; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP27iFcMFfT4CXw/ReCHv2Yii4/gC3hzz6XF+P+IlL2ZBon7xZBY2w/JW4qbxZ7mZ90SzfXbUL2GlXbaJE92cFdMUsMFH2nhKMap9nAjIxanhoywn15YmPZDifOHIzt3nhUwz/IDr9m+5zmRkzylx1fUu6x8cInz02QPlZV7PjKhwunGy6KnCW2KibQSHduZ6ZRNcVclNfhjEPUkJwxEU2C+hPPYo0veSMNzNz5TKtTZEaO3Vyvswz5iGoljobMcX4AoDSDc1/VBaw8rC9QkyC9hYF7aUSwhR9S1r0F1ROoyBcuV1Iix064mHhZBytjNHpp1Jd6ALmyjyRYtFLJcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWPKPWBL+OnBN5OqpJkcLu/DBykXAh/wTUqjVfoaVf8=;
 b=imgiKFmijoMjwGdLI0GN1OHUejl4vPwRZKaxNd1Mjip7DKInZ0gXBulTqYszF8pbhYu4MkaVt/TxoTSGhol6u539aCr2GGgcBl7mls2D5CYSoYw6UKPU573zn/+qp4Kst4hTyyk8zy7Nr2uvqQ131MmyyaJ3GwK3yRvlxswvHhZ9CPYhAZ+BDT5ducDDJu7VibaFiAs+nQfagbftblGPYFBETEjOLjOH5AhIIda9EUB43k3p9S0eothJ+fnc1TZ2r2LiW+IL3yAqn0iAffa7MC2ICY/mzhObSZBJK5eF7e/q6tEMIyucnpQscg9HVr/8aROVe+AhFAw4bBMHUn90Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWPKPWBL+OnBN5OqpJkcLu/DBykXAh/wTUqjVfoaVf8=;
 b=wPcdkdSu/PbDYQAMyRyyQK5wTpTyHcuEphHCkPOmbn9bKUOwWBt7uO5UKXRywMpa9DKqtHuW63ieTzF3l96yXvUSED1n+2f1z0gi2mGgrITVXnAl/1CsVLfR1ScojZLUd0FcDAbAwXm3cc1BdypwA+HMARu9qQQzD4lRHFKsG6k84+ERf8mYMnHNdBDtXj2PfSOuYtgxYZAsA4wLyMRspKmOxig4p0qXp/qJCtCKI6HIqYTuqumAWVLqtk54716i6esIM6bRh9RZDO7xIkM5AztX0Mkh43feVVgWnYh2jRmaMPAT1dKnshl1pLXNUnBps23wZcqgIgzMbk3cjdDydg==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 09:00:29 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 09:00:29 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>, "Carlos Song (OSS)"
	<carlos.song@oss.nxp.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Andi Shyti <andi.shyti@kernel.org>, Frank Li
	<frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>, Kaushal Butala
	<kaushalkernelmailinglist@gmail.com>, Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Thread-Topic: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Thread-Index: AQHc7O4Z5txHwyLcp0GmJoBnLT9VjQ==
Date: Tue, 26 May 2026 09:00:29 +0000
Message-ID:
 <AM0PR04MB68023033BCC34474D12D4EB8E80B2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References:
 <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
 <AM0PR04MB6802B906706F0CDE5BA73696E80B2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <ahVV1X_cdhHDmRwc@L30177.local>
In-Reply-To: <ahVV1X_cdhHDmRwc@L30177.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|AM8PR04MB7379:EE_
x-ms-office365-filtering-correlation-id: be8978b9-6b22-407b-8115-08debb053c79
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021|4143699003|6133799003|3023799007|11063799006|22082099003|56012099003|18002099003|15866825006|41080700001;
x-microsoft-antispam-message-info:
 i1Knthr1hXtYcW3lMRhkVI0YEKoFr1iESYh4webreo0Hi27uvW5vF68Vz4GI2xg84hVv4lSUePXobzImGEzW4BIZUbwZW89RcPm+fBdkjS2u0sEHDLVCRUDf43zxy2u/kfpM04nIi7b4CnBXaGVnCUN26UlbDEn9eQeA+bjqqmXCWlYHUSFqQbNnKrCDb+pGt2rLCpwGqxJzm9G8SK4hb/GHPM2T/VKSR3haFmpAjTRmmOUw1JABIXYkOF3qgHm01hBQpknFtuj+jm2aHq/mKVb3zyysPQ1JbspLVTkSpjeeNKWmQcYoDKcOf+UxZZaPAAWFt+X0bnrREBRzPFAiEvuJJEIumwmH+PO7s9buvBH4hWkiwf2RtF+JUbQagSq1PkJvdwEmEEPIkflMODa9lQhFE28qYQU5TDcWMdbPuUd+iTVz6JBqV+o8aEJCRZ4MQS2CQo144WMB2ZPHAV1RW9kS5CY2b7x8+pCqp+6VlY1q5ORP1PkfDgF04yJOQzrNhFOoUW9Bug0Z0jK/k9YMu0vUo7H12PmOagWkU9lL6YBReh3BNFDD1CQ4jSXi6mAizgXqLJN5Bi93uVpjlKiTd1jVBkX6qan5Tgi/6JAWOeXIHyU0qxk7hqcPIMw51cJwaioMWx4Py9vPjo3GhE+RkQMJ0gwuHGM8uocnpcJS7XgPVGhibOTP2JnHHD6myUbPbiCy1iAcvUg3DxhEQp2y+OahuAy7uft/6OwMMHNhG1U1f0gvFVxbyAimhSqNp6n9LwHoj3FmB/NaRPBduHnlGjy50dY/94Yie2os3uxSHD/K+ilxlG56CcReTiG3OVKv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021)(4143699003)(6133799003)(3023799007)(11063799006)(22082099003)(56012099003)(18002099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2ydeEMQY4IhD2eMJAIgutX9BLtshIeoLVr24SQuLO+h1kyDsO6gLWs+l91cL?=
 =?us-ascii?Q?mGPUaI6lty7+z31BM/lb0AeWw0bu2NC6L2a8cy66RF6b1n3UTCql6IVaWlPe?=
 =?us-ascii?Q?j42bqrpjJ04uNI+bddQCNZePRdif7hC/WvoudGQ7qxnNx7pvXpmr1z91hiE0?=
 =?us-ascii?Q?AGimXbOSOT9yIirAPh9kt/cTR86ohiejhiXGU+enLdmgxv6PUgd2zh3ZDFfr?=
 =?us-ascii?Q?8+xUjwgwWbHOz4M6RPHpmmBIyPYX5GNcNNP0hNoLjqT6iTdH3iRzuYhiNv47?=
 =?us-ascii?Q?k8Oze/UoZQDwo6nnX4B87bsfjfrMGZUSiUwjS5yqI3hpLZClL6qEn5rmU7UQ?=
 =?us-ascii?Q?6O3kfb0gkRxs+kbB+dBBYDGl1v7zlLfoD4sT8xSebcOBkE3BBkTRWCfT2/T9?=
 =?us-ascii?Q?v+JG4DOFoUYaIpgqHsYO/GEOP1Bml8KpTC6Z+Y8p/CLZchfbzjlV8Luy9xGt?=
 =?us-ascii?Q?8htxJ6U/I5E+4GDbti4GAQn/EYZN3YeTJtgNXO2aWsxz4a6JfhgJdeNFQ1tW?=
 =?us-ascii?Q?6mnwoywxTk19ADBiFoJuIUrDBUIdclhg8t7xHz+V1T8tGwvp/2rmatujIqQP?=
 =?us-ascii?Q?jLtIm8P1VYO+Mt4xGhJENLQ4vvbl/gUrznjPqPNLVLmhP9glFks9cX7FV9cP?=
 =?us-ascii?Q?SrmcSHrhLfFaWQoEsE0382tg4quynOh+IBGy30ggi4w7xJSR/GM2kx/1XwDa?=
 =?us-ascii?Q?7r6PSkWMiNbgoLL+DWcZDUNAgSu2KkveOiEQTGFt/IdUHcD7wVnson1RHSxg?=
 =?us-ascii?Q?wqf8dq9H4fdwrCrih1+7U8Shm7nSIUWCimswJaaBH5nCC3zDSllYPYRQPPPC?=
 =?us-ascii?Q?BJTH5vjhQDS5Hty8kumF0uHK4v3L0wZyTuqvYXYe7lkyPeqUJSAICHHZp9eC?=
 =?us-ascii?Q?1S78Z/rToGMJYCC1HNE3XAlH0GCaFmZqCU0LbVmIx656lNTf4OfLpiKmDFOO?=
 =?us-ascii?Q?UhgFS9ickGsN+5VGhLktm46Xbmao+wyodzu8Vj22g/mGXINPYeCtrNmfswu1?=
 =?us-ascii?Q?2758nk/7PHbZUXS3X+W23Lv2pRyXHCGxGrr/OsWb6TaAQXCIAXTpWvTcRASS?=
 =?us-ascii?Q?UpRVNMYqzS2JRuKqY9wU3H9nKwMMWxSblNwaSQ4qcFqnrKoaSyoSBOqKIvsZ?=
 =?us-ascii?Q?PgGLrZgcq+w526yoP/ARuAOsURxeMJAqfSVmj+SUMbKN4jLe/0ftYKF3koyD?=
 =?us-ascii?Q?h2AwWW+x0HpqeRStEZG19+G8azRMcOKpXeFL72Pj8yiBeTyEC7Ztgh3z8oW1?=
 =?us-ascii?Q?zJf9w3X9cFiPiyuNK0ObOIOatLH6q4Wt+6NXRgqaYYQjJmH0D4KJlaqKTyum?=
 =?us-ascii?Q?MXAUcnReYRwJMDryec5+N6HdQr18Arjcycu9fwQb1rlTaKeLd8ZKbNqB8k3v?=
 =?us-ascii?Q?sCKgwU3l2hphpQ2hzoo/dIql/yi0qWUnNrHtOtW2/XsnZeYREi7/24IGDIlf?=
 =?us-ascii?Q?4GAb+2S4cTQvy6EyYoBlaKCInklhM6UFCe+ovZYhOZ90XHL1YTmU995rSmIB?=
 =?us-ascii?Q?VLjfN+F0d8hVk7ijrB+yd+98UquLeAgDhqU30mF8tNtNLD4Z6O8WKkuAiPT8?=
 =?us-ascii?Q?t3MSN1bc07ceN2WipDkD99bBogJi+kuizqx84QS8v1j1l3xYeLEoL06xGDx+?=
 =?us-ascii?Q?GGk0aZnOvYrTOp1X+jifHtlSgfq17RRL3bh7JH57ysyBF7+nxSEALTB8Y3mL?=
 =?us-ascii?Q?BLCFtrMl+aHTlXNRfPEdb0m1PwrRHQ5r6OM0Czugmo91EVGYcaBQzs7WEEe4?=
 =?us-ascii?Q?+tIHFWlLMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8978b9-6b22-407b-8115-08debb053c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 09:00:29.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvHrQdGVqqgn8/uW2pazr0tNFl0d+9/bWu2GZLMlzCLEfIJPq8dvv+mdUyxM0k3La8SeaKxAGa8f6qCaxGDOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7379
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254283-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[free.fr,oss.nxp.com];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C66375D3075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Tuesday, May 26, 2026 4:12 PM
> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Andi Shyti <andi.shyti@kernel.org>; Frank Li
> <frank.li@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; Wolfram Sang <wsa@kernel.org>; Kaushal
> Butala <kaushalkernelmailinglist@gmail.com>; Shawn Guo
> <shawn.guo@freescale.com>; Stefan Eichenberger
> <stefan.eichenberger@toradex.com>; linux-i2c@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking t=
he bus
>=20
> [You don't often get email from vjardin@free.fr. Learn why this is import=
ant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hi Carlos,
>=20
> > Thanks for working on this fix, this looks good to me.
>=20
> thanks for checking it. It took some times to isolate this issue and then=
 find a
> fix.
>=20
> > SMBus block reads with a length of 0 seem quite uncommon in practice.
> > Was this triggered by a specific device behavior, or mainly found
> > during boundary / compliance testing?
>=20
> It is trigger by the usage of a mpq8785 on the i2c bus: when the kernel
> attaches on it using its pmsbus/hwmon framework, then the i2c bus get
> locked on lx2160 !
>=20
> > Regarding the handling of len =3D=3D 0,
> > I see that the patch sets:
> >
> >     msg->buf[0] =3D 0;
> >     msg->len =3D 2;
> >
> > It relies on the last-byte STOP handling together with TXAK. It will
> > help I2C-IMX generate NACK + STOP and release the bus, right?
>=20
> Yes, exactly. Reading I2DR for the length byte has already armed the next=
 byte,
> so we set TXAK to NACK it and extend msg->len to 2.
> Next then i2c_imx_isr_read_continue() at msg_buf_idx =3D=3D msg->len - 1,=
 ie the
> normal last-byte path, which clears MSTA to emit STOP. So NACK + STOP, an=
d
> THEN the bus is released. I do not see any other means to handle it.
>=20
> > len =3D 0 is a legal behavior, So it go into a successful path.
>=20
> Yes. count =3D=3D 0 is legal (SMBus 3.1 6.5.7), so the transfer reaches
> STATE_DONE and returns success.
>=20
> > But len > I2C_SMBUS_BLOCK_MAX is abnormal behavior. So it go into a fai=
l
> path.
>=20
> Correct, and it is a protocol error, so it needs to end up with a -EPROTO=
 while
> a count of 0 is an ok case.
>=20
> > Do I understand it right?
>=20
> yes. I do not see any other means to handle it.
>=20
> > Also, if possible could you briefly describe how you validated this
> > change (e.g. test setup or steps, with and without the fix)?
>=20
> On a lx2160a board, on its i2c, bind a mpq8785, and enable the Kernel
> pmbus/hwmon framework, then the i2c bus becomes un-useable. Using a
> scope, we can confirm that the lx21260a i2c cannot recover.
>=20
Hi, Vincent

Thank you very much!

Acked-by: Carlos Song <carlos.song@nxp.com>

> Best regards,
>   Vincent

