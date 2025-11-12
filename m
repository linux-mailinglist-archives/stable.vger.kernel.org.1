Return-Path: <stable+bounces-194567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A282C50930
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 06:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDC824E029F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 05:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73BE2C11FE;
	Wed, 12 Nov 2025 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DsdKOSh0"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5C38FB9;
	Wed, 12 Nov 2025 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923612; cv=fail; b=F+OEwKU0WiN7jhtQq98Q1tfAixrwopzKT5CmeYwdnTctlISOOJdJ/XuBCQRqvRXiQYCAnZSxY7jLgKZ2+DRIvH7pHsyXEflxEPUY0OiYen5A1tMOY8sLVj9mToCbP8+vsJYi+k2lGulaTkXS+cJvBtkS6IgUnOi/sxDMobKuQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923612; c=relaxed/simple;
	bh=BcbEIwjTIsmxWtLNyl+K+j3wp+zT2JMTtEyyorrzCIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPJBrkSmPG8YGNbL5Y3M2ki/RIJuckwoRMMooSk0t6rt/A11aVSaRnrMegDIir+WzMYslQ9yGRJ2sVuD2U93aggjJ+qyaxTXp6lOmfOGMkQ8bFoSMuqglR2c/CS1A54pRkHylT62dswXov476HN6Vna1vstKLdDkaT/vuhgA3Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DsdKOSh0; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZME0lFdEhpNYeJpZJE4bJC8Zll0Gz4U6489urpejhDS91qr7/y1afOs+pMcjngW0FqhE2Cep2fpWdU0eKQJDr/YgoOPTH3gZFy6XQsPbkdzsOfAuRj5HtoNsMnhwMxtrjKp/WuV5FNvcGB3YITBWFNKko3URy1uRYIW4o1GsMItNo8i3pIDSb2upnutDCb0lRYmP+bDcO8bZhSqbZ2WGDBOJ+rbzt3hUBwCkoBhoCs9qmYjsNtaPxnMMzpHG3tz+DmRgsz9fFuFIScxedyM3FkcsO/CziJgHd1KJJPaq6wDfoRjhTtrKlbughMbFwVIh8OHgbHsRj2Ir3tZSmBYkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PL94vsRXezWDLVlMvi+A90AdCd+cSiqVeoneh8mcvI=;
 b=St5rTvKngDbUHN6socBtP0QcHLRpOEMNzBMLpBioEWbM9lWDciGrcguHNwXIxgfpITe8sKE70i5j1SZpCwALq1CrdWU1QV8hcq1z2qEqVQf2zoLGGMEUVT/oBYN3MdkLIfxU79p2xItgMuKoYH0GyPaTO5cWx5l9LkdRddMAVdIDCs8hTDi4oDlqC1dBCsFumQ/59uwP8kqb6AGVx+rHE/t0T+hCi9Jeyfy9KUhhZ43Fodd3TCitUhq58O472UscfwBwImMmHfNGwU1Rnl9q3aiehJY2APfBCQSGK/7HXxpqa22u4XsVFkA5YBs0fi22o/PCSUhlfLvTNpndR3hzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PL94vsRXezWDLVlMvi+A90AdCd+cSiqVeoneh8mcvI=;
 b=DsdKOSh0LmpvOr387Eb2mEz9ZBf2aM40NVfi/79iv8u+ANqoxhkaAgxniaD5vePZiIT6bUNHJjuYd3+m8a/A/EtLDBiTl8ihVkT6svSMXEFEjZuSid7mmy7n88LjuyUpor6gYkpFAoVDUl7x9qUkZfi5Jt5ByliMxO66oYcx5bZJPTDhSqsERnTsdM/D3PHq+HIYSS5uWxudJNK8S+JJt9mZf8KdrQ1AsSe5vMP7KUNPXsKB6Q11P65WEVxPkZwCr8IXKKG12Qo5QWk1L3jIGrE+qioK9oCXuf970b9/krX+Qv+31Q/zwVItu4fDYl7xaKz47e2rEhQt0+MP1JIwFQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 05:00:06 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9298.012; Wed, 12 Nov 2025
 05:00:05 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
	<rostedt@goodmis.org>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter
	<jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Derek
 Barbosa <debarbos@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on
 suspend
Thread-Topic: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on
 suspend
Thread-Index: AQHcUxmQ9vYzvwDVK0K3yH/te3wEpbTufBjg
Date: Wed, 12 Nov 2025 05:00:05 +0000
Message-ID:
 <DB9PR04MB84297ECBB5E4E1DA0BD8B1B592CCA@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
In-Reply-To: <20251111144328.887159-2-john.ogness@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PAXPR04MB8992:EE_
x-ms-office365-filtering-correlation-id: a944a5a6-8af7-4aaf-b322-08de21a85864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0yCVY5gzABwdldQDXDoHTARnyScEXrQVvAXYDQrayfY/s67jEtyZoK0IJtHL?=
 =?us-ascii?Q?kEC4hWc8BtUePDy9g2VBfB4pAIu//JWcAFaXh0m2zfFfL7F724u1FzC6i/an?=
 =?us-ascii?Q?Q+2kcx9TGpuFggn5xg3NsrmFYY2/HrlDAfrUjMx5qx4rSjcYTAqqLTAE8YJH?=
 =?us-ascii?Q?TDTfpyS0rM5WLiEMt2LjH67A4QnxdgNMGEn+0MH3YkuUTtT7oqk2QUeABQaC?=
 =?us-ascii?Q?mOwCINgMealaqGpbfiXmedr+lIJc4i3yw9v9+Q9n1DZguB00ty56gLsHs9dF?=
 =?us-ascii?Q?vhDxnuFe+JuBin2kwwo3g/s5FlDr+d2L9T9zQaeO+H+8aQ/TeVhyaOP9J0lh?=
 =?us-ascii?Q?N4AQKl2g6lPc2I65Q9EN0aIacQu4jE0raT3ZWBGukXuVfVNowvAllXj/lvXE?=
 =?us-ascii?Q?g6sDE3mCdYmW5AbAdmHFt/NiR4KvI/E4RIMVt+PXitMZ5ca7yfn+a371Ovvx?=
 =?us-ascii?Q?vhL5GU2EFssMZfvvJfhVo4Kr5LVEI4Trh1Z5X10DFwcHs7UDd9Mx84aqHA/G?=
 =?us-ascii?Q?ySt9Wj8OBhLCdHSAfYVWzEPSOMcj3fiBj6YR4122MKpRntPXYn3NJVbf0VPD?=
 =?us-ascii?Q?l8B2qNZlKiVYNR4fGAPfr6Uq65UY1SjqjQ6l+/3YpuyiVut4o5nD+Q1TWUOI?=
 =?us-ascii?Q?AjvPKJzFN/NpzDBQMq926J8+htXUM/vi5bUArRL12nLXTNVLY5C71eCkxUiM?=
 =?us-ascii?Q?m/8mCPh4ch9YjPq7uDxF+HBhQNPoDpSRCdMw82FQhEw1fM+9xs6jwO5cZqCk?=
 =?us-ascii?Q?+jXWak+A8KBMkGmBM9hU6fk0BkwNXCkd3sTOy7j1sANYWZA1uiVZjK7g/rLp?=
 =?us-ascii?Q?zMbetADAXx6DRqW9JZ2fsfDUrubXV1dj8uq2VMBAwAArOaxXZvbIcCgSmumG?=
 =?us-ascii?Q?vT0QBHZTcbtGp+WNUByonTjozIhe5JyLlYZXfDSBuh2xB3SSuAoWV8SAvs3G?=
 =?us-ascii?Q?C3xQYKifDzMTlN68WsMOuKWbeexDvooDkr1wx5232ej05Xq78urDVrf2YQDb?=
 =?us-ascii?Q?vJE1vtdH7DDBNMQlNVOZYQuM+12xFHpyoqXF/aMyALvMMKvxXsRB8PhdVNL1?=
 =?us-ascii?Q?xUSERL98/f/jwjT5MLP6/rP09E+PuKRqjL7bbrAwtV86/NoM0FIpaGDrTd1m?=
 =?us-ascii?Q?U6Iaj9KSyCKrJBgUQHaAoliBMdBlz6dyOBG9HADwoHd0sjGyTdN2mtZmno9D?=
 =?us-ascii?Q?oKk8Jhmlobt7oikIZB3eRPRodeLPSdt1ylkBnjx9uKJUGpBe0xcSG3MYUrxu?=
 =?us-ascii?Q?xmuck6A9a6egTruobo4tBWwSUXdXkxTewpkePWvZ9ctrD9Zjv+KxCRRRGDd6?=
 =?us-ascii?Q?4JPdKCSmu0OI9erRT1XqptSJBBLXPuKFG2IS2b6gw8Dw7pT/I7ViUyk4MsW6?=
 =?us-ascii?Q?1YpCmud4Y26epafimfbuW3CYTy9ARzEhk3TByGJQVUdpjUWk/1wqU3twzFQ2?=
 =?us-ascii?Q?6OkxszJ6E40sfxOO4er/Eko2dRnyylHwv7IB0J9ioXzN8kSNnc4mJw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C/dXbYvIEMnO1lLJnezUWKxsDqqvQEH/TQH+5PJtIjX00EalhXZx/g+Fhnoy?=
 =?us-ascii?Q?fzFVLknXz7/xdLOECABjbc42aKGBc240ePXDeZFv8vijXaLtTfi5mKJap0RV?=
 =?us-ascii?Q?Qk+Myay+zGWzi/cnYcQFiC4s++wbQXowt1HcM49tAYfYaVkyZnw8rLZEMXMZ?=
 =?us-ascii?Q?k5IyEwB/kQx7FfVdQSHFVbZmZk1qDtcNY2+QBqYx61a0t9lFpQ0gqtudsoJz?=
 =?us-ascii?Q?hNi+CnCgl0Sun9pATPaP1tEXv6KYCgF64hoigAR9LKqYVsoZfc8JaQgGhZl7?=
 =?us-ascii?Q?1R3LIS4DXvkmMUDcVVQ0QDLGVnZNSBYU9DGPisbJ1N0zEG9q2xFXv+ZRAv3V?=
 =?us-ascii?Q?UBqH5SOTjXZGvWC60sxlNaVIY4q54dsbph8q5m5ScZkO+02N0yVPAuGuZDvh?=
 =?us-ascii?Q?9DeWX3JNSwsgcX68RGxEIAYhKVezpOO1btNsQjF/zGEXgrZGgrLUO2OrB8C9?=
 =?us-ascii?Q?Qp9d6dRygDomJjCxjJyBqb/l8mS4XYILjeoY8yFjgOU5Tlvg+KEZIFg7etpv?=
 =?us-ascii?Q?pk5mPM+K+tN+PTO78VhaNQTvcxI9z5/7O26DZ+iIPrdtvW8nDLMA6ZhAEaB7?=
 =?us-ascii?Q?lIua+suWOo19+CC3Kng2GDIia723zXNkp7BfesQFvEJZI8KmvSxQdgeGVAzw?=
 =?us-ascii?Q?IvHvoHj6JRxGe4bBUlog2YOQNNILGUHy2U2lSHJUbXcBT1GcjQPPfzaObKb1?=
 =?us-ascii?Q?rN5IMGN/GXCnCZvzzrcRmYluEKLp98I8Z93QgFU96nhvJHdZ6O86b7jFKWSb?=
 =?us-ascii?Q?IrsI/MUxvAlgHLY0O9TOsyWBMaD1Zn7bkFjf4SfgBfM5s99VX4X8w19kCKSE?=
 =?us-ascii?Q?rWeHcGtvStq5eBNa9YbuOaTUKYG9g71IJTroSBYC/zBEd3PooCg1ln7i8qtf?=
 =?us-ascii?Q?kHnHljy/L9pQNXrbt1JpbWmXCWKhVLp7IUY8NhsjMsmrupU0oTpnHpBX/Bx7?=
 =?us-ascii?Q?BInC0ghKnz9w5wq4Egf9PSdlcXh8+Z3pa1ymh6Zj8c/KGDApE4pTueFByVlz?=
 =?us-ascii?Q?7AS2haAvp114Xn4/ZUSkxfj633AP44p2TSfdaZXLOEqkpMNvKgZ2E09s46hi?=
 =?us-ascii?Q?dZ8rS6ehJmt9OLS30by0IWIv8UqkSviCe7C60EI0UzeKrkGZS0OWg4sm77kf?=
 =?us-ascii?Q?31yvg/WPor3H2c+xJ7sgV0T354Dcxpdo27ePE2uFMBkZCTMzXzph/SjvuB2H?=
 =?us-ascii?Q?YgqMguSJw85ly4IHarogDsk9SuIijbG5SMYasrij0iDAkdpO0xWZoQp1gXRr?=
 =?us-ascii?Q?L8jCJ75TGMEDU5Kvccxt/bkHck4gCH1EJ6fJSj2VMgl6u5PcM8KOv5ZgyfiB?=
 =?us-ascii?Q?JKbHOe6ROChVbBRr9Jn0XeBSpShTU5k/M7MzgPR92fVCXOGFmNjZSrYrAzIn?=
 =?us-ascii?Q?gDfdTYOfxocjlCfvsDsXoYxkFkvbwFiR3CsDK58jz1KI938CTm/3caWlFAh2?=
 =?us-ascii?Q?PEcOmTBQrzP4rsjOSc/KpHwbw/d1E6JQt62Sf8iRWFhk0XBJPQ/gpGHgrcI0?=
 =?us-ascii?Q?kWa2rNLG+zcIXSY1gL1aIlhKWiPVdi9Pmkty0d74x4c7RPK7nVQkOzGSvHCu?=
 =?us-ascii?Q?itLeDP+2YR6PHOgeep8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a944a5a6-8af7-4aaf-b322-08de21a85864
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 05:00:05.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEtQWIdZEmo9SDu6mKsg1dqBHYFL3WqiGvTRp98ZAW7PuSDpcbbd2SANbTpOQ96lECYNlSzpxequQHKSIJuSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992



> -----Original Message-----
> From: John Ogness <john.ogness@linutronix.de>
> Sent: Tuesday, November 11, 2025 10:43 PM
> To: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>; Steven Rostedt
> <rostedt@goodmis.org>; Sherry Sun <sherry.sun@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; Jon Hunter <jonathanh@nvidia.com>; Thierry Reding
> <thierry.reding@gmail.com>; Derek Barbosa <debarbos@redhat.com>; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on suspe=
nd
>
> Allowing irq_work to be scheduled while trying to suspend has shown to
> cause problems as some architectures interpret the pending interrupts as =
a
> reason to not suspend. This became a problem for
> printk() with the introduction of NBCON consoles. With every
> printk() call, NBCON console printing kthreads are woken by queueing
> irq_work. This means that irq_work continues to be queued due to
> printk() calls late in the suspend procedure.
>
> Avoid this problem by preventing printk() from queueing irq_work once
> console suspending has begun. This applies to triggering NBCON and legacy
> deferred printing as well as klogd waiters.
>
> Since triggering of NBCON threaded printing relies on irq_work, the
> pr_flush() within console_suspend_all() is used to perform the final flus=
hing
> before suspending consoles and blocking irq_work queueing.
> NBCON consoles that are not suspended (due to the usage of the
> "no_console_suspend" boot argument) transition to atomic flushing.
>
> Introduce a new global variable @console_offload_blocked to flag when
> irq_work queueing is to be avoided. The flag is used by
> printk_get_console_flush_type() to avoid allowing deferred printing and
> switch NBCON consoles to atomic flushing. It is also used by
> vprintk_emit() to avoid klogd waking.
>
> Cc: <stable@vger.kernel.org> # 6.13.x because no drivers in 6.12.x
> Fixes: 6b93bb41f6ea ("printk: Add non-BKL (nbcon) console basic
> infrastructure")
> Closes:
> https://lore.ke/
> rnel.org%2Flkml%2FDB9PR04MB8429E7DDF2D93C2695DE401D92C4A%40DB
> 9PR04MB8429.eurprd04.prod.outlook.com&data=3D05%7C02%7Csherry.sun%4
> 0nxp.com%7C70da522fd21f416f3d1708de2130affc%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C638984690180001517%7CUnknown%7CTWFp
> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DjzpzHfyW
> 0kCsvsUz4DgQqSdoNxedZF2rnT9gS%2FuBa7A%3D&reserved=3D0
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

For this patch, Tested-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry

> ---
>  kernel/printk/internal.h |  8 ++++---
>  kernel/printk/printk.c   | 51 ++++++++++++++++++++++++++++------------
>  2 files changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h index
> f72bbfa266d6c..b20929b7d71f5 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -230,6 +230,8 @@ struct console_flush_type {
>       bool    legacy_offload;
>  };
>
> +extern bool console_irqwork_blocked;
> +
>  /*
>   * Identify which console flushing methods should be used in the context=
 of
>   * the caller.
> @@ -241,7 +243,7 @@ static inline void printk_get_console_flush_type(stru=
ct
> console_flush_type *ft)
>       switch (nbcon_get_default_prio()) {
>       case NBCON_PRIO_NORMAL:
>               if (have_nbcon_console && !have_boot_console) {
> -                     if (printk_kthreads_running)
> +                     if (printk_kthreads_running
> && !console_irqwork_blocked)
>                               ft->nbcon_offload =3D true;
>                       else
>                               ft->nbcon_atomic =3D true;
> @@ -251,7 +253,7 @@ static inline void printk_get_console_flush_type(stru=
ct
> console_flush_type *ft)
>               if (have_legacy_console || have_boot_console) {
>                       if (!is_printk_legacy_deferred())
>                               ft->legacy_direct =3D true;
> -                     else
> +                     else if (!console_irqwork_blocked)
>                               ft->legacy_offload =3D true;
>               }
>               break;
> @@ -264,7 +266,7 @@ static inline void printk_get_console_flush_type(stru=
ct
> console_flush_type *ft)
>               if (have_legacy_console || have_boot_console) {
>                       if (!is_printk_legacy_deferred())
>                               ft->legacy_direct =3D true;
> -                     else
> +                     else if (!console_irqwork_blocked)
>                               ft->legacy_offload =3D true;
>               }
>               break;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c index
> 5aee9ffb16b9a..94fc4a8662d4b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -462,6 +462,9 @@ bool have_boot_console;
>  /* See printk_legacy_allow_panic_sync() for details. */  bool
> legacy_allow_panic_sync;
>
> +/* Avoid using irq_work when suspending. */ bool
> +console_irqwork_blocked;
> +
>  #ifdef CONFIG_PRINTK
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level=
,
>
>       if (ft.legacy_offload)
>               defer_console_output();
> -     else
> +     else if (!console_irqwork_blocked)
>               wake_up_klogd();
>
>       return printed_len;
> @@ -2730,10 +2733,20 @@ void console_suspend_all(void)  {
>       struct console *con;
>
> +     if (console_suspend_enabled)
> +             pr_info("Suspending console(s) (use no_console_suspend to
> debug)\n");
> +
> +     /*
> +      * Flush any console backlog and then avoid queueing irq_work until
> +      * console_resume_all(). Until then deferred printing is no longer
> +      * triggered, NBCON consoles transition to atomic flushing, and
> +      * any klogd waiters are not triggered.
> +      */
> +     pr_flush(1000, true);
> +     console_irqwork_blocked =3D true;
> +
>       if (!console_suspend_enabled)
>               return;
> -     pr_info("Suspending console(s) (use no_console_suspend to
> debug)\n");
> -     pr_flush(1000, true);
>
>       console_list_lock();
>       for_each_console(con)
> @@ -2754,26 +2767,34 @@ void console_resume_all(void)
>       struct console_flush_type ft;
>       struct console *con;
>
> -     if (!console_suspend_enabled)
> -             return;
> -
> -     console_list_lock();
> -     for_each_console(con)
> -             console_srcu_write_flags(con, con->flags &
> ~CON_SUSPENDED);
> -     console_list_unlock();
> -
>       /*
> -      * Ensure that all SRCU list walks have completed. All printing
> -      * contexts must be able to see they are no longer suspended so
> -      * that they are guaranteed to wake up and resume printing.
> +      * Allow queueing irq_work. After restoring console state, deferred
> +      * printing and any klogd waiters need to be triggered in case ther=
e
> +      * is now a console backlog.
>        */
> -     synchronize_srcu(&console_srcu);
> +     console_irqwork_blocked =3D false;
> +
> +     if (console_suspend_enabled) {
> +             console_list_lock();
> +             for_each_console(con)
> +                     console_srcu_write_flags(con, con->flags &
> ~CON_SUSPENDED);
> +             console_list_unlock();
> +
> +             /*
> +              * Ensure that all SRCU list walks have completed. All prin=
ting
> +              * contexts must be able to see they are no longer suspende=
d
> so
> +              * that they are guaranteed to wake up and resume printing.
> +              */
> +             synchronize_srcu(&console_srcu);
> +     }
>
>       printk_get_console_flush_type(&ft);
>       if (ft.nbcon_offload)
>               nbcon_kthreads_wake();
>       if (ft.legacy_offload)
>               defer_console_output();
> +     else
> +             wake_up_klogd();
>
>       pr_flush(1000, true);
>  }
> --
> 2.47.3


