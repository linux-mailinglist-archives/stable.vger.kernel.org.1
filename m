Return-Path: <stable+bounces-114391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62038A2D615
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C74169CF3
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7865246331;
	Sat,  8 Feb 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="nWsRVFFw"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6F1E4A9;
	Sat,  8 Feb 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739018529; cv=fail; b=sjSpm1/MKdWfHXKRN0f+Cw5oi0Gc7VYZfAdU/S5E1lT0qiXyxi4i5KEXisEMYAFzSpnVCMsQ3a4dfZbNtCTXp5yt8AdM1H6vUD+dBUS3fmd6wSk/mzoQff0mP+xM75x2Bnb4tveySxY8gE/upzfs7aXWlkVMkh5Iz3kkxk2HuOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739018529; c=relaxed/simple;
	bh=PUA+JAcXH7YFYLC4t9ndxwDu9L71q61Lu3hhwfDbBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rxXNkw2UGltKBEnRMByUikybWagkcsA3b/y9+SvUqaUT5QJ+r6kdVDTom3/kgdcaJcwlryOcxjBJt/5PhtnJCxAbFO3wONu/tiP9n4cGxSELU0iwbtRbbWni0WpZlXTi8OqJcxiV3nLc5InxtnHS2jg3F9H/viGKfS2PgdNMjvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=nWsRVFFw; arc=fail smtp.client-ip=40.107.237.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2XW7Jz1l/ZqS/6kvmD/x9dKVp8DwcMeGn/+Wbdj1vt/5ZEq8YTByCHg7fh+XNDhcmB2SRS6O9MxpNcOEtpxZyir4EHgSz5J0UI3IElc1LvEWyF9u2UdNSU76RVonzVdColG50DxoZ8Ps+ZA/slP4a/7Cz1RephZhb2hmVbCnbiIqM51v7RzQhU4Ch4CggFnKoLHVw79sS0I5/gFTYTk5vCrFicnpTBrM1r8th3OM9RHI5WKivx3S+TWQBTsex4BGIBkjsYWVL1EilSHuxvTBHOidBYbZmCZjniune4ZPrDu2CzP2nV+0o9tnt0YcNYJ3b7REEmH0uzaMifBsUCfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5svjNw0M/WKucWyE970Yh+vsTbuQM0lVrmq6OMhIeLs=;
 b=urvVwsqT/WiAorROj+6RcHF4csmgC/HJVvyBs6YMTJGTkbOoHTN7fSowxlSy6/mXMZbARVmm2qpBogKVzsWQADGbfKHBYXffdWo6ayGaebm0D3sZwIC6RjerYObNvWi4vSXS5EHSsnyC4HdMdavZknBa87vBNsy5PQ8JRFrGUKOwL0p8+CfwNf+EhqswqoqS6W/aKmIPgq4z9Zmc5sScxGvmo5K5wcA7ERBJ/r5Mxbc8sLaFk9MZRKhGPjquDaj9jYsRrFey3d0VtwopYaGdY7emch4A5h3Ogj3rXPt62tD6M2COH4IoOvM4n98XxfgSe6WXdVnWVSknLJMuJaC6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5svjNw0M/WKucWyE970Yh+vsTbuQM0lVrmq6OMhIeLs=;
 b=nWsRVFFwu1Xsr0gvl4WpG7Y99sJE1aMICuYzY8pQuQzndF32jFxtPIkVr6j80DHr5i4QxCHwrnhL2mJfpuWnRQqfLpq77mOb0N4VkfrQ2U2JhU2s09lz0uGbg7h43bCFl1A/DqPz/bRNTuehIOOO2qE2C/SyhRH7QbBHRRKt4Vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by CYXPR08MB9684.namprd08.prod.outlook.com (2603:10b6:930:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Sat, 8 Feb
 2025 12:42:04 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8422.010; Sat, 8 Feb 2025
 12:42:04 +0000
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
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3] serial: 8250: Fix fifo underflow on flush
Date: Sat,  8 Feb 2025 12:41:44 +0000
Message-ID: <20250208124148.1189191-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::12) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|CYXPR08MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ac122f-29e2-4506-cd62-08dd483dfd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5zudbKMG9ZQzRM0mvYyLz5ibyuItlQuV2ywE/pg+ezLeN8Y2/GbTWHHfEez?=
 =?us-ascii?Q?mDpH7Tb+h631b/cWZEu6cqDLW3nVGHMhD2G+iRWv3n5Gs60HFmtt6hvq+XdE?=
 =?us-ascii?Q?CGK7AWGt0RdpDZ3BPIPUBj9TedvX/CFtqHZZauiABQI5b3AaxCKs7cdX5z0o?=
 =?us-ascii?Q?4Zwkeam3UKZWpxm5jJhKO6PJ8aiyxKChv4ON4Yy0K3YxiVada/N8uZC87/xu?=
 =?us-ascii?Q?EXRCTQFEpidmvp7+/1M2tlfetJol2dm+iq1GXFrLqLDH1tOLmYVCO36iA3uw?=
 =?us-ascii?Q?MIOci/yB4tgCzxsOLXfuFvs+DyUI0a0VK6QZEbjewXY+x6cQa3pObAAz56Un?=
 =?us-ascii?Q?wv3JP3aWlmkk6uvptcZ00HP6JOFoLDl4bfXkpYsXZa6ZQKS3xTuMrliDCWLf?=
 =?us-ascii?Q?tUkW9mPB2LkllZnWjVaTDQK2HO+wTSR1KnaFuunh/bP6moin5GUWhqkAC+oT?=
 =?us-ascii?Q?GlnAqXYQQsl3Penc+q7KJ+N0b5DXf2qMCuGl7tBwlX5waisFJdX1zsudR5ay?=
 =?us-ascii?Q?e4ZubVrLsVd27y0xFojzTYqrXbepnpD8IowiCsaRr4emS7DM/2VMmrXpmoNf?=
 =?us-ascii?Q?MqioXbS4UvaoRC6jBObDI9UQJI78Y/6fziqt6nrxzO61csmZT1rJDkIEj4ln?=
 =?us-ascii?Q?BzGvH02aRr0lY5hHfT5zMqGrayM2aUMtIFehTwLsDbVJmtKqL4plvySTd9G5?=
 =?us-ascii?Q?huHX5e8v+vEl+TxvTp/yP9BCxwItuWLmJ7plyEUEPSP5Vdg+W9jMKdG1sJi3?=
 =?us-ascii?Q?cABLaR2R90ADZcZv3LTQ+gVlk8/QP53xtg9tNexJhxQOSesLOoZ/C3aKRb/W?=
 =?us-ascii?Q?89m6HLrA46tBlijt5MOVL8Xltzq2MbJpgdekvuskNrPH2hScDsRxIHsvNNF3?=
 =?us-ascii?Q?JHiC22IEffgXKtYdwAcZJ38tTKO5WlEggkpXoQa2PfU/DUIHPhnqspTyhxrQ?=
 =?us-ascii?Q?8UAUtTW6ulsfKnoJI8j8J1JZXtA1Ue9EGGcZHOlDEJ3oFqA01BLu8cwbJTqV?=
 =?us-ascii?Q?7txRVJ1cN0ML7NbtF10TmfAv3XK7ryiZviPQf6UsdBkHNqgwYrxejDFWxlbf?=
 =?us-ascii?Q?b/95JZE8jQuQL/lQKJ7dk0jmwyGX2SIqkZ7MKxRZHclj2dcA8zfqgxGx3kU0?=
 =?us-ascii?Q?9pHkUIkErwocV5Xh5jcy/pvTvYafi19b+kgFB/C0TbsPhWUXi54earrnVIRm?=
 =?us-ascii?Q?3QPSswP10JPhMtvUaTReso7EpLg8dLNW9Q4/LLpOJT4XVdlLoi6M9FqS+VlH?=
 =?us-ascii?Q?JFRmmNBSfg8VCrUv/VP41XkGlkrNzy8ov6ohxVb93j/F6UU0alTXTcuYZUMK?=
 =?us-ascii?Q?LDGgXfrvSWqoRvTiHiC11apmc8YkHve+ESp1lcfAkH9UPKddynt/5l1vmwgI?=
 =?us-ascii?Q?NSRdY7NbuXKpkhnxM65wEVVceVGdoxilVYKwdjCzdEe7nmGblLs9kfUp476A?=
 =?us-ascii?Q?MJX56zEDCoN/OlFeZYQklZoKcekxlhcb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2gE+kV68m04OyTtlLvKgpTbTNmgBNnjsSh0knUox2FpL+4TQ7jA3kUfzvh9?=
 =?us-ascii?Q?HbrmdOUCsOn+7Rexv2RqlZDA7xzad0e7CrES1OSxWtU7YAQbglYElpRKDbk4?=
 =?us-ascii?Q?Ebi77S26mPZh4YwM1BDkTtB1lUutf/NgoJsRkCKb3fCJbkpy3Xor+UghbxKH?=
 =?us-ascii?Q?YnneMYmQrl8+9Si9/V322HdunQ+h6LnYUN0E/eQLIyQ8iwmWUep9ZDnbgO55?=
 =?us-ascii?Q?ggLqYfDS2V7mvrpbRlkDqGO1IeWAvXzuvNhTtEWhsGagcPR7bSsDAxbTGirA?=
 =?us-ascii?Q?gqgkexoB0lGdOR6O02BrSnpGhj0UHy9Jw2M3wD8J54YHZ3u5Yu1hNnFrVNCw?=
 =?us-ascii?Q?GW7qUdZw4MhOw+L07ZE/A5jlQPokMA7KO0sPx6XQ4u6EdTauGvbD9JnCc1Jh?=
 =?us-ascii?Q?5NVZeW11LUu09G6Xx44IHEgFa5cpF/B/fsiG8NUub/Wu8RV6LIBtaMrdXZJN?=
 =?us-ascii?Q?dSGaZorZS3wWnINQJKy6SrtD28tSocFW+ckKRJ+e+BL99haQWREVVLnrIJTL?=
 =?us-ascii?Q?/1C/VJueuTOG/LZ5AC4bY25WuqhH20H1SImn25mPT8feKVb9p6p8s1Euy3ue?=
 =?us-ascii?Q?oqCvCqPr9CQnell0+Su2RUPjoXQpwxeUMgm0nphgAjarxe2Dx54C5uiNaBbt?=
 =?us-ascii?Q?vEUThYzFnKTbhNLQ9mRohXp0w/5xZFtgnq5i3eshaa+zgajcYXnxiE3sJkqI?=
 =?us-ascii?Q?XlD/EpsraTdgkSlqWbnChQOdwDkaHz79GN5YxfDsKt0njWYoa7gyjXUYCB6L?=
 =?us-ascii?Q?AAiHF25x1skHJXJcK8ehLhydViN1jjkWIdAke85Zn14KVmXNgx7SWzeMcO5a?=
 =?us-ascii?Q?qNZWhboSgnwhKaokq1foLoHrip3lSyBQnxXH9uNYMpOE5MxaGz3GXHMJ22zr?=
 =?us-ascii?Q?ly/E4omBOYLh+xFt6MtcFrpaBFF262Sz/tNK4YgDqS97p5muNGqeH3CkPHHM?=
 =?us-ascii?Q?rPPWdKkSs47dBqbyB+6WhD5dqNm3Vo6aShvwXxUutul8oF2ZR8wy6Qo//4DT?=
 =?us-ascii?Q?drG8orsnRsXdSWvOWeP7Gm+hKIYozf/Z7IWOzmD7Rpbb4w49BJ48o8SNcHCe?=
 =?us-ascii?Q?6R6bSiaACPQNAE0cDoTEieG/gmpgw4gJcAr+IVK71vzzIClgS2uG76N7cWVr?=
 =?us-ascii?Q?HTObq8t04MKx85yECilEH6Jt7ed0lo+Cqmo7xambJhLLm/MNaNM52q/wrqMH?=
 =?us-ascii?Q?cbbGwvzFjm831MFYhU1r/6uDMY7M1LemrkC37k97M0cfxVS7n958L26kb17x?=
 =?us-ascii?Q?PEc6FEIu2gjuPW+p2GNZNg/6288HzR/uvI51Ikzke8JB5hEvK+LP5kktafa7?=
 =?us-ascii?Q?Q4wc6pHmpHo3/YStZoVaQw1wXp8wgs/SMxGZBiUl6Pciak/UNsfXtK3j4TGq?=
 =?us-ascii?Q?JsUe3hD2UHVJU+w/SaDlOA5LnU4tdkg0uHvbqJ5j0lTQVDhVePm0VxVMmCh8?=
 =?us-ascii?Q?o2i1Hb1xtRNuMp5FyEr7bUV9n82p1Scb5fLZ1A++BMhhqOgm+aYAqfaQHJ92?=
 =?us-ascii?Q?rNGoEr/8eHUYwwTASSTy/MIP5rbVBtuZaee2KErwng0MoSPrJ2wbHhy9VLNn?=
 =?us-ascii?Q?ZPnuYt3yxqhIiTDZYeI0036+4FQJCxXJyxrxFDnafu/ZERDpFlmQJQTwKo6l?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ac122f-29e2-4506-cd62-08dd483dfd7b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 12:42:04.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvOtQ39YFK8ev+ouB2cS+zX6c7OyoN2fHaYJbIBECLXiMsSVOKzwoY0ixisJXvHJPvq5nWQpLARJ1P543uPOntch0Yz6m9ydD0CJzP6ZNiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9684

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
Changes in v3:
- Fix !CONFIG_SERIAL_8250_DMA build
Changes in v2:
- Add Fixes: tag
- Return early to reduce indentation in serial8250_tx_dma_flush()

 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_dma.c  | 16 ++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 11e05aa014e54..b861585ca02ac 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -374,6 +374,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
+extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -406,6 +407,7 @@ static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
+static inline void serial8250_tx_dma_flush(struct uart_8250_port *p) { }
 static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
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


