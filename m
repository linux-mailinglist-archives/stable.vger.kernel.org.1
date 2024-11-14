Return-Path: <stable+bounces-93046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E39C9167
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB96F1F2402F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA018D64D;
	Thu, 14 Nov 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FImUiaz7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cd9C+P0T"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A964AD5B
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607689; cv=fail; b=rw3NmFvHVMKzI41MTLkdBgfeEnjcqwk57FIEBxkLLWhg7Z2p9yd2idQ6UgFIT5TBPjeEQtIFqeMpUQ6pPwOkNv3TyTlCBD08vIc3wKEjtZl2oMvqJ8JwzGW/bDUrLh6bIB5FjtGpHdQXSaGuEu9T2oxF1inRfnfEf5Iu/CgSTHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607689; c=relaxed/simple;
	bh=ZR9Z+pIbZNe3xAvK1N+EFAHTmum1ugQAj2rpyZx6km4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mOuelbi80F4/IYRUudx5rKBZdbQLoFjT2J8I6ta9BH4MobCT93Wt1IFStal8SEJUkBhjU3ctKj6g/8DRw5hSifiFP0WqwvgRYfEJ7dewX8zDIuWK2KmqKjtOI6J6+rpYAQ+ZZAGf0Xj/yqZ4/V8NpiB5yZTqVOnBuXA/yo7aMHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FImUiaz7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cd9C+P0T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECmhNQ001320;
	Thu, 14 Nov 2024 18:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oaEJh1vtFLb4erx1zqTdRtYfkGqbty3M8NhEz/KFjok=; b=
	FImUiaz7QPV/4rc7/JegALY1tX71gHmQ5QL8wCF671MuFuTu1doJ7lCeRxFw9BoQ
	+z1PE12aKLhleIKdULR8OXOmyvkFs9rQM2ZoHhZPA9pgjKp47YxrOdy9GhXCd7b9
	sbfvYFRy6n0uTMrpdNUiY0ZmD7vgTZEwZpdDF9PxWHjoh/XG6DMcKNHbMy8inz/1
	/z17EIKyJzG8NE8rRv1UpIJtlg711++Q4I/R3FC/bpojbh8ZwIJRQc29MErJKDOk
	ZwfrnKcrsW413WYwFTzQLyEybDCuohxVB+ULq5FwerL13WM8YT1YpKDmPrcs3Usk
	g3CTZ4lN8gu3vqy+JVRIYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4kjaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHnWuA035895;
	Thu, 14 Nov 2024 18:07:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b6228-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB3AQoiDhXVbNdS0gOST3zNH9XyfN6iOZL1E8ognaUTWb6dGnZJH5P2+SvBvmRFsHrmyCCFZwzGFr/yXAM9t4pRZ5LbmcmhKOxJhT0s1Gy/hdHYGVz2xJdFJpgYkAl5pH4x718hEaJD9LvC6q+vDAqWmWh+Bc2ii01FH737bIrckUNgajZW8UVxEmC4SZ3+gM09qsdt1x0kLj91MSj3iDCrhf5kmoFOUsVQl+trmJ70KGAw86cf7vQi31t+Fbu1galBc84aS34Ig1p1xvXO2Lt3NtC0gsrEMspFbAPULt1o0QGntUl5ARKieqAm5Z/u986Utz4qUZvn7thkaab8IlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaEJh1vtFLb4erx1zqTdRtYfkGqbty3M8NhEz/KFjok=;
 b=jWIsgTfwbsVdTTbvqe9S0C3YpvzAOFyXLeP14chQumRE6RdbKkgm+oqIuNUQRsE7V3JBphuUUZ2EQk7dwM6P1Hnr6jUGU3LTqhVRpTLAbSCy9cT0aP/qimFmNZs/6aXKpxkEAK/VksJy80NmyCb8apSF9GAZtKwJr+D/Htxro8okkTKEJTNRoYO0dQyy/KYKD/ZCNIW3de/wobQ0gjfUMrBsLDVErR9ne2vMuCY/1XmOklb19hBihBzOKYtIKEaz3mAhCmwwpQkTvphaztNGZcQJC0Jsp2ZMxtWgUBmEPjVeh7ODmKV7c8fLZP1Itp2WInzneLu1VqWqJDEFTwDMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaEJh1vtFLb4erx1zqTdRtYfkGqbty3M8NhEz/KFjok=;
 b=cd9C+P0TVdjMOWZs4BBa9g7QABDFW8ycjYgWbtevPWXhXaRgpDyJ7eQzbyKuzMl6WOPwlxBkYd1PFAjXhAQPzVseq4WxluahfKpli6DgaEqyx4lrYZuTTjZlGulVaoiP/KO/g7EYl3aGUdBMKVcQ0EsnZgwqMniSHEaYNAkioF0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 18:07:45 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:07:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Thu, 14 Nov 2024 18:07:41 +0000
Message-ID: <20241114180741.807213-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111138-moving-borough-7e09@gregkh>
References: <2024111138-moving-borough-7e09@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: fef26708-393f-462d-f6f1-08dd04d73d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eo3n4XTvnOXg0Y76O8Du9FgR4EUF4KmhF+aGfG0oscH/soDGeXeS09ap6PYx?=
 =?us-ascii?Q?zBLi20il9pULs/V4Zkg9a1mglKPMsmJD+FTfSmmXbawb0D6KGGDqBSNt0EZV?=
 =?us-ascii?Q?Fxg3Jzzpt6zbm7Y4pPs1I+iPC4nKC5gSLSFKMCq+abvC1WSDK6xh1rSAfWY9?=
 =?us-ascii?Q?ja9bCBfhHqJw5ltrHVNuz9oU3jt7bJZdnoHDZ8g/Kjw1ge9PR9L/ERp69sbA?=
 =?us-ascii?Q?20VxkAWqqKUW6lPwZj4GTw6gRD/W+ywAvrBMIMTfgCAZSNDXt8B3ZUa83Rez?=
 =?us-ascii?Q?BUGl3g3xto1bU83SpwWds6z1k0ZKcOUuO8fj+AbCPb6BcsUbFg0s8Ma9b41x?=
 =?us-ascii?Q?cFNTT54CrI4qGTkCsZEK+IXyBdE7Qi0ZGkgtxirxB2qeLLyIKWQouHoVfW9s?=
 =?us-ascii?Q?nXzJr0pMmet0Oy3khYao4biZzfhz1o+lZ6Ja4xJDWMk74VZgquPHP66BikZL?=
 =?us-ascii?Q?LKicP7Ueh+a+bhQz/jqGJ4iaUDr7vs4PJKYIObxGPdGa5uGBN1ieCrqxpCFB?=
 =?us-ascii?Q?I7H+Jn8B0V3sYXvY3IDuh3CEEvZBykuQzvuqqwaF6zhgTJJKSsJo1HrST0Gj?=
 =?us-ascii?Q?AfUAfN/s2bd0GLZs8Nf1qLLQcA1hOqX/prh+XRHpb3omBc7VYcOxmUCmhOXf?=
 =?us-ascii?Q?X388ZolUjEPbbuJEh+fYWkF4+9UGtK4qc5FI/PLTk5oO0QqY2VGx1ZJ1D816?=
 =?us-ascii?Q?4+Ryz+f1+6lEndMLqoFz5AfM0kD2miBZvbtty8YbAxNlZ3oTrXJ9W4p9xWSC?=
 =?us-ascii?Q?pdnVkd33NlXKk3yNYJ7DDZupHdTZQ/z3HC4HVWxXL7V7LW0SNIHeLd0wWxvw?=
 =?us-ascii?Q?jhM0AWNcpniTo8ItW+XCnaERZkQIgi/9TfLllDUdF6IojZl/OsqQsOJJRfEY?=
 =?us-ascii?Q?9NABE4A7aLOrZHXZ5FGE7hHHFiUg0DDiGgq+xWdTwchHYkm73ArML1296iF+?=
 =?us-ascii?Q?xqZzrVv9V1GxdwxDoqpd9zxeWihMCNUdvCMj8A/rGfOcEFPNK8EcYYEvhAAg?=
 =?us-ascii?Q?AuVu+jQ6ZcdBALHzHCpL8U6+umJAIcjN+S6GQSs/iGyV69SwsTreghMmqgfO?=
 =?us-ascii?Q?gDTlZPjuUkE2pLKG+skn3s8OG2H3rkffPiSFbFoAHNS/QktFYK5h//3OMR+y?=
 =?us-ascii?Q?SZxMIbpvPLS1m63ka93DDMhjOdto0gomiA4+8eM8XfK38GFiS8jLxCyRpSMQ?=
 =?us-ascii?Q?TjGHqzNVVNo/QtFTpEqcCJawkPfMLV5PzdXtEmDSAjlOu1qYUapRtJOWRyIH?=
 =?us-ascii?Q?h0e3608r7qvIYpOgsSspr8QTPg/eZEFsPmfWQTPy4g1cCaAHjqurZljegJe3?=
 =?us-ascii?Q?pLACu9IH9qMLhbENTQF4bXWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?65150deR78WfHjs3VAwTKbYF2lo2FzMnO7wa9XQlaTk4RylxvadricI2zju5?=
 =?us-ascii?Q?ZT6BqgxEZJzLYEme+1QslY40dJ1heVLTxRuuN/DfD1Cd9hQ8xG0W+K4+psF1?=
 =?us-ascii?Q?7tiDoq1McFAAwOm7z4R4HRG1jsGYwAmCh4Hd0jDqAlhMMN3SwQPg7+GhgBFn?=
 =?us-ascii?Q?jBouSBeVSyU96/jhs5XnEUFK7tMB8kNN5Ln2dQdm67z0zb2CZ1X1DAUr/nYp?=
 =?us-ascii?Q?TIpQhqj8/VjktTmqHscqyJtkdXlervAZDziaSE/EsK6gBSYoFIDy+kTUQLdS?=
 =?us-ascii?Q?XY1fhjrSaGwcqnHKOto3qW74gZhjbWZGAh+z9w52MQ+P1lSY8DaA1yxrc+VG?=
 =?us-ascii?Q?EdJxYzwjyPfvUJkJNRmGk8//s4t2DSbobckOoI8OEfmI/JvRIz5YeKCLkkR/?=
 =?us-ascii?Q?7B1BPRKXHbhFQPQWkuzHaEBYT/aaLmiSQqALSC0+TUQuJlDPxAb0404Jc3UM?=
 =?us-ascii?Q?z6XxlANVAP72hZhoST1TaOHwro+p06nBIpQmGV+NefX5PipG1oIol2VnGAAP?=
 =?us-ascii?Q?tQh9EEwC89rzSqUqxSpcTLGcnDgJ5u5X/xQL7l/RP0e2QQeQao8v6K72W0cK?=
 =?us-ascii?Q?WIsmRlM2bLwMhk2pHeZf6Q8KlAG2/2C1KRHGdk/w7UNiKR5AVMF4iIE4Feua?=
 =?us-ascii?Q?Ca5L+CxAewfDrnAKRcXHaJZZ2SO+gNqrAfzuXA3ymej4sJCasv0uCK3WZooc?=
 =?us-ascii?Q?ethGzD/12iOIHIXqc6G8zdBNfVr+WEGeXoZEsW79sRFRY0Nk+kYF73jEjj0e?=
 =?us-ascii?Q?SuOg31xwS56vRFvaE0RWFS2wrsRooIqt2yuF/k0/pnx5CgJpZtwzOTy3YjSZ?=
 =?us-ascii?Q?FURuXT2b8tmgszCpd+/t8K/QspGNo5cb66kFG7FWgyJuJ6F2PqJzC/zUbRdg?=
 =?us-ascii?Q?exXUYhsHX7Q+hI1faG3xn2JE0gJ3hXynHHk/cYnz9hiXzlDnvrvIWAnpGUwq?=
 =?us-ascii?Q?Efo+Mk7RatJKpcMSHsBQfTXYpUR87HSGx7VPcdek5l3CAC6eTLFPEWBsuluw?=
 =?us-ascii?Q?nd6fPV6ZP4l8pJka/jaYZNU6GKIzCmRXF2TnTe+HL2boFDPf7PIIyQuw5Nmn?=
 =?us-ascii?Q?VMafso+O9e7fFxa+LG/ff+z/Mi+2HtZsfRhuE3/CEJA37mYH/FZ/2pngQc2z?=
 =?us-ascii?Q?PU0baZk1KDpm1ZLlHrmdk8EfM3Phr3qw+eZiUB+X3GT++cYX50UMY1+sX2oj?=
 =?us-ascii?Q?XLRJy39rKNNUomSSDdpdd+5N3XiQTkzidRPx7iQzu7q4zJvgJDexncepK2U0?=
 =?us-ascii?Q?skFXeNHiAWNTXuddFhKxDz4LvxatZRxYNkzTzF7Kp2jjOMX8fAOtErF3mF/d?=
 =?us-ascii?Q?dWsp5Dkg4FvduVTjieBpHTuK0oxe0QS5i44E/XzpLkPQeQjZZ0Bv2UH+cxRz?=
 =?us-ascii?Q?doyQIZ+DsW09kch94IUM0+tOqAjtCUHvyjvjc8pQXGHgGav2NDGITa+ZEzgS?=
 =?us-ascii?Q?mME5ORF63mDZRdsI0nbP5CX7E4IeCERjrjIB0vYZrSMS8lWdxKxYK3T7iO8r?=
 =?us-ascii?Q?yKh8urZwUnu6CEdSKSwqAcy9wed07G0c9VSV32HysPUoH+HbXIWHWrcBtXJc?=
 =?us-ascii?Q?50StFaB+9ZwBuF4gUKHMQbl7WS3hbCejnrHumuHmvwZ+YsANCmGXjZaSutpn?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J3wTrjtX0d5rAhsdJBVCNdZqDWu0innddOFcV87as26+Jny6Qsd+SiysSbgnnGqe404yQ0YbSsW276XAQscUyXGByHTSWr10LqxBNtxj6kmq5O24OFFhEgIz4aBU9b/Qo8/Kx661qQ8bzzblV+EYlkzUeJlRbDeDWAaGrIZn1/k7NiBBbDkoZIuPxuMvH2ClPGVH+j63bvt8efafMnTUaisW0GLkLwmM7ozVI3Xinj+LZJyhVl/usy9ad0p4U0dtjq6yz3kvFt453QU+ufPpf0xGJELOmchod3opCIpuHS8aN90giwlIOV94rZTbrE2iF5ZioU3I9BrPtL2/mRatVqASJstHuKvgbxH1alj3ieA6xmUCd2eXc1UYxMRSC8vsVp5Nsxvw7nYtcGA35wXS2FQI65J7q3Oa/V8OwzWBCCUO+OyCFP7JrqYQcA11yZAXUryUSJViutN2evKdMAMkNI/bal+7fw1KILxVUGAliKghF3J90nYmGTGMXlfOdY1Oiyy8KQ/0K1ORLm8iY9hKGeGy5aYc8efjv1QmhnTE1lH7QorYJTMs0VvfmYAiWREOqQvEfEAj/MxldTRBrUhJz0nVPubSctAAyThyISi+hD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef26708-393f-462d-f6f1-08dd04d73d8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:07:45.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq15Bzizl7mPqNeJN7eW0pcxC5l6VQqbLI03HFcvc30TQ2ft/bPT3WOE0ZEqKHo9MWqznA0KFX2hrxnuC2Mh8o+98Ag2ojTbKQTinKEILbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140142
X-Proofpoint-ORIG-GUID: P0fNKbtNtf6lyKIQ2Zcl_9S4TT8Usnyi
X-Proofpoint-GUID: P0fNKbtNtf6lyKIQ2Zcl_9S4TT8Usnyi

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81)
---
 arch/arm64/include/asm/mman.h | 10 +++++++---
 include/linux/mman.h          |  7 ++++---
 mm/mmap.c                     |  2 +-
 mm/nommu.c                    |  2 +-
 mm/shmem.c                    |  3 ---
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ef35c52aabd6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..21ea08b919d9 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_validate_prot
@@ -147,12 +148,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bfec4df51c2..322677f61d30 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1316,7 +1316,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index e0428fa57526..859ba6bdeb9c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -903,7 +903,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 	/* vm_flags |= mm->def_flags; */
 
 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 0e1fbc53717d..d1a33f66cc7f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2308,9 +2308,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vma->vm_flags |= VM_MTE_ALLOWED;
-
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;
-- 
2.47.0


