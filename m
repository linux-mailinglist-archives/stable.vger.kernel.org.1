Return-Path: <stable+bounces-83448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A38A99A4BA
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CF11F24835
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E4219CA1;
	Fri, 11 Oct 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="QEQGPkWE"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2093.outbound.protection.outlook.com [40.107.103.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C752185B1
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652685; cv=fail; b=OyJiWXHL7sEyR7mFLusdOVAlFsBppTrFYc2/lSCfZqGwQo3/1e+zpug4czJRRcs2AttakSnRz/zCsSDm4LgFU6pg2pKH2rTi/uP97iiG3PfML5QThW48KglvuRh/IYB21rAM/XKFaD0nX5d0fCfv8R7pFWAk9HAsYvC6UBmEhSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652685; c=relaxed/simple;
	bh=fKDz1+sc3cZV9qBiCLxEhzwEV6SicUkOLz08yQDwucI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=scFyVXk5nmYAW51fwCZFMIKHu15GBiFGv6C4CvR7yjD4MBU+LEep8xlU0zW9Aupzle4n9Rz49EsaZPQ5CxelswIcHfCl7LTpe+bwbFkdX7QvR5RW/y+aiaHoJnHlPKp2m7IIcVQOnhEMDbZVZOuSAgaC2PtvDnvz1qRAtuvFi7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=QEQGPkWE; arc=fail smtp.client-ip=40.107.103.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3VzoHNRXoGHg+1qnXZHRhWpl1RJ97Q2L3jJ/IMMShKhf8QtA9PEWu59a4kDNEsxQgB+BFPAMEYHs28K4SkbjZMiHA0nq0mcbDMwY+hoxpiaBCxsVs+tGyDbScy4+CT9GDllkXUaFCwTYZ47y/oYNiojedvEdxu17JB9lnvDjtlWwA4uOFWPrRMPUX0a5DCMOSpO5ttVRmsnXfJRsxdm5jIB1oCcp+0Tr5Vp/YCCT3M2Gy4U5rH/CsG37yo5BFzBMHXiRq8/k0+3E6aEOP0RWpqOxIDeixSkvRHYIbL0i6uwHtbEOMK2O8sOcG7AcXNv9CYh2RrJJQ8mQIl62fFcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWtG4lLNFIIz4bE+Os27+BhRNjznkpcIwy4Rr4rev8w=;
 b=YMoeRDEltaYlk2OsOlh/56txyH0AWVPDqqZgKz0pUeNhup+DqtAwhUDzTGFBYsCqWOD2vGAEFiGV8ocyKUYO0j9kdXOiFEOsQEaWbequp+fLFhSn1/9huPtn5jeWfnE8J9rsauHp07ATwbKSsYidJWKGqLi8hTxuYEJGi3eNeXFrEXD/lUqA3OurLeG3Wa1q4mVwNh3xfgHtI9MelYRtkAPuDEvhrxBGzeXd17RHelY8csXDxWTs2k0/kPLwJr3RkPx0Qcm8XugSRbOv9urA+LMplnFoAUhIgU50jp0CelsVxUkFOfQGcrZBIa5G6IvcO4B0rLJLbPwWE58rVvu75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWtG4lLNFIIz4bE+Os27+BhRNjznkpcIwy4Rr4rev8w=;
 b=QEQGPkWEbaVfehPrUHsjdRPOSTwX3DCHhizFOeUfd/8Eanl1H2m5kuXflJ/alnZZZLlNpechG+Av1EHJ7qtgpms7bcbnDra8WZVob5OT+LKcSPR3h5ooUPBXXdSjT/MJP8fr0et99s7rgshg3N2Ka9Rab/8oRIlaPbldJDUQPzoJXKjjK1hfoD0yzJUN4gXsAwed/IsfV5JiLNGjMrtnfqcCIzEG3ogE3qYnf86Fji2+PuzWQSOPryXNcZ8icnBimCQalNc8J+DETvZpNp05sRf5yIXbny0IdHTmdoFohcw+U12RiAtOvGgpBtxQdgLWAq2wLKhmFmckbugV0lpADg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by GV1P192MB1809.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 13:17:56 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 13:17:55 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: "j.nixdorf@avm.de" <j.nixdorf@avm.de>,
	"David S . Miller" <davem@davemloft.net>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19] net: ipv6: ensure we call ipv6_mc_down() at most once
Date: Fri, 11 Oct 2024 15:17:36 +0200
Message-ID: <20241011131736.20362-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0417.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::20) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|GV1P192MB1809:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c194f5-20b1-4bc8-38c0-08dce9f71e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7S9doc2EfQDEan1tg+lVm+uLfj1kjZs/mlI011VZVQQ1VQKqd2gAxJR+UdrC?=
 =?us-ascii?Q?AtYBOb4O34q5f8YeplMle9bBChciyOgoPSedQpa5CHPm9LzBQcE9VFgTPgd2?=
 =?us-ascii?Q?KgZBnF/tQGw+k5eXfrH4Vet66ZSYuJzq0dtIdX60npWC1rJ62ubOBKNUCkNR?=
 =?us-ascii?Q?amq9LY3Xk4ntCYAQKIZD/38QgRX0zi4/JaI+F0TPg1omV+swT4qiVKYJT/A4?=
 =?us-ascii?Q?0gM8hKnc/25DLVa+IXbKvKbDdgKd9ieGOQKVoXLuoLcLs9xdkTpAJ5OAaK6t?=
 =?us-ascii?Q?qdXO5mJC3EC0rrcvQfT1abAqPxxRelOp8sN22TBTIW9I+E03EqvZ2341rF4E?=
 =?us-ascii?Q?32bFYtaKPtYx212wzQomIu3VOlOqyUHbJpmNA1X+35HG27fYt9oZUy5pkar9?=
 =?us-ascii?Q?VSEUwFOgAWdrSBpsIRMLfWEPfiFb+IH5BD9D2+SqtuyIk1ETt0yiPyYs920S?=
 =?us-ascii?Q?fVYr/fw8w2x4r7ctRrrQjQnoSTU7aPIzK3bNhPqAKgIldQrogOCHqVUkatv5?=
 =?us-ascii?Q?n0gZIiilUhZOeLRxWov3Ft+saKLQ9i0yn8xYT+1JIzbPAem1orbIECNXelET?=
 =?us-ascii?Q?RoUpwtSlOOr0+UpMdPBTdWZ9/E6N7haBf4vzH29FifUwhPx/OZ/8lkR7c5dd?=
 =?us-ascii?Q?nrL8g95vI94VtsD2ILZO2o8egMYiQ6ZOrriu8gOAizctsrbyNNEoM4YWeo+C?=
 =?us-ascii?Q?9ybGIxldfndRJ4iDACq/oz/h6ecQcPT2ZUs7KuMhXtSxTNXTtEOyJOqhDx73?=
 =?us-ascii?Q?HzLWP9SUdlbzCh7J0zNRi4CX3lI7xFtQqmtUC8vIeCermC+SVX6pTDqzqPJt?=
 =?us-ascii?Q?xZ1ey4cPymwyYwRa6gZtR5HJlyOYWNC2yHdC3lgdpMn32rFBOtOjuhvsZP9i?=
 =?us-ascii?Q?UOUkbXQQSXiNxUemc93d5ulndtVuEdxw1WPw871cx6FOYuVRgZFN4+wRDwF9?=
 =?us-ascii?Q?eDACQ0mWSOZmRB20iKEL4GkNG4T1+zXqD/LVoMTf/uhY7mIpDK1eCOGj2s3K?=
 =?us-ascii?Q?UagFHfl9kRHmMqJMRAt1RgMM8aGtQHvCMjdFygrcttZMHteegG1M/e92kkHb?=
 =?us-ascii?Q?ZT/ml533j42qgnOzgs+WkZQpC4XgODRmUU9ipAiZOKMvxsOavDbZdYpFt8TG?=
 =?us-ascii?Q?izRxgO1nhhHhpzEuA8eKev/DdeaKIpIyLGSXNWYFEtshM+1r/Ez/rnRpWnD0?=
 =?us-ascii?Q?Ha2QAhcURZRNAv6sh9v3sugcMNPxnXOFoW2RuaUQymKbrk4ig1MQ5noomhpg?=
 =?us-ascii?Q?ytOi0kKD5Ks+qvmw3MSmSomj8m0HRfMKmAIQ8Yll8muPOh5u/HVk+nL/EaAf?=
 =?us-ascii?Q?7j7PWngcg16JbUHj5B5NlvF7pVrDPbawSoGYWq3pwvJ4jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WY2Nr4MVqetSSSvfvONNGtebU2Qotlda9ij63lJxkkG2J6Mb3XGmG+/j14rL?=
 =?us-ascii?Q?Eqiic4pXreqXe/NhYoBNTa0YxmQkPXKhxfd5VoYdnpEXF8rU8Dno/lahXwCb?=
 =?us-ascii?Q?B3EcVptU/+i8HvWgAWP4h1AilceuTKyAYUhPbenCHdaA0Uc6JFGA34pXLzEy?=
 =?us-ascii?Q?/0v6Un9ximRGNQ/uIfscavsXi7flJHCuuMCJeu/XsQzLLMXXFeF8qByMTnL2?=
 =?us-ascii?Q?wba2oGOIuOTSw4BaG4NvNz1TIJ0hW25WanXitslA0c0qsVEdw3+F0JDITPyy?=
 =?us-ascii?Q?QaR8B+hj1omgFP35LIVyJ3xEFn5Y9EO7eAtVVYsndsVIAL7V45nHua93B1pu?=
 =?us-ascii?Q?HWGCmwvkN6pfOe9u66SgCpd6nHGs9PMREwOlyU6bKx4CBUYmIJS0glmY6C8/?=
 =?us-ascii?Q?1Lnc4eHzg+XZ9gJDb4kHaYvBtUDd1VP2v3ZfGHZHY8YvgfU+KKPH56YSPVg1?=
 =?us-ascii?Q?qLwrlLvWOlROI2t2badJaYJDgBJxAtr7/AcQA2rbjT/+VmaH7I5vvW0N/5jp?=
 =?us-ascii?Q?L4bk6agxiYxascQ/4O8rcIKMBuLmh+9Dkh5SAp9jvzJy0GxnzRVAuKjD78SK?=
 =?us-ascii?Q?pgUIWnhrcV5RhFpcZ5Zw8PCw79PMll8ElZ/fICcc4PkfebScqH1yWfRkr0Pi?=
 =?us-ascii?Q?EQgeK/laqga3TDKOSmOZWcmeu0TapjVa00c29KcHwdEro48y4EtviYGdBTtw?=
 =?us-ascii?Q?3uQ1z9ds5eMFeKD1rCA4E8HwH7vZcbqp+0yLPvhlxPVXrlO78rE8vthiTdVJ?=
 =?us-ascii?Q?4RJywp8cCFHKv+25+eL4BOl+4j1ZQQhpnmYQOQsDWieY2b1cVsc/aFX/lN+d?=
 =?us-ascii?Q?WDOtcqkPs+Pc5Ko1PswLG4rAj+38TUxfaWUPTqhOL2W/gsOzwutpJRdEEuTE?=
 =?us-ascii?Q?CljQq35ACU36exKnhG2WhbWE81m79mY1hfJDAaWXdmzPjGdcslL+vpEDj5b1?=
 =?us-ascii?Q?txSUNHt3GDgIdBM7e4SYpHIObycQ85xG6ZLw8FjYrD6Mz/1kFnawAnvkDM80?=
 =?us-ascii?Q?+YHriPhQuIlcL7Ia6hCZOnU6ZXTVqtGfAB/nxQnwhzRbIWeKzVKHzYEQJCwR?=
 =?us-ascii?Q?g/vytRSW3ST3yrlnNmJtm8p4wfIo+ioT0SMBAT5AVpcPww8g0G8K7bOnmrOD?=
 =?us-ascii?Q?kCULbqNvVRiymI28SK10Yq2+n8huH1b2g6ZdB9iDVLfX4vB85cX5P4KGniWO?=
 =?us-ascii?Q?b7PAX57lor1eTwUCUpCDnvaQWKEYi1yTkC623BVJiNbJEq5BDAh/15V/Xn67?=
 =?us-ascii?Q?2231xcK0cqHd6dB/aguqx5bdDEDHyxyOVVVgAl5ISvQpzKNWTTFA34jd14nJ?=
 =?us-ascii?Q?5IjeWxk+sZkEqaU0YJ/kkmrEhdurXjS0s+J3G5Yyo8lFjsLu+udBxIPcp0Wb?=
 =?us-ascii?Q?mHV14tPI1njS0zdz3u7rCuggzX11sfPsjUhfFLZH4KJrZtnRNkAQHEJjBGXE?=
 =?us-ascii?Q?lu4c5dMNS/SNtLvJw2XWkjb/r2V4C41FV2p/cu+snDGycv+OOoZbDfhpYnnj?=
 =?us-ascii?Q?ffoEwUN6rtywBoFsg76EubdfxQtfAuey3xg+vytAX638B0ppFZkcnKsxcQAg?=
 =?us-ascii?Q?hUPsyrMYGUri9CKP0Z/vyXhiOFhP5Z3phq0ttyuL6TSSJHjNgT0MyCDrI5Sj?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c194f5-20b1-4bc8-38c0-08dce9f71e5f
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 13:17:55.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp6JqalPyUkWF7sqy2FUt/dohvcY+tmbJO3uWmyLhc68zds9lzcybfZn4dMt0F5GYdvReabHHkJjylSiYj+mWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1809

From: "j.nixdorf@avm.de" <j.nixdorf@avm.de>

commit 9995b408f17ff8c7f11bc725c8aa225ba3a63b1c upstream.

There are two reasons for addrconf_notify() to be called with NETDEV_DOWN:
either the network device is actually going down, or IPv6 was disabled
on the interface.

If either of them stays down while the other is toggled, we repeatedly
call the code for NETDEV_DOWN, including ipv6_mc_down(), while never
calling the corresponding ipv6_mc_up() in between. This will cause a
new entry in idev->mc_tomb to be allocated for each multicast group
the interface is subscribed to, which in turn leaks one struct ifmcaddr6
per nontrivial multicast group the interface is subscribed to.

The following reproducer will leak at least $n objects:

ip addr add ff2e::4242/32 dev eth0 autojoin
sysctl -w net.ipv6.conf.eth0.disable_ipv6=1
for i in $(seq 1 $n); do
	ip link set up eth0; ip link set down eth0
done

Joining groups with IPV6_ADD_MEMBERSHIP (unprivileged) or setting the
sysctl net.ipv6.conf.eth0.forwarding to 1 (=> subscribing to ff02::2)
can also be used to create a nontrivial idev->mc_list, which will the
leak objects with the right up-down-sequence.

Based on both sources for NETDEV_DOWN events the interface IPv6 state
should be considered:

 - not ready if the network interface is not ready OR IPv6 is disabled
   for it
 - ready if the network interface is ready AND IPv6 is enabled for it

The functions ipv6_mc_up() and ipv6_down() should only be run when this
state changes.

Implement this by remembering when the IPv6 state is ready, and only
run ipv6_mc_down() if it actually changed from ready to not ready.

The other direction (not ready -> ready) already works correctly, as:

 - the interface notification triggered codepath for NETDEV_UP /
   NETDEV_CHANGE returns early if ipv6 is disabled, and
 - the disable_ipv6=0 triggered codepath skips fully initializing the
   interface as long as addrconf_link_ready(dev) returns false
 - calling ipv6_mc_up() repeatedly does not leak anything

Fixes: 3ce62a84d53c ("ipv6: exit early in addrconf_notify() if IPv6 is disabled")
Signed-off-by: Johannes Nixdorf <j.nixdorf@avm.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 net/ipv6/addrconf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9058d59acd0a..7763b7f672fa 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3679,6 +3679,7 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 	struct inet6_ifaddr *ifa;
 	LIST_HEAD(tmp_addr_list);
 	bool keep_addr = false;
+	bool was_ready;
 	int state, i;
 
 	ASSERT_RTNL();
@@ -3744,7 +3745,10 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 
 	addrconf_del_rs_timer(idev);
 
-	/* Step 2: clear flags for stateless addrconf */
+	/* Step 2: clear flags for stateless addrconf, repeated down
+	 *         detection
+	 */
+	was_ready = idev->if_flags & IF_READY;
 	if (!how)
 		idev->if_flags &= ~(IF_RS_SENT|IF_RA_RCVD|IF_READY);
 
@@ -3824,7 +3828,7 @@ static int addrconf_ifdown(struct net_device *dev, int how)
 	if (how) {
 		ipv6_ac_destroy_dev(idev);
 		ipv6_mc_destroy_dev(idev);
-	} else {
+	} else if (was_ready) {
 		ipv6_mc_down(idev);
 	}
 
-- 
2.43.0


