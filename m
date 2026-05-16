Return-Path: <stable+bounces-248978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF7CMkE3CGoHegMAu9opvQ
	(envelope-from <stable+bounces-248978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932155AE73
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4307D30087F9
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD53AF64B;
	Sat, 16 May 2026 09:22:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020128.outbound.protection.outlook.com [52.101.69.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FB295DAC;
	Sat, 16 May 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923326; cv=fail; b=aZUBA8/dOF2+NmFTvLDadvVuQowYYnfWpX1HLkkKTAqlspq/t4XSIDLqWkttfT0w4R0lTkmeRgx02W22nFIKXPql35ziH11E6+MMSGTKBMXBtMjBMjveKnEAw5VvtFr346TUcSFj9tQzmxxfp3MAkxQqmxVWtl49JSDmunQazWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923326; c=relaxed/simple;
	bh=AZIb7kZtJhvRBX9VRkN6FpZEiDyuczpmxezA9nWKtMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZpszzbPGPCbUsgaUI+Up4nFasbLCHpFJ7QoSbCkGHs1RV2w79ctmPQyWIaLf7tDXYVXCGDdEVqw/cTK17e97gFijdXSGmj6doXXGpmZBgiQvr4h4hzuPnbBZGpDWGvYCxRlYPtJBK5p8eNtHH3HFotp0C91drb9/Ij2YmWRgCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunnix.com; spf=pass smtp.mailfrom=secunnix.com; arc=fail smtp.client-ip=52.101.69.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunnix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunnix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep2ebGKfU7cHj+c71yH0l12qmrKXpXj1fG97gMRV65JTVYYHMrkLbBG/J5b2m3Hw9W0mmM4OhhT+F1nWxrwyTvFj2OEMwfbcAq6CAV1vmGs136/J3kG5f2JTnCsANP+x53FtS9fETXa5FWRj+M6zkEkcwJnrI/+haN29QqItFLkzQ4Wh/0ctXnZNRfKDMJxeJIJXPEiJA2KDRyaxIFGBZrg/SoUr7mHdBjK8UJjyMaIoI8oIXwrrdEtYsz8kqVuvcu+yB6ykO2JBj14Y++Q7e/bDuLNj9m87nCjr5dvJnrlSNbw1Qre8CEHJ5jzZ40u5NQotMEzNzaV8XRVetbflgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVyx9JCtEgdUFC49tWymnNuD3uAm0Rhh/HMWpka3YUs=;
 b=C+DTidn4BuXJYscQn7LbzuRQjz/mzSqJolPH1DIiGAgpHyQqSAB89xdw5Cc+SvQHLQGcOGDmVJT6HKhxApjeT4r7vxjBFsYvbjq1ja30wJbc0DbRIxZAYOB2IK62X3eD3/yVH34dnncZgBwxTwojtd+TqNZ12ynIVYoQaErRzFm4jV9OB75VbxYT1zP+UTmcoyXg+JLMugyK2v0+V+WS8CR08ce7Sk+S+Qllzuu9A9ufxEgvbu7Frb3L9P8lg0pqwzKXk1FS0rV+PuKD1+mlhIxqNgM1/Rdc/U856d+dZTqgbMkjRfbizj/TjGnCxIuj8aTqBf3WSshDVoGBUH3HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=secunnix.com; dmarc=pass action=none header.from=secunnix.com;
 dkim=pass header.d=secunnix.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=secunnix.com;
Received: from AS8P250MB0791.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:570::14)
 by VI6PPF0B291967C.EURP250.PROD.OUTLOOK.COM (2603:10a6:808:1::245) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Sat, 16 May
 2026 09:22:00 +0000
Received: from AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 ([fe80::8627:43f7:324e:6aa1]) by AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 ([fe80::8627:43f7:324e:6aa1%6]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 09:22:00 +0000
From: =?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>
Subject: [PATCH v3] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
Date: Sat, 16 May 2026 12:21:39 +0300
Message-Id: <20260516092139.2618159-1-safa.karakus@secunnix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZL4P1HkA_FMFkBu0Ou-qi1a6Atv3ae-U32r2U1JgkOe1A@mail.gmail.com>
References: <CABBYNZL4P1HkA_FMFkBu0Ou-qi1a6Atv3ae-U32r2U1JgkOe1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:570::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0791:EE_|VI6PPF0B291967C:EE_
X-MS-Office365-Filtering-Correlation-Id: 939e1759-0bca-4b84-0f76-08deb32c9569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	l8/z/7c1d95k7frlJN70LHiYN0tNDWYgUmmyJX6VligHOGSWrO5Yzx0fgRxgiAnOnBCI1YD6JZHcetL7eBLjttnl910Q03/S3qSGzxLPZcYHWhLTN1G2tc/A1PxSfSvZK/iG4/9uPXyNywcCXmyC2xrw6DJPje5JPrLvNw3/U6dqh3uRVel26lc31V3znvUAQMkIvgniGM+ExLnUDT0hrwQgUgi5jzyjSNBoOW70gKM64mtaw1UYvUo7AwbJmzjVmr3xg549LCkqU6JP02zs8xEFFQGS6biwF0gjxSP/nqqWolEvEdPQtXvCN6KcDaSpE2qBfpAw7CxJOPs0O+bhTcH+152wpenfhj3r26+fojULHvouGlPaU4Z+uauSUw8KPil2zPchfUW7b5yrSymE7amdlAHtRJtwvFVQdbt0+i1826wJkrbGJg3ang7bBFC6jpxAva76sa82Gaw6nh+35AWfWksIOMbV20GyNDFP/WBPGJS3LlSLPeiUZMtDzVHMop3+1gyMSm2xs4NnU440TaxzhKTyUyQpGIfJuNTvVT5VXnnigSe/FCh8P02MPRBHK0p67Vtq+7f1kI5sZMd2Fjh+rnZ8Z0W4ILtBUEvmyqYHUiTuPz83/Ys2blYa0hyKKXjOsOHZoZ1NihEP9L5XRZbCu/5fUaAFNw8u9v0bVd+NS4j7sSjpcvKqwH+6533wZc1uV7bMqH7g+IdqPDp1dp0xOtQxXAVR8zO27wUKkHbO/s0UBeYOb8GnkoEDCJ6G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P250MB0791.EURP250.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhkMjNFYzJrN2tjMXNRNFg2VGdycW9tMkFLLzI5alZKSkhwRm1aSlUzR2Jw?=
 =?utf-8?B?UERIdkg1d0pOaE9kdUdHN2ZxdmM2d3lYT0hjMVVHSXYvdlNrcmtJZ0huNGhX?=
 =?utf-8?B?NGEyWkoreVg5TXVyN1F4ZGlKRERRaVRYeElTaWkzNUp0bFFlcGViN3U0UnM2?=
 =?utf-8?B?ZUlJZWdqTmlxUDMrNndlcVF2M2xFenlEWktnWS9FNkFaWTdwNnlRRjhDVGNX?=
 =?utf-8?B?N3N4ZXdKdStUUFJDZFNIT3BZM3g3bHpaclk0N2M1NFNQcTU3ZGsycURBaG1B?=
 =?utf-8?B?MlNobG1iMUw4S2ZmbnZhVlduL1A0a0pqV09YY2Zlc2YrQ3UvZm1jNm9BeS9I?=
 =?utf-8?B?U2lqTTFMcWhrMlg2aDhhOXBQYXV0cjZqejBtK2VzYjlNUjF4NjFmWVBTQnRU?=
 =?utf-8?B?bHRuSEVXeVV3RjQvM1Z1YktidjNCc2E4TERMcDEyTXFDTVFzd25CdzRVYkdh?=
 =?utf-8?B?bzRkYWdGT1dXSmlIVTFVaU9ZNzNaZnRSMnlFZC9EbVZIR3ZDSTZsUlZJYUxV?=
 =?utf-8?B?UTQxU3RNb0xZRU01OVovWFNuVVVGYk4rU3FabjVmZ2NhMnJ4SlhjZWc5SlJG?=
 =?utf-8?B?NjNiWWZUOWlNVmJLZjNrSVcwVnBXUG03TW9pYTJ5M0JCSmhmNGpnNlQ1THpS?=
 =?utf-8?B?dERMdEtucXprcGl1UW5XOTNOMHVGMDRrTTVMR0hKNzFzTFVpMWU5UE41T25z?=
 =?utf-8?B?WkZSTGtkSklmazFvVFpoekt3TklLdStWYVZSSGVaY0c4Y1BYNTV2ZTVTMy8r?=
 =?utf-8?B?MnFYV2p3S3piNllUYytkVWFDdVZHK2MzWERCckEyczNHSmZTS1M5SDRRcldn?=
 =?utf-8?B?R2F3YjIza0cxMmJsZm93SkRKSUdiTkRhUUNMdCtXaGUwbTNxcjg0a25QSHV6?=
 =?utf-8?B?djdOREdYREZ1d1NDUUxZclQ4bXl5U2RNSFFoTmhnczJkSW1YMm56dHRlbGJP?=
 =?utf-8?B?WFBCQlFtMm56VGFQeUNzZVdjWXJPUUlOcTZjRjkvejh0L29hRm9SaUdhSmNX?=
 =?utf-8?B?amRrelZPUlFqU1VxREJ0LzB6QWdWOXN3cEdMWENOWVZXT2lORWZRNnFDR0Fy?=
 =?utf-8?B?WkU1US9BdTZyUFljaFdXd3ZZeDlEZ3BRczVKZ25HMnJFZnROTGlOc2xWYXZC?=
 =?utf-8?B?N2pIbTRrM044RkQwYnZCL1NIbng2NUhXWGpjQ0REeW9aQkx6SzNKbmN5MGMv?=
 =?utf-8?B?elpxK0QxSXoyZkZ6UTB5VktMMnlVOHovMGVrSkdMUFlaRmdzcCtoT1VhbnVw?=
 =?utf-8?B?SklzODdSUTB0UDRobGI4M0dSZ0ZENHVHUEZ4VUFpaFBuOVhvVXpza1pGVnU1?=
 =?utf-8?B?WnFhOVJxSnJGcGI5VnhOcExDSjRtZHZUam5HSnlFa3lNeXlkd2pML3BocmNi?=
 =?utf-8?B?R3pCQkFQSFk5T1JNUnQ3d0l5dTgwUEdhczlhdW14Mm1KQ1NqcWFiVDlJNWdw?=
 =?utf-8?B?QTBZRmtxdTI3bFpaVmhFeWFwc2xhV2FESjQ2T3llNFROOHY2QTRhTCtpc3VE?=
 =?utf-8?B?N29rREFFVm5QRkFSSjAzYTRaN2g5aG4xcUNFU0xWRjk1ckxFNGdIOVRWSVNq?=
 =?utf-8?B?dlU4bXEvWWxseEFCK05VN2NZSC9xVlpCdExsMS9GYVdJdWdWYnJaZ3hYMm1n?=
 =?utf-8?B?ajlEdkJUYkpES1VNVENIbzJtc2U1L1NSSWgzWlMxUUlnZTZwU1J3OWY1VmtT?=
 =?utf-8?B?SFB1cTE2VjN5alMvOXJRMlhIWm50dFlFUGN5WllFemF4cGJBSzh1YkxWQXl5?=
 =?utf-8?B?WEV5bjNGblg5cThUMVpvNUlNNmxXam1LUW5vazdDdUJSYlNUaFFyeW4ram8v?=
 =?utf-8?B?bk41aGhpa0Eva2tvcWoyeFcyREdvU3A2RWtRMEFUUklZZFVBNzBUaCtjMU80?=
 =?utf-8?B?RGpnMU40RE10cUFSRllBUllpaVk5WTI3eXZoODRRdUtEb3RidG5WK3J3YTNu?=
 =?utf-8?B?SWpoRlQ5Y1pWRmVPWXp0WndvSVZSb01FRkpUMlVwK1gxTWJ4Nk11WG9Ob0Mw?=
 =?utf-8?B?blZUVG9DZUl1bmVueHcrejlUV3pxaXlrZTdoeUdvRjJWZVQwRjRsM1FMSmZJ?=
 =?utf-8?B?TEozUldhcUFvUW1SRVBudEhnT0xyUWRIQUpyTVZvam9KbTVwSHFNTzZBYXFY?=
 =?utf-8?B?ZndoZ2xZNmRiUzFVbVlWV0Q4NmNIdzZoVEVidVVlbHJJazN1OVpnbEVhd2Uv?=
 =?utf-8?B?aFN1dk8zc1Nock5kTDZESHhHWTNRVlRLUkdVdFJ5ZWN6M0xhN2FDaG54WXFm?=
 =?utf-8?B?YUN0Tjk2UGN1N1FxSjJiNmQrakg0dDVGblFvQUFGd1RJdmJISWk3Mlo1SXlO?=
 =?utf-8?B?WUxZNXltWnZFTlBMQTIwUFhoQmh2cEkxM0tadjhYMzRLeWdYQjkwNjlMZDZK?=
 =?utf-8?Q?7kY82iDRGfA/R0r8=3D?=
X-OriginatorOrg: secunnix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939e1759-0bca-4b84-0f76-08deb32c9569
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 09:22:00.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2eefc8bf-b417-4556-be78-a3aa096a840e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onUI/HMDIyL+t6Ehe7Q+Adrqei+faqFHdQpaGadwR4Rbx+m/raWlNm/uYEVuKpX7iJkKKdKBZTZk+Sre1QbXlVBfB7Jvj1MxvcotFR6b9mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF0B291967C
X-Rspamd-Queue-Id: 6932155AE73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[secunnix.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248978-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,secunnix.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safa.karakus@secunnix.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
accept queue and release_sock()s it before returning, so the returned
sk has no caller reference and is unlocked.

l2cap_sock_cleanup_listen() walks these children on listening-socket
close.  A concurrent HCI disconnect drives hci_rx_work ->
l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
frees the child sk and its l2cap_chan; cleanup_listen() then uses both:

  BUG: KASAN: slab-use-after-free in l2cap_sock_kill
    l2cap_sock_kill / l2cap_sock_cleanup_listen / __x64_sys_close
  Freed by: l2cap_conn_del -> l2cap_sock_close_cb -> l2cap_sock_kill

CVE-2025-39860 only serialised the two userspace threads racing
bt_accept_dequeue() (cleanup_listen() under lock_sock() in
l2cap_sock_release()); it does not cover l2cap_conn_del() from
hci_rx_work, so this still reproduces on v7.0-rc5.

Take the reference at the source: bt_accept_dequeue() does sock_hold()
while sk is still locked, before release_sock(); callers sock_put().
cleanup_listen() pins the chan with l2cap_chan_hold_unless_zero() under
a brief child sk lock (serialising vs l2cap_sock_teardown_cb()), drops
it before l2cap_chan_lock(), and skips a duplicate l2cap_sock_kill() on
SOCK_DEAD.  conn->lock is not taken here: cleanup_listen() runs under
the parent sk lock and that would invert
conn->lock -> chan->lock -> sk_lock (lockdep).

KASAN/SMP: 12 use-after-free per run before, 0 and no lockdep over
1400+ raced iterations after.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Safa Karakuş <safa.karakus@secunnix.com>
---
Hi Luiz,

v3 - addresses the sashiko findings on v1.  An interim approach using
conn->lock closed the UAF but hit a lockdep inversion, so this pins the
chan via a brief child sk lock instead.

Changes since v2:
 - Take the ref inside bt_accept_dequeue() (v1/v2 added sock_hold()
   after it, racing the free); also fix the chan lifetime; no
   conn->lock (lockdep).  Reproduced on v7.0-rc5 post CVE-2025-39860:
   12 UAF/run -> 0.
Changes since v1: consistent From/Signed-off-by.

 net/bluetooth/af_bluetooth.c | 10 +++++++
 net/bluetooth/iso.c          |  9 ++++++-
 net/bluetooth/l2cap_sock.c   | 51 +++++++++++++++++++++++++++++++-----
 net/bluetooth/rfcomm/sock.c  |  9 ++++++-
 net/bluetooth/sco.c          |  9 ++++++-
 5 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 2b94e2077..10eafe7c1 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -309,6 +309,16 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
+			/* Hand the caller a reference taken while sk is still
+			 * locked.  bt_accept_unlink() just dropped the
+			 * accept-queue reference; without this hold a
+			 * concurrent teardown (e.g. l2cap_conn_del() ->
+			 * l2cap_sock_kill()) could free sk between
+			 * release_sock() and the caller using it.  Every
+			 * caller drops this with sock_put() when done.
+			 */
+			sock_hold(sk);
+
 			release_sock(sk);
 			return sk;
 		}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..94732563d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -759,6 +759,8 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		iso_sock_close(sk);
 		iso_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	/* If listening socket has a hcon, properly disconnect it */
@@ -1364,8 +1366,13 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45..61f2b20a7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -349,8 +349,13 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
@@ -1475,22 +1480,54 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	BT_DBG("parent %p state %s", parent,
 	       state_to_string(parent->sk_state));
 
-	/* Close not yet accepted channels */
+	/* Close not yet accepted channels.
+	 *
+	 * bt_accept_dequeue() now returns sk with an extra reference held
+	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * -> l2cap_sock_kill() cannot free sk under us.
+	 *
+	 * cleanup_listen() runs under the parent sk lock, so unlike
+	 * l2cap_sock_shutdown() we must NOT take conn->lock here: that would
+	 * establish sk_lock -> conn->lock and invert the established
+	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
+	 *
+	 * Instead, briefly take the child sk lock to fetch and pin its chan.
+	 * l2cap_conn_del() reaches the chan free only via
+	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
+	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
+	 * therefore guarantees the chan cannot be freed while we read and
+	 * pin it (hold_unless_zero() additionally skips a chan already past
+	 * its last reference).  We then drop the sk lock before taking
+	 * chan->lock, so sk and chan locks are never held together.
+	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		struct l2cap_chan *chan;
+
+		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
+		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		release_sock(sk);
+		if (!chan) {
+			/* l2cap_conn_del() already tearing this child down */
+			sock_put(sk);
+			continue;
+		}
 
 		BT_DBG("child chan %p state %s", chan,
 		       state_to_string(chan->state));
 
-		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
-
 		__clear_chan_timer(chan);
 		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_sock_kill(sk);
-
+		/* l2cap_conn_del() may already have killed this socket
+		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
+		 * double sock_put()/l2cap_chan_put().
+		 */
+		if (!sock_flag(sk, SOCK_DEAD))
+			l2cap_sock_kill(sk);
 		l2cap_chan_unlock(chan);
+
 		l2cap_chan_put(chan);
+		sock_put(sk);
 	}
 }
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index be6639cd6..bd7d959c6 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -180,6 +180,8 @@ static void rfcomm_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		rfcomm_sock_close(sk);
 		rfcomm_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -497,8 +499,13 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 584e059de..72bcbf1da 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -487,6 +487,8 @@ static void sco_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		sco_sock_close(sk);
 		sco_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -743,8 +745,13 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
-- 
2.34.1


