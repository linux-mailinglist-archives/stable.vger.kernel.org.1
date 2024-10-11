Return-Path: <stable+bounces-83464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67899A61F
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B755286D97
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0F212F10;
	Fri, 11 Oct 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="btemqSX6"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2113.outbound.protection.outlook.com [40.107.22.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E386184
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656174; cv=fail; b=txEsD1JB/9Ek1AhHtwY2Xp5BrE2rOxB7fT0bitYXS1t+FkeILhLRQV5VpVPpFLKguuIxRMxObQMeYJLljxipieOGgRw6gKZ+B29XSrmQSXQFtEqcDq1y+5Xll9dqIyIqmBndEaH5i86tuIG3bZK6KhJq+6B2Koxx451kAeuKaqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656174; c=relaxed/simple;
	bh=jdHq3pJrai1a4sCkqce4MQLoCfIoPcZCTTtcXF1EnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RsPa3M0pl3jZrZZBbCc/aN7Ye7+CQOrxE0msFX4nhdQXe3FpkemRGJzDSCk14UcqySIgdYjTWM7T9D5kr/K+2UDDsD2uwnfpe7h+osOZ9kaARL3bY5FbeiF2/X0LvDOmBnHJ/E5eQBZk7ZwgfCM+5WDGfb7bsHWKqV1BHiHQNYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=btemqSX6; arc=fail smtp.client-ip=40.107.22.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmpvGMY50ow2vl4lW+QdBM7d4Wyp1uCFJ9/UeGB9F0mcUmWxSEd/Ky6qtDhS9M5cgnGByC/YbSUVJL6KixQaUedFqSKcW3CmN06kB+KGo7KOn0T708zce3s7SjekqHeYTsLC3xMPRB8BRa2F7eSdyYSQivsFHIpLcawf65cDcIINUOqKtSgrp3omxbibyNLKswrfJqmJ2XCFw48TQQPznUJ5HDPW4FZP9IUVbPsU3yW04zFrgaLMTfQUXhLdCJEa0AasCiVbYVb7xRv619ptveLMEtOzfUfHKGkNbz7+QkGC4Cdz+msSpxSMHAKpdMMpSmI6THK5yJ3M5CR76aC8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FEewRk9FXJDryEzOzR55WTLysg2YbmmSDoLR46NAQE=;
 b=SqJ+NoVPkK4XFHVr2WvHTs8cC9is+qXBbqcT91S3yMlCHpmTVg9pyAUbzZnYoTZRA1USyinux9TYWBlgeqj8KUuDTvYN2v+lXPF6LYPa6utsj927JVbqEzlorXDrV9aSjAcBAfZO1hHwLWyWGUSZ+Qt/GAuIVVE22YEKstZqoygDo2yk+R2eUqead14UaAl9NlJ2wMze5Q3vYUStV5uq8UawujjjUOxeY+YwTq2h47y2BbCxJhrKR4rSBMsa+4ygc6I869Mm+IXpnxDLBQHQC+Wot0K20ghRAYI8urDLlSkSxTHaBEv50IxxqrTjQwLJGo8CuN6hF+bYPwerr3CugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FEewRk9FXJDryEzOzR55WTLysg2YbmmSDoLR46NAQE=;
 b=btemqSX6NGTFQ2aXCpXk8bZBDIuNHs7RLSMZoFgnxncSAIDmO07t2fj2Jx2Raa9oU+c/2L09bksysJK2hVEAHN7Dmg3xguKF5mdxGyzjZoGO0PYuNp5MudsbEJS6ElD9P85QdvEGUO+UhGbKStRUb95YtZoym+ssbdqhtVG5yiqj5K4JOhBUsHl6pWfbqyRa2dBNYPPcG7+SH4zDC7wIuFsUDliHO0T6ZM3qjxRAIoPm/qzEcCo2koEARlVZA17iohEEHIVAWKLXH4LckchJ/5jQDvKlNAU+OEtjRL/QwjtMVzVv1BQ6bT9B7M9ib20q6EUdhlm5Q6IwZFDaBnsHXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB8P192MB0647.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:163::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:16:07 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:16:07 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Alexander Wetzel <alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 5.4] wifi: mac80211: sdata can be NULL during AMPDU start
Date: Fri, 11 Oct 2024 16:15:46 +0200
Message-ID: <20241011141546.50661-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::27) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB8P192MB0647:EE_
X-MS-Office365-Filtering-Correlation-Id: 920d48f5-43db-4da0-3307-08dce9ff3f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wh1vlQgfbSLqgOFGmtJ8a1pRj59TCdup5iwgXGN4jc7BHSHs0lSji1UaLHI/?=
 =?us-ascii?Q?urhPTEdPwv6wE14T0kj3UGn9G8aRXC1uzwmEmsEoDbGzysS1NLlWUS+4Y6eY?=
 =?us-ascii?Q?lRzIp10v4gyZIYehMKngmpnfrF0ubBAfWOxNRKFJAOg5l7yuf/8nnsdj/gqA?=
 =?us-ascii?Q?rC2JPK9Ld6D9FxzjGBQdv76f34twznUlB7HVUbyjEiswHwl/hXsxebAr8wik?=
 =?us-ascii?Q?clFbwSaD1qTzviUCPZOaDxkmU6r9ac3duqAWone0cylzhd4BejJtBWtIrRn7?=
 =?us-ascii?Q?7UyiXtjDFidmigZ89q7T1+rHd8tNar/0MeG1hedYfVjS0g79rsZVzGDVlXbu?=
 =?us-ascii?Q?Uik8GGA5GkJLfaLyT7VQkeR5mgSWQ0ca+Rx39OqkaOWQOBacKS3xFgHLhGfd?=
 =?us-ascii?Q?zCVVx+cJkAbdMZhQ73EcgwTrHz2aVk3EdZ9c++Wo/0SfNq/lXglVWfflrYc9?=
 =?us-ascii?Q?FFQNursOaUtCjj4WV9cjWBdRvyiAyKUkcqRQq/Brs75oZwMUHYEE1yEiK5mr?=
 =?us-ascii?Q?pTaSzc2V4bkOXwdpmJyuifnTu3I0L0b7f8zwGFy9eYmcdRXYbJbrNguQzW2g?=
 =?us-ascii?Q?/rXtUMiTHXrFjslEN71mtsozrjSBmOAOJ7ErGmJjOiwJwZRUNakRbN9h6uL2?=
 =?us-ascii?Q?HwFZIrdTInaOHjT6G7EW+ibiI8PoE4NnWmgEJ9RvYQbngBIgCb5VfwI0yUtf?=
 =?us-ascii?Q?CUvIpEABb+sjQjxMmhVswM9bFU0NeSVmgq8tLzff7SM8EFPJ0EbHT16zRvBS?=
 =?us-ascii?Q?eb7R1E8MAz8QQZiVrm/MchG/ZaooSBoRqzOuIAy7a7fxP8VxdKcYGuN305Cu?=
 =?us-ascii?Q?WFSTnnI8jbkddc7BeueC78kTuluzzmr2diQnfbUKXHZewGMOsumPgfsEmci1?=
 =?us-ascii?Q?QY+HGPa2jI10eEm55yw7fxKUX1JNwRYr+epm+9m6rgjcFQsVzN4wr+U5aiwb?=
 =?us-ascii?Q?0nv8+lyeUmpUlh1qnsn+ouZkq75WIw/GhXVY+rmi6WArdlZHAtgwyO9o5OPg?=
 =?us-ascii?Q?WssFSrl6KzePuspLwLIkFjpYH4IAkz4VNlR1+XUB6zcU1yuydASEubAA6qB5?=
 =?us-ascii?Q?4xQpKkfoxhihRiFAVv0cN+8h9pigmdIdjWawV/gKT/dDFv8rwPPZrFGSWUig?=
 =?us-ascii?Q?sinNnqNOBZajPklmiu2cRV/uM1469xsnAeNSUIySd43EC7GQsam1hEoEkv0N?=
 =?us-ascii?Q?rFg0UvaFWPjLUoqoo8OF+coFJA/S1jHpBhWR8Fbg46kJH2w6xFTk4dPwjJQV?=
 =?us-ascii?Q?V4yQHn084z7lPMxmmB4GU36+KsWWcR+NThtDWVsZRWDlfhHzL4mDspm9/orV?=
 =?us-ascii?Q?2fwaDUYSuaheN3xB5niOz/D4kiNDUImk8U5+6P2J/7kFMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVrZcQjK/48BQ7nUEziojRwLFe9QXW0WBm0xAacuVHPtSlI3CGyWysyp4Lf4?=
 =?us-ascii?Q?In6/NzU8RZfYDkl/qUrpfbgKM8zGZvpuK0WCTGDXgA4P8He/A3Lc3xImq2gl?=
 =?us-ascii?Q?G5G4gMtDUprLMk6OyUlb83gD7KVAzQ9ppQWtW3zKaj4GBLS4PKFegLndXt5u?=
 =?us-ascii?Q?HbQ8A2kvKVnats2mp9J9Ek6FMJ2To8vrohZCEBuV8xcg9QErDVVXUXILRzGN?=
 =?us-ascii?Q?ZTXH03WUe4ZxFvAn4y36YjS2cfgc2D+AkZHRoLQcfKS1m6ZEeM2nTkxCITKi?=
 =?us-ascii?Q?hGO5uOPxVRpWtBCrOCulcitzgpWeG1QMnKFBBC+ESf4ThV9Q5eKnTRlISWTC?=
 =?us-ascii?Q?u4ExBYZKqLVxfYSfOr6qkucAM1W3fO9j6wZ3iUIYGVrT7rMLa52e9AcrgArX?=
 =?us-ascii?Q?jgUrmCIcvuYX52cCp0FkyMem4S1/DkK/geMxqBcq2rPv8iie9YmQ4uibfXpC?=
 =?us-ascii?Q?DzG90tkwGtMWj15ub9dVemfRAtYNYGWJt8VxY6UuFXQwyrBOjq8aTyT0T0Mh?=
 =?us-ascii?Q?UuNMnvuJHFs2pa9UlEi9mF3kKsMZJoTVUQh1Ar6CbPdx+J50RZpY3ig9Edkm?=
 =?us-ascii?Q?kAgRF2lU5nWq5mE5ScANFzbB3P44gxvIWG1gv4Oyjrj3NctoH6zFkcxiWcJo?=
 =?us-ascii?Q?dwRei9L1ttrQSbMsoDXB5x9iesCO5RWNMeWzQjsCfWqROnB51jq95NOX+FfG?=
 =?us-ascii?Q?Bbpmy/15eaefqYm0TRQCVX3Frj0VGxLuGafY67VWhWAa8fDuxb0BpfEdQo/v?=
 =?us-ascii?Q?hC0qBdOLGGV4pW7kjd3AoNz1VmoraX8kRcRUnGAzP4KE1N9IH/roE0HUTVz4?=
 =?us-ascii?Q?r00E7nwKdKV9p97gMsfHvmlxJVABh/1GWKjsHgHZfpOXZZe718JbrkEkoiGC?=
 =?us-ascii?Q?AjJ9AgpTBmpmKHNGfY4S2OxCSTn/2e2eHCGYCZH9wPqTEwvYvHVyWcoY5oU1?=
 =?us-ascii?Q?VK7ZmeWTn3odqXNGHB4gI0Laoy+cY0xO4dUaqklm9w9MYF0YQknJqPBZRqS6?=
 =?us-ascii?Q?MlcoiHIx6QHdtBVCFCNxthMAtxqaZos2u1epKQB99f5VUhMB26OQvATOM/f2?=
 =?us-ascii?Q?6WVId8YrPoT+DytO0um/BMQ6AeXWfrEl9+C2rZqiR6h2shgqRni0JpWN0KG8?=
 =?us-ascii?Q?jvxMvBhvx9AfVEV3N+WB0R9jmpWC7ldT1RoMXokmIbgyOSUsByySO3+52Dz4?=
 =?us-ascii?Q?hVTdUZxfbUbbUnoRyyUtMTmTQednVA3cr/j2+tQ4V4kREWf3x43W7xwfw/ad?=
 =?us-ascii?Q?Nd1ADdqWt4tgXWONezOZAgbQNEWSSeoKHg+d0gGTuGxCuTkbRyHpx4YW7l8k?=
 =?us-ascii?Q?7XAwLHyt1htimudURegTu8LrVgB7Bh5DiyY5g/5aVD5DXOYanO3p/k9cpI6w?=
 =?us-ascii?Q?4Nta2nllLV5UrfJGYmEuXvD4oRKutp+WBEVW2E1itmQOnXlJyxL8XDULQ8Rn?=
 =?us-ascii?Q?ukbE84w9v2RT6RiJpkam7i58Lv6+CU1wnV4rk/+yLPJEdTrNVXAelHlZO+PT?=
 =?us-ascii?Q?aNeGPr/ynTeG5OoC0/mBa/snF9QdNbpEzzBeq5G7PCvBb4JevEMkZ9uKCJwg?=
 =?us-ascii?Q?HEJv4Yv16ASjllxlphIgbbBDQTZxUsC12vqZnjbkybs60pWtydbRDxW+EyFj?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920d48f5-43db-4da0-3307-08dce9ff3f60
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:16:07.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLjPBKEJBnPLd+VEtriFyge7iuvXQFLL7p6YN5+jQP4WmFszaDqicYKRyf/Pv/QC3Ef4fLRicRzNiQn0eiHuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P192MB0647

From: Alexander Wetzel <alexander@wetzel-home.de>

commit 69403bad97aa0162e3d7911b27e25abe774093df upstream.

ieee80211_tx_ba_session_handle_start() may get NULL for sdata when a
deauthentication is ongoing.

Here a trace triggering the race with the hostapd test
multi_ap_fronthaul_on_ap:

(gdb) list *drv_ampdu_action+0x46
0x8b16 is in drv_ampdu_action (net/mac80211/driver-ops.c:396).
391             int ret = -EOPNOTSUPP;
392
393             might_sleep();
394
395             sdata = get_bss_sdata(sdata);
396             if (!check_sdata_in_driver(sdata))
397                     return -EIO;
398
399             trace_drv_ampdu_action(local, sdata, params);
400

wlan0: moving STA 02:00:00:00:03:00 to state 3
wlan0: associated
wlan0: deauthenticating from 02:00:00:00:03:00 by local choice (Reason: 3=DEAUTH_LEAVING)
wlan3.sta1: Open BA session requested for 02:00:00:00:00:00 tid 0
wlan3.sta1: dropped frame to 02:00:00:00:00:00 (unauthorized port)
wlan0: moving STA 02:00:00:00:03:00 to state 2
wlan0: moving STA 02:00:00:00:03:00 to state 1
wlan0: Removed STA 02:00:00:00:03:00
wlan0: Destroyed STA 02:00:00:00:03:00
BUG: unable to handle page fault for address: fffffffffffffb48
PGD 11814067 P4D 11814067 PUD 11816067 PMD 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 2 PID: 133397 Comm: kworker/u16:1 Tainted: G        W          6.1.0-rc8-wt+ #59
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
Workqueue: phy3 ieee80211_ba_session_work [mac80211]
RIP: 0010:drv_ampdu_action+0x46/0x280 [mac80211]
Code: 53 48 89 f3 be 89 01 00 00 e8 d6 43 bf ef e8 21 46 81 f0 83 bb a0 1b 00 00 04 75 0e 48 8b 9b 28 0d 00 00 48 81 eb 10 0e 00 00 <8b> 93 58 09 00 00 f6 c2 20 0f 84 3b 01 00 00 8b 05 dd 1c 0f 00 85
RSP: 0018:ffffc900025ebd20 EFLAGS: 00010287
RAX: 0000000000000000 RBX: fffffffffffff1f0 RCX: ffff888102228240
RDX: 0000000080000000 RSI: ffffffff918c5de0 RDI: ffff888102228b40
RBP: ffffc900025ebd40 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888118c18ec0
R13: 0000000000000000 R14: ffffc900025ebd60 R15: ffff888018b7efb8
FS:  0000000000000000(0000) GS:ffff88817a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffb48 CR3: 0000000105228006 CR4: 0000000000170ee0
Call Trace:
 <TASK>
 ieee80211_tx_ba_session_handle_start+0xd0/0x190 [mac80211]
 ieee80211_ba_session_work+0xff/0x2e0 [mac80211]
 process_one_work+0x29f/0x620
 worker_thread+0x4d/0x3d0
 ? process_one_work+0x620/0x620
 kthread+0xfb/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
Link: https://lore.kernel.org/r/20221230121850.218810-2-alexander@wetzel-home.de
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 net/mac80211/agg-tx.c     | 6 +++++-
 net/mac80211/driver-ops.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index f30cdd7f3a73..52712a47463e 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -489,7 +489,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_ampdu_params params = {
 		.sta = &sta->sta,
 		.action = IEEE80211_AMPDU_TX_START,
@@ -519,10 +519,14 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
+	sdata = sta->sdata;
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	tid_tx->ssn = params.ssn;
 	if (ret) {
+		if (!sdata)
+			return;
+
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 48322e45e7dd..120bd9cdf7df 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -331,6 +331,9 @@ int drv_ampdu_action(struct ieee80211_local *local,
 
 	might_sleep();
 
+	if (!sdata)
+		return -EIO;
+
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
-- 
2.43.0


