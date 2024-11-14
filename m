Return-Path: <stable+bounces-93036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3E9C90C4
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A57D28149D
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C0189F39;
	Thu, 14 Nov 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f3Jccn1e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UwVJLDpn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0A1C683
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605226; cv=fail; b=P3Oh9p9dB/C+7E/wzyraEsYdTXSEhAbj918aXqu6ZuJ1foJsn0eNCk6GqLx8wLD4p8RHrjTBhZdJw/X6iHjTgZo65hfDWUj50kv4ECCEL2sR3M+zqVliaq9Y5J7u6blVIJYCbpM1GjB8/Rhz2VblGY1DYZe0v8LYcB0/2Fik49Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605226; c=relaxed/simple;
	bh=ajob2453zlFut6WcQWDbeDT53dTMV+wzkY6m6SMDuSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQvpZliz7YHb29T9Zhk3Jo7ZhJ98NvjYb4X7zbmmGoQKMJLV02yLHhuUEMNxkC7Ku12Ex6T4zQogUmBPFSYmcjwsDChOM0PxmFAioeQ0rSeVF2twJG+2Cl/sU4QT0TAViE+9BH74B8ZMXKx3LeNQxPwQ/0nBDF6/fRdub1P9VAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f3Jccn1e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UwVJLDpn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECSjXl008280;
	Thu, 14 Nov 2024 17:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F+7yMcMe2KONC8J9mwFUdLLB8yE90lDqZVMzZJLeVH8=; b=
	f3Jccn1e+iDXIAjOj7wFaAn1Ujl8eP4gz2SVsDlozL1R36VGzy+M9vd2CEEas+XE
	Bk5cITATKtwhiCsPvCbfbobRp4FDjI89Q/rNsxVwO2WME/rH6QUTHz37aQJm7flb
	DjVqrWD2swLb5kiJAlSM7X4WuWzpJQq15aqVNA6qKxiq7Gxpd1VRv+k5AxEo6MRp
	j6w5UO4Hy56WCp834UFe1V5ue5eeTtYsugUJR+knn+A+zyeGcPLDOZqPjOhqoAN2
	xIJKwZWpDh+5Bqw01nOysmrxNIwoSwILq9lW9Tu42Dx/wm6YsyMZZyId3F2q+xjB
	G0NSIROu/V3e5FGJ9vEUzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51s8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEFm8MX000566;
	Thu, 14 Nov 2024 17:26:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpagnh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYU0aEOGgefrdMuEqDk/xJisL4VYeecxpT7Ad2UbbNBoZ/GANVWllim/UgKq0+9KFf40P7pIXcrGi+i1pK9QFR8p+r3pDgFvgai+njpC0dtENLkfBdA3825D8DaDJBBWf3g7Zycx2YDAtKxp3QkOd5lkTgJgIbFh0vdtaUIawCYRPkZlI8zbKcTpXHP8RMwuOnQ8OB+Qglvzjgc4+dW+TOhhwkHN9gps8RYuugxf+GQyHirWAplBikm0q9ckdshfBPk9J9nQGiTqMyPA94/I7KxUfoTzKWjDKWTAaaD7CgBYQmQ7RPZC4obqLGneB5jSgyZKBWGTUmBLj2rfGVpt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+7yMcMe2KONC8J9mwFUdLLB8yE90lDqZVMzZJLeVH8=;
 b=b1rZd+55WLaznFKex362F2Vzy7bwuz4Th++yTwlPW4UXMyyMm3UNqemPvcsBZpbFu86MZob3CtHrIO4BXx31NfirTVAL9Ia0piWkDUiO3Ap7vsWvtAysKaewdw5p0w1GmPS7fnGY/KIwbfxf7YfsaXbfU3PFnBVp9YLAIFXNCGWTlbZl94N5cgjmBSQeMbJcPtHlTOwNHATPBZZRxDpoEpwQmbaX1EEbZNYkxEnmEBT/4H0yZul7P89te390Sxb+0HrFjuidTsPEalFXqtm7zOQGddS8tOTZBZAm8BbA/nkK/CAAgtQyBojBNTjFCgerXUo3xU4e/x2OM1kIMr/7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+7yMcMe2KONC8J9mwFUdLLB8yE90lDqZVMzZJLeVH8=;
 b=UwVJLDpnS+uNPNU3jrhI6hCxZq+ixGKy8DxDnjidEnzyde2dk5QKmp5PdJCau/CL/U4e3Mt21FGsMW+KNwdjLjaza7rj5eflplEJWKACI8kUxpBaBPSInmQTf4feuNahty0H6S9ZRpNGh5Dx5romo98u9vPCpT12R/bkbxMBAeA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:26:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:26:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Thu, 14 Nov 2024 17:26:30 +0000
Message-ID: <20241114172630.730876-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111146-visiting-designing-ea20@gregkh>
References: <2024111146-visiting-designing-ea20@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0457.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e5659a-a46d-41e3-fc6f-08dd04d17cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXS0mddV/9U+YPlI/I2QqOIS4naWLZLGiO50Fffz/+QtFHiFkYDMEFaFU1Ot?=
 =?us-ascii?Q?QQmQf2SwfCl7S1F2S9Df+pGPCPxOpRplw0q0XJ+dST6mKsrKbgYdAeUK/Qx1?=
 =?us-ascii?Q?b/6iDqXV3Sz3LEaP7VS+5K0jmUC05CoHZF4+tA6gyuP2Pfy2pPxagZvhO4Dd?=
 =?us-ascii?Q?sVfpPjfC2WjmatiTJPFnuMkPs/7U3a8NH8WGQe8VMLClN+SyeRj+odu8TnGm?=
 =?us-ascii?Q?tQ2+1vOgIbuIjwyvPyHKZswF+4yg4PR0MqdJcDH4jNnAGsJFkm4k8tzQrq99?=
 =?us-ascii?Q?cIyGspe+F8Sqywy4H984bpJ9bSqRKLD11VsbnEWN/llPMpdmp/ICFDDoZ3Dp?=
 =?us-ascii?Q?+P4/nQWZ0NkBZJRRyyL0pd4zBg730yLAqI4qBZQE7G9SMYc0JAw0mRral/3s?=
 =?us-ascii?Q?jJLxFDojc95Y5NWWpRXViV8YUmKkoOCUyuhHDMeCHxu+hYll43RqVNG7bnqV?=
 =?us-ascii?Q?RO0GOL2d1efPC2reoYbn4i8KPsJ3kUyjO82UlAiVwhSsmRHS1/qAx+0sdIWi?=
 =?us-ascii?Q?TMUbUgZ+/Wu9wpGWYQ3Rmayk+4uJwihE9OOsGiX381qR6qer2KHr7225cCW8?=
 =?us-ascii?Q?T/ea6+TUKURbIIDbLENXE+Tq9/swq+j0FvNiSGR/4NOEvMR6fJRYaZCQLL1w?=
 =?us-ascii?Q?ZZz1N1yH+ZTx2ioTn/XwGHZLjypinLr9awGeVrFJmGDVZo3wfJFiuaO1gOvC?=
 =?us-ascii?Q?b5z/14wjTl4QYmLSLB4r9dZ3CnFoso4T8zlW22t/K9tINJG8nwdZvlgUHayG?=
 =?us-ascii?Q?eeva7guC0T12WJlvhXm/ifWG9HihO30/ybpSOZ9d3RPF8ajsdAovo3j+VgZY?=
 =?us-ascii?Q?IiDmh2HA7TiYp5/mXUigRPc6xV/NB+djjx0A7fZvecb3mgv/5lO1gfUTIpte?=
 =?us-ascii?Q?WZKeXsf7D/o4xWr4wGq5e2S1Y4yuSN+BXpjgi7qBF7M1JO3kwLBSWMto7I4t?=
 =?us-ascii?Q?Eri76GomZVtjm/ZELrqa0xjLhx+sWGuy8cnchrPxJwGpElNtwzUfXf8Qrc3j?=
 =?us-ascii?Q?ujuYnrpIA3qkVlEXkUVUPfrVwFcVURUFeBLmcbzMlIAzHEUeaqTzz3JpttX4?=
 =?us-ascii?Q?ZgCgH/dDgwkE7NiBeJtImhqxo8N31/qNZ+AmmUDP0mr1LhI7uZ+JjwSTVv5A?=
 =?us-ascii?Q?SDDKS8cIzgzYYXs5FtSCxr9OxkD1OAQ6/EVm5JcdXqxTbRICaaTtUYKz5jFc?=
 =?us-ascii?Q?oQ/7bdnIktRFVFSSBGdJLTY5QvvBleke0xujrg2ZkJnzX/gtVae19q4a8Kdk?=
 =?us-ascii?Q?+BqfE918Kt6aGIdBgbPKIKIRO2RgSBdf97eHyYoeC57AwrEaji4/PQ+1s6dq?=
 =?us-ascii?Q?oiALINbxrHCjxh95cxSmCS1T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcUvBsYGHIpC6XiBRBJq5IGzHwrUSNr/qmMKv8YiFwEkxOuoiu6n0rKcth+G?=
 =?us-ascii?Q?eux6hMaOtcgZlYorVL9I90hcxDeXaqjs8yj0fY6IEjU2cpJISf0aU1hyV0h8?=
 =?us-ascii?Q?PHvbhlhp068an/vEyXSAnhQgZTehKSnLvVhS74IaZZNjhckpiahDvV9DAQnU?=
 =?us-ascii?Q?MdleLOQ7yY5y4GqVPq3BmJgZRvZpxoswIr+6Gd7ScupJbcje3vcw9IlQrF4t?=
 =?us-ascii?Q?MxjEdFpgSj39xIta+cOGDPCMfqA/znWnw8h8SpneMmCU6lsmUNSJIR+Cd4yO?=
 =?us-ascii?Q?5CS7skce8AaIjVpNPZh3E2++xF4zGmlkO9sIthsU2jP4WwJV7VawV1Ujadh0?=
 =?us-ascii?Q?p6sWZIwfMnUAldHwrcI0x5QneYMKrv3xmSvCLoOMiEl01Qv0JH6sm8CLXKwM?=
 =?us-ascii?Q?t+doB8Ur+pjkgLLCFbCaV5NCs5kQpE4kPU/W3Vgs9Gf3vI7suGXHosYGIV8c?=
 =?us-ascii?Q?T5V7fOIubo/DEI01O4AW/cdSO60Bcwuyc+3G79uAhtwmfZzLKBub61kmpvXs?=
 =?us-ascii?Q?W4N5sscB17gbOdQzebHot6lwZDoag62BhNTq6OCN7IbPoVFSZCU9uALWyMju?=
 =?us-ascii?Q?ZfijxvKGOGCIsK7azeebt9uKYlnW70nOPGInluJbdr7bZpl4ItvunwKQOUtp?=
 =?us-ascii?Q?SDQC6vNZHgF8inY35wKDAB6u3QAJLcCqhJSTc9RIviFtrUZYEMlp4mzhxVu6?=
 =?us-ascii?Q?yN+aLd/WQVSltMdPQKA3aVsn0i97pCJmJbwuG/Hvvd0xbSE1MjaksQX4Xt2X?=
 =?us-ascii?Q?NtGjNPixeRKv/f6CEYmarxJq5z+lJWBaJikWHtMo6WJvlVf3s4gkKWDJi9E/?=
 =?us-ascii?Q?76cz4tHRWZfsIMI2Nyp0tJxzV3LS66fmQNHwS4kxboV0yLFJUaBdmH1vhoFl?=
 =?us-ascii?Q?tOwYJmckfxoubfEozv8oOmQU56OpuUFiS4p9Cyn1ORZ6M3flrA1U+sXld2ZC?=
 =?us-ascii?Q?NDRtFyD0T+kiZC1UEfx9H/SPCcZbM2B2znwNQA8RuYbROs9bjE9WAdDZaXRc?=
 =?us-ascii?Q?iiMS2ps9kq5GujK8zbWz9XMzf87Sdu9VdlJe8KWd+0wZe0DphtrpZCeqMFxu?=
 =?us-ascii?Q?BtCsrEr1HpMcnJKTxwgR6XHFt2/uzM6amPuTSXhMqZkBLczgCU9trUdR408O?=
 =?us-ascii?Q?/L+8AqzfvB6x+R1WAyT61y/+u9l2k3jC3SNIKM9uSL/UFcQ/YQZn6kbh4fBJ?=
 =?us-ascii?Q?+eTEXbDd0Bb+wIRmMtCoDRHLCePR8LbKrg24FoZXc/vfqDyBlNqugnmsO4tY?=
 =?us-ascii?Q?sni/qXT8kjTjhWtnQXDBoTyAv3kVfyaxx75qbiJlJKCNcp58HvSHngqEiEC5?=
 =?us-ascii?Q?VkeeteJWbfgnSxYRVpNmYwQXa6ns9v5pXlvxAf4nTdyLuTzKuqyahbIAI8EH?=
 =?us-ascii?Q?Ie3YP3iYwov4zVgyjZSaA5VY4VfjAUwtrPkxVOL48rKbx2mYPitIYthOV3ck?=
 =?us-ascii?Q?d/YDy5p3nGVJ5LWVPwumxM/xr9x385KyoE8FpSsXjRpyJReBEF8mx74EsLXn?=
 =?us-ascii?Q?voNWzEXT4qUSOTScefR9x+Bg9NK1WbMh8rKJ9yq3RastXUFwX6iSBGtG6wL2?=
 =?us-ascii?Q?QuWBrx55uWj1m1Na2DW0UPld7+2KizcKbXBoMR9t3wtSpv4eCRU/k5lPEp1P?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WVw/g30upB1qv7cDKFX5mUfvJlDiziswl3Mx/5ITUKx1PsXFl6r6u76qkIUbE0qxqBlFah8bwC60RGm8ft208PN5VKK/jI5ogIknn9C45lckLKt7YOkwRiyYC13MkD8roiWLd3ZdFAJUUxX/6p04mzUgrwGYZhM/TSqPx1ewXgaz6+ulbtQG3LgsnrUygLwggngzoFxDrlq3OTk/0GtCnIv0sRebN1n4gqAWEzPz+Y0ciNO/67lwugPqu/uYHhsawMsUVIvjTbKUnXJztRGICgIbbYEN9dSXqrf5pClisNrCmME9OCQaNng5t5FDaVDU4hk1d2NVnSZNxZaySEuU/hDshlJzcvrBh/jnEXF+CScCmKTg6m50q+av0w602ISjAhQ5V+QoJeCgXQJSPahxZcLMxqfJ0daw+7sxCyQ/chfl0f2ba+F8zOqvpWUGkBByCELDDL0yaebaub+foHP/CFlJXxeOEFs+zOGcfO2zJOoWTsFT8v1yhjy8UqPqW9phx6YKUAUqHNiSm0NU/ruPYqzd9D8j5lm3t9TvwKqLa1hPxrHSjU3gFeS62+kfam8xdHqLFdJO9X0JtA3nlm5PVM1tEoDUrX+p7CqLdtn2oNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e5659a-a46d-41e3-fc6f-08dd04d17cec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:26:34.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SSjDVWfbuhKHolWJd9YdkpYqHPAYPZ4p0cWhrkZB8FcF0unlzpy5sdxvxOUV8Vtuk9VBH0c8vCrXwIzRty3YV5NvLLX7APC9IQnhyPlqXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140136
X-Proofpoint-ORIG-GUID: gfBxUBn7VxvUzqqUlIDzitHh9H5potGy
X-Proofpoint-GUID: gfBxUBn7VxvUzqqUlIDzitHh9H5potGy

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf)
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 mm/util.c     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 840b8a330b9a..e47f112a63d3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,18 @@
 
 void page_writeback_init(void);
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 33ebda8385b9..f4eac5a95d64 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1808,7 +1808,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * new file must not have been exposed to user-space, yet.
 		 */
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1823,7 +1823,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		addr = vma->vm_start;
 
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		/* If vm_flags changed after mmap_file(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 0faf39b32cdb..fdacc3d119c3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -955,7 +955,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -986,7 +986,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index ad8f8c482d14..8e5bd2c9f4b4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1073,3 +1073,21 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	kunmap_atomic(addr1);
 	return ret;
 }
+
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}
-- 
2.47.0


