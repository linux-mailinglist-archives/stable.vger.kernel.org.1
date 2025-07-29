Return-Path: <stable+bounces-165064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FEB14E91
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DA64E5C8C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D2199934;
	Tue, 29 Jul 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GkJwChP0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iTxFcpsu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271B79E1;
	Tue, 29 Jul 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796545; cv=fail; b=ZJIQ9fU0B6eXFVYsbXUJRP5orOw3FagvIAnWNj40HvoSMzMKN6tRc7o3Thmzr5PCtAdyyGz3LWP7fOVXNIJH8p0oos63pARhfDIyUlB1alWE/fMjnCHDlUdnyJZiA+A7kgVOQ/fn3jmf/iee3G0+BB5AGqpaByy8ag7ZzOTpKAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796545; c=relaxed/simple;
	bh=2PFcdlNYEBHbFojPBnPR5EBbn5xDgyrosxsXjTQZd6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ShnWLyf23uYMK67fbMQ6rNVjzcOp4nG8CWznDpdjElQQ/0W0V3oeE5VXpU8T/v5sGcq5t6ktaV/16oM4fHNiCoK+7/ufjvKwI+wOXPJyZW/2OjXmGCxRGLg40dL20t4fJABR9DPtYHb1nLhpHEi+VR4/8F0kiysA2p4J7V2o7WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GkJwChP0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iTxFcpsu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDg7Me023033;
	Tue, 29 Jul 2025 13:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OeOfqjGiSTrg2aS88m
	nSoEcBqOCd4dYv+OhdO0g7jhs=; b=GkJwChP06kMm4MzYNTQvdSJlJXYiGVLZna
	WdWmEHqbGdqE+J/VUXIwfpfL4tLM+ldFLKoMHpCJ6IzPS6UyvYaEC6QM5iFSVR/s
	Ha2hbQTyVgeme/aP2w07y2Al5180pXh9GJCoK8dJpyFB5B0d5o9X6uUvyL+LfTKk
	N/cHtuUPN9TuOHkOKkzLVDS/Uv9WEA2YF8BhmYu3CLE/V0+CTyrWOPJbrUiV4YlR
	U3sAZeUwCMQbj//0hligt6gqqDq5jqohxf5ZNNwtxyKbXrFZAH0+cqaeclnuAJyK
	JrAER1dgHzPBL3WRf1ImO6IUBo0yLh5X+Va5fgwR5wzQQ5l54CMg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e7t1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:42:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TCaqnX038437;
	Tue, 29 Jul 2025 13:42:01 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9p1y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf/XVlaXXZXld3vpS8L7fvkzL+7upg81iOf9MP3pLPlT+TONUTEQ5pbaB5Nq4oi03LFfIXCGCKrXUjx2RqGC26QzyFOkGUKPmy8uhXsti9dQwwmcgURviJeheocym4zlq0l7LcH/RL+EA0cO3MEtsAH1JHJAI2I5Ux9IYSVR4pSmKrOzhxdkIEDc7AKKPqQG7ghNOsqHoCPd0T/LHFoBOPdmfKchDHE5hVGkgUZxNAyvLx7Hl3r1uZ5SlgwyLcmTWKfCY6/xyTrqBbpYmWONRlMnspn8J+pTvbz01yhoIRiQTvbhQt6s/TvBhoheurKibLJreY5gVR3GN0CihRbpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeOfqjGiSTrg2aS88mnSoEcBqOCd4dYv+OhdO0g7jhs=;
 b=FJqn5pe8a1U1jZbGzjn1XMY9bBoGy8pdfIGKNTlS2ie+HLQghlEgQMeIiQLvj8Q2dITkKnaPnWxP612oEPnBnLB1HcQyJ83x9ynkzTzSz81Ol5RqlqGTt6bAzobTmedglJpFVm8ip08NmJIawjR4p09pR8FOR5VWIm7v+J+uHl6nZSQdU/IfAukyp1S9Lo+D4L9KITp2u2/zRql/7G/UQUhXd4pGMKElSZ38oQ3XPnLuWueV1XDC5hpdlQw9TBteiBDNJnDmu88+rBETZYgyg0pMVADlcmbfTjkugInLAtEnB1gY4uZUQNVzsfPITzaNipzlPB3kMqTE1f0DvU0qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeOfqjGiSTrg2aS88mnSoEcBqOCd4dYv+OhdO0g7jhs=;
 b=iTxFcpsu+zEGPhMg8eBTbJkL7zzcVwdYhv4JY9L10rJ9BkvBdAJlkdQaLFmp4DJje/f8+XwP2t1+iewuQ2egCu5UxpoMhJXJkzyqwGBXwdILcJoi+3nyVuoL+M/lSbcpb2noXVtrKrugl0RbS8hEsQRc1yoAReOMCgq8e1YjdTs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 13:41:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 13:41:59 +0000
Date: Tue, 29 Jul 2025 22:41:42 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Li Qiong <liqiong@nfschina.com>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aIjPlvRyRttUDAow@hyeyoo>
References: <20250729081455.3311961-1-liqiong@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729081455.3311961-1-liqiong@nfschina.com>
X-ClientProxiedBy: SL2PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:100:55::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7604a918-0976-4d9d-ea0e-08ddcea5b109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MfbAu65OaEu1v4ip3YNyiUlOez38nNAJ3qP9wFJOetAbzOORDFMx/1bxIod2?=
 =?us-ascii?Q?GeqsGsqMXtaymsECiFvRNWgoi8SNDhKh1BhzniRTs4olx5MoOK7PE8ULMxhL?=
 =?us-ascii?Q?rp2BIcP4+ErtoSaAcx+uvAkrfAKFw/5mjp5RJa/CvHBBkeZNLUYgmSM43ZmU?=
 =?us-ascii?Q?HiC6KQIRoRJU2MiPsCTV+lX+V4mNUjS9ZsFMH7rWVwELTGX3kFhWrjpk1hGD?=
 =?us-ascii?Q?Gh82wVd0kNTKZMK9O3mMLIhIJqPHza18pmwba9lk7Sf3L2dX3V76Y8JH/kfN?=
 =?us-ascii?Q?6NCshFXSKS8TwmO3XAAt3Zn6rzf0Q+pvVXQXLj4MJCnBv+I0PX4ipRG9cz8B?=
 =?us-ascii?Q?E7hKQ9SEu99+OJk6gi15wn3P1K6K3suST5IaC3kYqINsxLYgeHOIW84uhDNE?=
 =?us-ascii?Q?qlScihau1rlP0jhF4gfQ8RwfXejF07wZed5QBu4GU5MUtrwXSlDuuN982T76?=
 =?us-ascii?Q?lKSMBlivNu/VfveRaDUbcIdTqE4wClEUd6A9S9s4J0OMZoqETt2Erh+Nvq2/?=
 =?us-ascii?Q?6A7w42kD3A2xfZXiACpPOQpZfA6qvp0nS+i3ZxbqBRpqF44x22BVhdDQpdtB?=
 =?us-ascii?Q?tXZkK0d+eDpaBJuTJXDcx/RYCJaKlOH0EWaxc4uPsUv5HQFaOQwMCRkr5S5u?=
 =?us-ascii?Q?f0rQuyEQw0RTIhHHuTj6UZpi0CZInscDZm6oFWbGT+WUR0rF1RoC2UW8hNMZ?=
 =?us-ascii?Q?vF/PlzdxIfjF8ZEYXsRMom1SfsNoeZ/79h/jvxcStf6000SjB/oJkyN70ZQ0?=
 =?us-ascii?Q?yXbVmTwYCBr2IO3pjhenTdFEFAqs2G3KtGLm9Cd0MU9yMboJWBcAtXtFWk66?=
 =?us-ascii?Q?MZEMrvwt8PZJvXQsFonqS/V1SBfS6RqCTA8EE+HqSgNkNRmXI4/7EUvCR5gN?=
 =?us-ascii?Q?hAKwPUBiRC/6ZL8f1HkBQzaNKlli3b3cpPljONcKqj2nUblOEUCX7w7Ldzul?=
 =?us-ascii?Q?9Ye5zOeS06u2rPrPjtjdEiEJ9+ExGViAtjLVrzZuQNord9SwhpyOLqe1ZVlF?=
 =?us-ascii?Q?rX/WbL1UND16mySLkwAgtdFUXmKFrDdm556UdXdPZxCeo74P+xFF3fxT1wR5?=
 =?us-ascii?Q?+rqp1gY13HqunPbl2kbkSPT5Mfn7OGFY2/mYHlnYWEz9Flv7ihLgf7lz1d/Y?=
 =?us-ascii?Q?wc6UKimzjAaiDLH3/T5ynSO/Nfpj3lZTWkpwW29mV1Ehcb3DVujvGLpQy5wP?=
 =?us-ascii?Q?gygUee+V9sFaV1wbwBjTgLArde8XCdkeoEw3GYOJWHZku8JV5uyu/qyLD42N?=
 =?us-ascii?Q?07xPNo9X2VI+G+PERzdQ4xeur6fw24sam9Yjv8hkFzpV7JGm/rbXH6Gfi7GN?=
 =?us-ascii?Q?TPU6zi/E0iQjjuyF8SqQ2toenNMmI+3mU+TWDC4SYd0ZfZ+jqayXl09ddwL2?=
 =?us-ascii?Q?JslKO2FNpTZh73MNSCBKW9UKltD6WNlT8KNW8Hi+KRw5G0CA0lYN3pP8iYdy?=
 =?us-ascii?Q?gxAD+64ih1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQwXV/5aH8sczGmRF0S6y8o+OuF3aGyy/eo3l3dviqbazzALaGEPDmtuH+xT?=
 =?us-ascii?Q?zD5t/l+YlyoNVlpt90P5Uiqofkkx76p8ttkDcXFK73aeXdonFM2MHwVuCi6W?=
 =?us-ascii?Q?9WGKhn6KKgLiy0i3jGQoyCIcIcV4bfjO498UvB57rnsv6mrFv9KMO19PcoVc?=
 =?us-ascii?Q?AlStZmEtFUMGTpkS/EIGIMDeIxU4FKFN27y7UD/tyr5WVnsPbWKzMCApedCW?=
 =?us-ascii?Q?IQQprNxMA/uIiN0Qk+QeYn8q+crjRmU6kLe5u0o8LViShs/QgT3xIeq3o8s/?=
 =?us-ascii?Q?0eiCOA42/l/s5j/CVQMdEqfMDv1W0P77JJJsgRco/iPSq7w3HRfNPZHCnZJd?=
 =?us-ascii?Q?Kf09WamDT2RqdzfknVwvyRmttOG4A5Me3yI2sVKJro5ymtyhoq5jBpOlcP99?=
 =?us-ascii?Q?Zemdk9atijBjXjXNmOjh3ODBRfrfmfhg4MatmlHyaHVb4Jy5+Ck/LyWxE94H?=
 =?us-ascii?Q?ARPuwQmmhFxpSAA21y5yPFdjASPFgjfyXJOqZdZZ9eQgnqk2bNiBsME9TVEL?=
 =?us-ascii?Q?tefNcKOBVwCu5ZYxtgtvoc1RRUfKimrWhZEEYLTWhErYe+h8jMnxvx4mZTOW?=
 =?us-ascii?Q?i3qeH/GEPSeNPvNAEUas1oyENdWLRmmf8hPk9OSWY4KvacfGnL7qHs1XmjbU?=
 =?us-ascii?Q?yIHiiMjd/NjY1d93F7iVO+pxgOt5/kHzd9bpwP4Gp70snzjcg3eDBRgtNUaz?=
 =?us-ascii?Q?muzeyQgoxrcZKyxVwFwZKdWYmpD2c0Tsvc2SLguZZbojdaJ/xAGMTXI6qstj?=
 =?us-ascii?Q?YONv55JhdpYzJICQOcm+/RFud6MmhOJvSO1USEV2s2oWFY3Uu00vL1A/betv?=
 =?us-ascii?Q?OzsL/0G99b+08kIozbcAznFaDybWOvnfCP+58HumGrFn884QdmMipBBrhGhE?=
 =?us-ascii?Q?8zgOHoNHU5Kg9dxP5gN8UGNWoG7CPU2D+Z/OIQcSeo40Qg1yplxg1Y70LXoQ?=
 =?us-ascii?Q?KFkPK/nr2xGsxBCnsWhah5F1Y+qyF3LFwrqINCyk/3AQ3llGYrnA6Lpk9QtL?=
 =?us-ascii?Q?4yEkCUwYV1dceSIxE9scslyUviI4kVRDOGNbDhUyEGgFabheJK4bMYkHOmIC?=
 =?us-ascii?Q?2wbTJd++YTsWrbdGmbtfXOInXKRqG7beutgoYwnZjcPPifhDAV6rlGXmTv22?=
 =?us-ascii?Q?1F15DFKLoBU/otK/9629VThD14Q010DoRl9ySU4I4kTF21K7kO6J9OfphSgO?=
 =?us-ascii?Q?cB4dv5vvpA9L0e0LYKBVdsp5PDc0RWp2qlclKRZQRMZPC5JMvbEXLVZ/0cSE?=
 =?us-ascii?Q?hPiYK6zw9NG56N73ONWhln+2ByWzkD6akgbwMgb0ID9aHqe1EfZQM6S+lI+C?=
 =?us-ascii?Q?ziS67nFyKPQ80nCF5RsDRsu+Rw+GfCXFlKiJOKIf/qdYDcpaa/vrGhsiUfHB?=
 =?us-ascii?Q?DZVxeF+HA1uvR9kgocWo0V+7GYF4mUVp0+g/5Qb6w+qzVrgLoUgBZ9ZrT4SL?=
 =?us-ascii?Q?K6DY1N2+FJMHxRtFbMDDd/NM8/j634Odejdr4pL09HGN2dhqZG+lp2a2CgG2?=
 =?us-ascii?Q?39kedEn1AD10YlofYjvTjspR8MhuLDw1vL/ZARn3QkIRXn879ODHhT+OyiyZ?=
 =?us-ascii?Q?oAOKoq80zDcE+SStaGQUt7YyvZ6UMlKIxkZFn9Xo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C/tHRhkFWbR68wVXRf6fYkOK5Y7h9t4xuOUdW82kFNEO/o3PsYqVkw/iwj9uIOmakVV/Orfs8IhsXSwR5BDY4IubXlaapaveHwKTrb5dsgzS8zLfoTwEnrwDnJPpjHl97rPW+9+Dt0VOE97oMNQjnXnbLPWuJr8PHXcwLB0WIGG+2nC2s64adh48PNLPX5HjSHOQ+SXB9eUcfcTTRLkA6Blbdc9Z5hXPcnM0O1EHa6KLsmzYe/mRdwrEtSXuMpMJ2XgBQTrJseiiBI6tkChKL+SY+pJ1/p5GBhp2LjmMg/Et1VcvNR0ODZO0DfX3hk2Q6omQkpntfdJTK+VZ+fVJ1aWTCQzDKEvMftH+ZLsSeE8fvgIZZ4nmss8GQaNryPsG0xvNNK5ulw51RLlSjI5keXR7AVPTwcZViNQwXHLj94qfjAbPw+IAR93+gPyNydIjskDLUhvKjC5i2Hv+0lxOSmAkU4BUtGjYgfLmhnOFsL2v/M4ZPjEYBYsZX4iPEW9H7xhroXr259NqJ9W8d9rJS0XObXv1tfPq0Lw5INYcKu4B1R4gnVyVdrHH7F0kr6hMox8F0ccKbJ+VnC4b8YNHx59s+XzVJ5Y58/ZJgav4bdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7604a918-0976-4d9d-ea0e-08ddcea5b109
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:41:59.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSS1S0CcsUci9x+wK8pj5hqZLbUCdxnei4v5Ydqgrli7HM2KBJgPSpvDTUrz1YOyGTWmha0oChFwFAfLgn2mCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=858 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290106
X-Proofpoint-ORIG-GUID: L05xcP0im155mdavotGqMzDybT7Y2eH9
X-Proofpoint-GUID: L05xcP0im155mdavotGqMzDybT7Y2eH9
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=6888cfb0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SlVAvriTAAAA:8
 a=25QDi5WC7j_5mWbxKMgA:9 a=CjuIK1q_8ugA:10 a=qesGs21RGGeVIEdTuB6w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNiBTYWx0ZWRfX9Ds6Ew01ulKR
 oK4+9yHs21DzwkJvzkrHq2mnhFivap2hiLD8d3VPU0GRPpedpksQem93t0ZAFjHrYA5yutkQ38G
 XywNkoQy9wisSVtcEeGfdwbyenScMIbgkoIHLi0VM3rQklHKlApw2DM53SN/0FFyYnfXOcEFjV7
 mobyM3wYViR/NqjRpdHZZlEysG/NxVXWswMhtkw6Kn3IYjbYyyR5pe4Xfm/c/tvrZuFIaNHzcHK
 URLbtfo6QhwMwGC8VNhHQJyVgWFMdl4sX06wpvfkxtxTshkm4dm8ubYTsEsL7DmJnO2R8K+DxIg
 a6TDH18YIOPFGrVeATVUDlzi+T2JQjD8OLLF0XPKsTNA0XfZwUpcBpqdk/stxtE4Qg5WaU9VHMT
 GDWXiU+u378kAe5N1tI3wN2Gbn8DvOv4ztmsWRtrVK34q9h8tBefWDjGBX8RyP0lLRdAsm6Z

On Tue, Jul 29, 2025 at 04:14:55PM +0800, Li Qiong wrote:
> For debugging, object_err() prints free pointer of the object.
> However, if check_valid_pointer() returns false for a object,
> dereferncing `object + s->offset` can lead to a crash. Therefore,
> print the object's address in such cases.

As the code changed a bit, I think the commit message could better reflect
what this patch actually does.

> Fixes: bb192ed9aa71 ("mm/slub: Convert most struct page to struct slab by spatch")

As Vlastimil mentioned in previous version, this is not the first commit
that introduced this problem.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
> v2:
> - rephrase the commit message, add comment for object_err().
> v3:
> - check object pointer in object_err().
> ---
>  mm/slub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 31e11ef256f9..d3abae5a2193 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1104,7 +1104,11 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>  		return;
>  
>  	slab_bug(s, reason);
> -	print_trailer(s, slab, object);
> +	if (!check_valid_pointer(s, slab, object)) {
> +		print_slab_info(slab);
> +		pr_err("invalid object 0x%p\n", object);

Can we just handle this inside print_trailer() because that's the function
that prints the object's free pointer, metadata, etc.?

Also, the message should start with a capital letter.

and "invalid object" sounds misleading because it's the pointer
that is invalid. Perhaps simply "Invalid pointer 0x%p\n"?
(What would be the most comprehensive message here? :P)

> +	} else
> +		print_trailer(s, slab, object);

>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  
>  	WARN_ON(1);
> @@ -1587,7 +1591,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>  		return 0;
>  
>  	if (!check_valid_pointer(s, slab, object)) {
> -		object_err(s, slab, object, "Freelist Pointer check fails");
> +		slab_err(s, slab, "Freelist Pointer(0x%p) check fails", object);
>  		return 0;

Do we really need this hunk after making object_err() resiliant
against wild pointers?

>  	}

-- 
Cheers,
Harry / Hyeonggon

