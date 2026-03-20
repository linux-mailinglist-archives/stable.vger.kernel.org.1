Return-Path: <stable+bounces-227623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFGQKpeyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:48:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208C2E100F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F7731088BD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4F366073;
	Fri, 20 Mar 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="KKzEzKIf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205B365A17;
	Fri, 20 Mar 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039555; cv=fail; b=t2fPDMvyO6RtYftpVs6iknkFDoqDScCbry49RwjW7A2MKbPqdttukf/379ckrz1tETOLo2YT0V57tbMQCxxepZCcijuwiLag2Z6vKyz8+u0nreEcLOG3V9PmqUTCF9x0Gw3jbJXVdHv1HJxWfhOzo4VJu3NydSWVSC6iAiFDU6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039555; c=relaxed/simple;
	bh=rcwcHlpEBCS1Mf4ElviHMFgaWj0HvERy7ItD+HceGX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyvZGElTIT2feoa+GVStJCD+o4x75BNgX5C/QAmCnar6DBOXqScSFsLEpNsbY7+se3rflwcI1UK8GhA2/q8HHywEpJyXG5twKiIEHLO9+bj9X05V8797GbWtm4CgNtSAwOsf5smSO55gowK/VUjX6dgnliRW7YRv6M9NZmkhrsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=KKzEzKIf; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K7njld216331;
	Fri, 20 Mar 2026 20:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=h06npuR6H8YcEVJchKJLhfTiqLHdaoa5iGGWLcfl1pI=; b=
	KKzEzKIfMbOdYLRDzzz3IucR/5LwUj8KXKJhBact7cegrT9PzBuJsjhHV0SX8f85
	JVePSsvFXVvVALjqM7JSUNsAIqTkHwA53+wttF7TEYk4r6ouZJRV3Gxuo8Dgph4p
	+GZ33GF//+QRidfrfco3tj3RbD/Gn/f+qVjagZhG66p4xExRhHHfDfqPimepC1Lw
	JQG4JDncvGyWqtlkrNryFxCEis3sauT3y5GxAGngC9w+P5QsBM7amAOy543/DJcv
	h1YuRPjoZHwmXQPspr72QukJJejh2udv3vBomQw409IhZ+FCL/1+DvvtTVFFFNC2
	lrDCQ2a7fq2ra13Bkw+3Xw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9anw3gw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:45:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0ytMXjdr/8dWyO/0sf9syD6WvfhIDiYv7Udg/8SxGiOQtbJk6jD/3yR30mzUMH5e4VZn3+Z1z1jFCQ49B9slpDqNAMufeuUX5IFv2RFoin+AfTezBCTFmAooNOalW5xccPpnLgZFaUsOn0N2F1MPSOmvGTeoFDZUlt5nY4mWxTRQ7NBjxVAwMARPuKp6SNjNwW1NAUv3vlgJNpKNxL3AjSWPqnRXUboy3WpEFH7uhO2njsImdvb+4zWyGhpP/qegohR6lZApXtd3+bK5F+40m8LZ13BV89bYb7D9fWsQf8v0TsaQjycqrympSn9cWkquiY64ghnEgbouSbAKg9xCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h06npuR6H8YcEVJchKJLhfTiqLHdaoa5iGGWLcfl1pI=;
 b=Dc9UWw6B5rV21qQ11IdWdUxBbBNDo8nRGKDpidjc6a2UH71txEXEmq4UuiGzrK0ltR8XnqCzpRRzp/o37vGCkC5NXI8NtS25o2zHWusM76M/3vyI5fp/EpZt8nmL7ADPouDTywtK7O7g//ulipfIEY9pITck9x1/6fuhkkj8g5++F6PicQm+U03MqRDK5qv+7wfKwM8EXFQP/ZSYneSQEANPQXHPMByD5297JG+KoQ4nf2VocDdVoWWtPFny84Yt+NY3ps2NWO+rZo70MIUJOldZmoJ3TwhHFxuuUjWq8AUJnhdHa2FMwxsIXUx8973L/Dl2RC1ZS6qVOa+u8DNszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:45:06 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:45:06 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] timers/migration: Remove locking on group connection
Date: Fri, 20 Mar 2026 22:44:41 +0200
Message-ID: <20260320204442.32901-7-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 171c349a-b4cc-404e-2ad8-08de86c191cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ufq08GTXZ9pz9kl8p35LB18W+xeo2RXrgg9dQWU0XAgaDbuGjfSR9tF7eq/Omr3h/2ugIV+ueu3IdL3CUwPZcTta52891bsJfs3QVZ0qPxqL59WxcI+OhVxtdxKfKemj0zTI7fh0P/cYH3CrzsVMHh2wKWvx8YY+5apehq+BVuPdb4FVtLuVGm4sIMJeEWsEZFhRRTCG5h6IFJ/Epp1XEkqXokoS14UnnkBGOoUpF6cLKJtRYBR254iz8+QNNTCbJBwW7X6YR+XUtB/ZR3bgVcWonXg874MhAku0AauR15pK/H3QBl7e5paI8//UjfZLNvLf+VYHwWo2FeaQRfdh6SFw9819hZgK7VhHASPVT27XFYyGZAReJqKsmXup5XDIKsDyWx/v1vEdtUGEsBOo4MiJhwc7DybqtlyvkNwMzgmKzKAR5kG3a2otsPaL8GgXcyhMbbkWeFmB+l/7XUiN/z2qvPrqkRhn3sV2XxfcA4DYRzYkIRw4NjGLK21RdAyCjmjoup1p5uxgT4d06MR7h6j7Mijounaxwu1ZL5aRjY74afTzbxEbaxU/p3Ocp0aDfRDP00sAK90eoiS/zc7qcECr5jhB/JdsN68sbFtsODuk0ztMT5saO8g1fh4RuvStjXz/9Kivzy9jBG+zSSN887l2R0G0/mPAMbwhP9KuSEpQp2aR1pAbDADCPP/ldcl+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8OAl6lB689WgadITbX9+QxN9eHeqJ2cx/JUk4YGIs23CeesHQbSoDprfjW4?=
 =?us-ascii?Q?78fQvWItiTy2ibBSzfcpa4zoId7GamAOor0laqJkmm+21zQWxZrX+BJbhD2c?=
 =?us-ascii?Q?jFSAVv8Sl2kxJ9+Z4tQy8lELuLsibSWb/BSLTlFGDlQ1zBJqtM7V3F9AIDh7?=
 =?us-ascii?Q?WkyMgan7ye+4KUUq3WGe0YUGIhp+1VJeyw79I64StbAaySfl1vVg3LvaLyqu?=
 =?us-ascii?Q?rvn8KDUQgwRGJIoJHg5cLlwM3ygZy5os9hTs4dXKt4vQgiuotySL9gjonu1O?=
 =?us-ascii?Q?tYxj2VgCRmGmfuAmgTG3wJ63h+LmXa+cxqXusm06gPgE1lfmG//EVvTcabmD?=
 =?us-ascii?Q?eY/svVo93PyX7USeVp8EkDaF974ZXp/2S+Gj1mgWoPORFgp+rYmJ8h1vFcoq?=
 =?us-ascii?Q?m+D9p8Bu2aX9knuwQFHu+rtk67Av2WY+B/S+XTHO6QPeiP7aXcptR9JXkhze?=
 =?us-ascii?Q?BQOcr+MJVo5GZ3KOXtzofNsPLA7UtLxGCTyjWBtHQHdxbDj8ePXQ9esob8jC?=
 =?us-ascii?Q?mXi8yDTEmCBA04e5I09fz8VZBFdi++0S+sk0wLN7X/IyQhcyVf0ipD/BCmYg?=
 =?us-ascii?Q?1mfB/pu/lKjs+h3AajCjP/NOm8QjMGssCQeryESe3eci81NTXw+paRAD1eEC?=
 =?us-ascii?Q?Ggimo9gSG7VEMcrEInKJDpJ+b8fI6p91hY30+VXMty67Ui09q6osP6i2VBmV?=
 =?us-ascii?Q?rZg0iHBcGgwq1bxBbbFRnh+1NgBlBXntSKyzFn4nw3HY8/sEviyPN36FTKWX?=
 =?us-ascii?Q?utKy0LPJGf9Lp9U0ujd6UcmQhI9X9vlY4VDDqQBhH36dphdGE+edWzXu4uEv?=
 =?us-ascii?Q?oKlAnGo+DGovvnnQ/2PgoWYGcM54bAP8+K96BfCRSso7Ev6GjcrkzD+sYuwb?=
 =?us-ascii?Q?OzS76llwNcOkbNERoCeQDMTEeVomioijgIap0Nd+e7GyOjj87/jSuD5NkZ16?=
 =?us-ascii?Q?inNs1Nq/Iow4IWNnB2hrn3EC7OW6ShUIlYSkDgPeMueniJXw/Zhy1IgClMVc?=
 =?us-ascii?Q?bsuNJ7Ik/ZiR1zLCNaIRBWXudGdAn+jkwZXRSn1yB63HSGoyOETD+Q4P4SOU?=
 =?us-ascii?Q?SkCJ2xVFElCqq99lO/sxHhNhcVrlbAtL4aS8jYq1jB0JvJLWGaNzv3XfgR0d?=
 =?us-ascii?Q?gQx9MoYq9CijL59bmMFV4QurRvE3zKEDBodqowDeacsxoUxgK6Yg5OpueGh/?=
 =?us-ascii?Q?uXMSffzw8DzFSNyKzyK5NbHSDHcnSqcrHqjQkLltoZiZ4pfoQXjux9EiGw0X?=
 =?us-ascii?Q?+p7qWtir394BVIcxkQPP3hPIu0CYez5vIp7/55oeaTO/+1hfExWte9zmsGrU?=
 =?us-ascii?Q?AzexqQnxP0Sh5x+xv1nKEeHLhA9/bh6W7ELODLVfHTmdq0ganF9d5x7t/Tbu?=
 =?us-ascii?Q?kPh0kZaQFw1QoPmvlZLKbE8DcTGKOIg836s/XGG5HWlZDRC66ia+2eNPPO5R?=
 =?us-ascii?Q?iemLAWx5wMxibCjGPf99r58kKS05Z9AKLhWAcbJ9ZjYcChN0m0/Pg1VoZ9AW?=
 =?us-ascii?Q?eRcVOrlY0gRYLCBjqi7I/ooztkSEe4MOGDI62z4cAmlKqe4PqiscXqP2HqgI?=
 =?us-ascii?Q?0miaizwak3F5NinpbBzgJVdFRVtuf31+BDuvRMP64bG2/1Rc8f9x1OOWZtXS?=
 =?us-ascii?Q?xZOkfxUyaCfTlpgG9Q1x73nruQibGeAtytfIJFfjW5J8REr9D1wnrpx0n2Kl?=
 =?us-ascii?Q?qkXPTiNZFn9BOOpba6GNPosT65T8GSg8hgQznZvUZCCvmnppnAx3f7VUvgFT?=
 =?us-ascii?Q?barkO3gfLbwjDRJXmk+RTKenoA7m3xj7jE6EE+WgAtBoibpGNpIYJ3UYYXS1?=
X-MS-Exchange-AntiSpam-MessageData-1: tl1fgumm7W7F1Xy0UAVM7laQFnl//xNGS14=
X-Exchange-RoutingPolicyChecked:
	CdtmI5PWfO4ZVekSp6rgEn/B3Zej0EE31CELDVjW9qTM46HlVNOmyqFAn0aMVhG1yyx6Z7LwJy/Kai0tm2fKjvExyCTy2O+J0EM7VUCnPouD3ZK7sSZK99EVAis7i/Fxo3meLvhSY6HlkmX7VY9q+/TZLVpH4W1Dnb+ySEp2z7tYWomIx4GzjPeTFDPAAcj7LhPPuzFkHUiVzCUiY0S9WiHPkBAypJIQTIgju8qH75qSVjSZPzeRq1COXD1rYlMQkYM2aW/z6kCoJ3al8hB/igXxgjF7757avgxaQv+4gTMtg/dXFHyCGBKF/ukxCwMcHJzlgWNhrMXiydt4IxfXWA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171c349a-b4cc-404e-2ad8-08de86c191cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:45:06.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTQpN4e/VbzhggQ6Evqy5SwXhbHI3Bxn2zqoBJ+3vTUX674mtIsNlv3pZPKajCeEQp/ymwGSMvKL7mBf/5TNQH+rjE9/0PvhzgKumRvrwOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bdb1d4 cx=c_pps
 a=ysgzExocFkmHQmNOaQPFvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=m8AVFSUq4rpQVGrp6HcA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: nPpCkqK0lwmTnWZrHvDf6JmC2Fed8_cZ
X-Proofpoint-GUID: nPpCkqK0lwmTnWZrHvDf6JmC2Fed8_cZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX/ku/XDLZCx+V
 d2MH4KFtQg7mQ4r79amGtFKxOsq8JDmRnq1Qw79JPGpspjn8ERr62ftzqw5PlqtU7AmmJg4KWBV
 b92itjn0ISQgk8yJLcCG0w0sfXJ1vJch6autg1drCqBZysX//xwM+rywismknxxdkMV4hPxVTKT
 imErV349GdJT87YRIlO1tAHOm20XQ2NE2AbYFvcuNCi3HrSXiaJPdwoboFoVZvxElZUS/70L45x
 dZOHe8yTB49fTP0LuikNr3A+MM7wXSeUAGshjpTSrldZLbvMnl0mNfWEUYyOXU/5FTlCBK/T9By
 GZ2iVeoFu9dglWi1E4O4lW2VzKeavrDywMHQAJbEocVU5FLxXzBwplyc5T3NjZztT4+I/HTYMSZ
 LvrmJKbxEKo92/GR2LQuRZ0NvPBLH957CbM0aNcIIbQEBG2jtJZ7BwAONIXryIZPRmwaR2L+ps3
 pDTnSGVJ0xW7W/Oyhvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227623-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,windriver.com:dkim,windriver.com:mid,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2208C2E100F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit fa9620355d4192200f15cb3d97c6eb9c02442249 ]

Initializing the tmc's group, the group's number of children and the
group's parent can all be done without locking because:

  1) Reading the group's parent and its group mask is done locklessly.

  2) The connections prepared for a given CPU hierarchy are visible to the
     target CPU once online, thanks to the CPU hotplug enforced memory
     ordering.

  3) In case of a newly created upper level, the new root and its
     connections and initialization are made visible by the CPU which made
     the connections. When that CPUs goes idle in the future, the new link
     is published by tmigr_inactive_up() through the atomic RmW on
     ->migr_state.

  4) If CPUs were still walking up the active hierarchy, they could observe
     the new root earlier. In this case the ordering is enforced by an
     early initialization of the group mask and by barriers that maintain
     address dependency as explained in:

     b729cc1ec21a ("timers/migration: Fix another race between hotplug and idle entry/exit")
     de3ced72a792 ("timers/migration: Enforce group initialization visibility to tree walkers")

  5) Timers are propagated by a chain of group locking from the bottom to
     the top. And while doing so, the tree also propagates groups links
     and initialization. Therefore remote expiration, which also relies
     on group locking, will observe those links and initialization while
     holding the root lock before walking the tree remotely and update
     remote timers. This is especially important for migrators in the
     active hierarchy that may observe the new root early.

Therefore the locking is unnecessary at initialization. If anything, it
just brings confusion. Remove it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-3-frederic@kernel.org
Stable-dep-of: 5eb579dfd46b ("timers/migration: Fix imbalanced NUMA trees")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timer_migration.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1e371f1fdc86c..5f8aef94ca0f7 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1573,9 +1573,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 {
 	struct tmigr_walk data;
 
-	raw_spin_lock_irq(&child->lock);
-	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
 	if (activate) {
 		/*
 		 * @child is the old top and @parent the new one. In this
@@ -1596,9 +1593,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 */
 	smp_store_release(&child->parent, parent);
 
-	raw_spin_unlock(&parent->lock);
-	raw_spin_unlock_irq(&child->lock);
-
 	trace_tmigr_connect_child_parent(child);
 
 	if (!activate)
@@ -1695,13 +1689,9 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		if (i == 0) {
 			struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
 
-			raw_spin_lock_irq(&group->lock);
-
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
-			raw_spin_unlock_irq(&group->lock);
-
 			trace_tmigr_connect_cpu_parent(tmc);
 
 			/* There are no children that need to be connected */
-- 
2.53.0


