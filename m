Return-Path: <stable+bounces-83465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FB99A620
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4614BB2809C
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17CE218D91;
	Fri, 11 Oct 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="yuF0OnLW"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2127.outbound.protection.outlook.com [40.107.247.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5F1CCB40
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656194; cv=fail; b=tbzUJwns7iq2Pmtw7i11i9+JQPtQIPgXZJJcdh3IkzESsnPjxiNDoW5GZo7ev6d5j3Dt/eaPdwv7uelnsoWiAOIVS5BGVAZ6scgc05DoRVsrg4FKauJq+twqMvGxx+slm5+QPKifFaPtB3ueXtp+RGQW+Uw1eyfFYqjNcOrpB9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656194; c=relaxed/simple;
	bh=Z2aUj7p2txPQOf4/eU7zMMK2oRrA4RueMG7r0skbVs0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hh8NDG6ba4TLHj6FQJ5/7owO22P740KgfIwVGgH8hwO+GC8RRSkXooY3RRR3oRJDBYLP0L2wOpbTp6MjVZIhwYmxBbkv0qvnJktTNKHjs7MiNAr+8XSVRpkCh/veA+6/chlg8nmpUmudIkUNU0o1mdO6IIbBcCZiUoSUlIy3FT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=yuF0OnLW; arc=fail smtp.client-ip=40.107.247.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebu0EIHynn7JiQ00Xl4ErjvIOfnDHaOh+8ZJSduDlsTFE/yHS6WA4AdnNiBAZfMqAjxnOC5uo9ZyoAudyIk4OOqGECU1uetrlv8lZHNULVyQIYPKJMlhLGNcaoCPS1VOMedL4V5iLwSBx/bPTbYBaqT36ekEdywKvAILFcrofiQLu2vlWWTfWRE6lAG/tPuCLhZxfN9p7TKizh6G2oVPT7pAogiY2AsKHcD1B2cC13QW9Bs+aIqIECLd7ZuRlHWavuQXV6KcWyM5ZTr075vblIuGHfshTbnHjJkJOdWBhlXqoHnETAnpZtONMo0G27o/exdzPFuFzo7zGjqo34atXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMZfW8T37RKBsDXrv1q7B7rN/iHZvHHHREXmKfO6g38=;
 b=KppVwGUzrCyTcP+YRT2YDj7QGQSe1AdGZdPOr4DM77fVW/COaUEMUbSCa9SoB5SJBUpWbuM4S2KVBTSE1IFCtjcmn7Barf90fRE3zj60VjP/qDKgK7JQ9r9y18IXLvNeiq8QIx4wVGU01MhIrRsknggZr0ndxZnDypusIelD+V3xzm9PABW7P6D27modp+HwUgyWLPNkvv3/o6QMDvl5MgrpK3Rgmf/n2At9JSoWfyqed7p8Aq6TNU++FlA8AKCML72zn1ghQAe5pyqQP1P88IsurYMPYOIFOF0YETffpjfUEZJCru388C7prRUd0lC3Eu6lxo+RutOdiRLvg2gZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMZfW8T37RKBsDXrv1q7B7rN/iHZvHHHREXmKfO6g38=;
 b=yuF0OnLW+3XJu/MvfM5ucT7528D2X3VqOGEcoMNYH78A2J78SklJm02f977Q6bnqXSFjbddyfxNngsK1D5W3LJITKpn0eaAUDgr4eKhDV3gN/R0AZnl4gtGHM0kL7r8S1EMl6K7hPlRazFt3lpfmo0pcP/FvPxo10pbDuDx5rz9BHQjd6R2hAuH7cKJSKSAvunx8gIbP6yv+W3yyDtCSAmlpjHJMX8/EzU0djFWOhOn/KbQG4YVLmokToiclbQ4lC6dq0nxp9LAbWzJZGt8p9NGXrAp7bVukNphWPGUKJKYGeX44BEpP8fvSox2mF+k+tUqajYiAAD9/HeWSMjRxMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by PR3P192MB0761.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:16:28 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:16:28 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Alexander Wetzel <alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19] wifi: mac80211: sdata can be NULL during AMPDU start
Date: Fri, 11 Oct 2024 16:16:09 +0200
Message-ID: <20241011141609.50684-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::26) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|PR3P192MB0761:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d60de4-6e26-4c14-995a-08dce9ff4bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8G1Yx+oA33BJ+OKwxQqFYnwlcv2LO6K5YVbluYctJXSUgu5nefPmHB1bPtP?=
 =?us-ascii?Q?7jhvRKhBvVSXwVNk+7JyWeFO/kgr3UNlgjZt3i6gC7nCoo6WpiBuR4We47ll?=
 =?us-ascii?Q?G/y7VQzQ+lLTM7Prec4fh/C96skQSeLl/OodT5D7jl7P9Aq6lmmxM72tSp1E?=
 =?us-ascii?Q?hTqU8ILaJSmg0/oeZ2X2noZ0+G28hOEp/Xrxp/+TWHgaPuwqs75ieIQoOZCM?=
 =?us-ascii?Q?RL8Wp4fNg3L6HKP+rbrMd0VAwkxkNbJAjNll1Qf51U102goUnIWGe+tM6TCA?=
 =?us-ascii?Q?bwrDOAbpnLjLbynnKiCCvgzR5MLIn+hn9gT9BTpigtC7jjW3IjgMl7REuj+B?=
 =?us-ascii?Q?SFxdhz5snn3sdAPThvFtq8ewXcx7ozsdaaMm6bP6AHCD1MauKigt3688ZkDZ?=
 =?us-ascii?Q?qlWW6hMERs/bPT3bl+w5Wymiv2TRA+Vd0C18FMdpRRSFhhZNWdh8gtGK9Qv8?=
 =?us-ascii?Q?nqb9IB0ehJ8oy20DzfzOXr3TI9jYx56liL5sEeZd54OfUmKPSfDznH9uk6IB?=
 =?us-ascii?Q?czuZ/KTAqBrdd8DlsjKzpPTMhLi9RS5KBU+3EGK2JAusWev2yicQtZ7bY+z4?=
 =?us-ascii?Q?K69+y7w5rkjQmXU7/iwb3IHsc82zuZJFj1GMweRkdzGrs8IlVzx0Kc2ea6eI?=
 =?us-ascii?Q?yyakrSgiNE0S1xACQsEOAwuGGF9C8pCtRkzkIZqcLAjAP7PQT1rw7wG/ZnHS?=
 =?us-ascii?Q?ONfHu0f3Of15neH4Er2DHxzYL2InGbTKPKEyLdReZZBATCdz05mM2jDKZ8J1?=
 =?us-ascii?Q?i70TRo2I9IMr3p23v8QXAJnhs7eED6l/zaVgDBClrOJ6po2/oT4EOH0cUaB6?=
 =?us-ascii?Q?6h7MjNQjcp4wbQgpYNs+uzxtC5HjemsZiKDdTfx+N2mVjLAdJCnnSxl8KOD0?=
 =?us-ascii?Q?foI0capAz6sXRcafcgrlP5PwS0syF/Lro/q4MD9IwcU4+YlODUyRfbxilJsL?=
 =?us-ascii?Q?+yYntMhfS3qWZro7P2+A2B1ONHFjOJUxqW8s5E3SsKs+ui47keeL+w5nB9YJ?=
 =?us-ascii?Q?YuupkiXe90wj8bxdCu7yllRUz/FuPbUHA5qjqkD5Jn9Q552LYelkp5hPg3E9?=
 =?us-ascii?Q?3N3uRXFcWXWNc+VlFXvcSLookibLhumWlNR/vGdUp3yKqZSDQ0F/MPrwoxhz?=
 =?us-ascii?Q?03HQETRIyKgGHbo1HHApVMC0QCffEQwJD3TnfSBrCUuEvv1L0ObybFgUhuR9?=
 =?us-ascii?Q?Yp8DRAf7avyoe04S9fRMtXjMdpq+msiRFfOlX25OY2ToTGtxiVT6cvqa2pGW?=
 =?us-ascii?Q?7bilbFA0pID7aDicTNPxIqJWPxItXqBKltAi2EuqF8AOrp+kNhqN5KcCMzV7?=
 =?us-ascii?Q?hAFTzpY+hqYnyLK3STGYAjJSev/ZnTi3bY+YklP5iL0s8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbJQVQSHc7e8LI9Bp011N65e5R/ZiCtBKDHjLsDnaY8mVUr9V+PfXrZqJwJV?=
 =?us-ascii?Q?5gzMuzJc+k3axCervTXYtqhKenZjA1IyVKPN5kge2WO9Bf7Tz785cQZ3QnGW?=
 =?us-ascii?Q?01K6LOo3uYQEMluLsW0gfDo9qAYSK4opxqIAD/osLcwUuzqH6RrmjRMRLoWN?=
 =?us-ascii?Q?y1q+pPFJnd34b5MrJlFnhgxJAinwYkSJ6oNuJyVo8lzbhQCso7NnlnIkI8XL?=
 =?us-ascii?Q?iZfBWfkhbX/SBlDwNaJa416Br/tP+ZgUvUWYzjy5Faj88BV00UxRmACecjdH?=
 =?us-ascii?Q?fQsPv3nnktoF8E3OH/oYvZeUAYGjGEaqSk2WZwx9wcLOezuBlTm6uszjWFXH?=
 =?us-ascii?Q?+m3+jZ8//eHM5IhgivIeBr7qbizRPbaJAkUTJPRK1CQW0pjcOpK1CeXHmg52?=
 =?us-ascii?Q?69j01yRKWYap+RNcqyGhd8oBtkWpNAAuBZrPnlK5jXQbY3+O48G5I4XwHEhw?=
 =?us-ascii?Q?oVbE6Zo4LCs3jv66KGMIDlrpmSWCTI/Naj1e5xVIFX5cSgwrqg0EErrUUsyb?=
 =?us-ascii?Q?XEnN8dU3+tjuGeUeL2+Rl6yH68uya0nwc28LsVOq70RwRVaGnec+lQwUwAbH?=
 =?us-ascii?Q?NYYTHVA5vqsTrF/eZOtXoTb1yGFvwWOVmNjbLA0QEMG0CatyYFgMvemkWrUh?=
 =?us-ascii?Q?1IU815NNDT24m5M/gjP9MmuFje8FJ0pI43cOkJXVyrb8o1MZZS+X1bmuRCpT?=
 =?us-ascii?Q?29fQ1fOW07HyYsgpbRFfeVB6toj81qyt7/x15HI1krV/kFzqiNm1wFdjwGF/?=
 =?us-ascii?Q?rnubuarKESpApWmJRpxt82FrONRnESouR4ZjptFhhGuB6kxqSFxY0dvRakdn?=
 =?us-ascii?Q?RnEoZhOL0R5frvWFEFBTio4vwdM2RLEsat/uLeHlNG7QCTBPCzPc/sntsyoD?=
 =?us-ascii?Q?ZtSqVPQYWbwfNeoK0i+cpUis0MoXByc4pBpMySFWFhAVNJ7DQ2HRSZTgaLwk?=
 =?us-ascii?Q?S+BV4rwR5KNo/a7SKMxi6+tVTng6frNMT++D3LqbuaXt/B+bv94/Pd4vMcOQ?=
 =?us-ascii?Q?uQV0fe5p9L8e4uGQooOt986xuaYGGyKy3kEHnAcF2+HqZgXoRFykq2MN8Aq9?=
 =?us-ascii?Q?+AFBEvd3K1HYQFSGn1pM8HRkB2ZzlKfQK7a/7mAJ5AO3XJr80VE4Dovy2W7k?=
 =?us-ascii?Q?9J2145HfS/1Sdp95r4TyjFWPiMPFas2X7PHR9zXDOWYAGhipxWph2gFQ30nY?=
 =?us-ascii?Q?RrNzKGjzDJg5y+EngjTuuFTTmss15Ztl5deXL6aDxSQRMy0UT7JNRVPb2+Rv?=
 =?us-ascii?Q?Uh8Byrg444E3fLclArKDljiPxDZRESjAqLsTZfcSs90tqJyArNCwttbdTtXS?=
 =?us-ascii?Q?OZjNedj7jpfGw59FkrrFnPdA2RkwNr3uRdJzflVcHBcTGW30PTxD/D7ze77C?=
 =?us-ascii?Q?zmp/8tCkh7Y4YcxPS6Vq7K7JYAcrgolXOAZQSR+H8Ifh1WRrVKVCf1WDm6bn?=
 =?us-ascii?Q?sZS2qFQtHvN9LHO+cie+1eK1zNASGYGgmc7wjIhKGLQP674WHvJSmw1d5rrK?=
 =?us-ascii?Q?ZAoCcXA35jxms9zdoqoTHCXmmgpJKWst8LbJUMSmCwvv5oRDbUXr7+gdbnVh?=
 =?us-ascii?Q?cEHZ4o1TQOtvw2zfG/lChC2m+uVz0falo9FjQXDe7E1yun7uoXSN3qY720cq?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d60de4-6e26-4c14-995a-08dce9ff4bfb
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:16:28.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxPRo8Vrx2IL8kyRlPUYeA4moge4A0gGslVbzLBYDxVFQ50wg/J5iybazR4xeM1+5ruyln4zQH6nz2xfilHsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0761

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
index 79138225e880..43e8c6b0618a 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -455,7 +455,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_ampdu_params params = {
 		.sta = &sta->sta,
 		.action = IEEE80211_AMPDU_TX_START,
@@ -486,9 +486,13 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
+	sdata = sta->sdata;
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	if (ret) {
+		if (!sdata)
+			return;
+
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 9f0f437a09b9..208ee342eb27 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -313,6 +313,9 @@ int drv_ampdu_action(struct ieee80211_local *local,
 
 	might_sleep();
 
+	if (!sdata)
+		return -EIO;
+
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
-- 
2.43.0


