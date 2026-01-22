Return-Path: <stable+bounces-211295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMtBE1hscmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:28:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CB6C6B4
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDEB630073E0
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807E37C105;
	Thu, 22 Jan 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pangj3yf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EtKe0K8u"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDA378D98
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106494; cv=fail; b=Wn9eyDr9NjCTIU3mafZW/HqlxFVp1B4Yq8qt+QABrj/exjdz8mfsoDhtdbT+C3Ze1PexcIRxlt3+G2EISe8yAs8x/kLha7FHqpkRIPz2qrYs0AsP65L5MkT33SYNx1vkER9pSj6ApCEiBHMBFRljj4rRQ8WB7er+xf3MmKQ7zXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106494; c=relaxed/simple;
	bh=zNlMJ965SZmuCdb6/U0GFYH0LICLyyJV9CxKMGLt89Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWNieBl/UNtOS51zd+0JG0QzC2Zv3zwtJwjtOV80MUyMv+SagDITeFsB+EkRY4VQKqkx2vxd8S1Y28lL6iSjmxsqBvnOplcc0/ogFOu/R1JurWfoi0Mmo2aaotekSv7t0Sak1T5n90ro2OTy/U76QlBkjst3SYSyoJt22VX1Lrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pangj3yf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EtKe0K8u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgQhw515590
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nnn2BgykKkjni5nZd3LogIB1yQpmRUfpf9VHt1IFXtM=; b=
	pangj3yf8K4iHaoAI/bWKD0NuDW0iImDePQxJkwJ1Wu7p+pIcmt/bWl73KZbe2H/
	YdwLCOkLPKSQIoL2APtsemIREph7wh+kFEuJ4l28tMJFgPSojlI6Z69qIPsYxCtg
	xXp4zk2v8hXjXlRNnWl7swPzF9hmkqtfaks8vOwRFO/2NxGAflw6SBrQ04D15C68
	MHmYiBtxB9v/KOQjmEI3L4O+IkzPHpGNvvKtDgCTzju3+pr2Gvf7Yk/oJVnGVABu
	6PT33qZpwMRHHcABoUwXY4FAILR5wnyjZ2fvHsm04bhZTF9Ujwkyccn7VQjmZ3Dk
	YHKTG6+q13wuUDAYr7pXWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qgd6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:27:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIPqSr022652
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:27:56 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vh1mc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uek0HZ6NwqCFEfztG1Csqm7d6quA2EzZbKwXgmlatvCCfTcvcFLgA1F6Bv4Uc2H7spr156EIw3nhvK7qzBcW3HuLYwI0Wx9Oi/Ohya28H9PW2771RKE+yynEzuRFmXw4aRHQKAvkcuAQ49yQxiJSGYeVMz+i7JN/4XETbA1jQZrWlLgWKU2OqC2j898F7dNSloDdJDvmQ5blv1ObmL8+reZiaC1EUQIYNpCT3K0XeFzfEjZ/ZtfZJty4NnH/l/8MuRF25AVERDmhDr+PcZ7XwsRkFvTcdbYvMmk34+Cz4JycZ2QFqLwpQVNxRRr5jnLk8OtZ3cVjQsPKiGScVSlyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnn2BgykKkjni5nZd3LogIB1yQpmRUfpf9VHt1IFXtM=;
 b=gjM7F7JeTl+gI1w5YuLK7c9FrviaHnjaWgkEVCCwu4ebOi23E6OCtA1rVeSiLKvzcjUmL3kqub7hnt8fXaQXi1dgCe87tVBOTO9fyj/GfsPZQhbxuRp5Zld0kC8sEaHFGZL4KravcPc0ewYYuFaOl9NCJDrzCywLuie8MB+E3gx27CtybTRUWoiCmBHZZOwPyo/e6Owcaj4Xyp+KPGBaBczmSSVpZZa4dWyPMvz9RzC9srbLJXRLy6YDQ3ATq5rLzBe3XKzwYiQo1iEtdZeb1l/nYXyfOvnO1RhKFSUJCHrS8gTJmiVfDPy/cU9+Onq+lZ6KeUayToZGjmybQKHutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnn2BgykKkjni5nZd3LogIB1yQpmRUfpf9VHt1IFXtM=;
 b=EtKe0K8ucJKcWGe03/G0+iP2ZeRz9KilR6O3I2x+h93FLQEQQaPjZ6YFrYmNPZSSSydJQ9PEoF7kE4o/w+tyNKDAnaRaM0fLxbeZM4s/t+3Nnr6IrrulfBoncd2kzCKzXvEHhaLExrvpTuM/EWQETS33PweYtWgaqJSEbaClya8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BLAPR10MB5204.namprd10.prod.outlook.com (2603:10b6:208:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 18:27:47 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 18:27:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted merge
Date: Thu, 22 Jan 2026 18:27:44 +0000
Message-ID: <20260122182744.2301298-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2026012009-headroom-imitate-c895@gregkh>
References: <2026012009-headroom-imitate-c895@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BLAPR10MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 180e59df-962e-4a33-5dc4-08de59e3f0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMaG1zCK4DNlqz6XsR0W3S7Eh+osbm3Qn35tn5TBNyNtb9zdGzqUkY/85IMt?=
 =?us-ascii?Q?113kCuto7WUdhXuVmOGnLE0HBMIi7F+IwWS/NmoOr5JgvZM6peR0Y+8Rit8R?=
 =?us-ascii?Q?sB4e+JSUgOqFNPvpXtjtd4KX8idHzFFhj8zo7C7vwVwRQVWANU1kmDxd0EOl?=
 =?us-ascii?Q?q/XR5Us9VpfEkvXhSvXZ2YBDw664uW0fCEBdmgGaycnXGPVMjfUtj+j4+GMo?=
 =?us-ascii?Q?sqRs+aDRMXRYuECwOMZtqJbe/ueLRq8sKohor/d5ZkGYDAZ/Wr/SU1Q6aK0I?=
 =?us-ascii?Q?44otiYVR7L6lrnUNI/tzJnYa1WRFHuy5DMZNqKu+j6eoa407SaSbL9gNozdQ?=
 =?us-ascii?Q?e+32uoI/tJkBexNeknIfozHV9qv9srOQH1rlPlLsx8XZpvznp0FI12idh//8?=
 =?us-ascii?Q?r31mOS+tF1sU+8/AudZlrVyOucgg9k1eJaypQ/4T9DYVDx55+MmnrkTT0vzC?=
 =?us-ascii?Q?Qc6+6WNrOVHeGe7blwG7mNn7vANu1HX9F3sy7Gk9794cE7GK4D33QPSlPpRm?=
 =?us-ascii?Q?DRmRK8BLXnkTaAI18A3F5FRnMsdLTjN+6aQVomb77Zb2I7zHwEPWC0CHNuSt?=
 =?us-ascii?Q?nYGd5dDJjlZxi/N0JRMPcgsUZfMpQWxHuXbFh/iyIkOYHBNXnAcuI8m2g6Iv?=
 =?us-ascii?Q?twlHlHo7l6RZjiLvzCECOiJG4VLm92m4EN1xprfN9t9RAmeoV0Kmg3q6u/7U?=
 =?us-ascii?Q?deumzHIfG6BrSj0IXSJJ3grx3vcI60xGrJnpUWq+/GOY6Jm7zD77FE9at6Mz?=
 =?us-ascii?Q?e3hkFDxyFAztNURTP1ecz9VPNGwZqXP0eSlu1/n5ec4zsJ79/cKIUrWGePj6?=
 =?us-ascii?Q?94t98W+UMJCda/wfLfOyzG6Xkz/4Tk9E+I0fDpVqKdeR2L1VLtbFUwwiaPIF?=
 =?us-ascii?Q?i2Jh+pZXph9WOmEjLrWyN5AWEkz3fgGrp2ygYzVLRN5zJuZLRjf59OJRxHBA?=
 =?us-ascii?Q?0jSqzyL9yLHLFQXKYFdcVaj4a9PFODRTWl5xHWPRRGfFi3NPK9QWYqqxDLKp?=
 =?us-ascii?Q?Y5QJ4b2gXKwdM8c1qm2kJ+0TlG2eS44I8Xv1fecggm3xapM0+8NbUxSc9kFv?=
 =?us-ascii?Q?tb9QkPPKOhAxyvtqZMNtojfR84nAExz/X/hCxviyg21+VOi/iyeuzsrUoSaj?=
 =?us-ascii?Q?g1h6MufPT3MOfKhbSQ6BCZFsH1U0mJayhzCeYuL3uHvLFsArNVu1FfoOPTYT?=
 =?us-ascii?Q?jMzi6PF4F24SpVRhgEOywjBD5M1PMBz4n58hDMw9tXxu0beuiw2qHpt/fXDP?=
 =?us-ascii?Q?qknuTZVDvkTV7isijOKO7eFC20LWnqcvjeOxMdPjLK2ZEXm18Wc7aiVYDHcW?=
 =?us-ascii?Q?+AMp64J1jUulWm8j0ieaCyYDKI2u20frW7GRFsYcaEXwo8a5bkFq0PtP6nur?=
 =?us-ascii?Q?EMvm7ZSCvP3jitnriC03J5taKnSux31eScuqPM5FzkSoqFUgXaSphDiU6H2a?=
 =?us-ascii?Q?YzitHi82OBfrJwyenh5YPpCG5eR4F5TP915LAwgVH/BuXRid+SToOnBiG4Ub?=
 =?us-ascii?Q?STlJPP+RC2og9ugHiaKY+dNXTqpgp/ToH1XWkpP8yN4HU/vvOupmU2YgJK+T?=
 =?us-ascii?Q?rPkae5ooab9isfQS3Iq4uNqZAyrt8rA6UISsrR6g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VWvN1i2DGyYQLlcvEVjI1E1oc/CAiv2YVrVj7kW2xs2RGRGkFDa9NhIt2F+?=
 =?us-ascii?Q?huy92uUyplrTDNh7xq0wN002pqa6MW4Cm0x4kPhOY1EfoChYFe64tUPHvWij?=
 =?us-ascii?Q?KOJSGgDq9uQBXRvAu6lAry4lKHIvnrS5PDP695w6pBBPWMT5TqjNBF04F8M0?=
 =?us-ascii?Q?RlEzX4h3tJlVlrCxKb+ELtESi/vfMbbt2hspNK+BpSHXtvOsbIXyLq7NwQyS?=
 =?us-ascii?Q?LsKcksUAJy2+AimYUWO1tCOI9hy0K6SqR3DGJfC9K/OlOsjST7F9lHUyItwJ?=
 =?us-ascii?Q?2om9B7GGGGUI2PBVHULQ0AAcVMBkCm1SWIPRdJDFibg5oNrE/tyCH2yr/YTo?=
 =?us-ascii?Q?aJZGEUG3C6D/vuMHfxTZNPUSvp6zghHqvO3lNGSezxZOO2Yho6vFgAfKIPew?=
 =?us-ascii?Q?/8KaWlHs2fbDxeC9lskhHB1cjJEAW+8QfB9CZLg5r+555GMMpoMAXpJLWH+s?=
 =?us-ascii?Q?9Mwh286xrlHDC4Irm/j1cndINUgLQelGcoc9ohei07XuLojIHwKDOVULNHj9?=
 =?us-ascii?Q?iPk3j61Xg0aNxJz0yCPcvyS5xTrulxAlzMULLu7sfbQxTKoGSNegBqjXBeOL?=
 =?us-ascii?Q?svaVQWqDJF5FE+wYD44elCc8lve51t1IBq99Epa9Vy7SVzrRaktyvTG80r1d?=
 =?us-ascii?Q?iofZuMb0QlwiSIWqL6hwEtvM4cb5bUBpTnOuWuHetFKvRBJh5nxINjGP08D4?=
 =?us-ascii?Q?NJrwUj01XAw/blNGWp4yR15lX0mTYXlOlLmnaVao787jGdibMxBBE/p0sYMV?=
 =?us-ascii?Q?2XNP96i8mdiEcXIN9OMDuoI2BXsnz2FKTBS4UhvlpNETxOEi2t+L1xGvS46T?=
 =?us-ascii?Q?ZGKTKbtGuH5azGp7ZIRJeRtvhm5ZhpYGDXi5O/Tj+m8GebO1/ZTD+C/YIbc1?=
 =?us-ascii?Q?mKvgWhCTkKy6kF1aCX1PjN0KwAcz8vT2ga2oI/KRvmBGQa28aojx4j0yCGA4?=
 =?us-ascii?Q?4Wlc5IgyJnk2uMuLNuWqxgoT2/f1mOVL4oUg8ys5Y3c+m6z+5cNMXMqx9lUG?=
 =?us-ascii?Q?k7IyuaW6mtZa5PdEPip7pk06KP+oCc1wXTwJYzH+yCcIPE1cCFbBnmEsyZmv?=
 =?us-ascii?Q?HRvksb0bW20gBGS7xXUS8Kj9XD18C7FJ8HNv5N7y8+bkwtVumEy954c0tD/y?=
 =?us-ascii?Q?Ad9Lz4xa7MrYx/EPYAyFfsRutW0O19FGLi4dhsjkPrjV0DEVwRnU0moJ/Zor?=
 =?us-ascii?Q?eZKfkAQm5djtVEFPryLqAHvAotwrmkOhapzXPiS/3bLoMvgpHPrETOhztNaR?=
 =?us-ascii?Q?Z/9UyuA8yrTnhhOqZQE4Vw4Yq4yWQqoymLZC3+H6KruFgpwiTa1EnicT5HhZ?=
 =?us-ascii?Q?TL9aszUVFR559Hmi8GsFRnsMyJpSnJ3BF0iH4JdBZ/SY6wvcuF865hwlCbar?=
 =?us-ascii?Q?HZ/MPGug5uDCX7wv+61Wj8I410WgfV++Mz1JdxJ0dCwJoIJz/T2ttvrKcspo?=
 =?us-ascii?Q?DPMxrWg9EIrhs6QaJ4SS7FWPjccOecMfubmS5Re0VHXbCVhRvtcMBGpppHnP?=
 =?us-ascii?Q?5iqsGu/acXGk27XWlw8mOGm5uDU9sdmU02xKbv1sgN4Zba6de7aOEAMme9a3?=
 =?us-ascii?Q?UTxio0kFEOSr58MBHq2BsIKloMIbTCKJYk2v+u5lDH/l25awHrajJMhZ1kD3?=
 =?us-ascii?Q?b3bCsa8mmdHgmKbuM85Dr3zQZ3U/bxtIdLRDg6/y13PbRynaXBbQ9EpkJ086?=
 =?us-ascii?Q?Y+Tv/Wj/YzMwesgzU/MubjvlUlrVPwjiGUOp7V1aJTUfoQzRa6hQNKgHJNek?=
 =?us-ascii?Q?zlE9zcCxxh0dNUA+J0tVN71XgC2YBJo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bfahJGwaAQ++KV4jYuAguJR3PTigp8aFWkXxvnU5/Yq+QW9+3+dktWZ4gOvhnh2iSpskWuLSo++5LVebYyt3tUaG+esgaGdDihQ2PqBcrmmfl92NScEMGxXzQy44t36C5vnh1nSuJotPjt/6F768TUaJAf0OFpg/431eskPIN1cC0mTRfniv+B7kr287uWrYM86tvMa8kPjWpTyahOgzuk5Agxar04t4zYFg+czJCQ9Ujc4KS6VwfgTa//lm2pA8BHJw8nWEWKzhF9AZcV73GVjTilbIl+OviDQUs3PWeic5H2qKVZl3vpzV6CzXto3bC5BNet7zbxmfMch9W0DL9pjYEDCAccHt2jxLD//rM8ZWUo/q9Y16R/w97EdRuRyzMLQUGq2qivhEDQGkuTjVRsBpElex1NNv5LuvR0iylrdrfEjJK9We/0JyjQx94ntkvy9Vte+s+HTDvEA0hdKXJqVHxVV7JFlfb+SnYfULq5QP+303XG9JK78tjUhjb+M+A8C1h7S486PGYU9c5PPaLD2fmvTgP09snSZjWpQPmogPOVDide0ytW+reBUgyy2kwLgMu3zVflHSPExgxiRATv+8xfFKaDPCxQ92RHv2YtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180e59df-962e-4a33-5dc4-08de59e3f0eb
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 18:27:46.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pzmqvdjFQSvTXAgfws6aBYH0sKYFc9NnR7mjl3w6QSWEpuqgN3bCmyIV/pNeFIhUpq+C1aXXb5vjw75aD1p+pDSBIN5uavb1UDEdreZG1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220140
X-Proofpoint-GUID: IG8gFKoj09-dqQJWM9jIbYOiYWlYNWrW
X-Proofpoint-ORIG-GUID: IG8gFKoj09-dqQJWM9jIbYOiYWlYNWrW
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=69726c2d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8
 a=fwyzoN0nAAAA:8 a=Z4Rwk6OoAAAA:8 a=DpmDNo7s59ZT7HOtwsIA:9
 a=cQPPKAXgyycSBL8etih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Sc3RvPAMVtkGz6dGeUiH:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0MSBTYWx0ZWRfX7MdKVXdxbpC8
 yqeMPtK4ftmGm6MNWUNS2tpj2zSEOLFlEW9+M97Zvtxyn18c+Gl2/wGpzdxBOdkOPoq3ki8oD+G
 Rwt5jZSh1KWxfoWfpbWa/UxdGKPZV0ylOcVHKVrNBW9LPOKBh0HhX1o5clyrq4priiv7NzV/nwg
 YuhJSudsLWHXfc8Kzp5ukiwVltlNBW6VEjErpGjxkvwir52YRPPP4Z9IEecT6JGg42+xw3k1MwS
 Xl0VIsA6CvY26TDdPNo2ZmhhX/sx4YY/lcB02zzUAPbOn8nQHSujdDQraiY+n6aiwI3jQxpdG4g
 4TsCb8s+6TJo360EiF32WazsodaE2KNJOnoBTzghHOT348nBDpzbbUfEJC1DrWq+kytoLVoogte
 nezwyIsD4jn9IiIp8J+YHufJyjjxjl9FHqlIlFEwD5eeTxDULBSKK55Xy+o+QIG9cvaMJ4nMbH0
 c/QFBNPpbt5ZcP8wlQ/mYFAmMhxiypvaY8n1kQN8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211295-lists,stable=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,suse.cz:email,surriel.com:email,arm.com:email,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 885CB6C6B4
X-Rspamd-Action: no action

Patch series "mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted
merge", v2.

Commit 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA
merges") introduced the ability to merge previously unavailable VMA merge
scenarios.

However, it is handling merges incorrectly when it comes to mremap() of a
faulted VMA adjacent to an unfaulted VMA.  The issues arise in three
cases:

1. Previous VMA unfaulted:

              copied -----|
                          v
	|-----------|.............|
	| unfaulted |(faulted VMA)|
	|-----------|.............|
	     prev

2. Next VMA unfaulted:

              copied -----|
                          v
	            |.............|-----------|
	            |(faulted VMA)| unfaulted |
                    |.............|-----------|
		                      next

3. Both adjacent VMAs unfaulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)| unfaulted |
	|-----------|.............|-----------|
	     prev                      next

This series fixes each of these cases, and introduces self tests to assert
that the issues are corrected.

I also test a further case which was already handled, to assert that my
changes continues to correctly handle it:

4. prev unfaulted, next faulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)|  faulted  |
	|-----------|.............|-----------|
	     prev                      next

This bug was discovered via a syzbot report, linked to in the first patch
in the series, I confirmed that this series fixes the bug.

I also discovered that we are failing to check that the faulted VMA was
not forked when merging a copied VMA in cases 1-3 above, an issue this
series also addresses.

I also added self tests to assert that this is resolved (and confirmed
that the tests failed prior to this).

I also cleaned up vma_expand() as part of this work, renamed
vma_had_uncowed_parents() to vma_is_fork_child() as the previous name was
unduly confusing, and simplified the comments around this function.

This patch (of 4):

Commit 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA
merges") introduced the ability to merge previously unavailable VMA merge
scenarios.

The key piece of logic introduced was the ability to merge a faulted VMA
immediately next to an unfaulted VMA, which relies upon dup_anon_vma() to
correctly handle anon_vma state.

In the case of the merge of an existing VMA (that is changing properties
of a VMA and then merging if those properties are shared by adjacent
VMAs), dup_anon_vma() is invoked correctly.

However in the case of the merge of a new VMA, a corner case peculiar to
mremap() was missed.

The issue is that vma_expand() only performs dup_anon_vma() if the target
(the VMA that will ultimately become the merged VMA): is not the next VMA,
i.e.  the one that appears after the range in which the new VMA is to be
established.

A key insight here is that in all other cases other than mremap(), a new
VMA merge either expands an existing VMA, meaning that the target VMA will
be that VMA, or would have anon_vma be NULL.

Specifically:

* __mmap_region() - no anon_vma in place, initial mapping.
* do_brk_flags() - expanding an existing VMA.
* vma_merge_extend() - expanding an existing VMA.
* relocate_vma_down() - no anon_vma in place, initial mapping.

In addition, we are in the unique situation of needing to duplicate
anon_vma state from a VMA that is neither the previous or next VMA being
merged with.

dup_anon_vma() deals exclusively with the target=unfaulted, src=faulted
case.  This leaves four possibilities, in each case where the copied VMA
is faulted:

1. Previous VMA unfaulted:

              copied -----|
                          v
	|-----------|.............|
	| unfaulted |(faulted VMA)|
	|-----------|.............|
	     prev

target = prev, expand prev to cover.

2. Next VMA unfaulted:

              copied -----|
                          v
	            |.............|-----------|
	            |(faulted VMA)| unfaulted |
                    |.............|-----------|
		                      next

target = next, expand next to cover.

3. Both adjacent VMAs unfaulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)| unfaulted |
	|-----------|.............|-----------|
	     prev                      next

target = prev, expand prev to cover.

4. prev unfaulted, next faulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)|  faulted  |
	|-----------|.............|-----------|
	     prev                      next

target = prev, expand prev to cover.  Essentially equivalent to 3, but
with additional requirement that next's anon_vma is the same as the copied
VMA's.  This is covered by the existing logic.

To account for this very explicitly, we introduce
vma_merge_copied_range(), which sets a newly introduced vmg->copied_from
field, then invokes vma_merge_new_range() which handles the rest of the
logic.

We then update the key vma_expand() function to clean up the logic and
make what's going on clearer, making the 'remove next' case less special,
before invoking dup_anon_vma() unconditionally should we be copying from a
VMA.

Note that in case 3, the if (remove_next) ...  branch will be a no-op, as
next=src in this instance and src is unfaulted.

In case 4, it won't be, but since in this instance next=src and it is
faulted, this will have required tgt=faulted, src=faulted to be
compatible, meaning that next->anon_vma == vmg->copied_from->anon_vma, and
thus a single dup_anon_vma() of next suffices to copy anon_vma state for
the copied-from VMA also.

If we are copying from a VMA in a successful merge we must _always_
propagate anon_vma state.

This issue can be observed most directly by invoked mremap() to move
around a VMA and cause this kind of merge with the MREMAP_DONTUNMAP flag
specified.

This will result in unlink_anon_vmas() being called after failing to
duplicate anon_vma state to the target VMA, which results in the anon_vma
itself being freed with folios still possessing dangling pointers to the
anon_vma and thus a use-after-free bug.

This bug was discovered via a syzbot report, which this patch resolves.

We further make a change to update the mergeable anon_vma check to assert
the copied-from anon_vma did not have CoW parents, as otherwise
dup_anon_vma() might incorrectly propagate CoW ancestors from the next VMA
in case 4 despite the anon_vma's being identical for both VMAs.

Link: https://lkml.kernel.org/r/cover.1767638272.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/b7930ad2b1503a657e29fe928eb33061d7eadf5b.1767638272.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA merges")
Reported-by: syzbot+b165fc2e11771c66d8ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/694a2745.050a0220.19928e.0017.GAE@google.com/
Reported-by: syzbot+5272541ccbbb14e2ec30@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/694e3dc6.050a0220.35954c.0066.GAE@google.com/
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 61f67c230a5e7c741c352349ea80147fbe65bfae)
---
 mm/vma.c | 71 ++++++++++++++++++++++++++++++++++++++++++--------------
 mm/vma.h |  3 +++
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index abe0da33c844..ca0425518d02 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -835,6 +835,8 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	VM_WARN_ON_VMG(middle &&
 		       !(vma_iter_addr(vmg->vmi) >= middle->vm_start &&
 			 vma_iter_addr(vmg->vmi) < middle->vm_end), vmg);
+	/* An existing merge can never be used by the mremap() logic. */
+	VM_WARN_ON_VMG(vmg->copied_from, vmg);
 
 	vmg->state = VMA_MERGE_NOMERGE;
 
@@ -1101,6 +1103,33 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	return NULL;
 }
 
+/*
+ * vma_merge_copied_range - Attempt to merge a VMA that is being copied by
+ * mremap()
+ *
+ * @vmg: Describes the VMA we are adding, in the copied-to range @vmg->start to
+ *       @vmg->end (exclusive), which we try to merge with any adjacent VMAs if
+ *       possible.
+ *
+ * vmg->prev, next, start, end, pgoff should all be relative to the COPIED TO
+ * range, i.e. the target range for the VMA.
+ *
+ * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
+ *          to the VMA we expanded.
+ *
+ * ASSUMPTIONS: Same as vma_merge_new_range(), except vmg->middle must contain
+ *              the copied-from VMA.
+ */
+static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vmg)
+{
+	/* We must have a copied-from VMA. */
+	VM_WARN_ON_VMG(!vmg->middle, vmg);
+
+	vmg->copied_from = vmg->middle;
+	vmg->middle = NULL;
+	return vma_merge_new_range(vmg);
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -1123,38 +1152,45 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	int ret = 0;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
 	mmap_assert_write_locked(vmg->mm);
-
 	vma_start_write(target);
-	if (next && (target != next) && (vmg->end == next->vm_end)) {
-		int ret;
 
+	if (next && target != next && vmg->end == next->vm_end)
 		remove_next = true;
-		/* This should already have been checked by this point. */
-		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
-		vma_start_write(next);
-		/*
-		 * In this case we don't report OOM, so vmg->give_up_on_mm is
-		 * safe.
-		 */
-		ret = dup_anon_vma(target, next, &anon_dup);
-		if (ret)
-			return ret;
-	}
 
+	/* We must have a target. */
+	VM_WARN_ON_VMG(!target, vmg);
+	/* This should have already been checked by this point. */
+	VM_WARN_ON_VMG(remove_next && !can_merge_remove_vma(next), vmg);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON_VMG(next && !remove_next &&
 		       next != target && vmg->end > next->vm_start, vmg);
-	/* Only handles expanding */
+	/* Only handles expanding. */
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
+	/*
+	 * If we are removing the next VMA or copying from a VMA
+	 * (e.g. mremap()'ing), we must propagate anon_vma state.
+	 *
+	 * Note that, by convention, callers ignore OOM for this case, so
+	 * we don't need to account for vmg->give_up_on_mm here.
+	 */
 	if (remove_next)
-		vmg->__remove_next = true;
+		ret = dup_anon_vma(target, next, &anon_dup);
+	if (!ret && vmg->copied_from)
+		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+	if (ret)
+		return ret;
 
+	if (remove_next) {
+		vma_start_write(next);
+		vmg->__remove_next = true;
+	}
 	if (commit_merge(vmg))
 		goto nomem;
 
@@ -1837,10 +1873,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	vmg.middle = NULL; /* New VMA range. */
 	vmg.pgoff = pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
-	new_vma = vma_merge_new_range(&vmg);
+	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
 		/*
diff --git a/mm/vma.h b/mm/vma.h
index 9183fe549009..d73e1b324bfd 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -106,6 +106,9 @@ struct vma_merge_struct {
 	struct anon_vma_name *anon_name;
 	enum vma_merge_state state;
 
+	/* If copied from (i.e. mremap()'d) the VMA from which we are copying. */
+	struct vm_area_struct *copied_from;
+
 	/* Flags which callers can use to modify merge behaviour: */
 
 	/*
-- 
2.52.0


