Return-Path: <stable+bounces-188284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F0BF45D6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 04:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2080B407CE2
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FE621D3F4;
	Tue, 21 Oct 2025 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SC2+xb1w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xAZaAlp1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E04AEE2;
	Tue, 21 Oct 2025 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013035; cv=fail; b=j/DsmpOSZ4eFZafH16VKMuKTwWn4BsNgF7sbeTMqvUIWek2I9uGF7/24kjjCQLwQ6Fp1GxH4ZpaGsDtA9/Sc+X3RSxQT5D1F2g4tgbFGtY9L7SUf7CD7smCjNZBo6mi5VNke++LPwJktJse/4ZFQTVbpk0nxD//nu85lJZ7rPTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013035; c=relaxed/simple;
	bh=TQh8AtVkozZtctHv8OpkyXcrql48wEVR6U7zl/m7yXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NjyVJXqvRJcH37wtTXLlj7nxcfFGFToxOUfUIJPhXGbqZR6ubXJoqj4PioP2gev2hJRAeVmGYsNwbEmMEkVf1VajEYQCc3WQe7RJM/GvTWw6mtU/ec5AVc/oYA68GGZm4Tu0K4wgFlLHQg40xU3N8hesHDb4DrHR5CdPYMHtwoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SC2+xb1w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xAZaAlp1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJuj2k003494;
	Tue, 21 Oct 2025 02:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Gmgx6rUgSbYPeVTE9D
	8rTUBGek9ebWOf7J51PG+KFi8=; b=SC2+xb1wjRjQzTUuKYRD6gyZAFpuvjyhRS
	N0x+FlWE6deD55njqQLUNWD2CcETaymg41wWuDJmWS0Y3lpMTfP0xt1CPE+vb/Jz
	WRwdWVN6NimdtYsAYaVvpbapx/6g+lEb0QUbZrh91W0GzKRsUYcA5kOrogkbxxK6
	ufK49KofBrslcOCyZKuUL0G6CM1tiFIyIvSE8zJph5wjE+hAnkDLqP5LJ7y0biYv
	w8M5T75yM1z306i2/4ghb28hIPRW4bcGFh7ofNi6SalsIpIfvGgPYPcvnlMhjWXY
	qjxFI5x3DzjVmimTYKZ5xMDUyhXrqDajaOLfXBb1ODXZdIZ6mrbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypuhjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 02:16:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KNpplm025448;
	Tue, 21 Oct 2025 02:16:38 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbc4hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 02:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Dsw6z60um77kF+Ma182bRBG5e0JJqUDASGUJrdjPGDM17ilms4JxnEHPIHUbf5gG7EG4e0ay6NgdadjFdRC0JKqN+YELlXCBqgTlul6fMA4taEWGvvb0c7vpRylh8aFsQdZTS/NH6Zb0kvS1nlowXCeoPzDVgnr7P3SdSznJY1T+EOP/nd8bI7iGJQIjTC6IDV8LtFE/sK2zhyxAqWNZfGS39D76dq0J6k5u4KT8fYSpf/3iCv2HtCD9T35Kcqe5tvkAyG8Jd0LA59kzcCBS9/es9Rk2CunpVN1w9Ib0hpCgY8eRsS1PUE94CLjGLyBOn7mWOHRYwSs2o9StvUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmgx6rUgSbYPeVTE9D8rTUBGek9ebWOf7J51PG+KFi8=;
 b=OWdJtxpbBMtwAGPmVrvONQd9QnkhEjabokZeJlOIIvxdEP9RFFWkzlRtWklQ71qzygGU1kfhHx8YW+uilfBCjSLG/cMZ9PtZv6NCwBLqWe++IlpqACyvNxTPfyfKR+R/Axl1YgTv5WMHf1n+WbhezMc8TobO0uD9BTeo3mUvk8IoLDOCr9dx8tg9LiFP/8UtQH61BQaR9XSujnbVO+xfXDldD+CMXYZ0c1nsRtA1dM9SnSmT5EQ4eV92r5KtOp0gqdFWKFxoeth8ykUFWDkBBvQvPvt0N6Ol24JoqhFpGZ0MrdkkHnBYKKlVWVG7vExW1ilPnLogl3cZAJwWeCt92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmgx6rUgSbYPeVTE9D8rTUBGek9ebWOf7J51PG+KFi8=;
 b=xAZaAlp1pNfo2SLGjD+jaM32J5nbXl0s1D/dOCmir2mVZO5SagYqORhIr4dbxd9AtppGKeBNkmmGk8kVi80YN1ZcclwNsVugWkePtlIxuhAW4+lpUNzyDdMl7jFGg8vHwE1ADYGAm30Df8/pTz+nCAL0UWNUUx001B7oxFZrtGE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 02:16:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 02:16:36 +0000
Date: Tue, 21 Oct 2025 11:16:29 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] slab: Avoid race on slab->obj_exts in
 alloc_slab_obj_exts
Message-ID: <aPbs_cu261GnQgcu@hyeyoo>
References: <20251021010353.1187193-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021010353.1187193-1-hao.ge@linux.dev>
X-ClientProxiedBy: SL2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:100:2d::30) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bab498e-01ef-457e-0a19-08de1047dc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G50yf/K5HYIZ4mBg5vm5zgJ5gxlZ4MXq+P1rGv9wM4u2+9JEfrn0Wo+VbCwU?=
 =?us-ascii?Q?VeLFbYRi6aatg5DuUbO6kE2G/NrXcHG9Yg1WtEXh0mjT3ZjwRgsnfJ1qCx6b?=
 =?us-ascii?Q?+J0y1bjjZFToMYhB3lTGwbZVL/lkEGf55k9Vo2J52tSPRtz3nckIlm+DQJkx?=
 =?us-ascii?Q?B9j/cihn4PONVePDuGuA9dC6EgrdXfcR6EM8ZAk5j38FmRGU/JRk7BLoq3cZ?=
 =?us-ascii?Q?OCdDWmw9tIVN1i3KvjdbrO+eSVfl1T/Dm0x5ekoqbTjcumHKWSZWwuu5ugLw?=
 =?us-ascii?Q?Kqk1CrwJPM3U7dIP1UAHTkYG7pz1yDLAO5921nrZuI4tZG3n15FAbNTnPpUl?=
 =?us-ascii?Q?FbYFB1qxGOKy6jB8nGWxMA2aGH/ABxe4DOJlVZ6sW+LiKHaDHU8Q1m/fOIVN?=
 =?us-ascii?Q?iZAMvp8Nr8scAnJwbND5kgs9dw9U1cptvmGd7rDF7m9e54fBrpqR4pekc2eM?=
 =?us-ascii?Q?qPke8U1zlhb7hJQNSPWLK09wSyb5bpeCdy5H6PX725XCHzlFBtQUey+43PU9?=
 =?us-ascii?Q?OTWuqS4ZGsK1LMTASv4QL336vNhd3KC72qV0lkzRn+SSE21h4puOLgptwBNy?=
 =?us-ascii?Q?NP6pQ2cGaISlD5AieFpZZvlKI6ufchhErq56U1o2njVodofPS9QHtLvCFTIY?=
 =?us-ascii?Q?BFciSfSCvSmiopAYur3fJXZ/J0SkKWtkZn846Q7lWIeDOYUf2Z+nLtNPZEr2?=
 =?us-ascii?Q?XhTmyiGCbgigvfDTFMcbNmBQeiqKV4swDGiGFs2u8Ip6uOSMXIrqRk4USbcV?=
 =?us-ascii?Q?0vHVDyLlWF1s0XuOMd0huqh/mW3eW1b+w6rwC7qnxPTqFl2OK2yqAJqS7RIY?=
 =?us-ascii?Q?g8fPVT8xafvPLswVYuJ08eJb2yie8BJr9tqILl/hSWGuY/gicH8fOOTJYAm2?=
 =?us-ascii?Q?j+ZmnIvgpqBxTq0k902k+VMF/qEjoGCaSQt6AfxMge+vqti54A7m/OyJm7DW?=
 =?us-ascii?Q?ktioGDvjqdbaR7GabWtoEPn9zLO4ZDN7U6DAXDStdGGGd6/Xg9DXmU32fHWG?=
 =?us-ascii?Q?mLvokLE7h++Jm4RuS2nYnPscR1a2nYaBcCPmtIU8dOw5cr/txf2XiOOFfgFp?=
 =?us-ascii?Q?t7PZOpCYBzXwYlZUw9bd4I7Tb29zHad1ymDBR5ppXCSdJVjdba+fnTYdAZHo?=
 =?us-ascii?Q?9uMSBtMzPm0X0xDey8U0DM33e+pNEmRNsE+w5/XARX+krHRSNXZTnqZzCrW8?=
 =?us-ascii?Q?L9vofriuTY4OKJheaCty0F1tvfCsGKYJGAGCJTJqcy7YfFzEY6PrISUwFWoE?=
 =?us-ascii?Q?WPVqpOZZ5XIaQZOURPVhgpAnG03TsVZFc8a2KT3o4zL+e7fLHCgevZHzU4zN?=
 =?us-ascii?Q?nW+M7PDjBD7Yqasp1Pt4Y9pahK6bemQMwZNe1XPzF6LsHYndXUjAmjU+54/C?=
 =?us-ascii?Q?9Y2bPpgKpW2v4un+aefyuxG7wrB1vu/QVDxa/iQa5ERsTwyquJp5GoE9ei1R?=
 =?us-ascii?Q?3GFbksWs1Baz0jY+yKEIH4PadphgHAZO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQ0dV7HkhVsW+atDsXikHEpmdnEPZDIvV+78yOYBoyQeQCiQeB9x3gDH0QyR?=
 =?us-ascii?Q?BPHXpH8jS8jHnXwIBXVmx71H9yeTv3/idDnG+MrjwNCM8y5rglPUGj3wzO3g?=
 =?us-ascii?Q?pLt50snLND8z2Toy6qKGDzJplmfCP+QelOf+eR3wpLikBUpHZEv1eWV8f2Y+?=
 =?us-ascii?Q?o4V+/nP/82yQ1juHr7Kxi4eR4Atw6F6hBOZgc/9RRP5ZI1tnObf4+cZWiMg4?=
 =?us-ascii?Q?HkMizPiZ4iLLpehxkz9/A2DgH9jSOE7WO1AjcPoZJqFMkHG2ycDHSJ+gE/0D?=
 =?us-ascii?Q?pIt8QlGZUAGvHpyZKBfNalPM6J7jQDpiCxuozuTXwf3VXAyYW/N7kpJRqnDy?=
 =?us-ascii?Q?/I2iGdINPjqv2oA/55MjmW7ujyBnuyUWGa8No5zgxDbt+LiiiSBCzY7uVl72?=
 =?us-ascii?Q?gU0zOqDcuJUnRuK3dJzliz1VUFXLtd/iQ6NyhlCIV1HFaC/4jczQSWsbZNPu?=
 =?us-ascii?Q?hsrFrQZpguxo4VsT6ESDanaKZ4acZZ5WNDD3i156MXv7VxeHxHjZOpTwcV4g?=
 =?us-ascii?Q?Mj33pDCeU5KzUQ7Zp7oCZFFUDvJCyu569O1MXEW+esz8kN9OWnYSTycxrcBQ?=
 =?us-ascii?Q?UrGh2tLjkRaBhG2zfhientQflXvyp01uiPOWYr2V1i0kQG1QIHvoWl+YQOTZ?=
 =?us-ascii?Q?cbfxOUcTliwCOE+R5HqKxiNneXnAp7Ec76h0CeUl9My0nJEUzo+tO90zfr/c?=
 =?us-ascii?Q?5hAmptztI6B/BwgvVHDNeCYlUkqCGBSCRzQDfluJL9ghd4ZPfxA0piDTnJbY?=
 =?us-ascii?Q?KiuDig29YBf6IdUDWJxhHIGA2yVfB5KwjtymqnqjIhADVizbGpUYVMnJRqEI?=
 =?us-ascii?Q?J2FRQm7S6dzB3fAhx5Sbk132cs4zyrZMTfL3c8mWmbh3PrqtyJ4nt1uqDDV+?=
 =?us-ascii?Q?4dRbfVYsAU/jT8BZeqLXdKRq9k5xEK31ffT8iyXCoHzczB0jubAuljC6ZbgH?=
 =?us-ascii?Q?UyTLICvPy64tuyJD4SfytA+lgbsUgtB9sU66mmbCwgq/UDewFjTcgBBXLIvv?=
 =?us-ascii?Q?/slJW+36qA6WA+lbs2jtDXCE2aoQ3rzAaWn6sXk3CeoZUKAzYje+jJ5+m22J?=
 =?us-ascii?Q?gWw6fLaoMdkHDnNJmlz1efOFbhj1KIzbK5/n8+8XCRsRE3s5P6HMMhT7b7Rb?=
 =?us-ascii?Q?glaNvO5r0RSLIoYF2qR9tDHOAcV9wgHvzjLuDVwyuGnX8N2BNVRHGeJk6SHD?=
 =?us-ascii?Q?VD/L5jefWVx/3pRN3qhczBtSPq0jQ8xPwh0hImW4UvgYe/1VBDkhacXRqfu1?=
 =?us-ascii?Q?/0PgVpanqX9D0Vjk6Gk/QFvy7cjvxaClqMHmm4uTB210i5s8PSU4cuPcFPfp?=
 =?us-ascii?Q?L8mwJNI1RY2msbHY2at5xADZxHGfPrdxJRc6AOMsbq1c9XOf4sPyDMjx4Ler?=
 =?us-ascii?Q?2svpExRma/a8x26JnSGxkVkBflRyUO4hEnGt98QqWOYywWb2AVX5cSm24XYi?=
 =?us-ascii?Q?A9f7mZRDmRvh1xaclKQVRfVl/brr8XZisFrjAcDH3DY6pxWT0UjpcYTMYHY2?=
 =?us-ascii?Q?AtPLLUd0o9iW1M71sqVnvvznjrYsS4Jnu3Iggd0jO7K80tboEtOVEbdtSjOu?=
 =?us-ascii?Q?CICahdQ8suo3oog/ZGDVVxDHYYKU0w2DAAOIKqyS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BtZZi1SUgvndBdmHyY/l5qOF337RlLpAI+4qCOXF+IdPwI6+WRDwKsnhCX4kJe+hWGzD5OUkLOglUxFRUMMGQoo0g/+A17hQrHHkzyq3TT/QNBtzfYZ9Vqlh2eMfRDNW3AVt1nywHHEYAHL0Z6DRLmV0gQUu66LrltPqp+l9vFoQVlALx+jG/zb7nJyutw1OPFkVxJMDQUEIA1ivKoqXfMfv/fEI+ckXZhhn6h4JvG12aMgVY8+DYotAQCQhctRH+S1C1yvtNURcjy5mt8tVUEDO+V24b6yeSPZw3OMNwhEpdG8juw4UQqWNrYTmdioVXkKZ+PoMZw1mXwWIuL0qqltuBN4HhYyZkYkPARwZyZqIGCQK4l9nV3ip5oz1CWhYpJ8PTYRdbjMMXsgkcH/Yty/+eivhP6FGQy/QkK3/7SqT3H8Zke8Ga0XMhTrI1Pr4hABejE/nvaE6OV4QbwRUeuooumSopbJ+8UHifNAv7+whNBNs1EEh8itUiLHsZJTtR0NYzjx8yHSciYKmlaYc9eZ33+PIXoSZF2QI+6w1UuLIb6UJc9X1ntsLhZDM1aPsOmYWtCw3FiiIo2oHt9IPihaOGXpbJjfbvOvlW7xrG7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bab498e-01ef-457e-0a19-08de1047dc4c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 02:16:35.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scY3ovIhY5gICKUl6o0vumYzyIc2ih5x2aVl+H32PArJ3YGx8S5tcDtCpi3cO4+sCJfX0i5fEv2pyy1vmUT2DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=964 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210017
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX2EPjfednJ/5s
 6BQh+j0cHP8BcrdAmvHsYAt0biSOLpVs5MgL4QOt8IiIUlExPtO1t7Fy6oqKteCgLedVH1PzlJX
 XrjF7tAx+ppRlHAiSKAM4y9AnivBH9RA2NjRZMUGqE+lJqG7ZC56fRS3hPhohJB0IAq2rCTuSow
 lqZfZCyCTroRNWy7+pFvFaPmVirUFcZxa8ZrKfuMKUEa/A2r4t2XimlnrsrFOpOB65pAZbPlaDH
 V6C3RaMtOBc3ZxtSOuMqJSP95yed0xgzZID/1V6NzSI0xw0UBt4qCKW8Lzqdp3Xo6N0JID5fHe5
 QzSJtw2qghBPDe2NA3fD8DNw6hjCel02WkBsOqPSLnUq6g+qbVf3w0s7wu8e4j2S7dumLxpxC4m
 O6HO5HszpoaYvOlHUHQtM7t56rHhvA==
X-Proofpoint-GUID: Lh-HmxFQQUuaXIE1_ENDtC2cCv82qjHf
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f6ed07 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=4osiln6yPbGtAIqfufkA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Lh-HmxFQQUuaXIE1_ENDtC2cCv82qjHf

On Tue, Oct 21, 2025 at 09:03:53AM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> If two competing threads enter alloc_slab_obj_exts() and one of them
> fails to allocate the object extension vector, it might override the
> valid slab->obj_exts allocated by the other thread with
> OBJEXTS_ALLOC_FAIL. This will cause the thread that lost this race and
> expects a valid pointer to dereference a NULL pointer later on.
> 
> Update slab->obj_exts atomically using cmpxchg() to avoid
> slab->obj_exts overrides by racing threads.
> 
> Thanks for Vlastimil and Suren's help with debugging.
> 
> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v3: According to Suren's suggestion, simplify the commit message and the code comments.
>     Thanks for Suren.
> 
> v2: Incorporate handling for the scenario where, if mark_failed_objexts_alloc wins the race,
>     the other process (that previously succeeded in allocation) will lose the race, based on Suren's suggestion.
>     Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
> ---

Looks good to me, thanks for fixing this!

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

