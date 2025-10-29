Return-Path: <stable+bounces-191668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB6C1CAE5
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B27C4E171A
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7A33B95C;
	Wed, 29 Oct 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5WGNgA4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="csC998FL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0473546FE
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761073; cv=fail; b=IXHfauAPbssLxL0bf9jO5g/8JivjGtHUAfOpY8rmgSqnyA6XysBB7l9FD/RGS7QjqJ5lKVct/lmzeamfC/QkhRyvjITzKgP1PPCKHcPk4ykbf1a5SlA9d0Klb5wZrnda1uA68cA8micW6Jlrr1GVrOUb78oquqM4BefYzPgzX40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761073; c=relaxed/simple;
	bh=T3o0f43ZFlj3ybzNiPNBxEzF3r1vIkzxRQRWlcoU5Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kB9EfK8tpEwb1+Fa2CAOoM+NGyk4nwzz5+tjj8EizG24fVCeYKTWGsbJS2K+wkl3MUktiKxHLaqDrB6UvV7WRceQPYokS2YyFBPYZMwvOvnfBpAQmhdQmdjJ6tqT4MIT03J1yKK8b1Z3IfLbE/j1isGojYQGZKVwN5LPT5l7y5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5WGNgA4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=csC998FL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGgJB2012713;
	Wed, 29 Oct 2025 18:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=T3o0f43ZFlj3ybzNiP
	NBxEzF3r1vIkzxRQRWlcoU5Zk=; b=Y5WGNgA4Hm2Mnx0hofKBzv3JS0qNP0WTTR
	Tf9SniP/vAbjoFYTqR2lAM2UTnk4E5/eagz91YJoyIvi5Um2VKrT6Eadpl6SZcQG
	J/7hHIprza5kjlFqdBd8p0zZuuhTF0xb3EIAJ4uGrXcN6GyJfyiEdJT5Xf5EVP90
	urRllmp6pWh0h1aolpCAhBuQKEm4kZoc7Hx9YXxZbf4MhsD1XxL5nmOQ3PL9nrts
	UFQuQRxWy0mEXsFKucXmbLofSM3DaNIeZhYU6C7YKiGsY6Y8Zu5ofGdcewmyuOrT
	uLtzAESEaplgzEexgo/pnkQKrglJ1SEEdCTY56nQ7+AuGDMyDbdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3b4w1w8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 18:02:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59THhfFU021173;
	Wed, 29 Oct 2025 18:02:57 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359u7hpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 18:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gE87jXOjRddQiKyuNTjDg0QR6ZcLuV06XOa5n176L4+F/E8kfaB/VrBMYbhYeEMOiH7bkQZadFefTB7q5deqzpLUkyYoxIXhLizqyWef/fabtcG/7fwHdDjmGX4kwnP59Ia6Mi4bC4vxDBbd5zQ6jfbuL17BZlTanVFHUM6UKt7LhB6pzkv6D1NEVqElJd6EJR13SD+xv+Tl6oJ24a3GKoGXsj7yVStvHCKJbs2Ydnz1re+KxP7YZj3Ip0Kp/jaHjdV+bsc5QlwwHP7SyNcw+Raaxdr3AB6DAf33JqSLRqpVneXwKps0ejMBCaGN/cKP0ug5DZbY+shETt4C3gfUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3o0f43ZFlj3ybzNiPNBxEzF3r1vIkzxRQRWlcoU5Zk=;
 b=iJlTFS6XVhypTWwnzAwrHk+bgjM+xKK38VIsJk1HY+aNAA9dUEkhbyr9gjhMFT5O0CKLzjRGQVrYkutj5XGOpwRK6MQZ9SEm+t2hvTAXhXGBJKkXysZejOshgZqhax35WON2vw+/kYLkk10KM8uUK6yl+jffF/Dx2V1ESi3ZNoHLZsZykP6l/BNdNvwd0S7zv4dP98XV31vVkaX80wIfmMcEoiyJDCM3nCuUg+qewPjk2N6cWgQtPb/8AbYA64rBqxwZ1M+dOBYwH3Tq0BsmaHg3vdhmUKn+0m54Qgx/TdRKBMvGWIRnFXcmvwEqPX/qR6YZ7LA117WAy/RrXsEv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3o0f43ZFlj3ybzNiPNBxEzF3r1vIkzxRQRWlcoU5Zk=;
 b=csC998FLwkGqALp91B/i1pqjD/75jTH/ZIRrwZJsFkLXF+ph/tcDBDCA6SvB8jP0ifbRySjzO5k60VypCXDDkhWcnOpE9JrgJBlGUuTVB5VTcpY+7Fe1qd6vTHNq/rG5eeHnXpGOz4U405QPNpdaZQa9ci3DWwWqGgGwmtHia78=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 18:02:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 18:02:52 +0000
Date: Wed, 29 Oct 2025 18:02:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
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
Message-ID: <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
References: <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
X-ClientProxiedBy: LO4P123CA0301.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e185476-6ef4-4fde-018c-08de1715610f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I12/u/3dPkX86GidmAsQLMm2EgCC1dIl8mW+bCMJX0EmNM2iNcmhcyYHwMMq?=
 =?us-ascii?Q?2b+gOpicTT9JS/JkThIidJLHRTIz4AI7sFFRgYt9l4MnD8hqri9uf11nSgI3?=
 =?us-ascii?Q?SYFODsO4lT3oiHBrUccb4K3DMdXREUTB8BHMD77XBPFiYT0iCDkXCDpoJU9Z?=
 =?us-ascii?Q?4vUqFAdLdZZDUjZcR3T/HmYQ3u7zh4Rw96QzG6UCULxr1Tajw1+nAfFUK3dh?=
 =?us-ascii?Q?MKuU7KKTOs0W2OEDBycN161X/sVklbYGap+t5v5wAfx8VQzLejF2cmOWlpiG?=
 =?us-ascii?Q?1akMpOUt9hjxfMz4qjd4lTyBChJg2fkE/VTQ6g4PbJxUjlm5JB1j8VfHgDSi?=
 =?us-ascii?Q?jEOcEsirBxPKK5SEonD7FxLsgugbrD5FzYw8TtGKAQEs8VuccUmbyDtdidRx?=
 =?us-ascii?Q?V8VBhAWptUlcMrjs9TRkorELWuQrxjBap8GppJR9T1Kbrc0Hoii3vAFvDoXs?=
 =?us-ascii?Q?jaoTRKDk+SkCpyqg9ndg8zyG01onrj0zTbGSHp/IPWeRtAFeU4fY/3OUUfm8?=
 =?us-ascii?Q?8UfPBcKxbvDBM9NnG4OwCdH1dOEojIJ6PZ7dxv4UPq0WxKLLwKgWXyOMLW/L?=
 =?us-ascii?Q?8IKcGViXkm2Zy0oo2cBSOs+ir0J7K8IlodRntnC2oHzWb52nXQBCq3+B5KdL?=
 =?us-ascii?Q?u9QH8FvF8//0zwc1ix81V4wK/+/5wKH6C359r5rMQUSzU+zykxOFZdOXNVba?=
 =?us-ascii?Q?s8ySVL4VIoGsPn+Kp2SWONzI9/3/NA0RnXNmDE/xdEqL2eGUhXwo0eJ18fcJ?=
 =?us-ascii?Q?Pfufz7o6mwVZw9urL5yBEiatyaM3xbtB35c7YNQX1vJjX9PpCyUgdCiltVb2?=
 =?us-ascii?Q?nlyi5CMOvBAM2Wmp4czxPmFLtkb7RWD2gF7MIwePpp+PmYC1zG4VuSOYAiBw?=
 =?us-ascii?Q?6lcC0MRQSiGR6V5zpCKjtvZ4DLSLDtH+rJnAbaMWsn/J2fVKVS5Py27ktkbO?=
 =?us-ascii?Q?QvSa3PY5nATdyXtWr3tO2n7NWUE+ukXqR3AeEcdwsy8BdLB+uAHyWHEaa7su?=
 =?us-ascii?Q?4vbe17JTPVUkFwcDptiNUyD6PkPkJ1le2SHWPiFYjSNH09jqXE3zTxgms2we?=
 =?us-ascii?Q?67TtZsssLYhKRVFXu2T9+AJ1l11KeoKcY/0+GfUJ01GGHe86iKK9Beik8VmV?=
 =?us-ascii?Q?yNh0pOQ5DK2RnjGPPbM4q+pLa7lmM6fVTImG4WWGEMkArS3e/QQiXvXKL0LQ?=
 =?us-ascii?Q?Jg7YXIqezY0U8G31Zk3mtWQHH7gPIgCIJ5v7OOUWgA8e++6rUm55k1IHOCee?=
 =?us-ascii?Q?u/poEJhdiBwRGdSZtXboWaxZt1QgXh9q/hY1R+FULD4g62pui5OAQNr2PRtR?=
 =?us-ascii?Q?18M9Pu3tcLeFtoq+XsvuTH+BzO49rUo3MgRuxxzFy2+aW9pzMaz+5WYw9gIl?=
 =?us-ascii?Q?RdJCGz+9TUURL/r2PIJbfhfnohykKKJF/jl/57THHOxeN4DNBFNn1ynI61j+?=
 =?us-ascii?Q?3rFv0cerF4bZTA2+fXsisxXwaIGfY/in?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gmL8sSapQJ15brXP84gN02qTIfmV9vny6sFElBtH+dS+d4wdH/FrtRXVpbg?=
 =?us-ascii?Q?kkyY5i4jYpz5fiKsdhObkZ9xXHrLi/qbdUVJR278JTN+61Ec+jYLEtOc+exz?=
 =?us-ascii?Q?GR67McDm+zjsWBXRZb7r5H9PUTvyqU4zvslxOzrYfhMlIrps2vlp0sg5gai8?=
 =?us-ascii?Q?ftze0Lyky4kl2bg7v6D6O9pcMi4C7iI+/XUpGekEcXpAzYkJYgYrw4703vXX?=
 =?us-ascii?Q?uiPK+uqU0/l5hVqz9RzRy2XSfofvvaFeJ0ZvavkrmgF0gwsI42I9Yukb/UI3?=
 =?us-ascii?Q?888R5DKrQjlkZfy5RyMHWngHwnZWbpbuorHAZ6AwkEqRKcwAKo1v3wt/mhwa?=
 =?us-ascii?Q?yE2vQVYABmFYeSen7rT8wGY0hhLzOLNsekL0r6/CGMBHvexzMph8RwHHYSdL?=
 =?us-ascii?Q?l/BcSBcztgiKq+Rtrua6ckdq6/0RODznyN4Y3a4uvJjTICM4IpOh1i82QWEH?=
 =?us-ascii?Q?h8ie4mqE19ZGlOpyW2l83ur3f7de5zkO+ghnFFubFQf8rxza6sQVE/lTrJxp?=
 =?us-ascii?Q?jSUACFDIIbBjgq215dBsMG6HStmNnHMvRqTwiNj6Z+ri21Sgw3OmoWe7YI1C?=
 =?us-ascii?Q?SpR7Jb6LSYM6/8XJvYN6vVeKAaVmIMN1BmW7BGcZkUPfQrU8xUElqkyl4iLb?=
 =?us-ascii?Q?w2mWz8oITf/Js0Jw+svX11L54zxHs05IffbzCJy7D6GQ7Zh8iEei79YVJPRo?=
 =?us-ascii?Q?l/SYminD6m44qZSp4BopzMz/WjzakKTf+RqqK1+4WGDoXEX9K/YDfacSlOUO?=
 =?us-ascii?Q?jnTxeiGCLMy4pvG6mHJG7F73MA4mHkXiTXJ5yH9vPZes7/CIlJbVdPFgA4Qb?=
 =?us-ascii?Q?Z4qs50cLhRTS8RRPtZSz42YVu04G6v3TkQhzV3HIWGhB2RwBm5KBKflTeYsR?=
 =?us-ascii?Q?d4GkqjOT78aqXtc091tw4yu57wUPP+NJ49qnoUmo47U0vbkxKNbH151XQngR?=
 =?us-ascii?Q?rA8pammwtJq3d+jkL2at9MQIliSVlGCFFcJ5marnxKeACR22tzq86KTHu7bp?=
 =?us-ascii?Q?EJvzVDXCmZULlapC4uMX6AKK9nPDk00tg4tGVS11h4Dp1bQDk/o5rzX0iN5l?=
 =?us-ascii?Q?XzZd5rk3kbOZ7nTAv7OCX+qx5dhI/6cHHb55bZhCksVXvtet2sHsHtTqJ3/0?=
 =?us-ascii?Q?MDiPEYcZf49UKFthSmUl7NKJCemm8UOQaHQjw58Z8Lg77aW3yIL6NeQpMqcO?=
 =?us-ascii?Q?8R1HYozxo3Vt0BzJxJ4UltrJQKAmZMqTIP3CQiiJ0ulzww4oJ9Y12EfJi4u7?=
 =?us-ascii?Q?Q45YPAv4/TpgxOstfEwtAjy1163vOWdyres3g2U9pkiLJAB/+mRlrutMX3hB?=
 =?us-ascii?Q?2o8vuCtZdlXIR7EBQVxA/xYApkWrq+P/6J2PJcaaG54qFesa7dh2tzl3b4FY?=
 =?us-ascii?Q?FKTQcOWnIGuB80hoTOHmZDZQy9eTJ9NXaV+40lheJSufKpJmEv35mXX8fapO?=
 =?us-ascii?Q?8pKTTkArgO5akKC6W8xA8GNDBh3PD1GsTuqrVa9XsuIWQGXd5bQbQLIr45YF?=
 =?us-ascii?Q?xjo7yuCuNM2nd5hu7vguu4Su2bIo64s0dABN/pEEnK7GciEUykiS+/oB4R60?=
 =?us-ascii?Q?JhonnPtVSOLhc/1wTC2N30Rf0wfeY537rm/LEGWwH3CI5xNkjDS2XEHpOUP/?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lQi0bj9TCPPkkrYJhz7FNCFRwleNV+c4hKYalbDH1j3f7OYFzImMZWTcikJxg8y+kIklnsxgnxnfw8f9ErsvKEldrL45ssVNEpwNhvB6JSJYOLXJPIJavGCrQD3oFMZXWWa9oiXpFccwa+fO7MB9dWHnvYnWv9VXfETGRYsdXhd9LQqSh0apQj/3Y+281E58Sp0EvIq2/T/6KhFIpHqEFMWF6RIFwnEKdNtHRWXItoQXoQGVF6Fvg3j7gzP+pSxaWM4WpegG4bH8j3WifHiQi7naXoeWw2mRhoXisGYUeC7hHljVv2hpsQCzobZ/YXTaMPcmNrPrAsq18aIxZEeA4aaQVwjSWJNX3Z6ZHfqujw+9PulvBZhomINeAhztHHObshaBM720s+rJvm0nX+xiaC1mHivL1qFDT7jHEoGtcHN8EcsfzeYtnsL2N+b7GE2MppNWZuR+98ilEUTlqEDTo9vswBK+AAzIAH2I0IenT/hRLKeAuAFyMbUKUE6XKvptB64WXuGNAeH/QDGZKvpO+5MpOqOFPjHQj8i/xxZwwcC8K4gSZoZnBNP1pWXoNSxPLm7IDuZzR7hfHJDOttgCm75kHZzku5DpzJJyf9xzSQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e185476-6ef4-4fde-018c-08de1715610f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:02:52.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4lzJ/Xnk8EXM+OlzjT7ShCyi0q1h0DWCRg0QEqT7mL9qtvCuz8SqvcV1XwmmDTUaGyt1oweKML/wzHi/cz1H5kQx6Mtsg+YJqRKNNVLBg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=373
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510290143
X-Authority-Analysis: v=2.4 cv=R9YO2NRX c=1 sm=1 tr=0 ts=690256d2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RrTQ1NEvnBZ2AI5r1LwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNiBTYWx0ZWRfX1bxkB0pjoyIa
 P6kar7t47v/u+NF16ZQ6cJvv1GN93/yzBfVYFfysFMilOFw/NQ/vCspE97DdRHuejSeBc9TyEka
 YGQZRlgyrMDcow9M41bsTJZ1wou9dRQa4qmzzAapALx+YXn6/1N3Fhe8ptFa9zSra0Wewk6gd9J
 jeB8yUmQEm8zBzET10XggdKngyPgQgFxua3Tnc5bFudSPlvRC5X1sQnhNhaIX1XfDgjcGJbthN4
 V+zN6Xmxw+VmTTEMR2ecpJOAx1chO8JvMWKzkTqSXJaBuugMeCQ+hCNNyg5uuqo110P6c1Myymm
 qG5hCN0BRGcuUlEvoJv4IlgXmsZA7o4aOd/xG1O3+kqrv7WBr1JR+0jwviUfjJTVc0HwUeVrWUp
 wyHLL3jpQe0/PrkrPorCadvrsK83i4vuLOIGR68vJmXDJ7OrQbM=
X-Proofpoint-ORIG-GUID: l-KXyxxOJUi1-wfwu5RA_OIiZP7CW6p6
X-Proofpoint-GUID: l-KXyxxOJUi1-wfwu5RA_OIiZP7CW6p6

On Wed, Oct 29, 2025 at 05:19:54PM +0100, David Hildenbrand wrote:
> > > > > Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?
> > > >
> > > > Because nothing else on that path is guaranteed to send any IPIs
> > > > before the page table becomes reusable in another process.
> > >
> > > I feel that David's suggestion of just disallowing the use of shared page
> > > tables like this (I mean really does it actually come up that much?) is the
> > > right one then.
> >
> > Yeah, I also like that suggestion.
>
> I started hacking on this (only found a bit of time this week), and in
> essence, we'll be using the mmu_gather when unsharing to collect the pages
> and handle the TLB flushing etc.
>
> (TLB flushing in that hugetlb area is a mess)
>
> It almost looks like a cleanup.
>
> Having that said, it will take a bit longer to finish it and, of course, I
> first have to test it then to see if it even works.
>
> But it looks doable. :)

Ohhhh nice :)

I look forward to it!

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

