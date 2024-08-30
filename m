Return-Path: <stable+bounces-71572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A0965C13
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD90F1C23539
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC416DC34;
	Fri, 30 Aug 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="QeqV6MqC"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2114.outbound.protection.outlook.com [40.107.20.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877B16D4C2
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007794; cv=fail; b=sTgLjirPgfQREIiptHm5viM6w/1+GV30PyhfMU/UH8uaC1eZDzFpN0hVW4Lz1ioijL/zaOpfZrqZesFUFH3QTGtgg7ryBo0BCyEvPOjHem1LKMUpEl3xSrc50JClsI6tzTDvxprJjo1YcZs3FFCEmL23m5MN6+p3si2CthfAulg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007794; c=relaxed/simple;
	bh=gP/zjeeIDojtfx8BEy9offHoe2LWqTv0kkw5Rbdu8e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eWoVZXFsTfcfwns988+NfJssWDuGFO84FFMzJPFZKU9AKpDg+OfZPbtTufmAIj2s7/23l/OZIFggeSlbzVrio6NmglzsAPFMjoHlbStdwDvAPP8FPdlccE1n29D8WgBwgL3MjwCNjkt6UOjIff6+V0mnojprg2Xku4cdUNztJko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=QeqV6MqC; arc=fail smtp.client-ip=40.107.20.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZBZp87Rw/6z24UY4zyISX3hAJVjUFiqD3eEQ997Z2iUFCzNc282+Qp/HBAdIQshX/lJovN6FI4JdmSJsg8eSD7fiOVDCK52xL5EAa/mCf1FOZT3e1hfxvH7M3Y/DOalAQFspKygiUowQ32TAXK7TMiySUNYaxn2seS3Us3NoPX70WvDnBh/pJuzyxWxxLMnujf6WWU8ac3CXw2SU7YRk4VWjDrbS+CFzfMZVOMvTIKt3RlG/NtLf9O1H1v8t3BsO85krEsbZngXRr8uSy4gunyoNB+lW2a+tf5Ksg3427rFahKoH2F43eLxMOI/MrIr7cLSKiabNSHzMqSAy06Pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo4pmVEMHI9g2zlnADHL1u4Ow2KsIVp4dfeOEwp2JC8=;
 b=lG4W9RZkEyIHHLe8rMfIN2Gvosw450gbQNH169qymaksaP3PaDtnky088IUqHb0YgEwGNtEgIfdO3Qa3IOCbgK6NXI5I2GljGDJlf+Aq3ZG/Z9UuO5wQQ1mGKNrdcRvxGRPr+Wvtg489Whz7dP5TqAW+W1cef5jnSHZpE4bNgXptz1LBFSTV0AyKMRy1m1u/ehuKUD0IkOgy1XjeaQBndyL7VbosrX0kFlqiONVJrQzdu1hG05VX/BV1Atkv0u/pUNR4Dxkk2FZy9Ukdi+o3ePE5h+cesvByXe5JUrN58QCwaZT763ZdMYcdrdh0AH4ffIfV1bL7mhqL17huZ7hMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo4pmVEMHI9g2zlnADHL1u4Ow2KsIVp4dfeOEwp2JC8=;
 b=QeqV6MqCjL3X3YJbNtncw4avYimNA4H8eZ4ZzBNEXLXZlgV2S6Z46uPDRtLujK6TizfajTj0qQVhGAbU1qFV3oPpypx/dMEtBlnOGD3+/x+LWP6diCE6MFduj4DNBXoAwFX9QK86xm6oj5kJb0lWYC1y8cVNwjqzfKxNpyy7wRMpCTOvy3pNp/ee4V+EJ6eb+sTAo+bLq9orutlEqg2YX2Miw/1T3jPhdHeMCnBC9oUW2pPDYwxf2ziLMlWdeZgX9OnyaJZRg5itPQIYzFSlZxPid19zLalVoHmy3bSt7hMihpApquorxDw6eNQBHfcLXn18e3iwYhHqgvCz97u3DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AM8P192MB0884.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:49:49 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:49:49 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 1/1] net: prevent mss overflow in skb_segment()
Date: Fri, 30 Aug 2024 10:44:54 +0200
Message-ID: <20240830084923.27162-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830084923.27162-1-hsimeliere.opensource@witekio.com>
References: <20240830084923.27162-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P193CA0014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AM8P192MB0884:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b50298-06c7-4e4a-0a19-08dcc8d0b4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPV/yPmQH8VmlHO3QwVRKwetYtcOovCqA5RloD+JhHpfbUFfHwJpl+NyTreP?=
 =?us-ascii?Q?HzcSAmvuIX54kn1jeODIaeFNmBW8sABBLBMhfu3H3YQvT7B1uXd+3wdBqOo8?=
 =?us-ascii?Q?Ud4v1U+aIK2AmoBmQxfecjKBskScIYpDcKXFO6jSqUbBZ6elu9PmhjuaEhFo?=
 =?us-ascii?Q?shP7CT1169Wcg6no16ILX+Rde8PuIA4TcSa1yJ7pEQ9N2KBj7+TOt08U4b/m?=
 =?us-ascii?Q?FSQqv1CPtdVFIGhkgZmqLP5iQJy5uKt0EzXBaIVMhF9aEnIHtTtAagUHa7E1?=
 =?us-ascii?Q?5oEB4/mCEs+u9FyUnGDISeXsf/O/DYGE/88/bAz7Y4CnWLDhBCV4WGLkk/xM?=
 =?us-ascii?Q?pKuY/lhxGuI2GABJEEPUKkSksx8viHgGCb/xG1akvWu9b7s7hxg12sWzGydd?=
 =?us-ascii?Q?iVSNKOB5Qs3ql9c0hb9wF4IRgYoA8/PFJHeYFjckzGk9BGCNOIhUR4dGG2y3?=
 =?us-ascii?Q?4xI054K3SIjxZtW3HNp0lUd2P+k0W7/sxQizhsFIEj002j0Z/Duorw0d/CzV?=
 =?us-ascii?Q?BXFXPyavcohVOfiwNmhj2r5w5sNVpOtBQd+EfPr10IoHC/3YAJfE5nUtDKO4?=
 =?us-ascii?Q?I9uJERgEqckSOvc6iehsmY+DXTvcXcK+IrVzWhQWEdcI3UGBHz9wvjb2vuvA?=
 =?us-ascii?Q?/OlAgTXlUfoE5oE/2tr5K4I6cDXAgEI4EcFgpgZcMGOicoSspoZ29aTrfufU?=
 =?us-ascii?Q?1uYB8ELEEnPjQSgPwC4s6aiScAWCHCU35rpJbwiv5oHUIEivQOvKOKvZ2Rm8?=
 =?us-ascii?Q?/WCgDl47H9R5lrIHHoS/mfdQlC5DsWM8hsenjpwBS2bc3Lf7VQukqMR4MpBX?=
 =?us-ascii?Q?cvaoiO75pRQc20uMPW7tdumr5MrYL6b0rnjCdDjzzkr2eCF9aIKHSPxaoFE7?=
 =?us-ascii?Q?ETCnxTqbihC/zHD+tMa/Q3UM88c7R9m/MCuxOmqK4ayctzndjGNjJz1J/Ziv?=
 =?us-ascii?Q?S42vSJ70Ox+ZE3UezruAsbDhCIg1eWiWfJdkbBDRN8gkSHXsc0n6Dosw5xyr?=
 =?us-ascii?Q?FxJkL7PNAbGgO+janJRAwUQCY/kxg7Ka9Loq045MW+34xCdWyhPixZtIBaok?=
 =?us-ascii?Q?1aiamP5mBw9nHaH0R3U+6tdii7jGdxEo/aK8x+D6lXUbVP0HIFSQ3sm3G4TT?=
 =?us-ascii?Q?B+GTKyCuPWTmMIAez5SabG85J3aH7bUuZWRn66lo15tqpSfrVEACm73HaZ4r?=
 =?us-ascii?Q?jAUDORIb9N9lYDj1KbphtKleGCRHaLqvjXVbYelLZoNnoUh4mhW17EOfIZTQ?=
 =?us-ascii?Q?xLuL1e9eqV+eIGZwCIFG/z3EAfWDWVOcS4NSXqlvEEhLZ2H6pIwybJeBZcl0?=
 =?us-ascii?Q?X3VDAVLoxVASpw78GZXNuBWKNONplhmHJaR1pakdn2LpWm5z3ak49qmQfoIH?=
 =?us-ascii?Q?T7QqwMQfPGNTTNpQ035VEwmBvBCp7CHUrEgTAvsI7bPC8ezpQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ppEinGiIUY6B8qLra4/4ypsLoMBAP6WYRkJcw+jpS8NMpZbgErIpweQkrrh0?=
 =?us-ascii?Q?oXwbCTtOwxhkMhcO+1K6XZgdEBcVfXwA0j3C/ZYRYxol7o+RcIMNjsolDL6U?=
 =?us-ascii?Q?ww0VMUfsBLZsUAfHEiKWqlo6qZ1H8yUApBjY0hUU/2Xeh3eiBiUnUXs7OJ8F?=
 =?us-ascii?Q?d8bmjOuIR3fFroCa8BEjTaNa4t/9KUX/Gjg7/XhEYzeSl78PiqGpOS2K7K2f?=
 =?us-ascii?Q?e120cSiomRiW0nJOFSfxkRXUc2YiIqTPLDL5j3t7mq1kg/6Yp36BT2QTKrZ9?=
 =?us-ascii?Q?iUaF7gJ2oYwGrFkFgt+4SYFy5C/+1iW/M+Y91zMhrUBpDtv+sxbHDN+RLnxP?=
 =?us-ascii?Q?100UemxSfHnXp/LBj/EqJYKvJbz88xAFmrIgd7+odFS2AHPswaYzRCczQzCM?=
 =?us-ascii?Q?NDB2gGU3pPLiQF95E3Y4gT17AiDPwk9NSKSUER86CwJ0f4vFdkMx2Sg/w4+y?=
 =?us-ascii?Q?+8GiQOLtkqtsAkpyE8jdTqlszsWWkg+jLG2II49a17iUrwIifRBnTxmoDXr7?=
 =?us-ascii?Q?akn2tniq5o1cGTmsbGRC/k3amyF0dyoR1aVZvDefLEebMCohSWefRFaVOoHs?=
 =?us-ascii?Q?wHiRYG4v1PoTKSavSv1qam0lZKw8Q8o0nX8lC3ag49Sc/Gop0YoTRtQ/88F9?=
 =?us-ascii?Q?CKRmmW7CtNyxwg+MvCBQVBqujksEXv6+jmQ7cXotrey2/bPTvhSJvD+PpLVW?=
 =?us-ascii?Q?DshsrtR6ramakNfMNfQJLcgsgohiZwDMdpIT382LPU5f4oKMyBGXLzFS0yJR?=
 =?us-ascii?Q?fXIsjuDWvcxzl/KbyLx3h+r1gZeBSQpjUheIMa9KCgu2BYfXQooG0lRmqK5N?=
 =?us-ascii?Q?DCHnR7Hgn6keZWA1V4bTi1taGztoXCyU/0gdoPiPpwaYLoExRyxk+qWNbWEI?=
 =?us-ascii?Q?ncIevsxfKD1aiYYwO7ZsKwXCinKho5Mz/A2+ooPZoo1kcA8A0eE0HpuXyiU4?=
 =?us-ascii?Q?ibDAxdd7784CMCcf4aCCwKPzAXd8w/ROdLJmoxvvmhExTcI/alWNsd34I/6C?=
 =?us-ascii?Q?dzoFv2RxjVznNnIeCjfOfOeVfvrOfSIQWvMXxyqgVm3nhf6vUBR0yuiLJgOq?=
 =?us-ascii?Q?DaLOh07AvtNEs95ZzI1SsCcnX8fkzRg88Tz8E4vjskDTQZHBcMN/AayVXTld?=
 =?us-ascii?Q?3gbg0IE2wi9mlyA/VyO16n4AMfV6plXMKaBPS/ByNysf6FkU7lasv3U5qNWM?=
 =?us-ascii?Q?h/6POUfWBI8VlnGqMwCNZl/j3VAp7IBV2+/EcfBk9OOVk/mBfTwUM0ti/VWc?=
 =?us-ascii?Q?stX2gs1ttUcYc/D0o0W0MLoW6iDCdlUoO0GZUJ3UWYShCiAQVsJyc95bc2MA?=
 =?us-ascii?Q?q4o9qBXvCQu8IV9ZjRoaXzUWvLfz9ZJPEMzwdoPDv1aEzXnoOqWbPCKIHo6x?=
 =?us-ascii?Q?hsLXJdMnfGvNj9itQ3NAgn15lMKbHdMkplA/1NSp4TGaQTOjveHmORLU0xUN?=
 =?us-ascii?Q?wNj/hfJLJEfLvODqE37QAM1DNa7CsCof1/3hFlGTQlmVdFjAbiiZZijv+Sq3?=
 =?us-ascii?Q?d7rRjPFd0njJaRx4NmgUOAYMmVRBO3MAIE6xx7yJbtp3/0jRnhai6xUxvLRt?=
 =?us-ascii?Q?jXEa7DVL5+RjTIryg7h14DFrMVW3JdNOAvLXiSWBzNRks+zHptXIXk0Qz9b+?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b50298-06c7-4e4a-0a19-08dcc8d0b4d9
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:49:49.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+NNFP0C5+AyO++vFZN1ltgDSL7TP7h18P7LJiObt7vcDm4tZYATr35pAp014tMDpVyWc3f8VcvsnAF28D2llw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0884

From: Eric Dumazet <edumazet@google.com>

commit 23d05d563b7e7b0314e65c8e882bc27eac2da8e7 upstream.

Once again syzbot is able to crash the kernel in skb_segment() [1]

GSO_BY_FRAGS is a forbidden value, but unfortunately the following
computation in skb_segment() can reach it quite easily :

	mss = mss * partial_segs;

65535 = 3 * 5 * 17 * 257, so many initial values of mss can lead to
a bad final result.

Make sure to limit segmentation so that the new mss value is smaller
than GSO_BY_FRAGS.

[1]

general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 1 PID: 5079 Comm: syz-executor993 Not tainted 6.7.0-rc4-syzkaller-00141-g1ae4cd3cbdd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:skb_segment+0x181d/0x3f30 net/core/skbuff.c:4551
Code: 83 e3 02 e9 fb ed ff ff e8 90 68 1c f9 48 8b 84 24 f8 00 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 8a 21 00 00 48 8b 84 24 f8 00
RSP: 0018:ffffc900043473d0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000010046 RCX: ffffffff886b1597
RDX: 000000000000000e RSI: ffffffff886b2520 RDI: 0000000000000070
RBP: ffffc90004347578 R08: 0000000000000005 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000002 R12: ffff888063202ac0
R13: 0000000000010000 R14: 000000000000ffff R15: 0000000000000046
FS: 0000555556e7e380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000027ee2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
udp6_ufo_fragment+0xa0e/0xd00 net/ipv6/udp_offload.c:109
ipv6_gso_segment+0x534/0x17e0 net/ipv6/ip6_offload.c:120
skb_mac_gso_segment+0x290/0x610 net/core/gso.c:53
__skb_gso_segment+0x339/0x710 net/core/gso.c:124
skb_gso_segment include/net/gso.h:83 [inline]
validate_xmit_skb+0x36c/0xeb0 net/core/dev.c:3626
__dev_queue_xmit+0x6f3/0x3d60 net/core/dev.c:4338
dev_queue_xmit include/linux/netdevice.h:3134 [inline]
packet_xmit+0x257/0x380 net/packet/af_packet.c:276
packet_snd net/packet/af_packet.c:3087 [inline]
packet_sendmsg+0x24c6/0x5220 net/packet/af_packet.c:3119
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
__sys_sendto+0x255/0x340 net/socket.c:2190
__do_sys_sendto net/socket.c:2202 [inline]
__se_sys_sendto net/socket.c:2198 [inline]
__x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8692032aa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8d685418 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8692032aa9
RDX: 0000000000010048 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000020000540 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff8d685480
R13: 0000000000000001 R14: 00007fff8d685480 R15: 0000000000000003
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_segment+0x181d/0x3f30 net/core/skbuff.c:4551
Code: 83 e3 02 e9 fb ed ff ff e8 90 68 1c f9 48 8b 84 24 f8 00 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 8a 21 00 00 48 8b 84 24 f8 00
RSP: 0018:ffffc900043473d0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000010046 RCX: ffffffff886b1597
RDX: 000000000000000e RSI: ffffffff886b2520 RDI: 0000000000000070
RBP: ffffc90004347578 R08: 0000000000000005 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000002 R12: ffff888063202ac0
R13: 0000000000010000 R14: 000000000000ffff R15: 0000000000000046
FS: 0000555556e7e380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000027ee2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20231212164621.4131800-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e03cd719b86b..cb336e79e05f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3625,8 +3625,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
+		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len, GSO_BY_FRAGS - 1U) / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
-- 
2.43.0


