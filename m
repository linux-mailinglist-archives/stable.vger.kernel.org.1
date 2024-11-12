Return-Path: <stable+bounces-92187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F809C4C0F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 02:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEB1281B7C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC922040A8;
	Tue, 12 Nov 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUuqgtuX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vSC1VOim"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A97487A5;
	Tue, 12 Nov 2024 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731376304; cv=fail; b=JSaDNjImL5SpgUBznrqJ+5qO7IbigyTUUir5jooLh1Dr7GCPeuLWZMItY1lvltnGdzKgkAswAYsplitssG/AY/Br40F3OlQ2O1ZHc2UDCXj2kVBGIrrVQlNlwW58T2atAxTLleVDOg3TGvZ/O0CEnx+REn3XLrPE4ShDMYu7MVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731376304; c=relaxed/simple;
	bh=WKSfrozAdnXhgs4/mMmrl7oe6U1Nt9TTGBjNnnt8lS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oC0srIYDa0z7+ELLhrAV0H5DXaT+LEGlwl7e/i6dPY2Ws4gIh38I9S7719a04ZpElHfy9at6sjiorkcM/kWvcPELEimWGZL3bHftjDp8khoPzd4z0TeH63x4JXKVlJsNTzoBgR6yVgsnob5uqgaqjI/Vlmf0zwpfISbR9daAW+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nUuqgtuX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vSC1VOim; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABMtdUj030667;
	Tue, 12 Nov 2024 01:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=s9UslJcy5NSLF4NgrB
	c7zkmDUtZWbQ4hBndcBt9q4+w=; b=nUuqgtuXe3iCp/kjCTGkN6IoY+69nSPUXJ
	m+eXnnoGUpYbN1Tj4+yTg/VlbrgzmJizwvP2V/I9Ig8e1aBtH4E+HvxrQsz8Q2sO
	KtyPFSvNnzRmzXYFmb6MAHLREqEE08PLxnIVp7pnGq3hct7kMPUcvws8R91celrf
	ST8Lr3NMc9jkLLwYw+pWoc1xJz5bYhF3dUZHNUk/AKf1FrID4NM7M7YOD8mfKy6Q
	h4lI+kCwyNY/VTAjjiv2kJUDp1pmzjct4OQyic35jPbXCVDmYRC/ZzgN3WJwVqOb
	sG3VsTIQihmKbqtwtOGk71tkWnktxljqdT0dLAXdLBFKZeWfkgYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5bd7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 01:51:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABN21ZR028418;
	Tue, 12 Nov 2024 01:51:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp6nw2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 01:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIx4EVrDwT7MmH1Ni7HzGsE6deflXr99EiWCBxfJ2K9mK6UDiyOWpo5wK2CmNW+8o1yX/BRhT7q3SpAhydOEoWGLnPmOInA+Eh/jzZkfT2rzlLxGS96AeayMMz1TaI8PhcQXglw8t7qs7axy+PiVnZ+9LLNvmh9dbkfN5y514GlHjkB4++x2LQ71GdOkKuZe8z05Tw7qlvvZ3Y4X7uvJr/vrxbGPch3EmyDZtXo39W9thmZc8qZJ5IXVKZLXJcRJGUPflH8/xPYcQ8zutuPfF2iPgazQvjiVfqtaZf8Z0zJVWz6VUEkZpJxS6xCqseLn2x+ehx9dsh4HNyMVb+PnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9UslJcy5NSLF4NgrBc7zkmDUtZWbQ4hBndcBt9q4+w=;
 b=TT4EaPjceQqqdJ3M7LrRMw7nh0YUPGJWFcDD1ydl45RcuAdMHzpe1TTiKspgTXiytn1eku+fSIP8WUQbLmcSZ656Zwb38yTQEKvVbIEaoZ1z0rsNZ5HoupHjb7A9ydv5+mcYT1mgA+eSbO6syZty2BdQGnawvJDo7LCmTexcgjzKIor2cyk9XEi3FhzRhWb0OxOSHIBGbGObH3qj0pHJuMt9cwGPry/4uS25ZNwfEw4Ex8n2wmeiVprW50ULdyMVFiyOlTFjANcvsFd8NK0Ls7Q/W8BTnETlVBKqm59eqeiy1eazA93DSMNNJJJ5gH68nrATJED6xSFI1BJnVA8f7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9UslJcy5NSLF4NgrBc7zkmDUtZWbQ4hBndcBt9q4+w=;
 b=vSC1VOimFnnLFo4rtO0FXrKfNNzhVMip3oPIPe81h1t3f6K5gudHjbNlah1fxI9KHaXL+oXRWNDZBYAbyOt1Pj7YH5Ngh0/kV0NxL1wY6Q3VznBQZIWgZg8rWTrR2qT8jwPyvRqqyLM4skUoDTd1MzKUpvTsalU9DrXtbQyIngs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV3PR10MB7866.namprd10.prod.outlook.com (2603:10b6:408:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 01:51:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:51:29 +0000
Date: Mon, 11 Nov 2024 20:51:25 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: Fix address wraparound in move_page_tables()
Message-ID: <aliths7obwfbrwj6add6v6vtdqrzqwg7rrmrevfetb3pabjajo@dinr4rsovgzh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0437.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV3PR10MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 705a2e05-6699-451b-5303-08dd02bc8664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnrLzqVH5ebmBWaEHwMlNmuvJcUuJyoTZvGn/KM1Cu+xQKcZcCYeaUb24p6E?=
 =?us-ascii?Q?vdJWUaI7H7EjmuZznjrHyWXmC6MCNFhumHF1KP+Vog5zPnZDZl1ZWxGC4T+S?=
 =?us-ascii?Q?ZBMUDk5s1RBSoDFKXotBZVRWRMXZ6KA0Nk/19WImmOtuvYHMtxlrfwojU+RN?=
 =?us-ascii?Q?pB5Xd7QFpSo/0ue1igWmGYEdgWs+ljDXIC9QDwJRDKQ0Ic4VQy6Ip8MnzWXI?=
 =?us-ascii?Q?RL029T7oAtHXj+JYOXTq3hWfjTNZeuNWwpWot5bxCLM5wGhHDenmHoRGAImD?=
 =?us-ascii?Q?4KswUmL2fCmotfuxhLv49yKTGtY8kGWXS1DOh6RcBhBX9Qyrqaq55+s9F0/U?=
 =?us-ascii?Q?EtlxYwgB3ArVGxrvCUrXhLJ1Lep4oFxWbjtPbXHeyWcvg99i5TkiM9GmJ7lo?=
 =?us-ascii?Q?lZRD7n0my9ipHE7R8lYTUaOVwJC2cpPLel9hyFVO4PpCdyhQqYuyszII/heg?=
 =?us-ascii?Q?6h3XDMzHX0h7/rIxtxzTz3hdO2FT8fKX0ucwcn4WMXbU/1rrZgy98gyxGkKx?=
 =?us-ascii?Q?V6waIM3E2+Utp+vycRe98FmuFgxonB944iu2TEylcNpUFWSyuMf6XmxRX/kk?=
 =?us-ascii?Q?sALivP5zmh/9uNKz7o7KueEIwsJP2nPdFosUsUkJCh6MB1v995uXSiDvm+Bb?=
 =?us-ascii?Q?mlRoozff9v04j+i1C3MGHlgjIsBDAJ7kAr5f5C7ob2pxGIkT92z2ovpNxKgJ?=
 =?us-ascii?Q?2JNAT8u12R2+JMrsOp0qJeZ1hzOxcxp4SnIKd1uCAz4v02Pb8n5yjEUAr4UK?=
 =?us-ascii?Q?k/Gs58tVghK13uSMaoFcHkpY9TlVPszB9rKK/mUtrGBxD9UmsHPbAVU0e2rC?=
 =?us-ascii?Q?pvIzeXP+Yls79rG82guO/rbMq+W0tnDXqRf53FX9dp0o+bCMhdeHwa4vv1xx?=
 =?us-ascii?Q?3FggLYDGmjpMZXgjZSlJ6spkIf7PAd3cGOhdjpC9aTFmOUk8CHohguiHJUqA?=
 =?us-ascii?Q?e7K6LB7uLVdNUaLGxas118Ajvrp7h9gwLy/EtmVt3DdsbbLylKj0AU8Y+0cL?=
 =?us-ascii?Q?Gc8h1QUUMNBRfsylDwp+SDymuqBGB2043wo5czNiioZyZ6x4/8lh04AdfUyv?=
 =?us-ascii?Q?dgcEG7ibkq2R7Bv7cSyXcL1oC7Bbmts7XPjThuFATNjl+ddaiaHXgkCzLnu6?=
 =?us-ascii?Q?dHLrpNOHCRFBKu66fxH/pLl6qRhdfsRn5W/2kaOvwnAfFiZw1dR6UvPn4WEh?=
 =?us-ascii?Q?XzW0gUn1+1z+1qzDJHn1Y8cdF/F5vcDQ7c0XpdJrcaFGZre7CBSqC0696WD+?=
 =?us-ascii?Q?0XYkSDpR6ICyv7mI4lZkuiRjoq1OSIPIiWwNkoY23nMb/18Kaf4lzKQ9Psvi?=
 =?us-ascii?Q?NoLlmu9mh9raQtcOtzZjbWsM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wuk6svZ0b5xJiJBnnmPs4hxepbgQqYxSMApqBEKVlu0NOKxDi5brhPWaTiFH?=
 =?us-ascii?Q?gYSRle2jEj4Hm/JVqKumS2wqx98rMpx9jY2qpStnT9rg281zRd3a7wXpC3hq?=
 =?us-ascii?Q?fC2tfTBMNxpHRY1zf+XLVeRhhQCJ/jYvZJqNZzH6j8lMKAwBmTHp2L66hBhC?=
 =?us-ascii?Q?l6NaIDJAkAN/9J6e65iQNmhzJ64qxNFidCJ8xlbq4nJCuUg15GqpG/OhJLqy?=
 =?us-ascii?Q?yUB9VSCfJJwNnompsMP+OKhoQGM7pu4sL45YMEtC7ig1dZ7ZF8BoQ3oYxDbA?=
 =?us-ascii?Q?UbESCPZ/cvoO8cULC6HCTYX939XIQIDycs3TXpkPPEiS/RBdx20I2YwLVenl?=
 =?us-ascii?Q?tVJEKW1/FRRXHKvNOFI9/z8eeDVYLmUmSd6VxbML9CXlVMKoAuTX9nYJkTDR?=
 =?us-ascii?Q?fif7eyPwOQx9933hmXQZ8KoeB2P0113ZAkcgvbQWP3E5Uet5yIBOB6UkOpHM?=
 =?us-ascii?Q?Mo/H50fY5kscGzYpTXbO/QyScTRN3XaKNsCKkyJGSbdZZj5exwVQpWlezCG9?=
 =?us-ascii?Q?iAayQ6Y43qYHszn38h2wlZhLb72fjQQlPV7LB4w48eDyvKp5v2ltzHeaXwEt?=
 =?us-ascii?Q?mCwPQPvDeA/0TgF6Bu3nZTNnMyfzN87LhPEsCtjrtZ7lOnnxr1UL0bsdwFiF?=
 =?us-ascii?Q?q0cGkDVtWdEjkdJmfZJ9QFy75OraJiIZDIcPqYXZdiEkW2jlgQ7QginXDrb8?=
 =?us-ascii?Q?Glla5G6aluxP6wfd280TFgW2fjmmi7hCz0TJibhz6xI57DEBITKOk4QspLH3?=
 =?us-ascii?Q?6AzLSt8wkElt/9+ub0AnpiQy51HefS6k551CKL+0ncubjTTmjfmG0bFIMWWt?=
 =?us-ascii?Q?/nA9+TysnO3aJs1ShxDcMUD8Un4uu+Jd4oi0UTMt79C8yiR5RbhT6bZeq54b?=
 =?us-ascii?Q?gR4St8Tas9vXYtThGBsAxPduFOuOfxExSnovQyIdRqYSr+Cq7vi8KM0DsCFW?=
 =?us-ascii?Q?qAtwdeoNX8AQZ7cn3Gf7ZsnVQmUdx3rdy7vLERPki1nN1bOMauPEZkiCAYiL?=
 =?us-ascii?Q?MMug7nRsAUUDfckh55SAWXx19dxhchHu1P1W8PfkM4zIRK2KAqrWJM3QcTpf?=
 =?us-ascii?Q?gD5HN7F1CnBl5RKZy37C2FcbS5hbyUFe9x+wLQ7U0j90iOgYtIrrDyWtDiWa?=
 =?us-ascii?Q?NqXKEHmgxc8XqZBYAGa3MAHDlfmw06QeKDLbWagJgHYz+EYOoPRc6NgTgLhx?=
 =?us-ascii?Q?iR1dcSGHlMmKde0SzZhv/uwsYsg7R2PzgXlWj1ORecf+hPqBCCHZOMs+IVVE?=
 =?us-ascii?Q?l/P6TDswjgG/l67+bMe+JqU6Waqqq/5bsTRllk7FIK8yFBl+/i6mexMCyp1l?=
 =?us-ascii?Q?OlsH0+2vi63/Dvm4ALsFFDgZwswjix3d9qRSd2jKfcoeWBmk77GhD+v1uaB0?=
 =?us-ascii?Q?8Bf1hW8CNdYdRUyBaosQfOBy4bVutj37tBBDNWjeEGo1Ql2vfbsTOH29WSAa?=
 =?us-ascii?Q?pNJ5gJUVfA5/Cj8Vj3c2TDpTkkv/BKgOlzhrmwpVUcpgZkarXZciF8aaqAVl?=
 =?us-ascii?Q?KpkzKje5+5jF4yEfJUa2Z/fdkrLC29yOlEak2zfHHu1XiL7kvVzFSOGQ8D9E?=
 =?us-ascii?Q?C7Y+01i8WwUxZumxLtSzsjaKFVz97WFKSX9mSlMn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FcSgZfWKPtd/l1V1lKFkxhe5vaJTVMljKYSg7iPvNZpBb0rTIkBISuJ/LKtGj3abuzbaJZdRhs6aBRlxbFzmdVMPqMP4XoGmXgJDWpi1f20yxbGTXt9NJlPq/02eoT/lUXQwzIC3kWrVG6yxtVudRnBwa85oSs5ztJ5vNDqouL0XXWfN70nGQhwBZUqVaui0uwiy4bkAJTXqxCuAjcm1QzXo9xsJQuwYfd/itkYBzOnz2B8GhyCQAye/z0vYGmz7270lZVQO/M3UeK9rGVoWnNGUu7KTiGMdukpNZKAVgqN9M+SHaDsfbinA1Jc0KVVKI1xjr7peYrqwhw2airJOnnC/ERl+9ofMf5t2Nhf6kcPVzURCawbQNThxxXlm07Hhqv9/z6F9JD6sVcqcj+lndFMzrwgHPdcG3z0+DaKE6Ie62reoj8ucNUc+H8GVrbyEVxDNVH6yHEmtfyvpGJd+W5HnpKysOdo/ciT+/5cv4ykbiY1+Q44UIZXNJFeHzGANqI2hepsNHOZr7DsTC7/y+UVk3uEvOjsVPEe05jTM9pIalzMlA5fWhSIltViOqhlUHxCpeB4lCutKzqsU0vvkHyAg7p9FkEaDX35iqDm4bs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705a2e05-6699-451b-5303-08dd02bc8664
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 01:51:29.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErBqtjPoPMpuMENKtdm04FUARSdRtbc1B+iU/uYMDcDQcI50bxG2EyeSzgr27HNbnvPUztbrn4FWseVbcn/gDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411120013
X-Proofpoint-ORIG-GUID: _mJeRogUY7GGVya4tp9JZKJ2gkl6epxq
X-Proofpoint-GUID: _mJeRogUY7GGVya4tp9JZKJ2gkl6epxq

* Jann Horn <jannh@google.com> [241111 14:35]:
> On 32-bit platforms, it is possible for the expression
> `len + old_addr < old_end` to be false-positive if `len + old_addr` wraps
> around. `old_addr` is the cursor in the old range up to which page table
> entries have been moved; so if the operation succeeded, `old_addr` is the
> *end* of the old region, and adding `len` to it can wrap.
> 
> The overflow causes mremap() to mistakenly believe that PTEs have been
> copied; the consequence is that mremap() bails out, but doesn't move the
> PTEs back before the new VMA is unmapped, causing anonymous pages in the
> region to be lost. So basically if userspace tries to mremap() a
> private-anon region and hits this bug, mremap() will return an error and
> the private-anon region's contents appear to have been zeroed.
> 
> The idea of this check is that `old_end - len` is the original start
> address, and writing the check that way also makes it easier to read; so
> fix the check by rearranging the comparison accordingly.
> 
> (An alternate fix would be to refactor this function by introducing an
> "orig_old_start" variable or such.)
> 
> Cc: stable@vger.kernel.org
> Fixes: af8ca1c14906 ("mm/mremap: optimize the start addresses in move_page_tables()")
> Signed-off-by: Jann Horn <jannh@google.com>


Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Tested in a VM with a 32-bit X86 kernel; without the patch:
> 
> ```
> user@horn:~/big_mremap$ cat test.c
> #define _GNU_SOURCE
> #include <stdlib.h>
> #include <stdio.h>
> #include <err.h>
> #include <sys/mman.h>
> 
> #define ADDR1 ((void*)0x60000000)
> #define ADDR2 ((void*)0x10000000)
> #define SIZE          0x50000000uL
> 
> int main(void) {
>   unsigned char *p1 = mmap(ADDR1, SIZE, PROT_READ|PROT_WRITE,
>       MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
>   if (p1 == MAP_FAILED)
>     err(1, "mmap 1");
>   unsigned char *p2 = mmap(ADDR2, SIZE, PROT_NONE,
>       MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
>   if (p2 == MAP_FAILED)
>     err(1, "mmap 2");
>   *p1 = 0x41;
>   printf("first char is 0x%02hhx\n", *p1);
>   unsigned char *p3 = mremap(p1, SIZE, SIZE,
>       MREMAP_MAYMOVE|MREMAP_FIXED, p2);
>   if (p3 == MAP_FAILED) {
>     printf("mremap() failed; first char is 0x%02hhx\n", *p1);
>   } else {
>     printf("mremap() succeeded; first char is 0x%02hhx\n", *p3);
>   }
> }
> user@horn:~/big_mremap$ gcc -static -o test test.c
> user@horn:~/big_mremap$ setarch -R ./test
> first char is 0x41
> mremap() failed; first char is 0x00
> ```
> 
> With the patch:
> 
> ```
> user@horn:~/big_mremap$ setarch -R ./test
> first char is 0x41
> mremap() succeeded; first char is 0x41
> ```
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index dda09e957a5d4c2546934b796e862e5e0213b311..dee98ff2bbd64439200dddac16c4bd054537c2ed 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -648,7 +648,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	 * Prevent negative return values when {old,new}_addr was realigned
>  	 * but we broke out of the above loop for the first PMD itself.
>  	 */
> -	if (len + old_addr < old_end)
> +	if (old_addr < old_end - len)
>  		return 0;
>  
>  	return len + old_addr - old_end;	/* how much done */
> 
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241111-fix-mremap-32bit-wrap-747105730f20
> 
> -- 
> Jann Horn <jannh@google.com>
> 

