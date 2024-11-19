Return-Path: <stable+bounces-94036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3A9D28C5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CD281BE4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD6192D77;
	Tue, 19 Nov 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITocsUAp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d1iUP1IN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BA1CCB4E;
	Tue, 19 Nov 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028396; cv=fail; b=jweOpIKiGezCDLRSj6hxgWSZUBO5+xE5G0Fn6FXPDYNiNHmkzhnKBA+Aeyf3MEO4N54YGJzkbFKlK+Ijy0Zg5kU2VkaZEydKB/6mhyES1Zd/ooSlg90bELLPbgG0uyhPRxjz3gy34YMgk0A7FEI5mQmaqC+jIg3+gXCaKHLtv34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028396; c=relaxed/simple;
	bh=iflOcetKJUc2IgG6/icBGJYHjfA89MbaN0ndGbq19oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ojw2mN54Tr/0NSB5TAzRcVfE3tOfhGUjT5gIC1LOYMKkqNH8mg1kkx/Qd/vBqb/k9eWk8MOgrdYSXfAdporKkE/32/z45HtPXraE/z/BVMc+wgvSkUX9+TzKZSNzzuiWOVetOCp0T8k6SFXqlGSkhMwJ571FRpfFaG+KQBWcnD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITocsUAp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d1iUP1IN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDhLU2027923;
	Tue, 19 Nov 2024 14:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oLn0g+KyLx7qkwFZvO
	D+2mXP0g7uhTyXicY86RghWKc=; b=ITocsUApzeEUFf802EMGE/OrhGV/TovoZv
	pKNuyYpyminteJ8dSqxMLa3F6STb52rSFmwpuX+/QuS1TxGCAeB9ER1Z263y8POK
	aemVaqg24SmHvaOQiRMKNm8HasGc5Fznel1lXjXKMne8p7E7IDI981+jax3k47CU
	MjsW0/bElKGxvnbXUcZGjJI+sxFRvOeo85sdlvWvMwrE7Z3ljNyrRys7s4WEqcHt
	mcn0C0NmCMuVzneHRaC1NO5lg19Bp0n683uX2A6tp2oKYR1DwKjC7cJz/+PI47tS
	mfcY3nhYKb+lxDp1YJHX9lGK1Ue0BMLFYdPxo+oYPUB+wyLwNBpA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr3jpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:59:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDaLor009145;
	Tue, 19 Nov 2024 14:59:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8uk96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyEH6B2MhYJmFlbPb4uSjehoSowFJuvBQplh3X8zN3q3vCC84KVmZ/PHXiLA4KTZOIrPz9NZNKkkeh3nAiWrD2Yhe86LZFsuTTStf23bc5X/Q30M+7YbnnwHRT6CpnQOf9G1rWre0DmbjiKYltzcAC+Z94H4lF7lQ34f1tCUYzQgx7Ct2hi76JmXZ1uijX+k5DCJIGRteeOzoGoOe8CIrR1gXi36j4E0uWxaVT6zAPpvto21gFFgJZSZXHSBmeFxsmAb7bAaDs6zNgQ3bbD3XFphBEkmmRHT6TOdk3l8UdnqQUFieGLqu0zEQ3TVoCy5wnOGwP5x4ALVQaim99mi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLn0g+KyLx7qkwFZvOD+2mXP0g7uhTyXicY86RghWKc=;
 b=fSsSUoUYHQcL/pnxrMldgmvHfodS1LXen07PavSr7bf4YNtXgVHMXe6IXEKVBcbV6FUVYyczoV1bFNLcM92AmW9+Xgtd4YXSrOq7Ni+U/DUfe9EeUSjoC3JZq0b0pJ9PyMY97bIGIw9yAK87UaQ746kXWtMky/a/WojHM52Zb2Qh5s3gXRVHnPF7Z70/q+RzgUJctMl7lzf6/Ite1UOk3mqPx8RcjYr/tlEfiubwFu56RueW0u+H2oYul6LqKiN8yAZ3qHzWzzIQekA1gM0onqAEV73DWbN1kJZrSBOE1XNQ2nNgpgOY8C7szJa7HSEGtHICsnkiiJjfGSINsVC55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLn0g+KyLx7qkwFZvOD+2mXP0g7uhTyXicY86RghWKc=;
 b=d1iUP1INl4Tsu0lI7C9IzY10GlvGsB8hLAlGkxys7d5Vf1dx3QnQbeLBWv9nFhPPUvHSiFJS55K6Jkkj6duMU86RhxoEnvkjEQvMybMX/i1pox6rcX8jWT9yDOdiHsREPe8cN7u4NZJIrBDH5HwVYwf5YHpGo5dJUD0WXZvBusI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6785.namprd10.prod.outlook.com (2603:10b6:610:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 14:59:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 14:59:40 +0000
Date: Tue, 19 Nov 2024 14:59:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <989cddf0-a3af-4f84-8b68-876e811a8795@lucifer.local>
References: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0ea8c5-52c9-4a0b-0f93-08dd08aacb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CRKnxMO1H/khuvXyAMHPgfhzJJBWAs3rIEQmrzXliZuq+C0xt4e3vPSsHV3W?=
 =?us-ascii?Q?pHiTl/PnNo4B0u5cocSJYehLomnGEny7irHV9DJiNmTzg4OeOMIQAB7nz/qz?=
 =?us-ascii?Q?O613Nt6PrxlpOlgI99tmqnDh6X4FfBcqBdi/uraxcrr7Tr8Ck2fASVQv8qXh?=
 =?us-ascii?Q?wvEJMeatprPJZtmoUT4VPZPiPXuftwLot/XbKYJIOk9P7bbg6DIVerZj+QLl?=
 =?us-ascii?Q?hulgyR5LnNCXJkSLE0fkl6oLkRHBSeROn9TTeULlEYAeJZLn0W0ybnSpV1nN?=
 =?us-ascii?Q?nOJZTfTZnf+e3CUHSnxh463uDUss+XMAJplv1ufQbAPXasRd7VTu6SQbaN6N?=
 =?us-ascii?Q?RAL08H7k8LDs29XMDWQzEnRjL1b834ns62crO8sjMd/9lU56z+HUXaQVf7YM?=
 =?us-ascii?Q?oph1Mh86P2dBsUi94qJM61JWZyfDUjzXKrJMYBm10G+VEKdvvqL9CD4eNq0a?=
 =?us-ascii?Q?vnGeHDK3kxLcy1iZHbGk6F0C5uJZZ6rYhhCHNxFgnWA6svijaikYi6gDTNBK?=
 =?us-ascii?Q?Apc7Wx+xCSmU1s3xO68YWWhTnc8KRNdfdkEA/IRC4Eg3g8tlVDW7U11xmL+I?=
 =?us-ascii?Q?mAAUAaOKKsCUsuCnbbBcJ6L7Qw+8Zs1+9f6Gb5i0JIjVjUjOuWnrmvKEaUv3?=
 =?us-ascii?Q?2qMrMtXiNlDTqr7j3Q3HQ/ie3qlmA+5mqynn7NGuGmbzBmxlwxOZSyTcUOXi?=
 =?us-ascii?Q?o4V0Tcg6ZB5REid0qztjMWPUirwqare5Q9mExbxCMRdwtG7yJkzynoyYCpAd?=
 =?us-ascii?Q?dRiKa39SNztqTq/IRNdcT4HYsOl/0GNVbvlv5IYslsgY6KTKXUJh6Z8+f3Ki?=
 =?us-ascii?Q?zANSY4BmZ0QyJNgm0G+S9c3BU+Vf0VSP76Ia5ns/NoOQz/7F3b7hvHnwIbz4?=
 =?us-ascii?Q?+n0GT6dIFljezy3Qv5o7pTlISUUlIaglCyRFUllJBd/KSUffuq3USifxwzb7?=
 =?us-ascii?Q?VEz5A/hMmPoS4LENXuyDm6NXSyM1xAl7gnhOFdbTYCVteyddSzL8n7v1aU0M?=
 =?us-ascii?Q?zBB5Uycr/qTTS45hTWi7WMsrQwCVvTqff0uXLq1jaCz4nzz19Nttqlp2Fh7l?=
 =?us-ascii?Q?hCmtrVF4km4mqx2ljIPT/svSeYYl+rn5maBvMdHBuIF359srgjCQmsWnR0AB?=
 =?us-ascii?Q?0wRshz/8M4ici2/U38FCb0lSO4heMZ0qjW1EAWQyFtFfHP8AJZxDf8oGziY3?=
 =?us-ascii?Q?07hCR62KjPGZSXLtN+qcO8gCkBC4Eyvb3gMLYkFCNDNB9aJ23b2/of58rY6f?=
 =?us-ascii?Q?HvnGtLacb2kaWfWkf14D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufN6kv8ZArAXB0r5R2062eeGsqTuVo0UmSaJJ1/eVYhj+Oi/mlkSfektjIGs?=
 =?us-ascii?Q?lr7hddqAYo0RTcsJvlkZwIqpks7UcnKoQNyRRzXGt5O90eL4yg98DTZDokri?=
 =?us-ascii?Q?Sb34ZBlu3iuDzxMjJwqYjbU/iUNOCVcMiZfjhj/TOkjQyTlKJ5QWSbqQlDax?=
 =?us-ascii?Q?UD4YK11Yxf7IC/6sqtI6YXEcF83SSUDMD5HPmJ1E77A81MtHfPy4lCAYdOvq?=
 =?us-ascii?Q?1Ny8vFhmDoFwC3MLjNJpgqHy3h1bXiiHxxyKhKvjCF928O3WkY4iVAxWiwWN?=
 =?us-ascii?Q?lc+TBsGnBsKzXc9sp6una5s/ftL2u0ejFUPe9VvPoo7MspvScwp0YW1FfAY+?=
 =?us-ascii?Q?JKnw1bPKru3h3b9xIu1VuZWS8EMx58GfIozszIZRMmyjvomfR23eao8sw9EJ?=
 =?us-ascii?Q?FxYEQOSHmbvzXM+osfEFqsi2Sf/Wis8XH0vpTML0JKpgdIrw+lnZRdgK5Pt/?=
 =?us-ascii?Q?ImydAwkdf92NM2UtdEsyhquYUJYQUxAzaPOJmx05pqA8680zjEbPRt1bnz6x?=
 =?us-ascii?Q?v6c86HkBdUmoSwx03h+jk0kaOOKHJYZKqumNmAaTI8Z+eSg8MToPB3zySAEB?=
 =?us-ascii?Q?lBdaB6uJyVnmbXCjj4uaQZV5r+HIXAO64Hu0dvpllnDCSDwgXlfZiNgJjYZ4?=
 =?us-ascii?Q?P5ywQ0zPxo93oc3lU46hO834/I9+Tr+AqXAO8Xm58Yr/ivavjnM/JwvG3ueJ?=
 =?us-ascii?Q?dgOVMPkxGxh32w/B6GFSbMN/vGld2syj/duTRQCOtH6h0X9lVvx2pKjZv1uf?=
 =?us-ascii?Q?KW1tRZo9M7iN70jnJinsZ5FKeNiObvBcoE226wQeMqzN9uEa8yNnjS5efu9O?=
 =?us-ascii?Q?Kk9Nnz1ftalhoyfu5K7vg/Ccjre6gaY5n/OpqIuOsbCSASUWwHPoSIZ0Pj2U?=
 =?us-ascii?Q?AI6JirGy6MRTxjUtuOlONmYaCm9Te2jo2ZDyx1UA2xLgM4s/uAp/xprgl6kY?=
 =?us-ascii?Q?NpESTzMRXmUU77cglFwHnxefh1LKmlm0vkQr4vpn/6LyAoDmAd8NaKHYxDhs?=
 =?us-ascii?Q?2Ow3GvEak/iDOU4GZ1igpgNITCtftu1u4ctLr3Al9lhszvXUEMt86kVTA1x0?=
 =?us-ascii?Q?ZBdZXPhGMs3UgDRW8He6phzL9LSTSRfqpA9OSIAYKpyfj5PNWkcpiw9g60lc?=
 =?us-ascii?Q?22xK5DHFl+pCAZw0eGhReXthr+Gpu/omDWisoPJJ+WcyKmEgj+R1jtaAEoH9?=
 =?us-ascii?Q?pmfOXiDMxmANtGFCY+hyOXZvwU21vIlRDfJQOWI33aVCahTl0Xt4t9FoLbcL?=
 =?us-ascii?Q?myrAkaSQbq9DRIYIRaFttSlhSZDj/qwJTg1B2q6xdQ6thVkoM3aI+/1OCU3O?=
 =?us-ascii?Q?Onse/dbGqmog9QzWnHCtY6S1JMe+ZKQF8qj/Iu4iqPe3hoE801mNoM+DbHaS?=
 =?us-ascii?Q?jsDHox1CgfSa13t5udQpp4JD0kxRaYG90Wk7pwN+WSIsc2IeNFYvsmNluOhO?=
 =?us-ascii?Q?LJycQq2QrP/aTsS+n7+krr5c92f4DCts6nkTeDNdoHFuq5x6WxGdcGes3oEJ?=
 =?us-ascii?Q?p0F3xYLAAN4xxDR8L4XvbgUSLsmAW0pmMyP9Q3fc3GSgqlXZxvOII4WB+5Zc?=
 =?us-ascii?Q?UvqpFU7o91jTWS1G2HwvNp8dpr/YBJsbD2zf/pS76PcK70Wo2xEedHCLlAWw?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bopUe/F4cke8lLCgHt4jGru/OKTcXNgWgIdx1UjySaB3dJRY4Zz/FbKdnha9YvXUnTxbquXVjEUuJyulsC6HjhJjzAspKTH0fMbyjlRDeTgrEiz7NOkxOzlpltcNDZyEn3HOiFqQyOEcpWqJXZuJfNOVxotX/0I3k1cyv9JZkbL8ZbHvkG2GmlFZTbr8nEQBXqdTLjxV1uRRrxETp8VLifZ43uJ+P/VyGzlXzXNhKiOH01wpRK4dXpPm4KL/7ivC/peIc2mQdXj/UehXEdJA299AXisG5YLQNQNrqg+JVzuQVjrowb5gJEAW+bxJHAoG6CHzgAYOEHPFrLpmLeHnwsYECdy+fmROhT2NVUgzW3Q/zfAKEIVxpkACasCsxIcHb3T1s5IrYiRWF1j54tz2djhbrCAWw+UjR3qogS+ASh7ekekghwuQ/jIa+OSitFE7hmmQojHeovjH/WBYVQGnTYJAKthOfTcs6hwMqhPXhqp2/ZkzLjMwZNaDHReC9eX7/erdYrfqG9aHP8BryYqebOhKnlpOeeVedLiywS6sEHzRAoHog/1AO2Sk2yVCeL2SMzPeWkeRI67JGiE1Y8mAZHJPMNmLTnRW8D1r5LYWjEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ea8c5-52c9-4a0b-0f93-08dd08aacb0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:59:40.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBhd6XV+VEZQ66dVNophOY6J6nUv3TzOBEp27cbvRxmQkgUE+fgMuzQ+NqNHj2wCcqjerk5nd10qQr0s87BMjikcvlt6XtGzyQZZF6HH3MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190110
X-Proofpoint-ORIG-GUID: BnoyCENuLr2oswSvewwt7ysBgm6-eVIy
X-Proofpoint-GUID: BnoyCENuLr2oswSvewwt7ysBgm6-eVIy

On Mon, Nov 18, 2024 at 02:40:48PM -0500, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The mmap_region() function tries to install a new vma, which requires a
> pre-allocation for the maple tree write due to the complex locking
> scenarios involved.
>
> Recent efforts to simplify the error recovery required the relocation of
> the preallocation of the maple tree nodes (via vma_iter_prealloc()
> calling mas_preallocate()) higher in the function.
>
> The relocation of the preallocation meant that, if there was a file
> associated with the vma and the driver call (mmap_file()) modified the
> vma flags, then a new merge of the new vma with existing vmas is
> attempted.
>
> During the attempt to merge the existing vma with the new vma, the vma
> iterator is used - the same iterator that would be used for the next
> write attempt to the tree.  In the event of needing a further allocation
> and if the new allocations fails, the vma iterator (and contained maple
> state) will cleaned up, including freeing all previous allocations and
> will be reset internally.
>
> Upon returning to the __mmap_region() function, the error reason is lost
> and the function sets the vma iterator limits, and then tries to
> continue to store the new vma using vma_iter_store() - which expects
> preallocated nodes.
>
> A preallocation should be performed in case the allocations were lost
> during the failure scenario - there is no risk of over allocating.  The
> range is already set in the vma_iter_store() call below, so it is not
> necessary.
>
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/mmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79d541f1502b2..5cef9a1981f1b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1491,7 +1491,10 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  				vm_flags = vma->vm_flags;
>  				goto file_expanded;
>  			}
> -			vma_iter_config(&vmi, addr, end);
> +			if (vma_iter_prealloc(&vmi, vma)) {
> +				error = -ENOMEM;
> +				goto unmap_and_free_file_vma;
> +			}

This breaks the whole thing of these changes which is to avoid having to
abort after invoking mmap_file(), so we can't do it this way.

As discussed via IRC, it's probably best to do this with __GFP_NOFAIL or
similar to avoid the abort altogether.

But reaching this point is very common, since drivers will often change the
flags, and failing to merge is also very common so we need to be sure this
is a no-op if no pre-allocation is required in the _very rare_ (if even
possible in reality) case of a merge failure due to OOM.

We store in the vmg state whether a merge failed due to oom, which you can
test for explicitly via vmg_nomem().


>  		}
>
>  		vm_flags = vma->vm_flags;
> --
> 2.43.0
>

