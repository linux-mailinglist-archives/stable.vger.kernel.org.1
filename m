Return-Path: <stable+bounces-78211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7C98941C
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567BD1C23533
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88A13E8A5;
	Sun, 29 Sep 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QoSFgTt1"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6284BE4E;
	Sun, 29 Sep 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601119; cv=fail; b=YQjai3rj85YaIQa2Hp499L3DT5RhOvEXDY7TXx5QfidsuFrdTJWKt9m6FiTU4h4WeScZdacmnSvsOTB5XJv6wcVVT58KMUmVUdrG8VCWeRyAA/mLkPNiliijtsEZ8VRbWvVZX818DJK9FFOVc+kITKuehtlH/TQcQKwVciIMfbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601119; c=relaxed/simple;
	bh=5MrPrnEhlb2kTZZKtqE6/zmxKBVG0gwTLdn33fa5u+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9JuXTW9HoL428Tc3qAK3eZB+Oy90xmP+AQyyPZ8A3aPUMj1WW7V9hDs891M4BM0BNboCXYMg3GTvyb+xSYMsJXmIyY1rpTD2pUu2p9TSzsNsP7vIbp2KJmmqopETp65ecXFRED+haSgo+QBbVCFb29Jw5yDWhzImWCecsLMoDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QoSFgTt1; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu5EhPV9P+NZeukntvhnQHwSf+TuOQ3Fw0J6+7+iraovMTZkbaIys/Cck2v3UqqkGB8KYSW8j3hNu/yc6xR+aaDqoQO2Q+5dpuyKjTeVeO2reBunPob1AA1vF2E41EeXxM1Q5U1bR79kSyBBF1lcCbv8cIy532oaaq56hXsZHRxQ4ICsbmufLo9/IuxEkR4BCU69s382EGRuSkJ7bIKvQjrlnQgWlPcn6kwj1Mk7qQxgCDTCDW7cQk95MuNIBooqAvn3P+ekDJpg699L1I+dsks8c/PB+KSpBlt+6IHHp7t9fcq2YShOl+vDYwKZQtep08P138BpUVd2JyUD11Oj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyFtzztl/OT3B9zLNeC6p2DN1q4ySB+/XQQMyDQch54=;
 b=Js+fItA0+TP2GjiAcyKHiyhzRGp6FiHEXVhMzwd1d/M7vxSTLRvQZqXsYWa/pOW0R/8SRh+9EyGNFrdfLe66a/MIwxhw/SXXtS8fvhorcDrFT6YJmlF7lkRzwu3owcgpubQBJeowZdKg84dvZrIzI+cm37WJdfFH84Ya5SFp1crB7VU7PLyLIQHrYhlPo7wqG1BA3WOv29sul5m30l88oJ7xPqXhPB08FinmRHnOteyG39hrcz9rLt5MOEOU4JRVsoin2SNZct0u127TPT/GVvqfUvXqqUIwpyGEqsl9UKW6glM5ylwGt31FYpMlz9R54aP0KoVVYwQbcMmaW5AK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyFtzztl/OT3B9zLNeC6p2DN1q4ySB+/XQQMyDQch54=;
 b=QoSFgTt1LTsTnVX95gotJUZJUfFocMJKnng8V/IJV6WaTTC6CA9LUlC0lKOmIyOEqcAyYkCL31J4KgNcJCACb9umsxpL8fp8eYfrutWCEaZFkNDY6J/+lovPDg6/2iF5aOylJQ+wMehmSbkhjumATvqneUS5Iw4lIc63Vt4R2XB4aj+lXLesch4/Q/6cNqkzxsKYBOZZNDMputDzfDZTxLgqwei+QFWGxgw4W/BQ5HvGM/Ei+DrNyicEYONBRMUfiXVPBo4QMfZn+NyCUqFsbO4E4nuTVgAMPWTlQAV+0VgYaK4cia7+ELGS3hxwuuyKfjfrrLhrp0HoVtf73+qlNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 09:11:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 09:11:55 +0000
Date: Sun, 29 Sep 2024 12:11:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
	greearb@candelatech.com, fw@strlen.de, dsahern@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] vrf: revert "vrf: Remove unnecessary RCU-bh critical
 section"
Message-ID: <ZvkZ0Ex0k6_G6hNo@shredder.mtl.com>
References: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c35c0f-b668-4907-24a6-08dce066c35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eg0Vo61fQwcd/F2yiN+QjY6WzwW2K/zhfehHmbsGPxpE6B+hMY0kzgYKzCtr?=
 =?us-ascii?Q?pUStma3Gb4NjvX5rKyx4qDSzdbGZ4G31zamb3y8baWcL/7fNZMcvDXvEiB4L?=
 =?us-ascii?Q?+3qX0lwuUKWbxvTP062ZklOp93RYBJ6Cv5RFGyIRKpxxE9tz712t9cUe/8B4?=
 =?us-ascii?Q?xXCc/JWvDe5kDWKi3kaJFfeJ+h+MACijLUza+i1+zCCrAFGxrtiLULIL1uVN?=
 =?us-ascii?Q?X4hZpuwtQQKCsRjc477DREu/8SeDGs3ZTZ4c/aPw2DPKrNoIIB0jurKso2pe?=
 =?us-ascii?Q?JFH9m67dX8mgGD2TRBVpsbXNI4iW/ct5xzNYFdL6hhBrV4TP0UfDzBjBD5+7?=
 =?us-ascii?Q?VWoKoB5QzY5T8RGveW8VPkRdH1In5tm85K4La5RFusD+l5t4osBQw877UvyU?=
 =?us-ascii?Q?KBccBqvvnnr2WpscD9qkFGB6PBlerF5tYupJ9+GKG17btUWzo+sSc8bE7VHd?=
 =?us-ascii?Q?msxBp1b5FNSUTYnuqzlDWMLM13yjgiIOUdTGrNWMFO0tZDK/9FJomFQkzAuw?=
 =?us-ascii?Q?U2+FgysoI0b449X3XbQ5Cg3NjnK86Z0jiMLnpb+ZGdPCh9KGgekwD4XLf8cQ?=
 =?us-ascii?Q?utn3M9Wlbxv7Hg6fcy0I3oBuXzip3UnrZBhcGYZqKfwOEM5F2OxFQ929QRRz?=
 =?us-ascii?Q?itqkzrLYRPWcLNjyrJrwgS0vqjV1sarYGsuPGn6PTHAHrJdvTjFP44THJGdd?=
 =?us-ascii?Q?mu2RbPhH/pgq7PjUQCbZyxPS5uzQCraIDosJmprxHN3bSdLvFpNJ9dfk8Jzx?=
 =?us-ascii?Q?16eNh7J/Y9fUpQu8q8MP6hBIFF+VfznyJZVX9J9eJP4ZsXGBLutW067vkr0T?=
 =?us-ascii?Q?L7P+D+82uc0qTmXNgIsmWhzMVdRWo0k+VgUFTmkrWv13FCOQReI8RcigwaiB?=
 =?us-ascii?Q?vSkI22U+eu6IGQPmPDGTbqagFyx2BmHt6kOzv+6OWIA8BnQ7Xm0yisSRWEu3?=
 =?us-ascii?Q?cU/NlDCh5pSkPDkI8n/nmuJP4YK0dAbhNn7TNEpm0IcZKT78AzoWS5ro20qe?=
 =?us-ascii?Q?ubE9aXEGAleJa15vyskrjWQvm0u/PSL+UxsT61kMdmz9FhB+JcB9Yl478Y9s?=
 =?us-ascii?Q?VPD3K7lKM+AkodwdHExfY0n+ydl6lsfOEtjdj7ht2gN6WBB0z0cgUdUno4GG?=
 =?us-ascii?Q?gSt4iCA0jHxdyn8mn0zpzC12zYwSDzeaFod2AMfQsBi1TfAF6ysuuCTXv4Qf?=
 =?us-ascii?Q?jL2KtxR2m6RPgDN7hLtJiUC1ClccBy2ZcBQP1oVmtMhkJAxrI+j/qWRl1t7U?=
 =?us-ascii?Q?l/7rMtUFN3vooFgv0Td83p4nS1l4iUqK3yoU4iyI/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPwuezuKsbi9HielUd80yzeE829KyG6ZylsIf4H367IwkVNp+4pPBba36VmL?=
 =?us-ascii?Q?fPPF9ndy0vdH6ZqJxSffpJCi3RookQzuLKnedot8Gc54txC5ZasvaTvKvwmo?=
 =?us-ascii?Q?geW8iAhK8gMzkopypeXRbchqjQ3ZaS3sHKHFVX6qAI30qBYFFET24cMyxOEX?=
 =?us-ascii?Q?6hDepUmGeg6ztLqtEGQHRO1ESmbuI1joEymNSFwt/jQCmMWfVf0VXwEC4MAa?=
 =?us-ascii?Q?2lOUtL6fEO6Ept1kLSGKRTtSdVR6rorhd0ZX4QinfLTr0S39r8KxnMKZVovb?=
 =?us-ascii?Q?J2Z1B0VNtMFzLNgc1XmmIl7vQCk7Wu+YV0dDetWpzMTNPk1cqmkT3xxT9VXW?=
 =?us-ascii?Q?GgUAh8jYNOneMFw4yzWcjW9iFuu9hpVqVANguW0MZTLFqvocSGjE+XhHvzeT?=
 =?us-ascii?Q?+Ogma8jbN66KooXTmwUfOwFUzSuIsUlin7EE0lOX44mplrPgcJMVNBEqsw4w?=
 =?us-ascii?Q?3QqNGY8Wxx2it+m6JvQfWok8KHj4IkuvoAJa0cdvzTyfqBudbuKjWI7aeADU?=
 =?us-ascii?Q?eAOWuGchNzucKJs2/Tdkmv3PthVgDg+GOS5n9scDQYvfx8vVWV+SSXXPwauL?=
 =?us-ascii?Q?fZEG/5qmg7Je5eNEEmZSR7pbdgYC4kLu5jdRtmCFDAvtyOS1MV1qula5yEpt?=
 =?us-ascii?Q?PelmGU+BqL7X5/o2bGFiVPLTRx2LEiPaGis/yHkXryP6ti7wTMz2gn3uEYEL?=
 =?us-ascii?Q?4a4f2T1kZ4Jwyky714dxo7jfoj/VbEVzge7Oe8o7cj/MnzuDU/47aCClK5wl?=
 =?us-ascii?Q?TNk4pT0BVl4j1nZ59/Lt/QJS/nSkXZgoRogMUlrbp4lgo1Z434HOf3gwqYzg?=
 =?us-ascii?Q?zmP5veVp2VxfkYvfSUdZPC9sMkNSy+GkSX5JwBP9PJb640ZdUlSDzdN4kmbw?=
 =?us-ascii?Q?Y3+Qc/27NMIFL/8k/tYuhqWjs3msugy2WHU906TN72868M4DOHMnzHmiDM+5?=
 =?us-ascii?Q?xPGjzohoR+2BqXfoKOWa9S+e9ZSQckrkRBEWTY4SBbCowuf2HC9NX40scgBH?=
 =?us-ascii?Q?NJqo11njrt6lYX83NopkcCVdNdk86BUwS81QM+UbzXgGlpEBaos9pcPOVIHW?=
 =?us-ascii?Q?QVPZr53ke497tdolxbsvgEvlgUnjJR1p0VQrnL/7ShDy/3g4ubVzI8sqYMyU?=
 =?us-ascii?Q?G6UaY2+OtTMkeg6+Bo1iZwzm+bjGlZ/wsSLjJ2ELoimBC9viIA4uxDw0cEHC?=
 =?us-ascii?Q?cDYh7JniGZHk/i49OkE6HxQx0KIcDIsQDB74V035ZAkaTLWBsgpTCGDElyXt?=
 =?us-ascii?Q?5sdTqC2mHH98MiuEN0MKjdhHDTftmISNJDmdtq8wXyKkChVVs16rc7eOrBpk?=
 =?us-ascii?Q?VlFIY7u2W/ZIDXjWt9lhm3ABR3lUM+nT4T9KINcE4AkZNclrE2jf4Y9WEMY/?=
 =?us-ascii?Q?7wWioz1chZkq3D8G5n+aN3TowmtmPZSt6ebg0A0BuOJmAcdLkWFAfyBcMVRZ?=
 =?us-ascii?Q?/OB2hD1nkxF8gkKoW6xFwapNqQZqvvyD1ylo4Uuo+w50wUnNqcF4/Jq/mnQY?=
 =?us-ascii?Q?fRgK0sg60L0UqJpAQESeTSum9+Q79r5qUgnV5HQdFxbFSs4lSlKI3NGTeuv1?=
 =?us-ascii?Q?DZqYfTVSdgbwmuZaD/zEErMqA2vaim1UVc025RVX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c35c0f-b668-4907-24a6-08dce066c35d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 09:11:54.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px/asOPRxVDfjjQHWg/JtcLgMfvwlh3q1ZRhcoAaSFSBo44td7/bJkJLYTUn8ahRuZFPqxoo8Vjnmrn9J0r9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

On Sun, Sep 29, 2024 at 02:18:20AM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> 
> dev_queue_xmit_nit is expected to be called with BH disabled.
> __dev_queue_xmit has the following:
> 
>         /* Disable soft irqs for various locks below. Also
>          * stops preemption for RCU.
>          */
>         rcu_read_lock_bh();
> 
> VRF must follow this invariant. The referenced commit removed this
> protection. Which triggered a lockdep warning:

[...]

> 
> Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
> Link: https://lore.kernel.org/netdev/20240925185216.1990381-1-greearb@candelatech.com/
> Reported-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks Willem!

The reason my script from 504fc6f4f7f6 did not trigger the problem is
that it was pinging the address inside the VRF, so vrf_finish_direct()
was only called from the Rx path.

If you ping the address outside of the VRF:

ping -I vrf1 -i 0.1 -c 10 -q 192.0.2.1

Then vrf_finish_direct() is called from process context and the lockdep
warning is triggered. Tested that it does not trigger after applying the
revert.

