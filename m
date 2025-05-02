Return-Path: <stable+bounces-139508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8FAA789C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8916FD79
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4C1B87E1;
	Fri,  2 May 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZyFy62mU";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZyFy62mU"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C14A32;
	Fri,  2 May 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206646; cv=fail; b=GE4KtIC3GMecU4wcVGRGasPfuOOADJvj7mGLVnPkVS+zMKIWCMZnJD+m06pvqs8AsYisuzNL7Yk6w+g9M6QhAiJV6pQHK27QIDIR0lQ90PcVwM0Qn+1WtTidhFcUUkLb+Nfw9IiziDtxuZmvKgyZYUUi9VWXzfwNGcXsdR9HYYQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206646; c=relaxed/simple;
	bh=IHL3wUOHELbki39nXdqK3KOXiZ2FiX8f/sYCHppdo1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nNvDSLMq/5A1PAxpaqFoENwxiix9HgIXadbiVW9zf3ovGv1QQzBEsbd58ewQuxgnyTJI6IdOQ6poVNHeoRiOXV+JMBF0FH3js6yuGF0wRp9+oXhGi4ocxRicx+Z+QF3lF2yYfDD1i/XS8cDkwSTKmBSBIUocRrveAjdBVeKiX0M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZyFy62mU; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZyFy62mU; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZeFMfWSVUAu19ryXWDN1HQDsVa4ntMLcaKw1GwptiSMRJuy6dsPWWxSoDoawvi300TWeP92zasjJC4RFeMFKz/v+udYa2Ebe0Lne+YPXUMcWFtAaB+mBhwdf+bKuMH5e6owoE2lthW+NVLnGPQ2+R+Y8L50mU3icb6UXQGvtTxQu+kLigHDMCB3yYSsbv1QyL7sYb4Iw0EBBWBxnNdxFl8RaJ1c0f8AYvRNF5i6xlbdPCZyUjnXbEfeNBDXr1VIO2MsPuDhzsaKOTv16Tl8dVwVU2kDjy/ogni/8yzMN4aX3rorjI/0bSJyiB4Axv4vNmoSAl0n6xj0rkhwe2Jy93w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qWSaeOFqcucQkf2NXSth++JDg+kwvhwNDS0cu1+gEk=;
 b=G8nb/WmYuv1SZxgaIhTY+eaNCJr530wAHTJzPoj2SN+1DH9gIy5tDQO5oQU8Gf0ZVKcKbeeQere8G5h/dhJQKp0njNl+q/z0SZeDO/v3U8M+oQhLrH1nToCtVEQ8n+dfJgZZuhcP0lcjgIN/Psh7n8I7eP7pHm3TjW93u6stI8fpprs4u8a/XV4oFWbj/MNRNxizv5wxyhxyYAVwHPaoiZUljswRKGCeQSh9j9TxqspFYD+UfSIz1rjR3jkX7w6nsFmm2MW8dwjoclWAX9Z42DucvXRH0WjweCsRuId0oeKKhdj2FxTRzknVyCHIjo16LwpKiXK8CkYKlGrYAmJ/BA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qWSaeOFqcucQkf2NXSth++JDg+kwvhwNDS0cu1+gEk=;
 b=ZyFy62mUaEZqoVzBsDObNMr0DtEMA0FUu28tpwi7yuWM1fV8HRZojfvyBk6owghsmOtufQHplcbUnQ646Lvncv6cyab5XknHORiEH6QVye+TwTwr5IO9fPzvMcszFaAoPg65BWr686mNLSe7Ah9To3KN7WRQrkGPzoJAuhd3r4s=
Received: from DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) by DU0PR08MB10366.eurprd08.prod.outlook.com
 (2603:10a6:10:40a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 17:23:59 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::5e) by DUZPR01CA0059.outlook.office365.com
 (2603:10a6:10:469::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 17:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.20
 via Frontend Transport; Fri, 2 May 2025 17:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQaPXkytQctD9bVp0k8mVJNQm30FO8I+k9dRW0UMx6gwF9l7KlV5zmklKCibN84JuOMtlFpVrkZBmLOjDNXNznNiiv0KstpfnanWqKhAXfALitoZwzthcenEzoc+4CC5oWRX2+JVgTLAs5vXVQfNEYnMB8iG0hZxn0GohLZulKwriw4qzw+MmVNoW1P3jNqqVeTn2cLa++zCEyoC26FeSztFmwqkqkLR/oL6MZtCt9u065QWlgBBEjkPWgz9xlJmvVH+1cSJW+BOtP5QC7UQYMA/X/nnp+QdCAhG9AcH3qoViMHXMbqsC3/1neryYWy+YphUlFUoImTreFnxRoVnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qWSaeOFqcucQkf2NXSth++JDg+kwvhwNDS0cu1+gEk=;
 b=NYObTwKBHLEdsnxTyQPMwUSyMeyCiDuZNVm7fSfGJwFCBTky8SgaYOLJyMOaAY5ukvD7myeaumnGB3MT8u1NWaMEF8Dj2VpKKRRTiaMwFrJtWK60sVGT6oAZEGAhttABRsJc4uZ3XjxsuHEP0qFaxuiEQIGw//bVPL1kZG5jdPLqx4hgEXhktM7/3a4W3N0kyXaPv1f5aqDkcYVnq8pgkkF5Nlr/A8PIGO52XCjnw04pImuFEZgde/3iNpgPtBJ6WcbxTgmqPvoJXaFJH8BgarytRq7852NFjmtooAPOnrqp8/iJwY5Hk4fVtvqu0mNTt0aWZNhWZUMCDgxjilHreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qWSaeOFqcucQkf2NXSth++JDg+kwvhwNDS0cu1+gEk=;
 b=ZyFy62mUaEZqoVzBsDObNMr0DtEMA0FUu28tpwi7yuWM1fV8HRZojfvyBk6owghsmOtufQHplcbUnQ646Lvncv6cyab5XknHORiEH6QVye+TwTwr5IO9fPzvMcszFaAoPg65BWr686mNLSe7Ah9To3KN7WRQrkGPzoJAuhd3r4s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 17:23:25 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 17:23:25 +0000
Date: Fri, 2 May 2025 18:23:23 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, frederic@kernel.org, joey.gouly@arm.com,
	james.morse@arm.com, hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBT/i/1DmFsU0GUk@e129823.arm.com>
References: <20250502145755.3751405-1-yeoreum.yun@arm.com>
 <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0375.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::20) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|AM9PR08MB6052:EE_|DB5PEPF00014B89:EE_|DU0PR08MB10366:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e7fcc3-dac7-4964-b7fa-08dd899e203c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?PuQnquSbIzc9CIv0JNOMxifYv0DENLkTAdw7bDl4GODwmV1QiZziFy8MdFYj?=
 =?us-ascii?Q?r90Az3h6cRouRezoAl8Yg5YhyjuNsIQIw28L12aQcSOppt9iFeaMT6/c1SoB?=
 =?us-ascii?Q?jis8lEAPV9apocArjkW77woQPNgKJQ0zEZu7pvI3gZPxYKpL2cI5DPAkFvMw?=
 =?us-ascii?Q?mHUhIenRf+rOj3nPdw+8lhP3OpzEDvLcn4fk8vhgeBjC6B8OHBnDOzL53PG7?=
 =?us-ascii?Q?UqXF7cba8Rkk20gphv/HBhvXSylG/q/BKTnGsCZoqq8as2NMBY/iQ3b0cw9w?=
 =?us-ascii?Q?UWLa/O86URdc7myj36ca+C7KjGKipnQ682adN2XdTKpkxZsFSaKNBqhtYUJp?=
 =?us-ascii?Q?CVgnYoMXu8rozEscCbDxjMjH8mZ1lTLk3+vGVpbk23DodbYRi/iUpZbAVNTY?=
 =?us-ascii?Q?wTwm8p1ZuQa+5QMd4+NZXe6uYZ7NnoIiQmn6SHDo0GO5UZSAVBQqbySBAepF?=
 =?us-ascii?Q?EF3jqnI3z4KLyR0AWmR0FPVXamx8rXa/tD04KnD//WZF1VDWSFFCbepBtxuR?=
 =?us-ascii?Q?W+e8pJBZRzwJMb6QqivZRfOM/KlvhHPcOimZkciDCYFqrvFx4DqtxGycQJgs?=
 =?us-ascii?Q?kr7sVOOi3+4otjBp4ZRS3xTdzKzIaAN3e2vglNG3wKd1C9VPWSzTZ2OjrT64?=
 =?us-ascii?Q?s0xp/OWbuZIQYWoLYEOS/PieISJ2g67pwy/mYInTyfFAQVk9vaCiVjJ+vhdt?=
 =?us-ascii?Q?7J6siiDFn/DVhd11TDRmktPklW3OH80+f772rglInRPm0RhwemUMqJSJDKU0?=
 =?us-ascii?Q?h+34HqxmL9zreqhemCY4H8xuKLwhkGxFKzxSq3UMEPP40TtByAZ6VuLPmbCM?=
 =?us-ascii?Q?455AgRE5y6J3lDEl10yMXrDUtKWooHI4ipkBJhWTKipvmn+dn54bn1kOoI51?=
 =?us-ascii?Q?jTgcXxSjQ/J2Q2zVdy33vO5MUXAZQrp74x3sZFWfabhgpt+oHP7CX635YC45?=
 =?us-ascii?Q?StSDmWq1QHXZBozO2MhDxZASOEl8lJAeJnWyqyaWr5l+Wx+oPTK64jVKOr4n?=
 =?us-ascii?Q?DWwKcBsUDlj9QwLHv6j6C+u7lJ65grmwIhtE9sV7N6IMtlkq2GbyCswgm8YD?=
 =?us-ascii?Q?YiG12V1heFKLafypalFrtmtK6VGx48/q4qdArdiya7qNs3FNmJiPl3+RCzFs?=
 =?us-ascii?Q?Jt+n+3fJ2xwYwMcEjJtliWAO6xlGlSzYRwNPGLtN3NpbYQnW7DzVGvOelUuS?=
 =?us-ascii?Q?Eh0RMSBLGPQ/Yw5EqD/5/c6iDweQsno+eJnWE3IgueoHz1nx0B0ruJHt6vpg?=
 =?us-ascii?Q?VABy+h0+MUINVu2SIsrgPWfBgSg+yP6hKNhRMwO16JYJ18svFJkUcwV6GrdE?=
 =?us-ascii?Q?PQ2qKF9uzkmAPsRWKwRwSRjphK8XFfkqNOi0vGQpDrfUcwDce7xqYeCy7UZk?=
 =?us-ascii?Q?ZALe19hzxSThorLQAXnSRI7SNYG8yTX2P6E9r2xuOqrJA/usub1CrAuMiA/8?=
 =?us-ascii?Q?U4IP/Zz4sPM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6052
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a5a33d5-dd4d-4742-a854-08dd899e0be6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|35042699022|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bpqrhYgxkN7T+t1IxdpIkTfxh6l1TDTg1rNHS4Ob7SlkKECFfLizOyX4IxE?=
 =?us-ascii?Q?4aBZaq9oC0TSf42aGyo9xHIv478bTAqEE8n8VbNxIL22SYO1q4h+q0Grs5qU?=
 =?us-ascii?Q?Kzm4GlJXhLzMHpgAJeS5Izkb4ORa7ZuQOYJ088wuWC1pQtTEvIujfs4KH8oX?=
 =?us-ascii?Q?ACv6iSgB1+p7iHuLK3DoYgMGQHwFPuPfRfY0ha4NP4oR0reMvFLNWc3UvvgI?=
 =?us-ascii?Q?JmU0Ut4yito/x0dmXKdN6MU/8kh0pn0N/teQFqC7uJu6CAl6LJqXcvnuUBo4?=
 =?us-ascii?Q?t014AEY14m7nxt90rtzIkleKtXxvxCCw6lbFl24kTaU95efk4qXJ9tSGuuJn?=
 =?us-ascii?Q?xXyCDjToW7nyoWHDVcoCT2qzx13MwpfJA+DrKW24xZ04Po/jbgM4DgV8cFAr?=
 =?us-ascii?Q?wd8beMrtDQThynxfGESQwqhLi8F1NvrmGNUXtxsSteulyleKzJS5LcUGnJBA?=
 =?us-ascii?Q?p2gXbCxN820NDMx6Qncvsw9q5uybtnwP7NeuNN7KEAwEvzb5phJZrpo/PoBo?=
 =?us-ascii?Q?P1hPk0rAf60Ac6IESIbV73WohthXn/8Ab6q4vgUqrhKmyHN+kc9bo/ZtekeB?=
 =?us-ascii?Q?eh3cnYa5YTqL6mUn9U7yiNBGLbAoK0pq+su+8AjnMoYHNm2IN13ADxaS4qPy?=
 =?us-ascii?Q?shog9v9ck6tw+IHu0LPTjc6C1Sd4WScCdtqRyYcml2lWI2eXcdl0RreTDl+Y?=
 =?us-ascii?Q?/+4OFJvESW1S5zffAQh8XLWPWh+MYzio6CK18yLpeWgulLjWjvVG6L/DEgpN?=
 =?us-ascii?Q?f8oRaYpN3iOBxODq6a6mwA0FZG4b02TU5Tnk8qfUpbcoSY5OWQ45xhPXZ9av?=
 =?us-ascii?Q?x++uqEyRcuR3JWe8C+EGGk96Q+56U9dmdOtU7M+1liwH5ZwrZfHvoB9glhWD?=
 =?us-ascii?Q?vw3uNKS6gqDupufaGCzn9XiS3OUUyGbS+4QHGd7xig3vVUcKSheejYOYRntV?=
 =?us-ascii?Q?kFuywVa+6E9WTsXOSyPy1LOr9aVIT6x4HW7iyBfdID0k1h5obJ/AmvTXqXxR?=
 =?us-ascii?Q?6BM42BVGY8BZHcvpqB7Wkokh7Cb1iZJ/892UfR7mClj4LKdAbNhhPM4TTOK0?=
 =?us-ascii?Q?/zwwfpUet3AT19Yt1VZlZ5lX+qqSpCR6UR2NTSDmXm4GGZo5Vb6pWnmiLk2F?=
 =?us-ascii?Q?YCCE2OpPhIDyCVbSU0LaVPI9q2TtxyCUpECMAGPSLJUDFe0NnYn3B/u9k03x?=
 =?us-ascii?Q?9GCFLhd18Eb3mm8Luk80WF2ouhSDyeOhSiIOBUb/PluoV0C9rB4/1EDXC+Ui?=
 =?us-ascii?Q?z9d8W+x81Ij8gTmQQsQfnFfvnT/G+ZaeSCi5Y2u53mP12ily6ackdqRn0uQ3?=
 =?us-ascii?Q?5D9uXmMEgYOCPJ5przan6Vp+NnNyeOBbmXX1M4fvdWeJ6isVC4hZuiGTT0ZC?=
 =?us-ascii?Q?Z0olcWPYmN1EnnY0qMu9ogWEEXLJniqiEgLArkRJIIs4N/k7NUT3M53ZnjEc?=
 =?us-ascii?Q?eT0A+kTXh43Ux1iW13e3n5/Y1r9F0CY9lSvzPerlmyqVpuYruu1GvDEeQxsn?=
 =?us-ascii?Q?qUAtrqZ704ExXCkRLKh5bHi9Ar1WbKLCKF1c?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(35042699022)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:23:59.4155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e7fcc3-dac7-4964-b7fa-08dd899e203c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10366

Hi Ard,

> On Fri, 2 May 2025 at 16:58, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > create_init_idmap() could be called before .bss section initialization
> > which is done in early_map_kernel() since data/test_prot could be set
> > wrong for PTE_MAYBE_NG macro.
> >
> > PTE_MAYBE_NG macro is set according to value of "arm64_use_ng_mappings".
> > and this variable is located in .bss section.
> >
> >    # llvm-objdump-21 --syms vmlinux-gcc | grep arm64_use_ng_mappings
> >      ffff800082f242a8 g O .bss    0000000000000001 arm64_use_ng_mappings
> >
> > If .bss section doesn't initialized, "arm64_use_ng_mappings" would be set
> > with garbage value ant then the text_prot or data_prot could be set
> > with garbgae value.
> >
> > Here is what i saw with kernel compiled via llvm-21
> >
> >   // create_init_idmap()
> >   ffff80008255c058: d10103ff            sub     sp, sp, #0x40
> >   ffff80008255c05c: a9017bfd            stp     x29, x30, [sp, #0x10]
> >   ffff80008255c060: a90257f6            stp     x22, x21, [sp, #0x20]
> >   ffff80008255c064: a9034ff4            stp     x20, x19, [sp, #0x30]
> >   ffff80008255c068: 910043fd            add     x29, sp, #0x10
> >   ffff80008255c06c: 90003fc8            adrp    x8, 0xffff800082d54000
> >   ffff80008255c070: d280e06a            mov     x10, #0x703     // =1795
> >   ffff80008255c074: 91400409            add     x9, x0, #0x1, lsl #12 // =0x1000
> >   ffff80008255c078: 394a4108            ldrb    w8, [x8, #0x290] ------------- (1)
> >   ffff80008255c07c: f2e00d0a            movk    x10, #0x68, lsl #48
> >   ffff80008255c080: f90007e9            str     x9, [sp, #0x8]
> >   ffff80008255c084: aa0103f3            mov     x19, x1
> >   ffff80008255c088: aa0003f4            mov     x20, x0
> >   ffff80008255c08c: 14000000            b       0xffff80008255c08c <__pi_create_init_idmap+0x34>
> >   ffff80008255c090: aa082d56            orr     x22, x10, x8, lsl #11 -------- (2)
> >
>
> Interesting. So Clang just shifts the value of "arm64_use_ng_mappings"
> into bit #11, on the basis that 'bool' is a u8 that can only hold
> values 0 or 1.
>
> It is actually kind of nice that this happened, or we would likely
> have never found out - setting nG inadvertently on the initial ID map
> is not something one would ever notice in practice.
> ...

Yeap. it's a quite nice and funny :D

> >
> > In case of gcc, according to value of arm64_use_ng_mappings (annoated as(3)),
> > it branches to each prot settup code.
> > However this is also problem since it branches according to garbage
> > value too -- idmapping with wrong pgprot.
> >
>
> I think the only way to deal with this in a robust manner is to never
> call C code before clearing BSS. But this would mean clearing BSS
> before setting up the ID map, which means it will run with the caches
> disabled, making it slower and also making it necessary to perform
> cache invalidation afterwards.
>
> Making arm64_use_ng_mappings __ro_after_init seems like a useful
> change by itself, so I am not objecting to that. But we don't solve it
> more fundamentally, please at least add a big fat comment why it is
> important that the variable remains there.

Agree. I'll add the comment on arm64_use_ng_mapping.

Thanks!

--
Sincerely,
Yeoreum Yun

