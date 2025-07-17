Return-Path: <stable+bounces-163268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7397B08E35
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A278D1AA7979
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2F2E5B13;
	Thu, 17 Jul 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H+xJFL3f"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012048.outbound.protection.outlook.com [52.101.71.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A62E54B0;
	Thu, 17 Jul 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758812; cv=fail; b=Dq7qjjcEagfQwDyedgY9Mv5e2tyIRR5ad2OuO6ZCVLc38cr3mPGka6lEE7GKlQL4VR0MZikjXdww5HMeIazUhc1XD/w8CkYa5u1ifNehA6p7AZI+UwDJKbMKw3xesHUDdjL+riNfA+mcjDoj7jtHJZa71Xf2dLHb+HA+C6degjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758812; c=relaxed/simple;
	bh=Q0l9OC5ddtQSXUYcdDr1VZ71pAu3z8U0vsaat7bl5iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O4yLnmk3ZWjITYYi3LLUdXXoNA/QAUOXUgcYiAd/7laFv4AvAQyK/4odbTwNm4MsCFxZB7YntdpwaKcxiXRbecDqdGY5GbEJTq+28NQQwL5PQrBBdmz8I24Tr8AZBWvyOj0pm6QEFd6PynThFm4KvTzyHMViNgOBhfhev7X61Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H+xJFL3f; arc=fail smtp.client-ip=52.101.71.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcUFAoUPj5+W6BZshEB2LCQk/7skUYF4FGH1LZ6vWffCpYBnbQzF3Um+kgTB7oyYQ4ndWTBIJa44FxRlSKjjxP0M7KV8XcuefFQ6TqQPOl7f2xhVnnuybrdXaXNuIAT/vWijpsF/K5rrPhfrbqdsgJUMbRzXIsxxkuc14+sGCVvweeriiOipS7XPZepb4sCkxj/0QJZnKHpObjg0keNkK+CN9fNwKDuZjeMIZfh0+hJzZMJ4fckacwIPYOxlsmseYIOmxZPI75TY+3DWcrZm0wBHBx7vHoU4jdV1JxAz5sTJmQK/MNktH7mENEacDMhlN4ojhgXUUbW4tT+vKwBrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cWfLAOrNOJJSEl9nVe0yOW8WhS2rbpJtoVRWJZ4Kd0=;
 b=QiKgNmfWxNG2gAf7ThnvQbcBJHWQRkR1tX0x0bfHOo8typzuZnVdoVsSQDh27VYCUjtZPgQ1l2yqI3m8mAcnJWYfHQ8QSK9xiQ1xC+3tnyKeSXgioGyaBOlA96N3zWstikXkVGIypttEOTCryJTFQbBYje/ywE69at3u6J8k0w0C36SijUNgOI4hku1667gzir0iel+Q0skP2ukt6kWezjE80/D2zMXxv8Wb+MkcdyRd3WIVFAVw3MrMls12QGsNd39upEUyNGQD4xWx0AglACLE9UEKgNxrpRMl2oTndx9lWCtWoQptoBku4Zq+cii2hIXzFHiA1G/5PQAQlaS4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cWfLAOrNOJJSEl9nVe0yOW8WhS2rbpJtoVRWJZ4Kd0=;
 b=H+xJFL3fXHdAxHntmRBF5gYFKJfQPnoTY0AMskd1KkCx25MZHKftN6UVCK3jcwZ9yoHPHlVNLgqMTTAuWdK+zB850ERWCmkuKvE04uAlt/11z1JEDJJbGtSH3NG9WNPqiZjTnLQXfT/O4hPPtl0PXV5v+Yp65416Qvnf9RtiGT1Bz3e7d5UNKXTz6gkw8zwBw8kfVWSzQall1uXdRvWBQYdj3RVknFWMJQQzZRncQfH+3LYCB8sj4yADjbZ7AfJhFjgJ1QwRwNc5gV2GCmqrtnxwQ/eDFPBj000unXGLfJJwKpyXi0X852tr4kh1+y2zGVyLeEgpL/fjMqBsSkwksA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 13:26:47 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8880.030; Thu, 17 Jul 2025
 13:26:47 +0000
Date: Thu, 17 Jul 2025 16:26:44 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] dpaa2-eth: Fix device reference count leak in
 MAC endpoint handling
Message-ID: <qitl4tsrbgs7fsx7s6ib5q3uhuq2f7ptbopphfjakln6lyq6xr@r3woy2jb7ey6>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
 <20250717022309.3339976-2-make24@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717022309.3339976-2-make24@iscas.ac.cn>
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|DBBPR04MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 15efd68a-e878-47f9-e8dd-08ddc535948b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSos/wTPAHcheEmTKEWV8eu63gveI/XRC/pizoX/85+Ohybj5v62r2+OtwbM?=
 =?us-ascii?Q?sKcvz/s8jgD4405VfptyKpYeGV5bigKlzF+YXwT1LX4mzi/GbKBlGPzxcJyJ?=
 =?us-ascii?Q?6Vr5K5o6gk6oSUHCM3lqcBqs3yIPILQuFk4KhyTQCL5UduGfYljBo24wdsaA?=
 =?us-ascii?Q?4U7RwnpamBUOuGo4mOb0HNthvgttPQIu8cl07OzCpnP0itlG/XUf5XhMZYju?=
 =?us-ascii?Q?yWmfPkOk9dWp41orDwPTxOhXc3otqt1fgI7vCmlL0GYofSh1qbGVVPkmab/4?=
 =?us-ascii?Q?edPO+kVRKFdzuJfhbG2gXyAG7XVAh0s/kV9dYkEl7xE0j7NkhRmvRCiLAF9m?=
 =?us-ascii?Q?WY1cBQe7r0FzaoOyGNiJ8BcxEFhNd/kYWr/rz3g0Y/c/Lf5AqP7bNr34zllF?=
 =?us-ascii?Q?m/SHSRskOpPUFP8iLDeMiNoz3bmXpwczFCGLs/iSXbS3/hSUBlC1R5kduuCM?=
 =?us-ascii?Q?t3SB+YTtarss+e5fACic3zUb0sIwUA9mzPBGQZXimnHf8BEzovFlK7nQkYVT?=
 =?us-ascii?Q?CpTHTsvw+Qn89tAuLX8ApebPqA5Zq8NNnK75Ma4QRc1/x9RHSFit/EW1oQIL?=
 =?us-ascii?Q?hPQ++lq6TYPTAHLkf+JtkOJikqyKLwGn9ZdPOQIqmVWeWcN9JOFup5pvTHr5?=
 =?us-ascii?Q?AKZe0WAzufgSAww85lWmR/e8cEqlCN44zdN/pv6LcJIemMOECruKvbGZIebb?=
 =?us-ascii?Q?ffwNuUNzFwdaFqUTZYBKmdVT5y94q0FssQTMLBq6gUjB+uETdeIzs0YOTeTv?=
 =?us-ascii?Q?cBC7ocZL+NiLmk+33T3WyEWOY99F5N5d3GC+QVblgjlcdav52duMOutjuA0L?=
 =?us-ascii?Q?QUWSVF84MiIZqvmf17SgftDGMRoowpACUxiijGBFjttel8rK5agjNDP0vV2g?=
 =?us-ascii?Q?E9N2EWrKGM5E02UViC+NZK6BwOB0ezXKukZNmj6D1ePJT34w3V6ftcWxqnDH?=
 =?us-ascii?Q?d08L9PxQvOkHlEiA+9ZAxqFGAZljAjmrWYaB1iPsBCE1SY7WiBJCwaRlAc15?=
 =?us-ascii?Q?ASjaiS04nAttw3XC4bXacWcwukRqonPIWL8thx+zXeDvQ4VrHKE1SYlHLjfg?=
 =?us-ascii?Q?j82cnE2iF3aDzQCcjS/SElaNXuJU17Zj+AuuRixtvvOinKwcDQ3cbthu3ADl?=
 =?us-ascii?Q?YMuwP+5xkDmQhp07HHNeXFwNPdmN6M7LJ2H4jcneaRHnjT9jES3KNHX4z77Z?=
 =?us-ascii?Q?O8T9jd+VQMBI8lXwbDmohSl2z4bB9yM8dZh6UW+e32G0vjQAMZGm0+oS86y1?=
 =?us-ascii?Q?lLGHJhrBrt1LwdgX4DzYrRZ8+rwAA1vlxGnj6AAeUE+qhkYTIbTsuZlqgGnR?=
 =?us-ascii?Q?TBnh0lwr1saQteBpCAUcX29yza4dTLnAeBBB97ITsOdw+pKWjTPxrBhyDxSV?=
 =?us-ascii?Q?INnZv+ysY3y02kwP3AzubNnCSDEfdPBztbOVaNIrj5Ad2gq5Cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z887FDYMPQXKH2r6WU1N96bRNIeFxiBHpP2G1ibRQdRg7nXlUIphxNKaON5M?=
 =?us-ascii?Q?yWxJT761YIRpGWcAIuzq1CN3f3duwHhQ75655+v1WXuH1/R4I6H0jfbuyvFu?=
 =?us-ascii?Q?ALGoKz4GxESgikUeGuKUd7/zzYflG99bulyHUx5txrNaizqNEIAFkzcjz+27?=
 =?us-ascii?Q?m8o4Sj6XdMFCte8+lhPRRMfgNnl8sGFhJieydz0iMhYeQrGAx9c0hGXw6/Ot?=
 =?us-ascii?Q?7vhiD1ZH5erm7URvsJjE0rDnIe6/41jMPTyMIU0jYdQWO5SNrrrEsMbgeUbT?=
 =?us-ascii?Q?+upzPpZE3zm1FQ/oElyRz7rzWINhBW2gDNxW4i2f1/6+m3BFvLzpAizdpiw3?=
 =?us-ascii?Q?r+d0PEdlRTzNBDoDV4duWes0dVqW7nb7t042SzF4FPsjtHC8blFwsovnRhgo?=
 =?us-ascii?Q?ZnCuqMmNdOuh4ay6Nmczz3Nse6xh4v+A9uQkl54x52csOCbuSRe/5XsaHVxy?=
 =?us-ascii?Q?Ly8osP0t2SZmzqKt/5azAgbrUo4+lOTkUw5fwneTKr86Yx+UhabctiwzEpJ3?=
 =?us-ascii?Q?HCjAL0PHW+Z8W/cUDF6UaXrVjNDh8NnO6wjCJPIzacJhQrR3ZAMye/O2/DIp?=
 =?us-ascii?Q?njXppaHn6kbAL1Houh+IrrSxu7z4ihL+7eVHc3OnWLa2wdyEilyARN6UliKd?=
 =?us-ascii?Q?dsxwfsP5DcEYwWBXOsCFTqesnLTk1YfPW8usPTOvUG7d5vwtN8DisJmEgNVf?=
 =?us-ascii?Q?nrujPCO3gSw1cp4cceGuYm/lceN/oWFT/z97XP2y0JHvmFRWC2loHOs+P5vP?=
 =?us-ascii?Q?7M/L8AQb13yCu4PIOnUNG2oGtTHUmmOP8JzSIaT+8ATO9QQmAXBuOGuhX3Em?=
 =?us-ascii?Q?SICdfX7Dz86EsOH2CanKvditXqkZp0nxcaLbTQK/A/z7ZTE3dDfrxP1CW09a?=
 =?us-ascii?Q?/BCmhNS7Y88rhKcpNkvhri1Jum3+01c59Fvim3mkV9DVY2+s8DGx2RQOuuR/?=
 =?us-ascii?Q?UAUVyPclXdQLunJagJ2VS/QrEy7r9W0KBM/qhjISfJM83oTLtYpqDzxSZOB0?=
 =?us-ascii?Q?IGtVDUcAubRXCbqPSXWfvNK5Wkrg+4g59XxxmlSXIbqDkILNmtZGCa6ZafAc?=
 =?us-ascii?Q?gHs37/NONQN8k5lyBLUYXwiwz82r63wDWMO9BHkhTB5326zBn/fAJTwDK2hD?=
 =?us-ascii?Q?eo4owO8+PA7rveo3IFGpz4im/hc1BjJZlWo2ZZq1HYmMSNwhmpnR0tweu2fO?=
 =?us-ascii?Q?GW49LHmxeTY5ODZvXwwNxYCkAwMHM1edppwmPS0ThdV2rl1lzyWsc2jaobVZ?=
 =?us-ascii?Q?DDehvHSaAbYO+VGc50IK0A3JAUfwYIOx285M1CEQ4ZZ1mI617ff+cQctsH+e?=
 =?us-ascii?Q?4pvByZV27ffQOmg4N8+GX+pxJBpzFYKMruwuSdOqEy8A31wpvsMEEe2AVcuN?=
 =?us-ascii?Q?SyQgvSvxVJq3V9gDYKiU7SZvlMuyQ2OKZnhgS+BU2avgTbS7NX7fe8S2R2Ky?=
 =?us-ascii?Q?FbqO/W+INlO21ttzWAaFzHBYeIqfDX7t6zU6HeZxFKB0K7VUJzVVwGiIuJb3?=
 =?us-ascii?Q?ormPD6e72epNs6aCbq5lebwOF5LbgGCRvwn3jpikjnz2DkIwqHLAbT+iFk65?=
 =?us-ascii?Q?V5ha9yotH0DCRp85kIF49/Rd3Y2L5XLz50xVp3jB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15efd68a-e878-47f9-e8dd-08ddc535948b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:26:47.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJoMzfHnt3uQ3A+46m8dCQtXDu9aOsh4HKPuVfVcvVSAHtybQqeqmYd7I39+/M4rJXS2Mz+Z3S1QhYzuo9J5LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058

On Thu, Jul 17, 2025 at 10:23:08AM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function uses device_find_child() for
> localization, which implicitly calls get_device() to increment the
> device's reference count before returning the pointer. However, the
> caller dpaa2_eth_connect_mac() fails to properly release this 
> reference in multiple scenarios. We should call put_device() to 
> decrement reference count properly.
> 
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


