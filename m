Return-Path: <stable+bounces-214692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJJuOlMjhmklKAQAu9opvQ
	(envelope-from <stable+bounces-214692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:22:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB53100E79
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 373B93005326
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6E03B5314;
	Fri,  6 Feb 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5QINGKx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kWktoPr1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F13B52FA
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398542; cv=fail; b=EKzBkuOFa1L4hxr01WHkMf0hnq2EarM5AsBUJBk48mplz+NEq3WQhoFGSZwKCFt6rIaRypoVBCIbsbfnjE0QlEzdSrNe2e96iR887pAknO0T5DRM/1JIuL1o5GoTiEjw3ViY/owHkkAWmnUstCImL8lsUPpZb1nqHaYkO5fUgKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398542; c=relaxed/simple;
	bh=D7MzSQH9HNXDIbkmP8DKqM6fNEVTQBCDG7tQrw5J3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cB4XvU/PIrQpOBrKiHPeOd2Ko9RjPRgOl6Pu5762zkPBuiJcCo83XUEXRhu0ofq/p7TwWeslYQvU4Sjk6irBy1y/YcQA2YFJRMDpupDbpR/n8X/JbmwUGS1ZhQLz1lOPwG+APCe/A4RtFXEBNqIRnwOIlLa2og25srIVSoEQCn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5QINGKx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kWktoPr1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616EvIPE3111471;
	Fri, 6 Feb 2026 17:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HFq75dN8GuiRkJhiWO
	eB4dXIhpvTGo7ZYmfoWViy1nM=; b=C5QINGKxeYQ3ZcG9VaC549S+QUsjwPQvtG
	M8yYa3gsCWXclgqdNecRBHuvoLkUMXQiAx3TKlW62j3fEnygowMPdNrMLPW3XeD7
	AJLpib4Qu7Mbwwzv7iFrSB4br7oyjI3Yon3GxAKscnx3qoGPyuLfHsjhZgXm4EPU
	pXmboPVy8C43xFD1HjFyzIUG9PbZXo8U5rS2BAYI68ux55UcS9duclca2lpZRSsl
	bFeAIF5Tmu2dLPD+CC2V9vE8k/I56hz1M9jwAQ5qtOEkVMkNaOpGENf6i+cwUkhm
	ruNKqO5SGPMQo1SuvFX0XQF4Kt9cvHBRm/o4BX/nLkbzLunaRIYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c50ddhjks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 17:20:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616GsI2D040064;
	Fri, 6 Feb 2026 17:20:41 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c55gcck0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 17:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeVKA0veRzzO3TiXsv3TNnWA9u2DOqIruDCVV4eHQGYhW/la0yxm9sOR1HPxU/FCkgyky8lwir94jXJKZt78ljWcVrJI0vbIr6LRkBnw3sImQpg8Gu003CFuHjwuBDhkVVaaTlVqEERZVvMQO7EiPokefSqoHEGF/4ojHuGAkOJuMui84NZJpewttWhmlCWrgjwyddUc147Un78KyW1RWFpD4rJ+wQDck1Q7PQIwR3ObFuShhrvscZ1p8aIQxVYONYnReoqawK+ayzMxxHuXTaEAe0vnAEwGelTTaQ4KXohEARRacXdlOsKjy3LdoursB7iEdrReSrscniKuI7cxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFq75dN8GuiRkJhiWOeB4dXIhpvTGo7ZYmfoWViy1nM=;
 b=FqQRdXWGhfGy+tB2CYuUYPFXSd8VTdZdw9SFWZnYtBhtHwNCSeGZojW4lBxPuAdcwtGK+7poMdZa9avv1B4AC9rlJMFGgpTn+urTL8hD2Wl7mN+iomtK3gm8OLaL36dM/2TX2a4N4G918gmOQ8xQk28X3rBTmoxLyRGD9YTBeIZ96tdbtuFnJv85VpYXsHaeSkQ0nmYecYIBHgCA6i/IdarF3+9vL0JvcO2JwyKp0FlrYjo2PKrV6umiyBgVIBEdtuLoHC6GY/FktH3/tlEkRNgyy3g8xlx75A8oUe/6CNXrkxw+Pt54V1rL4Rc2fcNQJV5YnDmZ2Pz42dQ58Q34Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFq75dN8GuiRkJhiWOeB4dXIhpvTGo7ZYmfoWViy1nM=;
 b=kWktoPr1d4JJGOCpVv1QvBjlVWpepD9A51YXiIutG7znGsuEeaqe2Dj2KA/CVGGJ+PWOWWiGTuVxtfylCAA2DAPGMYvhmWU6XWpiMhNd/tyaSln6rc+XSj0pSZcuKnOkvRBycG17ep0/9EOJGi5CQy7Tv3AQXrLe6gsYgVz2t0k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF9E376D9DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 17:20:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 17:20:36 +0000
Date: Sat, 7 Feb 2026 02:20:28 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: skip debug_check_no_{obj,locks}_freed
 with FPI_TRYLOCK
Message-ID: <aYYi3DhceyKbta2Y@hyeyoo>
References: <20260206165802.17280-1-harry.yoo@oracle.com>
 <7B9B9CF3-29A6-4271-8C3C-87FF3EB9FA4D@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B9B9CF3-29A6-4271-8C3C-87FF3EB9FA4D@nvidia.com>
X-ClientProxiedBy: SL2P216CA0164.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF9E376D9DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 51952ad7-63eb-4115-8a11-08de65a40aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jhGPziEhTxJDPVDxIORP82cyZTk0tvVB3NXZLX2Kv6krN3RtzYMkRAZ+ztZH?=
 =?us-ascii?Q?hFbcws1o4plxkNCPGj/D/Lw7Wa3ygjw226ggc7lOnizN+ha5zUstHg+cQHmW?=
 =?us-ascii?Q?9LIDcA4QpcfOmlToZiFlPtoIuzFua5aOH30IjhWlxJz8SW3iJi6JdmVNiqxD?=
 =?us-ascii?Q?y1I59J9zMjQ92Mp/G3LDpNb4PthZI+LMq5Aek3MfGFDVrD2NZndOj6OE2VUB?=
 =?us-ascii?Q?n7E5xpGGkvtsIRhN1jbIPUZkqT5IOl5bQULpRmCcfL3WMlvrt4TMDlwaWtTO?=
 =?us-ascii?Q?0jYp+im9kXr+JZoao49kVUtwfYjBSOJz4yuPH7iy5FQLXJjzcFRpqOmJBes8?=
 =?us-ascii?Q?UAW5/TA3RmbQRWLwouO/NwUPXiP03/ZWo4sN3VwNmTvhQmiO7KhG+DCVbXIG?=
 =?us-ascii?Q?Ygi6PdRE7Z9oxyLPGfCA0OvdAqfaOC1mNtwVBYyJdqV0HGAnN3LzTPWK5HKO?=
 =?us-ascii?Q?SRNvAnTwuzN+Lh5ipaIzYTOXymZ3QbULZCJ04fX0pAnhLFLCLs3SrVEpzX5x?=
 =?us-ascii?Q?56kCleYyupdlR1+Wl0pyRDHW2yt0+h+vGlUwjxCMnSCkpSUsdsNF2PcUSfd3?=
 =?us-ascii?Q?lnh5dE3Xi1CBqfBosaVXSmtRZdFMWMCqghvZMMpPHaMMT1aXA9s9rqoEfoZB?=
 =?us-ascii?Q?poTPG9qlfVmQYL21JnVC440eq3YVAY4+uJr3e3briJmmbk48PUq3O5IjJzrt?=
 =?us-ascii?Q?0yoOI+touO4omKIOOjdVJTdeyeTaOx/12a4YqziFXGqBjD/NFpDmUxD/Dr9+?=
 =?us-ascii?Q?SZZumoOoQFY5b46rHvIRXDMX8f9zJBEWMZXGvNfaVc1auCBut/Ux9fiSM2Xp?=
 =?us-ascii?Q?LR2PUiNI1nhLd6WzpdGmT0/RKCFsnlvjAlTOwAkK1nUg/7VXutVJpFc8YBSB?=
 =?us-ascii?Q?qkVzy6Qo0tZzcnGr01CL9yZSRf6AxK7Q7ybpjiXKJpJwd5GHL70MnaJnxxPh?=
 =?us-ascii?Q?0q6AxwS+3hC4BTRHmLnLlV7KHemigRJa8W8ryOOq75pMSPihtVw8l+cXqydX?=
 =?us-ascii?Q?6w4HqXxQ7cjLSRo0g+IpbjqVGWbRF2n384E2tl4wSAm6l3NnS363tWLggFO2?=
 =?us-ascii?Q?FGxj3phhJUrQo+fTFQl/SIX1OMG6ojbUUG6T9YjlSzQgnEKX3OdJP9OSA02+?=
 =?us-ascii?Q?m6BzsTkqwdOCTfWpt4yJCNVhsu+pBpyHLvLroE6Vgf52hhYIH8gO8bm4u6pd?=
 =?us-ascii?Q?VyXPoQitSpDrjmZjMcvtu3yWfZjD0kNfccj+DiE5paC37WPX4RYrywrd3ccJ?=
 =?us-ascii?Q?8zeaLPuViFGziNd3lmk0wenxlNia2Ci3Okw6oDVPxDvd9H+R6ygDVjTA4G1L?=
 =?us-ascii?Q?bbjRJB/0dMwqb6qY796DHZUGP0jArGYMByxMJVZjNWJ6pbd6BzVjl92ee63p?=
 =?us-ascii?Q?43s+1+yjrrqDXC7tnNV7MGX6HSbxxQmkWnoa/48lrWtNqTNRlYY3+P14nnf3?=
 =?us-ascii?Q?QEKEFPaZRyD061/j5k27KK9Wk6GFx/bF1AvcOpW08nJufiWqFWz19AXRR43V?=
 =?us-ascii?Q?AHfb9h4hDRMVchtBPjGo1T0jySgoucMj1+HjCOE1gCE3XAFtUy59cOTXYS50?=
 =?us-ascii?Q?7i5UlWG7QkRpkWHsfJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1hbcL/aIaVLggASpZGSzMsXZUAaSsF8+cQ5lKdaI9zL8TLspBSsYtxsVg1QF?=
 =?us-ascii?Q?FsW3aFTen/XvSy4yaGN7025Sko0dhDonYPekrGAda+K/ipu2tqBGcPYodJNm?=
 =?us-ascii?Q?Xne0qIU3BbXErE9jXTprykIzFOzzxx4Nekh57211gqvdhp8eD2GN3LdDZrsP?=
 =?us-ascii?Q?MBlhmt7PtBotPztkPYZJAmSDZXulzwUjAw8bfeIi7NEscMtemrU/aJuWV3T4?=
 =?us-ascii?Q?LYv1LFmLVsGktqfiorspWhAZ6wT8iclYIHk6SOq/cVkn0GCKAunRndtiMCvL?=
 =?us-ascii?Q?HWDi2H1WznkEjDlTh2XQMwyDav7YFNNsr8JqRrfAyV43IqsUMiqda9w+6YUb?=
 =?us-ascii?Q?fVvgGGyWaMwJKMylv/KUDCExRkg2y2PN9mFanOeH37ilWtNAWodLF4j80cgX?=
 =?us-ascii?Q?jaY+xg4kFcYFuP786mNszbBHTfZAbbi0vuPijF1yzFwZlZEV1fiNuU0Nz6xs?=
 =?us-ascii?Q?zjwUsfu0k6GIgqMX2ynnxC6phiuHVZRTZpF0tDUiuZ2lk6Kmt9H/IxXclBhX?=
 =?us-ascii?Q?ZQETy8fEOfQxNUPMGZw5eYN7vwewK+YLZr/f7TXuvcu7AtEG7U15DozyXVBk?=
 =?us-ascii?Q?u4HckXWSehC5CbvhIleJnOer846jvQ9WSVTyTOrEwsAx6ShL/FRoGp7oJzW7?=
 =?us-ascii?Q?FjIyqEYzyb0JUNVIw+1w7j6kJZzquCkJ7mgfic152WP47NRRLa/3Ljes9Qeo?=
 =?us-ascii?Q?XoAiLIBhcm0nOrnG85KhGfNiQLDHRycGkw05i65+G69X5DB2rdcB0zriSN0A?=
 =?us-ascii?Q?2h/6wHQlazWeOwha5p9cuRBXKd36H2/E7LA3yvg6c9KM9qgAqCIs2vN2xk+X?=
 =?us-ascii?Q?B5dS9FriZkqrQq680mjr8HYw7ETD9Dr6Q7lSjePtSCSrfKLNZRzJoO+FKc0i?=
 =?us-ascii?Q?WN6ju5PFgnMVBviu66ckVCRTLxsbzuZEC5W1ryXerQGGE18+LximmiyM6aCg?=
 =?us-ascii?Q?1VTVeK3ME3abpIIRjMaL6uoENKjt2Ehd5rXhKZ7OlWoyFc8ieMyp0mL+OAFa?=
 =?us-ascii?Q?+QAOPeZV427jUSHwXJMJhTkyDyBdCpu/XiRCace9sr8liBvoa4Cv2UAN2UCe?=
 =?us-ascii?Q?ORAK8rZqAnzMaa9dSEAsg4xnVK/nXo9EDzcLBNvJi1tzSrSr6cnpnIgDrQuG?=
 =?us-ascii?Q?Z3rvlTO+z83zcVyIUnImBEWDnp7rCR07wOndVNSHaeL1CUtFo3n358znrH6p?=
 =?us-ascii?Q?PB0svhMDcvs8WXUJmaoMbmdMfwcnFwYSNWCkOkHQdMQTRWmGer/o4a3m/t9K?=
 =?us-ascii?Q?1EE9BqggIBba6mwVfvVSFl0kuwqsEKI/okXVM+nhId/kQ9JcAavks9wWe7vz?=
 =?us-ascii?Q?3rRvOKddNSZm/E3SmNEv43T6CZWhW1GkZcZ/FwAc4NgsGR/oyb2mau4+WbgJ?=
 =?us-ascii?Q?ZyEa9HTM0dXaSOBfmIZfnYU5OrXqT9YRUbka8oCLz8W5AXmLGHksrWsu4Ugf?=
 =?us-ascii?Q?LWvRaOEuDuePolABxR0xgtByOhKP/+5oHGgYieVyN8JNqkCP9Ze/n44JRwL/?=
 =?us-ascii?Q?Y17NyuyfOrczM3mdLA2H+fIWIYozKLYOFYqkpuYKNkNfXBZ6Bdi6I+xrwxz2?=
 =?us-ascii?Q?hBCthpWegs9eZPdSM+GZQ2kZP48vkhueWIkj3nlfINnC4M/AE7pUZjYhTxZP?=
 =?us-ascii?Q?HsytUJbnF60csUHkzEe68jx4Ry4U8s+Xntc314NcG0dBmY9ezuxWJ6BOds7C?=
 =?us-ascii?Q?LkL/rfZecUwZlN4i0a0gNTbSieBcxKw/BbwzVPDJ9948NfHKQRu52aRnvPtZ?=
 =?us-ascii?Q?jRU7Ua5A+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FRJygepKE0wS/FjkUjW1Oc07fm5lyIi6Z4Q14O+E00XoxYY6Qn2vPBJsVXEUkYBISGbZdyjk+h76dcseUIAuIqKGKAua7CcJr+Dc1fGbmRtk00lHzSiLzcNByYIfwhUi10dvKqR0t3n4fE7mBfrU1jovIdcy0KmH9m0DLt/zVuC1prtzc7OupqMqtAjHJPrabyTCf79+BacWF/mThUlR/1TtqbOaGObsx/vIy8Kje46iwsBcLuUagqX3rTqlLv5ncWdRfC2c2e6wrse3QILqBfXse7BT3LSloOwrh/lcFecqgjGiwAc1uO/4mVdOegdNwzHiArvwVcPxUmUYHVYMUEcNTN9ftiEInEuBpURRVZM1/Ne4zRMpRMaIoX7dpR6tzImLu6WZDhkUyLS6dg0G41Y4xlX9YPK2WKp3Sokd+EfxlhjfFj+gNk6R0NxS8Xt2f3zweRpmyHq7fnsUp43wO+63AqKLB2S6XNP/bmd63tivJ6qthzryOhlX/vOpSuDs+RJ/DIscyfSUQekD0Rt1AuKbwTzDLv9AZ8Y46CfS+aj6J2UelYr1Jr8jwCzL1B1Bp9tCkrSmFY1YJ7VXKO21PowGgDRm2rmJgqx4jHtjVmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51952ad7-63eb-4115-8a11-08de65a40aa7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:20:36.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yavn0wbwufwrzytYfkw09WdcMCbh1v0acP3VeofEBbNGtYAmL+jr32RJkHd3p3R+JXBi/nLWFFF3F2lsFg7Egw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9E376D9DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602060126
X-Authority-Analysis: v=2.4 cv=TvvrRTXh c=1 sm=1 tr=0 ts=698622ea cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=NOBdQsLoAk3bkFjZUdcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: SHDKaAFaEGTjXVaI9z4S6xiEm8R_j01R
X-Proofpoint-ORIG-GUID: SHDKaAFaEGTjXVaI9z4S6xiEm8R_j01R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyNiBTYWx0ZWRfX4CcoZttxAvdZ
 QeV8TGV04BkZmyK38jGpb1jZYGGKOCQS2D3S//6Xxu5vmOfjQFegrIKuMrFzO/aYBZznM2nH9tI
 i+tInBlXsWxOFeBQ5lpsgamp5tH1VrpDitMlaBLbEvFKgQ5aham+GIiicYf1h8e3c11XD6s2OxZ
 ofLhVvnWws9WRyhOn9sdNfKErmCWbspfspmXY4qAvcql/py9zbVSWt+Srw1ZWxVjJ7QbNblueME
 /VWx+OI/DKiAtdG9V+bulgFplrICHRRo6maQHN38n0RmxD58EWXolviJEvj+8DG8G8gIXyn3Zq5
 rGdsr7FIctFgd4eRuRiDaq1CvLttNAUGFlSDhVxile55En6EF9GYPT4plUx+OnlPDt74mnKZ8dm
 DbbFmJpHh2R4XH/6vbFIK4ymmghru2wTtgN1IDt6Ua9Bqh/LiY5z+cJQFuzjuzzR95qoIikmnqc
 y/O77oq1LOc5f53woqg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214692-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0CB53100E79
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 12:08:04PM -0500, Zi Yan wrote:
> On 6 Feb 2026, at 11:58, Harry Yoo wrote:
> 
> > When CONFIG_DEBUG_OBJECTS_FREE is enabled,
> > debug_check_no_{obj,locks}_freed() functions are called.
> >
> > Since both of them spin on a lock, they are not safe to be called
> > if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:
> >
> >   ================================
> >   WARNING: inconsistent lock state
> >   6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
> >   --------------------------------
> >   inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >   kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
> >   ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
> >   {INITIAL USE} state was registered at:
> >     lock_acquire+0xd9/0x2f0
> >     _raw_spin_lock_irqsave+0x4c/0x80
> >     __debug_object_init+0x9d/0x1f0
> >     debug_object_init+0x34/0x50
> >     __init_work+0x28/0x40
> >     init_cgroup_housekeeping+0x151/0x210
> >     init_cgroup_root+0x3d/0x140
> >     cgroup_init_early+0x30/0x240
> >     start_kernel+0x3e/0xcd0
> >     x86_64_start_reservations+0x18/0x30
> >     x86_64_start_kernel+0xf3/0x140
> >     common_startup_64+0x13e/0x148
> >   irq event stamp: 2998
> >   hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
> >   hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
> >   softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
> >   softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
> >
> >   other info that might help us debug this:
> >    Possible unsafe locking scenario:
> >
> >          CPU0
> >          ----
> >     lock(&obj_hash[i].lock);
> >     <Interrupt>
> >       lock(&obj_hash[i].lock);
> >
> >    *** DEADLOCK ***
> >
> > Fix this by adding an fpi_t parameter to free_pages_prepare() and
> > skipping those checks if FPI_TRYLOCK is set. Since mm/compaction.c
> > calls free_pages_prepare(), move the fpi_t definition to mm/internal.h.
> >
> > Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/compaction.c |  2 +-
> >  mm/internal.h   | 35 ++++++++++++++++++++++++++++++++++-
> >  mm/page_alloc.c | 42 ++++++------------------------------------
> >  3 files changed, 41 insertions(+), 38 deletions(-)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 1e8f8eca318c..9ffeb7c6d2b0 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1859,7 +1859,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
> >  	struct page *page = &dst->page;
> >
> >  	if (folio_put_testzero(dst)) {
> > -		free_pages_prepare(page, order);
> > +		free_pages_prepare(page, order, FPI_NONE);
> 
> Is it OK to add something like free_pages_prepare_fpi_none() for this one
> to avoid the FPI flag move?

Yeah, moving FPI flag definition isn't great :)

I'm totally fine with your suggestion,
as long as page allocator/compaction folks are fine with it!

-- 
Cheers,
Harry / Hyeonggon

