Return-Path: <stable+bounces-181468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFA0B95BA0
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4F07B497F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E62F2907;
	Tue, 23 Sep 2025 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yi1lIQjN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XgZBZTAw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E42287503
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628003; cv=fail; b=nstNu/hAlEzPRxiix+Vl+BmMpGtXU/cOAeytZbaqlrrz6q8pNg/RtsuznMsSv6NgnP4m1eJE+KttKxM4nPKeUqGZsqjZIpJcScjOuBrFqlKDdTKXJxs0F9+0rGe5OsmwzetxMuufm1YpZPbC98EdhKNQfH1ft2VkSfDMwdNe2Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628003; c=relaxed/simple;
	bh=ogCXC/RcOb31PqQHZ+54ohMTKrFla3iCvpIq0MH3gu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVX4zYKiAp7anhtk9FaclNfNHMZi2n5cN36ReFFHFw5jlU9whxDcEanf4ELIdveCviEHFN/psMYq6d2gQeDVf9MpZ31Efd7YupUIPMgmifRrCBakxwvRvcMUnPdPLCwsy9fo/I1BdXD0eP5KoFbwFMtsH50Nrmqp19ZyBT7nRNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yi1lIQjN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XgZBZTAw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7tvIl006636;
	Tue, 23 Sep 2025 11:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gS64qx+2+6E7VGX811
	BNRfn7MZ5OOsGz384CQhV0k3M=; b=Yi1lIQjN6WLcLCiC5DPCsT5dK+ofKEiMGw
	2tJ2P6AtL8dqNP0TgaxdNL4S6iS544LOZVVtKzR8R+sNmgWHY6jz870mwjXS5wHo
	6+9q+/H91e+5pZ3NotL0RQ+RyNyMcGuG37Uabscub7XaUykZKZbHr/gZwuVVFcJH
	27Ctk17X4XNrHkKkvF9XanebMqixWXAGQs+UzLFhjBUBWQrSrfwDUIPlDMYhl7lz
	vs0F/jjz/ysVA7eIXSXhsIt5mn7mWXjZJA9sz3C53Ns3eJOxZodzOq0CBkk4xWzI
	6Dvev/jndUDo+c8dDrA8h/LynqP9K7sQDYfDauyJl8vjD/WtAz/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499m59cd16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 11:46:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58NBbekT002072;
	Tue, 23 Sep 2025 11:46:13 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq82w4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 11:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnM8J2teDUm6m77T/SLPCy+Tm/iD2NKo0tt494txvuwPFQC0F8l8j0OT/b2DLiBKaCW/GHTeX9H2PodcUy7wn0fO4qNkLfQgdtj4t9Dc9gZrRdz7iObWRHVxv3udZkPPZ0V9gZmqcGBSM3T+Q5fSDXShnUuv+EW1J7i1977qhPSP/KTxTdCHajoltEQyyoE4w5Dv97Av6NdaoEzA/4p7Ot7PvHOKj7HiX00SV6cWMGOmBM7bJ0+C4aEbQbKsgRGgscblq5Q1jVotV3xzFC5w0goHHP+uwVBIhY96571SD4Rv+qTLHXgMGyeOunYxd9LvywJhuDMH3PYmJyclWLVjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS64qx+2+6E7VGX811BNRfn7MZ5OOsGz384CQhV0k3M=;
 b=ivohbbePXpke1AvUTVT4byzLZzHa49DBKtWo+V28wgRhvsS/CP3E68dvaSd7D6s7OfAi6FECTidoUapOOawZTFxG0DZtNXykyFlZ7T3xl+WiBddNnVh36OQpPxy4nmwjwpAKFvnDxKgkze5zwu2Lg8Io74bD6cz77kpdy3GGL6POELVWDAV7b12IB/PgHcA69YDbamf0PgD3zXBsGQJLIn8jDQBjNRMtsX890f605IPmJ86YVCG2/YSCduCQAc6XXjC6pISXr3TGxtF8Zg5q2g7jj+vuGzf5YYmyVm5EYXCb7OywFh9/j7Tk8fwkVWfeAhgnpL1jA+1+3FioW/MUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS64qx+2+6E7VGX811BNRfn7MZ5OOsGz384CQhV0k3M=;
 b=XgZBZTAwes0SiYVTkpiEgFRVbMKkiHvpyA4r4ia47Nvl59poQmNJ1G2+iMqwwM2YOWmcpuBRu6Es1AmJM7FlmJuNiKagRnoce6vEz5FK+ZzvKvcZ8LFvsE8HJ0cyDVUaxl/j5SC4pB8Gbe+3TckozlB1DpsRXmWPe24NheXsWqw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA6PR10MB8038.namprd10.prod.outlook.com (2603:10b6:806:43c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 23 Sep
 2025 11:46:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 11:46:10 +0000
Date: Tue, 23 Sep 2025 20:46:01 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [DISCUSSION] Fixing bad pmd due to a race condition between
 change_prot_numa() and THP migration in pre-6.5 kernels.
Message-ID: <aNKIVVPLlxdX2Slj@hyeyoo>
References: <20250921232709.1608699-1-harry.yoo@oracle.com>
 <b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com>
X-ClientProxiedBy: SL2P216CA0129.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA6PR10MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cceac59-5031-4d89-a87e-08ddfa96ca38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S919p78ALoHs6SO/UpR8PxSFeLZToKrA2f+ymT7VwaLQ4WRO5NI1y2ff0OYv?=
 =?us-ascii?Q?SqMIxPND0v2XNz1AuA4fzv8FzdqNKsjClRCzaXrNu0+Aj/wD8KQcXEToB9MB?=
 =?us-ascii?Q?vhV1EEyXuiUIEInfE8pJOIBahlIz7ArWVV+eoXHGiXibl598vCNlW0/eKZch?=
 =?us-ascii?Q?cTVlRoSmrbL2gVK5qezP5xEjXCZWarII+SdL/fqd7leGeCxwGCI5++7Y5+mc?=
 =?us-ascii?Q?wkkrooJ5vrJQJQs+Zs/8oNMVp4AOvvJhOvfLNuZywILLqvtDxKZ2ZQ5iAcsc?=
 =?us-ascii?Q?7M0ByAkVf8uyp5A8EY9ueiwRcbmJIjAOQVpPze9yz63MGs7nxJbZWIhKzveE?=
 =?us-ascii?Q?8kE2IbYOZv4EQ0WShDaUS9HdR3fuRzEbHUXgXLZNJC8Akp1D6s7WqNb/iuLS?=
 =?us-ascii?Q?uMWbmJAcdRldFA2CzwqOmVeRtBaDEM9D92t63+xgi2y5tLJO+sgkwHpv38R9?=
 =?us-ascii?Q?v5Q6Ac4tWRVlFI270bur/msM6RnsZI/fHPk1KFnKV4s1nCGcGZu/aZEyVYa1?=
 =?us-ascii?Q?3D5W1qstgWZ/GNYfzcHvsDzAYknPN9tmbOSr4HiFSR93MZ/2d5HPSo8a2jHb?=
 =?us-ascii?Q?7L+6Oc91M1s6tuVLDmyD4QGWcUT9H+0CQgNmZ8gygou7wUP8Ix3tl2QePdgX?=
 =?us-ascii?Q?nUmifVmccXqivnekljbokf02a7fC1aee4Vmlyegx/fNAg0FnQmjH/Isn8ii3?=
 =?us-ascii?Q?GpRH+UDXJlZTrQPWvfaWn273qG/V2jZqBuRvrRO9PBMqyx7bELQWYmC7kGXU?=
 =?us-ascii?Q?n3+Cr52oIrftPfHYTPYaRUGWKCkqutVLrZmehs5kf1dP1/77+jH9pDdCgaL5?=
 =?us-ascii?Q?oRAKwtB7P+Y8wBTrVAbiemaIgttDcP/Noedy9wgmrA3iCFwlHh5y14sPtzk2?=
 =?us-ascii?Q?oUPhidWk2yzzPhC1Bpmh7sCuclXvMGYsrzNYG7PX5VS+z4rGk9jN3D9VMuum?=
 =?us-ascii?Q?0aoy/4Jig5hdA0nxzIifUMQeotzkUVrF7q3bl7U77vzCNywBSGON6JrVlVBj?=
 =?us-ascii?Q?YeFNGxPfq3GER3/xp570SBEQg/fo7+KC7+5EyU5FFCSULZuyQ6gzDZQavO6m?=
 =?us-ascii?Q?0AFcQwYhxoR9zJ8pYzndAAEev4DsYTevGk9gFY/h6I1KiKYABPmJRh+QrNXN?=
 =?us-ascii?Q?dnf8ZdxkeLmBnV0DTL1WWh2itBpkU+YuZDzA5PnJ0Xsqf0su21IqDxKKwrDF?=
 =?us-ascii?Q?+ZzdUr+ovoodic60HSWR2qKt1aSWwgNbBki1rK/hnLccuBIBgVPhRFO/Pfn/?=
 =?us-ascii?Q?GnOBFmRYsqThHyAomvuxw4ykJw/5XbN4kFcTujFB3fAa2lJKsHISYyebNwiW?=
 =?us-ascii?Q?vf365KeZoFyb0VD5dFI6s8Ddu7X0c12f/GP6VHyUnEqPyufPY6gSKUWYz88F?=
 =?us-ascii?Q?3mzLT4GZmHQd2DpWPf9vhJ/P+Q71?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCde2NW0J2BX76wQ3ZPj+tOLCNvlqLy5Xu/sRYnFIRtqmuqCNoYnnfkSAQ4k?=
 =?us-ascii?Q?nKK8BxPEyv0puSmZnMfvn3v8HJxJlpfgICiKq7YRAJ3eeVo5U+0maq6wJJIs?=
 =?us-ascii?Q?erU8Dpz7KA9SjQjtrjYCspw0qqiSu7aEpCBSn/6opv7JSMix+WbgVy4oInv7?=
 =?us-ascii?Q?z8yaWk8BLaYWZMbRc+UYuyIK4AfsMbup6ExcgXU/DxXciQ2JPdaV1sS2XOYv?=
 =?us-ascii?Q?cNr/DgzeAwvd975uazY5ozHgOTlFFiswU755hVJ84KA49I1U4CHMBk4tVv76?=
 =?us-ascii?Q?6BnsX4ms6rb7fJC9w7gA4IVuLj4X8cXlVOZWkfaQRlXdRtbf+5ISaPJyIxif?=
 =?us-ascii?Q?5s4gNjbHKhTzfTXGMwwgDQA6oBtW/nSlUH7QoJuAGmOeQFBKfw4MoBRX5FTd?=
 =?us-ascii?Q?iitvVwnUAH6gjX2iz1ogZvJRSKbz0I/08oAVdsdxx3H4Ymp1o8lHXh53AoQR?=
 =?us-ascii?Q?m7zMzWfAOc1R33GQ9jQtcYuckz26o6moU8YSwc0yx1oUuZkE0YefsKvAehKG?=
 =?us-ascii?Q?DUaZd9alh7Us2SMa2y6O1+0IpGH4uy10AvfAVp6prCDHb8XniArFoTiLfrms?=
 =?us-ascii?Q?RR1u1YiPaVtn/okAa98pT+V8hJHilaAqnZ643VpXQBze57WkY4e8nlAooGr9?=
 =?us-ascii?Q?fs3R+AJ1HjgizhL+S4dmnN304iWVEnb+GNqOQa0mJRCdv4dOItycb1vJ/a9N?=
 =?us-ascii?Q?mh9sfnHxJYllfLoIBhpAr19lI1grDtU//YRD7RR77NJ3wWNUfKa7cZ3x9cuc?=
 =?us-ascii?Q?dTfFGw+jDEmmEinMHVUjLhQOVoG5EGAKveViVo3V3VuVH8Q60IJBaTjHiDxh?=
 =?us-ascii?Q?RHuEhTh/jUb/zqK1+Zc1nvxGlSVOh8FIDrF2RaTLn2RA+rhKOA/N4MmMYv36?=
 =?us-ascii?Q?KBpLWs+84pEMFAIL1HKBfOzy2uCEoQRs3tUw02a8B8vsv+ppkrpq/Kw0mrLZ?=
 =?us-ascii?Q?33zIq3Y88o/Xt+jsmilqF0eA+n1fa86764NyKV/WjVu0TbRvRBKCh2+TSH4e?=
 =?us-ascii?Q?4tgRbANq9+cqUoTcHySmPoCPwaeK3hocdF2DhBJ0IAzCmIXZp6s5u1MJUGF8?=
 =?us-ascii?Q?f1S5c5AIZ8UJgHCOgt12H9ozGLRHLEOM/pi/52vR2CRDkwKmcCRMg5XXIkcg?=
 =?us-ascii?Q?4z7onXxNfEiQLaARk5Un6Nb8vBBVfgVpUOGN+Nwero0YPsfRfntB3bRN2t3r?=
 =?us-ascii?Q?FE/3X484qb3uGkO1VlfPfVCspCRz3G9ED8RgjJkqWn/j/8CyiaDVNoj/yw+v?=
 =?us-ascii?Q?UpQ7FtYA1/3oD0dv57x8pOld91OIiWqbkj+4aP19XBqIdO12KSu8OWFRJBCq?=
 =?us-ascii?Q?n+BMulWwTpXhXQvZwL8g+0Tsii6qFmCaaNcp5Hk2f4tMjW5qxuF33nTedxk2?=
 =?us-ascii?Q?ucyjnY90Ue0178XZg4wbixQt7tNx40cm+GMLVdorHWIYVCfcCGTDzF3CKUl+?=
 =?us-ascii?Q?pofq8qSpxBRGU4lSaFTAM6t2VtQamXjaZiaw5aYEzvlBK/Ycf+35LOiUc0RU?=
 =?us-ascii?Q?sYwRG8sMn7wUk0aRcbmYRapegsV1PsEJZSpdZ1/+d+MToLN+9oVN51OW9Wf2?=
 =?us-ascii?Q?L432sdC6YblSMfu6nB7fnIp4w2dxBeUCnvaA1ls3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aXtwD4waZZ205Gq4z8D0gv6w4htbXEd2cda4NSbIfcihk4xjfsPx4pNoV5HWjWGSDfViwhEXN6RyZVXyWO5lOI496YaJ5pseIcAeTttGu8jeUkn21usdqzr+G2UK6rScon3CYAvw0gbJxfObPp1xXm+q8acNyNcgpDXUvKHeTkq6pJu0XHaTffgMlba9PE8D76B5maIdRJt5tJrKSfbkHh+b8T6LbsYBjoupOSX3tiFP9Ur1Jj7scA5i5hjy9zxyuaSjBBkF3EfrBGsnx+UgfVJf4q8VzCMpp91eIpyCia90xPMD7al+7hLKm+nYn5Cyg0TCa6FCjVugDfVG7bhcMclZrec1G66LVlSkySQUf+g/bt9KDCnVOD9+eVBghFt/WEGy+kp0p8lmCZJKPsqWJ02Hk3f0c6rtvpAIll6F/QLTlFwt9zPK+ktYackzwM11l4P5lGIFJVqQ9RI/bfqGU4orLQ9eircCwlUMYJdD6vwjlqqejcKJR5bEOyQoaDO8v11qhN//FV8emndJ96PpnYUa9xJ7mchVOtfWrMzZAMuQsS2BqKlrjsMS9wpLDQ7/hqhmPzR2wjxmM0RIxYWWb+Y+XLrE8jH6AI0OJMCBulM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cceac59-5031-4d89-a87e-08ddfa96ca38
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:46:10.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpax5lxGcAVJc5HLmvoSwzNNVdXsCPo7Ys5bV6IwwAYedB9GkwJoEnMt1iHwaI4TcXXFc92fNfWoKdbo7lU/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230108
X-Proofpoint-ORIG-GUID: lE3iMij01rHq7rJ-k14x5ThXCAEUz9X2
X-Proofpoint-GUID: lE3iMij01rHq7rJ-k14x5ThXCAEUz9X2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOCBTYWx0ZWRfX8aWsxSqvYZsn
 NrMDlDFd+EVFsNZexkQ6hpROczLkzJOS3frErwiayc2UcAe3GWP319snxCGR+UeOTdCN3tg8hGk
 x2xnSv79xbB/vYAD9lrFQOEYOQjso79Axkht+L8Y5rrO6X7Nn2Curz+M8Xu2xokfrHhunhlS0wH
 oDRc14hckDXW06zUvCx/imqVcbgfCHXjX6CHr1K10Rs/bW+oX4vNtvy6Giikn2aboXEwdiiPVWt
 h834YApr8MUULB7fLQOK5I/nwE+07AGJpJ3b6EPYjA/zn8gYX4x37VrgOGtxhB/gCMbjlPJusys
 WsTkg2VfltQoRj0DItHPnIqayAwBxtZiwMgjuy5DR2meuyeTluZn+XNzQS3T35DStN53tx0j0Dq
 zMKJs2a8
X-Authority-Analysis: v=2.4 cv=HJrDFptv c=1 sm=1 tr=0 ts=68d28886 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=R_Myd5XaAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=qFlA8k2I85BGAsidc7YA:9 a=CjuIK1q_8ugA:10 a=1R1Xb7_w0-cA:10
 a=OREKyDgYLcYA:10 a=L2g4Dz8VuBQ37YGmWQah:22

On Tue, Sep 23, 2025 at 11:00:57AM +0200, David Hildenbrand wrote:
> On 22.09.25 01:27, Harry Yoo wrote:
> > Hi. This is supposed to be a patch, but I think it's worth discussing
> > how it should be backported to -stable, so I've labeled it as [DISCUSSION].
> > 
> > The bug described below was unintentionally fixed in v6.5 and not
> > backported to -stable. So technically I would need to use "Option 3" [A],
> 
> What is option 3?

Citing Option 3 from [A]:
> Send the patch, after verifying that it follows the above rules, to
> stable@vger.kernel.org and mention the kernel versions you wish it to be
> applied to. When doing so, you must note the upstream commit ID in the
> changelog of your submission with a separate line above the commit text,
>
> like this:
> commit <sha1> upstream.
>
> Or alternatively:
> [ Upstream commit <sha1> ]
>
> If the submitted patch deviates from the original upstream patch
> (for example because it had to be adjusted for the older API),
> this must be very clearly documented and justified in the patch description.

> Just to clarify: it's fine to do a backport of a commit
> even though it was not tagged as a fix.

Thanks for looking into it, David!

Ok, I was worried that the original patch's description will confuse
people because 1) we don't allow pte_map_offset_lock() to fail in older
kernels, which the original patch relies on, and 2) the patch does not
mention the race condition (because it fixed the race 'accidentaly' :D).

I'll backport the original patch but make it clear that:

1. while the original patch did not mention the race condition,
   the patch fixes a it, and add link to this discussion.

2. we can't remove 1) pmd_trans_unstable() check in change_pte_range(),
   and 2) "bad" pmd check in change_pmd_range() because we don't allow
   pte_offset_map_lock() to fail().

3. pmd_read_atomic() is used instead of pmdp_get_lockless() beucase it
   does not exist in older kernels.

> > but since the original patch [B] did not intend to fix a bug (and it's also
> > part of a larger patch series), it looks quite different from the patch below,
> > and I'm not sure what the backport should look like.
> > 
> > I think there are probably two options:
> > 
> > 1. Provide the description of the original patch along with a very long,
> >     detailed explanation of why the patch deviates from the upstream version, or
> > 
> > 2. Post the patch below with a clarification that it was fixed upstream
> >     by commit 670ddd8cdcbd1.
> > 
> > Any thoughts?
> > 
> > [A] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> > [B] https://lkml.kernel.org/r/725a42a9-91e9-c868-925-e3a5fd40bb4f@google.com
> >      (Upstream commit 670ddd8cdcbd1)
> > 
> > In any case, no matter how we backport this, it needs some review and
> > feedback would be appreciated. The patch applies to v6.1 and v5.15, and
> > v5.10 but not v5.4.
> > 
> >  From cf45867ab8e48b42160b7253390db7bdecef1455 Mon Sep 17 00:00:00 2001
> > From: Harry Yoo <harry.yoo@oracle.com>
> > Date: Thu, 11 Sep 2025 20:05:40 +0900
> > Subject: [PATCH] mm, numa: fix bad pmd by atomically checking is_swap_pmd() in
> >   change_prot_numa()
> > 
> > It was observed that a bad pmd is seen when automatic NUMA balancing
> > is marking page table entries as prot_numa:
> > 
> > [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
> > 
> > With some kernel modification, the call stack was dumped:
> > 
> > [2437548.235022] Call Trace:
> > [2437548.238234]  <TASK>
> > [2437548.241060]  dump_stack_lvl+0x46/0x61
> > [2437548.245689]  panic+0x106/0x2e5
> > [2437548.249497]  pmd_clear_bad+0x3c/0x3c
> > [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
> > [2437548.259537]  change_p4d_range+0x156/0x20e
> > [2437548.264392]  change_protection_range+0x116/0x1a9
> > [2437548.269976]  change_prot_numa+0x15/0x37
> > [2437548.274774]  task_numa_work+0x1b8/0x302
> > [2437548.279512]  task_work_run+0x62/0x95
> > [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
> > [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
> > [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
> > [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
> > [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b
> > 
> > This is due to a race condition between change_prot_numa() and
> > THP migration because the kernel doesn't check is_swap_pmd() and
> > pmd_trans_huge() atomically:
> > 
> > change_prot_numa()                      THP migration
> > ======================================================================
> > - change_pmd_range()
> > -> is_swap_pmd() returns false,
> >     meaning it's not a PMD migration
> >     entry.
> > 
> > 				    - do_huge_pmd_numa_page()
> > 				    -> migrate_misplaced_page() sets
> > 				       migration entries for the THP.
> > 
> > - change_pmd_range()
> > -> pmd_none_or_clear_bad_unless_trans_huge()
> > -> pmd_none() and pmd_trans_huge() returns false
> > 
> > - pmd_none_or_clear_bad_unless_trans_huge()
> > -> pmd_bad() returns true for the migration entry!
> > 
> > For the race condition described above to occur:
> > 
> > 1) AutoNUMA must be unmapping a range of pages, with at least part of the
> > range already unmapped by AutoNUMA.
> > 
> > 2) While AutoNUMA is in the process of unmapping, a NUMA hinting fault
> > occurs within that range, specifically when we are about to unmap
> > the PMD entry, between the is_swap_pmd() and pmd_trans_huge() checks.
> > 
> > So this is a really rare race condition and it's observed that it takes
> > usually a few days of autonuma-intensive testing to trigger.
> > 
> > A bit of history on a similar race condition in the past:
> > 
> > In fact, a similar race condition caused by not checking pmd_trans_huge()
> > atomically was reported [1] in 2017. However, instead of the patch [1],
> > another patch series [3] fixed the problem [2] by not clearing the pmd
> > entry but invaliding it instead (so that pmd_trans_huge() would still
> > return true).
> > 
> > Despite patch series [3], the bad pmd error continued to be reported
> > in mainline. As a result, [1] was resurrected [4] and it landed mainline
> > in 2020 in a hope that it would resolve the issue. However, now it turns
> > out that [3] was not sufficient.
> > 
> > Fix this race condition by checking is_swap_pmd() and pmd_trans_huge()
> > atomically. With that, the kernel should see either
> > pmd_trans_huge() == true, or is_swap_pmd() == true when another task is
> > migrating the page concurrently.
> > 
> > This bug was introduced when THP migration support was added. More
> > specifically, by commit 84c3fc4e9c56 ("mm: thp: check pmd migration entry
> > in common path")).
> > 
> > It is unintentionally fixed since v6.5 by commit 670ddd8cdcbd1
> > ("mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()") while
> > removing pmd_none_or_clear_bad_unless_trans_huge() function. But it's not
> > backported to -stable because it was fixed unintentionally.
> > 
> > Link: https://lore.kernel.org/linux-mm/20170410094825.2yfo5zehn7pchg6a@techsingularity.net [1]
> > Link: https://lore.kernel.org/linux-mm/8A6309F4-DB76-48FA-BE7F-BF9536A4C4E5@cs.rutgers.edu [2]
> > Link: https://lore.kernel.org/linux-mm/20170302151034.27829-1-kirill.shutemov@linux.intel.com [3]
> > Link: https://lore.kernel.org/linux-mm/20200216191800.22423-1-aquini@redhat.com [4]
> > Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >   mm/mprotect.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 668bfaa6ed2a..c0e796c0f9b0 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -303,7 +303,7 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
> 
> This is like the worst function, ever :D

Glad it's removed recently :)

> >   	if (pmd_none(pmdval))
> >   		return 1;
> > -	if (pmd_trans_huge(pmdval))
> > +	if (is_swap_pmd(pmdval) || pmd_trans_huge(pmdval))
> >   		return 0;
> >   	if (unlikely(pmd_bad(pmdval))) {
> >   		pmd_clear_bad(pmd);
> > @@ -373,7 +373,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
> >   		 * Hence, it's necessary to atomically read the PMD value
> >   		 * for all the checks.
> >   		 */
> > -		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
> > +		if (!pmd_devmap(*pmd) &&
> >   		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
> >   			goto next;
> 
> This is all because we are trying to be smart and walking page tables
> without the page table lock held. This is just absolutely nasty.

commit 175ad4f1e7a2 ("mm: mprotect: use pmd_trans_unstable instead of
taking the pmd_lock") did this :(

> What about the following check:
> 
> if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
> 
> Couldn't we have a similar race there when we are concurrently migrating?

An excellent point! I agree that there could be a similar race,
but with something other than "bad pmd" error.

It'd be more robust to do something like:

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2a..6feca04f9833 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -288,31 +288,6 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-/*
- * Used when setting automatic NUMA hinting protection where it is
- * critical that a numa hinting PMD is not confused with a bad PMD.
- */
-static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
-{
-	pmd_t pmdval = pmd_read_atomic(pmd);
-
-	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	barrier();
-#endif
-
-	if (pmd_none(pmdval))
-		return 1;
-	if (pmd_trans_huge(pmdval))
-		return 0;
-	if (unlikely(pmd_bad(pmdval))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
-
-	return 0;
-}
-
 /* Return true if we're uffd wr-protecting file-backed memory, or false */
 static inline bool
 uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
@@ -361,6 +336,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		unsigned long this_pages;
+		pmd_t _pmd;
 
 		next = pmd_addr_end(addr, end);
 
@@ -373,9 +349,20 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 		 * Hence, it's necessary to atomically read the PMD value
 		 * for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
-			goto next;
+		_pmd = pmd_read_atomic(pmd);
+		/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		barrier();
+#endif
+		if (!is_swap_pmd(_pmd) && !pmd_devmap(_pmd) &&
+				!pmd_trans_huge(_pmd)) {
+			if (pmd_none(_pmd))
+				goto next;
+			if (unlikely(pmd_bad(_pmd))) {
+				pmd_clear_bad(pmd);
+				goto next;
+			}
+		}
 
 		/* invoke the mmu notifier if the pmd is populated */
 		if (!range.start) {
@@ -385,7 +372,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    uffd_wp_protect_file(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);

-- 
Cheers,
Harry / Hyeonggon

