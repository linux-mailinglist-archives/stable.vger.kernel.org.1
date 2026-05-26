Return-Path: <stable+bounces-254250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMtrGgNFFWprUAcAu9opvQ
	(envelope-from <stable+bounces-254250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:00:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFD95D16B7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F668300C027
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82A2FFF81;
	Tue, 26 May 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FFHqA4XO"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27E372B3D;
	Tue, 26 May 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778817; cv=fail; b=YKgFYgtL5ITUvaZ6pJR40Ld00oQICjO7yloiRI/Evy3yfpmfpbGXCRctwsMel4Tvt0ZXxSy9DpMiHF5WhCPtlXBU28ePwtwW62i8YRUeBZa0nnti7H4CweSovxxVrdogNhEKkoGrgTi2lDvBngar75nLJVRDL7/CpUWICnom9Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778817; c=relaxed/simple;
	bh=Gb+mVm5YKv6HzCn3dXKbiYdx25c4t9jqjJKdV7bB1D4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h98j0ffcZ1vHFy+GsDrgLrcFbVpPfvnpXI+3ehUYsZpGNwls2zK0LqnTxuP4RfcBnSlxJivwYgrtk8ihpntGrKrwj2YqM21y5l4WLwnq4iVKNVgMoqeMe/CHkQMH40Ry/eIvuLW+dRt20ljwkQ7B3pvbu0R9KVxQnSckSzKg2eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FFHqA4XO; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnjYn+e8FGry4FkHAnWAd8AlmA7Hpiq1J9I6NHd6m+57mg3Zvka4jh/AepMOdrGSIPIMKOPSxVXg/7GCVYxvFRhTQnHAKmvFBCNcHfo1GW5noneo7L1yt/c3RzF7QUg7ahEtDsxeDCEDjkwksIkvXRRHgd9bO80+ihhS9QFW2seMeI4A8otNRR7jCs1V86hLndD6UTQlUC+zfe03Z4lmBk2itkzrIUsd5WOlTsJoF6fEuyBizf+3h0wWvShuwpRMnoVXfqw+E58KOzF+96wVkkDyNr7mw8vDjOFCHudCEehX3jowd8dIDe29Vr/1dspkB7LBcIO6Y/4sWzeWrlKFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v842Zw1RqH6tMAZuqSlsuRjsFZYqUcohGUYmJKRPrjY=;
 b=I1EDIehvMnd7SAOjwqmjnl8qqLDjp+TX1txtKfg1OZbmzcJ8xZu8Kg4cyuGsXrXFZJuaG3rYHjcsZf3GRyyHhbE4ZPzJaU9xL+LhfC82efdunUpxak2J/twsq90ife65ZulAxUmDJJUwdNld8C453ZOqKsk6Kg0y/eIa9zutXEDfw9fjRoJZmBalMeVOR6WRVBC39oM68oFRtZZd6GlUXzV0+DUvpQE9CTnQ9L2gu0UKAh43A+5lp6793/ekj//iQ5bAq+ybQEfrKuVR2R8MIBEgB4wCr9YXJ15CdHhXAI1jnw3svpkOjzW1pDdFlIZ/T5z+qxM1AHEh/FIleJuIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v842Zw1RqH6tMAZuqSlsuRjsFZYqUcohGUYmJKRPrjY=;
 b=FFHqA4XOOQ23//TXM2sqWj1jvWrO9B54A8g4XPMmmCzckY4UzMFjqKRBLYFaWSdQcRG5vLgKI6+IHxpnYIpGqdAl0PPXQsPMBRgLOZQWgUmmk95L88XxUq+qe6Vzt4WK3n9IGC7myhGfyQAo+rPJHH2YSCsf4EGQPOnI+YqOISlK2AAMsbahKFT/IBMZQOQ4gtfG9IwESYOvqN+Wvo5xgerRK/ho/0A58X66N34l0uCzPWRL2wSErN/UrU0asE/E7p2TsYZm5OB0hbEvgu8o1TsOS5kYSX69M3zbNFYwwXAgK5NmgwesvGk/KM6Mkhc8VZDoeaFP7xcpbF8f/DpuWg==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by GV1PR04MB10680.eurprd04.prod.outlook.com (2603:10a6:150:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:00:01 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 07:00:01 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Wolfram Sang
	<wsa@kernel.org>, Kaushal Butala <kaushalkernelmailinglist@gmail.com>, Shawn
 Guo <shawn.guo@freescale.com>, Stefan Eichenberger
	<stefan.eichenberger@toradex.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Thread-Topic: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Thread-Index: AQHc7N1F3oFMAbZiGUKDWYIfsI8lBA==
Date: Tue, 26 May 2026 07:00:01 +0000
Message-ID:
 <AM0PR04MB6802B906706F0CDE5BA73696E80B2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References:
 <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
In-Reply-To:
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|GV1PR04MB10680:EE_
x-ms-office365-filtering-correlation-id: 9e019998-5744-4021-4f4e-08debaf46816
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021|921020|4143699003|11063799006|6133799003|18002099003|56012099003|22082099003|41080700001|15866825006;
x-microsoft-antispam-message-info:
 4TCqS4hc1lK2yH9slWbgxR5m7z5sbb+nzVR1WWgYuH+AXZ5yaDi2ic/mx+IJdtp/JYeC1orksAgK9NJqWaOByG+M+GDjAuGpJFhTIgTfwx7Z8w02xUViEjPXfuy7O9u6r8nsbxQGNldMWmDAxyAt7WYgdIMYh+TX8kjJnhh827aXsLYPgufOHAtyKUeupdmXWd/f60/HuBDkHNTdnIlqi/1/8JtaRudGd3mAbv+8fb65D/tp4topxigOMquDE3brV2I+49O39TI3bgz9xWkRGxp5NTYMDIvuQyua2b1bODK7oJPVX01d4vb8w6w1zXNjfdE6Phu6aA5zVlFp8FRqWIrmiD2jBQaxmCVw2UY8fGxFOdlwePQFpyy8zNVlH+4EWwlSAUhwY/Kys5yzoawvI1e2IOFThqzKFhWInqq2cplw3Sc/XBZ5r1ocur4bXgBXzJNIYBBNUKtuvtZzlP4bRDiF63eNYHGaGbKz3vcq/2/fkzpJVm5z+FlV7KiT0HPAqLyg68RZdI2q+lQzpyH9w5pEWDNx2YAAZbtvJizVKcmXqYHy2s6jaVfneDM0oJwJdT2V9tdb/aiw80uj54OOZiKDF+kbXcD5ZRawSnsdbqjAb7JFj+Fr53M9mHhSEYCk73xrA/vxoYgVY4buoRZ5w/ITM5P2W2zTFvfzlOQ4V00iDtJP6gwyQ5ppX2nNfYyU050mlHK6E8/AoMVxD4jes/sUg5558YkbTyMsF6kDAsK6CooqMoM9kfOfyfUE8I4S8zS7fNV/3VDmwr6S347+AkjAGU5EUd627nI0yGVBz+BTPCJNu+5qnEnoQaL4xN9QKt1lCFbkEr1jYkWYJ/SAJw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021)(921020)(4143699003)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k+chqc5Yc3tz6R3Q8empiTBpLorTVCTsWTBDJz8jBmI6ywC93c9BdaazVb9E?=
 =?us-ascii?Q?40XGISLD57VKdJRst7XIUEbFA5Z+QtnoPKAg1QQGCPI1sWhAGFqHVvnjZhVG?=
 =?us-ascii?Q?Cvp32gDXUAJhoaXQi+tC25HnhZszaxKytiSLKgkZ2g77tnpgYzqQ6vxH2+Qz?=
 =?us-ascii?Q?gpMntXpiBJDcGELU6ln+0JfVXnXrpuxR02DTneyEOwSMLdwEsdhAe+60Rlxm?=
 =?us-ascii?Q?QB2hGTlf5IAiwGomLgJdd6v4+54puSG18JY8gc6MDObi/kn6dlj5hvxSGUOZ?=
 =?us-ascii?Q?SNGzrOg/MhOTKHVNywi9EE9Phx3yHxBzVEMYJUWfHJOib9M1URiGdnE7eFu0?=
 =?us-ascii?Q?0q+9rBuoYoUExdLcXOB4YZm0QnN/1b5nT8n3HaPBqamoJR8DWgXoGB7uNKIv?=
 =?us-ascii?Q?aydlWrjg13PILeRxOPAQwVrmLX6HWnZnJjpnK6JsoWpz4c2AlEqseEVySp4j?=
 =?us-ascii?Q?6BJIMTomhnTmr7onqFt4AVnE9HmAieCZ/6b7C/AZ5B6zz4l5UnPDwa6gUzp4?=
 =?us-ascii?Q?MbPPTgoF2g6VdlJaLOPM7PPP2wrE8MjniptF/c1pfNLVs9oFpLNAvzFBV4bL?=
 =?us-ascii?Q?Gm5EgHiYbh25RCPB7qE2O7G5xToD9FtBqOQnha5sMAzs98LKgE39OaLWCuBF?=
 =?us-ascii?Q?1fZYBaoe5/637tPbPjkAKbicOJPNQ97bFriKPjg2GLrFizjPUalbKizol3iC?=
 =?us-ascii?Q?YSTe2ntWu77dlXCYhxs08KuGlA9DY/YNcC2tkE4lyCjqgHS4YieCsvAT4Yph?=
 =?us-ascii?Q?priH4qGugEcLklRUJoNpvWMrU0B9vJwVfFyGO7TBANk5w0rWiTzy9HJCMxiF?=
 =?us-ascii?Q?koBdm6/b7lX7G9P3JMIcJRDuttwUr2odT3Clev/DtX36KxQ1QGvEw4i4CXvw?=
 =?us-ascii?Q?LIZ2lsoctPxRvv8q9FbIJ4CuyRBuielNrmqV4rpgGcm80WgKsmaqJH32qvjX?=
 =?us-ascii?Q?TXptQNdtVy0K2saGJSH8+Mu9cNfuzJ+mtn7fZT6m6kdrXsxUkpF3anZyt2FA?=
 =?us-ascii?Q?349e3H2fsQ0iYmbvjCuPLXNvGF1nx0FgD+rSRjagdJmGM2QRoy6HKaUyPfaN?=
 =?us-ascii?Q?xL9pEIfMU7rjBFhdOH1xwzz3xPZWjvf7V/3AvIoy9fLd5h5u7mMroVMV3iYC?=
 =?us-ascii?Q?8wLJp5vfAp7KSTkTFB/9Y3WSGeKqPVtmYTPVGda5ivvzcBpmqdQN7G8eOaca?=
 =?us-ascii?Q?Z8qYprjRRHLYezg2uoS+jUM00os7vn1Vt4t7pxNRbW7OPEUa/W2goLBkdoe8?=
 =?us-ascii?Q?r3r/nBX/oWhYVo9nEOgnENFP0vrPbDFu1l3/B2aCJZnOS7HgMzxULJh/tS7I?=
 =?us-ascii?Q?KftKGeqmSxeTvhYtNxEEKs2pMRJA2nL5ZyQii5VnROaRVYcq0jHuAho5pVmD?=
 =?us-ascii?Q?9Tw+EDP/lQECWKv3n3e+PtTbRVZn04TMBlCe04pjJzda5IA+gKx/3SN100jw?=
 =?us-ascii?Q?EyJVDKa4+/QVZ3zoC3dOyMFtGgABa1ac7rrrupJbG5lgUy4LhH/BWVjqFy+i?=
 =?us-ascii?Q?MBOke0Ho+Cr9EIIP9ezLb2Mf1klnkz6+kDS1Veq9F0ZXh+z3bfrELcfFjgwF?=
 =?us-ascii?Q?0qXhVW6eG5Uo18pIGqmQHkqcdnp69b5CxCM1D69jF+6S1w3hWpwZPH0lVo6m?=
 =?us-ascii?Q?nvx+JCc3HodeQGSxyzlpccr24w4BK62TP0gv6YmAuQX8XbzxrnC4ex7GjP3E?=
 =?us-ascii?Q?Q0JqeWICcm5OHXNFsGplPXOzB1qg05X/0dZHSbqM7IdaETO7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e019998-5744-4021-4f4e-08debaf46816
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 07:00:01.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UecDeTk4cr3uKKKjNevX5h5Sl6yUiG7zoFXHhOmnaCrWEH9bWpWhmpM3X/HEKRclJx6DAaYkHqK2tGR4QDp0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10680
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254250-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[free.fr,pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0BFD95D16B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Tuesday, May 26, 2026 12:43 AM
> To: Oleksij Rempel <o.rempel@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Andi Shyti <andi.shyti@kernel.org>; Frank Li
> <frank.li@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Wolfram Sang <wsa@kernel.org>; Kaushal Butala
> <kaushalkernelmailinglist@gmail.com>; Shawn Guo
> <shawn.guo@freescale.com>; Stefan Eichenberger
> <stefan.eichenberger@toradex.com>
> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Vince=
nt
> Jardin <vjardin@free.fr>; stable@vger.kernel.org
> Subject: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the b=
us
>=20
> [You don't often get email from vjardin@free.fr. Learn why this is import=
ant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> i2c-imx rejects a SMBus Block Read byte count of 0 (valid per SMBus 3.1
> 6.5.7) and it returns without a NACK+STOP, leaving the target holding SDA=
 so the
> bus is stuck until a power cycle occur.
>=20
> The same bug is occuring with two independently introduced spots, so the =
fix is
> two patches with their respective Fixes: tags and backport ranges:
>=20
>   1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
>   2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+
>=20


Hi Vincent,

Thanks for working on this fix, this looks good to me.

SMBus block reads with a length of 0 seem quite uncommon in practice.
Was this triggered by a specific device behavior, or mainly found
during boundary / compliance testing?

Regarding the handling of len =3D=3D 0,
I see that the patch sets:

    msg->buf[0] =3D 0;
    msg->len =3D 2;

It relies on the last-byte STOP handling together with TXAK. It will help I=
2C-IMX generate NACK + STOP and
release the bus, right? len =3D 0 is a legal behavior, So it go into a succ=
essful path.
But len > I2C_SMBUS_BLOCK_MAX is abnormal behavior. So it go into a fail pa=
th.
Do I understand it right?

Also, if possible could you briefly describe how you validated this change
(e.g. test setup or steps, with and without the fix)?

Thanks again for the fix.

Carlos

> ---
> Changes in v2:
> - Handle when count > I2C_SMBUS_BLOCK_MAX the same way as count =3D=3D 0
>   Reported by the Sashiko AI review on v1.
>=20
> ---
> Vincent Jardin (2):
>       i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
>       i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)
>=20
>  drivers/i2c/busses/i2c-imx.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> ---
> base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
> change-id: 20260525-for-upstream-i2c-lx2160-fix-v1-0cba0a0093e5
>=20
> Best regards,
> --
> Vincent Jardin <vjardin@free.fr>
>=20


