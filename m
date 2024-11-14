Return-Path: <stable+bounces-93039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E738E9C90D6
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D3C280DD4
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7BA183CC7;
	Thu, 14 Nov 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LBJM7Inr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FjLfoPdY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217E2AE8E
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605448; cv=fail; b=V32JfcAk98H5fsG/8kJC8fdFe/e1XT5xmoPgYTcjMVPA6ZTur6FX26RFMQJXUtVPcvXxVM+OuKZH5FbfUXD4tKcLscMxSDTKyVDzLdellTNegB5Aom2SLwoZ7jW7eZIVPo859jqfgcQXLJWJMKltGyg2NXM9fo+sNr1Xc0jDVw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605448; c=relaxed/simple;
	bh=uXX6aoak5tH/7qRSpfxsAkXwvWo6KxTTuLmNfOyhcrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MIbTrqaafao/uoWsiCeBVj3bEl0IHJJVoFMnC+m4lL2g7MZObxapR0Ea4azaGKwFJ9F3vt+mylX5j5W7XcN0zoxNV2CO/fixV+LBPB5rJz7Z0gTalT4t6QU/QtuF+sL97sU/AKsW8E/7lXjanZTnPOYzBpoEHzAeNXFMDI0RIsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LBJM7Inr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FjLfoPdY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEDAsN3000538;
	Thu, 14 Nov 2024 17:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IcuESm/US6y2p3RKGpVl0Y5pLAZ1ObANDungBweokrE=; b=
	LBJM7Inr/71s5NKF/do/OMtOj3f9dFknCarNQyms0TJQaBpYvdI9D/mddB+VIVF8
	ZhJ800/wgJHZW9qYZN6IA/8t4fUBicGmGOCBeCBsXqbSuNGPdP0Phba8g590hi6j
	8wRLZikL8iMqzqwO7NEpg4RiAdafXigNibJtIhHQrg5eEHN9Gb/1X0tPvagvG0hs
	hI7z0yIAt8xVG9iyVXT1HpsY1KzQsNosX5V4bdAIw65ffbheGS1d/TrBes/6u8Y1
	vAdwNLjD5g22hJi36EJX5fPdH1C9GycKw04HLAVEMZL+UTWR2jbwWuwRzM9ncWmf
	gFIFg3Wk6dRKgwtudPReoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5hn42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGGpPo022744;
	Thu, 14 Nov 2024 17:30:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1kw4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKkIog+qy1FAUcFsmCCP+gchhXbqWiZAdSNVXNZPlDJBdG2JUa3DFhuZ/ReANZhh9O0Lti+/DmQ42HAjIFtthJMKQfo6IQl0aQA6lI94tuUrg+0n02L5A+CDB1KTP2CRGrXXruoTdRPm/pk5AAUdUcyKWpxfgh2WwdYIBoqMqhtuGltqfgUakvgsnA5kTtYdkLFTbBfuhVPpDqW8kYUVgQliXVu5QLMqk8Ka2YY4OV/mpOe3EMTKe2r7ux8H8ShD17Cf8yxmGI89YO+OnQx/Nsv35OATk1fGa+VX+UwCHPqFEwFgnS1pyx9lbBvv3Jb0NWqYKhf+S/w+SQ9jECGE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcuESm/US6y2p3RKGpVl0Y5pLAZ1ObANDungBweokrE=;
 b=v0pofDttesVlQ4E1AqYAVKlkpShyuGuOeU2Tru6xo3dlCHqo50jWk3/9WKiHrfogkyn69VX6lnKu5LQyYviHTqGHHyGS2WG1gwY0oyC5qqFWQkbsM3sco02K7T57ZYTV6l3t9JYvJ/TQIgYirKzT4kG9XKQUADX4rrk4gq/2Jqp3pi/4NSyv63kQsS4Op9vHIDJ2m/mBfU8/IYP3GcAiZBN6WxpBkUW92y5HAl5TtrC3NzA80eE/b8s4bmD6Cy7XEb/j3c/mu9LKw5xR/if7oED3VnMRFNRpwjJ9rVHR0JDfR2Q/vuhSbHMEu8c85HkIfDz+IB/rztgUaqfJAB2FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcuESm/US6y2p3RKGpVl0Y5pLAZ1ObANDungBweokrE=;
 b=FjLfoPdYtGWt5JyfchYBXRC30sMRHj+HyqfjI5qMkCZOHsmN43AGfaxQBE3g9tYQ5qpy6or9lnNq0yG0etzVn4wH2RXROFl50Mcv0JlWvjxfOH1q64fzTWhJ2Q0USAAkJfa48QbZ4vRYA7EpjL0BWZAlHGYK2VOs0di2zAecSRY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:30:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:30:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Thu, 14 Nov 2024 17:30:12 +0000
Message-ID: <20241114173012.731208-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111145-filter-sash-390f@gregkh>
References: <2024111145-filter-sash-390f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfe551b-ca8b-4300-8af3-08dd04d20566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lr025w0QV+TLLCrSA7XlASPPojxnsKe+vW+BOqDxDLbS4X1xOxPUP4hyVKkL?=
 =?us-ascii?Q?cwrfi75w5Q17PLu7IO0623Xp0nOGlcptpAi+Ym7aRbpgegM/jOT11DXtnL1z?=
 =?us-ascii?Q?uuzEYaCvyXThLsxY6MrF+ncfcEj/+ojvyGxvk/pB1VLN0HifEI7UJq1I4bTz?=
 =?us-ascii?Q?ovYwZzRT5b/q6wrXpQZGgzjxWAsQ95RNwgZn/hcspt4/b7LzbbCz3M5zfGs/?=
 =?us-ascii?Q?iQxr+frnrcqCZsGErlVm1sCAz1Ysfl4plHmR+UnAq6zEcplvVoYAl7LU04nU?=
 =?us-ascii?Q?2lYqpE4jasF6TKkWhDMMIzUOb1mrB9N63ZwTbR4dNgn2JSNj0K8WLnqaqpaS?=
 =?us-ascii?Q?Cj9BswhjxZYkvuNEWhHmu5/uKnYEuu0EuNTYWoOX0+0nXU4IfR6oDDRCZzeH?=
 =?us-ascii?Q?Kf+pMTkj/Iqjb/ugyZ7cOawhFYfM4oEjIsvLKuYYNeNftsJJDPwCMexgnPip?=
 =?us-ascii?Q?gaHX+SsnIL7lRm35ithMlo4qsyHAWNZKbUEVJ6Ra7OGKxr/XUn5MT4Iq4cG1?=
 =?us-ascii?Q?GlnYA/S/TQ3rTqVLSiMUM2gKW6YM8vDaODRoYqs2Ulw32yTqjiQW+sni7jp2?=
 =?us-ascii?Q?Pg1TbRk7Y5aR93tVdl5mKT3gAOaKNMCC9fkM2IZjqZ9Z05Nb45HdwvUaYq2b?=
 =?us-ascii?Q?+iCJDQ7wr4YldacQD0RvU1QQkCjp2pXKUKHqFG5HdVem3zgyKBVF2q4EBpFj?=
 =?us-ascii?Q?wTjFiS5BNU5GoqIP0dOciGuZsXFcxF7Z3dhx2h05w/darkrJU3fu2aYjzLai?=
 =?us-ascii?Q?Qlf9imUoFTlmTG+zdrE6wiPBytRg+wLvc5ssWvDCWboplMcTWVqG2UaIRy5h?=
 =?us-ascii?Q?8urq4q4j8E+AOq18BOIqk3FXUW7IdbkQVwQd2eWmyT626Gji7Vcs8oEQlTp+?=
 =?us-ascii?Q?d9ual8Eja4Hzzog+Qh9VWK5D9Cy2DMYFo5M+qMDpvxsVhqvXpl80OESuzl7a?=
 =?us-ascii?Q?uHDfdii95eoTF2KreacGBFLNQEqCaX05W2Q0lL5enXF7Ejgh4RQnn0/YL1kg?=
 =?us-ascii?Q?4U1rzkYlDPOqjFh3UX4myueruIfdYh3g4TJKr2tMWqNf/K0ec5gyw41ASlTc?=
 =?us-ascii?Q?0rH4Irm14WHsTQOp3adxXGqoLxzq6HnLvFdnswh/F6e90ffa3skoulmkmBoJ?=
 =?us-ascii?Q?LRDHScddsHrtxk/3njwPTLsozKz9d5/XFKpoaxHXTYipYyLt/bP7mJIwhnf4?=
 =?us-ascii?Q?YjQzu5MwumY+PE7u296aWl+f7MMGRtWmS6Q+VAGwriif3zYmD1QvynzCb7Ex?=
 =?us-ascii?Q?Swsk5/LCPBshlhZzZpPEuc3cYkb/q7Ki6/4++YT0OOp/0zIqEdp98+JFYprr?=
 =?us-ascii?Q?Nn11M6IoPWIYgXW/XdEgGMQz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TrupAeJTn3MDacvU6c/DFMniutKrvMguaLoPgNY/L/SSR6peb8IpVjCdM0Ln?=
 =?us-ascii?Q?N99XEILcbVjup04ODjxaE7SyQcbnXsuzRLe00gF7BLAzkElLkK2UXX0KEcXL?=
 =?us-ascii?Q?R6OULXN7hGI/danhTKReMm4EOYAa44SNTTcePT9DB5xm2A/2ou0C8dfB5dfW?=
 =?us-ascii?Q?XQht96GZglqcbv3917e1e60eYut2VL9417x26VSIpUq27/mVZsfsy250z2jl?=
 =?us-ascii?Q?PAAwGIjcdgbnVy8amBbm9evVjBiCp+VUYGOjCgTCfPA2+cOISFcwVNHoG70Z?=
 =?us-ascii?Q?3r3VM+9Fj9c49vEloLZwMd3pXstFA8U2jS8hE4wpfDoJtgXYfV6ko1G5OZUB?=
 =?us-ascii?Q?rdd0Kkm2MTvMD6W9lnom6uGFMYt+GWHRDsPVTgN/knYFEr19MNLm7l3wl/KA?=
 =?us-ascii?Q?Td6o1RMFQZbaak2nFTVQawTX6eNP5H5VyVHPR7BwqldZh6/vLdjA0937n++F?=
 =?us-ascii?Q?Vu2fAi+IZYKQtpNZYiQEgGdjntlX9E5lpw0PPRXCB9f+fJKMbtaNcHe3fJqb?=
 =?us-ascii?Q?pY9qDspxMaY9fi+l0dYpjFU2nk1xcLid9I8KsGj+xAtjKbF2V5QcaAs6O6Qa?=
 =?us-ascii?Q?HcNBidEvbLpoDTfv7YhcAGSdSSVyMSmlw/5Ri/fKWiVnhfPnNvFYjJWBTI7y?=
 =?us-ascii?Q?4tHI9I1T6zQW2yvlT3dqOVUZGosuWwNnS67TCE6oacL5BO2cT/dvAnfIM+Pj?=
 =?us-ascii?Q?Xypj9ZNFzpldpaHTqJ5l2Ic9dMdpT8oXq4PQTY9w37iLkVZJz4YXVIaPrBF3?=
 =?us-ascii?Q?q/FDfJdw3yeuZ/GW2SjcL4g7JM0dfprxVz3CL8rENRF7IBVhMxwKV+xKSqNR?=
 =?us-ascii?Q?jCKC2tVyQyiN6wyR4QuhQY7Gu6a1hsctzsVOw0Z4JRK+aBj0h0E8gG+eNzjT?=
 =?us-ascii?Q?CEATaKf0UOou+6PMZu+FUje+cq9R1wEtm336igfDbjd2xxYGB2B/E8XrrJkD?=
 =?us-ascii?Q?4gq+87BXCj639kBaT9mN1D29GRpglQ9m8JRa+n2lFbxgyWTaO7t63Ku7gXnh?=
 =?us-ascii?Q?MlF73KJ2S1ilqj5EYNd2Cw3snUEctGHjWleg6H5UN8OpL3b3spyBGlzN6Xd3?=
 =?us-ascii?Q?/QPeBVUKanDvLUFM5OORzAKQHyG2TNCFDaIXmLpYaF3WZchwpGnaUltXW/5u?=
 =?us-ascii?Q?uhkIjLbtYp/PEyMBrruZO+rHU7ytigYJD5FRKQ8TjicYGdOI3iLWHZS8DivE?=
 =?us-ascii?Q?x3CjTAPPiiJdqWKRGL54bBUI5o28qKYjcQe5PGYroiKJRxKsJ+YkkhMOIe9i?=
 =?us-ascii?Q?SdC8Y5rP6oEjwhPemW2pCxd0+Yakh0+5vbSqT6VEEHBB3DD36hHpWe+MFhbN?=
 =?us-ascii?Q?Tf32h79mAkvR3/H/r9NkJ2dlNdqUvceuCgMgHJ9wKWxu7/AS7khbcAsxPUxC?=
 =?us-ascii?Q?9hEZG8D3Jki/tR0YWjCuhUajFc8RIAzARJKQ2Lxh/TD+kh8PmrUqM7Pz1KRC?=
 =?us-ascii?Q?aKrHWWc5N3u05mnnfn9pP60avVVbmcuPyjRFGATKtegPt45yZaDyuzahxW0d?=
 =?us-ascii?Q?UDx1PK8HC6yethKZkfNSn8thxqlzSLAN+2ZW06RVdE3NRVFT1gX41PvqVRFI?=
 =?us-ascii?Q?9ecH2OHc/N1HjOeFI0vDLqvffGQ0JyM34lh7mhquREEvCzkAPk9bWPp8SOct?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	diaPX+nxAYxCFzmKKTHhz14TKllL7FUuSJJKq7lVbb5DHKd/ULklxkoTVh3xyRzpXvJ9zCs02nyUDoxZOTdHnZCzsoPQHSkIO8rhUCAflswUKonbEe7o76/UnTRvNqwxAl5WrtK4krK97Hl5oDPmdvwmbdpkn5uxJ+SGthgYYX69q7rihu+YK9+RC0E/C/gYLyjpqQOKPoozRyORBvR7JKvpWNf/PypP+tx5LIMuMp2Tx48QRk7jVoy811skHsapU2NgEtjuQdpcpC95y+iuBpPK5nKqi2eG6Eo2gLHFNihhKI2xpXvnOzzAfVhRaR8MmagM47mV/VMXe7DM84kuCMqdJKRISS0RgJNWa+hlbtFSZEhGJprsDgwNDepIsYXkWj7SWDa8kKDhUR8bm+D4EEQNEz4CMC1i9OQ5Z/7RGnboUgs7FpB0OYb4Kqot+bxrlBsY6/UP50/D+nTT9FYxh22XXH6hlJIjW/zjyLHaHt3jorpmtO4KBF+DE7IFldkNq+tSIYQSdNtjg6XWZlrRb/DwXYt/QTfz+waOVryodasoI4zmV7tzUI8Tx8qWJcDtritFiKlanReNTXV4Uc+OZ9jLm8ySK/icaYy4l7RvFIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfe551b-ca8b-4300-8af3-08dd04d20566
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:30:23.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYERofVXHCjaDo1oOUM2Sy86vxxeJtLoW/uvPspFr7OCVtwvHiKRGsT06JAc69Scd7xOg0xvySw5AntqNVRDvFvHImOuk1dA+bCMhlCSTKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140137
X-Proofpoint-ORIG-GUID: ZfBZW1TZceNByc-Ze1yvr_8DyuGW0reQ
X-Proofpoint-GUID: ZfBZW1TZceNByc-Ze1yvr_8DyuGW0reQ

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf)
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 mm/util.c     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cd444aa7a10a..4670e97eb694 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,18 @@
 
 void page_writeback_init(void);
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index a0a4eadc8779..11d023eab949 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1788,7 +1788,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1803,7 +1803,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		addr = vma->vm_start;
 
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		/* If vm_flags changed after mmap_file(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 02d2427b8f9e..2515c98d4be1 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -942,7 +942,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -973,7 +973,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index 973021847e69..f55d7be982de 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1086,6 +1086,24 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


