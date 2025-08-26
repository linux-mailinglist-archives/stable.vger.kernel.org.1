Return-Path: <stable+bounces-172926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C7EB35801
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA5D7C1245
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9B2FF17A;
	Tue, 26 Aug 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lPNM951J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ejPBippp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31A2FAC05
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199036; cv=fail; b=t0dPnN6g2w/EAohth7PKTQO817LCMR6C0Dg3d2nl9TPgVRlDSv/uU+qsVHiAzip/VGvqIrN0GrrmVKVEAUk3NBSEPPB5VSwF9WVuwGgkA77AeOqvyr0I2JfdczICxs86UFGkJ5aF8anmHL5cCyharAhasNcyN9TSzCOfyN+DsnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199036; c=relaxed/simple;
	bh=SfOXnnoE/VS+NmVtIZ9NOuKu6/OLofzfWFKNlye1cjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bmsaHLbddWFe7Jf3QEOCXacqcYMN8vXYirPp9zHVHDPsjQPF/i9zaJuuGSNgBAuYLdR1usZ49oympOJuzcKzlJ314EtI3+HENDF5VQvjCGFAuFPxeFGAgiQQanQriF/FoUTnrGahBXPzgA+F8paZHIdazEXi11omG7DohudcFwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lPNM951J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ejPBippp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8m3Na013818;
	Tue, 26 Aug 2025 09:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Y8UTdBVoI9KcoPqp2u
	spimpTyoTvxQPajoOAeCzlH/M=; b=lPNM951Jio6+3pccevN5J1kkfcNYc1SO5N
	NMRmubn4zADbCY6vS30IraTj63d5ZudBuXRaIc6ynmVd8p7EVtyJHvcxHlg/PG/L
	0FOK9/fn4mOV43ZB41U4JW2naZJCGKtd45TFblPj4YqsSRn0QW5180PdPOcbwiQe
	+R0/IW4UHjrczv7C2eKW8yZVqL9tkyQDak7iGCOv3os+GMgSg5rYiIgtDeB60SND
	u/UTQaYwqgIwuqu028vG5TxRVQnt88SUlnEsH1KOUQbayvDU7zV/tChjoskI+01x
	t9TBguS8vxbDQHwHEpr5tVog+urcwM71xXyPkd+B8B2xoVqyXRJA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twarsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 09:03:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q7cLeP012107;
	Tue, 26 Aug 2025 09:03:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439932x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 09:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDz8ucyytO+hHh9t1W5WDExuKZ25FcTZCWEaIQGv2Xx7F9EQ6RgdCputt7zys0INpQnwg+JLgc2j1+2JsmWIM4mVvikKqaEtpGbqef5KFkeNdwQEtksc1Op/ZALCAgX0swf6+xvn+OU9cmO44lKjfSCBGny9HRKe2fBRca9/fEsSyXWdZqH35zBc/JaiWRvYCTSPfZB6NnjAeb9hnhwGvsewm9WvxE3OwATmallnXa8NBjXxfIjEMNii/zi4EVFMEP60npYF8zKDFyjtkL5WpsD4gSG+hKMKCuiN4z/soMQPKSHYH/m8EIqd6WfsbpXAmGjbhDQYWR++9v+k+SA1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8UTdBVoI9KcoPqp2uspimpTyoTvxQPajoOAeCzlH/M=;
 b=wcv/eSSGnINeAkYuPvdqf2yqadAAxCAoBVfb5NDgQCtJauU8nCRTk0u6ikY6t6sGd6HjmRPfSBc1vJQFy4xU1I+pnt17+7caMiYLRT31BQbu7nWLTBCGVo1UssTmni2BijDKW/kWPLtydRbTmdtnUu6n2W7b8fBvZTydwF6evjr5R4860oMweKPo8w+aIDYedO1U+rr/JaknxCOVe2WSuPRfHKGXfquOfn+El1yLXyxzm0XEGR0JYKsQ9K3wi6A/eBd2Mg/ACTVFknTIulHIRrguEqQ8HXnleKrP+sErooK7W0pKbaBIgnpiSfRuXgNiz03BmP7oHz4rE+bxTBqnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8UTdBVoI9KcoPqp2uspimpTyoTvxQPajoOAeCzlH/M=;
 b=ejPBipppMopG0KLYFv2lTdgKDQgBlU79RTpf4DrNQ2cLwIshxM8rrbxuzNo2Nr91034bGUwsp7yClHUi/AU24y2zmpWgeyfA+qQpbxZLA7htVYiEQ0d1Z0j+eB9LI+6tNyJ9kqGZxdz5Y0agAIX64MlRGEzx7c0qW3AMoRcIvPQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 09:03:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 09:03:30 +0000
Date: Tue, 26 Aug 2025 10:03:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Message-ID: <e9342d11-fe37-4df4-bc29-cc7f7e0ed38c@lucifer.local>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
 <0a2004c2-76e7-43ea-be47-b6c957e0fc14@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2004c2-76e7-43ea-be47-b6c957e0fc14@redhat.com>
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b432cc-fa6d-42b6-b5a8-08dde47f6d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBthv7XVxbS5ozdcnn1o5zycPp+BTO2JBRDTrzEPMbmM0OLAsOEXX/uFym3h?=
 =?us-ascii?Q?OzT43eC3eyOhScUq0yquQAvnnz0+pUwvQ+VWXjA/viRD+ETSgCuNBn20J0mu?=
 =?us-ascii?Q?2hOg+w5+MzlkYb6nE3bKaIWxKdcr+DX1d8AEGB93lZin2g1qPw9N22MeL58h?=
 =?us-ascii?Q?hFt8J3Z7mPZ1pFDp793qI6WJ5lEt0jZwXN38t1Fu5QtQJXfhQF1JM6G6trtx?=
 =?us-ascii?Q?A+EsXmtn0VH/aBDJke6wWFCQE9fDLdw0TGINtd8qfCbpvN3z06aFyvs2yoaf?=
 =?us-ascii?Q?N4pf7FbK+6fZGFfqiuAAreOyh8wMIwZeO1tw/bEpYjIgMI3iBcPdc4fOi06u?=
 =?us-ascii?Q?Igw/TDxWSp+JmqI8uD1DhhbyaSQNKPKQLFCXTqaMFK5TsEq7Wb2DLPucVGZf?=
 =?us-ascii?Q?n4ssHQtN/uPKDu+aVncbNttJBjWwM2CYHbN6xPm18xBUgaMoaLHryLLkN6yf?=
 =?us-ascii?Q?Jm2EPn2uYqfpdLcsOG8OrBtlP27ub1hT3pQRhlC0H+uXwr6GRefHI1UjDdIv?=
 =?us-ascii?Q?pykNehA7KZGPLmp6fkU/2yRQnomKs6VzBJDEIOd949TXDVlMA5Y7Uht9aUil?=
 =?us-ascii?Q?ajcMYILFpyV4zNYEo7JCEJCEUwCr4mb01FSQHpnvUM1+T9irprsOJZGpaGlI?=
 =?us-ascii?Q?q1VZWo8mPkibQzisqLugK4keBL0PkcuerAJ+fn/X4aCKc4GedDhIrjyo2ixU?=
 =?us-ascii?Q?F/TD3rnouokfM19BXwgBXADA+M2swenLfMRoozLj7bVeECgGVdkbNHUXQKOu?=
 =?us-ascii?Q?GAdazVSu2NuJVp6mFfCKcvRdKCAnQX4Rt4m5dLuLZ4NJBeCGZWje1zM72Tmm?=
 =?us-ascii?Q?9DWu8+RzEeKSt4Kv/1YixRAO6kgxbqnTbIvC/Aez/bPBmbhCO1eJ/VZryEHF?=
 =?us-ascii?Q?x6r6Cra18bOj2DyNa1jlAJcVPVTZBoUDH/IK3yjAutIAaINiazH1qKPzoO4J?=
 =?us-ascii?Q?3fO2rY652PSAB403AzHE/4xzYSMe/JSj6ESWKyh6vjQrAWCL3rxzJM6AOX6c?=
 =?us-ascii?Q?/hIZfTd0vyzElO+mC4vNjTXahr/KZhM4znC8IdfDYF/wAUziIcQ1TyTWhDpL?=
 =?us-ascii?Q?3cdrP97juUSn8g+ngzCSOA2wm6eEk2M6XhWVRaTJ1lOt+X2NkpuYQcTL9xIW?=
 =?us-ascii?Q?O1uxFkd4Rv0j374HyUnW/fCHAWN5lbelaazeF/iriAfW8JK/kx4kPiKvY6UW?=
 =?us-ascii?Q?MkqAbHjO/gwuSQzvWG1jpgUg8EVDx8tU5FLEqBYFZELo+iELe6KNKlkf+/2P?=
 =?us-ascii?Q?tzV7CrelmyxNrI0Pm4CRH5o/Z5bLgMPsVRmL6JJ2yScivLSM335yKQS7pGg0?=
 =?us-ascii?Q?tvid7fOQPrY8IiZkqvawWmjdEeHqEVR5tSkewi7rZTftkve4zvtbMDBcNHCK?=
 =?us-ascii?Q?8At82JjtGq55fZsurCDEReev3eVzrd6RhO0MZcddojOb+hYIKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RtSzZAL7mjMRteO8YvUD8Pnuo8VC906RPWgIJlN4K+e3x5AQbUuXH6WnQyD?=
 =?us-ascii?Q?G7ICPyYpzJe5adGN+QeCwny+qo+PxjbqgQ3SYgdoFmbsUNMy6kAYtl2iGj9b?=
 =?us-ascii?Q?LyG7iNyxMidr/4/LegsLGqbCTAPfoSTiYiN7rc2LyYiMFMe2qzYUjjTd/S26?=
 =?us-ascii?Q?Ek7mjKm28ymU/B5JoGmmBEo5h2hxhWibtwQfN7dGYHQQmuOysfIk0U7x091C?=
 =?us-ascii?Q?OdsGwsK1/U+8dOo2dSz6fQHzzRF1jAOOzhEBVNTThposjFtbNDvxG9jVgc76?=
 =?us-ascii?Q?tKYP44tY7OyiXGFwRwdAN23AOTM73DUytcLD4ks0sfZYzTwh8uDYjXhF1nyd?=
 =?us-ascii?Q?IWFGonon73l1ADMXFoVFDAurif5Fn1xOhwYvAnSwhGtqBfjVLLy7xgZzEQdJ?=
 =?us-ascii?Q?eKd6Bvs3GbT5CaR8ORk+7Q6TL8CrkcNgykugj0jVOOA8cVb/uGKbApYdH3Z1?=
 =?us-ascii?Q?8VqrKefIDSVaroLcE1LNZgnjG2GnY5USN/uaoFZmmDXlWTOfzOIsoLGcnrmq?=
 =?us-ascii?Q?BtnI488x2h8a6S7ee7TUfo38TNaj30KVWCj2FqmpuCKxUkczvSkGlyfAO6Uy?=
 =?us-ascii?Q?qm0jb9eQTAS+q+35DTpwZg8wcQiS8uhZMkeC00fZULE6syLnLsMdW74xqq+z?=
 =?us-ascii?Q?yqwpQpL1YtAZR2icto/exkVazBKW/rBsV4cpcV9m1w1/WbZ2myiyYJd8oh66?=
 =?us-ascii?Q?L30T9J4EEgHW75V5DTuKcSKZrlTdIrIrwQCvzr4lBxggJdpAhzBIgMpqcNtJ?=
 =?us-ascii?Q?9BrvsgrL7eiotg5O8UY98Tco/d+VIeWxQZhQy+frvy2AQfUu5OVfpUuxUQSQ?=
 =?us-ascii?Q?EDDxtvfnqh3jX05OoxJxPtCS9VguWoY126kq7duMHpatD7pTy3dnF5iBUfdU?=
 =?us-ascii?Q?kscrAf8Wge3Qe7nmFJGby7P1h1kDLakRjaCuI5CxaQvo7SftOfLYydU9awuT?=
 =?us-ascii?Q?FMH0LCYCjsw/fkgPU+xSYnzmSGjevS7o+5vpWERXKZtp96vl3ZXMPYe1Wb3X?=
 =?us-ascii?Q?Kmerj2vxBcaMOGPjPatiuxdJ1fxickwb7ovR0i5efK7Zr13EkzQYrjDLFjMc?=
 =?us-ascii?Q?Ag4jbkVrm56ZlWdKyzYwabF7Jh09kw6m80svXn0hFBm8nCdUGyK0FE8Mm5kG?=
 =?us-ascii?Q?ZCiXakCdcZxooAnCcluO8LJAIh+i5rMVZa4EKpubLIDsxnGba7IGg//JzTUU?=
 =?us-ascii?Q?nDH+rNPptMAhoJFtKz25k1XoDrdmJea6kIZaK5VRoEwZYKYENtSdgWFFLg4G?=
 =?us-ascii?Q?kLwgIiclEitofF/t6Uyt5ZkwQQ/OFbbHtNaRO557ZGqrz0IhDVUfl85CITa8?=
 =?us-ascii?Q?1AHSdAejeH6NTsS2qzBkRfmI3CBOh2/ifdWzVrwR0UDY8sxrRmCHOLZtmL/P?=
 =?us-ascii?Q?vQSLvI4TSbYALBGMoBSdkMxyx3pvgJA/wxB58VNNCT2Tyzbl6Bo6+bbfE22A?=
 =?us-ascii?Q?SxOIhhcT6THHKFJdnPRUm2KctdhjT6cWsnTa3Wk1/3oQ8mEw/PxhuUCjmzkh?=
 =?us-ascii?Q?vI/KzDXFDNJnZ3+wzfTVrR+qrNGgWHOI61+44MBBMAnjeYYw7PgqqgiAZueG?=
 =?us-ascii?Q?M8fqTScyxgH4GsG4d9NMyj2iMdT5mlsnT/6WmaGOpkHRTKgLQEiHyaKdhRkd?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6vo7WnXfUYW1x0jHxfRScKWJDhko0a3tUFS+6z5X7Sb6NxdSiBG53wMtQROSRad38zv0KPQ70vGSkgX1/YLSlq3QzJuaUPCUHdODIXsKpFZeF38mSYqtqSGGSqgLBNfTNobMDw6W8mw9qhJgMpoYI4+4/rCqBLig4fwlVz78d13TcC0VCxnY8RKMYRmApZx0emV8ApVJvU2bkmkgCC9ehngbVbCURR4IHoTBxMdzq3F3PAJGLGj862rmifztIKSzSIO6obb4KiOgDsYXcvxYJjTRTjWMjdvWv2nPNEPhDyQvx2N4DwG6eVy3Zg9cOHWvXhYVRINagMZZoBHfnnBMK3PtsDNqHXhgyfzAGY0xYuM5r29LtotphZKwz0RTJC08vElhdIXQNqTs8Y7BYsWtIeCWl6MFyDBD7DMPG1MVP5WkMQdYPR4pX5JLkkhxUlT2CRMT85qP5vM6X60BsPN+1EjS4lwurh1cxL8BSdWDMiwuHgqTgS7zoRhBHYBS9ANNdRTKOFUEoqPHwxAevzy8Pafw90VBPkDQ9p96pXiB9uQa47v0THN33/3Wci2oCa1HmpHnhGtt+8EvL4LaU7RzywHmhlapKN8X6AKU9oow0gc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b432cc-fa6d-42b6-b5a8-08dde47f6d34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 09:03:30.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIMUCua9tin0AVxWWZKU+q2ETvDmThR82AD3NTkZuwgc/otdUCKlvlrJ/MCbIEmraLy6MqXQhshN2etMABk0mq5WR9lb4ZlNFsIN3EfFzqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260080
X-Proofpoint-ORIG-GUID: exSlUpJK_sbT1ZeYvcn3AAZQ5Cuncq_7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfXz9PoPWoQhkAQ
 0+2bWsa5lURRcZYqE2tyDbaundYatYBqeEY2YzhiRAg8uCv1sa/0erOTt67eO3aybQPvPoRAAA2
 ckL5cBrfwjsDTznJoHU520en2xkptD9ZvcYeKhsjdurqZ6lWNRirUlBrmf2O0s3BaAAOH8/RUdf
 LC6JkTb60slykOzLsrUuS42nPQ8GrCaggAJ17Y7QxOkfNekWmgVa30EbUwlJCPHHXn6xk405LW+
 kFuHRuDVITF+H2WPDitGX2XuQUROvq3YB8FGmzuW9cjFjwldMYK+BA/b7Vv/gy5zTWL1oR024J+
 a+062LzT4s1fEcwkVRhxfgie3HdxWtdpWaQ9XlyhPeg75lzZqU+CBfjwtiRC4wPfW2aiH86jrry
 FF4WUY+7NmKqkFUc2zRvtCjhHE+GDQ==
X-Proofpoint-GUID: exSlUpJK_sbT1ZeYvcn3AAZQ5Cuncq_7
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68ad7866 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=N2g673orZsZYSPfrGyUA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12070

On Tue, Aug 26, 2025 at 10:53:45AM +0200, David Hildenbrand wrote:
> On 22.08.25 08:33, Wei Yang wrote:
> > Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
> > mmu_notifier_test_young(), but we should pass the address need to test.
>
> ... "but we are passing the wrong address".
>
> > In xxx_scan_pmd(), the actual iteration address is "_address" not
> > "address". We seem to misuse the variable on the very beginning.
> >
> > Change it to the right one.
> >
> > Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Cc: Nico Pache <npache@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Dev Jain <dev.jain@arm.com>
> > Cc: Barry Song <baohua@kernel.org>
> > CC: <stable@vger.kernel.org>
> >
> > ---
> > The original commit 8ee53820edfd is at 2011.
> > Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
> > extract khugepaged from mm/huge_memory.c") in 2022.
> > ---
> >   mm/khugepaged.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 24e18a7f8a93..b000942250d1 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> >   		if (cc->is_khugepaged &&
> >   		    (pte_young(pteval) || folio_test_young(folio) ||
> >   		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
> > -								     address)))
> > +								     _address)))
>
> Please just put that into a single line, that's a perfectly reasonable case
> to exceed 80 chars.
>
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> >   			referenced++;
> >   	}
> >   	if (!writable) {
>
> Maybe, just maybe, it's because of *horrible* variable naming.
>
> Can someone please send a cleanup to rename address -> pmd_addr and
> _address -> pte_addr or sth like that?

YES THIS.

>
> pretty much any naming is better than this.

I despise it, and I realyl underlined this on review in Nico's series because
it's just beyond belief.

It's terrible. I mean maybe even I will do something about this, if my review
load eases up at some point...

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

