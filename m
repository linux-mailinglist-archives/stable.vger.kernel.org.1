Return-Path: <stable+bounces-233802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA1HDNYC1mlsAAgAu9opvQ
	(envelope-from <stable+bounces-233802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:25:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1D3B8110
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83117300D0CC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DB3815F9;
	Wed,  8 Apr 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZy0NKxO"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365137B02E;
	Wed,  8 Apr 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633107; cv=fail; b=IrkyM07nzFe8nz1UKOCMlBHpcon9+e2ZygzYsrrLIMI7jTcz2f81QCq7ChTZS/vo3tU5FaulcjQj/p3SE9TeAjyl1eYujB2c+6iXIBrUfpmbw5MNgUAiXR8fRcFW0kRsxLSUGCiknDtRGWgxWqoKyJ5pi7HLUoAb7tmTRzruy/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633107; c=relaxed/simple;
	bh=UqDGOod4CgfN4fgIDsIIRYhEPXaT7K7djoIeOqOVKJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LHEDBUwSCkT2lg0rztKXo5jHFhz6rVgsREjtPjDNg58BWWs0Y2fYvOHmGk+OIIzsdI04s3NV7wVExlBMBi6xZnQLWPvqQcdI54uL3aEQ0C/sy5gR8iZJ6RsBKDPMsEVw9kRq63EsL1JvafTaceWlh7rWr8Wangj3u3TINs5OVPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UZy0NKxO; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVPnKNgL264yxVye36ZDJXpJYXhrnHZnv/jUFCLVIFLKgc+0UnE9I79n7KiRdvUdVyGcZrzL82dtWKD7zjwAwYUwu5V6OW2lldtRPmCjbvLJdof84F9BaGkyOZEc27Xxjd0B7H80OtXnjXU5Cz2SP7gmTXzNgRIaTRIaGKuU3CJ4iME7z6JWytDjTmcBVwoR/YCK6aQ2mqbPWphKoomvXdZTZOWz7cdD8u6WRFvT+dN3awXH5+FKJo6QHIE46KdRKGaVbtRBSGeIdXVMbrHnDPh/yg0CrTrfbgDElkGRB4OYZ+LTLrMrlV91O0+z3yP3TEkesCAFQ4bSQU9zr2aljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3490y57QnUmtLkcuCyV0keN+nijm5wtwiGsaQV+FSk=;
 b=hCWY5Ck63DnezULx6+IkzvZgw64aWKbzt9Vz+wgj2g4yyHvrnpahqaDOyjNK15PeDE3LLaWaWX7FP0GAkQdi/Wyp2JLiQNRPQdYYtMl1p54YH6XiRf4a/nDI7IqVvdnkyMZq9W8Kl3aIqOs3U/pT8bVEH6q3fGmmL22hRnDpl3X23DRsOnX5X4vRKLA12vF5Pt+WgqCcFprTvefdmMrlNSk4JHFz/cmmslqXG5lKk+EBetsjqQk/aF+CAFk08XczArBN8bCSR5xVBt5HMccaz/sbqoe0yKBmAycnhYjyBLDHh0qBdX+976lRxgwdeSwQ5+0pFqGY/ZySBUV0r8TPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3490y57QnUmtLkcuCyV0keN+nijm5wtwiGsaQV+FSk=;
 b=UZy0NKxOZDGna6gem3MLTyE6SxztO12jbOrBHpu4C8YLDv0Va/RZuMwuuJc8EYWqy9awG0NNAXXxaw0MQjPhoQbYwOvXXuQ0cRnb7kpZKHC28jZtfMjOEDVMavxkbJ9snfdk5orLq7Lr5oYPI3o15NRSMxtS04EBNv625LA1LAaP92Xah77K+VO4QFm4rK8cti0VEtWHQEAQKYlhrbnH+st2Tdy8zRlffHOiLRAXDWoMva0D8wsiU67/2l15rBc5x+TlPD5fFSrV5Wn32dJJ8qdzNt/IMyz7rykPZvwMAl/iDhUdzaZAUiybKfmUNUJnKpp2Wp7Hwkgqcv292HZLgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7869.eurprd04.prod.outlook.com (2603:10a6:102:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 07:25:01 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 07:25:01 +0000
Date: Wed, 8 Apr 2026 03:24:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] interconnect: imx: fix use-after-free in
 imx_icc_node_init_qos()
Message-ID: <adYCxobWRbPLdRlt@lizhi-Precision-Tower-5810>
References: <20260408031004.309483-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408031004.309483-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: SN7PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:806:126::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c87ac8-b00f-4f00-e143-08de953ff228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	hXrmFGWzCBdz3A1lCQ2AyvtjCOqHrwcPr1FHhbjax5XAHw3tyPs9g56edOaR6qhkeO6o81OVm/GNqpb4jnqoN4hZi+RmV3v4bXv9k1AgdWXa8z6vXrWGjIpfep43c2fIN4n5FbAN0KcKuH8eUP0etMN7smqLbCZv8dVPIjV+TNDdQGwcMHa8lbk+bWgHMLnxxvLt9jksRQMxEpXXWzAvfiFndh3CADV83MEn/utTH6eiTSWhfoQjMGSk34oahNbI443jGp5933Hsg52qSDLvKI0erp5CXAo46+aL1/sR/MD2KsGee7BtzOVF0Ln6Nq5Avw76RD0K6y6+7FgR7xWQLH9PpLAPiVJXlF4eU5VpBpdizaD0e/PAOY0YwjPmu5ZmZDRgBozBg3hu0gnhMGPYPiqAckZVcF8CPjIVNI30UiAmTnejvgc0CjzGjP30IvMuRpsTlqZu4Pks3PY1tNbGX285N4vKNQWqF0bhKrE3wa3ps3SY+J3DniGL7LwUL6bWcTbMNeP5pndV2QgLWWYXXVsL1llOZA2o387cWIH4GjLASrVNi2HLl19YkMoRsjHxvrUAXAAiqsBM/pdVW+TR3FAElKbDy8wbaQdnGE4bjSjXoPeAyxdqcl2if93JyrbqKZcuWE4Azs6BCMf669gp/UekE/YYR0nDp12vJ1A/whOgmFSFSBv0D75s41QoVCxquoUYnU6KcCnxaqcx1Tz+7zkUtP/tqGsTqzd4IdcYkYWRhg+qoiGEWgYTU+6BHiafUashw6VueCZsyu0XotSMUETt/6OH+26UN+15Ic5uJak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JvKpFG31XHq1vqmxi7SPqVc5Y+EJaHQW2BYTKFnXO2Fz92EKZLYl0n7Uhn4?=
 =?us-ascii?Q?AhadCpuFK6fwst0Ju3XpjWHEnBB8HmwDvikSxkGKX4Wb4UMnG4CFiFhWXm5Y?=
 =?us-ascii?Q?QK6ymQYfCjtsLJFj3yJTTdv5BgC1el7xRKKm7VTYf5ORwSw5hcrh3TlePiM8?=
 =?us-ascii?Q?68E1FDfyFDlQ9al95TZXqRf4QIgeZtC8tBIKRGORjVxSXhMJFjPDOgypSSff?=
 =?us-ascii?Q?kalHrD4Oao1iPW+m/SYBpGZd1zn2tst8MwshZsz+DZXnyK7wdr+XGRQKeUpx?=
 =?us-ascii?Q?XrDw8HsTerupzTJwFxKkz0WsRk/3gNRCQEH+ZNmDjA1QageGddFu/HdaCPj6?=
 =?us-ascii?Q?VgfkCyLmoN9ZwZ5XYH6VIC0RyvsaHkpeG+mOCCBiMD3mBSFkxdPjJvkwKLCs?=
 =?us-ascii?Q?4hare6KsSiffd2mXqlNoXzu2uA2lh8EzHgVqdyeLqPUPxYqSrQPQk68F8yrE?=
 =?us-ascii?Q?DOU98bWhDsobZDL2uC3I2Ab6PYA7DaLc/3XFr4FmpBsKMJbDxI1bQojXjVnF?=
 =?us-ascii?Q?P2renagPftIilLJzrmGbRcZ/CIV9CmMOmqEKLDoeqKOS2PZOnxabD3sl3JoM?=
 =?us-ascii?Q?mZ/oXTnLXV3y1zi2c8qaHl+sRRWW38bXNRywXcERyO0X7O4Z4AmhPO/ezusk?=
 =?us-ascii?Q?XkPT7mECgPBcULbqNXJL78mlJjr6cJ6gO+ZG1Dq1TXbOfIE9jzh+gzWtKrgN?=
 =?us-ascii?Q?b4JjObJH5mG2/+cEz3WU8UKBmL8gDHxAytJlE80CPPBvwA+CAsDuMCVWXPqm?=
 =?us-ascii?Q?xg4Y+XOxgIU9YvyIhEQTgfZ9rFukqy9mQQB5YSlVb2E1agcL1TUJXWqY5pYk?=
 =?us-ascii?Q?ENhvZfjXl26JLNT7zHAao/W6sfoMqPYEIHHG3oo31U5ANP1snV5gxQ41OXZz?=
 =?us-ascii?Q?2NZG5X9dX7uaggioO9WFpzHU87BmFRB/oqG6fN5EPfQ5SJdBKdhHV5I+0Ulh?=
 =?us-ascii?Q?YGKRjFK5SivdpPVJbEdAQ4Hu2znWn9RyZ6tGSmMR7xr4pmPCwrVRCLjCZhN5?=
 =?us-ascii?Q?oInFL/1A+xsgLhaNRwy76xWEYVJOPufz/33pTsCWLOq50c6rPR2mu9hclNNI?=
 =?us-ascii?Q?ariJgEXqQMEIWHIrzzF5HE99Z89HYa0wJpqZuB/6mYUlSCj8lL5w0wyIl3hn?=
 =?us-ascii?Q?K34nAa5ZfMyFu5IoZd0IEAz8XxlZDwjHiuBQD6y94+zFdpMcyLMWd/1slXeX?=
 =?us-ascii?Q?enHBJW2gqJP2Vn16irjbKsyMiQL1M7P6x00AeMrUkPyHtOZAVILMSE5q29zW?=
 =?us-ascii?Q?zwHvrkZyxXroqP64QDUIy2p8oN/LlceLldNIPh4oCGeyEbt3x/LyzY64kgTE?=
 =?us-ascii?Q?l6Nwqob+hYtleIGgpQf22J81X5oqvEg4o8aX8W/3ezmvbcBoOn2Tg1MaiUp8?=
 =?us-ascii?Q?/+4hsz3QFpRccJwoWPqOqonp6H4SwEL0+/8R2NTQb9TgZSFpASKp7qt6a/MT?=
 =?us-ascii?Q?kn1xVtiWojr58J3Rw0YomalTUacOLrrNFVgaNPa/Mu+vEy0D+rs0vuuL2vD3?=
 =?us-ascii?Q?fOydA+prAQ7a9523QAkcvGlKppTyDJdyvCYMiWx5toTRzGOkoqPmCtF2tVXc?=
 =?us-ascii?Q?UlgqW6W5r6XCC3DhE+yvmDhRqWisF4jSgeXC7huHvq6qVBSyCAUMnoARiaX5?=
 =?us-ascii?Q?QBvjvviEwzA6vTxvToVDnoEg1WfxrD3gGRyBqEmGFx0jEiPx6LH++lDjKbbX?=
 =?us-ascii?Q?JFlGcxnip+whoW/wQZoHtMeLImWDNqreOM1MNI2OCQO+5phn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c87ac8-b00f-4f00-e143-08de953ff228
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:25:01.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmCtO38r4lviHH67WPuy7wQ1PoFsyCH4GBz4ZcHNZc+P95Ysy/atL5yjZ/eGb9x5WpPfouJolbkxN03dzFNR9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-233802-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,iscas.ac.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6D1D3B8110
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 03:10:04AM +0000, Wentao Liang wrote:
> Move of_node_put(dn) after the last use of dn, and add a missing put
> in the error path to avoid both use-after-free and reference leak.
>
> Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/interconnect/imx/imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 9511f80cf041..75431b5ccef8 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -143,15 +143,16 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
>  		}
>

Please use auto cleanup to fix this problem

struct device_node * __free(device_nod) dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);

Frank
>  		pdev = of_find_device_by_node(dn);
> -		of_node_put(dn);
>  		if (!pdev) {
>  			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
>  				 node->name, node->id, dn);
> +			of_node_put(dn);
>  			return -EPROBE_DEFER;
>  		}
>  		node_data->qos_dev = &pdev->dev;
>  		dev_dbg(dev, "node %s[%d] has device node %pOF\n",
>  			node->name, node->id, dn);
> +		of_node_put(dn);
>  	}
>
>  	return dev_pm_qos_add_request(node_data->qos_dev,
> --
> 2.34.1
>

