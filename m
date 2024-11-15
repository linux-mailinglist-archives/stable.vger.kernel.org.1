Return-Path: <stable+bounces-93477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5758C9CDA17
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CB3281D79
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F6188A0E;
	Fri, 15 Nov 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXK+ELo4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aKy3VDtI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8518871E
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657167; cv=fail; b=WKSsfalZZIit9KVgbCkrK7WOJOuOlT4kb49Q8fTKbFzrd9nbfh9wzjJTazq30I4VxWsFzwgbzebPFYL5N+dD32qXmqPZYM/6XGBMaxPgCMAaCjMiF0ThLgoK9gZ3XE/upMN07LJ/TnMUpKEX37tlWzdZaJJM215aATdrpcvw21c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657167; c=relaxed/simple;
	bh=98ncAhtmhJ8sjSuXxb1wJt6xjRGkO7eDImpLktXO4rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=icJL4YL4PG6VxwVovDm0lD/SDb45Ujorg6yQw/oJIvzNhE762bRuCKpT5OXgHMZaPfqbdxbKLp/Vqa9FrZ+5nNBbfsIXiJy2TsiuH0zCcGpNbDfxKzVDGZiwL4RiIDQIHYQWAR+tY3f1rWsDSJSZbOY+WxFN/P2latk3qt3a0DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fXK+ELo4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aKy3VDtI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF7cq9i003438;
	Fri, 15 Nov 2024 07:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vhXg/Im+hZVrC7BUMj
	t0hSGaAIxJDjOzMN3qBeMM0S8=; b=fXK+ELo4mAitoGX7OUbmztUo93vwziBItZ
	DmB5f5iRArZix7SjJ6KlLKtrqnQzN+dz5mN7clJ4eeBR7RfO9Q3/IunuNj0sq5Dg
	nYPBIicjAvrrb8lYExaL3RUzMKcn064rvV6zjX1dSQ+vQnzloscUrQfW+26vl34c
	ryB6sSh1bU7HC1n2H+/nlVt9SfsLtHt6+nS7wO68ZpMa9kF/1mJvHPYB+goXJj7S
	zSZsJ2yc2shaNNJJlQbYTBB0LWG+x+3ZqRXNA39OXH7+4sopDrrPqDPz7PEAyHJi
	rVdp63PoSeDyx3clZ1HNjZCv+HqEqleGt+SgYytSYH4DSIOxOelA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2av8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 07:52:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF61NqO025897;
	Fri, 15 Nov 2024 07:52:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bwc78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 07:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUiFM1c9wIQIgnAgqROs1Vj+pqdV91kMCYybxSCLuIWGxl3xCFz6B/cqz+cQeWswie4PqyfDst6QagTd2WXlnnqXceMwDOTKGinaA/pwqwy985Ni6EuZaARyT2a6cdTGs2RtS5XspxVI5Y8OfpQlf2QoZP4S3cSxB9TIgAY240uIiVJqXJ4vOfsh0mXxhD5vW9HoNGpwGTo6o1TRcVGgIuveOz+V8HN7ZrKO7LGyh/73tvPmAlBBVXfkrOP2gRWGYnJEz+IBPIWdtMW1CDFYKK6GW7+HGcutou3CaBmCnP8nWL3VK4L3BR+hQhwtxZYKwVf5DgCZFc1eqX/1Nxn33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhXg/Im+hZVrC7BUMjt0hSGaAIxJDjOzMN3qBeMM0S8=;
 b=GyGYlbD12LZHDADtFLrPN3Yr4z8zIY0uVtGMcjjBq28jZ9Ko7/naqDr/ubLrm7ydcDuMeoVMRWTeM+2bBn/I34ZmhUMpqrOoq/+oZoE13bHlGf5In7q0tB7sCGXPpDz/CxXMeCR0F1/vJlRKeCc904DhfVxY/uGkJHGX8He66VQslBwm76Rv4msH9nFLUU/6+Yc88DDiJdozmucT2TkZrOKbQ5/PbRHL3hgNxzaPGnFtdOrXpaGrsAMk9YDsA44z51jrb0KGbs4mZk9gd4gRzXCbuXlaHpElQrqY6am983HpI6mDViftwyIxc+ETmUQJ7GWfpyrnmuUMt4Cint/uaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhXg/Im+hZVrC7BUMjt0hSGaAIxJDjOzMN3qBeMM0S8=;
 b=aKy3VDtINzN2xf3nEtleJJzIGn8Oie3BvxNkOwm/80GwAtiLXkL0olKluMKMeePVdA3SmntpyN4f2ijQQTgcLwCzzX/RDcOXxbw+sY9scp/RtZU3VqS2GHY88IVCblBf38adfzz+yba3QbbC6bQMxUo7PT57s9tIvVE7ida9j3k=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 07:52:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 07:52:33 +0000
Date: Fri, 15 Nov 2024 07:52:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.6.y] mm: refactor map_deny_write_exec()
Message-ID: <bb420574-76ab-430e-838f-18690196b175@lucifer.local>
References: <2024111110-dubbed-hydration-c1be@gregkh>
 <20241114183615.849150-1-lorenzo.stoakes@oracle.com>
 <2024111540-vegan-discard-a481@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111540-vegan-discard-a481@gregkh>
X-ClientProxiedBy: LO4P123CA0313.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cd50ea-7b0e-400d-2b5c-08dd054a768a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mz4sRcyoYxD7bJB67dwv8vgnHPtKb7Wxx0rcgv+tMBsniqYxnDsCbGecwH3+?=
 =?us-ascii?Q?ryHyow1sjK2lUIRraILhNOjvdxPZ6smrDs1ghjbR6r9tv8szDmTPakMRZDLH?=
 =?us-ascii?Q?mOvkWMSY1LBZ1qj7ZaMFMHrAtE4NZ61WcMZuxDssNEf3Ko5WDF+YBvXH7yz2?=
 =?us-ascii?Q?SSeHoT+V/qnx+GcKVaOWHeiVdtwPyyEryWJS3/Kvked4wsxQqTiA0upYcIey?=
 =?us-ascii?Q?2zZITDr0hHicFgxA3PozdW5bHzGGV9L5OcB93Ocd9tewjqlQg8Yd6q7bS824?=
 =?us-ascii?Q?KGQqbX7qJ9RKxrC5k2mrpXwrDJY3khJ7pfshsj8w+S6OiSJJkfxcTFATFXQ2?=
 =?us-ascii?Q?zW951d1WvT9vdqG0Qe9d1IGG3odJkD1b/kJlUROA9e5oRZ+zBkmhAHfeMo0T?=
 =?us-ascii?Q?o9xa1SkQesQ0xIWAR+IiciKMfviurUpqeMppe8S5TKHsYMv+8YbaaPDvXC2B?=
 =?us-ascii?Q?TjB4nohFAyCt5zwYYe8cyUV6Du8ieDLkgyZLcj7zJzsYnQMQ853Sg8/skJRh?=
 =?us-ascii?Q?GRpuzZMZREXFv542+slQ8ZudW90fekL4WYyCs4whcTUXpZOvi4gGnljmaBQN?=
 =?us-ascii?Q?3ROr+SiEyu2FUJv3YwIrqqe7KSL9v6JRGKUSp033kLhEuwIpJeezRIKHNAA6?=
 =?us-ascii?Q?kU29QWw+mG8q77SWL61Fq/11wZDiJdEebBJjMGjKKAxCu5y1yX5HS6gqvPj7?=
 =?us-ascii?Q?lQZ3O90jZ5Lz3te2uSSf9i6JPfjZ77GFw7sL9t4Km1b62wsMA+xqd6u5zLYl?=
 =?us-ascii?Q?p+OXwcYppds54kaYM08Ra0WdQHvv4zV2Lp+0Bd5n4pfPpGOXXZLNHf6uC4zF?=
 =?us-ascii?Q?2+BRmATE0VHEVj2kWFfp28lJoPcYw+V1TmDQQhNjOy4/Hu0tA8gqL4zQrWQ7?=
 =?us-ascii?Q?jbqm5zUUQ0Ggr1XMPlV+GBtQ9yR9pyrQFD2ojF5bvsqqb2RJ83o/sgQ7q0gI?=
 =?us-ascii?Q?soGwoqCn6M00UGFM1k6aN8aCguUrwrPZHc501zU4QcwANHz/Gy1Q33nhRwZW?=
 =?us-ascii?Q?MqGidPxor2ky47QQDI099GxLldFaNt6HuMaRd0RmdW76f+nTh9bWo4kE93gy?=
 =?us-ascii?Q?GQ06UGlJjqzBqev/iA5nscTlva54qoVWnnxilQN53CY1dS1fpH6/0MF0MZJm?=
 =?us-ascii?Q?Bn93F9yMc5fJEFTdKElr27LboavyenBOybWz2vSnmRfhU57+1+gcu7nP9MlY?=
 =?us-ascii?Q?sFsGbU/HCOKyY8LZpgrNTZjXhnnKd93mHabLveG+RDoVJ9T72r4iCxNuZeA7?=
 =?us-ascii?Q?dPOy/0EuzGfNosFtU3txfjLkCuqBo+zAmVmn5sj+D/vQyo2gypCZbIyr7j+l?=
 =?us-ascii?Q?/qfm1qVpOR7PjI45xKsT2lcJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kT55GDFjjJMurCaMMAgH3/bezd383IrfYlGuNLH/rAuwloMTP8L4d/KBGT5z?=
 =?us-ascii?Q?y5xNeIOLBElVNlu99kxqkdukMezIXVkpyE1Ii1TLxQVyRCUgui8EivHT4Nbo?=
 =?us-ascii?Q?GepvWZw1Os9+xphQ/jn9ZwseVCUlgSQ6Sg2yni/s0OORa27ArIijLSSnmGs+?=
 =?us-ascii?Q?/o4/5jp1zItiuYE2ZYc3H9bYsKQeerjj3eol/Yi5ppCRxu575UIZHvgbNfkP?=
 =?us-ascii?Q?9tPEkRNaTKR7geGLNBwjS15vzdRehhn+OkWGR0Jt5nvca0CXVwaRXLumAw4E?=
 =?us-ascii?Q?ukkcjICQYhufKHrF16cyk4m1TTV8D3szEowqMcjcwflVg9hesALgsZ6TAbvQ?=
 =?us-ascii?Q?SkicGIE58ylqhg6oEE0W5rXAQLVIy4Uj2srGXcjXWENOaRY7BXkE5GopOAHv?=
 =?us-ascii?Q?ELGt5jfdN/jfkR2ss6RfarGLMK1EtCKysgZ5+DoTYZDPeUEYVwaNCP3z95yn?=
 =?us-ascii?Q?4J4NnpVM2T/MZh5pcR9HDDCIZHYDwPkJjPaoI4NSLi5J0m/nFCJIKk8Lo80N?=
 =?us-ascii?Q?oiv97g0FOOdxwfxYJeYD/+Fk2T88Nt+2gxP1DvNHam1y8+nCOX430+cIjvaL?=
 =?us-ascii?Q?+qhdO4BkrE/KXHOYC8aOrmjGHITWAri4H2SZlBdLztjrwjmJHFAAYSfA9PgH?=
 =?us-ascii?Q?YSUUFQycSjHQtBtG6z6senhq5e6RFHzsor0nIj9H3wfLjyqMLLbqVsDZQzGu?=
 =?us-ascii?Q?nTw95WGXP0redt4KDijd33iNVQvC08jcK3tg+l6Tz+OM0pU5OiWUJwpiCv0R?=
 =?us-ascii?Q?CsrhUOIVsXN4SJDg0fJn10fizcCWFZK05vGPPoSnCtGVpTv7lktaSNi5ifs1?=
 =?us-ascii?Q?YO+NoqiF5fAIbv/EzfYOL9V6kzi30xBqbJTR7HDflndFLIXaB9Hk7MBNB7pc?=
 =?us-ascii?Q?tAA5tygQLW+LH6g3m/6JMebRk4/j/qzwMD3iS0jwLKKNqTHB44rHevqP/KJk?=
 =?us-ascii?Q?Y+JqjwSmQvVxr6fVrSXYP9iAoBgNlSdxqxlMmqtV+CWa1cjMVbpAHlp9N8tY?=
 =?us-ascii?Q?TTHv2SUHmhASLs0Pzuh41TwR0B5idWy+yd+cPZpGOhBd2UpmGTKI6gRH54pd?=
 =?us-ascii?Q?Zo385VVmW5Xd6XKD1qJNHqh5mkuJw8pDQVUMtyK6HPuqpY7ksR+0/tBJCpw5?=
 =?us-ascii?Q?5W5JU89ChflEQ6/5zOzOzM2AXLdeBQ8Bba3snu0bhydGxl4cOJGIZ2DXuO8F?=
 =?us-ascii?Q?Gs4MwaoFpd9KI/bQ9KKb/bO0JQOTaIjrHlgvPe4DSjvMFpf9P0Z3ZOakj3Vw?=
 =?us-ascii?Q?RzohLfR7zQYUMJCgytlmlC5Gfu6DDECOcCJ30BQAofuavH3pnmTrr4i5XfrR?=
 =?us-ascii?Q?r6o3BSktz/OsJ1+5NUNreq7MgJ6qiYk0V72muKFhTHAflXJLYhMw1tyzvHzp?=
 =?us-ascii?Q?iR+4hvE6On6dMqlNi0IwgDQggViWIFlSj25/U0nBdoM0PJuwiL5urpFJ/gQ6?=
 =?us-ascii?Q?uMfh1S1lzlUR6p3KsTVVghtRXX6pfNC92TyrZIpiXWM6aW9JB1EywvZVuKsQ?=
 =?us-ascii?Q?KkqKgAyMjBGxO7t/QHnwhTZ5RGz97ENwouKxy8mFzcRWyEoLsNgqMtBS09xb?=
 =?us-ascii?Q?FlrKUKOaiySx42J1gkMfRF+0khetKhc+0KOj7//WtGq68DyctQ9zpIi70HnY?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jLkz31v4jlH4l0LP18cBRNX62TI4AdpXaBTUaMVuicMjlByEBt7NRmuWqRS3NTq9ZltsBVPnjblAA9urNzalY5fM+CCADP/SPi5Cy8cgTvcw4sqZFHAFd0T80l4dJMTN09XHI6QOCwDty2bHQAQphMApBib0JQHlZkLGdxm0CPaT5I4ktQZub1uQ307yz77poB13jTUHQx0aDWvkM/CV/19lU83iTRbcom2toJkbOkOZJuDEssSSVWmVNxQJoIDQNFCX8eXUNfaTCFH87Z4uLOMzt7lXlQMlvWkeP9PqOfybmoJET4VhJuZ7O2981XoFZ6zmsqYwziXfYnkpsiQhz7wQyK0SHluDhkn3nDAY+h+nGqRAsnN2aVyvhTnmDx14SxVFEtQ5iUA08DIRpvkEyQWe/i2RpEAlaeeOgMVx6WrTVYq4AjjiyP5UprhOAOzeLkx6Y6yNw6+btagZ/7d8bXXwsHKedHrryRc629JmBrj703zV3kQcn+4RdP/zfpMBZFSA+tske+pa9rSL2GvQ6mb3g5l2fAGxqBxucz4c1UBcK27VCKvmYGGR2NrRF1QK0VaKmeQUe1NtFGXfj5EvFOn7Jadpi440bWMMF3dz+7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cd50ea-7b0e-400d-2b5c-08dd054a768a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 07:52:33.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X18urdMoxYGzaKGmAoWrkEIs6zeb5z4g8KtndK4X2GHQN/Gm7s+LPbuR7wkOiRMXiMAZehjSgVSCA8uQCthqf2xqobWiYeqBlWJAIULnp/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150065
X-Proofpoint-ORIG-GUID: XCyZ7Su2_IlvXkJk--PJMOw2d9uXTPer
X-Proofpoint-GUID: XCyZ7Su2_IlvXkJk--PJMOw2d9uXTPer

On Fri, Nov 15, 2024 at 05:02:29AM +0100, Greg KH wrote:
> On Thu, Nov 14, 2024 at 06:36:15PM +0000, Lorenzo Stoakes wrote:
> > Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> > parameter but rather to accept VMA flags parameters, which allows us to use
> > this function early in mmap_region() in a subsequent commit.
> >
> > While we're here, we refactor the function to be more readable and add some
> > additional documentation.
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mman.h | 21 ++++++++++++++++++---
> >  mm/mmap.c            |  2 +-
> >  mm/mprotect.c        |  2 +-
> >  3 files changed, 20 insertions(+), 5 deletions(-)
>
> There's no clue here as to what the upstream git id is :(

It's in-reply-to a mail that literally contains the upstream git id,
following the instructions you explicitly gave.

>
> Also, you sent lots of patches for each branch, but not as a series, so
> we have no idea what order these go in :(

I did wonder how you'd sort out ordering, but again, I was following your
explicit instructions.

>
> Can you resend all of these, with the upstream git id in it, and as a
> patch series, so we know to apply them correctly?

I'll do this, but... I do have to say, Greg, each of these patches are in
reply to a mail stating something like, for instance this one:

	The patch below does not apply to the 6.6-stable tree.
	If someone wants it applied there, or to any other stable or longterm
	tree, then please email the backport, including the original git commit
	id to <stable@vger.kernel.org>.

(I note the above hand waves mention of including original git commit, but
it's unwise to then immediately list explicit commands none of which
mention this...)

	To reproduce the conflict and resubmit, you may use the following commands:

	git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
	git checkout FETCH_HEAD
	git cherry-pick -x 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf
	# <resolve conflicts, build, test, etc.>
	git commit -s
	git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111110-dubbed-hydration-c1be@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Might I politely suggest changing this or no longer telling people a series
of commands to follow that result in 'please redo everything over again'?

Something like prefixing this with 'IF YOU NEED ONLY FIXUP A SINGLE COMMIT
YOU CAN DO THE FOLLOWING:'?

Because right now it reads as 'you _must_ follow these instructions' to
resolve the issue.

>
> thanks,
>
> greg k-h

A side note but... I didn't actually want to do these backports this way
(as per our conversation prior to submission of original series), but my
upstream patches got changed to cc: stable @ vger.kernel.org which
triggered the bots, and is why I tried the follow these instructions.

I would otherwise have sent these as series in the first instance. But
c'est la vie. Murphy's law dictated this series of events happen instead :(

Thanks, Lorenzo

