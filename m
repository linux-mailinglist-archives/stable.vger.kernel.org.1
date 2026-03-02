Return-Path: <stable+bounces-222657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HvWI2PKpWnEFgAAu9opvQ
	(envelope-from <stable+bounces-222657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:35:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2C1DDE01
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AEFD304C7D3
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A747317158;
	Mon,  2 Mar 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n3If/7du";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A1WqFnuh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC2283FE5;
	Mon,  2 Mar 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472910; cv=fail; b=HiexFGGaIqsthGOOfc3rGG6hHngnb00ZyGZ4hGcHHN5oYw6HGiKDNGDSts7Utp81/7o1C6FlywuwKr3OIqRREJxJ0S0rvflNQegHO6F0lZmSAJNZA7TsBVdV+6gTtKH7KQT/lRlM2xsOy2GpXTMJiBV4Ml40zaVY5fdRimE0CvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472910; c=relaxed/simple;
	bh=SlvQRvFIW8YBAk7xZ8qFvkPXfkotvLoIelupyhAoIGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CNuFf18mM2XOo9iXpNgcOi5nIK5Bs9SdUtlIV9mp9Xon1uk4hV+niOtEuzvpjBSIGYLmpv8V2wDSi/gvlP60/rMitOZVieNvt/5XPbmnmtKpfgQE0fCKWLPR7sZ0N2W19/q6K/4QBrc8Ozt1pYpGGpLR+F26xT5Na2tQZl78260=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n3If/7du; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A1WqFnuh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622HCEgG2684010;
	Mon, 2 Mar 2026 17:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lHTxaBT9ppevFgUrRS
	Sm4P2BPQHs1E2evifX/qDwPOU=; b=n3If/7duFCoaM0l5QReXHrPyPy1W54nOaE
	9tYyWJzcwQIxxmoQrx4kxC4C9KO3MOjkvrDfxZACOwMz7/BXtx+SE1fBEDj/3P0D
	yNINuaY+/eq+JuEuha4W1On7OBpIjBbR1qxtzI0HW+PD4zGDaRUhNFs1KPt0fClR
	jlVk/CrjpgHydseX8d3q4Y3e/pp+gMAId5yw9mmGBy1muwun4Dn6mwFO3rzUAcmt
	Hc2vIFPkIrGEXnzep3WaGqocg1GGldMEyWG97rm4Gjw/IjRC3R9IHAQp/nFhDi83
	vA+Czv+JAH+Uv5VDSBxMJlS3LwafdVEDE9+QfBlONal0djhdSBng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cner8012v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 17:34:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622HRXVs037925;
	Mon, 2 Mar 2026 17:34:53 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdgxw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 17:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMBP30AyeTY5V5DeP41cQ4zj00x4Gy+Ar7nQ6g9GGm6HaiElzq5Sn0836aSTrYg2uGZ1P1oRfjRSYMBuYvSUzSgaaPZ1yYCwcsV6fFqqnk6VWcHPrEDYjqo2n2xbGt/vVZvBJGiPkn7oTHZCJhAJonJYJAvh51YCZ+vmHI8UbB2neoXlXxDC0dyl7106JnrIyTvDa/c2Q6ZAcnmgwiQQPmCgGFHflKcovibNSCDQhMQQEvXbR91PweAiXUmdLsJb5EfEahlqjHG07mq/dLNtgGVVtB7YmMypZjH5taCynuvG3ZM2Hv8A5Vt95CmgaIne/xYXue7TPNCwuUy8HdQj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHTxaBT9ppevFgUrRSSm4P2BPQHs1E2evifX/qDwPOU=;
 b=M9uyU5b5M/iaBvNVv3NHjDCBQsk3iMOFbLzSarM7z3N1x2A1+PE6rH6dE5tkwx2JObRBdjFVfIux33Uxo7nM49KkuK95+lH7JHKeOiSsCIVrQ1J28L3qntK6/FgrrWS21NriAaQisaHr0z5SUX1Zg8wSCnMfSRpMuybYYeE2SYpdQNKqA4PPCngIexnTWC/PdYj+wa0n0zCP4KfHlr3yOGuqdRpfdUoRJ/V6vPq0bILY8lBGVVrqHuRmUZR5I85ZjuLF/WLB9/tp5mBkkgM2zk8OYEPnw8Q2ZN6UD7T2GlHtcj3A9S4gtPXvs3ZDPnz7WJMMiHks+Mapzi3ZnGDXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHTxaBT9ppevFgUrRSSm4P2BPQHs1E2evifX/qDwPOU=;
 b=A1WqFnuh7IU77B615ADjpcloYyGHNoouC75xdNd0Lq5+ethw9t/C+rZcxH6ZCrqZ+YnX2IAQUN+6Qqr1o3ac0zHXedJufuSEt/STxJk9fQU7m+DaiVI8n0wSAgeoURaLt+5Jwwfe1vu1fG76YPux7FvhJZZ6iGAS4O/amooRm7s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV0PR10MB997588.namprd10.prod.outlook.com (2603:10b6:408:33f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 17:34:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 17:34:51 +0000
Date: Mon, 2 Mar 2026 17:34:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/huge_memory: Prevent huge zeropage refcount
 corruption in PMD move
Message-ID: <842272d9-9e9c-498b-9b11-cbad25f526c9@lucifer.local>
References: <aaBVz7eb6-VBCvaz@chrisdown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaBVz7eb6-VBCvaz@chrisdown.name>
X-ClientProxiedBy: AM5PR1001CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV0PR10MB997588:EE_
X-MS-Office365-Filtering-Correlation-Id: d009c948-a6f2-4cf9-954d-08de78820232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Idb2DzRCTZYM0X09WBORQEFphpScfWUWO1S+O4fjb06UCX8LHTxAN/VkDgxsY92DD/AdABzn6wcA2laBW+R1esbZDcYNtW63SoDbFlaGEyZCT41HFVarolxTkhOD+uXF/9eW2ClwRQv4/ZlEQIK7QxujfhS/c8IWIik+KbWT7dk0Da1SYqwy8wXEoBRTM9aLNaG61O8N/OJMos47CTZLmEI7Uld9SwqZy/HbW8J1QuIEfPzJbdo9qmG8a18YArS+n7+2AasCsEPEPftj+h//LaFe5HszwAgju3yQduuwGF6TNTB6p6OsOrpRJSskIr6dJjLAE8S8MQzy1ErWp5M3oYJmDz9J0WTXVsKtRSS+5FbzuxUQduxyRc8MovI4OD1Gyb+l3/bPWYZBiMRp9GHGBH1cPwaKe92jkC+mU/pox7Z5LidcZqIijCPzeRkdIs2zEmFF+oLQ9v3+iMVs952OBrho/OVaslgTVwTbr+fHWq5jty7IhtzbF54HxgE+AZ4p4i+DueUxnbXUJhQ4D9axkiMQ8smR/YDshXG4G+/qIdOKO7E6xysJ32HLzkeLCBHdpsD1Sq1BbtMj0+gCdjIqSirw7oUQ4YsbD8qN65gIofhpVHRS4gXKlqAScMEiX+dDHrKS4j9KcIM+OtQISatQJ3+XruYWA94aWOvNxjyG1G4AHcYMi8YS62vKgw+DOMXbE5AA4m39XK/ddlGLrKUgB9znnA3HWTIWyr7jKZSZGCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wny4gUIR4X582l6NpjBdK2YRlMG/KQ3Yfcm7AvpURUhOveAqV1bvTj3KiQtA?=
 =?us-ascii?Q?iy2qtNkm7QuYWvg5vscba67zq04XneCQJDJV6gfBtNY3HOg8VAPmqZjSRurh?=
 =?us-ascii?Q?HjMbWSLePmKvga7REBUVDg2eiiPxiLs6hNKsashuy0jP9JWHSUD5DvdeE3fG?=
 =?us-ascii?Q?3PpDsX79cQUnu4z0f5s4RzsbHkzjLaCBfW6ZsBf3q+OJKWjBOrcRzICEwlDw?=
 =?us-ascii?Q?6l59TGzTQcex6OyHU20XTKzb1C+1pZb16lHY3jwFvhcSDUFp+k6FSPa5wv3G?=
 =?us-ascii?Q?iNQoycxP2GSXvTx73mvKIH9ENG0vp279Yynr0nTZQym7dh2abJsyCV4xy5Py?=
 =?us-ascii?Q?gMytFmu5ZyoGkezN37a+xGyPkP4fBOWozk+MFtNnvZy1+eJcIz2Jq0Tw4EGi?=
 =?us-ascii?Q?qbuIfwNgBh+eDrmXnVwfUFDbH+mQBvI47Yc+CEJL7S9EydjWA0nyPYtBOBoP?=
 =?us-ascii?Q?FVJTmvMNYpWZobH3tQMgeWKaQGCZ2Yjqehx9FpeuW7S82uNAp16BXvrZOTdo?=
 =?us-ascii?Q?hPieo8RdR0qtfqSLvFOR3pBypqhdH3oVWHC16kEa401wK7cc/weh/NCc6k7Z?=
 =?us-ascii?Q?G9jjI/DvN5JI1wSEcrDNoEvT9plzxsApRvP30uvQycSaaWnAb5SVLzxboCht?=
 =?us-ascii?Q?7Z9usKUzLgZw6EZV8+ROqHFeighEZb6apY7/E8zgUNNMEBGst4TuSYLQpdTL?=
 =?us-ascii?Q?iKpqCy9LBgDqzXTwSZbVoLMQav9sXwken8hFXEbKcAkCZPe7VxNpp5CwGtOb?=
 =?us-ascii?Q?PGG9CymjKrI4CH12TGG9mqKczPr9GNeIZqZBl1ggnK/vRGoe0sEWbrIxYrrH?=
 =?us-ascii?Q?4GprEUcxg5hCowBonPmbmhmuWtp1VpPxxugn5TAO9MsWPDvfacMuqiFfMtdJ?=
 =?us-ascii?Q?tJWwCyH77Grq1SKjV4d67bIZ2SHml5V94fvTA5xMz+K/F9kkRKtATV0c/Uo5?=
 =?us-ascii?Q?lVYOjOVvSVR4ABXKXQ0Bj5+nsGzcLM/OkCgEz8VA0bDTOYbnRTheb99IgGSi?=
 =?us-ascii?Q?WTOfgmts2RlHfZvm5/40vkOUAdZv10Jvr31tHTaZoXY/royoq5Q3JZ7pGxOR?=
 =?us-ascii?Q?t/WM1niqVh7CRm71syqR6RFy1MOfOFWvwX23dmaeogsEQ2dGwDKOGoDqfN97?=
 =?us-ascii?Q?TREvp0YX7V8vAVT/l0VE/VLfybYwqkLMoRAxt861e1h1jW6nStvzZ39rvUeZ?=
 =?us-ascii?Q?rBaumwHSodMdALa3F6H4HnHhbsDLzUhX7G7AiWmY4rDAUG0qlKpHt9nZ20ub?=
 =?us-ascii?Q?3KGue1STNPbDLgKhMvccYv8Y5Zle0oF7yqXBm0Muao2rk9DvzFN87SRrFz4R?=
 =?us-ascii?Q?2Cf7gHuPBpLZzNxu09HlqksOlYZ59pYQafR3vMH6sKHC8S6oar3sCd2R9ftN?=
 =?us-ascii?Q?JKHAsdzvoj4DtVtWIRD33EEl0FyzKUZU49YOS1WXbDmTqBFc2PB2NhDO38Iy?=
 =?us-ascii?Q?JGw4HbEpEqaXZpCyA12neFiiwzLfOMIVuZghyjXgPSAsRWRzEyG90AEwZtVb?=
 =?us-ascii?Q?IY6EuZ/CjsaTeRReQutH49N5VYH5K+Iu6HKYa2wapedypfyWFdEiXfcGt6y2?=
 =?us-ascii?Q?vbL3ZtpZkxNpZuJsO93tVzTmEJpcBS6+V+DsJwImjzNvFJ6pWlIsud+r3F7O?=
 =?us-ascii?Q?VX5cPSoKFu/W4QTgrnFeauPk1lVeq6x4FgDzmAPlMFNuRFHsA/lr4oTECume?=
 =?us-ascii?Q?8ZygggAuveZa1YukeZEcwhO6OeNDkh1zFDozUi0SMFCH0lonGSjivMqjXBLW?=
 =?us-ascii?Q?GVQq8cyveGbtAcs8mGeheDPuWdCbBUo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yDAh05t4GGMHV2OJ1/vpkxsLu7Evgs+gquql8EHD8OWimyB4Cul8nACJ++48VSCFBvUE/2c3GAQw6Pvakpi1BRawn8DcFxft9XytEdsqSz4tlyu/SkUlbJl4MbJOmpRuESgN399HiMLRR40HiXc+zTrFzuqjv+cUuS8xvbbH20jjqjSRStEUNvrTTVCznOvGQtyVmyUTUnR0bdGp/ha2/vxJghEroZdwFZknfaB8VYC0HKSW6gZy67gWoOGNoTS96IO4BrzENleUG0i9vDaQ6gysThTh4bEBmqLG0pW5hnPOD2muVWys0oncbMSNImR8hJCZYkLMD1bVuTyxTrp8XuwpgpuUQY/ddWg/an+LNLtHXvpc3RDfwjkLStTLIG3yvUxPqr65YHrpOuplWtL3Tj36IEjPF8BApuKcFOmC5skxHXa6QPJhSgR/CYy/nRQadVWo/hN0sqZEyYfEgx6JsiwT6e2mGwnTtDUYe8eIR8Y24/tnP3OkuytcjpwEX1/uEJLgWev5pP65Hlbtee9TJC2jc607ziTBoch/zOUpAebfL51Usz6BYUgTAJyufDuLJAhI8GuXJ67ZHbZ6NhhVh5lfMxkZmAocJtK8bhs4FcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d009c948-a6f2-4cf9-954d-08de78820232
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:34:51.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAKqE73PvBmFeaHNcDNYdILKPBntkxZmEgDS3JOuowy/H+hoUrVTFLfgdYMX8fiFW8sG8WZEVsom+RoNY6xF7oNGYe/r9RzhCrfKd736iiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=706 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MiBTYWx0ZWRfXwZbBad7RPB3T
 TJBfTIQABC2E+xklwmIcsC8JvDgsfjyEt12/djdUacUNwQtFA2qS+4vT59UWXsEUNPJvWp0IOTp
 N5++jNVLMs5IDjiZyi0uiPxki4aY+KB/Qwxm4t1ZnrW9vytvcZoGYIz6MZBwRs8gRBc+Xw9TaEb
 Gp1W3CJUTPW3J26LeqiINZ68Jb3jj9oIX1nXEpcGfVBUQ4N/e6DKW1TCQWDMziJxgPkQG5D0lYM
 2C1b7DXfX/q/Cqqhri2rANGK/dLOGaA0N4/7DW45oLDP+Kg14yzo0DlWaDKMCJHubmnnt1KgyUq
 Yq3pIyGq34kzi5BWuXQLlPkyxf7jKtT0eQy9ZNFlgmMdrX5sd06Dqhe50yZQegSXqYNAXxc0/en
 EKZfLyYh+IEcbXDithBi7wMZV41Q8kcOcgy96vo53Se+E3ijfMss9EzfM2ER9QRlc3H77at/Dnt
 CzFbxPFVCi48eSKUk05Wh1M8jtxXMfp+gqO2h7hs=
X-Proofpoint-GUID: MUL1jc8O3Fol9taVF5YU9jbxLKLl32oM
X-Authority-Analysis: v=2.4 cv=OcOVzxTY c=1 sm=1 tr=0 ts=69a5ca3e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=vjtDiOC896RkgtxD1rUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13810
X-Proofpoint-ORIG-GUID: MUL1jc8O3Fol9taVF5YU9jbxLKLl32oM
X-Rspamd-Queue-Id: E7A2C1DDE01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222657-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chrisdown.name:email,oracle.onmicrosoft.com:dkim,lucifer.local:mid];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:16:47PM +0800, Chris Down wrote:
> After commit d82d09e48219 ("mm/huge_memory: mark PMD mappings of the
> huge zero folio special"), moved huge zero PMDs must remain special so
> vm_normal_page_pmd() continues to treat them as special mappings.
>
> move_pages_huge_pmd() currently reconstructs the destination PMD in the
> huge zero page branch, which drops PMD state such as pmd_special() on
> architectures with CONFIG_ARCH_HAS_PTE_SPECIAL. As a result,
> vm_normal_page_pmd() can treat the moved huge zero PMD as a normal page
> and corrupt its refcount.
>
> Instead of reconstructing the PMD from the folio, derive the destination
> entry from src_pmdval after pmdp_huge_clear_flush(), then handle the PMD
> metadata the same way move_huge_pmd() does for moved entries by marking
> it soft-dirty and clearing uffd-wp.
>
> Fixes: d82d09e48219 ("mm/huge_memory: mark PMD mappings of the huge zero folio special")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  mm/huge_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fed57951a7cd..8166b5e871ad 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2794,7 +2794,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
>  		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
>  	} else {
>  		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> -		_dst_pmd = folio_mk_pmd(page_folio(src_page), dst_vma->vm_page_prot);
> +		_dst_pmd = move_soft_dirty_pmd(src_pmdval);
> +		_dst_pmd = clear_uffd_wp_pmd(_dst_pmd);

I'm confused as to what's going on here, it seems like the 2/3 is simply
updating the 1/3 with a different fixes?

I agree with David that just moving it is probably completely fine, so I think
this should be the only actual patch you need, and you can just Fixes:
e3981db444a0 with it? Then make this a v3 series with 2 patches this + the test
right (but maybe best not backport the test :)?

>  	}
>  	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
>
> --
> 2.51.2
>
>
>

