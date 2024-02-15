Return-Path: <stable+bounces-20279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FB856702
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 16:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9760281D72
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A3132497;
	Thu, 15 Feb 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="CzFlejs4"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249E1754B
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010163; cv=fail; b=FuaVeFgeoBvezYvYU3b/Mytd40obGpmmV2rItaeog8x+ecBs23ZmrTnxqD6QWOHDzLglLTT5fz+J/rGgUB96tjJTXzjxAUfNHt+JxzdwAgikokvgQnXYVdSR5Lgcp+Enuc/nvPGkF35A6BwIgw6fRXeCOd3o+5pur0yLdDWTjS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010163; c=relaxed/simple;
	bh=nVqxIy2L72qgZ3MoyOHC2yVG3NS7iXbKWDMVBmUS2XA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qiSP2Hvp8KHbQwBTTua8gzXD2vatLwa3nqj3Gm3oghF65v5H+/xMJEsR05768MaOPPhn3iGLQLb2xz4uFEme6/GAMmMVoBy/4r6QVQKxDveUOBzBNfyOci124zxCFlvAM+VuxwLTVu3hdfDABl5sa2/wbP0YUvDG1TxeIfrKI1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=CzFlejs4; arc=fail smtp.client-ip=40.107.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5tMt9rPjI3UdEWe6cpXE7xpgsdWB99PCRt0wTQgzw/NgvG5n6QOK0JkQ/ZL4uodSGdY3jK+b9A4yJMLkhaUzrdx0pYlUxw6sY8RqD7t1Uk4NEXkAWLOwDF3rl2/3fKIaT4SQe4SDXL/cNPNh81AWlcLBINFH1otjwxubcwwTw8VSn8G9ilNH6mu48F57tLJjS6nCic9g+xXHx3+yLNh23k0iKC7UZTPTJfmIWdcw8g51xy0dGuh7EnHir6n6Hq7nTpHLTFe+p0gEYdEbZntwvL67MStsJZnBGqovfgC1W2NpWFKF/Nrs+NPJFDgKR/WgJCbJ4fbAneH30jAPMo73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVqxIy2L72qgZ3MoyOHC2yVG3NS7iXbKWDMVBmUS2XA=;
 b=CznJKfPlYKmYNg9pCzzON0FbX5OjOyIX/CX/9zBf8G/EFWrq6MOyUG8PEYzQlpvR2H320/o3ocZdaK1bYcsCPc5RsFPLwf9xbCOkXJc+YppPw28l4Ejri2WXYcPjIFPMyQL2vx1CzKsaNgEbwHLUearO6tA4oE3Zth4vlZz64qRt2+wOdf13VEYRlQ+F7Tk2Wvm4JHVJpAYIoJxK3EQM3AhnkIc0JOkxb49imzwkGqbCfXCB9wKdBztqypnSar1Ev7YpkCukF/YzdFOStKJ+8eeYlKxM4wWp9Sm/RUGSXOZiqCLliEmMAlOUlvtr762yfZNfMs8qhrvu1RHVkma9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVqxIy2L72qgZ3MoyOHC2yVG3NS7iXbKWDMVBmUS2XA=;
 b=CzFlejs40aB6WXjcpPRYJ474igtZx516rEBvpNjBgoi6H7mRW1sowcjkRKCWog6Y7DmdJYe1oQmH5yV/mD1I3OaNi/xnH8oCkq8vIUHxgJ7YhenzyZFbhNOBwQUwUagf6H0cYbMX1Iw0zHiRAg9kgccSH6Tf6rmxJ4faAaoWlDtGHP6gN74zGJB+qcYE8nHJbA4KRCo7d+uRwc873iGKwyoLcaKA5mKR+79K2kSnrLOXVMARlacFPmOyWixBeV5D28eK5j0MJsdPz465v+it7UhnRkF9pa8o2GOQkuLZfKqVuUYx5jFZPRP1HKr6rhx/Z+noptCyk7YZHFKVsAiYLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1539.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 15:15:52 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::9a43:c1dc:91c3:186c]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::9a43:c1dc:91c3:186c%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 15:15:52 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH stmmac 4.19 0/2] Fix kernel freeze when probing stmmac devices
Date: Thu, 15 Feb 2024 16:15:25 +0100
Message-Id: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9688abb8-2bca-41d4-1f01-08dc2e38ffa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L7Zek/llQw8+OjMFlIR7ntaWjdnTdK2xZOhYhDIiVgvR+Z3PeoeZeY6CsMROLpJIy4+sGiq35T7XkASjnn9+z8aRL70kQ5aSwb0ubjDJtY1Eb4K8uy9OSoPz4D37FC//LMz0X7HymOzRMOe+IWtIw/K3U1kV5DGyxZbup1dDtHk9fWvmbqKM1umVSh8W12qiyaz/MhhicWemfebLPBitjSxNS6IEZnQn5JZoPruEQRRec8Y4o7ICvG67U4rUPgDWZa1mpM4dER2RDeVhL6JL8tiSZKoI6pWkJGrOwoHLVcUeEykOwLn6Oial5Yec9p7bGsMijXVh8m4aH+/4WbMbXwOOTJu0RcHchqwcxhA39Nw8J0iQ1g5HXDIHKsN+9+wzjTQZSRMmRLDaeZil4WYeYV68//MMACpFfTYdqPZewsP8+PwBuo3ZJVV/XjBMD/d8MkiAfnP0PkFWI+9DQ9dDNDNg4SdkpUjRDbWefX2pqjeIS6CfjSYiic3+BV+vvt3qNze0OU5t0gisXIxBYCtljWCwrCFwssJX9SOgQjnTGrHmMB2SNTpskDJvC/Dd1uESSD2MqKLmnwUoKkPCk+LSRyoIAuhqqi2A7hKfd3ez/WeMNDuRXIdlTECGCLvoUP0F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6666004)(316002)(2906002)(66946007)(66476007)(6512007)(6916009)(5660300002)(36756003)(66556008)(8676002)(41300700001)(478600001)(26005)(52116002)(9686003)(2616005)(6506007)(38350700005)(6486002)(558084003)(1076003)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Rg1xpeAFAzMSJ5MAUZvRUEOJXg/hLfNn8ltSm1x1mCDsc8zgxusomAi0D2f?=
 =?us-ascii?Q?jKLaCJunB6T5zQjtb3IARS9DRC79lOx2LqMnuAtvacX8ys3+GjH+ldu4fA5E?=
 =?us-ascii?Q?nEG+3n3i9f4WvLqng/EIEwH/8pvsziRrwXpB/EoHIcog5qExS5XeqsjCxrAd?=
 =?us-ascii?Q?/eUpz71va/RsogphrzKSP4o/7bTfjLuZjcmrynmGxZiTwD+RKBwznCNLv28k?=
 =?us-ascii?Q?XG40pNxyjzfDkW1b+S5GcBj831Jw2wod2HEio7tJWCSJ5fTCn0s1wBv+L49r?=
 =?us-ascii?Q?JTFUBL4yv3DDdtPY0YM+bWKCxJvQiGmCAHU4+tgg3ZF55/q23/0BFMa/up4T?=
 =?us-ascii?Q?erABzmMQFN42zZEX1tzxP9ke/AADuYj8ta2c9BNZ+ydcJk9t5pDm+jY2B6sr?=
 =?us-ascii?Q?hlerF8l3z8+3x7tr3Bhy5BszXPFVxqgr6nkaLdfhe9zyXXWCSWD3O98zQhs2?=
 =?us-ascii?Q?yG+PmNzdBcisRye1WeVx0rwMdnMnaD8mUKgrUa8YoN3IbSj+7289Hwopp2lK?=
 =?us-ascii?Q?EyVtgorCtgs0o1R9IkUrtxjuUrNF/x6xYXYiUkgurvF6pVCCounsfkEi/uQe?=
 =?us-ascii?Q?vhDnbGuDH1kNHdXForwpK6da5/IowKZBVV6Dnx4Q52tqH6NuS3ifxtA1aFFE?=
 =?us-ascii?Q?Yi4Lgu9VLYXmgy+48oK/ODTF9ShT+0Y3hMJplzatPjBcs7yK2CCU55+YVAHz?=
 =?us-ascii?Q?t3IZdTv9Bw5ErUAW5HOMsbDYdUKbi2qBPlDUiJ736lRR22B7nb93mBUHcFlb?=
 =?us-ascii?Q?6iZGVw7eBDuPLe9Xys4GzMJaviaSxpOA+E1+ToN7zSWJxyFQt0Txy3YV/8j1?=
 =?us-ascii?Q?xMR0cOPYz3GlkL2XgYefrRK6QSqa6JRg7J8y3VHT0IG1qPcq09SdWSvXqnwk?=
 =?us-ascii?Q?AkFcbS63fh2Hor1Zz8+CGVFn8zoP7+Appimp7SUFm+YG8NeYl52lA4YgWowW?=
 =?us-ascii?Q?jJiZnU7bVsrv8ysORmyUucT2WmroatS9d1uVxZrYzVxdbnB7fgzrmKxiracO?=
 =?us-ascii?Q?UWmapuLn/e+YSxucFr6DUBdtOlQTCMLMRvHsbkIHILHQb7MSVBzHOzoog4Ss?=
 =?us-ascii?Q?UwYlggWMRNFah150uMeTHkyzPBuS0g9MI6t0S+hG+2hJCXE6NW9IaVwOsFma?=
 =?us-ascii?Q?QQAXrhxAj6tfc0nVZt5inw6kQgCzCO9PkVBIkwpcvFvPqL+wL05wp36O2VEC?=
 =?us-ascii?Q?vTFXf0vv5ZCgzxh0D83chz1iASTipcwWr4YsMZ7Pd1vjqq4564YjjspG5Tdg?=
 =?us-ascii?Q?nCOp7OhfIQLSeftqIU1KrOtkrUpHXHuT4M7H/Yz3zbvml9mzwvzG8VYWjgiP?=
 =?us-ascii?Q?IksDl+bG/AT/QlOirqyemZUQPUsykHdE6rrlUCQMJtgzzc63ui8TGMTpe4wa?=
 =?us-ascii?Q?+/mT+wNG1N1KAIEQahLeoA6wOProXkJCETXuslBn1ioWwbvi2KL3DnsqG1gD?=
 =?us-ascii?Q?fYL6mBJv3BFPrrv0/rzffWLKHzQfB85sfVpENR0GEtYfs2dzsLTJuOzgRNOb?=
 =?us-ascii?Q?eh3VSddoIKbydcuIvrU7DIAkDdl3rwldYBf/r8z9ZllsQQT+7GW/Ado/5Vsp?=
 =?us-ascii?Q?7Z0MI2gzvxi+UgXf4k+nTOK7Nvq0pLVGg+9dEt1D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9688abb8-2bca-41d4-1f01-08dc2e38ffa8
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:15:52.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWxV+33ZfuYqvB7TCP8lRG2wBZWiT7FpFZyNWw8EFShTf67ZqmK4iPio4IhhXa/CWFMUOoo2iBS6EGxuljYBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1539

Fix kernel freeze reproduced when probing stmmac devices on kernel 4.19:
Upstream commit 474a31e13a4e9749fb3ee55794d69d0f17ee0998 to fix freeze and
upstream commit 8d72ab119f42f25abb393093472ae0ca275088b6 to apply the fix correctly.


