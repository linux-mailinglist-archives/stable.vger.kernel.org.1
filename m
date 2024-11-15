Return-Path: <stable+bounces-93537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393019CDE80
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A0282624
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B361BDA95;
	Fri, 15 Nov 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eHeNEwDy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tn2zave8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958081BD4E4;
	Fri, 15 Nov 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674557; cv=fail; b=ujUXT/5vD+PBCP7LBI+JnSvWwObtMwcdc6g3jkIcFbzbI6nG2HjG8wua2FS6rdpkJCrLYY/oWBc2WyFXQaVUtGL6HrrmEAnPWVMpg8Cf5qOi7X5WtnUEPZ5rJQoVsupGSF/yydT2XhbAUnw/lEzSFN0tg+540O85So9xkiC6PFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674557; c=relaxed/simple;
	bh=akgC8a+gK+lqML2mKGEIjvEIm5paQeFwTdGgIxkQk6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YefGKGOIU1gFTVsSw5QPHuc6HeEJkUldDva6Gti6dSKoaz5rZ0KmAaJfpeHhMG4J7Z9plmJzNtjHw9jiv1H3VFRqDHi4ZiK97qQSQJlUMkCCJJ+i81A891XToJW0+opluMecDMLVewcMMKQrK8hBik9qE4X6CJmcgqFm6uItC0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eHeNEwDy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tn2zave8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHGhv026024;
	Fri, 15 Nov 2024 12:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g4lhvb8C2OfyVjOD4h8GKh1wFOBJ6R0iZcQUPnrOE70=; b=
	eHeNEwDyHA1FnAh+7g30wMpTzIVgdYl86Meq4pYUnKNVffC/gAxRaTiA0/0VwogP
	hHHR3ancXaWDs1b49m4r0BqabSz9BbkSu6rhYQIV0OFeTwn/JTbSoJE8EW8e/9+m
	lh19PUFllyDikXIOFNoKKg1+aN5FCd+doT9FTXIEeGtSQ0Ew3n/idmKj7qAoDNIs
	I0MYUs6l/Y00WzDi+v2UdrCjk8BgrL4WVAuFeo9uUfDYfexnfDVIh12INiwa74Q7
	Gy3TW3I6BDF0Im4IM6E/PlZEZMDEFr6OAwN5Ra1j7fwqB5p7dcuInnB71d6o6sX7
	JyGM5SF9vT8JL8m6y7iwCQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heu6hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCXkje035901;
	Fri, 15 Nov 2024 12:42:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c564r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKM5cc4BHUimTlsO2Vistlhqcvx1h8AgDf904X/v7HW1Hrbzl72b42TlMUPFuB5MaaFo1N+j0sUsAjzkNNHFidtVPc/GE8KX1panlfoySf/wRqxaf/A/1kdRmOXwFIt30egLQlqXIB1TzwY4z1w6rjsN7nBmgcK1EDJzD8CMG9CCU25enlH9mHhQJFRO3RL6dUhR5j4TJFVFk2L0n54T9O7e8JeA5Y7lxEsCe+pMNXW+pAZ7+ELxIOj6pjrJxrKLHmpWe1EoAXEHJonuJpVFy0ujK3cLQ7rz+yTFp+Nysz6Zmw7uEAOr3fg9xNjmv9lI+Q/zEwa+bH3pEqwcwlWSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4lhvb8C2OfyVjOD4h8GKh1wFOBJ6R0iZcQUPnrOE70=;
 b=KonPrnKZ/9ZWQs0AVCfjkC8pb/gFoZYQxvbxv4lpNK30SC5Mdd+DUJZUEgiJap2C4eyymPcum3sO+5gnWTXhrxSvXaolMs+6jqVjrU2qSykwdLnwp/ph1JsWwvSHi85IT9yTCFEeRDNJIOI3Au/3LcLOHCRo0RR9hAF40RoQixogheq/w4i1YTBU9yDX/0gm/c+KOQ5XwQ9oXsZsOVSK98sotVByVDYR+/wyxEay1vkTgcuAMs47oJfd3RML4G58TWfUK01adNPBkBegwsKsPw9xiqxg4NCyMojyvd1fHFUfvjtU0yfkOAQoenzRH2FCA/GWkHY0TpRkLch+112dGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4lhvb8C2OfyVjOD4h8GKh1wFOBJ6R0iZcQUPnrOE70=;
 b=tn2zave8udvICg63kGbBz5vOGKx7lVN23lfumr1EgXHi9utGkrp65CpByt5ednavMT8B1jbGNn2ngn/xuFq6xewuY9+V0iKfYt6cgzlK118jJ4rvaOZZDDMGl52wUuPEauXd1G23PfGH5ivyYJTDGhqEuNMbiL+nfEGqHr4MoiI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:42:13 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:42:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6.y 3/5] mm: refactor map_deny_write_exec()
Date: Fri, 15 Nov 2024 12:41:56 +0000
Message-ID: <a7f0a2f48d376b2c4e2e3adf7ac011abe1eeeead.1731672733.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3907286c-3672-44f6-e2cd-08dd0572ed94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SVg6jZPGWE+h/y74Q112aSiDJoUx5mcdcKRWuTLOibK5X2NCndx9lrtkEdm8?=
 =?us-ascii?Q?g2N1Axf8I8OjetHITHNXLNxuNEo6AaOrHHmwvT73uPVqEW9sVPjrnh496Wfw?=
 =?us-ascii?Q?VWjjD3H94DXy2XWbcBRUOxwXOumHXegywJm1yKGKe1J+H0gmDNeERku4jSNF?=
 =?us-ascii?Q?zxqY1WS6F2SpyImFb4Gh4dH5tu/mMIR97pdW4IauO3+i94YgNbMyLF5tcKpI?=
 =?us-ascii?Q?TgaQrmQ4np7sCRxc9TZIMv1iaFPsS9Pri794p7c/KwU3ZbQQDwpxr3axupym?=
 =?us-ascii?Q?xeePQUunDizUQvIq2xq+uC7DyNFXKfPcqkNYcXXIrbx9a9DBeFHFr2UbIxIg?=
 =?us-ascii?Q?6/PqYA2I7iKj3pJ3xLr0uGfrhhNtqm3phEVWkcYyJWs7LZlHTzl+JOWrn4+Z?=
 =?us-ascii?Q?NWWwQGXcCuUW8j72Euo4MDvZxLC3X18MgoJoMNrRA1GK2FpOuaPc46uJpLF5?=
 =?us-ascii?Q?AwhPhnzMsKCLyshL7YC0eyy1kh51TLDtwA8rBP0URgaPB0I9TeYG8v0FHjUe?=
 =?us-ascii?Q?1QXo/V9j9jt6sWShoPRFoJW458Z5Nh/XyxcmHC7FxfFqgK/qX3pqyy1a0v7Y?=
 =?us-ascii?Q?PSZjBX4G0nO2CCsCCPat/Fn8j28oNr9WnYjvLt4pw3JHKRZ9askoVba+CIup?=
 =?us-ascii?Q?h7NGsHW+3w03qzbA07Omg30UnJzmzdg9fGvxKWrz6odUAKJqaVb/aE3mi/+n?=
 =?us-ascii?Q?qU9xVDn3UvtmnxovPU3wxK/63gK/3jH0LLcgD19paCWzL8O05E7RAT0Cw2Jz?=
 =?us-ascii?Q?dVKGR2WXq+OswCcGVFO0AMueX1FhI2ceh5YazNOxCwt1ox1p07AbvNqtxHAy?=
 =?us-ascii?Q?GnfOupWZUS6TDmQz5XCut8pk9oglz34/MHrzNwppJ7Y8L7SyYJL534hyDQ6f?=
 =?us-ascii?Q?YmAZUrznPDge0xcOUpNoiKjLohGIeUjb1FKnbT+1fUxqLdaiUm7brQA4h9mo?=
 =?us-ascii?Q?7pzpHT8LimPYHyyOwN1kEP3Gl7g0vluPPEdUC4cz/hGpnVLrrznKWPpt1YnK?=
 =?us-ascii?Q?E90XUaiV6WUW3gOX2jR3zkQDmuP59y2MS7qo7dOYaj3dLD2mob79TuPUPjgu?=
 =?us-ascii?Q?eg7mxiBkHoljjqYpitsjXibSkl1CYGVU2P0lOjJeuLYZLP41Y7k/yM27/fS/?=
 =?us-ascii?Q?oRIOBKWeSLf7R/C6YZI0A7G68lKiJqzsc2o/KCS+L+NIypNWeqbrTy79cjID?=
 =?us-ascii?Q?aM/iTUf4OxaMiXMBnaDicD020lXI8IkUm6kOSvzRmKMkGVzpVC7890VmbNKX?=
 =?us-ascii?Q?n5ZsLr9tWG9s8n38kVeW5AuQye+wYku6MA3giL/9bQNkNT1DgpX8c8bVGviS?=
 =?us-ascii?Q?ZNl2OK/VrB818E9f8ROFAAT7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?04qYkFAIkscjJsrbWSRYQBOZ+ou+38D1jCxxM0m+VCbdxmBnvfFpPSmJEUw6?=
 =?us-ascii?Q?0m9Z1XnyNTMwJtoYLo8QAfaMsQerIKLSqx+3F8Pxn4KWwmrHExCobNv2gQhM?=
 =?us-ascii?Q?2cWYAyMCOOnwhzedN80TVKEPugtEdNqmg8EsSdu/OchrTy8wXXKhLZvATg8y?=
 =?us-ascii?Q?zU/ooa40PKQL2eWX0qRQdmM+0IPcIGnFImN2MZLXh1yEpZnTAwFbVRnvkJFe?=
 =?us-ascii?Q?qK2keN2yxQMSoqP6QzfJZ0OGxncuXkaOa1hwQT3d4KWa1oqOp5dd85GnxixJ?=
 =?us-ascii?Q?efN1V5iCdiFc2YLfxs1Ny+XGOPa+cqn4yODBVX3m4+4Fh/UpdU6XX8CVVnnT?=
 =?us-ascii?Q?jYMSVjF0VF8GOewVCtxQEJYAuGJpkSsVfZ/gK3hUYA/tIgBMeUDeAMWeyCqv?=
 =?us-ascii?Q?iFzQQB3LMGI696M0+jvL0dsOSu3F7Vxf054GJ54/UkbiomxoaE3G7MmfHPjP?=
 =?us-ascii?Q?bScCtlp7KBX1GnzXWLn/eBPMdH1hIk7vd6u8ahcPWYaVGMONpCo5DCKa9Sk8?=
 =?us-ascii?Q?eTHkbuyjpnXrf7d8fhBhDpQSBWndUAc5zu0XFdkM+AXMOce9FWT8L1VwxWEQ?=
 =?us-ascii?Q?1nLWshS2QndXULm9+5SnqY5K+DloMqZJLx9uageTunTvUX6/xbEdDR5FNnT0?=
 =?us-ascii?Q?ewrBajW8a1zt8st5h7p7yjzXvqsxeg8rfE1Qv6ZaBdFbioLs0Oa3MkrLOZTx?=
 =?us-ascii?Q?Wwtm/cOvidfF4HH877w/CBrT56NSbfCNwj808ebASmQoEnm8Cc0wg0wvO/CS?=
 =?us-ascii?Q?S3q0Db2l0FW1ysQu97DRr1vOLHCYEt7c4TZ6iU9c3DQZytR8Z7Nzcnq5mQ9Z?=
 =?us-ascii?Q?CmygbEktCUczEn5BSMdv7PE6lVIsxivHw6IQOTPsl0ikM1XuEx5FE9h0apEm?=
 =?us-ascii?Q?TdFNIOcLcUe2GjxVxefRxBP6SWSiXOpQBxps8VND9pgc8MQ2HoqkRJTtgr+N?=
 =?us-ascii?Q?z/kT80cUc5GQHta9/frLEyL5tMg5p05QNO1pVMPVXyNDvpbB61N0NdHtR1jN?=
 =?us-ascii?Q?R1Kf27aQrQQLDp60dwtFbOHdaeZhB0uTCIeaCQgJRbNkIGaNqoOKNAHP+mWH?=
 =?us-ascii?Q?rMs6zzLDZu7Ks0vIvSav7R9UbVL/shmBGRNYQFLpusXZReTMTLDYLlRvlbWB?=
 =?us-ascii?Q?B1vZ2Y7UIp7nBnlbN0eiFoChncsMdddrGhrqe8Uqv87rniTCGUxttFJQnjFT?=
 =?us-ascii?Q?8dWVmCb3d1nDyiK363IRKU7aFkwS3awmkhwwgi3wm3lCuYi8HfEvzHBtskGn?=
 =?us-ascii?Q?drzBGNmo+Rw9wqLdatQOmVeTdGCIhgDXyCPAI4Q17PPhs3rVhIz1vBcmqCmD?=
 =?us-ascii?Q?p4W6nVA8iBwBL6+AYs6xwRsIoFE8AwdJOJoa3sVe/ZYfldZIb2qU6PZR2Ahs?=
 =?us-ascii?Q?wYCUIF9KMiBdMqO2+h3f67DNY8fcr9hi1QUT3Se59TaFVC8EPp4jjHEbxEfn?=
 =?us-ascii?Q?KTssW+hcCHBC2p5cvZ2wJ1QdM8CwLVAPOZsOP7cRRPaOos2O/2okJWTWe+ol?=
 =?us-ascii?Q?GfWIdIrUiu+5RWNDNPPs/nbEViAU8l+6Hl3gUYRHjP6UP+opgcbEncx9m8Vf?=
 =?us-ascii?Q?tuls3Ul5ESKw5a/dD0YmqXEqBacKxNpPVwAAWuKAv6dQR+a6iVNQtf1704Xx?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rNkA7EFuysRf/8MsF3LgfNc/yhctiIdQ+qdU3ndOUlJsHEGgDvQjBa1X1KfamlZezCshfZLkZO/XRAwTfPDEbVa+gsL6GuK9bVExFEk3PWP1J5lk94pXsVn3gXt7kTZJbkTEpXsewRYB5wwkYEbCShHxOu1Fgop9ISMF4t88ApHFNJ8ccvLpytW6CV1FHdCnE3iCzjER2ig9CVvFWXjKXM8DjTDG54kvMV5XNkmGI71uuD+2aRdeNQBdybypX4PIP90CPbahR3SpHJb5tci68EDBomjBwiUU1CKZWHRs8bwIv/Fc9pSgDiEtBznsY6MmN+MmXyOVT/fsG6LzRCCYU/LmvE+sAWuOEOliYRkaEV5wTMLBysYXlTlfiXXP5BeYidVibvMVLyjQOwMaASUQqot8YLjveDJ1Ew/2mI5fTnQykfRsa0Qt2pkOGkzEyFc6vtFeU4dmeUbLwNx+lxHaDB334RYZv00qBORPpTg4mpxDWPUDdkNwjoHmy3xWq7oP2zvQTQZYO13zYL0mrATcUt2qGx+QBWdjuwX9CgzWTtyV+ZSj6CRa+Ak7W1W2Rs6Uh2+jXdpUOXrPP8A59k56pTHguuLcsKrsZNr3yc95fWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3907286c-3672-44f6-e2cd-08dd0572ed94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:42:12.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1eetwGaqOXKQ+UyOlevgfW3NYlK212Zys3177vU/jbfs7Fhv1ZaV4poBOqN9AEUgqc9f2+wTmKP4+MoPuiMTRtw0VqGExsLYdUeKrNObcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: DsbnIAcLJnyFsgQ79_RAcNtzr-Zl73-N
X-Proofpoint-GUID: DsbnIAcLJnyFsgQ79_RAcNtzr-Zl73-N

[ Upstream commit 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf ]

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to
use this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add
some additional documentation.

Link: https://lkml.kernel.org/r/6be8bb59cd7c68006ebb006eb9d8dc27104b1f70.1730224667.git.lorenzo.stoakes@oracle.com
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
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mman.h | 21 ++++++++++++++++++---
 mm/mmap.c            |  2 +-
 mm/mprotect.c        |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index db4741007bef..651705c2bf47 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -187,16 +187,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;
 
-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
 		return true;
 
-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
 		return true;
 
 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index 9fefd13640d1..d71ac65563b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2826,7 +2826,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..7e870a8c9402 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -791,7 +791,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}
 
-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
-- 
2.47.0


