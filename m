Return-Path: <stable+bounces-118912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64EA41EC8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712C0188BE58
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD07221F20;
	Mon, 24 Feb 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="KXozoVLx"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2093.outbound.protection.outlook.com [40.107.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4023219318;
	Mon, 24 Feb 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399513; cv=fail; b=BRJYqO44Q9LX/qEStFhqF5boNIIgovMGyuFU3CY068/aC43BQpVe647Pr6jp68xcZRTW7UXWp2POT+NL+FNQgK1ejrqf8MEvyk0O/1yiGYBCjhmIcr56dkHxThCwlvVy8d3EfyJgnHDJcc5mIuCL6PtShOLhemVrTjxiQnRgbUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399513; c=relaxed/simple;
	bh=1M3bwCscoLrKJPKH8WjO0JybTL4DtHnffzJHTTJkRV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxMPxCTKvhwM+RlAiIubXkxVOeGnPPDGm6Ggi0sRK5gxGAhR6yY0ACC3UN6MsCcIwcFBOqpJNJoNFFdW6+f1I/pV6PnAqPOhugfYQceeO6Zto57C1wnpcIu6UqISnBH22vWHNMnvim4qg9NZmsWPz8tjatigQh+RImUFTcssUnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=KXozoVLx; arc=fail smtp.client-ip=40.107.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppk1AStqfnPz5b8leiHo3+5qH845F1E5yEQfru/WqSPNOGwXFeUPYj8T+1I6O6fJXxjnW1udlYk1KH1j1NF0RIMfq4PrdCp4uQxFAmrAQnR1V6qo/cvLWMfbdn7+z3HYtaLOF9dCMCksXoV7U/8rctdvq3V2V1rLtgKx2FFsHHUOuJ5/TBB38eNZ0WjiKNvcVlNCCYTOJSr18kLZxxDyJgxigVnpEWuUy47gh4DwB/2sAJO4HOx0a+8cx6lG/taj9IJEQvQIgIMFVdC5URPyVGQpAZeLbDLjMy/bQMCgEh0T57nal4775TltSGEsSgvRhso9didQ/JX6QSlr63Bi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ces/Va6U5fgRFrzO4oEqBG/woZa9NwmtXDUvb0jODOA=;
 b=XDjV/sgw0KQcFCvzw9HS9+4Qmy5Iwa6RdpoOY11Dc1M0kl67xiDuTK6+0fTRpGtoJvQoxWGEOSxfGCTafCIg69PiGgjMrJuzJaRjIs/ozDcvy95Sorr3JBUvI3dZId6QlRYDuy1TnTCpM2T8y4SXgfehqf+AEyhqrVkiyZYSncgsd41O6JUtWk4UYI/xA0Pl/mu2EoQ+S9/FvM5Nai3xhedO1e7+U0wS9WZx73rhGfkjb9nNz6kODbgWd1U2AWO+QaQxWZ65LZI/1EyrHLb2rHRx05pb7Bj0qFSgmwzVRWWjbNcbeSa2Qs4orrP/jW5zeENFuHdZMKvN48Ra27m2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ces/Va6U5fgRFrzO4oEqBG/woZa9NwmtXDUvb0jODOA=;
 b=KXozoVLxUrKWscbs9QCjXmV2Ke40BHPtc1udQvqCuiH3eRDDs5wf0MKMsgWX9s8WnJpC1/Sn+F+lDONBgzLSzf/eaMrlq/kkoQwNqDb7lhPmMtDP5V7040SYHJEefnNmm5RSBp/C8NMUUapMsT6CLVxP5tRpYp1SJwYBlcvrVgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by LV8PR08MB9629.namprd08.prod.outlook.com (2603:10b6:408:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 12:18:24 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:18:24 +0000
Date: Mon, 24 Feb 2025 12:18:16 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: andriy.shevchenko@linux.intel.com, arnd@arndb.de,
	fancer.lancer@gmail.com, ftoth@exalondelft.nl,
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, stable@vger.kernel.org,
	sunilvl@ventanamicro.com
Subject: Re: [PATCH v3] serial: 8250: Fix fifo underflow on flush
Message-ID: <Z7xjiPA7nziASvC7-jkeeping@inmusicbrands.com>
References: <20250208124148.1189191-1-jkeeping@inmusicbrands.com>
 <20250222132627.25818-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222132627.25818-1-guanwentao@uniontech.com>
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|LV8PR08MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d926a7-f758-4188-ac68-08dd54cd55dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BLegwHq5vWqrRtOg3xZZt6eXee9pdGKH6RZbnclN9uY65ASh86hQfqYbGNUO?=
 =?us-ascii?Q?Ft/inzfGr77qGXSjYINWvdgF94AzTfZ7BkRBvrX98j0VHs6LQVpSYW0wW2vU?=
 =?us-ascii?Q?lKapaN1M1BamR8AcIOzF/2P6CeSLCuEtTN/WEFqHrGIqL0ojI7y/GOZpct2E?=
 =?us-ascii?Q?wmAHHg956r93svBoIzt+dsOBIasmzMDkEB5I4UDugi0by5GvHfBWJKAEdtWq?=
 =?us-ascii?Q?b/A8njvkLSouZdgZHBJ1E+5St/mlqsFc1OX3jfsCbAfJ7Zwu+ZLn7vuaDH5M?=
 =?us-ascii?Q?6yfyRdMlYl03jUY6OMze3p/sG8neNbGsZhKIoxbU+Sn2UcnNQNy9je8NsVZN?=
 =?us-ascii?Q?Tlic7YkTkaJRDGSJRMZVqOhJ6Woe46SKvgCtXkVkx9A9i2/BSAzsfWC9wH0z?=
 =?us-ascii?Q?iZ36aTUsGeA8RDhM0CBXyGwCYGqVewGGu3031oRKsUqBTEDDUcGGZoeJ78iu?=
 =?us-ascii?Q?G9ARNO696EKfs7NxE9B2OD+dqTgk+D52HSnY8Du999Rwg5bGinbj9Ke8JL2g?=
 =?us-ascii?Q?fjnysiUKgOFlELTDFLtS/1tK/xUVc13KpCvR9h5czQGAM8m6aCqhGjf2pI24?=
 =?us-ascii?Q?Tjq4qYEV+OmFuB7Ux+MAPLBffHb2MxIJLwdeduk971Mj3x/l/Zxd//4m+BlT?=
 =?us-ascii?Q?8T0CYuZvBOFAPSjJmUMR5dYu6DvspDQhFm+c4Qmjv30e1hsrhMElUpeS0KpN?=
 =?us-ascii?Q?1SZ0WNTodf9q527ptva2fAmnLwFaUMVvbvVCGmOyEfiaXRTJIEYk4A+OMu7F?=
 =?us-ascii?Q?eI13EWZmBPL1QsIcMdmcZsrUoPsXwJFfXYs4rBObcT6oz/jLpfUbOXM68xH9?=
 =?us-ascii?Q?W5MsPfnoQKmGKd8qx9+3Gpl+fcMQz20W+vg/6LPbF3gA8q3gVkjbIjQb3vqR?=
 =?us-ascii?Q?oHNfQvFnF2xaHLu2qYD8jjiUNUGPIhfq19f3NokGg+ml7V3CCymynKVI2z8g?=
 =?us-ascii?Q?aKshss+OPDh62L4YCW3/lzimRmQcXaXid0+2xHR9JyFn+CeX9uEOmWDTYmMi?=
 =?us-ascii?Q?dONrnw0+YpE1TQwxvUoJkT8PmPiqvBXZZOBWBDft2dYZKaI1ikQp7xl1zxDK?=
 =?us-ascii?Q?jAiFmHut125z6JEa7LP8roPnMbm0FzCYBG5yG9CZl2Is7HiQQE4AZov/fUmQ?=
 =?us-ascii?Q?eJ0vtLTtx0ViCpoGdx+zf+CeOCEm+xfT2gxYhpm1tTPnisGYP+WyrUItC2oj?=
 =?us-ascii?Q?xLFqvQXBC82jLNMJ6KvWH+CL0xwmACTfViqi8X5PF74mQ0xhN9A0r62FZGOK?=
 =?us-ascii?Q?CnYCO8M+nxtii15LK9wh8+fLXlhSRxsmPguMRtM3OvCIbTgGzTqNZm8UBege?=
 =?us-ascii?Q?1fMuCWW0wiyGCbZ7u/XVGYyq1hiBjmMvplCHJAyvqO2+zBmdRy7bOIMSW+YA?=
 =?us-ascii?Q?4x0lF6bnLISWtCCoesDz0bulTGVDh2AG0svVo/5yZHEtvIQpcpSnZGcfya7l?=
 =?us-ascii?Q?82pVQdHKlUGLxVb803EOwOZo5KaZGwsF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bqo1fwxaa5/9E/+usB0rAOcA4ui6VWdjBd/2iySszlU8wZuFZaIAOvTaN/PV?=
 =?us-ascii?Q?ZyStBCfBmkeLoELv14LpQvGvpR4SCthqaDtjFieqlwKNUylykxbobOHrn9kN?=
 =?us-ascii?Q?nE0R8s8HysrlTKxTqkuNeFLblngeDYg1VYKpVE0Hda1p6jI/53xP9O/rrd5c?=
 =?us-ascii?Q?NhWXNzOph12cL2wHeVpCuH04X6R7tGmgkOJYgL8TokHom6Ki3deBq7vWdBll?=
 =?us-ascii?Q?HwU8pb2I8UPfY6UO6p0kw8EkyA9X408x+IupkBMdO5PKo6E4eG1f1zf6lqyt?=
 =?us-ascii?Q?hWLe9acWvDqVWrFbao06Z49E+Kqepd5sI5l2t4JX+Zd07s7/Ptzrr/kNjxlU?=
 =?us-ascii?Q?dAXQtClfPHKm6JRvel/Zuth4rlSPgJt4QHh5ZuyuFSZ73uh4mDZ50jR9XKPi?=
 =?us-ascii?Q?/DTAsTa9c1MCWOfHq4QLeUW1qWrl2KHd2Qk6bjKD00nopXUDcwDu1Qj6rhaq?=
 =?us-ascii?Q?t5mJF0MAKGnkkZSwJAmCxbDqRZmvB+UdEUxKWf+9no32hAP524IJWG2UfYcg?=
 =?us-ascii?Q?eVJ7TbhL7dV1VHiBLy+KxHzPkoNBsgU0P3EzG379zeBhi5F8qS1F4eSLEKE5?=
 =?us-ascii?Q?KgBvLmrQe7QWbog7K+msvMiMeT4Az+XjzJIK4zvRhF+FryrKZkLorvi2Mxtg?=
 =?us-ascii?Q?w7PZVlC+I/MSjE7v1E5P6v0dBpYV9zZiC/bGZ2h6bghgw7B6bvIJBmerE8ol?=
 =?us-ascii?Q?p1xT+cgE0ugk0F7PXoaISVLybZTPUccqiXHSbuov0A7+QW3AeoyVBAm543fr?=
 =?us-ascii?Q?ZaVgpgQ01nTGE2XJYYZ5ps/FyoIOgwZRpOf4bXjxo3CeNiD5IgpZPo7yn2qZ?=
 =?us-ascii?Q?HrQgMUtMMlUHENdDVNlfo+6Q7zxCE69p2hHzqMDTmxK2KXx5NH7eeqC66MMa?=
 =?us-ascii?Q?lKzwmJ84Ud0D1QEHNCkeCUw4NScL1RdBmiJF+RArVViI+7dhuGXI3sSnnWAu?=
 =?us-ascii?Q?s5tW2t+XTenp7w3+48tYlqkz9MxVnhc4SBUeg14i+EYMwNubXAL8IihtXVh4?=
 =?us-ascii?Q?HS71wAmxWad4c53VgqbpXVOd0Su+LwsrUunQjA1B026oCaC1pzR41Aapa/Sb?=
 =?us-ascii?Q?QXrEWVQceRfu5aTQ2NSS/rvggRcaSI62zcmM7fu5auWl4KThIKVo9M2qvVuI?=
 =?us-ascii?Q?3UBWFrGBNMOT1KFlFg4vG3Ix6w7fLlHxRgE3MYU41Vr1BfM+t+mwUePg5FDX?=
 =?us-ascii?Q?Wccbu0B4Lwu2evxkDXG40EezK5hRddLN7+RJeEz3WutGWRffffS2Vxin9ED1?=
 =?us-ascii?Q?zVBdVxCB1ioshcnU1MmKUhZBWEL1YoUYZAjepm+fHpMjSPVHGoC8aTzeppWO?=
 =?us-ascii?Q?wolMXG2bDoWCfwKciy04PN/iB7braAfUN7KPH0w+qzz/O/Wcx57f3N4tY7KL?=
 =?us-ascii?Q?UsTVYhJ/hSBz8Diy9TBpSW1F7mn6/1XFNOaFRTu+3OlkZQuYat0ya1ByCtpj?=
 =?us-ascii?Q?miiNi5yN2BGEwyKi3oO+2yL51+munkGJSFtSju1zW7df83I01sF72TpbbnnG?=
 =?us-ascii?Q?vd1mUPakWD0UM0gNP3/H+x2DXbS2O1GZMuv4cVxae69MjrMG9Hv14FHK7wXM?=
 =?us-ascii?Q?3wcBM+/yGg/G/ocshJmZtYIhwVsQ9ISg7kz91XQHSmJ82iHposbJB4IZ0kd0?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d926a7-f758-4188-ac68-08dd54cd55dc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:18:24.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHnCXufeWEGNuVZ+wN6BKIQe5/ndlp7B23yomaPgprWVhRGJPJR9npJO9fTe5ff4ttMbzx/Z8uLd5MQHKJBev84ZIdKggWpIlRD6h9XThTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9629

On Sat, Feb 22, 2025 at 09:26:27PM +0800, Wentao Guan wrote:
> It seems strange that call 'dmaengine_terminate_async( **dma->rxchan** );' in
> 'serial8250_ **tx** _dma_flush' during code review.
> I am not a professional reviewer in this module, could you explaim the change?

It's a typo!  Nice catch, I will send a patch to fix this.


Regards,
John

