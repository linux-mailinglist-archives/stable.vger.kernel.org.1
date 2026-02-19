Return-Path: <stable+bounces-217443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEzyDfcjl2mZvAIAu9opvQ
	(envelope-from <stable+bounces-217443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:53:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BD15FCF8
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8CE230060A5
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C4533FE06;
	Thu, 19 Feb 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jgbreElu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61645244685;
	Thu, 19 Feb 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512812; cv=fail; b=LB+cROhDWaJpfobE48Nk9f/kjp6pzUaiTG3mbyt2d8IV6yA1mYicmENrimnbzXyIvjziOO8z0FEk4oTeLfQZ22gYlfxhi6rpvp4jcqaAfAIzhIWiw7x7RzIqKlgyRjvKDRqXvEHh0R0N6AmaW45jYyTavtYZ6vnLedzC03ard/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512812; c=relaxed/simple;
	bh=sTAhqBgIvElAjTgmxJ8XYuhgkcM4O3STgOOPnTqTWEw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BoiqbJlyleAChD1IIwwdOhD2Iaoy73vSD0AA3VM3CraOmmDiUUn8BnatS5V8tQ9v7yIiIEXC8lZxrcUYg/fl5Vee1snTxLMSuF1wNfeGwWNzwS5zz4uRwuaiTpm+1X9n5XPz+6zcz0UbA8CUDp5G8XXHeQncwN8GzWcvsTxl4Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jgbreElu; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JCF2Fu232851;
	Thu, 19 Feb 2026 06:52:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=o3szzmaDrY8XU5Ynns5NnP
	jWpv199rRHgI3gPA1d9+4=; b=jgbreEludqV6Q2/rsSnp0rGV7UKiF4puogftLT
	KAOFeqRtNTay3rANBpBIBoObxPLPlRsUNroaSDQNE1520RlIMjG4whrat2KaYGKn
	9Pwfe6RooXM4fbHbRvyLXeDfYCFeI+FSP5rsT1P62U0qfKFhnn2RBHW8U6jF1oKG
	dOCsGXdEyNEXTYAnlR1SLf6c+Rs/VdMIPTQYsyfklBsKt90j9UviuEftsJsyFZg0
	dG84l4N3QweYVnw5B8YAScv2U2JWRtNkwacLeYLMIAkgfnAwEeClqlgSn8mnqWEJ
	kxX5OpSoaWMuNBu0pVvgUwsT2iVAruIP+FAMUxFYCspj4nQQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cdtuagemg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 06:52:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMXWqXhiskOFl02eZ3y7vOBNvAnxzCTMFwx5mIIgUII472IKUOqKz0NneWLcgNxoAkS2GiAuql860+/hLxksIuIQp4Xolri+DdgOaYgnpVeBwtcY3a5Yacqwn4fxJ/qT++YxDq1TY3Yh35Y5krBi6WzWuOSNW4TXHk63WzHY7nDJmtlPZF/OvbbbP+Ccx7R4KmGlKEILtn6XWUuzbrkpgn5VJpqPjstcaqs1bIB4lSprc0AIb2epbyNm68Z9TtRTppPn60ZvChm29dLR2tFaT7snbEwVzWZi07XKnKvV/H2pTSnWek9AZ2hiUdS6XJu5tgABxqOLqK6ZqIEQATX74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3szzmaDrY8XU5Ynns5NnPjWpv199rRHgI3gPA1d9+4=;
 b=yRUsW2eW/2MipNB2yqs7712w3Jbm7Vbu+ep4ArPyOO1Pzhx6nFTr4E2RE9zCXxjWceyMVqRa6U82bZKk3xXklZAHkOaBhLP834J3lWRwakXb78FnwyylZiiPVQDU/r12nXiTfcuucgtmcBXqNO0Q3vGAc0jsZj9XJyeWkWFpb+om6tM41sAVJESpC8c8YWQhryOGjz6GDlcHYcTN7bQxtlzDAXUXsRbW2r/O0NSbTlj0vQIVDNmODa8Rw/vEq+MkIuMc5fDreyhDActtYt+TTenCT3IUKFsBZUfxEOP7kr3hHZWjf8xdwel8A8ykBJKAc7+NdgUL6j7kkWFaY1x3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:52:42 +0000
Received: from MN2PR11MB4646.namprd11.prod.outlook.com
 ([fe80::648d:7adc:f762:1372]) by MN2PR11MB4646.namprd11.prod.outlook.com
 ([fe80::648d:7adc:f762:1372%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 14:52:41 +0000
Date: Thu, 19 Feb 2026 22:52:24 +0800
From: Kevin Hao <kexin.hao@windriver.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, pabeni@redhat.com,
        nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net v3] net: macb: Relocate mog_init_rings() callback
 from macb_mac_link_up() to macb_open()
Message-ID: <aZcjqF1E57E-i5aS@pek-khao-d3>
References: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
 <20260219-knapsack-thirteen-7d9e83451a40@thorsis.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6856BtWp9TLXFk0K"
Content-Disposition: inline
In-Reply-To: <20260219-knapsack-thirteen-7d9e83451a40@thorsis.com>
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To MW3PR11MB4651.namprd11.prod.outlook.com
 (2603:10b6:303:2c::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4646:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1904e16d-161d-4a36-257a-08de6fc68734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yGBF4QKHmvCZ0OmLmyl5jRYnCA8qz5Z+Qhc7hByaZDtv6Xr6CFUABDP6bjdR?=
 =?us-ascii?Q?jixpolxvRhO1ZA8I2kFZxDnWfRbwZIYPqMRKCnAZXokS5YU2vksjKPlmfDd2?=
 =?us-ascii?Q?5gY7MxFWagCYA+6Kj22Fn2LJVkjdqtSvbWH6EyOciotaCsHR1dxXRLGejLBR?=
 =?us-ascii?Q?ns4eOjQcQ9T6cDvLjGjiCWFPltH4l/ZkpDGjbQMwzVay77HpegGyF5uaIrNL?=
 =?us-ascii?Q?ZgobZtZpSTYfg9+kEbraS+bU5J7d35ragmUuU2aeT5Ckh+++EQ9Y1l66ICcI?=
 =?us-ascii?Q?edIENKUUNp3qIIdTDCQTAj1X1AYnqPPdPLSQMJsfbh8lAO4Test3mE4B/Rmx?=
 =?us-ascii?Q?B4xnfZyX5pOYBmlasUqIBk2zMz64u5Vh2HSchwXSbgNZKKPK0YWSfQ3v9nIN?=
 =?us-ascii?Q?P5336JtixSSD74RdFxGKCNT49QumA+D2s9zamaNAww9lXgcrDFD/18hrchRw?=
 =?us-ascii?Q?5S2cOyoGmu0IXN3BstoP7JD/vMx6TRa6Wnmay8+PD2EVoQolX4eEPMmPyDkv?=
 =?us-ascii?Q?YJ0B7Z4Dww1cnBr9WAhGH7i89JixqfYSkqsj3VTIEiteWPWe1RTEQ7yKWPke?=
 =?us-ascii?Q?+Dvb97H3iXMfnyBOqj3VRnGdvvfRiu4QzgEswW1CS3diIBlW2+0q+J420XM6?=
 =?us-ascii?Q?PshXqWcT9S98L7JYtctVByVgSRvza+EvWaPGz9BoKVu1Qnzs/rupsVTF9mPd?=
 =?us-ascii?Q?YFHpuW18BDSVBEfRfRwVFEMdTMuJ/diyorY+/8q6IuV5HxMORN8UDymSucw3?=
 =?us-ascii?Q?YLx/4z+oB6EXBNLx39GULL1BwDH3k+tiMo/D4Oqet7Cy15haO3duzNs50ZoS?=
 =?us-ascii?Q?iz9IC1w2INkWOafp2EJY3G98iOy5SZ1FBGNgNezjdI/PVP3j8EoKr97TuGUP?=
 =?us-ascii?Q?Op0esbbfnZz92RLyVxhOBc1Ux9xGe227qfBZ+y5oObzST3RTyGuHUX7aZYFG?=
 =?us-ascii?Q?VKnOJKmshL0Kg8b7bYV40u5PXw2pM/EpA7WXpeb7FQt6VqA+6//+dV5HMZKe?=
 =?us-ascii?Q?A3MZQ94TR0yeQz9Kj0wBZ3BwbuBINDTTk+vmxfO7O6ID75l4Pm5bq9YmxM9v?=
 =?us-ascii?Q?K/HjKdvKs55nIHoQU1dM0ew1ndq+PzvAi5nVPWuaZq12R9vM1RelwDTDNd4P?=
 =?us-ascii?Q?5ptlYfl96P4aAyqgtiMP8nwwPSddzaHUiekvfewtxED8V3joEXEnpbDGNPbj?=
 =?us-ascii?Q?B/nuO4SbD1piX6+dj4YwaaibpXOgEQQJa9GRtCAPDl/TXcMnvFznNB99nQwM?=
 =?us-ascii?Q?EvPIBfSUYG28xSlMsyQ1f0D7S5aKMn1VS9A7K1fxJn3RC9o/YFrrpPvXSVKt?=
 =?us-ascii?Q?VfoDARqswxkMb5JWNq6qUl1HXb/ZJWVdbtg0ShSpgbvf4ilrugDNPp8oRokt?=
 =?us-ascii?Q?Ob6y0hbxmHGdgFY++ZZsWToNZwq2Hmr/24g+YVgiIFH3vjsbmOsCbW5qgKQj?=
 =?us-ascii?Q?dLLMebKrdfSXh1u/R7kSgghFT/u3BWrCd6FBlZw77+1Ge2JYr5/dXpnqEXri?=
 =?us-ascii?Q?wCWUdLLHRaBV5ossr6CVMseM6scISh3EnFzlW5AJF/5ePtuCN9IoivtR5gHk?=
 =?us-ascii?Q?5VsXSUj1Pr5t5QDa1ZeBdLzjrUXK20OJw8SWujWPOPnkED0m2iuaEo6L4VMJ?=
 =?us-ascii?Q?GpqNbgT6Xvz5tqe7GkGyeWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4646.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rV39di4BaCz9js/uvE6tbv5U55vcOn9OYyQTtZmYAgjMf923xTxZAWgSmTTG?=
 =?us-ascii?Q?wibZmOzkuz48oTiK/R1kyks6uzqXLyJ/QetfA62VtbZkx3fw49qMlayszRP8?=
 =?us-ascii?Q?P1ftTH8PUXaEm+yuHlDYHpCGx7e06cE1fEgAtvVKCu15sczwh1POiYmNO+UE?=
 =?us-ascii?Q?qYheEVchPGT5ytmTp3wci9CTP3rq5XbwgEh/8rT8cpJ7IYsafJSlrQippS0x?=
 =?us-ascii?Q?zRiWnC1lNMdjienPjK1ET0afa1qlzE3ipsImF945kG4hhXwSdy1SphYEQvz0?=
 =?us-ascii?Q?fJ6Mbs/1RKLNS9h/0Lj99z8dMtcvhy3RNSFtOQaQH1ljeFs2B2Wh1ONZkxNF?=
 =?us-ascii?Q?OkUeovDtnjcAUpI3cWLBr9KPfPevRJjaK8q2vCT8rYaYOHZdyEScVFzzT2vK?=
 =?us-ascii?Q?aDKe7Qfo+MVWN1/b5wCTUqw3ZhL3S8qWv2qhIZ7TjmD7zXNLwJ9HYPy5iu9T?=
 =?us-ascii?Q?+BydODfzD/YNq4pjLClQKaXl+g8891yz0xtx31mrWE9VWPDxTGKzzW4D8/uk?=
 =?us-ascii?Q?LXGHyc5pDsT74NvkZunrVqOLY66TEd8IqIepIhjgFME8gQTyqYxRl5MQ0aCT?=
 =?us-ascii?Q?apB1cLLx/24qbJmomlYQmn9rk0SL/0FyzLHbymSTqk6j+pHTB6S/9qg/w4Ee?=
 =?us-ascii?Q?dG73fGk9zEGsZSRyGEJZhtcOrwbqJ/a0CATx9Ai3uLKF6eV3swh0nNZcEPLm?=
 =?us-ascii?Q?TPHobn9YVi6OB25x3iXKt0Rux1vb4R8rWKRAYvV5+Akq9pmOvgzzwAbqlKi+?=
 =?us-ascii?Q?/L3/KnT/DEiTNrPaX046hPS+UoiD09lNzgvVsmT2qjBJRfw3zCb8FYd/mYQD?=
 =?us-ascii?Q?CpJG3YOdzMjiNJmSYylS7ljfrKhRPi32p0SiEdZDfm0VB/vlVunoJ35KyFxO?=
 =?us-ascii?Q?6lPOOqhinrjm9epPxaO2nEX+LqCwQyjzf10leFSj8SJNebliylSxVc82ygxZ?=
 =?us-ascii?Q?M7/HtBSjeOvT67tpwvGJ6y1u42hiX/xd5+15TjD3vuzfzeL6L+dp+Mze5//c?=
 =?us-ascii?Q?xCZh+D6bZtGEUANq416MgRLPjKdIkLwidUvocuKZ2FclbXUZx9ElWxhb6pwS?=
 =?us-ascii?Q?o8VeQ8md28DI8uhoN4e4tqhxWitYSi5cEd+7UELYJ9hkHTXNbwpKsyv7vLFp?=
 =?us-ascii?Q?bn3kD4FpN5tigSiSRfsfxdkPLBtfuwySBpZEja4Hm+MmDK3mia064+xrwMQO?=
 =?us-ascii?Q?nDnZzlKoGTKGP+PPeBe2YSDyoCDMfvu1JAksob3y8nWo/jMg76p8v34Q5JsO?=
 =?us-ascii?Q?J5jkc69JqNGcsI2NjTd3NYLzBuz2v9frriNZ3WNnew/ogA0FhYvCv1rK+H39?=
 =?us-ascii?Q?luxc8UIH0o7EigNDRJ+LvMgXUEGTV5J4YIZ5YI5OdjP1ZggkOnmcBqcwtBvt?=
 =?us-ascii?Q?BXw8LOt/tzZbJMRHfTTAabBpoW9ko9n2oHB2YZBFmbDIG2d29dBMTXgzWn5J?=
 =?us-ascii?Q?qQUN1l3yQT7nAyYqDdPSSCBqfeXQn6KieuXh9E2aWn92yDwnJBdvOTVsdT+O?=
 =?us-ascii?Q?NZu3CkixA0axM0ei9W969qlbjrFTH3TSiHzsoT17pN/nmkCTf3pHpbTd/FKG?=
 =?us-ascii?Q?vCRntxzUCzyeIxgzvzsb8sfJGUs8bTtSGoGMjcN4Lwol7VJQqGrznaU0xZaf?=
 =?us-ascii?Q?1AUxmKtosb7GXH6JrtfR/57YkVw1VfdUtv98p7KSamVYqqutSXzzM/XBknT1?=
 =?us-ascii?Q?4wqx4outruzHkJFCMtqFb07mru41D34gQzAnepGVFJCKBhoxRDiS9B3j9YmO?=
 =?us-ascii?Q?6ScdHTihQg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1904e16d-161d-4a36-257a-08de6fc68734
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:52:41.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aQ9K8BNGnwLDJaRYNnx/2W7KrB81AbqCAchmDHiuuWrPZoKzpCv59NQSmdc5Vq+OpaFoR1ED/IRgSVIhhg00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
X-Authority-Analysis: v=2.4 cv=OqxCCi/t c=1 sm=1 tr=0 ts=699723c0 cx=c_pps
 a=WVTIIPXEjO/6WBYygohQVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=AI6JGT_P_9y9NPY-QngA:9 a=CjuIK1q_8ugA:10 a=U3A8r_S1kB-gp6PnrEkA:9
X-Proofpoint-GUID: rpyzh22QOBNWB0K2f8qhcnUDI60eQi7Y
X-Proofpoint-ORIG-GUID: rpyzh22QOBNWB0K2f8qhcnUDI60eQi7Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzNiBTYWx0ZWRfX2qkwnzljBLp7
 wY0YG7OejRAT0TyWNcwP1NXLwQGktHxso1uapTlLjBfzAIKT+j6KN6mBeNQ+fT3eaZaiPee3lMi
 sT+T9EmwR1QqIFMNJXeNucU9IBNCz3ZMJazqNtHFWnS33fOXkTSSFFErBBZRcyexoZCoTskwVel
 jTBeZjUXa7J2lv1CnlE8qS3ZWYhso9qupK4wQImwc4IQGKFFSoq/ZTSdRKMynDlr5Bs80/fAG8v
 MowzEwpuQqeJCTFwH+ai1dd01xrcLfuDhnJmD5Tvtq/gmVoqgRUL0eKjcjmHd0N4HoT3vTeBiMD
 kPuYHlI35qp3XNiSS73R/KgygkgQQnloevIufq4QJazEucHCGtzyPpODyQlSguXSmYKepxNSWkx
 d8oI2Zwg7kvs+JF1+WZQ9wLq6C/eZ6Be34wDusLsuN/Ffv0Y9ZdKdUvDyWbtVqkrxOuW8dfmBtl
 tF/I84zE1cu+0o1DqDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602190136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217443-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,windriver.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexin.hao@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5E5BD15FCF8
X-Rspamd-Action: no action

--6856BtWp9TLXFk0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 03:34:54PM +0100, Alexander Dahl wrote:
> After upgrading from 6.12.57-rt14 to 6.12.66-rt15 on a custom at91
> sam9x60 based board with PREEMPT_RT patch, we noticed a complete
> system lockup, which I bisected to this changeset.
>=20
> After unplugging and plugging the ethernet cable, while
> running PROFINET, system does not respond to anything anymore.
> Last message in kernel log is:
>=20
>   [  +8.621919] macb f802c000.ethernet eth0: Link is Up - 100Mbps/Full - =
flow control off
>=20
> Heartbeat LED does not blink anymore, no network communication,
> serial console does not respond anymore.
>=20
> Reverting that change locally prevents the system lockup for me, but
> what is the proper course of action on kernel side now?  Send a revert
> to stable?  Send a revert to master?  Please advise.
>=20
> (I'm aware there were least two more patches on netdev referencing
> this change, but if I'm not mistaken none of those made it to stable,
> right?)

A fix for this commit is available in the latest mainline kernel. Could you
please verify whether it resolves the issue you encountered?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dbf9cf80cab81e39701861a42877a28295ade266f

Thanks,
Kevin

--6856BtWp9TLXFk0K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmXI6gACgkQk1jtMN6u
sXESiAf+Oh8BARZGMI/VqSRaUc6dV7NY0XuOD0Gmi08D6zj2md1+tp0b6R5ZVsG6
pz7CGsTnC0QOeFgy+TNK6eiM3zPhy4WdeMALkhAwW70klOb1+Zh8cul6r15CB2kq
VzXjfgFnieLaRfvY9xGw59DEjKh/lKM9JJSlmhC9ddG/ZnlWGl9rBGmKJAIG9CYp
A1qQNSVCBmtTKnySqjXoVjPds3nzCwmNe/7O1oUT/CYpcHDJ7QennTMHiOD8RHfU
XHaTDFHuOkQqSwp4cZHuxRIeiEsOe7DW7k6IFHN5y/NEfIJQd+PdhhGQRMkWWi5v
4Mi5RCimm42LWUnZPn+YFr6cnD5F6A==
=dMJ+
-----END PGP SIGNATURE-----

--6856BtWp9TLXFk0K--

