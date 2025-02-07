Return-Path: <stable+bounces-114236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C6A2C19C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5E73A3305
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793DA1DF24D;
	Fri,  7 Feb 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="oJbX1CvT"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F61DEFF7;
	Fri,  7 Feb 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928063; cv=fail; b=BkHEn2JNbu485hxUAkeifQtd+Zntqg5k1vvZpEFqos3MX/n4HMC5dBmbrvZpmFVI67LdH2XpGa65eX4w2DQsmdGHka1BcNKEDarhpUA/Sesu8ERyO7yaml3ukQMHc9tTU9wUACf4u/F7EAO1GSxrcNxdJJ0/NfwNAn+YDiTaTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928063; c=relaxed/simple;
	bh=m9ZbU5cxFzY0iY0eSOLeEeI3YMAohgntyfHlzgSfVtw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EVwwqwZWkM7TNQQt0BOSid+AOkPvJsPnJrSULoutH5fS56GNZ24w2vulgpfiaUtNpVwZ8jMIQq1LErLgcpBvVq0IumweJjAqEVmX3qw+E8IsbY9426aoQWvSEw1mgM8/5k1j9ERu1X92JX7EWMYrASbGtlVPEe/P3p1VyPwymZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=oJbX1CvT; arc=fail smtp.client-ip=40.107.93.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/pkX6yPzfStyFo7bcTqJy2fo1/5gO/3q+XlTB6xs4rYu+pUTircpIqnC6rgKSajQXQrfhc8CAUJSQd/8Aq10mq/EoYcWA99ECbpdyXPcrlFKoVFkwOISpECIuu+uOaID/ICFTJDbuzPneCVwKhmiSqY+HzN7SPnhjxoGc7HL4Fpi94c89XBggekf0Iv6YleiAFEVrRR6nQhMG+xHN/bz9sZszfBliYXRId82cVXgewsVdn1fHM61hzhjCjOq95x0bTwgmV05VBpN/h7nPJCuz5qZfuRlB9qfbBNCmsvXw41jxJuqod86/rciIoDo8RVO4hME/qQ525ZGDfbUKWEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2loUqnZZ1jDKSUlz6AUKddMN2STNvOYtwwnT/DtKzw=;
 b=GXEBuCVV4pAwhwnU2Ku0GO3dbafnJevl1lEsn9SCftA5V2ylMdnY69TkLPu1ZNCbtU0FN/fcp4MwFz8R/gHn4VRLQfdRd2rExrC3cZZKdcSY7hWorigXkcV3B9+dTK1rs756Rg2SMWc7Lc8JQ7hoz2FrOKzPV8O+NSVU7r2+7CmCqH1CDhZxaJdCETKTX0ljWq88wcoCv6fg8w5af5PTwXAvv7BUkbCtLgY/BmwbZAT9hPRewQQdApUMBXEhpiWsDajCyUxZ0WbiyWTcyHH/KP/znzv87SdNL169W2/rY+cnvpVDaTx+NOLSlfutjITlNvVlne7gOaDwTR0FnMKTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2loUqnZZ1jDKSUlz6AUKddMN2STNvOYtwwnT/DtKzw=;
 b=oJbX1CvTZIQxVnadqFjUIti0/RQboAAfwOK7QxR3aLRvm8UJCZqAUzPHc0i1sfKjnq2x8avykB7qBUb9Z9nSaMIPBYXaGUo4NvzHWKC7IbCPfqmjm8VTK+UwUm9brcBxFLizV10f16u64s4V9tGK16C7XiZuuqO0uu6UYLmRAnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by SJ0PR08MB8409.namprd08.prod.outlook.com (2603:10b6:a03:4e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 11:34:18 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 11:34:18 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Petr Mladek <pmladek@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	John Ogness <john.ogness@linutronix.de>,
	Ferry Toth <ftoth@exalondelft.nl>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: 8250: Fix fifo underflow on flush
Date: Fri,  7 Feb 2025 11:26:05 +0000
Message-ID: <20250207112608.693947-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::8) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|SJ0PR08MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5914eb-dfcd-4e05-db18-08dd476b5b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AP2bE4ssYBhz5zUw6/QJ59XaL+wjw9IXkuVoPZwF/8I+wi8B0u6RmqbwmJnE?=
 =?us-ascii?Q?tNS4ej66BXCaYeM/uZx2cRLCh/7PPgHW2sPYubpIko4R3Y+X8uzgYGrSd33+?=
 =?us-ascii?Q?vwD0+EK32psYQsvpzCmkBp5THRuSTHR5AmWMEMjrCMxzeK8g3Z/568NtDeN8?=
 =?us-ascii?Q?O2h6cM6Yf7h8NhereQUhmJiyindHAKOFLme4UXALkrRhvKRZmOBS4Ma2qhmy?=
 =?us-ascii?Q?yHjTixwGoSQnhsZkRh6n+cV6wl6VOYgAiBJKLbaIXPHa6TuGR18aEvl3dpgg?=
 =?us-ascii?Q?qiURgAgHgVa42YxanphyR9InlZZzgzFZFaYKUQup81k8AE9BauEiz9mLfWZT?=
 =?us-ascii?Q?+on+DT2GyNqGAfnrqsp41xWG78g2FG7VGhb4btqAn0804HP9wgk7YCbjC9yC?=
 =?us-ascii?Q?lclRYIJvIZBmjN4Vw1y/jZVaiAcUTa2wBmXqgW8QlT6q9itnXw5tR0b0zGQj?=
 =?us-ascii?Q?91/dxIfALKmL2HF2f8yZkLXwmmwIquqN8FQYeLJ8L+5vqJHo3BCIGAqeFh59?=
 =?us-ascii?Q?RaXCy7m4zFii/j/ht30mUlIBxctNv+5D7RYPTXXftQTc10kG8o+fz9btMIHN?=
 =?us-ascii?Q?+2ebb+z4flzhl2PI93TlyU3dX3q90jihHAsKbNIjRNyseCtQcJXNffyAQx56?=
 =?us-ascii?Q?KFZzr0pBoMKVnf97G++lZgSooQq8Ci+UAQDxeX/34SS6u7OZJkWJiXo3Vj2y?=
 =?us-ascii?Q?5UEHnFt7abWyojUtaaGZ6CJ7XAvpOrAalp6Kp0qpNxQjOGUgyX+W7ze3+Rcd?=
 =?us-ascii?Q?owvAXzNjlwbw2br3AeKwqLek441BKp2SvuB/y9w3bIs8GjzkGv0CsX+u2a8k?=
 =?us-ascii?Q?fZh+IywA9JYiGW8uLVxcVO/XSFA/e+voxSwEL8dtEEuwqd6WObACGBXauyLt?=
 =?us-ascii?Q?eEo+Ljsf2B6jrxJFERAoQBYVDEYMH/9lwrvwHzZsz3YclKq8yNc5ak0Yw920?=
 =?us-ascii?Q?YQUyCmyWQ5AB6rpba5V9WMhRzEKKLXMPlOLscZPMUBOTAJfsb7oZsmiKOOwM?=
 =?us-ascii?Q?gZuOE/lS7Pt9BdIsDmdYxFp+h/6JWeJW3a3rDvQ2nwKpBa7jsURpBvABWOEh?=
 =?us-ascii?Q?ojA830XQXOptTlzOWXMWOrYWBz1XgK5dLmfspNmNgpY5koYCCqyjM84y2PaP?=
 =?us-ascii?Q?Zj+OjimNDzaZWs7ZPfMjfAQE17Wdkaj+bRifS8/lynAeMEs4HvOk46fo4DDR?=
 =?us-ascii?Q?4BgR0FsJMbmGlrflYA0ydPLkwjrnLJC8823sKmAcwVjw8Hy0VI2RDapasuQD?=
 =?us-ascii?Q?33QZJvNe+FTj7kmeToi73XQ5yYd31dKgDV7rBFxjfacgO5BeLZ+9KA7nFC/K?=
 =?us-ascii?Q?mGXIR7EjqkQpLewn5HeeNyrZcK16wEVpvC2Kv1C3+b7YXA6//NADUX9wOAcr?=
 =?us-ascii?Q?OBxIRBOOwr+IJPC54ub9eDUfsBLn2BvYst06qHdXHtrkqRhRl+DUEYnH9e1P?=
 =?us-ascii?Q?bYyOjb+2u8YWKGC7LaNxpG1gJOlDXf9g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0B8sofLVbvYJVdEtpvRr86SrHt5G8uhXwaIskoRF7uKORld2YC54fgGlTS3E?=
 =?us-ascii?Q?Cf/ilngIjynPXsGwPb/SYMtnZPrtTurdt7b/aqa0xrFiZFF6Okf0Zi1VfOy8?=
 =?us-ascii?Q?fdYjfC7gG4BCjO3sSLEn6xC5u5EAze5sc9wp5RVaNobwqx/ut+s50ll1UIfB?=
 =?us-ascii?Q?JAkMNF4Gm2zOYliQLB+bd1hiCYTKDxPsHMf+dnDGL3waGeZ7CcsL2cnL0//n?=
 =?us-ascii?Q?X9syXIVO5CIDlK4WE6aFCSc4BA4I+GWiLKV2HnVNqbQ7HlXGaiYdCm+wREkm?=
 =?us-ascii?Q?ULDEg2En0QLln+ukam/oJfnrSnuIuYCguv2GI57S2sha10W8PSOvuB2jPxep?=
 =?us-ascii?Q?z5p13wKb/Qr7NuuneFgUrDSGfr8BuWpD/ZvVdK+I1LLSjjAu0FYsENH7YwHK?=
 =?us-ascii?Q?v8s7CyWIY/K2SPE1NtGcBkXWjNtTW2bb3xqorYoSF8fTF12fineFjwGfTJ7W?=
 =?us-ascii?Q?eIrlrsEp40ecocE4Nsx+uwQ18pIiVkRdn2FdrI708kUteCq7hvjYk/KMMNol?=
 =?us-ascii?Q?8Lq3v39givsXKT5iGidJ1F+zUFepPE+upZSPt4usiGYou4bDh312yJv3IIhr?=
 =?us-ascii?Q?PEa7t2UBEdd/mSQ3Btm7PQQ9/gE4JmP/F+IXqB+wdeELvbLOvVIrPVIL3Jzs?=
 =?us-ascii?Q?83UetlKf3jXlTs0C7gf3aU1RQvGoi2SegQsq08VsgqGUhXIwGc17qsiCWWGs?=
 =?us-ascii?Q?tTrlSMtsexy2Gj/1jOrcU7QDXwxnfjQhPSblGpVUmyRlmL8gXaXwRRe2Gee9?=
 =?us-ascii?Q?jHPlVCDzPhjrkIQjysvJTkM2sD8jDkGI84HQyMQN6bSbvhV6GiTJQ0YAtHSp?=
 =?us-ascii?Q?q5YlG7UWaUuExkX8BxEIW49HHH/E7PSuWrzAb/imp6DO0c+gg3efYJ66iDiV?=
 =?us-ascii?Q?Sko7qWEhm5LudEZveEeCXel8FQwMElpt+zHiOlZN5DeJvr6dgYvto48VMMf9?=
 =?us-ascii?Q?J0YLdegyuwWs6zvekutqWkOJYDbPwuqmAiZDnCO7xgn2wtB/WfnxbvqIC6Vu?=
 =?us-ascii?Q?JlrQaffgzyOpTbFvvx+LPFAxSAjMs9oS47F19HEbgMb3dLpWxktDRMVVPGCG?=
 =?us-ascii?Q?iOuBHcnTHrDIYGQ85YbZIegONBXq3Kx9qpTh+QzB/sMVjzUt26xFkp/0esog?=
 =?us-ascii?Q?Vun40DotCaOE7M0Ld0JNc2d2G+easiSaJmHxEANVwp29QYkZ3TfW7cL2iPNf?=
 =?us-ascii?Q?+EKzRLXZo7V/Ghp3PHzedRUJiRw2wW/Y5u/nAURbmhadCpMjeo8wvBEg65S5?=
 =?us-ascii?Q?Qf2QmDAMYiw4KNX4ZiuNlApp3CSUen1QVLZJTVkykTC1xcr7ZrY3ZP5oV+ef?=
 =?us-ascii?Q?+jjTWIGTw/Xq3QIOMirmU1D3VsMxjYpn19NphCSFpJ7LcKOiJdQ0l5zAbZRy?=
 =?us-ascii?Q?aKIyQq5gT/XtKpqeunnMpIRO54NoFXhHPwNRE/jBa0al0SE9OKYHgFPrg3zn?=
 =?us-ascii?Q?0GdNL/c3IURBPHrOqPaTnreZLPc340g5hNAxpT7MgqBR6/JtllQoX3/u/cIe?=
 =?us-ascii?Q?PtpFfpo2HlVm36mlmHa0b/KJM3oO4hOp3hME/QwUuBgiWhyE4tJRVI1tmavc?=
 =?us-ascii?Q?ygzmAql6NouMdXKLE/vaKUqCf3aYwrNHS6/4w5xnLDg9Ytb/nDI+YYvpPRis?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5914eb-dfcd-4e05-db18-08dd476b5b82
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:34:18.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O8oFtPHKX5PpxPZHcEPz9XbhdqvZBmyaBpPxIB4xiQ9vqzJ439F9dCVWUVjlc2KwTjOv49+oq6ooy16EkDvwr0TqZ/fgnkV6dDyXvMTUDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8409

When flushing the serial port's buffer, uart_flush_buffer() calls
kfifo_reset() but if there is an outstanding DMA transfer then the
completion function will consume data from the kfifo via
uart_xmit_advance(), underflowing and leading to ongoing DMA as the
driver tries to transmit another 2^32 bytes.

This is readily reproduced with serial-generic and amidi sending even
short messages as closing the device on exit will wait for the fifo to
drain and in the underflow case amidi hangs for 30 seconds on exit in
tty_wait_until_sent().  A trace of that gives:

     kworker/1:1-84    [001]    51.769423: bprint:               serial8250_tx_dma: tx_size=3 fifo_len=3
           amidi-763   [001]    51.769460: bprint:               uart_flush_buffer: resetting fifo
 irq/21-fe530000-76    [000]    51.769474: bprint:               __dma_tx_complete: tx_size=3
 irq/21-fe530000-76    [000]    51.769479: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294967293
 irq/21-fe530000-76    [000]    51.781295: bprint:               __dma_tx_complete: tx_size=4096
 irq/21-fe530000-76    [000]    51.781301: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294963197
 irq/21-fe530000-76    [000]    51.793131: bprint:               __dma_tx_complete: tx_size=4096
 irq/21-fe530000-76    [000]    51.793135: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294959101
 irq/21-fe530000-76    [000]    51.804949: bprint:               __dma_tx_complete: tx_size=4096

Since the port lock is held in when the kfifo is reset in
uart_flush_buffer() and in __dma_tx_complete(), adding a flush_buffer
hook to adjust the outstanding DMA byte count is sufficient to avoid the
kfifo underflow.

Fixes: 9ee4b83e51f74 ("serial: 8250: Add support for dmaengine")
Cc: stable@vger.kernel.org
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
Changes in v2:
- Add Fixes: tag
- Return early to reduce indentation in serial8250_tx_dma_flush()

 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_dma.c  | 16 ++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |  9 +++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 11e05aa014e54..8ef45622e4363 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -374,6 +374,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
+extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index d215c494ee24c..f245a84f4a508 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -149,6 +149,22 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	return ret;
 }
 
+void serial8250_tx_dma_flush(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	/*
+	 * kfifo_reset() has been called by the serial core, avoid
+	 * advancing and underflowing in __dma_tx_complete().
+	 */
+	dma->tx_size = 0;
+
+	dmaengine_terminate_async(dma->rxchan);
+}
+
 int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d7976a21cca9c..442967a6cd52d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2555,6 +2555,14 @@ static void serial8250_shutdown(struct uart_port *port)
 		serial8250_do_shutdown(port);
 }
 
+static void serial8250_flush_buffer(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (up->dma)
+		serial8250_tx_dma_flush(up);
+}
+
 static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 					      unsigned int baud,
 					      unsigned int *frac)
@@ -3244,6 +3252,7 @@ static const struct uart_ops serial8250_pops = {
 	.break_ctl	= serial8250_break_ctl,
 	.startup	= serial8250_startup,
 	.shutdown	= serial8250_shutdown,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_termios	= serial8250_set_termios,
 	.set_ldisc	= serial8250_set_ldisc,
 	.pm		= serial8250_pm,
-- 
2.48.1


