Return-Path: <stable+bounces-185667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D24BD9C4A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF34F330A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCFC31283E;
	Tue, 14 Oct 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JDILBQTZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ulxfT7qF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268783148D0;
	Tue, 14 Oct 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449114; cv=fail; b=Hga+mY17tArDqTqdKpoIpOTBl5krpOrDV4CybPkkkK8yoxRy7vbQLywrPtgu8pg4XalA++veJdczgrBC/rA2JgTkH06osNcW59Chf6fygvBio1hoTgIVzgd+HlRMECWtIeeGN97mpOZHDr3nKb/D4GuyBXGv3/9+F9zSHPI5jpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449114; c=relaxed/simple;
	bh=oGuAJtavE53wHP7iWBmYz/OJeiZEdXnwCppBhe7q21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nOvufvgiJGOogxa0op2IY0ZpRIocurpgZAOTW0bPUMk8CrQECYQEqXOCghZyBkZtMH/wLKNDNY5M1ign0F4PufTpT+01gcjF6SQaAaqDqhw7e/g0Uma/WTs9T2Kqm6ZRLszRNy7q/Nfppo/Yj8ja+zAMfkO4X3VPjwy3ClqLFSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JDILBQTZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ulxfT7qF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECu7uX013201;
	Tue, 14 Oct 2025 13:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=uzdaZMPB4blosHYKQZ
	gE1n4wbVm2Lv5e3HM2M1/5050=; b=JDILBQTZy7YA7N2aaM+PaoR4ndgDOdlWOg
	/DKnwaGpMeNTCHg/hdxG8ZZmfSIUMZmDctN10hENeIGFTR4/1y2I5VkGeEGNqs/f
	Kf4u0Qh7wY4YOANaDycRcHzbvBZbDnah84dqe/OUvaIqaCQRqekxbApvYP+BhY0/
	SpEDZykwD93j5PvwiA+1RStMWXm91PwMnz7utErIsILKhmb8Qt9Wh1zd7jNUOaR0
	XWN30bmGNgON5/DfBK5hxoWhnrXyg68CPk0dodCtE4Lp64A2RqnGW7z4gjWXgCkf
	r3Jk+rMh2uHJ682Wly+9E2V0L9z1rYPqz13eMsuoehtFRWI5YRsg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bvd1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:38:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECc4JB037871;
	Tue, 14 Oct 2025 13:38:16 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpeyhht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfK3XdCVDafKew9OeVunmrzvbr7QZc5Q05BMN+GBzwBG4QlgxT5MtKnrt7u1jOxY3eMw+b3FxVObaNEMSRqsoJwcTEmGBmpGkgosffO92c1KI3Tf6JsOiCF+qEnuo08+fVavPpZCvwB71g7I/W/zdE3CNzx7YLt0Te5mL+L8L3yo37Q5GjuYVHaw2Wewpi4aB7lBKjoQDTUGpVVNIuSPiaaP9LC070bjuK8vMTF2VHiNgVQjogGYvvH72j8wR/l5j9KPBW9E1oRtaxAM1wZ023NKyCmqicR99VjzzZEnpvn2oqobG0em29pP3N/FkD53qA2t4kcr7axK6oxD+mKLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzdaZMPB4blosHYKQZgE1n4wbVm2Lv5e3HM2M1/5050=;
 b=jrJTgZmg6JgArRvYhDZJqdJrD6lB7KGKkuYIunlcDqe3iKE6+7a49XhK6PpOkmVqe36xApvq3VpxZdXHLsv3aaeCgsz+yLAhmcIZW2snueNbLoUH7Jt063LkrUPahhlaGc6xix43Zu6JWjp5pIgN5C6LEeNlGXTkFyEzK8MgY7elbwr2BncbLSTdzrEV/o3VHClwbj+Em7icLoVJ/EKmvGYdy7j7uBbkOLhEu4uWmenEr+k8+YVXl5tsor5NF8qJeZlUrfz0IV8NUv8SaphX49D16O1hgs/MluWPq79R5/qLZgAv8FaD0Vm8aFmit5XfNk8E0RfYs//oYKsPnPxXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzdaZMPB4blosHYKQZgE1n4wbVm2Lv5e3HM2M1/5050=;
 b=ulxfT7qFnJnaR3dMy4He9Q1Gi4jd8DHe0Med8QjeyYjd3AI6PDflclEhXOIYegkdWoeAuIN4eh2164hy3KCtiZwSEJ8tMs3mBC8yYAPXIiloQmwb3my8It6FcaOFtzECGA/CAT7d6WMrOyBotqwrGdrTgsJEIfbUAShG/PjTZ6g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 13:38:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 13:38:10 +0000
Date: Tue, 14 Oct 2025 14:38:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Message-ID: <24b1fc5c-32bc-45c4-beeb-f794e0fd0b79@lucifer.local>
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003155238.2147410-1-ryan.roberts@arm.com>
X-ClientProxiedBy: LO3P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 169f59b8-a4aa-4c86-538f-08de0b26ea72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tmG8Bed5TELOq9oPmtxhjJdGG6xT7QLRY+MY/BqG4vr9qBRYKW4IOqydfDRn?=
 =?us-ascii?Q?guSDESKjBqv9Qf0+DaygAPcm+Hpat77MD3KlpOeL4G4mOa1LOoovyJJkF1Py?=
 =?us-ascii?Q?OEu2wsrbuLfNfOoyEkoygTxP6Fqr0vNMqAFNMYdjdTMMOFQIznf7klaGWFIZ?=
 =?us-ascii?Q?M5kILydE+SLYr8Guyf1PYDmB23kZBRBHdOcDrGoSYrPArUtc6sQxj0UiWgaL?=
 =?us-ascii?Q?ah5fFr+i/8MhVQLt0iM591wRheo2ggLN+nMGS0JMCrD3X+iNAs07ffy3/43Y?=
 =?us-ascii?Q?6Oxnz9BpCwOSUfGgqm44X1IRZnG9HV+WgdM/HdVqREsQtDQfPYx6k86BjQxp?=
 =?us-ascii?Q?I96nXqCYN5/ciOtMeyUESR1NC+vw57Cu28wFbaN7a8sSCJhzb+VV31E3/CfG?=
 =?us-ascii?Q?DoVcKB4xdFKP5EI/nOOMM8jfSgyKqa6QsBNEGJ2va1B4kwq7+rHKDj/sv4ny?=
 =?us-ascii?Q?8+ZZfDtnOX2S4/SM25bG5nvHKOv56uwfwzgifyyFKd+ML8UXFXvhXrALkErd?=
 =?us-ascii?Q?UY34efSmaA6dg1s94HPR95eemQJoA3PLM/x/oPISvbhvtczzn9aAOkmgHW7Y?=
 =?us-ascii?Q?LpZyAMrpEKwhhE7U3MvQBi/COEh4JwBsboTqO7j0MDaKWG3igZNpNsWl9BFy?=
 =?us-ascii?Q?0Ii44T1vLYcvfF7U74MJ1j6a8NuWuGGy8gkw/cSXDVSKlxhcvsmmQ+7sNu1m?=
 =?us-ascii?Q?cs6rCWbOuRp/5dG9+IPMVz3aUEEIhWG3IEDgh0g52NKP7iAINWVD4JEgdoc4?=
 =?us-ascii?Q?/eO9i4yeL9rAlLl/A81S3fhAJzdaa19onrGezem2Qq/YmWjGfdSzfJ9n0nV5?=
 =?us-ascii?Q?FI5y6amoKqPh3EbKuiZ1KnaNYVkadDC+j4bMyjXfnfsQiRv9TqKLoARJT6hV?=
 =?us-ascii?Q?5USFMSJbl3EoiwMAkRdlirPybDX5HBNRF8WH7RneCmS+RAXOSqpK6xhKJW2t?=
 =?us-ascii?Q?zQTv99SY582O2Ct6Wdqeo6ZtKHd16o1JP8Rm/Ww4qTUP7LS2f+2vpPqLFfeg?=
 =?us-ascii?Q?Ka6aEG6uNe6jMEONdCFaMd8EW8ZmrPesS8PkZ/M1zCuYkgc+J4w+Zswv/yGD?=
 =?us-ascii?Q?Jse0kN0D7il4n4WAF6U3ipLFLvGJ/+ZcMZzmiSkEUDlxKJ6if2CzONTW9f1u?=
 =?us-ascii?Q?Qpd+5nVlV+/52MJvw+7BC3fhgLP1T1x94d4BskDPvthS6PDJ/1iO1hkJuP1C?=
 =?us-ascii?Q?qvh4XcaUcQHRqOepAl2P1wieIZN4k/XdannKG7uwtHqMIQEEdvwgNImRlRMo?=
 =?us-ascii?Q?US36hsQAj1gjYx1FP+bUCb8RsriXrGEOgaLWHPCQybutjFpanIK9Vdn1dtCl?=
 =?us-ascii?Q?tWNdyk0n0bi6qWuwxdURyqd4vMhvPcel8bUX9u3ASEhNRAtqTl9mHOl47NIX?=
 =?us-ascii?Q?jKnGXYJVXy2iNUjTIfomtZeHgxCD8jQjhT/wvUL0WQYwK3LCV2fy3AqUuxON?=
 =?us-ascii?Q?OTg3cPy0R7NSrZhZbYF5aRoeAJEolwgM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3NE9kk9fL/t8XXP7eC9S0p+ivtcFCcJxZGmQjRVcQdSM2rjjueIFC/B2i9U?=
 =?us-ascii?Q?khByg2lJqNi+NyEkJSaPE9WSGAYbqBAnQkPO750x+tiunaxLwaIF1jw4Tdw2?=
 =?us-ascii?Q?6PC/VUKaOcxEHICAj798U3fAfuuVzcVgbBXZnemOjlZ3/CAUFo3V5Wj2hhAy?=
 =?us-ascii?Q?2cwTwZmi2DuMjwM8gSjFuSDG0DnT99KMnwsRQuR6pM3HVV5RA3fUV0vvQ37i?=
 =?us-ascii?Q?hvNo6/hoXLC3vm0G2xcTCequ2mCoi0pRBPJpL0Rb2PBtMrCQLcSj73jM4qFK?=
 =?us-ascii?Q?BaNl9YUheDL03tLElB2dXDNTBaDb24JMn1bFOu8UFqs5RChcZMPuV/QNiuRD?=
 =?us-ascii?Q?exIwNfBtD88o+yP6n8ob6odu8Iz/oQ5DFsD61b3s+3GIf1/fpeXtUUUhtqEv?=
 =?us-ascii?Q?MJKVFH14ugEjkCLA1jE8kC15ExanNyaXetnWtcCYTrT/6kBBWdCzJgYHPYzr?=
 =?us-ascii?Q?Pj79Ao3oVxv8HlrU60P1CQ95XW74ufKGxpGC2BY/ioDk1ZoSaVVK/QFW/MPX?=
 =?us-ascii?Q?RPViwwvnVbKFkrhFrqPxSUQFkLTR3V4IZ4TgSKztViijl6sZadNTICjtAdYb?=
 =?us-ascii?Q?KeJYnd3yG1Mk5tY+R4AuADnd15RKp7kKW2xjCK0Ro3xeG2msFtkjUwNGps6b?=
 =?us-ascii?Q?jS9Z9lxWmHhwUWz8RGoJAw5DEXgtqW9ppYbNe8Ajnf+54L05o3Rgm9OI3Ypz?=
 =?us-ascii?Q?s2xnqhdwkD5SsKxvRRsXrfFlj70wa3E1HFVD6g1cbm/byhdiuB3Q0VSDFd47?=
 =?us-ascii?Q?WRarbTsNoQxYYCPjIf04HSNQnkEsERDCTMx1s1YL/utgzCD3kX5PQA9McfRs?=
 =?us-ascii?Q?iiRINvA2/l3BUbnhmE7XkkVoKDwiYnv2YJ16R7q9DS4r3nLSsE9AmizgDWUE?=
 =?us-ascii?Q?p4ctttaPxPEG6iZpKvpXHdJQXmI/R0XwK/tzoqOvgJT+Uu7QycT8t57Ibv4k?=
 =?us-ascii?Q?fVomRF8Rt57LpY1FDeXfYg9KLIztameks1ml+eQleseCIgBQ2gXimuLgbUvs?=
 =?us-ascii?Q?78gTnD2qo5d64in8551DxE+vZ/2uFePTLl8I6HSB2ML08UImBodKSf0mTic5?=
 =?us-ascii?Q?dcrvYVROkQtw9W6VFw9j676bcKGl/Z/V7rILBqYzv3g5sVbVvUdsmHElzXgL?=
 =?us-ascii?Q?AIaaI8xS25qknwIQUh+Ui16WcVcfJuwB9RmSlHazaS3P+Ce7Wej6a10S2xLb?=
 =?us-ascii?Q?E04AW7SDDJSaSOkq75h8jK16/DJkMk006H4ZJjriP6lEJe7hcOW5s8oVd7MV?=
 =?us-ascii?Q?VaZ4O/RgjK4h+TfaqOnpGXT3cdcv2cYoTcOhx9N6tvb8yH9M7P14E9hjpShw?=
 =?us-ascii?Q?SF7eoKwgyGAFou4LDHkomXYef4mScbYKMZW+nUOu2KVHP8dwba27vyYSkic2?=
 =?us-ascii?Q?BeeQcce/NIf6DNIvTVMcyugJJ4wjopG7SIXdQ+D4vd5P6UUVqjWf7XzWD2Iy?=
 =?us-ascii?Q?eTOcCx0HDbf5l/GBHc5Fzj/nDn9iDwQ0aHq0O6ZlIHZ7cD/2PS11Vsm8eWtL?=
 =?us-ascii?Q?uA8rGXdujUZJdxBgD0HSgen1+xRHcav19ILRzLCIEbvUKtEPzn6hxk5GLYAg?=
 =?us-ascii?Q?ipYaU8LeOJGWVOXFT8NeqKava42nzifuS4cTUgre6/Ts4l4ZjPZiFL8JfJJj?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	okBTEeUzsRxKHk9MMpuVarLxHaOsm+L+NNtIijMaM9uBz2azowG6SOy3N0HDkbEzhHOJMaWPEyvdeiw6qY1PAbnw51t6TdjJZQM5YqKbB1VHY1AP76x7na6UtYRYeH22zxTzzQxXnoEdMyqmlf/hN2ztRqPUgQakMBaYB4mdUlYusYehw+Zm8BCaM5VwwnL3AnmndADEvvUaELjWeBANGxXYKPwbOsmcgRFIYulCnYzjVFGsJo8HU458V5GzBNLRPNjqMve4HDSLf1XfYnVSOgM03oz9yPs0laStg/7HF43AWmQzahdJ5pPVz1DIgG7aV2ST1tIuhhNbfqc+IQdSYzjB28Ss6qn+dfN8iswnB5A27WvOzFEIGvD4vI1E23fcA1gXZ10mZ57r/FhoyXuzX6CBRrANdUICHIEUfBbbANcTTdBWe9sMc9E/Tv59BcZ1g+hm9UljPvlj5WZLflQp/LzlRp7rIsYY2LyWJc2AcXtkbiuAR0JPClBLinwj87705mwrpAuz75s0YhYJLtjO1Qg2GHf7b3JAvXcxdfvUU6JQJsgD9siNPUFaslQ/x2PwknDDwh9HBeD6AkVn7SJXqJXmAb+wU7drzC4ZnFtf8jw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169f59b8-a4aa-4c86-538f-08de0b26ea72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:38:10.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPAU+e1dP6COo5r1yk0zuVgzlE0rEMO2AVGzk+P0YBMJMI+Bk3x27GEaj4Hlak10a3JfrL70bHgSxalSkQApRSckJr5Ct2sxNks1Qc/571Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140104
X-Proofpoint-GUID: dW32L5HtMZkNis3rNns6eLCUjPPMM73Q
X-Proofpoint-ORIG-GUID: dW32L5HtMZkNis3rNns6eLCUjPPMM73Q
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ee5248 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=t1Kh4uhbCuRW0kA8Y-oA:9
 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXxPQWlICD5ivL
 L2qWuKCXz5UbcCjTC0HPgIwQMYEGd9pWaB7/Ua/HTCeyLfU2JcddNfFEZSH4S/jve+BGHO1jikm
 zjV3s3azZY8QZ/8tgLEC89awlMoh7gAQWUbDibXZiNi0Bj9MNXCVclDPj9Li8UxoQ0KW1+47nLn
 ZuAhlyfzDBnszwaDdXReA7OQ0O7BtKnv5G0BNW1H53AnEsQN/AF1QLzThdF62rMz4uGLmu7/bMH
 DVLM1Q8cgxh7sjNACVoRQS/uTiHMxQYBX0scG1/9lbiMUbc503giSTJPKkpgEsFvbMenvw1YpLL
 lfH5+pxqq8Td7HWs0m9+cFICbpT10CdtGls6jcuH2GTSUSJFMnOtlPsYKGmASwtRBHu/HfRgYaJ
 6haI1X9HXmRvZ+H7r63pZCLI2ngnWpjHnwFgDBOywg5Cjpcn6AQ=

On Fri, Oct 03, 2025 at 04:52:36PM +0100, Ryan Roberts wrote:
> fsnotify_mmap_perm() requires a byte offset for the file about to be
> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
> Previously the conversion was done incorrectly so let's fix it, being
> careful not to overflow on 32-bit platforms.
>
> Discovered during code review.
>

Yikes, that's kind of crazy that has been in place for so long but not picked
up...

> Cc: <stable@vger.kernel.org>
> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks for fixing this!

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> Applies against today's mm-unstable (aa05a436eca8).
>
> Thanks,
> Ryan
>
>
>  mm/util.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index 6c1d64ed0221..8989d5767528 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -566,6 +566,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot,
>  	unsigned long flag, unsigned long pgoff)
>  {
> +	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
>  	unsigned long ret;
>  	struct mm_struct *mm = current->mm;
>  	unsigned long populate;
> @@ -573,7 +574,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>
>  	ret = security_mmap_file(file, prot, flag);
>  	if (!ret)
> -		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
> +		ret = fsnotify_mmap_perm(file, prot, off, len);
>  	if (!ret) {
>  		if (mmap_write_lock_killable(mm))
>  			return -EINTR;
> --
> 2.43.0
>

