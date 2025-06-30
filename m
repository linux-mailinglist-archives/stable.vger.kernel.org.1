Return-Path: <stable+bounces-158956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EAAEDF63
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ACD1892EAF
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA1F28A73D;
	Mon, 30 Jun 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDswN/Pk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N7BUo93m"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A528B3F6;
	Mon, 30 Jun 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290916; cv=fail; b=Ty1qoo/LgJUrVAqCg9D2F1H80LxmzhwVlcS1/+L7XFGMSI5n/a9gw2IBwogqfK8GJrd+FxKLUWqGXE+dSGZ9wFHtFJANIviLoQMIAAxo+RbJBaNDpFT6U2KDjZbQWzm3CuMkLnUOk0tPCBZ2hVwb2Bx1oN+oOHB+4C/nP8aaRKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290916; c=relaxed/simple;
	bh=DpQbTplUeENq0L16YoZkjpt0MtFE8ohy5qEIGYdoWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KGauZ1yK2eoZkMzoliI6K+CYNp+EiAmxCIZXm2OJ5dLK9kVR+lahy1K1Aeq2PwpaB6BOCAgaMZPGloNTM689Dnhc2bHa2xXTem6oJxWXhc0j0Nx0mmZ3RCrKKGg/RTde5jZKBCc3N/a4+hqFOh/QZu0KloMcZgQkwQce2Kx8Dtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kDswN/Pk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N7BUo93m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDBlrC001354;
	Mon, 30 Jun 2025 13:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LJhu3bvCLNG7wFD7d9
	ed3STDSHjXcFKGlUaM2Fgb4Ao=; b=kDswN/Pk2KeX/Nfv0kYxFf/1w+x42enOeR
	RXmCCqltZgQJEQrloklESMUHFNH9oGLv8xc/Dkq15iK0a9flmuPfQaQEz51pagEv
	WFisupmnNK8ok4KBb00lHEm8h3GSw5/eIcACCuaxYE53JlXTAfiHrbgbLD2mb51b
	oQ5izMJEC+91xQLSPtEgjyxbWnL/ZS96M0mITyixgWAtHYhHBo+UQfkhgZ4y9kgs
	8lb+Wm+y8MyzXeh72fkhoXAKCsaocuyJ+X4q07IaXvwRsrxGfXQLZD24OQISA2g+
	TNrDMtEEya//QGrKY1K6tB0CUg9SnmhtSA7ayXNuFYhs5h/TzfHg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w2h7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 13:39:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCE36T017468;
	Mon, 30 Jun 2025 13:39:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1d3fbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 13:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxHvrT6c9mv7zHhVBOwDUaJe/omenTljYSomWmttAqJ92cv5NPDKJ3uLFvtW2Ei1wDS5bLCCr2+dJN97JEEF8xTHfa0A/CX+ChGmFkY0Qk/8s0IbHsFQUaLmg4QP3hKDY0uksirLG6r3sR6tz0yhq9tkFVQc2mRnlxSavmP4mopU/gUfeM0zIBQcSHRDZt+U2IyNE5y9BRlV31lei/TVPLjONDpaIfPcQ6ndPXY4bkfGsFa0Ih8ygogDzMAvwiWyE47MISSdNM8Vo+jvEmXKltOpe5RkXYAuZgijoeAW455jOCeowUq4SiU/i0t6UR/fcckEEowA0sxxI2rpyC6gTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJhu3bvCLNG7wFD7d9ed3STDSHjXcFKGlUaM2Fgb4Ao=;
 b=C7Q25RIrNSXZ+y7Ma4+v9whbhrfSIkXixqNNurrj4n3LoPhuGBXKwDqPK7X3gE+vFfhi6FQHwPcpB5S3jKFOa/oKBSwcS03vU4I3KFVL+Krr/9vOorBkR1A1fCLL7LwZahdOU1T8S6lOctaQ1dbBxE55/pCqltuaYQZeRCwTvaJdB2xSlmYOUJc5M0nZy6Ue1W+YfV+vZ5M9dJFty4778E+cw8e0/SRtM6zHOAOoqIS6fIW52ZwsRE1gwO1WpcGNrqPGNfZSxI1jBCTalGJRdqXyejgPh4R+yAiqas0uGkbexjfz+LzB5spg7CsouR6CQz34nbwF1YXg44WIVhVDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJhu3bvCLNG7wFD7d9ed3STDSHjXcFKGlUaM2Fgb4Ao=;
 b=N7BUo93m6oMrAjGRU99cZU48YWO/8LkaV5eKQFdf+8admhC9rMPtvl/azpZIQnqPYku0Fj+Nc7RFGf751KKViZh0V6xueW5F03/NyE8x6E/wrr16+Pq5FxHL4C6Ml1ae54SvJRVUCfPFjy+CPx5pveXo40woBxsxYnpJ+g048r8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6079.namprd10.prod.outlook.com (2603:10b6:8:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 13:39:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 13:39:46 +0000
Date: Mon, 30 Jun 2025 14:39:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com,
        baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org,
        huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
        mingzhe.yang@ly.com, stable@vger.kernel.org,
        Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Message-ID: <41483c78-84f2-42fc-b9ab-09823eb796c4@lucifer.local>
References: <20250630011305.23754-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630011305.23754-1-lance.yang@linux.dev>
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab4b1e-2371-400b-2dca-08ddb7db93fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yIgqZx/vl9dq0TMPObYptVyzliRBNI5s79x0q/tXKwGPBL1NfN0Pg9cM+gEx?=
 =?us-ascii?Q?RTpWKEuX0IKT8taX4P9sCUHrcitbTg617etEAqBJfxjQEVNftiCIsHRfUeiS?=
 =?us-ascii?Q?ZdiPsB9dRcfeFc1Of5qpuvm095mnhWEE+34mb+SuyQnLCMvQz+5SX9iDKEvj?=
 =?us-ascii?Q?QHUnHRR99bVc2YIXL2b17Iyz0VWZH+oaXrwaYBvEcfgMMrLJEaKJs5qmCqIp?=
 =?us-ascii?Q?I0yGbwvqEqIUBWvFCvRwiZrOi/qRO36D0Dx+SKc3+aCGUGUrwQNq0ypiV5qL?=
 =?us-ascii?Q?QHT9sFaTpBbIkuZV2rxGF/+vZ/elcfrveQmrqVRbuw1v5q8CnG2A9pFviF21?=
 =?us-ascii?Q?D5NbqWvLPC5TSViSBnT0GbiXPD2dxTEyoOElJQIaWKItySgX5REXunxsTaUH?=
 =?us-ascii?Q?B+OsH02gmTjVpyp1pppFfvoaVL/hqPSRNFGvwBuCj5OUXHUj57Z7MDqPwFq7?=
 =?us-ascii?Q?+uklcj2coAKhzw5AaKa5IDBp63ZRFJUzkapgSMvx+mTUHZaYo/ZnxWBOj2j7?=
 =?us-ascii?Q?a3nHWWx1OJezXljK6XNBuhg0VtLOFvl0BPF24opz2h7mE/GG/PPZjDO0jPzb?=
 =?us-ascii?Q?uUuWMxqo4nMNbRLDXeujsVRcUl6DGUXsXep7joeCjXOf7OhHzaiGJVKFG19H?=
 =?us-ascii?Q?HoJbrnBstNFlIvKD6A9hBVYZc1m+Ttaa9A3bXKxb7Hhoal8pWbP1M8GBOdNu?=
 =?us-ascii?Q?PeOZzkANW3uJyyJ7BEFy4FIA2UiaEBxDvhVL3gMFXZAeVX/V2FwbyjUDv3v3?=
 =?us-ascii?Q?0zts/OiTQCVraSpqMkYbLqGwlxZVbX5QeEzwVBmObzL7Ua0BIOtuCDoLbN/C?=
 =?us-ascii?Q?Oc1fHlDyBg59FjOreeEgva2InkQLv9ISnwYriAZjPHmqCzDNqIvEs00ZB1du?=
 =?us-ascii?Q?DVDjqqgF2HaI/MelTVCbGM0MEW3T+xM1WlXnYgjqO+skFg5+mnCdp/f6Dxnc?=
 =?us-ascii?Q?4x3cPeRbbwy5bUDcxunh6chAD+8HY5FblDxS5E7i/2AqOLSgTmW75rOzLVAF?=
 =?us-ascii?Q?MExaGFp8zznaZ+LM9tB/y66/1X/x8nUFnUEFRYOGMx9sW00gQTQdJWcKlgHz?=
 =?us-ascii?Q?3y+/p5MUjtK/X+Sp8mwikoR9kPAxlp5plydLYIsUvEYqaAPmNJDo6DBNIzBi?=
 =?us-ascii?Q?nExz7k2n8Z7LMXp1WMXrCAXn/ppqJFPcVw6eScWkhegl2QRfRdar8qEMS2XN?=
 =?us-ascii?Q?h8egJEfDMa03wylK5zoUG1GReTBykKplc6hsiHXan2FtEB3Nn21gRNST+pWx?=
 =?us-ascii?Q?6CU2kcoGYFP7qGhoVHnfG1rQPQFtM6DWLFnM68j+a6cKwmLuHruDMXdupQHE?=
 =?us-ascii?Q?Aq9i0rce+JlA4Tw4d44OiXymWlkH1t6qnitMKeWYIO9hCTIf0jDIzCOItO3B?=
 =?us-ascii?Q?H0TmHPnbf4zsLB0h9tEjQuvlyTseTfVq3jj2t4UIiZ+/OG06jj+cSzwUyeBk?=
 =?us-ascii?Q?dy4zEy2d9zQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7r2m8OiLZWSXWmDhbkMKLNbYPknbtVWjOLKibqaWAmXdutaDcL9QKzyuSw9U?=
 =?us-ascii?Q?V3FlMQ5t/HVy2nXIRyTYzevtFqgreZ/cmEYbszbKNY5UDqXKgDCcxTi1Pea9?=
 =?us-ascii?Q?XimRPr35jhpMeYb7hWPKwnT6hhh+sn46jvoArHGz2sTOrrS/1gA9Aey2rb5Z?=
 =?us-ascii?Q?gEkH+oo7VExYa194Q3fbMWqT1KqTBxJWgzxiTOgv3fYmpAwwWesCpDkA4lkD?=
 =?us-ascii?Q?jeAn3dJMnp2r37KtRI82/P23GQ250FbMe79O7CB+xl6Wf0FsWzTL+Ub44Dzh?=
 =?us-ascii?Q?g22S/tb+q5t2TIXeeSYas+y6T13AvEfzlGgjNZGBgcLPEMxrh37UEfn5fGpA?=
 =?us-ascii?Q?s0UAKVejQHgVK6uitt+QeKr8mOiXjjnmnf0Re1DdtJV21DZ1y4kVaxdmOnTE?=
 =?us-ascii?Q?RigDjPDN2L4UtLXlNi3+hmNcMbU0K457dBt+gG760aK3HdMamhLw75b6EnNY?=
 =?us-ascii?Q?TXlJFC7oMYWS4Tf3sa/XZQT3ZooBCxK36VqHDZruhu9Tz7iKdIRlfNzvLBqZ?=
 =?us-ascii?Q?m0pIwH2hVbFQanxZ9QCfh8sC4OqnhujkcKVTce7RftP4MmhdL4hHBqIYw5C9?=
 =?us-ascii?Q?Rf2FcskWNOhJJZJDZltfLSs78DZhWdHbH+Ag8UN+7RowDH0ODttc8+emyjvy?=
 =?us-ascii?Q?nfKNTxDuQgBr/vnz9ihasMaI3Jde6t0yXqwAXLtwRSgzQsjJr9KytMqT/JB/?=
 =?us-ascii?Q?MRZ1iyi8I3YKC7FpPkRz+uNn/wbXhLO1MP/8pi6kTZhMWXgaTIDLUAd0gpP9?=
 =?us-ascii?Q?bFdb+XrgT+c7Mg+HUKDlGMZEYjxga1cmojLE2RC2OUvbJssYuImlOjRDdaSI?=
 =?us-ascii?Q?G+PRLHh9dsrFM5fBCN9hLq5uV3YHEq6dm+bHk/9OfQPr8Lnnz2MWqdiCXAl6?=
 =?us-ascii?Q?+8g8M06JRxUnpoHAf31EuQN+ssXOuu5CGZrTMWfP/ATSxDsUsmp9dWMVb/En?=
 =?us-ascii?Q?fLu1a0EYmgqRnXkA0t6KcnFWt+rzqSiOysi3ehZC3COZiPMUrxypFFIC7Zbj?=
 =?us-ascii?Q?+jtdMZIwT0zAkH7xbw6+9mOWKUVr33AS0dX96EJaEpByBJxxgHQmI5C8cZrq?=
 =?us-ascii?Q?GB0PNN1Jt6QGqth/CPzdOQPtJ+BytzIMhrH2BTK657rzSSnu5cHw4t3yvlpp?=
 =?us-ascii?Q?W0t6qkTps16M61udcEaYSVvYdXIkIm/Yt8r2GjeGwWYNFL2kz2suVBAAi6wB?=
 =?us-ascii?Q?BaNO22GvIE3mLkYWEyzLTMe92gLB1na/q5cJUli0bcjZTZsODW6CNOFLHai9?=
 =?us-ascii?Q?iAC7H3Xqivfl32fB4LqaT8gaZO2l01wgMKPjU5Mb0/x0OLVSbYtU/NUB7fjL?=
 =?us-ascii?Q?HhgOa+ihKh5zykgulBUFaCw5o11HmlQipRCe44cTLFx6M3/tPiai7z4aa627?=
 =?us-ascii?Q?u2JuithLSaKyPmuEMofsef4cEdmsXius4DbSLhBslt693+aZTtD+ynfvEbZp?=
 =?us-ascii?Q?YXOKk8wwRMjFtgRrjuYUh5vUU9k7Mm5vfnsfUeKlJMaT+mpwY8psQlyDGeO4?=
 =?us-ascii?Q?9MNjxvlqhrd90AhOwfK3y3mR4nA0b4gH3uJNyVRJ/ZGc/s0f8ax/kmimJsOz?=
 =?us-ascii?Q?C26bpbZItdcUJiD2G/c3nHhreDehX8HIvWqJB298ufaoGE1TiPvdJrXV/tGg?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PLeqAFDyIP3fC8S4S7PrEpQC2up9XLcBhyLKhIwtvJdQpkXiaM4MyunoyQaTKVPLcyVRq4qlGPEdtZ9tW6VLpXrbUUqgACcHiypUZUGrqXrkfx33unEPiqYvp/3LBnZPgRFv33GJDBS720G6K9gjUWEdN5ZERSk7/McnMXWxgrPr6Vwc03dbdnagD3BAignyTn4CxTqqqC0KyymwU2tokCBKQreq6BAiNayYQ805bpZa3F1SiIY2MoVBecBkk0CknlwhKcz8Vg/w5fLsRFxWYpf5XuApnG995UgCuCBiU9/+GcPFJgF93Wo1vtvw24Thifq9RNaWjgrHXdwSGgKA/rLAPTTO6tAEfdyRKTHIgEEf0DONfVyB9kEc+wohHfRP2cbF/Dktj0qbR+yN8+iE8dA5SH6p5Zzzxzs7Mr7t/NTY/195LOTE0YzF47m7fcWntBQHjuyIZ8YTWSABbzIuBiZgTQtdmuo3SH4csBOxxrz5rlTiVE05QL2eL+lld9RRQoAAbVOVke3F/ZNtMdexTpYgX5Tlca1xSeIrfytsFqQEDIYxxk+xHcTOOm9/AEXbK+Jf66lWIdc1ej03YKl+9g9WK40noKTiKm30UZ7uFxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab4b1e-2371-400b-2dca-08ddb7db93fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:39:46.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssJY3YqpnU5Kc2Z6hNTIK6N98Li3V20pbTuztE5uZMhXZyqlMYDqHVhBQ1g8IvtxAg7FSOT5/Zw5Q7T1BAFJQmrPJd4ufZ9QAtFVrsoLi60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300112
X-Proofpoint-GUID: vXBbJWEKBNYVgJ0ByrcK-lUg-t1uAXJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExMSBTYWx0ZWRfX2YHnQ4QAwiy5 iBUyQQ7sC3IZS4kVFkHYpq7e6Q46ejliVPKB6DdEYHoe66e2pytk0cRlb5dAjncBvhAS53N0PVW TLzpDsBGDqYOl24uFDz9TaK4TTAWr9bRiZ40m9/FKOZ40unnOY7AmszftKugbOcUw0IWH/ZL0pf
 eSqlNLDDTTZKHkHzHJEnyWCjg1XG5wn5+7tTRFpcw3kia7J0UAV/3VSur9d83hP3eC+mDzbuTAa 63ZJRy1QhLv8rpJzvNmh9iyDrq2xK5t53skwH3xEbOuav9DUPZimwUEuyZAKi7dKDQvkzOLILnS Lqd1E68LDQxrCAKQMYjWjjYhWp8QvAism6PTVXmOZeMVqpxE4g3MOud6qQTTI1CO3BmA6VjoEx/
 VxYt3DdpI18jBMPJanGhf9KADJvYNwwOfRa+v59O4Qxlem+MBslJlZkcIMVTgLIhYbb5wa1z
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=686293a5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=bv91L0u5tX2j7Fmyg9IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: vXBbJWEKBNYVgJ0ByrcK-lUg-t1uAXJ3

On Mon, Jun 30, 2025 at 09:13:05AM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio's PTE mappings
> are not fully contained within a single page table.
>
> While this scenario might be rare, an issue triggerable from userspace must
> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> access by refactoring the logic into a new helper, folio_unmap_pte_batch().
>
> The new helper correctly calculates the safe batch size by capping the scan
> at both the VMA and PMD boundaries. To simplify the code, it also supports
> partial batching (i.e., any number of pages from 1 up to the calculated
> safe maximum), as there is no strong reason to special-case for fully
> mapped folios.
>
> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
>
> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
> Cc: <stable@vger.kernel.org>
> Acked-by: Barry Song <baohua@kernel.org>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

This LGTM:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v2 -> v3:
>  - Tweak changelog (per Barry and David)
>  - Pick AB from Barry - thanks!
>  - https://lore.kernel.org/linux-mm/20250627062319.84936-1-lance.yang@linux.dev
>
> v1 -> v2:
>  - Update subject and changelog (per Barry)
>  - https://lore.kernel.org/linux-mm/20250627025214.30887-1-lance.yang@linux.dev
>
>  mm/rmap.c | 46 ++++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index fb63d9256f09..1320b88fab74 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1845,23 +1845,32 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
>  #endif
>  }
>
> -/* We support batch unmapping of PTEs for lazyfree large folios */
> -static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
> -			struct folio *folio, pte_t *ptep)
> +static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
> +			struct page_vma_mapped_walk *pvmw,
> +			enum ttu_flags flags, pte_t pte)
>  {
>  	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> -	int max_nr = folio_nr_pages(folio);
> -	pte_t pte = ptep_get(ptep);
> +	unsigned long end_addr, addr = pvmw->address;
> +	struct vm_area_struct *vma = pvmw->vma;
> +	unsigned int max_nr;
> +
> +	if (flags & TTU_HWPOISON)
> +		return 1;
> +	if (!folio_test_large(folio))
> +		return 1;
>
> +	/* We may only batch within a single VMA and a single page table. */
> +	end_addr = pmd_addr_end(addr, vma->vm_end);
> +	max_nr = (end_addr - addr) >> PAGE_SHIFT;
> +
> +	/* We only support lazyfree batching for now ... */
>  	if (!folio_test_anon(folio) || folio_test_swapbacked(folio))
> -		return false;
> +		return 1;
>  	if (pte_unused(pte))
> -		return false;
> -	if (pte_pfn(pte) != folio_pfn(folio))
> -		return false;
> +		return 1;
>
> -	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
> -			       NULL, NULL) == max_nr;
> +	return folio_pte_batch(folio, addr, pvmw->pte, pte, max_nr, fpb_flags,
> +			       NULL, NULL, NULL);

I guess this will conflict with David's changes, but maybe in this simpler case
and given this was existing code a bit less? Anyway let's see.

>  }
>
>  /*
> @@ -2024,9 +2033,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			if (pte_dirty(pteval))
>  				folio_mark_dirty(folio);
>  		} else if (likely(pte_present(pteval))) {
> -			if (folio_test_large(folio) && !(flags & TTU_HWPOISON) &&
> -			    can_batch_unmap_folio_ptes(address, folio, pvmw.pte))
> -				nr_pages = folio_nr_pages(folio);
> +			nr_pages = folio_unmap_pte_batch(folio, &pvmw, flags, pteval);
>  			end_addr = address + nr_pages * PAGE_SIZE;
>  			flush_cache_range(vma, address, end_addr);
>
> @@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			hugetlb_remove_rmap(folio);
>  		} else {
>  			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
> -			folio_ref_sub(folio, nr_pages - 1);
>  		}
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
> -		folio_put(folio);
> -		/* We have already batched the entire folio */
> -		if (nr_pages > 1)
> +		folio_put_refs(folio, nr_pages);
> +
> +		/*
> +		 * If we are sure that we batched the entire folio and cleared
> +		 * all PTEs, we can just optimize and stop right here.
> +		 */
> +		if (nr_pages == folio_nr_pages(folio))
>  			goto walk_done;
>  		continue;
>  walk_abort:
> --
> 2.49.0
>

