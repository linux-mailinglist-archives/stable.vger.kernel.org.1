Return-Path: <stable+bounces-106833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B524A0249B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 12:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E033A2425
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594ED1DAC80;
	Mon,  6 Jan 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Brv70obz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rs0UkRju"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553E199391
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164634; cv=fail; b=E3Wmy8XDl46dpPQa+nVPSzbeCubmOq1rvYUmMriNGzmwuxXc4yaf6I3/tbtNnkTbJbmwEu0y0sy+pcNcP9oIlN16ZGdmh5ydCTTInqaLTlYG2HaBASnOOvuhuK3YwJXCGU+eEui4mNNC0eneG0SffUlsnvW9On3m0kfs6jCeUgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164634; c=relaxed/simple;
	bh=SnrAkq3HyTN1LTgHy1C8Rt/H0ulEgs9F/micONjOeoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOroeNnvZn3d1arw+J5SzX4c2QQW/ef9utL9XpDZo7tJP8BQ+086P/UeH2bnjQExkEXZf6NmDXgGO1iBZtaRBYr5FX1B0TXRR4F5rSZeo/zzBYUJNcx8/Yw7gsQJNemL5X71jBA+pHRpYhFOoq2mgR/PJ0533iDk/c87PIepFWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Brv70obz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rs0UkRju; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5068toop011341;
	Mon, 6 Jan 2025 11:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=sz5Cgy3bhLnTSoxxQ2
	+IH5CcZfX+Y3R7homx+KD3dd4=; b=Brv70obz76hZHmJJzMzVfBjuSZeUfutGTz
	epuKp6MYumIMnUfKEGBDpmfpb+meyHk6d9Ve5NkKL/fbzUlv1tAt42er9lwgvWA8
	I/MELavSSE0TocU/HAi6Em2cDQ+FbCuHFp2mR7Q4wv31rTwmoyNhLqIVZBcJ6Mwo
	vUit1jBZwW8yL9/4WEx/5Nm1aY9AIZNtIoxdtgFG93wula2FlGsCDSsSRtX2W1Ob
	ikv+Zod3D7lgCuk+mTkhSFb8Ku39AvuvjDWFDlrcxjAm1mUoQ9WaoG4nzMlf9hAW
	z4lk0eAmO1LM2whSgnfvp13sI+O6GNILGo2X4Aq9S2w2eSgV2fKw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc2krh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 11:57:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506AmOPq010873;
	Mon, 6 Jan 2025 11:57:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue6y9tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 11:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpgP5Yn9Qzl1wJJzeKsXxI0WZdGLyd4xAIiPU0MG+avO+E9WHz+7ea4zgynEVjIyczxNDV+NgJPlb6JWY+P2iagA3xht1Ob5s/brxF0RaN578gXkzTyuxiQqGkZsGfM8NiuvFdmtKFRajpCj4zJER3Q2Ygf82oVjxZ1PJAb0ON3qKMoWV6N0Wh3m4fZPCe8bh71jg6+N8WsIO+NsQNNddLkvCeDr+om04D7MFOOtDG1oJycovK3/MUszj4Mpou2Z3JvgCdpwbRmJ+EUY7X2T4Zoee+XDc7uVlt7sGz7wraJdtVYZcOO0sa9qJ+BLRjq73RLgfTVpIg+7ASxO2NiyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz5Cgy3bhLnTSoxxQ2+IH5CcZfX+Y3R7homx+KD3dd4=;
 b=yUtXC2QoZ8QNMnL8DtK8GQV+zEcJypFsTSYB9puvdQcNRgtygseQjef4ImJ63J47wJitlo2iKFZiNZBqgHECUUaErf9Q5a65UT6lVvU6NtNOTqRYlB4PSIHolu3jwBR4DPu6fcu4GswxwA5OdFoCHTsZpf6hM+W4AzCMvqEmDiqEF2EIEH+dPGTAENlzodzrcOJ91+KLFzvdJYQuk7Oho2uCJJPVNOp6pxfoBL9L9u/2AbxWHR8hDJQ8mp8V6dOt+bT2NzNPaed4C5kPYNGrsheYS7fsuYLgYrpC4bYTK+ufM+vl3Sm1Z7lJQD1ExLPK//pn+qmV6MBKCN8k6vuVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz5Cgy3bhLnTSoxxQ2+IH5CcZfX+Y3R7homx+KD3dd4=;
 b=Rs0UkRjuVdGhRbKaQtJ2YWQoiAoBFF4kzAOWctUKjLwFx61Q6sEx9MI50roPhmvSrm7c7pSJgCZvcjpKSO0lzi6CEE5JMmuiOtXgC2E6BMNb3FpSNqkt5L5r2Jq/LQJaqSnekypgw+6gNldn8ajX6IKZqbLCkS1zHC4u8SEDnoQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7631.namprd10.prod.outlook.com (2603:10b6:610:180::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 11:56:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 11:56:56 +0000
Date: Mon, 6 Jan 2025 11:56:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: gregkh@linuxfoundation.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        ju.orth@gmail.com, shuah@kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm: reinstate ability to map write-sealed
 memfd mappings" failed to apply to 6.6-stable tree
Message-ID: <d583760e-38b7-484f-94a3-2c787107832f@lucifer.local>
References: <2025010652-resemble-faceplate-702c@gregkh>
 <5c77a26b-9248-4f04-a5cb-256186dfb7f2@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c77a26b-9248-4f04-a5cb-256186dfb7f2@lucifer.local>
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: f0672cfa-d4d2-4fc0-b7a5-08dd2e4937eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HRKKaB3zD2ojCa91u0U37P2XnfUeSVccJVXvk/lYbtF7xYISi0DLM2UUEqDD?=
 =?us-ascii?Q?VDdIUsGg7yu1Vtm2S2h/rz6SnN8r8bbbGh1JN+ETb3x6wvtH5bV4Pv8Vug+W?=
 =?us-ascii?Q?sePv4r5plxd/7O6oDKLzs6kY2KfBOO5+7iWUsW39UFauQGQyhmwTvx3a1p5T?=
 =?us-ascii?Q?kHsetoxT/aN6xG9XgBt+UwRf1wuU51kk/jpLrhKEoR518VwWjO0q/w/eAGhS?=
 =?us-ascii?Q?8WaVZOPIa5kECdihp3Zc+CGxSLqiYZReK5/PbhvXk6d8GclQooeO3Pg5MUiW?=
 =?us-ascii?Q?B3iKaXRO8Sjj22LdNzTQIHct1WVSD4ZOlwKGUU2xsnlQxhAThEkQqpdkuD+/?=
 =?us-ascii?Q?K2Pwm7YANAqPZyrrApcjF+AERSvINxDK0aBE/geu+/Q0h0XwbU7otO0BJXm7?=
 =?us-ascii?Q?ix4tnTtSPJ0tEXMLN10Tg2s+BTYobDNGqgTy1wygZ3Bg5cYYuUhbH8JHO+/y?=
 =?us-ascii?Q?XS/r75hbbBjCT+Gc6czwTnx3KcvMtdfnYgGj1miozkYTn3/fhqTN6etvgwYs?=
 =?us-ascii?Q?nii/S2pEUjlbGr81cMUZizggUnx6cBFKWSge8Nb9iSTnQHJN0YvdtKF/3kAH?=
 =?us-ascii?Q?jt9g3uOxZDzPyvXgK+IKEGLsgCE2uXGd0MdVFQR9Y6Ht762NfPXv8PLqaZCK?=
 =?us-ascii?Q?Jwh+W9ykMuT3lmdfdKRFGsMKOwmV+eci/mggn3o9jUMHqCfBR9AVSQWAlY6u?=
 =?us-ascii?Q?DdVPTnz7xXxXJY7W06PMIiHhhA9MqIEPqReDm+F+1WWj2CCnFo5uwGfFJ3e3?=
 =?us-ascii?Q?m5TDURAg0PPCx7+dTomtUyR81+ZJPFx1Ns8l5TyNZfhGEhcIRqb7n5tiivt0?=
 =?us-ascii?Q?f+zENx6MCXQzdMojclw8KKoBxlVv0g//1jbalCVyj3lLBkXwv9dtyZLozeig?=
 =?us-ascii?Q?YEYXKoJgZyjb/YQgwDvhnWrMngAYBDsYrDm/Fxx7GsNdw/yvfakWBqJk47dO?=
 =?us-ascii?Q?Ih3KL+4Rp/uHNZ7LoZpBpptOp2715daD7z0onrsZ2wou2QIu7LtIzysNinqd?=
 =?us-ascii?Q?MsYEMEg+TiaBKYK+ADsBj8OqY8pe2YSP9Z78ZxjhTzuvAdy8akHC+MZDFMR7?=
 =?us-ascii?Q?wlDAyy277LlRTzUncKjfTeG6sy1qlDugNf3zq4zO476CuGQE2jq8AX/KF8Tj?=
 =?us-ascii?Q?pFJXtbuWhsASnkMAcZRZanWgqYTGp16/1kbptoZ3H3cpY9LmbENq5NQNfDjf?=
 =?us-ascii?Q?iS0SsfGdkGhvI9v/g0NU3VDP6LwaBftD1+7oVEN9vY0SOM1pQMmL+GZslVXN?=
 =?us-ascii?Q?ZadYhO96MPkvyxuJ+/mU8J/9l2FTJkAL+Y/XUPhpLrgQ0N4oWBYPY83exD4z?=
 =?us-ascii?Q?oPKtfbCW48yvLvz4JB0cZzjotRc3vNopOisVmtbLv1uL5uE9YS4mdu3ySSMd?=
 =?us-ascii?Q?ll+OgUhIz56nJ/6oKG6TfHH0J+aaWVpUVunnUBQ6L2JafQG6Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8WDKZCxn7NBI/DHr6kYloHcjPKKz5vtDF4bopAKla30ZjcoN8W6i81hjPChn?=
 =?us-ascii?Q?xVtveqjOxnZqie4Fi5TPQ6hKFGV0FkotWTflTnFHWVQEyakVEk7RhKEVm/VL?=
 =?us-ascii?Q?sBVIqchVnHmfF/07378WfYuND5qrF3GlF53saNbWob8pJB2ow37gQpIkUikm?=
 =?us-ascii?Q?wFv6wl2eHkZDkfMDIdBpd1wL3qIxMeClkoTORB4zgdITmn5tlqhMvQaDFBrw?=
 =?us-ascii?Q?N5d5gHdqAFO6J2t1qi+2ves7ZwDaKl7UCbN0DWe1ZcCnGduKz+pB5tGxST2L?=
 =?us-ascii?Q?QnqsQA5paw3AATEJtQXeIIBmKfINZbgkIcs+5m61a76IG9Tyof7ZGUXkCJ1K?=
 =?us-ascii?Q?63SRFK0/eijltQ4B4TxRvWeSwcTyUFB8QPUkInh7FQ472lLss9H3XYEZql0j?=
 =?us-ascii?Q?BdXPbliWbWzgJUgswYQsyk6aDAUpHDpyetvVhFZTmjpYOc1IdB232t1HyTpz?=
 =?us-ascii?Q?y3uOUQIxK0PMxupE9NrELEjyTuwiJVc8A7Tqn42iJUjGI9Q8DoYscounpeJm?=
 =?us-ascii?Q?iZGrXabaJzYDA9mEvlP8LhNoWpl+Z+s9h71adpEwflpp/bUWnI2eIbZ+w6gb?=
 =?us-ascii?Q?zGfzd47khP2uqaxl7al4VIQ9TwRIC9jpZEMBp/ZfU6lTCL/dLG73g5dWOx6h?=
 =?us-ascii?Q?lQRHyL1SEZkriSB8UO12X/q0tefnsUDBS0K3xB1uQgyOPX6sB7jvLcyqcg0p?=
 =?us-ascii?Q?6GHtKg5knnOAeZPe8afmSont/D84qH7lEGs20PfsKtO/PS3ifHi3gbKp5MKX?=
 =?us-ascii?Q?MfPdOLvLlsMYmMBcdNKn+bUmzurBA/GN/ghuCoYVBXCRph1stN7lNF0N+8US?=
 =?us-ascii?Q?Lg79w2e5bQVgv435rpnuTSqu8H7Mp7WT4+hAvfPMaHOpWt3vL6tQEjLa4WDQ?=
 =?us-ascii?Q?HEchWI0o9JbbMvUKHGhoUiiGPppwkuypOKneCei99Dn+LaiuqYI+4+s2PPZ2?=
 =?us-ascii?Q?v0/0GZPIITrTvuRwDizfl87W97WAxpQ1iO6gp2beBDmt6kX54ufbH3GDVwaC?=
 =?us-ascii?Q?diyYZujN0+FZMCNF3XkKRfbRNLPkqhdZCo1oHd2PCJHZ1nygDkH+sFiaIIIV?=
 =?us-ascii?Q?SU88A6VcLf7kjkqMG9/B0K/lFn9jQy1hBaenxabxkfmvdmG5of4xnELF5NiI?=
 =?us-ascii?Q?NqJbJPhQb/Q3YLRklpcYm/zkRAy2u6hvyqIh6xUMYpF31vL0LHOuwyr3ISJa?=
 =?us-ascii?Q?FVnxyCwqMPKETqH1aZgsOvi8CydvUUIyLnfLjFdTwY+yDrs7sP3jsFDrZlb8?=
 =?us-ascii?Q?MaM93GQ5RaVgfsfHQgPPDJ6asmvGB98mjlnymfhb/MWjaW04Ahp74RZ4YTQw?=
 =?us-ascii?Q?4pZcqCRwLNwfBP+fLRlcXj3Duv0McrlzZozW0q6OVf+wS1RcDHWNcpiW3DVY?=
 =?us-ascii?Q?ev/oAvRSusX9CfXUrNXe7EI+3YopuziffSyTM2MP74fXgynN0dWceEO4uuqr?=
 =?us-ascii?Q?EAFFNf5v5o1JZy7+ubh1iQMAtW3i5sV0IYTUS1Jl+uq8jSVSoTtXiY5u5QxA?=
 =?us-ascii?Q?mMy6c9d7nRq0Hb5e/0p7HpF416JjIq+xiBROKJQIatFg6/Hh4xv/S8mBjaE3?=
 =?us-ascii?Q?1AImm58aCQxhaSOwU5EIl70nn75cpPmjNN1zg/vCj4opK20MoIyeWB+fOUSv?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WvpU0d/vC7j/Hq53nF+oc+EmcMDzdoekbLhPuv80a0q7b02drM9VyfiOCKG13F4iehPUPBl0mJM75ACL+7w5SUAOv4w+2Y2senUZsn7F1WnvJFV3pmKXcErWas8ZPhbnWm7B0XqS9/0reSXJAr9KzZvvrtlwCmXLppLdCVJYrpTCNCSgm55Vj7QDwrDOXVh+79TXUMXG8kFM0WukbkgmxiSQwyqkbxcWt6Zm1/ooOtNoKSqN7z5PX6g8IcV1SNDP1koPkd5nj8m4fny7tT5bippvxS1qjdXYVLh7m/EMcln69GWnp3Dm9ivgc66TuDanPXQjpuJ7LPnuyMSwtt7c+0Tuz7I01VakG+vK2wcYECshrK/R3CgGG4vrRbrKaJjqKzwlJf8x8iWCWeAGKF6REn+6F8s2Rz6273ipKvpLfvxY6LKS2M5s0BVwRlUI7rNTSUoX8l7yXRr+wrG0urvt5xMSC2HIXP4vazZW2gPOw2SHnnKIGTkrAZ/AbEviQA/DoqwtYM1BlbHt5+nF6Po7XukydhepsdDdACU4tfBlnw82mfZpWBv46ClbMrCFPBMVqawnCU9NY7o4Cnpetl486nzuqseCP4XawA5qeDEbpfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0672cfa-d4d2-4fc0-b7a5-08dd2e4937eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 11:56:56.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOHQcntrHY29WrcFo8txsgBt0ONwUV6SSSVa5ckyZx2IFCxFTE86LeF0ptzitMZ1vGtN9i+wH//StM+2DOHkiLBbwAdTQTQpxp7W/JfGZQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501060105
X-Proofpoint-ORIG-GUID: 0GUKKDhbHBkaWRHNkzj6wDzytmIC3q7j
X-Proofpoint-GUID: 0GUKKDhbHBkaWRHNkzj6wDzytmIC3q7j

On Mon, Jan 06, 2025 at 11:19:17AM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 06, 2025 at 12:06:52PM +0100, gregkh@linuxfoundation.org wrote:
> >
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
>
> I actually intentionally didn't add Cc: Stable there as I knew this needed
> manual backport (to >=6.6.y... - the feature is only introduced in 6.6!) but I
> guess it was added on.
>
> Now the auto-scripts fired anyway, can you confirm whether 6.12 got it or
> not? To save me the effort of backporting this to 6.12 as well if I don't
> need to.
>
> I'll send out a manual backport for 6.6.y shortly. Older stable kernels
> obviously don't need this.

Correction - the feature I am fixing landed in 6.7, so no need for a backport to
6.6 then :)

Only 6.12 requires a backport.

>
> Thanks!
>
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 8ec396d05d1b737c87311fb7311f753b02c2a6b1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010652-resemble-faceplate-702c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> >
> > Possible dependencies:
> >
> >
> >
> > thanks,
> >
> > greg k-h
> >
> > ------------------ original commit in Linus's tree ------------------
> >
> > From 8ec396d05d1b737c87311fb7311f753b02c2a6b1 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Thu, 28 Nov 2024 15:06:17 +0000
> > Subject: [PATCH] mm: reinstate ability to map write-sealed memfd mappings
> >  read-only
> >
> > Patch series "mm: reinstate ability to map write-sealed memfd mappings
> > read-only".
> >
> > In commit 158978945f31 ("mm: perform the mapping_map_writable() check
> > after call_mmap()") (and preceding changes in the same series) it became
> > possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> >
> > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > behaviour") unintentionally undid this logic by moving the
> > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > thereby regressing this change.
> >
> > This series reworks how we both permit write-sealed mappings being mapped
> > read-only and disallow mprotect() from undoing the write-seal, fixing this
> > regression.
> >
> > We also add a regression test to ensure that we do not accidentally
> > regress this in future.
> >
> > Thanks to Julian Orth for reporting this regression.
> >
> >
> > This patch (of 2):
> >
> > In commit 158978945f31 ("mm: perform the mapping_map_writable() check
> > after call_mmap()") (and preceding changes in the same series) it became
> > possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> >
> > This was previously unnecessarily disallowed, despite the man page
> > documentation indicating that it would be, thereby limiting the usefulness
> > of F_SEAL_WRITE logic.
> >
> > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> > seal (one which disallows future writes to the memfd) to also be used for
> > F_SEAL_WRITE.
> >
> > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> > read-only mapping to disallow mprotect() from overriding the seal - an
> > operation performed by seal_check_write(), invoked from shmem_mmap(), the
> > f_op->mmap() hook used by shmem mappings.
> >
> > By extending this to F_SEAL_WRITE and critically - checking
> > mapping_map_writable() to determine if we may map the memfd AFTER we
> > invoke shmem_mmap() - the desired logic becomes possible.  This is because
> > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> > have cleared.
> >
> > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > behaviour") unintentionally undid this logic by moving the
> > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > thereby regressing this change.
> >
> > We reinstate this functionality by moving the check out of shmem_mmap()
> > and instead performing it in do_mmap() at the point at which VMA flags are
> > being determined, which seems in any case to be a more appropriate place
> > in which to make this determination.
> >
> > In order to achieve this we rework memfd seal logic to allow us access to
> > this information using existing logic and eliminate the clearing of
> > VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> > instead.
> >
> > Link: https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
> > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Julian Orth <ju.orth@gmail.com>
> > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >
> > diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> > index 3f2cf339ceaf..d437e3070850 100644
> > --- a/include/linux/memfd.h
> > +++ b/include/linux/memfd.h
> > @@ -7,6 +7,7 @@
> >  #ifdef CONFIG_MEMFD_CREATE
> >  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
> >  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> > +unsigned int *memfd_file_seals_ptr(struct file *file);
> >  #else
> >  static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
> >  {
> > @@ -16,6 +17,19 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
> >  {
> >  	return ERR_PTR(-EINVAL);
> >  }
> > +
> > +static inline unsigned int *memfd_file_seals_ptr(struct file *file)
> > +{
> > +	return NULL;
> > +}
> >  #endif
> >
> > +/* Retrieve memfd seals associated with the file, if any. */
> > +static inline unsigned int memfd_file_seals(struct file *file)
> > +{
> > +	unsigned int *sealsp = memfd_file_seals_ptr(file);
> > +
> > +	return sealsp ? *sealsp : 0;
> > +}
> > +
> >  #endif /* __LINUX_MEMFD_H */
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 338a76ce9083..fb397918c43d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4101,6 +4101,37 @@ void mem_dump_obj(void *object);
> >  static inline void mem_dump_obj(void *object) {}
> >  #endif
> >
> > +static inline bool is_write_sealed(int seals)
> > +{
> > +	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
> > +}
> > +
> > +/**
> > + * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
> > + *                      in which case writes should be disallowing moving
> > + *                      forwards.
> > + * @seals: the seals to check
> > + * @vm_flags: the VMA flags to check
> > + *
> > + * Returns whether readonly sealed, in which case writess should be disallowed
> > + * going forward.
> > + */
> > +static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
> > +{
> > +	/*
> > +	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
> > +	 * MAP_SHARED and read-only, take care to not allow mprotect to
> > +	 * revert protections on such mappings. Do this only for shared
> > +	 * mappings. For private mappings, don't need to mask
> > +	 * VM_MAYWRITE as we still want them to be COW-writable.
> > +	 */
> > +	if (is_write_sealed(seals) &&
> > +	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  /**
> >   * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
> >   *                    handle them.
> > @@ -4112,24 +4143,15 @@ static inline void mem_dump_obj(void *object) {}
> >   */
> >  static inline int seal_check_write(int seals, struct vm_area_struct *vma)
> >  {
> > -	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
> > -		/*
> > -		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> > -		 * write seals are active.
> > -		 */
> > -		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> > -			return -EPERM;
> > +	if (!is_write_sealed(seals))
> > +		return 0;
> >
> > -		/*
> > -		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
> > -		 * MAP_SHARED and read-only, take care to not allow mprotect to
> > -		 * revert protections on such mappings. Do this only for shared
> > -		 * mappings. For private mappings, don't need to mask
> > -		 * VM_MAYWRITE as we still want them to be COW-writable.
> > -		 */
> > -		if (vma->vm_flags & VM_SHARED)
> > -			vm_flags_clear(vma, VM_MAYWRITE);
> > -	}
> > +	/*
> > +	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> > +	 * write seals are active.
> > +	 */
> > +	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> > +		return -EPERM;
> >
> >  	return 0;
> >  }
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index c17c3ea701a1..35a370d75c9a 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -170,7 +170,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
> >  	return error;
> >  }
> >
> > -static unsigned int *memfd_file_seals_ptr(struct file *file)
> > +unsigned int *memfd_file_seals_ptr(struct file *file)
> >  {
> >  	if (shmem_file(file))
> >  		return &SHMEM_I(file_inode(file))->seals;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d32b7e701058..16f8e8be01f8 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -47,6 +47,7 @@
> >  #include <linux/oom.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> > +#include <linux/memfd.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/cacheflush.h>
> > @@ -368,6 +369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >
> >  	if (file) {
> >  		struct inode *inode = file_inode(file);
> > +		unsigned int seals = memfd_file_seals(file);
> >  		unsigned long flags_mask;
> >
> >  		if (!file_mmap_ok(file, inode, pgoff, len))
> > @@ -408,6 +410,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  			vm_flags |= VM_SHARED | VM_MAYSHARE;
> >  			if (!(file->f_mode & FMODE_WRITE))
> >  				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
> > +			else if (is_readonly_sealed(seals, vm_flags))
> > +				vm_flags &= ~VM_MAYWRITE;
> >  			fallthrough;
> >  		case MAP_PRIVATE:
> >  			if (!(file->f_mode & FMODE_READ))
> >

