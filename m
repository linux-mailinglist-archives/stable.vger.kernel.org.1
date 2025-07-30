Return-Path: <stable+bounces-165593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EDAB166F3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C15C3BC69D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8E51B0439;
	Wed, 30 Jul 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxPndsBR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b/V+PqPw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049A1DE2BC
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904058; cv=fail; b=tyUUybwqT29RGSkYuek1drdgSzsj6HvWtwGXZddImhBb4xP0Hiy4rdPZYg2JjzLI8HWroT+DCO8HefCTKKhv830OwEJr9Upykkk29iZve9nJot5Hd5ac5KMMYkpqEYzEH0OEX87ACbj2Rsqzc+9XCBbEOp7ihlLEatIV8KMwxXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904058; c=relaxed/simple;
	bh=ELQUnndzLzXLSpOFoHL1YrT3crBeaeQVrkwAdiONXJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mmlCqeYrs+t5l5Hm/BLxCi+cewXSKqSv4M6VDwO1enA7EnT2lbwhU237wR5oQtBHd5aU8LCIDPe1IU9iahONeTlWCO2CeqZxFMRLpmiE7NSN3GW10EqXqyuh6XmFyG7EpnAXzEjfp1hvff4rgtD2OJVdxWl3T+H2vMmDh6mCFYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NxPndsBR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b/V+PqPw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJC2hO019085;
	Wed, 30 Jul 2025 19:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ELQUnndzLzXLSpOFoH
	L1YrT3crBeaeQVrkwAdiONXJg=; b=NxPndsBRKRqRs5t9zDHbHMp8Sf+Rssae92
	DJ2foHMznzNus+gKUYBaK81N6PjTA89GInpLuj3BXzRGo2p3r4YSZ53xzPKkSSIU
	5vEQLSq6npVzN8F/2094Mn8CNKtICD8xRwCqO5vJ5nBsj4yPdjC+FZyLCXdq9i8H
	lWGA+mfOqLS2NllMjLF/eb6CC0aE+5k3P3aYQsaoR521teNBjNDH+aCKQNiiSx0f
	aJuf+8I/LOcGBONc6NVm2xSTfOAxWplM+jmiWdBpTIrBe6gixJpBoq9V+THgLLKJ
	CqyYNA3K3bsOt0uR3mplLw1SnuVXUh+Q6yXygAbp3WSDP6Pa9QUQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yjnd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 19:34:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJSS8f011124;
	Wed, 30 Jul 2025 19:34:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbegbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 19:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4k6EOE2A5nN1HGaDyY1zP5XLhgueHFtq2empsi5twgFazTmgV6QsFUAKosoe+c9vJTASYOW1hF2tYgmEHDUr6ON2uqu6pbDRQWvfq7SgyPxcabGFm6sclgzCCVt6NFKlIVKvs/ZyXddFmzy13jlAdgtscoorQMX2By+4OkBs04oHbA1ci2Xf3im083zE4XZjhG0xV9Jc+7z0xmu5FEKqH9MDvqIFUgXgZr8D8zctgoeJCIuyljF66H0SfW6/gP/UtCyoenii1YPBsmn8BklZFdJWK4RIAWju8DPlBOjHqReFkA18XnlUk/hRAMTaKxYHll7PInAjPnb9x8Fyg+51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELQUnndzLzXLSpOFoHL1YrT3crBeaeQVrkwAdiONXJg=;
 b=HCm5ilQhHqn/GnX11sHEjUm40Y9Duk7Il3UBEAM22Kxh/R8csV2rcgTlA93MtXZKfOdpOn+BDMEqEfC/ptE2f2Jh5VL+iXhxTTKy/7dT0mqxLXjAGvHFnBRjJ8T5ugfkN5aJESTbQD0g2kOSDyYkl37DcAvbdBAwHa0AXJsinL8wmbZais/wXxLG9S/q1Uv/4Nu7v9BZWbuDZF67N2hoBhtK5IMBvY3mMpT5RZeh21qBg8uE9M4Vla16sjXi0TUqMPKcPdjdltq814M/DInbhDsasZtZXZlZtmnj+OaQeH3bh4Lmq0FiNU5zZ4yhORorld0NUxqzdslpy6GL/HnvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELQUnndzLzXLSpOFoHL1YrT3crBeaeQVrkwAdiONXJg=;
 b=b/V+PqPw3NDMrJbayf3hgrC6rFcLDqGtkXtZSdRO/5zBewBtDETSlUgJfg0Hgs9HnW+FJAJhA7t90PCYq7mHNpJEyCSh7sAcecSfKyDHdsxDvIHEXuYSitz9Zal7vK3oa/tx9QZs83rnFuC+KW4DrS+VAY4pNKGb9m7HroOZFc4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 19:34:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:34:04 +0000
Date: Wed, 30 Jul 2025 20:34:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: gregkh@linuxfoundation.org, aliceryhl@google.com, surenb@google.com,
        stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
 <aIpVKpqXmfuITxf-@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpVKpqXmfuITxf-@google.com>
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 5710d1c1-421e-409e-986c-08ddcfa00b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuEVV51IHT5lJZrmGVdAJCQUp6NqSaUdU/Q2/CQQUXdARwDpV1qyyymNBOOX?=
 =?us-ascii?Q?+WtGiUd4SE8rmCth9qGn2/bOjA2ihTwHsAAk7o2J/Cq/ErT7Mi5Ak2MBsd80?=
 =?us-ascii?Q?Me1eXcV5sJZPqJMdep8tbd0uWZ49pISNrp01bBQ+giKyYrnCGrpq75hYaR8i?=
 =?us-ascii?Q?ebfHa3Q/xNYikk6srsWP3vyOkuNouwCsIVgZIrOE/1SSTQB/MLWbAJf84GON?=
 =?us-ascii?Q?46orZ/tPh/6iIrvl3y9qY8QwcGod//wOoPQCczUL007OwrdBXTArKi42/lAy?=
 =?us-ascii?Q?qZlG1C6FkdBzY7a35XPni2LksQfAFpk4B5HNRE1CtCWokCaBZByzwYBPxPYr?=
 =?us-ascii?Q?XqVTRQzShum18Naxj0QEIKo0qBu+UOd1DHyboX2hETSLvPTW/ujU27GJykZK?=
 =?us-ascii?Q?OQqqKRCg3t7gzzx1XkVx/WzsH2QsyKqhXDind1D8Cci3F1CjpSG1mdmZi5Ak?=
 =?us-ascii?Q?7Wjqg+UKvK3F3DKLosiSmNU+0VrEKJLqz0NO9nKWcnFpOWl1fnNgbYaioCyK?=
 =?us-ascii?Q?H/nDpQ8WMEpYs+cfaFEJlIXwUDO17eZci2ivCjP7ElYM6/+aj2kJ5uPuNZXl?=
 =?us-ascii?Q?ugqufsnMXxspEOlOHSsVI2xgr5QDJ/i2Ik03lmWoSVAwTPjY4WqU0xFlaUqM?=
 =?us-ascii?Q?KRrmTSQMYxNHtog6uUfasJlVJhR+b2GOAVgMkmZ6tb73zAEGGGCuXFt4/m1b?=
 =?us-ascii?Q?BSOYoBx9PgpnCqiLamE8eIQuZI0DeW7oO8/+o7YwdAoaVPYHQB4ToAH3JSCr?=
 =?us-ascii?Q?i11+CohfykcsvBNBo0teGhJv0jBuxCRg/E8PDCHTnfimDS3P4wOdfUHf3Tje?=
 =?us-ascii?Q?zErXjl1wEV5dDPlvvU8LeSsCXSZ6h+fREMNW9tvO2vXrFHt3NrQH0gh1K3NA?=
 =?us-ascii?Q?usefjdy0oPC2Pu8gCFEXzDNWQy/es3FE8OtHv6t6j/aNYcLKV9MsOdAne38r?=
 =?us-ascii?Q?0J+HFLnKROwFSbBqeH8V3/3LHOuyMufdZFwdJpYQUFMQ/tfdfwAV6NNf0GdX?=
 =?us-ascii?Q?rfe4XTYjceqcTySZVXqd3Kf5aw5uk6eNT24CeWENXizE1hf/n+gC7yvMr9S/?=
 =?us-ascii?Q?NZ2WX9PIDrQamPp7JtV/B5NNoY0nhnzu6hHX+CxPbNS0nDeHDm4rB0pRzgzI?=
 =?us-ascii?Q?JxKZnxYLwWtmsLAqYPjYTIxNC/6wOZmL+/D5K5vdy7hQFV4LrbnvOwZU0H/i?=
 =?us-ascii?Q?mcL/e016taBasBN1y073loO9JfajVzaYFjM4tQb2CyMFWvrAbDnZ+NTEK4Rx?=
 =?us-ascii?Q?YnWFTWTxNvAfwjIHfBMjL44azZjbUXEb8xYc8GaK8RtHTEQoSso8jA8llIGG?=
 =?us-ascii?Q?RRFSqvu/TTyy3WEGdZVqYzOt9w7MfRukd9jXh1qXqBeLB22IOEWDyb0fViYG?=
 =?us-ascii?Q?0vtutaEIthuGJjuzK8OeIoaeJZDEbWVVPl6DT02jBJmmlY4VFQSN2Hb+H39Z?=
 =?us-ascii?Q?PLFTjTV/qtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NVonN+ZX76jUnRwm7drViDRuzZ4rbwMm3JUHcYiZNpSHSTR2owqAoim+30k5?=
 =?us-ascii?Q?Wb4bG1hOjYiPSJnyhFN/gjxw4UhPxKhg/REXzbHL5KV8Cv1zmOemHJmzao+x?=
 =?us-ascii?Q?zZQeh7mBEGap9WSIDFofxu8zYQaFGGq4uDLJ1fYQ/9ddiYM2fhqb1UnoXB4V?=
 =?us-ascii?Q?zngKE7dMNMWBdYuknPGU5KuIEABPDKtjZgb0c1XmZaUrk/BDxaFJEsZ7RPeP?=
 =?us-ascii?Q?ZyIioYoovJ/NmjtUG7w4beGIH4Qao/wBNH4oSRHu9Zo/TJXy8fwHXUn4XwLr?=
 =?us-ascii?Q?iqoBJpoql+2Jz/J3tb8wDiO5DdNI6/YLmgytsnHRzbVWmPmRtI9i4bxM2UyE?=
 =?us-ascii?Q?tUyauMVkJGjEymAmy8myXltCHx36GU32LmYr3qXy1JfZrZuvZ7ycSupZv0kB?=
 =?us-ascii?Q?LGYBqKp8ubLm9vmNBJyU28AaEC5h2l3Q+KyWJwgOa5vklRAHj34j0OdIsW3/?=
 =?us-ascii?Q?MQPzETGI/aVVg9aqC2d8/tT2A3MNAXj5AftfJ4p7lD24BB+VJl4loRarFLsk?=
 =?us-ascii?Q?LF1t4W2RbBdYaOFlHyH/+2sRanx0AV7p/P1Z+Z9veV/+JsS65qFgU8rfz7d5?=
 =?us-ascii?Q?PDdQhMLgGUffiU8eMJZ0bNBQQclXYZiWBxWM2imOtVEylewsjcxwIwGDeVJk?=
 =?us-ascii?Q?PnCFbfPtwH6oZsVNK3OmykZkBWqGatgYtoJcXax6CrMqeImiobiwKqxbg6h6?=
 =?us-ascii?Q?+DJq+wEF4JGlmEfA88IHhRGt2+snK1vMsGcTKQ7Vb89uARjY3qI7vk67B8r3?=
 =?us-ascii?Q?T0o/Dxon5YDU18SRpbqg2kW2MVJdWhXtLYhMkHmc/b8LoKnqIjUnx6wtnBn/?=
 =?us-ascii?Q?vYxUlMaN1qPM/W4caskZYg83ESlWEfq+KTwDBGX9EyniG1fFKLJeHy0a9dc3?=
 =?us-ascii?Q?U1IiMDqN5D3Z9ndwpaU5X4jA1Aajzdf8Aw0WQyVl3XDanfTF6s+AC3W1ASQN?=
 =?us-ascii?Q?lgV9Wn5ZBkZNiLSQ+0BDQK5iFMq4Vr/scgYqmbK9wDBKUGi82dTx01g0652a?=
 =?us-ascii?Q?UYe2OsdnU/YDwb34pAKq876EGcqKdmkZ+kNYG01go1kkkAHCDeJHntt3skS9?=
 =?us-ascii?Q?YDeV9DxPXiyjC0vOQ/njfCIWN/NNr8olYoDq1+cptCKDESzOChLfFxq8VxFU?=
 =?us-ascii?Q?JNzomgOuLp7xuTIpn8XeuhCxgnfcoyXdvAs/LK0jphC0qNBKxRPywGwYKM9C?=
 =?us-ascii?Q?IMs0WUe8ckYfogMMrtC846KmYlMhNwzX1xJmHjI0sFSARvKW9TaMK/UmZH3n?=
 =?us-ascii?Q?IrSLuE5oARBoVCOB+dygOqlBVo5G6QG5wVgro+YiWiaCMoR6/pOv1gXoM4QO?=
 =?us-ascii?Q?cX84LJ5gpgBk0HcZewlJirRbYrl6SrWUdSVu2zlEqWOESkzsDLufdN9jeq6X?=
 =?us-ascii?Q?eOerFPD+gSDjx45anPLVZEjYHU13f/o7jTxzACHioz83D2I9ANV/Ic8S2xbE?=
 =?us-ascii?Q?cwBiel2g5MjIUh9oZ5wfEW4aG8ujPF5g5R38KVYzql+EQp5xsjg0JEGPoHRN?=
 =?us-ascii?Q?upVj6xBWlBwQvBZMYvhoJLWhESk2XdKkYpZo1fu+V1HaZZFvWYZqOysnOtuM?=
 =?us-ascii?Q?Qj4W9KZHFuiyy8J9voY8w+tq6MAiHeDaL87eS2Dl1L5+uDcMsO4cDCLhkmIT?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3M6oonY65EwXxvfp4JyQnzUOx/CasBqixPr54EdctFB3bqcRGURomS7Ex5wp3pKNLVjMcGnGNM6OVpdcEuDSQ674rwPEfepakCO1RavO2lUQZeTEzTUSDqMOODvI9hOMVg1MLq8EiZLpvqxL0wveOSqYWq75p0KFjJjOgaT6JNWXwALFmjB0WT+fnKXIlb2FG9f4USsygLz9w2lwfkdsePWqUr6ED04LGiP7KYyV265mUPaN7LATopmip5oEcqjfSpqK0LL8shYzEoKGfTOUwgI2n7aKEGBsWeE1pU9x3gJFDd4diIXR4Yr8BYS88v041ppLSWm6VbZEUjARbYyMi4sOwI+uORyxpuoK5gadjdtvJRgbjW+zZGdweNmUpeQK4Szff0GZAQgmMiIaDNiVoXvK3MWVvtory/rXcCV9v11z/XEVzjXPy1UmErLvmYvhsxamkCt/ZGwGu6h1lOxBxik1qIAHLC9eCeaeFgog0bOkBN5vc9u5fAyUHRg2O/zEoVvCvUqexmxG2bPIYgUWn5HGki5RhUHKdo5nF7N3zqFMGq1yIslx1AI20t2aXVRWq3SuNkjb7JNiHOPC8KBbRWLmuiGESaYgIiAyG8sq5j8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5710d1c1-421e-409e-986c-08ddcfa00b40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:34:04.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+y/bcvwaQz6dgxNQ549X6FUCKpmOb3b3Sk3kS2DIoLu4ZX+Ffe95qNRK8MMyRxk9+hR5rC2LG0YgPBnC2hAN5eZHBAuM6v/612yJtIo/0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300144
X-Proofpoint-GUID: 3b5c-Gm0nz4Z8BNdjw4EElIKZhJEKTPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE0MyBTYWx0ZWRfX/X2RoXKc71kY
 OxmnT8IFgbcOoLkvcD7D7OAWaxGhZ72KYFtl7vYO+t2obQAQdZScxwjjR8dA2fO+BT5E5b7FmIl
 03Xpc+CWMGSwpXD0bVaSilWhE4Xq5nxZBL6O+97brOfD50ac4w7UGRcx1cNtdeFqRZGFijPGnq0
 GHH0WMm9znTgJq7qQU8iXrQHkltQU86gEf6K4XVMAKsaVrypeMXHvvhsLYYl0LbvWweUByN3Er/
 M69uVhw1EBZq5rgvK/XhWt6oB3OtsndmSUI4r7pNekbk6sckMdidc5OqHpUTydqF6qt0FxeqtEw
 RpAVt0EZtKOMYE1xiWSQ2nid45k6BM6SLm9khQwKqSWbuOuU6itbNXkYrg/7LEsOa5vvIYrJmhf
 mIcCwtiJrzYw8XLlcZgu4oDvlSF8kzp/hmogAFUgCZamc/hUkwmUXRp1GG/MNp5EYXCzo8Ki
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688a73b5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=IuDAGQzYtyh91S_zYk0A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13604
X-Proofpoint-ORIG-GUID: 3b5c-Gm0nz4Z8BNdjw4EElIKZhJEKTPG

On Wed, Jul 30, 2025 at 10:23:54AM -0700, Isaac Manjarres wrote:
> On Wed, Jul 30, 2025 at 03:21:48PM +0100, Lorenzo Stoakes wrote:
> > Hi Isaac,
> >
> > Thanks very much for all your hard work on this!
> >
> > I'll respond to this one, but this is a general comment for all the
> > backports.
> >
> > I just wonder if this is what backporting is for - really this is a new
> > feature, yes the documentation is incorrect, which is why I made the
> > change, but it's sort of debatable if that's a bug or a new feature.
>
> Hi Lorenzo,
>
> Thanks for your feedback on this. That's a good question. The rationale
> that I had when backporting these fixes was: The original intent of
> F_SEAL_WRITE was to just prevent any writes to region after it had
> been write-sealed, and that the existing behavior on older kernels
> may have been a result of oversight or just an accident, making it a
> bug. So fixing it would be fixing a bug that has been around for a
> while. I hadn't really thought of it as a new feature.

Right, makes sense.

>
> I also learned recently that, at least for Android, there were attempts
> in the past to map write-sealed memfds as read-only and shared, which
> failed. This was surprising to developers, and they ended up working
> around it. I'm not sure why it wasn't reported then, but this being
> a surprise to multiple developers makes it feel like more of a bug
> to me on older kernels.

Yeah I always felt the behaviour was surprising, which was what motivated
me in the first place (though at Andy's prompting I believe).

>
> >
> > Having said that, I'm not against you doing this, just wondering about
> > that.
> >
> > Also - what kind of testing have you do on these series?
> I did the following tests:
>
> 1. I have a unit test that tries to map write-sealed memfds as
> read-only and shared. I verified that this works for each kernel version
> that this series is being applied to.
>
> 2. Android devices do use memfds as well, so I did try these patches out
> on a device running each kernel version, and tried boot testing, using
> several apps/games. I was looking for functional failures in these
> scenarios but didn't encounter any.
>
> Do you have any other recommendations of what I should test?

No, that sounds good to me! Thank you for taking the time to implement and
carefully check this :)

In this case I have no objections to these backports!

Cheers, Lorenzo

