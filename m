Return-Path: <stable+bounces-92946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3009C7BF1
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759ACB26495
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332B167D83;
	Wed, 13 Nov 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D0AkMdfp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ElyTQ/ws"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062F13D8B1
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523147; cv=fail; b=huOF99jSYSw7lQkmk9SE2ajzCA20A2cPkxQqnoMWC12j7II3B+mQ03oscMvd0pgOQ9vnc40E0jQLQwOWqARbEKwatteBwDMgTsegI6Rz+D90IRvdwyS6wOeg7TVDjzmkU2vcq3mstu40+TIfX0Kw71TmXWc/C1YUQIszzi3p7kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523147; c=relaxed/simple;
	bh=gePmMZcxPGN3wtiC4weAyF64NQCY2TrYRINpYWywO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JPK03Wx9uKl4c8TqrjkcaURbmMn+WbkJrgpFsR69Y8bbPaImehBcYbpnb3KERbb4MYX0479QRhJheslfCcQEcA2eNcBdXZwSCCDm7MpGVv6Qs27Zll+cNSvJjPM4IK4Dm9RgOlY9dhNoWwZEahqXiVvr3QqC4pQyc6Q6dscuME8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D0AkMdfp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ElyTQ/ws; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBeEL007656;
	Wed, 13 Nov 2024 18:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vNcN1rp2qmg6XH1LqG
	VDZkpHyj8w52bvbr92MWmOjgk=; b=D0AkMdfpHdP9sq6f03qY1W84jDkU1FE+Jt
	BuExNA60TLznI9Z+wu434qLt/K5HuSC2RmasUpYgivyAcXzyPq5GdqGqSOe2JWYu
	ysQLwAJIy0J5f13tAiCpJxMDjrV0TAuwdkBW6Elfwi+U4Ly5Lu9iCic/181/Qfx9
	4mEqLIl4dCVxRLhXFsVurQnW25OFgMs63rGD/53O/s+iFl3uqKG1XTKAjrg0yQgc
	5kG1JnNY/ofj82qo+sA+OZHh2Bmbtrdd/ZTSYFH3A/636Qi7kN+FHpAySQh7uzfL
	cdALJ7CXkkuSwwxCQMstaCs3Oop330ybtBxBvdtYdL4h+sE/B94A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n4yjfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:38:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHT4vF022819;
	Wed, 13 Nov 2024 18:38:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw06xs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:38:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI1FV9VMn6x2sA/HKRtKgCu2013ieXH0Wj5aGMUlYCs+f7rymbV/byQ/HVBWImlzk3F6QrTXRJqlSOz1cJgsP8ksiWtIY1mG4cKXwRARSq+wc39bNf/smLK5h0cNQYDscev5Um+dunrXSMjdKZY5cvlP2bsNokwPWGnkrl51M1PGdVf1ODGPEpo7qxX0CEegIcf1hKmvh5Yf9rFZEnF+6Pc0VqrhqHiAoN3ZSczxX4QFNFLlPd4OfAGZlcTt2WH5LFlcUooJ32x/5ZakR2v1Hw38pBBvJslxT4HWs5tsVBFgcyE7R3B/YgSKUu1HpPVODcKvG1guD2Fm51TB6zCujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNcN1rp2qmg6XH1LqGVDZkpHyj8w52bvbr92MWmOjgk=;
 b=mpdgu32BVD6E3mKqllQkIm1iubRG125RltRVQndgHORJj9+Z1YiJjS8zdgFFW6CTQnn4cRcxzSOg+7sCUT+rW+RhwgHHhNYzd3E0Uxt07HKpqXAJyEKynhdm03nn77+UF/9HOJHpA2iiqTZW7l3g6dwGX7haonciQDbXgMxKBvLf//Zs7K5kr7g60GAk+lBLgDmTKbokiljisIuFVZ3OUn5MwMADNnlBmuGJqiFdVx9vlfrbV5hD4J0FiAcVCZf20/r7boOLg8PuyusmGSMT1951QV2wnLjU2jTW8ownuJbvX0irgny6/DlnpfyNTstdLle4n2JiIN/t0PE7i4m27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNcN1rp2qmg6XH1LqGVDZkpHyj8w52bvbr92MWmOjgk=;
 b=ElyTQ/wsRODlYTMnDkxtX93KmDX8ETSbVF3XidS7QNFMwCk/XYf7FqGbY9Rp2Cee4QjkDeQuQDWBtEsLA53YX0W/Mg1RWnLr/MSWx95ElF1Y3EV05DC5ebsf0khqdHpfMDZQ2UDdsxRzDnY4EkRucaOPJ8LHlqdKgka0C8cOrF8=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by SN7PR10MB6596.namprd10.prod.outlook.com (2603:10b6:806:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 18:38:54 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 18:38:53 +0000
Date: Wed, 13 Nov 2024 13:38:51 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] maple_tree: simplify split calculation
Message-ID: <supyd4e5q3th2u7pcrt4c2rm46f6v4tuh7tt4fomgvajiltrxr@z3ub2a7xkqjw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org
References: <20241113031616.10530-1-richard.weiyang@gmail.com>
 <20241113031616.10530-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113031616.10530-2-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0003.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|SN7PR10MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c74022-49d0-4c24-e62b-08dd04126cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66S7vB1NYG9s26QZS49FstsTJewaSVbmprCnhOE3FMmrGfiJuk7iHJFr5BSO?=
 =?us-ascii?Q?/wCVhSi35zYXB0//HoUrT3mOdGj3ScxZWIQUQT3YhJMFyum/Ctz7KhLP0TTu?=
 =?us-ascii?Q?iEuVgo/GWmSUBB9CY14yv/GVjRZr7HksM9UGro/XHJjqU4Zvg6YXgIB2kWZ0?=
 =?us-ascii?Q?HqsxFg6z2Y8yFhJFug2+8NiYLNUri5QUFRErpVl7MZMo+rJ6HIOn0eVwAQvr?=
 =?us-ascii?Q?+Sl870Yg6UhTOj81rWK+W8ayv9YG0t89jPNArzkepy1FMA4gcZfklJQD0ksG?=
 =?us-ascii?Q?sj7zlSE5tEUPvhe4HxQML85IhayxCo7cflpIaN8gUSKMthxq8deBVMBqVLXf?=
 =?us-ascii?Q?gBbZ62qdWdEHOyfFqA0XVzdJQAGqD/ky7fk0JPr1kNpIsPoV1kFC0ymLp82b?=
 =?us-ascii?Q?8xKqlCQJJzzSSPMB7kN2RmPdr4uYh4luNMBgJju82O0x+y4GMefhx5f7M7h1?=
 =?us-ascii?Q?WQ7cGzeH8rMD5Sll177RjrINZKa/yy24kfnyZ8s7W/8cH3eL312lBhZBm2kR?=
 =?us-ascii?Q?3TZs6GTRRJRAiWIUIk/4i7VY+P99CEO3Uuw7cjLEe+dCGvuNOqyzWM08hs/6?=
 =?us-ascii?Q?5c5cCXFGxUk5sfHniGwFxmwYfer0e6FL1rnplB08qo8551sudnGWkDOUyXCp?=
 =?us-ascii?Q?2xe46QKfO+jiAYLijT/eTHozN3iqGR70OvJhQ80ueWz0/caqheRg3lvgwm2f?=
 =?us-ascii?Q?ZuTvNSBMDAFvviIWKTyOsuA28WiWfv5CKD9O+m9Q0OWc/SUWmaBJBd0yVBLL?=
 =?us-ascii?Q?+Uv0jmvZj6emUvsMaDXN9puYGxpDj8WYkOnhdGZa6DHRl5xCaFHMYXh249VB?=
 =?us-ascii?Q?9Vvs3Yep0rSdsg3fOnem8d/fl5mctcashY91SM9ggRY2MmCa7Lenps6tcrQk?=
 =?us-ascii?Q?lZJqxDuc1Wgn5/e+TuOKzFFxn4WwGDvWORAqKFP+Jq7yfdugCYhbgk/jIXVi?=
 =?us-ascii?Q?NaqX6wEz3N2YDPJhP3NFYL0ZwGBU5x2LHUvOoIfYAJxzs/h3iAYeB0A6ageR?=
 =?us-ascii?Q?T2Kmt8nC5pQ/mvlHw04pGaXFJv2BWh6fsE8nEWXMLFBmY09VpuD8t2RqYGlV?=
 =?us-ascii?Q?NSiqLkBVSRbddVBrf4E3GK0sB+SsC+VYgDB/jsivKKah4ndNq7cuZSWufoRM?=
 =?us-ascii?Q?6R/FzuwguLmQI4Tk+VzpXaXnzCUBcpSB9MGHjj2/I7okp357BEHzNgmqHiSm?=
 =?us-ascii?Q?4WxmcThTSi51jzktggfJy9P1/eIoNMPLr6kkNLeZG0/KVzAmxlE7S8xQB4JJ?=
 =?us-ascii?Q?xOojwEBc3VAjy3ezJiO01AoohIX9F3CgLt3SNqBnGKiwntytdKai2XWZzhvq?=
 =?us-ascii?Q?fhAvaTtmqoUFGnmjhsrloLzB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFGrSr73TqE31WDwWP0ekYDrd3+LYuoAo4qVoI9HbUXY4m5irx0lVW2RC5cg?=
 =?us-ascii?Q?E3w8otTIukyUPQ/zZ0LjxDYbqfeNqBh9Y19NFcszRpjRFF1mjN+XfUn6Up1P?=
 =?us-ascii?Q?6J2Kktfc5ObKNkDgfaOZayBvjTQW/IFaAnQZOBnkrgKdZKxkqQnzkbyPszRP?=
 =?us-ascii?Q?MAHz9eF+y2J0hWaBrgfgf0qFObLPKqH/lTR6RuTa235pp7AdFCNYuWCPLfX1?=
 =?us-ascii?Q?jLQRQAFwpeUWMbiH1ZQI+UPr5MRA+QBH7iygXgqsc/gNg+fFjQPaCnUkB4ou?=
 =?us-ascii?Q?E2Lj1zmRb+e9n5LpXtpdG+O8lPpI97pwzicFhs2O2YuOUMYfIVGAh/vnG8MG?=
 =?us-ascii?Q?YnPBSW38C/qTW9ccF1nRhhUCeXc9d0h4vRlmLXpVEKnk1sJUQXaNSNCKhtwz?=
 =?us-ascii?Q?PJROgnnXwDwQuem+0W/nGwMz7TSnYx0UUlnZZL3EQZw5WAgCIB1f0FfjKnkX?=
 =?us-ascii?Q?5iqfT/2X7SF0Ku4BMxcPzepogeX8rCydUyQJcdi64vV/Tjf8G8ErQd1+vHaf?=
 =?us-ascii?Q?cdUN9sKEELIlM7WgI4nIRP6DVwJb0yZXPycmGbceveYzEslfcEG6xDLanBj7?=
 =?us-ascii?Q?bprioPYe2hplKlY0CCzWdNx1TGCuiz6yi4YPcWHWXCMT+9RE/BAAWaz1det0?=
 =?us-ascii?Q?MZXUbyT3bAMA4h4EVe0MdXmnAS8ncczH6nkeca/Gq7yPlCYI06bsXEMwCmz2?=
 =?us-ascii?Q?LDZ+nCpJ7AiVnWtDCd/fsBRD96tMhjLOzmbakMfFvO8jLurIZsdYiiYQdIV3?=
 =?us-ascii?Q?IaGHA2LbiuBg0ikTc0Qq0Q/BtMi+uQY+XgXzHx9JreZ1/qIc5JFQr/4YMuxp?=
 =?us-ascii?Q?ZRKNCVJG5uJc+IAX7W8txELILK3N0MN9nDz9vqM5gGDnOfrzj9dxNws88bV7?=
 =?us-ascii?Q?qzU2HPcCtAz7/WYpNdiauQ2Rh4by7+dx+vo6mhoK8L1nbXgS62CTHxfKTM0e?=
 =?us-ascii?Q?Zmb6I//0j0GZlFXTvsHSGCAp7Eq4ewICToWpfsSjXSfRySyelVXUfStm/Sbb?=
 =?us-ascii?Q?6JKbUpZuo7I4nHC1WyyWIiBdE+YDF+ySne6RkbkSSa+Pr0M9F75QVAAZPJqU?=
 =?us-ascii?Q?J15Xt8onU03mUACAeINxqcWQdJXCFomulgwID8SS8ge81uGq/q29DPPMaOE9?=
 =?us-ascii?Q?x0nJM+2UZ9J3K0Guv0R2+R7ZU3Xb7f5Z+SYGlixpkZkgskuG5RfcjNwfpasM?=
 =?us-ascii?Q?Wo8sQdgKUoWCiEJzGru2aByuUppX4ADE3ssRpvA++TF0H9nDmvmWDJdoUNHM?=
 =?us-ascii?Q?r9Rn/vF1DpJW+9XVdyYyWrc9ISKC84k3vm/L8S61RH+yz3N6MGYkZWLIbxKZ?=
 =?us-ascii?Q?oJYh0+lk3a/ni7RV3dAdKzLdI4WvPY/B4HaQu+8yPUqEad+pKX+SRxsX2qI+?=
 =?us-ascii?Q?F5E9X3on/AzjpXdEzhScCYX/UbDWiXSV1qv7KQdWY8DYbSCMxTAMxvNWVVhh?=
 =?us-ascii?Q?XX4Yq/2iBue1jWXRtJol+BACWE/VXKQ19YwgpCj9CCq6yFazZ1tf3GusLJp3?=
 =?us-ascii?Q?nzlvl/QdQ//GcgPdXinGMmi1iQfWtPumUwxapStNeeVGqGt5BSRv4VaRvQs0?=
 =?us-ascii?Q?NJhJYt4sFKbUeipu3JP2GC0An4ptwbEh3NcOW/MQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KRYSb3bXfkPziaYa+Yq0loXRvvu3taq30KNQM57y+Dfj+kD9GfkqGGaKwXyBFflap48mtPOi4grze0DP0lFbyG64+tNNjKX7LV1FPiAtouYmKnAgPM2CTn0846U1ul3o5myX95h94n+R83Yshm703WAa37G93p2OkpeVcGY24yWNxmg9ZaIi1Aeex6bQmeIEB8aHjkAS3734NlcYZIOx6YXOlaiHo1MW3djf82zClGK/zoRf9yxGkkuElKfe8K70FuI6p6GoXjlanoN6qBbg15+oKBaWOyp/2uOs3K2KDJxUmMEshMDbnzvgJsmZNCmdT1s6tp8e4FCTXAdtpli5CKOvJ7pgMgYJCNlYaEfbp4zn6QYSCdxN7A++cky8b3P/r3KKwr6vQ0d9vfKjn6AYv626VPr3hus+s+oYixkevr87QSaiRDjJ6DMgIHMOj8Jg0xR76+C5Yl9yVSBcZe4pIQGLtoFjKXq0XRD1C3t8x61OpnCTB8/pXJ5lfRzdxS2VyDD13xoKxVaUt3FfVXeivoru/0FJLYE0NAWQn42Jp8jl4HOBNJCRTyi+AoIin70OZuBWI4Ny/5HH8cwax+OZbv5/X2o1EEv/vibqdPmnOzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c74022-49d0-4c24-e62b-08dd04126cb3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:38:53.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iknz+PRpgvS8CvugpnxLHM6a/hFrvv3fPvrtc+7PyFsKr0IT9cOX2Qa+dohUjd7YTuIcGO2qVVkx9F7ZyBq/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130153
X-Proofpoint-ORIG-GUID: ijNAJATUIsQrSqLSCyhwfQRyDrG6Yphb
X-Proofpoint-GUID: ijNAJATUIsQrSqLSCyhwfQRyDrG6Yphb

* Wei Yang <richard.weiyang@gmail.com> [241112 22:17]:
> The current calculation for splitting nodes tries to enforce a minimum
> span on the leaf nodes.  This code is complex and never worked correctly
> to begin with, due to the min value being passed as 0 for all leaves.
> 
> The calculation should just split the data as equally as possible
> between the new nodes.  Note that b_end will be one more than the data,
> so the left side is still favoured in the calculation.
> 
> The current code may also lead to a deficient node by not leaving enough
> data for the right side of the split. This issue is also addressed with
> the split calculation change.
> 
> [liam: rephrase the change log]
> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> CC: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: <stable@vger.kernel.org>
> 

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> v3:
>   * Liam helps rephrase the change log
>   * add fix tag and cc stable
> ---
>  lib/maple_tree.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index d0ae808f3a14..4f2950a1c38d 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1863,11 +1863,11 @@ static inline int mab_no_null_split(struct maple_big_node *b_node,
>   * Return: The first split location.  The middle split is set in @mid_split.
>   */
>  static inline int mab_calc_split(struct ma_state *mas,
> -	 struct maple_big_node *bn, unsigned char *mid_split, unsigned long min)
> +	 struct maple_big_node *bn, unsigned char *mid_split)
>  {
>  	unsigned char b_end = bn->b_end;
>  	int split = b_end / 2; /* Assume equal split. */
> -	unsigned char slot_min, slot_count = mt_slots[bn->type];
> +	unsigned char slot_count = mt_slots[bn->type];
>  
>  	/*
>  	 * To support gap tracking, all NULL entries are kept together and a node cannot
> @@ -1900,18 +1900,7 @@ static inline int mab_calc_split(struct ma_state *mas,
>  		split = b_end / 3;
>  		*mid_split = split * 2;
>  	} else {
> -		slot_min = mt_min_slots[bn->type];
> -
>  		*mid_split = 0;
> -		/*
> -		 * Avoid having a range less than the slot count unless it
> -		 * causes one node to be deficient.
> -		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
> -		 */
> -		while ((split < slot_count - 1) &&
> -		       ((bn->pivot[split] - min) < slot_count - 1) &&
> -		       (b_end - split > slot_min))
> -			split++;
>  	}
>  
>  	/* Avoid ending a node on a NULL entry */
> @@ -2377,7 +2366,7 @@ static inline struct maple_enode
>  static inline unsigned char mas_mab_to_node(struct ma_state *mas,
>  	struct maple_big_node *b_node, struct maple_enode **left,
>  	struct maple_enode **right, struct maple_enode **middle,
> -	unsigned char *mid_split, unsigned long min)
> +	unsigned char *mid_split)
>  {
>  	unsigned char split = 0;
>  	unsigned char slot_count = mt_slots[b_node->type];
> @@ -2390,7 +2379,7 @@ static inline unsigned char mas_mab_to_node(struct ma_state *mas,
>  	if (b_node->b_end < slot_count) {
>  		split = b_node->b_end;
>  	} else {
> -		split = mab_calc_split(mas, b_node, mid_split, min);
> +		split = mab_calc_split(mas, b_node, mid_split);
>  		*right = mas_new_ma_node(mas, b_node);
>  	}
>  
> @@ -2877,7 +2866,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  		mast->bn->b_end--;
>  		mast->bn->type = mte_node_type(mast->orig_l->node);
>  		split = mas_mab_to_node(mas, mast->bn, &left, &right, &middle,
> -					&mid_split, mast->orig_l->min);
> +					&mid_split);
>  		mast_set_split_parents(mast, left, middle, right, split,
>  				       mid_split);
>  		mast_cp_to_nodes(mast, left, middle, right, split, mid_split);
> @@ -3365,7 +3354,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  		if (mas_push_data(mas, height, &mast, false))
>  			break;
>  
> -		split = mab_calc_split(mas, b_node, &mid_split, prev_l_mas.min);
> +		split = mab_calc_split(mas, b_node, &mid_split);
>  		mast_split_data(&mast, mas, split);
>  		/*
>  		 * Usually correct, mab_mas_cp in the above call overwrites
> -- 
> 2.34.1
> 

