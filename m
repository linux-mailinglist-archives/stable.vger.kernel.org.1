Return-Path: <stable+bounces-222805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB1/OR6LpmnMRAAAu9opvQ
	(envelope-from <stable+bounces-222805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:17:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035A1EA0A5
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75939301DE29
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC9285C8B;
	Tue,  3 Mar 2026 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRAegzmh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vrIT1mwW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727B1D86DC;
	Tue,  3 Mar 2026 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522266; cv=fail; b=R3I+Xf0Ew9C7ODdqcRMwIztzI0CSuyIu53/qPnc3WpK2jtNE7Eutnm5K7a3+5XacGH88eLiI8Wj8dazAlzL1Jku5+x1ovWIg9cULrh5AKuQp3LCs+gm+IOCxoLEdzKs+M5aYo8Wekh7aMvLy3pkjUQUCbx1475BAiP8Dbp04HWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522266; c=relaxed/simple;
	bh=v+ivxIhnKbvPdfFES5FcWQ58dXGtTiOHKR2uxSa4Ets=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RdUI+3VBfVB7X5rmIZlwvWaHYZl57bvZ/te1Z5Qs6B6n934qu71ySf6GnenKzoSiJZf5NnRZSKJPPAI2kHWVQY/ooIxyFMb5y1DPNJxC/oId5ZvvF3iIC1gfJW7nXwuG3VtfWsEQkwz22esAhjtZ0ERDcOYEQTU6K4H3+c8j8ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRAegzmh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vrIT1mwW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236BSiM2883981;
	Tue, 3 Mar 2026 07:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C5oEw5XFIlwIPv65bL
	Us8HHiqGZSxBE+3TCu9OxiTKE=; b=FRAegzmhkiHw5bx/7Ju+Z5NFAjCPmxUrSa
	oCsNHGCtmH77vPZ4KcfkMmDFZX2B+fG8+ehBU1f5V408MP4PZuxupo71tbZX6fj9
	KfjoQm2kr9XqajSSLPauR7EOUDZqOMKESMxQ9IviNkvNLkjAfKhlAq7mVmj3oNtk
	69sQqz7SsyrGqw82NkoUaNEtR5vXTv7f9jIrDYCzFF3UTxCfma6UUFv1iQsOa7l8
	CsOa2L/kMdxr3MAh2824ZRJREyulUuZUzid7zKHJEYZMYOMkhAL3jZd51WqoaVrU
	ZUcLv6fINF6FYJJtfdsM8elt71UMyQteVf/cqntFNEypoy0eLFvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnt5fg1j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 07:12:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6234qGLr029882;
	Tue, 3 Mar 2026 07:12:18 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt9yah6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 07:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJu70huUoR7mP2Eblvv2fJ3a/Bg6/ed6aVN2fTRfwVmmpPrrqWQM09Qj8D0pFNHhHpsTG5jaN+IBgCBkWFoswZuTZeBERjaZgWteAx+lIiVhoxgW1VvMkwsSzxXnWP6ZlS6ryya7Bs1m6uUk221GSxy2CwiSKOkqrszzT8fcvT/L/MdKqVCWsTdnDpMILkA2gQjemxNDXVkd5ShRlmUBMbGW+2/F9dZMQRLk/d6fm5z7tdedfWUpP4SJ2zHkN0DbXqOmAzWRxYH+VfuTaIzb82jmPpuKt/XK767yspdn0CM93IeJhhu3ZDbgxWvHqZXHT9dpPiASxlTYjMiJK2/L5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5oEw5XFIlwIPv65bLUs8HHiqGZSxBE+3TCu9OxiTKE=;
 b=O/a5DE7mVlihJHKz2iehYX80CplW6p0sSMsRwLZqUzybNuCN8ioDkZ+SZHFl4SSagSnoKKR7KxU0iJu5pHvRmKtIvM+VnBuuIvLcC7jm90MAp1gUq7DDAnLEwcSeDOoRf1DBC4NJu+JjF0XTMli9+KOGDlcsAVFkeDD3jLuGlQoXzz9sQQVYUOkppv9rKbx9w1xTYyDwZxVWPRHq6CPzyklOCVlms923EjDwsPShX08GVS2pO00CPzY5ZU+j///Dqx54rkaSbCTu6YxUjotqQdVtadn6o4xWUj8K0NvrOZSi9Pot4jSCJ1iUuam23BFCJvCVcIos9+X/emX+D5YPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5oEw5XFIlwIPv65bLUs8HHiqGZSxBE+3TCu9OxiTKE=;
 b=vrIT1mwWnvffDq/r7jxq44K0jGcGhS1IhqRmlpYhGkSiNXSnwIBY7h0bm5kbxKvd0hwPCZTYgaCrqlhlDNVUuggm8T05GUF5wo7f9rjw9Zhsdev9p7C4E6kXGtieT+VV1NVFJvyVbdhG3yPwHBSgaJjrGzul9qll2rpM3WJscYc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:12:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 07:12:14 +0000
Date: Tue, 3 Mar 2026 07:12:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: Fix use of NULL folio in
 move_pages_huge_pmd()
Message-ID: <5efb6235-e9f5-4e28-94fa-f95326ca7015@lucifer.local>
References: <aaBVg6nPQz-WvyzT@chrisdown.name>
 <27c260d2-796f-48a6-8b1c-751ab172d480@lucifer.local>
 <89d988b7-846f-48aa-9b69-c316f2179d61@kernel.org>
 <479c691e-1330-462d-9d7d-25cfda1f190b@lucifer.local>
 <99bb6e08-2c70-4b52-8fbc-1233173fc195@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99bb6e08-2c70-4b52-8fbc-1233173fc195@kernel.org>
X-ClientProxiedBy: LO6P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2539a953-ffff-4fdd-c602-08de78f43204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	ruvwLk/HK+1GCPk33BsNxWtMTvuvLNzpmzqAx/faIq6GbMrca5czcUJZ1KNRKUg8C218gHZdNaGldOKR2ULJGhMG4tyW0yLqQE3va+nTnGZ8we4LR9xaLnuwgNWfXW2zLOCyo8+1T4ep0TVD8ydLgglG+eZ8NIltv1TRZi39uEsYWQtdDJR3aNWDOgi1xk09kUrb68RhwmNFnr+QAbSL4gVs35NT2nKP5rfk74EN6yGIuNsRN1OwLmXQY6mHuNhgwiLUorTQPK9SJQ2ouj4AfSV3djK1hHio+MMu3Ae5HAORKREVb3kypXMEzcFoBnHtpArrpYzHQzO6MiZ5FttXO/jWxg7NSugNq37fhe34y2aX+m/yBcmj6ROxM3Pd5elZt3VRwY46VqhM3QHUvtAIkqvQLA+RZRE52xRfSNQJnlpLNgJJt0QF3DbFEo/s6i6Erk0SH3DSv10KW6uEO3TxblmeqBjkQL3eHs/jTZ5GB4Jxbdqml89BdqDCEQBZU3okqgffuq9sBeQXOXd8vljQQCH8AGrEIwT2JR4SWM9yK71TKK53Q2WdTuj0yNzmgEE5b4CVWxkuQOX+Y28I+CaFzZM15T+Exd5XcaTo675iwP2bue8PNkNQgppOqYtjyzX2r0RQtre/9Vr9IojYwcDN+sPyC6ltpJdftd+X1mCXmHjXhGfn7Ly6IL1oJZJKXyce/HNaFNdg3ToJo81nWOtXhH1vjGrQ4JaJj1pSA5o9cxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHozwMB+YOddM3TNx0dRTmfJz3+odbzYL4gSCZEt2RmBMIUmQHL83G6oF6BV?=
 =?us-ascii?Q?KqTuEhBgP+jWj+69GSPtMiHQL1C3UUEDeEcr/mLnv2UDHBTLpEhfkFrSo8c3?=
 =?us-ascii?Q?0lgmVVoJPnVB83xvaq5wTecGZPu3fCdSCtGTWP1QYYpdxv/96O4r123HnBYf?=
 =?us-ascii?Q?D9+3Kjdaepc+LYclK6y+iyaDcnIdRpPPDxJjnooS6Ob91H7iH2+8CczKz9P2?=
 =?us-ascii?Q?Kr7Jyv5zRCief/7ioYZLT5NIkblfjvVFZUwRsic3jYV4CfxK5iTj99dGBBgi?=
 =?us-ascii?Q?nNtgLwdwEtgTXTyeinppFE6wHNdctUlGsMdslHoXfJHDVVqDyaSWS30rWOkT?=
 =?us-ascii?Q?lGpVn7QkT1A98cNWMcG0yojrsmV5xJqfxnOOLXhA8Kc2CuTx4sv8W2mFIr9o?=
 =?us-ascii?Q?g76QaVxyQJF8kBRfCxaRTYNUhO3DbRRBJnedYtoqGNn/UZpA1U/TaeihsANe?=
 =?us-ascii?Q?XHWVKeNVlRD5F/r9DcGbGNdi9mTOK25kvV6KcedaJEx2G63hn42I6mzwuxL0?=
 =?us-ascii?Q?uSLBPBtVzhxvUkORP85GFm4kMh3wmh8geq0LBzoMU7+7tBHzzCWUvGsKSPOh?=
 =?us-ascii?Q?EJa2dAHH3gW1fI81CsrnX8UbK1+OSQYy9weo9a2YBhz0Ooru/2DiHXB8vqk3?=
 =?us-ascii?Q?0wVehpFCGV7q6/6z0ahiY2oiUTSSDD4l6fqNQpLCUZnPjbzy0aaBlGIj5ZeZ?=
 =?us-ascii?Q?TQYcvqB2ZDuXEOrHSSyVh62ppWgFUXw4D1UUCflBGDnbOAVAkIU0aSyGRA30?=
 =?us-ascii?Q?/6op7GxkaJZg/roxkMyMKUh4FAOqE4Tqi8XQZ4SCBSRrz3z09RMe/9OdzHEW?=
 =?us-ascii?Q?kr/ozh2OkDTF4n2GM9dhOEHSu5BhsVzlNn/GqMp4/MsSm7Lb5FvXVEy+1lQG?=
 =?us-ascii?Q?IFxqBWFwEwzS6g6ds1QOxcbPjCS5ND5JCxSICvkveZxxBFbxnmtEpEABA14F?=
 =?us-ascii?Q?Okp+pl0lRwYm7eg2VFv9wSKMHsH3Wu0IktLCp5Zi5MOsC0SqewjuEDLcwW31?=
 =?us-ascii?Q?Drz10aUkmGRzZ9ygNXQKNISGYgYvXvC+/vW/5HBr/9eoW4vI5NsmmH4hhG/O?=
 =?us-ascii?Q?LHAZcq2M71FgzOcbaql/Zxn7U89Y2/r7u3WTSmgMrhWPlaiTv0IGsk4aYYrw?=
 =?us-ascii?Q?+bbLdr5lbJcBtlmQfxWa+4hTFmydUXy6AJbbMGT3KXDglZYA1KOlIPoMSHIu?=
 =?us-ascii?Q?hSHXZ57HPrq/l1DAz/N6NLxt1Q388yreMIEwZjR5YCXMz0QmRBlOthFE+0tU?=
 =?us-ascii?Q?5LPsbbK3anj25k/XGMUZA41yVO+m3U1zPsLVeJfMaoL7P+oHofdTOZsye5ta?=
 =?us-ascii?Q?zdCdezD4xbohy0C/7uYqbkj7gMEcI8dZ9WQNDMSgYCoKu0cN38OY9c/N5N6s?=
 =?us-ascii?Q?QkeVcnP+1QUnSXmHyr6MEOLqZwJ6wwwfNHCtFw4XbE6XLici0KYVnqfFfjOz?=
 =?us-ascii?Q?lI8+i4v2taxDpXuGtOT2egmN0lBmdZQjtIvM+8rW565jo4NsJHwbf7+GrwVR?=
 =?us-ascii?Q?zdDSPjY8ycwOkQ6Qf8dfKDc/tGO6X4uWj6rjN0VyGc5WwLt45btmiiLpyvyt?=
 =?us-ascii?Q?Tnpo7XraGi10s+II5j26KFnPZnOkieImiuR9EN3mYsPUepgqYDdvxCGv2Smd?=
 =?us-ascii?Q?LCOsBDfN7Qvkw++YnLLvj7bDQLBMj2KgAqgvgUKKcn/tybygbEsa4QIQZFsL?=
 =?us-ascii?Q?QijGXlcPXZz70a6Vu5nAq5iNV/6WclzouYAunHDpmLLyFJl2Hm7ip30mXyPq?=
 =?us-ascii?Q?ltXEAps1GuM7JUrYbvXmcvhWCnGU4RQ=3D?=
X-Exchange-RoutingPolicyChecked:
	IjjHAsIk5/0u07+9qXHEbE602CjxklIGc/33p+0I5Z2vC5RxynqDCGSq97JJdSrGe0EmBiNNK5mjoXBS89T/Jkx7/OGTcgHlAwP4lJLQRkJgpqRmyFJB9CK+b+iyflC936ZvDX+3xZXjj1ZQF325pLu8HoSvw/idt9dJfxecPc5pv0aroR/6gyoTNdtDgjVMBLdpj07XObrt6L0mBbFUEGlg+ijlDNCsAha3wW512G0zNRbs6xAQNY0PBy1pEaOy0WT8iIIxaxjAv14/freg2MihsrvWpVi+z2B7d4PFDgzBTD7ORC4e/fkRGVKLiujiB0DQPB+QdBH+P/xRNYAXsw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ajw9n51CKb06ksptyyuix1na4TPpMzyDTGpPoyc2LTQDNvf1lD6xHxMnvWR2P78ZGns4sPDCTBBxk4HkhUYKtKGg3BDWG8pydMLJND+DV6ZNN/HlJ+CKlU6yHk11+KMk33Zj/5uafY4DQvavTQZFd85qFCvoNFoCAFwqEb67lw5Nd2Y+yju4ohEqoBZuUXkVbLxcRDNgDI1y2XOrp3i3Ndm/jA+KS+eDBpgAxpYDLz6Jl0GFRkAAoAJva/ALr/Fzpa9eLoCVM3D0g86+jgJaqjQhiCWNb7fW5OpyuvJ3QKWoM+h7bYx+r0geZx8Om1uNZlTumZCPPum6LHF6XBnvyxJybHOJ9w7AX0OSgWUIbXZXVRWybr/7euLx1UY0Aij6XGjaOqdERr5hBQh80oHv2AYgutL9iF0OWPtHsujm5SO4D46t4cKa62bb/SH9pP0ECONKf1O6PqU9ti7Q3tiUZh+i9fcA532N8m2A5hR82rPf8ULHBNGC1wYpaTqv+S5NQzp6FhCUsGMASsG3u2zU6fx3P8v5dOO+cDXe8knAAP1nRnq3ec8KFe/WpNFl8/t25u4t+OWOf3+CzOObD3Ufl62B/8bKY91005Gcg7jqXSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2539a953-ffff-4fdd-c602-08de78f43204
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:12:14.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOW8Ns2Am8skm6JdQA6cqwDAl0DGcFw8xfgn/lfmeGpOeRKiTfP1pWHKqWQtXxdgAvU/VPviC8Ju9qb2BXtHIfAANAnoApVkRAiHCeV4E7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603030049
X-Authority-Analysis: v=2.4 cv=QOBlhwLL c=1 sm=1 tr=0 ts=69a689d2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=4hWz-t2M-U9jOkj_3IwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: GSuwUTYr7rO2HJBjap5Cpv5dai4EQvJC
X-Proofpoint-GUID: GSuwUTYr7rO2HJBjap5Cpv5dai4EQvJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA0OSBTYWx0ZWRfXy7YbnSaHDc5e
 Ez0mX8/a4RXtT0Aqq0tVNOkk/cL1P1NIz7VIA4MrAlAl72zenZzi0ElKATAWGvP8NqRjiz0fZys
 wj1rjvPSJRhflc1F9x9ziSnShHt+CsIlbhz6XQQGmHnd6BIlwUiZi3dqBAiOnvLM89A8s63o3yj
 F/DSbWhQEciuRCjXi2BuNkSkveg8SaykeTNviYSvQXdIT71KkOSB/mcp5nfX2iwzzF3o4POsETQ
 t/hLAQQF7lPh4dKeKBnsi2cHbPBdYQdF9M+2IjfLRwRTa2Pzq53N7kxW/8T4geNBRAghI07cURu
 SD9YAh6a7Xr1ajEaRkjBcbTkHAnJ/AUqRN87SOARAPwsi2eUDVt5aWINnsC4aG79Vj3iyEStKFP
 5F3oMLCxZMRaiDIGYTXARtmPBpTq4k+emUclE1i7e4M8onoZdNTcN2MkJq3VyjEstRgYF9VK2DC
 VVga/GLR96/q7ZikTeA==
X-Rspamd-Queue-Id: 5035A1EA0A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222805-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,lucifer.local:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:05:37PM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 18:43, Lorenzo Stoakes wrote:
> > On Mon, Mar 02, 2026 at 06:35:46PM +0100, David Hildenbrand (Arm) wrote:
> >>
> >>>
> >>> I prefer my version at [0].
> >>>
> >>> Cleaner to actually pull out the zero_folio into a local variable, and also we
> >>> should mark it special to be consistent with other codepaths.
> >>
> >> I argued in v1 that we should handle it similar to an ordinary move
> >> during mremap()->move_huge_pmd() and not split it over two patches.
> >>
> >> It's still split over two patches, which doesn't make sense.
> >
> > Yes, let's not do that, I made the same comment.
> >
> >>
> >> https://lore.kernel.org/linux-mm/0b653dcd-842b-4360-bc1c-8fe779efbc23@kernel.org/
> >>
> >> I don't think there is no need to get the folio involved at all if we
> >> know that we have a well-prepared PMD (zero folio, makred as special).
> >>
> >> The less code we have that has to deal with setting PMDs special (and
> >> possible messing it up), the better.
> >
> > Yup I agree, I replied accordingly. That's a more elegant thing than duplicating
> > huge zero installation code.
> >
> > I had just assumed that there was _some reason_ why we wouldn't want to do that
> > given the original patch from Suren didn't just do that, and for the sakes of a
> > backport no need to think too deep on it.
> >
> > But you're right I don't think there's any reason we need to diverge from what
> > mremap() would do.
> >
> > That does have:
> >
> > 		if (vma_has_uffd_without_event_remap(vma))
> > 			pmd = clear_uffd_wp_pmd(pmd);
> >
> > Though rather than unconditonally invoking clear_uffd_wp_pmd().
> >
> > Is that correct?
>
> My conclusion was that UFFDIO_MOVE will never move uffd-wp information
> (just like we currently don't do for any moved PTEs).
>
> mremap() might sometimes. But it also effectively moves all (most) uffd
> VMA properties, so it has slightly different semantics.

Ack thanks!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

