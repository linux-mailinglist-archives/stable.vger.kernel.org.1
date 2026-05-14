Return-Path: <stable+bounces-247286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNT3OXgmBmqmfgIAu9opvQ
	(envelope-from <stable+bounces-247286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:46:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F06EA5467A9
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C7593017382
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0153B813C;
	Thu, 14 May 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Nh0FF0qi"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE639AD32
	for <stable@vger.kernel.org>; Thu, 14 May 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787952; cv=fail; b=jcz9UMRySx1KcfGi1j/oROj4G5KCjIOdvzHtkEpEdxLuc8mLwjfxtqEdlaZx5gsj/3KPvF+HyhBpQBfLTqFtbtYydXWmH+R4LZPZfHxBg5Pe0Q66y6gvw6ngHfJO0cGFVTVqURkqOJT1Fk8sK6ES6/85/0eU7MPP47fD7PyeJJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787952; c=relaxed/simple;
	bh=w8EmOmgEQC8fmH69qi0s8j+4/PAaPq1MiL0mDGW9F1A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C2RIK1VJmWxS8vjdwsfLIG7ZXwAz/qWP0r728pMQ9496P/n7ixbuzkt7/9sx1G7RavgXTBqS3ahza+60QiH4GMs0yLh0LSl4aDNJZTdSLEMdCvbz8K8OPgUDd8DGJQr2GQOBlPa5Wcpgu/TysjiLSWpF4Q2U59EPxT5Wyf1UcmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Nh0FF0qi; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUJqsbey5DqjypZ9p3JLF4hu5qBqTbB21aMCrW9X5vFXvskqmwnQo/sFQygX7dKxWAAIVFvboFtopOnBQZ7tZAGLEVF71U7HL7jaU25llVQUQiRoeyScEdPQ9+rvyvENxL9YYiOqJ2yvYD/IPskiSr50WgTiuK0iH7vzOBfDhScIO2pygh5YVjK/6Z3hND082PfCLlNik3El189vfqUJ5lLhKpnOTMKaUu2RWen6NYcj+wM4vE3iZ8OVyPdsWzjK02btWaOq8/Us/c8/qdD8u/SjmNgOnbcbdCCRo9R4ZUorSGalXoGph0a6e0LCyxi5Jr1Sctr4fDyonteb8iYMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnyTAOHRfLNdGMV7WDhKs/l51eoIoc+rbltH+l6MGds=;
 b=Ic+qsuu09NKz8YJb3UKTA804rH7EanirH9wT4aCCjBWFH2HQ1c69mubuQp51ScNKpKIAVRe/5dQ9ZsvPtbgwlX/RKtX5X5gf8V5F64ZrYBywU6q/wTcSDgKdPmSUuwnctpc/+30JySxrVkdW0rGVHZvUJUX4UwYkoRic8mr3VQMYKMzRwROE76J+/mK3XHqzsG62jGf3mLy5GYhJFvBhcEJOxrFf4hTRb81Gc11gjyTqtEnjI1oNFwy0xhAhgImfD2OAm8BTYJg3gZ/3xVxHj9hxgFGH2/vR1QACsYv/A8YfTdMLDmRgNK0wbFL0SiLSDebxi2DB9RIjxakN0ha/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnyTAOHRfLNdGMV7WDhKs/l51eoIoc+rbltH+l6MGds=;
 b=Nh0FF0qickYK3X3vLdk9GIOsNR1AkHFBSyldSlWtK7vNglkwQXnUNbmT21CALflxuiowz5aTdvyF6b/1VpirmD7pf9NFL354O8+2tO0BB5PcjDSdm/Uiz8EmGtyvLPdMca6TqHbeGgLjt/R+BT7Lj4o6+TFTSEbpSoSbxQ9OKB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB6208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 14 May
 2026 19:45:42 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 19:45:42 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregor Herburger
 <gregor.herburger@linutronix.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>
Subject: fixups for Raspberry Pi 5 revision D
Date: Thu, 14 May 2026 21:45:40 +0200
Message-ID: <87wlx5epwb.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F679.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::3b6) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 961b789b-95a6-4fae-97f9-08deb1f1623f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|56012099003|18002099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	HOwHuLnS7HCASSFLlm5+RFkrNU5coiuLlV4tx1ebaIDQagMopu0l33mp1ZiRHOsmLt0xb+GoCHsZkWOekt/CfTGtjHZ58frzDq4fTmeYDOge3Chfb7yKs7Ah+mTbK1+nRYTI6owHHUv+30O8SQTkax3ZDnhGM+3SYvCLeu7I66gVwgU9mdij5Y6uOVzmdTWe6LZgMUennG2/DBL91MAL0tclEnR7PGbvLOUqXwI1aXos64jgGFARB3vhdvOxvmPE5tg+8btd5/kF1eCdJsr40ChZTh0sODvIAGMxyCGDQs20SQ8UgBthnJQYci1p06BZ6XVIGgWkBxuZsWPNuTcgKu/hX1CEmySjuH7yUe9Cej10ZwEORiiFFxPFivP34xvZfRK45iKOGy2esz7LIV4NLjhas/2a1l3Rv09eSdSy4dbNvykKeCtMPCsKlbmIqPNvveKzudOw5f/q9LpeXhyZUO8r4rjM7CFKnxQ43IQVs4qsLtaFfYGY46GIPzfs55GH5vO+p6xtjcnq6cDxOTdgau2z7U3UJfFYm48P9vojymsqOu7O+4TyVB5HOiPuv8ljiEEQjJ+9JpE7nhcEQmGBlIOnqNLtlJu+y8zVO5Llrn7J0+ELyjDjQKCzuVddkfrSyDChPWWtvuIwRq0Ltv7ponSOOaBWjlQzHBzHUkYhFmXHVNcy3cwRFLWhByYhlST5i4iTc/gnkakDX4LNMarcGXPbhWJh7VeC4wDEJKlr/YWA0PPG0WfEI6dkMIIXHRs2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(56012099003)(18002099003)(11063799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/z8scVRpHA1aBgrnDE9w0+ns2IpYmoGWt3/MiyR9THznunMUhYU8ytO0HGW?=
 =?us-ascii?Q?Ei0l+RzYTvJPIb6cw6wUYGoD0YaZPA3v+pCFXrYa5slVm6vfLqTxJo7aFt5Z?=
 =?us-ascii?Q?UeYUa3NRU/SvhENhVj98lLAKBeOnUrMTeKWm9tnbGSEm9fp2nCBJpldlqx9g?=
 =?us-ascii?Q?jBB85qk/jFhkcQk/vodxude3NUKBkrC2emhKE8pOBNGoZxEhoEQHRAtQyfDy?=
 =?us-ascii?Q?od+iBrHAMrOKKg8ffGjahWxn6ESQvq8ObspXlbwDzdDsiDbxoXr0PJRqPkP+?=
 =?us-ascii?Q?TcxItPjWHWsRraVSmAaTd8Dd07NISqvBt5aGBYcSFgGnC4mNOpwYqumjg0z+?=
 =?us-ascii?Q?i7qP1OWUho/cJJFqZKm6fRJLMNXW/+F4euTy5MWljbVcH0tsL34GC+/TF/aW?=
 =?us-ascii?Q?2QdaISLaj5gugYZqVVQqvfSHiM3p4zyPu0LlmwIVHJ+L2TwMZNQ3H+f+4gtm?=
 =?us-ascii?Q?tDWroCqU5heZU3WcCGZFSEhcUaiuoQkWDKuYGf1c+tX8PCE6dyPwQxBpL5mX?=
 =?us-ascii?Q?gBF8TQicvo/XsWXFQJm73WxZhK68iz8Gf/UuvJW8ybDNX5gP5VQjC8AxYEtP?=
 =?us-ascii?Q?KNi6O5VXCxuVdIai3t7ChoYLdJnMOhwhF6aytWwj9x6vlabx6KwJ18vzfJEk?=
 =?us-ascii?Q?BLq0o0WGrnV8WKvLGu3r7HNUnap0tBEGS/rUih9cwv7NvBKAoXDOsVkO7XCz?=
 =?us-ascii?Q?qGUQSOq85nn5umov4CNReu4HnEZWZREKWm6IKctPkfrvNuWFukm4gQQLXVB2?=
 =?us-ascii?Q?cHX9UjHD2Hf3Jc5pT9z/rrn/t8xZYG9Sm670sr2YVGsC9NzFMD1Oa6I34wbe?=
 =?us-ascii?Q?l1DHBA8PILZmfpQCeOhlK3RaBxP5EF+zA3iG9Td87o5EG4cFVfIik0b0HzsS?=
 =?us-ascii?Q?Mc4gO4gQOBGJ6Dt52gN664Y+xisjfX9ixWNL69rk6+vg0UqlsY9dW3R/sYWo?=
 =?us-ascii?Q?kMd/hZLLppDIJXl79X5Htotl/do7MOQuZDirMkFNtESEwf4hfHVQyXpmRiCj?=
 =?us-ascii?Q?tgWm8B/y084TFOUWsjvjzEPUeJ86A9gvVU7T6kaZo7T/Hln2xDuiUeNp0OVz?=
 =?us-ascii?Q?q5hfnGh8CvEtYdDzzzYSjgVN95oRHySyc9qCAuG2W+f2BXqNnMpY3UNeu3gq?=
 =?us-ascii?Q?wZ6CjvOFxKTzUcrc0wLnPMISRTmo+nLDxeFeT8ANCSnn0XeV9K/OxJ68CHL7?=
 =?us-ascii?Q?wYTRDbDzJRkStV1LYY49vHmxHghDqip7PQ0GvgUm3Uy2kg5NwbWO6F16ndPC?=
 =?us-ascii?Q?NLMd8WmzXnD5zXR8hnSFswwVnKg1W3GporHnJid2TuVW/NxbIHO8Dy/j/sVV?=
 =?us-ascii?Q?eADpHWzBVnWr8cjD3f/KPJRVyHYO7n1txeCChWLP0mfttuk9It/fciHUVcdv?=
 =?us-ascii?Q?LJO0UqSPnKo7uAc9vSBS80eGwP2mF7HfEB9GnFYt5K69ENPmu7HtiJyHizKn?=
 =?us-ascii?Q?3cKLidoMIcddtVmXKro/kB16uvordME5DgNkT03Vysb+yTWsfDfLY79krAkJ?=
 =?us-ascii?Q?Mdlnz0kdcz6JINZorw+zHwtf9tBOyw8CCXpuS0pcFvB+pTrInoTkSWn0g1t1?=
 =?us-ascii?Q?GJhXRkghKb1nfwYrKDFHQRKQg7BghdgpZL73qce999qR+SEMzgAkDSyox2GN?=
 =?us-ascii?Q?OZE7Upf+pBK9iIPbEDVsQnqlBxG36i8CNGHT1NwAnx2m1SHn3qbeYvqDCy0P?=
 =?us-ascii?Q?nzoK7ALRY/IN15vucWeteOGgZcbnZWDoyYbZUiymoEQQzlJkL18jKwWdMYRD?=
 =?us-ascii?Q?07L7kNkd8Q4q7nJJ39FeAYxxbU6AddM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 961b789b-95a6-4fae-97f9-08deb1f1623f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:45:42.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg7uRo5zvZgnh6U73jNO1AdvY3UEPDdTnOaiACAIj8oaanvTaBZQvJowSbDPHqm7HqqMN9ZQm7Y+dZtq2lPWdLoFg0p/M/YoXWv0jPjB1Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6208
X-Rspamd-Queue-Id: F06EA5467A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[prevas.dk,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[prevas.dk:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-247286-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[prevas.dk:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ravi@prevas.dk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,prevas.dk:mid,prevas.dk:dkim]
X-Rspamd-Action: no action

Hi Greg,

Please consider adding the commits

aeb078cebc40d ("arm64: dts: broadcom: bcm2712-d-rpi-5-b: add fixes for pinctrl/pinctrl_aon")
18d4a06e10051 ("arm64: dts: broadcom: bcm2712-d-rpi-5-b: update uart10 interrupt")

to the stable trees. Without the first, a Raspberry Pi 5 revision D
simply fails to boot, ending rather quickly with a

 Kernel panic - not syncing: Asynchronous SError Interrupt
 CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G   M                6.18.29 #1 NONE 
 Tainted: [M]=MACHINE_CHECK
 Hardware name: Raspberry Pi 5 Model B Rev 1.1 (DT)
 Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0x60/0x80
  dump_stack+0x18/0x24
  vpanic+0xec/0x2d0
  abort+0x0/0x4
  nmi_panic+0x64/0x70
  arm64_serror_panic+0x70/0x7c
  do_serror+0x20/0x6c
  el1h_64_error_handler+0x38/0x60
  el1h_64_error+0x6c/0x70
  brcmstb_pull_config_set+0x64/0x128 (P)
  brcmstb_pinconf_set+0x64/0xd8
  pinconf_apply_setting+0xb8/0x13c
  pinctrl_commit_state+0x11c/0x260
  pinctrl_select_state+0x1c/0x30
  pinctrl_bind_pins+0x14c/0x160
  really_probe+0x54/0x2bc
  __driver_probe_device+0x78/0x120
  driver_probe_device+0x3c/0x178
  __driver_attach+0x90/0x184
  bus_for_each_dev+0x7c/0xe0
  driver_attach+0x24/0x3c
  bus_add_driver+0xe4/0x20c
  driver_register+0x68/0x130
  __platform_driver_register+0x20/0x2c
  brcmuart_init+0x38/0x5c
  do_one_initcall+0x60/0x1d4
  kernel_init_freeable+0x284/0x300
  kernel_init+0x28/0x13c
  ret_from_fork+0x10/0x20

since the pinctrl register layout is slightly different on that
revision.

For both, a suitable Fixes tag would have been 

Fixes: 44839e2ac8ec5 ("arm64: dts: broadcom: Add DT for D-step version of BCM2712")

i.e. this goes back to 6.14, so I suppose that means it is eligible for
6.18.y and 7.0.y. I have tested by applying them on top of v6.18.29.

Thanks,
Rasmus

