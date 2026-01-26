Return-Path: <stable+bounces-211535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOxTF64sd2nacwEAu9opvQ
	(envelope-from <stable+bounces-211535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B258985ACA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6441030053F0
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5FA3090C5;
	Mon, 26 Jan 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FneBvUIJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qAOqdTCL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5F3033E5
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417899; cv=fail; b=YdP6ht1wR8YTrntGu7eBYaEQYrITMWoUK7CfP2/uPLOgk9whE9rUxSGYB4WasUj4wbYGidWjrrOhGDf0d89rcjE4XrAUJIV/D//9H9JTpbibsZWNlLFajBQufJ1UV3lS6D7pgtfNxjxQ66rbMaAgr6KFY5UR6F8h9KFYa73Lr9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417899; c=relaxed/simple;
	bh=NUBHSpxYi15RahAuiQcj5ooAbvOljPBV/4bRNibRmwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BGq8YL8WGOiaOMHDkRX9vMNERgA3n7paRzgQOOih+24Odfe/33Opsr/BAJx7YxaE0TpUfau9nVozz4LTAgh0qwCDHWsaWzExIF8sLzDNB4KFWcMaHdu1PZetv2vq4MlBCTfIKir0tDPd4/Xwctkw0Q6uMtYUdxBtp+9hFgJ+j64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FneBvUIJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qAOqdTCL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q3gKBm142226;
	Mon, 26 Jan 2026 08:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=F3i6FolrEZKvTkiSfQ
	015kG1rZ21w5mqAyvQev7K0yk=; b=FneBvUIJWeRtUWTpCribkVdeFNU24ewVk+
	oRv62JY74bNU6cL9tFgw+w45tSJT9lJxcg636RiGwvDUpUg1g5LoPNbwA1EI1984
	JoKDSkF3y/w/bGrk6jlMFek8dRSk7kWoqt5BFCckHYaXc43RPgxeu+u4K6PvS4NZ
	zESPyVqGY2aj1q+MW3RgBQaLt78hcoRyW+DCST7uJtvzrdlBUeuyiYHKS3joPuVl
	qtl/eqs2gAi4wxwy02cyGUKCHCsdhgf3U47Ds0zrLvx+B+smlFPL0yaRc7AiNj10
	e+W3EuHRLCKPE633IoX1eM1XlLIzbnI1aXbt0RoeGLFjsrMynD5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmr9gv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 08:58:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60Q65VI4019823;
	Mon, 26 Jan 2026 08:58:03 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhd0k3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 08:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9JPMXdzucuelpUjprsVsG8Vue/YHESDF+cwSZHIvrEy/2MLaw6E/IeL74G3grw5IpK5lnIoDk5fuyOzKI7D6gNI+Q/zFFrvNupwhJ8ZOHVhmIy+4emIBtzLk2ToclcdeW6I1cwzyMQf8xUv0tCPoDsDRC/+3B6+dsYS4ZRculTx9vzq0KHuriRxdMK7ysz0tVlrZSgPlgQLBvb/aWIsw/6P3n7vOERHJ1AfqKnfRfeG2aJUf9LszoffarE9Nr15l4iblHCrIC4wK0QgKYO+Yab5B3u95ftlW+dDmr9vFqLKXTXqyLZg81NIw618WcO7Zj6OL74r4vj+iomKArToMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3i6FolrEZKvTkiSfQ015kG1rZ21w5mqAyvQev7K0yk=;
 b=MgmXkS+GaGNQcIYT11lbDCZoWbRIvKwg0Sdu564m3e/Rp8ixfJQDDhj86jKOTCt7x+mvXCI0w7c5L62xNAN97TUOZskqsXyWFVoWW3R3bJMkTPotN47uxzBsv25vqlaagtntYBhd0rIq0Q0vhP1vuZhUaMIJ2Ui7v5agHRQxPrYmCX9c9DQ20XWYS9cVDQAUKZyQBpqQ1z+j/h9U9uzp28j1jULOn5nTyeZHwJ2/mtiQ9PbIhNECvbptbNjt39xIsBpBIII4RA1SMhHKIOH1g+oUoHE7I0xOyQfNWLIptsoLnUNN9Tvwnsi5L57qd1mGYJdiHbeM8Z6mvh7zyen9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3i6FolrEZKvTkiSfQ015kG1rZ21w5mqAyvQev7K0yk=;
 b=qAOqdTCLDKRp3ASFkTKF7+TrEwaqmyYj5A1CyQHwGLZpHvGp4aDinKT/yBlSumOpQbdtZ9MVjg3+qHjrxkAfuFqV9U5vf/qSolPKNsrhj4i0i/Cj6Al0cj/0zomxBz5Nk9Wy0LC/xS8Y8GIoEvtlKZyVvqnwyhXt4+zTelVanRE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 08:57:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 08:57:56 +0000
Date: Mon, 26 Jan 2026 17:57:51 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cl@gentwo.org,
        rientjes@google.com, surenb@google.com, hao.li@linux.dev,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Message-ID: <aXcsjyKFsmeVggp5@hyeyoo>
References: <20260124104614.9739-1-harry.yoo@oracle.com>
 <2b116198-b27a-4b20-90b2-951343f9fff1@suse.cz>
 <aXcmGMlH3sWO03rv@hyeyoo>
 <55ab1a9b-1d7a-4e7e-b6bc-ee327197dc4b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ab1a9b-1d7a-4e7e-b6bc-ee327197dc4b@suse.cz>
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: d395ce8e-b51f-4614-8a57-08de5cb8ff46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c685807VYQr1sekWP4tci3fD8qgvik8IKT61tks+c8lpxvq2tKoy2tzvVC2P?=
 =?us-ascii?Q?ym9vhsk7Ux3KSnTzn6GAR1uj2BAOzu7RwBZ7FpeDDjZoTvBGVY0oFMRKTH6g?=
 =?us-ascii?Q?73YWt679ai1kYTiAegl3y7NVjryQ6WkbcJbV7TG5GYt3/gYndLFtkdUGYGtX?=
 =?us-ascii?Q?TPf/uyAXKc8UgHHzdjsRUBH4zX8lTfVOcLYKoIZW/ielUSEm8BuGpAv1mavF?=
 =?us-ascii?Q?eBYV+hVlEteaYD4ezHNnrt5II+OBq/Qs6Zj0aPfMJeYauyEoCR57lUXu5zLn?=
 =?us-ascii?Q?7zK1bnIIGHjyj90NhdVVvxmuO9F9/UeUyqAlY5YFSSP0H+BpC3pOD/fqESVw?=
 =?us-ascii?Q?3lgTLa8ZCv4ElZGUSiqqbZtPUXyPo3nwwjlsRGklpZ4rleOD0Fm6F6ozFaRk?=
 =?us-ascii?Q?OHtmgphfyaqsPo45LiICtMiQi4ZLzSBEzljjjXzOe40yXf9woHS+Y3mY5HXK?=
 =?us-ascii?Q?fQ7pwG9vKeaEivKjuaJFG2pHuWhvJUKb6qjE2goytIdb+mrGZ7dE89vGv55J?=
 =?us-ascii?Q?9RlrF4DnzUqMwuw5kOH48GNS9Kuofr7C/2NQP4HsIglWPX/fnqVq+Zx/dbqw?=
 =?us-ascii?Q?Ie14GSE9lv7kpmVYxxJr9gCU/P8ehsWPxAX9rgwZZAfLNO2LjQqpi8R79+yj?=
 =?us-ascii?Q?o3kx1TkA+JjvWvhVaAWGiyJxsrqAQ6ZvD+KcBx+zxyMsuy2GT9S6DFbcx9uB?=
 =?us-ascii?Q?6KHcVHrES5wh5+hFSr4nAnHhbHbkCyzrIg2I4wp9HDK4L8lWZIuIGqjnTZOt?=
 =?us-ascii?Q?i7gwfQTaxe41ab16agzSloLAUXN+BLeiyBct6miz9Vbo/KGEXdurfGhRzW8Y?=
 =?us-ascii?Q?907meMHAqrWTOrNRhgJ5PMgRDsaHPNvh4oZmtINl9L63nRwQrEIAIQAKOWyZ?=
 =?us-ascii?Q?Thg4o9BwSV5og8Jo1B9n9MOoBw8o4imFUD0L703cnXr+ujjT8MhXfpLkH80k?=
 =?us-ascii?Q?AuXIT8WEoKQ/IStVLVAs+DKSju4rN0HYBDhAylt5VbqBtRXaxQj0EoU1UlIo?=
 =?us-ascii?Q?GPfR1VSEd+H59JhT0BZJgLtt5gnGwOPrGsg/fxsPGG1cXXyFDOTNXsJcfNEP?=
 =?us-ascii?Q?mRkiQ4kfs5HdhA6VCquxC8nXG7U4WduSHGMbBV88SZDVoIanzR2kpd3qdio0?=
 =?us-ascii?Q?p3iG96kZMXiQRmRNvWm5Z1r3Rp9Kv+oQQbdNiQG3Mch+D9xpzFaN+wIB3Agx?=
 =?us-ascii?Q?6cbgztCc/N9kRQ8WQIUEc2PconkWkzm3TQ6rVcrnXu+U4F8svnJcWr1qhnOy?=
 =?us-ascii?Q?Pi32TpNAkXfT/gF+PBiKinp06nP0YCOZ7MG6jw0nFMNiIHsMJY2i/K7LUvVp?=
 =?us-ascii?Q?PZsR5FzDrzeQ/PPKsE1Tnj1LUH65CcZyObCGTDue+MKBNomQQuZMj6FTwOJo?=
 =?us-ascii?Q?Prl6LPXRadKZMffSXNFdbJ8M0EJEKyGzu7h5eX8Kn6U0nITK7r3kE8qyKRxX?=
 =?us-ascii?Q?wOsz27VxSRxBYujc7WqnLEY73WKM7E8xEE37hlDjuf7M/tSF+UAPq2H02LxL?=
 =?us-ascii?Q?ueOFREnWBe5kGnSDKLqdHaZXE9TOWKFTq7/uUBq4gSwej6G90efcxWRd/xWU?=
 =?us-ascii?Q?rB3udw9cEei0se8BQzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w+NW4KG5z6lJPYtHa2IXuLIq2WJ1OgCeX3ADuoBufkP7M7vu67KB4mcTdgK3?=
 =?us-ascii?Q?2k/70dQaNuUQ5NjAqqMGfnUYVtRP2uuZV/W0v1TsjNODHYFxZJPFo7VnYefQ?=
 =?us-ascii?Q?nfjIE+NGNy8MJYOkQmkJ1t0jFiw7dhhTy6KD0MxB7B/xZQZGx+sTdiVvrFGW?=
 =?us-ascii?Q?7gwinLQJo5TKhFYcKn9xwHRNdNbNobxhl7Ds/BC2YxJMmD2GKNjpRCEN07xa?=
 =?us-ascii?Q?HVLjP1jZZB4/bDMdnRF1fFMa1tlNEftO48dZTvthPH/4Jg3KVaRRa0deEUln?=
 =?us-ascii?Q?vwvsKpqiVsyqxHyZBADk0y9GI/+qSCC0HjSMROzemH2oPLbeGgLdEZyMxRX8?=
 =?us-ascii?Q?NarQqfHbGQEXi/jwrahJHvgbW7gFMhb7LaPpVYoar1QYlpBS3/QCeQoTmWbj?=
 =?us-ascii?Q?JNUkHK7xiXnkYevoCq+17h154pNCrvJNbpHYOF0W7SatXpGGgXBnktngKRAL?=
 =?us-ascii?Q?Nbf+XFtl/QxpxTW8CxTCbSHdRpRAuQ8PJX+CgLe5qj84WV4nIFet3Jf9Pix9?=
 =?us-ascii?Q?z7XQmnjUQoJcEadMfI91CWb+uTDmSMMI90oVJ2+F2rmN4xLyKva+jngZA/cJ?=
 =?us-ascii?Q?FcgZTbsAj5iPLMjcf/aycJUikoLii4gN50zW4C/9M9fGrPzHxWrln8kmPFXk?=
 =?us-ascii?Q?h2sgsNWspzwMQ1xiNPjSN36p21ngt29lVTdlARrIzj1xO9xXa5fT4/GXM6We?=
 =?us-ascii?Q?knLUMVqGAClodOY0nx2IIYzGVTNo+BiDcui2UpzmdVRguvGgEO47gaRhdid+?=
 =?us-ascii?Q?xgXmpe80VtN+pPbCI4AQtkBPcO6RKyTjigPGY6nogkfNF0itSZNKXquIwdJU?=
 =?us-ascii?Q?z0D7k+fVydt6GSyBnAuBAa5i2JpB2GsFI4cwV4OnQEAVUEbiQ4iJv86vN++g?=
 =?us-ascii?Q?Mtu2N7SU2PAYFTq2+x3vFvQLyAtATkxjjKHzDcX5Jv48EczW6fIwkNbrjoJV?=
 =?us-ascii?Q?VdBtd6lqJjuPrSIntU1anisfQEU4WzvuADPyYl7C3dtVv1OJ/iN42ZtFu266?=
 =?us-ascii?Q?XJ3WfylIT0uFXShZ6t4Pvh+OIMslPkcnK1iFSjZJV8G5Td3ESSty2iJ/p3Zr?=
 =?us-ascii?Q?KoDgCmkwVfJDeUltaKDTJ4oZDnZTJ3tTh6RgQBExyGQaqvhEpHGcItPWeiZ6?=
 =?us-ascii?Q?Yi+m9LIz0vFqbBmXi9vP4vHG+eeLV9rOUSFFCLlvXkEko1Qcp/Y2btgz1gJq?=
 =?us-ascii?Q?H1bQBCojT0iKyyjbz/L4ySfuMUVYWlm19XTU0VV9aI4UOBZBlWV3WtjQon1t?=
 =?us-ascii?Q?Mz5HXXVzQsyLi6ZsXY36JSYBsFFeS3zV22TOoQPboPdbEAIHPfgn+7wIG1DT?=
 =?us-ascii?Q?geXUmhSzy99KBZ+4CfT9Nu56Ccbv269FVTFgHNum5g6t19/4TnjW4ky30pJn?=
 =?us-ascii?Q?ksA4aI+i9hsUXDxHTfC34WiyHPmQJD1qEE/GnrO7UnutXiteYBLO/IapBIDd?=
 =?us-ascii?Q?fR3aVJYYPHn9/ZrJGypUs+g2sW136SvsAl8uwxcjM3YugIgFQoPP4HQwkdm4?=
 =?us-ascii?Q?b9jSYYawev+dhzDTHumRbjXL//fCGfWUVVJRXOu+RjfrdJL0B68lx/EEeTp2?=
 =?us-ascii?Q?7NNkUq0yWvu0i9b5vOF9s9kU4ve8cVwMHF5y/0BDT/0038ZYiNS3/J5RZrbn?=
 =?us-ascii?Q?G0tLuNroR6jsznmzAvXJ9A3LDbPSvzT7iuVpv9L+QB1AAlbi9oJYUWH8xtxO?=
 =?us-ascii?Q?Q9n5tZ6oAdLBDaRo0zBN8ChXUq6ttl8hZn9f68sieCJm/k1kZcPyMWtsjwQQ?=
 =?us-ascii?Q?mcuPd8An2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5+K61oKLRydKHi7x30f1t5mxRHjJZUGOinLRMZd3fB1zVnbeLU+OBzkhBpnNrZ09Id9g0+X+hEihJ330HozQoUiQBSjU1WXzmR38TZiMr0ewGYGAIvA4LOrLXar8QmGdhyFgbcdAOW+k3sRBmoP791xHECTsb1X3IzJk+MbZwLvwGlBKTKSkzKiPyodhulSWnKKfz1NB8t9s/HJ1t7rDDmc6O9obGkNrlDcD5Nq9VYQccUmOrHGiN2K93jUWKKN8UFMjjnahk7HVho2mU2OzZrB3Xr4NtSp+RXUxPmDc9yBCAmccv8w3JyTGUeY1TDHDi1i1n73709Kh2FAEJGOS7DAwwF7Xf3MKJzc7hgLY+MvTiZsL/HbaQJ/1Sr1Q8O+xtLcthqsMJTtFQFczWg1BXmHaU+Ppv1PzVht7fl9mu3WEe2f2lMJbWFghbXpoUSK9pw47ZFrBEB93G6dZ8dMfMcey/9U8IFHOgD4XeLuYWhhGG76ZWJSaXfzcPopAiwqTQGBsJsVTauMb9o0kZH9oowuJWdHBRgFmMQBl/yKfyoA+wx7emnbnHdgg9N5q2RSw4t7Fo3lBpw5DeRBOVVZ8JRQ8pqRgtnw1etCbcybLNbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d395ce8e-b51f-4614-8a57-08de5cb8ff46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:57:56.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8y1PRwQqOCuivrDHgUe9xhKtF7cioEihch0wh+jP2PMZC5/d+N37V2SO1YdkqaZbo1saI1OPtkVunjJoJ5PwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=850 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260076
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=69772c9d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Qx8tcVzxNuVNlklqwQwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: moau7tZIyHcylWJAO4uVQ1VECsjgoMeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA3NiBTYWx0ZWRfX6SwotNEVhiB4
 +FQm9Q7nr+VmpSBcNFsGQjD/nVwHoDY5EFqlNBZmO/ykiIll8HH40SmFz4MZ1wEIWsz/RjtelrJ
 sUQI43CJnxp10UXYpXPjFLbAe1kp32nak4PmJg0ivJi9R/1sEOgyuiF/tBgQ81peCAP6Ljtflfj
 /buMZ1p2ywx5ae50jUFSevKunKfZmNFg9jpYKVsU6/hfGWsxnpStGkWjXbpv7Q9JScrPih6YgWJ
 ln0pq4vGUs1lvqbWci55XBgVOtCNrZ0rCkKMSnxCp43vJSH5Q8D8nJkRYwr8FdJMTEPovjTP7xR
 jokX0S+tyBUu7Xg6b5evGHEHuDFhEjg2+D8TO5vUj8y1PF9TOedI0i4B4+/ZbA8mtcMKiqqbOqd
 3sEnikblY3aZfINHd7orSfwzr9FqsPhEx+FDJsHZ+ZaeBiKaxK3GXh9kXKIyNCsZ0a4ThzflQnu
 PahzPHBXUfhYuPKqXGy04jTO9jJHSHr8kg1aoK5A=
X-Proofpoint-GUID: moau7tZIyHcylWJAO4uVQ1VECsjgoMeQ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211535-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B258985ACA
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:37:29AM +0100, Vlastimil Babka wrote:
> On 1/26/26 09:30, Harry Yoo wrote:
> > On Mon, Jan 26, 2026 at 08:36:16AM +0100, Vlastimil Babka wrote:
> > /*
> >  * Calculate the allocation size for slabobj_ext array.
> >  *
> >  * When memory allocation profiling is enabled, the obj_exts array
> >  * could be allocated from the same slab it's being allocated for.
> >  * This would prevent the slab from ever being freed because it would
> >  * always contain at least one allocated object (its own obj_exts array).
> >  *
> >  * To avoid this, increase the allocation size when we detect the array
> >  * would come from the same cache, forcing it to use a different cache.
> >  */
> > static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
> >                                          struct slab *slab, gfp_t gfp)
> > {
> >         size_t sz = sizeof(struct slabobj_ext) * slab->objects;
> >         struct kmem_cache *obj_exts_cache;
> > 
> >         /*
> >          * slabobj_ext array for KMALLOC_CGROUP allocations
> >          * are served from KMALLOC_NORMAL caches.
> >          */
> >         if (!mem_alloc_profiling_enabled())
> >                 return sz;
> > 
> >         if (sz > KMALLOC_MAX_CACHE_SIZE)
> >                 return sz;
> > 
> >         if (!is_kmalloc_normal(s))
> >                 return sz;
> > 
> >         obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
> >         /*
> >          * Random kmalloc caches have multiple caches per size, and the cache
> 
> Maybe start with something like "We can't simply compare s with
> obj_exts_cache, because..."
> 
> >          * is selected by the caller address. Since caller address may differ
> >          * between kmalloc_slab() and actual allocation, bump size when both
> >          * are normal kmalloc caches of same size.
> 
> As we don't test the other for normal kmalloc(), anymore this now reads as
> if we forgot to.

Ok, something like this:

"We can't simply compare s with obj_exts_cache, because random kmalloc
caches have multiple caches per size, selected by caller address.
Since caller address may differ between kmalloc_slab() and actual
allocation, bump size when sizes are equal."

> >          */
> >         if (s->size == obj_exts_cache->size)
> >                 return s->object_size + 1;
> 
> Why switch to size from object_size for the checks? I'd be worried that due
> to debugging etc this can yield wrong results?

Oops, sorry. copied from wrong version of the patch.
Yeah I initially compared size and then switched to object_size for the
reason you mentioned.

> > 
> >         return sz;
> > }

-- 
Cheers,
Harry / Hyeonggon

