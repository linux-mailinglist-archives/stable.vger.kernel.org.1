Return-Path: <stable+bounces-109336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC5A14A28
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2BC3AA886
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5581F78F4;
	Fri, 17 Jan 2025 07:29:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BEE1F63CF
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098996; cv=fail; b=gMLPXlL/c19MEuShFnOVBBn5g3HaQvx6oSPRoJ5+WSqeHjZv2c2Hb/XXmvaMxve6fLWVr+6uQcDvBrF5U8JiKJn3ho29uuGtHvJvDc2CVLtBcOwHx4SzarGylJsK8cmOsd5d3pw+Ka985SENLeMKSNRrR1xdGyBYIeDe/ZVtpAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098996; c=relaxed/simple;
	bh=lwi389TV/4bSBZ7qpq5MSo+IyJ+s+VMfZ8cX4sU9tnE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HWL3Jpu9KyXZ2tr0BdxA7+/OHLvKuqkbuTvkY+fk48wYWojzcNwI8iWj3V777UouDO1JuifRfnMadxIpq3aSsGnkb/YQQ96U8k51ujeOrTngKcOgzrk6xCrra3DBzZJdjKqt16Q6w4+f6Dx5RFYHN1Ytd3vgtnu/EaKP6urWMOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H5DX1t006312
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 23:29:47 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 443mt76c4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 23:29:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpnUUAnm+aDt7ukkXvKrEYq/ehSNBk5+T4KTTMjJQ+vrUWTxQmDcRI9+DQrLPfFwFfKYwtgTlLXGDZoNOjKegydARuk7jRKeNehxVivnhqdYBGqQFfQQouR0x9w0f5iI2817y97e2wU0Isx4sji+Rrf9+Jla4u4kJBDn0/0c2jiy52DOMoDCCqg+XnmFRM9KDmB366e78YbT03/oe/oqYvZjSuYhklM9zHRkCCRTzq5J7LvRTqry2xyq37EFsbtqkjDdt71zcfHBoXONi2FsrC+OYTMwV0xiWzge/yVq4sKNFrtsIK2lISDQ+STy+PcLdYoZWhcAtJLXa5z5v9bEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBqmO4xjJsOE+MIpAXOfMslilsC7K1We6/BnP6d73Pw=;
 b=FO6u63hN1hxewx9zfMkNQNGBcF9censDeZSQgMM+mDvOfSf+tmQS+Q1fTuif8klK0YKC5Wn7oPDQY7BA47B13SnJry5VoC53oPU8987SbcMPjJ2JLCi56UGsIEYffkdu8a/tIuqzbEcj28Pc1qGL+GX6yo8Hz9brT8CYQMx8APvkMwwKplaDNr6BZgZ/+AC2xNfiqNwD4TTU+3+b8yBBiKImma3uylmjI33aJ8vrAZaJqm7IwN+ORom6/GOQt8MehgyGIl/GoU0RRL8+7qK+bs8DoBebe1HJjyq0wH0W3t3lDaUkKwLP9TeEN/hbnQb6xBE+9eo5GSyFyH+V/qPbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 07:29:44 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:29:43 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To:
Cc: stable@vger.kernel.org, bo.sun.cn@windriver.com
Subject: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when PCI_PROBE_ONLY is enabled
Date: Fri, 17 Jan 2025 15:29:31 +0800
Message-ID: <20250117072933.28157-1-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4ff268-0815-4768-3557-08dd36c8b661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9rr7fa7fNE+vUIw+wcKR3NoptdkwWOyoM4F0G3FcToH2rtXRxwppqIB6qhC?=
 =?us-ascii?Q?WYBH56ZxIkBVO68PzgSnTv4ehaNg6o6kiObZe7WsTJNVd4DbI+YP/NZkhEQn?=
 =?us-ascii?Q?18GSVMqc3mGLLS/FHoCzSvQtpAKfDGury7/9VXxzxyRX0XVwfAQPQc2e6LOa?=
 =?us-ascii?Q?UNn7HiWffEkdIPdEc4SNooyKohDxKyBecYPwju2vp8K04uDO/qMBxJvHX5yo?=
 =?us-ascii?Q?igOCu4tnm5xkID7QwFapE8LySonbIzU2fTKR6m1ltaRKkdZX/aQtEVzui/sE?=
 =?us-ascii?Q?9+rEE85a5gL3WnxnJ5749WStpkMlfCQyx64JY69kHIhqaFbf01GeXD2DhYF8?=
 =?us-ascii?Q?UfSyvnYjQz6EcvJj3zqPxwf3I129oifm/F6xdEOQ/wi+ROPYNlkwUp6hfXI7?=
 =?us-ascii?Q?la6bG5GUc/Jyl8kbb4Voqn7+T+tVcjpyL2EWw4hFcqU6jSr+jbSU6gShFIO0?=
 =?us-ascii?Q?BBy/bzvEBjERWnrYWSL/FKXhTxEZt7tPGfy2eskPokyIHoQLT+TTK0Ez/qbm?=
 =?us-ascii?Q?B68IjyU+HH8jqwknBGMCcN0yxFsoaJ07d/FocvkPcIOtslcZjJ4xVw4CXzDd?=
 =?us-ascii?Q?N7929D+jibZFDBVrfOd2NYxXplxEYFCA1g1F3H8FqdnHk4JGLbsWpaETnNib?=
 =?us-ascii?Q?19rTW9WY7VHy1iLGNDpOb99T6SDO/vWUhQ3UdpLQh5cmwaV4BxdktWouw86I?=
 =?us-ascii?Q?7Ph9xxKUJfy8Ua8ZmGDlNCyNNN1Z2KQIMEytvEOBydTHtUICIk0eThRU1LO0?=
 =?us-ascii?Q?xx7ov9KuZiyO594ClYHmIb3LNTHbCWiEmXwcvcjXUpbQk/HyXk99Gask374R?=
 =?us-ascii?Q?8j9Qb5eDwnzeBuzeo/Sw27ISE9QBrmP0c+zgKcVqpQviWiSOJL8HnyCNp2Nd?=
 =?us-ascii?Q?r+YL4mHWdyHCWE/5NXbyvs5ahMqUl80nr9RfqTVeLZkP84XHtsuUAvDiz20F?=
 =?us-ascii?Q?wvyP/TogpVZQ0VBH06tCi8tSRzYGum9ZRHh/3SNz9HFdjl7PqAg6LGO7UdLK?=
 =?us-ascii?Q?qDuCG7Ua1hFbHC2hv7eliJp9yleEatE86u3T0y9Oh823fEIQOxjQOWfedq1e?=
 =?us-ascii?Q?SOu/J8WODomQ7H23T0u0dGU0LzyC+qXlcYtMsWVEAdjyW0OJ1NX/hndjgtcC?=
 =?us-ascii?Q?eKjgz6lzcnT44oeP4j/pXd1yejAnoEsGcPSO1krGrfr2LX6IX6oloqT+3dlD?=
 =?us-ascii?Q?A4mki37ohEzIzTKdaucTE89rxdAbd/mWaKDLlqsoLt8dYXSjz++TTjZR5uIg?=
 =?us-ascii?Q?tYPeyYviP4P+rZR5PNSYbjQVRZmkQZYh/CnmnNG8B+HgPgCKjQ4mse/H96q9?=
 =?us-ascii?Q?dMZN0wyS5Zl7wHx6pbvTCdGvMuNRbkg5kokdYfAx+nmDurJNG30MVYUezBwo?=
 =?us-ascii?Q?kpjLCzwIfBdpBc2HK8RxrGy/MTa+T1PIW0pJMce2Xz+rBeBa+j+HKy02cBwg?=
 =?us-ascii?Q?nYJzlCq73+63pokcEMhV4vJyKh7691Df?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzQuD6FVPMtzxdlaqySLDhG6dbbIo5ZfDWlHGPHmgvzcZbWNbXfTx+wnaYkI?=
 =?us-ascii?Q?oryXI7upXo2gkHL0q410Rba3RAnFSIuO1GNz3a7sCCFDKKb9ntQIdlRf2bvo?=
 =?us-ascii?Q?7xnAprYjgCuoYh3dwvLLxJ3BsYHNhHrvJkesx+n6veqCyeWrgqtEUWKkySgi?=
 =?us-ascii?Q?RlceobvQ56Sq8TjGtqFg3+sl5AsEx0ZkrYUhJFhgIvJwh/HFd2c8WU4MJ3+M?=
 =?us-ascii?Q?U0F182hRqHYbqUMaVdA8bvh0+TcVyb3qUBYeTFgvJYTOe52g1DUGdzJXLtE9?=
 =?us-ascii?Q?4XXnqOtwyeD58sphglFOcqEX6RsV+WmHdWKhJRw8mTChh+aqOlnERWbyFZcl?=
 =?us-ascii?Q?re+YwPwetqHQPsjI97fnFViI0ciQdGAYhydKquktyVhJuPqyXZdbWZWejGOn?=
 =?us-ascii?Q?F7yHXHjcn86NrGfASzTJTQ3fm6sO2ImVa0tbBOu9aXAJaayO7Vem1qpVyZ09?=
 =?us-ascii?Q?A4iPv/q8CTJwSKsyDeBtP9+7Hv2vkRef73pY9SkVKoz/id205uu4zS+lqXY7?=
 =?us-ascii?Q?egAxm12uwRgLAQQ1YabVLBS0oledDPufGSqNiNw7caQUtVZrRUeRghMDZPup?=
 =?us-ascii?Q?X27GWfu5PuoMILQCSKkTkrcCYr9AFeCfEdffXJf9DvKUj6m3jFXrxjZaICMQ?=
 =?us-ascii?Q?hKGU5l72CXv9O84xZydVvTHviKcIuYROVDUvySU85ug/39mLj8pNixQeau/i?=
 =?us-ascii?Q?dE2vGZddZ1o2yPPH+DXLM7HbCa7sRuHu+7gCH2ynq1g58qJSNNiKhEHe+jLH?=
 =?us-ascii?Q?ygk+mjB92z0E6rnIj9KTDAGbRscMrgKZeZbK9fI0wmshbXuAzY3jWsGEbY0s?=
 =?us-ascii?Q?MDzzPkPQVSkJjh8uZPE7n63VD1daUtHfODPVlDD3DIR0bUp1N3oo5VRfmxZs?=
 =?us-ascii?Q?oSGe3u3cdMGJejyiE0wrrr0QN7kPR5uVN5BOsJEBLMHQMeb9rYndGLUPaMr4?=
 =?us-ascii?Q?3dpQpZ6sHGBpxdp2FtDzpe/nWjgNkOvrdKin3JfJRsxkdHsXxI4CD9vzBEVn?=
 =?us-ascii?Q?SbhqnV5mjBKi7FJ+OtDvpS9D1RY2WUlyf4ATgO1jgxpF2/heQqbO5GksItOd?=
 =?us-ascii?Q?jZwJZUDUjbX6n+Ga3ds3tnpdTlCurpx7HnLI8qIJaB4r/M5Cax8ZH9Mvk0XM?=
 =?us-ascii?Q?VK8Vx6TFQaJcG0OyusK+IX4998pGWz6i3t6yhrQyu3/CGn4+5LP9LId9miUG?=
 =?us-ascii?Q?ynFxNPkxoYva4+MUlhVWDlnh/HM4h3l8J/7f/30rdU03SU14TFMd0oYgg28G?=
 =?us-ascii?Q?2DDULPGvrJBp9kW/u9F9kW76ZKTX8lk3uCI2T1vqdpxDppT4SNWdqCsFShH/?=
 =?us-ascii?Q?YVglRrnlV9T+Y+6k47li948dFO5ULdteP9351G5lgQSvXmN+qtTta6DqxH90?=
 =?us-ascii?Q?Tr3iX8OMcid7lCe4mRfniJK3VfrDSQZm0SpUsloqgYke+Fbi9SZefjVQyBwt?=
 =?us-ascii?Q?RZrmSA+JBAZ6jKQRkWUZXBeDV1zhOkZoU9Dro50R4FE1cjHxrCl7SclIrj3d?=
 =?us-ascii?Q?QvpDtMy2DP+QIGiQ0xcGqk18EkBQ4i9DfzLUfQP8l7v6u4dOSRCqu4qs6McX?=
 =?us-ascii?Q?oK4Iw6f1UMLFM4xayEQoUvTOLv+14046Q0yYTbxU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4ff268-0815-4768-3557-08dd36c8b661
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:29:43.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLoDwzMpRfinIDdTV2yQ1uGZmDq4cn11zTYgt86teeuhPG1T18BicfExpDFHT2Mkv3hAtTWQcsho18AMc8Qirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-Proofpoint-ORIG-GUID: 6Xp6GL3e_jrghyBchfrU34TU9yViU8iE
X-Authority-Analysis: v=2.4 cv=SeoNduRu c=1 sm=1 tr=0 ts=678a06eb cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=OQzckKujYBuisFixx9sA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6Xp6GL3e_jrghyBchfrU34TU9yViU8iE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_02,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501170058

On our Marvell OCTEON CN96XX board, we observed the following panic on
the latest kernel:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[0000000000000080] user address but active_mm is swapper
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
Hardware name: Marvell OcteonTX CN96XX board (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : of_pci_add_properties+0x278/0x4c8
lr : of_pci_add_properties+0x258/0x4c8
sp : ffff8000822ef9b0
x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
Call trace:
 of_pci_add_properties+0x278/0x4c8 (P)
 of_pci_make_dev_node+0xe0/0x158
 pci_bus_add_device+0x158/0x210
 pci_bus_add_devices+0x40/0x98
 pci_host_probe+0x94/0x118
 pci_host_common_probe+0x120/0x1a0
 platform_probe+0x70/0xf0
 really_probe+0xb4/0x2a8
 __driver_probe_device+0x80/0x140
 driver_probe_device+0x48/0x170
 __driver_attach+0x9c/0x1b0
 bus_for_each_dev+0x7c/0xe8
 driver_attach+0x2c/0x40
 bus_add_driver+0xec/0x218
 driver_register+0x68/0x138
 __platform_driver_register+0x2c/0x40
 gen_pci_driver_init+0x24/0x38
 do_one_initcall+0x4c/0x278
 kernel_init_freeable+0x1f4/0x3d0
 kernel_init+0x28/0x1f0
 ret_from_fork+0x10/0x20
Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)

This regression was introduced by commit 7246a4520b4b ("PCI: Use
preserve_config in place of pci_flags"). On our board, the 002:00:07.0
bridge is misconfigured by the bootloader. Both its secondary and
subordinate bus numbers are initialized to 0, while its fixed secondary
bus number is set to 8. However, bus number 8 is also assigned to another
bridge (0002:00:0f.0). Although this is a bootloader issue, before the
change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
bus number for these bridges were reassigned, avoiding any conflicts.

After the change introduced in commit 7246a4520b4b, the bus numbers
assigned by the bootloader are reused by all other bridges, except
the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
bootloader. However, since a pci_bus has already been allocated for
bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
002:00:07.0. This results in a pci bridge device without a pci_bus
attached (pdev->subordinate == NULL). Consequently, accessing
pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
dereference.

To summarize, we need to restore the PCI_REASSIGN_ALL_BUS flag when
PCI_PROBE_ONLY is enabled in order to work around issue like the one
described above.

Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
---
 drivers/pci/controller/pci-host-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index cf5f59a745b3..615923acbc3e 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
-- 
2.48.1


