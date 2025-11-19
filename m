Return-Path: <stable+bounces-195193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1208C700E2
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEAE2346920
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FF2F6929;
	Wed, 19 Nov 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqnIHf9b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O6OOCC0v"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC436E56B
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568567; cv=fail; b=upBPDROd4y+x7Bt+a5HZxYpQOylfgVti/nvcFEqTmF/cNChoCBn7TBdnTmH6BzNQS9VW4RcjqIDflYIRuv7ti1zBsTJu5xYgld05Jokg8/WoQnK81lXMKvacGxQA0W9Ym3CFTO0uAHgBsuao51hUDheKRI5FMF9ZHBEl50txrYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568567; c=relaxed/simple;
	bh=yzbxlypb9LrLxknbYl8qCwn4dgsz9rzNZw3YbUtHtE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UJEW2LC8p3SBKWwL2zJYGdvx6H9caYBY9NRUC6uzdVi1jymItPu3YyFFMpy7opjR6cUBJv8Nt5806THYHktXOGrMHunmh5wcd9kyA/GIV4A+dpM0siHdyV0S25V6MvFHM8JeAw7pWmB9hZNJaX5Z+5DwLvt9RQh62sK18shORCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lqnIHf9b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O6OOCC0v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEgBB4002653;
	Wed, 19 Nov 2025 16:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yzbxlypb9LrLxknbYl
	8qCwn4dgsz9rzNZw3YbUtHtE8=; b=lqnIHf9bBZ54IkKpYqBgTE0eOPvZMfxV7Z
	2Votn6AXJmbykYvFhI39pDuiU3LeC1e7/aP6dlO5CvejBqj8yZvkTMru0f7vIrme
	fvnqKbqQymCAJlEWv3LON/rGe+s3oNvaUYwdSdFzBuWaCzRCMALBRY10R8i2h7zJ
	V4EvjhqhC7X660qc8aRJUH/lmPXTkQVahkeNqtaB3cJBhDrL1o6+POdmi3gQKIPJ
	oo7QW+XHFoaKT0LnzZoyWid/ZIQ1PSzcu4E0JMTi4Hd10xL6I+rPWJnYYuRmUbLG
	mNZKT5VBcQGk971k0hIJ4femFPrC88fpUxzN7KUGQNYs1JoO6QLg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuq7pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:08:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJFRbvf002564;
	Wed, 19 Nov 2025 16:08:50 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyat0at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1LxoOZMutNaBrJsXMIF9yC5cTmK8c5VfOCCIu4TScS9ob427SrJNqQh7UdPAvtS5U4EozY96vUcf2ntS4QRqQehfyDIZhPfW8zzbT/eIjSjCW9O2tQ3ybVdA1NYnatUTWPwYaQY++FUf0swA4B881NMc7bEGx1RuBnuaCGmRtNYFlffUhQl9tuTL9dlGeZJn3dYHn9xXWZbqhtvO1L8B0sDGCcG3x8UuPGYfQZWH5UrhctG9jZVEvDbmrI6TfFuJLa5i+gsF9vmqFwnxX+E+q2RjlO7blNyUI6bmJ6xPI9axOqKhQEaTZGVPQXxk787HEoHO9gbqzPHzgf2hZE7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzbxlypb9LrLxknbYl8qCwn4dgsz9rzNZw3YbUtHtE8=;
 b=jjd6zGIstXEGFLgme8oASqGJy5q05mWeR5u/iD5TNlHE2w1DEdC9GzsiTrutikSoM/MWKOgO44NcZpzTVk5F3JjyRDBwnwSqdkdj/Te1fH8CHsUFu9tUOwuurq+l/0Jl4GAMc5BjGWNpPM+TYa/n/MxmfxWHvWOXIdE9RA8CINb+1HHKafqTEsc3Oq4RMN4RatjVEduqSAoGz3HvtiggocZBNeJuFFf0XtMqY/5wZhfmyVXO9mzJgRZhXrWVcNTPvNJjaLrlI/C+lyq0ZifPFRPJbU+4BRUt0poL4XixSpgLQwgdbclQPnGtBgBNHgMVfJxhBYKf3eF8HfrsbSXeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzbxlypb9LrLxknbYl8qCwn4dgsz9rzNZw3YbUtHtE8=;
 b=O6OOCC0vQg6J3K7pE8z+z7ton6dF6giM0uHB0GG6OfEDze76ljz0nfL55QAEMVZBJGKwdacZSlbKYpBHeihbKbb2lR1xptnBsTqWzJKaruOWDTmpbVjFvJrYmHyao3R9iIMxuGqF0MBMkPVT5RREVad53g8VZC/ezbC0EVfnwqg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:08:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:08:47 +0000
Date: Wed, 19 Nov 2025 16:08:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Message-ID: <1d53ef79-c88c-4c5b-af82-1eb22306993b@lucifer.local>
References: <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
 <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
 <944a09b0-77a6-40c9-8bea-d6b86a438d8a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944a09b0-77a6-40c9-8bea-d6b86a438d8a@kernel.org>
X-ClientProxiedBy: LO4P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c0a008-3388-4674-88cb-08de2785ec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6pzlSxm/FYGVI3sVD+VaX13QQtk4kRHMZuFIkdgBMBjXdNBHmU3A6FZreN8?=
 =?us-ascii?Q?6MFTpi3dXo3ZDNFPN2CV6Qs5BPxPgxMv6CzU8pkmE7xcPQ8yQd6cUOEGvHyF?=
 =?us-ascii?Q?A7gJ0elRPZfHTpthCEtJGtvGQnWn/q5beeCZUJqZ/+VITxyyOq7sOER5qjoZ?=
 =?us-ascii?Q?qybCf8TIOcTTj6WNR66RzTUvXy6d4n/ITnqed3SPVFGd+K9mg3HzFQdXyZL7?=
 =?us-ascii?Q?7QGdLBpvw5DrEncu2qu2yYET0uO9dFnRfSZxfJpYvg/FIuP/PtkYj3inxdPN?=
 =?us-ascii?Q?bLS6savEt20a/2SzVrEZn/oYga4rYxscJE3jSXZz1k/r/grdAtEfoA68JB6J?=
 =?us-ascii?Q?MLn2rw5+2dt3jzbroxLcQnVZeJwmLeBmLBboAF2BiOkazvFzlNRlsomDr0Yn?=
 =?us-ascii?Q?yISZ/ZXVb3vEciGTznAZKFELokd1uFORx6gMPOApIuZ7TTsLw7e9TOsLE+fb?=
 =?us-ascii?Q?xyNkbgxvW+T50TaGFL2bjYY9qRCfk1w+VLUOrapGEXICKS7uSfwksErin1ff?=
 =?us-ascii?Q?tVKBuyc9imMpBfmFiHqnkz6cYL6miii2a50mCnyHmtTy+pAfrAEExr7owzro?=
 =?us-ascii?Q?j/uVunD8D7K4GpPRYFARmiCnbEB964EKt87kajkTpix2veIoL1Nyt25bGGDw?=
 =?us-ascii?Q?e2HUSkG3jEw3q8Gih8SdvssZpvkRy6jpKeWoVvun+Zf5YxoaVbmYXthHvybo?=
 =?us-ascii?Q?05CRmO9SZQPovHSve3oUtX3vMNF7le86+ZOltMVGuPu7rCQwQvQ7AZY7joKl?=
 =?us-ascii?Q?MkHnjsf6SQHtmaE9ALIOIrGErxs+orirjcLRnWGL0PSdAnCZFUMQCJKdVre+?=
 =?us-ascii?Q?VMnVPLHu40AF4OAINBW2kZ5sQFnYn3whBjMnD3aNUWaWDCkeLSj+fnpK5QIj?=
 =?us-ascii?Q?oxDbuakHzeQM4yoldsXSJSZ+sxcfq1nWzyX6QHseD6eVwI6Nrx2Pwtkw8Ng2?=
 =?us-ascii?Q?xKF5FnIq3mev/sQj30X624s34fLx+B/RLJQvo3/+VVfPtsnepsI/MGmuN16R?=
 =?us-ascii?Q?D6GWsGMRm8Qsl/S+VS/w529NF6+hDQDM2Ct+v1nJsJgY6ZMJlh4OexYbGsq3?=
 =?us-ascii?Q?YTQ/X8cUE4MROgAqtdlB3hOBR6oTWFGKomemxYoiTzhtIroj036cVFTrQyPe?=
 =?us-ascii?Q?pna2intJwe73bVy06SitvirtySNgkklunwzo04V/IlVoWmr/wbiQ5EApD9Cx?=
 =?us-ascii?Q?oO1d9fYRVA/O1hJANQdh09WV4wmbWvTWM5ccUJa2SORRNdeCPGJ2926TRQFK?=
 =?us-ascii?Q?00OPpv6PgUEWBb9FLp0WCt7pKWBpDd59uwIrpk4pcfIWis1cjPkeGdQDIRL4?=
 =?us-ascii?Q?SVy7p1ko4cHu7kBigumSbla8eMkv6dTcudp0fWWNTb96gksAoamBtr6IralQ?=
 =?us-ascii?Q?Q730c6yAJZB89n6DfAyo+wh94NXLeCe/6Azd5RxhWMMLYtCE/5v2/1KfutGe?=
 =?us-ascii?Q?RG6Xef16xeWAO010kxCHHuZVr5qsPBAz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c5eXZXJmGesdmMh8BddqYJMKJHIaoZ9JBjABOZqUyJ8t/EAhgP3QuAC621gd?=
 =?us-ascii?Q?YT4en7ihWYR5FNepjUxQGzmF8EYqEdtKkbLUpj94+DilwEagwqSxm6rdyfaN?=
 =?us-ascii?Q?XOvVma8jvHVD90BRgcakAZ5N8FrYjJgz12P1hDnrQA0W9jI22QX6QycZratm?=
 =?us-ascii?Q?/gyDSC8ebzGUHpYx0YlhMsHdmC9H/FmXpPaTWvpC/lZavjFhB4SCuxiq+6T/?=
 =?us-ascii?Q?GXZlwggGz49yndMzfdC/3qMBmwsl1Xg2Qj7OA3It7IsE5L9h3rb2CBV0ZPE2?=
 =?us-ascii?Q?lFFOgrYQhxysRUwRlEAIUk2ApcPtU+cItTK1NFdF8xFFWcrydEVVYNKNI8Cx?=
 =?us-ascii?Q?KAR/K6efXSnKuIJBH2PxVo1u5PNk9LSq2mKELZrGHJhbqKpCM5SWJTce+qpw?=
 =?us-ascii?Q?2eT68ygpuBzQEcwbVTh/NfykJQWwLtCBhqz5mWH6R+O503CXKP8GJ1n63MGd?=
 =?us-ascii?Q?G0befcDSBaUAK3ziTfx76OA8YiqM8xiuexxZlW7PevBLrNEFPUVu54d0xRG5?=
 =?us-ascii?Q?EN154HehlC+WRSp24rfanoJspiDkAGcA5QiMeDGL8vf9cOWYpbANbwiWDzrg?=
 =?us-ascii?Q?iFbvo7pj9xvzVnQTskqpFq4bKR1x4xI8rQ2++ZAFbsdWeD1ud72CM/C2l74s?=
 =?us-ascii?Q?odQ/xrerhf5MWHoCggJF33GvMOT1+6EyehcjGVyG5EM01e7ZWo+ZTCWXjNaO?=
 =?us-ascii?Q?80N1m0lpHl7wo53iArECFVH626Nq0m2Y+qTGB2q+WOlCgpr9SWx8MRep2qf6?=
 =?us-ascii?Q?gQ3hTm5lcxityMeAa3S/wznRN7BY7WLiJ7dd9X+FNHUOpumPzC6QkmhfGiZl?=
 =?us-ascii?Q?+McY/+EUkyOumYrAhEbdvGDKxEHcdJNMOXzTh1XyQpvmNwiW2P2kXkLsHrLl?=
 =?us-ascii?Q?q6jiCNw/lNGC6Ga6t4Sd2oS3Css2rAFmeGcFXUe9jQEbhgZinAI3d3RmK5Wv?=
 =?us-ascii?Q?2OUyhUmaLp3OWCYe6G/BV+oA3WRpCp/SSxDZAYz6oqTdHneLrAMZIc6SlKFa?=
 =?us-ascii?Q?7DQbHM/rbbV2gQ57rwiyg9NbwhkSwlj9EwKXQQ59ouiyE5nUPY91Z2BEdA3l?=
 =?us-ascii?Q?YurcVwEZYvj7BaT9ba6HNh2frz+8BwsH/JhhKOBjYG6UjaIUK3Mtl7XDD0zN?=
 =?us-ascii?Q?GCYufgWL/9qh9D6Cl/muc+miymg8lTlMMxtOdtXC4wwIFmQXW9lpkrKK9I0x?=
 =?us-ascii?Q?9pdPXsFpPotKvUFGjOgapFYdDiatECzR/b9eC/lZi74hmO9ExEqp64fuarJ6?=
 =?us-ascii?Q?lgkES7VURpmivVNhj38EZ9aVtzF5HoSdABT0JvyCajeH1f5TKUualSm/vyVM?=
 =?us-ascii?Q?uev8jCtjACuHclNXAY1TJ6Bu9RVaQmERucbYfrod77GKJ+s9/wrvIH5jRVdg?=
 =?us-ascii?Q?CAXPSuFaSFxm+crJn5QaZmnyMVehdcf/fJMLMhxEuFKOSf9ociG6V2bJ1hKn?=
 =?us-ascii?Q?IFQA3yo6MUjwHzfvEuaGEgUabzVCys7c1TKB/gTMizvDm6WBbixJxeza7GjV?=
 =?us-ascii?Q?LOtKDkvOu1Zd4bz9vLVys9QCspiCOrhcwsIiNNLaeq2LkLta2qr9UNZNtie5?=
 =?us-ascii?Q?rz7in5n6u84PGBlV36CtW58beeN/5vuDR3wLzszr0hDE2o8VqxOLqPSuBf9a?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RH9UiCAlbLxMz+QBbk+h7GmB3LqnOShI4My4WEMRCD+2dfteNk+Rs8EfPZTtIWpS72n5z0TlgkJLaG9/lmN0js3lEfOlzoHR7ePIGxT7GagxY3sySPx1ZFglGp1Bes8Z0ngOvQA4l/j62Nw/lNgOArYHYHmPYhB6ZekGGJ/PrF1CsLz+DVIqPC7q42peBrnl8ZCEo9JQ5NgJHssMhMGEg1oT7BL5UeS03+m1Kar01VsIOOudqZntbRdxpGd1uV/76nOL/mR2GDa+rX7NQfCV8g0mHTU1/9N9YEGdDac5kDK7W/Rceg9+cw7g5I7VebJIzOFC9tl45tvLh8sbncxgLw2dOhaihRjcZB6BENa3+Uit9kDnUuQABUFa4IX+rJSIVgyRjwu+WyTb5bV5rliXbmGkL/e9Nh5kL0dBAy1dgpIqCXaP8OrlbCRUbolImoutF02OmmlIu9NqIpne/fg22tcExwwgSGftlO3ZHwg9CH0jvvsieCl9Mj8FVOPBELAc8m2nDqx+K5wjNkayHycKbttUrbBpg+N3F9aJSXR9yjl8fjXrCzIlWvbT6CTYuL8phlAMDldOzou2RWKet2JGnutqdDVDdezodsXk2VO87So=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c0a008-3388-4674-88cb-08de2785ec0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:08:47.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqYN5WfyprUbhVCFSGscsHlBWsctJNl1DTdxYiyGD8g/ngH7zvjYTYmNjkpfWsq9mQfhdH1oUnuUavTVDxlk3Q3IJRjz32xvfi0naOaw6vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=778
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7agAM4hHJvfY
 N1o6a94SFSxBVnYyN+OgsyBHmHJHvDYzz6IqS7n787gNcQGJUkDOoRYiWgszd8N6jw1mLtezJiv
 2NLopZa6vNogGMoZPsnTHVenutuOwB5wXpDiqG6/t4XtrJjqqzniF8IQn0hfHDV9UkZk/KxHCVx
 YdNlXiSLGiuVbBoJUvUfPu6U7dOxhvrK6ZxgT66bmwJ89ysGPBc5eyB/iMcuqEZuMAXMR6ExHG1
 kOGuYnnZ2mkXOX5Wvm6KcjE8MUwQBogLcSsYSfWbSG+duRhwP9GlSwsvmBwot9ThvqTwaUjMvg+
 e1rG/VZ+DPw9s0tpgU0l7/Br5W3HIkgdXRCaq1lsyurpyAyIAW2AvUpy8U2StC2fOV5MlAdOf8C
 xO+eO61AMnSuyQS9BKGF2bmB9mH0wA==
X-Proofpoint-GUID: 2VS_1UtXP14dTGdqb0XERNsaHBdOiJB_
X-Proofpoint-ORIG-GUID: 2VS_1UtXP14dTGdqb0XERNsaHBdOiJB_
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691deb93 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=erSa-gMV-_eM4Qz0hUMA:9 a=CjuIK1q_8ugA:10

On Tue, Nov 18, 2025 at 11:03:07AM +0100, David Hildenbrand (Red Hat) wrote:
> On 29.10.25 19:02, Lorenzo Stoakes wrote:
> > On Wed, Oct 29, 2025 at 05:19:54PM +0100, David Hildenbrand wrote:
> > > > > > > Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?
> > > > > >
> > > > > > Because nothing else on that path is guaranteed to send any IPIs
> > > > > > before the page table becomes reusable in another process.
> > > > >
> > > > > I feel that David's suggestion of just disallowing the use of shared page
> > > > > tables like this (I mean really does it actually come up that much?) is the
> > > > > right one then.
> > > >
> > > > Yeah, I also like that suggestion.
> > >
> > > I started hacking on this (only found a bit of time this week), and in
> > > essence, we'll be using the mmu_gather when unsharing to collect the pages
> > > and handle the TLB flushing etc.
> > >
> > > (TLB flushing in that hugetlb area is a mess)
> > >
> > > It almost looks like a cleanup.
> > >
> > > Having that said, it will take a bit longer to finish it and, of course, I
> > > first have to test it then to see if it even works.
> > >
> > > But it looks doable. :)
> >
> > Ohhhh nice :)
> >
> > I look forward to it!
>
> As shared offline already, it looked simple, but there is one nasty corner
> case: if we never reuse a shared page table, who will take care of unmapping
> all pages?

Right. That is nasty... :)

>
> I played with various ideas, but it just ended up looking more complicated
> and possibly even slower.

Yeah...

>
> So what I am currently looking into is simply reducing (batching) the number
> of IPIs.

As in the IPIs we are now generating in tlb_remove_table_sync_one()?

Or something else?

As this bug is only an issue when we don't use IPIs for pgtable freeing right
(e.g. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set), as otherwise
tlb_remove_table_sync_one() is a no-op?

>
> In essence, we only have to send one IPI when unsharing multiple page
> tables, and we only have to send one when we are the last one sharing the
> page table (before it can get reused).

Right, hopefully that significantly cuts down on the amount genrated.

>
> While at it, I'm looking into making also the TLB flushing easier to
> understand here.

Good idea ;)

>
> I'm hacking on a prototype and should likely have something to test this
> week.

Thanks!

>
> [I guess what I am doing now is aligned with Jann's initial ideas to
> optimize this ]
>
> --
> Cheers
>
> David

Cheers, Lorenzo

