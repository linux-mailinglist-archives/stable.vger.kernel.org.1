Return-Path: <stable+bounces-119977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06409A4A553
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 22:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B594B189BCF6
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 21:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF21DDA36;
	Fri, 28 Feb 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7SPU+X1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NJPainqT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D671DDA0E;
	Fri, 28 Feb 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779319; cv=fail; b=e1mCSqrDsr6Pv279Et1jLAsv24bRBKSS/Qy0XAaRiv38G3KkUzS4jhWT2Cp25mwHcrB9w89/VmxDcMKOEEYPTTW+dHCFW2LFzqwZ4XiUrSZBYzkyjnfoOX9VomnnfgvwoV9qxY0okt9G/5cXrGdUdoTEMvHXFGFQM20HUW24WYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779319; c=relaxed/simple;
	bh=DAq8BBC5Ycv2E21N+a7ZoiTEfd8IxtTq7ZsFosIXOlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RQwf9uGzsK7KOagItQnJQYY5XJ2BRHuQKe+8EJk2t8HlEqBc3lzi0//lp4exnqfYdvBASVYPx+PJWEsLN8/cQSGEKKdcBpyv066qj9dSFgAGXcGdeXFoI1Jnxwejjz/vosW5vqoFVXU4W/ArWzJD5EyYG/yM6w81XJLJ2bV1fqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7SPU+X1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NJPainqT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJLAqI008736;
	Fri, 28 Feb 2025 21:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0oC+YjqvqIxqXaFoyP
	fNkEZEW7+FFNhPNIWV2TB/Jrc=; b=B7SPU+X1qwutAaC4tpuW1K14ArzVLb/G3+
	/RLQ9A6Yru+WbZF5azox1RH9bYbj456ejz+MQ+yvIEe7Yf8iO6GqFsb52jd1mBLk
	Ors+VNSyYDVlLebHBmeq27TBzZVAtMztRNpRNw5rDws+kmtruQYmHMYXAOYhsdNk
	+RWzj/utJzyS8Zk6qf5nO2SG8+tG2uwL0KO5izdcdriyXzIW+kVrASe2lzKTeHTN
	6G6yLEEoRKxpRf/8Hwa21JwQdGDdysNkhzouCOfqw4CIZeWgloP4qJ3gvY2eIeRL
	39moqhou5DtJHZDHXbL8IzwhUZJwRcluqy5qGm7877ONUyM5fn2w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psceheh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:48:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SKK9VO025584;
	Fri, 28 Feb 2025 21:48:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51mte6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBXo8nlZ1eqc8Hqvf4FUpEjTnfCJOXt32iKvdJIaN2iP5k5Ht3w62HLxTB9xbt2gHTbnnU1s6C7C3Jye4t4ulythvlSsl819cUS4oSBIiGNb9bL0mETqd5BnP8dZVacquzRf2PBcHYOZUkEZN/pblnEnmG5hbpoCk5+eF4Civ6QQQa+A0elr4PXsm8nBBSS+ldYXgotXcfcv4Nez4qqEdUtM4zl+aOE3k8G0poQBoLCtpoDa1mciOtAJh5Uc/6HD/e4B2zkaoS9YSpKEUI5vBktqXKDcISjoDH0WZrTu4yfxoy1Dtc+eGoWXUITT0HNOW8ajRvJdO2fxmmvZ1Z3n2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oC+YjqvqIxqXaFoyPfNkEZEW7+FFNhPNIWV2TB/Jrc=;
 b=pJG+OWvXfB4VK9j5ri49kKL3q5r7x8/7uuXAiKK4S5+WnjF/r7yAFjsexxEq8ZuXWSuTC50W/0vFYUQC7i8szUU+hm+D09H/Fk9LWIbDPelrnXw+clfODNvJbbK2lIrZqrKhrl3UPWP6bu6CsZ+oQEs6DqktjkHsF048nZTX7g64n4s6wLOv9HtTXKg8VMw6hdFmnEtxuuBDj+T5V5WRQFBIf9BOs+iDhF3SPW+B8hklLGu90Jh9NtWEA1GZR3ViYuRX4q18thqxi1RCTNaQd483sNOpKtrllHwk8w3ehHW4Xnoxv2syt82dRbcFENVjy8+pNDIlkOwbaYlo9zSQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oC+YjqvqIxqXaFoyPfNkEZEW7+FFNhPNIWV2TB/Jrc=;
 b=NJPainqTXgnQJ4VP45Q8uy4kUvB4C+z/dJ1jn5khpRIXKtLGZWVrFeIg4P34r+cDSPtBJrYaCcCocVdZARvlcFmzepcy3slWbiVeD4OcG0X7sY2KG4UFmyPYgHZwZjQ4d4MMbP7zIeeeFDpxBi2uUGoZFXhzM6tNl4T4ftEaaOo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5758.namprd10.prod.outlook.com (2603:10b6:806:235::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 21:48:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 21:48:16 +0000
Date: Fri, 28 Feb 2025 16:47:57 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com,
        erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com,
        sagis@google.com, oupton@google.com, pgonda@google.com,
        kirill@shutemov.name, dave.hansen@linux.intel.com,
        chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com,
        ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <Z8IvDeIJH2EJuPo-@char.us.oracle.com>
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-2-vannapurve@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220211628.1832258-2-vannapurve@google.com>
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 3252805a-95b9-496e-ec5a-08dd58419b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oV80LuenjPACITRWZ2kSXLpscNNFW37GCoBDYV+bxjBjP+zrh1LouuXjhWJ7?=
 =?us-ascii?Q?pVaJV1ugOA8DJZCfCgJl2dite4m7GmQy0x9Rg75rhq0o99fpbVrijz97VvQ5?=
 =?us-ascii?Q?eFOE/M880iUW9hX0fz1oPKmrd4lOLgoLnaF4rv+Vg1HnG1GvIQ4F1F4XBUgD?=
 =?us-ascii?Q?6y5bBdfau2R5NHezx/OPrmFi/486yU2ebULnCLpWlbkMDLOZ8cMJ8DtAo09I?=
 =?us-ascii?Q?38CZXLwldwxtOKtVYo1pZcpXicXXzudEU9+CZWxkLnXd6TUEOyb0FQBEWP6a?=
 =?us-ascii?Q?WvwJb/mjlE75VoQc+GkGZmsbtjZIpGrhyqaOgAlSOhLyrZSG7zJVGULwn1/f?=
 =?us-ascii?Q?6+6GyluPoXJ62bVJtoAKVGpD1AyB4kg3het2FRHu8HNWqUAalmRjQhMLTBo2?=
 =?us-ascii?Q?HuxqA2gu3FGLKrolg7t3g71VHVqAfoWuCgLBkr2gmWglwJBZh2km8TPKEZh/?=
 =?us-ascii?Q?9RvQfhJjag0hM5osYzZ5YOH9WhVHjEnI8k5UaLHosdXusD+80m112C8pg4fM?=
 =?us-ascii?Q?ElfzqHBN0H0LlISIQjGF7C5t/hhCRWYJ4J3aPhzWuly5QPFiYdeXWAqJlQWz?=
 =?us-ascii?Q?Db2HtGY35O4AJiL7PxBivLh5O38PvhV/18o6LIuS8YNZtB/PkpPH8nPGJxke?=
 =?us-ascii?Q?oUFS2mp+RYASodWet4nDd70na34S3pxyelUW6Q3XUcGjPeQT0iromTwAned2?=
 =?us-ascii?Q?yD4V4Ei0oX1KW2erBpge1tL/3hPtZGfLXRCB1yvMFsKukaZmIrC8y+rP2eOk?=
 =?us-ascii?Q?+YFqjIqBlvx8Kozg1jTe6Xg0l1mcrywFjaCrNG9aTCWdeUEYyEfmqp1zTuNX?=
 =?us-ascii?Q?sQr1S4t9JE5Az/mWxWW3KMt1h+7oLUWq5s8c5eA/3S+et3BAfidbav94S+Z2?=
 =?us-ascii?Q?qGDB96TBMN9gMGyJsE/Pw8jf7czRv7vzDmkdnY3TNmysQ7fQ7hcoEzBspXH0?=
 =?us-ascii?Q?Msa4PRKipV3Q+WEpehCSHGeggmmSFpMmNMa4lr3BxjU7oKnyw1kBvt5VEBPx?=
 =?us-ascii?Q?rFmb+/zfOQ9f5XztpGKpXI03rgI7B/m85dd9l1/QOls9YVruiyFmCOawgO0y?=
 =?us-ascii?Q?UKYf+5L+NF9jHuA+djVDCa7ip+ntEgsQkA9ajmRDAvX11Ri0s00/QzHZJNK8?=
 =?us-ascii?Q?oGJKG6PoPe3R5t9HiDpRNo6/tILHsPor4zhKKLF6G2aUZMctIvGDjMoSE+Yo?=
 =?us-ascii?Q?MAaXka9cLQJb6ZDAgN1IsIimhRmCzr4Se2rQX3cDi9ef87y+z4J46WawF6/H?=
 =?us-ascii?Q?iYZJk2Yols4QhWIcpy0ZEAds2ffWI+lpBypjTeVAOhiGcRnAtWo7dO34kZdJ?=
 =?us-ascii?Q?ASZsbXjZseuw65SuAvLHu7G++hRgjf+JMLRQtD1IgPFaYb8tS5Y7n8PbsHV3?=
 =?us-ascii?Q?GjVjDZ6vecWcTdDWiAW42yCtH4Yx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGW3Dos8Hn5mNOQUC7y0g0ZPtQIxhOh9rFgvMwRA71PkqYjnao1yvWXuIejq?=
 =?us-ascii?Q?z+1XPbfL0spXLO2Ffe5kR+rG0ZjwYUT+HUPeT02Q+VVeQHfDTCTKUc4sGUwq?=
 =?us-ascii?Q?GA2GPdeGpmE9kZqM3SpdiIrXRXZV0xTQFQ5mxKagAxkIjClhVwwT8HCppxBW?=
 =?us-ascii?Q?Ve10lCh+pjtGAYY+/G022zxgmOj33mA/HPpwsKgQ2zHW/qeqmmuKxAfqqC1s?=
 =?us-ascii?Q?h0tCJjoe2y8k452jPs0DyU0B+wr5BmdoWzld+8abg8EDd53oOOZuaZi3H7sO?=
 =?us-ascii?Q?UhoCgR3mctFDRIHBMSHVYDaj+YM2QWaEPMeYfMLlMq7m90lmgC4Pro2OY7yo?=
 =?us-ascii?Q?ksacmG1CM1WzULn+wVilA1QVq2zvJTEtWoGhNhwrRgtgekn+sxbEIvh5vA3r?=
 =?us-ascii?Q?Ed+bQXnExi8XxzFOdIGfUZ2HbphnRAzePuuwibDV5OJ71+pAd++tq+g4k6NN?=
 =?us-ascii?Q?Z9bfa3C+QIWidRmD1zGC6MBWUx6edKxWV0c9hBWUMMOq72W/VPGJRCBJ0khi?=
 =?us-ascii?Q?ts/5FTLxs7y2WjK7m9NUeKGufMtkpYukw9TWSHZ52dpCGgT1+hnfcYDEIJqh?=
 =?us-ascii?Q?+RWGt8drnExZUOL1swCopJL2rqb/nBqK/uyGyOp2HuHC/dmVBpyU/DJVhKUO?=
 =?us-ascii?Q?EMSCGYwmkZ5Lt40Y6zaIUMaayymGNZjkJK4v6vOTFAfjcPrxyVLYMvjdCfrf?=
 =?us-ascii?Q?InQZTfIMiaWBFOLlZZCpwtovfvFAkra5UaOa/z8NSFBFcjWYc3Z9T1wbXnAb?=
 =?us-ascii?Q?aEzHMtNhigJyegK/OQjTxLdoCk4qK1bNH87OJ1Jjlxt+/W2OosOUu3wGFQz/?=
 =?us-ascii?Q?eTWMyqU0B+FfhBfvySWc4z4pWWt+MwYtgOBpUBFvCysAlfIsYhvJsfY/VOXf?=
 =?us-ascii?Q?ySIV092mGhBXwhBiBsgXZ+fmp1K42EP43Vxr8ThTeIfs4EHB6NXZfweElb+U?=
 =?us-ascii?Q?6NRKS92hQQsrct5Zfdy7OZdxPeUwiTBr/dRSGEuVkOnZ3skxD6lH3S3a3p2A?=
 =?us-ascii?Q?LCWCXCE1qJMB+wVPR5v5RZYHoVVoaZGyx0JKrRH1X4yp5MF4Hr9j+YC6ZC4w?=
 =?us-ascii?Q?CsCGzQjt8xJHrrmRDu7A8wCSpBGf7vqw2ukFDwuykjKvYOGCeccSnQ7HA3LY?=
 =?us-ascii?Q?eI1TUYgUUFU2+gfXLZdwXgNXpGq3oeM/j8TCW7PE8OAEjspNlH4eu5I3QBiG?=
 =?us-ascii?Q?DB8ZBVKDPyq+NjUlJJaC127oTxTpOsf8F0eZOV7rB3NmYolGFGuqbut4fLND?=
 =?us-ascii?Q?WarnU1OEwjf07VJx0SZu3LBGEuIGag5MBurso1odBIMNvK3qMIW3XRFRj8kC?=
 =?us-ascii?Q?vO69G9qUtYVrtlQI/m2PIqiKJjWtzm+EJnO+qexuEyRaXHv5SOvrCpZghNUy?=
 =?us-ascii?Q?+UXFJDF/Ck4T4ByeuJrM3mbfo5QkmXHBQp7RVaI56uiStGmwt1JNMZuvb8Sy?=
 =?us-ascii?Q?hKFdBQddlUCfKQHVsZ8yBbQ7JVgsDzEsSHIk69RW4Z/HPB4UP6qpxKxGbiTW?=
 =?us-ascii?Q?oJEkgt1pqKz37XuZ1xuPQRRtFI6CbDGQYpG5mUIUbjoFXPn/OicBlNJN5Ioc?=
 =?us-ascii?Q?fN/avpbeYLfoo1Hn/GurT+AHMR0MCfHpXVO4iCgv7Wlmkv4tRjIQgHq6CmTz?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JVnapIgrzlIQx/b8q3mLb0j06KNcpDbstN6r9X+OW6o5DKhPwIjJ6aYha/uwcCvCDZCiY/JEM+r4zJXRFmr69WzLrNHU15AeBgXOM+oWo1Fw9Ra4n+ifkZ1PH1ETdB/qfS6dUHZVODYGYu24Jmo95w3TN163ZXXg3yhsaODe2dW6FMPxRDZ29RrqJCZVre/dg8tI3GLdhGgAWT+YMapHSbgBhTWdd6ng68n5bAUBtuYvEdK35/NN7DIgrSPasaWXnG9PCFS9MUcsPU6y7V66d172XyNGmaJUPYbaVQi18XH7Usy7hd3HtGxsTvAGjExeTu8SwWgvtaWkX6XQxcyOfSRoIANN4kWMf5+vPEgAr1PT1SnrCf1/oNANO2UvrsnsRGisTtkj6en9o4/ZhRAXi0VGaQ6OjsasZ6wp4YfrV4/Z7s/7MprK6RWRurm3jyshSwhr7YoMEomVIjeN+dur/GOGAi2CK3CE/S4V0iHmEM7tLU2YNTA9LbKtRlNDXUxLojeqtCZc/w0FSge/yiTbM7oV9YCTEW6zLpAJhdjGuLVM5a4NaJ980zCOwnupKPNKcHUkF/8V+g2sKDUDE7N2oYq44byMKRFR3epsqP4IIVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3252805a-95b9-496e-ec5a-08dd58419b5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 21:48:16.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DMph/XpXyP/hAq9ewncvivPtUqOlPX12vPhxyTcY4PSu0G+vhyyBzmlJ2uJmmFJCEipg+nGu/FrTQz3rITtwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=640
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280158
X-Proofpoint-GUID: kjoryVdBJEhbvMFtGEv-9sFB_nWmNouc
X-Proofpoint-ORIG-GUID: kjoryVdBJEhbvMFtGEv-9sFB_nWmNouc

On Thu, Feb 20, 2025 at 09:16:25PM +0000, Vishal Annapurve wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
> other VM guest types, features supported under CONFIG_PARAVIRT
> are self sufficient. CONFIG_PARAVIRT mainly provides support for
> TLB flush operations and time related operations.
> 
> For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
> most of its requirement except the need of HLT and SAFE_HLT
> paravirt calls, which is currently defined under
> CONFIG_PARAVIRT_XXL.
> 
> Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
> like platforms, move HLT and SAFE_HLT paravirt calls under
> CONFIG_PARAVIRT.

Could you use the bloat-o-meter to give an idea of the savings?

Also .. aren't most distros building with Xen support so they will
always have the full paravirt support?

> 
> Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
> break any functionality for current users of CONFIG_PARAVIRT.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
>  arch/x86/include/asm/paravirt.h       | 20 +++++++-------
>  arch/x86/include/asm/paravirt_types.h |  3 +-
>  arch/x86/kernel/paravirt.c            | 14 ++++++----
>  4 files changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index cf7fc2b8e3ce..1c2db11a2c3c 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
>  
>  #endif
>  
> +#ifndef CONFIG_PARAVIRT
> +#ifndef __ASSEMBLY__
> +/*
> + * Used in the idle loop; sti takes one instruction cycle
> + * to complete:
> + */
> +static __always_inline void arch_safe_halt(void)
> +{
> +	native_safe_halt();
> +}
> +
> +/*
> + * Used when interrupts are already enabled or to
> + * shutdown the processor:
> + */
> +static __always_inline void halt(void)
> +{
> +	native_halt();
> +}
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_PARAVIRT */
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  #include <asm/paravirt.h>
>  #else
> @@ -97,24 +119,6 @@ static __always_inline void arch_local_irq_enable(void)
>  	native_irq_enable();
>  }
>  
> -/*
> - * Used in the idle loop; sti takes one instruction cycle
> - * to complete:
> - */
> -static __always_inline void arch_safe_halt(void)
> -{
> -	native_safe_halt();
> -}
> -
> -/*
> - * Used when interrupts are already enabled or to
> - * shutdown the processor:
> - */
> -static __always_inline void halt(void)
> -{
> -	native_halt();
> -}
> -
>  /*
>   * For spinlocks, etc:
>   */
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 041aff51eb50..29e7331a0c98 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -107,6 +107,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
>  	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
>  }
>  
> +static __always_inline void arch_safe_halt(void)
> +{
> +	PVOP_VCALL0(irq.safe_halt);
> +}
> +
> +static inline void halt(void)
> +{
> +	PVOP_VCALL0(irq.halt);
> +}
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  static inline void load_sp0(unsigned long sp0)
>  {
> @@ -170,16 +180,6 @@ static inline void __write_cr4(unsigned long x)
>  	PVOP_VCALL1(cpu.write_cr4, x);
>  }
>  
> -static __always_inline void arch_safe_halt(void)
> -{
> -	PVOP_VCALL0(irq.safe_halt);
> -}
> -
> -static inline void halt(void)
> -{
> -	PVOP_VCALL0(irq.halt);
> -}
> -
>  static inline u64 paravirt_read_msr(unsigned msr)
>  {
>  	return PVOP_CALL1(u64, cpu.read_msr, msr);
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index fea56b04f436..abccfccc2e3f 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -120,10 +120,9 @@ struct pv_irq_ops {
>  	struct paravirt_callee_save save_fl;
>  	struct paravirt_callee_save irq_disable;
>  	struct paravirt_callee_save irq_enable;
> -
> +#endif
>  	void (*safe_halt)(void);
>  	void (*halt)(void);
> -#endif
>  } __no_randomize_layout;
>  
>  struct pv_mmu_ops {
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 1ccaa3397a67..c5bb980b8a67 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -110,6 +110,11 @@ int paravirt_disable_iospace(void)
>  	return request_resource(&ioport_resource, &reserve_ioports);
>  }
>  
> +static noinstr void pv_native_safe_halt(void)
> +{
> +	native_safe_halt();
> +}
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  static noinstr void pv_native_write_cr2(unsigned long val)
>  {
> @@ -125,11 +130,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
>  {
>  	native_set_debugreg(regno, val);
>  }
> -
> -static noinstr void pv_native_safe_halt(void)
> -{
> -	native_safe_halt();
> -}
>  #endif
>  
>  struct pv_info pv_info = {
> @@ -186,9 +186,11 @@ struct paravirt_patch_template pv_ops = {
>  	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
>  	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
>  	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
> +#endif /* CONFIG_PARAVIRT_XXL */
> +
> +	/* Irq HLT ops. */
>  	.irq.safe_halt		= pv_native_safe_halt,
>  	.irq.halt		= native_halt,
> -#endif /* CONFIG_PARAVIRT_XXL */
>  
>  	/* Mmu ops. */
>  	.mmu.flush_tlb_user	= native_flush_tlb_local,
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 
> 

