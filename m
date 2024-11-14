Return-Path: <stable+bounces-93044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432959C9164
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01653282EEE
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA018D647;
	Thu, 14 Nov 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kg7U/sjQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ouorLzVQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EBA32
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607676; cv=fail; b=nYXVaUOjmdzhSMyV7J3UVr9dE+YqcKjW7SBHQKmvUk7bkf4Xf+FBw6Q4IiKZi0PwpUgypfFmqKsgNJwak8mAfaQs/02VeDdlOwKu55EIkzhCr3upXx2hu+ji9zLm8qzZ4FkdSV2WWxTxCU/h57ZKdDdXV5CCkTNmwe5nrdbYSOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607676; c=relaxed/simple;
	bh=MS23/QRqlhxUt5HKpp3JQDW3t62C55zzvvyQEZOqHN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/obEhs3bIcC2C56XooXcB9u8D1kwONZywnezyChJRUmWVNqLQCBPFz/fsZmM+yA11rpUTc5BWx/jLmSA2CBmiVNJNe8t/XSSKvuU0RfZS9KepwdhOkP5JrqVUztIN/11a+xOXA5tdTku9VpozwM7V3BTepoYAmcEFLlAJpq4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kg7U/sjQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ouorLzVQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED3uCM008329;
	Thu, 14 Nov 2024 18:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PxHJyceR2T2O/7AWn5O4nX+rX/MTrrboLOzrVOMQ/Kg=; b=
	kg7U/sjQp+ptGQpVBOx8MYCP3mDFSKeirMPJGUhPyFFPMcaTzDL2P8GhF/JB1wp1
	ygQXHu1DpCYgKf0MjbtInT2H5zrwG9249EMnRr3iimpU/DXzY08s0aMTc8/AMN33
	3d7II09j72LQd7lOlEbppMGuWviqv/4p54axKDodxgALAwdeP5pkylrEVUSolUHe
	TZGWoqutn+4+PBda5O0JMKDL/l5b4aPYP90y6xnniEgi6/8J1hQCa1PMnt/n1YWH
	mPXB568d/CTc9cwX7M0E/NrMMSXUAwUkq826ntXb4jT5XBrxlROxDiofECG7O08H
	C2SFBOrzkiD663teP3e3PA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51v2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHuiaF025947;
	Thu, 14 Nov 2024 18:07:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b6kwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJjZ6SRrLVpTFpvphORAjAg7Z6VBu2BbFyIldWXWvIfe3OefpV86v+En59PIZjYKqafAVFCYh6XP+z8owMVxWWE2HceSw54pVh99eAdc3oyqbhrUndHLPYexGP4TdHGL9m5Ad4X7+U7iVizZGdDfi9pd6qhoiQyCJNuBDPNDh2l55gJvQ2bGJb7/K1QosiRxOmHtpxcKoCVnpz2oS9gNB8tGuSmlHlVz5CqRZ2e1R7iVToJacGTQpwOffr9mNH1JKXqd1l7bFi+jJchc8OXlJklMiNc4vtnPtTWcjCPGdl9JGYhAcyNbYR30q2G+dse0yu5rN4Bs/ehJr8PSLZiBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxHJyceR2T2O/7AWn5O4nX+rX/MTrrboLOzrVOMQ/Kg=;
 b=Nphsef9XOp8H502vxRWfeTdXYcvqqdZxlrvQLTX22XcR17kKpGZyJoXYhMr7tRkmZ0eLhJVjfLMUT5/SZzxnXVwjcB59GAEvmi24SMLRsPswZ7TxTyYY8orHeEj8hSK3GTTucPefahvtQxetEquJ3o7/Oxcze7IJiX2zTNHyTi/smtf6/ACzKeGI36fGlrjZt/bVCc1l+FXu++oLdHF+N+K86hwCE0V8Zqx60LfRlbAfl9Z0AQl3StaJ19xiMifwzVDXIAdJ8gPISb4sBOqhVZtPfFiNKLPKdeoLSE61gOg2QBaWJHcyTjM4j4TU4FrxkQJsrwTH8gyF5c3jiCIMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxHJyceR2T2O/7AWn5O4nX+rX/MTrrboLOzrVOMQ/Kg=;
 b=ouorLzVQx0lsJRvyM16TIIBxYAJmcD4rs7D9gPUPzMk9pt4M5pCPp8jtpwJDUlIWx9h7HZJNAV1bzyRoX0+bGA8RMTPxqK6i5JytvTy4/UmNNf3jjhihmK+XV0V7IFtxA10996S4yKOPzWOZcx6RHyyiTHuJvYS/S9CzcyaeAcw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 18:07:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:07:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Thu, 14 Nov 2024 18:07:24 +0000
Message-ID: <20241114180724.807175-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111143-gigahertz-handrail-961b@gregkh>
References: <2024111143-gigahertz-handrail-961b@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0255.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::27) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f87e25-fefb-4109-378c-08dd04d73397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gdIZkvvou/sb0TV7EliwkNcgY9eRVEjS9+8/RlPuAIZZhLbU+xNsvndUU1zV?=
 =?us-ascii?Q?9MGTxo5hcaBUETQ5BG9JYaESwOkWKdPVeZ2GrCmUZEDvDb4cRhOlJuwvvpHp?=
 =?us-ascii?Q?rj5lAe7otBFLUXTfEenz14XaLyb9oFQwB/0J6FU49HOEHlw6X6qu57HqOrxB?=
 =?us-ascii?Q?OMWau/ZlAgcU1FxXwqFOZckCc6UxYxwkmPPDrHFvcxLTUFV9CtWqC+bjYZQb?=
 =?us-ascii?Q?W3LTj9h2OeNrIudpMhS1cpcvKcBRfSsgw13U/sCJ3rEauSsDuEWevxa1jk57?=
 =?us-ascii?Q?n+k6Yo6vZue75ry5azABj36oyisi/rVzXvdws7WX7zAMHO4wnuFIqD9TygfJ?=
 =?us-ascii?Q?usn8g/nMof7jCnd3sKqIBoFDw8zWBDZg6S/bolQVNg8OP8yEO3/G9JrwtTG4?=
 =?us-ascii?Q?B2PGyT+SKIN5wwDn5EtaqyCZQDNHh3w0A6iKJgkK6GKQF0yURzGPryr4uqW2?=
 =?us-ascii?Q?Zp/6X6AVowb6ie9DniXj0upE76fHNrswp8FH5zKgzWcCgzkp0fcHgUnYYN+3?=
 =?us-ascii?Q?O1gcsnvshf5cyUhwsqdIPZK7LBwMIw1nHZJqEQu59J1qE9rqFs5r8/FtI3HV?=
 =?us-ascii?Q?dBtLRISheBaQkoqEICWpNUZXV+v3zMHl5xrVezFzPTelFFT+dg+ZQ56YQDXG?=
 =?us-ascii?Q?LHP7r74mu3RHtB1O6MtW7VMOUb/Z2YPL+SRqqwUJZIlt5aapnykyKexKVfyO?=
 =?us-ascii?Q?8XiNXrXixNakm67nyxzUnhQKoaqhP697vEe8lnH7livrDsH8j/a4NgKrBsnN?=
 =?us-ascii?Q?PcQBD6HZIfDjCRccjNKGtyicOTJiSs29taBiVeCtVwzhBu2dt388VTGo4/tx?=
 =?us-ascii?Q?qUFPfshgo7ExskKxmNT6XhAuQEuPgw+9pwY33TSOZUfBLjVXn4jS+yXCC3XN?=
 =?us-ascii?Q?JbGLR4cmj2VhuAw2k3IMT93J7oPW+qL8SEfo+ORr8JcoACPuTAIdiLWaNBOm?=
 =?us-ascii?Q?fILlBtShXW+M674ediX2xXE3Fo+Wue9MWHfYjWYzCYba+9OcIWW+G+aq2dW5?=
 =?us-ascii?Q?Y5PtT7GCNiSSrcEQ0MST7Gyj+UEqYm8Idzrxf9gK5bNtnfrkgYjdQm+UM5cb?=
 =?us-ascii?Q?BQYzCa4E6HuXzlM2lJmjOiqrwDvCm54kQt38kNMCNKJZCH2WYlJAU8eK7kta?=
 =?us-ascii?Q?AiiDWAO/EM1aH7KvZBgyasE2X/yUQIUd1jT+B6l8A50SIBnOHt+HHuByM+UL?=
 =?us-ascii?Q?kiUn7jrJ3aGcK9IVjgE41Y3H2Ux7w+Eokj/UCQnnNV0WJ1XQ1LiOURYun+fw?=
 =?us-ascii?Q?fmbC8gg58kut+2veFu4N68BVlIkg6zzH0+PU/2YK/j7dak7pxiCn1zSrFCzB?=
 =?us-ascii?Q?bqbQROO8EG63fBhAmdCn5tMd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hHqQaXu3Ih3CQidIPvSKv5P7WHwjAxSWdONdLrgRSTYQJ+iG8Z3BJSUUUGC?=
 =?us-ascii?Q?2npJUewbBMUkk80cP06C9yKKx/8o5RDJnxH2sxX96OaydbeBXpNxHY94HNmz?=
 =?us-ascii?Q?pPncOgl92BwfY8mJMPCgenkZNA/zPGLpsAjUCyTJybRvARVF+HM43HVAAdOL?=
 =?us-ascii?Q?IpCQ93pvzI2LIjvQBx2EZvOrTNDLGk2njMbAHTW0owwLbTAJHtEJGE9/T0ws?=
 =?us-ascii?Q?omfeiz+Al7iv3XyFsu2xaDyYh2uGmUF/pvhEielWFoKrYucdhcHvPehW2Jxc?=
 =?us-ascii?Q?Vw6GcohwqKmAjkOCjb21zANKZLl9HcLBWjlTLUt2NQUajXCs4X6N9U5aOILs?=
 =?us-ascii?Q?K8NKwLObTOJosPpGxIZGSP+lQHk2x0Gqlb5QAP0jidpZfcQXME5hiV5Yl7Co?=
 =?us-ascii?Q?+AT2y4VfcRSPGUUhFm6nd0/Ef35MezxvxvdDK2uTQR42nSDzlWRMYfcu+pML?=
 =?us-ascii?Q?hGDnumOlIN72czq5yHZr3WQc/Nvhd2agKke76d5spuFp3Wmb7T0d9nDKLJsr?=
 =?us-ascii?Q?3rfDClGn9Q4Xd3H5joGjLm6GWn9oFJhmXHj8h0R4x6KLr43P0dBeQwknlpmR?=
 =?us-ascii?Q?6BoAyKV+I92bBxdT4U87ndBOjSRS0A2nQioukdtE9Rg/orWZb3PcqW+8hMbO?=
 =?us-ascii?Q?KY4GFGdnkM7iPZIf43ZqfKNUnv+cLavTS97DfGF/UeAnPfMwKW3iHNM5bIFb?=
 =?us-ascii?Q?NUR4j4Dce3SmcJdVLsGBUyi7ksey6R/eJPrgRp+yfltqW2KHJFok4V7Q1ni2?=
 =?us-ascii?Q?L0kMP29Ke/gpTofhoCmuYaHMHG/eIduGQ1VslN+YGkbAyVhmI+1UIAFLS0Ur?=
 =?us-ascii?Q?pcnlE+M44IGEHH03Q4GJeGDD4z4/crLSkUQ25SmXBR0rDEWdeKzJFsRPTjgO?=
 =?us-ascii?Q?9iJg2Y9KDdcWqwGzgG2FBi9UFUyE9lUNXvxD2Jq6NZY+r62QzbU3Ig7NnNEs?=
 =?us-ascii?Q?cGd9XUr3EfpzY65wqjb6MtcPzI9ttydjTmJi9SDU++pbP3if+GSNA+d2142r?=
 =?us-ascii?Q?VV+WrQQdXM/BcfJHMpmovK4dJRe4cH5XJqH29z4soacqnkdCPmPZViKAiUYr?=
 =?us-ascii?Q?8YnzUe7BvLsDYfrgKSaYe43qPtF/M8If2UGH9svYE+p28PxKWLVx+/aRX0Qm?=
 =?us-ascii?Q?EFGauYZEb91FLJ7UgD/FE8+J7dlwREQH8nssTAq/C9vlVVg8KBCC1/9hxlRY?=
 =?us-ascii?Q?neS39youX8KmWyhqL2ntFQ/1DoGcKymPntU/c9d1HZvsXFTMqWl6ePzRRAEL?=
 =?us-ascii?Q?yZLJXf4JYG9mfGfoqLfVFYLtQf1FN6UWj7gA2f+jT2HYOWW5emgz9RH97eNy?=
 =?us-ascii?Q?ZKk8uFOJCaMXog4/a+1Al5VLvg0sfb1PyKzHbSSieAh980wRrYZqlrTf5C4Q?=
 =?us-ascii?Q?4f+sfkZuV9hrXdY98iMnmllBWnqNUjs2GaSE06HM6hcthgJSAvKZWHRLag5o?=
 =?us-ascii?Q?3Kod/fIlXM7f7unCanTBxwpT4dUIwCs0b67LJ1zcQ2p259Sf65Scif5v/8WG?=
 =?us-ascii?Q?EH24pexeWo7bpAP//TKYh/SAI0YmmPpE/l0Gf0RQdrGyQFNZUVURgf/+GbFT?=
 =?us-ascii?Q?6poRtgc4D/8bwQc2mvLDIvFiSk2RZmyglYI7Zqj15YqzeyTW6eKJdYrlgN4F?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IYhpg1AVnDd6DAF+3dNEjRQRFVhtWvpzT3lg1EUceiSt89yczEZSEcAw9JXUK3T4DGe3/Q0Qf9aFYwjsuyZWn6kc8Vh41OQ8lVt4hlF1AK+Mhuo79ioU/aUE5t3KOPuG+syshV91SgPt99mpOjm/xOPcxqg19d5tFccWVhuDU2WRagmF1o45M31pLUh70GNgBE9jt0EsG0MItAg0ZiOUziJQkCIWiNKlBLTXCZ3QQc1CGDHoMvVReIBN2QPayJqTFN7YyqZSkGc2RaZpJwSRoIBNjpAP5rexDaYuzhI00JS3GMSY0W3ZSnGvQ4XXTcPxPufsoHX1F455YzRYv7NQ1+CjxgXD75k98WLrcCMz/sUaY2YxKv/rVJQRGxTP30HSP9XVWqo6DZIgbzlTUYiwdWActKYkI4EMSRFnFrZVtq18zNeHkHPhgC2tfwptS2eTaff/y4u6M00ItCgNS0Z7m1k5QrB4jhr220WiCHG7/hTdhKaCMAbZrNayfZAFoVbFiZzY8QUWVW41O3B1T5Ejbw/8DZT4b53PI+nhJyeJh+SR4bCRfSSh7F4sICeekYPvvQNKCloDlRLoBAV81k9YnuVulbe+ALy7u8HFsw2bR+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f87e25-fefb-4109-378c-08dd04d73397
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:07:28.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBdGbZz0y3lBZIi8k5AnGNBVxS4WjluzTQ71x1as5abwZp8UQBTmBP9fR/osAEYcVfbXV6CBzoB/oQ21dLdYdrucZbbioObvN7F+fUqVwLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140142
X-Proofpoint-ORIG-GUID: JQdX-3Qd8wjywmEYuZ9OiwQSP6KvYrdd
X-Proofpoint-GUID: JQdX-3Qd8wjywmEYuZ9OiwQSP6KvYrdd

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
(cherry picked from commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf)
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 mm/util.c     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a50bc08337d2..85ac9c6a1393 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -52,6 +52,18 @@ struct folio_batch;
 
 void page_writeback_init(void);
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
diff --git a/mm/mmap.c b/mm/mmap.c
index c0f9575493de..bf2f1ca87bef 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2760,7 +2760,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -2775,7 +2775,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_reset(&mas);
 
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 8e8fe491d914..f09e798a4416 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -939,7 +939,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -970,7 +970,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index 94fff247831b..15f1970da665 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1103,6 +1103,24 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


