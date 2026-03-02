Return-Path: <stable+bounces-222659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OO0GNzKpWnEFgAAu9opvQ
	(envelope-from <stable+bounces-222659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:37:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B41DDE88
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8883D30526C8
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDD425CD8;
	Mon,  2 Mar 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jk9i3Wfj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="idoiT0o5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EC4266AF;
	Mon,  2 Mar 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473006; cv=fail; b=dT9+qviZ1czakTntCEmJ0APf7nC8RR3utF288ReQxuEBsJkw2b7Zcw8kGvbtwuwb5rGw9wLcmxg2JLkTIH0b6TNbg6HxFjadFNP4uQcC4BlszdpKINi6uI7u2l9y27oRNyfioXem2Ww0zapO28zAmI3cvx/n+f8PxBhDlwnYoxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473006; c=relaxed/simple;
	bh=//8aWjupJIMjOWwWNIAUjTHY0MljuvzM1x/zqFxicxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YT1YiRe6Tuzhe8rrS+0SClF/EZG11YGzo06Da38SE9pXH6IjI/uD7NUTwEsNqWFSrr0XVm3er+QQwcS3Ye7MGqbTFqo9miyo/mCVusSDAjWTVSE8BVKyrcOQJcv4RKS4tmzuVLhhc2S6tWZ9m69mEC8WX4toqqyEokVPgL5/5Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jk9i3Wfj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=idoiT0o5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622HZxnx2157170;
	Mon, 2 Mar 2026 17:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zX55JKRikT823GEsxC
	m8UJk7yeOuzwMmCHU7z94PpNg=; b=Jk9i3WfjQL9sfUjTCTadDyK8WlOgGVzI0h
	RxmlZGV2L05CVkOqIm1qj0ZQ9HjwZqQZdbbXGDGWVu2Gw2P0F513zJ/+PMdh9muD
	t6j9M5PMO7V36PS0BnsSI0ZkzhadvDt4emcp5MYgiORAPBvuySJsupP6rqqWzFDO
	W+H8HneO1nSWdWob3hcRCiIwaQ/hiL6W2eMgDVJ2///1+VVnZHJtwsuR8Bhy129l
	d3R2DriLxM/rg+t4jxma15lMEms5hWk8l0EfH95AoaG76J79XHkomojGLf15DXrs
	k5s1qV7wEC2neSiDsN//7ShoCe95AOCF55RtiTv+CCgkVxcMP1Uw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnf3d800w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 17:36:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622Fx9wM023057;
	Mon, 2 Mar 2026 17:36:14 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdhb5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 17:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEMRuSg/Eq6SMeIG7Mh/uFQUjzJUy/fuSbuzIFTzKna8sKWa+iNrS4puZ5ivNOWUi97Tvt+08mvZdigW3/ma+toI7Yfpm1clatSwsc2AeLYMhQH3Li3m11y9hp0M58JvczHvffFCW81eftYMlFKzVEL0R4VxcxiAK0g0D6iIEkUYTN+eMcsdAmv1xSg95yBGYvXMTg4fFGkkADpm1N1jzINKxVwM/hjt8SyhHONxQODx5fibFAFmN1pa+TI1Drv0L9dmdKmsFDRwtZbcE7CHsfQQgReGG3iYRsi55sWBKHcAuosLoLzwOwk6Gc/3fWFWselleCBPRN++Wab+TMxABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX55JKRikT823GEsxCm8UJk7yeOuzwMmCHU7z94PpNg=;
 b=AKmlhslu9QrKN4aXk5GCAqhw2AT1k92w5kUX5IL4ovoZv2toOdqUin6TMAflWHonxl77pyZg4EoOXl47XSAuw6Ea/vPw4fWJH33tpsfnMy+Zh+aA0T1DvBZsiwF3iFgF30ETG6UZG6U/IeDYVuGpSJ4d+Zqna0FTs+HsYJ7z4Huezy75IEMB6B6BCL2uKfrZwCCJIxTiyJQ+GuYAJsui9gDsptUIHpbkeVRqz+ygIL723kdSW82MTwwxO77QqaNj1sU4j6tcEA4ysYG0rYTcMKe5rQ5G8KuoLJ1F38grN3HeQjGflLvp8JSN4dRcnV1HSDxahrMFxkZsEjo0EF0JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX55JKRikT823GEsxCm8UJk7yeOuzwMmCHU7z94PpNg=;
 b=idoiT0o5gJanFWBcmMGG7bPUO8U14YxqGA1Kq10H+rRZPlFOiZ61ilH6sO1hcNFNImZqoMtWoC+O5XGrEV8DQP/8ARIdtrLibWtrhD0WmTd5Y3iEcd5LIX4EebohplPo4KpTpAWs6TPQ4x4mREer3SsIrOWjj6BV4zVf9rG6zGk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 17:36:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 17:36:10 +0000
Date: Mon, 2 Mar 2026 17:36:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: Fix use of NULL folio in
 move_pages_huge_pmd()
Message-ID: <b6096c06-9fbe-48a5-9efe-ae611a2e650b@lucifer.local>
References: <aaBVg6nPQz-WvyzT@chrisdown.name>
 <27c260d2-796f-48a6-8b1c-751ab172d480@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c260d2-796f-48a6-8b1c-751ab172d480@lucifer.local>
X-ClientProxiedBy: AM0P309CA0005.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ab9b6a-b4e8-4b31-4cc8-08de7882312e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	4sR7NGRI0FS8d5rD+zieS4OextNDlls8kez7P8nfIGuDD12lFH/LD+yzNvaRNHdF2AlfqrRp+3p/fs9F4sPx3L944s0NUlA7a5vvARms9BNEcxAY3n7BtNdEBG181l5NMF8GnNjS88AUmFl/td8A3POluxlVDygUS0GTKxzfw0wtQvpYUO00CWq7Mnhyw8sZPx/1parNQQNgELMwPDSSzOqscNzic+8e0ph2s3w6F7fph+ODKWpqmEO+HhdeoPEtExGCK8bp/jurZQw/XMsTckyHTEnGPaVcl/EgPfMcIvsK7nv5xHSQAIr/4mhLeKh4OsxOLjdfUVmkWz3CctfYEbEyFlyVMGu0kIFznLPMiKFAn0c/toLBec1yZcvVYI8VRGBuNBdXTDZCmFdwzeLLGQep7I2fvA/V2DY8oQjxEXjnN7fnhY5nBg4EOqr4txQ+RF63OsMKtlzIibQbUsXCb8vNZC9CGStG3I0wF/jYZlQiTC4aHwj3WW2Opl3A2f3Krw2MwrnTs6VsqFyi9Cy81cW4xDOO7JYh9DL/F4s6hd+2H0+/1LVyU7dYykQ/niqZGqgKCGBV0oGEaTpGqO539kUZS1F6qigwaZfCTYJFmpkjQsQqU3cBKdj1WUAJeP2I4WLjWbYWuSCV7lPprrrAAjQEC4hswIn2i4MhTSyKEvznj3I81jq6pioEOmH8nsfKyj6HpA2m6uyWWhSMNwiJ01ZoP7vmRmUy+spV9vhAVQM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pAV5cwMxg3wbZcF8v3tJUyJYSnnyRZ8C4c2ZQNyXe+kzfxCTwWXOpsUh6xQ8?=
 =?us-ascii?Q?9JHOnVimut3acK0QISSsWupS6R+OZhJLJCiKcPnFivOyQQDNPy0u3hrQQfQz?=
 =?us-ascii?Q?cn2YE+GudE4+lLed4jah/eMw3Bt0Hr2QA/B4o84NjHu6a5yvoI2xaxiPbpzD?=
 =?us-ascii?Q?ndm7zB7FYkHSuo5EgOvDhnEETyFj19o8d4a0bKB6nmiGxxxK0Y95VCLU4NTk?=
 =?us-ascii?Q?TXbQNKIh1xEqE7fFg4lrHasxBb6lFVCmjEjFj4EhBqWlAgl6hha4jn5qI0Ib?=
 =?us-ascii?Q?5t3JcEGIocEUHF+ncs7y3cgQji7lUj2eImhbUPPeqqGsgtxau6wxAMWwTRkU?=
 =?us-ascii?Q?TXq5ri0e/t2VJpuSt5NP/2QjBOipr56HUmOWzCe58TX8zyOwLfRlNcjpX+F3?=
 =?us-ascii?Q?JfjB7c0gbGVRIA+wWmYXuEP/DZbcv19Xv4xLqnFOOSD3JvtSb/Wlxh3ZUoJ2?=
 =?us-ascii?Q?2HJHOmctjpbVfS6Z1H3x3SmZxJQktp17Kofo1HOVFDJMsZJynQByVL7M1m4v?=
 =?us-ascii?Q?h0DtyvQWNOLIYOtMPFE5MTkrs9aVr5RFxSHStoyYiZsSst3qr46mcAkOCETG?=
 =?us-ascii?Q?YBFXC5dsUvXAfBZb6j3l0ddrvk9zhWMGyihzqwgprm/9FPH+sNi1VhhYJwmN?=
 =?us-ascii?Q?aAAc/Qb3JTTkJnCT0p83n5uQalD9H0cNCNeUgkGXRsiBGHyS/fXs+qmNH6ES?=
 =?us-ascii?Q?CtDd6tnmBUh02WiT3Zubs/ZcILpbR3IO04sH1IPH3DlPk5Y56+UkFyrPdYCS?=
 =?us-ascii?Q?RQtWgmKWxAWjvG1+pwUXX+CdYrbUgLYIGOljfImap6lydGXvLNh1BJnToL6E?=
 =?us-ascii?Q?xjHme+K1Z1nZBViog+r4nfdjDqMg0ibXTwVvVvGmpwODC4pJ5PDg3tGR2xlq?=
 =?us-ascii?Q?AuOtAWBsbUPzstCJuogbFPsdOSTEfVeKE18Ly2LGeL6+/wGokzIgUyQmIRjG?=
 =?us-ascii?Q?v3351Kn4VMYkBAdrNUUQnck/6/tjBJVvVSZU8gxYG0KxcgY1cMq9mFDsw9um?=
 =?us-ascii?Q?tIB+DUlcxcLLr0IOGxjIT2hSu8D+p1t3j1LKCPpB6sEmoXK5EhXZ/pVncHVd?=
 =?us-ascii?Q?S89I4LnzSqXEOjjFoTATJ3RhQ8BQTlqebPCRvz9O862u2NNx6p1Spn4vCJvN?=
 =?us-ascii?Q?PWLOqHNf5eOdAVQ6Y6w4nr/1CDi7i0hNKQT/NzXg+aZ6cwIJlLRyLoc8tUKc?=
 =?us-ascii?Q?/76oKmYQRavROJn0VOP1nR1LzFHz5IuSF/7iL2sdQXqSU+kBwBXtxiARypxL?=
 =?us-ascii?Q?yJuAvuE/bFL5nGJx2duViZGzbZgH9N2HURrebQXRMCNwtBc+/aCOGgZbElks?=
 =?us-ascii?Q?6vjsFJX+FUClB5vLq0589QBtUHN1UC/KPG/AvfLommD70RoTt7GmokmzMF26?=
 =?us-ascii?Q?ESkJ/MCmbXcyXBz/hG6opoZD/3ABqrMVaeJTvOf0gwCL2U0h9XWVdLfH/WMj?=
 =?us-ascii?Q?k82MeUMSutSQTCQH71LzimGv+UKGXuFJgt3YN2e6MO/gBRBi6EOh2bouXzAm?=
 =?us-ascii?Q?fvdERENLDEbKgm8y+5TZiChtrYFk4dD1sny3b+JcvZR9k6PiKEW91XVXy5v6?=
 =?us-ascii?Q?XODcOvNHUBlR1e94dYcy6OEcx/br2ESGxLv5NbkW2O2u+BARjhJHDA/cJLJ7?=
 =?us-ascii?Q?cV6KEN3SYfm/8nyAShC1VAEBw8s5vRh5B4zP36pCGyxePfuwnCJz7gDPZglk?=
 =?us-ascii?Q?t7dBhxG2XBNA0fhscq0yO5M8CrfQt3UTH229H5BLD3U68U6stI9NefGle1Ni?=
 =?us-ascii?Q?nK8VewpZ+Gw4W7gFdzEeDziZFZdU3B4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a1jQa8BPVVqgvXtVYOX+U2yECwG6gCW7Ix1H0KquznwU1tErcpa+Vw93mb2tpYFnTVdxwAncKa7TS76YpbqbacGSFy6xUjxf7YGZVVU9bDs3xpUk/hhbS5XmmDsAk8Lbss5IIdtemXEX1ljtjTwlNJnwPkMlUNsbnAVEL5EEhwIGhGW5FTDP1u+qJd6eDnQ93Xy5iMpxtwvQ+yDrw30nGtoc5abvBDUs0/NyKpLT/sdILZQ9Q4Lr1ZXCMw9GooxWyylor8VaXxoQfclut/IKUGvPgoDfD6zcnHcWXKRC57xvkRMqzSE7oqEwQJtCrYQIuJqaqC+wf8cg+87u1V2g0lLJFgUcqJAn+ec+ry26Qr2SzfvJgMMYc7YZriirYoc+EpymMVBffwDH1wcuHyuGqHvpo9ks0y8K14J4NZN7VNMnvFJ3u8i5jvIGO+Lq0BdiDaqe4B3mTP2j4lvovq3rdxlXHTuK/CKEIY1+xLBb5P19/zDuKYgadFrLIGnYfG8J0aflQ3SSdBMIOrxqlREFh0FK+fetZZGOadoZiitLflRWe85szvbf4iso2YjsavRYBPSG9xhXqLQ3tKUSm81hyQSDYQ7NtKFNNiXZF1M8gT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ab9b6a-b4e8-4b31-4cc8-08de7882312e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:36:10.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4/eEFQMJFvdG8SmaFb016i53MqDjV0Vyd6XNT+KDIBUtOn0fOF4LzQu2UbtYSmoHLJgEy9KLNt+ua/f5G4aLK+Rgj/dqIS/fJAnVX04wJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020142
X-Proofpoint-ORIG-GUID: 0GH5txrBy6BuS_EzvK3i5DOOMHwhidKi
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=69a5ca8f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Easn8hJ1fSvSI2O8vv0A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12262
X-Proofpoint-GUID: 0GH5txrBy6BuS_EzvK3i5DOOMHwhidKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MiBTYWx0ZWRfXxUYBciOC9oRz
 btctmhi1GvAWhKDhkALJ/k/qVSym3aZiQyCwr8ExQlnHdRVSabo/xoNlJkHLrCngKwt6/007b1C
 ZV9Nafczmjo43JHn5wYtUz7Aej17Rw07VCpbfGqPOmJ/JCHLOB283OaVaarOsp7U9pndNbE6WGR
 31t0Frs05GfAFNLXdInH3EiFJYId0M5nKlN/dL5EtFnGqh5+cKs60+wE1+x5vWIKMVbnn7WbQAf
 OknStjfTvI+guoMUCa9EDviTw7cQup3WM4aPPUZFiaeAqXmmoUcE9C+B6T+vNjyDU1idqSKIEMg
 agd3eRcqbT3hbdQhUZFQjYsZq9Fx2WtLhy2W+hWI6jbj3MCXUE5+A4F4a8uL5lbOwkTxoY1juqZ
 MbIhcYt/B10CQx+jSl/40nq/OAiJq1/AZzq8VB56WV9BM3126aA2ZwkxgAZUWoxi3tkzYtnRGbQ
 4i2uHNZcGAnSd7e9pf7xiwsoGwlTMd0f1A5RhArk=
X-Rspamd-Queue-Id: E28B41DDE88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222659-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 05:23:30PM +0000, Lorenzo Stoakes wrote:
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 44ff8a648afd..fed57951a7cd 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2794,7 +2794,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
> >  		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> >  	} else {
> >  		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> > -		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
> > +		_dst_pmd = folio_mk_pmd(page_folio(src_page), dst_vma->vm_page_prot);
>
> I prefer my version at [0].
>
> Cleaner to actually pull out the zero_folio into a local variable, and also we
> should mark it special to be consistent with other codepaths.
>
> [0]:https://lore.kernel.org/all/20260302170619.867056-1-lorenzo.stoakes@oracle.com/

OK ignore me, I saw David's comment and agree with him, as I said to you in the
2/3, let's just take that as the patch and mark that fixes e3981db444a0.

Assuming you agree David?

Thanks, Lorenzo

