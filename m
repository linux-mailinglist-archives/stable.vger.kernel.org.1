Return-Path: <stable+bounces-83487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD599AABA
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D31F22D1F
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D593519F12A;
	Fri, 11 Oct 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hql49Skf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SzKU7FeR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF674195811;
	Fri, 11 Oct 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669345; cv=fail; b=SLx/y0ixuhvfu4J1rsQu+7WMPjbgVAi6B54ixNJ/h7id8k9rmiffCM4NpUW9HpIxzcO+MvjLJyXgJPilrxW6iIF8QsWU6DGRaIyVDCY4POAphpRRknVi7uy5ApH8Z5fSUaFnbz07SpmHNRHA4fq5GBHykaVC7cljHX6Q3wzvU7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669345; c=relaxed/simple;
	bh=9B4JiE/woO5R/oufibGMvl/iRQ0EFup5mvAOo+/oIcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1DA7ROn9o/6uDyIA1SG3tKbUaVbkHE/GZe+S/YO2sOHwyizFykfaCF7X63vbPyryThad5rAobXtNmjui+tO0DDdGkfL0keYCCsuRSLWl47np1wLBfMefd5oi4yFiM8PLoq2XswB/3n/1uStvTT0Kjg7ilShXnCvLN1TG6yTVuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hql49Skf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SzKU7FeR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpY5o029765;
	Fri, 11 Oct 2024 17:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2hV94Aq6zIkJRAWODq
	ApksSAsMOHsv2mxIv7L4RwhBI=; b=Hql49SkfVz8Xj3Pz2g/Vq/otuVC8x5hAkp
	KTIUGyVDYQ63ZmAQvHDFrmZZNVqDcUsAaErurkQQd7KedP/8XbdosW+7ZzTVx4xM
	iD1mscJw/EcEglcFNyqd2Q4zHcduZnzuxobQ6fMweZYatUaOfl4pNaEqu1Eo/a43
	JtKYY8ZB7DbvS6TYZNKvg6Y1lO+jZFeZjBFwpISR2MZ16HANuMa7N31Dol3vy1LI
	gcga3O25qWv+MpACMonVivJt97TEaDzYi6jR7NxZo7o18PAgIuyWJiklV8QhmasY
	tdUP0YeQxZ16/+fdHrfMfJcdH1PjkwFkNgW2Zp3x9TUt/cPVcZVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwh81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 17:54:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BG9b93033314;
	Fri, 11 Oct 2024 17:54:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbjfg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 17:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W63tj6UmJ5KhIIEqoNlGc6lYF/lKMLbegEGMm3FIMAA9nlSHNGRJEWeGepQcF31lwOTfSQLnM3Go2VWqrSqTRE7zPrZIDUNGg8gawo3bFFUEmfZ03UKM8yGs17gl1C1d//o9jay0YV2WesP+EAQjbOGdHJQysxp5+uDwRhbbfUA/i/eFc/umBOyS3BvCQvdbHQY0k/zhnn/bDQZ4AxFQsP5+A9cRDn27Bcqkji8UBrSEZ+kbNXbPmzgZaYN61aavhUBYaj0lFUhsVs66Rc+0oFghmtDydyUv/KFInOAlhrwyL0UPtnwNTjKPnAMuHRQS97orZV9k0taYqpT9QTvtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hV94Aq6zIkJRAWODqApksSAsMOHsv2mxIv7L4RwhBI=;
 b=CynzgdaCZ9pt1a0zexox0xDFMitTp0ElpgifkNGUE5H0g/v2q5ScsIYiW34E8e/ARUQ/77LoCKXpvbgdpTb/kGBp8d8vPnF0jqXZFVIwWuHfpv0B9IlmHQfpdgS1Ep0DPoEVnIUVL1Wh3MwmMA7T5MvRSGFG6YW1WRDp5TFtrQY1UbBRDmk/zFj1xYSE0psRY3R2a0EXc5zz8+NK702tphYKg8ItZwcCkJOtImWMJbht/5Cfztk4cTKJs0OYj0MUvIhpxdGkD5O0nR6wnG3uwCAhpQ1IiiW45nagXxfZ8kahfS2bw94RUvzoVw/zFFkRd0RG+Ny2FF0Wk3WnBMOV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hV94Aq6zIkJRAWODqApksSAsMOHsv2mxIv7L4RwhBI=;
 b=SzKU7FeRPQ/CUo4kg0NSPClBzPst7/IhWLKPJAfBCs0hBvLautXy2He3E/XYZVXuJcSYBMrqSnFc5IHiTCVa8tywVA2x/XfI7T6tijGm+EkNGovePzOHsi+/TqqIX71FSmHrZ57CTVELMzjJIZN7ocPUhKPP8PBeDEMNWg4BeMU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM6PR10MB4396.namprd10.prod.outlook.com (2603:10b6:5:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 17:54:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 17:54:53 +0000
Date: Fri, 11 Oct 2024 13:54:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Helge Deller <deller@gmx.de>, Ben Hutchings <ben@decadent.org.uk>,
        Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RFC v2] mm: Enforce the stack gap when changing
 inaccessible VMAs
Message-ID: <dantzkqu2pyeypcbljes6omc2wuyqjguhgd4lcrk2tijfyyd2g@fx46a4mynnsh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Helge Deller <deller@gmx.de>, 
	Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@surriel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241011-stack-gap-inaccessible-v2-1-111b6a0ee2cb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-stack-gap-inaccessible-v2-1-111b6a0ee2cb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM6PR10MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: abac1a21-d1c3-4a49-a7c0-08dcea1dcf8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JqlpkjwqeP31/HLdCijO0UZxdYTfKGQAwi1oqvlYUhmgYhC9fqXfXo9vf1ng?=
 =?us-ascii?Q?897NqqnSH7nFDh8cPG/k5lGPHgBo2QdLO8tV8ZWqrvViKJmJ/iJBQw0bN07k?=
 =?us-ascii?Q?d95dAvwr6EGWvgFVY8vsQExWliMtgpZyf86ytxBlNwDyiHT6yMN1DHS8hqQE?=
 =?us-ascii?Q?9YuP0MYaYRg0YtpNKLd5QHLDp88v9wzGnHAfFvDJ/LlrDIpWRGPM7wtdpKZp?=
 =?us-ascii?Q?rxbdEzgQIK1pkx/283ZaMO3pIAze1Izq57thyKc7NrXLr/7uGeNfHVI/+v+L?=
 =?us-ascii?Q?w8Gb47d2+k6ddH3UPIBK069xhVxf6BwBw74iM5isq3+UulMPc/oOltRjvZhe?=
 =?us-ascii?Q?6VgVfIRIa34GeQxStsMPwhbs5IosV/PyBFrVzqDwvK/4VPQr5uyfbfPOn2dn?=
 =?us-ascii?Q?jTfvHcRxG9AX3y1N8A+VWSWmF++EJ3nu9X61A55xLINJCg+99FN39C6PRg+t?=
 =?us-ascii?Q?rqMWxSU79VyoTZikl/ZsrQch/RL5MkUjswboA6Vw2R8c1P342Mx3gFqhD/Ki?=
 =?us-ascii?Q?Lv2qsuB2ByvpPSRYub61W6t/oruFVC9z3LadtVUAyBoVP/4Uv0sBSWJ4hO0u?=
 =?us-ascii?Q?O7miya5brrEJwl5QkEZfC7FhutuiJ61PaW1ItUgWglS3ZNjMy9C4R9nI+QjN?=
 =?us-ascii?Q?LB40uZPd8q9D0R2UNSsxWgfXMPAVaa2+eJYgtiEIVsVHc6HubUvagKzoaYxw?=
 =?us-ascii?Q?zByf2BtXnJztnu+zssUtgcctXRyiySEzouomWUAWNjx6RMMDaMO3qtiZa2j5?=
 =?us-ascii?Q?/eKhiwu315EEYuGaOYhRChS+uA4+xVKLmFhjZ4D2iuHEe0pPe/Nv9nVQPT8f?=
 =?us-ascii?Q?BfIXG5jpeay9ydJDJgqYskjdxvjaZw3WKs5QtFFJ1/wwa3R7wTWBDTy7oeDS?=
 =?us-ascii?Q?KhFJ8tPPJRJpHsgGqpptkFeQYkJ/lyqZITS984L3S5sZCvjl6qshxXhomvkn?=
 =?us-ascii?Q?vABGvqHSD3hywmTZNDC/f5ljwMQSqFZGmagQcTgoeBmpR2QniSMLBGyXuh7I?=
 =?us-ascii?Q?opkrGvy3Ol8MFIlyr0k17MvoIZf1wQele4g22ehDJ5yIm3MvsPCvoDXF6F16?=
 =?us-ascii?Q?8Gggsyiz7DRbDBRcgfSRoVl8MSOh4rwzbQ9nfeSdPhW4MdB/8NmIAUscUYwh?=
 =?us-ascii?Q?rOHJ7GZOB0ZhZfYbVo8lHqt4LLTzQgFex9AQhcwVWMniHK0ROyb84qOgg09z?=
 =?us-ascii?Q?wh/wPjDlfToa5xMinROqDexVNb53bQeDvi5NiBJTxdwk/ff0NnOU3Kd1up0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvVBbIK+QBHun8xeYp87rdcqyECBhN3KHygPx4P52mq4zfVxSWDc/XkASxbd?=
 =?us-ascii?Q?YAUVg36TFm8C+9qJl2Ye4qUr/AUVIPqgJyVh9QKFbU4mWD1hCC1zktsoF+WF?=
 =?us-ascii?Q?ocp0M3XrB3dL8jD4ymBiHcUURZVV1nR3zfOby3fNaYLh8xafRRCATBpzAQqr?=
 =?us-ascii?Q?Gpn0H2vo+qQXZ97YMApJl/U8pl1B7T8HCD7PQH2B2qiOg/LBWjBekpFxKgjA?=
 =?us-ascii?Q?mCt0dkvDTkDZ7e1km8XddxkQ2WvVHUauuBxe53oQi+sq038CZ8BWiBUlkisV?=
 =?us-ascii?Q?71B1ul6yhxxc72+THgoQrSjsYJ/4zQ9la0aXzHl6wD9q586hS/H7TY9o8VPg?=
 =?us-ascii?Q?ClrZNjgkR8zBpn/xKDOaGwpC1Sq2W/WGeAxV5Y3IjqI6wwK5L19zCa+e/pjv?=
 =?us-ascii?Q?9p3FOPggO+DFaxUA5oabX4ZgWfWgE+V5sithgnnP3VTpp3kTOiE8QrSUz5mJ?=
 =?us-ascii?Q?txmmiaCB9XTA9j/VNKPdBZCI8QUf/EkPP85Pv61dUTQgoyHlC7m1ckn/Ld/L?=
 =?us-ascii?Q?JPXRaBk80cnusmkoUfwTzHTNyU8Q6rCwUvyoUZBHoni0yxBylDHGcBlJ8pAk?=
 =?us-ascii?Q?0LNRUDfizyDKmk/GQMU3BC8JcYxAAEhQFZPGo4S7ETsavQVtKpUVkuVaD62X?=
 =?us-ascii?Q?kldAtUaqsaNMFTgkEM4Mj+00sjYvsIwm3+HO4C1A86MhwFxnAMR86fF75bLk?=
 =?us-ascii?Q?OYo0zpzpKDKCyfzkKIaWVbYfquYQIfSudR8MXqhkSgCP64rvfISkvIlUradp?=
 =?us-ascii?Q?NFcXeL65cFFs8X5jhMrMbkQMjk8tqzG8sA2NhLyDw75YjaCeu4TnlocglK8I?=
 =?us-ascii?Q?1DjjvQ/6EofWw52yg2Slu+KtdT+eKjhtwLA7/eD122lRyNf/uLEW6Mfw+m2x?=
 =?us-ascii?Q?L5vhfzfiAr8UzYC0AUfmoEccNzKTQrgoPGlVZDs54Au51K4USazjPyZvS631?=
 =?us-ascii?Q?VSfvIKkSzd2JG7DF9Qyzsk9zAiZfc7OZKqSX0YDzMv381VMTkL+IunzDYObl?=
 =?us-ascii?Q?Hhq4ZhgcynkZkDMaBc/x6mAkcfikSZ5PlpfGl469eiki0MaXadcxfawHwxHX?=
 =?us-ascii?Q?JAR2yNFU1rbRw1vqelksXNwB4F1sP5Y0a/94wvFAeOHl6oDuprfcsOIuoHXw?=
 =?us-ascii?Q?3CDTxkGdP3NiP/MxhaL2iBVzHBkt/UzHaDqqhJ3CAYPd29dUepqfMmcybB0w?=
 =?us-ascii?Q?JK2GVp3afatB1fXWSIWU8Qncm6T0OEmykJCHAMyNXNE8LTdiGAPgJugFz4Wh?=
 =?us-ascii?Q?1j3bvp9wefP+yOmxVC4Ki/O9R0N9mPoNhlSiTTm0SOjYtNak3LrT9ieOV0dp?=
 =?us-ascii?Q?BEo1hgixb/4xRlT0cnOSbUZtJTUcePePIoaDaCE2QbvS81HbifhEliiROKTV?=
 =?us-ascii?Q?UbeE6rGkpHsWD8VnU1wFxylEhysmgEbQrPc2hka0osjcPa36AMrlddtzrmQB?=
 =?us-ascii?Q?Y9FddLyUX9HGfIvu3TGn0UYC8pH0jXqD8O/E8328fHsR1qGwhhTmiJantawd?=
 =?us-ascii?Q?cuTI5YfLlZWNdhjnVK0Ec4UOrX+YR7K2uEHRR9tofDXHH6NXE6MfwOCaaScN?=
 =?us-ascii?Q?z9FZ5+nIfP8aqVQFq2lxEpulBkqd0+WhY7r0UsvE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IkHKHSIn2JZBYF3wLAg4PlvGUSHNsK48Dvb//zT1Gqtyae/+6s7CjiTuetKlNn3FYyH6B8PF5tO+kWpaOcc0pfOlq9H9nt2agp4HvQbO9SSs+6Iivzm7+pO8oCY0/RxEAwCDcwXZIf2Twc94FuA3w6OYIg2tfEZwn2wt8KvqXwVFttcdksNFecmRbLa5MJoKD81rgNNnnROPbhoYz6ABxUSe9DfOwZcjMRnrUx1PeGn3OCCWZs8QY6SGNyeOHOcnGmpzqk5UE+ngTHpO7uwpcyqi1OwMPM/F13KvXDF0NMJIzOFdzLtoliFzv1/ZeZ8vAJcUczUXUTBoTJRvJJ6Oc2zyB4oNuLfYor0oKGE+mIJxXiTPZnRdNooUtZjFliHRkTY5vYzeU7WSXAnXGhycOErEPVmVkvMI0q8q1ipPRCXyd4fBr2/YimquYwvwGp6+UHEqGKiQj+LjiB5pSEmu2Jk3Zz8yUBiD3nHaBbDFOyiAWbRSJyRiIHzkGq5POvtCNZ0/9hnFGxLqhMtfLWs8nkJ+rCG27Ydu93RvsKqclT14YRTpC1nc225vjg2JPlYmoX/QJMyyTUkz73G4OScBwr8MDUs770F09xqoP9LR2sY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abac1a21-d1c3-4a49-a7c0-08dcea1dcf8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:54:53.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpMB/vNOYzS/nv2LmRpF8KiEKwpyMHprcEd75v1VSkNcDLcp45RXXYVgW4L/BRQ8t8XcJAUZ1y3vxE8P5IVNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110124
X-Proofpoint-ORIG-GUID: j8vtIDtlflHMmY3Is5f56lxs-l4dzRuM
X-Proofpoint-GUID: j8vtIDtlflHMmY3Is5f56lxs-l4dzRuM

* Jann Horn <jannh@google.com> [241011 11:51]:
> As explained in the comment block this change adds, we can't tell what
> userspace's intent is when the stack grows towards an inaccessible VMA.
> 
> We should ensure that, as long as code is compiled with something like
> -fstack-check, a stack overflow in this code can never cause the main stack
> to overflow into adjacent heap memory - so the bottom of a stack should
> never be directly adjacent to an accessible VMA.
> 
> As suggested by Lorenzo, enforce this by blocking attempts to:
> 
>  - make an inaccessible VMA accessible with mprotect() when it is too close
>    to a stack
>  - replace an inaccessible VMA with another VMA using MAP_FIXED when it is
>    too close to a stack
> 
> 
> I have a (highly contrived) C testcase for 32-bit x86 userspace with glibc
> that mixes malloc(), pthread creation, and recursion in just the right way
> such that the main stack overflows into malloc() arena memory, see the
> linked list post.
> 
> I don't know of any specific scenario where this is actually exploitable,
> but it seems like it could be a security problem for sufficiently unlucky
> userspace.
> 
> Link: https://lore.kernel.org/r/CAG48ez2v=r9-37JADA5DgnZdMLCjcbVxAjLt5eH5uoBohRdqsw@mail.gmail.com/
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: 561b5e0709e4 ("mm/mmap.c: do not blow on PROT_NONE MAP_FIXED holes in the stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This is an attempt at the alternate fix approach suggested by Lorenzo.
> 
> This turned into more code than I would prefer to have for a scenario
> like this...
> 
> Also, the way the gap is enforced in my patch for MAP_FIXED_NOREPLACE is
> a bit ugly. In the existing code, __get_unmapped_area() normally already
> enforces the stack gap even when it is called with a hint; but when
> MAP_FIXED_NOREPLACE is used, we kinda lie to __get_unmapped_area() and
> tell it we'll do a MAP_FIXED mapping (introduced in commit
> a4ff8e8620d3f when MAP_FIXED_NOREPLACE was created), then afterwards
> manually reject overlapping mappings.
> So I ended up also doing the gap check separately for
> MAP_FIXED_NOREPLACE.
> 
> The following test program exercises scenarios that could lead to the
> stack becoming directly adjacent to another accessible VMA,
> and passes with this patch applied:
> <<<
> 
> int main(void) {
>   setbuf(stdout, NULL);
> 
>   char *ptr = (char*)(  (unsigned long)(STACK_POINTER() - (1024*1024*4)/*4MiB*/) & ~0xfffUL  );
>   if (mmap(ptr, 0x1000, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) != ptr)
>     err(1, "mmap distant-from-stack");
>   *(volatile char *)(ptr + 0x1000); /* expand stack */
>   system("echo;cat /proc/$PPID/maps;echo");
> 
>   /* test transforming PROT_NONE mapping adjacent to stack */
>   if (mprotect(ptr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC) == 0)
>     errx(1, "mprotect adjacent to stack allowed");
>   if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED, -1, 0) != MAP_FAILED)
>     errx(1, "MAP_FIXED adjacent to stack allowed");
> 
>   if (munmap(ptr, 0x1000))
>     err(1, "munmap failed???");
> 
>   /* test creating new mapping adjacent to stack */
>   if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0) != MAP_FAILED)
>     errx(1, "MAP_FIXED_NOREPLACE adjacent to stack allowed");
>   if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) == ptr)
>     errx(1, "mmap hint adjacent to stack accepted");
> 
>   printf("all tests passed\n");
> }
> >>>
> ---
> Changes in v2:
> - Entirely new approach (suggested by Lorenzo)
> - Link to v1: https://lore.kernel.org/r/20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com
> ---
>  include/linux/mm.h |  1 +
>  mm/mmap.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/mprotect.c      |  6 +++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..ecd4afc304ca 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3520,6 +3520,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>  
>  struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
>  		unsigned long addr);
> +bool overlaps_stack_gap(struct mm_struct *mm, unsigned long addr, unsigned long len);
>  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>  			unsigned long pfn, unsigned long size, pgprot_t);
>  int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..937361be3c48 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -359,6 +359,20 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  			return -EEXIST;
>  	}
>  
> +	/*
> +	 * This does two things:
> +	 *
> +	 * 1. Disallow MAP_FIXED replacing a PROT_NONE VMA adjacent to a stack
> +	 * with an accessible VMA.
> +	 * 2. Disallow MAP_FIXED_NOREPLACE creating a new accessible VMA
> +	 * adjacent to a stack.
> +	 */
> +	if ((flags & (MAP_FIXED_NOREPLACE | MAP_FIXED)) &&
> +	    (prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
> +	    !(vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
> +	    overlaps_stack_gap(mm, addr, len))
> +		return (flags & MAP_FIXED) ? -ENOMEM : -EEXIST;
> +

This is probably going to impact performance for allocators by causing
two walks of the tree any time they protect a portion of mmaped area.

In the mmap_region() code, there is a place we know next/prev on
MAP_FIXED, and next for MAP_FIXED_NOREPLACE - which has a vma iterator
that would be lower cost than a tree walk.  That area may be a better
place to check these requirements.  Unfortunately, it may cause a vma
split in the vms_gather_munmap_vmas() call prior to this check, but
considering the rarity it may not be that big of a deal?

>  	if (flags & MAP_LOCKED)
>  		if (!can_do_mlock())
>  			return -EPERM;
> @@ -1341,6 +1355,57 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
>  	return vma;
>  }
>  
> +/*
> + * Does the specified VA range overlap the stack gap of a preceding or following
> + * stack VMA?
> + * Overlapping stack VMAs are ignored - so if someone deliberately creates a
> + * MAP_FIXED mapping in the middle of a stack or such, we let that go through.
> + *
> + * This is needed partly because userspace's intent when making PROT_NONE
> + * mappings is unclear; there are two different reasons for creating PROT_NONE
> + * mappings:
> + *
> + * A) Userspace wants to create its own guard mapping, for example for stacks.
> + * According to
> + * <https://lore.kernel.org/all/1499126133.2707.20.camel@decadent.org.uk/T/>,
> + * some Rust/Java programs do this with the main stack.
> + * Enforcing the kernel's stack gap between these userspace guard mappings and
> + * the main stack breaks stuff.
> + *
> + * B) Userspace wants to reserve some virtual address space for later mappings.
> + * This is done by memory allocators.
> + * In this case, we want to enforce a stack gap between the mapping and the
> + * stack.
> + *
> + * Because we can't tell these cases apart when a PROT_NONE mapping is created,
> + * we instead enforce the stack gap when a PROT_NONE mapping is made accessible
> + * (using mprotect()) or replaced with an accessible one (using MAP_FIXED).
> + */
> +bool overlaps_stack_gap(struct mm_struct *mm, unsigned long addr, unsigned long len)
> +{
> +
> +	struct vm_area_struct *vma, *prev_vma;
> +
> +	/* step 1: search for a non-overlapping following stack VMA */
> +	vma = find_vma(mm, addr+len);
> +	if (vma && vma->vm_start >= addr+len) {
> +		/* is it too close? */
> +		if (vma->vm_start - (addr+len) < stack_guard_start_gap(vma))
> +			return true;
> +	}
> +
> +	/* step 2: search for a non-overlapping preceding stack VMA */
> +	if (!IS_ENABLED(CONFIG_STACK_GROWSUP))
> +		return false;
> +	vma = find_vma_prev(mm, addr, &prev_vma);
> +	/* don't handle cases where the VA start overlaps a VMA */
> +	if (vma && vma->vm_start < addr)
> +		return false;
> +	if (!prev_vma || !(prev_vma->vm_flags & VM_GROWSUP))
> +		return false;
> +	return addr - prev_vma->vm_end < stack_guard_gap;
> +}
> +
>  /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
>   * @mm: The mm_struct
>   * @start: The start address to munmap
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0c5d6d06107d..2300e2eff956 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -772,6 +772,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		}
>  	}
>  
> +	error = -ENOMEM;
> +	if ((prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
> +	    !(vma->vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
> +	    overlaps_stack_gap(current->mm, start, end - start))
> +		goto out;
> +

We have prev just below your call here, so we could reuse that.  Getting
the vma after the mprotect range doesn't seem that easy.  I guess we
need to make the loop even more complicated and find the next vma (and
remember the fixup can merge).  This isn't as straight forward as what
you have, but would be faster.

>  	prev = vma_prev(&vmi);
>  	if (start > vma->vm_start)
>  		prev = vma;
> 
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241008-stack-gap-inaccessible-c7319f7d4b1b
> -- 
> Jann Horn <jannh@google.com>
> 

