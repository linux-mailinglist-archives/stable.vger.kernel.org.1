Return-Path: <stable+bounces-194623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC09C5320F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D314F97CB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E07345741;
	Wed, 12 Nov 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YyfIxq0i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KqtoDQnZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34E34572F;
	Wed, 12 Nov 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960022; cv=fail; b=A7Sx/gnLNzrAC5tuZPRmXsdlRCQcogrCeZt2NIg4VnIf2dd5S98H50IFDIlTQjgkhA9hhXAKnZqUe3h6xtCY9FFfnYgYkO9mUrOxmy3VOxZSFev+vhEqnVuizESYL+4wwd9zTos5RRuVxN+n1alSrWwBnxLj2Us0Gpgv8ehvexc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960022; c=relaxed/simple;
	bh=i69LvT//mh1JHZPtz6/7ZwggAkCpIfpDdmAzg8EoGH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rFWza0HEyeg02F5MVq7l94Ta6SMDnP/uBtRwcP2wjOLqI9spIyH6QiiBMESzcwT3GZ54EgqgWrApk210zvtOkePcP6bQKPauB8dTmR7nbOnlEQWEVXSOlFOl7x9jZL8VNL5UIlgMSzUXn79WdlAF3IkyRer+Ktyuwpcsr9bhG4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YyfIxq0i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KqtoDQnZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEuG8u023548;
	Wed, 12 Nov 2025 15:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5CEvDQeBz8lmpCHaQX
	v571TnFqb5IK8ONY61kiv4J2M=; b=YyfIxq0ilEPuFj3z6Pbz2xgMjWnD5LvLSg
	qysDvMKOAYmuZyRo9b/0y5rMUSdbqKRa+aGDzTfwgZlDnUeeZHl0m1WoN4uZCvpc
	5h8YNOsmLskLOYdrod9vJCmdkUPM5eOGW44EM0BvyqaIZMhO8G1LshQyT1wOccgF
	rZf64sd8nv0zrAG14zTp+NQr6ZEC3BVy23nxBTCKn01vev5CNXvr58HwhQvgPviQ
	jt/hedaqUNdxzcczvc9JxY/Uk35xeYPES4tpNiSb6MozH8xrnz0aq3qikVk5+lEo
	1IcF1gyR9eT6mLSDPlrAy4rOXZX4qabj+0M/zCXuJcsV/G2DlecA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4actyag8wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:06:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3Da009926;
	Wed, 12 Nov 2025 15:06:43 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabbjvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIHLHn+aCmFbPmS/L5+USZGZKwUfkxSe+ld3Y2hpSwxbOwK/YczNh6s9kzA4KWzkjwJzZTKuYaDoAwstSXPKdKYdvpAa6gCsQ/5AB2bw9Ts9YTKbUEkquyp17RBPNpE+2lNg9kKqC95D9dwq3wNE09LgPfdfDKGO9nfT5cgd28f6tmu0Nfgv1JdczV1HnfvkpjcSPO4PUvMh6R2DV8z6dxtirZ9xe8vSebqUclwa6saeZKmyUrKGTPHFtLMoXdnC+3S4BW4qR7Dnns1Ii5wZHwRt4dMbMrBb7eCv6ygLDSqudvmIIQKK5klUwvzqyyqz5JolT0Y/OEyAbeRPUs9sGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CEvDQeBz8lmpCHaQXv571TnFqb5IK8ONY61kiv4J2M=;
 b=nNYq8KSlieWJV7BZDcj8zWoL/zpD0QrdVNklni1uTYILT5qnpr8prTjEg//9kAtKTnMroIpDC15yJWWlOjd3LV2zFsC5EHJVqbxZBhIT1XiIkrBB+1IVzhApBxkDO/txDMPTgmUf2jf8B6BlZwSMnO1qwF+mbMLiWJUH5ls7qxth2DInj+y/3JWg1YvS9imBxWKbjB96DSVpcyTRD+FbG1sCoFg1JyRTcSm8F+9WYjiizoKlghNl7Nb4S3jN3cKQfPGqFy3RGFCNCLMVRDQn6AJvPx5+IPvwbnJFBgiT0iMJlTLMt4146hQ3hdPsZ7xNToBo2Pjn+vyZQ+cyUN2J7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CEvDQeBz8lmpCHaQXv571TnFqb5IK8ONY61kiv4J2M=;
 b=KqtoDQnZwXwTOK3xwNW2ep9ibb6fZAZ4MFX5g2Q+qfteaMd+F1Cc5q6oI24/DTyWVR7h09vSoXL0Kd1UFXnEuSvAzUqSBS1nhfIpE8l0ToTWrHzWnLmBPejT6iomxYXWDwzvNKZbTsCDHMzLg3FbzEYpeC+dsiN6g9IVFW8s24o=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:06:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:06:40 +0000
Date: Wed, 12 Nov 2025 15:06:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO6P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e875c9-030b-4230-e326-08de21fd15b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4F5hNo9kLKjHVMp2TdR3oNDUGGW6zwn7nk1IcD53c+JXs0JTO4o2A/yqdez?=
 =?us-ascii?Q?c7pu91Yiey53yieI5dKPfHCq5Jep/GOEh5vGtSqt7rh5qBbWJcxxiPP27frz?=
 =?us-ascii?Q?WonDZUsny60O/t7e2bIMU9lu/GmaLLtdDvokjBEDgAcRHVdSXgfAqYe/N59Z?=
 =?us-ascii?Q?MV2QormZxRpBZLRmFszGdqfPBcswp7jGrKwO1pm6m0mSuphwmO2+jD+d+6OQ?=
 =?us-ascii?Q?Y8kvoFB+sKl/I16xPqjMhEmLYTMbvgBjP4v2O3f2ABniFcJpHksT1Yjutm21?=
 =?us-ascii?Q?QP99WfiW0lpz5/dyEfM/9FswbmFhd4gvjGYEybrkcw3ClwUKZHrb4nOQiOs3?=
 =?us-ascii?Q?51ZBMFyVYgFJK4XIEtQ9Puky9wCblhb7tb/APl1KIfEbYYjdWbDTToUBUWKy?=
 =?us-ascii?Q?cD8KskeZw/qNWRSVAS3T3u+IsKtxvluN+FPKq/75wA4ocZTCgNY1+oAdOExw?=
 =?us-ascii?Q?mpHzVVo8KVMJK4CASoQaOCMOeli4lnzgMkSaK9huv+rJ6YXbyya9Sh28Fw1H?=
 =?us-ascii?Q?X5BPUV4gMBjQ4kE98i66J5nL1LEdp68vLPxwgtlo7W+Kyo33DorgqNcWwOGS?=
 =?us-ascii?Q?KNcJOvI1aeWRypnnx/CjrNUSZNaAyhrA4BB3aDaPq6TJrNlQEk5ksMrDIoKl?=
 =?us-ascii?Q?fHJbssClMOxfq7gFURe/sP0gX1NPMYu/EnLwXXIXWJ5TbbACnQErugOmyXOj?=
 =?us-ascii?Q?BA1IGS9sLgQmPR2bExi8XfK3Buds38ONCvrvlF0eeFgQPo0tKD2Zp3d1jP81?=
 =?us-ascii?Q?/MB5Q/rh8j1+1pL+p+7mujiUZH8RmtkCOmd/kD6sL1AcYEEfPCWw54Rb+ye1?=
 =?us-ascii?Q?hMyeJ535mkPmtaACs/SOlVEpQrCdNFm5KmEq9lMDFHf1rHviHoK7Yps8LpwM?=
 =?us-ascii?Q?pTl3bH1UHiXSRM4Tzo/yO2QiprUeEP2a67//nAuVZLVQjLctyZVQwGE9Wqi5?=
 =?us-ascii?Q?4Iwjy3NAolYpDW5iJK4TdO81mY5dnlBbDs6d8VhrLxXsnaKZVUk5XbvEPqvq?=
 =?us-ascii?Q?PET6IuOwf6ZW3EhA+G9E0M1Jd6NKMXQxfodJP21yiNujVsMamcZk9PbRRz3Q?=
 =?us-ascii?Q?zaM44/4oySlLld535zGNfnrtYHG6CHaDNujAHkSYa9d9Z5A5MESCE9/vhqwL?=
 =?us-ascii?Q?hCx4T2BI2G7xLU1jo/ooCQ9N0Oqw4VZP9B/pJC0fjXYT8rJP0MxWx1T7GmP6?=
 =?us-ascii?Q?xHxZNjzvV0qH916u9H0LpnG4xgOyFAenngNoWajZq4NZc3eHtlH4T1TDPGJ4?=
 =?us-ascii?Q?BqJ9AD+gyWO0MjQqY7Pw/beuRpe1zH8xAYD9HohxYnVEnTxWyhgAI8uptOF3?=
 =?us-ascii?Q?Y2i1b1RlXGd8Il635NN+L4YbT6Ewqj6D5I7jMh78GND6m/usezckqYTskA9c?=
 =?us-ascii?Q?H6CxtGuZF17y1JOB3YNfuiYGh3hWnyGvD/dAHrNYWGhJw89nCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgEgYlZZpTAkKUlH/UXIbHrEqgxp9ENFUMsWL0vunI394okP7+uvdcCe6q0B?=
 =?us-ascii?Q?8uzjXx7wGAAydBoTqkHqEpEuJJ81thsk/hWKKwYfELHGc2h15waAY+6TUl3D?=
 =?us-ascii?Q?IemAa/rHQXOXZHuDNg6NXC4kxGbG0U577FsrEW3mZn8SEvdKFybqSRVAk9SJ?=
 =?us-ascii?Q?Nchly516o35Xdz1Rf90Xw4AOcAnQSw5nLZHmlbBnVbxfJu35Vr3PKuOY1USY?=
 =?us-ascii?Q?64BjIww/v9tZFiZHKDPKv0KNuP7v9aRbioaGnaGXTqlkWD1DBhkd9i7au1Iy?=
 =?us-ascii?Q?cHEIaPTkNT808akhCP4ByXsC88FeDTFhaYarQw6UTErmmV1zcDpzGBNev+Wf?=
 =?us-ascii?Q?8Ie+MblHteYy8FAK2jPhZRLXDmZyJnj5J0kHPCmH1gcCsH/lTsz2g0hepOSR?=
 =?us-ascii?Q?YjIwnpyCxIMt1hfq0Mit5ep3BFt4cwt4QE9c5qwq8GKb4exLjKGpgiZZjp4v?=
 =?us-ascii?Q?I+mUyeaIWNjGGPIfwHmoPR5T1AzEYzB99+kUt3NAdnb6xKmxk7rLhPjCk8i0?=
 =?us-ascii?Q?nHmOYWIVAsFfGUQTYSaLH82yTWJjZKa8oHe0B+qOZqj2ktYrBb/aaCMEr8fP?=
 =?us-ascii?Q?Z1QPCWBGVtSUA9mqcoYYw9yiEdC3Xdjxfuw8kbzvKhroK523mZyAdQzcd/p4?=
 =?us-ascii?Q?nNZSPlrP12jYIw5b8lbdTIjI27wzcKG0CYCf3UZTHIyStyKbjTjOSzwc9y/N?=
 =?us-ascii?Q?GlLDYsjnGDJxDIVop6g5CgsqtUC8xSemnqAN/2RyS7djNSNd7JEdhKRx684W?=
 =?us-ascii?Q?IeZv+t3jKVYyxyUrbIYEdaPOibZ4S6AbaJkuFx/MhDHi5xu42bulqhBADRhQ?=
 =?us-ascii?Q?CfxoAf0dBM9LT9txFkNBSov27Y1szHoFxQbVMuQ69TCBIV4FwBMgdZQImf6A?=
 =?us-ascii?Q?F+QFaDiPHTqsoXBeDbV8sXzr3KWlUolE6FZgIDq2rWRmpjOcWanmKNGTsSej?=
 =?us-ascii?Q?wjvxTmzI7GHIvcLG1TJvsgX2y1TNtD6W2UEJjUBrQEZViqulgwKv9WvG2tWY?=
 =?us-ascii?Q?wxAVsgLeCU/bmHAUTr8qG0EgNbj/f4f5P8UfC2unYc7A/hoATvtphPCoWhO2?=
 =?us-ascii?Q?/PlRi/4rTMuYqFhuBPe26zg0JWWLR0ST8wGIYVx3qXHQUGk5smbwxm63zNJE?=
 =?us-ascii?Q?rlJQKD8pNyJFofrOi5lD5GLO/YdXiEV9ViMgwjcH9QxxNVE4RoIftw07K1pe?=
 =?us-ascii?Q?LdzXT2mv6Vgsanymw6ApLJSBOcvagjT7m2AUesYNueIOdtctziQCPbVpBjWG?=
 =?us-ascii?Q?c1EthbyUvYTFzjRsbR5A0fEOMIts4Zq7V4kgbk0jd2KqcspzOFjN8sVMgtx+?=
 =?us-ascii?Q?sAlfomMVS1tQD3iR5hr2JIvEPD/D974iXTeKOp+Nr+xdFsQ3NjwMvRMjpVGh?=
 =?us-ascii?Q?9nMi+zVf2xg/apK5fvNlH6wi0MCRtrNghBdfWusQkjj97tm5YzY2zIy45SlO?=
 =?us-ascii?Q?BsWGhrXNTLOTgyP6nGJz2kYaj+6Z4lo/Iv+3mCp2A9Y9/cL1n/QFCB2ZLas+?=
 =?us-ascii?Q?Q6QTyIECYVsF8aXPN1e4TGlu9x2NsJ3S74CBaKH1NXPoc8+oWgxs4ZzO0Up4?=
 =?us-ascii?Q?kaUxF1cmOXCI12xGk5c03rZUA1dm16FSHddSPFjr5lqfXiAvKn8d747z7w6O?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	duvW2txqMZAdP3WcALa4fQdxFMVZi7rEVvvfAHsPW8vRf4UfGVMYOkgfyl6ymv3iJvAh9eN3Buc/oqbHPxFtbukD7hUtvE7sNfKOGdfHobksAJ2OgsjsHTrF6/Mk8dEPWu6ji8hB6xyajmo3kr19RIRsN5uvuniKtlCofOlOlpqI1Asn/wVNJca5zb9GWoBc3QXHPNe0VXO2nC8LD8PcLFbVF5EL4JDkvEuJ0bB7ixt4SvkpTYwu2t+rRagVzY2GKTjU5MnxIMsioRRUzXmchGPV48eCY82AwswtdoWH8zU9ylmH0HO9A/WhZJMt1O7d77eXBju4miAN6f4DVxQyELQuxK0HyRnBC+5tgCx0XGGUIFwQnPz7vUXlB2r35k/XW5anmqHzZJq2Zc6a3s3XcywOCqcUibDvG7ynXlokp4Yl9SspRhc3FuWiwzCmRNKEwtKeE1+7VyNNKTCWfAvFYgXgQpIgEHLw8BAH+LQUPGH+D4HsU9bqrIszT3pPMRyMjOEGNDPuqWfQUUVanT82JTrC8tf0b2DG6XQtn9sw/U07u76d6p00OwQsxDlOTM+Ckdhx/kJKD9RX//9sVkKSJJ6JARpFlYBb2FunVIn+PYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e875c9-030b-4230-e326-08de21fd15b7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:06:40.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT+Ru1UueDdRWyuxdFd51PG5l/Dpj4hvKhuYQJRk+Rd3dxwMR8vhskpG1cdVDcPOx1k/jb+/qq1zIOYaop4KZnDl6tKC3HYHAkF+7TdvtWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120122
X-Authority-Analysis: v=2.4 cv=Y+r1cxeN c=1 sm=1 tr=0 ts=6914a284 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8
 a=yPCof4ZbAAAA:8 a=jlbU7W0MT8901EHh5ugA:9 a=CjuIK1q_8ugA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwNyBTYWx0ZWRfX7a0Cz+euVJb1
 CvW+e4o442s2Zd4KrdJMoWy2vkS/u3i5gQRapPFNzHv80TtPkRMBncEHLNwkYp6sMI17t5jUj7V
 IrAPw0QFdtriwN3PKs9c1AWp6qWb339iB8eP4GzwNsG8p5q/hOBBUscskyfiFTnJAejlGwUxF3+
 fE+n1wwZ800maBvss1Mox2RYAGWKCATE3YyF1k66lE38TyFyNKQZuxfQClwmJZBCU7kj7jqclj9
 Bv76sbJGJf6B9E5EsFFOM0sQ6gidkS9U1sm0K2ByMk3l6PAlYRpI07WWoeGiYg5srCjb1GMCHpg
 crr2KZ4s2Zr+GcUWRoEcZq11I6dzIUEDfMoTlSAA7VYDtLpSq5pl3C5t/ak2SxU2ZQZgLWoX+S6
 +1sR7yIWhqBLZNPDdSpMM98c3pUPzA==
X-Proofpoint-ORIG-GUID: n5YoLIaLTDAw3b_XqYDFf6Lcj15onXZq
X-Proofpoint-GUID: n5YoLIaLTDAw3b_XqYDFf6Lcj15onXZq

+cc Paul for hare-brained idea

On Tue, Nov 11, 2025 at 04:56:05PM -0500, Liam R. Howlett wrote:
> The retry in lock_vma_under_rcu() drops the rcu read lock before
> reacquiring the lock and trying again.  This may cause a use-after-free
> if the maple node the maple state was using was freed.
>
> The maple state is protected by the rcu read lock.  When the lock is
> dropped, the state cannot be reused as it tracks pointers to objects
> that may be freed during the time where the lock was not held.
>
> Any time the rcu read lock is dropped, the maple state must be
> invalidated.  Resetting the address and state to MA_START is the safest
> course of action, which will result in the next operation starting from
> the top of the tree.

Since we all missed it I do wonder if we need some super clear comment
saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
by doing 'blah'.

I think one source of confusion for me with maple tree operations is - what
to do if we are in a position where some kind of reset is needed?

So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
to me that we ought to set to the address.

I guess a mas_reset() would keep mas->index, last where they where which
also wouldn't be right would it?

In which case a mas_reset() is _also_ not a valid operation if invoked
after dropping/reacquiring the RCU lock right?

>
> Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
> lock on failure"), the rcu read lock was dropped and NULL was returned,
> so the retry would not have happened.  However, now that the read lock
> is dropped regardless of the return, we may use a freed maple tree node
> cached in the maple state on retry.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on failure")
> Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=131f9eb2b5807573275c
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

The reasoning seems sensible & LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


> ---
>  mm/mmap_lock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 39f341caf32c0..f2532af6208c0 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  		if (PTR_ERR(vma) == -EAGAIN) {
>  			count_vm_vma_lock_event(VMA_LOCK_MISS);
>  			/* The area was replaced with another one */
> +			mas_set(&mas, address);

I wonder if we could detect that the RCU lock was released (+ reacquired) in
mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?

Not sure if that's feasible, maybe Paul can comment? :)

I think Vlastimil made a similar kind of comment possibly off-list.

Would there be much overhead if we just did this:

retry:
	rcu_read_lock();
	mas_set(&mas, address);
	vma = mas_walk(&mas);

The retry path will be super rare, and I think the compiler should be smart
enough to not assign index, last twice and this would protect us.

Then we could have some function like:

mas_walk_from(&mas, address);

That did this.

Or, since we _literally_ only use mas for this one walk, have a simple
function like:

	/**
	 * ...
	 * Performs a single walk of a maple tree to the specified address,
	 * returning a pointer to an entry if found, or NULL if not.
	 * ...
	 */
	static void *mt_walk(struct maple_tree *mt, unsigned long address)
	{
		MA_STATE(mas, mt, address, adderss);

		lockdep_assert_in_rcu_read_lock();
		return mas_walk(&mas);
	}

That literally just does the walk as a one-off?

>  			goto retry;
>  		}
>
> --
> 2.47.2
>

Cheers, Lorenzo

