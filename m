Return-Path: <stable+bounces-146186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8452FAC2076
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6034A0332
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EA22A1FA;
	Fri, 23 May 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dU10i2Vy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NDHmQNNF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5A22370F;
	Fri, 23 May 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994473; cv=fail; b=F9WfcCUBlOe8P2aS2Twdr15iGKRNhh7r4hMVvV1M3DqqOz+tpw5mwsc2QYupLJQM0xer0h79UdZw2tdwrLBNKK3JKqzFD0t2ZJWwYwBlYJ1Cg3Q5IidYvtJQDxzttaVGJtub/bYKI4WIMAzzlGwKpH3oJEWDhr5K27dX1TiEDew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994473; c=relaxed/simple;
	bh=RRy0NQcUw7LhnA7w6AFQctqOu2summ5RvF4/EVXuoQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmjJKkUyINCn/jZAKlbGvdunhEjS3TAGlMeXyW8Dg5IWw7PfgTTcCC28zYhkOpkeOkZEDabMd+mKpM9rdnRrsB+YT8zjfp4/7KzZ/30k1x/vBHtMnnWlzZEUXZbapEAmz2tht9MWJRUOp/Q/K1q41HPJEwuGz6L2B8fXcTXwfrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dU10i2Vy; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NDHmQNNF reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9i5na012236;
	Fri, 23 May 2025 10:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1jPRwa6Z5etqRJe+lbR3Wes8ApiY2/RyhsoDm/XcT3o=; b=
	dU10i2Vyb9DiuMYz74G8PYFdcIf3GBS7A5By62smW1gje9DtGDsFsqv9rPatuT4b
	+17AF13OhCfUVH1B1c/ECuCQIz1eo9RMztDUiyM8rfKOefwKgct6To84kdY7B24a
	QwP3Iz4+TIIrwUogJYVQLqZdzeJXAJd4udspuk/l8GQ/TUM7Y21z/FlCzBciCg/p
	2Zy7x138m83mx1o3gbO++JIlx/nTW/gi0dKWRa0vGeJfbPX3IoiTFctJFIA6Wwmt
	4OodWLdg3KAAoGk/4/iYJ4IXqjbKX5t4C/4hl/6Xks6d0/tmjsADiemTPQ6MsDsn
	mMZlgraNNhFO4HELSvACMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tpmxr15t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 10:00:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9If0b032159;
	Fri, 23 May 2025 10:00:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweprje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 10:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b98nZGJ0DJ5O/lwwqQFmL5LU/m8mpc2Xp2np1qF+UZkX75KUmMHWusouOdMN+PuHknqcrYw09TIkEm58XUh8EA7MEGLwUpwb9GcnyLeffkRwopU21d6BmqqePDnDY3ojEX/ewIwyeWEnUiw8jwI96PLsdkS2kP7DV7axiMvsYmyJGd2V8eynpIUauI6QILnwUgwrVlDlCmcd3y3WQCyiz0O200LMylTa3d4CUkQkBoDpkqeEJwu5iK+Qxh9P+LQEoCbXkziooFCSwSk4w9hpj7Fha1RRoLrKMggXBS9L1NzoPv1+NytkYi7oA5qefsg4wTtiHWwRp+kiCj+jzOFdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wokRDvxMgmbgPhy32Tv5nUBs7M6ARebZH7KYuymFKGg=;
 b=Za1d3DER+gm7hThlDz/bNrFJW6UAdBStLXSQ1eBsULDJlmMEnWJ1UtqHn6Nt7XLA7wFbzp2yujDMWeZy/mDfjpa1COqQQk93j+bGaXYjCvtupNLLBhJScCDSObQeNkzO6frrU7XeER9Gn2KpGIcCmWCIsQVP8fz125rTylx6Kck/8oCou5WPeqIzG/ApCTP8BPjXOnI8A+R5C8CEvLQi7zoIJAZ0qeN2xGrF89t78Mv0e0bnEEfFMJSmoVxQczpYhEs7FoSbGP3hMOgSXpBNKY+0vIiwvgTHqzTk3tF35EkrQ18JKDGIdmunaGDmwD65HG3rM74a5c4Mn2hV8ju5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wokRDvxMgmbgPhy32Tv5nUBs7M6ARebZH7KYuymFKGg=;
 b=NDHmQNNF5C8ukWL5fryv4QsgurokETz5gYX1+NPYXZU3Xe0F1YOGWUzdrgfY6FSgAvMTITibexjDErwShXTHbKBRTZHCZnwO12YCMgf18fbsJsKmSEirGQdLjWpDjVC4DV6RisO793LLKPBhJXohWDweYZS8gMTZLxZtbPvBp94=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20; Fri, 23 May 2025 10:00:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 10:00:42 +0000
Date: Fri, 23 May 2025 11:00:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, revest@google.com,
        kernel-dev@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
Message-ID: <afba02be-21d0-49f2-9ca1-36ee6f7fe27f@lucifer.local>
References: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
X-ClientProxiedBy: LO2P265CA0240.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a5f1f9-0bae-469e-3234-08dd99e0adce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FiNNPygiUu3fgWG61bQXFay5SCvnl+D+fclPPQ8u423XBeYouyBb5Afx07?=
 =?iso-8859-1?Q?2Tt+4dtdCbiyaIFeP+Y+4cD6XV0smiYjUubJcUhV+EE+6a6khGXjZmH12a?=
 =?iso-8859-1?Q?YC+Zyw5Wo1+z7ymk99oEmfwQPKLPxVymUftLpYazkEdJ9AQ+kX7WcYqbSl?=
 =?iso-8859-1?Q?O98fBoas+Cq9Yn6HlUAsGCeWstf+umf1CNQ6L6Xs3hnYfmN2uxWyKlxst2?=
 =?iso-8859-1?Q?J5GsBm96/3op6uSJafuHYbBIXPe8KAwyB+f2Xi05zSIhkApYCJ3/obL3ne?=
 =?iso-8859-1?Q?tQHloOA559UAOAiAEunaaLY7KlUh1S6yPYWC5VfhdV7Ld1GNONBHzV7i8I?=
 =?iso-8859-1?Q?4h+JP/+IBt4qlChgP/m+DgPnVrO1zj04kTPMLjzuKvbYe5NPn2O0+FbrHA?=
 =?iso-8859-1?Q?Cfe1sdrSO5KueaCfcHr0cx5jc6N1ALv0p4yiM4bFaO1fVKRPACRwl6DmzI?=
 =?iso-8859-1?Q?OzxSi220OoPlf58+V8Qzs3McO+uWR8zBJtc5+dum88s+92GGEl5pNcWidU?=
 =?iso-8859-1?Q?XaGRHdpcbRDmjOEZNKuVD6m+KjEGofQRG4ADQlfZZKoWdNJii1z1IbmYAO?=
 =?iso-8859-1?Q?L56RAgKaixtpthwO+ONjytGgrbngTyQOAAq6GB65YTEmqdBP1KzbhgRbEg?=
 =?iso-8859-1?Q?fYqDPlUivj1RPGQUhjkeKVxR4kKns3wpITeW/MpKDMKIfR961t9UKqOks+?=
 =?iso-8859-1?Q?pQCW+R+1qhLV1sL5JbMF9XH79hE/E/q+97AOt/3QkfPsBUfkPE355jiXiv?=
 =?iso-8859-1?Q?ayq22kv9gZoPzFrLRCmAbUwZ7I8pbDYtIVJBg6KFSW8uOPhjNHyQmNi+yo?=
 =?iso-8859-1?Q?8gSaHsUVGr/ONU2aw/6zVhs8eEt5SWw+COCQQPeE6itNZnQX/LXqLOZDvG?=
 =?iso-8859-1?Q?tHzI2MZCCw01eBdj4+cy6PL59xg4sFpIdhIB78qucXh1kyuvrXasNMlNSg?=
 =?iso-8859-1?Q?Mh2dyEo+ug9h0ooPXQ19qN1yllbUdc9ApURxByW7TkX3CMLG8KAALiEAYP?=
 =?iso-8859-1?Q?cTCDGOpxKXF4cezf0vO/xw+ZN3RJUjIUDYmPhdgjACgzajt83vPOg4FptX?=
 =?iso-8859-1?Q?Bs6fWoRdBa7Ulnh0Fc3b7vB2EvdaTUlAeh7deVsWVTSzZreKogXRhojrid?=
 =?iso-8859-1?Q?6YluCA3ROwidxApbFm24u3yhLNQMDvW8naYItDSUuRz84Q/M0grtzhvH5q?=
 =?iso-8859-1?Q?FAEstkVxXnQBoAEtFNWfI932aKMZgbQ4vsEuPQwaZ9lDapVTkKnA581LPN?=
 =?iso-8859-1?Q?en6eVqwGevTEPowLgaq5SoLVjno2GZ7cXvO4llh6s4e4jAqsWoOoN9r/cA?=
 =?iso-8859-1?Q?oFYAfVV4ekJAUHAkBeY4Fa3j6v3CyIste6vY7Tv6L1vTryp2RByJj9GWTx?=
 =?iso-8859-1?Q?iH1OkQu5xHrIJ/qPofBJScWWEPrZadym7qgwy/A6ypewgdeCAZQSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Ewd9IGNPktgcf2xIJKcIgxNErlWqeQMCb4j3B5KyF4K8iv7WGvW8uXzQ2p?=
 =?iso-8859-1?Q?6OAMD05dVofRieOmNqhitggHB1vHgRZTdKe6uxvDmUf1stMhnLocMqZhoE?=
 =?iso-8859-1?Q?ALWUxlmoArIHhimGZNn4QyPEGBR9L7vbar7AbLloHY1Pqrd4EHM0pUTL3Z?=
 =?iso-8859-1?Q?mlqP0LbOOmFj5a0Ksuq2UfdXm/vejgriQ8wN2U3KgP7lr9BwO3Apbgvioe?=
 =?iso-8859-1?Q?HjWMjdahzttgtfuU1CXCKamhLom50iZLlwka91NeTvCCfWJMAi+T9XWmBQ?=
 =?iso-8859-1?Q?u87jk46kTHifcxfpVcxlUOgn5akVNPCcwVYc6y9Uva/Jf6ITsHteqXvv9+?=
 =?iso-8859-1?Q?7dchJ+FaWCx08PUQykmPBMcs7CYN9lUNn/6ACjDB8l5diFxyUNDWIyMxOB?=
 =?iso-8859-1?Q?wJIVbc+UWk6+UaAGi1yDcvu7d6OA9uZGfG64jVEC+TNcy0S1OUGPSM8Dd4?=
 =?iso-8859-1?Q?XwIHnP9JaL/HEa8ibSanEKOw7J0OkfmeStUJDjc62Kot9eTFECM1zjTswo?=
 =?iso-8859-1?Q?PPAMulsRonlrppVR1DVhjyT47Oxc4vF2DALtwNOgDzz1/33hb4pmeQY8yB?=
 =?iso-8859-1?Q?Fx3DHvKkdBHDRdKG+wvJhtSucQT+7jBKKr5IVWIGe+oVlWfVpuJYYaWKO/?=
 =?iso-8859-1?Q?tx5oozfQ8F9VI/YqihhSii8qi5grLumWBNHNrANzhauOJIsNP3Tij9POPb?=
 =?iso-8859-1?Q?etTHNM15AGDrb1DwD5uuGcmjjvzcAzEsv4sHtr20P16SXxI8NnqYRHSOte?=
 =?iso-8859-1?Q?gw2NOr489NXWcNOnhfpS75GVtOf27t0PTGWxSLTdZZ8evHnU5sFVoJJsgT?=
 =?iso-8859-1?Q?VRWKW1Y8PWph4Ar7Stsu/7UdfkaI/mN1FnnfgsRFbPnnCYE2Zxmz9KNkK0?=
 =?iso-8859-1?Q?QHjmRPvHEvnh31DWBUCcCOBIEn7NcY7e4lGzoPc25yyvuCg4AaieMkm7kj?=
 =?iso-8859-1?Q?Q6zvNvy7krUgIP47Na+sNtx/BXwN2En6TRZabggSrTQktmqkQfnGuJULmn?=
 =?iso-8859-1?Q?46BRCQhcgDft9ovMlN0VeiLBVEnEQe5OiaeebEuFw11lZ1cNJjOCUPmwqz?=
 =?iso-8859-1?Q?J9mPWuG1D6Pzf4wRoL/zQBhoJE/Q6hs37mxCQ68x73fnIRXJtCCs6HGLfK?=
 =?iso-8859-1?Q?loin5c4K/ysrM5b8gS8oby4/ct75PShTQsC0fEZGqWEi36Cp53nyKi9eti?=
 =?iso-8859-1?Q?y3HWGGY5IOaXmkcxv98R5jxUCn6pZjb+ILaN986Ij321ucr5KHftecqxPJ?=
 =?iso-8859-1?Q?wB3svpru1KP/RDPHPerTPQTw4xenirwQ9zFwCsRWWp7Kx9o07GUVPVdjbQ?=
 =?iso-8859-1?Q?jbrGQcaOlQ6QBgxyghHdI8glizcJeRvj90Qin3MCqKKSX/NewgUMz60qHX?=
 =?iso-8859-1?Q?Bqh8yfw1Qr/PLR0PaDH9jpVUED1k2X+UNDQ4eNDSr1c8b75OIa6X0mnFyv?=
 =?iso-8859-1?Q?PIeoqetR4bh1r+WbqGSHjrwicWSsYDdLqT439L/bik74ZjOesnw6qzmLWC?=
 =?iso-8859-1?Q?uECEEfvpkssv87LnICFoIH6+vu60ELqy37nM0zhn8BWsrELR8/O6el8ZZo?=
 =?iso-8859-1?Q?lg0fd051Rw5CUjx1DebtpNUJkPbO5m5vzvk/x07910HQa+EMTUABJQFUK8?=
 =?iso-8859-1?Q?wUDA2qe153BRLoCsjA17+cofAe01x8KWnoKzrUoYzx/oJdzq2HGibsMA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3iFVM2lbA5ctGWkkUy/wY1luhTilDHd1dAyTd2/Ui4U2W+kco1O33JO45d7kRGVlt0RLCavLvP1evvRNQDXr0SaP1UUbLTBkOz12CeBoArS3JzfDQJ4XqvHSFqyh4iQpxswcJpTGX7ajaNMkMoOnM7hGoaIDYOsrncFpDDphmF0o56CjBFqxBAg0lXXhA9tBLWXZX8Uf9T+8ogFdJpZQjOdpaiQv4mbCil2+bvRgdDkueTA49U/CN1ZofCVv6eZa3ZfkZMhZID0kstjQ/C4lsP0+erg7gh2/D6Rf2bdGQ9d9dAFazeXiMEWWHc9xglCZ8J/ERXyNhtk+OJlVvuV1iw/hg+p3UScAnAmnEYmLxKRBSmhU4C+7KbNy3jZzQg6ZdMeWgoPET7VaWZJ4YAxrh1vvk4ba4RDYnBApo+PInplW+0MGcqkA6c+bWAHqJhIE8jgzv7UGfH4VlsABG0NC59a4s6qVwDHN7RpbSymtBB8ruHywn+rZgbetsegnf+m4A9yVzIdQfeQqk+S89Jnx12XQp1kWW9hSTtbWDf2ui1U9GhyAXomclY3f4RRAeTxucdYr9uylDMZdH6Mftwgt04lj4tB911SN9cGb/KNjo+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a5f1f9-0bae-469e-3234-08dd99e0adce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 10:00:42.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEVF1Xs2vMh+Ykw/kRI/l92jQZkOGIxjUajQX1Tm0SKknQhsffVWCeeXZRzM7YIIo+IwDcTAZvf4zYuF3E0EzZ4WeQlM5w7+ntur/hNVHlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230088
X-Proofpoint-ORIG-GUID: r2MqSB02B5rNwNDzR30DFEHrSreRoJ4E
X-Authority-Analysis: v=2.4 cv=BdzY0qt2 c=1 sm=1 tr=0 ts=6830474e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=V2sgnzSHAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=WYxXOGqRqFjejIk87rMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: r2MqSB02B5rNwNDzR30DFEHrSreRoJ4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA4OCBTYWx0ZWRfXy/pHIwClWWVh XUhP2dMyOEPGWB48B78Mzc4bty8SXxIrqJ4wzYaOL2sKq2a6SOxM7YSq49MyVzqQVaRldu7pMK+ NFbIVcVDwGtTMSzIplPn0PMi9Vs7c/XfW9ZyKt1S7JxA7LkjAe+CEE8R1FrNIVVE5JkTHdRaadi
 825ivcodH03c39ACI3wu1BAF2rME4jBlL7MeHHmp4VN6cFkaI2T169miq+Y5yHHROi8rDurgwNA h1hEWVJ0u1Z3VmAz0iKNCcM/Sm0iWuLU5xJXtHcAQiQREhyUz+LD+BF4gCENT/MZLSQo59AXuOr wDmoxkm9VC3BTUX3CASkFrRwKJYb1fPWKJqins0M5imzP3XnE3LOyGLN5kvy8NesQ6u+2aF9AZY
 tC7uPfTShZAuLjIwBBwqfCtvaSc7qNk1id/AoyzCs4erC0Tlc/zHk/Pot61b0LoeXX36oO7o

+cc Oscar - please loop him in on this as he's looking at refactoring and
improving hugetlb as a whole! Thanks :)

Ricardo - thanks very much for this, TL;DR is - this is great work and you found
something painful :)

To be clear and to quell too much concern, this case is one that won't happen
realistically in reality - I'm see (afaict) your syzbot did fault injection to
get this. This is because the only way this could happen is for
vma_iter_prealloc() to fail, and it's really subject to being a 'too small to
fail' allocation, in other words direct reclaim will simply keep going until the
allocation succeeds in this case even under extreme memory pressure.

So this patch is perhaps less urgent than it might seem (though we should
address this, of course).

On Fri, May 23, 2025 at 09:56:18AM +0200, Ricardo Cañuelo Navarro wrote:
> If, during a mremap() operation for a hugetlb-backed memory mapping,
> copy_vma() fails after the source vma has been duplicated and
> opened (ie. vma_link() fails), the error is handled by closing the new

OK so really it is _only_ when vma_link() fails?

This error paths really are a problem. As is vma_close(). I'm pretty sure we've
seen similar issues actually with a miscounted reservation count caused by
vm_ops->close(), hugetlb seems really sensitive to this.

> vma. This updates the hugetlbfs reservation counter of the reservation
> map which at this point is referenced by both the source vma and the new
> copy. As a result, once the new vma has been freed and copy_vma()
> returns, the reservation counter for the source vma will be incorrect.

OK so looking into the code I think I got it:

copy_vma_and_data() already does this:

	if (is_vm_hugetlb_page(vma))
		clear_vma_resv_huge_pages(vma);

But only if copy_vma() succeeds.

Even if the page table move fails, we reverse the operation and _still_ do this.

We do this _before_ unmapping the VMA later in the operation.

But now vma_close() has screwed things up in this one singular case. We need to
fix this _prior to the vma_close()_ so it doesn't screw up this 'two VMAs
referencing the same reservation' special case.

OK so your patch makes sense.

>
> This patch addresses this corner case by clearing the hugetlb private
> page reservation reference for the new vma and decrementing the
> reference before closing the vma, so that vma_close() won't update the
> reservation counter.
>
> The issue was reported by a private syzbot instance, see the error
> report log [1] and reproducer [2]. Possible duplicate of public syzbot
> report [3].

Ordinarily 'private syzbot instance' makes me nervous, but you've made your case
here logically.

>
> Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
> Cc: stable@vger.kernel.org # 6.12+

Hm, do we have a Fixes?

This might be a massive pain to backport though due to a certain somebody
initials 'LS' who did a big refactoring... :)

Why 6.12+? It seems this bug has been around for... a while.

THEN AGAIN and importantly - I'm fine with this, as this is a bug that I
really don't believe can be hit in reality.

It is however vital we fix it so the error paths work correctly, especially
if at a later date we change how allocation works and fail more etc.

It matters more for the future than the past, basically.

> Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel.txt [1]
> Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel__repro.c [2]
> Link: https://lore.kernel.org/all/67000a50.050a0220.49194.048d.GAE@google.com/ [3]

Thanks for links, though it's better to please provide this information here
even if in succinct form. This is because commit messages are a permanent
record, and these links (other than lore) are ephemeral.

Here it's a bit of a pain, however, as presumably the repro is fairly big.

So, can we please copy/paste the splat from [1] and drop this link, maybe just
keep link [2] as it's not so important (I'm guessing this takes a while to repro
so the failure injection hits the right point?) and of course keep [3].

> ---
>  mm/vma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 839d12f02c885d3338d8d233583eb302d82bb80b..9d9f699ace977c9c869e5da5f88f12be183adcfb 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1834,6 +1834,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	return new_vma;
>
>  out_vma_link:
> +	if (is_vm_hugetlb_page(new_vma))
> +		clear_vma_resv_huge_pages(new_vma);

So,

Could you implement this slightly differently please? We're duplicating
this code now, so I think this should be in its own function with a copious
comment.

Something like:

static void fixup_hugetlb_reservations(struct vm_area_struct *vma)
{
	if (is_vm_hugetlb_page(new_vma))
		clear_vma_resv_huge_pages(new_vma);
}

And call this from here and also in copy_vma_and_data().

Could you also please update the comment in clear_vma_resv_huge_pages():

/*
 * Reset and decrement one ref on hugepage private reservation.
 * Called with mm->mmap_lock writer semaphore held.
 * This function should be only used by move_vma() and operate on
 * same sized vma. It should never come here with last ref on the
 * reservation.
 */

Drop the mention of the specific function (which is now wrong, but
mentioning _any_ function is asking for bit rot anyway) and replace with
something like 'This function should only be used by mremap and...'


>  	vma_close(new_vma);
>
>  	if (new_vma->vm_file)
>
> ---
> base-commit: 94305e83eccb3120c921cd3a015cd74731140bac
> change-id: 20250523-warning_in_page_counter_cancel-e8c71a6b4c88
>

Thanks!

