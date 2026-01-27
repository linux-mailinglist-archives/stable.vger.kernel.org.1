Return-Path: <stable+bounces-211856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKK1JyfkeGlJtwEAu9opvQ
	(envelope-from <stable+bounces-211856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:13:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A497856
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B38B301BA40
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35835313534;
	Tue, 27 Jan 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQtiyeLF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IlZbBnp7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49179346799;
	Tue, 27 Jan 2026 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530152; cv=fail; b=WaSfAwikb75Vo7v05zHAAh7F7IrZISjQ8E6mKYG1RyqIfunuiv+BfjBrfwqOErKtwF/y8NC+ORCzeC4rZnCq7akvBN1dCLBTUeQvE+B4FupObAwb7kQcj9smnz4vMnA5jALYyezFIXLNP7NeSmuWDhkfsgxdcerXH50IAn+zlvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530152; c=relaxed/simple;
	bh=CpfM8XzjGWCYhlYFT+lCgFnR4uv8X7NSzID7WJa0X3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WYOcxK8DmyhrJnGsG9+HDUqDCbhYlTWHVn82U2y//SBnH9V8Fz+ShsSZEqtE6LC1V2+RwGOthhfzvTpdmy2NQKWlEyASbDS3nBMn0zjLmAANPUq6h5GSYZwDsodBpfBSS6BsKK/vYajMUobIv75INmsLmIqdPJGAWKDK7cs3ZfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQtiyeLF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IlZbBnp7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEJ1M3280362;
	Tue, 27 Jan 2026 16:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5t582QGrC14pIhgsFn
	6X9e59v4k90P8OL0Ro01myA9k=; b=RQtiyeLFQfhPNAFc6jvLUI4McGVtlL+wmG
	wvVC7XOzNTHtQJJ7LfYWpan+Gj1ornnP2Dm+EEHbxAbIKDbCspo2YqXpinwCfwon
	tw3+lHAh6URAuWwS/wXwLn+1sQQU9sdXzY/v+l7I4K6HombrK1Eb7ocD1CJDJ5OE
	z9XE/X4p2Wl0+12bxqD0VNQYrBSKwkfZQ5WzTbZ1Hg721GZuA5IMjW+rRuxV3JzH
	/ZstFvoh3Av9PPfi0zOwLejG19IueZ5bdiTD68k7ZCX8vOTHIHyC5j7VGg0r6fHv
	SyEZJYraj1cDpEHHChs/eWEmpRU6g0xMnBKPPezxjQSOamw5PrVA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmrc97g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 16:08:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RFWDvl035109;
	Tue, 27 Jan 2026 16:08:27 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9m297-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 16:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ8ktfVj/joHNCRRE8fnc5pCIHvnhaWgrqmnKwZyYF7TgqpS9y5HHU1cpDgvt3kQuTXbQmVDz8FYrM4XPGGSIQ2hYsSJBTfxyG3I3tcvt8u6OSLpiEHlekoh/4RUjAaLpI2+J80OWDcLpjx8YPtdaeioTmaOEvrGfS+RWZGDUKMpqo2q5UwsJD+IeuhRicc7GME1DlfGFWe+GDtdwS4IwIvtOSFgMlIEwfs/O7RRty/QfUHsimSteFv8L374A+SzTvHw0EjS69ghew4xt1D5qm0njrEq/2N7ZCVar3WW5J5z7Z5ceMhbXuChcDyeXGEJiPYYzzAvtkJUOdq8RKT31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t582QGrC14pIhgsFn6X9e59v4k90P8OL0Ro01myA9k=;
 b=QSqVuTVQ5TXHcC4gUQ1HZgh418rbiRODlfpjkZa/tSFZfXHF9D/dBFqSO1Xd+N+UrTrKURPOrZE07HDE+rulcyvPVm4qCjsX4X55+BynEchhZ9FtMZPz/pLGBYIYf5awWuDUCX5o/px29u1DREt72xJICNW4UH/dSdxchsVfrucn241Z2O7+Xq8eZMk4INdRrvDP8YeDX2BDPcdhloqNaVf5VDpcpo1wqhEU5qhkqkQe5cZiElog6qxUcqEMTh6RhCjEYMsYHjj1w7NVaclUem87VPahVuoKgH1VQdWGzKeBd9/c4owYsFp9i/jGWn8lLhzLOj2VkTNn/RnkbRV+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t582QGrC14pIhgsFn6X9e59v4k90P8OL0Ro01myA9k=;
 b=IlZbBnp7jOnra64HkjqQ++LSvFK1CJ49G77ff+yPZtLWOtGNrj5yiAkqqVzp9b8mlZUmtftgtxTiVFjKxOVLi5GPgO9S+yfGD3eFI4EBpVrcMRymuVkVCRB9tglpSKBtedbDuKxckfNZC6LvlTnaV82HI6LY3PnF26eB7Rnda5w=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 16:08:11 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 16:08:11 +0000
Date: Tue, 27 Jan 2026 11:08:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/22] mm/slab: add rcu_barrier() to
 kvfree_rcu_barrier_on_cache()
Message-ID: <cgkr4xc5oczrjiox2utksbvecbke2kpniacaog36njcdmvkdxx@6hnvksdzrwja>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com, kernel test robot <oliver.sang@intel.com>, 
	stable@vger.kernel.org
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-1-041323d506f7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-1-041323d506f7@suse.cz>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT4PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ac915b-0e64-4ec6-dafe-08de5dbe44b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7Y7jc+QoSDwT+6/jVfAMEs8oJSbmbJ6DKTaE9dN7t2sMx1EgNjdHe4Og211?=
 =?us-ascii?Q?aA5wp6Vrf2aXQSJVcK5kdnmHze7UYiIa6yMbT0pzLWP3/JuDPKXyGpGUqE20?=
 =?us-ascii?Q?RCS5yaYeLx15mKfZ/EPR9a1583HfUdgor3Gcp2G3DDxV5amTxARI60eX0vJp?=
 =?us-ascii?Q?1PCQ7ixk9yOw4zsTbTEyOEvteT3XpkOKLGp64dvVctHOme+gnLv2GkbXj9Op?=
 =?us-ascii?Q?8E238xZ9kpeibasgyjV9juITBgbJLHQ+LRn0+vq9KZ30NUQvOv5q8ayXGgkg?=
 =?us-ascii?Q?TX4M6eOMwMgdG46SztdNW13PNLTIeZWjkh6b2VRgBS59QiCV1rzfgSjhk6KS?=
 =?us-ascii?Q?OYrUGPcMEjuPikwtF8jeNSpEDtsZP0PraH8q0EvHKlu4PW41qiHmv01ShZzC?=
 =?us-ascii?Q?1whT7ju55We4om0hg3fm75rRvGkbKzGu/TmTGkjM/aMSGl7jqlnNuXEUgt9P?=
 =?us-ascii?Q?dEUl6dtBUOzyVH0kzro1dncTQcXlyKjiqsdVN8Owh2fD+YFOEH6572Pvaq3d?=
 =?us-ascii?Q?tPNPCtMyuSEKDo3f7xW0TWHktlzht21NINWeBtdT5Mh7s/v5baPC1epvPb4R?=
 =?us-ascii?Q?VgfXFXJ5tkgt2vw683SNC5/yKgk5A6FcqJH/nDsJ35LDMCFYQq8/xOA5Ldiq?=
 =?us-ascii?Q?feF9ybYZJfG+i8UAvpbAhp+/cu5g7bLoVJp2UrxXQMzoF8eWL1EAL45/4rdL?=
 =?us-ascii?Q?XoSEHl7/C1Dxji3Wq8CtCez+AbV0d5J46XnY82F0yF1LSqKzsSuT3GEAfUQi?=
 =?us-ascii?Q?rDl+mia6wXwoiJlg8PVAGXwJ5+Tte5ERa1oKU8/UO66R9jrx5ZLnjuQefgNH?=
 =?us-ascii?Q?dulZ5ZkViYRPsA6QLfKnO8YXuY2rCxJRsLRi3GdmgSnIW9UtD1Khr7KDby9+?=
 =?us-ascii?Q?7B4YswrILJWrmmcw6Aknb9WzgNftMuaoXeXXJkNGt7nq05aw+2Rko/FLlLk8?=
 =?us-ascii?Q?FmROo6k1tDwJZV/crptk7ZdXQaVYEqOMMSP9WIap3F+QhkleihyCx7n3Fdzi?=
 =?us-ascii?Q?dzlbW2fXw44ZUFJ4cvmyjTdcnwUROFAAbkPxTwuUcV0on6r31F/lEwxm+11s?=
 =?us-ascii?Q?QN9wb+jfd+iJYNETOpW/sVs9wdu72lqT012Vt4jdTJLWhnJvQXfk5p2enB4F?=
 =?us-ascii?Q?4ZofSxdNfxG4fvtkPoywNALDdLw/Uz1TeUh58sFg+oqwBcUQH2qcQKvc/8KF?=
 =?us-ascii?Q?3O1CQf18xTFtQmS11uZJCaF9pJfz8qAw/+OYFgrv23Yzfe+Db1qOMiE5DEJ3?=
 =?us-ascii?Q?HE/XN95N7BKewFj4I9cuI3tkkzB+PLS8R2YUwuEeB085yfwcuIMd/aCpJfOh?=
 =?us-ascii?Q?rstNbuXPgOSHNGESlr2zW6t15L6U0mT48tX4qNf+/KCUCjFoi2NdGXmWknHb?=
 =?us-ascii?Q?vLKKmpU3U/HtT4GADSF2ukRZyRSTuvGm9QEZUXi2PxXa2p7IER1CkLfT4N3B?=
 =?us-ascii?Q?fAQy8YZTu13ByVxbasgl2KSxOEVvxhdhBMDHSSXsvIriQpdWHtDaP27O11rz?=
 =?us-ascii?Q?SvVegRSDj91VfXKSot+9LU+OEkl1x7JGVlLa8xaXmMmjWFqy0YxGDT/dX920?=
 =?us-ascii?Q?NkU5OAUcEstgiFz0GG1+BWs1hhZHKGrI+i/iF5v8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K79AyAYEOGEcsUr1iGiES6mnqPSLTEhoLrjNfWTDXzWiSgGHhtUDBmQlOE/r?=
 =?us-ascii?Q?Z8PmNtqgjaxsTxhB+lJc4hQ+HOUJ04JIP6udrgduJFpEp4mxesnnQVVNnmiH?=
 =?us-ascii?Q?4EkiXyTksD3dVz4xHA8s9nTaj+mwzD1zQdz3d5E5HuUQa6Ltt3a3b6bDbzrs?=
 =?us-ascii?Q?mv6/MLD4NuRMi3eG6M9Cj4roeHPbs98Agdi3B7GG9YTGr3GNl0ABxZDIPsiB?=
 =?us-ascii?Q?0nrxXQ1BJjzoLpvZpochwv6wxnObaCaAkYPgvPhAw57iDQcA6bgmqG+chMfo?=
 =?us-ascii?Q?YxyAbePVM1pXUN3CdkvuQcsDEmTjLaywF4XeRkFZmZ4AJ7boZmgXQk4tXXT1?=
 =?us-ascii?Q?CSH7oSc5vWWNwPUIVT3V3toicgWwYPoVehYCcdR+9re6RQAg+1mVCFCkOG7+?=
 =?us-ascii?Q?21mBt5WTnIX7ojZi8EnvwrJ442BoGU3kic3heA1pzbYd0tsyy2y30Hv7TTuX?=
 =?us-ascii?Q?+KqiqNRpDRG3VQCK6BSmQ8iAorAUf7/AUqkX1Pav29NRGNGcjI45twTKIoDS?=
 =?us-ascii?Q?L0sTVQKAVQWJKDgBNx9bpIKnmrvvaYgQPhhIu6eH1CCz48GBn2LA6pQuMmR3?=
 =?us-ascii?Q?0RSUI0fwapLxsUxQE9iT0lRQ8t7NJfW7OZAYgI4eC7hwSZeGe6uQrNupPBXK?=
 =?us-ascii?Q?Wnigs4uZKlRB68ju+evneHKmNGEwE1Lh+VMkbINLFcSve5kZq58e6k3rL0/Q?=
 =?us-ascii?Q?lBl8iwWbvczIHVtyZKKf9pxEK8zU9qCw3F0xkRTrHmgDBDcTKjn+4Ek84Biw?=
 =?us-ascii?Q?ashiWVs1sKp4hj52CltKUKNxJb+8rXAKpkWQSRgaBnxw6AEQsTysTrpwOKph?=
 =?us-ascii?Q?2m1EKZAeYORBfKncGpTT/2gFW1wUkprfUlDuVQKkmxKh1412m7Hgw4y75Vna?=
 =?us-ascii?Q?GyALfPtm3PJxj29nsPSTdyVGryRPhot9qLMcX+DXqPuHzjgEt5ZnO1k/IaNJ?=
 =?us-ascii?Q?4NPPNum6+4tQO9gRaeoii7BiDp5gliBkR30f5RiDJMPg0roIP1k+1CZXqYlM?=
 =?us-ascii?Q?S/0zHB7bgZKuii1EE/oRgQIc+PHxi5DAZm0otcsrD600ybVO+DwUwneUPvzO?=
 =?us-ascii?Q?5cl+3e8os6OZxDAu1f9OZir3jzfNAdlmtF0LBhi1XAZFx/0FnVkMdhBOqqRl?=
 =?us-ascii?Q?6gA8Va7ERHpL2BnBNmf0L0bjJig1ddEwg6TurE7SXCRI4JwyXUjPGLWLMR3t?=
 =?us-ascii?Q?VDDZwSqIoEDusI02kxf8gOCSQFxIZOLcffQZBt3KOBuoL7yPt0eXRjB52otU?=
 =?us-ascii?Q?Zo6lyOREWfUyXtH42XHKl0O5CGV5IaUE0L3TkKF6f5wF26lskt4kd1dw+atV?=
 =?us-ascii?Q?aQBoxw4yyVMYXwcDoptzBtF5L9/m481/Nhq04EvkbGuj0qea6Sx046YkaNec?=
 =?us-ascii?Q?GvgBRYJlgW3G/aCPFEU0aexWMmUHIZLkP6n3IXLd/Y7fG8OLpssCkfi1h2iO?=
 =?us-ascii?Q?hHEaLQ94EQUPBSBHywJ6HteTs4lZGmoK1Wg8+0XuRe09VfJVdh8bC5lrqvl9?=
 =?us-ascii?Q?VvKddY52rfreDN7On86CtCJIV8JppY6n6Im0GXmAuS40XCjcaDQ2aJj2cS7x?=
 =?us-ascii?Q?xSeaZpSI70OTQ8IkJOO7h1qhW5MpxAWYCElEGCMWvVCxkTo/DsXR7+7agGkr?=
 =?us-ascii?Q?xfjNdvrdsKrL4qmi79EvuRMpgcT+sIQGF1jzgD6r/AWUFWW9h0eirujlErms?=
 =?us-ascii?Q?U3UQfwgpY7OAxOrhoOFdGCmZHieXjPq6NKvddoCx1Kb/O1wM5YJE+0/XOBY7?=
 =?us-ascii?Q?0TJjfc5+wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rKSIfAXRSLUHi/DfHcOoFxMlirK6BGEX0fPQE/LXdXN3SMc8H7XQND5TB/ahCFKKp7LlbZF+tTlhajqsiwLrAJ+tKpemArDO33ogfzeEUwPY8TR/rsJevSEVNr8UJn1wIIq6axMxOuCLwjoyQrsHvCyfmrQQho65t2IxQwIBIobG13U/oedPHCsrPO0x5oAQSKHDtLCO8fNRowdVZ8yoRwZoC5Yg/6iNtT4HZllm1EXEguD1WyrBm6CGt3gkCGb0wgJRcF8UvK10EUISwTS4sFiKw6bZEkoGTZzf4mgaI7m8+2jV6PDDtkgPkMP4TgRGOSMxmcso9KsS7FlFq3+S5gtr/TBuoouwQiTYs+bpWJCCcvArhNx2tyqgiDdFwJeGmKflZdMqqnndSV9l2vREDHIaMHmlgZEDZIOx7iZWS3jGazOpa9Iy131fiJktwOpNXOjCX5eb99bShjLZ4dsqp/QY+JQ/V6ek1Pq+v2HLoWthKz60EtWT0UUplcFHorFJZBXFvr4kJkVhdJZpw7JoDFFZDGtu5ciIRkDX+fSfCRaaQJPWlM1adaTS6I1H70HbV6iFgppbAbgo8P3H2WXOoWZ+xR0B9rIUQIuzDvJ1SYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ac915b-0e64-4ec6-dafe-08de5dbe44b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:08:11.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfNvPTb/1g9mO3yA3EnojbjVgDWRzb+swG4UUBVJQHrl0mcST/Bt1KmcFn9YuYzdOV14KlUuPtDJtMZGxsQAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270132
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=6978e2fc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=Imt2tuDpn1oFvdueNcEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: zcPj0zP4SY8-6L_lPDvlm2109hnV2G-A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX7aG3eKTrLddV
 x8cuo31/UDRsAaLMfDzhRSNTjssSm1GpUXjOtGzFsAp0F/vQwRb/AXGZafn0XzDhHY9wWzwOLUV
 Isy2P31hzb7q7VXKOxWoTrLH3vvY1lYRMVpVTMMrki8KnJyvr7OQwax+wLb9NQPBn8/mI3C8ssm
 oiK2WNOqXQncckLamBTQat2fBwKmDOi7yogkvltaqdlmi7CgRLvbciJY1pdy4se3Wn0eZMDT5fJ
 h4wrRCAwnyA9igYvyUmt8Tz6GjhVf6xStwkOi4tx+rChPhv401LvdWxjy4PP9wnggh7aZsnvnu4
 uOGnAYr9vEOjaab9tcUuJT6k9OlVhGGnl8EUKPfNBilIP2LDXub98ga7cgRf952oHZk+Ua+7k/w
 54w7B+PwgKqvUaDoNhOSlJVUrslsRn6Lb/ML9Fbs1tEFw0RbF/67pR+slwnvYbqaQE4LxlLqp9o
 9fxAhU5C2zlcPlzvIbA==
X-Proofpoint-GUID: zcPj0zP4SY8-6L_lPDvlm2109hnV2G-A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211856-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 123A497856
X-Rspamd-Action: no action

* Vlastimil Babka <vbabka@suse.cz> [260123 01:53]:
> After we submit the rcu_free sheaves to call_rcu() we need to make sure
> the rcu callbacks complete. kvfree_rcu_barrier() does that via
> flush_all_rcu_sheaves() but kvfree_rcu_barrier_on_cache() doesn't. Fix
> that.
> 
> This currently causes no issues because the caches with sheaves we have
> are never destroyed. The problem flagged by kernel test robot was
> reported for a patch that enables sheaves for (almost) all caches, and
> occurred only with CONFIG_KASAN. Harry Yoo found the root cause [1]:
> 
>   It turns out the object freed by sheaf_flush_unused() was in KASAN
>   percpu quarantine list (confirmed by dumping the list) by the time
>   __kmem_cache_shutdown() returns an error.
> 
>   Quarantined objects are supposed to be flushed by kasan_cache_shutdown(),
>   but things go wrong if the rcu callback (rcu_free_sheaf_nobarn()) is
>   processed after kasan_cache_shutdown() finishes.
> 
>   That's why rcu_barrier() in __kmem_cache_shutdown() didn't help,
>   because it's called after kasan_cache_shutdown().
> 
>   Calling rcu_barrier() in kvfree_rcu_barrier_on_cache() guarantees
>   that it'll be added to the quarantine list before kasan_cache_shutdown()
>   is called. So it's a valid fix!
> 
> [1] https://lore.kernel.org/all/aWd6f3jERlrB5yeF@hyeyoo/
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202601121442.c530bed3-lkp@intel.com
> Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
> Cc: stable@vger.kernel.org
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Tested-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/slab_common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index eed7ea556cb1..ee994ec7f251 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2133,8 +2133,11 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>   */
>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  {
> -	if (s->cpu_sheaves)
> +	if (s->cpu_sheaves) {
>  		flush_rcu_sheaves_on_cache(s);
> +		rcu_barrier();
> +	}
> +
>  	/*
>  	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
>  	 * on a specific slab cache.
> 
> -- 
> 2.52.0
> 
> 

