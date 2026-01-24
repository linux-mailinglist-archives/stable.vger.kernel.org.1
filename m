Return-Path: <stable+bounces-211455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cT2KJM+kdGlI8QAAu9opvQ
	(envelope-from <stable+bounces-211455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:54:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2047D525
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89ECF3009FBC
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63057271A94;
	Sat, 24 Jan 2026 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHe2FPK0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s3sQkMe2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D89246BC6
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769252044; cv=fail; b=n7jJSmcbX2nNqiAr1qy0Z6FqUGjL1X5zKI7H+QlC5z77aVNJCVtCdjMwWgbNdnQzIK1TqwntmyfCinIcvJjPdBIR/Y6rVJ0YwwxX+gF3lw5xAOtC51gkkKHsamCsc9bJpLFCk0j29N+RnpdM4cADB2ugqobXLsErmn8Hn+CoVhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769252044; c=relaxed/simple;
	bh=zZ0nw+eO4mD3gDcyCEbuFw65S/DyivSp53irLzU32uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=slrweldZCxCLBNSmEN369O24fk4QLfZbU/MdA5L5VKLx34T3UaAyLDb5ojYNErlDPCh/Bc+9QTh6qZRD8CAsOHJ2yUKfQMo/FZIguWeLbvhCiaeXZe1zSOTZ6kqKS71dpIVZ/NfswKpWE3KtV4Q35rfQs3+q8FA9ezSoviO4FYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MHe2FPK0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s3sQkMe2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60OAZ1Lv1040926;
	Sat, 24 Jan 2026 10:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8PlBMqGq5yWmEAktVt
	L7WVFbBL/+QNBiNnnrgkRrDmI=; b=MHe2FPK0xr+vvBw7gEcXgA1nkYAkynKSgI
	RA/wPf58GIoQnKRxV6tqq/K1tY6QlgR/8A4kc6/eodIAEifs6wLU0jlfdg79S7ge
	RBtEllUAql6J6GAj9PoMVbq9oB1MsZNiL7CbikS8DVbLMqCJrHQJqcE2nVtzZSqy
	6YDLFfauKsdIlBh1OuKRWfLjqdlPpT1fd7+uEaccvdesSWS3acMoYBPbP13TIulV
	RnxcPZqDu+4oaCBdFQMr7Lg9224bhylT2ZCgg/4x6rATOyK6nYLm3dypyMb56aa/
	vC++StyYveFvuLxJjMYE0GY+pMw3pS7J9nH70jk/AR/cNKVWWXQA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2r6c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 10:53:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60O88a94033649;
	Sat, 24 Jan 2026 10:53:48 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh6bjn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 10:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb+bAdExI3bAkWgbqqLf2u7OLnoZ5a35qECsZGfzdjRPz7S8vOUiS7/O1MzkdqkJfZQ/dlhM0JWa2DeW7gkN6RzRJytW1iLC4iGrL6AsUG3XmiZ+APoBtbypCML34WCIwpGIevkEp6Usthc0R8gklYFSZZJbv18h1JW1AsRQqS2JBoycIyvcF62GVIT2Xr0lV403fLpQvUTS/mCyGo6FZU+EakY30oQHmyGLxXMHMl72k5jiwyIufkPsjo8Bd73cn0dwKih+Ag6kh05Jvcw++93hTLo5XIe5Sfya01ekOAsQxPaP3H0e6hr4FG9sfVQIfcoazf6zhc6nL3L2nEj2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PlBMqGq5yWmEAktVtL7WVFbBL/+QNBiNnnrgkRrDmI=;
 b=GB+8ncZqCeZn/POWO2Bfo7tLabFL6YYFFlA8VRlSSuyUtmOZ8qzYNVGcGZGW5Up/ucF8BtFw+LmHkZL2plm1oWKTrI1JRQoJtOo+SS6jnNt6hN3vVKyjRSnE6Poh5srZY5YJRmN9VZsPEYYgLecBHfyIX2WMIwLgilUoQMnPTyWq77H1XSpBhNsz/SfVWQkrFTwjlnI9Q80Us1wRdZ6QtW+SjS2bdJIwqdLBrkQX8UEV3QL3TOw0ryM+aTeKkFQhmoJjLGV/oPLI6M6NN/MinvCiHAia8yKQrM8bhNREBY3VIX/P+E5dspNnWnqaEMHhadkJpnyerzGjKZ40ObObgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PlBMqGq5yWmEAktVtL7WVFbBL/+QNBiNnnrgkRrDmI=;
 b=s3sQkMe2RA43AcGMcTsf1xEusMeJ+Tw13Pb4nVMMem9iiV0kujJ4AbO7aXWWusgOK5uJ+uVDxcafWl/yxNaUlT70EDXl3leATPUBhb1Fg9kR2NqqSUnYLKXcvYPAotCfzKGOybEAY4GTNWS1FVbsOoUDuzqQTZvV73TxBu33f3s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4916.namprd10.prod.outlook.com (2603:10b6:208:326::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 10:53:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 10:53:45 +0000
Date: Sat, 24 Jan 2026 19:53:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: linux-mm@kvack.org, cl@gentwo.org, rientjes@google.com, surenb@google.com,
        hao.li@linux.dev, kernel test robot <oliver.sang@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Message-ID: <aXSks_bGMIBa2OQw@hyeyoo>
References: <20260124104614.9739-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124104614.9739-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SL2PR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:100:55::30) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a4bf9b-a0b1-443b-24f9-08de5b36d85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HlP5W3DbFi1jpY76fOpaFS+BviVDJtF/1GweW5z6TaaqGL0nJZ2fLHBzsX0z?=
 =?us-ascii?Q?JyfwIp3CJjLXF0PRdD4PJd2fiS5IPBZaLKSiMyyYrvuhS/934Q2XcY7LwKEo?=
 =?us-ascii?Q?aR2QUP+k71PJwzvOt8vAxGg0nPRBBlwPqv9gZdSRHEzcdZRF4BLsm7tCgCU2?=
 =?us-ascii?Q?urLyJHKf47J5oTpFSWv1ClvienhNYUDOo0STB7SUR2ss0/ckltK7UnEvxrLl?=
 =?us-ascii?Q?MLCczCMy/1TJcRPGrkb9xfePfsJFNsPK98N+mxqAYnyoQ+qpvauX7MkWnA4A?=
 =?us-ascii?Q?DBepwV0YiqIaKVHQAkDgGC0PaaN6U6D1uoYGyjvQuiXurmELxkLdtw+YUDjl?=
 =?us-ascii?Q?330J+XlQPnMdInVwNVdf0HnvO7tv1N1ZljAlmgH0zVpr5MZRW4fELZ5L+0zq?=
 =?us-ascii?Q?0p3vl3K+pvf/3XOAs+MdMPjwCqOJPg0BFBosdAUGWnXQB58WeUKnx6wplsg3?=
 =?us-ascii?Q?frx/0fd7dLZdbEJvGpDO21Az9s9/rnPlIzfzz0OVN9UyJ26eA9PyTid4N5tE?=
 =?us-ascii?Q?ZVM2VhGoTO+PmNhDmPoOrASQ+mC31fH2UtmrrURnWRhxxpoFTS5Ub5UZhVwM?=
 =?us-ascii?Q?cMx1YXLcxGytbuOhmEIS+iMdqH9ZXKQbvKkB1eG4WYWavMhUPiy7I99iliep?=
 =?us-ascii?Q?DqyBaeCtAwAauJtZCN7Rky2PIaBmyGpIvfIpxpvZUNuI9Wis6D2L7bOW8+i+?=
 =?us-ascii?Q?j+PxHd+meD4aBs5npYsP9nBmu84v0IhwIkr4bt9+xNoWmMVWc8CIrID3A5rs?=
 =?us-ascii?Q?wC8pnLkfM8kW8shMQ5SwKqO7UcMJSEKoRu+SwkvxdyiIz+NOgTNmGb0pKRpg?=
 =?us-ascii?Q?o7MyYvJolwn067Jvd1z5fLKhYPIqIbTQWodoLLq0YTiPo+G7ycDPHtPTcRPp?=
 =?us-ascii?Q?TBg7+OsUaaPKkUjFk3oxYS0LxWmSiVkkMPUrIwH96h9+Pi1RB7P406VnJXBK?=
 =?us-ascii?Q?LCEk0VVHMREe9HqOCISglt8iC0qhFl0WunpGLS5SZeaVSjRpiPZO6ZmP6Xq9?=
 =?us-ascii?Q?HCuVP6YgOo/UbNFSQDs61gBVQB0CWfUh/tjZcFdja1YW/zJH9Ddl3lMgLeFo?=
 =?us-ascii?Q?gZdivUeoTSklu1LyAyvC60eceiaSFfIaLPvpU/zi60EUezQ4xcq7bMtwplTN?=
 =?us-ascii?Q?DPjG//zr2e9AyjclS9xOxXdnV+o1LgExSn4r3SsJGAmRCswduzIoKuskcOHZ?=
 =?us-ascii?Q?k8h9pnYd8Q3DP8j1zglcCHmptNbHtORbI8u059V9hlNWBhdbcDLttdnmH3ld?=
 =?us-ascii?Q?lIbHvjR3bHVvgzKXb7YCYPfdP6VjHV0xXSq9ZYEX+M4fPp2XMlJ0AsE2pUB1?=
 =?us-ascii?Q?E1UMrRIAiWaQnfVBySALSC47JHC8zPyWFBi6AaP9NPag2997ScvPQAPPNGQZ?=
 =?us-ascii?Q?rOPlf+fltJQedqq5CYLhCZ2QUipa4Cjy8Z4bxQWr9RBsV/PvBasg+nnHXZAW?=
 =?us-ascii?Q?ShPS43quTIob3kViDAr0IE0kK8nUW1G3Ml7/c3VdS+9CRS6RXGDfCf5p5oie?=
 =?us-ascii?Q?dK17aoR/iCdLlgmeCHcmQZKRr2VtgbsvUHR+0WIM4bUUY36p/ob4X0fcjFwi?=
 =?us-ascii?Q?NOM4tEQ8Tp0n0tKxajbTMfMIFk0TPKBX9nKdKwXH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQmdVSaFawfOu+HmyAopKS7lwDPFp/T2hDYV1WiKw1EXcfaYqW7z2MogqQwL?=
 =?us-ascii?Q?S78k1GJcECFVLC76LPVUl52UGFq5NoxxLkQm0ReU0At6APoz1OHwq9Y67amC?=
 =?us-ascii?Q?A6vs8D9k6BEb8iZc9DquMljdhRVqnfg69S0mRjAPDekD0ro6pug21j5CAI6w?=
 =?us-ascii?Q?5VSwMtsTGJrMm7Dr9w9LNhhOR6HiyFFFrB+uMxTbCpYRXsNSwDAfdgMR4HH6?=
 =?us-ascii?Q?ZqOqidvpFb1uwOFrIVCudyL+ZaWEr89wL+qy2s+ABLpdMFwY7/0AcUH584df?=
 =?us-ascii?Q?4GyAOlVt6UI+DL8MiYUmKexg9vcHUmOahYMuPlsd24Z+89ql4ys1rQegkXpd?=
 =?us-ascii?Q?ToY6WvCfGCukQMnLPZRAOkFkbLXlC/NAh4S3gopmxVvGjlSQI1FiUnMZ3tLS?=
 =?us-ascii?Q?gN0+vy4LwGJJExW4ObT6FBNj8cBmytkVw3vn8HOnEk6Rq33UOuW8O/VayM/i?=
 =?us-ascii?Q?h91YRWMy8/Q0ODHsOfvMDaUdJrZpHkT40tqINit2wZB2o0cahmQsPgA6iQRV?=
 =?us-ascii?Q?SMqpg1bcNjvporM7tmXC1/OEnT/2+/QuNjpsBXLr8+nUwANIBnddgZriMSmv?=
 =?us-ascii?Q?DC+PNxZ99hJYSY2EvSwsbk4RVPyxCPRSJefNmNHyWUO5AwRIznD+wWSLcxNn?=
 =?us-ascii?Q?PrJm1OP9Lk6RtHWT9b2sVCYeqqcLZbnHx0m/3/2xeB2DHfWQW2bxhME1sfa9?=
 =?us-ascii?Q?MrGrLMNqDB0KbkGMZbeuXaCwPQb+sGpSenMIN3sr6ZWErEFuztroV8MNHus3?=
 =?us-ascii?Q?oilzOAdtAHbVEb4NHh+Ot2X+YvdmZLYS7QdSazq7TnTMKwJX/TKN1DmDFAHU?=
 =?us-ascii?Q?0bffypc/dmQ5oexYaGitpgdA6T38lNE90WoX0mWl1JSjINWngeUtqe6CaiEE?=
 =?us-ascii?Q?VTa1zvOMFZb3KYtzhAhplvU2pIsEgBDLrY8APOZKmx+eO6d0GVaalYaKI6dZ?=
 =?us-ascii?Q?jAhUZUvn1PYwguKP11SNPqrRv3hBYRFfYQjFK03/KVDsLwS/NX5GUvOL7GbP?=
 =?us-ascii?Q?7O6qdQ8EpvS0GxK2p7k8gjwK2w4wWjfhYsSh35Or6PFIcvQwmGYI2dLrVYpb?=
 =?us-ascii?Q?9aIO9W1KFjUWcDsT8mV01Yyi/xYEppgVhEqpz1PHSjpWvIEjPUWp/4PTM2Va?=
 =?us-ascii?Q?MaoYCBJkDPBGtcFS4yQtfEIFZF6XRa8cMeFleBtEqOfpu0ot012nMKDgeDpP?=
 =?us-ascii?Q?aBTm10Qc0wdaEZ35WRHrjXX8KoEMQ3PC2xMIW5zzJf094rkpkS1EQPAaF0W5?=
 =?us-ascii?Q?9RLs78/bOe972nutquFBq+ZRbw6a5jxfyG0sC2iEjvw1BI1xeVwoz3WxiZRL?=
 =?us-ascii?Q?pZ0rVOo+/lcfF+kOYYU5H78eL+ivKxOmSR6ZCCSUDcDoyhS7DEbSfwTm+HFz?=
 =?us-ascii?Q?blBWPqQRG2SLUrBlpcNRRHMLBJhOQu3fjz8B1Jc71Luz33jxr5j1Ksnr8zmn?=
 =?us-ascii?Q?NWoTx7ab8x87l20Xa+w87xOZiUFKzbgAjHO0IA65V3jmCGofZc16Yhtw6wRa?=
 =?us-ascii?Q?qXugTXEws/re5jwsS5Hc9se9v/RxzToI/orFNiA05s0GbQYt65gGsAGxOdPB?=
 =?us-ascii?Q?6IZiB/StlAxNj8M18j55j4GXhIXlZbPJrjE1oKG6vwMzBnVIj6dHE1idN68E?=
 =?us-ascii?Q?3TtHM95I4TAh6BT1NAEMvm7KI/P5pODM+dnn6K3xhr1EqiaAbBYgFJbKE4Wd?=
 =?us-ascii?Q?j4FhyAdFOeqQRSR0w54HpFoFRhmk3ceLuRYncsEjzYQ5N1YWraBi9f1n0dst?=
 =?us-ascii?Q?yHoeeJ8wig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VOuPkYMr+c9caiueamavPGsOMhZqIjiIm541REaYCraPHVfuPWyoh1MbI2SuWanqh0jhJajdRkZsSbwj7mHx3c2sR73FhR14OIcDWUJnbqgXT61jfZQUChhZIyp13cSgyuFQ/MBooWmxe1Asen5ClVyaHzkmfJoel6Emvxz8oGekenmEx/TvB4deUkvk5AJc5sG7SMyCcQ6f8LrU48VzIx8aGcABJwa/6hYqddtcftPZGhUsn+NgQdlhfA1BEVXg5vYff6hwt68K5eY3NCmyRJVxCq08U4ddkOvMlKIYMCx3PFwNYsy0MViTB62ZzjDb+zPbjQzKPQySId3eNstPt6a6EeHfYlZ6fKNVlESMnsJcSm/Uzxmqt/rzdfcoohDfESj+xrZQfOh4MMrPpOIkJBhUhxdWAszFWOx+kGt0maSAndPgbp4yanbIwbs6atOEI00CsCtN56bPgf1Gu7CHvIHkdzJzp2hpQb76YQSfbzKtqLsF5pLnO5fzBFDtw8kJFSfmhoRV2TepZzAn7YNpyLMrYnRZ6OQYTgPO96moFKg81elsoeTwZ7Ku77AyGPlF5yU7TdBKuZAD9O92q0xVdVOJ8pcxEz+Xzn/CGjtRA74=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a4bf9b-a0b1-443b-24f9-08de5b36d85a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 10:53:45.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+fXnfnK0Ss5epuLeKaIL9rBKHSFrstBhDu7WtAZPKxIjlUyRmENV60aH0RYg095ZCkfzTGTlZeZliIEfXQHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601240086
X-Proofpoint-ORIG-GUID: e9ELoiUAf3ydz3NxCTmEg4KYnzV9qsTH
X-Proofpoint-GUID: e9ELoiUAf3ydz3NxCTmEg4KYnzV9qsTH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA4NiBTYWx0ZWRfXwXouVVEfcEjI
 7sKk3wV0JoFG2BOJaqzVGKCyC6RSRcoCOv0xU0JfZ31Xg7KjNfYIdsZTo8neFCuSYhaR4nI3E/G
 jbH/K3Px1iNVXFCK/XqDa/oRdN87MvnS84WehfEfyvi0yF+GflX64npOT8UAaqj0KyPWCmFlC4o
 pWj14DarU19ao63Oo5+mTOQUrpXJhLNporIGtC7xz2lq7gDyOHf7Mcv5rJIRiTc0w51y5QGx1Eq
 X8uYgtjjdRMrsWH+6ljk+J07QlV2gi7+OABLPaQ0e1lxAaktDJ4rtEOS5DDJDXPqRr8NiWbByqb
 MrxQwaYNasFQjd1xqysOcvvvscSwPoV7PWNoiicj+4M3M7ZOczojib9HSnKcisCWlB+axgWpr3w
 KMDERjPxEqkFnz7bEWlrOGF77Gvqn1WJbKklDXIsB5wz8O62NwySJnksjl8afi2y/XB6pf1+yji
 2Jhf2EjL5KiMl1xmtzA==
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=6974a4be b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=0xPqAKBWVPewZ0GJU-MA:9
 a=CjuIK1q_8ugA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211455-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DB2047D525
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:46:14PM +0900, Harry Yoo wrote:
> When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> can be allocated from the same slab we're allocating the array for.
> This led to obj_exts_in_slab() incorrectly returning true [1],
> although the array is not allocated from wasted space of the slab.
> 
> Vlastimil Babka observed that this problem should be fixed even when
> ignoring its incompatibility with obj_exts_in_slab(), because it creates
> slabs that are never freed as there is always at least one allocated
> object.
> 
> To avoid this, use the next kmalloc size or large kmalloc when
> kmalloc_slab() returns the same cache we're allocating the array for.
> 
> In case of random kmalloc caches, there are multiple kmalloc caches for
> the same size and the cache is selected based on the caller address.
> Because it is fragile to ensure the same caller address is passed to
> kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), fall back
> to (s->object_size + 1) when the sizes are equal.
> 
> Note that this doesn't happen when memory allocation profiling is
> disabled, as when the allocation of the array is triggered by memory
> cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com [1]
> Cc: stable@vger.kernel.org
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

I don't think this is urgent enough to be fixed as part of -rcX,
as it's been there since the introduction of memory allocation profiling.

Perhaps it could be the first patch of slab/for-7.0/obj_metadata branch and
-stable folks will pick up after it lands mainline?

