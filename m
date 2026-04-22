Return-Path: <stable+bounces-240280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCWgA7Ft6GkSKQIAu9opvQ
	(envelope-from <stable+bounces-240280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:41:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCD44283E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E61307A5C1
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531A316192;
	Wed, 22 Apr 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Fajmsw2r"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4A3246F0;
	Wed, 22 Apr 2026 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839656; cv=fail; b=HrukbtISOGceg7iaOBbe2l3wbozkm9JpMKKcdlHTE40d7cDam00IaXcfgt8v6WhtLvp4RH8VlvMQqrKjxfwaRjqdL5krJHz3hgSOxcF/MrOCSMzQiAk+JYbjnSvnHzE3LBaaRDaV9D1x3yb3BHZcXTgRT9I9qVvW+uUAfq3kCuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839656; c=relaxed/simple;
	bh=Oj9aUMqqclCYjPLPIDz+E2EVJDxwobLb+GErdT26r7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZHGxoIcgjkOm03VlyV+086Cj23dbadHAyCM7E7nJJFlhlTGkMuAwYX3pqo/iIgRrndMvALF1aZLhmdYP3mNVs2P7vrBRvL/blDjFGE3ecxLIjWIah9p3aq/j9nKxv+B3tL4t0moAr8JHEGxEaUj/waHmo5jTsgLE3YllbDNj2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Fajmsw2r; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5gD6p943792;
	Wed, 22 Apr 2026 06:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wjPon4yJp0Gp49rOEHpr5bIo4Hxao5DJ37lNHhuRtks=; b=
	Fajmsw2rsGc0nnnq5IOcK/NxY74ZejKFSADYGNlMDX7rIX8SOBMP2XLdI26YOlHe
	tY/8SqMee9MN0dTJcR5qwXWySOUa9740NIvUcpdwwsCx9b20x75CSxSeK2z8bFGU
	JWgeAwna6/dAXgRkXE50R5/poiUKBWYjS2l50jvqlDKsmO8lSEJQMcXQD5tg01/H
	+J1MBkQVWDSx9dEgTegaRFFYFRW3+XhQhg6LN7m3JhNG5L1QhKp1qhwh2d1PgB1E
	2aN8w+OyHTcD270e2clvIdNEwLcEOMejF62O3fLMLfcDYAitFQUPf+PRRDoCfTTd
	bABnjb4O2DK4h0E8RHE9Aw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dpenv8heg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:33:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia8rkYlLGlfuuxGXmInYpdLwud7wQUkwMtKs/2JmOqdf7dRCs+6xGGUoVVsRgBONh718AZwsvoZPPNyl5+2WvOSK2bGQrWN9ONOGOVyS4l70i+wOuMxhyiYxaxSuTsEyLZNoXrHahu0Ed6KUfq3SeOXkyU3cZ6CV8CWHMtF00Tbjl3s9166XISEbG0SF8Ih0/FylDzwNbRjkrGbdoJpX3bqSu1YkHQ0J1ZbdiaL8JLfCwT0xg52Jqb8ihxVqbcUOQCok0p4MALyVI6SbH0MQa3+K9gahNKFw14wv7Rw//uBKmYFBR5fkgeXA2Z+U7vhQEdlXCx5aONqGHUcG4yo9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjPon4yJp0Gp49rOEHpr5bIo4Hxao5DJ37lNHhuRtks=;
 b=YuZiiSlip57Wxg7aQbxsY3KPG3pAgjyNHZSDQevD0vh3wy5eV2lNUxoCZ6M4Wy6PKEBUGlzTgzdnUKgeGXkGHis8LzmUv0W6AeelzHOghyL68ESTfx0Ja8lqV9hjvOIg9geVwuicZTMQzYLyDbal97EG7tSbVk7YTHfRRAUyE6KN/4OjoiZ9fY5Qwma1st4wSwnnSZJXt4vNt8RM9GaJSebbGzIaDlGuxPzxxSVoqCAt6JQGGnQaMDLCsOUrnB0rOnmbF2OTyBmciXlZFpjn9vpLmqc+gdOHfHZEdrcdUIvb8T3Ca2cS+LguUFsy730ESKykG52F67XCjoBds4s9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 06:33:41 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:33:41 +0000
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
Subject: [PATCH v14 1/2] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Wed, 22 Apr 2026 09:32:41 +0300
Message-ID: <2ff52853da5f36c2d695d090c839bac87a35edcb.1776839248.git.ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA2PR11MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: b26e39f9-ddec-4ee6-a50b-08dea03917fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|52116014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/vBzrWuOSIhvcjvTGDr7DjR03vd/VkZOZlkad/srDCAJCEkOjQkqj9im9FGBX+PyObqnzVWa7rZN0blNfIbQ0wnceZt3HZ8SIubfDtBFHO05RpJJAB8cbsfz3leFcEiPpjStSZa6ERiKMfLDXquocsBdEv4JxEm/QWAtghLvdqhe5Kb7Xp7uaL/PbzngxAv8SRj+mF17N6ZpyUW+MMv/ruxvOhwhkACpB4n+hbgzfsIqEL1k7Atqv7d3SAczEzgM1rz/afAaL5BUK7CRS1D6sQm6vYGnKd6ultxebMtI3SlEJ3k53SWIPsraJ5EE57N6x0znjeQYRXPUHrkUs0PdvaLdIzBaBNhmMYyF97/8V+Rx1I2a5EwtoBRlrSUGOZdfGSlGOVJUWkJMmswdjawNP8rMKbZX4LH2W8B2qCTk3WaHUAv0gK5WsPbR6X9P2e3nJaWa9hfXopZbc4Jd4w/us+ZScqV9Yf6FBn8fPgvrenOZmt6R6QmQCgm4rL/YukR2ogI+zNyTIx0ynLOEDiKeYKkpUROzlGigEuDApb0t5GKqC44dcbORnG1Z6aV511A/c1pdBTp5yo7seP8XXfTJW4CjxmTUNRJw1Jm0+gIrmBVMCokSjFKsGTRtUzYctTRsK4TybAl7qhDBPQnnLSrAs6p3JJMq9RuMGsM3XcwnSIWvwxqTDJLbzOEZ5u1QDRVd+Pbf6/Q6dh6cF4tGVt7f8Dhoxw1XRN2o9mnBbFrk0+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjD+N7g5G5kB6GIK85LwG3eA7I0a5bprNIKlimne5zaJbTEXbnpjiZVnD+t0?=
 =?us-ascii?Q?VvTKuEyN49+sS83sO6sUDeNwWPMBC69LrxIwCxZGNU6fF+jRqHGoNk8tOrxX?=
 =?us-ascii?Q?sQayF3K+OZwdQgidmKTSaGImUvGt/R4JmQ4gctvzAY8See5YalpcUPdv265u?=
 =?us-ascii?Q?hCPFQV5cZINFgbVfYcVIn5AUX3HiiELjhtoCiwt+TmlMewnTjWS+iOf+IiDV?=
 =?us-ascii?Q?ezSYvSd5ESXqsiFoP8s+CXRTvwBdygJDdzoHes4nFeIhf9A0JDzRQ5FNk896?=
 =?us-ascii?Q?Rt7GgYqs0BGjTjT9hPoTQ8GKjvhJT1H/SwI6pqC2PbaZRlexzn6os+F4RBTU?=
 =?us-ascii?Q?2nRrBwaI41qY3HyLAfQ+akQpLvlxSaSjBqkl722ng3uzoICDK2gsnvEB7Mhl?=
 =?us-ascii?Q?9SpNOvY6f9SmcgA3jB+6PW4SBTWHeNZjXN1eXPvvZVLJY/fZMhXdFsPEeSF+?=
 =?us-ascii?Q?2JYd0lGoSrRgmCVPQzOYYRiihzn5ytmWuC1IBUOmPnkILOQl3Y64PbNFOHFn?=
 =?us-ascii?Q?f1lGs+TdVz/k00arTH0IwVw818CurGfQD7bEVG9g8VbuuFMc7E5SVia2hnDU?=
 =?us-ascii?Q?TZp5TTzEPOpR6o6yax1yj+aTEQ5NrFgYxGrfKzktguTZSH0AmXrcifgsoXyr?=
 =?us-ascii?Q?FRO5x/4fN7WfiNTdltEgOB84LOhK+xN/fP40y8P6/ITP5uDahAAxPat85P5N?=
 =?us-ascii?Q?3Ue124pCiRkLHv+VubuDghsouOz19M9tZOosxrm1481/IUgRqHHo+rGDRBu2?=
 =?us-ascii?Q?AVow6H5rJobpXFZl2m778dtX9pD54bSErO7V1wIqDjJjLO3bK/MZsEyUUKjV?=
 =?us-ascii?Q?0uFPMKeorwHoKQSkP9TEWGgWlqg7KvioIQhj0oeu6AcoCw4rc/H4lohPF77C?=
 =?us-ascii?Q?7lFr7LMgcsV6RIdybTnU4e77ZR+2wkgGUqQifdg1Q/BAVnwBcohFf0shoISZ?=
 =?us-ascii?Q?W6TKgx5GqWeAaew9igng7MXEq10oA55TGhekXEnAO+feSn/IkKlm+tFWUJnL?=
 =?us-ascii?Q?GElNuqeCP2Cl+oiVGZVsNIRyILvFiBKsO22vqm8SU/V0FhnGEattqdzxWFcv?=
 =?us-ascii?Q?WmggZmzeTC3ay9m1VNeLnk7QLimmO5jBrO0M16Z2ENJo7U06iZHDKXUDUMTb?=
 =?us-ascii?Q?dlagBEHtvj2e47JoeE1drSTxP/b7u6us1nGW1/wt/APufaQphEZmUbSOYw93?=
 =?us-ascii?Q?B8ldUNx1dHXDFqbxkxWR/cc6K14Mb+sgXxb9g9vsraXqxaLH+Cl7HuJMr/NC?=
 =?us-ascii?Q?VRs5H2nh723nZIzDQhG2HINeG5uDgEaLFhgkVPTc2I2macCSWadkV1jMUCkw?=
 =?us-ascii?Q?o6Syuk9WX5QxeVsakuiTGJxQBojs6cMtlW0iueyUkIR9Yjp5zA9vhce6v5Q/?=
 =?us-ascii?Q?aI0lVWmJCWvTV5smElhQmvkQGigMJCbzu44Yxa9DsTEq4oFhi5tqsT8d5+mF?=
 =?us-ascii?Q?n/EwGGDQcG6PjHzdDq6Muh+ro/easDiCNaBDvwwQzSl//qbtY2hQXOzEeLW0?=
 =?us-ascii?Q?3zgJtYtGm1bM0ZjmlWWmiWnG6K+tzMUW0VyoBHH+gHzmgRceMgsk5ov/DHDG?=
 =?us-ascii?Q?PCQSgj79PnIupj1xZjNJm3zBtwuheTNe6tXUL+c5Zv6E4FflQXspN1BXn3WH?=
 =?us-ascii?Q?D261UB1VR+0VKE32YAAlJoRs7ujT3qsZPDXfUWzOtlqzeRmeWi5uGbe40un1?=
 =?us-ascii?Q?i4QSQHWKfEeVrAlALl6+RnQEwj67mN5pZGJ/kisabx1V8l1LNf5Lxi/StDDy?=
 =?us-ascii?Q?2YNseudMlnKPYKRlQFn6AML8ctNPUK6kaaHCbMpSb7aFVNdrJfWwzea/Bped?=
X-MS-Exchange-AntiSpam-MessageData-1: w/tVjliMT46JGddry4z2r/0yuottBkLPw6s=
X-Exchange-RoutingPolicyChecked:
	C4etp8mUMAweH60/3atmM1R7QYOxhyRupbp9Fg3KHIUsKHNns9VjEpxlOC4a4aWsEfZvu/DCMFfIilWtw1kS9+ldjd53/yqPXg6BuVlTcUyNNtwe386OTNJNWA1X4H5htZ2po4U09a5w2hB72RKzImuPKeooY95Q/6PXIY2NnWvhNpRYS74U8aPiQOykWKxQtyvf1oGtWW6TAQec67wuymkMK3G+9OmJbhRI4hD/wNziCgZ5THY8avdpcpgg0kkU/hJHB/KP9C/Ke/Y0ZSM/L+zUfI1XV2MgPRULHapJ97jAQCOUtfCcYIh1hC42L6YJuyg/vWJ8M/vqrdpWPRD7iw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26e39f9-ddec-4ee6-a50b-08dea03917fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:33:41.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFEhsp8Ka6NYcHTCpET4gJkQdIouPvaToaiCXEvh/P5nTOLisSz2Axc+FwccO6e13/04ImaKuP8AffjCC6cp1ZXcmRaYkAw762bPCZPVA1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-Proofpoint-ORIG-GUID: ZgAi5WJ7DrWwBkZxGrR2_ptg9CUTu_fJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1OSBTYWx0ZWRfX/4hPaENNKqOv
 iHiA/rhhj2Jlzk4r0vQpiLMA8tOZ/W9CwkgAirC0lXvCd4ijJRTtMblzJqwYjYhj8VgnwUB0TRU
 KD3o2QB1jV8C1BThRS8fSpA4X0pDV9lj91X3uJhoMGNbYu/rDO5OIQhZADsZvMKV7A+NLWOx7aQ
 WXNCYvXM2hi22MEfZkT/Ps0u4Zom3iJ66vDlME9nF7UdTBhE+vNwnQYLkMW+d9/uJbz/wyvs4zN
 +4eeH/ZGLSgDXB1G/qru/3KF2aulfW28SElMJQbD5lGLBQ5FQIFmB6kGxpDfvIUcuxrOXujMl4+
 5wGPOI4nFVDdaCTHS2QYwEJI/bTWF/doI5+s0nUNl/63nJoQaIWcXBmPiGdmyRbXmaq87L5HyYw
 x6yFoL4cVbucyWwvkZErdCWSGDEZN0IyY2Y7jOjEoAh7Q7Tn8g1jfhVWhwFZK/unoJ39MQQDIgN
 MZBdxNUXagb59uPXvCg==
X-Authority-Analysis: v=2.4 cv=B9yJFutM c=1 sm=1 tr=0 ts=69e86bc7 cx=c_pps
 a=6NHOJSrb2DrgGhcKreW8mw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hh5_vNSPTWDFZ6TSUYYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ZgAi5WJ7DrWwBkZxGrR2_ptg9CUTu_fJ
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240280-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 65FCD44283E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant by tracking the current
owner task and a recursion depth counter, as suggested by Lukas Wunner
and Benjamin Block, since these recursive locking scenarios exist
elsewhere in the PCI subsystem:
 - If the lock is already held by the current task (owner == current):
   increments the depth counter and returns without re-acquiring,
   avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, then records the owner and sets depth to 1.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the depth counter and releases
the mutex (clearing the owner) only when the depth reaches zero.
A WARN_ON catches mismatched unlock calls from tasks that do not own
the lock.

This avoids relying on mutex_get_owner(), which is not exported to
modules and caused link failures for builds that inline this code
outside of the core kernel image.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Remove the rescan/remove locking from sriov_numvfs_store() that was
introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
enable/disable and hotplug"), since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
reducing the lock scope.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..7ed902539051 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,9 +495,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
-		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
-		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -509,9 +507,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
-	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
@@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..91f1dae6943b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3513,16 +3513,30 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static const struct task_struct *pci_rescan_remove_owner;
+static unsigned int pci_rescan_remove_depth;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (pci_rescan_remove_owner == current) {
+		pci_rescan_remove_depth++;
+	} else {
+		mutex_lock(&pci_rescan_remove_lock);
+		pci_rescan_remove_owner = current;
+		pci_rescan_remove_depth = 1;
+	}
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (WARN_ON(pci_rescan_remove_owner != current))
+		return;
+
+	if (--pci_rescan_remove_depth == 0) {
+		pci_rescan_remove_owner = NULL;
+		mutex_unlock(&pci_rescan_remove_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


