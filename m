Return-Path: <stable+bounces-93810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5AA9D1535
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12B41F234B6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC921B6D16;
	Mon, 18 Nov 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9eoTatX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mq2Ai5QQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47E1C07D2;
	Mon, 18 Nov 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946742; cv=fail; b=kUpROp6h6kHGIubIMZAGAlYcOg9uxQ58xOgG5kYUt56J5RMfkNnTZXo6i76xFCk21PWOcnNL2x9r8Z66iCwDXBr+hC7bxho3GvJbJlOTMOKfy3J8MBRadJSn1Fb6142EwUzCAatC78E+ipp2hYQaGqfxen0cRV2n+aJLkqyLmWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946742; c=relaxed/simple;
	bh=2lXFp7X7efz5VlJzZgYh66YC+AJnGOEBopeSl9HS9JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WCJ4lWR6cKP5oazn5DgatSzVtxidT4xPQ0gHge3N+/vQ2uAWaqHDiLcpJmD8OFjXUf5gnrgsZPY3GyQnGG/HGZBTrzzAuhkmP4nCfgj4vHu3Pf5Bk7c3EkaSMqIVH0Z5MKuzWU+upxDQ6vm8+jVhLivvl7hlMBAW3L4R++7doWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T9eoTatX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mq2Ai5QQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QZaD009482;
	Mon, 18 Nov 2024 16:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DQOybQXxm8QK69H+ekYsnrRu/djaUo/ByvscuyUxD20=; b=
	T9eoTatXzPU7SqlbkX0UOJbybDURIDq8nYa634fCa4wg5mLq/SHVgHqE63bgvVYr
	RF/1StqRGgyg5as7+xCVTWYhydeYt3HwM6rgBPxtCySipc/b/aGzd4PW3/j6ZKpR
	McBYTJureTeayOym2f0vsqMZloilZ8ClOWlqoMGRPjXqStPG6bqxQ3e1iOCTPcBO
	ARcgrao8gJnADYYWcKsLVngwLkg8VZq9bZRCl4gMLmLicH/fMuE4zrPShU7H9fue
	vmUDhqMCqLt7IXcJs6A4Ziod23Y70ABkWvr2WdRdK1S6k2jOPGvly7ZijIH2RgOa
	Dnp5qh8qKjrZi4Y1Q5QYvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc3425-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIG1G5k009102;
	Mon, 18 Nov 2024 16:18:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7gxfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9kGyHRfaA05D4JMCzfZfqhSZGXtsJBSNj6hp9i4pl0mHOfihSiyc1Pb4T9nz4BsydxzJGGdIu+5bpJUnssC5Ch8ARSwGpbOcJs2ml44yb8FlFSgkHzAlhQdIEQ9kPpue8BWDum0ckxTBAMNpRN6E+J/e/T+OhOckBGmz6xlYrPNxlFQ4+wFBZi3EyY9sPnt8x9iZR8N1PKMUao1HvGMKJPNB6RcU01xOiFqVBYFVCLvN3Lu30QReKbpacCEQ4kiAWUh7WNMNIqXzitRCpGoe2hNRMjucO8+InrzgWJDpE1ry+GftLFkW7EGsCGb5OCa0LhWDvUtDeg6CeyjU1VisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQOybQXxm8QK69H+ekYsnrRu/djaUo/ByvscuyUxD20=;
 b=LzZuJGd0vT13990tUQNhRLIZkUyAclpavRltVcgLBOZlc6KGjY0CPypsOZZ94dagq+ZpGyZ56361yy/4gmcZOZIbuYIFI/pEzZR6qCxyBw1YTEdJ6oFN6Aj7CNz+kuG+Twjs+DhS2GfajhztR7kl/oPr8kSzAGs6UTbmqZFVSexAv8UzJoBMrUdpR5tWvEn6dghebmk21Rqnby3ipF4QxqkEf+dvOrLnBPsHGbJYHqVZUTFDP5gKQDvBsCOuZ5kUv+vYbIfKP+bErUdf2GzZgMJJLlms8ikW5cAOKIBSlS7GNlz8JGfRATKxrx6D+ylniphNIkv+Xvh0lsYDXesAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQOybQXxm8QK69H+ekYsnrRu/djaUo/ByvscuyUxD20=;
 b=Mq2Ai5QQ5d380hUSEmB19YxNwwe3CwSHYhhRTbRtmhhIhLedELbYPmke4PYDZuG02x+ibuGMZ/Boz7j63GKFkbCtO2rK27FKx1R9PW1L8uP+IHKvah8o90unqJuZH+s22pW3WrnlERqElzQODfqg9ZWk2RTw+hg9SsvGS3V4Yk0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:18:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 16:18:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1.y v2 3/4] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Mon, 18 Nov 2024 16:17:27 +0000
Message-ID: <fb0aeea7eb024efb92c512a873f40aa6ab27898a.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
References: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dc83b8-cb10-429e-c549-08dd07ec9ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a3RY11dY+5cEUnk1B2GHk1ZLueSJoq/xxZyAOgoEqYh+L/4msjI1Ew8JWu95?=
 =?us-ascii?Q?OhB53yUwGVErFx9vGz1rc/q9Kbhjc/0fUgKFckQz4ntBVu8rM9O6mwDlmWWJ?=
 =?us-ascii?Q?m2E3S6SDf1WMbpDMS4hdhTmaZnL1YVN7X5RV5G9gKUfMbTs/gvFt2sLiMuZT?=
 =?us-ascii?Q?KMOBQoep+2NmOic0qKrlsAETZRwQA12er/QkzNhXBMrD4aB5Be+CYMqwpq49?=
 =?us-ascii?Q?J4Xk77ihmK45upU8Ga6F7O1oGdGgjxD3WM0A4+wavba5S3i8RBkJ6LHad4mH?=
 =?us-ascii?Q?VP9ez7zYh18OkNkh6LEc2K1eY8SAB5hZB/YL1eW6bpIdH9hv+kkZOBRRcC6U?=
 =?us-ascii?Q?0WD3lAZA2JkLMNB/+D87Z+0rFp1m+/sefIq90Sq68gR78t839f0imZFMGsWO?=
 =?us-ascii?Q?Xx1o3xxDbyVUOVxy5J68/wdDziYoT7/HUa9lXgP/HCZQkyvN8TGiShDFGRqP?=
 =?us-ascii?Q?HREwcPnvEZS4Jriv4POV2SAHKLhnyyehBaqxHQHr6w6VrcxRbFdTmEWWsaGz?=
 =?us-ascii?Q?hEuzaNxyopodqAe/ukiPZ6fDGXB88it3aavtR7XiX1hDJEVFDKPrlZfpBuog?=
 =?us-ascii?Q?yQkr0rkcaOBzypjcJKd6DQW1215WIxNAVF2w+DCHJxbWis+ZuI2Pe9qqyDBR?=
 =?us-ascii?Q?snzHyKSrW7AoSvnxT/0W7IJYNDtJR8DC9xy11fNavcg9mJdqE80K0eNz0/JX?=
 =?us-ascii?Q?FdnoVHwjiqJyQ0F00EaE/7qkkfGJgKuayIXjSx+v4GoKGST5AfO0sIhefINX?=
 =?us-ascii?Q?dyUrqbViKGgYL0Vtqsro0VfPNspVBnvCsElGt3hhr9PCeKxTSRJbdYTx4Pfz?=
 =?us-ascii?Q?Ktn+m2h4Ym6tp486bNG8Z/0hJxiFJ9Ttl5vDWfhyEuAjRKmQwG/Tz9LiFxS0?=
 =?us-ascii?Q?YFGEgwTv8B1Dtsfr0/RI/7q4OeIeVPJV+ZzQhmM7KVLWktinyWicJxsb+dzG?=
 =?us-ascii?Q?aq/LynWx1y08WB8nbsERE2e9xEOVK9jSlcYdfkb/Y6Dbf3quSMqu76crhxEN?=
 =?us-ascii?Q?Jn0gfoRBjYmxSiNr5CTnEb2xiYL4ZNGCbQ5lkFBZIQ0Qz5Mvqf0GjuxDdk4B?=
 =?us-ascii?Q?Vo6qJiXmiAabL/qZfQ3Gnb8ILwlYPkXOaFHpgZstU0iFDptxnQesNo+LmZpM?=
 =?us-ascii?Q?8DhGwZqg5bNg0aEpwVbYsMr/vZtgRoL3X90XvRfMe7H0/MaZugYoDFF0nPT+?=
 =?us-ascii?Q?iC4u935JtIVm+MjqgE5aZAMoKubgUVzqUdsAZ212qK2Sus8sUWK1BfCjcd3i?=
 =?us-ascii?Q?NlZQZLX5U209pyBRZJohH5LkQ67XV38H/WaxvSTTR1O1L+wriB0RsrT+IyJq?=
 =?us-ascii?Q?2HWLGgWye7KVZpBHkm0a06NR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dH2z1p72GeV6DftdIJ9M/pPUkYlIzWwHAyD9Fet9RZaFzOOk7lHmc+KST6pu?=
 =?us-ascii?Q?a5qb977hi5OgtRUqmaZj4qYBVMjRJMkGnyI2hJYzf/8E4IK+K//c07jNiOvJ?=
 =?us-ascii?Q?MSJxMAZWw48DvWMknwXVJ4lh98x5xwWDTTFZldWVf4LkfIPm0bsL0TSyIw+R?=
 =?us-ascii?Q?HY7N3Spxyzf2Q9aum2rRxOSghj42bOfpnIYToWkO3gyV6ab8Bu+dBiZ7xT3d?=
 =?us-ascii?Q?UlptXRlbZMJ+CnrWXN1YL8/3VcAQfIf4DsZEYp9GzrTP0aIJrmcRzALO/D49?=
 =?us-ascii?Q?ClkUYeZWHRn28ai69EievT3GdWIF51TJlOonXG8yowgTOsEoOPXDBPOHSJmX?=
 =?us-ascii?Q?My8NBTMpJHUlZ1q7XpXlCKHfQWT8SB6D9sT6mvcAYavQgTQvnceY0pB4GXWI?=
 =?us-ascii?Q?mq/J9/MHEFKPcIG5nApoGpc5YiuaEuUtyEVX9qsRn6PeBMg8KTSsZtYMhAoQ?=
 =?us-ascii?Q?kKq8lAAFv36tmBh/jKG/v2iJaHJtm8NEXrfz1Y1VxLt8chwHBm8RTzdxMdcg?=
 =?us-ascii?Q?QSp3Arrytdyg8od6soVo/XbYsu3Fc1Y7I8ulVWgUvHBFCFZr5narkG074e8p?=
 =?us-ascii?Q?8FcykwhzIbl+u8j4joewRDdL6GUADr6teRjL8lQ891YdnzzReIDNjse6l9q6?=
 =?us-ascii?Q?LUa5yDTOwuUeEbQUUr9tmK74kExmiyz1F+dbEpYL/gzXfgL69r2RPKVb92BA?=
 =?us-ascii?Q?b3ja2Dcoc2LsYne2rsrl+wAzIQfWb3KGPSH2/P8So0El+Ej2YO0sDFD63+Ri?=
 =?us-ascii?Q?VUSz3/qlAjcZSFTovr2r0wpfEAD+MueLjHSPuzxDTbimlrEbFLJbpm2AHSog?=
 =?us-ascii?Q?KHQ+BYv+Qbg58klqKI3CemDUrjna9mYvCfJn5SWQHs3WqhgW8RlfkihUK9gf?=
 =?us-ascii?Q?AVEi00nkK1mh0P7VaPoMUM2fsILT1oOa9T9NER25wiA5zv/F1QpcosiSvANN?=
 =?us-ascii?Q?5j7wRHY6bvyWU9GiNqxWuLFiNMY6BjUmYGmYADtnylCWYFhLrazf62OeobLV?=
 =?us-ascii?Q?rC/jqb2DbwXPCzKkLipHyqCfYeZ90yvLaNo1GDn9iRlE2UW/XO81t6/eWe7k?=
 =?us-ascii?Q?NFECzyPP8w1oXigU5vjNYHfaoF8I7V4SWi7MZfWZ+0R01PB62kkNRHW/TlDd?=
 =?us-ascii?Q?OUwWjpzujSB0HgUpv4TJMmfWxuTVtlBmdV1vF4ghmTuV695sVObZdImvG5uT?=
 =?us-ascii?Q?hXmE6ia5qEuyVxy5PAn8WPjGSXDskNc4/4ZrNQ9TNzgcvcLi1Xb1SM1uxGn9?=
 =?us-ascii?Q?kn7rRJxratqSbSt9QFWrv2thmL+kNzXWIiTfuTggZnnFFnM0TOTTCl/xCTza?=
 =?us-ascii?Q?s5jTgFPEih+MGug6bJ9swJp3hSeFq9CCZg4K++18wq7nb2sC+N2R0+PlDz86?=
 =?us-ascii?Q?hDhZBbb3ccpngu1BWl5cra1xRBydZnlV5QWrzBurcoGHjq8xPPSK3xfSOSrN?=
 =?us-ascii?Q?BfDsGuTm0YGnJr6TYoTZQfK+GDrJU2Nm1SkuxX8y1uw/C11pc+Ffl35Ez4xe?=
 =?us-ascii?Q?Tik77E6bSHIJbBS1q7Ux75Sz3VMBQZvI5kTvikIzf9KYa650xOVkjiuveoTD?=
 =?us-ascii?Q?Da7pJw7X6xGOTHvcbs4WT8ijcUufXEI0exkEkZbPdnkN00+GMz9YhtgYWk16?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	maork1lP6r2+Azhgdt9Mbfu8BpkFLp4dbRKQT3sKFeZzQZMWsSLFPPed26+w3cbOT9wqSwwXkK5I39S4nAdDy3hG/G9UnhE18Ak4DY7UGDmY0fJrcjvwbYs8D/kOQx9BVWiIthK0r8PmWYQiFpQCwIhLiLHTw9kogqOU23YT/1LRmKa0ndETAyhw/1lVnXjhg8Qa7+UbOnxq04xZ97LWq/8AFPDBSS4w3jEx1Rgw5H4CoI5OBQ9SteRCjyoaL9aR8it3ph0+gpQM838oRnN4lN4I3n7gddhX3po0XVV0yfi4M3pv609lUoULxWTvL6BTjSuEOVr4yBWC3rbAFdyRusPFkp3oofTyav0ISTpEPHHN6s+JYk68z4Os1KYz4vJkZJaXg/VpG7nQoVWo0HHwoyEfXqCBZGZm8roLm4/EAZKSSR6K6M3J/2I987Py0S0LS1VJwjSx1pH/SzODdpUA0R2iR3mzug2YWcCdDWZFfd5nTLhC5A4U08i4dWwPOaVzior9qqts2Ees1QCQwWSWvuvelu796Af8EcCDo/OVZRO3q03e9Wcjqta85iZEz4JrJykiTYvVL23cLWchleHlOHoDRIirYF3JNTSQK4Slb/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dc83b8-cb10-429e-c549-08dd07ec9ebc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:18:21.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoSnbu77s0kUz83tC92MSss03UNsQYyQqWq7jjWYTyy1m60mmLMt5h0PQd7//uvpgHWcXDkrd4YxDNUz3Yg3Kj03tZXXfU7hRqVjNF/L/PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180135
X-Proofpoint-GUID: M-Q7TO7tHsn5W1cYUrbQ9m-98e7SGbHF
X-Proofpoint-ORIG-GUID: M-Q7TO7tHsn5W1cYUrbQ9m-98e7SGbHF

[ Upstream commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81 ]

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h | 10 +++++++---
 include/linux/mman.h          |  7 ++++---
 mm/mmap.c                     |  2 +-
 mm/nommu.c                    |  2 +-
 mm/shmem.c                    |  3 ---
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ef35c52aabd6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..21ea08b919d9 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_validate_prot
@@ -147,12 +148,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bfec4df51c2..322677f61d30 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1316,7 +1316,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index e0428fa57526..859ba6bdeb9c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -903,7 +903,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 	/* vm_flags |= mm->def_flags; */
 
 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 0e1fbc53717d..d1a33f66cc7f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2308,9 +2308,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vma->vm_flags |= VM_MTE_ALLOWED;
-
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;
-- 
2.47.0


