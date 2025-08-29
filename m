Return-Path: <stable+bounces-176676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF28B3B0B9
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 04:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE220A0377F
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00481A4F3C;
	Fri, 29 Aug 2025 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KVZffB7L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VHbO7AfX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672E30CD84;
	Fri, 29 Aug 2025 02:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433219; cv=fail; b=eueI4I2o3UnamfDSf3NliTFo9SgvfPgmUdoORFnwJI9jVvj1tBK0251BEkG7mJ5r3QaPthGWxQ+M/UceRxaQ9Lggo9xlSr32tM01LvmuAZORPyEiQ1wPkm79V/RxyK9GaTbmulbDAcLxPNNhQu/CIoN+Fu/u6EgbGD84O3S9CTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433219; c=relaxed/simple;
	bh=PafMzAxv9ud9HYzVV34noJ3bBVMeoieu20hZ8EDRNKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oAcSopXNimP7yc5s0LCcjzFBcM4Xcn+UM7HPLACsBkyTwtTn/J1/UFldb0JEdCxzv16HY5WkMoHm56lM3Bf/vbFtSz8wB5iEPUhbwRpE+L6njKjM65b+VfopyBf6p6tKM6dFAf0Ov0l2ykFCl7Iezy0KAKpmWR2S6WwbY1cPerU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KVZffB7L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VHbO7AfX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T1frxM008401;
	Fri, 29 Aug 2025 02:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Xx6QB1bvfPch70kzCW
	vCjct0FRmDIksZuJnqZVyzvUU=; b=KVZffB7L6HWtzndVEavaONKoLRQu4Aymea
	ygzSovuJ50CpFNSW5Oxs8QoSA9+AbBWzyS6bwXfrGkIMUcFbdwEDg7WXyMaV3NUm
	oUAN73mTNFgk/YRExxjeerJgdPJZgq2Pd3MtLo+GHErEXl4Pn5HvmrPnG+BarE0e
	NI5GR8VwxevJ4JGSbPe+IBIBxSvDjb0obdTcRDwxBo7UBsTonzgvWCF8EL2GjDLb
	YwSw4XcIPtCM/lZrC8ALLn+sO2iffFcG2JwDxN7lGvlq2rEnM0eC5vTIswYG641V
	ivrjQMhRby9k+d7soqDawc+MPBxxoU7147TarZokxc1eNCp+JzzA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jaspbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 02:06:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SNo7pd005309;
	Fri, 29 Aug 2025 02:06:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8cus1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 02:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkcnfN6s4o9nYckXyBrLQqLz6SrOj9GLwAZpLQzbljURMW4kR7gRO/6liKGkfKhYAAlKYb39FVF3TPlUWkL5rWh0yHP09ccSZNJ5At2A8jwhQdn3QmDFRmiL/UxPW8JVbDGkHYOE0FMqYXt4cdHvG6ozZ5o7VU7z6plCItLtP5TCuTXci3cK52ztoxUb+1xxNFehieEvIITL4amFtCTpNLONitCmjDGTcVeXanCB2pTByEBJrGi1uZ/9xw8DmmEG7C+c+hlP/qb2L9oWQTU2Va18Zf46RR0SuNjBmD+4fcn4ttsFMRvmxzHe35jgrxh2I5URg90bXZLe7xRrWIr6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx6QB1bvfPch70kzCWvCjct0FRmDIksZuJnqZVyzvUU=;
 b=oLrzjsV3mA0MFIiKm2U2FPEyskyQCqfOhINSQrZe8frdMnnJGuGLz/EPVxx1Qpy2rz/Lh3a8CMrh4IOMAmm6VqKqB2S5ax9H5JbQH4FOeg7K66joSsBXDRMLoQ+Ys3rTH073upLaorTyIsyWDPR4kP24I4lH9TrUeVG336yEhGPBsWBEfncIHlzriaEFNPJBdrBkluIm7Hcu6QJ1JIpssQB1Vyas5kBrsX+KobnEmw+0Agg8GFZHCGs8Mda7pQgX4XcE5VtSLGLS/Oh/LOuZQ5U5yqrE4ISazxQHFWUgnRyPUuOeSEXoAAxqcwhQl1Fl9KPKYIQYu22YkKZtnJu1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx6QB1bvfPch70kzCWvCjct0FRmDIksZuJnqZVyzvUU=;
 b=VHbO7AfXtGlSONzKG71r+PKkVCmbX++IENVRdb1KRnThmnv4TvO5ZzUpl6hL0WK467Xkzq7PfdWLuNKXqd7UAK4h9JC0x0GY1UhnptO77cjtMiGebHDDRD5yns28nViwbSAVg/1yA6X3JR/jzhizRu8g2JSeYVPIVeikWNegBjo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB6713.namprd10.prod.outlook.com (2603:10b6:610:143::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 29 Aug
 2025 02:06:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 02:06:27 +0000
Date: Fri, 29 Aug 2025 11:06:17 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
        jserv@ccns.ncku.edu.tw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Joshua Hahn <joshua.hahnjy@gmail.com>, chuang@cs.nycu.edu.tw,
        cfmc.cs13@nycu.edu.tw, jhcheng.cs13@nycu.edu.tw, c.yuanhaur@wustl.edu
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when
 counts are equal
Message-ID: <aLELGQDzpjmQ4ppP@hyeyoo>
References: <20250825013419.240278-1-visitorckw@gmail.com>
 <20250825013419.240278-2-visitorckw@gmail.com>
 <eb2fa38c-d963-4466-8702-e7017557e718@suse.cz>
 <aKyjaTUneWQgwsV5@visitorckw-System-Product-Name>
 <aK1n_t-V1AlN86JR@hyeyoo>
 <aLCOVoshch9phL5M@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLCOVoshch9phL5M@visitorckw-System-Product-Name>
X-ClientProxiedBy: SEWP216CA0153.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4c214f-fb3d-4a59-fb56-08dde6a0a9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ME4a5PEwsWkw1MeNQrKS64cl2FV/L3EE5VJFMvHPJO5toKyEPZg5klImve1?=
 =?us-ascii?Q?+z5cAretvUATt7Nmg+o3lfnGQ3l3dVXOV8RaU1f6QX7lAmKRE4v/dH8Y2yGd?=
 =?us-ascii?Q?STk7I2WBhHB8FekdvPzHprI51wBOIYkqjtNwgQFoFS/PYwV8EZI7rWg+tO56?=
 =?us-ascii?Q?6RalPJEHIJkSasrA4bj+zCxr6FjY/8bpa4E0n8/9Zg8TMioKuHJ+q5aKSlQq?=
 =?us-ascii?Q?WWjenOHnmH8WVIVmY0Iz0ALwZH5WbTtlTZah4DRowmaqpMf4AGIvZ78/qn7K?=
 =?us-ascii?Q?yMJ0UHnazMhxZ0bf1QtGH7rP7rEifhKW/DZnZF+FdQi8+Dcz78g5kU2xy+ct?=
 =?us-ascii?Q?5LLcoiROQ/OfOdreYAiGNuQxTFz15Nzp92/G5Yk5U7KguYSccLg5owgXXaq6?=
 =?us-ascii?Q?rbnfatWyj1O8KBBQO11hp+HgS2wPBkMNDgZsBOiHjXTqd5Ckp8ZI7NFmT3Ol?=
 =?us-ascii?Q?hrvfR4vmf7siQ3PxlwKYotiu5hAHl8Hh+IWmqp2DAolsu7dGxGy/yKi/6B8S?=
 =?us-ascii?Q?BEyinOTfY3LmkGO9umkpwt0TQUhJFgg2RvUZhpE4rbepkugWUUtg1C5RWGdX?=
 =?us-ascii?Q?gOvTbDnyiaUpLnR13saoJc7l1jzWEZlvjDMXa7dO7HGhVEfLUWHwmK66FJcF?=
 =?us-ascii?Q?S1Fhv63Y9B+qOPV7/GVZjXjPcFiioHlz2twLzkSFJw/jZW0nwgr9PiS9cjI6?=
 =?us-ascii?Q?Kb5KYGDRRvABq9HNb9ljAymXQc9TZPc5sNHcMu5KA8s83kdh8iYia7eOYmK+?=
 =?us-ascii?Q?PhjdPSKduVSAHt7q0F9wcQY2HYLRAYAPLN7jGTfY4/M33IMOf2IQZyyq8ccp?=
 =?us-ascii?Q?w9PNO0+RH9cRXjhBzrNVhVkFXrtRwUqCbugK+xJvsAGIZ847HaGxgIi3fHth?=
 =?us-ascii?Q?0v6G8jrEsY1wSzqfayw8Qq1ecTenf0a/scAkoCmi+Dks/X8TMup+mHLeC/7K?=
 =?us-ascii?Q?O9RvyAtvWkl3aVfiUK17yktVuVeq259zfA9L2N9MkSV3A+zHeS4VTEarBVIZ?=
 =?us-ascii?Q?gZXn1KH++kcxA7HJ90Q3KgNcDGymmloiah4dgY+lN8St5pSTqEuLS4yO3bjG?=
 =?us-ascii?Q?Th/hP+MMUfM0tXJUqoTu3wSZNnpzqzRBzhpBCd+HPIu2qp1C7YIRw1Pzh3Jp?=
 =?us-ascii?Q?NMXDY1oyaDijrwV6PMf9GN6zpHxg90u52pmp+E5EsOkvQvmbXIpxlhJIROdp?=
 =?us-ascii?Q?6gUwG31XnHkbMk1072t1wg2IOzQZeI8TcSWWfAIt+Hdj6rD+aBSirajUvmt4?=
 =?us-ascii?Q?e+Cf8OwqgEuR6BsB8uNME51kJ7S+E4uMs7K8eDWrvYrkXhHAFMbnZ1VTSIf6?=
 =?us-ascii?Q?ZyIRJce3Y5hKScARqKpaWChvDG5VNWlQD4FU6RWAuBcvKKYm6ZsNgGtCDSVa?=
 =?us-ascii?Q?fdTT7sRs4rd0jVBfcz9+AJ9SBp4EhnIHYNDEhL+/3FZZD6rVIcVK5//Hw4Ku?=
 =?us-ascii?Q?a1tKGm3J1D0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Chgv91HqpLB3AsWxFPKS6s+2etpitj2Wrf200CaatuWN/e7kVglS+HRJG1f?=
 =?us-ascii?Q?2/W2cwXlAYO9OhQngIulg+PsYU2yfHvcjLmSazAsiB+uJxcITF8PYAnUnbEw?=
 =?us-ascii?Q?mu6is0N8FZQprRIUfW9CHtPx1A44HaGG9/4CBveSIDgXM8JkdRB0UPgQiPZL?=
 =?us-ascii?Q?R/gOPijhZzkZnEvTGBtsTzwCPr8Zqgc4UnST+mvWBu8VEbU5sKTTNvkRoUq+?=
 =?us-ascii?Q?N3QGKOQpG0dKRhh7TNMpobT+ezizJOS6qF+cLevsE5j/5LKTVd6yb5IlPJSs?=
 =?us-ascii?Q?4RfP3anuC5HilqZKLibCQlNEnqHhf1VlMHikDLP6AU8b8+x59QY74EnpnSqq?=
 =?us-ascii?Q?C5jmbSA2UqBi3R4ngQShCMJZYclZxnsh6dfUnaBsQH7fsNW73tbPx1xKPw+Y?=
 =?us-ascii?Q?f6jBNw1Lzd20eTvx9wOeTAi6s4HepEhc1l3ZekNM1CfZS8jFjMHpwzJokH9H?=
 =?us-ascii?Q?BC2Vab2GbOtLq6jL7P2ROq5Hsw8gRESPuvGJdKY1zBcT8gf1ow7gcGkJ308Y?=
 =?us-ascii?Q?nt24muAJmqQzL/Bj/s1Bf2Q3i0yZLQbE9dNUzFPXOGuOI2dFLfe6BqXB6lE4?=
 =?us-ascii?Q?EQZW2j+YlRqaAJGTV2t0GHUbCq33153rIcQUuvitx+M/S2vrq2Q+Ij6gH/PI?=
 =?us-ascii?Q?BPw5YCNtTkmHkD2uV5vI1PnIXXZJHvlm2oKEu56DU8ynnXAuGSRuzqUoHbfW?=
 =?us-ascii?Q?ujJ1c9vpU59mtk/t5kGAXiYCL17bRhNJazzsVS/IpcJuP++kDtWiBEK1Xb5h?=
 =?us-ascii?Q?PgZ8ueV0B6I1XslWOt+WNMQWar+sECvrTsMGWch3Npq81V4Axsq6C+9Luwmy?=
 =?us-ascii?Q?VVMpHVYLW1kZSr+KY9brW4pj30ddGFXiUpTdycfJ9IT9dWnitGT9QiIdgb2s?=
 =?us-ascii?Q?1oJr9dWyv1iQ59zChF5pLhLrWd4rHl0HuWBm4OYSYdQoXDuce2+dx9SiT4+Z?=
 =?us-ascii?Q?bd2BVMLm/EjvGswBMSeQfzS0XBPEdBrZftBl/FBLtXftqxnVgT5mQRmIzNwc?=
 =?us-ascii?Q?Ikx24dRTVzihbvvyx3fZk2jhHsOD/rqiiHllvnBing1U0AmopFiCX1eVxyuw?=
 =?us-ascii?Q?LY4QOsWkCuXModWz+3RuIkn0yXXal0YjHc8HgbgKrrbDjtSiH9Y++XsdBCVA?=
 =?us-ascii?Q?KuPOHc9MCAGuuRZgzS6aa8XdtbjjCH+iT3UwvygIdk/v4Ls/LKR2GKV4jqck?=
 =?us-ascii?Q?j6SrNMzgSU4bKAMA5ofApQwvnbywGQhpRXrsuoACovAvmjseqQ7RKane173e?=
 =?us-ascii?Q?1SxqUMQb422aT3yCxShxf1KXUrvv69PMP/VOmadEUpHjuoebHFjuypO0O+mu?=
 =?us-ascii?Q?9yqKyBwULOKGZvs1UBc7FqrVG04Na13lGRgA8h6tH0zdkambJSWc8+YbPyBJ?=
 =?us-ascii?Q?ls5U2QnBijRJQiqSrE90kMswrx4wKDRg+bwJmChLe2FD58PDA7jZCFteSM0o?=
 =?us-ascii?Q?ZQemgHTsLNTTKxcXPs/1yndjTO5eUgWKezi5Y0KriV5GcZIYwbq+uZuGi7k7?=
 =?us-ascii?Q?sXX204Ro2z7XXXekWfQZ36diK9bxAGyh+yeYt+A6A4VX4gzZRYnUW1UWhcnd?=
 =?us-ascii?Q?8fqvc2sp1hy7t0o0uKde1FFtnG5qZM7fqkWTl5N7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rPwrvJ20wFBOmKw0At5CS4OPDu5Pr/w1mgtSjnxhnj9LxDtWlfA4nV/RfZ04IF1DWmo2kEW4iXs7alN3cadIVzfL6upv4s+7TwEgTgg5UIzFJT4p9dto9h43p0cO+b6bZdH479MRHX6pzjQqqNT1FcSPpUPOaJZcguNd2S4pFKq7mIn5pVGs0sVaaWWz5OGJrCV5VKLlbcTr0axVRuuoZjK0uP96aLhYn2RXhq0e4sKr1JiEceQNTqJnjdB21cqVK0I69b3/M1+VIKe8oRG/KQqZHNvYO6dkm0ivWfdrrHH9bH5aNK52eLp3knYlbFMn0a6WfyHHHePcrP/wSTIaxc3cXHvD4MIi0VVGgot3w/O4p2heNItnexlt4sH0aXcnGf7tqOTrmr24oXgq0vqJyK9vICzkV11UQwYFKnFyUMaoxNM6PFApop8ENXqihvliC4hWqNacjsWKvJ5U/zze7/3TghThzMuRTwETY/VxufrOrV1/B2crONMBPstAgJnGhVHABERZS91lWeU+vNLnCQKtFTspvfZuJX0Z3epGaNfWxFLa9GVJ+tOLc5ZGcGEg8x3QzpcGgbPwbCOpC7nB+B515JRUuPMEMqyU+UldwLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4c214f-fb3d-4a59-fb56-08dde6a0a9ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:06:27.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xzqyc/Q4oQ03MexMN09SAr24tLLaa4oCKIHLZfRJi+v+yg+a+ow+swR0i7jq+exdIkb3y/pflR3dxyhlmi5Z/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290016
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX1iqUALlyR4yE
 /ZV3KzTFeNxiqY1kVOKxVmTr303uUQ/bIK8Epvu2wEjjCiWZbq1iisCvM9CJyYcxAvv4bHnKUt3
 tFAOOLS9YqeFKuNpuW44diSOSgNWJLOqCEaaqP01X2AK8fRfgKoAepzeN2eVk+DCjkSARmy4E5g
 WefMv8AkKOWVSOYBaWAgQ+o0dbqREVYOUFjiA3xbsSTIcYqU1RaTQdprrxe+j155XvvmIB7vA8Z
 MX0CrbYLp2PbYzUvwpebwn0Ldf294++bqy3lHIVpuc48ezVPMeCQRWOAB4IMpezTsQysoXCaQs2
 skiklytVHYoP9QqjcOhTXRkPGGj6hRXf47tEtDCE3MW29wwRoYkE0sjKe+9MMmU1hTwNkBHMgri
 Ifq+IGxgIuhNi7yRtaVZrJjIlJqU9Q==
X-Proofpoint-GUID: 2cLPU0pwPXTYLK2pUbw8z-YHeUVtIfDa
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b10b2b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=CuuHCt6lwlVgYl5tIdUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: 2cLPU0pwPXTYLK2pUbw8z-YHeUVtIfDa

On Fri, Aug 29, 2025 at 01:13:58AM +0800, Kuan-Wei Chiu wrote:
> On Tue, Aug 26, 2025 at 04:53:34PM +0900, Harry Yoo wrote:
> > On Tue, Aug 26, 2025 at 01:54:49AM +0800, Kuan-Wei Chiu wrote:
> > > Hi Vlastimil,
> > > 
> > > On Mon, Aug 25, 2025 at 07:28:17PM +0200, Vlastimil Babka wrote:
> > > > On 8/25/25 03:34, Kuan-Wei Chiu wrote:
> > > > > The comparison function cmp_loc_by_count() used for sorting stack trace
> > > > > locations in debugfs currently returns -1 if a->count > b->count and 1
> > > > > otherwise. This breaks the antisymmetry property required by sort(),
> > > > > because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> > > > > 1.
> > > > 
> > > > Good catch.
> > > > 
> > > > > This can lead to undefined or incorrect ordering results. Fix it by
> > > > 
> > > > Wonder if it can really affect anything in practice other than swapping
> > > > needlessly some records with an equal count?
> > > > 
> > > It could result in some elements being incorrectly ordered, similar to
> > > what happened before in ACPI causing issues with s2idle [1][2]. But in
> > > this case, the worst impact is just the display order not matching the
> > > count, so it's not too critical.
> > 
> > Could you give an example where the previous cmp_loc_by_count() code
> > produces an incorrectly sorted array?
> > 
> Sorry for the late reply.

No problem ;)

> I tried generating random arrays to find a concrete example where the
> old cmp_loc_by_count() causes a wrong ordering, but I couldn't
> reproduce one. So I would like to withdraw my earlier claim that it
> definitely leads to incorrect results, since I cannot demonstrate a
> failing case.

Yeah I couldn't either. Maybe mathematical proof would work, but I
didn't try.

> That said, I still believe the patch should be merged, because sort()
> only guarantees correct behavior if the comparison function satisfies
> antisymmetry and transitivity. When those are violated, correctness
> depends on implementation details, and future changes (e.g., switching
> to a different sorting algorithm) could potentially break the ordering.

Agreed. No doubt the series is worth merging, just wanted to clarify
that bit.

Thanks!

-- 
Cheers,
Harry / Hyeonggon

> Regards,
> Kuan-Wei
> 
> > > [1]: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
> > > [2]: https://lore.kernel.org/lkml/20240701205639.117194-1-visitorckw@gmail.com
> > > 
> > > > > explicitly returning 0 when the counts are equal, ensuring that the
> > > > > comparison function follows the expected mathematical properties.
> > > > 
> > > > Agreed with the cmp_int() suggestion for a v2.
> > > > 
> > > I'll make that change in v2.

