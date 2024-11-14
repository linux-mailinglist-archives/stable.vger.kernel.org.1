Return-Path: <stable+bounces-93005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B49C8B47
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 13:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC26288C7C
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448731FB89E;
	Thu, 14 Nov 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3qT00lb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zxX065KR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466081FAEEE
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589019; cv=fail; b=EpROgAdaVKkeLI6/CP+QFjTfgMomwEbsLbxpo01hfMhiHmSLLtBFITVDvqkG7DfQLVL1DvfqUzOZUK7QzDJr4QrAOUppXxNvSWExvIAuFjU4v2bifz1/FyZvDsSEFnkMs59knLC6k2ZY+iuEBC4LO3svy6CeUpn0xGQ2+nb37GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589019; c=relaxed/simple;
	bh=Q9GiUDy8BaliIcSnqlP82dgrf+aLwJReAaNo25I7jkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KG43Iv1ov70t+O+tJsYCjaNkVW+i7c6yVRm8aueV29RmhYl83QdQJCytOOrGlzlJQ+muSzlVPH0KlpMDJOI+q7PonoyKAenWK4cktZugRq4TYwHepxAJ2DNE3Dixwm0v87mQ43C9MYSMbX+qknc1dPI6Ge4afGFWMzlGZa5ut9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3qT00lb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zxX065KR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1fmps001319;
	Thu, 14 Nov 2024 12:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Q9GiUDy8BaliIcSnql
	P82dgrf+aLwJReAaNo25I7jkE=; b=R3qT00lbyqoT0n5y4WfZUm1On9hGgwEGb8
	tcXUuikk6mStcDnrfE91IOCW0bCGaEfyeJuCIi2Wyio50QTtMzIZ4qA6lJJ5Ph+A
	8l8dbgwEnjcDQ5vPEjZO169VPbzMBA2nylNKXMf/Gsqn/b32hVtmO6yCOshuwhpO
	+624Kd+35OBKibbaYyE/lXLuCK5Rz2ui/1UqT0YyC48F/8kbRcX+YANQrukzEwSD
	ZnHNnnt79VmpIG5ydnNxI/EszyqwJb8mzhRL5ows/wS5K9MKIJgDkeTcLxmtUIq3
	lvi3EpLRc+6xFnRsMSK9GpPd/UljPOx3u12uRggWgpHaKNqS7tMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4jtb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:56:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECKieY022894;
	Thu, 14 Nov 2024 12:56:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw18vxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr8OKq+ELW//it8uTThbSVxl6l7saga9EUw1d2XdJiE1uevxdgMg+4yOGvBAa/HMB4b/PaXc+0KoCLEdTGQA8vD9S0q03NufWlq1NERj49YHXTNq8LM277o3gKVxpffYvd30VQGV2nbp9BoKBgFeEKgPKC2CquJwl/lBdmTH34RbudcvbdlYR6G1d6HE90bXE8TaF8xES9DReqY492cQ8wEvHGvatrgwqEE3ZRdatEteh9pB9XBzHJVSGI0Pr2lkU7N0Hq7BkErDK0dscMdldrgS8TdmjGuWtnx/zmjfTCOQ7z9a2HFgTev2RH40BlLD1flFkPa+JY8GjTUc9No6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9GiUDy8BaliIcSnqlP82dgrf+aLwJReAaNo25I7jkE=;
 b=oCy7BXyDyQooPhbimUMjhJFtEZc7EvvqaE+OAwGJmO9Wie4GCcF36gbz2C4vh2gl/v+n0Qq/CSqHHYkKt0w/frMeV+JA/+gC98vH/fybDVZ4G/61+SXpI//1FG+giLBtSl5Hj8UFLN+/9BXTmDqIKef9/SaWsh95HhqjKtZcF+GCNU+yWAiuCIs3a42kiYNPFcgSrLw/RW5BobuVpuhVBXjATcr8OZv9hONzCAZ0WJzSseFeu8q+nU88KG/CVnYyd8nuN2WEw2fxnaLHj98QJgY+0g4N7wRV62rttO/MsvQf6+pZQ4Yp/5PiogINNh8WBoVvOkqLJqI/ryXx7CW0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9GiUDy8BaliIcSnqlP82dgrf+aLwJReAaNo25I7jkE=;
 b=zxX065KRuTAog4dSi8UAYVoyL5R2mdr+C7pUf18GUJ0lwI6Vos6Q5qfzG+4L1BBUTa6CL8wJ6B66lrjHdzPGku3o0Qd1Sv/yBOZOORJEHaT592TMh5Y25Zd+SpI6rxAhr4618dELEPMDcXc3Ma5kvCaqHPRIhbOP4+OKrGDzKu0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB6351.namprd10.prod.outlook.com (2603:10b6:a03:479::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 12:56:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 12:56:24 +0000
Date: Thu, 14 Nov 2024 12:56:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: gregkh@linuxfoundation.org
Cc: James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, andreas@gaisler.com, broonie@kernel.org,
        catalin.marinas@arm.com, davem@davemloft.net, deller@gmx.de,
        jannh@google.com, peterx@redhat.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org, vbabka@suse.cz, will@kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: refactor map_deny_write_exec()"
 failed to apply to 5.10-stable tree
Message-ID: <c0f3bae5-fd26-4ac2-8057-afdab9817977@lucifer.local>
References: <2024111112-follicle-scapegoat-c6bf@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111112-follicle-scapegoat-c6bf@gregkh>
X-ClientProxiedBy: LO2P265CA0421.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d3ad2c-ec7f-4da6-608a-08dd04abbeeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?egf4B+xcBOXSNJuceeKJ2erKs/hFEAK5tLumgvbKvja87zR8E3khn3NKmDbl?=
 =?us-ascii?Q?jWfFnm0S5CQ8rkL9DU39nsBS6MyP+KNRR4RZxnMJhC50ue7seDfQ76toXAMn?=
 =?us-ascii?Q?tlYqb5gwRPpxtLTnzPllZDRxEn8fRKdKiH4Frmtd7s4bW49V441+veLx0Id0?=
 =?us-ascii?Q?dNehxaUOGYjpAkhs2nYoOB25CE2A+R415l+tid6zGRJ9NkXsZC6P5hwic7p1?=
 =?us-ascii?Q?7Ft1OujYVFVzI8eW7qtO0yjSuZiuUZkELe0id/DKCwRHF7OWwMo3XICkKRUj?=
 =?us-ascii?Q?/fDX0gC2UMYH8ygqkOgoIgKwZClHg8UbwGAIbZwfAyWoHgI04z/z7+b5IIq2?=
 =?us-ascii?Q?zFAEGaB2MLlHB+y6dwfr6vMT3UNbA1DfkJowHl+8bvV2UISn4poxaRaaWcgm?=
 =?us-ascii?Q?CbRxQou+riaikme+0q1PjjwD5teQiz/4hlk4taBoEfX6eQFPRCsewOYAuQoi?=
 =?us-ascii?Q?Ej9Wm9l+nA4QwD/7evzFjRTcZbiTl3nnulNv1d7Bn5lTigv14/4bH83iJBGS?=
 =?us-ascii?Q?kXWUU3LxzVtHuc0b5MEwMG+nnSjBIdt+e9ISGQB3zuXStoH0ARJ/51dV6pZy?=
 =?us-ascii?Q?paF2/BU5NlpKwx4yJ33402+X6QVMvO8ZW7Zk9OW8HV35O9aupCGRdyiflYAF?=
 =?us-ascii?Q?rMMMgoBDgFc1arj9RR3ToN7O29mbnlrTxkneFjJHB3KJjHJeEpwlHzwPyilU?=
 =?us-ascii?Q?NR6nf73wIpGxKsIAmM7GPBOe9PVu9RFq8uGHmtAU8XW81OUN2chOUzraEOO2?=
 =?us-ascii?Q?iG1vEeVmx/qml68VjESdIYER9+wgqf1fBQFpNgBcvrWZdorbPaEv+6fg86Nt?=
 =?us-ascii?Q?nIRozle9KoEwtiyG6kQ87QVF5cXFT2CivPG6ZLS6V+G4GI0wVwzTgqhfHqAP?=
 =?us-ascii?Q?5M1lPH7GWd0/ezQD6QSulHSbcbIsNrcCPivEZouhY2k8FsKd/g1sE2tYqG/T?=
 =?us-ascii?Q?u9dsXOu0M/MVtAEYbDjBXIV0NgLbcnD+t6vPFBpUizuIAc3zNYTyLPesbDcb?=
 =?us-ascii?Q?cSK+EOVK1LBm7FIpDx6m3VGxiSHKHnkk+WNx3CadRB6v1dy59ogxaT5tpcJT?=
 =?us-ascii?Q?IYtPK9DEj8+ePxRXURxrUvNFppfhVs8VMs1CPuA7dNvckfNTuCwaGVwVSbRE?=
 =?us-ascii?Q?uLu02A98Q4uTL9/IPU+pBim+n8gjibe8fXFydFFFITDELjSjisZZJEFO0T8g?=
 =?us-ascii?Q?yRG9LddsQ2t1mHwJ0sJ6tBThYGk4QrCSX9aVQukh6gzlxSLSy65kAwu1coQ3?=
 =?us-ascii?Q?vJudAHviAv0JA02KfPE/9RzMxnyJL5IPmpo2bSDHKVMI6zkcH0Zn4EEIavVP?=
 =?us-ascii?Q?1yuISerWAwkLF+Sfwvu89JOp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BQxO89XkFz2a+AssxbTF2KlCmeLP7Ca01lKd3Y2ooIzBImq9RZXwEcCdvq9?=
 =?us-ascii?Q?a0hv8i9RvmjwgHpDDBqXK0Eo7RPYP3r69FgnJ3htpfYvpe6o2hpbN/8J3ZbL?=
 =?us-ascii?Q?Ez8h/e5J+zZiEU9gqE9zDN5owjwZyHYmrzlgOeai5qVKdCHDitcN0fTho2cS?=
 =?us-ascii?Q?pkBYrbtHFj+NUDpMdpfK3jdZjrwu4gF+d3EGjfYyDOyG3Q8vALOU9R7XCcPX?=
 =?us-ascii?Q?u48JSX/8+k0XqRXfbMwjrJmmOQkoHmeQ6/3145+SlDlB20ScI6JKsdXLuZ6t?=
 =?us-ascii?Q?yjkti1p+/dPrIYYbmf4M5nVDrhiyQtUI6j0JX7Altng+ApRtp4Rjm1NLYKaH?=
 =?us-ascii?Q?DD5JuwreAv+Asr22YqSNzVXnu1Ummrbq8YQ/FU/x/MrTpSutQF2v8oMfuIkz?=
 =?us-ascii?Q?NedGZwfcqgh6Dbdn2OCNVFxIW2FxIohPvoRzaAH5Cl+wrHfZZ8AwWs3dNc9U?=
 =?us-ascii?Q?Vuuho8sVXBr+IxVwz3ZScfhy77tGYuUDRFI0jd237sowvykVaElqSc2b17SA?=
 =?us-ascii?Q?rPI1wEVxHW/NR69mQqBIgTXaHfddA71US2Lv8rT9nlOmwRdsErPMnDSXJEBr?=
 =?us-ascii?Q?kvYRPymPW/4Mz92GTIh4RYboi5iAdq4UmyawGaCqvCCZTptUlpzYRLxeCodC?=
 =?us-ascii?Q?syAGL5yQOJMAW/mRmnhyLlgMf0NKIsJHFdHOttg7O9R2Wu4o4+sfkbOGPpq/?=
 =?us-ascii?Q?TrapYMsr9UdaE3DAKmP0t7eBlCnBqgnEeHxTs20+GJe35gJUY6OPxspzZlZ/?=
 =?us-ascii?Q?5gAY1g195LsYe7dsh7wc0GMC51fu42H6fl3jwJb1QxFpqasx/gXvORICKAAd?=
 =?us-ascii?Q?ISqR/DOsmKjfqggj1/NdKcgIrAQ0+ZoDbtwvJp2chrC+UKFCEzdA+PDmr7sC?=
 =?us-ascii?Q?djYuMlN9EJZtzmE/mgXKUciFNadH+tqDuvNh6ETxH/B8lzeeO+K3SKCjxI3c?=
 =?us-ascii?Q?2xHIRaMxulRznP/jpdihYBPItkSEmZZXv+Er0TjvbqQ7hyfhpqSmlOCHGQYs?=
 =?us-ascii?Q?xt7Noin8gpOaL1ISww1JsGy3agXSL5j2dUpiLgYq8jQk0zXL6e1B/cqZOA3j?=
 =?us-ascii?Q?oXLCLLfNh5INdwSdrQCsyShDYc1c18f5NKU7TjduMRVcEw98tA60CnghmQgh?=
 =?us-ascii?Q?u0FWev0sCye1QBSQzDjyJVFnG76Ec6V/3h5uG+7e5ytE6P/i9GhYD0uqJZNY?=
 =?us-ascii?Q?ESpTMfnRYAl5FGu8iC9hkaAvt/Cywi7fZpPROIw6CcTKAENYHweblpeYF9ZO?=
 =?us-ascii?Q?ViRXDmDtKUQh6bhHiYgKXEFoVX4xCXneaQWn8lmnjOzAT1WPRPb+7GG8r/J0?=
 =?us-ascii?Q?DjJfd3Eb050z/vHi2rvccLI9D6G9v5ROuX+VXRhumvEm5vdMqeFGxzEZeFiN?=
 =?us-ascii?Q?5MwznxHtgp+urJlJqqVDaiuG4QhfwUo4u1PMA7V8V6gsAHB+YUxR2imayXuw?=
 =?us-ascii?Q?KJFrUGICVCuZGWBeMNJAi9p9GSUprJ7FwOgyKpns7W/LNLB+GNzs0NGfk50/?=
 =?us-ascii?Q?dxAd75yxZR/q1n5VtKVuxmx1WiVtTrxCJTaRVMmHEGARqeXp8kgza1uAYVgR?=
 =?us-ascii?Q?/9PcaYEnKN+zwzD9L0xdEqzeL4sHFka76l2/1PEVu1fhpqNhEJPxTLgnZV7P?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AVqfYtJMN7x5H6u3d5UiBxRdMVXphhP/+8pROmzodaQdr/iTixqqGpiJMT6reCCt7wwbh6kKJwr5ZwyrqcJ8IiBXzOBA6c5s7ecn9jAC4o6olvHcVa5RWqnhhwOz5KEV1PVHM+MnQLBN1UHnrmZj97WYQeSbo+SfQtgGyemTiRK1K1cAwX4Fbc3L4dWEXJ3bPCASITwpBEqe0xotRQ1gTjy4SHn/MReL97W/JD7evJJbPobKXAumj9+AlUX5shXqQ7Pa0TvoJRlKaglVEIp2jCClnqKQ1cLw56nBJqkG4nUemC7SgTfagmG1o3+NbgeCPWpCdPrwYJ5QeUoWfifHdXqy1YtBWePNLUBQ6r3fI2pBQ++jqjgrPjpqZfObFaSbtvRDcUadZLBEeQZmlpOBOYpbbxsmB2AVT7la3t0wuHcIWNnVWi3AJjz+5ELL8QRX2FcUOCgiCp5k0JBT95ctsrxStT00CAWy2d76ekndVZrfC7UoCsB3bYy4pCjy1mdALhTJ3BIFhpu6u7l0urFPHXRCq5Qwprh8ec24VGa18vfEvBuOsONr3Qhl2hfLrKzI28MJK/U46p2RO7jBIFsZ110nDsvVUNu+LTMjlS1Vn50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d3ad2c-ec7f-4da6-608a-08dd04abbeeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 12:56:24.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODlkcJrSe0LqO1HiynBb/moAG9vgbvdz39vAAW8qOipwjm8geAK012tW03HimXjHdz0715E7wOhMDYSx44YOs9N+c2AC/cKI8zhA+awo80M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_04,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140101
X-Proofpoint-ORIG-GUID: 2CNbLe3godQhAKEj4bD2Cv5yB6fftG0e
X-Proofpoint-GUID: 2CNbLe3godQhAKEj4bD2Cv5yB6fftG0e

On Mon, Nov 11, 2024 at 12:38:13PM +0100, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111112-follicle-scapegoat-c6bf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
>

This patch relies upon commit b507808ebce2 ("mm: implement
memory-deny-write-execute as a prctl"), which was present only in kernels >=6.2
so there is no need to backport this patch for stable kernels prior to 6.6.

I am working on fixing up the remaining patches.

