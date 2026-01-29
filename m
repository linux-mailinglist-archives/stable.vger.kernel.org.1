Return-Path: <stable+bounces-212793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK3RB+aOe2kKGAIAu9opvQ
	(envelope-from <stable+bounces-212793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:46:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F13B263F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BFD93004404
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD422032D;
	Thu, 29 Jan 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FH6/Hisu"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AA78F2F;
	Thu, 29 Jan 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705179; cv=fail; b=IaV9wNXaa5augZI0M15WfHpL4/pbWO+FQrZ23X7hLNOWxesKWd/DZ82bHSDJP0gdg+ogfArSOwnIM8SuBIioym1gM5nhrB4p7/gwWkSTRLG/MplmQnvEcgqEZSrnHmOS1+FDY6+qRp//NDDT6PHaBg7Fy90npYT7gH9m++7Z1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705179; c=relaxed/simple;
	bh=9Ka7NwDEtG6wHaBF8GcHqCxdqyKbH4BNa0w7ccNTH/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUxN6bQGlxVnhhpcUo2Ito44/fHdllGsNrXK5dX3KlgPkJ61kbAv3WVNGBCJpxPr8jY3pCxS6rAXcXtzsWSKjktke2W1hFPTuOWtbmM7Erlel1YGUxeg55yOyCvrImye0MRXiG20iv92yOxbn7aR5QXUU2nVW67r7wroTnlSqBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FH6/Hisu; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZhcXZCpYro48xhhjEGp++0de4qeC1IDyynNRBFriS9ycRnAPThN5+XT0loAG7+FTYyal5yG5ZjfjP/TTwuWypYVXj8BsI42NC2abhEM3QogZv4ldsjZqhiA1qY5Yljc5Lk4eFG+xkn+1iAyKLytxAtFAuqOwPhS0WJaz4m8h5tESDf+SLDb/jnyFtSIDzq+rfFo288u2Z9UpnY5UtaKv6PG9Bb1JwgvUjO1x8bBGqXfkK5bltQtLLTRx4pD01DVPItfz2DCB2N9aodTizL3szo+ZNrOh44bmsu++63cF7+WCoNNVNeJ1dCU9CLrUDpnKTjTbYH0AIiou+J1irwhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww6WjAYHk2A5BbZJhN3cSd+3ULsrYzDHuQWgg//bBo4=;
 b=Sq727fghnfpX9uVxN93kkPEA7TyXKt2ghu79RJnGe6Qk3mwZy1fYx7obtP7D8KnwW4thaeXVQV+387T2fNclEN2to99YukLrQFELjPqv8cshacD91T1snFXyGAN7YOgB54DqEWF+UIrUSUg9zvGKoVJMtK1hhl4d9zZmlifG7UJog095Cu7QTwsEhMPfDDE8SiCDvosZ9K21f8yRKikooGjiWR4nzViBsFTfGRiyQCrTF082N2gyiWpQ7a6v/YmcPBf1OhntlOMgfdtYPhvsMEDP5ngZYjlmmFxy5jLh78CUfOC9H9ZeMaMlS67bMlJrzZy3A9Xa5T6OICeX1xnn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww6WjAYHk2A5BbZJhN3cSd+3ULsrYzDHuQWgg//bBo4=;
 b=FH6/HisuaatIVyOhD5p6i2Dm1Xw3fQFcNlxHCc58/G+LIB1plvsyPm7Q7qN3UZI9UBe6vodnea7GAHfuQi4YFmwWZSK1H+uLQxySWEYiNW5tTi5/YAPF8fFKMmgAxXKn/xgNXesTI+BO3asL1yLlWnRbzPJN/5CP2C41uR//6TIzNapKwvSZ8h1c50nPdJctX5YBOSK4Sr8sSwSYd+9Y0XPHpLpAj1uTN4OGPMlswI/L52cm8Obd6N3cEmvo2g+jcDlekwrj+CJrrCXwKYi3h8a92QQnNi9OzozyTRCBAkYqn2MKVHD7i3DVuszgsORw3fd+JcFgFq+EtuLBfqPn0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9824.eurprd04.prod.outlook.com (2603:10a6:10:4dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 16:46:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 16:46:14 +0000
Date: Thu, 29 Jan 2026 11:46:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx95-toradex-smarc: fix
 PMIC_SD2_VSEL label position
Message-ID: <aXuOzZc2s8TFVNn1@lizhi-Precision-Tower-5810>
References: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df49cbc-166f-4ed8-e6a6-08de5f55ea4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3RyrKqWj79dW5J866w3HYSVg9Hd6aZXnJPivLqA0ijfsXRXhw7Blu0BtQKs?=
 =?us-ascii?Q?jfjkbOJdgSJbh95xq3NfOKshlMpZCc3Qfuoe21e8XMjeH0mNQFbLRfBxVXkB?=
 =?us-ascii?Q?fCxxlkTc9RVIU4Sks0ACSN/WLDw0duTZaEmL0/0mYMZ/eNViNq8uAtq+ouCl?=
 =?us-ascii?Q?HEFwxg4fG3KB8ApwreIW+WeJgacUol7ZPCnebYe7fH3QFpuw0R8b2Gfkvw7Q?=
 =?us-ascii?Q?qxLinRY/SgRG9NDXZINPbpyTQx0q2EUW5TtJzXxAlgS3HaMTFi1bfBIFp5Dc?=
 =?us-ascii?Q?tU+kj5Ym1zoc5R4qQD9Ke+v4jrKPeYLRBEGnASN1acxTBMooRu/5c/gjFfTj?=
 =?us-ascii?Q?DWA9zLN63NdHpnggZfNJnKmuSuc5naxuwZAP+37hHOKpAA4QgAISL93alXAN?=
 =?us-ascii?Q?IcFuVreSpxud92JUNVoMVCtkRVX8b2qMkIizU0rrY12NnZzrqOCaU8X+vS5m?=
 =?us-ascii?Q?Snc47MSXkW5dTN/RmrTTI5R+2umbBzbJL50TDI1PK3qxjPZcTRmLRyVBpHCr?=
 =?us-ascii?Q?O59DQZaqO3W6ltYHX+645uL9iGitJpSMizL0z7AzYLCAgDVOnHOOIQhrQ1Fx?=
 =?us-ascii?Q?KrqqxNmkKA0rJc4N2yqTPAdTEQc0hPjGQY4mpf9jV3LERAPJ+d0KLtwxmp5z?=
 =?us-ascii?Q?8vx+7X5FnwPc7zaYDTs88npW9Yj0AE2fe5nll/mj9snaOY+DF37H3YKMBfZF?=
 =?us-ascii?Q?vz03BQg5jQp/g03Bw+EbxMeI4RqtITn1B9jDZZuTatrgyXLajPiJIJegOpxF?=
 =?us-ascii?Q?IKMDYpRer3QYB4naE2WXjmxSpWvG4KCY1qwNZ5oBuIfikW8xpQp5pc1G5l0A?=
 =?us-ascii?Q?te32O8X40OSATzhm9fe7txYlXdAx3YFtkb10QUSTbW2m1em2aATgWQwKI9Id?=
 =?us-ascii?Q?6W2FFAx9zjinLa4DdHaHilYPFiURUETTqYvFvgWO0HmOSEBAJqCj9tUHrti3?=
 =?us-ascii?Q?ceAkcS+tkIYvVLOd8es3L1utEvBA5x8+l/wiCUvp/WL9PlEXc7lXSRpYVLVs?=
 =?us-ascii?Q?9OYtrkrAfvAxtw3+G2WMxdXeajM+//4yTcb11spS9ICT2duULPxy38IKtNE/?=
 =?us-ascii?Q?0yR7XyXbUvAXuQwyoK3UmJ5j3J4xuvqvwSJm38seSMFApHKDynp+FEScsWxT?=
 =?us-ascii?Q?OwGE5VQ0N5oUYNh1BDayI05SgXmHZgSiervt3cKjEFhto8F99r4b55AR//KT?=
 =?us-ascii?Q?mO/XA5zsJJPiy20/eyi/SVUIhdYR+5sI/sj1+Ij1kNgYQDI7COatp77NlDym?=
 =?us-ascii?Q?8+sK2lYKfdjG9vgXHG57QTd5CfevXEPrOwvcWQr9+QEKiLZKGf0bOEObxguL?=
 =?us-ascii?Q?4wlf3114rigQawR1+iE+IFEx2Z2a3QgoYsTIzGN7h1wauRFhmfsJbyMWPNdO?=
 =?us-ascii?Q?e6XKmQmqIIKL3a4F6GYR9XFNZHN6uuFB/FOBQ27tdKnFVmlTi3cHCnKsREvt?=
 =?us-ascii?Q?SQ7434XaemX1lrDlxdAVHmkO3zyh4f+qvnCxocdRy5c5cBdL14PS3iQ1hygV?=
 =?us-ascii?Q?Fup9ZM7nCcGYIzGbdG4duTzlcWdUmPBveC2D1wlFq6MVKt35FkBSanuxeb+k?=
 =?us-ascii?Q?C41c/bF2vcAb1Ek4NqErnind5RuBxfNBS6kxhoY9IY+yOAm58A+DV3javdNY?=
 =?us-ascii?Q?BpY9xXZ97KawlGTw8XVN3aA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDxLBG8ZODxduXPRVl7NrcdeIs8BlldH9aOXC4ztPtg/KD275qN4mWhGfHBD?=
 =?us-ascii?Q?RMWHIuDEtPwgRANbYjfem63wYjYFOpH9Is6j2tKJF9eN/9XRvbRDsrw+2VAi?=
 =?us-ascii?Q?voyY1oT97WkDJZ0T2irMsWAdICCxWIhohMtqd6lGAmA/5Co6QzoktUGXGQEx?=
 =?us-ascii?Q?djw8ONPCPtQD6xMpHW5uzNO/YgMzZzpIfIU19yt20o1e2jfv7ex6ffJWjFYO?=
 =?us-ascii?Q?2D29cmuF1s3bYFSsXi6vD7qddlPoM8Q539chwnZ5SwbZ6iBg/KSinBwL9tcY?=
 =?us-ascii?Q?xnFEefTrGKS9DVDWtE5Asq++kA+yJXYl9kFRtPUpLw9hIZwQyp6walTrU0qN?=
 =?us-ascii?Q?YyChN/kwdCVVvIVl1+M4P+0Ib/TwzlGEsbAL4HP01FcPNJAubAL5cDYQSfRZ?=
 =?us-ascii?Q?eGVv+NTs7XO86Tu+WwY1qnvYeRemnc8CS7VAlJfQR/QWmRuOeaQxuFXgDizV?=
 =?us-ascii?Q?TRx3vww8a4sZxB5fM2IlNKqjlmxACjokJ5oKEFb+gb8PRAWJsQXH6VieBV6F?=
 =?us-ascii?Q?Ep9sdn4bQVUVY77+1JpbdgpFL3pkfxqFA2t0fF2KJcSGzQio8TP2yjld2OFV?=
 =?us-ascii?Q?OWE91i8/vFJXC+n9fZnvnjY4GFTAmvBReIC0Jg4fsl+XakGUSNSyYBtEDS+L?=
 =?us-ascii?Q?P8ZSI3h3BMgGVGBPnsJBCzxZCtIMAkJbPRjvyKfP1g7DCXK4q1UrXETHseHJ?=
 =?us-ascii?Q?qF6BYdOHgh2Nsv0c5G5pGwZGuIUpebIsWuf8p0VLk2UMOSAm1T5miZJc4Pfp?=
 =?us-ascii?Q?qTyXdV17KZpzsWSR1bLpvAG1tiTIgbQ9q5UUIgPZvTgPk/SUUwm1LUixrrJT?=
 =?us-ascii?Q?kG1wISssjK6wNaj0llIzVKldFfl8HrSsAr5EPAoVrl9SUnnjpOhrV6kk5HZl?=
 =?us-ascii?Q?8i8OYM7BUMyR+atWmTBhAX0E12TNSQSMXqR1SeVRvUO/b8dN3tEeqgL35afH?=
 =?us-ascii?Q?WDHG7HvGqaYYcp87wDPYLR+rIicfVA4rD7tJbGIX+61H6Z9ncdWbOe7y5bUA?=
 =?us-ascii?Q?2yWbgdoGXIBKQeW7BAqY2CVCoLufFVnbVCvNYDvARpjjjwOKDdhJUZHpAvny?=
 =?us-ascii?Q?93ChFd4n2W0bs6PE12Tr7ajfmfI7tnd4OMKSPQvnuFfh3A90wQpFFyQqFO64?=
 =?us-ascii?Q?bZas5IALzhq0QJ26Cw/s7uperbJZTjIQfT/I26gJMkXGtNPthWUoI6CR9CJf?=
 =?us-ascii?Q?AqSwgK9h53XpgZieTMt2lStZiFyRcTNmkYvVA/3Oi1JiWxBSyh3zO7/Mkx9J?=
 =?us-ascii?Q?/P+VWvb9zTVtojbFSqS4W8rmqumZoY1yKsyqcjwgjX1fjIn1x4+qRc0jHRSJ?=
 =?us-ascii?Q?SHI8rgQsm5nwEwC6z4zedR0NYVjJ6CQrS2+uVAUJrowD4vR4dDVP1h7cpp0r?=
 =?us-ascii?Q?KeXfI0RF/SOz2JE6jsEMJPLu2/KFORUy2lm85ishPUiIbtHSUmPmEJWAR6Dk?=
 =?us-ascii?Q?dAHMMKOK5HPWVdQPkyyC+Os4OUeGahTO5VLpSIEwuQtMh+rJmA5n5B5SEICB?=
 =?us-ascii?Q?L5/2onlYNYbBw3/T5OdBlplcUSjFwR8gDo+6nTS7C1VkwRLcoTe2opbo+pYP?=
 =?us-ascii?Q?GvCyUso6TxO7whA2puc1q8LCzapqjUNJmYWk9HLyKM2CF4sAGb+YSlrSMySO?=
 =?us-ascii?Q?u8gYRRrT+z60XEjrcqE2iK17hA03K3diW2LtDU75jXSCnNzMX2th+dBB2TRk?=
 =?us-ascii?Q?93bz41m5IF6XIb0JkwaRmtXinjKoLCB5LefRaBA6uG+F+XUe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df49cbc-166f-4ed8-e6a6-08de5f55ea4d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 16:46:14.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsshsJFbh7gA9NlCetiG4Z+YGqOMwrhfdLLRh9UO/XzJYz7mhbG/6Y+PSrwW3Aqp+2PFxFQoH+NKva8rCjOl4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9824
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212793-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 65F13B263F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:47:35AM +0100, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Fix the PMIC_SD2_VSEL gpio-line-name position. It should be on line 19
> of gpio3, not line 20.
>
> Fixes: 90bbe88e0ea6 ("arm64: dts: freescale: add Toradex SMARC iMX95")
> Cc: stable@vger.kernel.org
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
> index 5932ba238a8a..f64c05dc50f8 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
> @@ -262,7 +262,6 @@ &gpio3 {
>  			  "",
>  			  "",
>  			  "",
> -			  "",
>  			  "PMIC_SD2_VSEL";
>  	status = "okay";
>  };
> --
> 2.43.0
>

