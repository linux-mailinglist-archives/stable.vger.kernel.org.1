Return-Path: <stable+bounces-144099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53DAB4AEC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5022F3B2450
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC71E5B85;
	Tue, 13 May 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ci/eyBSk"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9471E3DE5
	for <stable@vger.kernel.org>; Tue, 13 May 2025 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113725; cv=fail; b=fDHfSc6sqkUs1dzJj4IBhfhxOLCbuDgYY+MbyZT/1X/tGscPjirhhIKTMbOADQza/FehB1DW+jhxjnsOeh5Cvhp40EUBkiZX2J+XNZpbWW5BL6RrTuwZ9aZx4yQbPPG43iGF7QCW90jaKKVqkrwImCVbAs6MtxE6pvYKYsBB8yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113725; c=relaxed/simple;
	bh=zd5RQLnS+pxHsCQXtsVXgYOlz0RyH3ugSqVR1jMfd+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uv8R44yaWZrOyhTpY/huSw3/wPqeCJH4R8ejEuFUZuVZ66ZUXUJ/csf4szziqeN1WmJanwMF7GlG7hz/SZqsCF0+/nbJ5ooVIkgHHj0H0H4N8BHv7KyJZrqm2q3pqmoBaK4KK9xbHRNLTWTvEFixUSrJk5SYBrDXpvwH3pA69oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Ci/eyBSk; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZa0VGX3coi7XlAzV6oDY/d6NUkQeId7CgTZuqKdvaT9PGfMapdZ3IN1Nw0Og9rP8cLJEHyebUYDZB9W6/DT4gRPVHftnoDZ2ZNRKhC0b7Cicx0SZtdi7Vx/fNIVOEOitjNreng1XlJ4JmcCMI92zvaM2JY97YV8mqqqzgBEAatM4nO7Ti7LEpWBkhlRuf6YNrcgClIvaoo6ose5AbYnpp0nzUWa6pFQcmJPbYkQWuEB1HnHbJKvYWl6JbP/YKk1Eu9IjrEzCdYt9BGFH62nZcrgWz+iuzJ4lD1db6rIgleMDArIKksSQUNOQt29kyb2ochGzuXaX8WqiP9ybdxh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1I5oGT5xEIc+GXZjzC8H/fXeVAN0pEyq7a6S+Nsacc=;
 b=bPLsN1EyZoJfhMx228Nb6YS5sEDXJFPeav2vhuJ7fIxa/lLuHlOGGEyK5VrFjkZlPOz+9AbTe372J/munOWxW+w3jBWh2sQpU74MQXvj+H7rSNznb6TVFq5MdN7ppx++NBrqRkAKsRJrtQaV/ebqCn5nY9fu7pv5S8cCq99GdndUD7mDASpZlndKgIw1NPPWzA3DK+aQizhF5nkkJYkJmUPuxxfNoHd7K2zsmAgzVHR9mCHwFtQ1oHBfmqVMYBXqwNKDksdGJsvdbT/nlbl+sg8vYSDy1e0NDqlv2PaZnzsdswm7RkfKlLg9nxw5F0bVSUsxkCU7LNv6V1fgcKxiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1I5oGT5xEIc+GXZjzC8H/fXeVAN0pEyq7a6S+Nsacc=;
 b=Ci/eyBSk4AxCbcdCNXMThrai40yENigTMJFuN0hn2+JAU9uNPcYs0q4iAXV5BBMa2l2MCUrhk1jax2gOJUujctrZ3vf64J+oF2ACIXWzsLjn/4ui/QyAgfeQ/VG5k+Cjguvxao7G+0/SD+4YLvyp3GFA19ghafdM+r2VH2v8s7A7fih2SLA6Js7KNnhoYybtI92RJQ+Pip852Y9yMjmaG2cozDfddA/3cj/qErKRQXOYvIm8vfK2sfgfUp1qUb2znLiwYGPOyVO7V1nIjAY3TfP7/ssYhtHHHkXhkbtFmm3n8lbBLU/KBUbzD4M7+Cqedu2VPSLMgkA2+RNr88qEhg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10258.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 05:21:58 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 05:21:58 +0000
From: Aditya Garg <gargaditya08@live.com>
To: gregkh@linuxfoundation.org
Cc: dmitry.torokhov@gmail.com,
	kernel.hias@eilert.tech,
	enopatch@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH RESEND 0/2] Rebase synaptics patches for 5.4
Date: Tue, 13 May 2025 05:19:48 +0000
Message-ID:
 <PN3PR01MB9597A25E7A73E2034C4C07C0B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250513052135.7997-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5952a5c2-618c-4648-0f82-08dd91de13f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799006|7092599006|8060799009|8022599003|15080799009|5072599009|1602099012|3412199025|4302099013|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ftv5FI+7WDIheVjT6m792yezMAOaT/bWzkCOkL7ATiXcdijrJOaKwaBfJiQr?=
 =?us-ascii?Q?+lPrvs7fRcQrDEVUEQpyW3k+opUmFLDxbfQAlwAlqCviscBhizriL8Q4rwVW?=
 =?us-ascii?Q?W75LKUMwrm+k5junbODrhxmM1wNqAF2+BRoK+gHJTIzZLPKyTdI7KxJyUJzY?=
 =?us-ascii?Q?I1C2D66XcLgbEvkEmv+i7UMoNjdR3nnn2tmBA5EPryAElaKvUJ85zkdy2CJB?=
 =?us-ascii?Q?OH4GuJRrkNiTdWCwyHxqCpFweXyCGRzElwam7L/IohUhGaaC/Gh5+cp6leMi?=
 =?us-ascii?Q?RJ5YFz3R1XO1WrQW3dMZoYcyuHLnOmx12faknoaQFOJWo8yt10grFro8zPqx?=
 =?us-ascii?Q?M88Is9RNQwj/L7Sj5tw5y35Gx2gRatWfOR5bQd5NQm2LMCHThYEEMCVgMBBK?=
 =?us-ascii?Q?LnfiwiRdxg3LLlPHdIpOnYt1GWuv0vJn+PFrJnoBdhO3vuQaC0mD86tKLfUg?=
 =?us-ascii?Q?2SdIpUkk22XrGVMjygmvu2isgPApd9l/Szn5WTD8tsOBrwNjcZSzMojpfOBv?=
 =?us-ascii?Q?adk5u+23oP04psu6uHW3jjR9q8woPqF/KcwMD+oQ4cp5z+8Y5il5K1SEufNq?=
 =?us-ascii?Q?srxe9Q36Cm1sqN7SbIrt4ZjnTbGH8aBME5ggZOmSgR7PT/woCIcVCXxXlR3j?=
 =?us-ascii?Q?IO57VDtvsFPrg2zHzcpb7kF4nnqtkhXJx39wkgdk1VFCR2PlpJTRKs7bx5bJ?=
 =?us-ascii?Q?SCMAn1onfX187z3WJoNReRZCQgKVd5oY/VUd611VYir+Gpbo7KhJEkBPcvY9?=
 =?us-ascii?Q?gCfraeqc2xNcZQ3MgJyBAj2H4m/e5USZDSE7J6vy/C4WulB57zy5ZceIZBjt?=
 =?us-ascii?Q?0I9jlU/YnFM72B2QtAWG+7f+Jpaq5O6q9Jlnl4lngmjGs7gy9jgMZw9NTMyY?=
 =?us-ascii?Q?oH+pt4tcDt2k3aCV5j0qH4QgNtmi8owHEaUlqfrUXhz64rRO1HwemsiO2HeJ?=
 =?us-ascii?Q?qrIb+t2KJWOfZhmXcHbUJIQj0eZxmRb3G8lxSdS4AxHgi6tYjwT0kto9M5FG?=
 =?us-ascii?Q?jYsFGjHDruUBu/J31lmUmjG32ZXXmBh/cj0NN1ezg+4b4pTuMqcXYh7OAIO1?=
 =?us-ascii?Q?4Hpzy/3RHxjgdJJssXDIK25FQHj6lHwC0+0krqEoAE+0HZGd/8LObW7gYQ2Z?=
 =?us-ascii?Q?dTbHpYdLJjLw84HABohc6ptn7qinaVnkExm3gl33AuqaPMYnJL1s+AbV/xoF?=
 =?us-ascii?Q?Enrnt98eQPVpI3ffygpezbISPbXoywmBxT881gOWj5xsmyxic1QznDkYZJma?=
 =?us-ascii?Q?e25ihdZiHNxRYy4eMuoW/LUOOQp5j+mlLMZIG4JsiQLg7OLA3jU6YiUbGlhP?=
 =?us-ascii?Q?l1t694DQpDrdUIHOp1oqZvYU?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q48FhWcPPuoP28EfpU4BjrKy9TlzUG2ACJtdptHIV49wSbD25LUnNntFhmHi?=
 =?us-ascii?Q?sxRyvAMAE+9k2z05eY0+U+FapCJ0KukvTB3HaR4KCv55WXEa4hbSXu1mKsJA?=
 =?us-ascii?Q?uo47TWJX2MfxtgJqe1q+oFFD3WaxTalrGiOWnMox5cg04+Qns7Gr1AnGRx1u?=
 =?us-ascii?Q?LqkRsFhg1hfv9sAcTb5Ha5uPUE5tYF00qohb9ewv9mLYoV7ne+WGmp8OHUhE?=
 =?us-ascii?Q?Tze1MILyzsOeQPif+ig+DB+3G2OtkuqTnexWQcrcV8tDhQ8trIObCNUYOgB3?=
 =?us-ascii?Q?SnqG4VoCyzYRk1ajcRLBE5+TR2Uzps9/1+o83Lbs40xb2iT+DF//LZYdylpc?=
 =?us-ascii?Q?xFowp+nH3NkeG6bE5W6uJ/90ChY+W/KFeW6wzBk1mCE+yuN/URQ79ETJBQAf?=
 =?us-ascii?Q?Ks7BTTcszDYvYH28SpRBaa3jJ91y8lH2PJ7mNHiU8wAaj2/ely9jQtXmF1t5?=
 =?us-ascii?Q?pqX1xDvlerqQkWtAE0CeL1ifwtOc/FiDzkPaHqTlT9acX3iZifUt8sMGWVPu?=
 =?us-ascii?Q?nLBLjPROEJylyKalc17z4znVtlZOf/+Ol7MH/xk+V7ujLeE+I6tpLX2SJ4/P?=
 =?us-ascii?Q?4jnw7Uw1zXIvqCO9yc5N1ZooUSyGZXAf+EaRbK8TRLg+ItTAooEZ7a3uHSvu?=
 =?us-ascii?Q?rK2Vdj8ITr881q2r5F/+uKhKvOZEkUpxvmjj4WmK1SqrO6Lwpp26JmMjRIjx?=
 =?us-ascii?Q?4+4Bkpz1CdihP/xIYorsYp5zR41QyjmmlWCRqemlnhNyf1fl2RxVQRxoeyAz?=
 =?us-ascii?Q?YYjMVBRAqcRt+5OQsa748CNvdB52LDuR1PSsAMpY4rEeelRzr+K27OEYOHye?=
 =?us-ascii?Q?2PH6heF7gkFLlp+SatZJOclBUbRHgChMsXDIo8b8ANwg/fJ2PyLsXIgOpVW9?=
 =?us-ascii?Q?XJ2gzor6zVAiDxLLK4UtGHLq1xOuIz5Im0toyaLxGCDnpSakpEGabBIvyPkB?=
 =?us-ascii?Q?Va1EQZg7dlyIGl4H0rXnhZZMtOBdqked+rcm3bRa7+K96eTk4CNHWkSNZydc?=
 =?us-ascii?Q?lZI6pXEmiUqkFNsMKU++Ysln/zsxNYqh/D7u2f0ZvEU11hmvBoQS7jDY2Hr6?=
 =?us-ascii?Q?Le4DI69f+RxQZTWmaTHXgCIdGaPaFNRJhbA19EUJzi9FUvx0EpRA72i6qDNc?=
 =?us-ascii?Q?ita+8i/SH9xT607N4vc337Py4eYLXHox0/mLwfi8hBWg5Kw9meecIaDfowIj?=
 =?us-ascii?Q?i2I8JqQFMpB9Agrj+UjL/Xd7xrtpnpea3vBF/8gqHx10w95+zYJgsL50hHA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5952a5c2-618c-4648-0f82-08dd91de13f2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 05:21:58.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10258

Hi Greg

Two patches for synaptics driver seems to not have been backported to 5.4
but have been added to 5.10 and later versions. These patches are:

1. https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10/input-synaptics-enable-smbus-for-hp-elitebook-850-g1.patch

2. https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10/input-synaptics-enable-intertouch-on-tuxedo-infinitybook-pro-14-v5.patch

I'm sending them after rebasing them to 5.4.

Thanks

RESEND: since I forgot to Cc stable

Aditya Garg (1):
  Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5

Dmitry Torokhov (1):
  Input: synaptics - enable SMBus for HP Elitebook 850 G1

 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.49.0


