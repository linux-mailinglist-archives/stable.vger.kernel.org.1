Return-Path: <stable+bounces-240026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDrxCS/i5mmr1gEAu9opvQ
	(envelope-from <stable+bounces-240026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:34:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ABE43583A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8EE300EA91
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A325A2A4;
	Tue, 21 Apr 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dz+Sz0GY"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76215B0EC;
	Tue, 21 Apr 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738823; cv=fail; b=dEJOsSOHk68vUXHvYjLeMIHWzZhJsQi6kAMTuyS+U+INKbEihtxIpfqoAvp/cjkKcp4khDYeLoRUJmawOGowDyyH31LVA9KGplALiNl3j7FQ8rVlGU4e/K0d4gIUY7SIOnV5Vu75PcrTOAzCSJzNXkHkpPg5p2cKVOw/cgHlD+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738823; c=relaxed/simple;
	bh=0gWS+RaGX5e5pI0putSmuvU9EPtmzEIlnpCJt6aDcDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tka+WMPKP0WVx++KuaBN8vaXdYYtL0lBeK/2z2m++5b9UgdJfduhsSuwiTQ4SgKcUSG6RJK8nH3yuUkyKkCER1c2r4woVuy60spHtfOqzVPgSQPVSgVRtPpzhWK4/iXWlowDJ5vU4P3Luvrgl8bev7KuVFIWNa0RjAMvstRmyOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dz+Sz0GY; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhgH1pQt7Qu5HuaZLFphZO099zR2WXxUD/KI0kPSSt1R5uJuVWuZJB03M6hmOIAxb3syqwrM/b6gF55LKBvG8KQ69pUa9rj+ACSGeRAvwxmUXCLjzpnTgDHOXXsWHuuMxK2H1VES3NoKHt+qdGtA8o/r8Rk7JZ2hZz/YXBqmTJWigd8SrjucJCexo9jhGGJt86GvjrU92t0Gb6Xuei0On4F2Mi3PDJCgYNtAWbZX/F+6QtUM5ECfHtI6DozyKYoqV/XNGA9Lsri0yAs4km634bzel09PYEuMVU5xBg4tN3+LJcSlrKMyp4kKnbisGQYVddvhf72zyxu4Kx/wqMQWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So9pkkY9x6V0ERELFPbEZ72wKSkk3hQ8uRn6Wt7GMuE=;
 b=pGiLjXtpakCCQ8GnVVFo3wHN8iCO1Y69PB5utCmyw2vNEIE5XpacPctYsWzq7OioicK5LpwE122b5bnAm/LLFboZf4vO3w5IBtRRbtAJFBgYffX+QNENUVvYD/dRnt7hYkZGfnR4QUEGWzcRK+oC6U7nWWJpvSoRtpusIXPwKRfEO9cZMmMAw+8DOVkx5/xAloIFtS7S2LPkl+lF377a2w9j9LfdDve//Rn6Xp2AzXs79ckKCRJZWmiRF/cQjYjc+Pt8C3PxVpw8/VfYZhk6IeVFMPnvFySYMy+qDuUQd7y9dCmiH2slv+wk7e5njQ0fNhYUNxQgiq7qNeRuMNLCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So9pkkY9x6V0ERELFPbEZ72wKSkk3hQ8uRn6Wt7GMuE=;
 b=Dz+Sz0GYU3PCddg8YTsUoFYWr9rF9BzAe3mlS1UmI981DsH2f0tczw2EIs0NTYfBpLn5VY9AclGdd+AQRjXzSqkRxph9uGTu5UpQoCX3xVf5pHJKYV55O7yoIaDVpZ0vxu3qCYqcFZ+ZNo5zrr2IYSBsRsMc10y4q/oRqf+SDWQXbC6G8J90J7mrvexE7nQ+D7Cv00bDx7nuDPwGzRxpQT6QFfgSckFXzsoGQc2b8iM84G5mI8jeKFJ5ZZocu4/UcbXhRZMXxg52bllBOsKHwFZHw3+/M/0khXAg8SR5TjUMY0rxz/P3GX7Bfb5CjDhYbFYjiaPAWSShUvAtw1220Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMCPR04MB12622.eurprd04.prod.outlook.com (2603:10a6:20b:76f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 02:33:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 02:33:37 +0000
Date: Mon, 20 Apr 2026 22:33:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	bhuvanchandra.dv@toradex.com, peng.fan@nxp.com, sherry.sun@nxp.com,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] serial: fsl_lpuart: fix rx buffer and DMA map leaks in
 start_rx_dma
Message-ID: <aebh75Od_EfYhbal@lizhi-Precision-Tower-5810>
References: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
X-ClientProxiedBy: SA9PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:6e::21) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMCPR04MB12622:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cafcda-5f88-495f-35e7-08de9f4e6108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TDltTECW8xyLUtDG4W4i2hoabD/wsA1drVZp+E2xAuBkCpSqGaRnG3EfwmtJmKRmGUd4knyJ/7pd+CHnEI8nCIMG6YWmdffWLTcrOF7QeczYGA4A5IvwFGQPjdUxHEXxmNCG/RpFXQg2UHhHOp+dv+KVc6nHO6GuK++0RcyDmAzLnMXxR1ZevFl96QSqPTKTOKsms8a4KZ2I66AOhRY9AMqouEsMmFsLZsXjfmPuhyFqBxicRQh3QqqcNMvvkdiU17iz8Fi8eg6dj+xFFs6KA27QvCUUg6DyhagD870ymPyXJZByt5/YMxNUcVK15dNSo4h3m57lrSgKeynj8QgoM9orc1H9bG9gXImSQzM1XWJXXbGfVNOixiSfEUtXzF2haN0HiLzfufLl7fcE5rhm4Rqb65kCJKQNKdaEyPTabgiCLaC+jPvhCctSagUGhhxh3PJXe+e0calbXe+R+yUpxBNM8jMiqo+DaV2meQV3TCtV+cUWJ5Zmuq2kLusq1OgLLIWGxEycLs9hVyopfz8SMR0++5WEBs4x14GtXfD7pj4qwe5qWaSuJqfkVPVhZZPlqmIQ80rrgheWUgSKQur1qpSBS3gG78BqUdA8MK8NHZVNYi2r0pjeyVFFyJ7gQefd9wSf+Ow+xFWV/aCP3OLxJoBcwdPzZ0WMtAtm4UCQ8xQb09SDWjL52o6ldJx55WqQqgbOPm05MRQZVpTyiVSfTI8qVd0zZXnAWh4/HauEFXNbtYJh8trAtPnj4VBpL3vHo+4CxhaXdiQuDNA5kAZw7FGX4QY+1fSEOhMZAb+oZXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npKhwNh0VxeZ/VMiR5MUfMzROB8ZEOJd1S4JBiRroNsSPW/cUxhvOUbsIrc3?=
 =?us-ascii?Q?6ggDSQiKsWXYz6gPJOpA4qtVgslCDPqxmKIPobq+EIWkuqiBUVKmfYzUC0+B?=
 =?us-ascii?Q?KJTAaMFMzE6912OEL5/pU5B6cA81tmmRrY2Me58HjuvPPEjRJOGQrzoqFSi/?=
 =?us-ascii?Q?pvy6oqUwLkai7Fcj8B+8PKWdfc59DBwrYFgWV4z/m7vehl2+KIx0cVFputQv?=
 =?us-ascii?Q?zoXIP62TMe1V2qPs/7XAyh/04OELUlSwokG09JMQ1oE3VUugN3xGco7dUhAa?=
 =?us-ascii?Q?XuchnHci2rgKWayougsRZ62BiNsFy5E4ixnPwJMvcuU6qKta2jLS5KW0qQtK?=
 =?us-ascii?Q?AV+8FKHm9bl13AzEiDh0DEG1ZqHC128wI4azMOiUhjSdYlPnkTJF61KN5i9n?=
 =?us-ascii?Q?ZegJuEO02L/hYrkDba3AqAHICEwMOlHEuy9OSKekJ31D5JAhHjFwHEWsM4JI?=
 =?us-ascii?Q?Lehnpla62Ke6vCvANQpSzdUWwr0Wp3aAsyACgylWlgOiXWv56OgHHrBG7Ege?=
 =?us-ascii?Q?g3UW81a+rjfQS5tnjASUVo/Hy+FtGHs8C1qHLcbuzU1akis2LSNhsKueACVr?=
 =?us-ascii?Q?LpzAkZpgqgPtR+g0rHtlbBEz3QbG88v7S/TaTLSP6Mw6qXWsbnakA9s2EZXq?=
 =?us-ascii?Q?s5V4pyvT1OFxe9/y1KURiIXGbOQY44uhGgC7px0DtbVGPWjDEXLWSyp7XCLS?=
 =?us-ascii?Q?UTD7s5hoOdEwZt1d1ZDVKERnrfMPqKigjKHlVSXLc+kmafb3keLeU/DJQ+wb?=
 =?us-ascii?Q?j2Ug96DLaBYHVfPIjKhD49qBLRkccuqLhJDlQ/UI9qfwScSZtXeMUL9CKovh?=
 =?us-ascii?Q?T2xqOKicbW2tfiTK0GbsuMLJ/BZ4KXibWRPxrLP9pwQpqg15Hfvc2UZEyPkF?=
 =?us-ascii?Q?OeDyU3aBVk3sIr5K3x5vp5ByXfawor1q4w2fxULlombyxtOCB0K0k33ftFdf?=
 =?us-ascii?Q?F9Y8fjE9q7aqjuu/TvqbEhCDj4wCkBf+CjoNhBRXzYW+fsx3n2axB9JM+R6x?=
 =?us-ascii?Q?Jf9KqcZIOlAwAPfjtkQxKB4ndG6YLcDxi3vMZNZkbL/kKmRKyhZfssK1Uksy?=
 =?us-ascii?Q?B0b1ndFIfthQ+JHb8XHCjy7eIWMCA0V+Scds+70zT08rsoY/eDmy/Klh51YA?=
 =?us-ascii?Q?UtWjaAw5HVeiq3ab+A6g8SO7hwxEN/1nybBZ0PxPycYpxnKrqPgI6l5/I/cm?=
 =?us-ascii?Q?Qt9GklCeZ/+7pIHuvGWqHoo8BSnt+TRbM+CNniyuFHkR29kVlIQDs4CngIA4?=
 =?us-ascii?Q?E0rIMstbyLSQYWYLDiNd8Theejrn5OLKUZ/jP9WETNhTUEIkhgmPLcwPTa1h?=
 =?us-ascii?Q?DsWyswQHzelansv/Al4PGnQ/z/1GjyjlteXIiW2mRPO6mQkt9FJ3EB3/1kdR?=
 =?us-ascii?Q?PzzmDwSRI4ZPoRw+UIrku96Hh5PT9KO1K6SKD9C+IQflNwIlosQVcwtQ+LHL?=
 =?us-ascii?Q?pp9l9E3qzDaVt1gvPhhZWaU62oE/43Goxr80HInUu+oBck1sX6vdK8xJfira?=
 =?us-ascii?Q?L4Y9MswrolEOYTFAeG33alGbgARPjRlMufzWuapdkZ4dOLqWneh2Q6vf8zKz?=
 =?us-ascii?Q?CLU/fqnkpNTck0RlIqkDXzu5D9l/rvKhw1Pb1uiSXdHzd6huNFvd/Q7LP4S2?=
 =?us-ascii?Q?dT+7vCkD2Qo6aAnY/CFfMyU/oD9kbE7dlVQ3JvIGu40KpKMULeC7kjuPL2AV?=
 =?us-ascii?Q?wcMjYPt4rzB0sBI9hp7rlxa7ynwKLW1ePPa89j1ClJQvVTUx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cafcda-5f88-495f-35e7-08de9f4e6108
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 02:33:37.7494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/i+fShVQrKrLKlLaNwXzIrwiGjEPzwpAl94xxYBeIvuhc5Qnw1D/egETGqh6v68f6Z7Rq9vl5b8cvaCSKup9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR04MB12622
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240026-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78ABE43583A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 07:29:03PM +0530, Shitalkumar Gandhi wrote:
> lpuart_start_rx_dma() allocates sport->rx_ring.buf with kzalloc() and
> then maps a scatterlist via dma_map_sg().  On three subsequent error
> paths the function returns directly without releasing those resources:
>
>   - when dma_map_sg() returns 0 (-EINVAL):
>       ring->buf is leaked.
>   - when dmaengine_slave_config() fails:
>       ring->buf and the DMA mapping are leaked.
>   - when dmaengine_prep_dma_cyclic() returns NULL:
>       ring->buf and the DMA mapping are leaked.
>
> The sole cleanup path, lpuart_dma_rx_free(), is only reached when
> lpuart_dma_rx_use is set, and the caller lpuart_rx_dma_startup() clears
> that flag on failure of lpuart_start_rx_dma().  So these resources are
> permanently leaked on every failure in this function.  Repeated port
> open/close or termios changes under error conditions will slowly consume
> memory and leave stale streaming DMA mappings behind.
>
> Fix it by introducing two error labels that unmap the scatterlist and
> free the ring buffer as appropriate.  While here, replace the misleading
> -EFAULT (bad userspace pointer) returned when dmaengine_prep_dma_cyclic()
> fails with the more accurate -ENOMEM, matching how other dmaengine users
> in the tree treat this failure.
>
> No functional change on the success path.
>
> Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/fsl_lpuart.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index f36d50fe056f..296a096be351 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1376,7 +1376,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>
>  	if (!nent) {
>  		dev_err(sport->port.dev, "DMA Rx mapping error\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_free_buf;
>  	}
>
>  	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
> @@ -1388,7 +1389,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	if (ret < 0) {
>  		dev_err(sport->port.dev,
>  				"DMA Rx slave config failed, err = %d\n", ret);
> -		return ret;
> +		goto err_unmap_sg;
>  	}
>
>  	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
> @@ -1399,7 +1400,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  				 DMA_PREP_INTERRUPT);
>  	if (!sport->dma_rx_desc) {
>  		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
> -		return -EFAULT;
> +		ret = -ENOMEM;
> +		goto err_unmap_sg;
>  	}
>
>  	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
> @@ -1423,6 +1425,13 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	}
>
>  	return 0;
> +
> +err_unmap_sg:
> +	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
> +err_free_buf:
> +	kfree(ring->buf);
> +	ring->buf = NULL;
> +	return ret;
>  }
>
>  static void lpuart_dma_rx_free(struct uart_port *port)
> --
> 2.25.1
>

