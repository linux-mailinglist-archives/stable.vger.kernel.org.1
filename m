Return-Path: <stable+bounces-93530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAF9CDE71
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6EB24A41
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A31BD00C;
	Fri, 15 Nov 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MmTBmgjM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NbhYj/7f"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87B1BC9E6;
	Fri, 15 Nov 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674445; cv=fail; b=aN15AlFsEagEtDaPmqavj1XgapKqW/fUwbU0H1iZdzf/YmXRPogN/A1otszRO1CmBum5srFZgtP+QOTPVLitAsZ6TxeYR2+2D4+9M32+TGdNEeIXNJHuzgCNg+Vz1xdzQLoL9OYsBy+bECGovVMyY3UGC19DJqyFQ+UVTA4wzmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674445; c=relaxed/simple;
	bh=sjI1WzT1XqGz+xz3HXhuHAdt/2TF7qsYE4GFZx6Qt38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MV6tVOSZ2Ho8ED9FwjmT09zQQCrpVeFQBD7hRxWZmUco8DJ/Hask9kpa+/DCGtkHipvKkrM3Hc1Cs6kZVrEh1D8ku6Ez4pHr+4sOrToFmSKLlRt8WxtZxoIa9XHXGTzmTzdrk1RKcai0yf/snUlE9ZkKP+rikSV53PWqR1MHOvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MmTBmgjM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NbhYj/7f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHJ0M014501;
	Fri, 15 Nov 2024 12:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OxWMYoiN4etCWEyz5nY0Duc+cphdupWfvPon5pvG3ks=; b=
	MmTBmgjMus1Y1OHoAThRhY82a4gjQY/Vt9sU7e/6vMChl+Ep9Kv2JtQkwAhLbvRy
	MC3AoL7g0Aur42VakX4l9NWLeYE2FmEIhARTEOPkGJbaCv1ecjoHsZEpOv2/FRmF
	sxuI/IYqQPCwbiC/wejt8tpm1ZHnCkiIzjpFcMlxajIK30A2RSisbsNGEhnIYXMS
	Qc3GnAt0QaRj2AUSXr1M492kEAqnSHrig4ROY84RHjG10t8YimyIR19h08hQAxok
	0D1bYbJqrsS+mmVMUqZVFUPnfOyEdTZG9uo7BST0T5+5/jHpffEoK4shsKrbLsFE
	ZitQy523nnoeip3kowCkAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2b9j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBtqdf022740;
	Fri, 15 Nov 2024 12:40:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2mrnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAbeRHfCFCgfWA317yQlByuFeGllSYItxYNgWK4LtAqJFMevP0or43rGFuQs/mlGibIwvlSwnkfqmHdWU1NwgqSkKHDZ2YB45mUzc7zPCCJdoIIipVx2OOCdsATilH3M6SXvfVzM7KY3PdmOgCrMuMOGzXfjH7+tdTw8Uk/kqNIFIqjfv7GGLj84XrA7PWNBPSvszyMiUdtsR6ZKTUBf9eMJ5Z/JE1km7aNgLdPPUiWo37pOnfWu3MWzIS1PbQv6EbIaqk+BIVKrlOBwlgS4j+WSjij2lmV7n8loqwkACIadXvhDmkEFki5oJAbqKISfrQQeAHOmudA2njG5hVSPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxWMYoiN4etCWEyz5nY0Duc+cphdupWfvPon5pvG3ks=;
 b=kPWr6E1P0WZkI35BzaR5dioXyk3vJYKALh16wz42bT7e4IVbaPzx+1XKHoW/msF3Zks0YQqtqqgfMxp2ZsuioKfK64mfRPGB2Zvy3ctB1lfgRw564Xz5twHNmvbNhBnqZLen6OFBPl9CdNWPciR3+R2513epPAUh4YIhz7lA58NNctzT8nM2S1lVVpEVUvxbBJeyw0cOkn1palOtw6FpgiAFVvpIpNEFgULrw/QtQqeGkmoBOx4Zbl/meHx4ENKRFoxv2ZgtnsgCILk5Au24ClQuEw3NRFpYrkyAoLb4K5jj11zn9ty7rfhvvrUGGJgds9utMd8nxBu4IGR7+Mz0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxWMYoiN4etCWEyz5nY0Duc+cphdupWfvPon5pvG3ks=;
 b=NbhYj/7fmWqhhhmDNCMxLSV9d9U9sDwC441VI6Zv05Bb6SdSluP3bNGH/S3mD8HHAT1rkAL9zsYfffIiZZXieQOFJnZEGdYqlqqqkJkLqA6iSinJsPsgLhcY0RuGTHWWDDFZ6DcGfRuV9whum5fklHFU4awZogWArdGlKo6Z64I=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:40:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:40:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1.y 2/4] mm: unconditionally close VMAs on error
Date: Fri, 15 Nov 2024 12:40:08 +0000
Message-ID: <58ab2716422d1ada28981b8e3b91e19ab1f5778b.1731671441.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7909ab-9380-449d-e51a-08dd0572aaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SN0Ini/hraWUDeQQad26sRSsRzUb32lzRlZ2v2k/rFaJDxTgdAJPwxavsGK?=
 =?us-ascii?Q?NDrwsExTx+5//ON50tqi7VCwAbYJTWrHMWBYu5npzfTbEVaGOiCUFZCVhRUm?=
 =?us-ascii?Q?TIKy/3vuMVo9eB6x7wWqpoCOj94tWYwTDZoJVJy34UYM+O5woEO0Z9Foek8Z?=
 =?us-ascii?Q?uNyo7tKrGPL9FmMFdinClIEPgdeAyudHY7WlLIvMxdYgpVfJ1gi7+xCDT6Ki?=
 =?us-ascii?Q?nBp0D0p4enYVY5OH85HJxaGvXuwcBpZWQ/gIekmEBce+PZjIqH6dZmag1kWC?=
 =?us-ascii?Q?4x/HP9MWi8rHq+IQ/qUSoheNtN8EHGlwGgQ8/pToJmBOeoIfiHyh721Xxuaf?=
 =?us-ascii?Q?zeRP3pAolP6gZkwKgwJd5Zh9pfSDsi6HEz4Nk9BjkVHWPTuvgJo24xs7lrqw?=
 =?us-ascii?Q?auQNzbmPHx3y9c0Dtc/kUhMLytqd/hPMYWit4KalGfZ5K4nwC1N4Ci2sbt0w?=
 =?us-ascii?Q?b58Rjrz+XScS0aEwNisANg/5VYlyU/Ubdu9cM4qxcWFQv8rFgkWCtofpNTQu?=
 =?us-ascii?Q?YT/7Z0pnq57l4GFsN39DtHxm5fkYsJTdzgcACSGabmyNcyVQJ4iMplrqSM0B?=
 =?us-ascii?Q?3xJyiZtmT9NKAPDYd/5ennywK8vOurcujOjpvh+9Mwv+xZZtweUvBg5Tg6go?=
 =?us-ascii?Q?VPeCAZJBjPu1shNiwHG8T68LVojakyfuKDibGg9e3uu7Pt7WtEQWMyd7WT/0?=
 =?us-ascii?Q?7pyatHIAmgr85GF/llH5oV66jwOY9KU/qrX9o4FgKvRHzDv3vAplHHHgqjbI?=
 =?us-ascii?Q?/9Mb2qGnml691OEf1QPFkUNiXUJLSZJD4jIVKR6SUKMnjhLH51KpNHg//MqN?=
 =?us-ascii?Q?gpzjSLGchliUEhlqVjYzeBBVLqKryVzxZz9MavAFofGVoUgnC0S6WF1PQFfT?=
 =?us-ascii?Q?bnysKXrH9gIYhE+I4DLihVEIC48ttLuvML3J9+dhUTsKIaQIhzlGNXwn04F5?=
 =?us-ascii?Q?KTJulpN8+fvtkc5hpibfLtxxKlaX40DuA/aCSs5S1cWaDWDkLDnEDxIno0nY?=
 =?us-ascii?Q?CBHN545StIKEsRjwFNzN0LdOO0KrjFRMaG1RzS/cLLmSmErwDhyChd98qTVo?=
 =?us-ascii?Q?3TAwKV5R9SiMXhzLlzqHHchRrIXfFjxiXquDQjFNxAAIhT1wCy79zG6aCG0l?=
 =?us-ascii?Q?kLdqHqH56E4KSs/oMXDaElSGABoaeiZikf1kZEqNYKdltfw/elk9K67sVwWr?=
 =?us-ascii?Q?nu5mYgrCZsW5v8S/oYdjeb+4PHDYsVhzkqQyEk+tUbn2IkuoImEojLE0qgm9?=
 =?us-ascii?Q?zw7l4CkwykgAEB/feyOg0ju5XfDaEzBJowS+jI3AswGlqajEtA+luv5Bphay?=
 =?us-ascii?Q?Ys+3BsDNOgwDA5rOHHtNzjUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H6TisW6MSazPmphUyjUJshC5R3m3atjflLCi6CYRNjGhRPWFl+0pEBSE/c7n?=
 =?us-ascii?Q?CoRGF8OWyiYf8dC8oukxWqQWAKoCJGuLQ+0s0+8QgJUoSY9jPZ6WiaUZqoTF?=
 =?us-ascii?Q?k0nl/ouxpOl/p9VTq7UkG3nx2cpTvOiyvHzybxSlCCajRlGRK0oV3fCQoR99?=
 =?us-ascii?Q?mXthqZkz3TnGYmWCtbtdcvnQ01KnWZouM2eLKzM9xsWpRi/EI5a0bxUtXwaW?=
 =?us-ascii?Q?8cljhnZRvhJtjopVdxZO3VPTli4bR6OyQ/0A1TSh+6IWlWTVtxajyDly6ghK?=
 =?us-ascii?Q?Q2kHNoIh01SD1BfBcaoyUbe8Z9wFLrEle7LMcZZQ87KEfcG92U8HzO/rmf6/?=
 =?us-ascii?Q?BkUCquo8TJ86RNvwex5oMfWsc/Z9+gzssIHdNpXdzm0dTOfS7sdk/eM3Ii9Y?=
 =?us-ascii?Q?hdcOMFZ3Ek+BPHHgGdh5DVrjwb2YUJDvXV8ri3h8wI0rOBF8gcR3CBQKnp37?=
 =?us-ascii?Q?axPxO3tigz1PDvTacZbjaBi6PiDXqLgBAfFtV6m5RVhoSolITXsVypvIIECq?=
 =?us-ascii?Q?LudJeetqXbWoS5glHcuGRjpBgYkleZxEuPLayX7Var4WkGGndln6F3FEtq2A?=
 =?us-ascii?Q?Ot+J6IIhuI7kQpoESlvOxLSY+UURLuS5mh0o9vFSQpghRhclPNuKHOBdJDuw?=
 =?us-ascii?Q?aKGCW/Y9x4NOMbjzkbhvI36Ctm8GVb6FkDrR/UcrtqdG1KlUJZKErHKyFrhk?=
 =?us-ascii?Q?GMbtvME3Cdld0JkzqkeLVFHTgTpFlqW30e1FzHFQ2Ov7V3slHoGGWwMIgbLx?=
 =?us-ascii?Q?RvowgFBuIHr6EjxFzeaUKgWLMr/c3MrNZpOOwQ1kNVrYEEq6/REeuinbX6WL?=
 =?us-ascii?Q?EeQVOQWTqy63KybOw4vj+jFQjOYZl5mik2bxJtpRSKWkzHLvqvejw+7g/JT6?=
 =?us-ascii?Q?FToyBGFx2TolqMjBcGfFyz1oologntHz0DiS0z5szRyx7JCHyBK22oy606mk?=
 =?us-ascii?Q?xjp4UGQghO/15xTeOsAKQj9DC9/WEN7fjjn9VZ8749nJvGgRrQtC3KzTdL6f?=
 =?us-ascii?Q?VrDUDK/GS1BnKL9z33HwBeAzPxLBFGTQYECgK7mK9reDt3ks4opiyPUDWWBE?=
 =?us-ascii?Q?GJzbOyIDHqa01BkySWOKHuqjZMni4N8CRrX1nvNldrvEdxFAKTUlORc0rQYS?=
 =?us-ascii?Q?B+g50kYt1UEzvl/4XGDV8TeHBMjLWzcHC22wOgc4xRoIx6LcRAEogaZ71KZj?=
 =?us-ascii?Q?D5r04wT/A/BHEQEzcA7aahJGmxGIlV/OHzsYLVhZAZ8+v6c278JG94+Q/YuI?=
 =?us-ascii?Q?IK9tUN6266U6al2RlvCFi2L0cAApOLUI7/IVHgAOrxAbQbaeeeUh/bNnPYhb?=
 =?us-ascii?Q?+fCqPJ/0eKBtsyLqI/Y49v6vS9A/YEXo5zn6JpWcQeycbB0IJhlTwfTPjmby?=
 =?us-ascii?Q?InFrw5j7hK0wlBmZA+AZIkHaBHzeR7PzYSpDfpiCpFxcW8tCUbQIuXmVWvs2?=
 =?us-ascii?Q?NSqKSiQxE2hXXftPGQJF3qEZrfp+6pxA4f2TUVXu66qI1zdf/gskwJgHwbHd?=
 =?us-ascii?Q?ByKkdRDYjjaGgayaHFbk7uByQoShuA/gXwBGnF4I5YcqRLRBuxdR44ptl+M+?=
 =?us-ascii?Q?PKmKbmqZznnXJjmXL0VZR3sJiVnvidNdyWj1iaNOH2aG8zRwxcmFMhS155Bg?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWjijpyQesvhmHPTBOXKotncBoJ3m2+Qw2lFEhXd1BFUL79E42oi/uA2dfZr+wrinmo9tVaacej3pPb0Bz7hiAjB2hm0i81UfTBn9HbnNf2GoRJKmzHsEKIEz3uppFkI3JKHHqd1bFEYylbZrTm3QgmiUQzokziW2atc1D2MS7NpvoWC87phttm9u+IhlC4GLxWL1M9j4dP8Nlmf0qo9uv7dZcsw1UpWZic+AAf8BJ9dnBEFvVRQY3/ujYUoiDU1TWmwYUH2ddH0qrHGdhQE093lj/GO52Fi1FS7fBitFR9hfzdzxrbYblmrCGqrJpEEWPQiIpZzcdqnZxSxe75k2MdPwiJHz2adsOrbY2Wl1hjYGm98ExlxNxF0NJPGVpQN/H8CTIcKQVJK4yJw33h5ZF4hoAuFweyOB3vfFmlpcn3qiLvem+1xCwX8y+2nHe9V7/nXFc2I7HE1poTqRJ3eK6Bhj+MiXQZ0M3VeZ8lwhgtoSVjPerEzwOtWGna2vWgnzuk02UWow3rpli+iNGONlbFONqcLk0tjpe6Z+sgQT7S1V5mIxbf7pRco2wsA17XRLEb6z3kPCXi9Zp00XKDKyarjz6HqEYYBMQn3wwXd2/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7909ab-9380-449d-e51a-08dd0572aaef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:40:20.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kxcup4xNp8HprQBVUwJSmOYld9fmG+CMhbXfAa79IRkxgxMKZBZs8yWUOmBfGLRD8r9JqNhA9LDfEttIFn0pMNO0eySlAxHbi1aUm/AOlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: H51HuOrTnqGSwv3BqamfB5cbYeVOQ3Nb
X-Proofpoint-GUID: H51HuOrTnqGSwv3BqamfB5cbYeVOQ3Nb

[ Upstream commit 4080ef1579b2413435413988d14ac8c68e4d42c8 ]

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     | 12 ++++--------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 85ac9c6a1393..16a4a9aece30 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -64,6 +64,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
diff --git a/mm/mmap.c b/mm/mmap.c
index bf2f1ca87bef..4bfec4df51c2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -136,8 +136,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static void remove_vma(struct vm_area_struct *vma)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -2388,8 +2387,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	new->vm_start = new->vm_end;
 	new->vm_pgoff = 0;
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
@@ -2885,8 +2883,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
@@ -3376,8 +3373,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);
 
 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/nommu.c b/mm/nommu.c
index f09e798a4416..e0428fa57526 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -650,8 +650,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index 15f1970da665..d3a2877c176f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1121,6 +1121,21 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


