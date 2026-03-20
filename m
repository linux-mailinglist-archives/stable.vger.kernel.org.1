Return-Path: <stable+bounces-227622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIu/JZCyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:48:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E6B2E1007
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D783102E64
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153D368272;
	Fri, 20 Mar 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Se7dO+0C"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7C36403C;
	Fri, 20 Mar 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039555; cv=fail; b=d1bpGgqkUoHuNfTt9TgIv2LlNROXpLrvwDoTkBtqR5IcaOJgB9ldmfd7S2Q/ACAzr8nB66cNP8yqgakMQab6vVKU76EUSiYqz4HryhLORBTMzKKQcSW1VvrEggtKfDzIOmYeERn36XQBXEFhySnDS5zvZEge4NlwcdbosZUStBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039555; c=relaxed/simple;
	bh=7QOKNFOJct6QrYxUNNSOZ+w3vVx1rEYHQ8HC2nnyrCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLkYUM+71dKaH1ucs41kbE01gWcsSn50TBx2Q7HXwmYrm0/way9gGQOO/wtlLfmOVbg8sZn+5rUbCLfQgH5+afL0QM8mfuyga1uxf78KmI/397z/cvKKHB72WDnNrbP75GgCr3tcdiwk52ociMYkfrnnb+0iqjta+tt/EX/ysEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Se7dO+0C; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8ad4J947177;
	Fri, 20 Mar 2026 13:44:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/t7FNfIZM7BrEgX7ee6KFEwpES1VDDsaEGCF2rgP7hY=; b=
	Se7dO+0C0gCWJPC8eZOzgcwu5mq+a/boYZtbHGiOMRCX+vbhqgbykVsR2Su03NWt
	9q8TpWrBqDisprjgE/niUNyPZfcLFmPAj2y7+n6M5ks5bPCt/qdLohiYQXTiu99Z
	iVXQa0B+FTNPhvw2HvYyC6VOhsLn++z/qieIPJhx0pMcgtnlm9axMIQEvuzW1fkZ
	IHcFZ0aESm1wzxV35p3OVyKd5Fuk4BwUevHKWt5k8CO0IV4gwsHTncrJep0iMaKH
	0Jrd5yZcggSA/lerb4jGNCUtGqpT3Hc7t7xqFrq6UxSOc+ZJVRB05s30VwoTHG7r
	YE5b3HIpU3MKoouwq5R4Iw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y18k1q-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyBN2HwHSN/OdrOyTsS9KmX6GqOS7TIYXt+mtkEMaXZeJQzVzvCA76RytKOR61tcJr0mHgkfPiP6aGzZHkM5wJDSTxkROGjfYWIiIoT9IMoPzRY0aYxJ6MRYY1bIARUnHYUZMPeD7WaRbBjvNUucNR/tOvIAOkn9GomFuov52i1f/vPI2EJRGxacU/7WEU17PFTQQN8XFgcqiqJWXc+yo0EIG0uhesHo4qOm2tenkN9fho0FEbmfj1hzyL9rwTY4da/jo5zlO7MUoP5Ri3kYRf0GcZK6fud0r8uuLQpxqXP4VWMElsm1CIxhh3EUxnbX56jUe/vWOmfRRFi0pq2ruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t7FNfIZM7BrEgX7ee6KFEwpES1VDDsaEGCF2rgP7hY=;
 b=XV1wIsnvaylEBZBe0pp6PZx8owcG54uD0EvmoCYiDO8OqyIikhksr7JBTqJC6EnJHKJoxro/DbkOg0T1lrmOaU0QtvNoUgEw2kGr4C+ux7SaQGcBil26XdRdcl3B7MqPM2j5svYCC7xia4iVaePAHDH7yHC5zPICIHKAJWflcPeRCt1a+0OVv9N6JJcKbCiypLEdfLLeU6NhvfuCqb7a5B4XqDaJbP03VfvPYrcZSUIiE3RA+KdUXjfRJc/8hs+H0oi91a+/5/nGu0PdwEZwwYPqUkArf8ikaM8ue4dK/OkW5xGe6bvN2hbO6dGBVZ/oL8sjkNUPK0ueawgU8H3Lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:44:55 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:44:55 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com
Subject: [PATCH 6.12.y 1/7] timer/migration: Fix kernel-doc warnings for union tmigr_state
Date: Fri, 20 Mar 2026 22:44:36 +0200
Message-ID: <20260320204442.32901-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320204442.32901-1-ionut.nechita@windriver.com>
References: <20260320204442.32901-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c88a8b-f711-4d5a-b474-08de86c18b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hKbuRYR/GcqpppFjyZSl5pFiJDrCBheNuHMTJXZFvO69456IDil3u2t+k0WO/CcUl98HF/akPMfYDi20Kj+T9Iz46DsjXGin6Ub9oFDuacUir1fERXc+NjhaEIFUiJdVI8gXHVgAKKwKIYpvaCxAWH8Iuy/bjR8xhanItSoLk0bZ+Knm6G/dn/PiAf7yCcUYrjWzSZXOIGbUN1Lc0BDQSFnfTakMapdeB5fdWPGum9ojkHywiomXMP0dGSECbARgQy0W6C48l32O8C76ZwloNEwNyWjlrUXdNcKGADOVtDdCqTKgSJi7r3xOf+ZF4EUPCNdjD4pH9129HtekOoIJ5DmVgK40nYppK1mFmrHsXPAyCoTGL73xMsW9sbvwKSeHa0w0cOUBdVMf0fBPhhrId/v4l5hDOxUEdJH8GT2p6uoYxzuBSbwH1ZzGvF/gsQGBCSYVTlyP4EZP3RcPMWdG+6FX4jKQWdciFczCpGjlMq8dF9NQuHtT4kbxt+Y/LweRIXsPBP8Q8kHO0cayr16L2lZf5ufZSMjEWPcxwIqF2LYwkSjtJWGbPyAcJp7upzS2sGoScMHu+gddJgws/4Q9R60X51atq8l2A1R6Ht2k7J6m2ny2Z9l1CaSzJCNlQejw+1/2t3Wue512qeeBODt2hx+DAu5yTGguxyC7Hv7QFC45In32lXmvQGF7AW61M7kWfFx/k98Dn9ALNPfs4t1lMv9RFwqG40zypUmJDTuaUDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zq/YKfCgnnmgvxItibaI8QeIAOLvgAU1KJ20fRzTMCBy+vcLKyhF3m0I7GVz?=
 =?us-ascii?Q?iIdO5/23eH4eZphYzHkmDffFk/gNjlGrzvd6gnRHsUm6hdVmwnI8TYOp1XUe?=
 =?us-ascii?Q?BoHpi/kRypXgOLDqE5e9U48otdGxqVCJxOaChHuZR9aVPjjcSm2Agob4JLD8?=
 =?us-ascii?Q?Vr0Cxe48bTJk2bi1c9fUcQT5zQTFpwS27xwj+UratWLLTpppvHgkdO9KBfF8?=
 =?us-ascii?Q?kXF/45ctp/IOTLI7LHDlzvSmGOqGhPJ0oTRDcMnGKIA88kdROODAL9VGvNsZ?=
 =?us-ascii?Q?ev6uZhUjhMc2JnqYVB9r4PO4CpETQ3FFpchee3xJ7yTvLQ1ClsxN7IzyK1Nb?=
 =?us-ascii?Q?PZeowu9dpuHdy96aKsaN0n+IbrXv7jgqKFMVF6Dn7MX1VRI29bKixZV/623v?=
 =?us-ascii?Q?RQ7OxZAXc+B1CrU9/SeTH7iVvOGqz8a959QgpB4FVBddUzotbl9Ak9jwk7Jx?=
 =?us-ascii?Q?9ckd8mTHatleWRnUyaSTvKA7LQxlu4XUJiUptypf3TS7ZUF2KuDLH1TcljJz?=
 =?us-ascii?Q?4WdTYnnvOE+YYwTaT5AycS/li/VeQ+U4KzSWixR55ZgezKFNCFzzOtFDwg2V?=
 =?us-ascii?Q?CePTgdZ3yXGGn7MZVR7VcUFrkOK+wImRFmNoxG28b/a0+IvzglPV7cp1CbCG?=
 =?us-ascii?Q?V6BdzjunyVLCH4yakuA6UvCufwiLhXkyVqC13TusKZu170do2fTyw4ADfK07?=
 =?us-ascii?Q?U194XuagLmPYBjia1T2ByLFL3CxzoBmFhEqIPvhWN2cIX2mHTZ1MB8yQP1l1?=
 =?us-ascii?Q?hKrFF5xKTlZOJA/zlRsx7WzuawJfHO58I/jAiScBkaQtDuNz3G4RXAp5kMfH?=
 =?us-ascii?Q?bJKLe13Ly1TYwWaL0QHqZyvw+AcDGqalUFqax2SUsgqWtXzGHQRsj8uYXjFW?=
 =?us-ascii?Q?oeY0nm4K/EOyl0ZH6pdxxe99S0372eoZpXGXeFYPNJtHqLiQd7B638VonKSV?=
 =?us-ascii?Q?luSvASnhjZErFzcTQpKQRmF3YtqAi3QrHidN12UvllOQ0WvoQU41FAZsWzHF?=
 =?us-ascii?Q?NZLcjgbl8qnC8+SClZ0680en1ZqXeNxdKuPDnMFmYGm/R9cqfarXUB5GcZiw?=
 =?us-ascii?Q?kqaKEd8vG9ulOb25XtjXala5WkZ5cuqRBb6v87QFKZWb3o5JPXKGI1ND44zv?=
 =?us-ascii?Q?mUyzXhbwQ5CbZEJdcZeVmAtMThOgFrA2Is4uo0qLn1tqTyQJUBHULz8p31C6?=
 =?us-ascii?Q?/DspQcKwYn465vwyj3haErVsmdu/qnCmqWuegk6Weppr0ebS37d4luZUVCbK?=
 =?us-ascii?Q?rQbElSZ805gjqvTBkelfFmf7BiD5eLxWs0LF3nYgD0/Jz6nrixHpupC5gHpE?=
 =?us-ascii?Q?sCzIghyIdZwEU0QPIh2ZYLVjYh8V/5Ocg/GtcjwNRSDr8TDiUMDDio50zHht?=
 =?us-ascii?Q?sWtaVUDBpscg9RFLxfiCD8AnkUmoF3sTx9pw+HPFBMLLOUFm2ER/jQWmx+s4?=
 =?us-ascii?Q?iAWO4120nbymMII50n2UZklJl3gWNXxrScGfdxsPp0l6s+jElc8DdD90qvHj?=
 =?us-ascii?Q?fVnHR8Gsx3CcetQ24nUJJPxQSZPRWoqZkttDSdEYT+hLzTvq8re4y5hrzf5D?=
 =?us-ascii?Q?YgYyxyUJGZTu/yX342aMOL4BDu6Vf6N9KP2Cto6b5upAKw6gfrse7l4PuxgI?=
 =?us-ascii?Q?EOP58puKgBRQkSMWi9LS2D/9TVRxOQHsgoe1vG+R0PtHafvjPwVOnE6IKeLC?=
 =?us-ascii?Q?Hw9QTV0GPT+QdnLqgef4ieiht0gCDOAABu1f/922DqepiQZK7fzL8A8GXV5e?=
 =?us-ascii?Q?gOGMDnmR8KC4n3+pT53PS+v3TtHvGIkTrerRfEqsgU56KkxWLXQvk+BCbEaL?=
X-MS-Exchange-AntiSpam-MessageData-1: Qc2MweNVd4o62rGoDgMQXRL2r49IZaIc2cg=
X-Exchange-RoutingPolicyChecked:
	ikwq5eKM4OkKbCuQMnEClMwHUg0oiMVQ31ike3KXn7mCWJ8WXE0+dgb7Ehnlx3OGdAESpEVqJnJUozflukmdQSTb3ZMKDyOxPz/uzRf3hklVYbk0eVAz/6LpGWrAKQx+iskV9OQDsC2X7HgbjwQnuleR8Wzx9tRXJKSmeLOSRh1C93Z87fALzvIwHB0TPfHFOXPtSH+cqGPMQ2O9KAkJSB08jT2LMkpvLGpng61VLM0HQPM5WPfH3EDHkvS/pSbPx+KyxHIOgB/nQgl0cee3Gz/DaHMpcAo1xLlsQ13fFBxByLGGopB6xTZGeJ7t3k9vToYGvZAYxGCO20dMv4Q01w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c88a8b-f711-4d5a-b474-08de86c18b39
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:44:55.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCOOW0dPRkBAskLuS7okNqLmdSW3lIV4tBjdwRckeLSYN0NBfjXvOvQE5eDE6oGgzcoLnhGaN1yaTJJEXH4XbudQn/mZJ9AnyGMmFEe1hFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69bdb1c9 cx=c_pps
 a=OGRNNHJcR/XwrOfql3gobQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=W8OALlVFJKLW7RJGoGYA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX6ANZaI5FDO/f
 oOYebyDhfJEcOT0qFYyiWcmN5gcQzm6Tj6jssAAZOyUEKoZC6ZpAdf3KApiA4eSr95oYZhlOgN0
 EgDfFNjR6dXAa7rg53BQ7aRLOwXK41mv3F5FtrEfPyhi7L377fvVGaAUvo9o01dDMxzs++78IPe
 sIg6c5tQaD9PLC1qZU0QpBKSWfIMFI9kZ7Hpy0gkvAbtQYlE2eZ6YXfLm8HiLC/6dMGC/TwzQfR
 n/QPUC9v0nyRTyCihpv5H7cE8rmfGInbtEXahogKDDad6UhmIwfDFb2r1qanIK/Q49O06/wmIM9
 diXIr+vLRZS58f345nLRkAwroX1ukacf0NCNfxd3pL94B9uEcn/9QrVvHyran0uYyivorAUfG01
 Ne9p6IgHLTEVkmJstaiFQpieMeghIc7YRdQfRNdri6OauiSQDX28wpkz4AwQE3qITc+gPardFdV
 ftAo2QpeVx5ocPfbtdw==
X-Proofpoint-GUID: XcvlhxTfJGdX187zX38XEXKeRbdqSElY
X-Proofpoint-ORIG-GUID: XcvlhxTfJGdX187zX38XEXKeRbdqSElY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227622-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:mid,linutronix.de:email,infradead.org:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1E6B2E1007
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Randy Dunlap <rdunlap@infradead.org>

Use the correct kernel-doc notation for nested structs/unions to
eliminate warnings:

timer_migration.h:119: warning: Incorrect use of kernel-doc format:          * struct - split state of tmigr_group
timer_migration.h:134: warning: Function parameter or struct member 'active' not described in 'tmigr_state'
timer_migration.h:134: warning: Function parameter or struct member 'migrator' not described in 'tmigr_state'
timer_migration.h:134: warning: Function parameter or struct member 'seq' not described in 'tmigr_state'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250111063156.910903-1-rdunlap@infradead.org
---
 kernel/time/timer_migration.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 154accc7a543c..ae19f70f8170f 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -110,22 +110,19 @@ struct tmigr_cpu {
  * union tmigr_state - state of tmigr_group
  * @state:	Combined version of the state - only used for atomic
  *		read/cmpxchg function
- * @struct:	Split version of the state - only use the struct members to
+ * &anon struct: Split version of the state - only use the struct members to
  *		update information to stay independent of endianness
+ * @active:	Contains each mask bit of the active children
+ * @migrator:	Contains mask of the child which is migrator
+ * @seq:	Sequence counter needs to be increased when an update
+ *		to the tmigr_state is done. It prevents a race when
+ *		updates in the child groups are propagated in changed
+ *		order. Detailed information about the scenario is
+ *		given in the documentation at the begin of
+ *		timer_migration.c.
  */
 union tmigr_state {
 	u32 state;
-	/**
-	 * struct - split state of tmigr_group
-	 * @active:	Contains each mask bit of the active children
-	 * @migrator:	Contains mask of the child which is migrator
-	 * @seq:	Sequence counter needs to be increased when an update
-	 *		to the tmigr_state is done. It prevents a race when
-	 *		updates in the child groups are propagated in changed
-	 *		order. Detailed information about the scenario is
-	 *		given in the documentation at the begin of
-	 *		timer_migration.c.
-	 */
 	struct {
 		u8	active;
 		u8	migrator;
-- 
2.53.0


