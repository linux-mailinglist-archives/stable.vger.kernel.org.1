Return-Path: <stable+bounces-240279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YSRQJOdr6GkSKQIAu9opvQ
	(envelope-from <stable+bounces-240279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EE8442750
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5F693028F74
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F18316192;
	Wed, 22 Apr 2026 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="T4xoOO0E"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665331715B;
	Wed, 22 Apr 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839652; cv=fail; b=EuLrr3cAAd6WmE7HXsTQEJs4sKQdphOJ9/osfhftTe8ZSz4ByunPeSar8yaL9gXwvwy7S8txJIUtjlWi/un5uWXDnxnMHv5TyedGoKmbKVDun8W5Nt6rsnvlOtWraPC3cGzaBugwfn55EH7bW+VVrENs7LTVoC923yH4mPQniEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839652; c=relaxed/simple;
	bh=qXf/UOKBDtGoCnSSB0Nbt1WXrzelG9mCc44VckEJw3U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gcfF6RCFvcPFSvCzwHH2vB6YmbD+qUsyxg0vCsy7PtkC5zw3dXzpQN4NwOdcJMr8EL/E5aE6IHTzcYoQbmIaOW+k6R9T3Mj8C5gEr/AHOJlsTFnqIkkYU0odxLecw4sRFwFmkxIHgmhPh6je43/EqEjiPwa+enzNS60vOYbeD80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=T4xoOO0E; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5gD6n943792;
	Wed, 22 Apr 2026 06:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ESvO2PutZ
	hk0NcaQ4vjC1H09fBZq7IBT5hiLbepLMzI=; b=T4xoOO0E7makfWSzHc3fOV080
	117yB+GwxuU6Zq4qKpAzKQoYyoOALbjFSZqW90VSDaO+FvZFTY2AvCTIyUO6BzF4
	Ndz5/eXri9st2XsjknrX00H2M/7Bus9LVRhwSpvpw7pbn+Tc1PmEaRNOyI2iaQIu
	HxrmvB8BfebKyae1KGI+4kIXkkKlniYwTzw76WgzehYAhc7Cr3YB4cxVxfWj7pl5
	MDp8t9W5LNb3D21BqL1UPzIFbhHAa6alZGFH+TiBPjaU2n2ixAMO4Xo91uMlxhmN
	ckbjpI5HljVApFH0wgK0Z+sX4gPXHS7L7UNHWwJyAfhMbnRPBdfy1aKOx9u4Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dpenv8hed-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:33:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPsFmx+ZfwLSkegWYvFUVZAdAnz0TbzE6p/sl+kveGqJjunR+HVw/T3SkrcQkEs7snNuYt7au6HbpbogDvOkE7eft17TTuRv3+Pm6bWnQ3nXNfivkyUhoQv7e6vtSayTf1lwN5GiHN8gLLtHqoxgWck2CpTVpp2Hr8MV40kkAjGGHiwm1/Gf8NANRTMwXfTC2RuIgN2fePonsWpxGbMUaRFsqqQMqmPdJ2CHuPeTAd3XqCQGthiQfv+6hnYZZd2Z2fyzhcUVe6SHUobUGXyLNLZWSOi6nth6IWRaZ6An7DtvuTzjdk81WKld5dnvsmpQMi/OBfKqpX/ij2PJ+IhE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESvO2PutZhk0NcaQ4vjC1H09fBZq7IBT5hiLbepLMzI=;
 b=I1/snweYiYMJAvGMtqdSgWm3RT0Z6F3GrfTJJAlKNNh5lBTHpgHB3nsIbON5C++dj8PeCr6EEFGcZRQzEz/um/1f8w4Ck3KKeBra7SqqlAtvfi4gsKr3dm9sQYxU00npB6Pb/lEtFGRTGqIn8JJuxQwwlQh9nRzstH+W5EIBHGePZbtYC96DfxlcoWos4Jja8eNclykQQyB4PXS9TWjmsQAJ3XFcp+TaH9ce/zyPNTV1ZQgj/+eK1wk5vyLB1/vCblHk6TPmaNfAtfsJ2U4qL2iMcMaNDOKkfZYa+uNouwfEEtDR7r4EJafY9jBJ14WVj8GWPFog+AuaMfggPE4BLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 06:33:24 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:33:23 +0000
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
Subject: [PATCH v14 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock
Date: Wed, 22 Apr 2026 09:32:40 +0300
Message-ID: <cover.1776839248.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA2PR11MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: e7678a0d-6b94-4889-e6d5-08dea0390d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|52116014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fV2OvbE4M1rIKDydPd/2yudCBOwSRrubQN0CeSSvG5bcWO4QF/7HYEzZfIpXGot3FQ8wWI8geV6NZBbPLMg1W15FT7y2kJUToGYWRrTkIP5L7DWnrcDwiLp0b9ccLlDXEL+/svi98lQ8hyezfhDTYCV7IN9bSky5wgktIdL3+fkt5ITkzDHDUwVSZ0xLUx90UaWrc+iNnRvDXU/paMn1NONEYYpqHIq/XZmGnkJtJmq23b8GGl7eqjJXktQodtZ3/tzFKYkjRoMij6dKWZkXsl8tAezhqwkYnpIV3oYqcT1jGLGRQ6afjrB24qL2m0TNzPRYDD0qo1j+sbhZpkWWcWNPXh7cxTfnEhq/DEdKkfvpDtlU8u0HCSDbmZYL7l/zixkJYQw7GD6CIUkAGDd07OfTYenk3UYNJrxQjud4flqt6WyjTfxccCLOv1qnuP/1SSzr+MHCcIR1PKB9KyUqz1Msfli9OPu5Ws301glO0s+7VDV4BBSKPvkHTX6raCCbrmlALDo2BQnP/V0x3b8R1Lvxgm/I04EeJaNIIgHks6+lIZuMnwLdLjQiqs3dxmc1UO0FQmj5R6os/UM6eGgcM6qVW7diudA6p7oJ10y4bwnJfpU4cOt8ApSIW0sJMbi60PFZLgYem205WqYdg0l/jt2r6aiZkVEDeS62dvpWGzRGifAONBh0u31WsktYUnugP1MImYdWSqIk4LeAearJ1XetyW7eiDeAcWCPBxfTs+AWSREUId76yApfzFUYLcIi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(52116014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7R+G6WnsiaTmWRoAqs3TZaB4Zftmz6GBiIo9xtC4uldzkQCjcgVMDoUvc1Fy?=
 =?us-ascii?Q?DK6zU500cRXEO+sh5BynHQphSujhoM449RK2Qbkzxfi0nEl+8ogI1Q4kODcb?=
 =?us-ascii?Q?yuhvx0vJOaFiq+IgxjvMH9UlJbNzd2iGASz0/C/T2H4H7XROK8L6jqqY6Ate?=
 =?us-ascii?Q?P3TPbaoNNfUO5FDW8+dV+ZC1p8X5x1ys+7R9gi+ZuV3+PhqmBN3gGUqn74lT?=
 =?us-ascii?Q?8Tbh+nqjPGIofZ2cuP3I8ebImVZRC0izf5bP28HCkCu5l8H+eqntv8Q1/sxA?=
 =?us-ascii?Q?IRmsb4JjwItjBFOLPxJm3BHFloHWkahr6JiN89Ire2zfEmQ73gH6pMymg5YV?=
 =?us-ascii?Q?joezN7uYFUFPdcC7x6cSJjo7aqyMr1l8cST8PyhUedBtfNTgr8SrfbU4cG6r?=
 =?us-ascii?Q?2sxExQU/bTsPxPAP+enVAx5chVW02WCC1aoH69gybl96hGBsvLS7Ji38oKFQ?=
 =?us-ascii?Q?S6FC9Vqwd065l10ehUXuqnDyP2Cr7wpajCfob4XuRWtIrDC/yAjmXbzQ0qFz?=
 =?us-ascii?Q?v5kg9Iw39yIkZRNaS8mLcJPD5LdC4xiviaqvXuhq8fpt8OpFXcAQmKu24dC7?=
 =?us-ascii?Q?bV82a9bk+PRBpdyorMFg/aNitgIyjueTP0s8ukQefSjqXWsqXIdcvWm/7W19?=
 =?us-ascii?Q?unoxczvjAB9RPniROXmJcHNWeB8P+R4UjAfq125R77gcsqz9PYSfwr1WBOBZ?=
 =?us-ascii?Q?tH8QhWU3Q2DCfOUK5w1lCw0Sl66r3gPdQI8PdsV0rlurENSeVKelOUt03nd9?=
 =?us-ascii?Q?cL6SEQ0E+oObSKz7GZKbOqjkNzMH44jRqnLvM3WYvLl4/bwHXyDtOfJe4Hc5?=
 =?us-ascii?Q?IKn1f6FxquVHNeeoNJiVr/R8pW1LU5+TkEaPEm3GT8zcJoX5WOztLK2tVhGv?=
 =?us-ascii?Q?asBWxLB7C01Yc3YiihFrgIjGu9JyVaSfT2LoLapClUIyc+GRuVA6CFjVDt/n?=
 =?us-ascii?Q?YhNiHlvz+2YhOdzvoMsrdhUaHK4ytCxu3gHLmc9MoLyRqvEaVoL1Ik0YINj5?=
 =?us-ascii?Q?bupEVJ8QX/7z8O0ThJ1rax2556c3G0x20zzziytdJ0tq6mKkoKDwQaKMBH8x?=
 =?us-ascii?Q?ckhmoRP+ToL+DF0shnHs3Pd6b+CKIx17QI2sdTC1w+gLGDhPtgTRA5ONAwk+?=
 =?us-ascii?Q?H+ZRaSZFr5r04arDYA5aS/qjDA/GcMDCceCOdnY5ZUaePN33rz77MFJRHHB4?=
 =?us-ascii?Q?tJok+om+ZKqtKUzs5XKBiIuouVeOB7yz319E+aW1mm3FEGt9h/FT2Sq5J/RK?=
 =?us-ascii?Q?5h5ccT8w5PB5vzemHa1IFUhr9JajIymF1Iyrtlrr5Cfy3FVDITjFUKS45+3T?=
 =?us-ascii?Q?/dd8UrwsDv4IKcg52NjcpzxqNDvbi2b32JDCpKZIUyFkxg/R6nXJ0CKJxPyV?=
 =?us-ascii?Q?17Ibms+Av7OCHWwOIcvjlna4MKfOPlfW1fZ+Q85+7MhNpfWGeLoK091xngrd?=
 =?us-ascii?Q?kM5wnpomVLb91bU6+Xm/FSb7cYy9li0PeUdAF7BS6q/Rd0dZn4dmVqcMz1+h?=
 =?us-ascii?Q?vp4/8OjUGihvgVOkMWVk8V1UWFkOTt14J+0j0P57Q+lsKjtOXYQkkyHF486V?=
 =?us-ascii?Q?4O1MPkoQET/c1Tn5AD58ulbgyHupb8Nom6ANpT/SyizBwc3B17Tg9BDmNng8?=
 =?us-ascii?Q?fqh/5jyasr/de8oRlF3K6DmnwWZRH1XolaGAvW7JQD1hxsUgd4XdZbMUSClk?=
 =?us-ascii?Q?azIBwbDTOLKNz6g/DnoGFX0TTRo2RAzwGtAG4TWm7cUJUogECDBcBO3qis1/?=
 =?us-ascii?Q?U9vy7FoVJAg2NOJgQ60xF75bt2JJgDz9P80vbf67qgNCkH+gPVjN/k4bHTWm?=
X-MS-Exchange-AntiSpam-MessageData-1: FFvJjCAWvpj+RaHoqqjX+AKz3ks7qwVqJfk=
X-Exchange-RoutingPolicyChecked:
	H1xoMhX+qLSLpct6buakxevImues7shAyTPuJHFHO4zlNeFm8Him4C3ZdFXlH9B7fJdOBzsNcqbbR4zSYHhj7FsRm8/scoI7mc+2hta9naoHG4J+jBafbq2Zh32GrEYzKBegnN0JgLlWxOCTj2Ceu8hVrMu5oZyHYTPciRl2MHhH4qz3B3akPeMPrtpGOzI1YNfnd4bxCehEIps3GE+6G1uns23pwOv0+pDh8vk7OIVrLDJyTb+sbQtkrQw5ZuMEBGp8h+ZJcTdxrcHpcyZchFFcckZsoqff3qyFxGRlGhpQ4u9mYPpFdt3tL6QcFt8cJ+OYQ/pvcbWpz23xh5Csnw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7678a0d-6b94-4889-e6d5-08dea0390d3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:33:23.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzaEUwufn8CdMJHdOo8XylkNr7tw6611Rc75936vwJK53JndDCqErdcSumFamVrnaPYrcEFjhUQHyaaz3ydKi012RtGTvG0o+Zf4mNo1qT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-Proofpoint-ORIG-GUID: G9wbpW15dpMh9XktWZZNzrSnbNh7-sUx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1OSBTYWx0ZWRfX4Na3vYygTY/H
 QfSTuZdhKg6D6haMMQJ80R0Rs0bsQdMRV2QgfwtxDPeSCryjTZGXzKwuWcldUKHiOZATbPy1LSG
 o5iK1c/D8ZNgF2TIAvQ23ZRm54EdB86Ke7onm6uISD5nqQwUpTg3JkSDbKyLQU66eAU4zL4ysUa
 xoAgaKaOr/tiNeOOUzyxrBlIu2vUgFVzGk/ONitnDm6v33FEzeqfqc6b/VEupitxHAWjznc+LJ0
 O8w12OQDoAvDKrR58JeMXg7Dd9EOpJSatN5XIhiZb8YZRhWTvcOdQR1aPayDwFEwHDPzhqE9DjE
 lATenj2Ehsy9Z6GGAUmnBsWyuzA8b41ouynMntu8T458DAm6MLcgY3dgSJ//RbUTFz+trBNXE+J
 +rHlmTVMGaoCPMbHzcID3i7M5rZtRfX4qSk8rfgWD2P2Nd53PIGPY0pMSgzzpT3RK2g6dz7tdyP
 M7cifMvyEk7SAGoUZlg==
X-Authority-Analysis: v=2.4 cv=B9yJFutM c=1 sm=1 tr=0 ts=69e86bb7 cx=c_pps
 a=Szpykk5hBk3mC7HHiWFpbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=3fcuMNHXLARaAz_BQGYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: G9wbpW15dpMh9XktWZZNzrSnbNh7-sUx
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240279-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1EE8442750
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

This is v14 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events.

Changes since v13 (Apr 21):
  - Patch 1/2: declared pci_rescan_remove_owner as
    'const struct task_struct *' to make it clear the pointer is
    only used for identity comparisons and never to modify the
    task_struct.  Suggested by Benjamin Block.
  - Patch 1/2: picked up Reviewed-by and Tested-by from
    Benjamin Block (given on v13).
  - Patch 2/2: unchanged from v13 (keeps R-b from Niklas Schnelle
    and R-b/T-b from Benjamin Block).

Changes since v12 (Apr 21):
  - Patch 1/2: replace mutex_get_owner() with explicit owner tracking
    (struct task_struct * + depth counter).  mutex_get_owner() is not
    exported outside the scheduler core and caused link failures in
    some build configurations:

      ld: vmlinux.o: in function `pci_lock_rescan_remove':
      drivers/pci/probe.c: undefined reference to `mutex_get_owner'

    The new implementation records the owner on first acquisition and
    clears it on final release, with a WARN_ON() catching mismatched
    unlock calls.  Semantics are unchanged.
  - Patch 1/2: dropped Reviewed-by/Tested-by since the locking
    primitive changed; please re-review.
  - Patch 2/2: unchanged from v12 (keeps R-b from Niklas Schnelle and
    R-b/T-b from Benjamin Block).

Changes since v11 (Mar 26):
  - Patch 2/2 picked up R-b Niklas Schnelle and R-b/T-b Benjamin Block
  - Rebased on linux-next (next-20260420)

Changes since v10 (Mar 18):
  - Patch 2/2: added kill_device() before device_release_driver() to
    prevent a new driver from binding between unbind and removal,
    closing the TOCTOU race window identified by Benjamin Block
  - Patch 1/2 unchanged from v10

Changes since v9 (Mar 10):
  - NEW patch 2/2: fix AB-BA deadlock in remove_store() by calling
    device_release_driver() before pci_stop_and_remove_bus_device_locked(),
    as suggested by Benjamin Block (addresses Guenter Roeck's report)
  - Patch 1/2 unchanged from v9

Changes since v8 (Mar 9):
  - Added Reviewed-by from Niklas Schnelle (IBM) and Tested-by (s390)
  - Added Fixes tags for the three related commits
  - Removed rescan/remove locking from sriov_numvfs_store() since
    locking is now handled in sriov_add_vfs() and sriov_del_vfs()
  - Rebased on linux-next (20260309)

The AB-BA deadlock:

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

Patch 2/2 fixes this by:
  1. Marking the device as dead via kill_device() so no new driver
     can bind (prevents TOCTOU race between unbind and removal)
  2. Calling device_release_driver() before
     pci_stop_and_remove_bus_device_locked(), so both paths take
     locks in the same order: device_lock first, then
     pci_rescan_remove_lock

Note: the concurrent unbind_store + hotplug-event case (where the
hotplug handler takes pci_rescan_remove_lock before device_lock)
remains a known limitation.  This is a pre-existing issue that
Benjamin Block is addressing separately in:
  https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/

This race has been independently observed by multiple organizations:
  - IBM (s390 platform-generated hot-unplug events racing with
    sriov_del_vfs during PF driver unload)
  - NVIDIA (tested by Dragos Tatulea in earlier versions)
  - Intel (xe driver hitting lockdep warnings and deadlocks when
    calling pci_disable_sriov from .remove)
  - Wind River (original reporter and patch author)

Test environment:
  - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
  - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
    versions)

Based on linux-next (next-20260420).

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/lkml/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]
Link: https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/ [v9]
Link: https://lore.kernel.org/linux-pci/20260318210316.61975-1-ionut.nechita@windriver.com/ [v10]
Link: https://lore.kernel.org/linux-pci/20260326083534.23602-1-ionut.nechita@windriver.com/ [v11]
Link: https://lore.kernel.org/linux-pci/cover.1776755661.git.ionut.nechita@windriver.com/ [v12]
Link: https://lore.kernel.org/linux-pci/cover.1776756380.git.ionut.nechita@windriver.com/ [v13]

Ionut Nechita (Wind River) (2):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs
  PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
    in remove_store

 drivers/pci/iov.c       |  9 +++++----
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 drivers/pci/probe.c     | 18 ++++++++++++++++--
 3 files changed, 50 insertions(+), 7 deletions(-)

-- 
2.53.0


