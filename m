Return-Path: <stable+bounces-158455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039AAE6F62
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 21:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282D2188A823
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F38298CBC;
	Tue, 24 Jun 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LM8PxsSR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K6HDhU+/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD57E1;
	Tue, 24 Jun 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792748; cv=fail; b=QvRnWCtd11C4toZNK1AaVuHZsR4u0vEztJy+bPVIu5A1J/QpRt3ZyTKpPz7HOV5GiMA6C+LmVEH5GyidJcxggZEh3NtguZTngFaxxsNbln4rv+h/omEI1vaWmprRK4l97xu22kvTl57t+ASIgtW5oBwLrxyXG8otUktdd4Y0neU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792748; c=relaxed/simple;
	bh=bjSYJAeR49yRsP/gtwn+nXQdpnCvHubY9bwnisdl7FM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TNB2H6qlB/CqCfW+5HuGNYLNMU731ALfycuBcjwu2wsh4WraYORDY5SSYIZYRrfzNXaMT8FUAYoTmcP1tRJVDxb1tzhJXH2b6yqM0QvYnAzy1ELkJ9qPel3t3LTg7JDd5b8FX5uJDi+F9ZrViTlyRKgmweI5fAmWWBGaN05FBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LM8PxsSR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K6HDhU+/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBiv9029904;
	Tue, 24 Jun 2025 19:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=nHlqYmveCJ49DM//
	OmQXanK0IQlZqB24DG/9F2txZWA=; b=LM8PxsSRq6+jtDNYo4fe6ndDSNOjDfgU
	s15a6LWuqU6INDiRJMEV41lhRCox7PBzmCrmmxPSTXRRIoqOLC6xr4u/xdmBQCTt
	mZJnPv8Y0yUz71O4DOLINvGgg3jb3/GkhTGWeF5uKovB/krI+E2TSCC9PtuP+p2j
	SRi3aUqfZ/dCPZCYQX7Mv1/50W6PR4hTWhypGmtlSWaA3+vCtrCTi4RlNCXRCyQd
	pDqv9LoiUFFr0miDDV/H3hncPQRCG02ihH/vCZ5XjQRFEh2uyimcxD7AErlB95kQ
	CgNGFB4UtrABOeCJVwCLHZl66Qu5f7GMNWJSQVJGQA0whxds3GsCiA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y5wgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OJ0wHW025598;
	Tue, 24 Jun 2025 19:18:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvwjguk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpDvnDJqbC8OTd5BgiLa03tV/vUkK0mHjDsL792UR+5XW+w6VOl5J1Lo1AoSU+LprnLAr0/vgyWJAluh87Y+mAcX5KvNK4Vy3Zk7Zcg/XXczqUqtgl1wS7JJC/Jn7Fy+DmF+FZnSqICuO3ZzQ1591oIorqn5iVwSh8uMwiglj8YIQoNE8OGwQ/9/FibMTxYMxnZTTnqu9PF/DcrjjKk9Cz3l3Kb7dwqFR5u0Lqv4KCffWSd0RFkFeOnAQzP6VhM0f/YJrW/DIPhqiS8XqygdoeWTiha1BvJkHgc1xeSXXz36QPGmt9NLfu2qR/y5VrdMIuLbACxV1cX8ZWmoDGTvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHlqYmveCJ49DM//OmQXanK0IQlZqB24DG/9F2txZWA=;
 b=bAN6yqQAQUOnNhnSqNn6mbOGQWIgGi8TdC9YGAm0ISP+glJDwVJLMkgXFRCblhz4gYSRNILp5h7zBDXf+PyL2w1MBmW/R8LhR4rSkA6EPExVcumSejxfgy+EtUXNu0lXMxZnjbZVatEDygmROBVhxNlHPOJbeRnSeOIgt8q7tgZ6iD4HNcAjg+jAFIOKM2nG/FIAToEya6E3IP8fQEp7Jwqo5TfavTMoeYPJJwkpyMZ+xG1q9R5WEa9NRnHf4Ivaj5jhsQx6xCuLTEruh3+Ipp9YnaReRW83g+bx6fezSjpqimDb2RN+TX+2/JuI+fX4NDuq9tKxNjKlkZgvy5Ivxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHlqYmveCJ49DM//OmQXanK0IQlZqB24DG/9F2txZWA=;
 b=K6HDhU+/V0iUtrSFz2M4fnqNaPZuO8yKOSSSsbpA6IA7KJpkGC3S5hE+EfCKqZeJy8PZspdP5sKF7qru5Ld0Q6Il4XHfKtu5tTSVSYzHu8QWrv2WxdgFUjQ5vpkveVDPEDHfBtTw4ZitAer25N1mD+RlKrh2Xg+Apib3rItFvZo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6905.namprd10.prod.outlook.com (2603:10b6:930:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 19:18:46 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 19:18:46 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>, stable@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 1/2] maple_tree: Fix mt_destroy_walk() on root leaf node
Date: Tue, 24 Jun 2025 15:18:40 -0400
Message-ID: <20250624191841.64682-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 58720236-4efc-4580-f0f4-08ddb353f0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGpgFCuzX8wHCKFfJ84b+/E3T0IGRBBpWBX94CQya9AFZgELEguFxJm1iM5B?=
 =?us-ascii?Q?Kdp58Q2OlX4A0NmrckwVAedEkwZSAfQ1oVrdvNJgb1+3rl2x2EpW1/FSJUik?=
 =?us-ascii?Q?rJ4np+WuxMEJobgPNGnflN8ODrDTiVnJ0K3rubMptQSk48n+l/974Czu/+bb?=
 =?us-ascii?Q?PFjjjjyTidpDHTwX92nWRrSkx2+QiqZE80NyEqoJefREKeNNBRLxAt2mO09I?=
 =?us-ascii?Q?PU/DS6s7KNphpcru2kAYKt+mK4JP5sXTQVfou+Svp1syF2C3BVMybu5JhYip?=
 =?us-ascii?Q?fKKSKVvBnGRIQj2usBucaLvcZcDSzYrAir9EDG9q5hIHgyWTpuSB9T9LPXKr?=
 =?us-ascii?Q?mTPVIjmp2nvrRXOL9Jhy895NV+HzcJuwBBSJK+wfqpRyp9CWJpYBeZB9GN3t?=
 =?us-ascii?Q?/Bm9w+1mdmB2GofcLKBKtgl6ZERRLyjJjmvItwtTClBRRyGw5M9t/tzIGotM?=
 =?us-ascii?Q?UPXrTM7rC0+4uFJu7pn2mBAXM3POhbV0SozZtdE4yhuDJManKpQg5PGEYXY/?=
 =?us-ascii?Q?7B6IWfzyzRmPn2PO+suCMfuvkS1vwG2IOc0/Fjm7k58bWZSCOkDXr/wpo528?=
 =?us-ascii?Q?jkByR/KkJ7w/O6/5sixl6Ye8VCk5CO5iRrSM+/QsXhtXXOEMt1dDDCQ/vgWD?=
 =?us-ascii?Q?j9uPDJX+wQbA2kel5nH8uZhHJHfQFFOMI/WRcVI5OqelggerriMUf/hIj1/3?=
 =?us-ascii?Q?kN28yN8BOgC53N7vFSsalFXPj264IUmU1fVDR8hUe9jACpDZq0LbwFg+lRhC?=
 =?us-ascii?Q?CnBfgVAlsBrBlsj5oJE+nNiZ4Gt0v9LKsQ+XjuVFMVJQ9Pacaj/PGMa9s76Z?=
 =?us-ascii?Q?L545KNdnLaCR8gucqmzeLT8qKApqz43xYsdPl+x9HXlM6529smyCq/oB23+v?=
 =?us-ascii?Q?DSTHRveuReeZrECQ7VjFz4puH6Sia6xEliNzudjXs7O+FcV2CJBy78IZOBzg?=
 =?us-ascii?Q?Ux0+qodvgbLEq7/JbdegfqYEHjP08WRpEevp4SHzxMgoQPZwyNYIYvzT2AhA?=
 =?us-ascii?Q?wdBPpT2C0rBujgU1G1Rd4LZmtt/TCEmycTD0CvdPiwCoXFTz/XHJC1jvavrq?=
 =?us-ascii?Q?VojV7zmSRCjo+V8+A0+p5Y+M4+yeJWTB5hrXij2VkNnEPO9dB8kj9g5TNn8z?=
 =?us-ascii?Q?mN/S2NvQ6WuzuCyVy51mSf+Ty38rUq6tnG8ILKhQylnua6LFUpRKRkor/TOK?=
 =?us-ascii?Q?TC4AmOnkkfJiMbQIeHoa5GqdvaWPtFg5j0jGmhChWjZbUoWKRATiVxu8a1vv?=
 =?us-ascii?Q?oumhENi4hgePR9vb2OjjXwe62wi+CL57VExQiHv4N+gSx8HoreO0K4v4Fqes?=
 =?us-ascii?Q?kT4+JoUvKH36MBb3g8HNZrI5BPcf9uFoJ5llHsyb8i303hWhYux0Xqx2HG9l?=
 =?us-ascii?Q?4ekXzH0IsZxpd65HGzw2LK8WDkvUb4m1TDc3g5RzD11AqW6IADx2gLoZ4/ZI?=
 =?us-ascii?Q?oEvyhnP+9FY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1/bPM72KUe/Tk1Pa1AqWzwbntcZSxVC4kQ2ywj16FWRz4ZH5CulUF7JwUiQ?=
 =?us-ascii?Q?oz7VYZcZ005E0cURg1uv7NEMwyRxennq6IHJbDVOqhsOCN4ue3RkhcgqFcOe?=
 =?us-ascii?Q?q/Ccat+BYAH/uWCQC0p3DPlTE1Iht4tmgGBkb5Q08zgA5M/NZ03yoix/UwiJ?=
 =?us-ascii?Q?uIIYXVFKNHBVCFbYbjs5mq9uwWmCEQDul1WgETOn2VjNrVdq8H/8Hv5idr5c?=
 =?us-ascii?Q?8NLIixSZeOI2J4cPKUMMREGNK16DF6ukdGvVRytHR0YdhVzEoZxNKr1RjxAZ?=
 =?us-ascii?Q?e8r7/Cg2kzK7Iiy8k+Z/HacPC7bxEwU7kll4ayao6rWvCu8TjHQslBX+syc8?=
 =?us-ascii?Q?9Kik3QnR5EXoeERm+I3EJart/iG3YStIKQnAUaRb7l2VEUew57bDxyKNcWl8?=
 =?us-ascii?Q?lGXt7vBKG6bH5Jfcs5VrV6hTGmtxSOzvDfUos3URkrHrXmhODDQ3thqXgvQE?=
 =?us-ascii?Q?HK7K67U+z/d28nM3hYhCJ7hGC68JQfaREgjq9czwHikgFgnwv5AaLBy7/KLg?=
 =?us-ascii?Q?axWhyIB9/mEP6oC6TvLw1eQLcP1JbAyzsiXdOr35Wr3zSpWUMceMVUFWDfIj?=
 =?us-ascii?Q?Al1S4WrG/eReS5etI0B5EWR6em9EAdCrJwW39iTGJpi4BDEpC6KLfN+1NFAz?=
 =?us-ascii?Q?eK2rcNUU9eIlxT0xWTzwCvmqmyhsyGrIm3q/UCe/XKHyvprdubkcvLA4dMIa?=
 =?us-ascii?Q?p+SyH7wEeWKFM50gBmS2Xf+oJo/HQraoUP643FTZQVdI4XmOsMmn9GyA0g8H?=
 =?us-ascii?Q?ocC9OF2sMUimZDjfXQ1nfhnJGYJHkawMkDvNjf1wvgT6df5Z2Lm/NGZiunN7?=
 =?us-ascii?Q?d2qqYXZQn+tfqfqODgjrHdpNoigStAsyAOAW/V8JOoEkDFCAoFm2AiZMNQfk?=
 =?us-ascii?Q?HNCingmLukv+vitXcm948/49U4waCJm4h8RMlfZF1BIsNq4Nby0anevBKlF3?=
 =?us-ascii?Q?U+/yANw5DIk6KlxQDb/1PM2fb+id5NNeC1CzHDaXh9NCxIBRYGnMQaALIJZU?=
 =?us-ascii?Q?iSLKM0WKTSJs5tQP61bIZGgzCYwSQhz5bqCOuZs3iVQxKiSzBD5rHc0+9fJ5?=
 =?us-ascii?Q?CRBpb2F5gAnFpPIh82wJFy9DXHhSUqelLD4yaYYkwNYqDkmi042IWvtxDI+3?=
 =?us-ascii?Q?SOswAKTlZ0oEBqoLwJuQg+e4XIz2shwPeuvBgMd58c5p5KivQOKkDbFUgzXR?=
 =?us-ascii?Q?kj73uAe6xcBjROrtmjN+Rjd7YkJxinvkcOhd+EKxmrEGy3PXRHLdyrqq8lU4?=
 =?us-ascii?Q?PkzdWERr7uDpYlT9hDKSvK9sxCdLoBPYuMUEMhHztuBABG7qa5fkJjrdaulB?=
 =?us-ascii?Q?3cbMnUoduPjweBO9BJTxbBCf0attUE+7z/Q3Khew2aJb663NTQHZudPUCj6V?=
 =?us-ascii?Q?Va3OkfK9wxSNIb2Nid9XThVOfEdwImKu45hORk/k3SsWgUzVSSpFMOemDe+n?=
 =?us-ascii?Q?TypwvPKI8/erKQpCQ2gbTQ2Hn/XnFoyz5eusmkLOBPP1YmHQ3s4paIIsrp3+?=
 =?us-ascii?Q?pFrQNzsJGrHMaOkJ0RTS/K5BzT7hkXddfHY8ed+EiN1o3XYjftEfktphxqPE?=
 =?us-ascii?Q?ik3+3a/nwG8AepjcZfkwyTWujTgNqL8UwVPq2vbU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MU93HhCBagpbAIVJpXHuKt9+VO3tqUsUd2bEDcraTMNQz/Qktx4yDmJigLw0dXLZe5PGRMBoRQRDhX4gEpUkyvE3pPtghRK/ezK2vYUPDWL6YxorFnQaz+un9vR1Vw7r7gmyGh6ITpyh5IbsrvKbjwtja+j6maYlJXUzcCyssKcYLf70movwmuh0+cc5Ywkuawu3oZmsJEYqAAwNYYLKc2eFeNs856rxFzO3y8tP/k/w4jLP1VwcQnCHfZMd1VfCRy2Ozt0HImL+EqjsCrjw1Dcf0QndGoCRYdRljNlCDzkDveZp7A0WBnhiYg/ju64ShcBdI1vlPBLuFxTnW6s5tSlyCRDvbM0aD7Q+UnPpTXFaIjFoTwpNaaeR4aKpTDQloGEHmorotkAPSUbBy2SqhAUe6HPtwWSXRAlurlBFo5j3iS3VeAByY+KceDQJ2esj2EBd5JBPfD8eJ6cGnDWTdfRRW7FQ4jOwbNLA/Y5ATqFLJ1mN8OcDXSIvwuH5j9Mtfay8ochAZvCpzntUgS/sxun0ZIKLxbyzPYMHAQs4rYVBw8PohApWlPaDpot9f5ODY80kLhP3qSwpTyE3T1kXIxK1TvLOKR2A2CUFZw5TV/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58720236-4efc-4580-f0f4-08ddb353f0ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 19:18:46.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwabxsG2c7tVs3sHtE+UxpCrzFsy6PqdircjYvBybhUiR2aT3Aa5Y6oPD9oVTXimLm/tO+bqFU7kCxDNwhOOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240158
X-Proofpoint-ORIG-GUID: UUO9Z3mLHI4u215xixLfxRBizkYR69La
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE1NyBTYWx0ZWRfX2GqoWHiFjFpq Be3zttqUBHiOthWX0LfzH5uctFT9DGukma7hrKVJQ56GSjRe4ZR5bW5rasKWDekOFgSAtWJtz5n 7edk80usKbs9rX9FWebu66wLH2qqG2f9KcWlzqriT7+OIWq67HIFP1VtK9nebbEJGLMmsgPOm0y
 H7Vrjx9UeJdd0lU49A7Rn0BBXOU8BIZQ6TB9K7U8cbZesxOMg+5kTXnsooK61+7ZHl1aZzjYCd+ bZRcmFijmvNcfKR2cAFlhCvYPslAOXewYvYRjseYrO7vcL2w7nbNd1mui5AOCmP9Qea5Q6T075v q6pjEYUiS85tFwNnxvywxdRG502ezlGli95N7nRK4ITYAJYwt565oDftzQ+l9luCRhJw2YcfugR
 hPnkvAY9gQsYIhrE/P7XSoyYrhxy5/S5RbF6+Ft+k94PHy0Q6cLMXVdOWXEmEtIlYx0LFmd6
X-Proofpoint-GUID: UUO9Z3mLHI4u215xixLfxRBizkYR69La
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=685afa19 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=JLtQmcOdNhV--w2LydQA:9 cc=ntf awl=host:14714

From: Wei Yang <richard.weiyang@gmail.com>

On destroy, we should set each node dead. But current code miss this
when the maple tree has only the root node.

The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
node dead, but this is skipped since the only root node is a leaf.

Fixes this by setting the node dead if it is a leaf.

Link: https://lore.kernel.org/all/20250407231354.11771-1-richard.weiyang@gmail.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6b0fc6ebbe363..85d17d943753d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5319,6 +5319,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 	struct maple_enode *start;
 
 	if (mte_is_leaf(enode)) {
+		mte_set_node_dead(enode);
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
-- 
2.47.2


