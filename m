Return-Path: <stable+bounces-165620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E4CB16B66
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 07:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EEE7B518C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 05:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCF1411EB;
	Thu, 31 Jul 2025 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DBB3X9QM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dfF0fU18"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D5522A
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938143; cv=fail; b=Wja+p9xCNzTMH5q34PeGgy2+oe/KYyQ6HfpKeUeG3r5jKQfdJPKyD0jBLDcvI27gH6MH8icf4gQzh12Xd8X9YVSgI1IAQZJHviqmmHc99QOyJbsFN7oBDEmimTXMkDvX937pMAz4ZQKQ1kp/GRmg23QaqM5IYRGyoZs+v41Gon4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938143; c=relaxed/simple;
	bh=R2zhOC32DwxjBP0Hcn1ZmKc5k9B2NZbmTj/96VBIAH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aR+c6cHaRmVxONoiRb6tWw9b906rvBxMtnjtvvaiaI+PFQ7cJzzDUND4k8w+NeR02A/lqjDnK6UxrZc2z6J/3CCFWM3T6ZVjWzwf2bvXBhyrTAsR88qsiySaSqvhernMwhdT4CD29Gfpxfrhp4xXZWPg59qYCek5c+AX0rOyWU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DBB3X9QM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dfF0fU18; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2g0RC026089;
	Thu, 31 Jul 2025 05:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=R2zhOC32DwxjBP0Hcn
	1ZmKc5k9B2NZbmTj/96VBIAH8=; b=DBB3X9QM03HzecVczhztEzNoU4EqCbO0QI
	TV8R5HKgZC0jHUQN3wVgY6f0Qju+5Lym1SbC3uzSARAHN6OgjtGQhaXWPY53Z2Ga
	ASgxX/PVD7TS5lz9e22GjK26BLixIRKmIUFWtuS5TI+ToQQebV/kNQ2YgOoouHNX
	ZIBcisqVl3IRnFhnV1ve+X0Myb9ncuIl1B1PR5MPTwL65+rcX6EKxpwWYWYuwZDb
	yUM0q/3H6AC7YImZaAN2fMvlc5CwIkv31IzZPKmjgy6UzIF1xm/+tQqfYSa/Zklm
	5by2JK0FGL2gYW9GEwHGcgTypl8CBLJ+DT2R1Go5E2SNu4Y9ULPg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x361b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 05:02:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V4X1T4034459;
	Thu, 31 Jul 2025 05:02:15 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfc8k15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 05:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuzbx4dfh2Ql9EwodtowrG2J8bXJDgL6LIXRVUN/+5TVARMwS8+2hMm2anoxns6Vo14en3WU1o8ZocUpDg8HXTZz28PZaBoySFY5vpXmCef9naBrTGsdxfuwEjHl08vD9sqlnvh+qZ7vrFdFf63J58fIESlqmx8LDxre0PyF4gKPZXaZMdl4NSaGCaT6rv6WAJdtuwwteh2x3Rz/ytsHYO8MZiaHm20F20vd51ZcluY8PZZSHgCZ6gNzqwOt17NbPV56l+dWOGEwFuIq0E4TSAsNOsvmIuQFY5N26bjfrcOTvXFYcDyePTWOTFmdScFdzEInncRbinju2tukKi69Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2zhOC32DwxjBP0Hcn1ZmKc5k9B2NZbmTj/96VBIAH8=;
 b=lnagw6gYneC5K/honYskLu4KNXrgh0W8UdmR5oRqHk0iTRzQotRjwZ+WCVkQFv1HckQ8m+A4BSENf97GR77JNnm6ECNwusMp40g81hLsNYwPd4YspLbhYg3+tPr//g22vAXzUt4/1u65onydr6FZDM6SD3pM+ebsceHS9PpRRb2DGkTaF5IReIqcqsINGgeV4jXlquNRtGGpYEM0HMy6uaV/YPhiID/5o8KGTxItvf5cAWHZjZZRTyww2enzLcj9coLtRucuW8SG/ZWcoBUeTFvLtU6SW2ABQ7SAbEduHh1c2r3/JYj5cc4yA2Il4XnluHXljS8ofR+CGl71lC4c0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2zhOC32DwxjBP0Hcn1ZmKc5k9B2NZbmTj/96VBIAH8=;
 b=dfF0fU18YnwFVmWxqnUYd22zLetJXKmUZkSl4JpsOwkPI8HlJM3lHtq9evvgdQWTDKPrm9Q9Oxwt/pLmFSH6UhAk+CuwXV+lovYhCe+do3/ZF+EUNPiX/wmG7i+xb+hDcKBGjr8vlMyCSUgCbWJ+i2E2Fac5PGreiqU6PfEuVes=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF742908B79.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 05:02:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 05:02:10 +0000
Date: Thu, 31 Jul 2025 06:02:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Isaac Manjarres <isaacmanjarres@google.com>, aliceryhl@google.com,
        surenb@google.com, stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <5dd0b1b5-008d-4ac5-aa91-3f5146b3d2a8@lucifer.local>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
 <aIpVKpqXmfuITxf-@google.com>
 <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>
 <aIqb-bDjsXppmyPN@google.com>
 <538efa9f-d3e5-41ab-ac82-5b7b799df706@lucifer.local>
 <2025073103-unheated-outbid-11a2@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025073103-unheated-outbid-11a2@gregkh>
X-ClientProxiedBy: GV3PEPF00002BA5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1c) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF742908B79:EE_
X-MS-Office365-Filtering-Correlation-Id: a586da6c-1579-4b95-8f2e-08ddcfef6822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hiWNWkL+cMfoBVxR2UtcbjtxmAnwNOOxDQux3v942HEVN7vSi2s3rqNk2PQB?=
 =?us-ascii?Q?3asm700HohgtxSX35MBgatX8mz2t0R4D2L4u9XJfYlSgKoE3d/IHZS7oAM0N?=
 =?us-ascii?Q?4AvjuCJITXxG09AKESxOmZwCsNpCDgNv5PZSCJ8WViRvXDIz56Ze8qc5K/eL?=
 =?us-ascii?Q?tu9A/acrg2TL1cekXRqoh5NsTkax2OaLBFfb+0kbWBdjxnah6qj49s2qr00+?=
 =?us-ascii?Q?j5dlStvwDCBV0txqLuuPJr2+PplD+5YFNST7omuzlYMWv2YOQcaHAj3YJrH2?=
 =?us-ascii?Q?KvV0xrBrgSeaQNgW1gAItguSH1yaiya+l13kdbOGRU0ib2RoSTQNDmlmTUiR?=
 =?us-ascii?Q?OUH8i7m89PjCoeSI63MLY/yLYYfldTfNkGUAxPUFA4OIf/aBhTwALKloMqI1?=
 =?us-ascii?Q?NDFn67Ow5WPfIk5CzWff9/o4/0ty3CP/RSneXeS4DAYd3dGxWg/qCo5Mr4DB?=
 =?us-ascii?Q?8YdcvY2lOk8d/W4s5liFySVnbDrda8Q+iJhAmm0MYvbE1HIAxJcv8btH05fl?=
 =?us-ascii?Q?mBNohE9nnNQmbydrrfxMLgBA4YyWmFDjeo/oZroFAR71IbLpKuJKCiOualt/?=
 =?us-ascii?Q?tlS+GwaidOXWLobrY5c1h39olWHVTIpvPYhmD2yNLIZubQ/nw9YhfuoRXP4w?=
 =?us-ascii?Q?3lr6ml/Q5tzSqskOgitB4LpHjhDiv4ovtIg18YTCQT2aLWFEIRLJT124pGgK?=
 =?us-ascii?Q?pKlCDuBu68u6d6QkZXZMxTZPPZMLKu/qC98tH/Yyx92xqt8oTNkQaXnrsZHJ?=
 =?us-ascii?Q?7eabYpvYKKqc8QU3zg9+Ss8HWRP6MHiqcrNYpLTfx+ciVbzN4sX+2S04lDmg?=
 =?us-ascii?Q?a5ZJ/1aGcmTRLQxVAZX2Pb+PDJACCI7xEr24BGjIAoTbg0cTaRoypRPydobn?=
 =?us-ascii?Q?ct9oqcSRQiznvuq604Lk1QxkJ9yym5iDWSdLGgIzVKEu5ZcYKwj4W7NWxdBI?=
 =?us-ascii?Q?QQoH3d7jfHKwkmpHC7+EzN9vS4BEMkdaYtxSkGRWB2QS8W+aF1B6SVjQjMrq?=
 =?us-ascii?Q?CU72gwWcJ/i4MD/P//naSIWCeOlgywx0hqBheTtmpTtRaSpqAcQyuu1j9sZA?=
 =?us-ascii?Q?gxFD+p+T36QVCr6SV6hCGWmAiy1HeYrbUYoI1SPiyQRffPXakZwy30nuivCR?=
 =?us-ascii?Q?bkfk8L341oiYmML0vDsohect9vd2pETRxA4fazavypog/W8dgHDbP80WxJS8?=
 =?us-ascii?Q?j1RmPmpiKkPfV7WigigTFNUOQbTdLoxwSngqBvyRPvnP8z2jONvWA5B/v1Xd?=
 =?us-ascii?Q?e1aNc6UOil1HhD/XBrVSKq/eiJj5AavnARfjhVea55pBG3EDcyvDGouldvqs?=
 =?us-ascii?Q?y8y9HuAO8pLVWZTa2W7PQKaHd12Nki0GU7PW58wrik2Q5AvdT+J9BQQ32YWy?=
 =?us-ascii?Q?ZWL4BHxBbqlSzmCvQ+++0eYahwLLm0K87qBI4YrIhAqWv80C5SFQyP1YHu0S?=
 =?us-ascii?Q?3HZte76ULNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GquQOR9+D0ONDdxWx6qgAaglOgiss8K19mhmTmdzBlPIBrIRqvttUJ+hKVuX?=
 =?us-ascii?Q?7li7x4E8zgTUil6R0Irzd4OgZRwhO9qRgocG5vwCjySRdVihqwQkYQQZzlfC?=
 =?us-ascii?Q?1i/NfnKiofH8HLeeCXkaDgtBphwOqWj8MKstryJgYTdb11wjqEyFY4iQ3lul?=
 =?us-ascii?Q?5OGc5X1JlJABJvjAPnCcmXQH1A8AsfAV/g4CZDdHNDlrE4Gt2Wi0HysNBRPm?=
 =?us-ascii?Q?fKg9MfWrpO9Hku5S7Jc4A8Rih3ozVZT2a5UrEDHx7PMQKPfH+Qx14SZFd+Kp?=
 =?us-ascii?Q?rrhcsc5H8LgNjQ26rKp48boOZMu919e0ORyaKTL9lZjdIyDkpo/FEnTxjEV9?=
 =?us-ascii?Q?3MRnYSJTAm7/z1IX9l8X2A5GL0rUb8PZk+1Ioc/0HyPvebhMewpDUhGTsbcS?=
 =?us-ascii?Q?DWQdnpClOuhhNu6R6DwJj2hvyhUk7nFDGfE1ir7xagL7quP4pYNYi/4xcqTt?=
 =?us-ascii?Q?NS0NoOtJORKpgqXqG7sY+ICA/RhWVUVyMrG/g80TG+a60+/ez+MdHy8Mvq8W?=
 =?us-ascii?Q?e9/1x1RnL+Jvvw3Rm+uWni8fDl0GKc7PGlZiEnc1tvVQshI6j0FJbnJWpn62?=
 =?us-ascii?Q?TKP7o8j1qEuqtNnGYSLs0nISWaOgj1j/gM2e+AXXAUYeK5f/UlylEWOvOY0r?=
 =?us-ascii?Q?cVnkEs0d9Mn6FAofi6lGno/rEsSDxjnb+QENlMnEIiFQn0IJy5QXIWSLBCwK?=
 =?us-ascii?Q?Y6Ma1TGMTDNhc1yRcuEIRKOtQKF3HH0M9RLZB5WgjlkerCI0lX1D8H4rzfy9?=
 =?us-ascii?Q?Htxbo8I+FAxRqonQaLpBPAXI5iK5jZ+v/altYs+jAW+ho827RXsK7UzBTDTn?=
 =?us-ascii?Q?OxdJtCv+q6UIPnXjO4oD5nBZW15ylY4HMpuy3N1nEtJJVfqgyiDsg/auUNmd?=
 =?us-ascii?Q?8cADObSNCSnaGPiM763JD7qr4lhA7PKLG2/iXFmKG4EwOs3VS58svVhRn9os?=
 =?us-ascii?Q?Jp/+Fo3pNle/vMHfbLTuRwcP+o+ilyCPZHyrpdCw1Z5Mocsi/U4T+4TnSEgC?=
 =?us-ascii?Q?Dg5HPIwoU9ZroyBVgZnoMJF/c57cFO+TNnVadVNYDy5/PPI4dgR/yh6bmW0n?=
 =?us-ascii?Q?X5sAvVg9ROSvEiIeMi1jVUeeWYHmnXwYKBdWqDUG5qbFFVE2YeEg6AOkG84O?=
 =?us-ascii?Q?2fT9hMnD4vgtRe1I+1dxfiJz4k/3wVPLylPq85MCXpeUDY+ZohkdujGLZRag?=
 =?us-ascii?Q?HGryQwv0VvnnbRwCVZNXMMZTtUfmjJr6It/wMUkLVG3mfyei7fxH0P1kkuHV?=
 =?us-ascii?Q?JLt0InnZLnZ4gyqYX/CBqiGH53vrZXs8vEyKKi8PFY/DFD5ZncLutwEu+7An?=
 =?us-ascii?Q?yaDyFrBIy0cJetpJFE+xj7g61ca7E9ABvVDKBs52vkskbeFFGYkWwSCvU1Uq?=
 =?us-ascii?Q?pkhVRmz58IYfOK/iQK2M8va4wNJLl0aWgc4NXoL1qSNQkNpZwNVSUA6dhPjF?=
 =?us-ascii?Q?Mwb3lBELxFLU2anjktOGCu5KqwYfduWXLmnmWXpkQOZoh/cnfrkmVCeaMLub?=
 =?us-ascii?Q?i9jqd/SBmy9OYakon6dke3qiLRDPyMBkWTJrcqybPht7H8L0S7l1rqvZQ+Et?=
 =?us-ascii?Q?oBmJ+QLLAvo1ZDUnmywLdlgZbOJw52VR/HXCvBwJojIM9C7a14VB0pKDLaam?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AU3RWEfBugNHLn7vlkC+i+umxIW1HxiQKk8LQoqW/iB5NqG/ObPDkUtOgi0CG5sJh0d9i46Z1QtE1xSgQFOAdNeNjtlmMy5Z4bIvYstkJ7Rqj23skOuP1pGm2KXVjazOuJjuRpEfN6HV75bGQwrv5J88qCW8rNUvGMMo5ipgPsVGIYgWvOEN6dXiFFkbv1+fZKTuIRzMG+DXP65wPAB2AVMRpIoGzaKepFzcBqksx79CSp4g/F96XbOe4W0Ea4g10vYpDeBSwWxiZx2uvZ3Ka5W9d/o6CP1VBa+g4aTsIYvD9X5ADQ1ZsdnTTOJt32YtWQL/VU70kPhBBf9IS0bRfUQKq3TLTsyauY0Dz6dOH0/cmmoUKmMVkuwl6aZQSFh5t7IPjHNQ55t6ulfof0Tn62TjHqNr4exGUrbGDJMdGXFKHP31Gk8ExcqJKbcztf+Y+jCVV6ZS5s6Wbt8Y174v8z+MfI4QUxEi2uW37D6TZFGdrq3BR8sokdaQYfjqjxPs9k1woj7OQtWkj/puLBkTUktqGtOH9mlqa4LquCWCG2Vka/l0k3ndT5GzQWdJXxeDuYNhyJzoKSPEkUn0iJWcDICp6okbPalAOOuhWEBIZCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a586da6c-1579-4b95-8f2e-08ddcfef6822
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 05:02:10.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuAuOj5IhMO+krJs141RucknB8OHOO2CxnyWVsQ8fiv7MxN1gTYfmmXsW3SqvSveMNNJtNZCIAWmbhQbj2QF87Mv6ZFHk4dLAAuOHQjM2Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF742908B79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=948 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310032
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688af8d8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=HU3-_liuL2-fsNq4R70A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Bwk899z7FVI3f1SjpVC6D-HD3BLlFns-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzMyBTYWx0ZWRfXz6hJiKYBYmGX
 kg7XHMuAA9BTJ5wc5mma0mMSrfF1+Vut+40JKZnN/uVF9h8Ol0dkF+N6ipP5FKk/rT/1yqXOECV
 B3NbpdM1V4fngLM8uLQXylbYBBOuRkK8TF9Kpq1fyUT1we3Q25mUxBLqdnaSSXkdWpRrM49FIVm
 HqjqpKKzVOYSnTCP0IgiGMt99hiKZ8r/LgLVBPDhCdZLlV838Zof222wvxwnHXnCe9L8WCHOpQ6
 vLE6GhTWCv/roaDQb7uYwUFXiOoWVJmFNkrvoMW48U3Qly4CRkX1nbxzhm+TJUF7fzfDXj2Ay8/
 ywB6L9547F1yIZGCkd1diCFswyETu//ay4FpgkWM62FfRJCo+u6hhwaES9s6PXrA7qSy8x+5v60
 7zBFZZllmT6l7MkBYRfSZRI2swKXvtSDX5ajTyuvkI34xR9GxmNxPVwv517tvb//JaGs6dA9
X-Proofpoint-ORIG-GUID: Bwk899z7FVI3f1SjpVC6D-HD3BLlFns-

On Thu, Jul 31, 2025 at 06:58:41AM +0200, Greg KH wrote:
> Yeah, give us a week or so to catch up with all of the recently
> submitted changes, the merge window, AND finally, a vacation for the
> stable maintainers....

You guys are allowed those? :P

