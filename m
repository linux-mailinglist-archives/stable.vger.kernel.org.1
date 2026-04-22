Return-Path: <stable+bounces-240281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF2PFeBs6GkSKQIAu9opvQ
	(envelope-from <stable+bounces-240281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:38:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C58794427BD
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A956B306F95E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8514831F98C;
	Wed, 22 Apr 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ncJKUFO6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F73101B8;
	Wed, 22 Apr 2026 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839686; cv=fail; b=blDTOsLhPCLXEVNVj3ePAHpNrCau9NfzwB99TOKkZWmpD1LgtL+i+MyiQa0kTUbyx2tqJS5X9s5QpiuTBVyuGc2+ZcwKzdWlIjxygpzU+LYpmIRzmk9Qc/FgQKciMDbiq3NeYfoE5GEgCZHtDWj6oZe8Fz+BJffrBDdz8Yu0W3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839686; c=relaxed/simple;
	bh=vrJgq2ubLedxXwnejb8xqvFNi+iBVzJof5NUXTpqQ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMq0NsgGJ3+YAGOkTDFlJ6ax64vOpyLfEA00g9gpI/xmH60CaMfG7phY9AeslWiV07xtXfcPdP5Z4QVndO0TbBtDnrWjoxs2DTiVe1o006bhjnCvsPQd7QTSXnmAKei6w258SCPEeuzPm3XjVbM7x1RcxH+0cesKbWS1YxjdzXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ncJKUFO6; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5gD6q943792;
	Wed, 22 Apr 2026 06:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=edruRNhOFxoTqLpoRttq5X20SXLnytn48rYp1IqcNcs=; b=
	ncJKUFO6DchRS46poZs7L2jRYyXoTgo42V9slULzqi5b/ebO6BocjuhiYxjju5nl
	3ZMcUrADFGfbpYyzEMponkOxp4JDT1g671Q/2kXIOOkaiAnyIDOixq1iEWfMxmJ2
	CTnXZqpX75VEeagnWpoy0CNE/SFza9fW5Ztkl3YwbNkoY5R5XLf13evLjk8D+ybP
	aBxssiczL4uwdNkgua+Bz57e02hOPPhf4gh5dUvf/PgAz4KDpJ/bxzN0OQiWncfi
	GzXBEQUmDB6d8B7JRl2t31IBNXim2AmdyJdpPWt8MHhG0A1Vn8k8EN24971Cmq1a
	5nOVuXlnu6NsxeQqQNUEEQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dpenv8hep-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:34:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MW++Ox3gcMUZNvBPGfMhFujwz/XXty5jeCf3zEbUBNXfwAgSynZiOIAZ+oBxUtRRLmOJ1+WD8UPcR22lTwCqMI8Ojzl1gddQ1UK62JwqnjE/ATYU3TTyP9FMCttroKQPphO/Gqk2/FO1DstNckkDOTE7zcKL2MoA6uiP1h3vtxfTu0CsU3B10V1UzDs/EJ1nMEJDGnS2rey3Tg7N+UmNwQ4GMa8VkWN0tPGkIrSbHvqtGaZ/lzkEF64NErzXWc/31Yj5DzFY9RslgR5bJElfRY5zIorCOO1tVZUvHdaITBJsmekXIQMqv8l4aDsMB2ZRHJWYl15kk6GfkcaHiKUisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edruRNhOFxoTqLpoRttq5X20SXLnytn48rYp1IqcNcs=;
 b=h+wHBdlN+D30Gxg0a8c3OohMykJ3cjti4y5O8XVx3A0wNvFTa9294adbqoLrCvfw4XikwbhKRdAI2dgohhkkIXQiP7N8z8j6mMkiDWXNQJVi+y80SJRTL1B0shHmd6TTsNS3ShJPDKjiT6ppHsll6d8x08daQKGogGgaCdazcc6AQ58pK5xg5j5mlHRPMieChk90uIyNGEa8T8VsUEGtSmHu9kWWee1x2Jm+kfJJBCd8X6pD8fKuhk6iEFNz4S48szPzT3X/6p9/RldaBinDth4fQbXTpI4IjIYmCrDqiIezn3R76RCj3op1mDUz6fwgzgjYDssjp7FbKLDXSK3dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 06:34:02 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:34:02 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v14 2/2] PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock in remove_store
Date: Wed, 22 Apr 2026 09:32:42 +0300
Message-ID: <87f609ef2eb1308daff16fa943ee204f5bdc40ea.1776839248.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776839248.git.ionut.nechita@windriver.com>
References: <cover.1776839248.git.ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIYP296CA0004.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::15) To PH0PR11MB7541.namprd11.prod.outlook.com
 (2603:10b6:510:26d::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb5f609-14a1-484c-c507-08dea03923f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|52116014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DLS1E3T0dqlGW1YNkU3ezEZmo3oLx1pp2dKZkNyVm8owdCwciB93HS1nUdC8kP3dt5zsiNWZl3QnfUkMYUaXSKIeWDsHX6wMTZasWeHp+DrrjtkNp2xWiJrb+hD6Prc4TE3IjTmsSUtvm5BniNbw/xlyiZP2lUNlex4Dx0853SbUSoJm71MZc/KOeNKYdPxFYfwGALuww9altyjQ67m5cnxJNFRw7oRvNHvj97qGQ3T8KWecYKwky0CI39D8cEJrcXNAdyYQwD5T1CphIxnr0Ohn9FBPplj/g1VicN/tgpt9XV6leG0wvbvp/DAsSyk9nm1F2v7eUm5apCSYgY+TLMchbcm+k0Ov9tFVaure/qS6TGhskb+YZ5EmhKCZDEDsA7EFF8m/xYo/CBO43OyCwhtg5PzCZW93W0yTXPzFVLZR4X8hIFseQfwfyWjrcSo5uGOqTtzhfAaDHl4cyQIyTLrpgNU53oCKVtx852ry1LT1KoVfF0IqDChvHTUmAWbGFe2cIsJoBnMFde8QaIMqeqZhvB5yI84hHaPtWrIeoI1zmNkbbA0Xqs43+Nkudpx/ZbtUQp1M/JKptkdHuXqEpmUJilU1rO/i1TcwQ6UDnDfnEDGtx+jklOtFwOf9fyFnSmHxnqTR1LXkADDXhuH/m7ECSGhWW4wFhFP90aMQ/sXnKJXrqw32swIMWF6ZVHID
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(52116014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9pmhzNb+EX/FMQcU1vzc8p4Qj90dd39awkj64zaxUDMWwuJLOlLHuejk5cK?=
 =?us-ascii?Q?GrvD76ZHpi/qxPkV8kmFJHgBLDzBqjpjt+P/mYjPCEq+TpS7KZaJT988LCqz?=
 =?us-ascii?Q?ASWxrFrvV+q85clO8tLdga/31GyftWjYOG2GECXaFEz523xcCMvMYmF99+rb?=
 =?us-ascii?Q?pOGTe+6QJ14IP/ILGw8iqrms8fPZub2nXh8nEmLh+1RD0G+ohNJCFsE5oCIh?=
 =?us-ascii?Q?DL+iRBaC0UKhl+WWKYTx2b+AXZk7HkYdaMZ8m1mv1N9ih1QWQGR2JOXTGrir?=
 =?us-ascii?Q?+CFzlPWj39RZ5GrHZVzqWA599bq1ukHqqQrq5H3FXNW0N2rpAhPleiZ0EFft?=
 =?us-ascii?Q?1jcwQXbaaU39k3OeOLy7DLWVtQv5M6sJiCDpsNR0ZsMI31c4Mkixh2tiXexb?=
 =?us-ascii?Q?74HsQorviN0Jl0bXH1PwJqLnSrThL8+Dnsqm5QEw3LvqPGmF+IAM6HxCJZpW?=
 =?us-ascii?Q?n4gPSvQC/yRw1bCPLGq77Phb2CHyDlFlq/Rw3k1gkmoQewF1hh6pBqj83lTl?=
 =?us-ascii?Q?oS2dgFHq9UlddVLuxfEJ6X/kU8PrcBu1NODuY/jjay3ff1jp2NKTKrOZpfwS?=
 =?us-ascii?Q?3Gl/a2i2o2eI8g7Vi+PatjBEClK2XCm/+RW2XhxW/kRcmQB9FMfXA7mm3wds?=
 =?us-ascii?Q?qssUfIlk7bG41vvnp3aAF5k5iDYRDm5RA8RQHRYQS96/q+Ut9YH/b6Yqr6lK?=
 =?us-ascii?Q?ZfWaRSmh6R0nVhNfsMwfbQ/Sj3yBkL0YscT7KEFMXsHYI+ar0ddwDOWgpsSk?=
 =?us-ascii?Q?BMY2cYiv/qiqAYOwhAGBFK5T4yZFywhBkvOZ9Z702Qb43s07X8Kou5+NKsYz?=
 =?us-ascii?Q?IA/q5kuinwSyFnJVGHugrUb7oo92bZmCju0Qn91/5hDpZQjMSmPbxotGbNh0?=
 =?us-ascii?Q?mDILQApvwMtNjtujdQlLNqiLsVxAkH07/JQM2NWH0hHDv55QefxTx4IT/6+d?=
 =?us-ascii?Q?C/poH65ZCl8ZbZTaafotapRXC8tG4bjWy7c3jtHg9xSIiB8yrqzkmNcvsLtd?=
 =?us-ascii?Q?U+xmJU1SH/828BL6c/Pzcv3erK+aHwUicKDknMauLD2lyHxGsXwsf4uTg+DG?=
 =?us-ascii?Q?IeFLyoGTlSHkhQ1nwuoHrXL5U1m6eGkQsULLqQufVoWyYosAbecArmus509d?=
 =?us-ascii?Q?eUBT1mms72BNU4vYRkRI6tKQ93/DOUNLd/QVUx4GShKY62Zsb9YfH59CmO89?=
 =?us-ascii?Q?5nFAh4MMz6mT+YDVeA4VxCbXQ7VICaJ2Fpj4W9MIdmkpzUUfwlzlKml9IcR5?=
 =?us-ascii?Q?5F4STDbzX9uFjrjzPL1rTmpq9m3XG4OLb1Ci+4+k8jfT4pTjf1rzaP93fzd6?=
 =?us-ascii?Q?brtF11OOat7OYSJ6JMK0BJfPnWZwp6EUAYGSZ88cweogTpMPQww0F7Rvfao8?=
 =?us-ascii?Q?mEZNbfR8J5Ffsdl19mC0cxfl4jNLILyy6g2gReQeI6HhGTIb9Sn/IHuhRmYV?=
 =?us-ascii?Q?kob/PJdc2YhzBFIIzs2Tx13clJgW4AWMB6Y64XPk92G/B6AvHdYh4DNndLmD?=
 =?us-ascii?Q?8KauDWb5VpvBVyPp1qZAV2HknphUzj3wchbi/uVN+pM3KwW2PF82Nw4yvuMD?=
 =?us-ascii?Q?XXEnJsmZEd6WEgcBRfuJSiJUF0LLbiL6rkmDfJCA0eEB22spgzjayHTkvZIO?=
 =?us-ascii?Q?mJted/5j6NES5yF3YGsC+Fd4HPjNR4l0aTKL+UIjht7XQarNaQs0HDdSMgUS?=
 =?us-ascii?Q?gUxXuoy86AqJg82RVK3CjOgyo28mOWlJNDN5bwhh7PI61Eqx6QwAQ0iICes/?=
 =?us-ascii?Q?7QYjP8u/dN/CGfYmqebQFAcDVyFiSV4eVeQIlrRPP3p2I0EMMfAnIXu7LNNv?=
X-MS-Exchange-AntiSpam-MessageData-1: fPHmlt3z1dmgm50nuShZqrNoYuPB7p8Btr4=
X-Exchange-RoutingPolicyChecked:
	kn6wYRH0jAYTXCtHhAuNnPoa8Eee+qLqvClCXupoYe8YkcLEVwYomar5RBTE1NLDwEaLms4NJHawLQ5zVPTjLGQz/wgJkz17mMt6rJP6MpNOUtLfvyHF/RYxAPVqjPb6F9ziXJ2cM97ECpVT5aVQ26f0s1tj/n1zn6rSpzOM9VENh/leIZXYisvLbAL8Y3YKIRx4PpoVl85LnDyg2l6hOq1fYt2KMiv6xoHFBoLryD+mE/jKpnObNnu3FCkn1jy6zfTeP5e47Jwwmv+wT/SCTFPL1uzxHqD2Wh1ycYzyJPOFR+EegLFdlh8+NKihnkLi0InpFJD6IzCavlXwCA+sWw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb5f609-14a1-484c-c507-08dea03923f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:34:01.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCbofIRii7vYnwfI+m2xP0phhJCoSijVdLLViTi1YxDZW+XXvcLTOUD8ZqHA+PcHRJS6fypV4WUVPUUj3ITs3D8sUnElzUohJ0czTMefKGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-Proofpoint-ORIG-GUID: izl7XkIqjWzYp0mKzIarLw-qOGboySbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1OSBTYWx0ZWRfX+IFAwoYD046C
 Uw/B+NlEFflkJuPjPvXsp+95WLtKic8pzdxH2zCetkcyrAkT8mHi69zZFEbIcBaoP/Z3R+XrMjh
 gVbEq4OiH/HoLpu2Z/+fByx9vPEkyxuozaWhScPhcFVtzHb71EGs3mt3NCVswS8stQfXEDTVbVX
 k9Ys6RKETgFnAWOWkCEYxw5z+Git7YNjLJHTBW2wxT1bR4+aGEwldNzU2w2G2JRSUgpJQmee9u2
 TU8mUvv73vp1MTgKjOgixv9jJstYnvUsAYkRDKVltqTQg2mXx5JyT4i4Vb3Y5LwGRqb75vix+et
 1HH9KBG8fhEw8YLkMOssU+5vF9eqoSEgdeXi+Nk8+VfzpKJ8gBl4BCkov4RcKmiyYt4hfHPhhJi
 noSrTT9EKtx62RZjRW5UyHh7j5sbNqtYq1M9a6iwnqLfQzDRPXDUhy7qO21cVzBu85znv2i4Dh4
 ngMCQiv+NnQxefmxcoA==
X-Authority-Analysis: v=2.4 cv=B9yJFutM c=1 sm=1 tr=0 ts=69e86bdc cx=c_pps
 a=f0OpuPnQRmDrWRgsA3vZMw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8
 a=mm2UkWPFonPHBTd3Hn4A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: izl7XkIqjWzYp0mKzIarLw-qOGboySbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220059
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240281-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C58794427BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

remove_store() calls pci_stop_and_remove_bus_device_locked() which
takes pci_rescan_remove_lock first, then device_lock during driver
release.  Meanwhile, unbind_store() takes device_lock first (via
device_driver_detach), and the driver's .remove() callback may call
pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().

This creates an AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Fix this by first marking the device as dead using kill_device() to
prevent any new driver from binding, then calling device_release_driver()
before pci_stop_and_remove_bus_device_locked().

Marking the device dead closes the race window between unbinding and
removal where a new driver could theoretically bind: once the dead flag
is set, the device core will refuse any new driver probe.

After device_release_driver() returns, the driver is already unbound,
so the subsequent device_release_driver() call inside
pci_stop_and_remove_bus_device_locked() becomes a no-op.

Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net/
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chlorum.ategam.org/
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..1426328e9f05 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,8 +521,36 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		/*
+		 * Mark the device as dead so that no new driver can bind
+		 * between the unbind and the removal below.  Once the
+		 * dead flag is set, the device core will refuse any new
+		 * driver probe.
+		 */
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+
+		/*
+		 * Unbind the driver before removing the device to avoid
+		 * an AB-BA deadlock between device_lock and
+		 * pci_rescan_remove_lock.  Without this, remove_store
+		 * takes pci_rescan_remove_lock first (via
+		 * pci_stop_and_remove_bus_device_locked) and then
+		 * device_lock during driver release, while a concurrent
+		 * unbind_store (or sriov_numvfs_store) takes device_lock
+		 * first and then pci_rescan_remove_lock (via
+		 * sriov_del_vfs), creating a circular dependency.
+		 *
+		 * By unbinding first, the driver's .remove() callback
+		 * (including any SR-IOV VF cleanup) completes before
+		 * pci_rescan_remove_lock is acquired, ensuring both
+		 * paths take locks in the same order.
+		 */
+		device_release_driver(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.53.0


