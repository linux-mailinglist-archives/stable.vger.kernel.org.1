Return-Path: <stable+bounces-178825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ACCB481DD
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5187AF0FC
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BD79DA;
	Mon,  8 Sep 2025 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="laFMS8xf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qr3xHXyD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5019D093
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293891; cv=fail; b=Vhlkwe8UpYnVqfcckfq2KBRqAX7WSBpBEnm6P6f922bdBps0IEN+2rIj6Hhsuo28JroW4R27QekYa6q1kiHJrAT9p6206akShhyDaJBgyfDrWI3sLcOJJ4DGbAXkroTsSS2PjcqZT8USSNUGDsdiu5S6t6FQ8m5oz7+B7UBfQFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293891; c=relaxed/simple;
	bh=R0WLe4zBkmkKhizrBXI3SEGiineg4pE75v5+hBCJjK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOLSBiUvst7FW/oNnq8obdk2XdDnVUDcYTOnVZLZf43CXEWWpOXeiNlMrN/agpKEtMbVR7xzIELn7jFdt7du4jkIvymLUj8k8hL53pRemRt3HOh6d3Aqe1nD0Pg0cwnj8Ghr+Jeo3pviU6nushlpchASrO3spXCHY40Jq/08asw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=laFMS8xf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qr3xHXyD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880YZwK020406;
	Mon, 8 Sep 2025 01:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eOQoflAWW0j905C1R/4rhQaQ/DAY8neHffM4B11LIjM=; b=
	laFMS8xfTqovyI+Tr85kHdwq3ZyWRpf6jB7mV9t7odchXgxD5ir3QkqvkMXv3RUL
	hVIuaC9x0UXA656RpSgxLD6DM5uhjfBIIKDI6StcYogRGyeymat8TohtUSZh3TaM
	zojkQCdegz34TozsLHQ1nE3cAMzktkR1ZfzgmkTjrV+H1Q6jWZoq1JuQyzQdxwMT
	EacFOE1tGOGvJsWsV2DY/P42AFb/6O+Pi55Dk1xAJJJGJAq953A/zr3ACnJTdD7O
	lV98xQmNqnWGPKcyRlQZpaY4Bsi8hQXaIRbjlB0qANA2GYkqKVRC1r6igoA1Il8c
	T4wClv6P1vO550TvVUonHw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491mqh8156-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 01:09:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 587Nl4GC002962;
	Mon, 8 Sep 2025 01:09:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bde1cqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 01:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDxDhC689jfLiBjAHwQ/k2mItK8sNVgOEuzJTXJF7BHatboJw+wYjd02nE52MOUIjaQ5qaYAvmQ+fYYxffvAEH/VrsW03K0WdqfZURbCpph0A2i/7CxBJ6JvGdWxIF+2FSjfujgNNaYjdIIiIj4BWzXcRWO6XFepe25WNMzuYRuVyk4kwN9PISMS9VVwJjrmopUrjSSkqeUsQa4/jm9DnE5rGDWuQm6WsF/0+E9EBI0GM2zEzAkZwLBNeaj/zJnGIDleEBE+Rwuea4+kBMRWYQoGTArUHy/OTIjZTRmW44JolnPQhKkMALAKFt0YJuN/SCiXOmm+5NaDeSvgYcN+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOQoflAWW0j905C1R/4rhQaQ/DAY8neHffM4B11LIjM=;
 b=lN5Y9uXaGI3SShpp8e9wJXvfZuregZ5KtX+4av/2xIOXDyM/1ZnDXKMT8PMUYC9EX0pvzKOxapKoCyBjpp92vxIAqlAcNivhSVnrdbBby5wAaLfZaFQsIlehInWZixE+S5tlPTMlBbe6Fh8d9ldjHglt/TcQYNTC4riiYs44NQU3GHL7/ioe2vKovwQZOfPt7r7FL0btJPiIWWZBsVpTOj9EqvgE7klnsVbrinP33I6EzgNG/BgPgAtc4wLy+0xLtugTGUYJxkCJRfbUO88ygKTs94xXZt12YNTwRLK/1Q8GNgehmmcvGysGrxonontZLWg7JBLst4m94q29VT3C7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOQoflAWW0j905C1R/4rhQaQ/DAY8neHffM4B11LIjM=;
 b=qr3xHXyDMeWUxZz16QHOcf2sFS5btGguwvSHRstKmrHaMr7HggdXgcbIaDNIbhtmURmOlPMmPFiRbEzcL/RXMmZ5epmsp5k+wz2XfQx6k4yksy3OHFQ+JbuTWrB1LYGs1NAyyxmW5rqBs1lDiKQjnJTzX/HY59Sxl27mW85K7ig=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 01:09:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 01:09:44 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
        Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
        Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleinxer <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon,  8 Sep 2025 10:09:31 +0900
Message-ID: <20250908010931.5757-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090602-bullwhip-runner-63fe@gregkh>
References: <2025090602-bullwhip-runner-63fe@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0133.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a080d70-e450-49e9-5d26-08ddee74658c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8mA7X6Gk6RuMG5lDt7tzT73w07cQxo+9iwJ+AozC/hCwKAXNQYK1SSuO5bc?=
 =?us-ascii?Q?Cj2Phj37wGWby/GnnSPou4hyMcND1wZzL0xQjT2BMzP3Z9MPGjYvQ8lFN8wE?=
 =?us-ascii?Q?5RMQEpWk+Yg0yIqS1Qw7oy7VcrMh/M/ojD6fN+629aYvkEACHB2m6E5k93CI?=
 =?us-ascii?Q?PLDM4mlUq3ynpJnUswDVFEdiKcKcIscvRPYNGM6+XG/++8UE5kmB6msZMMpL?=
 =?us-ascii?Q?BQOzzGNH0S+1HaXjOGsF63/Q1q7tE2/gl3d2ye60mUcbJe4oYS/9k0/a1HRb?=
 =?us-ascii?Q?i+cDs37Tikt7IQCInoEKstLJu3zFj9LTFP8DWXdpFPbPGmytnatmoHWG/R50?=
 =?us-ascii?Q?N7LgtVgAQUgT1YabVBvndQkEvNtn44AIGn+18oVVFqIXsJjMzJNRcI9RBVEE?=
 =?us-ascii?Q?2nMQ2Ku6E6nPbkgDe+IQtv79TNUpy5eYYHxKGialpjHsIG0aRnxaCsQpi1Af?=
 =?us-ascii?Q?S49LC7VLiqx69lf3l5X1SMOSgtj3njzzeHcXe95N716G9X/uHMR2MMcVoN9q?=
 =?us-ascii?Q?rsQsWOmfi79bviBqEKujjgGYvyO8QnOjOELwEPCWwL7Hu4MQhPcDCV0SuX/h?=
 =?us-ascii?Q?EKWgstFStyYkYY5lvQTpYn1Pn0trbRmEoy1x1KaOwPuvTTEZVrolbl9mL3S7?=
 =?us-ascii?Q?MIKI6WCtSzY/cKC2qAzu/jUCunAxGyfekFcYbII/BF+fE8io+fqrDVvTTaOT?=
 =?us-ascii?Q?Tcr+rpfVQvT7suz9FSglOX3Y9luNnjZDDHBin5sQK2gfBXjH+4UZvuRcxTBR?=
 =?us-ascii?Q?+YwE1j8GqF7wzuisT10BOdLGNeywLsoD7ntlLvQQpLpn2ijrC2gKColAUw6s?=
 =?us-ascii?Q?KzuegdjFBJQoE3voveMpHQsRafAEc2xPyoF/yQEZCHHyzTjF5L+Q+323vWlh?=
 =?us-ascii?Q?sXk/QcQkAKDrmpIn6C2fbo6NtKfuEhgiuwZNyNfDeVrW8K2g8VdaUzbYrrAq?=
 =?us-ascii?Q?d75a0r33ko7oSd6vvIuSGgG01vamHwpxfG2VqqjQlH8CL+5v92AUCXY4RTv4?=
 =?us-ascii?Q?zBx77JfE+gs2q+uwiox4TpMiqjcuvZe+AX9VIbDWItR94ecZDtq+XdohTClP?=
 =?us-ascii?Q?z9VFggloLFmnOL/Zkz2mtlQF/BP1FYEUw/IkGc0nk70fEUUbpv5SfUJlrcN7?=
 =?us-ascii?Q?QAUMcnWHZmaMDy4nTfPrkXcBvzu6HjAt8sMb5hA52hNGqXec/wjgVazhBEQl?=
 =?us-ascii?Q?a5fhRrZfZXXNxN8mbtSRZcDsXnbwwvQD+9o83E9yHleiqL2BDx5CgqLGG4HS?=
 =?us-ascii?Q?NDo3Liop7oTL6dL+KZ71tJm9ndo0C5o192ZXd4YuIp9Y6hsh8x133YAB5ViV?=
 =?us-ascii?Q?3eWVAORYeHl5acVGgOt+iI0u/4NmFeFnJa/d9IQhTrX1g2pfoWegVvgUYXqG?=
 =?us-ascii?Q?xCX4gZBBhTtKnXFtXzRQxiTkqUzJ22nUg4u+U6JKQsstzjlYE9rysQwIjMhd?=
 =?us-ascii?Q?xjwIoqr11uM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFtPiD5rB6tyCGqpF4w93rPw6aFlIxx0YL3Aj0OoRWFjDh91eNrCAUpXBhQ3?=
 =?us-ascii?Q?omNoI1Ehk0td//J0L+sDw+3pJD8KGeQfMdQAmMcXe4YtfTobdibqEdBuCA1h?=
 =?us-ascii?Q?lEIEyAseplfjwD4SQY3n2hAY62w22Vp8ng4tU0fL0QrDUvDfwe4DwCQJ5sK+?=
 =?us-ascii?Q?ai1GyHpBn7gWK9+thqGyLJm0Zm+M6YIffuxW2HCnwEgMP7tKYtujstK2l7M7?=
 =?us-ascii?Q?MIKYlqaTZplaGDhzjkStvCQ1NBjuOqQuBOISxQdgltvF/RYsh5zfgqwO4dXB?=
 =?us-ascii?Q?SDy3lOcub4FIk+MFrEPqFaBcYEqkkNKWImMzADG0DOFTn2KvjBASWYsx8Enq?=
 =?us-ascii?Q?VjaHtPA3Kkf2zxnfyRUHAVjMhZyRXIHKgFab4M+jKdJ0KjHHYwXvFDHvjZ4E?=
 =?us-ascii?Q?C7oVFFNF4Ifz8W3XLbw2fldj8fiY8GrNbkDNNZKkKipq3NcBvAs/sxiTygi8?=
 =?us-ascii?Q?gm+HT0AgN1uYtf6aO1DBuNjdeSwiTeXqekWJ+bycw4w99nJk9p5Ltr37B9Am?=
 =?us-ascii?Q?MtuZgtIgpyd3kEf+BpysWkZTjiyxWGWdgSVInMyCSHpBHbQBoo3Pk/ufvKpd?=
 =?us-ascii?Q?0+DZKStixRHvj+/HDhdQyhqqduGYXdL30fkqjBpyp5mMKtMadJZ63oSnvVJI?=
 =?us-ascii?Q?g/tj4twtyf3UpbaLXYJd5odWR1goJstaPPH+lrRe6faIijsgQYmeVin1iLrg?=
 =?us-ascii?Q?EMyKKFA3TabwUr4J5bpc5InKtNszesiVpC8/KO0ZCSVgbdJb67Xm6VNJQ6Rd?=
 =?us-ascii?Q?/KKeiLl0zxgKIZflryvwKh2FTTE9T/uRQH7m2Z5f9+wr+sNVZecjzWoPEJgT?=
 =?us-ascii?Q?76L77fyhJ9IYzFhqNp60blN1IBolxUmq2/N2rCMtJfaDoosXAYsgJYWTuawq?=
 =?us-ascii?Q?SGUsAFeMbb3EtqQ76fbmBvJrvsHQidX9GIj/IrqSCvjXPx/7Ltw/TTGXZYiJ?=
 =?us-ascii?Q?eZRbQnW06IR3xV+5noUoMKatoBfRJ7S/BsagHaS9TZoOMVpZb15WmEqWdlHH?=
 =?us-ascii?Q?OrJGbgKhlno8x1ZzRGO7nz2k+xJZlrCIASiaHec1aY8TC+yOiwoBBBKcjRNj?=
 =?us-ascii?Q?eDYLMoEY48QiwH3mmyUO+2IlERnVY45ODYTENlqwH070BDBXGdq8uBunQpYs?=
 =?us-ascii?Q?8pucL9uAY4Cf9jukOwiVQNjdDvm8FYKZ9lQHoJjoqVum/N33E6Km9ZJv4n/k?=
 =?us-ascii?Q?Spy1SN4Q5FtivtsVJEaQDs4qmczbseHuhnW8BbLLopA4xeIFEPiZNbqF1gbj?=
 =?us-ascii?Q?KIN0PtSDOxH6yYW8exuIXUBC36dtwrLhJ/K2S0qBvJhetlynJdd+KRPhmPpG?=
 =?us-ascii?Q?BUrgy95+LyqfH1m82TzvZOKKev+f+FR4l3It59DaWYKPv49VBwPA3iCh+6C8?=
 =?us-ascii?Q?bzKfe32y++caqdukZKvLpRAmdMBmwqcFOYLJSmQ7mOzdWHgEIvsEk3du1r7z?=
 =?us-ascii?Q?JbnGQetDvqMocvmZGfLgvXqs4ZDySQcJ37AaKArAcmQq+U1H72qbRimLlj8k?=
 =?us-ascii?Q?Q42kBT57/8r+JS55L7ytnOJ/WMcUuGL57JdYrDeqso2Pc8BP2DGdZdvN62vg?=
 =?us-ascii?Q?jMXY3fr2b6QCHFsr4AuF03qgaYiqtmMN1CxbbuMD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0G7oEh6lbjl7VsQOpBt2PKkrMZPAZ76qGtum2oOwe6dMMeP/jzh1ewnjLAJTUjqaVnOFgDUoes6dOjGTJryE4f7l19psDOgp9QIzF9/b784fuhiEn5gAbguTCkBUyynTUU681xkL5tTlLR8pccInaBZzH/L3ty908jMIw9yD/f6Qt2rWKSP6ERJy1Tih+kh8TOoUAwlN3fi43EtoX4FtBPVWG/Sppn/t5y3pkWU0KGQQRNi859JoYHjUXOpxu63nTcaPa3y0qLMAqqbyJQtFRyLvWN3ZGxyzB9U/n8/Xn3ZYSIdd/fRG/4wah9/F4/gwgk894FChuHyhepWnDNh8cjEKQIakW5Y8FGTKZjtbmTSpLVBFfan1/Os5YC9mgg1pdZdTmsqP4rfCZBUbYIFOTZHnBIjOjl06cFHptpkCT/OrOcghr2pquGCux2RoFGB04UVE9QfQAXjaJymRYB/WF7ybW5OVy6lVCzk4nAv7l/54yeTbI42Uo0LvxxJINoggTlKAjsmvp+w7dOtFLbiHEcHGfY3Su/LKKIKHIHhiCVEvXJ0a8REoHHpZyAM5vxkyKRpCZ5MGdKXxqo2XCyYd/tXOzsDShfjm0XT4sdxEaxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a080d70-e450-49e9-5d26-08ddee74658c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 01:09:44.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKqCnIhQbOU5B0l3h1wj5+6Uoqr2glbG+tEBqxzv0LpHWQxqvdWzkWpSTNEKEOKL+4LXk3TQRJxx/KNvP33Qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080008
X-Authority-Analysis: v=2.4 cv=ZqztK87G c=1 sm=1 tr=0 ts=68be2cdc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=Mq-BUGaGdN0al8lYWrQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: IgKJjk9StELtVw46xOXDD6vn8KYCJ14f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAwMyBTYWx0ZWRfXz8cQam25GOIv
 yMXzENz2RKutXFSpAdx/gtqkwVQwaUvJh4nBi1juK2GyfmH1w056dfM875lVMwsnxNqQMEQ3Zsd
 iqdJVaDnc3QWXtucOPsx+VMzey7BXDGuZuSxLq2TDbDN3/hjRDYsi55LGyyHgWRDdbTwGauuW8y
 jHtZDcmtG1HW1aSU0cp8q6zpvyYsdF+ZnBQboMDGccVPku3EmvUv5m6/sUBhT/VA1c9gDv3JUkc
 GIRZtBn1Vf9hhHNt7V9+P7heLpBfmue60wU4wSLs4wOZnHxE7f5gzG3jHu+f+hOattxcS1UN60F
 NXk+tYaDmpR3Aepw1Hx824aaBvFfEeHCfNO7ZWfVbE735YYxYMOjAun3nCjMT5AxyFphLjmBma1
 8vNJzvOH2Yk/sDZSyiPeYB42+wXECg==
X-Proofpoint-GUID: IgKJjk9StELtVw46xOXDD6vn8KYCJ14f

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.  These
helpers ensure proper synchronization of page tables when updating the
kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.  For
example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.  These are introduced in a new
header file, include/linux/pgalloc.h, so they can be called from common
code.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by
arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced.  Currently, these helpers are no-ops since no
architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

In theory, PUD and PMD level helpers can be added later if needed by other
architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
we introduce a PMD level helper.

[harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]
  Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bibo mao <maobibo@loongson.cn>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 26 ++++++++++++++++++++++----
 mm/kasan/init.c         | 12 ++++++------
 mm/percpu.c             |  6 +++---
 mm/sparse-vmemmap.c     |  6 +++---
 5 files changed, 63 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..9174fa59bbc5
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1ba6e32909f8..e7d5c02ac0fb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1343,6 +1343,23 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 /*
@@ -1833,10 +1850,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ac607c306292..d1810e624cfc 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -203,7 +203,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -224,7 +224,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -263,10 +263,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -285,7 +285,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index da21680ff294..fb0307723da6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3129,7 +3129,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3157,7 +3157,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!p4d)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -3165,7 +3165,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!pud)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c0388b2e959d..a76b648fc906 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
@@ -230,7 +230,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -242,7 +242,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


