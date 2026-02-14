Return-Path: <stable+bounces-216497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA1RNCTOkGkpdAEAu9opvQ
	(envelope-from <stable+bounces-216497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 20:33:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55AC13D0C6
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43B8F3006995
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422930274B;
	Sat, 14 Feb 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="h1Z8g7gm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6623183F;
	Sat, 14 Feb 2026 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097632; cv=fail; b=Q6wN/yYM3Y1wPtRAxrSmhPVt4YFFhCz/xl9LF1YerKiCpmblrdFTNhiUFO9+mPH6BhBgi9tAwc4eSAxZz+acHd7vJbtqDd4Qsz4X88Gl++qrpbi9e7fyjvPV/zLRspOaRPvVhGSal6ooh/nJv1y5qXsdwEILIIIEu1Vj4yb8zAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097632; c=relaxed/simple;
	bh=Dl0hwCWMgGb7PQU+8zGk8VYU+BYEs7s09q1g1Z18GMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uvr1an3vXJipIKd/QiRQwj15SIyFjVh//b3YhyzOYMyW0vgfag4hLQANKuW2yIJSWSf7D8L7ySGWCJbUmDdWs7z5aNJL8C1oC92kq78otIPK1cxZ77wK7EKnhlvSFbwjgiUGCaZraS9S8R2dsN/EC7NgrwZcVAqcZYqT1qE5b+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=h1Z8g7gm; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61EJK1aD1024949;
	Sat, 14 Feb 2026 11:33:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=JcMkbpOC1uAJ1YlzyTspHYrJuZRirw7GYwKjB7tXR7Y=; b=
	h1Z8g7gm5nxU7BkUIatlIxWWsQeSBqG1nH8Om5ndqQUN3vmvd49McXLcgJAHNBMc
	kKJ4l+Q58z7zGJljcmihc3/AEgr+jTnjhWJZ84DdaLQ3OnulkJTF+u0P9KGktIg8
	hj+rT/TgZfq0vw3cU3pXo6eIxPBMsCwfWK3Sh4wMfbY0rRCaxJBTa/ZLoAg4kwA0
	Ohlc+aiZkVao/qdk50Aw0gTDOtkFVUFV5KsOaIy81L9D8RqkmePdL5LOXGShD6C+
	bEJqbyU+JRUKU33rtZufAQ2HsAHa58vrVZnFJaHrx04oJ4mji0JJwccnHKudT0sz
	GjHjUkhv85z2Ko+Bob+6Lg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4casehg6jy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 14 Feb 2026 11:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHicOYIH0rhXidjwabwOwibCKpMyoeANgIGZ5Wnq8jVKWeda12gol4ZpvbRUENMg3K3iFdIVzcx+9quf6MhYQa0Hw4bicJRxscB0ZzdaDpGEDnosbs2chO7xw3gUHLrIOc2+Eg5SBqRaTXPWTtdPk6XOK4G48r8noL1HDWwGqGvngkBxJuCsXMVuAqsw/gZabNY/97YmYOBdc00supacbs2sGshUQ4Kr7Ki4icsE5SjWgWUcINzDXDxPQRbP6i9lKmztDVlPZlbjr4QabA0XRvr4VQATR5AfPi1rWEWKIkGyrK6Uy9hKpaKiUSR8EwzIojqhNAhkJPTs9HQQJASSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcMkbpOC1uAJ1YlzyTspHYrJuZRirw7GYwKjB7tXR7Y=;
 b=fB5NmkK+faKg+4pzDyWpYVYldUEIb+bNFPms9bTp+PfWa7udkE4cuJrIKIZ023vlipJtj1pz5qt50GinM/0BMnbEAQAisnWudlyhf0ZaSMsGjkqf7egHR2Z4lhT9x8BwdN/g6EIBSYXR0Mte9TYmdVmoX2O7xvGV7cxaSb6w4jYG3sP49GXCegqhGAFcZsrGKKWsH554huUGMFiUV156h/u3ckb+/DS/aQpRiSl4cLz7zCBoVLsG92fwhxePNvqmG4AB73EH3B0EXtDLbhD+ZJdlyF8ew9kLaUgvc9itwyKan4lRnJHZvdBKZ/7qTR+KwI4fCGtxBwVItMbzCefdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sat, 14 Feb
 2026 19:33:34 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 19:33:33 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott <sebott@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <sunlightlinux@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>, stable@vger.kernel.org,
        Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH v1 1/1] PCI/IOV: Add nested locking in sriov_add_vfs/sriov_del_vfs for complete serialization
Date: Sat, 14 Feb 2026 21:32:37 +0200
Message-ID: <20260214193235.262219-5-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214193235.262219-3-ionut.nechita@windriver.com>
References: <20260214193235.262219-3-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::14) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 2debb0f4-0282-4d5b-f94a-08de6bfff0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|52116014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSHqQ6KRomFm/QwOkCCqxXMQ+gOePjRg0I3Ed0h6NI3GCvS2hpNlUYsvF75k?=
 =?us-ascii?Q?AyYPpABJAvll/RWhWESyoBtxlECA+tTPzmJfghECHyzoTb+VYq2mhEk39xiT?=
 =?us-ascii?Q?UaxHv5Tf8rS0sds47SPsGP782W2Ux8IN46LEBgkk5WqXuWzZPcqoPhPGsb6t?=
 =?us-ascii?Q?wDuBwt/rilFdp2OL8k0mpfQfcYza5MnFHOZtrJTi9jeT4Yqgzx3zKfWLqsP+?=
 =?us-ascii?Q?Yi2S6jU9gQ4X5zckarcvm6moy0SbDPGNhXFZiq8QzRoiocRhAVSkwr6RKe0g?=
 =?us-ascii?Q?U1vUVPPIKfH8o84tPMy1L5JzmL8lwu6a9smJgSS9Auc8562ndSPY3/qc+M4N?=
 =?us-ascii?Q?bWceLRL6MoRC7rvFdhALeaRZrMuGunTTbaU4E4CEBvtDaQAqF1l/g5LmpF9U?=
 =?us-ascii?Q?t/+7wMVY5I1IkT843ysBT6Qcqo8cZDgdtimd+pj25wbtaABv2R+hY46NKUZ5?=
 =?us-ascii?Q?PjnObzNaYVyoW4IJ73qlguntOeiH2upXasDRchJVF6Y/X9pLzE4zp2x8RAWp?=
 =?us-ascii?Q?U2u5+k5mLKB2+fveV+JfrsT7FKd76iKq7sbhSkDBU13yOqWQ/dQpTk5d10V4?=
 =?us-ascii?Q?Eavn9zwgUczn1pPg9ucv7fEc9q1S2Xd57OzRROs/FcIs+FDs4WWBiOWhnffy?=
 =?us-ascii?Q?rjC4jiOEEOOOo0AAdiWhw61ILHS+efhPO6JRldVlR17P92F4vylvt7DMrlWk?=
 =?us-ascii?Q?q9Lbz5L9gIqL3KB5vJOKLhN+vZCTJxC24eE9k103unMAGGMT2KVSRrBJwZJf?=
 =?us-ascii?Q?U7FX2PtmJG5QzHRduQlA2osLPscntqm2qg1pbsoaVfm8YTk3OFYeVHr1DTjG?=
 =?us-ascii?Q?AVQRxUAlkReJmaXrcvdrcBkGNMVsWXajVd5wEsZRbPc1vvRVP/t4KyoIDCum?=
 =?us-ascii?Q?8WkxowAqKLU4FIv7f1P2tn57kHAMKPs7dz9Y7KFGBzfhJB62pWT82V6WSz41?=
 =?us-ascii?Q?WvTgWyLKLg/uLdCltI2dzZWA99+MiD1nOByyqSjXATKpoa+q+S4RljixIOdx?=
 =?us-ascii?Q?TpTRLrApwE/DfyLYwUCiitbqEmqnzP8W/CYT5FG2alz2CFW8ss3KJwk2+i/u?=
 =?us-ascii?Q?dImSsjOwLoIQVq+wlTDAmrOPj+4ayRp4ZsrpUT5wxkGXFcWKaaEnwoeT1rSU?=
 =?us-ascii?Q?aitw9y+m+V0n++pUtQHOvCbM8gFQtl9GPg3SzsmQ6kk5GJVavwJyqI1I/aT7?=
 =?us-ascii?Q?aaZxysCZ7ugSq8/QOrd254xBeiY49m+OORfUTPozBV7JcUlyuLUY5bKktg5h?=
 =?us-ascii?Q?/jv75ch1uzevVPoTB0EHXw5ILJbx2wS37lXJTNCXNCSOgCmFMbP0YrYQN+HA?=
 =?us-ascii?Q?9scmE0mhSR6MJm4jcQJG0jchg5/X7Hwb7+Y352RjigArlRvyrYFHiz8GKc+D?=
 =?us-ascii?Q?B4ItYZsn4g91I6e7EWyDGyfdzrbafyT6iEjFsVj5ot+ek7gEAhN3r0FS5mmb?=
 =?us-ascii?Q?uoYO6yid33k8bMau63D3H7TyYQl/qvgTGvzfEpIE3ExsEcOPFvg2GQ0kLPkd?=
 =?us-ascii?Q?SZ6yZy0WoO8rv7TrhJgqQR/R+GTVX7eUkkIgJGJL1Klk3B8/iscuQUCDbTul?=
 =?us-ascii?Q?c0IIHz3pVcwAFok10Q0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(52116014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNl8HtUv+t6J2rzQAKqefUvKytoTpB/V4SVNDuWePwhOhKBTpzqqxw03l9M8?=
 =?us-ascii?Q?7X6NnK2HZXd5fDfMDCdS3qlFwTJ0TocKL7ZSDBuOuXzMKjn+fIpxjegHbzhr?=
 =?us-ascii?Q?KfixXMQhVXc61vzgWC/epuwobDF4INR67M+KfznTaLEe5pQzrh2rfPlCAcV5?=
 =?us-ascii?Q?srGGHL9roNFW7vmVPBzFh/pW+CsJQw/IQW4Swu1977YrH/Spnm7D/q8TdeRP?=
 =?us-ascii?Q?GEuEXyHGOGGcvwNEqWaedDlErJH5Ozca1stRQdR6VsrtCi3/S9eJhQIBCvty?=
 =?us-ascii?Q?3yedfr5/1mcuqTaVF1kh4AGuOL0ypvcZ+1byP52ohRT7dh2TMN7KW9EkH0EY?=
 =?us-ascii?Q?IIW5Xm0HiOUrcx9fNp9QZWCpMnLBAGE9oSl/99uFzgVpmfuUURGvyW7vdFM4?=
 =?us-ascii?Q?xZijF0af88lvE9kzY2j8ho1oYDA43WGMOg5xFauDYJxrtAJUjTvL1F1bbcWj?=
 =?us-ascii?Q?u01dbRxmIuLqdBH9vg9WvYX4fAwUFNMgk1K4q9MjKk4cIUYyQgdWd/aZv1IB?=
 =?us-ascii?Q?ilixqFchOBGh1H5y2ziAQtjvYjATZl6pipBokkAgEvv41AmUR40NzGImvKCz?=
 =?us-ascii?Q?8e71Js+xt9cGaMSD9KC1BU4nEwHgzOi1EsJdLyhB0alwKfhrtt6felmr6dum?=
 =?us-ascii?Q?bO+GZkrOEmeS8xMvbHGIx+Yvuiuo406GKjm0DTuChPsYjW1y31FqgzJBV6VB?=
 =?us-ascii?Q?181Ba1Votvsg18Af1DyKWE4Z306lhcv3H6cGHFKq9MfoFycEdtUWWkBwFBWa?=
 =?us-ascii?Q?YvtXtaNXfJwBQapRCIObgbACmvQ4TkqrU89EOy2fY3reHgG/zHJ2Ssu+hTsx?=
 =?us-ascii?Q?alp/Dia+0GlwrI4jpVbqYPFQtsbKSKKH978vdCrJHqsvuqYjmhcXjik2mSl9?=
 =?us-ascii?Q?1PoQGX/Y2h0LRHjz07KX8Ub1v341yvG6/356mHFOFp4OrP5eoX7gVS1R+mLk?=
 =?us-ascii?Q?ZXWvp9gNKfBk6bQ/5XAPsjTj2PycKLQKFK35I/VLDbYVvZh9p33odWo61FpA?=
 =?us-ascii?Q?DOB4FY+2RjsBIkg4E/I43/0hC382cJmetfWDYfpIZ8pGE6Eug5VVSE5YWn0D?=
 =?us-ascii?Q?WSbeExBj1d89jd18pWr9t7doCBBzQEv7VSrNiGdvu06f8VAaOl0rLwzH4Rod?=
 =?us-ascii?Q?3aZVMGW3c/WX/K1AjEBNwYGcrvdTld+pG/lw8GaYX8eEtItZjaq7RmVx8NNp?=
 =?us-ascii?Q?sfuh6XYiA72RJrGBukG0gkLs7snzOOy8h9K6DQTFg8VSiADR+AZ0z3r24+Na?=
 =?us-ascii?Q?rHMZy0OkVG44VBQwbf2zP4i4OUIzD/qSj3D6iIQzrRXhS/MpRaPzaGbLHbGJ?=
 =?us-ascii?Q?ZlPVoR49sTkUDDii/GMzLHu79hUC7A/ZmD5d4EFw6KtG00RQc29BSlk7BJc2?=
 =?us-ascii?Q?g1GhrRa6QlLKokTTQzN/5c+HAIKj/2OdE1wCHwHChfDZlOg9ngSoYKbNUHUF?=
 =?us-ascii?Q?lWPYDay15AhxbD1ynY634eWMA2xwuWcRey2/wXCBmP3BrlcKH4I/BSf9BJRD?=
 =?us-ascii?Q?oqpbUxG202X0+6HIp1EVf9bf1SxsG5/d0EgfX7ppR35gQaiUENCVdi/s2xT8?=
 =?us-ascii?Q?CZi273pvRdV+mE9zfRE4Z28UpVTn55L3n4lgZRe7TcOv42Wg8pSm59oz70nj?=
 =?us-ascii?Q?rgrXV8fG3l/+xaDgI3N4/EmVzP8vvXUK8NLaqWmvjEqgIOkExQFViDw82FT+?=
 =?us-ascii?Q?NB4GxgO+QiCltgpQh9IZ6NeKNVTt/AZEHFg8GK600mTLiRCFqOOLGYsxk6Sr?=
 =?us-ascii?Q?z95aOLFrBy/2vTytAPvqSyMMIgHG1V/e0Z+47kmIoWRC/gDTwWUDzJHJ6WAs?=
X-MS-Exchange-AntiSpam-MessageData-1: 0QpyY/9KYLtn4TDEXXDzKujXIaWJdRMJGmY=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2debb0f4-0282-4d5b-f94a-08de6bfff0ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 19:33:33.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyEmStleWWks32rfnrDy9CqXAxydQpXcOCrckZqLDdR4/5u7peGNa7VSqdoXIp/QlUtixee5iksTCT9qo4gRtxyOFJrturMK2Gpj6xJ63Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDE2MyBTYWx0ZWRfX9y6InFIXSLb4
 tQFrpGV60+IKuuE7fcUjFGHGwmtrp62m0ula+GqCttbK1vwa7xoJdupl/EF1fj/tycBr8N4lNOd
 a28bjsrHlQTMP5W6tVgPhyG8NnDvZv/TIa4k7G1KLm6KDCn164ZsKPiPpntDZWwIccZ4r7sy3GU
 ZqJgooT0KNtYpoLJPLsipPXYxQBnYT5+4PcOsEagDlj9+bVvzhH7VWExHyMqqbX+FuPAaB6vqCe
 /V5jY/rjhYE2q+6MAWO4FEG0c5f4+4T362DPrfma9a2Y3YvZlWoU8bzE9bZfhkm/K1oU2pQbdKv
 D71Xb28GFeTb9EqfA/qg04rfcIiOJPLoTs/M/wVVo+UyAsM3l5OfCCzoybT3NldnVeqMaDFas2a
 Lj6ucoszpqdAJDLC4gU/TsVdHQz5H1udjkLdsERL5WXT+atSZqJeQzFql5oUE65E7wBiXnMDW7t
 gIUOC+OwEnq//gUpdxQ==
X-Proofpoint-ORIG-GUID: d1WJwzjFOZl0sfXA0j8JAHoCcPtvvwRT
X-Proofpoint-GUID: d1WJwzjFOZl0sfXA0j8JAHoCcPtvvwRT
X-Authority-Analysis: v=2.4 cv=Fek6BZ+6 c=1 sm=1 tr=0 ts=6990ce11 cx=c_pps
 a=/yS4kdDgObtqNMJizKN72Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=6S3VQf3ZLieD-afqmuUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-14_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602140163
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,gmail.com,vger.kernel.org,windriver.com,yahoo.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216497-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:mid,windriver.com:dkim,windriver.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E55AC13D0C6
X-Rspamd-Action: no action

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

Instead, introduce owner tracking for pci_rescan_remove_lock via a new
pci_lock_rescan_remove_nested() helper. This function checks if the
current task already holds the lock:
 - If the lock is not held: acquires it and returns true, providing
   full serialization against concurrent hotplug events (including
   platform-generated events on s390).
 - If the lock is already held by the current task (nested call from
   remove_store or sriov_numvfs_store paths): returns false without
   re-acquiring, avoiding deadlock while the caller already provides
   the necessary serialization.
 - If the lock is held by another task (concurrent hotplug): blocks
   until the lock is released, then acquires it, providing complete
   serialization. This is the key improvement over a trylock approach.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   | 10 ++++++++++
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4a659c34935e..38372ac0e2ad 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,19 +629,25 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
 	unsigned int i;
 	int rc;
+	bool nested;
 
 	if (dev->no_vf_scan)
 		return 0;
 
+	nested = !pci_lock_rescan_remove_nested();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	if (!nested)
+		pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	if (!nested)
+		pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -764,10 +770,14 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 static void sriov_del_vfs(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
+	bool nested;
 	int i;
 
+	nested = !pci_lock_rescan_remove_nested();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	if (!nested)
+		pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c8a0522e2e1f..7d3b705728fd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -367,6 +367,7 @@ static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 extern struct mutex pci_slot_mutex;
+bool pci_lock_rescan_remove_nested(void);
 
 extern raw_spinlock_t pci_lock;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7711f579fa1d..5f38ed0c641a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3478,19 +3478,31 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static struct task_struct *pci_rescan_remove_owner;
 
 void pci_lock_rescan_remove(void)
 {
 	mutex_lock(&pci_rescan_remove_lock);
+	pci_rescan_remove_owner = current;
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
+	pci_rescan_remove_owner = NULL;
 	mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
+bool pci_lock_rescan_remove_nested(void)
+{
+	if (pci_rescan_remove_owner == current)
+		return false;
+	pci_lock_rescan_remove();
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_nested);
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
-- 
2.53.0


