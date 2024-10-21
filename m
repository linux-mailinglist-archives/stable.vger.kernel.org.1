Return-Path: <stable+bounces-87591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C999A6EC9
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA889281749
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FD1CCECA;
	Mon, 21 Oct 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4h8eZwk"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA911CCB47;
	Mon, 21 Oct 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525982; cv=fail; b=jf4vyVubVfKpapkk7QIi5hXaO593bTST4IaykP5tgFlzvVRiZdEcdv26/tl6IzF4HMapjA9J9KXRu3Qlrd690aCL9+SfF4K7pTTShiHv4kD4BlRaYg7K6qfWD9CdVu6yinE1jhQFLqqQCVoJ31Q6rCvlgU1kKk/pU4rEdrNqhto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525982; c=relaxed/simple;
	bh=LVPvpN6UfUEPI4HEXhpgYwHHLlYJhpHRXlSArbO51z8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FVlbX0r7lOQf7t224gcXtlDetmzCXT2H1u0wqAugjkh2Ylo3UXPOQUssqpL0odC5wU9Qhipyn5Z/YE2XsdRioNmrxMIHyITZ0koRpTN8wE56j7WuczkIhqP3EVg+QkD9t+R56bNg9SfHdDMxwl4DQUhErTwcWScbas3AI7Mz2T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4h8eZwk; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNrkULC5fdenJM8iaY9OFC0r2K+TU6T+cp4BTQpq8bt18M9ULghoFQXlI8C+ii1g/dfA2K8WFiXR6649/y9ODr7XSNBtslk3aUWn7JPOi60+ScdW9i5n+SyaCqpDLZ15+j4lV5Qa5iJrkRe62xUXyCjyPFJoE/Bl+qUM+8snZQof97SQ9q8NhEDpdw//Bl5UyFrSzAvqk3EOC6m/sWromFd6Uew8Bq7xtoSabK/JbFIqmKKXvOOuASkPDRmrWUnhiFYcmUyP0y7xzpJA/Nq2/lFrH+Zcau/usG3OGM1TQQ7KfAU+pvZ4PSEEzRKKaSejLTNKed8OEiFzRJeiVsqi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxJ7QA8KaqJkauTfjxsCNmO4G/MQwnFXkQnmdpx9NVY=;
 b=rjGc1+SaFbVK+oBydHc44zfEjojnbpaOKvh91UeJbCq9VqQ/DKS4ROEJj+x32j4x1xlzdshg0+fKU8JwHdwTCuRA+fdPU9V4aUE8j4Kt+ImZvn1K54lvZ8ls+7BuTN0nJ/bruH7nIxITEFN3stBXaU1+45cR0CB4zD2DRPTEO+8wXsgDS5BddpDIGjtaGvnQV5Z0AnO03ReoXXxH8ZzGa3dqaaCyGn6Olpp2Z7MWo6gJmgcG26lApYVnZGU4xfZmrzL/LcllbLH5mNkp3JvhF2ayKKdOE6SjHuwe88kF7dXFZasYHis99UZ58LOdJHvUEhcQMLGTjMixba1/R1FIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxJ7QA8KaqJkauTfjxsCNmO4G/MQwnFXkQnmdpx9NVY=;
 b=F4h8eZwkFRvMEM+KP4Ft4vFZtFoAAzrjh24hbOMFLXd/uPDBXDFqml0btYJeyKgLgOsws9V31mmZIiDH+r6pixk1SbeIRxS0YvpxaPRXmbomHMRnLGJl5d/3SSsvq35qJutVyo/JZHFXG05RVidhCnoGVJnhS6wqhhZ4CQJBt1vRMeHsi5L10qx2VzK43lGVpUnR0r08+A8LlZKq5fH4KjWSH0cjmedle4gXtf02+YvlbwZIT+JQxwya3dWHy4mB4znpn7zS+YP/rvucBqYTUPBkyR4Lw4fqut5HWOjd8beQvyhCv7uG5lfztOXHInPta2/UNUw9RRwmhiWt7yXBcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM7PR04MB6790.eurprd04.prod.outlook.com (2603:10a6:20b:dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:52:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 15:52:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	festevam@gmail.com,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	kishon@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	marcel.ziswiler@toradex.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check
Date: Mon, 21 Oct 2024 11:52:41 -0400
Message-Id: <20241021155241.943665-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM7PR04MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fe5cf0-fd06-46fc-148c-08dcf1e86e23
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?spicvokFsSKZQOUTfcu6qFVSXaTOI29f1xFR1dGAKdzQ23xXc4tscjPzj09/?=
 =?us-ascii?Q?CEBOhvMglvITNw9vgMhixfPkfN1UXDEHu9LHuQa/RoiedA5+fltYINeyeje2?=
 =?us-ascii?Q?pYZsv9gJWEPqnSyLR1+4D6Ko8NjxIAN6Opa9FsDRldnu6JFdiMAV1+bC75Qx?=
 =?us-ascii?Q?gCs9IbV/YPW203mEr3Xn0h7ZBBLS8uDN+lyzfSx1Absmmc6x1e4w4shgOo6Z?=
 =?us-ascii?Q?VPftM8YDszf8SDpOHfD8d2br4sBvsMxq0wOKExUOfPa2j3VLRnSSPxu08sCs?=
 =?us-ascii?Q?UhqeCJCCT6xqh0S9uW0+kN9IpgFdWA9/WkKvCZVSQ/Y1rogut4dOrrwW6DcF?=
 =?us-ascii?Q?pm+uie5hC2NvjZJeGbwjH/p3L82Cppa1Htn1t0YIFYj5rZLIpRlqLYQpKeZb?=
 =?us-ascii?Q?rv390Q8OO2+Wjs1Ya35cWW0yo7KqqFEOxCu93dicKRvpIjgcfKuoVStiMY1w?=
 =?us-ascii?Q?k2zMzzIf73Mpiu20Y3v2wLcplDMdthgMskTZaaLh+c0aaseT1IbNOLUU35WD?=
 =?us-ascii?Q?G0FX/VuElLOdHp5nwc4MrZ0c4ngfYSPSxOvOjga+jmRIloByFeJF4UPc4y7n?=
 =?us-ascii?Q?z+hVS3IDkAALwxGCx2wF77X6oe2dX/EPtm8FK0ymK8YKdTBo/WH/dcfkbsSo?=
 =?us-ascii?Q?vSUN30j7pNfwqByMNHtF7Exl2mi+YiNHFqBSxeg3l7rP0P4ODXzywEz9ZjEy?=
 =?us-ascii?Q?nyOEg8OMa6IgGdeG1ZwVHYoY9EbTgLqKOb7kzfzcETqsOeGlqR6uQ6BajIMV?=
 =?us-ascii?Q?sD4G14V1v00oKY8Z24R4f30Zj+DyA8+T8hEi83O27qaTj5jh3Pzkwqn+zHBM?=
 =?us-ascii?Q?TXLochvPIAY/uOymE/F3g4nDuB1NXnQIA1DaKLZcghXHkc8pNK/0Il+oehxW?=
 =?us-ascii?Q?rMuO8rjopbMsZGyW0ncNA5mdygvQ8wIglGWJ1KgT2KbBUtx9QZXwvDTPZ+Bx?=
 =?us-ascii?Q?Xta5SahU8DpbWo82borb1jJvw2mvxtNOTYtHlybnYeUjsTnrDJ+kZe1pOnuf?=
 =?us-ascii?Q?qbKXwfCvPYr2shLmEeQL0bEFJp9TMzPHMT9BETEC89/hZFCdZNFjkxMleonw?=
 =?us-ascii?Q?h3X1xn8tHZMwqv2EQVoIrYMOMkE43pEQ/YMeWWPTDmQxoL7eHrJ5w3MMQnGj?=
 =?us-ascii?Q?QCXpQzuZGRPV1s+5H+Ahu4x2/IZotqMNp2BAiV34EhOUTvb81oc3j3ZEvmQP?=
 =?us-ascii?Q?ZcQjOLQCsdU0cSIZLICcd9rpWe6pDMqx+0AOTZjERDMT/F4gcoKqNMls2s56?=
 =?us-ascii?Q?oKfsKaEofmV5ef5bSQnfa0UfUUKVUxuGg1J+P8TNvFiJ5hzWsg8x/CyB1xAy?=
 =?us-ascii?Q?mc3dFeqoEXN58jMgr6e/C7javBxCraJ+UCftGm+dqse2iG0juxi32JtOA3z9?=
 =?us-ascii?Q?Qsm6m+4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Zsq1rng2huf9CseiyzJFRz9w6NEDJjSfALGqWG+ggtEjHeNRCFt8j9ULcj5i?=
 =?us-ascii?Q?T5i4X6EXkZ62to0eZmvKCJu/KfaZ38jalzSaQOYWaVtLfa8rzwSbA5ID+l4a?=
 =?us-ascii?Q?xlQ09Fs4nElXnZcLe0F3lk1L1OBT8aUs095PPErtc+dD1QQFxATyvUODcwC0?=
 =?us-ascii?Q?zfrs4vro9SqwtYBxyfWcrjW8ZjkBEpniZ1pJoxTn2PVUP+KnylODlTVABBaU?=
 =?us-ascii?Q?dNTF5cBAOr1FeIWV9SWT6JbukKELbkSh2EIOsL5YjBwvbEwDj0GBdz8tmkxY?=
 =?us-ascii?Q?oPubOPavQkoh3txC+HfgdWVq1xRp2/Q5HuF+DmxzI4oK7QhDKvdKwCW/kBrf?=
 =?us-ascii?Q?GmV/wceAumzuDY0W4F9Ifu2h+QQvJIZ5anLvWO+UAtNzGsW9jBqPO/cXmqE0?=
 =?us-ascii?Q?ZEoyLZMM3U9nYG7FW/ogXjOpM5r3NcmktfwqGEqdRrFjeCLD8Oq5IpMkrlAr?=
 =?us-ascii?Q?aK956ZCSIKokXeaJFQkQ/O/F49ycKdMMxm6VJym401n4/ezBOHansSC3TaAh?=
 =?us-ascii?Q?G9sR5LgYdqRUa7AtyVxaIy/XxPOJWyBxbaqswhCKxSU+lUQzw0buQYAsFqrS?=
 =?us-ascii?Q?IPLYpLoURki/sM9rANBbMCdRsA5yo9Se1NCoEKd/N6JVttbNtSRUZyM3uxuo?=
 =?us-ascii?Q?8kCo8+LzRFYWERJoci+pO+qmnjNoZEX63x2zFVtYlt0P6X3V8IDkVVttN9dw?=
 =?us-ascii?Q?tFQ3CR36KJVIQ5ZXxbcWBwycP4aQrivKYYImMw8MvyqrA5JbEVdMka6/Qi4L?=
 =?us-ascii?Q?76w+IrdWkX3KFbZO6v0unZWYgvCCWkJ5dAmV6C+Zwg2Vw38FJmbtvywnD+et?=
 =?us-ascii?Q?3fhrundXwCIE16K0AaWGaWTIj5aIpiHzY/TOSCt+VFpGZpzbSf1pyIP6aIYh?=
 =?us-ascii?Q?zeA9wtopE8XgeLQpdtsyoOTMgWgOcb1cHFBUu2Rqw0DcbjVIV8X7Ec6VF1wj?=
 =?us-ascii?Q?y62sS7aShNyF7PWVFhkRKYF1aBAuQmsgzK+jNjZslcu3KMRitBpmkvC+/hQa?=
 =?us-ascii?Q?LcqnZvnyvWXlD+IOJ/68t7xlCi2QZADRxqxiBlOhWXgCew7BmpyVNNmi2pOq?=
 =?us-ascii?Q?qGNxfS5/QS9qWsebDmMV5HA1AEupsijME0F4pM9+98RQM7oKzNLZ5XEdu0LM?=
 =?us-ascii?Q?5pRVvrdjoLzrqSMzw/kD+mcpKwmf87qr7BIrJmHaU7WtMXgUyg/4fl5hWDmZ?=
 =?us-ascii?Q?mLVkZArNjst4HL9hhLupxTIt0VFaFsEjcm41hJF6xY2rRXplr+K0IBQ8jbNY?=
 =?us-ascii?Q?08YF04wb3zbl2lw4g0SVxifsBUV4rmbP5qX6ST239O+P8vFaVI/tmLitDVYb?=
 =?us-ascii?Q?H6XnmJYOnjPPv55eriDkHHjgtWNRztbcPdn7dDAjyQB45syRwgRUDNKxtJU9?=
 =?us-ascii?Q?PYbsiUFI4W/AHCfPjiTpv8ws1Z5G4pG5snV6aRq31p0BYZ16ZZdkTIgMLpUL?=
 =?us-ascii?Q?h7ohi4SUdjqpQcKl1h5mz32XU1HfaDoqHSm2mo0KMuaUyQRATf5Hvks6ShXm?=
 =?us-ascii?Q?U0ZSteOY7UDiWgAgLH7eXp0Rn41IV0fJvQaxEdsxmhuT1XaTOP1Ul3BVhkD5?=
 =?us-ascii?Q?DVRiaa3RzSGqk8d7PPU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fe5cf0-fd06-46fc-148c-08dcf1e86e23
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:52:56.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUT32ERjbkbgJCsbl2dntYeP22XETYFZCv0nDaGbfBQnCDQmcsQvjL3GiwBZTgVn2rspNEcb96p+NJQKN+nVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6790

From: Richard Zhu <hongxing.zhu@nxp.com>

When enable initcall_debug together with higher debug level below.
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=9
CONFIG_CONSOLE_LOGLEVEL_QUIET=9
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7

The initialization of i.MX8MP PCIe PHY might be timeout failed randomly.
To fix this issue, adjust the sequence of the resets refer to the power
up sequence listed below.

i.MX8MP PCIe PHY power up sequence:
                          /---------------------------------------------
1.8v supply     ---------/
                    /---------------------------------------------------
0.8v supply     ---/

                ---\ /--------------------------------------------------
                    X        REFCLK Valid
Reference Clock ---/ \--------------------------------------------------
                             -------------------------------------------
                             |
i_init_restn    --------------
                                    ------------------------------------
                                    |
i_cmn_rstn      ---------------------
                                         -------------------------------
                                         |
o_pll_lock_done --------------------------

Logs:
imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff -> 0x0000000000
imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff -> 0x0018000000
probe of clk_imx8mp_audiomix.reset.0 returned 0 after 1052 usecs
probe of 30e20000.clock-controller returned 0 after 32971 usecs
phy phy-32f00000.pcie-phy.4: phy poweron failed --> -110
probe of 30e10000.dma-controller returned 0 after 10235 usecs
imx6q-pcie 33800000.pcie: waiting for PHY ready timeout!
dwhdmi-imx 32fd8000.hdmi: Detected HDMI TX controller v2.13a with HDCP (samsung_dw_hdmi_phy2)
imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -110

Fixes: dce9edff16ee ("phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

v2 changes:
- Rebase to latest fixes branch of linux-phy git repo.
- Richard's environment have problem and can't sent out patch. So I help
post this fix patch.
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 11fcb1867118c..e98361dcdeadf 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -141,11 +141,6 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
 	usleep_range(100, 200);
 
-	/* Do the PHY common block reset */
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_CMN_RST,
-			   IMX8MM_GPR_PCIE_CMN_RST);
-
 	switch (imx8_phy->drvdata->variant) {
 	case IMX8MP:
 		reset_control_deassert(imx8_phy->perst);
@@ -156,6 +151,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		break;
 	}
 
+	/* Do the PHY common block reset */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_CMN_RST,
+			   IMX8MM_GPR_PCIE_CMN_RST);
+
 	/* Polling to check the phy is ready or not. */
 	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
 				 val, val == ANA_PLL_DONE, 10, 20000);
-- 
2.34.1


