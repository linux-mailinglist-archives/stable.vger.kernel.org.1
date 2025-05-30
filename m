Return-Path: <stable+bounces-148143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDBAC8AB9
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BEB9E3A8A
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECEA220686;
	Fri, 30 May 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FGfqdXk6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aSSlQ7nR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A92220F4E;
	Fri, 30 May 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597330; cv=fail; b=ts+Yskfe44xOcZgJcfQ0ciasM24HDZ0qo38DgQa96Oe4eseyN7WglLWatbwdny9qj431eS1YrBlWA4sfX/isuAG3tIEZvlzddYxvQxpmTWMr20vRBOyykycOmHuWWY2ommrkYohJCl6e5sJFEcJIoILjGwr4xpO1Z1ECLW8ent4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597330; c=relaxed/simple;
	bh=0QKVr2JT3gUYFcKgExS+GQvbMIw5M7JfhLjoeIbi0Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caDSOTJR3uoNBYWMSlMa2U03tSLXJKVHMJ15zv4HbvEqR7jtfp5ddId9B9uF7BJOgHotogljVJ+KoS1nMl6ECMZQhSEK3ABEOs7zQJlXco5XQikdKwTgnUfhCNl+eoiA75h8rTq2C8RPvrPANLFdHj6HMhXM1tkYBaCinkx3GYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FGfqdXk6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aSSlQ7nR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U6u4QK013019;
	Fri, 30 May 2025 09:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mQeLNDmcmbWkV8TfUO
	3TMjmg4QdyOKYZQU8rDFcqnu4=; b=FGfqdXk6/vdXwMDWjlxgRrSlk7Gx5Ll0uw
	5hX2SS0lnQQWfkD37iDONoQ8g84az7KFmjhf3kJb6AKjMrEdLoz3kUPo5YQp+O7l
	wAfqg7+rzKU28ny+D+P5st8zI7lZzW2GFjb0zdSV7rr2SP6Mcn88LMdKEspf2NtB
	/v33+/Kl2opO+zQx+oRovJNVhIg3RxgatL0hgvZ8OTgs66sswaqdS4ciLN2xYXJz
	trwT3YlgIrV1DemIXd9nEsNNYa86a21+npjrCE5aTbixA5acqWtvYJxWH/i5/2Mh
	cC/qs52rHDhiyZgFa4N6rE3AS4DC6c3JX8qVcu8VJib6K0plfBrg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd9p3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:28:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54U80hPE025697;
	Fri, 30 May 2025 09:28:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jkajty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFKtmiNMLQwm6hDI1YlEI0ROAsDN9QQAnn9p945EYD3Xc5cH7OIjxUowithCRaNcr0YzGCKmrZrB9Vj5ARJNtDHjQJ1gE+agLgkwQy9eHWNjJTgHBKzCN/4sQI1LQgezIMZXdY1o8rBW0CEz+N4sN5LoGe5JlE41mDbkOsffFjkIsN6205ijNUo0xi802ZFIJCuKHTGcf3Y8kH+5dxpXGY0tF0Q1gth8J1CUsNehdOdMCvAsAmYTwvBhgEB6j7tbf1+Pv053FuIePS82Ij0iE4pVS/bg8VwKY8WMyaiq8oby9VAuURtt3nIef/2BmJFUqBDeOB55WibXh9PskklwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQeLNDmcmbWkV8TfUO3TMjmg4QdyOKYZQU8rDFcqnu4=;
 b=m7fGb9NpYEeMY47qxQbiN+wxnZ56buUGKOyVksEuMgT88msPkXU4HxwGa5YIrOP/lWiBNoe6pmJAV6QQCB+x8/nP+CI/upwVRi37k6brggmWNniTo0ChzmGXAvETsAt9WBXCA+FCgNQkoM26M+SY74F6bQoljQLaiWkseul98DhYb0h+re9mn36/V5ezqEZNgmihRk2aRGQ2go9h0w7xrqwrNNHLuOte6MBhjHTH8cTU9De74d7q16h+P5llQeHYyIiVZYqK6bUeh0j9RUIG6nVsTdKGQQnEDP1LnaCUMHtK1z2r9F8EyhiHxlXVmVWdCZk/7vqqQrZMiWvzE83rxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQeLNDmcmbWkV8TfUO3TMjmg4QdyOKYZQU8rDFcqnu4=;
 b=aSSlQ7nRRs49685uVjGnBnScjYH7QZilLqGiBz5c6aZ4ixg9CImOGJ1B9ceqhQLkRC5h2RgLvRdTzyIFIMU8GvlKpy/Cm930CxRol47xvwZDe2Vs9yttIySke65DiXjOlxuskF8kkP3nuu1cMj7pGlebX7TUcp7ZvnKqAnsxHx0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.38; Fri, 30 May
 2025 09:28:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 09:28:13 +0000
Date: Fri, 30 May 2025 10:28:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
Message-ID: <2a13548c-afbb-40b2-a9b4-326b3958ba29@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529155650.4017699-2-pulehui@huaweicloud.com>
X-ClientProxiedBy: LO4P123CA0491.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e47410-b2d9-4d55-e7ce-08dd9f5c4d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QzBwuu98vbqAYRiHngK9n5X/RsUcJFYwQ340nRJ7BqoW9JHyeJ0QnZts9qP?=
 =?us-ascii?Q?wi/BiACrmZiWGoAE+2DMdTm/4EXq9M5Db3T6AcbL+V1RGwDpT4I+xS679LY7?=
 =?us-ascii?Q?X6V8mYad8VYkLtdPFa60MIEKM67X8Dr7dUgAfYBz+SuZqAPjTuWIa8EzWlXf?=
 =?us-ascii?Q?L8nfr5be9BaLtO4PM6xrTHBX9YbLvGinv/W08i4rukoJst0iDlTiRDvZO56W?=
 =?us-ascii?Q?fZ0MXC8DF5EyFpo9BrZUzCEePxFBAX83ImW4gFqIxOgKdMvr1IuIOJ6Ge2dq?=
 =?us-ascii?Q?oL/2W17hK6CA4YpLfn45wDupoz3LfShe6mwloJeniANfghcmaBxrfAbdsQOw?=
 =?us-ascii?Q?okjcpMv7lC6SWO1qdLZEVY/Y5ifc/ppyueA/fp54vo3ai15c/cXIo4fOcrMD?=
 =?us-ascii?Q?cwUJeJ5573Kuw5GH7hm3YyFKNszVrT9tfMPnHAE2dzI3O3LotJvNsr2cXyav?=
 =?us-ascii?Q?z9mzoFBayWa9BxDD1dWp6CnmFfI8DdUQaQ/1tem8AfXxzrq9xsprddufR1Ah?=
 =?us-ascii?Q?MV3IpkYIK8rSQlxCNKgUPw6zQYuYg7uOPOr1uIpG57hP2MZDFDbgezICFOKG?=
 =?us-ascii?Q?KBxOHull6n9SYyH43mC47mk9rQ8En/CYnVyLlldpxyyGsx6o8THJXB700UhN?=
 =?us-ascii?Q?+JoC+wb2qGJ16k/DT7Xip0XoZhWNJTxZbeAuFJy+VhsYD1r/qQRm9CaWmyOy?=
 =?us-ascii?Q?IzuSau3jo0VnQfxFHia5PAzW9WG3UiEvWd/dv6HUBuMOz1zo1Ti5htm4pwlf?=
 =?us-ascii?Q?FFKhAuxeaAxhhbMbdobwsjnydJLoZI6W+sKISJddk05yPzQECLwElu6p4p0O?=
 =?us-ascii?Q?JV5/RmwOLOt+IwOm4urdhuv+12kwcncsh+gZgRhn3iFTZqIvM5BzmSGnTJLS?=
 =?us-ascii?Q?wZhFFL8EvxdzCtaV7bM/WHHCVszfhttWFhuW2hH4E+wsqWqHWYd4JgYeU79q?=
 =?us-ascii?Q?z+MtJJKNTBPYnPUEkyACtTuY+fZMF4kfUiQFtY+KeY+H48xG3YLYMRCpwyZn?=
 =?us-ascii?Q?3AQYTbx9q0WlYaoz6s590zCVPU/Zom5jzBwv/3OVm6MnRCJMbvXOY/N1yWCr?=
 =?us-ascii?Q?DACo99l6n5oYNn/Db5tme4abPqt5WKEfjgSKVjZzQuWLGk5rYzDAAUq273pP?=
 =?us-ascii?Q?M4yCXahK/cVBJzVy4HDCfROARjF29Yhu4KmhbJltklOrQPLvGrZfZhOJVe6H?=
 =?us-ascii?Q?+xzYBciV+fFm9pffnQJ432JuH3EhErS1DEE5EVDsq3LjkbcqDUys9rOIs+iX?=
 =?us-ascii?Q?wOKHNzHrITMrCs0hfE8qMvlfyJgzYiepq798wo3OjLckiDya8RUhOkbHaBMA?=
 =?us-ascii?Q?Uh4l/k1tTrNM26nAqQv663Itc3c8RXRDc9syjxmlb5MXr7ZVlTFWt1O3h/L+?=
 =?us-ascii?Q?obF7xQ8JxRW2t9uKP2JIcy8YysMg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nu6TCFTq3raln7HX+IpZHGCKTjwsNnwojeZtx42+Fj4arHZVWn/4pYA7njd+?=
 =?us-ascii?Q?TGOt3sh898KuezdYUbsUBmsR1+euZWVbJQ/OiuNDRTZ0BLLDnKn0I02qIpLL?=
 =?us-ascii?Q?c6DbznmD8XXUYqGiCWRM38fl/rt2BE3h+ddkvA9+FxU48U9Dye9gOGjBPATk?=
 =?us-ascii?Q?3/OS2PnCCwiV1hHP/r5TNV5/OlHZDPEWf972MjPb52aFqs6bQL0sqrmUkjgd?=
 =?us-ascii?Q?zpF0ceVfeYNzD/LSpsTgZw4/IgE7sZ0/oPpS92aA20yt/E6m4NJyn2Wrtb3s?=
 =?us-ascii?Q?qxyerXEv+R8NfgD3l6s0iyRcxvFM6SZXrm8rIPnD7dL54OI2Jv7ORPYfAKFk?=
 =?us-ascii?Q?mwQjvT5p8j6oiz1+N95Csatnl8Uhdq/b92cwEgftJB/dv4p1cVIEKabp+e3T?=
 =?us-ascii?Q?VOQ7oEtWbkm2TMA7TPrrSJp3MBcI57UbMFpfZZ4HSNddZPTW8fpecdmHDOri?=
 =?us-ascii?Q?gtZ0satmnWnbiAQMyTQqvpAf6tMkHicgn6mBD8myg/SyccAdrs1Xnj9CEB6K?=
 =?us-ascii?Q?scVXkLYIgH3O0oNi5cCUs1sijhjdgRguTtjfA7QIDpAVT46EWM5vjRTYUIAg?=
 =?us-ascii?Q?M2+qZWVaynX1GtzQ5P2b5mj/uIWGSHxQ5c5hWXpzU+OHHZ8DtVntb/VIwavz?=
 =?us-ascii?Q?YYP7J5TaIbxZfaBiHeeDW9oPNEGNtlTAv32d8WLbK1bhnx0PfjHngdkoOOGN?=
 =?us-ascii?Q?ELEqCymQDNNEr1igjfxK6LVS6jv3p7BAMILkNL28GmWOA5UBGLZA8da09LeM?=
 =?us-ascii?Q?Uw78Qdn5Lv+ZKk0wmUpQojWGhxMjXpqg9a8kJNFSBVxEBQP9fuIxEuNSPpfQ?=
 =?us-ascii?Q?cwAQ+hLAxfleUJfnkxk6b1aDlRMjKL/d0jjqmxoSkQPqy8A8Zidn/d8/TiMp?=
 =?us-ascii?Q?6TJmjR6P7OWmlwmEHnF99yTif/MI8Il2Th88o/83ZJxyoebu/2SOF+x3vKFx?=
 =?us-ascii?Q?EbVi5nGcIlnAHhP7/WG3DUCpHQGDxr5/XolOBtxuFjC4SXdsfCiGHUx1L4SN?=
 =?us-ascii?Q?TmAVuJ1/ffHFWPft8zk7gj1xeizPe6xaIPAuRzuCe87a4wZ5wMoSnCHwMGox?=
 =?us-ascii?Q?z7XAADZcwevxJu5BZur40W6Kjk4awtsNScB6kbzhQQ6FiEOwa3eZ8a4xIbST?=
 =?us-ascii?Q?UYqg1JR+Gk1ke5kSgI+13eQJYAMwtM6mAOyDMODgDWuprBM7RlIbeml2CqFt?=
 =?us-ascii?Q?bwVz2rEQN6+NkIerPq3c3HC/PZKWqBFTP6OEBFYp3EvGBrbp3I0y9mqlerE+?=
 =?us-ascii?Q?fjfoB5K102fhfp8nN2niCQ5/5md7z8xRUCN60vvEMKuHmmh1BCEIgel+nxz0?=
 =?us-ascii?Q?S9PKwqN34pKDOl2ejrBd7rUAWOudQlwcQmpzJjXitUGM0CI1hstsMHRhbJaN?=
 =?us-ascii?Q?lEDiV90ZedL57bcpZKdzjnGrVj8Go8QJuCeektWYxK5W/1yZ6RC1Rs57vsqF?=
 =?us-ascii?Q?Aqo7ARyfx9fG70FSl+Zged/+r5y+12aO8g4po+tp+Mc4xPgjif+S1lpd+ybv?=
 =?us-ascii?Q?Pf4FOPDVBV5MbVtX7Wblxsg6rE9u/0EWvNK4oUZt651U+IUUypmbkrWitwvf?=
 =?us-ascii?Q?wsuTvPtf6ce6s84ZYwTmopRXLivvge9uZiS62Umh9VyVP15jzoP9aoljyclh?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+FAit5mjNs15JIGppEKQllAcDT7WT1LaQJ/Y5xPrErn5HnvHpcT+rkAldwnMV3veQTdV5od7VmhclsMc6HAw1/r74oXZp2drFFiLQjSiBfnEsINh5R2aCdQNHdBMuBlVR0gU+p0c1yWjvSR2e2l74PVdeoX9N/D855gZy80Vy6qsoj4s5sUX8zsGpiLK/Xn7eqVuRVSWN+zWrwaJ8CISKy2YlcKATPDdKct8aVkPVDkDbt+A2o1fPtZj8klWz5hjRu7cgZKVcp+ACuhBUIplCAp+rKRRDPL8Fz1h4vz/sAxpssBdJ929lMIZ2XZtCuIjbT64YnSHgtTN1pfQKsFxjwu07Vltp7L0RltYODXO0qOhIi0TN6aqUmQtEWI3xalBjT5zdAP5FmZKZ4h1gzI68BHewXYdJQ3RQ9VIEAkpm+vDbVVhwbOSB8A1SG+C9g8H47CJRu/dXVEjULvPUUj7HyHH/sk93Ka+o4pny6/MdDW3vTw4P6qsSbHfwArp00XndLggkcQZ4DFMFeJWbRAI9FCpL/D3WDOZ7htwhHYtze76BkU4JE/kH2Rrt0De8Dnq+Z9AxX6pZ1oOZRtYo8z410gLe9j/08m6bcqrTeUypco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e47410-b2d9-4d55-e7ce-08dd9f5c4d34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:28:13.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNcEX+JOwBnAdWveos+ddc6RHBwrqcxtakE7nEFEswPAepx6X+qFoTa7CaAX+8pRRnyhtQ5SrjJzGOk+xzzfwhgso901CZB0WHGdvKOEsWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300080
X-Proofpoint-ORIG-GUID: FpzKDnr82wBU-FoNmizRI7i06f64HgRW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA4MCBTYWx0ZWRfXwgsaveThVlJq Q0XFpt7p4q0mCCppQvjh8zCMkM0Ug4+F91Epb7VDXpk3Rv3IbC3nn4unSzZl7WNL4HYk/I9n4+o ywKVATvFxrabzcGjGigK3uhJuJ6aFnkmX745kRja4AdkwWVERI99R2JExwzy45CVQMSbMuWYVdS
 md0/0dB1yGE8FS+zvxQp8b/d4OLv6NXLlMwKdtJtrSX7MobYVJg+rZFJx3f5TJ6S4RUN1pceAMu UPfxgfFBLe/iDOiqKox8ZGPUsbDc6/yf8psWP2UbG0x9rFnBkiiISjGbJhMcaivMsOe9o1OEOZw CiXLY7fhhg9vnCgvvJHJL5NWR/xKKGYsqO2i2Bz/e/s1hDQGqAuDrmzp8CDnHnAenvC53USuYyg
 5dqPDGMXPDNLRpwzaeZm4CJdQ/riCYv1WTocALjdbetIMrVQYl5UjVnrCWlAdhJSmUWppKsz
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68397a33 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=2Ei7gBovnH3WVZM9m-IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: FpzKDnr82wBU-FoNmizRI7i06f64HgRW

On Thu, May 29, 2025 at 03:56:47PM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> We encountered a BUG alert triggered by Syzkaller as follows:
>    BUG: Bad rss-counter state mm:00000000b4a60fca type:MM_ANONPAGES val:1
>
> And we can reproduce it with the following steps:
> 1. register uprobe on file at zero offset
> 2. mmap the file at zero offset:
>    addr1 = mmap(NULL, 2 * 4096, PROT_NONE, MAP_PRIVATE, fd, 0);
> 3. mremap part of vma1 to new vma2:
>    addr2 = mremap(addr1, 4096, 2 * 4096, MREMAP_MAYMOVE);
> 4. mremap back to orig addr1:
>    mremap(addr2, 4096, 4096, MREMAP_MAYMOVE | MREMAP_FIXED, addr1);
>
> In the step 3, the vma1 range [addr1, addr1 + 4096] will be remap to new
> vma2 with range [addr2, addr2 + 8192], and remap uprobe anon page from
> the vma1 to vma2, then unmap the vma1 range [addr1, addr1 + 4096]. In
> tht step 4, the vma2 range [addr2, addr2 + 4096] will be remap back to
> the addr range [addr1, addr1 + 4096]. Since the addr range
> [addr1 + 4096, addr1 + 8192] still maps the file, it will take
> vma_merge_new_range to expand the range, and then do uprobe_mmap in
> vma_complete. Since the merged vma pgoff is also zero offset, it will
> install uprobe anon page to the merged vma. However, the upcomming
> move_page_tables step, which use set_pte_at to remap the vma2 uprobe pte
> to the merged vma, will overwrite the newly uprobe pte in the merged
> vma, and lead that pte to be orphan.
>
> Since the uprobe pte will be remapped to the merged vma, we can
> remove the unnecessary uprobe_mmap upon merged vma.
>
> This problem was first find in linux-6.6.y and also exists in the
> community syzkaller:
> https://lore.kernel.org/all/000000000000ada39605a5e71711@google.com/T/
>
> CC: stable@vger.kernel.org
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/vma.c | 20 +++++++++++++++++---
>  mm/vma.h |  7 +++++++
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 1c6595f282e5..b2d7c03d8aa4 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -169,6 +169,9 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
>  	vp->file = vma->vm_file;
>  	if (vp->file)
>  		vp->mapping = vma->vm_file->f_mapping;
> +
> +	if (vmg && vmg->skip_vma_uprobe)
> +		vp->skip_vma_uprobe = true;
>  }
>
>  /*
> @@ -358,10 +361,13 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>
>  	if (vp->file) {
>  		i_mmap_unlock_write(vp->mapping);
> -		uprobe_mmap(vp->vma);
>
> -		if (vp->adj_next)
> -			uprobe_mmap(vp->adj_next);
> +		if (!vp->skip_vma_uprobe) {
> +			uprobe_mmap(vp->vma);
> +
> +			if (vp->adj_next)
> +				uprobe_mmap(vp->adj_next);
> +		}
>  	}
>
>  	if (vp->remove) {
> @@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  		faulted_in_anon_vma = false;
>  	}
>
> +	/*
> +	 * If the VMA we are copying might contain a uprobe PTE, ensure
> +	 * that we do not establish one upon merge. Otherwise, when mremap()
> +	 * moves page tables, it will orphan the newly created PTE.
> +	 */
> +	if (vma->vm_file)
> +		vmg.skip_vma_uprobe = true;
> +
>  	new_vma = find_vma_prev(mm, addr, &vmg.prev);
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
> diff --git a/mm/vma.h b/mm/vma.h
> index 9a8af9be29a8..0db066e7a45d 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -19,6 +19,8 @@ struct vma_prepare {
>  	struct vm_area_struct *insert;
>  	struct vm_area_struct *remove;
>  	struct vm_area_struct *remove2;
> +
> +	bool skip_vma_uprobe :1;
>  };
>
>  struct unlink_vma_file_batch {
> @@ -120,6 +122,11 @@ struct vma_merge_struct {
>  	 */
>  	bool give_up_on_oom :1;
>
> +	/*
> +	 * If set, skip uprobe_mmap upon merged vma.
> +	 */
> +	bool skip_vma_uprobe :1;
> +
>  	/* Internal flags set during merge process: */
>
>  	/*
> --
> 2.34.1
>

