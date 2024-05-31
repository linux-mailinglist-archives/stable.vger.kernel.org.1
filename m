Return-Path: <stable+bounces-47807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD098D673D
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 18:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300BA1F25199
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6515DBC4;
	Fri, 31 May 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U86mv36y"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD041C687;
	Fri, 31 May 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174239; cv=fail; b=fjF+MkYl9hdMvCay3rpHJeKKPw0vaBHJvOp0iHAD07EVVMvLG/eBOm0HENMRgiZlpm70rzQHzTNCwICmuLlC0zVIRdfHxjnL7+uzFa7YGl44rfSPtqGTYO04mJBcILFchoWB41ZSzP7uwi+NS99Q/L/jzDSdpMHqYMQT4sHSZgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174239; c=relaxed/simple;
	bh=cHqBg6hWQKOySEXBv5lcXJweofoYbEd+6+VX2m7w1nc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IMx/zTcezW8/KG73myE0gLbJ5vZkbSEhO+GceCVIoP7x4mRaZjwHSsbjoUVXDWhKO1Mq+2rNLxov8JhIL4IibaJIqyvcQszuWJcv+KASfh2e0SsMihosC5r/uhJIJjyMaA1N9VvYIsF02wtxJdoDqdgsR/W1frmZv7Hl1RssdBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U86mv36y; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1/kDEUnkRZO4eEPxMKdUSkw1J3CRS/nYxqxDdYIiQVq8/N+eUhqAohab8E2xYitpm7ob0/8Y/+tmL6Abwh91yTDA4U7A97ULaXs81KyVR/5+Q21ABThv8idHhxdYlRn/HMTArnanFve+bawCjlzam8EE/cGp3cbhC9zY2jnYxdbOWaYADeYsES/Yx6AAbZkKX+KvYWF5PwTF506MOHqdF+mPK7rc5k/0QEnjC29tg3WXYlES7mC1kC6jdG39YLJ2q6jnxhXFvi7ExcvLbhZ7W+ITa0Cd2M8Kb12QBMaUtAmtJ+ZJJ/meSFj8w7OVYr/iKWldhrvRnjW42hzjAG5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyu4oeEpKkyQ816PSY5tP0r6R0eqz5kVRRMc/XNd4yI=;
 b=jneeIOpcYlHmpLS1nk1g515Vjbp4mm2hEMb0fyjj2ShxxF7/edwR/NuLxKnIsf8/5o0Nno0Fd15egntyLMuVbVX9K+BhpCbodqRV+7vLY/i57YKv1FdifHjrGpXtAdPoOGCs4m+ywjQRL/Mhs+8vqaYh6K9l4HwAKnNfKVsQrrFdPUxwiMdgdIbteCDurMCLFHwm2pLTRBZIJAAezUzwaUDhP0GHVS0B1s+dVeeMDnDLKf8LW30a6WWl74smLMTCcX313uC0I2Qy0e8Zw/gG+gEuo0SzQPKfylv1AMEagb+ZKTZdOKV7XBaD00mn94owFtUWUW3QI/csZsE9VMNwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyu4oeEpKkyQ816PSY5tP0r6R0eqz5kVRRMc/XNd4yI=;
 b=U86mv36yz6lW2tQz56RtLwu8z6retQvFiCHFEirs4NPiG6yGQLJqhm85QEO2S+l8b/rRGLAe4Pt3KvB/mSTQUxpftG0D0Ocx8NvhhqNf/hhG821tnfUuI0MyaYsLAjLryRWynTjAqRs2R66su/iaTfAAlqqCSNCvzbcDGOF1a/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:50:34 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Fri, 31 May 2024
 16:50:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH stable-5.15.y 0/2] Fix PTP received on wrong port with bridged SJA1105 DSA
Date: Fri, 31 May 2024 19:50:14 +0300
Message-Id: <20240531165016.3021154-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0093.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::22) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6041f0-d9c9-4541-a968-08dc8191ca07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pACoEiqkh/0ry5DHYnyPybnsLkZJdp44qn3aDW/pCNDDhGC5vp8p4btGX/Gs?=
 =?us-ascii?Q?317ocw3PR8CAAhbIj1Rfl+/u/V90DEFOWxSmIth8u0qTWzb2MQxvflUdhKpT?=
 =?us-ascii?Q?RwcJiiKU4oBqBWs8CFNkCFXjlfRjEPAhB2o5wOrFKL63r0BDUPtdsARyEnlW?=
 =?us-ascii?Q?RayeEg4HZIK7T8vJai3NkaciLZUc1RDzj5oUDrJhPfrJ0+Z5zLNEHb7PTXAQ?=
 =?us-ascii?Q?rJWuHTUcT27w5SFk14/NKW4PAPEjjBMEEGYcdx0C2/TZsntWOXCI2AYq3QO1?=
 =?us-ascii?Q?uaRWVR/pqz/J00Cx1F1vXunHnnk8zh1nOXNHlR6Nz7foLhz9hULHKhdOaV0f?=
 =?us-ascii?Q?XkKZYZsosKdO7Zj+CwKIruwbLic+WOQ7qMBokBMsACbAwcHX2tp/0iZjEiAm?=
 =?us-ascii?Q?9sL8bXKrv8MmWxSbLdngYDboDHYrFHkuKT04G0jGbAWvBKB2ApaKEIETK+y5?=
 =?us-ascii?Q?p9ck45OkjZ9yRx9n+RF1oT14c0eeIndt9r+LwAKDJhubJHj5fDjTsIj/wMs0?=
 =?us-ascii?Q?xsLWLD9OnDqLrf+S3NAEn3OlnojZTqs0BRfKxFZn5MTIOTZZuyeT5dshuyu8?=
 =?us-ascii?Q?gibAYtKuyIFE/FNWwLVOCQDIHL0fJz4YaS+JqkBU23dB+A3hl0l0MYwTpkKu?=
 =?us-ascii?Q?ayrIZ9mTCejbr+zDcz/80US5rKHKHB87WqkKfweasv586CrjQ/rUBoqyG+MF?=
 =?us-ascii?Q?5VmIOnHBRY7hg6Zv56yZ5fF/4mWevwkeEljj2YZqehbupB+pOuL66hh+WXl5?=
 =?us-ascii?Q?KBWgUT7KHkEyIObUixOCb07YWnQwbAjRpeh6Mp+l0rV9ZrtH/hIC9DPvfLpS?=
 =?us-ascii?Q?UqTt3a30ZfP4Oo6ufvdWCyHctOSvqKhJGW4VOBk2lBFPNJ4OIMPR1w9qinB3?=
 =?us-ascii?Q?pILotml0sVBrTCMEdfo5rDw4jc1xG0F8dHGdPbhBZVpjupOMpdoXqzeEYPkW?=
 =?us-ascii?Q?lxzffHa6eK/ULprJhpYAoBqi4cf9644ntQkxTUdifjqAYFMB09/7OHZmdXlj?=
 =?us-ascii?Q?8w8jKPBym9efKq0ONmIm2TDeAdzPMm7zguXxT+QZ7HcunvzUr+Y0H5hI/7uq?=
 =?us-ascii?Q?/jZUq/3cPssuijgBNIiiBb6GjG88B4/Azg+1XV3ic5IZ/dnnY2xo8WtvyEsn?=
 =?us-ascii?Q?wfsbUh2zVfZlP/rPsUTaCPU4kSI6itFPYNajT1kWkOpKNY45emTRqQNf4df9?=
 =?us-ascii?Q?b9jaNLVKr/gGMFivgh0XcqAxto1+YZ2JTHQNqeD4yfnKQ1vBeSBENO7jrxck?=
 =?us-ascii?Q?S5hhz4jjnroJ3UFqBJz8lDIxRFVa9avhegR8Wu8Q5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2vFEZxStmGFyHEGz37FHs1uLCX1B2FP3tmoX0b2bvuIL58P9pwG9TZDd57s?=
 =?us-ascii?Q?gYyB6Aaoq3XMBRzVCFnyWzHIM83gsvLBQJFDj7OwWhkbGQDQ/FiDW5LYpP1W?=
 =?us-ascii?Q?XF18ex2JXzSQdi2SrUnTwTeJW74ugQNjlFbBFyLA5zJdlUZHA7UNKmw/Bs2R?=
 =?us-ascii?Q?O0QjGUn9lBQUo5IDdqJrM3pYj+E4op72r83IrPx/tTS4uu25pFFk4I48xmJj?=
 =?us-ascii?Q?q8qXMz1ZlfCg2IOihkpl3YhmcoBdvuu3QY6qhC7Mu0902gqcrSfZyuLYP7yX?=
 =?us-ascii?Q?R3dlYvqg1oQcbPI0YNplQ51s0N2N5DvVUDUfSbc7aFn00HDfI8zAr63lLUAc?=
 =?us-ascii?Q?wSi0WMVGPfMDIJxf7EnJraPlQMe5j35hTibHARKYerWogaZaxoumqKdscB+O?=
 =?us-ascii?Q?xha8Q53SCz2TEpufqjUZ/CXSxPMM6ayNHSDiTRiQyQOyoRSgHIhzhJetr+71?=
 =?us-ascii?Q?IJzS54oq8TRmV+ftBPpolQWYt0nhn5mAAwGjSdFQVR31mDCkHfbE3fgigU05?=
 =?us-ascii?Q?HvB4ZH0HRWCGPUNWRWzVrvk2U8zrHXeQDA61qkYHME8oZStSbXhwx3oj5ajq?=
 =?us-ascii?Q?MlWFbrAEVkDZUFfqLkWlLXLc1sFEbh0sd0NmPnSD5Z1LgX/EOrZ8pw0ig17N?=
 =?us-ascii?Q?b0sLpBX3mpRGWHiPMJgdKjmWqr84uJZXmzt/brBc+N6mk7Lr/H+MkQyisDhh?=
 =?us-ascii?Q?tN+ZCcPSZoLLRzD3V9BX/+yHdAGInr7szy90gDVI4la2it9s2vUI6KHV77dK?=
 =?us-ascii?Q?qseV/0qlx5EGvVlmiAsaOhfRqWCcyqDKlSlPWWaFeNn2770GNyQeVKn3pXVY?=
 =?us-ascii?Q?ZzauyyktTdi8JB6apu3c+zuQyXxJ2ekReKNZ//86RThkYw+3z9mru5kLzCvU?=
 =?us-ascii?Q?I/IqznrVeOJngyvTIfsohvnUten09RJWJo5jP3eik6nhMqB+tfLIO/KsAEY3?=
 =?us-ascii?Q?ssS2K+U5Em0uWWTlUZNztz0Y97jhjDaXa0FK+ybN4szibvgWjT6u7CVQFwJ6?=
 =?us-ascii?Q?yrOBIAXCy8b/dzSkWdh4tFYkVr2L/MEVBrg4qCAzQ1PqCqhAqjlGWjf+WJzW?=
 =?us-ascii?Q?aqw9mY27ig5ky4qRiziE54kumrdXjoeQHC/PgrsF4l2bEcbY3zn9uETPin9S?=
 =?us-ascii?Q?jEt2N3/iPMSwOYw7k/VuvVsTFJreGmh/p/eFVp4oP/mcHIY3K6PfUFxlkklL?=
 =?us-ascii?Q?ET+CZLMCTUDsZ5Tsv4xYazOKB8Hvt/oiwpSF977odXTQLpGp4IKalGZF/GBP?=
 =?us-ascii?Q?9ftF+uZXittsFDQ4THoX540Q9LFAwaLFd+OOUbMp0ORaPP5nHY28I5zm0aMX?=
 =?us-ascii?Q?4IZPemPXdR7A1Y5zzSmYUKm4fqCaPQ+ghQzXtFgxXhp2gGXA/woFZBqnF7+B?=
 =?us-ascii?Q?nMDEPowxwj3gNnh8qtrvPINNkF8OIwm5I8Ei6UKlEnqqTHlr9UPEmYRB70Q3?=
 =?us-ascii?Q?e8YqWMX315GGmH8my5YhonM6826q9+ekpqS3y3FUPT+JJRmlGtMEBgBCAeir?=
 =?us-ascii?Q?ShbxcwvobRzVjUxL5k3Wti+bSXZ7HqXxXi7OF5vF8sSh2/+QXN0EZjkLWv5h?=
 =?us-ascii?Q?KFqztRjyHIqLmVWtBAPoVGuvEmSAzkPzu8+yg0zQciewWFwesbJB25yhroQ8?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6041f0-d9c9-4541-a968-08dc8191ca07
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:50:34.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCa6BKhBVL0AmHP/uTwOV+btQ0Bopt3a67rinmEc2cVz6yMr4RPH0MKMOr/dxTK6ydKlkocPIOeu5g+eYFR4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233

It has been brought to my attention that what had been fixed 1 year ago
here for kernels 5.18 and later:
https://lore.kernel.org/netdev/20230626155112.3155993-1-vladimir.oltean@nxp.com/

is still broken on linux-5.15.y. Short summary: PTP boundary clock is
broken for ports under a VLAN-aware bridge.

The reason is that the Fixes: tags in those patches were wrong. The
issue originated from earlier, but the changes from 5.18 (blamed there),
aka DSA FDB isolation, masked that.

A straightforward cherry-pick was not possible, due to the conflict with
the aforementioned DSA FDB isolation work from 5.18. So I redid patch
2/2 and marked what I had to adapt.

Tested on the NXP LS1021A-TSN board.

Vladimir Oltean (2):
  net: dsa: sja1105: always enable the INCL_SRCPT option
  net: dsa: tag_sja1105: always prefer source port information from
    INCL_SRCPT

 drivers/net/dsa/sja1105/sja1105_main.c |  9 ++-----
 net/dsa/tag_sja1105.c                  | 34 ++++++++++++++++++++------
 2 files changed, 28 insertions(+), 15 deletions(-)
---

I'm sorry for the people who will want to backport DSA FDB isolation to
linux-5.15.y :(

-- 
2.34.1


