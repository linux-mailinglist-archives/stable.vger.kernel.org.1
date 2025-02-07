Return-Path: <stable+bounces-114237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E3A2C1B2
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9D0188C19B
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A791A9B4C;
	Fri,  7 Feb 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="ykhVsm0s"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FA1A2C0E
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928246; cv=fail; b=YyzPoCo3NgsPWxiVDRa1WDIWCUUxXmpiMVeFh+wSU/Gjw++mRLfpRWKIO9zgojd/ISGHzL36H1RLi4eBaV3vnUkm+R9GEQykWNEKOzN4oDHqWXBrw/5frAUC+5MUuv6/EbcsR1dDRLn3ZBZwjTKaon8MyR5LKBZQzZN54vyFwLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928246; c=relaxed/simple;
	bh=PAeFHKCqGNXVN0/kgO1e2DsAaL0OH0/3HBwWXdjYMDc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zgjr9xKy1JkpJcSdlaeASrIlZri0+Smia9r4E++eGWASCx3GkG+PBZuos+BG4ETbZm5LpGJJ7FpqOIS09XXlV0rYlF9Ig0yWUfp02HmYmnPNBgoN+XYzkUMyxgXksNfzNKDKTCOae2TW87+fM7EXOG3kwXX9mRMy4cDRKzd3oIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=ykhVsm0s; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8N/wjxi5dLjtRT2TXdzEiRW2UezqNn7yDj3OQyRLu4sbY2+Wtu2+qLAmN1Tn2jGseNoEJBTvcSZE942miZx6cdK+ZKwurwwP8JZCEZhxvSJlM4bBf3OUHAoXpqQrhGaHTu2AGamGFPv19S78wMFMoOZ77d2wY07PoWFCXm5R1TZ7tMC+wrR+PgXGKySycLIb1Gp0v8NDxEO4c4RVLpDv/YPmjWAow/+A5GHS+FA1OVBY46djX9C6enW/dWR/XFD2HnUk/895FGCgLRh6sLpndungw9pjlndQv8Lv4jX3MVq05xtz6+1iSy24XGDGg8Uj8yBFgrpT/nC+LN8FZDlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgJFUAgp8d9pS1G4QesYOGeZBwx1cK4NykJOuM3ftNw=;
 b=i+r8AgdZMv6jrYVJ0EBLo7zKARYFGLo1Lk6RkOqooY5zfkzMX6tS/SsStq8TNdNWmtaUdqXgCvTi94yYEEZIr7BIBVWGFBNI1tA+yEyfK0CZ13CMqSrK1A9/lxCbRcUdU8CgNECp1G7n55RkA6KXs41nedb+/FC3qks0RlbyrUV3n57TPdp77n4wHgEnIYS97A7GAIZQ+FnWDnTNT65OfWZ9lzKE6vosz3tvp+YRJwrRTu0ZAaAtGtv80ODT4rOOieBWIoMflUHsF9r+J3u8WnvjB530sNXR1oefnOG0jm/m/MZjjl1IFqMGd8RB9Xj4q0ZQEBYhBe5k8JL7WgMelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgJFUAgp8d9pS1G4QesYOGeZBwx1cK4NykJOuM3ftNw=;
 b=ykhVsm0s3KGTlmaC2hQ2EqKN/Hdkz1IGqJMUW4esf8+5KPIj8cKEWPPf7VCiHMUieXFcn5rViJ/TUbHyiaBGL/ws2ri9rCZ6q73sgi9g6UyBGMgTriLCLe1ZG3IMc8rrAdNikNmCYdxARqXGbnLmnTu/PmrrkpaFIH4m47UobRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:14a::15)
 by GV2P192MB1966.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:37:17 +0000
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b]) by VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b%5]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 11:37:17 +0000
From: vgiraud.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Victor Giraud <vgiraud.opensource@witekio.com>
Subject: [PATCH 6.6] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri,  7 Feb 2025 12:37:03 +0100
Message-Id: <20250207113703.2444446-1-vgiraud.opensource@witekio.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::27) To VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:800:14a::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P192MB0765:EE_|GV2P192MB1966:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e238c0-a701-4489-10b9-08dd476bc627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lAFgC6XB/qH8zGXPecVR6CHCMRDQgvUuqtonmKlSS4wFGLSzdAWThPhLMfPQ?=
 =?us-ascii?Q?lZibUtB/8/hUpBdSGYpR1UtXLUHMVKyV8ErHQhFAGbslftvifA2K/7o5qHkX?=
 =?us-ascii?Q?L5VxgI4aE15SGatu2lf0gK9u9TeJloK9uo9cPxVX8XIsR5FiOISZgTaRcVsL?=
 =?us-ascii?Q?7UU9jvlAC5UUNs5e/3vEWnba+LtC1qGt9B3EV2jh3YA1cWu18vfvfPRmI4Fy?=
 =?us-ascii?Q?N85NtG2Rjj0tI7nglAORdjMFzO6IF6n3LwVl44T3XNrAq/0qcA4Qa+7+rTkp?=
 =?us-ascii?Q?bGbK4rr5MPOqp3psITE+mQG/4LFTyXWc62pRlHA+VrOZ9yIX2nMtIwQF8r05?=
 =?us-ascii?Q?pN0z5UbFtjj/GjFQ7GRgrA0nIibFbyDgFDWSvGI+3tPQhtHF+bfoM3YlPVPX?=
 =?us-ascii?Q?3DNkZ6V/5YJFgrBjVD/vLhEKc/ZQZoCNe7lgqKpVORVFT2JuUh2XrT9lSdxj?=
 =?us-ascii?Q?k4J6mV/GZGOHs3m29dz8r1MdboTdw+SsFW6MQjbJRda6avW2tYFEmBNisDMi?=
 =?us-ascii?Q?OhZo8E1HjKeDgkHbE9x06J+reoFIV7fUIDwAuEPNIFHKc59GXFTCFAWCfZj0?=
 =?us-ascii?Q?E4S3Ott9UNlRPLa6jd9T+f+YkbgHIhuKU1UfspXf7KYdfsMCVe3i1IAmMlJc?=
 =?us-ascii?Q?ifCoRGSyLDebsMIlYBl4MJw1ByXV/sRtfjBhPufitPqNg/As9Z99tgIjiDw8?=
 =?us-ascii?Q?8YXDJt2RdqDjAls1R8oEpB2DW9Q8+aZ/yK3/WYSeeL3vT340a2oU8ShQkgwy?=
 =?us-ascii?Q?hDQsse34taYHlFzH1Qdo9tH0zTPLply8P3WxpraV1m2U5HS+RzyMc/6PvNG9?=
 =?us-ascii?Q?w2n/d++pCSKSJ/sbYElPy5WSaV+1g7z2apYoVKi71Qu0vdPMEhyM6tJC04Gu?=
 =?us-ascii?Q?bhPsCMJtFbOCDlMT08lIV/f1jlWbXb72wogKBR2TCVttQ/N3M6+p2tGMrSKG?=
 =?us-ascii?Q?oULJheLOE6FssKJ+pC6itCAYNyzOv8PWUv9zV8Pxai1NudhP3LUIh2L7n8Jt?=
 =?us-ascii?Q?JTPvl7xEw4i6vrs2fZv1FqD+MHEgGvxf2IVJMPQNS1XQSqdrfCXvVWLPsqeP?=
 =?us-ascii?Q?prkpSSGcrK1Mgl65fvxfvWQt4AZpeUoVzcwr0q5DEWy7wUPrxdbnc9X+hRqL?=
 =?us-ascii?Q?nzItPfh8ygOF5uqsDojIShq2Okk1xREElacoFs7wWE2pcm/10Y7FqXaoJbbF?=
 =?us-ascii?Q?7jWd22T5zfhzRxuEK0dCHzQSy67hF0Cby90VrPEQMm92TllEKUGnt9cs5qYG?=
 =?us-ascii?Q?lfSmo6l0VWgTVjnbVjA1cqCeywPR+NUjS4nXzAYyVqxUrOOfln5dWarnaGTD?=
 =?us-ascii?Q?DUHABwrg6W/UAyrOnccCOSVflDyJ4y7psVVhfKYyMALU4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P192MB0765.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(52116014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bwh+fxVeZdahRvqw+CZpHz/RYqdv9nSvOrLruxQ20pTiErnC2YxVw16216mf?=
 =?us-ascii?Q?YQtaLwfan8StjWj5VED6URLrwaucASmqtZmjIgWYeawwhiPqOjUPUKcOgCvm?=
 =?us-ascii?Q?c5KNubWvCNHGjgHdVnMEOQimK4Ozbl8FdwwW7V9lzxI+FZBadmVwOyq3heH9?=
 =?us-ascii?Q?W02vJn2ADhS2iIPwN7ai3xNmusoiWs3jyu0eOO57iEhzy0hjBBttfJr1Ll6j?=
 =?us-ascii?Q?ecMYcsEsLN+FkBPPpiq5g6NsE9tulkSrECww/YKUaA3mRXJKhqiOS6oIVscB?=
 =?us-ascii?Q?fj0DKUakprcbWpJrhKq1zDfOP6NJJzQgs6kYfxuK68Lk4EivoGiR8FDqt7qC?=
 =?us-ascii?Q?4iT8jWxJrhhZoboQ7stnbyQS71dWQEypPkAzoCwPjzg8blSdhbIp/z79wOy0?=
 =?us-ascii?Q?4U1kvTRPbvFF4BCzZdavEd4dtd8vCEogdU5xFFKzxFi2VvLzlX40oOBosqLx?=
 =?us-ascii?Q?kaN8ezvqxc/LwxDw7oCdlVhSrBgT9MoSb0YfTRhdOhHTFRjOiKxXX3x4D7eB?=
 =?us-ascii?Q?DbzpsXqzmY7/l0kRC5tkNcFRj3HiCzUUqqakjk4Po1EzZHCEejFK8dQ8m2ff?=
 =?us-ascii?Q?MNexFrb1atex1c2BF0rod9kYJE9FS6nfoa2F9s0jqnsGc3CYL9D8ApcjjvI5?=
 =?us-ascii?Q?Na125S91qDw/9GKSX9hJrw16S1gDFsRjPNLId5d/+OfDWDtkFzXRSs+3vNN/?=
 =?us-ascii?Q?iUF8sSVgdtwW0cmlg0Z4QW9tQF6/JYjJr9pSsrkbHr8429guXzfsS0NSPe8z?=
 =?us-ascii?Q?HMSiUeUeI7eeLfBlLtZ9PSiN7RjlM36NeHQuL8Rwaz2QMK5QLTaJg0s8yeMS?=
 =?us-ascii?Q?X9Yyw8R4sC3OS/ORxB4/t/Fi9NbKSXRQdGXp4FV3ruA0M8nzs90p4+CnErII?=
 =?us-ascii?Q?BH8TLT4ER9LpO2S5XrFbZ4YnV0ypRgm9dburYVbDCosuMc6HDhANhb2owTnJ?=
 =?us-ascii?Q?vXJQWWkT/SxUne0/JUAEdnYQMh0vwi5lmtSp/Nejph2hbZrwLuuKky6UUWzZ?=
 =?us-ascii?Q?thrnTLcsQkIjpkuuETb3OJn6KEgJp4HFmavgbdpclOPFD+fh6CUzxGhZ2pmU?=
 =?us-ascii?Q?1Yac2fhyRjzNVDV6611Yk4VkcnSKdcTsK4IYJdGvFFVl6cqhZn/9kCGPpbg9?=
 =?us-ascii?Q?gZ4GFAiA9pbRm5hbxfkfX+CQcE8LQtBB+tMTFaxhvXr6Vu8OmVyO0vkZfdQ1?=
 =?us-ascii?Q?V98ZMVPnlAPWrkWuSeE4sKxkfmz2pWen7HOExtJVG5O0N4GxNpZKLapFTPCL?=
 =?us-ascii?Q?N8WuFfdLsmljPHj9bZcbpOeQUc7JKymUf6Fwwv+PvKh1OYLDpe8yfg7xkgFF?=
 =?us-ascii?Q?qZTnjB32ZseJRAINSsjwNovUdXqFgshpAGarcslZvD+TadGbKVR04EBfZ+5V?=
 =?us-ascii?Q?XEgfnVGjECN09Xks1X73cdm1YL/lmGJnsHQS8t9ALJhcDUMl0JqYu9zBNNTN?=
 =?us-ascii?Q?6TODse0YvUXUF/CyjlLWxCNs2pob8gBm32d6xHopM6lUOnEA/L7fMK+CiX8w?=
 =?us-ascii?Q?DFDigWXT8uRdygg87deDusdX/Zn6NB7ldXzsl5N95LbNd10tp9Udzf1DXKAQ?=
 =?us-ascii?Q?wiWYGKUuk+VRWuBUYd34Hip9hWykz5CvsOT/jl2+ut5fNEy9B6V0jDLuFBCq?=
 =?us-ascii?Q?TlZ4C7yIZH37D14CFsanP266ez5xIT+NEHyMy7z7miBa?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e238c0-a701-4489-10b9-08dd476bc627
X-MS-Exchange-CrossTenant-AuthSource: VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:37:17.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VDbsll8aqu9qPVvr6JZhC+OVG6CIBiStlYl9wu15EJG1w4BSPYUiqvClCFLptRk/xVwNfDlCFgNAU1+k4Y0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1966

From: Lizhi Xu <lizhi.xu@windriver.com>

commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
---
 fs/ext4/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f019ce64eba4..b69d791be846 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3627,6 +3627,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 	}
 #endif
 
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be "
+			 "mounted with siphash");
+		return 0;
+	}
+
 	if (readonly)
 		return 1;
 
-- 
2.34.1


